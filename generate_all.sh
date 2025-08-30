#!/bin/bash
set -e

# -----------------------------
# Define directories
# -----------------------------
ROOT_DIR=$(pwd)
SRC_DIR="$ROOT_DIR/src"
MODEL_DIR="$SRC_DIR/model"
CONTROLLER_DIR="$SRC_DIR/controller"
WWW_DIR="$ROOT_DIR/www"

mkdir -p "$MODEL_DIR" "$CONTROLLER_DIR" "$WWW_DIR"

# -----------------------------
# CMakeLists.txt
# -----------------------------
cat > "$ROOT_DIR/CMakeLists.txt" <<'EOF'
cmake_minimum_required(VERSION 3.10)
project(sharpishly)
set(CMAKE_CXX_STANDARD 17)
file(GLOB_RECURSE SOURCES src/*.cpp)
add_executable(sharpishly ${SOURCES})
target_include_directories(sharpishly PRIVATE src src/controller src/model)
EOF

# -----------------------------
# run.sh
# -----------------------------
cat > "$ROOT_DIR/run.sh" <<'EOF'
#!/bin/bash
mkdir -p build
cd build
cmake ..
make -j$(nproc)
./sharpishly
EOF
chmod +x "$ROOT_DIR/run.sh"

# -----------------------------
# execCommand.h
# -----------------------------
cat > "$MODEL_DIR/execCommand.h" <<'EOF'
#ifndef EXECCOMMAND_H
#define EXECCOMMAND_H
#include <string>
#include <array>
#include <memory>
#include <stdexcept>
#include <cstdio>

inline std::string execCommand(const std::string& cmd) {
    std::array<char,128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd.c_str(),"r"),pclose);
    if(!pipe) throw std::runtime_error("popen() failed!");
    while(fgets(buffer.data(),buffer.size(),pipe.get())!=nullptr) result+=buffer.data();
    return result;
}
#endif
EOF

# -----------------------------
# EnvironmentManager Model
# -----------------------------
cat > "$MODEL_DIR/EnvironmentManager.h" <<'EOF'
#ifndef ENVIRONMENTMANAGER_H
#define ENVIRONMENTMANAGER_H
#include <string>
#include <vector>
struct Environment {
    std::string name, branch, dockerComposeFile;
    int webPort, apiPort;
};
class EnvironmentManager {
public:
    EnvironmentManager();
    std::vector<Environment> listEnvironments();
    std::string addEnvironment(const Environment &env);
    std::string removeEnvironment(const std::string &name);
    std::string updateEnvironment(const Environment &env);
    std::string deployEnvironment(const std::string &name);
private:
    std::vector<Environment> environments_;
};
#endif
EOF

cat > "$MODEL_DIR/EnvironmentManager.cpp" <<'EOF'
#include "EnvironmentManager.h"
#include "execCommand.h"
#include <algorithm>
#include <sstream>

EnvironmentManager::EnvironmentManager() {
    environments_ = {{"local","feature","docker-compose.override.yml",8080,3000},
                     {"development","develop","docker-compose.dev.yml",8081,3001},
                     {"staging","staging","docker-compose.staging.yml",8082,3002},
                     {"production","main","docker-compose.prod.yml",80,443}};
}
std::vector<Environment> EnvironmentManager::listEnvironments(){return environments_;}
std::string EnvironmentManager::addEnvironment(const Environment &e){environments_.push_back(e); return "✅ Added "+e.name+"\n";}
std::string EnvironmentManager::removeEnvironment(const std::string &n){environments_.erase(std::remove_if(environments_.begin(),environments_.end(),[&](const Environment &e){return e.name==n;}),environments_.end()); return "✅ Removed "+n+"\n";}
std::string EnvironmentManager::updateEnvironment(const Environment &e){for(auto &env:environments_){if(env.name==e.name){env=e; return "✅ Updated "+e.name+"\n";}} return "❌ Not found "+e.name+"\n";}

std::string EnvironmentManager::deployEnvironment(const std::string &name){
    auto it = std::find_if(environments_.begin(),environments_.end(),[&](const Environment &e){return e.name==name;});
    if(it==environments_.end()) return "❌ Not found: "+name+"\n";
    Environment &env=*it;
    std::stringstream out;
    auto checkPort=[&](int port){return execCommand("lsof -i:"+std::to_string(port)+" | grep LISTEN").empty();};
    if(!checkPort(env.webPort)) return "❌ Web port "+std::to_string(env.webPort)+" in use\n";
    if(!checkPort(env.apiPort)) return "❌ API port "+std::to_string(env.apiPort)+" in use\n";
    out<<"✅ Ports free, deploying "<<env.name<<"\n";
    out<<execCommand("git checkout "+env.branch)<<"\n";
    out<<execCommand("git pull")<<"\n";
    std::string cmd="docker-compose -f "+env.dockerComposeFile+" down && docker-compose -f "+env.dockerComposeFile+" build --no-cache && docker-compose -f "+env.dockerComposeFile+" up -d";
    out<<execCommand(cmd)<<"\n";
    return out.str();
}
EOF

# -----------------------------
# EnvironmentController
# -----------------------------
cat > "$CONTROLLER_DIR/EnvironmentController.h" <<'EOF'
#ifndef ENVIRONMENTCONTROLLER_H
#define ENVIRONMENTCONTROLLER_H
#include <string>
#include "model/EnvironmentManager.h"
class EnvironmentController {
public:
    std::string handleRequest(const std::string &route);
private:
    EnvironmentManager envManager_;
};
#endif
EOF

cat > "$CONTROLLER_DIR/EnvironmentController.cpp" <<'EOF'
#include "EnvironmentController.h"
#include <sstream>

std::string EnvironmentController::handleRequest(const std::string &route){
    if(route.find("/environments/deploy")==0){size_t pos=route.find("name="); if(pos==std::string::npos)return "❌ Missing name\n"; return envManager_.deployEnvironment(route.substr(pos+5));}
    if(route.find("/environments/add")==0){
        std::string name,branch,compose; int web=0,api=0; size_t pos;
        pos=route.find("name="); if(pos!=std::string::npos) name=route.substr(pos+5);
        pos=route.find("branch="); if(pos!=std::string::npos) branch=route.substr(pos+7);
        pos=route.find("compose="); if(pos!=std::string::npos) compose=route.substr(pos+8);
        pos=route.find("webPort="); if(pos!=std::string::npos) web=std::stoi(route.substr(pos+8));
        pos=route.find("apiPort="); if(pos!=std::string::npos) api=std::stoi(route.substr(pos+8));
        return envManager_.addEnvironment({name,branch,compose,web,api});
    }
    if(route.find("/environments/remove")==0){size_t pos=route.find("name="); if(pos==std::string::npos) return "❌ Missing name\n"; return envManager_.removeEnvironment(route.substr(pos+5));}
    if(route.find("/environments/update")==0){
        std::string name,branch,compose; int web=0,api=0; size_t pos;
        pos=route.find("name="); if(pos!=std::string::npos) name=route.substr(pos+5);
        pos=route.find("branch="); if(pos!=std::string::npos) branch=route.substr(pos+7);
        pos=route.find("compose="); if(pos!=std::string::npos) compose=route.substr(pos+8);
        pos=route.find("webPort="); if(pos!=std::string::npos) web=std::stoi(route.substr(pos+8));
        pos=route.find("apiPort="); if(pos!=std::string::npos) api=std::stoi(route.substr(pos+8));
        return envManager_.updateEnvironment({name,branch,compose,web,api});
    }
    if(route=="/environments/list"){auto envs=envManager_.listEnvironments(); std::stringstream ss; for(auto &e:envs) ss<<"Name: "<<e.name<<", Branch: "<<e.branch<<", Compose: "<<e.dockerComposeFile<<", WebPort: "<<e.webPort<<", API: "<<e.apiPort<<"\n"; return ss.str();}
    return "❌ Unknown route: "+route+"\n";
}
EOF

# -----------------------------
# index.html with integrated env admin
# -----------------------------
cat > "$WWW_DIR/index.html" <<'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Sharpishly Dev Dashboard</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Sharpishly Dev Dashboard</h1>
<div class="buttons">
<button onclick="callApi('/generate-cert')">Generate Cert</button>
<button onclick="callApi('/cleanup')">Cleanup</button>
<button onclick="callApi('/update-repo')">Update Repo</button>
<button onclick="callApi('/status')">Docker Status</button>
<button onclick="callApi('/update-hosts')">Update Hosts</button>
</div>

<h2>Environments</h2>
<form id="env-form">
Name: <input type="text" id="env-name"> Branch: <input type="text" id="env-branch">
Compose: <input type="text" id="env-compose"> Web Port: <input type="number" id="env-webPort"> API Port: <input type="number" id="env-apiPort">
<button type="button" onclick="addEnvironment()">Add / Update</button>
</form>
<div id="env-list"></div>
<pre id="output"></pre>

<script src="script.js"></script>
<script>
async function listEnvironments(){
    const outputEl=document.getElementById('env-list'); outputEl.innerHTML='';
    const res=await fetch('/environments/list',{method:'POST'}); const text=await res.text();
    text.split('\n').forEach(line=>{
        if(line.trim()!==''){
            const div=document.createElement('div'); div.textContent=line;
            const envName=line.split(',')[0].split(':')[1].trim();
            const btnDeploy=document.createElement('button'); btnDeploy.textContent='Deploy'; btnDeploy.onclick=()=>deployEnvironment(envName);
            const btnRemove=document.createElement('button'); btnRemove.textContent='Remove'; btnRemove.onclick=()=>removeEnvironment(envName);
            div.appendChild(btnDeploy); div.appendChild(btnRemove);
            outputEl.appendChild(div);
        }
    });
}
async function deployEnvironment(name){const outputEl=document.getElementById('output'); outputEl.textContent=''; const res=await fetch('/environments/deploy?name='+name,{method:'POST'}); const reader=res.body.getReader(); const decoder=new TextDecoder();
while(true){const {done,value}=await reader.read(); if(done) break; outputEl.textContent+=decoder.decode(value); outputEl.scrollTop=outputEl.scrollHeight;}}
async function removeEnvironment(name){const outputEl=document.getElementById('output'); const res=await fetch('/environments/remove?name='+name,{method:'POST'}); outputEl.textContent=await res.text(); listEnvironments();}
async function addEnvironment(){const name=document.getElementById('env-name').value; const branch=document.getElementById('env-branch').value; const compose=document.getElementById('env-compose').value; const web=document.getElementById('env-webPort').value; const api=document.getElementById('env-apiPort').value;
const path=`/environments/add?name=${name}&branch=${branch}&compose=${compose}&webPort=${web}&apiPort=${api}`; const outputEl=document.getElementById('output'); const res=await fetch(path,{method:'POST'}); outputEl.textContent=await res.text(); listEnvironments();}
listEnvironments();
</script>
</body>
</html>
EOF

# -----------------------------
# style.css
# -----------------------------
cat > "$WWW_DIR/style.css" <<'EOF'
body { font-family: monospace; padding:20px; background:#f2f2f2; }
.buttons button { margin:5px; padding:10px 20px; }
pre { background:#000; color:#0f0; padding:10px; height:400px; overflow:auto; }
#env-list div { margin:5px 0; }
#env-list button { margin-left:10px; padding:3px 8px; }
EOF

# -----------------------------
# script.js
# -----------------------------
cat > "$WWW_DIR/script.js" <<'EOF'
async function callApi(path){
    const outputEl=document.getElementById('output'); outputEl.textContent='';
    const res=await fetch(path,{method:'POST'}); const reader=res.body.getReader(); const decoder=new TextDecoder();
    while(true){const {done,value}=await reader.read(); if(done) break; outputEl.textContent+=decoder.decode(value); outputEl.scrollTop=outputEl.scrollHeight;}
}
EOF

echo "✅ Full project generated with integrated Environment Management (add/update/remove/deploy) in dashboard. Run './run.sh' to build and start."
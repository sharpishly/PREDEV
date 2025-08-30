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

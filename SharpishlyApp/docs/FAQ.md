PREDEV FAQ for Developers
This FAQ addresses common questions about PREDEV (a platform for environment synchronization) and SharpishlyApp (its C++ MVC reference implementation).
General Questions
What is PREDEV?
PREDEV eliminates custom shell scripts for deploying projects across environments (local, staging, production). It automates file/folder permissions, git submodule checkouts, SSH key setup, and environment synchronization to simplify onboarding and ensure consistency.
What is SharpishlyApp?
SharpishlyApp is the reference implementation of PREDEV, a C++ MVC framework for learning and experimentation, integrating C++, Docker, and DevOps workflows. See README.md for details.
Is PREDEV production-ready?
No, PREDEV and SharpishlyApp are experimental and educational tools. Thoroughly review and test the code before production use. See Security Notes in README.md.
Setup and Installation
What are the prerequisites for running PREDEV?

Operating System: Linux (Ubuntu 22.04 or later recommended).
Tools: CMake (>= 3.10), g++ (>= 13), Docker, Docker Compose, make, curl, git.

How do I install the prerequisites on Ubuntu?
sudo apt update
sudo apt install -y cmake g++ make curl git docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker

For Ubuntu versions with older g++ (e.g., 20.04):
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install -y g++-13

Verify:
cmake --version
g++-13 --version

How do I build and run SharpishlyApp?
See README.md for detailed instructions or use:
./run.sh
curl http://127.0.0.1:1966

Project Structure and Features
What is the project structure?
See README.md for the full directory layout, including src/View/www for web assets.
How do I add a new controller?

Create a new file in src/Controller/ (e.g., MyController.cpp).
Define the controller logic and register it in src/main.cpp via registerRoutes():routes.push_back({"/myroute", [](const std::string& request) {
    return "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nMy Route!";
}});


Rebuild and run:cd build && cmake .. && make && ./SharpishlyApp



How do I extend the HTTP server to support HTML?
Place index.html in src/View/www. Modify registerRoutes() in src/main.cpp to serve the file (planned for future releases). See README.md for an example.
Docker and DevOps
How does Docker work with PREDEV?
PREDEV uses local-Dockerfile and production-Dockerfile for development and production environments. Run:
docker-compose -f docker/local-docker-compose.yml up --build

See README.md for details.
What DevOps tools are planned?
Debugging, monitoring, security, and logging tools are planned, along with provisioning checks. See ROADMAP.md for details.
Troubleshooting
Build Issues
Why does run.sh fail with "No such file or directory" for SharpishlyApp/build?
The build directory is missing. Create it:
mkdir -p SharpishlyApp/build

Or modify run.sh to add:
mkdir -p SharpishlyApp/build

Why does run.sh fail with "cmake: command not found"?
Install CMake:
sudo apt update
sudo apt install -y cmake
cmake --version

Why does run.sh fail with "make: *** No targets specified and no makefile found"?
Ensure you’re in the build directory and run:
cmake ..
make

Check for missing dependencies:
sudo apt install -y g++-13

Why does run.sh fail with "./SharpishlyApp: Is a directory"?
A directory named SharpishlyApp conflicts with the binary. Remove it:
rm -rf SharpishlyApp/build/SharpishlyApp

Rebuild:
cd SharpishlyApp/build && cmake .. && make

Runtime Issues
Why isn’t the HTTP server responding?

Ensure SharpishlyApp is running:./SharpishlyApp


Check port 1966:curl http://127.0.0.1:1966
sudo netstat -tuln | grep 1966


Allow port 1966:sudo ufw allow 1966
sudo ufw status



Why are permissions incorrect for src/View/www?
Verify permissions:
ls -l SharpishlyApp/src/View/www

Set permissions:
sudo chmod -R u+rwX SharpishlyApp/src/View/www

Docker Issues
Why does docker-compose fail with "command not found"?
Install Docker Compose:
sudo apt install -y docker-compose

Why does Docker fail with permission errors?
Add your user to the Docker group:
sudo usermod -aG docker $USER

Log out and back in, then retry.
Contributing
See CONTRIBUTING.md for guidelines on reporting bugs, suggesting features, and submitting pull requests.
Licensing
PREDEV is licensed under the MIT License. See README.md for details.
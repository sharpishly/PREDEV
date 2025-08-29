### READ ME ##

# Structure

project/
│── src/
│   ├── main.cpp          // Entry point
│   ├── controller/
│   │   └── AppController.cpp/.h
│   ├── model/
│   │   ├── DockerManager.cpp/.h
│   │   ├── CertManager.cpp/.h
│   │   ├── GitManager.cpp/.h
│   │   └── HostManager.cpp/.h
│   └── view/
│       └── HttpServer.cpp/.h   // Minimal web server
│── www/
│   ├── index.html
│   ├── style.css
│   └── script.js
│── CMakeLists.txt


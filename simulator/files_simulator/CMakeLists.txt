cmake_minimum_required(VERSION 3.24)
project(files_simulator)

set(CMAKE_CXX_STANDARD 14)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK2 REQUIRED gtk+-2.0)

include_directories(${GTK2_INCLUDE_DIRS})
link_directories(${GTK2_LIBRARY_DIRS})

add_definitions(${GTK2_CFLAGS_OTHER})

add_executable(sim
        Controller.cpp
        Controller.h
        ControllerInterface.h
        Instrucoes.h
        main.cpp
        Mneumonicos.h
        Model.cpp
        Model.h
        ModelInterface.h
        Registradores.h
        Video.h
        View.cpp
        View.h)

target_link_libraries(sim ${GTK2_LIBRARIES} gthread-2.0)

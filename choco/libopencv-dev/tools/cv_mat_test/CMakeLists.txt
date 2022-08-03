cmake_minimum_required(VERSION 2.8...3.16)
project(cv_mat_test)

find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(cv_mat_test main.cpp)

if(OpenCV_VERSION VERSION_LESS "4")
else()
	if(MSVC)
	else()
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11") # CMAKE_CXX_STANDARD does not seem to work on macOS...
	endif()
endif()

if(OpenCV_STATIC)
	if(MSVC)
		if(CMAKE_VERSION VERSION_LESS 3.15.0)
			set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /MTd")
			set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
			set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /MT")
			set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
		else()
			set_target_properties(cv_mat_test PROPERTIES MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
		endif()
	elseif(NOT APPLE)
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libgcc -static-libstdc++")
	endif()
endif()

target_link_libraries(cv_mat_test ${OpenCV_LIBS})

if(MINGW)
	message(STATUS "You might need to set CMake variables OpenCV_ARCH=x86 (or e.g. x64) and OpenCV_RUNTIME=mingw (or e.g. mingw7) if e.g. OpenCV mixes 64 bit libraries with the 32 bit compiler or cannot find the correct versions...")
endif()

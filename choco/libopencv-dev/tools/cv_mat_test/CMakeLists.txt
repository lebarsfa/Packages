cmake_minimum_required(VERSION 3.16...3.26)

project(cv_mat_test LANGUAGES CXX)

find_package(OpenCV REQUIRED)

add_executable(cv_mat_test main.cpp)

if(OpenCV_VERSION VERSION_LESS "4")
else()
	target_compile_features(cv_mat_test PRIVATE cxx_std_11)
endif()

if(OpenCV_STATIC)
	if(MSVC)
		set_target_properties(cv_mat_test PROPERTIES MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
	elseif(NOT APPLE)
		target_link_libraries(cv_mat_test PRIVATE -static-libgcc -static-libstdc++)
	endif()
endif()

target_include_directories(cv_mat_test PRIVATE ${OpenCV_INCLUDE_DIRS})
target_link_libraries(cv_mat_test PRIVATE ${OpenCV_LIBS})

if(MINGW)
	message(STATUS "You might need to set CMake variables OpenCV_ARCH=x86 (or e.g. x64) and OpenCV_RUNTIME=mingw (or e.g. mingw7) if OpenCV mixes 64 bit libraries with the 32 bit compiler or cannot find the correct versions...")
endif()

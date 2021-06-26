See https://ms-iot.github.io/ROSOnWindows/GettingStarted/UsingROSonWindows.html and https://ms-iot.github.io/ROSOnWindows/GettingStarted/GithubSetupCD.html#manually-publish-a-chocolatey-package :
rem Check using set command if you have special characters in some environment variables and remove them if needed since it may cause problems...
mkdir c:\catkin_ws\src
cd c:\catkin_ws
rosinstall_generator hector_gazebo_plugins --deps --exclude RPP --tar --flat > pkg.rosinstall
vcs import --force src < pkg.rosinstall
rosdep update
rosdep install --from-paths src --ignore-src -r -y
rem To just build and use locally
rem catkin_make
rem devel\setup.bat
rem rospack find hector_gazebo_plugins
rem To create the package
cd ..\src\hector_gazebo_plugins\package
rem Copy in package the content of this GitHub folder
catkin_make install -DCATKIN_BUILD_BINARY_PACKAGE=ON
cd install
7z a -tzip ..\src\hector_gazebo_plugins\package\tools\drop.zip *
cd ..\src\hector_gazebo_plugins\package
build.bat
choco install output\ros-%ROS_DISTRO%-hector_gazebo_plugins.1.0.0.nupkg -y --force
rem To check installation
rospack find hector_gazebo_plugins

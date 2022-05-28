get_filename_component (_PREFIX "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
set (MAVLink_INCLUDE_DIRS "${_PREFIX}/include")
# Compatibility with nonstandard and legacy package variable expectations.
set (MAVLink_INCLUDE_DIR "${MAVLink_INCLUDE_DIRS}")
set (MAVLINK_INCLUDE_DIRS "${MAVLink_INCLUDE_DIRS}")
set (MAVLINK_INCLUDE_DIR "${MAVLink_INCLUDE_DIRS}")
set (mavlink_INCLUDE_DIRS "${MAVLink_INCLUDE_DIRS}")
set (mavlink_INCLUDE_DIR "${MAVLink_INCLUDE_DIRS}")

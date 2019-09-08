

include(FindPackageHandleStandardArgs)

message(STATUS "Conan: Using autogenerated Findportaudio.cmake")
# Global approach
set(portaudio_FOUND 1)
set(portaudio_VERSION "v190600.20161030")

find_package_handle_standard_args(portaudio REQUIRED_VARS portaudio_VERSION VERSION_VAR portaudio_VERSION)
mark_as_advanced(portaudio_FOUND portaudio_VERSION)



set(portaudio_INCLUDE_DIRS "/home/alex/.conan/data/portaudio/v190600.20161030/bincrafters/stable/package/6af9cc7cb931c5ad942174fd7838eb655717c709/include")
set(portaudio_INCLUDES "/home/alex/.conan/data/portaudio/v190600.20161030/bincrafters/stable/package/6af9cc7cb931c5ad942174fd7838eb655717c709/include")
set(portaudio_DEFINITIONS )
set(portaudio_LINKER_FLAGS_LIST "" "")
set(portaudio_COMPILE_DEFINITIONS )
set(portaudio_COMPILE_OPTIONS_LIST "" "")
set(portaudio_LIBRARIES_TARGETS "") # Will be filled later, if CMake 3
set(portaudio_LIBRARIES "") # Will be filled later
set(portaudio_LIBS "") # Same as portaudio_LIBRARIES

mark_as_advanced(portaudio_INCLUDE_DIRS
                 portaudio_INCLUDES
                 portaudio_DEFINITIONS
                 portaudio_LINKER_FLAGS_LIST
                 portaudio_COMPILE_DEFINITIONS
                 portaudio_COMPILE_OPTIONS_LIST
                 portaudio_LIBRARIES
                 portaudio_LIBS
                 portaudio_LIBRARIES_TARGETS)

# Find the real .lib/.a and add them to portaudio_LIBS and portaudio_LIBRARY_LIST
set(portaudio_LIBRARY_LIST portaudio jack asound m pthread)
set(portaudio_LIB_DIRS "/home/alex/.conan/data/portaudio/v190600.20161030/bincrafters/stable/package/6af9cc7cb931c5ad942174fd7838eb655717c709/lib")
foreach(_LIBRARY_NAME ${portaudio_LIBRARY_LIST})
    unset(CONAN_FOUND_LIBRARY CACHE)
    find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${portaudio_LIB_DIRS}
                 NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
    if(CONAN_FOUND_LIBRARY)
        list(APPEND portaudio_LIBRARIES ${CONAN_FOUND_LIBRARY})
        if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
            # Create a micro-target for each lib/a found
            set(_LIB_NAME CONAN_LIB::portaudio_${_LIBRARY_NAME})
            if(NOT TARGET ${_LIB_NAME})
                # Create a micro-target for each lib/a found
                add_library(${_LIB_NAME} UNKNOWN IMPORTED)
                set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            else()
                message(STATUS "Skipping already existing target: ${_LIB_NAME}")
            endif()
            list(APPEND portaudio_LIBRARIES_TARGETS ${_LIB_NAME})
        endif()
        message(STATUS "Found: ${CONAN_FOUND_LIBRARY}")
    else()
        message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
        list(APPEND portaudio_LIBRARIES_TARGETS ${_LIBRARY_NAME})
        list(APPEND portaudio_LIBRARIES ${_LIBRARY_NAME})
    endif()
endforeach()
set(portaudio_LIBS ${portaudio_LIBRARIES})

if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
    # Target approach
    if(NOT TARGET portaudio::portaudio)
        add_library(portaudio::portaudio INTERFACE IMPORTED)
        
    if(portaudio_INCLUDE_DIRS)
      set_target_properties(portaudio::portaudio PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${portaudio_INCLUDE_DIRS}")
    endif()
    set_property(TARGET portaudio::portaudio PROPERTY INTERFACE_LINK_LIBRARIES ${portaudio_LIBRARIES_TARGETS} "${portaudio_LINKER_FLAGS_LIST}")
    set_property(TARGET portaudio::portaudio PROPERTY INTERFACE_COMPILE_DEFINITIONS ${portaudio_COMPILE_DEFINITIONS})
    set_property(TARGET portaudio::portaudio PROPERTY INTERFACE_COMPILE_OPTIONS "${portaudio_COMPILE_OPTIONS_LIST}")

        
    endif()
endif()
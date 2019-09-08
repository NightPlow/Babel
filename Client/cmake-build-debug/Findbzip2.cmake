

include(FindPackageHandleStandardArgs)

message(STATUS "Conan: Using autogenerated Findbzip2.cmake")
# Global approach
set(bzip2_FOUND 1)
set(bzip2_VERSION "1.0.6")

find_package_handle_standard_args(bzip2 REQUIRED_VARS bzip2_VERSION VERSION_VAR bzip2_VERSION)
mark_as_advanced(bzip2_FOUND bzip2_VERSION)



set(bzip2_INCLUDE_DIRS "/home/alex/.conan/data/bzip2/1.0.6/conan/stable/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/include")
set(bzip2_INCLUDES "/home/alex/.conan/data/bzip2/1.0.6/conan/stable/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/include")
set(bzip2_DEFINITIONS )
set(bzip2_LINKER_FLAGS_LIST "" "")
set(bzip2_COMPILE_DEFINITIONS )
set(bzip2_COMPILE_OPTIONS_LIST "" "")
set(bzip2_LIBRARIES_TARGETS "") # Will be filled later, if CMake 3
set(bzip2_LIBRARIES "") # Will be filled later
set(bzip2_LIBS "") # Same as bzip2_LIBRARIES

mark_as_advanced(bzip2_INCLUDE_DIRS
                 bzip2_INCLUDES
                 bzip2_DEFINITIONS
                 bzip2_LINKER_FLAGS_LIST
                 bzip2_COMPILE_DEFINITIONS
                 bzip2_COMPILE_OPTIONS_LIST
                 bzip2_LIBRARIES
                 bzip2_LIBS
                 bzip2_LIBRARIES_TARGETS)

# Find the real .lib/.a and add them to bzip2_LIBS and bzip2_LIBRARY_LIST
set(bzip2_LIBRARY_LIST bz2)
set(bzip2_LIB_DIRS "/home/alex/.conan/data/bzip2/1.0.6/conan/stable/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/lib")
foreach(_LIBRARY_NAME ${bzip2_LIBRARY_LIST})
    unset(CONAN_FOUND_LIBRARY CACHE)
    find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${bzip2_LIB_DIRS}
                 NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
    if(CONAN_FOUND_LIBRARY)
        list(APPEND bzip2_LIBRARIES ${CONAN_FOUND_LIBRARY})
        if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
            # Create a micro-target for each lib/a found
            set(_LIB_NAME CONAN_LIB::bzip2_${_LIBRARY_NAME})
            if(NOT TARGET ${_LIB_NAME})
                # Create a micro-target for each lib/a found
                add_library(${_LIB_NAME} UNKNOWN IMPORTED)
                set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            else()
                message(STATUS "Skipping already existing target: ${_LIB_NAME}")
            endif()
            list(APPEND bzip2_LIBRARIES_TARGETS ${_LIB_NAME})
        endif()
        message(STATUS "Found: ${CONAN_FOUND_LIBRARY}")
    else()
        message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
        list(APPEND bzip2_LIBRARIES_TARGETS ${_LIBRARY_NAME})
        list(APPEND bzip2_LIBRARIES ${_LIBRARY_NAME})
    endif()
endforeach()
set(bzip2_LIBS ${bzip2_LIBRARIES})

if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
    # Target approach
    if(NOT TARGET bzip2::bzip2)
        add_library(bzip2::bzip2 INTERFACE IMPORTED)
        
    if(bzip2_INCLUDE_DIRS)
      set_target_properties(bzip2::bzip2 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${bzip2_INCLUDE_DIRS}")
    endif()
    set_property(TARGET bzip2::bzip2 PROPERTY INTERFACE_LINK_LIBRARIES ${bzip2_LIBRARIES_TARGETS} "${bzip2_LINKER_FLAGS_LIST}")
    set_property(TARGET bzip2::bzip2 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${bzip2_COMPILE_DEFINITIONS})
    set_property(TARGET bzip2::bzip2 PROPERTY INTERFACE_COMPILE_OPTIONS "${bzip2_COMPILE_OPTIONS_LIST}")

        
    endif()
endif()
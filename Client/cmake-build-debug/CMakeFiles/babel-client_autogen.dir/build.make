# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/alex/bin/Programs/clion-2019.2.1/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/alex/bin/Programs/clion-2019.2.1/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/alex/Epitech/Cpp/babel/Client

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/alex/Epitech/Cpp/babel/Client/cmake-build-debug

# Utility rule file for babel-client_autogen.

# Include the progress variables for this target.
include CMakeFiles/babel-client_autogen.dir/progress.make

CMakeFiles/babel-client_autogen:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/alex/Epitech/Cpp/babel/Client/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic MOC and UIC for target babel-client"
	/home/alex/bin/Programs/clion-2019.2.1/bin/cmake/linux/bin/cmake -E cmake_autogen /home/alex/Epitech/Cpp/babel/Client/cmake-build-debug/CMakeFiles/babel-client_autogen.dir/AutogenInfo.cmake Debug

babel-client_autogen: CMakeFiles/babel-client_autogen
babel-client_autogen: CMakeFiles/babel-client_autogen.dir/build.make

.PHONY : babel-client_autogen

# Rule to build all files generated by this target.
CMakeFiles/babel-client_autogen.dir/build: babel-client_autogen

.PHONY : CMakeFiles/babel-client_autogen.dir/build

CMakeFiles/babel-client_autogen.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/babel-client_autogen.dir/cmake_clean.cmake
.PHONY : CMakeFiles/babel-client_autogen.dir/clean

CMakeFiles/babel-client_autogen.dir/depend:
	cd /home/alex/Epitech/Cpp/babel/Client/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alex/Epitech/Cpp/babel/Client /home/alex/Epitech/Cpp/babel/Client /home/alex/Epitech/Cpp/babel/Client/cmake-build-debug /home/alex/Epitech/Cpp/babel/Client/cmake-build-debug /home/alex/Epitech/Cpp/babel/Client/cmake-build-debug/CMakeFiles/babel-client_autogen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/babel-client_autogen.dir/depend

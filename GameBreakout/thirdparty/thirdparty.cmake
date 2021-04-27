# OpenGL
find_package(OpenGL REQUIRED)
set(OPENGL_LIBRARY ${OPENGL_LIBRARIES})

# irrKlang
find_package(Irrklang REQUIRED)

# freetype2
set(FREETYPE_DIR "${THIRDPARTY_DIR}/freetype2")

add_subdirectory("${FREETYPE_DIR}")

set(FREETYPE_LIBRARY "freetype")
set(FREETYPE_INCLUDE_DIR "${FREETYPE_DIR}/include")

MESSAGE(STATUS "FREETYPE_LIBRARY = ${FREETYPE_LIBRARY}")
MESSAGE(STATUS "FREETYPE_INCLUDE_DIR = ${FREETYPE_INCLUDE_DIR}")

# glfw
find_library(GLFW_LIBRARY "glfw" "/usr/lib" "/usr/local/lib")
find_path(GLFW_INCLUDE_DIR "glfw/glfw.h" "/usr/include" "/usr/local/include")

if((NOT GLFW_LIBRARY) OR (NOT GLFW_INCLUDE_DIR))
	set(GLFW_DIR "${THIRDPARTY_DIR}/glfw")

	set(GLFW_BUILD_EXAMPLES OFF CACHE INTERNAL "Build the GLFW example programs")
	set(GLFW_BUILD_TESTS    OFF CACHE INTERNAL "Build the GLFW test programs")
	set(GLFW_BUILD_DOCS     OFF CACHE INTERNAL "Build the GLFW documentation")
	set(GLFW_INSTALL        OFF CACHE INTERNAL "Generate installation target")

    add_subdirectory("${GLFW_DIR}")

	set(GLFW_LIBRARY "glfw" "${GLFW_LIBRARIES}")
	set(GLFW_INCLUDE_DIR "${GLFW_DIR}/include")
endif()

# glad
set(GLAD_DIR "${THIRDPARTY_DIR}/glad")
add_library("glad" STATIC "${GLAD_DIR}/src/glad.c")
target_include_directories("glad" PRIVATE "${GLAD_DIR}/include")

set(GLAD_LIBRARY "glad")
set(GLAD_INCLUDE_DIR "${GLAD_DIR}/include")

# glm
set(GLM_DIR "${THIRDPARTY_DIR}/glm")
execute_process(COMMAND git submodule update --init ${GLM_DIR}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

set(GLM_INCLUDE_DIR "${GLM_DIR}")

# imgui
set(IMGUI_DIR "${THIRDPARTY_DIR}/imgui")
execute_process(COMMAND git submodule update --init ${IMGUI_DIR}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_library("imgui" STATIC "${IMGUI_DIR}/imgui.cpp"
                           "${IMGUI_DIR}/imgui_demo.cpp"
                           "${IMGUI_DIR}/imgui_draw.cpp"
                           "${IMGUI_DIR}/imgui_widgets.cpp")
target_include_directories("imgui" PRIVATE "${IMGUI_DIR}")

set(IMGUI_LIBRARY "imgui")
set(IMGUI_INCLUDE_DIR "${IMGUI_DIR}")

# stb_image
set(STB_IMAGE_DIR "${THIRDPARTY_DIR}/stb_image")
add_library("stb_image" STATIC "${STB_IMAGE_DIR}/stb_image.cpp")
target_include_directories("stb_image" PRIVATE "${STB_IMAGE_DIR}")

set(STB_IMAGE_LIBRARY "stb_image")
set(STB_IMAGE_INCLUDE_DIR "${STB_IMAGE_DIR}")
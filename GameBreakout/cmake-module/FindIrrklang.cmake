if(CMAKE_CL_64)
	FIND_PATH( IRRKLANG_INCLUDE_DIR NAMES irrKlang.h PATHS
		   "${PROJECT_SOURCE_DIR}/thirdparty/irrKlang-64bit-1.6.0/include")
		   
    # 64 bits
	if(WIN32)
		if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
			MESSAGE(STATUS "Using MSVC!")
			FIND_LIBRARY( IRRKLANG_LIBRARY NAMES irrKlang PATHS
				"${PROJECT_SOURCE_DIR}/thirdparty/irrKlang-64bit-1.6.0/lib/Winx64-visualStudio")
		endif()
	endif()
else()
    # 32 bits
	FIND_PATH( IRRKLANG_INCLUDE_DIR NAMES irrKlang.h PATHS
		   "${PROJECT_SOURCE_DIR}/thirdparty/irrKlang-1.6.0/include")
		   
	if(WIN32)
		if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
			MESSAGE(STATUS "Using MSVC!")
			FIND_LIBRARY( IRRKLANG_LIBRARY NAMES irrKlang PATHS
				"${PROJECT_SOURCE_DIR}/thirdparty/irrKlang-1.6.0/lib/Win32-visualStudio")
		elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
			MESSAGE(STATUS "Using GCC!")
			FIND_LIBRARY( IRRKLANG_LIBRARY NAMES libirrKlang.a PATHS
					"${PROJECT_SOURCE_DIR}/thirdparty/irrKlang-1.6.0/lib/Win32-gcc")
		endif()
	elseif(APPLE)
		FIND_LIBRARY( IRRKLANG_LIBRARY NAMES libirrklang.dylib PATHS
			"${PROJECT_SOURCE_DIR}/thirdparty/irrKlang-1.6.0/bin/macosx-gcc")
	elseif(UNIX AND NOT APPLE)	
		FIND_LIBRARY( IRRKLANG_LIBRARY NAMES IrrKlang PATHS
				"${PROJECT_SOURCE_DIR}/thirdparty/irrKlang-1.6.0/bin/linux-gcc") 
	endif()
endif()

SET(IRRKLANG_FOUND "NO")
IF(IRRKLANG_LIBRARY AND IRRKLANG_INCLUDE_DIR)
    SET(IRRKLANG_FOUND "YES")
ENDIF(IRRKLANG_LIBRARY AND IRRKLANG_INCLUDE_DIR)

if(IRRKLANG_FOUND)
	MESSAGE(STATUS "IrrKlang Found!")
	
	MESSAGE(STATUS "IRRKLANG_LIBRARY = ${IRRKLANG_LIBRARY}")
	MESSAGE(STATUS "IRRKLANG_INCLUDE_DIR = ${IRRKLANG_INCLUDE_DIR}")
else()
	MESSAGE(STATUS "IrrKlang NOT Found!")
endif()
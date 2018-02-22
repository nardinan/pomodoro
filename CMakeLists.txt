cmake_minimum_required(VERSION 3.9)

add_executable(pomodoro
        bubble.obj.c
        bubble.obj.h
        camera.obj.c
        camera.obj.h
        character.obj.c
        character.obj.h
        collector.obj.c
        collector.obj.h
        director.obj.c
        director.obj.h
        effecteer.obj.c
        effecteer.obj.h
        factory.obj.c
        factory.obj.h
        item.obj.c
        item.obj.h
        landscape.obj.c
        landscape.obj.h
        loader.obj.c
        loader.obj.h
        miranda.c
        miranda.h
        module_configuration.obj.c
        module_configuration.obj.h
        pomodoro.c
        puppeteer.obj.c
        puppeteer.obj.h
        screenwriter.obj.c
        screenwriter.obj.h
        stagecrafter.obj.c
        stagecrafter.obj.h)

INCLUDE(FindPkgConfig)
PKG_SEARCH_MODULE(SDL2 REQUIRED sdl2)
PKG_SEARCH_MODULE(SDL2TTF REQUIRED SDL2_ttf)
PKG_SEARCH_MODULE(SDL2IMAGE REQUIRED SDL2_image)
PKG_SEARCH_MODULE(SDL2MIXER REQUIRED SDL2_mixer)

INCLUDE_DIRECTORIES(${SDL2_INCLUDE_DIRS} ${SDL2TTF_INCLUDE_DIRS} ${SDL2IMAGE_INCLUDE_DIRS} ${SDL2MIXER_INCLUDE_DIRS} /usr/include)

TARGET_LINK_LIBRARIES(pomodoro ${SDL2_LIBRARIES} ${SDL2TTF_LIBRARIES} ${SDL2IMAGE_LIBRARIES} ${SDL2MIXER_LIBRARIES} miranda_ground miranda_objects
        miranda_geometry miranda_io miranda_network miranda_media miranda_ui)

# We need to transfer the 'data' directory into the executable file
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/data DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
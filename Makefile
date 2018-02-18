objects = miranda.o pomodoro.o loader.obj.o factory.obj.o module_configuration.obj.o bubble.obj.o camera.obj.o character.obj.o puppeteer.obj.o \
		  effecteer.obj.o item.obj.o landscape.obj.o stagecrafter.obj.o collector.obj.o screenwriter.obj.o director.obj.o
project = pomodoro
name = pomodoro
cc = gcc -g $(debug)
cflags = -I/usr/local/include -I. -fPIC `sdl2-config --cflags` -Wall -Wno-variadic-macros -Wno-pointer-arith -Wno-pointer-to-int-cast -c
lflags = -Wall
libags = -L/usr/local/lib `sdl2-config --libs` -lpthread -lmiranda_ground -lmiranda_objects -lmiranda_network -lmiranda_io -lmiranda_geometry \
		 -lmiranda_media -lmiranda_ui -lm
executable = $(name).bin

all: $(objects)
	$(cc) $(lflags) $(objects) -o $(executable) $(libags)

miranda.o: miranda.c miranda.h
	$(cc) $(cflags) miranda.c

pomodoro.o: pomodoro.c character.obj.h factory.obj.h
	$(cc) $(cflags) pomodoro.c

loader.obj.o: loader.obj.c loader.obj.h miranda.h
	$(cc) $(cflags) loader.obj.c

factory.obj.o: factory.obj.c factory.obj.h miranda.h
	$(cc) $(cflags) factory.obj.c

module_configuration.obj.o: module_configuration.obj.c module_configuration.obj.h
	$(cc) $(cflags) module_configuration.obj.c

bubble.obj.o: bubble.obj.c bubble.obj.h factory.obj.h miranda.h
	$(cc) $(cflags) bubble.obj.c

camera.obj.o: camera.obj.c camera.obj.h miranda.h
	$(cc) $(cflags) camera.obj.c

character.obj.o: character.obj.c character.obj.h factory.obj.h
	$(cc) $(cflags) character.obj.c

puppeteer.obj.o: puppeteer.obj.c puppeteer.obj.h character.obj.h
	$(cc) $(cflags) puppeteer.obj.c

effecteer.obj.o: effecteer.obj.c effecteer.obj.h factory.obj.h
	$(cc) $(cflags) effecteer.obj.c

item.obj.o: item.obj.c item.obj.h factory.obj.h
	$(cc) $(cflags) item.obj.c

landscape.obj.o: landscape.obj.c landscape.obj.h factory.obj.h
	$(cc) $(cflags) landscape.obj.c

stagecrafter.obj.o: stagecrafter.obj.c stagecrafter.obj.h puppeteer.obj.h
	$(cc) $(cflags) stagecrafter.obj.c

collector.obj.o: collector.obj.c collector.obj.h factory.obj.h
	$(cc) $(cflags) collector.obj.c

screenwriter.obj.o: screenwriter.obj.c screenwriter.obj.h factory.obj.h
	$(cc) $(cflags) screenwriter.obj.c

director.obj.o: director.obj.c director.obj.h miranda.h
	$(cc) $(cflags) director.obj.c

clean:
	rm -f *.o
	rm -f $(executable)

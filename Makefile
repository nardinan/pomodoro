objects = miranda.o pomodoro.o factory.obj.o bubble.obj.o character.obj.o puppeteer.obj.o
project = pomodoro
name = pomodoro
cc = clang -g $(debug)
cflags = -fPIC -Wall -Wno-variadic-macros -Wno-pointer-arith -Wno-pointer-to-int-cast -c
lflags = -Wall
libags = -L/usr/lib -lpthread -lmiranda_ground -lmiranda_objects -lmiranda_io -lmiranda_geometry -lmiranda_media -lmiranda_ui
executable = $(name).bin

all: $(objects)
	$(cc) $(lflags) $(objects) -o $(executable) $(libags)

miranda.o: miranda.c miranda.h
	$(cc) $(cflags) miranda.c

pomodoro.o: pomodoro.c character.obj.h factory.obj.h
	$(cc) $(cflags) pomodoro.c

factory.obj.o: factory.obj.c factory.obj.h miranda.h
	$(cc) $(cflags) factory.obj.c

bubble.obj.o: bubble.obj.c bubble.obj.h factory.obj.h miranda.h
	$(cc) $(cflags) bubble.obj.c

character.obj.o: character.obj.c character.obj.h factory.obj.h miranda.h
	$(cc) $(cflags) character.obj.c

puppeteer.o: puppeteer.obj.c puppeteer.obj.h character.obj.h
	$(cc) $(cflags) puppeteer.obj.c

clean:
	rm -f *.o
	rm -f $(executable)

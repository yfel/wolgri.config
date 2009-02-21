
.PHONY: all
all: libwinmenu.so

libwinmenu.so: libwinmenu.o
	gcc -shared libwinmenu.o -o libwinmenu.so `pkg-config gtk+-2.0 --libs`

libwinmenu.o: libwinmenu.c
	gcc -fPIC -c libwinmenu.c `pkg-config gtk+-2.0 --cflags`

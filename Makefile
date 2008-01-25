CC=/usr/local/bin/arm-apple-darwin-gcc

CPPFLAGS=-Wall -O3
LD=$(CC)
LDFLAGS = -framework CoreFoundation \
          -framework Foundation \
          -framework UIKit \
          -framework LayerKit \
          -framework CoreGraphics \
          -framework GraphicsServices \
          -framework CoreSurface \
          -lobjc

OBJECTS= main.o SplitterApplication.o SplitsView.o GroupView.o SoloView.o
APP=Splitter

all:	${APP}

%.o:	%.m
		$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
		rm -f *.o $(APP)


${APP}:	${OBJECTS}
	$(LD) $(LDFLAGS) -o $@ $^

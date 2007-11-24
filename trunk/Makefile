
CC = /usr/local/bin/arm-apple-darwin-gcc
LD = $(CC)
LDFLAGS = -Wl,-syslibroot,/usr/local/share/iphone-filesystem -ObjC \
	-framework CoreFoundation -framework Foundation \
	-framework UIKit -framework LayerKit -framework Coregraphics \
	-framework WebCore -framework WebKit  -lobjc
CFLAGS = -Wall -std=gnu99
TARGET = Splitter

all:	$(TARGET)

$(TARGET): main.o SplitterApplication.o SplitsView.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o:	%.m
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:	
	rm -fr *.o $(TARGET)

package: $(TARGET)
	rm -fr $(TARGET).app
	mkdir -p $(TARGET).app
	cp $(TARGET) $(TARGET).app
	cp Info.plist $(TARGET).app
	cp icon.png $(TARGET).app
		
install: $(TARGET)
	winscp -r $(TARGET).app root@${IPHONE_ADDRESS}:/Applications

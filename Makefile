IDIR =./include
LDIR = /usr/lib64
CC=g++
CFLAGS= -g -I$(IDIR) -L$(LDIR)
NAME=gl
ODIR=obj
SDIR=src

LIBS=-lGLEW -lglut -lGL -lGLU

_DEPS = hellomake.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

SRC=$(wildcard $(SDIR)/*.cpp)
OBJ_TEMP=$(SRC:.cpp=.o)
OBJ=$(subst src,obj,$(OBJ_TEMP))

$(ODIR)/%.o: $(SDIR)/%.cpp 
	$(info Compiling $@)
	$(CC) $(CFLAGS) -c -o $@ $< 
	$(info Done compiling $@)
	$(info )

.PHONY: default

default: build_info obj $(OBJ) 
	$(CC) $(CFLAGS) -o $(NAME) $(OBJ) $(LIBS)

.PHONY: obj
obj:
	if [ ! -d $(ODIR) ]; then mkdir $(ODIR); fi

.PHONE: build_info
build_info:
	$(info ------- Build start -------)
	$(info Starting compilation of object files)
	$(info CFLAGS=$(CFLAGS))
	$(info SRC=$(SRC))
	$(info OBJ_TEMP=$(OBJ_TEMP))
	$(info OBJ=$(OBJ))
	$(info )

clean:
	@if [ -d $(ODIR) ]; then rm -Rf $(ODIR); fi
	@if [ -e $(NAME) ]; then rm $(NAME); fi
	$(info Done)
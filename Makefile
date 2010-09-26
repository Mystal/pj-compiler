CC := clang

SRCDIR := src
BUILDDIR := build

BINS := $(addprefix $(BUILDDIR)/, lexer expr)
SBINS := $(addsuffix -static, $(BINS))
OBJS := $(addprefix $(BUILDDIR)/, buffer.o lexer.o lexfsm.o str.o token.o directive.o stack.o)

INCS := 
LIBS := 

.PHONY: all all-static expr lexer expr-static lexer-static clean

expr lexer expr-static lexer-static: %: $(BUILDDIR)/%

all: $(BINS)

all-static: $(SBINS)

clean:
	-rm -rf $(BUILDDIR)

$(BINS): %: $(OBJS) %driver.o
	$(CC) $(LIBS) -g -o $@ $^

$(SBINS): %: $(OBJS) %driver.o
	$(CC) $(LIBS) -static -g -o $@ $^

$(BUILDDIR)/%.o: $(SRCDIR)/%.c | $(BUILDDIR)
	$(CC) $(INCS) -std=c99 -g -c -o $@ $<

$(BUILDDIR):
	mkdir $(BUILDDIR)

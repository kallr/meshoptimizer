.SUFFIXES:
MAKEFLAGS+=-r

BUILD=build

SOURCES=$(wildcard src/*.cpp demo/*.cpp)
OBJECTS=$(SOURCES:%=$(BUILD)/%.o)

EXECUTABLE=$(BUILD)/meshoptimizer

CXXFLAGS=-g -Wall -Wextra -Wno-missing-field-initializers -Werror -std=c++11 -O3 -DNDEBUG
LDFLAGS=

all: $(EXECUTABLE)

test: $(EXECUTABLE)
	$(EXECUTABLE) demo/bunny.obj

format:
	clang-format -i $(SOURCES)

$(EXECUTABLE): $(OBJECTS)
	$(CXX) $(OBJECTS) $(LDFLAGS) -o $@

$(BUILD)/%.o: %
	@mkdir -p $(dir $@)
	$(CXX) $< $(CXXFLAGS) -c -MMD -MP -o $@

-include $(OBJECTS:.o=.d)
clean:
	rm -rf $(BUILD)

.PHONY: all clean format

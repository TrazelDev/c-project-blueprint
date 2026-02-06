all: run


APPLICATION_NAME := app
SRCS_DIR := src
BINS_DIR := bin

CC := gcc
CFLAGS := -MMD -MP -I src/
LDFLAGS := -lm


TARGET := $(BINS_DIR)/$(APPLICATION_NAME)
SRCS = $(shell find ./$(SRCS_DIR) -type f -name *.c)
HEADERS = $(shell find ./$(SRCS_DIR) -type f -name *.h)
OBJS = $(patsubst ./$(SRCS_DIR)/%.c,./$(BINS_DIR)/%.o,$(SRCS))
DEPS = $(OBJS:.o=.d)


run: build
	./$(TARGET)
build: $(TARGET)
clean:
	rm -rf $(BINS_DIR)/


$(TARGET): $(OBJS) $(HEADERS)
	$(CC) -o $@ $(OBJS)
./$(BINS_DIR)/%.o: ./$(SRCS_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@


-include $(DEPS)

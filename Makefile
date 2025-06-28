# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -g -Iinclude
SRC_DIR = src
BUILD_DIR = build

# All source files excluding test_logic.c
SRCS = $(filter-out $(SRC_DIR)/test_logic.c, $(wildcard $(SRC_DIR)/*.c))
OBJS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

# Final game binary
TARGET = $(BUILD_DIR)/rock_paper_scissors

all: $(TARGET)

# Link final binary
$(TARGET): $(OBJS)
	@$(CC) $(CFLAGS) -o $@ $^

# Compile each source file to object file
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@$(CC) $(CFLAGS) -c $< -o $@

# Run the game
run: $(TARGET)
	@./$(TARGET)

# Build and run test binary
test: $(SRC_DIR)/test_logic.c $(SRC_DIR)/game_logic.c
	@$(CC) $(CFLAGS) -o $(BUILD_DIR)/test_logic $(SRC_DIR)/test_logic.c $(SRC_DIR)/game_logic.c
	@./$(BUILD_DIR)/test_logic

# Clean build files
clean:
	@rm -f $(BUILD_DIR)/*.o $(TARGET) $(BUILD_DIR)/test_logic

.PHONY: all clean run test


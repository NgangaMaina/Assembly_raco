# Auto-detect assembler
ASM := $(shell command -v nasm 2>/dev/null || command -v as 2>/dev/null)
ifeq ($(ASM),)
    $(error No assembler found!)
endif

# Set flags based on assembler
ifeq ($(notdir $(ASM)),nasm)
    ASMFLAGS = -f elf64 -g -F dwarf
else
    ASMFLAGS = -g
endif

CC = gcc
CFLAGS = -no-pie
LD = ld
LDFLAGS = 

# Function to detect if assembly uses external C functions
# Looks for common patterns: extern printf, extern malloc, etc.
uses_c_libs = $(shell grep -E '^\s*extern\s+(printf|scanf|malloc|free|exit|puts|strlen|strcmp|strcpy|fopen|fclose)' $(1) 2>/dev/null)

# Pattern rules for .asm files
%: %.asm
	@echo "Assembling $<..."
	$(ASM) $(ASMFLAGS) $< -o $@.o
	@echo "Linking $@..."
	@if [ -n "$$(grep -E '^\s*extern\s+(printf|scanf|malloc|free|exit|puts|strlen|strcmp|strcpy|fopen|fclose)' $< 2>/dev/null)" ]; then \
		echo "  (Using gcc - detected C library calls)"; \
		$(CC) $(CFLAGS) -o $@ $@.o; \
	else \
		echo "  (Using ld - pure assembly)"; \
		$(LD) $(LDFLAGS) -o $@ $@.o; \
	fi
	@echo "Done: $@"

# Pattern rules for .s files  
%: %.s
	@echo "Assembling $<..."
	$(ASM) $(ASMFLAGS) $< -o $@.o
	@echo "Linking $@..."
	@if [ -n "$$(grep -E '^\s*extern\s+(printf|scanf|malloc|free|exit|puts|strlen|strcmp|strcpy|fopen|fclose)' $< 2>/dev/null)" ]; then \
		echo "  (Using gcc - detected C library calls)"; \
		$(CC) $(CFLAGS) -o $@ $@.o; \
	else \
		echo "  (Using ld - pure assembly)"; \
		$(LD) $(LDFLAGS) -o $@ $@.o; \
	fi
	@echo "Done: $@"

# Manual override targets if auto-detection fails
%-gcc: %.asm
	@echo "Assembling $< (forced gcc linking)..."
	$(ASM) $(ASMFLAGS) $< -o $*.o
	@echo "Linking with gcc..."
	$(CC) $(CFLAGS) -o $* $*.o
	@echo "Done: $*"

%-ld: %.asm
	@echo "Assembling $< (forced ld linking)..."
	$(ASM) $(ASMFLAGS) $< -o $*.o
	@echo "Linking with ld..."
	$(LD) $(LDFLAGS) -o $* $*.o
	@echo "Done: $*"

# Run - build first, then run
r-%: 
	@$(MAKE) $*
	@echo "Running $*..."
	@./$*
	@echo "Exit code: $$?"

# Debug - build first, then debug
d-%:
	@$(MAKE) $*
	gdb ./$*

.PHONY: clean

clean:
	rm -f *.o
	rm -f randomarr 

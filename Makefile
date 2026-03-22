.PHONY: help list pack pack-all clean

# Project configuration
SKILLS_DIR := .
OUTPUT_DIR := dist

# Color definitions
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m

# Default target
help:
	@echo "📦 Skill Packaging Tool"
	@echo ""
	@echo "Usage:"
	@echo "  make list              List all available skills"
	@echo "  make pack SKILL=name   Pack a specific skill"
	@echo "  make pack-all          Pack all skills"
	@echo "  make clean             Clean packaging output"
	@echo ""
	@echo "Examples:"
	@echo "  make pack SKILL=terabox-storage"
	@echo "  make pack SKILL=terabox-storage OVERWRITE=1"

# List all skills
list:
	@echo "$(BLUE)Available Skills:$(NC)"
	@echo ""
	@for skill_path in $(SKILLS_DIR)/*/; do \
		if [ -d "$$skill_path" ]; then \
			skill_name=$$(basename "$$skill_path"); \
			if [ -f "$$skill_path/SKILL.md" ]; then \
				echo "  ✓ $$skill_name"; \
			else \
				echo "  ⚠ $$skill_name (missing SKILL.md)"; \
			fi \
		fi \
	done
	@echo ""

# Pack a single skill
pack:
	@if [ -z "$(SKILL)" ]; then \
		echo "$(RED)❌ Error: Please specify the SKILL parameter$(NC)"; \
		echo "Usage: make pack SKILL=skill-name"; \
		exit 1; \
	fi
	@if [ ! -d "$(SKILLS_DIR)/$(SKILL)" ]; then \
		echo "$(RED)❌ Error: Skill '$(SKILL)' does not exist$(NC)"; \
		$(MAKE) list; \
		exit 1; \
	fi
	@mkdir -p $(OUTPUT_DIR)
	$(eval VERSION := $(shell cat $(SKILLS_DIR)/$(SKILL)/VERSION 2>/dev/null || echo "unknown"))
	$(eval ZIP_NAME := $(SKILL)-$(VERSION).zip)
	@if [ -f "$(OUTPUT_DIR)/$(ZIP_NAME)" ] && [ -z "$(OVERWRITE)" ]; then \
		echo "$(YELLOW)⚠️  $(OUTPUT_DIR)/$(ZIP_NAME) already exists$(NC)"; \
		echo "Use OVERWRITE=1 to overwrite"; \
		exit 1; \
	fi
	@echo "$(BLUE)📦 Packing: $(SKILL) v$(VERSION)$(NC)"
	@cd $(SKILLS_DIR) && zip -r "$(CURDIR)/$(OUTPUT_DIR)/$(ZIP_NAME)" "$(SKILL)" \
		-x "*/.git/*" "*/.DS_Store" "*/node_modules/*" "*/__pycache__/*" \
		-x "*/.env*" "*/.idea/*" "*/.vscode/*" "*/dist/*" "*/build/*" \
		-x "*.pyc" "*.log" "*.tmp" "*.swp" -q
	@echo "$(GREEN)✅ Packed successfully: $(OUTPUT_DIR)/$(ZIP_NAME)$$(du -h $(OUTPUT_DIR)/$(ZIP_NAME) | cut -f1 | xargs -I {} echo ' ({}')$(NC)"
	@echo ""
	@echo "Files in package:"
	@unzip -l "$(OUTPUT_DIR)/$(ZIP_NAME)" | tail -n +4 | grep -v "^$$" | grep -v "^--------" | awk '{print "  " $$4}' | head -15
	@file_count=$$(unzip -l "$(OUTPUT_DIR)/$(ZIP_NAME)" | grep -c "^.*[0-9].*$(SKILL)" || echo 0); \
	if [ "$$file_count" -gt 15 ]; then \
		echo "  ... and $$(($$file_count - 15)) more files"; \
	fi

# Pack all skills
pack-all:
	@echo "$(BLUE)📦 Packing all skills...$(NC)"
	@echo ""
	@mkdir -p $(OUTPUT_DIR)
	@for skill_path in $(SKILLS_DIR)/*/; do \
		if [ -d "$$skill_path" ]; then \
			skill_name=$$(basename "$$skill_path"); \
			$(MAKE) pack SKILL=$$skill_name OVERWRITE=1; \
			echo ""; \
		fi \
	done
	@echo "$(GREEN)✅ All skills packed$(NC)"
	@echo "Output directory: $(OUTPUT_DIR)/"
	@ls -lh $(OUTPUT_DIR)/*.zip 2>/dev/null || echo "No packed files yet"

# Clean output directory
clean:
	@rm -rf $(OUTPUT_DIR)/
	@echo "$(GREEN)✅ Cleaned $(OUTPUT_DIR)/ directory$(NC)"

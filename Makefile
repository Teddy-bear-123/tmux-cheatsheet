.PHONY: all build install clean uninstall

PLUGIN_DIR := $(HOME)/.tmux/plugins/tmux-cheatsheet

all: install

build:
	@echo "Building Rust binary..."
	chmod +x scripts/*.sh
	./scripts/build.sh

install: build
	@echo "Installing tmux-cheatsheet plugin..."
	mkdir -p $(PLUGIN_DIR)
	cp -r . $(PLUGIN_DIR)/
	chmod +x $(PLUGIN_DIR)/cheatsheet.tmux
	chmod +x $(PLUGIN_DIR)/scripts/*.sh
	@echo "Installation complete!"

clean:
	@echo "Cleaning build artifacts..."
	cargo clean
	rm -rf target/

uninstall:
	@echo "Uninstalling tmux-cheatsheet plugin..."
	rm -rf $(PLUGIN_DIR)
	@echo "Uninstallation complete!"


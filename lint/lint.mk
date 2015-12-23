# Use cpplint.py from Google to check C++ style
CXX_SRCS := $(shell find \
        ./ \
        -name "*.cpp" -or -name "*.hpp" -or -name "*.c" -or -name "*.h")
LINT_SCRIPT := lint/cpplint.py
LINT_OUTPUT_DIR := lint/.lint
LINT_EXT := lint.txt
LINT_OUTPUTS := $(addsuffix .$(LINT_EXT), $(addprefix $(LINT_OUTPUT_DIR)/, $(CXX_SRCS)))
EMPTY_LINT_REPORT := lint/.$(LINT_EXT)
NONEMPTY_LINT_REPORT := lint/$(LINT_EXT)

lint: $(EMPTY_LINT_REPORT)

lintclean:
	@ $(RM) -r $(LINT_OUTPUT_DIR) $(EMPTY_LINT_REPORT) $(NONEMPTY_LINT_REPORT)

$(LINT_OUTPUT_DIR):
	@ mkdir -p $(LINT_OUTPUT_DIR)

$(EMPTY_LINT_REPORT): $(LINT_OUTPUTS)
	@ cat $(LINT_OUTPUTS) > $@
	@ if [ -s "$@" ]; then \
		cat $@; \
		mv $@ $(NONEMPTY_LINT_REPORT); \
		echo "Found one or more lint errors."; \
		exit 1; \
	  fi; \
          $(RM) $(NONEMPTY_LINT_REPORT); \
          echo "No lint errors!";

$(LINT_OUTPUTS): $(LINT_OUTPUT_DIR)/%.lint.txt : % $(LINT_SCRIPT)
	@ mkdir -p $(dir $@)
	@ python $(LINT_SCRIPT) $< 2>&1 \
                | grep -v "^Done processing " \
                | grep -v "^Total errors found: 0" \
                > $@ \
                || true

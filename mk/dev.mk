.PHONY: dev-help bootrom-sim regress clean-build docs-check docs-site-install \
	docs-site-prepare docs-site-dev docs-site-build docs-site-preview docs-site-check

dev-help:
	@printf '%s\n' 'mpc-soc maintainer commands'
	@printf '%s\n' '  make -f Makefile.dev docs-check           Validate bilingual docs'
	@printf '%s\n' '  make -f Makefile.dev docs-site-check      Build the public documentation site'
	@printf '%s\n' '  make -f Makefile.dev bootrom-sim CASE=... Run one archived bootrom case'
	@printf '%s\n' '  make -f Makefile.dev regress              Run the full bootrom regression'
	@printf '%s\n' '  make -f Makefile.dev clean-build          Remove the entire build/ tree'

bootrom-sim:
	@test -n "$(CASE)" || (printf "$(CLR_ERR)ERROR: set CASE=<name>, e.g. make -f Makefile.dev bootrom-sim CASE=hello$(CLR_RESET)\n"; exit 2)
	@$(PYTHON) $(SOC_ROOT)/scripts/verilator_regress.py --cases "$(CASE)" --output "$(OUTPUT)" --core-sel "$(CORE_SEL)" $(if $(filter 1,$(STOP_ON_FAIL)),--stop-on-fail,) $(if $(filter-out 500000,$(MAX_CYCLES)),--max-cycles "$(MAX_CYCLES)",) $(if $(filter-out 0,$(TRACE)),--trace "$(TRACE)",)

regress:
	@$(PYTHON) $(SOC_ROOT)/scripts/verilator_regress.py --output "$(OUTPUT)" --core-sel "$(CORE_SEL)" $(if $(CASES),--cases "$(CASES)",) $(if $(filter 1,$(STOP_ON_FAIL)),--stop-on-fail,) $(if $(filter-out 500000,$(MAX_CYCLES)),--max-cycles "$(MAX_CYCLES)",) $(if $(filter-out 0,$(TRACE)),--trace "$(TRACE)",)

docs-check:
	@$(PYTHON) $(SOC_ROOT)/scripts/check_docs.py

docs-site-install:
	@npm --prefix $(DOCS_SITE_ROOT) ci

docs-site-prepare:
	@$(PYTHON) $(SOC_ROOT)/scripts/prepare_docs_site.py \
		--root $(SOC_ROOT) --output $(DOCS_SITE_SOURCE)

docs-site-dev: docs-site-prepare
	@npm --prefix $(DOCS_SITE_ROOT) run dev

docs-site-build: docs-site-prepare
	@npm --prefix $(DOCS_SITE_ROOT) run build

docs-site-preview:
	@npm --prefix $(DOCS_SITE_ROOT) run preview

docs-site-check: docs-check docs-site-build

clean-build:
	@test -n "$(SOC_ROOT)" -a "$(SOC_ROOT)" != "/" || (printf "$(CLR_ERR)ERROR: invalid SOC_ROOT=$(SOC_ROOT)$(CLR_RESET)\n"; exit 2)
	@printf "$(CLR_INFO)Removing $(SOC_ROOT)/build$(CLR_RESET)\n"
	@rm -rf "$(SOC_ROOT)/build"

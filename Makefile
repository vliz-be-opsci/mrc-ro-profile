PROFILE_VERSION := 0.1
PROFILE_DIR := profiles/mrc-ro-profile/$(PROFILE_VERSION)

BLUEPRINT := blueprints/mrc-crate.0.1.yaml
SHAPE := mrco.shacl.ttl
VOCABULARY := mrco.profile.vocab.ttl

CRATE_DIR := build/mrc-ro-profile
CRATE_METADATA := $(CRATE_DIR)/ro-crate-metadata.json

PYTHON_ENV := uv run

.PHONY: crate clean validate-profile

crate: $(CRATE_METADATA)

$(CRATE_METADATA): $(BLUEPRINT) $(PROFILE_DIR)/$(SHAPE) $(PROFILE_DIR)/$(VOCABULARY) scripts/build_ro_crate.py
	
	
	@mkdir -p $(CRATE_DIR)

	cp $(PROFILE_DIR)/$(SHAPE) \
		$(CRATE_DIR)/$(SHAPE)

	cp $(PROFILE_DIR)/$(VOCABULARY) \
		$(CRATE_DIR)/$(VOCABULARY)

	cp $(PROFILE_DIR)/ro-crate-metadata.json \
		$(CRATE_DIR)/.

validate-profile:
	$(PYTHON_ENV) rocrate-validator validate $(CRATE_DIR) -o validation-report.txt --verbose

clean:
	rm -rf build
	
	
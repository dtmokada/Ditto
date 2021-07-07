
.PHONY : log build debug test clean project

BUCK=buck

log:
	echo "Make"

update_cocoapods:
	pod install --repo-update

build:
	$(BUCK) build //Ditto:Ditto

debug:
	$(BUCK) install //Ditto:Ditto --run --simulator-name 'iPhone 12'


buck_out = $(shell $(BUCK) root)/buck-out
TEST_BUNDLE = $(shell $(BUCK) targets //Ditto:CITests --show-output | awk '{ print $$2 }')
test:
	@rm -f $(buck_out)/tmp/*.profraw
	@rm -f $(buck_out)/gen/*.profdata
	$(BUCK) test //Ditto:CITests --test-runner-env XCTOOL_TEST_ENV_LLVM_PROFILE_FILE="$(buck_out)/tmp/code-%p.profraw%15x" \
		--config-file code_coverage.buckconfig
	xcrun llvm-profdata merge -sparse '$(buck_out)/tmp/code-'*.profraw -o "$(buck_out)/gen/Coverage.profdata"
	xcrun llvm-cov report "$(TEST_BUNDLE)/CITests" -instr-profile "$(buck_out)/gen/Coverage.profdata" -ignore-filename-regex "Pods|Carthage|buck-out|Tests"

clean:
	rm -rf **/*.xcworkspace
	rm -rf **/*.xcodeproj
	$(BUCK) clean

project: clean
	$(BUCK) project //Ditto:workspace
	open Ditto/DittoApp-BUCK.xcworkspace
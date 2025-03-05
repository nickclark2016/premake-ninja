--
-- premake5.lua
-- Premake script for the Premake test suite.
-- (c) 2025 Nick Clark and the Premake project
--

	newaction {
		trigger = "test",
		description = "Run the tests",
		execute = function()
			test = require "self-test"
			premake.action.call("self-test")
		end
	}

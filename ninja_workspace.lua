--
-- ninja_workspace.lua
-- Functions for writing workspaces to Ninja build files.
-- (c) 2025 Nick Clark and the Premake project
--

	local p = premake
	local ninja = p.modules.ninja


	local project = p.project


--
-- Generate subninja calls for each configuration tuple on each project in the workspace.
--
-- @param wks
--    The workspace object representing the current workspace.
--

	function ninja.projects(wks)
		_p('# Projects')
		for _, prj in ipairs(wks.projects) do
			-- For each configuration, write out the subninja calls
			for cfg in project.eachconfig(prj) do
				local name = ninja.getninjafilename(cfg, true)
				local abspath = p.filename(cfg, name)

				local relpath = path.getrelative(wks.location, abspath)

				-- local path = p.filename()
				_p('subninja %s', relpath)
			end
		end
		_p('')
	end


	function ninja.phonies(wks)
		-- Write out the configuration tuple targets
		-- Write out the group tarets

		-- Build a table of all configuration short names and the corresponding project configurations
		local cfgs = {}

		for _, prj in ipairs(wks.projects) do
			for cfg in project.eachconfig(prj) do
				if not cfgs[cfg.shortname] then
					cfgs[cfg.shortname] = {}
				end
				table.insert(cfgs[cfg.shortname], prj.name .. '_' .. cfg.shortname)
			end
		end

		_p('# Phony targets')
		for shortname, cfgs in pairs(cfgs) do
			-- Write out the configuration tuple targets

			_p('build %s: phony %s', shortname, table.concat(cfgs, ' '))
		end
		_p('')

		_p('# Group targets')

		_p('')
	end


--
-- Generate a Ninja workspace file.
--
-- @param wks
--    The workspace object representing the current workspace.
--

	function ninja.generateworkspace(wks)
		p.eol("\n")

		ninja.header(wks)
		ninja.projects(wks)
		ninja.phonies(wks)
		-- Write project rules
		-- Write clean rules
		-- Write help rule
	end
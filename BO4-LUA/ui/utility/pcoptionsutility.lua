CoD.PCOptionsUtility = {}
CoD.PCOptionsUtility.OptionListFocusModelBehavior = false
CoD.PCOptionsUtility.CreatePCOptionTable = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	local f1_local0 = {
		models = {
			name = f1_arg3,
			desc = f1_arg4,
			image = f1_arg2,
			widgetType = f1_arg5,
			categoryElemId = CoD.PCOptionsUtility.CurrentPCCategoryDefinition,
		},
		properties = {
			_optionProperties = {},
		},
	}
	local f1_local1 = f1_arg5 ~= "openbutton"
	local f1_local2 = f1_local0.properties._optionProperties
	local f1_local3 = f1_arg6.getCurrentValue
	if not f1_local3 then
		f1_local3 = CoD.PCOptionsUtility.GetCurrentOptionValue
	end
	f1_local2._getCurrentValue = f1_local3
	f1_local2 = f1_local0.properties._optionProperties
	f1_local3 = f1_arg6.setCurrentValue
	if not f1_local3 then
		f1_local3 = CoD.PCOptionsUtility.SetCurrentOptionValue
	end
	f1_local2._setCurrentValue = f1_local3
	if f1_arg1 then
		f1_local0.models.profileVar = f1_arg1
		f1_local0.models.unavailableFunction = f1_arg7
		f1_local0.models.currentValue = f1_local0.properties._optionProperties._getCurrentValue(f1_arg1, f1_arg0)
	elseif not f1_local1 then
		f1_local0.models.unavailableFunction = f1_arg7
	else
		f1_local0.models.unavailableFunction = function()
			return true
		end
	end
	f1_local0.properties._optionProperties._valueUpdated = f1_arg6.valueUpdated
	if f1_arg5 == "checkbox" then
		if f1_arg1 then
			f1_local0.models.minValue = f1_arg6.minValue or 0
			f1_local0.models.maxValue = f1_arg6.maxValue or 1
			f1_local0.models.toggleOnString = f1_arg6.toggleOnString
			f1_local0.models.toggleOffString = f1_arg6.toggleOffString
		end
	elseif f1_arg5 == "slider" then
		if f1_arg1 then
			f1_local0.properties._optionProperties._options = f1_arg6.options
		end
		f1_local0.models.text = ""
	elseif f1_arg5 == "sliderbar" then
		if f1_arg1 then
			f1_local0.models.minValue = f1_arg6.minValue
			f1_local0.models.maxValue = f1_arg6.maxValue
			f1_local0.models.increment = f1_arg6.increment
			f1_local0.models.decimalPlace = f1_arg6.decimalPlace
		else
			f1_local0.models.currentValue = 0.5
			f1_local0.models.minValue = 0
			f1_local0.models.maxValue = 1
		end
	elseif f1_arg5 == "dropdown" then
		if f1_arg1 then
			f1_local0.properties._optionProperties._options = f1_arg6.options
			f1_local2 = f1_arg1 .. "Values"
			DataSources[f1_local2] = DataSourceHelpers.ListSetup(f1_local2, function(f3_arg0)
				local f3_local0 = {}
				for f3_local4, f3_local5 in pairs(f1_arg6.options) do
					table.insert(f3_local0, {
						models = f3_local5,
					})
				end
				return f3_local0
			end, true)
			f1_local0.models.optionsDataSource = f1_local2
			f1_local0.models.isOpen = false
			f1_local0.models.text = ""
		end
	elseif f1_arg5 == "expander" then
		f1_local2 = f1_arg6.frameWidget
		if f1_local2 == "keybinder" then
			if f1_arg6.keybindTable then
				f1_local0.models = f1_arg6.keybindTable.models
			end
		else
			f1_local3 = CoD.PCOptionsUtility.CreatePCOptionTable(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_local2, f1_arg6, f1_arg7)
			f1_local0.models = f1_local3.models
			f1_local0.properties._optionProperties._subWidgetProperties = f1_local3.properties
		end
		f1_local0.models.optionsDatasource = f1_arg6.optionsDatasource
		f1_local0.models.frameWidget = CoD.PCOptionsUtility.GetWidgetName(f1_local2)
		f1_local0.models.widgetType = f1_arg5
		f1_local0.models.isOpen = false
	elseif f1_arg5 == "openbutton" then
		f1_local0.models.openMenuName = f1_arg6.openMenuName
	end
	return f1_local0
end
CoD.PCOptionsUtility.PreparePCOptionListFromExpanderAsset = function(f4_arg0, f4_arg1)
	local f4_local0 = {}
	for f4_local4, f4_local5 in pairs(f4_arg1) do
		local f4_local6 = CoD.PCOptionsUtility.CreatePCOptionTableFromAsset(f4_arg0, Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f4_local5[0xC26A1C9201BF12F])))
		if f4_local6 then
			table.insert(f4_local0, f4_local6)
		end
	end
	return f4_local0
end
CoD.PCOptionsUtility.PrepareCategoryListFromAsset = function(f5_arg0, f5_arg1)
	local f5_local0 = {}
	local f5_local1 = Engine[0xA7E3CD65E63086F](f5_arg1)
	local f5_local2 = 1
	for f5_local6, f5_local7 in ipairs(f5_local1) do
		if f5_local7[0x9C678A18C0948A1] == 1 then
			table.insert(f5_local0, {
				models = {
					name = f5_local7[0x55F116BF695C8F6],
					categoryId = f5_local2,
				},
				properties = {},
			})
			f5_local2 = f5_local2 + 1
		end
	end
	return f5_local0
end
CoD.PCOptionsUtility.PreparePCOptionListFromAsset = function(f6_arg0, f6_arg1)
	local f6_local0 = {}
	for f6_local4, f6_local5 in ipairs(Engine[0xA7E3CD65E63086F](f6_arg1)) do
		local f6_local6 = CoD.PCOptionsUtility.CreatePCOptionTableFromAsset(f6_arg0, f6_local5)
		if f6_local6 then
			table.insert(f6_local0, f6_local6)
		end
	end
	return f6_local0
end
CoD.PCOptionsUtility.GetSpecialProfileData = function(f7_arg0, f7_arg1)
	local f7_local0 = CoD.PCOptionsUtility.SpecialProfileDefaults[f7_arg0]
	if not f7_local0 and f7_arg1 then
		f7_local0 = {}
		CoD.PCOptionsUtility.SpecialProfileDefaults[f7_arg0] = f7_local0
	end
	return f7_local0
end
CoD.PCOptionsUtility.CreatePCOptionTableFromAsset = function(f8_arg0, f8_arg1)
	if f8_arg1 and not CoD.OptionsUtility.ExcludeOption(f8_arg0, f8_arg1) then
		if CoD.PCKoreaUtility.ShowKorea15Plus() and f8_arg1[0xE0113A4F1783E87] ~= 0 then
			return nil
		elseif f8_arg1[0x3F5AD2205070F2E] == 1 then
			local f8_local0 = f8_arg1[0xCC44970C8397929]
			if CoD.PCKoreaUtility.ShowKorea15Plus() and f8_arg1[0x275454D1B48DC3] then
				f8_local0 = f8_arg1[0x275454D1B48DC3]
			end
			return CoD.PCOptionsUtility.MakeKeybindTable(f8_arg0, f8_arg1[0x55F116BF695C8F6], f8_local0, f8_arg1[0xE4CF24FFB07F9A2], f8_arg1[0xB092C1CAD1F6A32], f8_arg1[0xABB4544CC59EA03], f8_arg1[0x245C555A23CB4AE])
		elseif f8_arg1[0x9A5811D217C6EA1] == 1 then
			return CoD.PCOptionsUtility.CreateEmptySeparator(f8_arg0)
		end
		local f8_local0 = nil
		local f8_local1 = f8_arg1[0x6E183377E0C37F4]
		if f8_local1 then
			f8_local1 = Engine[0xC53F8D38DF9042B](f8_arg1[0x6E183377E0C37F4])
		end
		local f8_local2 = nil
		if not f8_arg1[0xCC44970C8397929] then
			local f8_local3 = 0x0
		end
		if CoD.PCKoreaUtility.ShowKorea15Plus() and f8_arg1[0x275454D1B48DC3] then
			local f8_local3 = f8_arg1[0x275454D1B48DC3]
		end
		local f8_local4 = {}
		local f8_local5 = {}
		local f8_local6 = f8_arg1[0x55F116BF695C8F6]
		if not f8_local6 then
			f8_local6 = 0x0
		end
		f8_local5.name = f8_local6
		f8_local5.desc = f8_local3
		f8_local5.image = f8_arg1[0x245C555A23CB4AE]
		f8_local5.widgetType = nil
		f8_local5.categoryElemId = CoD.PCOptionsUtility.CurrentPCCategoryDefinition
		f8_local5.refreshWidget = false
		f8_local4.models = f8_local5
		f8_local4.properties = {
			_optionProperties = {},
		}
		f8_local4.properties._optionProperties._getCurrentValue = CoD.PCOptionsUtility.GetCurrentOptionValue
		f8_local4.properties._optionProperties._setCurrentValue = CoD.PCOptionsUtility.SetCurrentOptionValue
		if f8_local1 then
			f8_local4.models.profileVar = f8_local1
			f8_local4.models.currentValue = f8_local4.properties._optionProperties._getCurrentValue(f8_local1, f8_arg0)
			if f8_arg1.option_dependencies then
				f8_local5 = {}
				for f8_local10, f8_local11 in ipairs(f8_arg1.option_dependencies) do
					f8_local11[0x409E4C67236C70F] = Engine[0xC53F8D38DF9042B](f8_local11[0x409E4C67236C70F])
					local f8_local12 = f8_local11[0x409E4C67236C70F]
					if f8_local11[0x54667F2165FEC5D] ~= "change" then
						table.insert(f8_local5, f8_local11)
					end
					local f8_local9 = CoD.PCOptionsUtility.GetSpecialProfileData(f8_local12, true)
					if not f8_local9.profilesToUpdate then
						f8_local9.profilesToUpdate = {}
					end
					f8_local9.profilesToUpdate[f8_local1] = true
				end
				if #f8_local5 > 0 then
					f8_local6 = CoD.PCOptionsUtility.GetSpecialProfileData(f8_local1, true)
					f8_local6.unavailableFunction = function(f9_arg0)
						local f9_local0 = false
						for f9_local5, f9_local6 in ipairs(f8_local5) do
							local f9_local7 = CoD.PCOptionsUtility.GetCurrentOptionValue(f9_local6[0x409E4C67236C70F], f9_arg0)
							local f9_local8 = f9_local6[0x568600B190E05ED]
							f9_local8 = tonumber(f9_local8) or f9_local8
							local f9_local4 = nil
							if f9_local6[0x54667F2165FEC5D] == "~=" then
								f9_local4 = f9_local7 ~= f9_local8
							else
								f9_local4 = f9_local7 == f9_local8
							end
							if not f9_local0 then
								f9_local0 = f9_local4
							end
						end
						if f8_arg1[0xC41C6F75DD0264C] ~= 0 then
							return f9_local0
						else
							return not f9_local0
						end
					end
				end
			end
			f8_local2 = CoD.PCOptionsUtility.GetSpecialProfileData(f8_local1, false)
			if f8_local2 then
				if f8_local2.getCurrentValue then
					f8_local4.properties._optionProperties._getCurrentValue = f8_local2.getCurrentValue
				end
				if f8_local2.setCurrentValue then
					f8_local4.properties._optionProperties._setCurrentValue = f8_local2.setCurrentValue
				end
				if f8_local2.unavailableFunction then
					f8_local4.models.unavailableFunction = f8_local2.unavailableFunction
				end
				if f8_local2.onActive then
					f8_local4.properties._optionProperties._onActive = f8_local2.onActive
				end
			end
		elseif not (not f8_arg1[0xA37009BD8B9445C] ~= 1 or f8_local1 ~= nil) or f8_arg1[0xA37009BD8B9445C] == 0 and f8_local1 == nil then
			f8_local4.models.unavailableFunction = function()
				return true
			end
		end
		if f8_arg1[0xA37009BD8B9445C] == 1 and f8_arg1[0x8CB8A755382AF5D] == "StartMenu_Options_CoDAccount_CTA" then
			f8_local4.models.unavailableFunction = function(f11_arg0)
				return CoD.SafeGetModelValue(DataSources.UNOAccountInfo.getModel(f11_arg0), "bSignedIn") == true
			end
		end
		if f8_arg1[0xC90BD2A41B080F5] == 1 then
			f8_local4.models.unavailableFunction = function()
				return true
			end
		end
		if f8_arg1[0x15A0D9812F3D286] == 1 then
			f8_local4.models.widgetType = "checkbox"
			if f8_local1 then
				f8_local5 = f8_local4.models
				f8_local6 = f8_arg1[0x63B3C67E28785EC]
				if not f8_local6 then
					f8_local6 = 0
				end
				f8_local5.minValue = f8_local6
				f8_local5 = f8_local4.models
				f8_local6 = f8_arg1[0x1FE13CC0DCFA646]
				if not f8_local6 then
					f8_local6 = 1
				end
				f8_local5.maxValue = f8_local6
				f8_local5 = f8_local4.models
				f8_local6 = f8_arg1[0xE0EC36B4536B579]
				if not f8_local6 then
					f8_local6 = Engine[0xF9F1239CFD921FE](0x5BE4D02B20F370A)
				end
				f8_local5.toggleOnString = f8_local6
				f8_local5 = f8_local4.models
				f8_local6 = f8_arg1[0xE511B9A41A891A3]
				if not f8_local6 then
					f8_local6 = Engine[0xF9F1239CFD921FE](0x17857948FC2CCFC)
				end
				f8_local5.toggleOffString = f8_local6
			end
		elseif f8_arg1[0xC97F4CCEE4EFEB7] == 1 then
			f8_local4.models.widgetType = "sliderbar"
			if f8_local1 then
				f8_local5 = f8_local4.models
				f8_local6 = f8_arg1[0xB5A1CBBE01A23F3]
				if not f8_local6 then
					f8_local6 = 0
				end
				f8_local5.minValue = f8_local6
				f8_local5 = f8_local4.models
				f8_local6 = f8_arg1[0x546C97C01207014]
				if not f8_local6 then
					f8_local6 = 1
				end
				f8_local5.maxValue = f8_local6
				f8_local5 = f8_local4.models
				f8_local6 = f8_arg1[0xD0592BDDB5DA4E1]
				if not f8_local6 then
					f8_local6 = 0
				end
				f8_local5.increment = f8_local6
			else
				f8_local4.models.currentValue = 0.5
				f8_local4.models.minValue = 0
				f8_local4.models.maxValue = 1
			end
		elseif f8_arg1[0x6145412E62302A1] == 1 then
			f8_local4.models.widgetType = "dropdown"
			if f8_local1 then
				if f8_local2 and f8_local2.getOptions then
					f8_local0 = f8_local2.getOptions
				else
					f8_local0 = function(f13_arg0)
						local f13_local0 = {}
						for f13_local4, f13_local5 in ipairs(f8_arg1.options) do
							table.insert(f13_local0, {
								name = Engine[0xF9F1239CFD921FE](f13_local5[0x9F7FCEC8FCB623D]),
								value = tonumber(f13_local5[0xCE4FD9430E80CEA]) or f13_local5[0xCE4FD9430E80CEA],
							})
						end
						return f13_local0
					end
				end
				f8_local4.properties._optionProperties._getOptions = f8_local0
				if f8_local2 then
					f8_local4.properties._optionProperties._useListOptionsOutdatedCheck = f8_local2.useListOptionsOutdatedCheck
				end
				f8_local5 = f8_arg1[0x6E183377E0C37F4] .. "Values"
				DataSources[f8_local5] = DataSourceHelpers.ListSetup(f8_local5, function(f14_arg0)
					local f14_local0 = {}
					for f14_local4, f14_local5 in pairs(f8_local0(f14_arg0)) do
						table.insert(f14_local0, {
							models = f14_local5,
						})
					end
					return f14_local0
				end, true)
				f8_local4.models.optionsDataSource = f8_local5
				f8_local4.models.isOpen = false
				f8_local4.models.text = ""
			end
		elseif f8_arg1[0xC196D6034CA07F] == 1 then
			f8_local6 = CoD.PCOptionsUtility.CreatePCOptionTableFromAsset(f8_arg0, Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f8_arg1[0x789A4DE9FEE4913])))
			if not f8_local6 then
				return nil
			end
			f8_local4.models = f8_local6.models
			f8_local4.properties._optionProperties._subWidgetProperties = f8_local6.properties
			f8_local4.models.frameWidget = CoD.PCOptionsUtility.GetWidgetName(f8_local6.models.widgetType)
			f8_local4.models.isOpen = false
			f8_local4.models.widgetType = "expander"
			local f8_local7 = f8_arg1[0x6E183377E0C37F4] .. "Values"
			DataSources[f8_local7] = CoD.PCOptionsUtility.SetupOptionDataSource(f8_local7, nil, false, f8_arg1.expander_options)
			f8_local4.models.optionsDataSource = f8_local7
		elseif f8_arg1[0x9C678A18C0948A1] == 1 then
			f8_local5 = CoD.PCOptionsUtility.CreatePCOptionCategorySeparator
			f8_local6 = f8_arg0
			local f8_local7 = f8_arg1[0xA9944DEDBF80E87]
			if not f8_local7 then
				f8_local7 = 0
			end
			local f8_local8 = f8_arg1[0x55F116BF695C8F6]
			if not f8_local8 then
				f8_local8 = 0x0
			end
			return f8_local5(f8_local6, f8_local7, f8_local8)
		elseif f8_arg1[0xA37009BD8B9445C] == 1 then
			f8_local4.models.widgetType = "openbutton"
			f8_local4.models.openMenuName = f8_arg1[0x8CB8A755382AF5D]
		else
			f8_local4.models.widgetType = "slider"
			if f8_local1 then
				if f8_local2 and f8_local2.getOptions then
					f8_local0 = f8_local2.getOptions
				else
					f8_local0 = function(f15_arg0)
						local f15_local0 = {}
						for f15_local4, f15_local5 in ipairs(f8_arg1.options) do
							table.insert(f15_local0, {
								name = Engine[0xF9F1239CFD921FE](f15_local5[0x9F7FCEC8FCB623D]),
								value = tonumber(f15_local5[0xCE4FD9430E80CEA]) or f15_local5[0xCE4FD9430E80CEA],
							})
						end
						return f15_local0
					end
				end
				f8_local4.properties._optionProperties._getOptions = f8_local0
				f8_local4.models.optionCount = 0
			end
			f8_local4.models.text = ""
		end
		return f8_local4
	else
		return nil
	end
end
CoD.PCOptionsUtility.MakeKeybindTable = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4, f16_arg5, f16_arg6)
	local f16_local0, f16_local1 = Engine[0x7C4C4DBF61B869E](f16_arg0, f16_arg3, f16_arg4)
	if f16_arg5 == nil then
		f16_arg5 = false
	end
	return {
		models = {
			name = f16_arg1,
			desc = f16_arg2,
			command = f16_arg3,
			bindIndex = f16_arg4,
			bind_main = f16_local0,
			bind_alt = f16_local1,
			image = f16_arg6,
			binding_main = false,
			binding_alt = false,
			widgetType = "keybinder",
			isDefault = f16_arg5,
		},
		properties = {},
	}
end
CoD.PCOptionsUtility.OptionTabIds = {
	Gameplay = "GameplayOption",
	Keybind = "KeybindsOption",
	Graphic = "GraphicsOption",
	Interface = "InterfaceOption",
	Audio = "AudioOption",
	Gamepad = "GamepadOption",
}
DataSources.OptionTabs = DataSourceHelpers.ListSetup("PC.OptionTabs", function(f17_arg0)
	return {
		{
			models = {
				name = 0xA31D2DFFA5784E3,
				listDataSource = "OptionGameplay",
				categoriesDataSource = "OptionGameplayCategories",
				image = "uie_optionicon_gameplay",
				id = CoD.PCOptionsUtility.OptionTabIds.Gameplay,
				available = true,
			},
			properties = {},
		},
		{
			models = {
				name = 0xD53C9B7E49145B7,
				listDataSource = "OptionKeyBindings",
				categoriesDataSource = "OptionKeyBindingCategories",
				image = "uie_optionicon_keybinds",
				id = CoD.PCOptionsUtility.OptionTabIds.Keybind,
				available = true,
			},
			properties = {},
		},
		{
			models = {
				name = 0x557B323E42088DA,
				listDataSource = "OptionGraphicsVideo",
				categoriesDataSource = "OptionGraphicsCategories",
				image = "ui_icon_startmenu_option_graphics",
				id = CoD.PCOptionsUtility.OptionTabIds.Graphic,
				available = true,
			},
			properties = {},
		},
		{
			models = {
				name = 0x8E5DCB83DFB1DEE,
				listDataSource = "OptionInterface",
				categoriesDataSource = "OptionInterfaceCategories",
				image = "t7_menu_startmenu_option_music",
				id = CoD.PCOptionsUtility.OptionTabIds.Interface,
				available = true,
			},
			properties = {},
		},
		{
			models = {
				name = 0xE26811C3A36321D,
				listDataSource = "OptionAudio",
				categoriesDataSource = "OptionAudioCategories",
				image = "uie_img_t7_menu_startmenu_option_audio",
				id = CoD.PCOptionsUtility.OptionTabIds.Audio,
				available = true,
			},
			properties = {},
		},
		{
			models = {
				name = 0x975126817A5EA2A,
				listDataSource = "OptionGamepad",
				categoriesDataSource = "OptionGamepadCategories",
				image = "uie_optionicon_accessibility",
				id = CoD.PCOptionsUtility.OptionTabIds.Gamepad,
				available = true,
			},
			properties = {},
		},
	}
end)
CoD.PCOptionsUtility.OptionModels = {}
CoD.PCOptionsUtility.GetOptionModel = function(f18_arg0, f18_arg1)
	return CoD.PCOptionsUtility.OptionModels[f18_arg0] and CoD.PCOptionsUtility.OptionModels[f18_arg0][f18_arg1]
end
CoD.PCOptionsUtility.GetPerControllerOptionModels = function(f19_arg0)
	return CoD.PCOptionsUtility.OptionModels[f19_arg0]
end
CoD.PCOptionsUtility.SyncAllOptionModels = function(f20_arg0)
	local f20_local0 = CoD.PCOptionsUtility.GetPerControllerOptionModels(f20_arg0)
	if f20_local0 then
		for f20_local11, f20_local12 in pairs(f20_local0) do
			if f20_local12.currentValue then
				f20_local12.currentValue:set(CoD.PCOptionsUtility.GetCurrentOptionValue(f20_local11, f20_arg0))
			end
			local f20_local4 = CoD.PCOptionsUtility.GetSpecialProfileData(f20_local11, false)
			if f20_local4 and f20_local4.profilesToUpdate then
				for f20_local8, f20_local9 in pairs(f20_local4.profilesToUpdate) do
					local f20_local10 = CoD.PCOptionsUtility.GetOptionModel(f20_arg0, f20_local8)
					if f20_local10 then
						Engine[0x6A489878620F3BC](f20_local10.refreshWidget)
					end
				end
			end
		end
	end
end
CoD.PCOptionsUtility.SyncAllOptionModelsForAllController = function()
	for f21_local3, f21_local4 in pairs(CoD.PCOptionsUtility.OptionModels) do
		CoD.PCOptionsUtility.SyncAllOptionModels(f21_local3)
	end
end
CoD.PCOptionsUtility.SyncOptionModel = function(f22_arg0, f22_arg1)
	local f22_local0 = CoD.PCOptionsUtility.GetPerControllerOptionModels(f22_arg0)
	if f22_local0 then
		local f22_local1 = f22_local0[f22_arg1]
		if f22_local1 and f22_local1.currentValue then
			f22_local1.currentValue:set(CoD.PCOptionsUtility.GetCurrentOptionValue(f22_arg1, f22_arg0))
		end
	end
end
CoD.PCOptionsUtility.SetupOptionDataSource = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
	local f23_local0 = DataSourceHelpers.ListSetup(
		f23_arg0,
		function(f25_arg0)
			if f23_arg3 ~= nil then
				return CoD.PCOptionsUtility.PreparePCOptionListFromExpanderAsset(f25_arg0, f23_arg3)
			elseif f23_arg2 then
				return CoD.PCOptionsUtility.PrepareCategoryListFromAsset(f25_arg0, f23_arg1)
			else
				return CoD.PCOptionsUtility.PreparePCOptionListFromAsset(f25_arg0, f23_arg1)
			end
		end,
		false,
		nil,
		function(f24_arg0, f24_arg1, f24_arg2)
			if f23_arg2 then
				return
			end
			local f24_local0 = CoD.PCOptionsUtility.OptionModels[f24_arg0]
			if not f24_local0 then
				f24_local0 = {}
				CoD.PCOptionsUtility.OptionModels[f24_arg0] = f24_local0
			end
			local f24_local1 = DataSources[f24_arg1.dataSourceName].getCount(f24_arg1)
			for f24_local2 = 1, f24_local1, 1 do
				local f24_local5 = f24_arg2[f24_local2]
				if f24_local5.profileVar then
					f24_local0[f24_local5.profileVar:get()] = f24_local5
				end
				if f24_local5.command then
					f24_local0[f24_local5.command:get()] = f24_local5
				end
			end
			CoD.PCOptionsUtility.SyncAllOptionModels(f24_arg0)
		end
	)
	if not f23_arg2 then
		f23_local0.getWidgetTypeForItem = function(f26_arg0, f26_arg1, f26_arg2)
			return CoD.PCOptionsUtility.GetOptionWidget(f26_arg0, f26_arg1, f26_arg2)
		end
	end
	return f23_local0
end
DataSources.OptionGraphicsVideo = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGraphicsVideo", 0x1AA317708A48A81, false)
DataSources.OptionGraphicsCategories = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGraphicsCategories", 0x1AA317708A48A81, true)
DataSources.OptionKeyBindings = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionKeybindings", 0x6D2467E662F8539, false)
DataSources.OptionKeyBindingCategories = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGraphicsCategories", 0x6D2467E662F8539, true)
DataSources.OptionGameplay = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGameplay", 0xE1D867DA45BE574, false)
DataSources.OptionGameplayCategories = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGraphicsCategories", 0xE1D867DA45BE574, true)
DataSources.OptionInterface = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionInterface", 0xE667FE66146F9B1, false)
DataSources.OptionInterfaceCategories = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionInterfaceCategories", 0xE667FE66146F9B1, true)
DataSources.OptionAudio = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionAudio", 0xA66EE44116637C0, false)
DataSources.OptionAudioCategories = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionAudioCategories", 0xA66EE44116637C0, true)
DataSources.OptionGamepad = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGamepad", 0xB70550C535036F1, false)
DataSources.OptionGamepadCategories = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGamepadCategories", 0xB70550C535036F1, true)
DataSources.OptionGraphicContentPC = CoD.PCOptionsUtility.SetupOptionDataSource("PC.OptionGraphicContentPC", 0x4B6E9F353ED2F1F, false)
DataSources.KeybindMessages = {
	getModel = function(f27_arg0)
		local f27_local0 = Engine[0x8DF2E5447F384B9]()
		local f27_local1 = f27_local0.KeybindMessages
		if not f27_local1 then
			f27_local1 = f27_local0:create("KeybindMessages")
			local f27_local2 = f27_local1:create("currentKeybind")
			f27_local2:set("")
			f27_local2 = f27_local1:create("pastKeybind")
			f27_local2:set("")
			f27_local2 = f27_local1:create("keybindMessage")
			f27_local2:set("")
			f27_local2 = f27_local1:create("isBindingKey")
			f27_local2:set(false)
			f27_local2 = f27_local1:create("showPastKeybind")
			f27_local2:set(false)
			f27_local2 = f27_local1:create("showErrorMessage")
			f27_local2:set(false)
			f27_local2 = f27_local1:create("showWarningMessage")
			f27_local2:set(false)
		end
		return f27_local1
	end,
	showBindingMessage = function(f28_arg0)
		local f28_local0 = Engine[0x8DF2E5447F384B9]()
		f28_local0.KeybindMessage.isBindingKey:set(true)
	end,
}
CoD.PCOptionsUtility.GetOptionWidget = function(f29_arg0, f29_arg1, f29_arg2)
	if f29_arg1 then
		local f29_local0 = Engine[0x40E824FE270E174](f29_arg1, "widgetType")
		if f29_local0 then
			local f29_local1 = Engine[0x614D394F6F9A18D](f29_local0)
			if f29_local1 == "keybinder" then
				return CoD.PC_StartMenu_Options_Controls_KeyBinder
			elseif f29_local1 == "checkbox" then
				return CoD.ToggleButton
			elseif f29_local1 == "slider" then
				return CoD.CyclingList
			elseif f29_local1 == "spacer" then
				return CoD.PC_EmptyWidget
			elseif f29_local1 == "sliderbar" then
				return CoD.SliderBar
			elseif f29_local1 == "label" then
				return CoD.Options_CategoryListSeparation
			elseif f29_local1 == "dropdown" then
				return CoD.DropDownList
			elseif f29_local1 == "expander" then
				return CoD.Expander
			elseif f29_local1 == "openbutton" then
				return CoD.OpenButton
			end
		end
	end
	return nil
end
CoD.PCOptionsUtility.GetWidgetName = function(f30_arg0)
	if f30_arg0 == "keybinder" then
		return "CoD.PC_StartMenu_Options_Controls_KeyBinder"
	elseif f30_arg0 == "checkbox" then
		return "CoD.ToggleButton"
	elseif f30_arg0 == "slider" then
		return "CoD.CyclingList"
	elseif f30_arg0 == "spacer" then
		return "CoD.PC_EmptyWidget"
	elseif f30_arg0 == "sliderbar" then
		return "CoD.SliderBar"
	elseif f30_arg0 == "label" then
		return "CoD.Options_CategoryListSeparation"
	elseif f30_arg0 == "expander" then
		return "CoD.Expander"
	elseif f30_arg0 == "openbutton" then
		return "CoD.OpenButton"
	else
		return nil
	end
end
CoD.PCOptionsUtility.GetWidgetType = function(f31_arg0)
	if f31_arg0 == "CoD.PC_StartMenu_Options_Controls_KeyBinder" then
		return "keybinder"
	elseif f31_arg0 == "CoD.ToggleButton" then
		return "checkbox"
	elseif f31_arg0 == "CoD.CyclingList" then
		return "slider"
	elseif f31_arg0 == "CoD.PC_EmptyWidget" then
		return "spacer"
	elseif f31_arg0 == "CoD.SliderBar" then
		return "sliderbar"
	elseif f31_arg0 == "CoD.Options_CategoryListSeparation" then
		return "label"
	elseif f31_arg0 == "CoD.Expander" then
		return "expander"
	elseif f31_arg0 == "CoD.OpenButton" then
		return "openbutton"
	else
		return nil
	end
end
CoD.PCOptionsUtility.CreateEmptySeparator = function(f32_arg0)
	return {
		models = {
			widgetType = "spacer",
		},
	}
end
CoD.PCOptionsUtility.CreatePCOptionCategorySeparator = function(f33_arg0, f33_arg1, f33_arg2)
	CoD.PCOptionsUtility.CurrentPCCategoryDefinition = f33_arg1
	return {
		models = {
			widgetType = "label",
			categoryId = f33_arg1,
			name = f33_arg2,
		},
	}
end
CoD.PCOptionsUtility.GetMonitorOptions = function(f34_arg0)
	local f34_local0 = {}
	local f34_local1 = Dvar[0xB5360289B81FB4F]:get()
	for f34_local2 = 1, f34_local1, 1 do
		table.insert(f34_local0, {
			name = tostring(f34_local2),
			value = f34_local2,
		})
	end
	return f34_local0
end
CoD.PCOptionsUtility.GetScreenResolutions = function(f35_arg0)
	local f35_local0 = {}
	local f35_local1 = nil
	if CoD.PCOptionsUtility.GetCurrentOptionValue(0x7119D0EEFF392AB, f35_arg0) == 0 then
		f35_local1 = Engine[0x1A1EC2FF7FCB8E1]()
	else
		local f35_local2 = CoD.PCOptionsUtility.GetCurrentOptionValue(0x106A603FD6135C0, f35_arg0)
		if f35_local2 > Dvar[0xB5360289B81FB4F]:get() then
			f35_local2 = 0
		end
		if f35_local2 == 0 then
			f35_local2 = Dvar[0x106A603FD6135C0]:get()
		end
		if f35_local2 == 0 then
			f35_local2 = 1
		end
		f35_local1 = Engine[0x92DDD217382F145](f35_local2)
	end
	table.sort(f35_local1, function(f36_arg0, f36_arg1)
		local f36_local0, f36_local1 = string.match(f36_arg0, "([%d]+)x([%d]+)")
		local f36_local2, f36_local3 = string.match(f36_arg1, "([%d]+)x([%d]+)")
		if f36_local0 == f36_local2 then
			return tonumber(f36_local1) < tonumber(f36_local3)
		else
			return tonumber(f36_local0) < tonumber(f36_local2)
		end
	end)
	local f35_local3 = {}
	local f35_local4 = CoD.PCOptionsUtility.GetCurrentOptionValue(0xDD980970E4D6B94, f35_arg0)
	for f35_local8, f35_local9 in ipairs(f35_local1) do
		if not f35_local3[f35_local9] then
			table.insert(f35_local0, {
				name = f35_local9,
				value = f35_local9,
			})
			f35_local3[f35_local9] = true
		end
	end
	return f35_local0
end
CoD.PCOptionsUtility.GetAvailableDisplayAdapters = function(f37_arg0)
	local f37_local0 = {}
	local f37_local1 = Engine[0x678F1B06D859DC8](f37_arg0)
	if Engine[0xAFB5DBCA2D637A2]() then
		table.insert(f37_local0, {
			name = Engine[0xF9F1239CFD921FE](0x73A226DD998C3FC, tostring(f37_local1[Engine[0x9C22BE63A2DBF94]() + 1])),
			value = -1,
		})
	else
		table.insert(f37_local0, {
			name = Engine[0xF9F1239CFD921FE](0x8A22339166BFAFF),
			value = -1,
		})
	end
	for f37_local5, f37_local6 in ipairs(f37_local1) do
		table.insert(f37_local0, {
			name = f37_local6,
			value = f37_local5 - 1,
		})
	end
	return f37_local0
end
CoD.PCOptionsUtility.GetAvailableHDROptions = function(f38_arg0)
	local f38_local0 = {}
	table.insert(f38_local0, {
		name = Engine[0xF9F1239CFD921FE](0x3ECBDDA975E2AC1),
		value = 0,
	})
	if Dvar[0xABA228867899BC]:get() then
		table.insert(f38_local0, {
			name = "10 bits",
			value = 1,
		})
	end
	if Dvar[0xB9DA25B27E0CA6A]:get() then
		table.insert(f38_local0, {
			name = "16 bits",
			value = 2,
		})
	end
	return f38_local0
end
CoD.PCOptionsUtility.GetRefreshRateOptions = function(f39_arg0)
	local f39_local0 = {}
	local f39_local1, f39_local2 = string.match(CoD.PCOptionsUtility.GetCurrentOptionValue(0xDD980970E4D6B94, f39_arg0), "([%d]+)x([%d]+)")
	local f39_local3 = CoD.PCOptionsUtility.GetCurrentOptionValue(0x106A603FD6135C0, f39_arg0)
	if f39_local3 > Dvar[0xB5360289B81FB4F]:get() then
		f39_local3 = 0
	end
	if f39_local3 == 0 then
		f39_local3 = Dvar[0x106A603FD6135C0]:get()
	end
	if f39_local3 == 0 then
		f39_local3 = 1
	end
	local f39_local4 = Engine[0x1F7FE9469BA7CD4](f39_local1, f39_local2, f39_local3)
	table.sort(f39_local4, function(f40_arg0, f40_arg1)
		return tonumber(f40_arg0) < tonumber(f40_arg1)
	end)
	for f39_local8, f39_local9 in ipairs(f39_local4) do
		table.insert(f39_local0, {
			name = f39_local9 .. "hz",
			value = tonumber(f39_local9),
		})
	end
	if #f39_local0 == 0 then
		table.insert(f39_local0, {
			name = "None",
			value = 0,
		})
	end
	return f39_local0
end
CoD.PCOptionsUtility.GetDisplayGammaModelOptions = function(f41_arg0)
	local f41_local0 = {}
	local f41_local1 = Dvar[0xAAA15D9B94E876A]:getDomainEnumStrings()
	local f41_local2 = {}
	local f41_local3 = Engine[0xF9F1239CFD921FE](0xD36D33E9AAA3F47)
	local f41_local4 = Engine[0xF9F1239CFD921FE](0x2A09C7DC8D3C600)
	f41_local2 = f41_local3
	for f41_local3 = 1, 2, 1 do
		table.insert(f41_local0, {
			name = f41_local2[f41_local3],
			value = f41_local3 - 1,
		})
	end
	return f41_local0
end
CoD.PCOptionsUtility.RevertPCHardwareChanges = function(f42_arg0, f42_arg1)
	CoD.PCOptionsUtility.ChangedOptionsList = {}
	CoD.PCOptionsUtility.UpdateOptionDirtyModel(f42_arg1)
	CoD.PCOptionsUtility.RefreshAllOptions(f42_arg0, f42_arg1)
end
CoD.PCOptionsUtility.ProfileTypes = {
	USER_PROFILE = 0,
	HARDWARE_PROFILE = 1,
	DVAR = 2,
}
CoD.PCOptionsUtility.ApplyOptionValue = function(f43_arg0, f43_arg1, f43_arg2)
	if CoD.PCOptionsUtility.SpecialProfileDefaults[f43_arg1] and CoD.PCOptionsUtility.SpecialProfileDefaults[f43_arg1].apply then
		CoD.PCOptionsUtility.SpecialProfileDefaults[f43_arg1].apply(f43_arg0, f43_arg2)
	else
		local f43_local0 = Dvar[f43_arg1]
		if f43_local0:exists() then
			if f43_local0:isBool() then
				f43_local0:latch(f43_arg2 == 1)
			else
				f43_local0:latch(f43_arg2)
			end
		else
			Engine[0x280E4C1191CC53D](f43_arg0, f43_arg1, f43_arg2)
			CoD.OptionsUtility.NotifyPlayerSettingsUpdate(f43_arg0, f43_arg1)
		end
	end
	if CoD.PCOptionsUtility.SettingsSession[f43_arg0] then
		CoD.PCOptionsUtility.SettingsSession[f43_arg0].optionsChangedInTab[CoD.PCOptionsUtility.GetCurrentOptionTabId(f43_arg0)] = true
	end
end
CoD.PCOptionsUtility.SettingsSession = {}
CoD.PCOptionsUtility.StartSettingsSession = function(f44_arg0)
	CoD.PCOptionsUtility.SettingsSession[f44_arg0] = {
		optionsChangedInTab = {},
	}
end
CoD.PCOptionsUtility.EndSettingsSession = function(f45_arg0)
	if not CoD.PCOptionsUtility.SettingsSession[f45_arg0] then
		return
	elseif CoD.PCOptionsUtility.SettingsSession[f45_arg0].optionsChangedInTab[CoD.PCOptionsUtility.OptionTabIds.Keybind] then
		GetKeybindsAndSendToDlog(f45_arg0)
	end
	if CoD.PCOptionsUtility.SettingsSession[f45_arg0].optionsChangedInTab[CoD.PCOptionsUtility.OptionTabIds.Gameplay] then
		GetGameplayOptionsAndSendToDlog(f45_arg0)
	end
end
CoD.PCOptionsUtility.ApplyAllPCChangedOptions = function(f46_arg0, f46_arg1)
	local f46_local0 = {}
	local f46_local1 = {}
	local f46_local2 = {}
	for f46_local6, f46_local7 in pairs(CoD.PCOptionsUtility.ChangedOptionsList) do
		CoD.PCOptionsUtility.ApplyOptionValue(f46_arg1, f46_local6, f46_local7)
	end
	if Engine[0x23974DC6BAF9D42]() then
		Engine[0x7C75E608EA39B5C](nil, "vid_restart")
	end
	CoD.PCOptionsUtility.RevertPCHardwareChanges(f46_arg0, f46_arg1)
end
CoD.PCOptionsUtility.CheckForPendingChanges = function(f47_arg0, f47_arg1)
	if CoD.PCOptionsUtility.AreOptionsDirty(f47_arg1) then
		CoD.OverlayUtility.CreateOverlay(f47_arg1, f47_arg0, "PendingChangesOnQuitOptionsMenu", function()
			GoBack(f47_arg0, f47_arg1)
		end)
	else
		GoBack(f47_arg0, f47_arg1)
	end
end
CoD.PCOptionsUtility.SyncHardwareProfileWithDVar = function(f49_arg0, f49_arg1)
	Engine[0x8257260A97ACE1F]()
end
CoD.PCOptionsUtility.ResetOptionsValue = function(f50_arg0, f50_arg1, f50_arg2)
	CoD.OverlayUtility.CreateOverlay(f50_arg1, f50_arg0, "ResetPCSettings", CoD.PCOptionsUtility.GetCurrentOptionTabId(f50_arg1))
end
CoD.PCOptionsUtility.ApplyOptionsValue = function(f51_arg0, f51_arg1)
	local f51_local0 = f51_arg0.TabContent.OptionsList.ScrollList.ScrollView.View.dataSourceName
	CoD.PCOptionsUtility.ApplyAllPCChangedOptions(f51_arg0, f51_arg1)
	Engine[0x8380915E32EF0B5]()
end
CoD.PCOptionsUtility.PrepareGamepadVisual = function(f52_arg0, f52_arg1)
	LUI.OverrideFunction_CallOriginalFirst(f52_arg1.OptionsList.ScrollList.ScrollView.View, "setModel", function(element, controller)
		if not CoD.ModelUtility.IsSelfModelNil(element, f52_arg0) and element.activeWidget then
			local f53_local0 = element.activeWidget
			if f53_local0._optionProperties and f53_local0._optionProperties._onActive then
				f53_local0._optionProperties._onActive(f52_arg0)
			else
				CoD.ModelUtility.SetControllerModelValueToEnum(f52_arg0, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BLANK)
			end
		end
	end)
end
CoD.PCOptionsUtility.IsGraphicsOptions = function(f54_arg0)
	return CoD.PCOptionsUtility.GetCurrentOptionTabId(f54_arg0) == CoD.PCOptionsUtility.OptionTabIds.Graphic
end
CoD.PCOptionsUtility.IsAudioOptions = function(f55_arg0)
	return CoD.PCOptionsUtility.GetCurrentOptionTabId(f55_arg0) == CoD.PCOptionsUtility.OptionTabIds.Audio
end
CoD.PCOptionsUtility.IsKeybindsOptions = function(f56_arg0)
	return CoD.PCOptionsUtility.GetCurrentOptionTabId(f56_arg0) == CoD.PCOptionsUtility.OptionTabIds.Keybind
end
CoD.PCOptionsUtility.UpdateCurrentOptionTabModel = function(f57_arg0, f57_arg1)
	if f57_arg0 then
		assert(f57_arg0.id)
		local f57_local0 = Engine[0x4DF5CFBC1771947](f57_arg1)
		f57_local0.CurrentOptionTab:set(f57_arg0.id:get())
	else
		local f57_local0 = Engine[0x4DF5CFBC1771947](f57_arg1)
		f57_local0.CurrentOptionTab:set("")
	end
end
CoD.PCOptionsUtility.GetCurrentOptionTabId = function(f58_arg0)
	local f58_local0 = Engine[0x4DF5CFBC1771947](f58_arg0)
	if f58_local0.CurrentOptionTab then
		local f58_local1 = Engine[0x4DF5CFBC1771947](f58_arg0)
		return f58_local1.CurrentOptionTab:get()
	else
		return nil
	end
end
CoD.PCOptionsUtility.IsGamepadOptions = function(f59_arg0)
	return CoD.PCOptionsUtility.GetCurrentOptionTabId(f59_arg0) == CoD.PCOptionsUtility.OptionTabIds.Gamepad
end
CoD.PCOptionsUtility.CurrentPCCategoryDefinition = 0
CoD.PCOptionsUtility.GetCurrentCategoryModel = function(f60_arg0)
	local f60_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f60_arg0), "PC.CurrentCategory")
	if not f60_local0 then
		f60_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f60_arg0), "PC.CurrentCategory")
	end
	return f60_local0
end
CoD.PCOptionsUtility.SetCurrentCategoryModel = function(f61_arg0, f61_arg1)
	local f61_local0 = CoD.PCOptionsUtility.GetCurrentCategoryModel(f61_arg0)
	f61_local0:set(f61_arg1)
end
CoD.PCOptionsUtility.GetOptionsDirtyModel = function(f62_arg0, f62_arg1)
	local f62_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f62_arg0), "PC.OptionsDirty")
	if not f62_local0 and f62_arg1 then
		f62_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f62_arg0), "PC.OptionsDirty")
	end
	return f62_local0
end
CoD.PCOptionsUtility.FreeOptionsDirtyModel = function(f63_arg0)
	local f63_local0 = CoD.PCOptionsUtility.GetOptionsDirtyModel(f63_arg0)
	if f63_local0 then
		Engine[0x8C7A8C4C5FD9892](f63_local0)
	end
end
CoD.PCOptionsUtility.UpdateOptionDirtyModel = function(f64_arg0)
	local f64_local0 = CoD.PCOptionsUtility.GetOptionsDirtyModel(f64_arg0, true)
	if next(CoD.PCOptionsUtility.ChangedOptionsList) == nil then
		f64_local0:set(0)
	else
		f64_local0:set(1)
	end
end
CoD.PCOptionsUtility.SetupDirtyOptionModel = function(f65_arg0)
	CoD.PCOptionsUtility.GetOptionsDirtyModel(f65_arg0, true)
end
CoD.PCOptionsUtility.AreOptionsDirty = function(f66_arg0)
	local f66_local0 = CoD.PCOptionsUtility.GetOptionsDirtyModel(f66_arg0, true)
	return f66_local0:get() == 1
end
CoD.PCOptionsUtility.RefreshAllOptions = function(f67_arg0, f67_arg1)
	local f67_local0 = Engine[0x6A489878620F3BC]
	local f67_local1 = Engine[0x8DF2E5447F384B9]()
	f67_local0(f67_local1.HardwareSettingsUpdate)
	f67_arg0:dispatchEventToRoot({
		name = "options_refresh",
		controller = f67_arg1,
	})
end
CoD.PCOptionsUtility.ChangedOptionsList = {}
CoD.PCOptionsUtility.SpecialProfileDefaults = {
	[0x822BC17B9C05B55] = {
		get = function(f68_arg0)
			return tonumber(Engine[0xB72F603CAC75B3A](f68_arg0, 0x822BC17B9C05B55))
		end,
		apply = function(f69_arg0, f69_arg1)
			Engine[0x280E4C1191CC53D](f69_arg0, 0x822BC17B9C05B55, f69_arg1)
			local f69_local0 = DataSources.GameplayFeedbackSettings.getModel(f69_arg0)
			f69_local0.hideRadiationHold:set(f69_arg1)
		end,
	},
	[0x51ACED7DF0546AF] = {
		get = function(f70_arg0)
			return tonumber(Engine[0xB72F603CAC75B3A](f70_arg0, 0x51ACED7DF0546AF))
		end,
		apply = function(f71_arg0, f71_arg1)
			Engine[0x280E4C1191CC53D](f71_arg0, 0x51ACED7DF0546AF, f71_arg1)
			local f71_local0 = DataSources.GameplayFeedbackSettings.getModel(f71_arg0)
			f71_local0.healthBarEnemyAlpha:set(f71_arg1)
		end,
	},
	[0x8E2603F64924C43] = {
		get = function(f72_arg0)
			return tonumber(Engine[0xB72F603CAC75B3A](f72_arg0, 0x8E2603F64924C43))
		end,
		apply = function(f73_arg0, f73_arg1)
			Engine[0x280E4C1191CC53D](f73_arg0, 0x8E2603F64924C43, f73_arg1)
			local f73_local0 = DataSources.GameplayFeedbackSettings.getModel(f73_arg0)
			f73_local0.healthBarAllyAlpha:set(f73_arg1)
		end,
	},
	[0xD830A5731CC8133] = {
		get = function(f74_arg0)
			if Dvar[0xA1149C362763AF2]:get() == 0 then
				return 0
			else
				return 1
			end
		end,
		apply = function(f75_arg0, f75_arg1)
			local f75_local0 = Dvar[0xA1149C362763AF2]
			if f75_arg1 == 0 then
				f75_local0:set(0)
			elseif f75_local0:get() == 0 then
				f75_local0:set(250)
				Dvar[0xEA880D1D83D3188]:set(0)
			end
		end,
	},
	[0xA1149C362763AF2] = {
		_maxFps = 250,
		get = function(f76_arg0)
			local f76_local0 = Dvar[0xA1149C362763AF2]:get()
			if f76_local0 == 0 then
				return CoD.PCOptionsUtility.SpecialProfileDefaults[0xA1149C362763AF2]._maxFps
			else
				return f76_local0
			end
		end,
		apply = function(f77_arg0, f77_arg1)
			if CoD.PCOptionsUtility.GetCurrentOptionValue(0xD830A5731CC8133, f77_arg0) ~= 0 then
				Dvar[0xA1149C362763AF2]:set(f77_arg1)
			end
		end,
	},
	[0xEA880D1D83D3188] = {
		get = function(f78_arg0)
			local f78_local0 = Dvar[0xEA880D1D83D3188]:get()
			local f78_local1 = CoD.PCOptionsUtility.GetCurrentOptionValue(0xA1149C362763AF2, f78_arg0)
			if f78_local0 == 0 or f78_local1 < f78_local0 then
				f78_local0 = f78_local1
			end
			return f78_local0
		end,
		apply = function(f79_arg0, f79_arg1)
			if CoD.PCOptionsUtility.GetCurrentOptionValue(0xD830A5731CC8133, f79_arg0) ~= 0 then
				Dvar[0xEA880D1D83D3188]:set(f79_arg1)
			end
		end,
	},
	[0xF0960B187602076] = {
		get = function(f80_arg0)
			return CoD.PCOptionsUtility.LinearMapFromTo(math.abs(Dvar[0x8045F57217A8E71]:get()), 0, 0.04, 0.1, 2)
		end,
		apply = function(f81_arg0, f81_arg1)
			local f81_local0 = Dvar[0x8045F57217A8E71]:get()
			Dvar[0x8045F57217A8E71]:set(f81_local0 / math.abs(f81_local0) * CoD.PCOptionsUtility.LinearMapFromTo(f81_arg1, 0.1, 2, 0, 0.04))
		end,
	},
	[0xF0FB2125D28A0C0] = {
		get = function(f82_arg0)
			if Dvar[0x8045F57217A8E71]:get() < 0 then
				return -1
			else
				return 1
			end
		end,
		apply = function(f83_arg0, f83_arg1)
			Dvar[0x8045F57217A8E71]:set(f83_arg1 * math.abs(Dvar[0x8045F57217A8E71]:get()))
		end,
	},
	[0xF1BFEB2452744FE] = {
		get = function(f84_arg0)
			local f84_local0 = Dvar[0xF1BFEB2452744FE]:get()
			local f84_local1 = Dvar[0xEA85F8276AE6F39]:get()
			if f84_local0 == true then
				if f84_local1 == 3 then
					return 3
				elseif f84_local1 == 2 then
					return 2
				else
					return 1
				end
			else
				return 0
			end
		end,
		apply = function(f85_arg0, f85_arg1)
			if f85_arg1 == 0 then
				Dvar[0xF1BFEB2452744FE]:latch(false)
			elseif f85_arg1 == 1 then
				Dvar[0xF1BFEB2452744FE]:latch(true)
				Dvar[0xEA85F8276AE6F39]:latch(0)
			elseif f85_arg1 == 2 then
				Dvar[0xF1BFEB2452744FE]:latch(true)
				Dvar[0xEA85F8276AE6F39]:latch(2)
			elseif f85_arg1 == 3 then
				Dvar[0xF1BFEB2452744FE]:latch(true)
				Dvar[0xEA85F8276AE6F39]:latch(3)
			end
		end,
	},
	[0x7F3D0B2A87CE0] = {
		get = function(f86_arg0)
			return Engine[0x187F9D07DD24EC4]()
		end,
		apply = function(f87_arg0, f87_arg1)
			Engine[0xC275E2C8867FB28](f87_arg1)
		end,
	},
	[0xA9B3F99F070C094] = {
		getOptions = function(f88_arg0)
			return CoD.PCOptionsUtility.GetAvailableDisplayAdapters(f88_arg0)
		end,
	},
	[0x75FAB09C00BEF8] = {
		get = function(f89_arg0)
			return tonumber(Dvar[0x42B9136D7EB8906]:get())
		end,
		apply = function(f90_arg0, f90_arg1)
			Dvar[0x42B9136D7EB8906]:set(f90_arg1)
		end,
	},
	[0x67CC3ACAB147B9] = {
		get = function(f91_arg0)
			local f91_local0 = Dvar[0x880C893C1C3B86]:get() == true
			local f91_local1 = nil
			if CoD.PCOptionsUtility.ChangedOptionsList[0x67CC3ACAB147B9] == nil then
				f91_local1 = Dvar[0x67CC3ACAB147B9]:get()
			else
				f91_local1 = CoD.PCOptionsUtility.ChangedOptionsList[0x67CC3ACAB147B9]
			end
			if f91_local0 and f91_local1 ~= 0 then
				return 1
			else
				return 0
			end
		end,
		apply = function(f92_arg0, f92_arg1)
			local f92_local0 = Dvar[0x67CC3ACAB147B9]
			local f92_local1 = f92_local0
			f92_local0 = f92_local0.set
			local f92_local2
			if f92_arg1 == 0 then
				f92_local2 = 0
				if not f92_local2 then
				else
					f92_local0(f92_local1, f92_local2)
				end
			end
			f92_local2 = -1
		end,
	},
	[0x106A603FD6135C0] = {
		getOptions = function(f93_arg0)
			return CoD.PCOptionsUtility.GetMonitorOptions(f93_arg0)
		end,
		get = function(f94_arg0)
			local f94_local0 = Dvar[0x106A603FD6135C0]:get()
			if f94_local0 == 0 then
				f94_local0 = 1
			end
			return f94_local0
		end,
	},
	[0xDD980970E4D6B94] = {
		getOptions = function(f95_arg0)
			return CoD.PCOptionsUtility.GetScreenResolutions(f95_arg0)
		end,
	},
	[0x7D92627D31E5627] = {
		getOptions = function(f96_arg0)
			return CoD.PCOptionsUtility.GetRefreshRateOptions(f96_arg0)
		end,
	},
	[0xAAA15D9B94E876A] = {
		getOptions = function(f97_arg0)
			return CoD.PCOptionsUtility.GetDisplayGammaModelOptions(f97_arg0)
		end,
	},
	[0xAB8E3637D379A77] = {
		get = function(f98_arg0)
			return CoD.PCOptionsUtility.OptionListFocusModelBehavior and 1 or 0
		end,
		apply = function(f99_arg0, f99_arg1)
			CoD.PCOptionsUtility.OptionListFocusModelBehavior = f99_arg1 == 1
		end,
		immediate_apply = true,
	},
	[0x40D1506D7E0D5B9] = {
		getOptions = function(f100_arg0)
			local f100_local0 = Engine[0x4F23B0EEAB93E63]()
			if #f100_local0 == 0 then
				f100_local0[1] = {
					name = Dvar[0x40D1506D7E0D5B9]:get(),
					value = 1,
				}
			end
			for f100_local4, f100_local5 in pairs(f100_local0) do
				if f100_local5.name == "Default System Device" then
					f100_local5.name = Engine[0xF9F1239CFD921FE](0x39DDC196A10C8D)
				end
				if f100_local5.name == "Default Communication Device" then
					f100_local5.name = Engine[0xF9F1239CFD921FE](0x3355E2D7781B790)
				end
				if f100_local5.name == "No Device" then
					f100_local5.name = Engine[0xF9F1239CFD921FE](0xB1BBF20445D4FAD)
				end
			end
			return f100_local0
		end,
		get = function(f101_arg0)
			local f101_local0 = Dvar[0x40D1506D7E0D5B9]:get()
			local f101_local1 = Engine[0x4F23B0EEAB93E63]()
			local f101_local2 = nil
			if #f101_local1 > 0 then
				for f101_local6, f101_local7 in pairs(f101_local1) do
					if f101_local7.name == f101_local0 then
						return f101_local7.value
					elseif f101_local7.name == "Default System Device" then
						f101_local2 = f101_local7.value
					end
				end
			end
			return f101_local2 or 0
		end,
		apply = function(f102_arg0, f102_arg1)
			Engine[0x68342BC526449B6](f102_arg1)
		end,
		setCurrentValue = function(f103_arg0, f103_arg1, f103_arg2)
			Engine[0x68342BC526449B6](f103_arg2)
			CoD.PCOptionsUtility.SetCurrentOptionValue(f103_arg0, f103_arg1, f103_arg2)
		end,
		useListOptionsOutdatedCheck = true,
	},
	[0x6B2142845794848] = {
		getOptions = function(f104_arg0)
			local f104_local0 = Engine[0x92162338F72037A]()
			if #f104_local0 == 0 then
				f104_local0[1] = {
					name = Dvar[0x6B2142845794848]:get(),
					value = 1,
				}
			end
			for f104_local4, f104_local5 in pairs(f104_local0) do
				if f104_local5.name == "Default System Device" then
					f104_local5.name = Engine[0xF9F1239CFD921FE](0x39DDC196A10C8D)
				end
				if f104_local5.name == "Default Communication Device" then
					f104_local5.name = Engine[0xF9F1239CFD921FE](0x3355E2D7781B790)
				end
				if f104_local5.name == "No Device" then
					f104_local5.name = Engine[0xF9F1239CFD921FE](0xB1BBF20445D4FAD)
				end
			end
			return f104_local0
		end,
		get = function(f105_arg0)
			local f105_local0 = Dvar[0x6B2142845794848]:get()
			local f105_local1 = Engine[0x92162338F72037A]()
			local f105_local2 = nil
			if #f105_local1 > 0 then
				for f105_local6, f105_local7 in pairs(Engine[0x92162338F72037A]()) do
					if f105_local7.name == f105_local0 then
						return f105_local7.value
					elseif f105_local7.name == "Default System Device" then
						f105_local2 = f105_local7.value
					end
				end
			end
			return f105_local2 or 0
		end,
		apply = function(f106_arg0, f106_arg1)
			Engine[0x32A85529CFEC271](f106_arg1)
		end,
		setCurrentValue = function(f107_arg0, f107_arg1, f107_arg2)
			Engine[0x32A85529CFEC271](f107_arg2)
			CoD.PCOptionsUtility.SetCurrentOptionValue(f107_arg0, f107_arg1, f107_arg2)
		end,
		useListOptionsOutdatedCheck = true,
	},
	[0x60DAE1D26156AD3] = {
		apply = function(f108_arg0, f108_arg1)
			Engine[0x280E4C1191CC53D](f108_arg0, 0x60DAE1D26156AD3, f108_arg1)
			DataSourceHelperRecreate(f108_arg0, "StickLayoutLabels")
		end,
		onActive = function(f109_arg0)
			CoD.ModelUtility.SetControllerModelValueToEnum(f109_arg0, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_STICKS)
		end,
	},
	[0xA65074E99DCE92F] = {
		apply = function(f110_arg0, f110_arg1)
			Engine[0x280E4C1191CC53D](f110_arg0, 0xA65074E99DCE92F, f110_arg1)
			DataSourceHelperRecreate(f110_arg0, "ButtonLayoutLabels")
		end,
		onActive = function(f111_arg0)
			CoD.ModelUtility.SetControllerModelValueToEnum(f111_arg0, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BUTTONS)
		end,
	},
	[0x82852615C40E4FC] = {
		apply = function(f112_arg0, f112_arg1)
			Engine[0x280E4C1191CC53D](f112_arg0, 0x82852615C40E4FC, f112_arg1)
			DataSourceHelperRecreate(f112_arg0, "ButtonLayoutLabels")
		end,
		onActive = function(f113_arg0)
			CoD.ModelUtility.SetControllerModelValueToEnum(f113_arg0, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BUTTONS)
		end,
	},
	[0xFF11E85689F1D27] = {
		apply = function(f114_arg0, f114_arg1)
			local f114_local0
			if 1 <= f114_arg1 then
				f114_local0 = 3
				if not f114_local0 then
				else
					local f114_local1 = f114_arg1 ~= 2
					Dvar[0xFDA5D20BF93E4D6]:set(f114_local0)
					Dvar[0x584D68D5979628B]:set(f114_local1)
					Dvar[0xFF11E85689F1D27]:set(f114_local1)
				end
			end
			f114_local0 = 0
		end,
		get = function(f115_arg0)
			local f115_local0 = 0
			if not Dvar[0xFF11E85689F1D27]:get() then
				f115_local0 = 2
			elseif Dvar[0xFDA5D20BF93E4D6]:get() == 3 then
				f115_local0 = 1
			end
			return f115_local0
		end,
	},
	[0x2A69EB47F9E465F] = {
		get = function(f116_arg0)
			local f116_local0 = Dvar[0x2A69EB47F9E465F]:get() and 1 or 0
			if not Engine[0xDFF1D0F8D75A972](f116_arg0) then
				f116_local0 = 0
			end
			return f116_local0
		end,
		apply = function(f117_arg0, f117_arg1)
			Dvar[0x2A69EB47F9E465F]:set(f117_arg1 == 1)
		end,
		unavailableFunction = function(f118_arg0)
			return not Engine[0xDFF1D0F8D75A972](f118_arg0)
		end,
	},
	[0x8C156AE83C76D5E] = {
		get = function(f119_arg0)
			return Dvar[0x8C156AE83C76D5E]:get() and 1 or 0
		end,
		apply = function(f120_arg0, f120_arg1)
			Dvar[0x8C156AE83C76D5E]:set(f120_arg1 == 1)
			local f120_local0 = DataSources.PCTelemetry.getModel(f120_arg0)
			f120_local0.showVoiceSuspended:set(f120_arg1)
		end,
	},
	[0x5C8A34838083469] = {
		get = function(f121_arg0)
			return Engine[0x521BD332BD7984C](Enum[0xF6296F5D7A38AD2][0x8AE60B993F07980]) and 0 or 1
		end,
		apply = function(f122_arg0, f122_arg1)
			local f122_local0
			if f122_arg1 == 0 then
				f122_local0 = true
			else
				f122_local0 = false
			end
			Engine[0x9D12A6D16B07D89](Enum[0xF6296F5D7A38AD2][0x8AE60B993F07980], f122_local0)
			if not f122_local0 then
				local f122_local1 = Engine[0xCA0ADE9B4DA235D]
				local f122_local2 = CoD.ChatClientUtility.GetInputChannelModel(f122_arg0)
				if f122_local1(f122_local2:get()) then
					Engine[0x8D53AF0ABECF512]()
				end
			end
		end,
	},
	[0x2A230CA7EF4FC3B] = {
		get = function(f123_arg0)
			return Engine[0x521BD332BD7984C](Enum[0xF6296F5D7A38AD2][0xEB1743CA5B28F23]) and 0 or 1
		end,
		apply = function(f124_arg0, f124_arg1)
			local f124_local0
			if f124_arg1 == 0 then
				f124_local0 = true
			else
				f124_local0 = false
			end
			Engine[0x9D12A6D16B07D89](Enum[0xF6296F5D7A38AD2][0xEB1743CA5B28F23], f124_local0)
			if not f124_local0 then
				local f124_local1 = Engine[0xCA0ADE9B4DA235D]
				local f124_local2 = CoD.ChatClientUtility.GetInputChannelModel(f124_arg0)
				if f124_local1(f124_local2:get()) then
					Engine[0x8D53AF0ABECF512]()
				end
			end
		end,
	},
	[0x119A5A04BCDB324] = {
		get = function(f125_arg0)
			return CoD.PCOptionsUtility.IsRecordingLoopBack(f125_arg0) and 1 or 0
		end,
	},
}
CoD.PCOptionsUtility.LinearMapFromTo = function(f126_arg0, f126_arg1, f126_arg2, f126_arg3, f126_arg4)
	local f126_local0 = (f126_arg0 - f126_arg1) / (f126_arg2 - f126_arg1)
	return f126_local0 * f126_arg4 + (1 - f126_local0) * f126_arg3
end
CoD.PCOptionsUtility.GetOptionValue = function(f127_arg0, f127_arg1)
	if CoD.PCOptionsUtility.SpecialProfileDefaults[f127_arg0] and CoD.PCOptionsUtility.SpecialProfileDefaults[f127_arg0].get then
		return CoD.PCOptionsUtility.SpecialProfileDefaults[f127_arg0].get(f127_arg1)
	elseif Engine[0x6EFFE5E7E57CDD5](f127_arg0) then
		local f127_local0 = Engine[0x8C7ADE01B406F5E](f127_arg1, f127_arg0)
		local f127_local1 = tonumber(f127_local0)
		if f127_local1 then
			return f127_local1
		else
			return f127_local0
		end
	end
	local f127_local0 = Dvar[f127_arg0]:get()
	local f127_local1 = tonumber(f127_local0)
	if f127_local0 == true then
		f127_local1 = 1
	elseif f127_local0 == false then
		f127_local1 = 0
	end
	if f127_local1 ~= nil then
		return f127_local1
	end
	return f127_local0
end
CoD.PCOptionsUtility.SetCurrentOptionValue = function(f128_arg0, f128_arg1, f128_arg2)
	local f128_local0 = CoD.PCOptionsUtility.GetOptionModel(f128_arg1, f128_arg0)
	local f128_local1 = CoD.SafeGetModelValue(f128_local0, "unavailableFunction")
	if f128_local1 and f128_local1(f128_arg1) then
		return
	end
	local f128_local2 = CoD.PCOptionsUtility.SpecialProfileDefaults[f128_arg0]
	if CoD.PCOptionsUtility.GetCurrentOptionTabId(f128_arg1) ~= CoD.PCOptionsUtility.OptionTabIds.Graphic then
		CoD.PCOptionsUtility.ApplyOptionValue(f128_arg1, f128_arg0, f128_arg2, CoD.PCOptionsUtility.ProfileTypes.USER_PROFILE)
	elseif f128_arg2 == CoD.PCOptionsUtility.GetOptionValue(f128_arg0, f128_arg1) then
		CoD.PCOptionsUtility.ChangedOptionsList[f128_arg0] = nil
	else
		CoD.PCOptionsUtility.ChangedOptionsList[f128_arg0] = f128_arg2
	end
	if f128_local0 and not f128_local0.currentValue:set(CoD.PCOptionsUtility.GetCurrentOptionValue(f128_arg0, f128_arg1)) then
		f128_local0.currentValue:forceNotifySubscriptions()
	end
	local f128_local3 = CoD.PCOptionsUtility.GetSpecialProfileData(f128_arg0, false)
	if f128_local3 and f128_local3.profilesToUpdate then
		for f128_local7, f128_local8 in pairs(f128_local3.profilesToUpdate) do
			local f128_local9 = CoD.PCOptionsUtility.GetOptionModel(f128_arg1, f128_local7)
			if f128_local9 then
				Engine[0x6A489878620F3BC](f128_local9.refreshWidget)
			end
		end
	end
	if CoD.PCOptionsUtility.IsVRAMBarUpdateRequired(f128_arg0) then
		CoD.PCOptionsUtility.PrepareVRAMBarUpdate(f128_arg1)
	end
	CoD.PCOptionsUtility.UpdateOptionDirtyModel(f128_arg1)
end
CoD.PCOptionsUtility.GetCurrentOptionValue = function(f129_arg0, f129_arg1)
	if CoD.PCOptionsUtility.ChangedOptionsList[f129_arg0] == nil then
		return CoD.PCOptionsUtility.GetOptionValue(f129_arg0, f129_arg1)
	else
		return CoD.PCOptionsUtility.ChangedOptionsList[f129_arg0]
	end
end
CoD.PCOptionsUtility.RefreshSpecificOptions = function(f130_arg0, f130_arg1)
	for f130_local3, f130_local4 in pairs(f130_arg1) do
		local f130_local5 = CoD.PCOptionsUtility.GetOptionModel(f130_arg0, f130_local4)
		if f130_local5 then
			Engine[0x6A489878620F3BC](f130_local5.refreshWidget)
		end
	end
end
CoD.PCOptionsUtility.IsVRAMOverflown = function(f131_arg0)
	local f131_local0, f131_local1 = Engine[0x9831D90925B3DA3]()
	local f131_local2 = Engine[0x4DF5CFBC1771947](f131_arg0)
	return f131_local1 < f131_local2.PC.VRAMBar:get()
end
CoD.PCOptionsUtility.IsVRAMOverRecommended = function(f132_arg0)
	local f132_local0, f132_local1 = Engine[0x9831D90925B3DA3]()
	local f132_local2 = Engine[0x4DF5CFBC1771947](f132_arg0)
	return f132_local0 < f132_local2.PC.VRAMBar:get()
end
CoD.PCOptionsUtility.VRAMPredictOptionNames = {
	0x10198A6861793FE,
	0x4F87480528FF262,
	0x4B8757D7CB6ED3A,
	0x7F3D0B2A87CE0,
	0xD7E6E97898910A0,
	0x67CC3ACAB147B9,
	0xF1BFEB2452744FE,
	0x200BF2595389AC4,
	0x7119D0EEFF392AB,
	0x5A15D5A249FE0ED,
	0xA86ED746CA5D8E3,
	0xDD980970E4D6B94,
	0x106A603FD6135C0,
	0xE2E4C9FF8CB579E,
	0xD679AB6B6B38EFD,
}
CoD.PCOptionsUtility.IsVRAMBarUpdateRequired = function(f133_arg0)
	for f133_local3, f133_local4 in ipairs(CoD.PCOptionsUtility.VRAMPredictOptionNames) do
		if f133_local4 == f133_arg0 then
			return true
		end
	end
	return false
end
CoD.PCOptionsUtility.DelayVRAMBarUpdate = function(f134_arg0, f134_arg1, f134_arg2)
	f134_arg0:addElement(LUI.UITimer.newElementTimer(f134_arg2, true, function(f135_arg0)
		CoD.PCOptionsUtility.PrepareVRAMBarUpdate(f134_arg1)
	end))
end
CoD.PCOptionsUtility.PrepareVRAMBarUpdate = function(f136_arg0)
	local f136_local0 = {}
	for f136_local4, f136_local5 in ipairs(CoD.PCOptionsUtility.VRAMPredictOptionNames) do
		f136_local0[f136_local5] = CoD.PCOptionsUtility.GetCurrentOptionValue(f136_local5, f136_arg0)
	end
	f136_local1 = 0
	f136_local2 = 0
	if f136_local0[0x7119D0EEFF392AB] == 1 then
		f136_local3 = CoDShared.splitString(f136_local0[0xDD980970E4D6B94], "x")
		f136_local1 = tonumber(f136_local3[1])
		f136_local2 = tonumber(f136_local3[2])
	end
	local f136_local6 = Engine[0xBE57033070D5585](f136_local1, f136_local2, f136_local0[0x7119D0EEFF392AB], f136_local0[0x106A603FD6135C0], f136_local0[0x5A15D5A249FE0ED], f136_local0[0xA86ED746CA5D8E3], f136_local0[0x10198A6861793FE], f136_local0[0x4F87480528FF262], f136_local0[0x4B8757D7CB6ED3A], f136_local0[0x7F3D0B2A87CE0], f136_local0[0xD7E6E97898910A0], f136_local0[0xE2E4C9FF8CB579E], f136_local0[0xD679AB6B6B38EFD], f136_local0[0x67CC3ACAB147B9], f136_local0[0xF1BFEB2452744FE], f136_local0[0x4F87480528FF262] > 0, f136_local0[0x200BF2595389AC4] == 1, f136_local0[0x4B8757D7CB6ED3A] > 1, f136_local0[0xF1BFEB2452744FE] > 0)
	local f136_local7 = Engine[0x4DF5CFBC1771947](f136_arg0)
	f136_local7.PC.VRAMBar:set(f136_local6)
end
CoD.PCOptionsUtility.UpdateVRAMBar = function(f137_arg0, f137_arg1, f137_arg2)
	local f137_local0, f137_local1 = Engine[0x9831D90925B3DA3]()
	local f137_local2 = Engine[0x4DF5CFBC1771947](f137_arg0)
	f137_local2 = f137_local2.PC.VRAMBar:get()
	local f137_local3 = f137_local2 / f137_local1
	if f137_local1 < f137_local2 then
		f137_local3 = 1
	end
	f137_arg1.MbUsage:setText(Engine[0xF9F1239CFD921FE](0xBF86D864C077F3E, tostring(f137_local2), tostring(f137_local1)))
	f137_arg1.FilledBar:setWidth(f137_arg1.FilledBarBackground:getWidth() * f137_local3)
end
CoD.PCOptionsUtility.InitializeVRAMBar = function(f138_arg0, f138_arg1, f138_arg2)
	if not f138_arg1.__isInitialized then
		local f138_local0, f138_local1 = Engine[0x9831D90925B3DA3]()
		local f138_local2 = f138_arg1.FilledBarBackground:getWidth() * f138_local0 / f138_local1
		f138_arg1.RecommendedLimit:setLeftRight(0, 0, f138_local2, f138_local2 + f138_arg1.FilledBar:getWidth())
		CoD.PCOptionsUtility.PrepareVRAMBarUpdate(f138_arg0)
		f138_arg1.__isInitialized = true
	end
end
CoD.PCOptionsUtility.SyncVoiceModel = function(f139_arg0)
	CoD.PCOptionsUtility.SyncOptionModel(f139_arg0, 0x2A69EB47F9E465F)
end
CoD.PCOptionsUtility.SyncAudioDeviceModel = function(f140_arg0)
	local f140_local0 = CoD.PCOptionsUtility.GetOptionModel(f140_arg0, 0x6B2142845794848)
	if f140_local0 then
		Engine[0x6A489878620F3BC](f140_local0.refreshWidget)
		CoD.PCOptionsUtility.SyncOptionModel(f140_arg0, 0x6B2142845794848)
	end
	local f140_local1 = CoD.PCOptionsUtility.GetOptionModel(f140_arg0, 0x40D1506D7E0D5B9)
	if f140_local1 then
		Engine[0x6A489878620F3BC](f140_local1.refreshWidget)
		CoD.PCOptionsUtility.SyncOptionModel(f140_arg0, 0x40D1506D7E0D5B9)
	end
end
CoD.PCOptionsUtility.RefreshVoiceChatTelemetryDisplay = function(f141_arg0)
	SetGlobalModelValue("PCTelemetry.showVoiceSuspended", CoD.PCOptionsUtility.GetCurrentOptionValue(0x8C156AE83C76D5E, f141_arg0))
end
CoD.PCOptionsUtility.CommandToXHash = function(f142_arg0, f142_arg1)
	return f142_local1.name and f142_local2 and f142_local1.name:get()
end
CoD.PCOptionsUtility.GameSettingsFrameLoseFocus = function(f143_arg0, f143_arg1)
	if f143_arg0.TabFramePC then
		SetLoseFocusToElement(f143_arg0, "TabFramePC", f143_arg1)
	end
end
CoD.PCOptionsUtility.RefreshMicCalibrationOptions = function(f144_arg0)
	CoD.PCOptionsUtility.RefreshSpecificOptions(f144_arg0, {
		0x2A69EB47F9E465F,
		0x68BA4B53502094D,
	})
end
CoD.PCOptionsUtility.StartLoopBackCalibrationRecording = function(f145_arg0)
	Engine[0xC4CE1782AAA810D]()
	local f145_local0 = DataSources.SpeakingEnergy:getModel(f145_arg0)
	f145_local0.isRecording:set(true)
	CoD.PCOptionsUtility.RefreshMicCalibrationOptions(f145_arg0)
end
CoD.PCOptionsUtility.StopLoopBackCalibrationRecording = function(f146_arg0)
	Engine[0x7F10050DCE5B23]()
	local f146_local0 = DataSources.SpeakingEnergy.getModel(f146_arg0)
	f146_local0.isRecording:set(false)
	f146_local0 = DataSources.SpeakingEnergy.getModel(f146_arg0)
	f146_local0.displayText:set("0")
	CoD.PCOptionsUtility.RefreshMicCalibrationOptions(f146_arg0)
end
CoD.PCOptionsUtility.IsRecordingLoopBack = function(f147_arg0)
	local f147_local0 = DataSources.SpeakingEnergy.getModel(f147_arg0)
	return f147_local0.isRecording:get()
end
CoD.PCOptionsUtility.StopLoopBackCalibrationRecordingIfRecording = function(f148_arg0)
	if CoD.PCOptionsUtility.IsRecordingLoopBack(f148_arg0) then
		CoD.PCOptionsUtility.StopLoopBackCalibrationRecording(f148_arg0)
	end
end
CoD.PCOptionsUtility.IsVoiceOverflown = function(f149_arg0)
	local f149_local0 = Engine[0x22EAAB59AA27E9B]("voiceBar_maxValue")
	local f149_local1 = DataSources.SpeakingEnergy.getModel(f149_arg0)
	return f149_local0 < tonumber(f149_local1.displayText:get() or 0)
end
CoD.PCOptionsUtility.UpdateVoiceBar = function(f150_arg0, f150_arg1, f150_arg2)
	local f150_local0 = Engine[0x22EAAB59AA27E9B]("voiceBar_recommendedValue") and Engine[0x22EAAB59AA27E9B]("voiceBar_recommendedValue") or 50
	local f150_local1 = Engine[0x22EAAB59AA27E9B]("voiceBar_maxValue") and Engine[0x22EAAB59AA27E9B]("voiceBar_maxValue") or 100
	local f150_local2 = DataSources.SpeakingEnergy.getModel(f150_arg0)
	local f150_local3 = tonumber(f150_local2.displayText:get() or 0)
	if not CoD.PCOptionsUtility.IsRecordingLoopBack(f150_arg0) then
		f150_local3 = 0
	end
	if not f150_local3 then
		return
	end
	local f150_local4 = f150_local3 / f150_local1
	if f150_local1 < f150_local3 then
		f150_local4 = 1
	end
	f150_arg1.DynamicBar.FilledBar:setWidth(f150_arg1.DynamicBar.FilledBarBackground:getWidth() * f150_local4)
end
CoD.PCOptionsUtility.SetVoiceDvars = function()
	Engine[0xB177D654FFB67BE]("voiceBar_recommendedValue", 30)
	Engine[0xB177D654FFB67BE]("voiceBar_maxValue", 70)
end
CoD.PCOptionsUtility.InitializeVoiceBar = function(f152_arg0, f152_arg1)
	local f152_local0 = f152_arg1.DynamicBar:getWidth() * (Engine[0x22EAAB59AA27E9B]("voiceBar_recommendedValue") and Engine[0x22EAAB59AA27E9B]("voiceBar_recommendedValue") or 50) / (Engine[0x22EAAB59AA27E9B]("voiceBar_maxValue") and Engine[0x22EAAB59AA27E9B]("voiceBar_maxValue") or 100)
	f152_arg1.DynamicBar.RecommendedLimit:setLeftRight(0, 0, f152_local0, f152_local0 + 2)
end
DataSources.SpeakingEnergy = {
	prepare = function(f153_arg0)
		local f153_local0 = Engine[0x8DF2E5447F384B9]()
		f153_local0 = f153_local0:create("SpeakingEnergy")
		local f153_local1 = f153_local0:create("displayText")
		f153_local1:set("0")
		f153_local1 = f153_local0:create("isRecording")
		f153_local1:set(false)
	end,
	getModel = function(f154_arg0)
		local f154_local0 = Engine[0x8DF2E5447F384B9]()
		f154_local0 = f154_local0.SpeakingEnergy
		if not f154_local0 or not f154_local0.isRecording then
			DataSources.SpeakingEnergy.prepare(f154_arg0)
			local f154_local1 = Engine[0x8DF2E5447F384B9]()
			f154_local0 = f154_local1.SpeakingEnergy
		end
		return f154_local0
	end,
}

require("x64:64bbc2f21267b33")
require("x64:8c6423d3c47fd33")
require("x64:9583ae1e21ae4")
require("x64:38c11a77e96e48c")
local f0_local0 = function(f1_arg0)
	local f1_local0 = {}
	local f1_local1 = nil
	local f1_local2 = CoD.OptionsUtility.DraftSettings
	if f1_local2 and #f1_local2 > 0 then
		for f1_local6, f1_local7 in ipairs(f1_local2) do
			f1_local1 = CoD.OptionsUtility.GetGameSettingsInfo(f1_local7)
			table.insert(f1_local0, CoD.OptionsUtility.CreateListOptions(f1_arg0, f1_local1.name, f1_local1.hintText, f1_local1.setting, f1_local1, "GameTypeOptionsList_" .. f1_local7))
		end
	end
	return f1_local0
end
local f0_local1 = function(f2_arg0)
	local f2_local0 = CoD.PlayerRoleUtility.GetHeroList(Engine[0x3EAC408F958FF05]())
	local f2_local1 = Engine[0x1E32FEF495242B8]()
	local f2_local2 = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
		print("Setting ALL Max Character Count:  Max: " .. f3_arg3)
		if f2_local0 and #f2_local0 > 0 then
			local f3_local0 = false
			for f3_local4, f3_local5 in ipairs(f2_local0) do
				if f2_local1[0x53F3A0F536232FB][f3_local5.bodyIndex]:get() ~= f3_arg3 then
					f2_local1[0x53F3A0F536232FB][f3_local5.bodyIndex]:set(f3_arg3)
					f3_local0 = true
				end
			end
			f3_local1 = Engine[0x8DF2E5447F384B9]()
			f3_local1 = f3_local1:create("GametypeSettings.UpdateCharacters")
			f3_local1:forceNotifySubscriptions()
		end
	end
	local f2_local3 = nil
	for f2_local7, f2_local8 in ipairs(f2_local0) do
		if not f2_local3 then
			f2_local3 = f2_local1[0x53F3A0F536232FB][f2_local8.bodyIndex]:get()
		end
		if f2_local3 ~= f2_local1[0x53F3A0F536232FB][f2_local8.bodyIndex]:get() then
			f2_local3 = nil
			break
		end
	end
	f2_local4 = 5
	f2_local5 = "allCharacterOptions"
	DataSources[f2_local5] = DataSourceHelpers.ListSetup(f2_local5, function(f4_arg0)
		local f4_local0 = {}
		local f4_local1 = table.insert
		local f4_local2 = f4_local0
		local f4_local3 = {
			models = {
				text = Engine[0xF9F1239CFD921FE](0xEEBDA1A33FABDC),
			},
		}
		local f4_local4 = {}
		local f4_local5
		if f2_local3 ~= nil and f2_local4 >= f2_local3 and f2_local3 > 0 then
			f4_local5 = false
		else
			f4_local5 = true
		end
		f4_local4.selectIndex = f4_local5
		f4_local4.loopEdges = true
		f4_local3.properties = f4_local4
		f4_local1(f4_local2, f4_local3)
		for f4_local1 = 1, f2_local4, 1 do
			table.insert(f4_local0, {
				models = {
					text = f4_local1,
				},
				properties = {
					selectIndex = f2_local3 == f4_local1,
					loopEdges = true,
					action = f2_local2,
					actionParam = f4_local1,
				},
			})
		end
		f4_local0[1].properties.first = true
		f4_local0[#f4_local0].properties.last = true
		return f4_local0
	end, nil, nil, nil)
	f2_local6 = {}
	table.insert(f2_local6, {
		models = {
			name = 0x3F979FF83304183,
			desc = 0x1403A7CB59B0FED,
			image = "blacktransparent",
			optionsDatasource = f2_local5,
		},
		properties = {},
	})
	return f2_local6
end
local f0_local2 = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = 5
	local f5_local1 = f5_arg1:get()
	local f5_local2 = f5_arg0:get()
	local f5_local3 = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
		if f5_arg1:get() ~= f6_arg3 then
			f5_arg1:set(f6_arg3)
			print("Setting Max Character Count: Character:" .. f5_arg2 .. " Max: " .. f6_arg3)
			local f6_local0 = Engine[0x8DF2E5447F384B9]()
			f6_local0 = f6_local0:create("GametypeSettings.CharacterUpdated")
			f6_local0:forceNotifySubscriptions()
		end
	end
	local f5_local4 = "gts_maxUniqueRolesPerTeam" .. f5_arg2
	DataSources[f5_local4] = DataSourceHelpers.ListSetup(f5_local4, function()
		local f7_local0 = {}
		for f7_local1 = 0, f5_local0, 1 do
			table.insert(f7_local0, {
				models = {
					text = f7_local1,
				},
				properties = {
					title = 0x0,
					desc = 0x0,
					image = "",
					value = f7_local1,
					isDefault = f5_local2 == f7_local1,
					selectIndex = f7_local1 == f5_local1,
					loopEdges = true,
					action = f5_local3,
					actionParam = f7_local1,
				},
			})
		end
		f7_local0[1].properties.first = true
		f7_local0[f5_local0 + 1].properties.last = true
		return f7_local0
	end, nil, nil, nil)
	return f5_local4
end
local f0_local3 = function(f8_arg0)
	local f8_local0 = {}
	local f8_local1 = nil
	local f8_local2 = Engine[0x1E32FEF495242B8]()
	local f8_local3 = Engine[0x1E32FEF495242B8]()
	local f8_local4 = CoD.PlayerRoleUtility.GetHeroList(Engine[0x3EAC408F958FF05]())
	if f8_local4 and #f8_local4 > 0 then
		for f8_local8, f8_local9 in ipairs(f8_local4) do
			local f8_local10 = f8_local9.bodyIndex
			local f8_local11 = f8_local3[0x53F3A0F536232FB][f8_local10]
			local f8_local12 = f8_local2[0x53F3A0F536232FB][f8_local10]
			table.insert(f8_local0, {
				models = {
					name = Engine[0xF9F1239CFD921FE](f8_local9.displayName),
					desc = 0x3F61F4CF743D1BF,
					image = "blacktransparent",
					optionsDatasource = f0_local2(f8_local11, f8_local12, f8_local10),
				},
				properties = {
					revert = function(f9_arg0)
						f8_local12:set(f8_local11:get())
					end,
				},
			})
		end
	end
	return f8_local0
end
local f0_local4 = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = Engine[0x8DF2E5447F384B9]()
	f10_local0 = f10_local0:create("GametypeSettings.CharacterUpdated")
	if f10_arg1.updateSubscription then
		f10_arg1:removeSubscription(f10_arg1.updateSubscription)
	end
	f10_arg1.updateSubscription = f10_arg1:subscribeToModel(f10_local0, function()
		f10_arg1:updateDataSource(true)
	end, false)
end
local f0_local5 = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "GametypeSettings"), "UpdateCharacters")
	if f12_arg1.updateSubscription then
		f12_arg1:removeSubscription(f12_arg1.updateSubscription)
	end
	f12_arg1.updateSubscription = f12_arg1:subscribeToModel(f12_local0, function()
		f12_arg1:updateDataSource(true)
	end, false)
end
DataSources.DraftSettings = DataSourceHelpers.ListSetup("DraftSettings", f0_local0, nil, nil, nil)
DataSources.AllCharacterSettings = DataSourceHelpers.ListSetup("AllCharacterSettings", f0_local1, nil, nil, f0_local4)
DataSources.CharacterSettings = DataSourceHelpers.ListSetup("CharacterSettings", f0_local3, nil, nil, f0_local5)
CoD.GameSettings_Characters = InheritFrom(LUI.UIElement)
CoD.GameSettings_Characters.__defaultWidth = 1920
CoD.GameSettings_Characters.__defaultHeight = 877
CoD.GameSettings_Characters.new = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5, f14_arg6, f14_arg7, f14_arg8, f14_arg9)
	local self = LUI.UIElement.new(f14_arg2, f14_arg3, f14_arg4, f14_arg5, f14_arg6, f14_arg7, f14_arg8, f14_arg9)
	self:setClass(CoD.GameSettings_Characters)
	self.id = "GameSettings_Characters"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f14_arg0:addElementToPendingUpdateStateList(self)
	local GameSettingsSelectedItemInfo = CoD.GameSettings_SelectedItemInfo.new(f14_arg0, f14_arg1, 0, 1, 0, 0, -0.5, 0.5, 234, 436)
	GameSettingsSelectedItemInfo.GameModeName:setAlpha(0)
	self:addElement(GameSettingsSelectedItemInfo)
	self.GameSettingsSelectedItemInfo = GameSettingsSelectedItemInfo
	local f14_local2 = nil
	local OptionCategoryGrid = LUI.GridLayout.new(f14_arg0, f14_arg1, false, 0, 0, 8, 0, nil, nil, false, false, false, false)
	OptionCategoryGrid:setLeftRight(0, 0, 100, 350)
	OptionCategoryGrid:setTopBottom(0, 0, 10, 592)
	OptionCategoryGrid:setWidgetType(CoD.CustomGames_OptionCategoryButton)
	OptionCategoryGrid:setVerticalCount(5)
	OptionCategoryGrid:setSpacing(8)
	OptionCategoryGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionCategoryGrid:setDataSource("SpecialistOptionCategories")
	OptionCategoryGrid:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f14_arg0, f14_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f15_local0
	end)
	f14_arg0:AddButtonCallbackFunction(OptionCategoryGrid, f14_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ShowWidget(self.SlidersPC)
		SetCurrentElementAsActive(self, element, controller)
		SetFocusToElement(self, "SlidersPC", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(OptionCategoryGrid)
	self.OptionCategoryGrid = OptionCategoryGrid
	local f14_local4 = nil
	local SlidersPC = LUI.UIList.new(f14_arg0, f14_arg1, 8, 0, nil, false, false, false, false)
	SlidersPC:setLeftRight(0, 0, 367, 1067)
	SlidersPC:setTopBottom(0, 0, 10, 818)
	SlidersPC:setWidgetType(CoD.CustomGames_SettingSlider)
	SlidersPC:setVerticalCount(12)
	SlidersPC:setSpacing(8)
	SlidersPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SlidersPC:setVerticalCounter(CoD.verticalCounter)
	SlidersPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f18_local0 = nil
		ProcessListAction(self, element, f14_arg1, f14_arg0)
		GameSettingsButtonGainFocus(self, element, f14_arg1)
		SetCurrentElementAsActive(self, element, f14_arg1)
		return f18_local0
	end)
	SlidersPC:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, false)
		CoD.Menu.UpdateButtonShownState(element, f14_arg0, f14_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(element, f14_arg0, f14_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		return f19_local0
	end)
	SlidersPC:registerEventHandler("lose_focus", function(element, event)
		local f20_local0 = nil
		if element.loseFocus then
			f20_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f20_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryGrid, true)
		return f20_local0
	end)
	f14_arg0:AddButtonCallbackFunction(SlidersPC, f14_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_contextual_1", function(element, menu, controller, model)
		if AlwaysFalse() then
			OpenGameSettingsOptionsMenu(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x8E7772DFD9BBDEB, nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f14_arg0:AddButtonCallbackFunction(SlidersPC, f14_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		SetFocusToElement(self, "OptionCategoryGrid", controller)
		CoD.OptionsUtility.SetFocusToGrid(self.OptionCategoryGrid)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x0, nil, nil)
		return false
	end, false)
	self:addElement(SlidersPC)
	self.SlidersPC = SlidersPC
	local f14_local6 = nil
	f14_local6 = LUI.UIElement.createFake()
	self.OptionCategoryList = f14_local6
	local f14_local7 = nil
	f14_local7 = LUI.UIElement.createFake()
	self.Sliders = f14_local7
	SlidersPC:linkToElementModel(OptionCategoryGrid, "optionsListDatasource", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			SlidersPC:setDataSource(f25_local0)
		end
	end)
	f14_local7:linkToElementModel(f14_local6, "optionsListDatasource", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			f14_local7:setDataSource(f26_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "EditSettings",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f14_arg1, "customGamesEdit") and not IsPC()
			end,
		},
		{
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	local f14_local8 = self
	local f14_local9 = self.subscribeToModel
	local f14_local10 = Engine[0x4DF5CFBC1771947](f14_arg1)
	f14_local9(f14_local8, f14_local10.customGamesEdit, function(f29_arg0)
		f14_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f14_arg0,
			controller = f14_arg1,
			modelValue = f29_arg0:get(),
			modelName = "customGamesEdit",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f14_arg1, "customGamesEdit", false)
	end)
	OptionCategoryGrid.id = "OptionCategoryGrid"
	SlidersPC.id = "SlidersPC"
	f14_local6.id = "OptionCategoryList"
	f14_local7.id = "Sliders"
	self.__defaultFocus = f14_local6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f14_arg1, f14_arg0)
	end
	f14_local9 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.OptionCategoryGrid)
		ForceCheckDefaultPCFocus(self.OptionCategoryGrid, f14_arg0, f14_arg1)
	end
	f14_local9 = SlidersPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f14_local9, false)
		SetElementProperty(f14_local9, "ignoreSavedActive", true)
	end
	SetElementCanBeNavigatedTo(f14_local6, false)
	SetElementCanBeNavigatedTo(f14_local7, false)
	return self
end
CoD.GameSettings_Characters.__resetProperties = function(f31_arg0)
	f31_arg0.Sliders:completeAnimation()
	f31_arg0.GameSettingsSelectedItemInfo:completeAnimation()
	f31_arg0.OptionCategoryList:completeAnimation()
	f31_arg0.Sliders:setAlpha(1)
	f31_arg0.GameSettingsSelectedItemInfo.ToolTip:setAlpha(1)
	f31_arg0.OptionCategoryList:setAlpha(1)
end
CoD.GameSettings_Characters.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.GameSettingsSelectedItemInfo:completeAnimation()
			f32_arg0.GameSettingsSelectedItemInfo.ToolTip:completeAnimation()
			f32_arg0.GameSettingsSelectedItemInfo.ToolTip:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.GameSettingsSelectedItemInfo)
			f32_arg0.Sliders:completeAnimation()
			f32_arg0.Sliders:setAlpha(0.1)
			f32_arg0.clipFinished(f32_arg0.Sliders)
		end,
	},
	EditSettings = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
			f33_arg0.OptionCategoryList:completeAnimation()
			f33_arg0.OptionCategoryList:setAlpha(0.1)
			f33_arg0.clipFinished(f33_arg0.OptionCategoryList)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.GameSettingsSelectedItemInfo:completeAnimation()
			f34_arg0.GameSettingsSelectedItemInfo.ToolTip:completeAnimation()
			f34_arg0.GameSettingsSelectedItemInfo.ToolTip:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.GameSettingsSelectedItemInfo)
		end,
	},
}
CoD.GameSettings_Characters.__onClose = function(f35_arg0)
	f35_arg0.SlidersPC:close()
	f35_arg0.Sliders:close()
	f35_arg0.GameSettingsSelectedItemInfo:close()
	f35_arg0.OptionCategoryGrid:close()
	f35_arg0.OptionCategoryList:close()
end

require("x64:4a41f318bc01aae")
require("x64:64bbc2f21267b33")
require("x64:48be5c6feaceeb4")
require("x64:d5504359f8c0fcd")
require("x64:38c11a77e96e48c")
CoD.DirectorCodCasterTeamSettings = InheritFrom(LUI.UIElement)
CoD.DirectorCodCasterTeamSettings.__defaultWidth = 1920
CoD.DirectorCodCasterTeamSettings.__defaultHeight = 1080
CoD.DirectorCodCasterTeamSettings.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CodCasterUtility.PreLoadCodCasterTeamSettings(self, f1_arg1)
	self:setClass(CoD.DirectorCodCasterTeamSettings)
	self.id = "DirectorCodCasterTeamSettings"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	local ButtonListPC = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	ButtonListPC:setLeftRight(0, 0, 366, 1066)
	ButtonListPC:setTopBottom(0, 0, 52, 98)
	ButtonListPC:setWidgetType(CoD.StartMenu_Options_SettingSlider)
	ButtonListPC:setSpacing(6)
	ButtonListPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonListPC:setVerticalCounter(CoD.verticalCounter)
	ButtonListPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		GameSettingsButtonGainFocus(self, element, f1_arg1)
		SetCurrentElementAsActive(self, element, f1_arg1)
		return f2_local0
	end)
	ButtonListPC:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryListPC, false)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		return f3_local0
	end)
	ButtonListPC:registerEventHandler("lose_focus", function(element, event)
		local f4_local0 = nil
		if element.loseFocus then
			f4_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f4_local0 = element.super:loseFocus(event)
		end
		SetElementCanBeNavigatedTo(self.OptionCategoryListPC, true)
		return f4_local0
	end)
	ButtonListPC:registerEventHandler("list_active_changed", function(element, event)
		local f5_local0 = nil
		CoD.GridAndListUtility.UpdateDataSource(self.OptionCategoryListPC, true, true, true)
		CoD.CodCasterUtility.UpdateTeamIdentity(self, f1_arg1, false)
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonListPC, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.ButtonListPC)
		SetControllerModelValue(controller, "customGamesEdit", false)
		SetFocusToElement(self, "OptionCategoryListPC", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	ButtonListPC:subscribeToGlobalModel(f1_arg1, "PerController", "PlayerSettingsUpdate", function(model)
		local f8_local0 = ButtonListPC
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "PlayerSettingsUpdate", "codcaster_fe_team_identity") and not CoD.ModelUtility.IsSelfNil(self.ButtonListPC, f1_arg1) then
			CoD.GridAndListUtility.UpdateDataSource(self.OptionCategoryListPC, true, true, true)
			CoD.CodCasterUtility.UpdateTeamIdentity(self, f1_arg1, false)
		end
	end)
	self:addElement(ButtonListPC)
	self.ButtonListPC = ButtonListPC
	local f1_local3 = nil
	local OptionCategoryListPC = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	OptionCategoryListPC:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsElementPropertyValue(element, "disabled", true)
			end,
		},
	})
	local f1_local5 = OptionCategoryListPC
	local f1_local6 = OptionCategoryListPC.subscribeToModel
	local OptionInfo = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, OptionInfo.customGamesEdit, function(f10_arg0)
		f1_arg0:updateElementState(OptionCategoryListPC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "customGamesEdit",
		})
	end, false)
	OptionCategoryListPC:setLeftRight(0, 0, 100, 350)
	OptionCategoryListPC:setTopBottom(0, 0, 52, 398)
	OptionCategoryListPC:setWidgetType(CoD.CustomGames_OptionCategoryButton)
	OptionCategoryListPC:setVerticalCount(3)
	OptionCategoryListPC:setSpacing(8)
	OptionCategoryListPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionCategoryListPC:setDataSource("CodCasterTeamSettingsCategories")
	OptionCategoryListPC:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionCategoryListPC, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsElementPropertyValue(element, "actionTeam", nil) then
			ShowWidget(self.ButtonListPC)
			SetCurrentElementAsActive(self, element, controller)
			SetFocusToElement(self, "ButtonListPC", controller)
			return true
		elseif not IsElementPropertyValue(element, "actionTeam", nil) then
			CoD.CodCasterUtility.OpenCodCasterEditTeamSettings(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementPropertyValue(element, "actionTeam", nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif not IsElementPropertyValue(element, "actionTeam", nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionCategoryListPC)
	self.OptionCategoryListPC = OptionCategoryListPC
	f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.ButtonList = f1_local6
	f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.OptionCategoryList = f1_local5
	OptionInfo = CoD.StartMenu_Options_SettingInfo.new(f1_arg0, f1_arg1, 0, 0, 1088, 1788, 0, 0, 52, 156)
	self:addElement(OptionInfo)
	self.OptionInfo = OptionInfo
	local f1_local8 = nil
	f1_local8 = LUI.UIElement.createFake()
	self.CodCasterTeamIdentityInformationPanel = f1_local8
	local CodCasterTeamIdentityInformationPanelPC = nil
	CodCasterTeamIdentityInformationPanelPC = CoD.CodCasterTeamIdentityInformationPanel.new(f1_arg0, f1_arg1, 0, 0, 366, 1140, 0, 0, 99, 639)
	CodCasterTeamIdentityInformationPanelPC:mergeStateConditions({
		{
			stateName = "ShowBoth",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTeam1Info") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTeam2Info")
			end,
		},
		{
			stateName = "ShowTeam1Only",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTeam1Info") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTeam2Info")
			end,
		},
		{
			stateName = "ShowTeam2Only",
			condition = function(menu, element, event)
				local f16_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTeam1Info") then
					f16_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTeam2Info")
				else
					f16_local0 = false
				end
				return f16_local0
			end,
		},
	})
	CodCasterTeamIdentityInformationPanelPC:linkToElementModel(CodCasterTeamIdentityInformationPanelPC, "showTeam1Info", true, function(model)
		f1_arg0:updateElementState(CodCasterTeamIdentityInformationPanelPC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showTeam1Info",
		})
	end)
	CodCasterTeamIdentityInformationPanelPC:linkToElementModel(CodCasterTeamIdentityInformationPanelPC, "showTeam2Info", true, function(model)
		f1_arg0:updateElementState(CodCasterTeamIdentityInformationPanelPC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showTeam2Info",
		})
	end)
	self:addElement(CodCasterTeamIdentityInformationPanelPC)
	self.CodCasterTeamIdentityInformationPanelPC = CodCasterTeamIdentityInformationPanelPC
	ButtonListPC:linkToElementModel(OptionCategoryListPC, "optionsListDatasource", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			ButtonListPC:setDataSource(f19_local0)
		end
	end)
	f1_local6:linkToElementModel(f1_local5, "optionsListDatasource", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			f1_local6:setDataSource(f20_local0)
		end
	end)
	f1_local8:linkToElementModel(f1_local5, nil, false, function(model)
		f1_local8:setModel(model, f1_arg1)
	end)
	CodCasterTeamIdentityInformationPanelPC:linkToElementModel(OptionCategoryListPC, nil, false, function(model)
		CodCasterTeamIdentityInformationPanelPC:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "EditSettings",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "customGamesEdit") and not IsPC()
			end,
		},
		{
			stateName = "DefaultPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12.customGamesEdit, function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "customGamesEdit",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg1, "customGamesEdit", false)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "GametypeSettings.ResetTeam", function(model)
		local f27_local0 = self
		if not IsPC() then
			CoD.GridAndListUtility.UpdateDataSource(self.OptionCategoryList, true, true, true)
			CoD.CodCasterUtility.UpdateTeamIdentity(self, f1_arg1, true)
		elseif IsPC() then
			CoD.GridAndListUtility.UpdateDataSource(self.OptionCategoryListPC, true, true, true)
			CoD.CodCasterUtility.UpdateTeamIdentity(self, f1_arg1, true)
		end
	end)
	ButtonListPC.id = "ButtonListPC"
	OptionCategoryListPC.id = "OptionCategoryListPC"
	f1_local6.id = "ButtonList"
	f1_local5.id = "OptionCategoryList"
	self.__defaultFocus = f1_local5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.OptionCategoryListPC)
		ForceCheckDefaultPCFocus(self.OptionCategoryListPC, f1_arg0, f1_arg1)
	end
	f1_local11 = ButtonListPC
	if IsPC() then
		SetElementCanBeNavigatedTo(f1_local11, false)
		SetElementProperty(f1_local11, "ignoreSavedActive", true)
	end
	SetElementCanBeNavigatedTo(f1_local6, false)
	SetElementCanBeNavigatedTo(f1_local5, false)
	return self
end
CoD.DirectorCodCasterTeamSettings.__resetProperties = function(f28_arg0)
	f28_arg0.ButtonList:completeAnimation()
	f28_arg0.OptionInfo:completeAnimation()
	f28_arg0.OptionCategoryList:completeAnimation()
	f28_arg0.ButtonList:setAlpha(1)
	f28_arg0.OptionInfo:setAlpha(1)
	f28_arg0.OptionCategoryList:setAlpha(1)
end
CoD.DirectorCodCasterTeamSettings.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.ButtonList:completeAnimation()
			f29_arg0.ButtonList:setAlpha(0.12)
			f29_arg0.clipFinished(f29_arg0.ButtonList)
			f29_arg0.OptionInfo:completeAnimation()
			f29_arg0.OptionInfo:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.OptionInfo)
		end,
	},
	EditSettings = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(0)
			f30_arg0.OptionCategoryList:completeAnimation()
			f30_arg0.OptionCategoryList:setAlpha(0.12)
			f30_arg0.clipFinished(f30_arg0.OptionCategoryList)
		end,
	},
	DefaultPC = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorCodCasterTeamSettings.__onClose = function(f32_arg0)
	f32_arg0.ButtonListPC:close()
	f32_arg0.ButtonList:close()
	f32_arg0.CodCasterTeamIdentityInformationPanel:close()
	f32_arg0.CodCasterTeamIdentityInformationPanelPC:close()
	f32_arg0.OptionCategoryListPC:close()
	f32_arg0.OptionCategoryList:close()
	f32_arg0.OptionInfo:close()
end

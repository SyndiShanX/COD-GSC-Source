require("x64:eda152e1d10147a")
require("x64:2c1273189457a97")
require("x64:71d2a0ed724628e")
require("x64:185563fab2ddf96")
require("x64:75e2a524b093c12")
CoD.WZPersonalizeCharacterInspect = InheritFrom(CoD.Menu)
LUI.createMenu.WZPersonalizeCharacterInspect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WZPersonalizeCharacterInspect", f1_arg0)
	local f1_local1 = self
	CoD.PlayerRoleUtility[@"hash_12B307D12327547E"](f1_arg0)
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1.model)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1.properties)
	SendClientScriptMenuExpressionStateChangeNotify(f1_arg0, f1_local1, true, f1_arg1.model.characterIndex:get())
	self:setClass(CoD.WZPersonalizeCharacterInspect)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0.5, 0.5, -375, 375, 0.5, 0.5, -465, 235)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackingFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	BackingFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	BackingFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_72AA2EA68ACC2317"))
	BackingFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BackingFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(BackingFrame)
	self.BackingFrame = BackingFrame
	local options = LUI.UIList.new(f1_local1, f1_arg0, 13, 0, nil, false, false, false, false)
	options:setLeftRight(0.5, 0.5, -813, -420)
	options:setTopBottom(0, 0, 222.5, 947.5)
	options:setWidgetType(CoD.SpecialistPersonalizationButtonOption)
	options:setVerticalCount(9)
	options:setSpacing(13)
	options:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	options:setDataSource("MPSpecialistHUBOptions")
	options:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(options, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(options)
	self.options = options
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	local bgblur = LUI.UIImage.new(0.5, 0.5, 260.5, 800.5, 0.5, 0.5, 321.5, 423.5)
	bgblur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	bgblur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(bgblur)
	self.bgblur = bgblur
	local BackingNoise = LUI.UIImage.new(0.5, 0.5, 260, 800, 0.5, 0.5, 321.5, 423.5)
	BackingNoise:setAlpha(0.8)
	BackingNoise:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local BraketBottom = LUI.UIImage.new(0.5, 0.5, 256, 803, 0.5, 0.5, 397, 425)
	BraketBottom:setZRot(180)
	BraketBottom:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_info_bracket"))
	BraketBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BraketBottom:setShaderVector(0, 0, 0, 0, 0)
	BraketBottom:setupNineSliceShader(350, 20)
	self:addElement(BraketBottom)
	self.BraketBottom = BraketBottom
	local FuiBox02Right = LUI.UIImage.new(0.5, 0.5, 763.5, 797.5, 0.5, 0.5, 360, 326)
	FuiBox02Right:setAlpha(0.1)
	FuiBox02Right:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local SpecialistName = LUI.UIText.new(0.5, 0.5, 271.5, 789.5, 0.5, 0.5, 360, 389)
	SpecialistName:setRGB(0.92, 0.89, 0.72)
	SpecialistName:setAlpha(0.7)
	SpecialistName:setZoom(3)
	SpecialistName:setTTF("ttmussels_regular")
	SpecialistName:setLetterSpacing(8)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SpecialistName:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SpecialistName:setText(CoD.SocialUtility.CleanGamerTag(ToUpper(CoD.BaseUtility.LocalizeIfXHash(f7_local0))))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local CharacterSelectionPrestigeInfo = CoD.CharacterSelection_PrestigeInfo.new(f1_local1, f1_arg0, 0.5, 0.5, 260, 334, 0.5, 0.5, 235, 309)
	CharacterSelectionPrestigeInfo:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f8_local0
				if not IsPrestigeLevelAtZero(f1_arg0) then
					f8_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "isEchelonUnlock")
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
	})
	CharacterSelectionPrestigeInfo:linkToElementModel(CharacterSelectionPrestigeInfo, "isEchelonUnlock", true, function(model)
		f1_local1:updateElementState(CharacterSelectionPrestigeInfo, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "isEchelonUnlock",
		})
	end)
	CharacterSelectionPrestigeInfo:linkToElementModel(self, nil, false, function(model)
		CharacterSelectionPrestigeInfo:setModel(model, f1_arg0)
	end)
	self:addElement(CharacterSelectionPrestigeInfo)
	self.CharacterSelectionPrestigeInfo = CharacterSelectionPrestigeInfo
	self:registerEventHandler("occlusion_change", function(self, event)
		local f11_local0 = nil
		if self.OcclusionChange then
			f11_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f11_local0 = self.super:OcclusionChange(event)
		end
		CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1.model)
		SendClientScriptMenuExpressionStateChangeNotify(f1_arg0, f1_local1, true, f1_arg1.model.characterIndex:get())
		if not f11_local0 then
			f11_local0 = self:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		UploadStats(self, f1_arg0)
		SaveLoadoutGeneric(f1_arg0)
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	BackingFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		BackingFrame.id = "BackingFrame"
	end
	options.id = "options"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = options
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.WZPersonalizeCharacterInspect.__resetProperties = function(f15_arg0)
	f15_arg0.options:completeAnimation()
	f15_arg0.options:setLeftRight(0.5, 0.5, -813, -420)
	f15_arg0.options:setTopBottom(0, 0, 222.5, 947.5)
end
CoD.WZPersonalizeCharacterInspect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.options:completeAnimation()
			f17_arg0.options:setLeftRight(0.5, 0.5, -813, -420)
			f17_arg0.options:setTopBottom(0.5, 0.5, -317.5, 407.5)
			f17_arg0.clipFinished(f17_arg0.options)
		end,
	},
}
CoD.WZPersonalizeCharacterInspect.__onClose = function(f18_arg0)
	f18_arg0.XCamMouseControl:close()
	f18_arg0.BackingFrame:close()
	f18_arg0.options:close()
	f18_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
	f18_arg0.SpecialistName:close()
	f18_arg0.CharacterSelectionPrestigeInfo:close()
end

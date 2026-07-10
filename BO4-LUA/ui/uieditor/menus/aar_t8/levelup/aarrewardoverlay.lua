require("x64:2caedcdba8e68d0")
require("x64:ce1e6b6549d478c")
CoD.AARRewardOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.AARRewardOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AARRewardOverlay", f1_arg0)
	local f1_local1 = self
	SetControllerModelValue(f1_arg0, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_REWARDS)
	self:setClass(CoD.AARRewardOverlay)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0.85, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local RewardsTab = CoD.AARRewardsTab.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	RewardsTab:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local ZMRewardsTitle = RewardsTab
	local RewardsTitle = RewardsTab.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg0)
	RewardsTitle(ZMRewardsTitle, f1_local8["AAR.activeTab"], function(f4_arg0)
		f1_local1:updateElementState(RewardsTab, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	ZMRewardsTitle = RewardsTab
	RewardsTitle = RewardsTab.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	RewardsTitle(ZMRewardsTitle, f1_local8["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_local1:updateElementState(RewardsTab, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(RewardsTab)
	self.RewardsTab = RewardsTab
	RewardsTitle = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 26, 77)
	RewardsTitle:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
	RewardsTitle:setText(Engine[0xF9F1239CFD921FE](0x897061E92EE5BFC))
	RewardsTitle:setTTF("ttmussels_regular")
	RewardsTitle:setLetterSpacing(14)
	RewardsTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RewardsTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(RewardsTitle)
	self.RewardsTitle = RewardsTitle
	ZMRewardsTitle = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 26, 77)
	ZMRewardsTitle:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
	ZMRewardsTitle:setAlpha(0)
	ZMRewardsTitle:setText(Engine[0xF9F1239CFD921FE](0x897061E92EE5BFC))
	ZMRewardsTitle:setTTF("skorzhen")
	ZMRewardsTitle:setLetterSpacing(14)
	ZMRewardsTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ZMRewardsTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(ZMRewardsTitle)
	self.ZMRewardsTitle = ZMRewardsTitle
	self:mergeStateConditions({
		{
			stateName = "IsZM",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local9 = self
	f1_local8 = self.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local9, f1_local10["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f8_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local9, f1_local10.LastInput, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsPC() then
			CoD.AARUtility.InitRewardsPaging(controller)
			GoBack(self, controller)
			return true
		elseif IsPC() and IsGamepad(controller) then
			CoD.AARUtility.InitRewardsPaging(controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, nil)
			return true
		elseif IsPC() and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.InitRewardsPaging(controller)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.AARUtility.InitRewardsPaging(controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.InitRewardsPaging(controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self.__on_menuOpened_self = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
		local f18_local0 = self
		if IsPC() then
			CoD.PCUtility.SetupDismissTimerRewardsAAR(f18_local0, f18_arg1, f18_arg2)
		end
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetControllerModelValue(f1_arg0, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	RewardsTab.id = "RewardsTab"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = RewardsTab
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.AARRewardOverlay.__resetProperties = function(f21_arg0)
	f21_arg0.RewardsTitle:completeAnimation()
	f21_arg0.RewardsTab:completeAnimation()
	f21_arg0.ZMRewardsTitle:completeAnimation()
	f21_arg0.RewardsTitle:setAlpha(1)
	f21_arg0.RewardsTab:setAlpha(1)
	f21_arg0.ZMRewardsTitle:setAlpha(0)
end
CoD.AARRewardOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.RewardsTab:beginAnimation(200)
				f22_arg0.RewardsTab:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.RewardsTab:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.RewardsTab:completeAnimation()
			f22_arg0.RewardsTab:setAlpha(0)
			f22_local0(f22_arg0.RewardsTab)
			local f22_local1 = function(f25_arg0)
				f22_arg0.RewardsTitle:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f22_arg0.RewardsTitle:setAlpha(1)
				f22_arg0.RewardsTitle:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.RewardsTitle:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.RewardsTitle:completeAnimation()
			f22_arg0.RewardsTitle:setAlpha(0)
			f22_local1(f22_arg0.RewardsTitle)
			f22_arg0.ZMRewardsTitle:completeAnimation()
			f22_arg0.ZMRewardsTitle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ZMRewardsTitle)
		end,
	},
	IsZM = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f28_arg0:setAlpha(1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.RewardsTab:beginAnimation(200)
				f26_arg0.RewardsTab:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.RewardsTab:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.RewardsTab:completeAnimation()
			f26_arg0.RewardsTab:setAlpha(0)
			f26_local0(f26_arg0.RewardsTab)
			f26_arg0.RewardsTitle:completeAnimation()
			f26_arg0.RewardsTitle:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.RewardsTitle)
			local f26_local1 = function(f29_arg0)
				f26_arg0.ZMRewardsTitle:beginAnimation(150)
				f26_arg0.ZMRewardsTitle:setAlpha(1)
				f26_arg0.ZMRewardsTitle:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ZMRewardsTitle:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ZMRewardsTitle:completeAnimation()
			f26_arg0.ZMRewardsTitle:setAlpha(0)
			f26_local1(f26_arg0.ZMRewardsTitle)
		end,
	},
}
CoD.AARRewardOverlay.__onClose = function(f30_arg0)
	f30_arg0.__on_close_removeOverrides()
	f30_arg0.FooterContainerFrontendRight:close()
	f30_arg0.RewardsTab:close()
end

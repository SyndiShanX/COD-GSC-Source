require("x64:eda152e1d10147a")
require("x64:f792a7ef58d5981")
require("x64:a49999b54fd0d2b")
require("x64:7895a9e2a5208f5")
require("x64:8904074a6536944")
require("x64:75e2a524b093c12")
CoD.ReticleSelect = InheritFrom(CoD.Menu)
LUI.createMenu.ReticleSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ReticleSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SetControllerModelValue(f1_arg0, "WeaponPersonalization.listUpdate", 0)
	SetControllerModelValue(f1_arg0, "WeaponPersonalization.reticleListUpdate", 0)
	CoD.WeaponOptionsUtility.InitPaintCansCountModel(f1_arg0)
	self:setClass(CoD.ReticleSelect)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 63, 663)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local BackgroundSlidePanel = CoD.cac_background_slide_panel.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 670, 1292)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local ReticleGroupContainer = CoD.ReticleGroupContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 670, 1020)
	self:addElement(ReticleGroupContainer)
	self.ReticleGroupContainer = ReticleGroupContainer
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x47C91925D0A93E6))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local WeaponOptionInfo = CoD.WeaponOptionInfo.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 463, 607)
	self:addElement(WeaponOptionInfo)
	self.WeaponOptionInfo = WeaponOptionInfo
	local ReticleCategoryTabs = CoD.ReticleCategoryTabs.new(f1_local1, f1_arg0, 0.5, 0.5, -560, 560, 0, 0, 51, 86)
	self:addElement(ReticleCategoryTabs)
	self.ReticleCategoryTabs = ReticleCategoryTabs
	WeaponOptionInfo:linkToElementModel(ReticleGroupContainer.ReticlesList, nil, false, function(model)
		WeaponOptionInfo:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
		DelayGoBack(menu, controller, 200)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x78D439E1B360368, nil, nil)
		return true
	end, false)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	ReticleGroupContainer.id = "ReticleGroupContainer"
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	ReticleCategoryTabs.id = "ReticleCategoryTabs"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ReticleGroupContainer
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local8 = self
	CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	CoD.WeaponOptionsUtility.ResetWeaponOptions(f1_local1, f1_arg0)
	f1_local8 = ReticleCategoryTabs
	SizeToSafeArea(f1_local8, f1_arg0)
	DisableKeyboardNavigationByElement(f1_local8)
	return self
end
CoD.ReticleSelect.__resetProperties = function(f6_arg0)
	f6_arg0.ReticleGroupContainer:completeAnimation()
	f6_arg0.BackgroundSlidePanel:completeAnimation()
	f6_arg0.ReticleGroupContainer:setTopBottom(0, 0, 670, 1020)
	f6_arg0.ReticleGroupContainer:setAlpha(1)
	f6_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 670, 1292)
	f6_arg0.BackgroundSlidePanel:setAlpha(1)
end
CoD.ReticleSelect.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.BackgroundSlidePanel:completeAnimation()
			f7_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1230, 1852)
			f7_arg0.BackgroundSlidePanel:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BackgroundSlidePanel)
			f7_arg0.ReticleGroupContainer:completeAnimation()
			f7_arg0.ReticleGroupContainer:setTopBottom(0, 0, 1230, 1580)
			f7_arg0.ReticleGroupContainer:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ReticleGroupContainer)
		end,
		Open = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(100)
					f10_arg0:setTopBottom(0, 0, 670, 1292)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.BackgroundSlidePanel:beginAnimation(100)
				f8_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 950, 1572)
				f8_arg0.BackgroundSlidePanel:setAlpha(1)
				f8_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.BackgroundSlidePanel:completeAnimation()
			f8_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1230, 1852)
			f8_arg0.BackgroundSlidePanel:setAlpha(0)
			f8_local0(f8_arg0.BackgroundSlidePanel)
			local f8_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(100)
					f12_arg0:setTopBottom(0, 0, 670, 1020)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.ReticleGroupContainer:beginAnimation(100)
				f8_arg0.ReticleGroupContainer:setTopBottom(0, 0, 950, 1300)
				f8_arg0.ReticleGroupContainer:setAlpha(1)
				f8_arg0.ReticleGroupContainer:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ReticleGroupContainer:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f8_arg0.ReticleGroupContainer:completeAnimation()
			f8_arg0.ReticleGroupContainer:setTopBottom(0, 0, 1230, 1580)
			f8_arg0.ReticleGroupContainer:setAlpha(0)
			f8_local1(f8_arg0.ReticleGroupContainer)
		end,
		Close = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(100)
					f15_arg0:setTopBottom(0, 0, 1230, 1852)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.BackgroundSlidePanel:beginAnimation(100)
				f13_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 950, 1572)
				f13_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.BackgroundSlidePanel:completeAnimation()
			f13_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 670, 1292)
			f13_arg0.BackgroundSlidePanel:setAlpha(1)
			f13_local0(f13_arg0.BackgroundSlidePanel)
			local f13_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(100)
					f17_arg0:setTopBottom(0, 0, 1230, 1580)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.ReticleGroupContainer:beginAnimation(100)
				f13_arg0.ReticleGroupContainer:setTopBottom(0, 0, 950, 1300)
				f13_arg0.ReticleGroupContainer:setAlpha(0)
				f13_arg0.ReticleGroupContainer:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ReticleGroupContainer:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f13_arg0.ReticleGroupContainer:completeAnimation()
			f13_arg0.ReticleGroupContainer:setTopBottom(0, 0, 670, 1020)
			f13_arg0.ReticleGroupContainer:setAlpha(1)
			f13_local1(f13_arg0.ReticleGroupContainer)
		end,
	},
}
CoD.ReticleSelect.__onClose = function(f18_arg0)
	f18_arg0.WeaponOptionInfo:close()
	f18_arg0.XCamMouseControl:close()
	f18_arg0.BackgroundSlidePanel:close()
	f18_arg0.ReticleGroupContainer:close()
	f18_arg0.GenericMenuFrame:close()
	f18_arg0.ReticleCategoryTabs:close()
end

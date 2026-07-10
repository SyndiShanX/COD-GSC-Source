require("x64:2bf789c3c32d132")
require("x64:1a70a3d7e2725e9")
require("x64:ce1e6b6549d478c")
require("x64:4fef7f34e3f5ca0")
require("x64:c7e896ee4bc3f8")
CoD.AARMeritReportOverlay = InheritFrom(CoD.Menu)
LUI.createMenu.AARMeritReportOverlay = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AARMeritReportOverlay", f1_arg0)
	local f1_local1 = self
	CoD.AARUtility.SetupMeritRewardModels(f1_local1, f1_arg0, false)
	self:setClass(CoD.AARMeritReportOverlay)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0.5, 2.5, -2400, -2400, 0.5, 1.5, -540, -540)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local FractalGrid = LUI.UIImage.new(0.5, 0.5, -960, 960, 0, 1, 0, 0)
	FractalGrid:setAlpha(0)
	FractalGrid:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_fractalgrid"))
	FractalGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	FractalGrid:setShaderVector(0, 1, 1, 0, 0)
	FractalGrid:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(FractalGrid)
	self.FractalGrid = FractalGrid
	local BgElements = CoD.AARLevelUpOverlay_LevelUpBg.new(f1_local1, f1_arg0, 0.5, 0.5, -835, 835, 0.5, 0.5, -335, 451)
	self:addElement(BgElements)
	self.BgElements = BgElements
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
	local MeritReport = CoD.MeritReportWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	MeritReport:mergeStateConditions({
		{
			stateName = "ContractsEnabledTabs",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	MeritReport:subscribeToGlobalModel(f1_arg0, "AARMeritReport", nil, function(model)
		MeritReport:setModel(model, f1_arg0)
	end)
	self:addElement(MeritReport)
	self.MeritReport = MeritReport
	local MeritReportLabel = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 53, 104)
	MeritReportLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	MeritReportLabel:setAlpha(0)
	MeritReportLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29C7C549DBCFDA00"))
	MeritReportLabel:setTTF("ttmussels_regular")
	MeritReportLabel:setLetterSpacing(14)
	MeritReportLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MeritReportLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MeritReportLabel)
	self.MeritReportLabel = MeritReportLabel
	local DoubleXPIcon = CoD.DoubleXPIcon.new(f1_local1, f1_arg0, 0.5, 0.5, 605, 677, 0.5, 0.5, 348, 420)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	local TrialInfoBannerWidget = CoD.TrialInfoBannerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -352.5, 418.5, 0.5, 0.5, 11, 46)
	TrialInfoBannerWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownLarge",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysTrue()
			end,
		},
	})
	TrialInfoBannerWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x28C4CE674D04F7))
	self:addElement(TrialInfoBannerWidget)
	self.TrialInfoBannerWidget = TrialInfoBannerWidget
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local12(f1_local11, f1_local13.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsPC() then
			CoD.AARUtility.CloseMeritReportOverlay(menu, controller)
			return true
		elseif IsPC() and IsGamepad(controller) then
			CoD.AARUtility.CloseMeritReportOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, nil)
			return true
		elseif IsPC() and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.CloseMeritReportOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		CoD.AARUtility.CloseMeritReportOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.CloseMeritReportOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local12 = self
	CoD.AARUtility.AnimateMeritReportNumbers(f1_local1, f1_arg0)
	return self
end
CoD.AARMeritReportOverlay.__resetProperties = function(f17_arg0)
	f17_arg0.FractalGrid:completeAnimation()
	f17_arg0.BgElements:completeAnimation()
	f17_arg0.MeritReport:completeAnimation()
	f17_arg0.FractalGrid:setAlpha(0)
	f17_arg0.BgElements:setAlpha(1)
	f17_arg0.MeritReport:setAlpha(1)
end
CoD.AARMeritReportOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.FractalGrid:completeAnimation()
			f18_arg0.FractalGrid:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.FractalGrid)
			local f18_local0 = function(f19_arg0)
				f19_arg0:beginAnimation(100)
				f19_arg0:setAlpha(1)
				f19_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.BgElements:beginAnimation(100)
			f18_arg0.BgElements:setAlpha(0)
			f18_arg0.BgElements:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
			f18_arg0.BgElements:registerEventHandler("transition_complete_keyframe", f18_local0)
			local f18_local1 = function(f20_arg0)
				f20_arg0:beginAnimation(150)
				f20_arg0:setAlpha(1)
				f20_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.MeritReport:beginAnimation(250)
			f18_arg0.MeritReport:setAlpha(0)
			f18_arg0.MeritReport:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
			f18_arg0.MeritReport:registerEventHandler("transition_complete_keyframe", f18_local1)
		end,
	},
}
CoD.AARMeritReportOverlay.__onClose = function(f21_arg0)
	f21_arg0.BgElements:close()
	f21_arg0.FooterContainerFrontendRight:close()
	f21_arg0.MeritReport:close()
	f21_arg0.DoubleXPIcon:close()
	f21_arg0.TrialInfoBannerWidget:close()
end

require("x64:1e4812bc9d39ec5")
require("x64:aad8c6cb8c21870")
require("x64:ce1e6b6549d478c")
require("x64:c829ac7d797ba4c")
CoD.AAR_LeaguePlay_PlacementMatchesProgress = InheritFrom(CoD.Menu)
LUI.createMenu.AAR_LeaguePlay_PlacementMatchesProgress = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AAR_LeaguePlay_PlacementMatchesProgress", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.AAR_LeaguePlay_PlacementMatchesProgress)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(-0.5, 1.5, 0, 0, 0.5, 1.5, -540, -540)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.8)
	self:addElement(Backing)
	self.Backing = Backing
	local arenaLeaguePlayBg = CoD.arenaLeaguePlayBg.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(arenaLeaguePlayBg)
	self.arenaLeaguePlayBg = arenaLeaguePlayBg
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
	local MainCornerL = LUI.UIImage.new(0.5, 0.5, -759, -729, 0.5, 0.5, -394, -364)
	MainCornerL:setAlpha(0.04)
	MainCornerL:setYRot(180)
	MainCornerL:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_topright"))
	self:addElement(MainCornerL)
	self.MainCornerL = MainCornerL
	local MainCornerR = LUI.UIImage.new(0.5, 0.5, 737, 767, 0.5, 0.5, -395, -365)
	MainCornerR:setAlpha(0.04)
	MainCornerR:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_topright"))
	self:addElement(MainCornerR)
	self.MainCornerR = MainCornerR
	local ArenaSkillEvaluationWidget = CoD.ArenaSkillEvaluationWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -480, 480, 0.5, 0.5, -351.5, 388.5)
	self:addElement(ArenaSkillEvaluationWidget)
	self.ArenaSkillEvaluationWidget = ArenaSkillEvaluationWidget
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, 403, 589, 0.5, 0.5, 340, 400)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_778D439E1B360368"))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.ClosePlacementMatchesProgressOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.ClosePlacementMatchesProgressOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "ui_confirm")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.ClosePlacementMatchesProgressOverlay(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	ArenaSkillEvaluationWidget.id = "ArenaSkillEvaluationWidget"
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.AAR_LeaguePlay_PlacementMatchesProgress.__resetProperties = function(f10_arg0)
	f10_arg0.ArenaSkillEvaluationWidget:completeAnimation()
	f10_arg0.arenaLeaguePlayBg:completeAnimation()
	f10_arg0.ArenaSkillEvaluationWidget:setAlpha(1)
	f10_arg0.arenaLeaguePlayBg:setAlpha(1)
end
CoD.AAR_LeaguePlay_PlacementMatchesProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(200)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.arenaLeaguePlayBg:beginAnimation(100)
				f11_arg0.arenaLeaguePlayBg:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.arenaLeaguePlayBg:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.arenaLeaguePlayBg:completeAnimation()
			f11_arg0.arenaLeaguePlayBg:setAlpha(0)
			f11_local0(f11_arg0.arenaLeaguePlayBg)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(199)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.ArenaSkillEvaluationWidget:beginAnimation(300)
				f11_arg0.ArenaSkillEvaluationWidget:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ArenaSkillEvaluationWidget:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.ArenaSkillEvaluationWidget:completeAnimation()
			f11_arg0.ArenaSkillEvaluationWidget:setAlpha(0)
			f11_local1(f11_arg0.ArenaSkillEvaluationWidget)
		end,
	},
}
CoD.AAR_LeaguePlay_PlacementMatchesProgress.__onClose = function(f16_arg0)
	f16_arg0.arenaLeaguePlayBg:close()
	f16_arg0.FooterContainerFrontendRight:close()
	f16_arg0.ArenaSkillEvaluationWidget:close()
	f16_arg0.featureOverlayButtonMouseOnly:close()
end

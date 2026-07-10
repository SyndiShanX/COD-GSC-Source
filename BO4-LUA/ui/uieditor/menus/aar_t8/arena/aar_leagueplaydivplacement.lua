require("x64:2bf789c3c32d132")
require("x64:945c1007275eb71")
require("x64:8d25a159c5da22e")
require("x64:e9502b110907a96")
require("x64:ce1e6b6549d478c")
CoD.AAR_LeaguePlayDivPlacement = InheritFrom(CoD.Menu)
LUI.createMenu.AAR_LeaguePlayDivPlacement = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AAR_LeaguePlayDivPlacement", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.AAR_LeaguePlayDivPlacement)
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
	self:addElement(Backing)
	self.Backing = Backing
	local FractalGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FractalGrid:setAlpha(0)
	FractalGrid:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_fractalgrid"))
	FractalGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	FractalGrid:setShaderVector(0, 1, 1, 0, 0)
	FractalGrid:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(FractalGrid)
	self.FractalGrid = FractalGrid
	local PlacementMessage = CoD.CompetitiveAARDivisionRankAwardcontainer.new(f1_local1, f1_arg0, 0.5, 0.5, -300, 300, 0.5, 0.5, 100, 351)
	self:addElement(PlacementMessage)
	self.PlacementMessage = PlacementMessage
	local BgElements = CoD.AARLevelUpOverlay_LevelUpBg.new(f1_local1, f1_arg0, 0.5, 0.5, -832, 832, 0.38, 0.38, -391, 571)
	self:addElement(BgElements)
	self.BgElements = BgElements
	local ladderpoint3 = LUI.UIText.new(0.5, 0.5, -350, 350, 0.5, 0.5, -38.5, -17.5)
	ladderpoint3:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F3C06F0168BAFE4"))
	ladderpoint3:setTTF("ttmussels_regular")
	ladderpoint3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	ladderpoint3:setLetterSpacing(2)
	ladderpoint3:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ladderpoint3:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ladderpoint3)
	self.ladderpoint3 = ladderpoint3
	local ArenaDivisionUpTittleInternal = CoD.ArenaDivisionUpTittleInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -199.5, 200.5, 0.5, 0.5, -487.5, -434.5)
	self:addElement(ArenaDivisionUpTittleInternal)
	self.ArenaDivisionUpTittleInternal = ArenaDivisionUpTittleInternal
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
	local ArenaDivisionPlacementBonusInternal = CoD.ArenaDivisionPlacementBonusInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -350, 350, 0.5, 0.5, -420, -70)
	self:addElement(ArenaDivisionPlacementBonusInternal)
	self.ArenaDivisionPlacementBonusInternal = ArenaDivisionPlacementBonusInternal
	local infoBracketBot = LUI.UIImage.new(0.5, 0.5, -325, 325, 0.5, 0.5, 61, 69)
	infoBracketBot:setRGB(0.98, 1, 0.89)
	infoBracketBot:setAlpha(0.35)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local MainCornerL = LUI.UIImage.new(0.5, 0.5, -759, -729, 0, 0, 146, 176)
	MainCornerL:setAlpha(0.04)
	MainCornerL:setYRot(180)
	MainCornerL:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_topright"))
	self:addElement(MainCornerL)
	self.MainCornerL = MainCornerL
	local MainCornerR = LUI.UIImage.new(0.5, 0.5, 737, 767, 0, 0, 145, 175)
	MainCornerR:setAlpha(0.04)
	MainCornerR:setImage(RegisterImage(@"uie_ui_hud_notifications_bracket_topright"))
	self:addElement(MainCornerR)
	self.MainCornerR = MainCornerR
	local Sound = LUI.UIElement.new(0, 0, 452.5, 484.5, 0, 0, -35.5, -3.5)
	Sound:setPlaySoundDirect(true)
	self:addElement(Sound)
	self.Sound = Sound
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.CloseArenaLeaguePlayPlacementOverlay(menu, controller)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "ui_confirm")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			CoD.AARUtility.CloseArenaLeaguePlayPlacementOverlay(menu, controller)
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
	self.__on_menuOpened_self = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		local f7_local0 = self
		PlaySoundAlias("uin_wl_division_place")
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	PlacementMessage.id = "PlacementMessage"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local15 = self
	CoD.ArenaLeaguePlayUtility.PopulateLeaguePlayDatasources(f1_arg0)
	return self
end
CoD.AAR_LeaguePlayDivPlacement.__resetProperties = function(f9_arg0)
	f9_arg0.Backing:completeAnimation()
	f9_arg0.FractalGrid:completeAnimation()
	f9_arg0.BgElements:completeAnimation()
	f9_arg0.MainCornerR:completeAnimation()
	f9_arg0.MainCornerL:completeAnimation()
	f9_arg0.ArenaDivisionUpTittleInternal:completeAnimation()
	f9_arg0.ArenaDivisionPlacementBonusInternal:completeAnimation()
	f9_arg0.Sound:completeAnimation()
	f9_arg0.PlacementMessage:completeAnimation()
	f9_arg0.infoBracketBot:completeAnimation()
	f9_arg0.ladderpoint3:completeAnimation()
	f9_arg0.Backing:setAlpha(1)
	f9_arg0.FractalGrid:setAlpha(0)
	f9_arg0.BgElements:setAlpha(1)
	f9_arg0.MainCornerR:setAlpha(0.04)
	f9_arg0.MainCornerL:setAlpha(0.04)
	f9_arg0.ArenaDivisionUpTittleInternal:setAlpha(1)
	f9_arg0.ArenaDivisionPlacementBonusInternal:setAlpha(1)
	f9_arg0.PlacementMessage:setAlpha(1)
	f9_arg0.infoBracketBot:setAlpha(0.35)
	f9_arg0.ladderpoint3:setAlpha(1)
end
CoD.AAR_LeaguePlayDivPlacement.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(11)
			local f10_local0 = function(f11_arg0)
				f10_arg0.Backing:beginAnimation(100)
				f10_arg0.Backing:setAlpha(0.9)
				f10_arg0.Backing:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Backing:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setAlpha(0)
			f10_local0(f10_arg0.Backing)
			f10_arg0.FractalGrid:completeAnimation()
			f10_arg0.FractalGrid:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FractalGrid)
			local f10_local1 = function(f12_arg0)
				f12_arg0:beginAnimation(100)
				f12_arg0:setAlpha(1)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.PlacementMessage:beginAnimation(210)
			f10_arg0.PlacementMessage:setAlpha(0)
			f10_arg0.PlacementMessage:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.PlacementMessage:registerEventHandler("transition_complete_keyframe", f10_local1)
			local f10_local2 = function(f13_arg0)
				f10_arg0.BgElements:beginAnimation(100)
				f10_arg0.BgElements:setAlpha(1)
				f10_arg0.BgElements:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BgElements:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.BgElements:completeAnimation()
			f10_arg0.BgElements:setAlpha(0)
			f10_local2(f10_arg0.BgElements)
			local f10_local3 = function(f14_arg0)
				f14_arg0:beginAnimation(100)
				f14_arg0:setAlpha(1)
				f14_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ladderpoint3:beginAnimation(210)
			f10_arg0.ladderpoint3:setAlpha(0)
			f10_arg0.ladderpoint3:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.ladderpoint3:registerEventHandler("transition_complete_keyframe", f10_local3)
			local f10_local4 = function(f15_arg0)
				f15_arg0:beginAnimation(99)
				f15_arg0:setAlpha(1)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ArenaDivisionUpTittleInternal:beginAnimation(110)
			f10_arg0.ArenaDivisionUpTittleInternal:setAlpha(0)
			f10_arg0.ArenaDivisionUpTittleInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.ArenaDivisionUpTittleInternal:registerEventHandler("transition_complete_keyframe", f10_local4)
			local f10_local5 = function(f16_arg0)
				f16_arg0:beginAnimation(99)
				f16_arg0:setAlpha(1)
				f16_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ArenaDivisionPlacementBonusInternal:beginAnimation(160)
			f10_arg0.ArenaDivisionPlacementBonusInternal:setAlpha(0)
			f10_arg0.ArenaDivisionPlacementBonusInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.ArenaDivisionPlacementBonusInternal:registerEventHandler("transition_complete_keyframe", f10_local5)
			local f10_local6 = function(f17_arg0)
				f17_arg0:beginAnimation(100)
				f17_arg0:setAlpha(0.45)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.infoBracketBot:beginAnimation(210)
			f10_arg0.infoBracketBot:setAlpha(0)
			f10_arg0.infoBracketBot:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.infoBracketBot:registerEventHandler("transition_complete_keyframe", f10_local6)
			local f10_local7 = function(f18_arg0)
				f18_arg0:beginAnimation(99)
				f18_arg0:setAlpha(0.04)
				f18_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.MainCornerL:beginAnimation(60)
			f10_arg0.MainCornerL:setAlpha(0)
			f10_arg0.MainCornerL:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.MainCornerL:registerEventHandler("transition_complete_keyframe", f10_local7)
			local f10_local8 = function(f19_arg0)
				f19_arg0:beginAnimation(99)
				f19_arg0:setAlpha(0.04)
				f19_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.MainCornerR:beginAnimation(60)
			f10_arg0.MainCornerR:setAlpha(0)
			f10_arg0.MainCornerR:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.MainCornerR:registerEventHandler("transition_complete_keyframe", f10_local8)
			f10_arg0.Sound:beginAnimation(160)
			f10_arg0.Sound:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_wlh_ladder_points", f10_arg1)
				f10_arg0.clipFinished(element, event)
			end)
		end,
	},
}
CoD.AAR_LeaguePlayDivPlacement.__onClose = function(f21_arg0)
	f21_arg0.__on_close_removeOverrides()
	f21_arg0.PlacementMessage:close()
	f21_arg0.BgElements:close()
	f21_arg0.ArenaDivisionUpTittleInternal:close()
	f21_arg0.FooterContainerFrontendRight:close()
	f21_arg0.ArenaDivisionPlacementBonusInternal:close()
end

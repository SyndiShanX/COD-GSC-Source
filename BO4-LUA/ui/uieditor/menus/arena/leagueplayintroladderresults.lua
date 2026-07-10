require("x64:fd865cf485e3dcc")
require("x64:3bb17357d3298bf")
require("x64:b2fcc92c4342e54")
require("x64:ce1e6b6549d478c")
require("x64:2cf4ad39ea2c548")
require("x64:f027dcc6409e42c")
CoD.LeaguePlayIntroLadderResults = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlayIntroLadderResults = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlayIntroLadderResults", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LeaguePlayIntroLadderResults)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ItemShopBackgroundBlur = CoD.ItemShopBackgroundBlur.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ItemShopBackgroundBlur)
	self.ItemShopBackgroundBlur = ItemShopBackgroundBlur
	local Background = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -348.5, 176.5)
	Background:setImage(RegisterImage(@"ui_menu_ftue_wl_welcome"))
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Background:setShaderVector(0, 0, 0, 0, 0)
	Background:setShaderVector(1, 1, 1, 0, 0)
	Background:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BGDotPatternTop = LUI.UIImage.new(0.5, 0.5, -960, 959, 0.5, 0.5, -407.5, -348.5)
	BGDotPatternTop:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BGDotPatternTop:setAlpha(0.05)
	BGDotPatternTop:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	BGDotPatternTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BGDotPatternTop:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternTop:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternTop)
	self.BGDotPatternTop = BGDotPatternTop
	local Title = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, -405, -345)
	Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Title:setText(LocalizeToUpperString(@"hash_3A833716CBB8F05A"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(5)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0.5, 0.5, -960.5, 959.5, 0.5, 0.5, 205.5, 230.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setAlpha(0.5)
	Description:setText(LocalizeToUpperString(0x1FA6FF98309472))
	Description:setTTF("ttmussels_regular")
	Description:setLetterSpacing(4)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Description)
	self.Description = Description
	local CurrentSkillPlacementGlow = LUI.UIText.new(0.5, 0.5, -960.5, 959.5, 0.5, 0.5, 257.5, 305.5)
	CurrentSkillPlacementGlow:setRGB(0.83, 0.52, 0.85)
	CurrentSkillPlacementGlow:setAlpha(0)
	CurrentSkillPlacementGlow:setTTF("ttmussels_demibold")
	CurrentSkillPlacementGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	CurrentSkillPlacementGlow:setShaderVector(0, 0.47, 0, 0, 0)
	CurrentSkillPlacementGlow:setShaderVector(1, 0.05, 0, 0, 0)
	CurrentSkillPlacementGlow:setShaderVector(2, 1.36, 0.42, 1, 0.35)
	CurrentSkillPlacementGlow:setLetterSpacing(8)
	CurrentSkillPlacementGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CurrentSkillPlacementGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CurrentSkillPlacementGlow:subscribeToGlobalModel(f1_arg0, "LeaguePlay", "leaguePlaySkillDivisionName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentSkillPlacementGlow:setText(LocalizeToUpperString(LocalizeIntoString(@"hash_17DF5AC7BE07BAF5", f2_local0)))
		end
	end)
	self:addElement(CurrentSkillPlacementGlow)
	self.CurrentSkillPlacementGlow = CurrentSkillPlacementGlow
	local CurrentSkillPlacementStroke = LUI.UIText.new(0.5, 0.5, -960.5, 959.5, 0.5, 0.5, 257.5, 305.5)
	CurrentSkillPlacementStroke:setRGB(0.98, 0.73, 1)
	CurrentSkillPlacementStroke:setAlpha(0)
	CurrentSkillPlacementStroke:setTTF("ttmussels_demibold")
	CurrentSkillPlacementStroke:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	CurrentSkillPlacementStroke:setShaderVector(0, 0.1, 0, 0, 0)
	CurrentSkillPlacementStroke:setShaderVector(1, 1, 0.5, 1.29, 0.25)
	CurrentSkillPlacementStroke:setLetterSpacing(8)
	CurrentSkillPlacementStroke:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CurrentSkillPlacementStroke:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CurrentSkillPlacementStroke:subscribeToGlobalModel(f1_arg0, "LeaguePlay", "leaguePlaySkillDivisionName", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CurrentSkillPlacementStroke:setText(LocalizeToUpperString(LocalizeIntoString(@"hash_17DF5AC7BE07BAF5", f3_local0)))
		end
	end)
	self:addElement(CurrentSkillPlacementStroke)
	self.CurrentSkillPlacementStroke = CurrentSkillPlacementStroke
	local CurrentSkillPlacement = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, 257.5, 305.5)
	CurrentSkillPlacement:setRGB(0.49, 0.15, 0.52)
	CurrentSkillPlacement:setAlpha(0)
	CurrentSkillPlacement:setTTF("ttmussels_demibold")
	CurrentSkillPlacement:setLetterSpacing(8)
	CurrentSkillPlacement:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CurrentSkillPlacement:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CurrentSkillPlacement:subscribeToGlobalModel(f1_arg0, "LeaguePlay", "leaguePlaySkillDivisionName", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CurrentSkillPlacement:setText(LocalizeToUpperString(LocalizeIntoString(@"hash_17DF5AC7BE07BAF5", f4_local0)))
		end
	end)
	self:addElement(CurrentSkillPlacement)
	self.CurrentSkillPlacement = CurrentSkillPlacement
	local CenterGradient = LUI.UIImage.new(0.5, 0.5, -267, 267, 0.5, 0.5, -348.5, 176.5)
	CenterGradient:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CenterGradient:setAlpha(0.06)
	CenterGradient:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	CenterGradient:setShaderVector(0, 0.06, 0.94, 0, 0)
	CenterGradient:setShaderVector(1, 0.24, 0.27, 0, 0)
	CenterGradient:setShaderVector(2, 0.23, 1, 0, 0)
	CenterGradient:setShaderVector(3, 0.53, 0, 0, 0)
	CenterGradient:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(CenterGradient)
	self.CenterGradient = CenterGradient
	local Subdivision = LUI.UIText.new(0.5, 0.5, -960.5, 959.5, 0.5, 0.5, 310.5, 331.5)
	Subdivision:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Subdivision:setAlpha(0.5)
	Subdivision:setTTF("default")
	Subdivision:setLetterSpacing(4)
	Subdivision:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Subdivision:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Subdivision:subscribeToGlobalModel(f1_arg0, "LeaguePlayLadder", "leagueNameCode", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Subdivision:setText(LocalizeToUpperString(LocalizeIntoString(@"hash_6FB7575B725F90E9", CoD.ArenaLeaguePlayUtility.ConvertLadderNameCode(f5_local0))))
		end
	end)
	self:addElement(Subdivision)
	self.Subdivision = Subdivision
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local Timer = LUI.UIText.new(0.5, 0.5, -960.5, 959.5, 0.5, 0.5, 362, 383)
	Timer:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	Timer:setTTF("ttmussels_regular")
	Timer:setLetterSpacing(4)
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Timer:subscribeToGlobalModel(f1_arg0, "Arena", "arenaEventTimer", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Timer:setText(LocalizeToUpperString(LocalizeIntoString(@"hash_2B0802AD78CE7749", f7_local0)))
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	local GradientEffectLeft = LUI.UIImage.new(0.5, 0.5, -960.5, -0.5, 0.5, 0.5, -348.5, 176.5)
	GradientEffectLeft:setRGB(0, 0, 0)
	GradientEffectLeft:setAlpha(0.98)
	GradientEffectLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	GradientEffectLeft:setShaderVector(0, 1, 0, 0, 0)
	GradientEffectLeft:setShaderVector(1, 0.48, 0, 0, 0)
	GradientEffectLeft:setShaderVector(2, 1, 0, 0, 0)
	GradientEffectLeft:setShaderVector(3, 0, 0, 0, 0)
	GradientEffectLeft:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(GradientEffectLeft)
	self.GradientEffectLeft = GradientEffectLeft
	local GradientEffectRight = LUI.UIImage.new(0.5, 0.5, -1, 959, 0.5, 0.5, -348.5, 176.5)
	GradientEffectRight:setRGB(0, 0, 0)
	GradientEffectRight:setAlpha(0.98)
	GradientEffectRight:setYRot(180)
	GradientEffectRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	GradientEffectRight:setShaderVector(0, 1, 0, 0, 0)
	GradientEffectRight:setShaderVector(1, 0.49, 0, 0, 0)
	GradientEffectRight:setShaderVector(2, 1, 0, 0, 0)
	GradientEffectRight:setShaderVector(3, 0, 0, 0, 0)
	GradientEffectRight:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(GradientEffectRight)
	self.GradientEffectRight = GradientEffectRight
	local RubyLightRay = CoD.LeaguePlayIntrolLadderRubyLightRay.new(f1_local1, f1_arg0, 0.5, 0.5, -250, 250, 0.5, 0.5, -300, 300)
	RubyLightRay:setScale(1.4, 1.4)
	self:addElement(RubyLightRay)
	self.RubyLightRay = RubyLightRay
	local CurrentSkillBagde = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -100, 100)
	CurrentSkillBagde:subscribeToGlobalModel(f1_arg0, "LeaguePlay", "leaguePlaySkillDivisionGem", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CurrentSkillBagde:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(CurrentSkillBagde)
	self.CurrentSkillBagde = CurrentSkillBagde
	local LadderTitleText = CoD.LeaguePlayIntrolLadderTitleText.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, 257.5, 305.5)
	self:addElement(LadderTitleText)
	self.LadderTitleText = LadderTitleText
	local PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, 650, 890, 1, 1, -189, -109)
	PCButton.OptionText:setText(LocalizeToUpperString(@"menu/continue"))
	PCButton:linkToElementModel(self, "image", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			PCButton.Icon:setImage(RegisterImage(f9_local0))
		end
	end)
	PCButton:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f10_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBackAndOpenOverlayOnParent(self, "LeaguePlayLadderResults", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBackAndOpenOverlayOnParent(self, "LeaguePlayLadderResults", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/continue", nil, "ui_confirm")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			GoBackAndOpenOverlayOnParent(self, "LeaguePlayLadderResults", controller)
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
	if CoD.isPC then
		PCButton.id = "PCButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local20 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.LeaguePlayIntroLadderResults.__resetProperties = function(f17_arg0)
	f17_arg0.LadderTitleText:completeAnimation()
	f17_arg0.Title:completeAnimation()
	f17_arg0.CurrentSkillBagde:completeAnimation()
	f17_arg0.RubyLightRay:completeAnimation()
	f17_arg0.LadderTitleText:setAlpha(1)
	f17_arg0.LadderTitleText:setScale(1, 1)
	f17_arg0.Title:setAlpha(1)
	f17_arg0.Title:setScale(1, 1)
	f17_arg0.CurrentSkillBagde:setAlpha(1)
	f17_arg0.CurrentSkillBagde:setScale(1, 1)
	f17_arg0.RubyLightRay:setAlpha(1)
	f17_arg0.RubyLightRay:setScale(1.4, 1.4)
end
CoD.LeaguePlayIntroLadderResults.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						f22_arg0:beginAnimation(49)
						f22_arg0:setAlpha(1)
						f22_arg0:setScale(1, 1)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f21_arg0:beginAnimation(200)
					f21_arg0:setAlpha(0.8)
					f21_arg0:setScale(0.9, 0.9)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f19_arg0.Title:beginAnimation(1150)
				f19_arg0.Title:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Title:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.Title:completeAnimation()
			f19_arg0.Title:setAlpha(0)
			f19_arg0.Title:setScale(4, 4)
			f19_local0(f19_arg0.Title)
			local f19_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						f25_arg0:beginAnimation(50)
						f25_arg0:setAlpha(1)
						f25_arg0:setScale(1.5, 1.5)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f24_arg0:beginAnimation(250)
					f24_arg0:setAlpha(0.83)
					f24_arg0:setScale(1.65, 1.65)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f19_arg0.RubyLightRay:beginAnimation(1420)
				f19_arg0.RubyLightRay:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.RubyLightRay:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f19_arg0.RubyLightRay:completeAnimation()
			f19_arg0.RubyLightRay:setAlpha(0)
			f19_arg0.RubyLightRay:setScale(0, 0)
			f19_local1(f19_arg0.RubyLightRay)
			local f19_local2 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						local f28_local0 = function(f29_arg0)
							f29_arg0:beginAnimation(250)
							f29_arg0:setAlpha(1)
							f29_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
						end
						f28_arg0:beginAnimation(49)
						f28_arg0:setAlpha(0.38)
						f28_arg0:setScale(1, 1)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
					end
					f27_arg0:beginAnimation(100)
					f27_arg0:setAlpha(0.25)
					f27_arg0:setScale(0.96, 0.96)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f19_arg0.CurrentSkillBagde:beginAnimation(1350)
				f19_arg0.CurrentSkillBagde:setScale(2, 2)
				f19_arg0.CurrentSkillBagde:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CurrentSkillBagde:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f19_arg0.CurrentSkillBagde:completeAnimation()
			f19_arg0.CurrentSkillBagde:setAlpha(0)
			f19_arg0.CurrentSkillBagde:setScale(1.8, 1.8)
			f19_local2(f19_arg0.CurrentSkillBagde)
			local f19_local3 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					local f31_local0 = function(f32_arg0)
						f32_arg0:beginAnimation(39)
						f32_arg0:setAlpha(1)
						f32_arg0:setScale(1, 1)
						f32_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f31_arg0:beginAnimation(200)
					f31_arg0:setAlpha(0.83)
					f31_arg0:setScale(0.9, 0.9)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
				end
				f19_arg0.LadderTitleText:beginAnimation(1750)
				f19_arg0.LadderTitleText:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.LadderTitleText:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f19_arg0.LadderTitleText:completeAnimation()
			f19_arg0.LadderTitleText:setAlpha(0)
			f19_arg0.LadderTitleText:setScale(2, 2)
			f19_local3(f19_arg0.LadderTitleText)
		end,
	},
}
CoD.LeaguePlayIntroLadderResults.__onClose = function(f33_arg0)
	f33_arg0.ItemShopBackgroundBlur:close()
	f33_arg0.CurrentSkillPlacementGlow:close()
	f33_arg0.CurrentSkillPlacementStroke:close()
	f33_arg0.CurrentSkillPlacement:close()
	f33_arg0.Subdivision:close()
	f33_arg0.FooterContainerFrontendRight:close()
	f33_arg0.Timer:close()
	f33_arg0.RubyLightRay:close()
	f33_arg0.CurrentSkillBagde:close()
	f33_arg0.LadderTitleText:close()
	f33_arg0.PCButton:close()
end

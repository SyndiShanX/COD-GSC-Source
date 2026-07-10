require("x64:e4f3618aad5a562")
require("x64:3ff924af57d228a")
require("x64:b50aee012bc703d")
CoD.PC_AchievementNotification = InheritFrom(LUI.UIElement)
CoD.PC_AchievementNotification.__defaultWidth = 430
CoD.PC_AchievementNotification.__defaultHeight = 80
CoD.PC_AchievementNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_AchievementNotification)
	self.id = "PC_AchievementNotification"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.PC_Notif_Background.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Background:mergeStateConditions({
		{
			stateName = "InGame",
			condition = function(menu, element, event)
				return not InFrontend()
			end,
		},
	})
	self:addElement(Background)
	self.Background = Background
	local AchievementIcon = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 80, 0, 0, 0, 80)
	AchievementIcon:subscribeToGlobalModel(f1_arg1, "PCAchievementNotification", "image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AchievementIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(AchievementIcon)
	self.AchievementIcon = AchievementIcon
	local PointsInnerGlowBG = LUI.UIImage.new(1, 1, -54, -11, 0, 1, 11, -11)
	PointsInnerGlowBG:setRGB(0.67, 0.67, 0.67)
	PointsInnerGlowBG:setAlpha(0.01)
	PointsInnerGlowBG:setImage(RegisterImage(@"uie_innerglow"))
	self:addElement(PointsInnerGlowBG)
	self.PointsInnerGlowBG = PointsInnerGlowBG
	local PointsBorder = LUI.UIImage.new(1, 1, -54, -11, 0, 1, 11, -11)
	PointsBorder:setRGB(0.38, 0.38, 0.38)
	PointsBorder:setAlpha(0.1)
	PointsBorder:setImage(RegisterImage(@"uie_highlight_border_line"))
	PointsBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	PointsBorder:setShaderVector(0, 0, 0, 0, 0)
	PointsBorder:setupNineSliceShader(6, 6)
	self:addElement(PointsBorder)
	self.PointsBorder = PointsBorder
	local Texts = CoD.PC_AchievementNotification_Texts.new(f1_arg0, f1_arg1, 0, 1, 93, -63, 0.5, 0.5, -19.5, 15.5)
	self:addElement(Texts)
	self.Texts = Texts
	local ScoreValue = LUI.UIText.new(1, 1, -66, 0, 0.5, 0.5, -13, 13)
	ScoreValue:setRGB(0.89, 0.87, 0.85)
	ScoreValue:setTTF("ttmussels_regular")
	ScoreValue:setLetterSpacing(3)
	ScoreValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ScoreValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ScoreValue:subscribeToGlobalModel(f1_arg1, "PCAchievementNotification", "score", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ScoreValue:setText(f4_local0)
		end
	end)
	self:addElement(ScoreValue)
	self.ScoreValue = ScoreValue
	local CompletedTick = CoD.PC_Achievement_CompletedTick.new(f1_arg0, f1_arg1, 0, 0, -20, 0, 0, 1, 0, 0)
	CompletedTick:setAlpha(0)
	CompletedTick.TabBackingGlow:setScale(2, 7.2)
	self:addElement(CompletedTick)
	self.CompletedTick = CompletedTick
	local TabBacking = LUI.UIImage.new(0.23, 0, -125, 7, -0.4, 1.4, -30, 30)
	TabBacking:setAlpha(0)
	TabBacking:setImage(RegisterImage(@"uie_ui_menu_common_tab_backing"))
	TabBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TabBacking:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -2, 2)
	Frame:setRGB(0.49, 0.49, 0.49)
	Frame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementNotification.__resetProperties = function(f5_arg0)
	f5_arg0.TabBacking:completeAnimation()
	f5_arg0.CompletedTick:completeAnimation()
	f5_arg0.TabBacking:setAlpha(0)
	f5_arg0.TabBacking:setScale(1, 1)
	f5_arg0.CompletedTick:setTopBottom(0, 1, 0, 0)
	f5_arg0.CompletedTick:setAlpha(0)
	f5_arg0.CompletedTick.TabBackingGlow:setScale(2, 7.2)
end
CoD.PC_AchievementNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.CompletedTick:beginAnimation(150)
				f7_arg0.CompletedTick.TabBackingGlow:beginAnimation(150)
				f7_arg0.CompletedTick:setTopBottom(0, 1, 0, 0)
				f7_arg0.CompletedTick:setAlpha(1)
				f7_arg0.CompletedTick.TabBackingGlow:setScale(1.6, 8)
				f7_arg0.CompletedTick:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.CompletedTick:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.CompletedTick:completeAnimation()
			f7_arg0.CompletedTick.TabBackingGlow:completeAnimation()
			f7_arg0.CompletedTick:setTopBottom(0.26, 0.76, 0, 0)
			f7_arg0.CompletedTick:setAlpha(0)
			f7_arg0.CompletedTick.TabBackingGlow:setScale(3, 4)
			f7_local0(f7_arg0.CompletedTick)
			local f7_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							local f12_local0 = function(f13_arg0)
								f13_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_out"])
								f13_arg0:setAlpha(0)
								f13_arg0:setScale(2, 1.5)
								f13_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
							end
							f12_arg0:beginAnimation(9)
							f12_arg0:setAlpha(0.8)
							f12_arg0:setScale(1, 1.1)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
						end
						f11_arg0:beginAnimation(39)
						f11_arg0:setScale(2, 2)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(390, Enum[@"luitween"][@"luitween_ease_out"])
					f10_arg0:setAlpha(0)
					f10_arg0:setScale(2, 1.5)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f7_arg0.TabBacking:beginAnimation(150)
				f7_arg0.TabBacking:setAlpha(0.8)
				f7_arg0.TabBacking:setScale(1, 1.1)
				f7_arg0.TabBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.TabBacking:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f7_arg0.TabBacking:completeAnimation()
			f7_arg0.TabBacking:setAlpha(0)
			f7_arg0.TabBacking:setScale(1, 0.5)
			f7_local1(f7_arg0.TabBacking)
		end,
	},
}
CoD.PC_AchievementNotification.__onClose = function(f14_arg0)
	f14_arg0.Background:close()
	f14_arg0.AchievementIcon:close()
	f14_arg0.Texts:close()
	f14_arg0.ScoreValue:close()
	f14_arg0.CompletedTick:close()
end

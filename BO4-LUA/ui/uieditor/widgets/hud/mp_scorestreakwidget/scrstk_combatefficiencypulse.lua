require("x64:266f2c0c39e9736")
CoD.ScrStk_CombatEfficiencyPulse = InheritFrom(LUI.UIElement)
CoD.ScrStk_CombatEfficiencyPulse.__defaultWidth = 109
CoD.ScrStk_CombatEfficiencyPulse.__defaultHeight = 175
CoD.ScrStk_CombatEfficiencyPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_CombatEfficiencyPulse)
	self.id = "ScrStk_CombatEfficiencyPulse"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScrStkCombatEfficiencyScrollFX0 = CoD.ScrStk_CombatEfficiencyScrollFX.new(f1_arg0, f1_arg1, 0.5, 0.5, -28, 0, 0, 1, 0, 0)
	ScrStkCombatEfficiencyScrollFX0:setRGB(0.84, 0.98, 1)
	self:addElement(ScrStkCombatEfficiencyScrollFX0)
	self.ScrStkCombatEfficiencyScrollFX0 = ScrStkCombatEfficiencyScrollFX0
	local ScrStkCombatEfficiencyScrollFX00 = CoD.ScrStk_CombatEfficiencyScrollFX.new(f1_arg0, f1_arg1, 0.5, 0.5, 0, 28, 0, 1, 0, 0)
	ScrStkCombatEfficiencyScrollFX00:setRGB(0.84, 0.98, 1)
	ScrStkCombatEfficiencyScrollFX00:setYRot(180)
	self:addElement(ScrStkCombatEfficiencyScrollFX00)
	self.ScrStkCombatEfficiencyScrollFX00 = ScrStkCombatEfficiencyScrollFX00
	local Image0 = LUI.UIImage.new(0.5, 0.5, -53, 55, 0, 1, 0, 0)
	Image0:setRGB(0, 0.79, 1)
	Image0:setAlpha(0)
	Image0:setImage(RegisterImage(@"uie_t7_mp_hud_scorestreak_fillglowvert"))
	self:addElement(Image0)
	self.Image0 = Image0
	local Glow = LUI.UIImage.new(0.5, 0.5, -84, 86, 0.5, 0.5, -88, 88)
	Glow:setRGB(0, 0.6, 1)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_t7_cp_hud_tacmode_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScrStk_CombatEfficiencyPulse.__resetProperties = function(f2_arg0)
	f2_arg0.Glow:completeAnimation()
	f2_arg0.Image0:completeAnimation()
	f2_arg0.Glow:setLeftRight(0.5, 0.5, -84, 86)
	f2_arg0.Glow:setTopBottom(0.5, 0.5, -88, 88)
	f2_arg0.Glow:setAlpha(0)
	f2_arg0.Image0:setLeftRight(0.5, 0.5, -53, 55)
	f2_arg0.Image0:setTopBottom(0, 1, 0, 0)
	f2_arg0.Image0:setAlpha(0)
end
CoD.ScrStk_CombatEfficiencyPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ScoreAdded = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(489)
					f6_arg0:setLeftRight(0.5, 0.5, -63, 63)
					f6_arg0:setAlpha(0)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.Image0:beginAnimation(20)
				f4_arg0.Image0:setLeftRight(0.5, 0.5, -33.22, 31.29)
				f4_arg0.Image0:setAlpha(1)
				f4_arg0.Image0:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Image0:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.Image0:completeAnimation()
			f4_arg0.Image0:setLeftRight(0.5, 0.5, -32, 30)
			f4_arg0.Image0:setTopBottom(0, 1, 0, 0)
			f4_arg0.Image0:setAlpha(0)
			f4_local0(f4_arg0.Image0)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(9)
						f9_arg0:setLeftRight(0.5, 0.5, -84, 86)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(450)
					f8_arg0:setLeftRight(0.5, 0.5, -83.07, 84.79)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f4_arg0.Glow:beginAnimation(40)
				f4_arg0.Glow:setLeftRight(0.5, 0.5, -41.22, 30.34)
				f4_arg0.Glow:setAlpha(1)
				f4_arg0.Glow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Glow:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.Glow:completeAnimation()
			f4_arg0.Glow:setLeftRight(0.5, 0.5, -37.5, 25.5)
			f4_arg0.Glow:setTopBottom(0.5, 0.5, -88, 88)
			f4_arg0.Glow:setAlpha(0)
			f4_local1(f4_arg0.Glow)
		end,
	},
}
CoD.ScrStk_CombatEfficiencyPulse.__onClose = function(f10_arg0)
	f10_arg0.ScrStkCombatEfficiencyScrollFX0:close()
	f10_arg0.ScrStkCombatEfficiencyScrollFX00:close()
end

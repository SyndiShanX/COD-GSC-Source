CoD.LeaguePlayIntrolLadderRubyLightRay = InheritFrom(LUI.UIElement)
CoD.LeaguePlayIntrolLadderRubyLightRay.__defaultWidth = 500
CoD.LeaguePlayIntrolLadderRubyLightRay.__defaultHeight = 600
CoD.LeaguePlayIntrolLadderRubyLightRay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayIntrolLadderRubyLightRay)
	self.id = "LeaguePlayIntrolLadderRubyLightRay"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LightBurstBeckingSmall = LUI.UIImage.new(0.1, 0.9, 0, 0, 0.17, 0.83, 0, 0)
	LightBurstBeckingSmall:setAlpha(0)
	LightBurstBeckingSmall:setScale(1.9, 1.9)
	LightBurstBeckingSmall:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_flare"))
	LightBurstBeckingSmall:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	LightBurstBeckingSmall:setShaderVector(0, 0, 1, 0, 0)
	LightBurstBeckingSmall:setShaderVector(1, 0.25, 0.25, 0, 0)
	LightBurstBeckingSmall:setShaderVector(2, 0, 1, 0, 0)
	LightBurstBeckingSmall:setShaderVector(3, 0.25, 0.25, 0, 0)
	LightBurstBeckingSmall:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LightBurstBeckingSmall)
	self.LightBurstBeckingSmall = LightBurstBeckingSmall
	local LightBurstBeckingLarge = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LightBurstBeckingLarge:setAlpha(0)
	LightBurstBeckingLarge:setImage(RegisterImage(@"uie_light_burst"))
	LightBurstBeckingLarge:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	LightBurstBeckingLarge:setShaderVector(0, 0, 1, 0, 0)
	LightBurstBeckingLarge:setShaderVector(1, 0.52, 0.52, 0, 0)
	LightBurstBeckingLarge:setShaderVector(2, 0, 1, 0, 0)
	LightBurstBeckingLarge:setShaderVector(3, 0.52, 0.52, 0, 0)
	LightBurstBeckingLarge:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LightBurstBeckingLarge)
	self.LightBurstBeckingLarge = LightBurstBeckingLarge
	self:mergeStateConditions({
		{
			stateName = "Competitor",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 1)
			end,
		},
		{
			stateName = "Advanced",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 2)
			end,
		},
		{
			stateName = "Expert",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 3)
			end,
		},
		{
			stateName = "Elite",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 4)
			end,
		},
		{
			stateName = "Master",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 5)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayIntrolLadderRubyLightRay.__resetProperties = function(f7_arg0)
	f7_arg0.LightBurstBeckingLarge:completeAnimation()
	f7_arg0.LightBurstBeckingSmall:completeAnimation()
	f7_arg0.LightBurstBeckingLarge:setRGB(1, 1, 1)
	f7_arg0.LightBurstBeckingLarge:setAlpha(0)
	f7_arg0.LightBurstBeckingLarge:setZRot(0)
	f7_arg0.LightBurstBeckingSmall:setRGB(1, 1, 1)
	f7_arg0.LightBurstBeckingSmall:setAlpha(0)
	f7_arg0.LightBurstBeckingSmall:setZRot(0)
	f7_arg0.LightBurstBeckingSmall:setScale(1.9, 1.9)
end
CoD.LeaguePlayIntrolLadderRubyLightRay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Competitor = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(15000)
					f11_arg0:setZRot(180)
					f11_arg0:setScale(1.3, 1.3)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.LightBurstBeckingSmall:beginAnimation(15000)
				f9_arg0.LightBurstBeckingSmall:setZRot(90)
				f9_arg0.LightBurstBeckingSmall:setScale(1.4, 1.4)
				f9_arg0.LightBurstBeckingSmall:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.LightBurstBeckingSmall:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.LightBurstBeckingSmall:completeAnimation()
			f9_arg0.LightBurstBeckingSmall:setRGB(1, 1, 1)
			f9_arg0.LightBurstBeckingSmall:setAlpha(0)
			f9_arg0.LightBurstBeckingSmall:setZRot(0)
			f9_arg0.LightBurstBeckingSmall:setScale(1.3, 1.3)
			f9_local0(f9_arg0.LightBurstBeckingSmall)
			local f9_local1 = function(f12_arg0)
				f9_arg0.LightBurstBeckingLarge:beginAnimation(30000)
				f9_arg0.LightBurstBeckingLarge:setZRot(-180)
				f9_arg0.LightBurstBeckingLarge:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.LightBurstBeckingLarge:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.LightBurstBeckingLarge:completeAnimation()
			f9_arg0.LightBurstBeckingLarge:setRGB(0.71, 0.71, 0.71)
			f9_arg0.LightBurstBeckingLarge:setAlpha(0)
			f9_arg0.LightBurstBeckingLarge:setZRot(0)
			f9_local1(f9_arg0.LightBurstBeckingLarge)
		end,
	},
	Advanced = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(15040)
					f15_arg0:setZRot(180)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.LightBurstBeckingSmall:beginAnimation(14960)
				f13_arg0.LightBurstBeckingSmall:setZRot(90)
				f13_arg0.LightBurstBeckingSmall:setScale(1.4, 1.4)
				f13_arg0.LightBurstBeckingSmall:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.LightBurstBeckingSmall:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.LightBurstBeckingSmall:completeAnimation()
			f13_arg0.LightBurstBeckingSmall:setRGB(1, 0.92, 0.04)
			f13_arg0.LightBurstBeckingSmall:setAlpha(1)
			f13_arg0.LightBurstBeckingSmall:setZRot(0)
			f13_arg0.LightBurstBeckingSmall:setScale(1.3, 1.3)
			f13_local0(f13_arg0.LightBurstBeckingSmall)
			local f13_local1 = function(f16_arg0)
				f13_arg0.LightBurstBeckingLarge:beginAnimation(30000)
				f13_arg0.LightBurstBeckingLarge:setZRot(-180)
				f13_arg0.LightBurstBeckingLarge:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.LightBurstBeckingLarge:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.LightBurstBeckingLarge:completeAnimation()
			f13_arg0.LightBurstBeckingLarge:setRGB(0.87, 0.64, 0.02)
			f13_arg0.LightBurstBeckingLarge:setAlpha(1)
			f13_arg0.LightBurstBeckingLarge:setZRot(0)
			f13_local1(f13_arg0.LightBurstBeckingLarge)
		end,
	},
	Expert = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(15040)
					f19_arg0:setZRot(180)
					f19_arg0:setScale(1.3, 1.3)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.LightBurstBeckingSmall:beginAnimation(9960)
				f17_arg0.LightBurstBeckingSmall:setZRot(72)
				f17_arg0.LightBurstBeckingSmall:setScale(1.4, 1.4)
				f17_arg0.LightBurstBeckingSmall:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.LightBurstBeckingSmall:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.LightBurstBeckingSmall:completeAnimation()
			f17_arg0.LightBurstBeckingSmall:setRGB(0.31, 0.91, 0.05)
			f17_arg0.LightBurstBeckingSmall:setAlpha(1)
			f17_arg0.LightBurstBeckingSmall:setZRot(0)
			f17_arg0.LightBurstBeckingSmall:setScale(1.3, 1.3)
			f17_local0(f17_arg0.LightBurstBeckingSmall)
			local f17_local1 = function(f20_arg0)
				f17_arg0.LightBurstBeckingLarge:beginAnimation(25000)
				f17_arg0.LightBurstBeckingLarge:setZRot(-180)
				f17_arg0.LightBurstBeckingLarge:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.LightBurstBeckingLarge:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.LightBurstBeckingLarge:completeAnimation()
			f17_arg0.LightBurstBeckingLarge:setRGB(0.47, 0.74, 0.05)
			f17_arg0.LightBurstBeckingLarge:setAlpha(1)
			f17_arg0.LightBurstBeckingLarge:setZRot(0)
			f17_local1(f17_arg0.LightBurstBeckingLarge)
			f17_arg0.nextClip = "DefaultClip"
		end,
	},
	Elite = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(15000)
					f23_arg0:setZRot(180)
					f23_arg0:setScale(1.3, 1.3)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.LightBurstBeckingSmall:beginAnimation(15000)
				f21_arg0.LightBurstBeckingSmall:setZRot(90)
				f21_arg0.LightBurstBeckingSmall:setScale(1.4, 1.4)
				f21_arg0.LightBurstBeckingSmall:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.LightBurstBeckingSmall:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.LightBurstBeckingSmall:completeAnimation()
			f21_arg0.LightBurstBeckingSmall:setAlpha(1)
			f21_arg0.LightBurstBeckingSmall:setZRot(0)
			f21_arg0.LightBurstBeckingSmall:setScale(1.3, 1.3)
			f21_local0(f21_arg0.LightBurstBeckingSmall)
			local f21_local1 = function(f24_arg0)
				f21_arg0.LightBurstBeckingLarge:beginAnimation(30000)
				f21_arg0.LightBurstBeckingLarge:setZRot(-180)
				f21_arg0.LightBurstBeckingLarge:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.LightBurstBeckingLarge:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.LightBurstBeckingLarge:completeAnimation()
			f21_arg0.LightBurstBeckingLarge:setRGB(0.52, 0.52, 0.52)
			f21_arg0.LightBurstBeckingLarge:setAlpha(1)
			f21_arg0.LightBurstBeckingLarge:setZRot(0)
			f21_local1(f21_arg0.LightBurstBeckingLarge)
			f21_arg0.nextClip = "DefaultClip"
		end,
	},
	Master = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(15000)
					f27_arg0:setZRot(180)
					f27_arg0:setScale(1.3, 1.3)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.LightBurstBeckingSmall:beginAnimation(10000)
				f25_arg0.LightBurstBeckingSmall:setZRot(72)
				f25_arg0.LightBurstBeckingSmall:setScale(1.4, 1.4)
				f25_arg0.LightBurstBeckingSmall:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.LightBurstBeckingSmall:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.LightBurstBeckingSmall:completeAnimation()
			f25_arg0.LightBurstBeckingSmall:setRGB(0.82, 0.52, 0.85)
			f25_arg0.LightBurstBeckingSmall:setAlpha(1)
			f25_arg0.LightBurstBeckingSmall:setZRot(0)
			f25_arg0.LightBurstBeckingSmall:setScale(1.3, 1.3)
			f25_local0(f25_arg0.LightBurstBeckingSmall)
			local f25_local1 = function(f28_arg0)
				f25_arg0.LightBurstBeckingLarge:beginAnimation(25000)
				f25_arg0.LightBurstBeckingLarge:setZRot(-180)
				f25_arg0.LightBurstBeckingLarge:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.LightBurstBeckingLarge:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.LightBurstBeckingLarge:completeAnimation()
			f25_arg0.LightBurstBeckingLarge:setRGB(1, 0.35, 0.84)
			f25_arg0.LightBurstBeckingLarge:setAlpha(1)
			f25_arg0.LightBurstBeckingLarge:setZRot(0)
			f25_local1(f25_arg0.LightBurstBeckingLarge)
			f25_arg0.nextClip = "DefaultClip"
		end,
	},
}

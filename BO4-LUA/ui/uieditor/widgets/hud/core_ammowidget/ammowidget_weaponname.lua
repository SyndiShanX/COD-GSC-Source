CoD.AmmoWidget_WeaponName = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_WeaponName.__defaultWidth = 120
CoD.AmmoWidget_WeaponName.__defaultHeight = 12
CoD.AmmoWidget_WeaponName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_WeaponName)
	self.id = "AmmoWidget_WeaponName"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeroAbilityUseString = LUI.UIText.new(0, 0, 0, 107, 0, 0, 0.5, 11.5)
	HeroAbilityUseString:setRGB(0.73, 0.71, 0.64)
	HeroAbilityUseString:setText("")
	HeroAbilityUseString:setTTF("ttmussels_demibold")
	HeroAbilityUseString:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	HeroAbilityUseString:setLetterSpacing(1)
	HeroAbilityUseString:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HeroAbilityUseString:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	self:subscribeToGlobalModel(f1_arg1, "PerController", "heldWeapons.0.updateWeaponSelect", function(model)
		local f2_local0 = self
		PulseElementToStateAndBack(self, "Respawn", f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_WeaponName.__resetProperties = function(f3_arg0)
	f3_arg0.HeroAbilityUseString:completeAnimation()
	f3_arg0.HeroAbilityUseString:setLeftRight(0, 0, 0, 107)
	f3_arg0.HeroAbilityUseString:setTopBottom(0, 0, 0.5, 11.5)
	f3_arg0.HeroAbilityUseString:setAlpha(1)
end
CoD.AmmoWidget_WeaponName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.HeroAbilityUseString:beginAnimation(1990)
				f4_arg0.HeroAbilityUseString:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.HeroAbilityUseString:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.HeroAbilityUseString:completeAnimation()
			f4_arg0.HeroAbilityUseString:setAlpha(1)
			f4_local0(f4_arg0.HeroAbilityUseString)
		end,
		Hidden = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.HeroAbilityUseString:beginAnimation(200)
				f6_arg0.HeroAbilityUseString:setAlpha(0)
				f6_arg0.HeroAbilityUseString:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.HeroAbilityUseString:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.HeroAbilityUseString:completeAnimation()
			f6_arg0.HeroAbilityUseString:setLeftRight(0, 0, -11, 127)
			f6_arg0.HeroAbilityUseString:setTopBottom(0, 0, 11.5, 23.5)
			f6_arg0.HeroAbilityUseString:setAlpha(1)
			f6_local0(f6_arg0.HeroAbilityUseString)
		end,
	},
	Respawn = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.HeroAbilityUseString:completeAnimation()
			f8_arg0.HeroAbilityUseString:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.HeroAbilityUseString)
		end,
		DefaultState = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(360)
						f12_arg0:setAlpha(0.2)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(1530)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.HeroAbilityUseString:beginAnimation(100)
				f9_arg0.HeroAbilityUseString:setAlpha(1)
				f9_arg0.HeroAbilityUseString:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.HeroAbilityUseString:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.HeroAbilityUseString:completeAnimation()
			f9_arg0.HeroAbilityUseString:setAlpha(0)
			f9_local0(f9_arg0.HeroAbilityUseString)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.HeroAbilityUseString:completeAnimation()
			f13_arg0.HeroAbilityUseString:setLeftRight(0, 0, -11, 127)
			f13_arg0.HeroAbilityUseString:setTopBottom(0, 0, 11.5, 23.5)
			f13_arg0.HeroAbilityUseString:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.HeroAbilityUseString)
		end,
		DefaultState = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.HeroAbilityUseString:beginAnimation(200)
				f14_arg0.HeroAbilityUseString:setAlpha(1)
				f14_arg0.HeroAbilityUseString:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.HeroAbilityUseString:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.HeroAbilityUseString:completeAnimation()
			f14_arg0.HeroAbilityUseString:setLeftRight(0, 0, -11, 153)
			f14_arg0.HeroAbilityUseString:setTopBottom(0, 0, 11.5, 21.5)
			f14_arg0.HeroAbilityUseString:setAlpha(0)
			f14_local0(f14_arg0.HeroAbilityUseString)
		end,
	},
}

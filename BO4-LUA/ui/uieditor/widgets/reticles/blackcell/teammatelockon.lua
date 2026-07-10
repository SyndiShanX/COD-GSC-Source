CoD.TeamMateLockOn = InheritFrom(LUI.UIElement)
CoD.TeamMateLockOn.__defaultWidth = 204
CoD.TeamMateLockOn.__defaultHeight = 154
CoD.TeamMateLockOn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TeamMateLockOn)
	self.id = "TeamMateLockOn"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PanelGlow = LUI.UIImage.new(0.5, 0.5, -152, 149, 0.5, 0.5, -101, 105)
	PanelGlow:setRGB(0.97, 0.36, 0.07)
	PanelGlow:setAlpha(0.49)
	PanelGlow:setImage(RegisterImage(0x5BE416E17DAB33B))
	PanelGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PanelGlow)
	self.PanelGlow = PanelGlow
	local teamLockOn = LUI.UIImage.new(0.5, 0.5, -114, 118, 0.5, 0.5, -85, -25)
	teamLockOn:setImage(RegisterImage(0xD4D03B92B49DA4D))
	self:addElement(teamLockOn)
	self.teamLockOn = teamLockOn
	local teamLockOn0 = LUI.UIImage.new(0.5, 0.5, -114, 118, 0.5, 0.5, 28, 88)
	teamLockOn0:setImage(RegisterImage(0xD4D03B92B49DA4D))
	self:addElement(teamLockOn0)
	self.teamLockOn0 = teamLockOn0
	local TeammateLockonShadow = LUI.UIText.new(0.5, 0.5, -89, 95, 0.5, 0.5, -43, 2)
	TeammateLockonShadow:setRGB(0, 0, 0)
	TeammateLockonShadow:setAlpha(0.8)
	TeammateLockonShadow:setText(LocalizeToUpperString(0x7E386673A19B47C))
	TeammateLockonShadow:setTTF("ttmussels_demibold")
	TeammateLockonShadow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TeammateLockonShadow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TeammateLockonShadow)
	self.TeammateLockonShadow = TeammateLockonShadow
	local TeammateLockon = LUI.UIText.new(0.5, 0.5, -89, 95, 0.5, 0.5, -43, 2)
	TeammateLockon:setText(LocalizeToUpperString(0x7E386673A19B47C))
	TeammateLockon:setTTF("ttmussels_demibold")
	TeammateLockon:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TeammateLockon:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TeammateLockon)
	self.TeammateLockon = TeammateLockon
	local TeammateHackingShadow = LUI.UIText.new(0.5, 0.5, -85, 89, 0.5, 0.5, -43, 2)
	TeammateHackingShadow:setRGB(0, 0, 0)
	TeammateHackingShadow:setAlpha(0)
	TeammateHackingShadow:setText(Engine[0xF9F1239CFD921FE](0xCAA2EBE5B5EFE52))
	TeammateHackingShadow:setTTF("ttmussels_demibold")
	TeammateHackingShadow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TeammateHackingShadow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TeammateHackingShadow)
	self.TeammateHackingShadow = TeammateHackingShadow
	local TeammateHacking = LUI.UIText.new(0.5, 0.5, -85, 89, 0.5, 0.5, -43, 2)
	TeammateHacking:setAlpha(0)
	TeammateHacking:setText(Engine[0xF9F1239CFD921FE](0xCAA2EBE5B5EFE52))
	TeammateHacking:setTTF("ttmussels_demibold")
	TeammateHacking:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TeammateHacking:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TeammateHacking)
	self.TeammateHacking = TeammateHacking
	self:mergeStateConditions({
		{
			stateName = "Hacking",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "lockedOnEnemyTeamHacking") and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f1_arg1, "CurrentWeapon", "lockedOnEnemy", Enum[0xF041D1802ECFE69][0xFFFAB60076992A1])
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "lockedOnEnemyTeamTargetting") and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f1_arg1, "CurrentWeapon", "lockedOnEnemy", Enum[0xF041D1802ECFE69][0xFFFAB60076992A1])
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.lockedOnEnemyTeamHacking, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lockedOnEnemyTeamHacking",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.lockedOnEnemy, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lockedOnEnemy",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.lockedOnEnemyTeamTargetting, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lockedOnEnemyTeamTargetting",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TeamMateLockOn.__resetProperties = function(f7_arg0)
	f7_arg0.teamLockOn:completeAnimation()
	f7_arg0.TeammateLockon:completeAnimation()
	f7_arg0.teamLockOn0:completeAnimation()
	f7_arg0.PanelGlow:completeAnimation()
	f7_arg0.TeammateLockonShadow:completeAnimation()
	f7_arg0.TeammateHacking:completeAnimation()
	f7_arg0.TeammateHackingShadow:completeAnimation()
	f7_arg0.teamLockOn:setAlpha(1)
	f7_arg0.TeammateLockon:setAlpha(1)
	f7_arg0.teamLockOn0:setAlpha(1)
	f7_arg0.PanelGlow:setAlpha(0.49)
	f7_arg0.TeammateLockonShadow:setAlpha(0.8)
	f7_arg0.TeammateHacking:setAlpha(0)
	f7_arg0.TeammateHackingShadow:setAlpha(0)
end
CoD.TeamMateLockOn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.PanelGlow:completeAnimation()
			f8_arg0.PanelGlow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PanelGlow)
			f8_arg0.teamLockOn:completeAnimation()
			f8_arg0.teamLockOn:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.teamLockOn)
			f8_arg0.teamLockOn0:completeAnimation()
			f8_arg0.teamLockOn0:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.teamLockOn0)
			f8_arg0.TeammateLockonShadow:completeAnimation()
			f8_arg0.TeammateLockonShadow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TeammateLockonShadow)
			f8_arg0.TeammateLockon:completeAnimation()
			f8_arg0.TeammateLockon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TeammateLockon)
		end,
		Locking = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			local f9_local0 = function(f10_arg0)
				f9_arg0.PanelGlow:beginAnimation(100)
				f9_arg0.PanelGlow:setAlpha(0.49)
				f9_arg0.PanelGlow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.PanelGlow:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.PanelGlow:completeAnimation()
			f9_arg0.PanelGlow:setAlpha(0)
			f9_local0(f9_arg0.PanelGlow)
			local f9_local1 = function(f11_arg0)
				f9_arg0.teamLockOn:beginAnimation(100)
				f9_arg0.teamLockOn:setAlpha(1)
				f9_arg0.teamLockOn:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.teamLockOn:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.teamLockOn:completeAnimation()
			f9_arg0.teamLockOn:setAlpha(0)
			f9_local1(f9_arg0.teamLockOn)
			local f9_local2 = function(f12_arg0)
				f9_arg0.teamLockOn0:beginAnimation(100)
				f9_arg0.teamLockOn0:setAlpha(1)
				f9_arg0.teamLockOn0:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.teamLockOn0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.teamLockOn0:completeAnimation()
			f9_arg0.teamLockOn0:setAlpha(0)
			f9_local2(f9_arg0.teamLockOn0)
			local f9_local3 = function(f13_arg0)
				f9_arg0.TeammateLockonShadow:beginAnimation(100)
				f9_arg0.TeammateLockonShadow:setAlpha(0.8)
				f9_arg0.TeammateLockonShadow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.TeammateLockonShadow:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.TeammateLockonShadow:completeAnimation()
			f9_arg0.TeammateLockonShadow:setAlpha(0)
			f9_local3(f9_arg0.TeammateLockonShadow)
			local f9_local4 = function(f14_arg0)
				f9_arg0.TeammateLockon:beginAnimation(100)
				f9_arg0.TeammateLockon:setAlpha(1)
				f9_arg0.TeammateLockon:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.TeammateLockon:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.TeammateLockon:completeAnimation()
			f9_arg0.TeammateLockon:setAlpha(0)
			f9_local4(f9_arg0.TeammateLockon)
		end,
		Hacking = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			local f15_local0 = function(f16_arg0)
				f15_arg0.PanelGlow:beginAnimation(100)
				f15_arg0.PanelGlow:setAlpha(0.49)
				f15_arg0.PanelGlow:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.PanelGlow:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.PanelGlow:completeAnimation()
			f15_arg0.PanelGlow:setAlpha(0)
			f15_local0(f15_arg0.PanelGlow)
			local f15_local1 = function(f17_arg0)
				f15_arg0.teamLockOn:beginAnimation(100)
				f15_arg0.teamLockOn:setAlpha(1)
				f15_arg0.teamLockOn:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.teamLockOn:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.teamLockOn:completeAnimation()
			f15_arg0.teamLockOn:setAlpha(0)
			f15_local1(f15_arg0.teamLockOn)
			local f15_local2 = function(f18_arg0)
				f15_arg0.teamLockOn0:beginAnimation(100)
				f15_arg0.teamLockOn0:setAlpha(1)
				f15_arg0.teamLockOn0:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.teamLockOn0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.teamLockOn0:completeAnimation()
			f15_arg0.teamLockOn0:setAlpha(0)
			f15_local2(f15_arg0.teamLockOn0)
			f15_arg0.TeammateLockonShadow:completeAnimation()
			f15_arg0.TeammateLockonShadow:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TeammateLockonShadow)
			f15_arg0.TeammateLockon:completeAnimation()
			f15_arg0.TeammateLockon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TeammateLockon)
			local f15_local3 = function(f19_arg0)
				f15_arg0.TeammateHackingShadow:beginAnimation(100)
				f15_arg0.TeammateHackingShadow:setAlpha(0.8)
				f15_arg0.TeammateHackingShadow:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TeammateHackingShadow:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.TeammateHackingShadow:completeAnimation()
			f15_arg0.TeammateHackingShadow:setAlpha(0)
			f15_local3(f15_arg0.TeammateHackingShadow)
			local f15_local4 = function(f20_arg0)
				f15_arg0.TeammateHacking:beginAnimation(100)
				f15_arg0.TeammateHacking:setAlpha(1)
				f15_arg0.TeammateHacking:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TeammateHacking:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.TeammateHacking:completeAnimation()
			f15_arg0.TeammateHacking:setAlpha(0)
			f15_local4(f15_arg0.TeammateHacking)
		end,
	},
	Hacking = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			f21_arg0.TeammateLockonShadow:completeAnimation()
			f21_arg0.TeammateLockonShadow:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TeammateLockonShadow)
			f21_arg0.TeammateLockon:completeAnimation()
			f21_arg0.TeammateLockon:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TeammateLockon)
			f21_arg0.TeammateHackingShadow:completeAnimation()
			f21_arg0.TeammateHackingShadow:setAlpha(0.8)
			f21_arg0.clipFinished(f21_arg0.TeammateHackingShadow)
			f21_arg0.TeammateHacking:completeAnimation()
			f21_arg0.TeammateHacking:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.TeammateHacking)
		end,
	},
	Locked = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
}

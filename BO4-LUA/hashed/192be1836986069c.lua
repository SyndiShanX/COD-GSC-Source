CoD.Tak5Reticle_LockOn = InheritFrom(LUI.UIElement)
CoD.Tak5Reticle_LockOn.__defaultWidth = 150
CoD.Tak5Reticle_LockOn.__defaultHeight = 150
CoD.Tak5Reticle_LockOn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tak5Reticle_LockOn)
	self.id = "Tak5Reticle_LockOn"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local reticleBg = LUI.UIImage.new(0, 0, 54, 96, 0, 0, 54, 96)
	reticleBg:setAlpha(0.25)
	reticleBg:setImage(RegisterImage(0x23BB3031AA3E882))
	self:addElement(reticleBg)
	self.reticleBg = reticleBg
	local LockOn = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	LockOn:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	LockOn:setZRot(135)
	LockOn:setImage(RegisterImage(0x5C3FF395F0A052A))
	self:addElement(LockOn)
	self.LockOn = LockOn
	local LockOnAdd = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	LockOnAdd:setAlpha(0.2)
	LockOnAdd:setZRot(135)
	LockOnAdd:setImage(RegisterImage(0x5C3FF395F0A052A))
	LockOnAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	LockOnAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(LockOnAdd)
	self.LockOnAdd = LockOnAdd
	self:mergeStateConditions({
		{
			stateName = "AlreadyBoosted",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsTeammateHealTargetAlreadyBoosted(f1_arg1)
			end,
		},
		{
			stateName = "LockedOn",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsTeammateHealTargeting(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.status, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.targetClientNum, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "targetClientNum",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "TeammateHealTargeting", "targetClientNum", function(model)
		local f6_local0 = self
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "TeammateHealTargeting", "targetClientNum", LuaDefine.INVALID_CLIENT_INDEX) then
			PlayClip(self, "TargetChange", f1_arg1)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Tak5Reticle_LockOn.__resetProperties = function(f7_arg0)
	f7_arg0.LockOn:completeAnimation()
	f7_arg0.reticleBg:completeAnimation()
	f7_arg0.LockOnAdd:completeAnimation()
	f7_arg0.LockOn:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	f7_arg0.LockOn:setAlpha(1)
	f7_arg0.LockOn:setZRot(135)
	f7_arg0.LockOn:setScale(1, 1)
	f7_arg0.reticleBg:setAlpha(0.25)
	f7_arg0.reticleBg:setScale(1, 1)
	f7_arg0.LockOnAdd:setAlpha(0.2)
	f7_arg0.LockOnAdd:setZRot(135)
	f7_arg0.LockOnAdd:setScale(1, 1)
	f7_arg0.LockOnAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f7_arg0.LockOnAdd:setShaderVector(0, 1.5, 0, 0, 0)
end
CoD.Tak5Reticle_LockOn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.reticleBg:completeAnimation()
			f8_arg0.reticleBg:setScale(0.6, 0.6)
			f8_arg0.clipFinished(f8_arg0.reticleBg)
			f8_arg0.LockOn:completeAnimation()
			f8_arg0.LockOn:setZRot(135)
			f8_arg0.LockOn:setScale(0.25, 0.25)
			f8_arg0.clipFinished(f8_arg0.LockOn)
			f8_arg0.LockOnAdd:completeAnimation()
			f8_arg0.LockOnAdd:setAlpha(0.2)
			f8_arg0.LockOnAdd:setZRot(135)
			f8_arg0.LockOnAdd:setScale(0.25, 0.25)
			f8_arg0.LockOnAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f8_arg0.LockOnAdd:setShaderVector(0, 1.5, 0, 0, 0)
			f8_arg0.clipFinished(f8_arg0.LockOnAdd)
		end,
	},
	AlreadyBoosted = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.reticleBg:completeAnimation()
			f9_arg0.reticleBg:setScale(0.5, 0.5)
			f9_arg0.clipFinished(f9_arg0.reticleBg)
			f9_arg0.LockOn:completeAnimation()
			f9_arg0.LockOn:setRGB(1, 1, 1)
			f9_arg0.LockOn:setAlpha(0.5)
			f9_arg0.LockOn:setZRot(135)
			f9_arg0.LockOn:setScale(0.5, 0.5)
			f9_arg0.clipFinished(f9_arg0.LockOn)
			f9_arg0.LockOnAdd:completeAnimation()
			f9_arg0.LockOnAdd:setAlpha(0)
			f9_arg0.LockOnAdd:setScale(0.5, 0.5)
			f9_arg0.clipFinished(f9_arg0.LockOnAdd)
		end,
		TargetChange = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			local f10_local0 = function(f11_arg0)
				f10_arg0.reticleBg:beginAnimation(60, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f10_arg0.reticleBg:setAlpha(0.25)
				f10_arg0.reticleBg:setScale(0.5, 0.5)
				f10_arg0.reticleBg:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.reticleBg:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.reticleBg:completeAnimation()
			f10_arg0.reticleBg:setAlpha(0.5)
			f10_arg0.reticleBg:setScale(0.8, 0.8)
			f10_local0(f10_arg0.reticleBg)
			local f10_local1 = function(f12_arg0)
				f10_arg0.LockOn:beginAnimation(60)
				f10_arg0.LockOn:setZRot(135)
				f10_arg0.LockOn:setScale(0.5, 0.5)
				f10_arg0.LockOn:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.LockOn:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.LockOn:completeAnimation()
			f10_arg0.LockOn:setRGB(1, 1, 1)
			f10_arg0.LockOn:setAlpha(0.5)
			f10_arg0.LockOn:setZRot(0)
			f10_arg0.LockOn:setScale(0.4, 0.4)
			f10_local1(f10_arg0.LockOn)
			local f10_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(30)
					f14_arg0:setAlpha(0)
					f14_arg0:setZRot(135)
					f14_arg0:setScale(0.5, 0.5)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.LockOnAdd:beginAnimation(30)
				f10_arg0.LockOnAdd:setAlpha(0.1)
				f10_arg0.LockOnAdd:setZRot(68)
				f10_arg0.LockOnAdd:setScale(0.45, 0.45)
				f10_arg0.LockOnAdd:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.LockOnAdd:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f10_arg0.LockOnAdd:completeAnimation()
			f10_arg0.LockOnAdd:setAlpha(0)
			f10_arg0.LockOnAdd:setZRot(0)
			f10_arg0.LockOnAdd:setScale(0.4, 0.4)
			f10_local2(f10_arg0.LockOnAdd)
		end,
	},
	LockedOn = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.reticleBg:completeAnimation()
			f15_arg0.reticleBg:setAlpha(0)
			f15_arg0.reticleBg:setScale(1, 1)
			f15_arg0.clipFinished(f15_arg0.reticleBg)
			f15_arg0.LockOn:completeAnimation()
			f15_arg0.LockOn:setRGB(0.92, 0.89, 0.72)
			f15_arg0.LockOn:setAlpha(0)
			f15_arg0.LockOn:setZRot(0)
			f15_arg0.LockOn:setScale(1, 1)
			f15_arg0.clipFinished(f15_arg0.LockOn)
			f15_arg0.LockOnAdd:completeAnimation()
			f15_arg0.LockOnAdd:setAlpha(0)
			f15_arg0.LockOnAdd:setZRot(0)
			f15_arg0.LockOnAdd:setScale(1, 1)
			f15_arg0.clipFinished(f15_arg0.LockOnAdd)
		end,
		TargetChange = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.reticleBg:completeAnimation()
			f16_arg0.reticleBg:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.reticleBg)
			f16_arg0.LockOn:completeAnimation()
			f16_arg0.LockOn:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.LockOn)
			f16_arg0.LockOnAdd:completeAnimation()
			f16_arg0.LockOnAdd:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.LockOnAdd)
		end,
	},
}

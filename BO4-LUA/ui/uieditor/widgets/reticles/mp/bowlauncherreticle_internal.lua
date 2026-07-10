require("x64:d560796d05a6b46")
require("x64:d4371bcab0deefc")
require("x64:d4374bcab0df415")
require("x64:d4373bcab0df262")
require("x64:d436ebcab0de9e3")
CoD.BowLauncherReticle_Internal = InheritFrom(LUI.UIElement)
CoD.BowLauncherReticle_Internal.__defaultWidth = 160
CoD.BowLauncherReticle_Internal.__defaultHeight = 160
CoD.BowLauncherReticle_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BowLauncherReticle_Internal)
	self.id = "BowLauncherReticle_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BowLauncherReticleL1 = CoD.BowLauncherReticle_L1.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -80, 80)
	BowLauncherReticleL1:mergeStateConditions({
		{
			stateName = "Drawn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "currentShotCharge", 1)
			end,
		},
	})
	local BowLauncherReticleL3 = BowLauncherReticleL1
	local BowLauncherReticleL2 = BowLauncherReticleL1.subscribeToModel
	local BowLauncherReticleL4 = DataSources.CurrentWeapon.getModel(f1_arg1)
	BowLauncherReticleL2(BowLauncherReticleL3, BowLauncherReticleL4.currentShotCharge, function(f3_arg0)
		f1_arg0:updateElementState(BowLauncherReticleL1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "currentShotCharge",
		})
	end, false)
	self:addElement(BowLauncherReticleL1)
	self.BowLauncherReticleL1 = BowLauncherReticleL1
	BowLauncherReticleL2 = CoD.BowLauncherReticle_L2.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -55.5, 104.5)
	BowLauncherReticleL2:mergeStateConditions({
		{
			stateName = "Drawn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "currentShotCharge", 0.65)
			end,
		},
	})
	BowLauncherReticleL4 = BowLauncherReticleL2
	BowLauncherReticleL3 = BowLauncherReticleL2.subscribeToModel
	local BowLauncherReticleDot = DataSources.CurrentWeapon.getModel(f1_arg1)
	BowLauncherReticleL3(BowLauncherReticleL4, BowLauncherReticleDot.currentShotCharge, function(f5_arg0)
		f1_arg0:updateElementState(BowLauncherReticleL2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "currentShotCharge",
		})
	end, false)
	self:addElement(BowLauncherReticleL2)
	self.BowLauncherReticleL2 = BowLauncherReticleL2
	BowLauncherReticleL3 = CoD.BowLauncherReticle_L3.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -39.5, 120.5)
	BowLauncherReticleL3:mergeStateConditions({
		{
			stateName = "Drawn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "currentShotCharge", 0.4)
			end,
		},
	})
	BowLauncherReticleDot = BowLauncherReticleL3
	BowLauncherReticleL4 = BowLauncherReticleL3.subscribeToModel
	local WingL = DataSources.CurrentWeapon.getModel(f1_arg1)
	BowLauncherReticleL4(BowLauncherReticleDot, WingL.currentShotCharge, function(f7_arg0)
		f1_arg0:updateElementState(BowLauncherReticleL3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "currentShotCharge",
		})
	end, false)
	self:addElement(BowLauncherReticleL3)
	self.BowLauncherReticleL3 = BowLauncherReticleL3
	BowLauncherReticleL4 = CoD.BowLauncherReticle_L4.new(f1_arg0, f1_arg1, 0.5, 0.5, -9, 9, 0.5, 0.5, 43.5, 52.5)
	BowLauncherReticleL4:mergeStateConditions({
		{
			stateName = "Drawn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "currentShotCharge", 0.2)
			end,
		},
	})
	WingL = BowLauncherReticleL4
	BowLauncherReticleDot = BowLauncherReticleL4.subscribeToModel
	local WingR = DataSources.CurrentWeapon.getModel(f1_arg1)
	BowLauncherReticleDot(WingL, WingR.currentShotCharge, function(f9_arg0)
		f1_arg0:updateElementState(BowLauncherReticleL4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "currentShotCharge",
		})
	end, false)
	self:addElement(BowLauncherReticleL4)
	self.BowLauncherReticleL4 = BowLauncherReticleL4
	BowLauncherReticleDot = CoD.BowLauncherReticle_Dot.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0.5, 0.5, -80, 80)
	self:addElement(BowLauncherReticleDot)
	self.BowLauncherReticleDot = BowLauncherReticleDot
	WingL = LUI.UIImage.new(-1.31, -1.2, 220, 220, 0.27, 0.5, 34.5, 34.5)
	WingL:setImage(RegisterImage(0x3CE9CF4F5C3D42F))
	self:addElement(WingL)
	self.WingL = WingL
	WingR = LUI.UIImage.new(-1.08, -0.96, 304, 304, 0.4, 0.63, 12.5, 12.5)
	WingR:setImage(RegisterImage(0x3CE92F4F5C3C331))
	self:addElement(WingR)
	self.WingR = WingR
	local DrawLine = LUI.UIImage.new(-1, -0.93, 235, 235, -0.02, 0.13, 12, 12)
	DrawLine:setImage(RegisterImage(0x862D295DBF13568))
	self:addElement(DrawLine)
	self.DrawLine = DrawLine
	local DrawLine2 = LUI.UIImage.new(-1.02, -0.95, 237, 237, 0.73, 0.88, 12, 12)
	DrawLine2:setImage(RegisterImage(0x862D295DBF13568))
	self:addElement(DrawLine2)
	self.DrawLine2 = DrawLine2
	local ADSCurve = LUI.UIImage.new(-0.47, -0.12, 127, 127, -0.01, 0.14, 9, 9)
	ADSCurve:setImage(RegisterImage(0x8A25F3AC063C84B))
	self:addElement(ADSCurve)
	self.ADSCurve = ADSCurve
	self:mergeStateConditions({
		{
			stateName = "ADS",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "lookingDownSights") and not CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "currentShotCharge", 0)
			end,
		},
		{
			stateName = "ChargingShotADS",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "lookingDownSights") and CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "currentShotCharge", 0)
			end,
		},
		{
			stateName = "ChargingShot",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "currentShotCharge", 0)
			end,
		},
		{
			stateName = "StartupComplete",
			condition = function(menu, element, event)
				return PropertyIsTrue(self, "startupComplete")
			end,
		},
		{
			stateName = "Initializing",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local12(f1_local11, f1_local13.lookingDownSights, function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lookingDownSights",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local12(f1_local11, f1_local13.currentShotCharge, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "currentShotCharge",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		SetProperty(self, "startupComplete", true)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BowLauncherReticle_Internal.__resetProperties = function(f18_arg0)
	f18_arg0.DrawLine:completeAnimation()
	f18_arg0.DrawLine2:completeAnimation()
	f18_arg0.ADSCurve:completeAnimation()
	f18_arg0.WingR:completeAnimation()
	f18_arg0.WingL:completeAnimation()
	f18_arg0.BowLauncherReticleL1:completeAnimation()
	f18_arg0.BowLauncherReticleL3:completeAnimation()
	f18_arg0.BowLauncherReticleL2:completeAnimation()
	f18_arg0.BowLauncherReticleDot:completeAnimation()
	f18_arg0.BowLauncherReticleL4:completeAnimation()
	f18_arg0.DrawLine:setLeftRight(-1, -0.93, 235, 235)
	f18_arg0.DrawLine:setTopBottom(-0.02, 0.13, 12, 12)
	f18_arg0.DrawLine:setAlpha(1)
	f18_arg0.DrawLine2:setTopBottom(0.73, 0.88, 12, 12)
	f18_arg0.DrawLine2:setAlpha(1)
	f18_arg0.ADSCurve:setLeftRight(-0.47, -0.12, 127, 127)
	f18_arg0.ADSCurve:setTopBottom(-0.01, 0.14, 9, 9)
	f18_arg0.ADSCurve:setAlpha(1)
	f18_arg0.WingR:setLeftRight(-1.08, -0.96, 304, 304)
	f18_arg0.WingR:setAlpha(1)
	f18_arg0.WingL:setLeftRight(-1.31, -1.2, 220, 220)
	f18_arg0.WingL:setAlpha(1)
	f18_arg0.BowLauncherReticleL1:setAlpha(1)
	f18_arg0.BowLauncherReticleL3:setAlpha(1)
	f18_arg0.BowLauncherReticleL2:setAlpha(1)
	f18_arg0.BowLauncherReticleDot:setRGB(1, 1, 1)
	f18_arg0.BowLauncherReticleDot:setAlpha(1)
	f18_arg0.BowLauncherReticleL4:setAlpha(1)
end
CoD.BowLauncherReticle_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.DrawLine:completeAnimation()
			f19_arg0.DrawLine:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DrawLine)
			f19_arg0.DrawLine2:completeAnimation()
			f19_arg0.DrawLine2:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DrawLine2)
			f19_arg0.ADSCurve:completeAnimation()
			f19_arg0.ADSCurve:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ADSCurve)
		end,
		ChargingShot = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(8)
			f20_arg0.BowLauncherReticleL1:completeAnimation()
			f20_arg0.BowLauncherReticleL1:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.BowLauncherReticleL1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.BowLauncherReticleL2:beginAnimation(160)
				f20_arg0.BowLauncherReticleL2:setAlpha(0)
				f20_arg0.BowLauncherReticleL2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BowLauncherReticleL2:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.BowLauncherReticleL2:completeAnimation()
			f20_arg0.BowLauncherReticleL2:setAlpha(1)
			f20_local0(f20_arg0.BowLauncherReticleL2)
			local f20_local1 = function(f22_arg0)
				f20_arg0.BowLauncherReticleL3:beginAnimation(160)
				f20_arg0.BowLauncherReticleL3:setAlpha(0)
				f20_arg0.BowLauncherReticleL3:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BowLauncherReticleL3:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.BowLauncherReticleL3:completeAnimation()
			f20_arg0.BowLauncherReticleL3:setAlpha(1)
			f20_local1(f20_arg0.BowLauncherReticleL3)
			local f20_local2 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						f25_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f25_arg0:setLeftRight(-1.31, -1.2, 264, 264)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
					end
					f24_arg0:beginAnimation(150)
					f24_arg0:setLeftRight(-1.31, -1.2, 247, 247)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f20_arg0.WingL:beginAnimation(160)
				f20_arg0.WingL:setLeftRight(-1.31, -1.2, 233.94, 233.94)
				f20_arg0.WingL:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.WingL:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f20_arg0.WingL:completeAnimation()
			f20_arg0.WingL:setLeftRight(-1.31, -1.2, 220, 220)
			f20_arg0.WingL:setAlpha(1)
			f20_local2(f20_arg0.WingL)
			local f20_local3 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f27_arg0:setLeftRight(-1.08, -0.96, 260, 260)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.WingR:beginAnimation(310)
				f20_arg0.WingR:setLeftRight(-1.08, -0.96, 277, 277)
				f20_arg0.WingR:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.WingR:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f20_arg0.WingR:completeAnimation()
			f20_arg0.WingR:setLeftRight(-1.08, -0.96, 304, 304)
			f20_arg0.WingR:setAlpha(1)
			f20_local3(f20_arg0.WingR)
			local f20_local4 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					local f29_local0 = function(f30_arg0)
						f30_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f30_arg0:setTopBottom(0.17, 0.32, 21, 21)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
					end
					f29_arg0:beginAnimation(150)
					f29_arg0:setTopBottom(0.07, 0.22, 17, 17)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f20_arg0.DrawLine:beginAnimation(160)
				f20_arg0.DrawLine:setTopBottom(0.02, 0.17, 12, 12)
				f20_arg0.DrawLine:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.DrawLine:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f20_arg0.DrawLine:completeAnimation()
			f20_arg0.DrawLine:setLeftRight(-1, -0.93, 235, 235)
			f20_arg0.DrawLine:setTopBottom(-0.02, 0.13, 12, 12)
			f20_arg0.DrawLine:setAlpha(1)
			f20_local4(f20_arg0.DrawLine)
			local f20_local5 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f33_arg0:setTopBottom(0.48, 0.63, 12, 12)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(150)
					f32_arg0:setTopBottom(0.61, 0.76, 12, 12)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f20_arg0.DrawLine2:beginAnimation(160)
				f20_arg0.DrawLine2:setTopBottom(0.66, 0.81, 12, 12)
				f20_arg0.DrawLine2:setAlpha(1)
				f20_arg0.DrawLine2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.DrawLine2:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f20_arg0.DrawLine2:completeAnimation()
			f20_arg0.DrawLine2:setTopBottom(0.72, 0.87, 12, 12)
			f20_arg0.DrawLine2:setAlpha(0)
			f20_local5(f20_arg0.DrawLine2)
			f20_arg0.ADSCurve:completeAnimation()
			f20_arg0.ADSCurve:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ADSCurve)
		end,
	},
	ADS = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			f34_arg0.DrawLine:completeAnimation()
			f34_arg0.DrawLine:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DrawLine)
			f34_arg0.DrawLine2:completeAnimation()
			f34_arg0.DrawLine2:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DrawLine2)
			f34_arg0.ADSCurve:completeAnimation()
			f34_arg0.ADSCurve:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ADSCurve)
		end,
		ChargingShotADS = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(8)
			f35_arg0.BowLauncherReticleL1:completeAnimation()
			f35_arg0.BowLauncherReticleL1:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.BowLauncherReticleL1)
			local f35_local0 = function(f36_arg0)
				f35_arg0.BowLauncherReticleL2:beginAnimation(160)
				f35_arg0.BowLauncherReticleL2:setAlpha(0)
				f35_arg0.BowLauncherReticleL2:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.BowLauncherReticleL2:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.BowLauncherReticleL2:completeAnimation()
			f35_arg0.BowLauncherReticleL2:setAlpha(1)
			f35_local0(f35_arg0.BowLauncherReticleL2)
			local f35_local1 = function(f37_arg0)
				f35_arg0.BowLauncherReticleL3:beginAnimation(160)
				f35_arg0.BowLauncherReticleL3:setAlpha(0)
				f35_arg0.BowLauncherReticleL3:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.BowLauncherReticleL3:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.BowLauncherReticleL3:completeAnimation()
			f35_arg0.BowLauncherReticleL3:setAlpha(1)
			f35_local1(f35_arg0.BowLauncherReticleL3)
			local f35_local2 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(80)
					f39_arg0:setLeftRight(-1.31, -1.2, 264, 264)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
				end
				f35_arg0.WingL:beginAnimation(280)
				f35_arg0.WingL:setLeftRight(-1.31, -1.2, 247, 247)
				f35_arg0.WingL:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.WingL:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f35_arg0.WingL:completeAnimation()
			f35_arg0.WingL:setLeftRight(-1.31, -1.2, 220, 220)
			f35_arg0.WingL:setAlpha(1)
			f35_local2(f35_arg0.WingL)
			local f35_local3 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					f41_arg0:beginAnimation(80)
					f41_arg0:setLeftRight(-1.08, -0.96, 260, 260)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
				end
				f35_arg0.WingR:beginAnimation(280)
				f35_arg0.WingR:setLeftRight(-1.08, -0.96, 277, 277)
				f35_arg0.WingR:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.WingR:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f35_arg0.WingR:completeAnimation()
			f35_arg0.WingR:setLeftRight(-1.08, -0.96, 304, 304)
			f35_arg0.WingR:setAlpha(1)
			f35_local3(f35_arg0.WingR)
			f35_arg0.DrawLine:completeAnimation()
			f35_arg0.DrawLine:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.DrawLine)
			local f35_local4 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(80)
						f44_arg0:setTopBottom(0.48, 0.63, 12, 12)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(120)
					f43_arg0:setTopBottom(0.61, 0.76, 12, 12)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f35_arg0.DrawLine2:beginAnimation(160)
				f35_arg0.DrawLine2:setTopBottom(0.66, 0.81, 12, 12)
				f35_arg0.DrawLine2:setAlpha(1)
				f35_arg0.DrawLine2:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.DrawLine2:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f35_arg0.DrawLine2:completeAnimation()
			f35_arg0.DrawLine2:setTopBottom(0.72, 0.87, 12, 12)
			f35_arg0.DrawLine2:setAlpha(0)
			f35_local4(f35_arg0.DrawLine2)
			local f35_local5 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(80)
					f46_arg0:setLeftRight(-0.41, -0.18, 133, 121)
					f46_arg0:setTopBottom(0.29, 0.39, 16, 12)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
				end
				f35_arg0.ADSCurve:beginAnimation(280)
				f35_arg0.ADSCurve:setLeftRight(-0.42, -0.18, 131.67, 122.33)
				f35_arg0.ADSCurve:setTopBottom(0.24, 0.34, 7.5, 3.5)
				f35_arg0.ADSCurve:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.ADSCurve:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f35_arg0.ADSCurve:completeAnimation()
			f35_arg0.ADSCurve:setLeftRight(-0.43, -0.16, 127, 127)
			f35_arg0.ADSCurve:setTopBottom(-0.03, 0.09, 9, 9)
			f35_arg0.ADSCurve:setAlpha(1)
			f35_local5(f35_arg0.ADSCurve)
		end,
	},
	ChargingShotADS = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(8)
			f47_arg0.BowLauncherReticleL1:completeAnimation()
			f47_arg0.BowLauncherReticleL1:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BowLauncherReticleL1)
			f47_arg0.BowLauncherReticleL2:completeAnimation()
			f47_arg0.BowLauncherReticleL2:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BowLauncherReticleL2)
			f47_arg0.BowLauncherReticleL3:completeAnimation()
			f47_arg0.BowLauncherReticleL3:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.BowLauncherReticleL3)
			f47_arg0.WingL:completeAnimation()
			f47_arg0.WingL:setLeftRight(-1.31, -1.2, 264, 264)
			f47_arg0.WingL:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.WingL)
			f47_arg0.WingR:completeAnimation()
			f47_arg0.WingR:setLeftRight(-1.08, -0.96, 260, 260)
			f47_arg0.WingR:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.WingR)
			f47_arg0.DrawLine:completeAnimation()
			f47_arg0.DrawLine:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.DrawLine)
			f47_arg0.DrawLine2:completeAnimation()
			f47_arg0.DrawLine2:setTopBottom(0.48, 0.63, 12, 12)
			f47_arg0.clipFinished(f47_arg0.DrawLine2)
			f47_arg0.ADSCurve:completeAnimation()
			f47_arg0.ADSCurve:setLeftRight(-0.41, -0.18, 133, 121)
			f47_arg0.ADSCurve:setTopBottom(0.29, 0.39, 16, 12)
			f47_arg0.clipFinished(f47_arg0.ADSCurve)
		end,
		ChargingShot = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(8)
			f48_arg0.BowLauncherReticleL1:completeAnimation()
			f48_arg0.BowLauncherReticleL1:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.BowLauncherReticleL1)
			f48_arg0.BowLauncherReticleL2:completeAnimation()
			f48_arg0.BowLauncherReticleL2:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.BowLauncherReticleL2)
			f48_arg0.BowLauncherReticleL3:completeAnimation()
			f48_arg0.BowLauncherReticleL3:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.BowLauncherReticleL3)
			f48_arg0.WingL:completeAnimation()
			f48_arg0.WingL:setLeftRight(-1.31, -1.2, 264, 264)
			f48_arg0.WingL:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.WingL)
			f48_arg0.WingR:completeAnimation()
			f48_arg0.WingR:setLeftRight(-1.08, -0.96, 260, 260)
			f48_arg0.WingR:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.WingR)
			local f48_local0 = function(f49_arg0)
				f48_arg0.DrawLine:beginAnimation(50)
				f48_arg0.DrawLine:setLeftRight(-1, -0.93, 235, 235)
				f48_arg0.DrawLine:setTopBottom(0.16, 0.31, 21, 21)
				f48_arg0.DrawLine:setAlpha(1)
				f48_arg0.DrawLine:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.DrawLine:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.DrawLine:completeAnimation()
			f48_arg0.DrawLine:setTopBottom(0.16, 0.16, 21, 21)
			f48_arg0.DrawLine:setAlpha(0)
			f48_local0(f48_arg0.DrawLine)
			f48_arg0.DrawLine2:completeAnimation()
			f48_arg0.DrawLine2:setTopBottom(0.48, 0.63, 12, 12)
			f48_arg0.DrawLine2:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.DrawLine2)
			local f48_local1 = function(f50_arg0)
				f48_arg0.ADSCurve:beginAnimation(50)
				f48_arg0.ADSCurve:setLeftRight(-0.37, -0.35, 138, 138)
				f48_arg0.ADSCurve:setTopBottom(-0.03, 0.09, 57, 53)
				f48_arg0.ADSCurve:setAlpha(0)
				f48_arg0.ADSCurve:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.ADSCurve:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.ADSCurve:completeAnimation()
			f48_arg0.ADSCurve:setLeftRight(-0.49, -0.25, 145.5, 133.5)
			f48_arg0.ADSCurve:setTopBottom(0.29, 0.39, 16, 12)
			f48_arg0.ADSCurve:setAlpha(1)
			f48_local1(f48_arg0.ADSCurve)
		end,
	},
	ChargingShot = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(8)
			f51_arg0.BowLauncherReticleL1:completeAnimation()
			f51_arg0.BowLauncherReticleL1:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.BowLauncherReticleL1)
			f51_arg0.BowLauncherReticleL2:completeAnimation()
			f51_arg0.BowLauncherReticleL2:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.BowLauncherReticleL2)
			f51_arg0.BowLauncherReticleL3:completeAnimation()
			f51_arg0.BowLauncherReticleL3:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.BowLauncherReticleL3)
			f51_arg0.WingL:completeAnimation()
			f51_arg0.WingL:setLeftRight(-1.31, -1.2, 264, 264)
			f51_arg0.WingL:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.WingL)
			f51_arg0.WingR:completeAnimation()
			f51_arg0.WingR:setLeftRight(-1.08, -0.96, 260, 260)
			f51_arg0.WingR:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.WingR)
			f51_arg0.DrawLine:completeAnimation()
			f51_arg0.DrawLine:setLeftRight(-1, -0.93, 235, 235)
			f51_arg0.DrawLine:setTopBottom(0.16, 0.31, 21, 21)
			f51_arg0.DrawLine:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.DrawLine)
			f51_arg0.DrawLine2:completeAnimation()
			f51_arg0.DrawLine2:setTopBottom(0.48, 0.63, 12, 12)
			f51_arg0.DrawLine2:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.DrawLine2)
			f51_arg0.ADSCurve:completeAnimation()
			f51_arg0.ADSCurve:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.ADSCurve)
		end,
		ChargingShotADS = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(8)
			f52_arg0.BowLauncherReticleL1:completeAnimation()
			f52_arg0.BowLauncherReticleL1:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.BowLauncherReticleL1)
			f52_arg0.BowLauncherReticleL2:completeAnimation()
			f52_arg0.BowLauncherReticleL2:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.BowLauncherReticleL2)
			f52_arg0.BowLauncherReticleL3:completeAnimation()
			f52_arg0.BowLauncherReticleL3:setAlpha(0)
			f52_arg0.clipFinished(f52_arg0.BowLauncherReticleL3)
			f52_arg0.WingL:completeAnimation()
			f52_arg0.WingL:setLeftRight(-1.31, -1.2, 264, 264)
			f52_arg0.WingL:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.WingL)
			f52_arg0.WingR:completeAnimation()
			f52_arg0.WingR:setLeftRight(-1.08, -0.96, 260, 260)
			f52_arg0.WingR:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.WingR)
			local f52_local0 = function(f53_arg0)
				f52_arg0.DrawLine:beginAnimation(50)
				f52_arg0.DrawLine:setAlpha(0)
				f52_arg0.DrawLine:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.DrawLine:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.DrawLine:completeAnimation()
			f52_arg0.DrawLine:setLeftRight(-1, -0.93, 235, 235)
			f52_arg0.DrawLine:setTopBottom(0.16, 0.31, 21, 21)
			f52_arg0.DrawLine:setAlpha(1)
			f52_local0(f52_arg0.DrawLine)
			f52_arg0.DrawLine2:completeAnimation()
			f52_arg0.DrawLine2:setTopBottom(0.48, 0.63, 12, 12)
			f52_arg0.DrawLine2:setAlpha(1)
			f52_arg0.clipFinished(f52_arg0.DrawLine2)
			local f52_local1 = function(f54_arg0)
				f52_arg0.ADSCurve:beginAnimation(50)
				f52_arg0.ADSCurve:setLeftRight(-0.48, -0.25, 144.5, 132.5)
				f52_arg0.ADSCurve:setTopBottom(0.29, 0.39, 16, 12)
				f52_arg0.ADSCurve:setAlpha(1)
				f52_arg0.ADSCurve:registerEventHandler("interrupted_keyframe", f52_arg0.clipInterrupted)
				f52_arg0.ADSCurve:registerEventHandler("transition_complete_keyframe", f52_arg0.clipFinished)
			end
			f52_arg0.ADSCurve:completeAnimation()
			f52_arg0.ADSCurve:setLeftRight(-0.37, -0.35, 138.5, 138.5)
			f52_arg0.ADSCurve:setTopBottom(-0.03, 0.09, 55, 55)
			f52_arg0.ADSCurve:setAlpha(0)
			f52_local1(f52_arg0.ADSCurve)
		end,
	},
	StartupComplete = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(4)
			f55_arg0.BowLauncherReticleDot:completeAnimation()
			f55_arg0.BowLauncherReticleDot:setRGB(1, 1, 1)
			f55_arg0.clipFinished(f55_arg0.BowLauncherReticleDot)
			f55_arg0.DrawLine:completeAnimation()
			f55_arg0.DrawLine:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.DrawLine)
			f55_arg0.DrawLine2:completeAnimation()
			f55_arg0.DrawLine2:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.DrawLine2)
			f55_arg0.ADSCurve:completeAnimation()
			f55_arg0.ADSCurve:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ADSCurve)
		end,
		ChargingShot = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(8)
			f56_arg0.BowLauncherReticleL1:completeAnimation()
			f56_arg0.BowLauncherReticleL1:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.BowLauncherReticleL1)
			local f56_local0 = function(f57_arg0)
				f56_arg0.BowLauncherReticleL2:beginAnimation(160)
				f56_arg0.BowLauncherReticleL2:setAlpha(0)
				f56_arg0.BowLauncherReticleL2:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.BowLauncherReticleL2:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.BowLauncherReticleL2:completeAnimation()
			f56_arg0.BowLauncherReticleL2:setAlpha(1)
			f56_local0(f56_arg0.BowLauncherReticleL2)
			local f56_local1 = function(f58_arg0)
				f56_arg0.BowLauncherReticleL3:beginAnimation(160)
				f56_arg0.BowLauncherReticleL3:setAlpha(0)
				f56_arg0.BowLauncherReticleL3:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.BowLauncherReticleL3:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
			end
			f56_arg0.BowLauncherReticleL3:completeAnimation()
			f56_arg0.BowLauncherReticleL3:setAlpha(1)
			f56_local1(f56_arg0.BowLauncherReticleL3)
			local f56_local2 = function(f59_arg0)
				local f59_local0 = function(f60_arg0)
					local f60_local0 = function(f61_arg0)
						f61_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f61_arg0:setLeftRight(-1.31, -1.2, 264, 264)
						f61_arg0:setAlpha(0.15)
						f61_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
					end
					f60_arg0:beginAnimation(150)
					f60_arg0:setLeftRight(-1.31, -1.2, 247, 247)
					f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
				end
				f56_arg0.WingL:beginAnimation(160)
				f56_arg0.WingL:setLeftRight(-1.31, -1.2, 233.94, 233.94)
				f56_arg0.WingL:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.WingL:registerEventHandler("transition_complete_keyframe", f59_local0)
			end
			f56_arg0.WingL:completeAnimation()
			f56_arg0.WingL:setLeftRight(-1.31, -1.2, 220, 220)
			f56_arg0.WingL:setAlpha(1)
			f56_local2(f56_arg0.WingL)
			local f56_local3 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					f63_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f63_arg0:setLeftRight(-1.08, -0.96, 260, 260)
					f63_arg0:setAlpha(0.15)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
				end
				f56_arg0.WingR:beginAnimation(310)
				f56_arg0.WingR:setLeftRight(-1.08, -0.96, 277, 277)
				f56_arg0.WingR:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.WingR:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f56_arg0.WingR:completeAnimation()
			f56_arg0.WingR:setLeftRight(-1.08, -0.96, 304, 304)
			f56_arg0.WingR:setAlpha(1)
			f56_local3(f56_arg0.WingR)
			local f56_local4 = function(f64_arg0)
				local f64_local0 = function(f65_arg0)
					local f65_local0 = function(f66_arg0)
						f66_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f66_arg0:setTopBottom(0.17, 0.32, 21, 21)
						f66_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
					end
					f65_arg0:beginAnimation(150)
					f65_arg0:setTopBottom(0.07, 0.22, 17, 17)
					f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
				end
				f56_arg0.DrawLine:beginAnimation(160)
				f56_arg0.DrawLine:setTopBottom(0.02, 0.17, 12, 12)
				f56_arg0.DrawLine:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.DrawLine:registerEventHandler("transition_complete_keyframe", f64_local0)
			end
			f56_arg0.DrawLine:completeAnimation()
			f56_arg0.DrawLine:setLeftRight(-1, -0.93, 235, 235)
			f56_arg0.DrawLine:setTopBottom(-0.02, 0.13, 12, 12)
			f56_arg0.DrawLine:setAlpha(1)
			f56_local4(f56_arg0.DrawLine)
			local f56_local5 = function(f67_arg0)
				local f67_local0 = function(f68_arg0)
					local f68_local0 = function(f69_arg0)
						f69_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f69_arg0:setTopBottom(0.48, 0.63, 12, 12)
						f69_arg0:registerEventHandler("transition_complete_keyframe", f56_arg0.clipFinished)
					end
					f68_arg0:beginAnimation(150)
					f68_arg0:setTopBottom(0.61, 0.76, 12, 12)
					f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
				end
				f56_arg0.DrawLine2:beginAnimation(160)
				f56_arg0.DrawLine2:setTopBottom(0.66, 0.81, 12, 12)
				f56_arg0.DrawLine2:setAlpha(1)
				f56_arg0.DrawLine2:registerEventHandler("interrupted_keyframe", f56_arg0.clipInterrupted)
				f56_arg0.DrawLine2:registerEventHandler("transition_complete_keyframe", f67_local0)
			end
			f56_arg0.DrawLine2:completeAnimation()
			f56_arg0.DrawLine2:setTopBottom(0.72, 0.87, 12, 12)
			f56_arg0.DrawLine2:setAlpha(0)
			f56_local5(f56_arg0.DrawLine2)
			f56_arg0.ADSCurve:completeAnimation()
			f56_arg0.ADSCurve:setAlpha(0)
			f56_arg0.clipFinished(f56_arg0.ADSCurve)
		end,
	},
	Initializing = {
		DefaultClip = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(8)
			local f70_local0 = function(f71_arg0)
				local f71_local0 = function(f72_arg0)
					f72_arg0:beginAnimation(69)
					f72_arg0:setAlpha(1)
					f72_arg0:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
				end
				f70_arg0.BowLauncherReticleL1:beginAnimation(90)
				f70_arg0.BowLauncherReticleL1:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
				f70_arg0.BowLauncherReticleL1:registerEventHandler("transition_complete_keyframe", f71_local0)
			end
			f70_arg0.BowLauncherReticleL1:completeAnimation()
			f70_arg0.BowLauncherReticleL1:setAlpha(0)
			f70_local0(f70_arg0.BowLauncherReticleL1)
			local f70_local1 = function(f73_arg0)
				f73_arg0:beginAnimation(80)
				f73_arg0:setAlpha(1)
				f73_arg0:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.BowLauncherReticleL2:beginAnimation(170)
			f70_arg0.BowLauncherReticleL2:setAlpha(0)
			f70_arg0.BowLauncherReticleL2:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
			f70_arg0.BowLauncherReticleL2:registerEventHandler("transition_complete_keyframe", f70_local1)
			local f70_local2 = function(f74_arg0)
				f74_arg0:beginAnimation(80)
				f74_arg0:setAlpha(1)
				f74_arg0:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.BowLauncherReticleL3:beginAnimation(250)
			f70_arg0.BowLauncherReticleL3:setAlpha(0)
			f70_arg0.BowLauncherReticleL3:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
			f70_arg0.BowLauncherReticleL3:registerEventHandler("transition_complete_keyframe", f70_local2)
			local f70_local3 = function(f75_arg0)
				f75_arg0:beginAnimation(80)
				f75_arg0:setAlpha(1)
				f75_arg0:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.BowLauncherReticleL4:beginAnimation(250)
			f70_arg0.BowLauncherReticleL4:setAlpha(0)
			f70_arg0.BowLauncherReticleL4:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
			f70_arg0.BowLauncherReticleL4:registerEventHandler("transition_complete_keyframe", f70_local3)
			local f70_local4 = function(f76_arg0)
				f76_arg0:beginAnimation(60)
				f76_arg0:setAlpha(1)
				f76_arg0:registerEventHandler("transition_complete_keyframe", f70_arg0.clipFinished)
			end
			f70_arg0.BowLauncherReticleDot:beginAnimation(40)
			f70_arg0.BowLauncherReticleDot:setAlpha(0)
			f70_arg0.BowLauncherReticleDot:registerEventHandler("interrupted_keyframe", f70_arg0.clipInterrupted)
			f70_arg0.BowLauncherReticleDot:registerEventHandler("transition_complete_keyframe", f70_local4)
			f70_arg0.DrawLine:completeAnimation()
			f70_arg0.DrawLine:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.DrawLine)
			f70_arg0.DrawLine2:completeAnimation()
			f70_arg0.DrawLine2:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.DrawLine2)
			f70_arg0.ADSCurve:completeAnimation()
			f70_arg0.ADSCurve:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.ADSCurve)
		end,
		ChargingShot = function(f77_arg0, f77_arg1)
			f77_arg0:__resetProperties()
			f77_arg0:setupElementClipCounter(8)
			f77_arg0.BowLauncherReticleL1:completeAnimation()
			f77_arg0.BowLauncherReticleL1:setAlpha(0)
			f77_arg0.clipFinished(f77_arg0.BowLauncherReticleL1)
			local f77_local0 = function(f78_arg0)
				f77_arg0.BowLauncherReticleL2:beginAnimation(160)
				f77_arg0.BowLauncherReticleL2:setAlpha(0)
				f77_arg0.BowLauncherReticleL2:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.BowLauncherReticleL2:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
			end
			f77_arg0.BowLauncherReticleL2:completeAnimation()
			f77_arg0.BowLauncherReticleL2:setAlpha(1)
			f77_local0(f77_arg0.BowLauncherReticleL2)
			local f77_local1 = function(f79_arg0)
				f77_arg0.BowLauncherReticleL3:beginAnimation(160)
				f77_arg0.BowLauncherReticleL3:setAlpha(0)
				f77_arg0.BowLauncherReticleL3:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.BowLauncherReticleL3:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
			end
			f77_arg0.BowLauncherReticleL3:completeAnimation()
			f77_arg0.BowLauncherReticleL3:setAlpha(1)
			f77_local1(f77_arg0.BowLauncherReticleL3)
			local f77_local2 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					local f81_local0 = function(f82_arg0)
						f82_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f82_arg0:setLeftRight(-1.31, -1.2, 264, 264)
						f82_arg0:setAlpha(0.15)
						f82_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
					end
					f81_arg0:beginAnimation(150)
					f81_arg0:setLeftRight(-1.31, -1.2, 247, 247)
					f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
				end
				f77_arg0.WingL:beginAnimation(160)
				f77_arg0.WingL:setLeftRight(-1.31, -1.2, 233.94, 233.94)
				f77_arg0.WingL:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.WingL:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f77_arg0.WingL:completeAnimation()
			f77_arg0.WingL:setLeftRight(-1.31, -1.2, 220, 220)
			f77_arg0.WingL:setAlpha(1)
			f77_local2(f77_arg0.WingL)
			local f77_local3 = function(f83_arg0)
				local f83_local0 = function(f84_arg0)
					f84_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f84_arg0:setLeftRight(-1.08, -0.96, 260, 260)
					f84_arg0:setAlpha(0.15)
					f84_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
				end
				f77_arg0.WingR:beginAnimation(310)
				f77_arg0.WingR:setLeftRight(-1.08, -0.96, 277, 277)
				f77_arg0.WingR:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.WingR:registerEventHandler("transition_complete_keyframe", f83_local0)
			end
			f77_arg0.WingR:completeAnimation()
			f77_arg0.WingR:setLeftRight(-1.08, -0.96, 304, 304)
			f77_arg0.WingR:setAlpha(1)
			f77_local3(f77_arg0.WingR)
			local f77_local4 = function(f85_arg0)
				local f85_local0 = function(f86_arg0)
					local f86_local0 = function(f87_arg0)
						f87_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f87_arg0:setTopBottom(0.17, 0.32, 21, 21)
						f87_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
					end
					f86_arg0:beginAnimation(150)
					f86_arg0:setTopBottom(0.07, 0.22, 17, 17)
					f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
				end
				f77_arg0.DrawLine:beginAnimation(160)
				f77_arg0.DrawLine:setTopBottom(0.02, 0.17, 12, 12)
				f77_arg0.DrawLine:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.DrawLine:registerEventHandler("transition_complete_keyframe", f85_local0)
			end
			f77_arg0.DrawLine:completeAnimation()
			f77_arg0.DrawLine:setLeftRight(-1, -0.93, 235, 235)
			f77_arg0.DrawLine:setTopBottom(-0.02, 0.13, 12, 12)
			f77_arg0.DrawLine:setAlpha(1)
			f77_local4(f77_arg0.DrawLine)
			local f77_local5 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					local f89_local0 = function(f90_arg0)
						f90_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f90_arg0:setTopBottom(0.48, 0.63, 12, 12)
						f90_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
					end
					f89_arg0:beginAnimation(150)
					f89_arg0:setTopBottom(0.61, 0.76, 12, 12)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
				end
				f77_arg0.DrawLine2:beginAnimation(160)
				f77_arg0.DrawLine2:setTopBottom(0.66, 0.81, 12, 12)
				f77_arg0.DrawLine2:setAlpha(1)
				f77_arg0.DrawLine2:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.DrawLine2:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f77_arg0.DrawLine2:completeAnimation()
			f77_arg0.DrawLine2:setTopBottom(0.72, 0.87, 12, 12)
			f77_arg0.DrawLine2:setAlpha(0)
			f77_local5(f77_arg0.DrawLine2)
			f77_arg0.ADSCurve:completeAnimation()
			f77_arg0.ADSCurve:setAlpha(0)
			f77_arg0.clipFinished(f77_arg0.ADSCurve)
		end,
	},
}
CoD.BowLauncherReticle_Internal.__onClose = function(f91_arg0)
	f91_arg0.BowLauncherReticleL1:close()
	f91_arg0.BowLauncherReticleL2:close()
	f91_arg0.BowLauncherReticleL3:close()
	f91_arg0.BowLauncherReticleL4:close()
	f91_arg0.BowLauncherReticleDot:close()
end

require("x64:e56c058f8224562")
require("x64:43b65b64b2fc4f8")
CoD.ScrStk_MeterInternal = InheritFrom(LUI.UIElement)
CoD.ScrStk_MeterInternal.__defaultWidth = 6
CoD.ScrStk_MeterInternal.__defaultHeight = 180
CoD.ScrStk_MeterInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_MeterInternal)
	self.id = "ScrStk_MeterInternal"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Back = LUI.UIImage.new(0.5, 0.5, -9, 3, 0.5, 0.5, -90, 90)
	Back:setRGB(0.51, 0.55, 0.64)
	Back:setAlpha(0)
	Back:setImage(RegisterImage(0xA1726B8A4CE14DC))
	self:addElement(Back)
	self.Back = Back
	local Fill = LUI.UIImage.new(0.5, 0.5, -9, 7, 0.5, 0.5, -58, 96)
	Fill:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Fill:setXRot(180)
	Fill:setImage(RegisterImage(0xBECC85DF0ADD5A3))
	Fill:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	Fill:setShaderVector(0, 1, 0, 0, 0)
	Fill:setShaderVector(1, 0, 0, 0, 0)
	Fill:setShaderVector(2, 1, 0, 0, 0)
	Fill:setShaderVector(3, 0, 0, 0, 0)
	Fill:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Fill)
	self.Fill = Fill
	local FocusMeterBack = LUI.UIImage.new(0.5, 0.5, -9, 3, 0.5, 0.5, -90, 90)
	FocusMeterBack:setRGB(0.22, 0.38, 0.52)
	FocusMeterBack:setAlpha(0)
	FocusMeterBack:setImage(RegisterImage(0x8F6C52A7DE4A976))
	self:addElement(FocusMeterBack)
	self.FocusMeterBack = FocusMeterBack
	local FocusMeterFill = LUI.UIImage.new(0.5, 0.5, -9, 3, 0.5, 0.5, 90, -90)
	FocusMeterFill:setRGB(0.15, 0.56, 0.88)
	FocusMeterFill:setAlpha(0)
	FocusMeterFill:setImage(RegisterImage(0xEA536493B5121C4))
	FocusMeterFill:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	FocusMeterFill:setShaderVector(0, 1, 0, 0, 0)
	FocusMeterFill:setShaderVector(1, 0, 0, 0, 0)
	FocusMeterFill:setShaderVector(2, 1, 0, 0, 0)
	FocusMeterFill:setShaderVector(3, 0, 0, 0, 0)
	FocusMeterFill:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FocusMeterFill)
	self.FocusMeterFill = FocusMeterFill
	local CombatEfficiencyPulse = CoD.ScrStk_CombatEfficiencyPulse.new(f1_arg0, f1_arg1, 0.5, 0.5, -119, 113, 0, 1, 3, -3)
	CombatEfficiencyPulse:setAlpha(0)
	CombatEfficiencyPulse:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(CombatEfficiencyPulse)
	self.CombatEfficiencyPulse = CombatEfficiencyPulse
	local FocusMeterFillWhite = CoD.ScrStk_MeterKarat.new(f1_arg0, f1_arg1, 0.5, 0.5, -9, 3, 0.5, 0.5, 80, 92)
	FocusMeterFillWhite:setAlpha(0)
	self:addElement(FocusMeterFillWhite)
	self.FocusMeterFillWhite = FocusMeterFillWhite
	self:mergeStateConditions({
		{
			stateName = "CombatEfficiency",
			condition = function(menu, element, event)
				return IsSpecificGadgetInUse(f1_arg1, element, "gadget_combat_efficiency")
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.ScorestreakSelectUtility.ScorestreakMeterPostLoad(self, f1_arg1)
	return self
end
CoD.ScrStk_MeterInternal.__resetProperties = function(f5_arg0)
	f5_arg0.Fill:completeAnimation()
	f5_arg0.Back:completeAnimation()
	f5_arg0.CombatEfficiencyPulse:completeAnimation()
	f5_arg0.FocusMeterBack:completeAnimation()
	f5_arg0.FocusMeterFill:completeAnimation()
	f5_arg0.FocusMeterFillWhite:completeAnimation()
	f5_arg0.Fill:setAlpha(1)
	f5_arg0.Back:setAlpha(0)
	f5_arg0.CombatEfficiencyPulse:setAlpha(0)
	f5_arg0.FocusMeterBack:setRGB(0.22, 0.38, 0.52)
	f5_arg0.FocusMeterBack:setAlpha(0)
	f5_arg0.FocusMeterFill:setAlpha(0)
	f5_arg0.FocusMeterFillWhite:setAlpha(0)
end
CoD.ScrStk_MeterInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		CombatEfficiency = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(6)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Back:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f7_arg0.Back:setAlpha(0)
				f7_arg0.Back:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Back:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Back:completeAnimation()
			f7_arg0.Back:setAlpha(0.5)
			f7_local0(f7_arg0.Back)
			local f7_local1 = function(f9_arg0)
				f7_arg0.Fill:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f7_arg0.Fill:setAlpha(0)
				f7_arg0.Fill:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Fill:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Fill:completeAnimation()
			f7_arg0.Fill:setAlpha(1)
			f7_local1(f7_arg0.Fill)
			local f7_local2 = function(f10_arg0)
				f7_arg0.FocusMeterBack:beginAnimation(300)
				f7_arg0.FocusMeterBack:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FocusMeterBack:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FocusMeterBack:completeAnimation()
			f7_arg0.FocusMeterBack:setRGB(0.22, 0.38, 0.52)
			f7_arg0.FocusMeterBack:setAlpha(0)
			f7_local2(f7_arg0.FocusMeterBack)
			local f7_local3 = function(f11_arg0)
				f7_arg0.FocusMeterFill:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f7_arg0.FocusMeterFill:setAlpha(1)
				f7_arg0.FocusMeterFill:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FocusMeterFill:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FocusMeterFill:completeAnimation()
			f7_arg0.FocusMeterFill:setAlpha(0)
			f7_local3(f7_arg0.FocusMeterFill)
			local f7_local4 = function(f12_arg0)
				f7_arg0.CombatEfficiencyPulse:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f7_arg0.CombatEfficiencyPulse:setAlpha(1)
				f7_arg0.CombatEfficiencyPulse:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.CombatEfficiencyPulse:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.CombatEfficiencyPulse:completeAnimation()
			f7_arg0.CombatEfficiencyPulse:setAlpha(0)
			f7_local4(f7_arg0.CombatEfficiencyPulse)
			local f7_local5 = function(f13_arg0)
				f7_arg0.FocusMeterFillWhite:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f7_arg0.FocusMeterFillWhite:setAlpha(1)
				f7_arg0.FocusMeterFillWhite:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FocusMeterFillWhite:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FocusMeterFillWhite:completeAnimation()
			f7_arg0.FocusMeterFillWhite:setAlpha(0)
			f7_local5(f7_arg0.FocusMeterFillWhite)
		end,
	},
	CombatEfficiency = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.Back:completeAnimation()
			f14_arg0.Back:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Back)
			f14_arg0.Fill:completeAnimation()
			f14_arg0.Fill:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Fill)
			f14_arg0.FocusMeterFill:completeAnimation()
			f14_arg0.FocusMeterFill:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.FocusMeterFill)
			f14_arg0.CombatEfficiencyPulse:completeAnimation()
			f14_arg0.CombatEfficiencyPulse:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.CombatEfficiencyPulse)
			f14_arg0.FocusMeterFillWhite:completeAnimation()
			f14_arg0.FocusMeterFillWhite:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.FocusMeterFillWhite)
		end,
		DefaultState = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(6)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Back:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f15_arg0.Back:setAlpha(0.5)
				f15_arg0.Back:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Back:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Back:completeAnimation()
			f15_arg0.Back:setAlpha(0)
			f15_local0(f15_arg0.Back)
			local f15_local1 = function(f17_arg0)
				f15_arg0.Fill:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f15_arg0.Fill:setAlpha(1)
				f15_arg0.Fill:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Fill:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Fill:completeAnimation()
			f15_arg0.Fill:setAlpha(0)
			f15_local1(f15_arg0.Fill)
			local f15_local2 = function(f18_arg0)
				f15_arg0.FocusMeterBack:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f15_arg0.FocusMeterBack:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.FocusMeterBack:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.FocusMeterBack:completeAnimation()
			f15_arg0.FocusMeterBack:setAlpha(0)
			f15_local2(f15_arg0.FocusMeterBack)
			local f15_local3 = function(f19_arg0)
				f15_arg0.FocusMeterFill:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f15_arg0.FocusMeterFill:setAlpha(0)
				f15_arg0.FocusMeterFill:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.FocusMeterFill:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.FocusMeterFill:completeAnimation()
			f15_arg0.FocusMeterFill:setAlpha(1)
			f15_local3(f15_arg0.FocusMeterFill)
			local f15_local4 = function(f20_arg0)
				f15_arg0.CombatEfficiencyPulse:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f15_arg0.CombatEfficiencyPulse:setAlpha(0)
				f15_arg0.CombatEfficiencyPulse:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.CombatEfficiencyPulse:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.CombatEfficiencyPulse:completeAnimation()
			f15_arg0.CombatEfficiencyPulse:setAlpha(1)
			f15_local4(f15_arg0.CombatEfficiencyPulse)
			local f15_local5 = function(f21_arg0)
				f15_arg0.FocusMeterFillWhite:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f15_arg0.FocusMeterFillWhite:setAlpha(0)
				f15_arg0.FocusMeterFillWhite:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.FocusMeterFillWhite:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.FocusMeterFillWhite:completeAnimation()
			f15_arg0.FocusMeterFillWhite:setAlpha(1)
			f15_local5(f15_arg0.FocusMeterFillWhite)
		end,
	},
}
CoD.ScrStk_MeterInternal.__onClose = function(f22_arg0)
	f22_arg0.CombatEfficiencyPulse:close()
	f22_arg0.FocusMeterFillWhite:close()
end

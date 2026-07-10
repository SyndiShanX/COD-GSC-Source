require("x64:221a97cdde7b25d")
require("x64:f027a1f1c4219b3")
require("x64:3cceba23a026334")
require("x64:dba761763bfd768")
CoD.VHUDHawkInternal = InheritFrom(LUI.UIElement)
CoD.VHUDHawkInternal.__defaultWidth = 1920
CoD.VHUDHawkInternal.__defaultHeight = 1080
CoD.VHUDHawkInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.hawkWeakSignal", 0)
	self:setClass(CoD.VHUDHawkInternal)
	self.id = "VHUDHawkInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HawkReticle = CoD.VHUDHawkReticle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	HawkReticle:linkToElementModel(self, nil, false, function(model)
		HawkReticle:setModel(model, f1_arg1)
	end)
	self:addElement(HawkReticle)
	self.HawkReticle = HawkReticle
	local f1_local2 = nil
	self.FlyUpPrompt = LUI.UIElement.createFake()
	local f1_local3 = nil
	self.FlyDownPrompt = LUI.UIElement.createFake()
	local VHUDHawkWeakSignal = CoD.VHUDHawkWeakSignal.new(f1_arg0, f1_arg1, 0.5, 0.5, -97.5, 97.5, 1, 1, -243, -145)
	VHUDHawkWeakSignal:setAlpha(0)
	self:addElement(VHUDHawkWeakSignal)
	self.VHUDHawkWeakSignal = VHUDHawkWeakSignal
	local Speed = CoD.vhud_hellstorm_SpeedWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, -280, 0.5, 0.5, -6.5, 26.5)
	Speed:linkToElementModel(self, nil, false, function(model)
		Speed:setModel(model, f1_arg1)
	end)
	self:addElement(Speed)
	self.Speed = Speed
	local AltMeterL = CoD.vhud_hellstorm_AltWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 288, 508, 0.5, 0.5, -6.5, 26.5)
	AltMeterL:linkToElementModel(self, nil, false, function(model)
		AltMeterL:setModel(model, f1_arg1)
	end)
	self:addElement(AltMeterL)
	self.AltMeterL = AltMeterL
	self:mergeStateConditions({
		{
			stateName = "WeakSignal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hawkWeakSignal", 0)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.hawkWeakSignal"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.hawkWeakSignal",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	if IsPC() then
		SizeToHudArea(self.HawkReticle, f1_arg1)
	end
	return self
end
CoD.VHUDHawkInternal.__resetProperties = function(f7_arg0)
	f7_arg0.VHUDHawkWeakSignal:completeAnimation()
	f7_arg0.VHUDHawkWeakSignal:setAlpha(0)
end
CoD.VHUDHawkInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	WeakSignal = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.VHUDHawkWeakSignal:beginAnimation(200)
				f9_arg0.VHUDHawkWeakSignal:setAlpha(1)
				f9_arg0.VHUDHawkWeakSignal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.VHUDHawkWeakSignal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.VHUDHawkWeakSignal:completeAnimation()
			f9_arg0.VHUDHawkWeakSignal:setAlpha(0)
			f9_local0(f9_arg0.VHUDHawkWeakSignal)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.VHUDHawkWeakSignal:beginAnimation(200)
				f11_arg0.VHUDHawkWeakSignal:setAlpha(0)
				f11_arg0.VHUDHawkWeakSignal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.VHUDHawkWeakSignal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.VHUDHawkWeakSignal:completeAnimation()
			f11_arg0.VHUDHawkWeakSignal:setAlpha(1)
			f11_local0(f11_arg0.VHUDHawkWeakSignal)
		end,
	},
}
CoD.VHUDHawkInternal.__onClose = function(f13_arg0)
	f13_arg0.HawkReticle:close()
	f13_arg0.FlyUpPrompt:close()
	f13_arg0.FlyDownPrompt:close()
	f13_arg0.VHUDHawkWeakSignal:close()
	f13_arg0.Speed:close()
	f13_arg0.AltMeterL:close()
end

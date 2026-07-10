require("x64:97483b442684eeb")
CoD.ReservesSpecialContract = InheritFrom(LUI.UIElement)
CoD.ReservesSpecialContract.__defaultWidth = 684
CoD.ReservesSpecialContract.__defaultHeight = 132
CoD.ReservesSpecialContract.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesSpecialContract)
	self.id = "ReservesSpecialContract"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReservesPromo = CoD.ReservesSpecialContractInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 684, 0, 0, 0, 132)
	ReservesPromo:linkToElementModel(self, nil, false, function(model)
		ReservesPromo:setModel(model, f1_arg1)
	end)
	self:addElement(ReservesPromo)
	self.ReservesPromo = ReservesPromo
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "active")
			end,
		},
	})
	self:linkToElementModel(self, "active", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "active",
		})
	end)
	ReservesPromo.id = "ReservesPromo"
	self.__defaultFocus = ReservesPromo
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesSpecialContract.__resetProperties = function(f5_arg0)
	f5_arg0.ReservesPromo:completeAnimation()
	f5_arg0.ReservesPromo:setAlpha(1)
	f5_arg0.ReservesPromo:setScale(1, 1)
end
CoD.ReservesSpecialContract.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ReservesPromo:completeAnimation()
			f7_arg0.ReservesPromo:setScale(1.02, 1.02)
			f7_arg0.clipFinished(f7_arg0.ReservesPromo)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ReservesPromo:beginAnimation(200)
				f8_arg0.ReservesPromo:setScale(1.02, 1.02)
				f8_arg0.ReservesPromo:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ReservesPromo:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ReservesPromo:completeAnimation()
			f8_arg0.ReservesPromo:setScale(1, 1)
			f8_local0(f8_arg0.ReservesPromo)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.ReservesPromo:beginAnimation(100)
				f10_arg0.ReservesPromo:setScale(1, 1)
				f10_arg0.ReservesPromo:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ReservesPromo:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ReservesPromo:completeAnimation()
			f10_arg0.ReservesPromo:setScale(1.02, 1.02)
			f10_local0(f10_arg0.ReservesPromo)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ReservesPromo:completeAnimation()
			f12_arg0.ReservesPromo:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ReservesPromo)
		end,
	},
}
CoD.ReservesSpecialContract.__onClose = function(f13_arg0)
	f13_arg0.ReservesPromo:close()
end

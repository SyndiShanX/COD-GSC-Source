require("x64:595834f2b669b05")
CoD.ReservesPromoContainer = InheritFrom(LUI.UIElement)
CoD.ReservesPromoContainer.__defaultWidth = 556
CoD.ReservesPromoContainer.__defaultHeight = 132
CoD.ReservesPromoContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesPromoContainer)
	self.id = "ReservesPromoContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReservesPromo = CoD.ReservesPromoInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 556, 0, 0, 0, 132)
	ReservesPromo:linkToElementModel(self, nil, false, function(model)
		ReservesPromo:setModel(model, f1_arg1)
	end)
	self:addElement(ReservesPromo)
	self.ReservesPromo = ReservesPromo
	ReservesPromo.id = "ReservesPromo"
	self.__defaultFocus = ReservesPromo
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesPromoContainer.__resetProperties = function(f3_arg0)
	f3_arg0.ReservesPromo:completeAnimation()
	f3_arg0.ReservesPromo:setScale(1, 1)
end
CoD.ReservesPromoContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ReservesPromo:completeAnimation()
			f5_arg0.ReservesPromo:setScale(1.02, 1.02)
			f5_arg0.clipFinished(f5_arg0.ReservesPromo)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.ReservesPromo:beginAnimation(200)
				f6_arg0.ReservesPromo:setScale(1.02, 1.02)
				f6_arg0.ReservesPromo:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ReservesPromo:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.ReservesPromo:completeAnimation()
			f6_arg0.ReservesPromo:setScale(1, 1)
			f6_local0(f6_arg0.ReservesPromo)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ReservesPromo:beginAnimation(100)
				f8_arg0.ReservesPromo:setScale(1, 1)
				f8_arg0.ReservesPromo:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ReservesPromo:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ReservesPromo:completeAnimation()
			f8_arg0.ReservesPromo:setScale(1.02, 1.02)
			f8_local0(f8_arg0.ReservesPromo)
		end,
	},
}
CoD.ReservesPromoContainer.__onClose = function(f10_arg0)
	f10_arg0.ReservesPromo:close()
end

require("x64:a94557301609cd0")
CoD.ReservesLootPurchaseBundleButtonContainer = InheritFrom(LUI.UIElement)
CoD.ReservesLootPurchaseBundleButtonContainer.__defaultWidth = 248
CoD.ReservesLootPurchaseBundleButtonContainer.__defaultHeight = 462
CoD.ReservesLootPurchaseBundleButtonContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesLootPurchaseBundleButtonContainer)
	self.id = "ReservesLootPurchaseBundleButtonContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReservesItemHorizontal = CoD.ReservesLootPurchaseBundleButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -124, 124, 0.5, 0.5, -231, 231)
	ReservesItemHorizontal:linkToElementModel(self, nil, false, function(model)
		ReservesItemHorizontal:setModel(model, f1_arg1)
	end)
	self:addElement(ReservesItemHorizontal)
	self.ReservesItemHorizontal = ReservesItemHorizontal
	ReservesItemHorizontal.id = "ReservesItemHorizontal"
	self.__defaultFocus = ReservesItemHorizontal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesLootPurchaseBundleButtonContainer.__resetProperties = function(f3_arg0)
	f3_arg0.ReservesItemHorizontal:completeAnimation()
	f3_arg0.ReservesItemHorizontal:setScale(1, 1)
end
CoD.ReservesLootPurchaseBundleButtonContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ReservesItemHorizontal:completeAnimation()
			f5_arg0.ReservesItemHorizontal:setScale(1.02, 1.02)
			f5_arg0.clipFinished(f5_arg0.ReservesItemHorizontal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.ReservesItemHorizontal:beginAnimation(200)
				f6_arg0.ReservesItemHorizontal:setScale(1.02, 1.02)
				f6_arg0.ReservesItemHorizontal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ReservesItemHorizontal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.ReservesItemHorizontal:completeAnimation()
			f6_arg0.ReservesItemHorizontal:setScale(1, 1)
			f6_local0(f6_arg0.ReservesItemHorizontal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ReservesItemHorizontal:beginAnimation(100)
				f8_arg0.ReservesItemHorizontal:setScale(1, 1)
				f8_arg0.ReservesItemHorizontal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ReservesItemHorizontal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ReservesItemHorizontal:completeAnimation()
			f8_arg0.ReservesItemHorizontal:setScale(1.02, 1.02)
			f8_local0(f8_arg0.ReservesItemHorizontal)
		end,
	},
}
CoD.ReservesLootPurchaseBundleButtonContainer.__onClose = function(f10_arg0)
	f10_arg0.ReservesItemHorizontal:close()
end

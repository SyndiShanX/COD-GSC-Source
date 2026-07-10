require("x64:27d58cfb8220372")
CoD.CallingCardsSet_BlackMarketWidget = InheritFrom(LUI.UIElement)
CoD.CallingCardsSet_BlackMarketWidget.__defaultWidth = 360
CoD.CallingCardsSet_BlackMarketWidget.__defaultHeight = 126
CoD.CallingCardsSet_BlackMarketWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCardsSet_BlackMarketWidget)
	self.id = "CallingCardsSet_BlackMarketWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardsSetBlackMarketWidgetInternal = CoD.CallingCardsSet_BlackMarketWidgetInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0.5, 0.5, -63, 63)
	CallingCardsSetBlackMarketWidgetInternal:linkToElementModel(self, nil, false, function(model)
		CallingCardsSetBlackMarketWidgetInternal:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsSetBlackMarketWidgetInternal)
	self.CallingCardsSetBlackMarketWidgetInternal = CallingCardsSetBlackMarketWidgetInternal
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		UpdateElementState(self, "NoiseTiledBacking", controller)
	end)
	CallingCardsSetBlackMarketWidgetInternal.id = "CallingCardsSetBlackMarketWidgetInternal"
	self.__defaultFocus = CallingCardsSetBlackMarketWidgetInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCardsSet_BlackMarketWidget.__resetProperties = function(f4_arg0)
	f4_arg0.CallingCardsSetBlackMarketWidgetInternal:completeAnimation()
	f4_arg0.CallingCardsSetBlackMarketWidgetInternal:setScale(1, 1)
end
CoD.CallingCardsSet_BlackMarketWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.CallingCardsSetBlackMarketWidgetInternal:completeAnimation()
			f6_arg0.CallingCardsSetBlackMarketWidgetInternal:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.CallingCardsSetBlackMarketWidgetInternal)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.CallingCardsSetBlackMarketWidgetInternal:beginAnimation(200)
				f7_arg0.CallingCardsSetBlackMarketWidgetInternal:setScale(1.05, 1.05)
				f7_arg0.CallingCardsSetBlackMarketWidgetInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.CallingCardsSetBlackMarketWidgetInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.CallingCardsSetBlackMarketWidgetInternal:completeAnimation()
			f7_arg0.CallingCardsSetBlackMarketWidgetInternal:setScale(1, 1)
			f7_local0(f7_arg0.CallingCardsSetBlackMarketWidgetInternal)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.CallingCardsSetBlackMarketWidgetInternal:beginAnimation(200)
				f9_arg0.CallingCardsSetBlackMarketWidgetInternal:setScale(1, 1)
				f9_arg0.CallingCardsSetBlackMarketWidgetInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.CallingCardsSetBlackMarketWidgetInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.CallingCardsSetBlackMarketWidgetInternal:completeAnimation()
			f9_arg0.CallingCardsSetBlackMarketWidgetInternal:setScale(1.05, 1.05)
			f9_local0(f9_arg0.CallingCardsSetBlackMarketWidgetInternal)
		end,
	},
}
CoD.CallingCardsSet_BlackMarketWidget.__onClose = function(f11_arg0)
	f11_arg0.CallingCardsSetBlackMarketWidgetInternal:close()
end

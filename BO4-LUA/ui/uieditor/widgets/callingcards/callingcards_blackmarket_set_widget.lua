require("x64:5d1185ed0a5c4a2")
CoD.CallingCards_BlackMarket_Set_Widget = InheritFrom(LUI.UIElement)
CoD.CallingCards_BlackMarket_Set_Widget.__defaultWidth = 453
CoD.CallingCards_BlackMarket_Set_Widget.__defaultHeight = 202
CoD.CallingCards_BlackMarket_Set_Widget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_BlackMarket_Set_Widget)
	self.id = "CallingCards_BlackMarket_Set_Widget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardsBlackMarketSetWidgetInternal = CoD.CallingCards_BlackMarket_Set_WidgetInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -226.5, 226.5, 0.5, 0.5, -101, 101)
	CallingCardsBlackMarketSetWidgetInternal:linkToElementModel(self, nil, false, function(model)
		CallingCardsBlackMarketSetWidgetInternal:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsBlackMarketSetWidgetInternal)
	self.CallingCardsBlackMarketSetWidgetInternal = CallingCardsBlackMarketSetWidgetInternal
	CallingCardsBlackMarketSetWidgetInternal.id = "CallingCardsBlackMarketSetWidgetInternal"
	self.__defaultFocus = CallingCardsBlackMarketSetWidgetInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_BlackMarket_Set_Widget.__resetProperties = function(f3_arg0)
	f3_arg0.CallingCardsBlackMarketSetWidgetInternal:completeAnimation()
	f3_arg0.CallingCardsBlackMarketSetWidgetInternal:setScale(1, 1)
end
CoD.CallingCards_BlackMarket_Set_Widget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CallingCardsBlackMarketSetWidgetInternal:completeAnimation()
			f5_arg0.CallingCardsBlackMarketSetWidgetInternal:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.CallingCardsBlackMarketSetWidgetInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CallingCardsBlackMarketSetWidgetInternal:beginAnimation(200)
				f6_arg0.CallingCardsBlackMarketSetWidgetInternal:setScale(1.05, 1.05)
				f6_arg0.CallingCardsBlackMarketSetWidgetInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CallingCardsBlackMarketSetWidgetInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CallingCardsBlackMarketSetWidgetInternal:completeAnimation()
			f6_arg0.CallingCardsBlackMarketSetWidgetInternal:setScale(1, 1)
			f6_local0(f6_arg0.CallingCardsBlackMarketSetWidgetInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CallingCardsBlackMarketSetWidgetInternal:beginAnimation(200)
				f8_arg0.CallingCardsBlackMarketSetWidgetInternal:setScale(1, 1)
				f8_arg0.CallingCardsBlackMarketSetWidgetInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CallingCardsBlackMarketSetWidgetInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CallingCardsBlackMarketSetWidgetInternal:completeAnimation()
			f8_arg0.CallingCardsBlackMarketSetWidgetInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.CallingCardsBlackMarketSetWidgetInternal)
		end,
	},
}
CoD.CallingCards_BlackMarket_Set_Widget.__onClose = function(f10_arg0)
	f10_arg0.CallingCardsBlackMarketSetWidgetInternal:close()
end

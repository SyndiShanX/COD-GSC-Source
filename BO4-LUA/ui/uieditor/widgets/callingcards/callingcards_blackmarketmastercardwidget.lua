require("x64:7b3a7af0731a398")
CoD.CallingCards_BlackMarketMasterCardWidget = InheritFrom(LUI.UIElement)
CoD.CallingCards_BlackMarketMasterCardWidget.__defaultWidth = 1131
CoD.CallingCards_BlackMarketMasterCardWidget.__defaultHeight = 100
CoD.CallingCards_BlackMarketMasterCardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_BlackMarketMasterCardWidget)
	self.id = "CallingCards_BlackMarketMasterCardWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardsBlackMarketMasterCardWidgetInternal = CoD.CallingCards_BlackMarketMasterCardWidgetInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -565.5, 565.5, 0.5, 0.5, -50, 50)
	CallingCardsBlackMarketMasterCardWidgetInternal:linkToElementModel(self, nil, false, function(model)
		CallingCardsBlackMarketMasterCardWidgetInternal:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsBlackMarketMasterCardWidgetInternal)
	self.CallingCardsBlackMarketMasterCardWidgetInternal = CallingCardsBlackMarketMasterCardWidgetInternal
	CallingCardsBlackMarketMasterCardWidgetInternal.id = "CallingCardsBlackMarketMasterCardWidgetInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_BlackMarketMasterCardWidget.__resetProperties = function(f3_arg0)
	f3_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:completeAnimation()
	f3_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setAlpha(1)
	f3_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setScale(1, 1)
end
CoD.CallingCards_BlackMarketMasterCardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:completeAnimation()
			f5_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.CallingCardsBlackMarketMasterCardWidgetInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:beginAnimation(200)
				f6_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setScale(1.05, 1.05)
				f6_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:completeAnimation()
			f6_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setScale(1, 1)
			f6_local0(f6_arg0.CallingCardsBlackMarketMasterCardWidgetInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:beginAnimation(200)
				f8_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setScale(1, 1)
				f8_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:completeAnimation()
			f8_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.CallingCardsBlackMarketMasterCardWidgetInternal)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:completeAnimation()
			f10_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CallingCardsBlackMarketMasterCardWidgetInternal)
		end,
	},
}
CoD.CallingCards_BlackMarketMasterCardWidget.__onClose = function(f11_arg0)
	f11_arg0.CallingCardsBlackMarketMasterCardWidgetInternal:close()
end

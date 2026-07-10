require("x64:c77c8cd900dd009")
CoD.CallingCards_BlackMarket_CardWidget = InheritFrom(LUI.UIElement)
CoD.CallingCards_BlackMarket_CardWidget.__defaultWidth = 360
CoD.CallingCards_BlackMarket_CardWidget.__defaultHeight = 90
CoD.CallingCards_BlackMarket_CardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_BlackMarket_CardWidget)
	self.id = "CallingCards_BlackMarket_CardWidget"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCards = CoD.CallingCards_BlackMarket_CardWidgetInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0.5, 0.5, -45, 45)
	CallingCards:linkToElementModel(self, nil, false, function(model)
		CallingCards:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCards)
	self.CallingCards = CallingCards
	CallingCards.id = "CallingCards"
	self.__defaultFocus = CallingCards
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_BlackMarket_CardWidget.__resetProperties = function(f3_arg0)
	f3_arg0.CallingCards:completeAnimation()
	f3_arg0.CallingCards:setScale(1, 1)
end
CoD.CallingCards_BlackMarket_CardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CallingCards:completeAnimation()
			f5_arg0.CallingCards:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.CallingCards)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CallingCards:beginAnimation(200)
				f6_arg0.CallingCards:setScale(1.05, 1.05)
				f6_arg0.CallingCards:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CallingCards:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CallingCards:completeAnimation()
			f6_arg0.CallingCards:setScale(1, 1)
			f6_local0(f6_arg0.CallingCards)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CallingCards:beginAnimation(200)
				f8_arg0.CallingCards:setScale(1, 1)
				f8_arg0.CallingCards:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CallingCards:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CallingCards:completeAnimation()
			f8_arg0.CallingCards:setScale(1.05, 1.05)
			f8_local0(f8_arg0.CallingCards)
		end,
	},
}
CoD.CallingCards_BlackMarket_CardWidget.__onClose = function(f10_arg0)
	f10_arg0.CallingCards:close()
end

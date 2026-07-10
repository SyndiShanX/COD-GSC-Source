require("x64:228a7baa572b047")
CoD.InspectionGamerCardInternalWidget = InheritFrom(LUI.UIElement)
CoD.InspectionGamerCardInternalWidget.__defaultWidth = 348
CoD.InspectionGamerCardInternalWidget.__defaultHeight = 87
CoD.InspectionGamerCardInternalWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionGamerCardInternalWidget)
	self.id = "InspectionGamerCardInternalWidget"
	self.soundSet = "ModeSelection"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -268.5, 268.5, 0.5, 0.5, -67, 67)
	CallingCardsFrameWidget:setScale(0.65, 0.65)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionGamerCardInternalWidget.__resetProperties = function(f3_arg0)
	f3_arg0.CallingCardsFrameWidget:completeAnimation()
	f3_arg0.CallingCardsFrameWidget:setAlpha(1)
end
CoD.InspectionGamerCardInternalWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CallingCardsFrameWidget:completeAnimation()
			f5_arg0.CallingCardsFrameWidget:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CallingCardsFrameWidget)
		end,
	},
}
CoD.InspectionGamerCardInternalWidget.__onClose = function(f6_arg0)
	f6_arg0.CallingCardsFrameWidget:close()
end

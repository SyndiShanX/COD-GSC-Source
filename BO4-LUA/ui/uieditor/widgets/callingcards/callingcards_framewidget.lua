require("ui/uieditor/widgets/callingcards/callingcards_basicimage")
CoD.CallingCards_FrameWidget = InheritFrom(LUI.UIElement)
CoD.CallingCards_FrameWidget.__defaultWidth = 720
CoD.CallingCards_FrameWidget.__defaultHeight = 180
CoD.CallingCards_FrameWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_FrameWidget)
	self.id = "CallingCards_FrameWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CardIconFrame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	CardIconFrame:setLeftRight(0, 1, 0, 0)
	CardIconFrame:setTopBottom(0, 1, 0, 0)
	CardIconFrame:changeFrameWidget(CoD.CallingCards_BasicImage)
	CardIconFrame:linkToElementModel(self, nil, false, function(model)
		CardIconFrame:setModel(model, f1_arg1)
	end)
	CardIconFrame:linkToElementModel(self, nil, true, function(model)
		CoD.ChallengesUtility.UpdateCallingCard(f1_arg0, f1_arg1, self, CardIconFrame, model)
	end)
	self:addElement(CardIconFrame)
	self.CardIconFrame = CardIconFrame
	CardIconFrame.id = "CardIconFrame"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.CallingCards_FrameWidget.__onClose = function(f4_arg0)
	f4_arg0.CardIconFrame:close()
end

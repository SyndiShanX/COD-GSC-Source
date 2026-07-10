require("x64:a1112c4f772a43c")
CoD.KillcamKilledByAttachmentsLine = InheritFrom(LUI.UIElement)
CoD.KillcamKilledByAttachmentsLine.__defaultWidth = 375
CoD.KillcamKilledByAttachmentsLine.__defaultHeight = 35
CoD.KillcamKilledByAttachmentsLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.KillcamKilledByAttachmentsLine)
	self.id = "KillcamKilledByAttachmentsLine"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, -12, 12, 0, 0, 0, 35)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.6)
	self:addElement(Background)
	self.Background = Background
	local Attachment0 = CoD.KillcamKilledByAttachmentLabel.new(f1_arg0, f1_arg1, 0, 0, 250, 375, 0, 0, 8.5, 26.5)
	Attachment0:mergeStateConditions({
		{
			stateName = "HidePlus",
			condition = function(menu, element, event)
				return not IsSelfInState(self, "ExtraAttachments")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(Attachment0, "setWidth", function(element, controller)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Attachment0)
	self.Attachment0 = Attachment0
	local Attachment1 = CoD.KillcamKilledByAttachmentLabel.new(f1_arg0, f1_arg1, 0, 0, 125, 250, 0, 0, 8.5, 26.5)
	Attachment1:mergeStateConditions({
		{
			stateName = "HidePlus",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(Attachment1, "setWidth", function(element, controller)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Attachment1)
	self.Attachment1 = Attachment1
	local Attachment2 = CoD.KillcamKilledByAttachmentLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 125, 0, 0, 8.5, 26.5)
	Attachment2:mergeStateConditions({
		{
			stateName = "HidePlus",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(Attachment2, "setWidth", function(element, controller)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Attachment2)
	self.Attachment2 = Attachment2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	if IsCurrentLanguageReversed() then
		ReverseChildrenOrder(self)
	end
	return self
end
CoD.KillcamKilledByAttachmentsLine.__onClose = function(f8_arg0)
	f8_arg0.Attachment0:close()
	f8_arg0.Attachment1:close()
	f8_arg0.Attachment2:close()
end

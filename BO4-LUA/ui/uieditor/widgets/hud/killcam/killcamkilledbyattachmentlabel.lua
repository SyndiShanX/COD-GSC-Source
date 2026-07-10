CoD.KillcamKilledByAttachmentLabel = InheritFrom(LUI.UIElement)
CoD.KillcamKilledByAttachmentLabel.__defaultWidth = 125
CoD.KillcamKilledByAttachmentLabel.__defaultHeight = 18
CoD.KillcamKilledByAttachmentLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 6, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.KillcamKilledByAttachmentLabel)
	self.id = "KillcamKilledByAttachmentLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Plus = LUI.UIText.new(0, 0, 0, 9, 0.5, 0.5, -9, 9)
	Plus:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/plus"))
	Plus:setTTF("0arame_mono_stencil")
	Plus:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Plus)
	self.Plus = Plus
	local Attachment = LUI.UIText.new(0, 0, 15, 219, 0.5, 0.5, -9, 9)
	Attachment:setText("")
	Attachment:setTTF("0arame_mono_stencil")
	Attachment:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachment:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(Attachment, "setText", function(element, controller)
		UpdateSelfState(self, f1_arg1)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Attachment)
	self.Attachment = Attachment
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not ElementHasText(self, "Attachment")
			end,
		},
		{
			stateName = "HidePlus",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	if IsCurrentLanguageReversed() then
		ReverseChildrenOrder(self)
	end
	return self
end
CoD.KillcamKilledByAttachmentLabel.__resetProperties = function(f5_arg0)
	f5_arg0.Plus:completeAnimation()
	f5_arg0.Attachment:completeAnimation()
	f5_arg0.Plus:setAlpha(1)
	f5_arg0.Attachment:setAlpha(1)
end
CoD.KillcamKilledByAttachmentLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Plus:completeAnimation()
			f7_arg0.Plus:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Plus)
			f7_arg0.Attachment:completeAnimation()
			f7_arg0.Attachment:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Attachment)
		end,
	},
	HidePlus = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Plus:completeAnimation()
			f8_arg0.Plus:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Plus)
		end,
	},
}

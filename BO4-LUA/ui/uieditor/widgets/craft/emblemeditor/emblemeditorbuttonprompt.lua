CoD.EmblemEditorButtonPrompt = InheritFrom(LUI.UIElement)
CoD.EmblemEditorButtonPrompt.__defaultWidth = 321
CoD.EmblemEditorButtonPrompt.__defaultHeight = 36
CoD.EmblemEditorButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorButtonPrompt)
	self.id = "EmblemEditorButtonPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(1, 1, -36, 0, 0, 0, 0, 36)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(1, 1, -169, -45, 0, 0, 6, 30)
	label:setText("")
	label:setTTF("dinnext_regular")
	label:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(label)
	self.label = label
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorButtonPrompt.__resetProperties = function(f2_arg0)
	f2_arg0.label:completeAnimation()
	f2_arg0.buttonPromptImage:completeAnimation()
	f2_arg0.label:setAlpha(1)
	f2_arg0.buttonPromptImage:setLeftRight(1, 1, -36, 0)
	f2_arg0.buttonPromptImage:setTopBottom(0, 0, 0, 36)
	f2_arg0.buttonPromptImage:setAlpha(1)
end
CoD.EmblemEditorButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Hide = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.buttonPromptImage:completeAnimation()
			f4_arg0.buttonPromptImage:setLeftRight(1, 1, 0, 48)
			f4_arg0.buttonPromptImage:setTopBottom(0, 0, 0, 46)
			f4_arg0.buttonPromptImage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.buttonPromptImage)
			f4_arg0.label:completeAnimation()
			f4_arg0.label:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.label)
		end,
	},
}

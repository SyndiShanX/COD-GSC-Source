CoD.buttonprompt = InheritFrom(LUI.UIElement)
CoD.buttonprompt.__defaultWidth = 240
CoD.buttonprompt.__defaultHeight = 46
CoD.buttonprompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.buttonprompt)
	self.id = "buttonprompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 5, 25, 0.5, 0.5, -10, 10)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0, 0, 36, 236, 0.5, 0.5, -7.5, 7.5)
	label:setText("")
	label:setTTF("ttmussels_regular")
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(label)
	self.label = label
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.buttonprompt.__resetProperties = function(f2_arg0)
	f2_arg0.label:completeAnimation()
	f2_arg0.buttonPromptImage:completeAnimation()
	f2_arg0.label:setAlpha(1)
	f2_arg0.buttonPromptImage:setLeftRight(0, 0, 5, 25)
	f2_arg0.buttonPromptImage:setTopBottom(0.5, 0.5, -10, 10)
	f2_arg0.buttonPromptImage:setAlpha(1)
end
CoD.buttonprompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Hide = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.buttonPromptImage:completeAnimation()
			f4_arg0.buttonPromptImage:setLeftRight(0, 0, 0, 48)
			f4_arg0.buttonPromptImage:setTopBottom(0.5, 0.5, 0, 46)
			f4_arg0.buttonPromptImage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.buttonPromptImage)
			f4_arg0.label:completeAnimation()
			f4_arg0.label:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.label)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.buttonPromptImage:completeAnimation()
			f5_arg0.buttonPromptImage:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.buttonPromptImage)
			f5_arg0.label:completeAnimation()
			f5_arg0.label:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.label)
		end,
	},
}

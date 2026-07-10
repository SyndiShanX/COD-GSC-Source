require("x64:c926437e6209de")
CoD.ImagePrompt = InheritFrom(LUI.UIElement)
CoD.ImagePrompt.__defaultWidth = 400
CoD.ImagePrompt.__defaultHeight = 60
CoD.ImagePrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ImagePrompt)
	self.id = "ImagePrompt"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ImagePromptInternal = CoD.ImagePrompt_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ImagePromptInternal:linkToElementModel(self, nil, false, function(model)
		ImagePromptInternal:setModel(model, f1_arg1)
	end)
	ImagePromptInternal:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ImagePromptInternal.warningIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	ImagePromptInternal:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ImagePromptInternal.warningTextPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(ImagePromptInternal)
	self.ImagePromptInternal = ImagePromptInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ImagePrompt.__resetProperties = function(f5_arg0)
	f5_arg0.ImagePromptInternal:completeAnimation()
	f5_arg0.ImagePromptInternal:setAlpha(1)
end
CoD.ImagePrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ImagePromptInternal:completeAnimation()
			f7_arg0.ImagePromptInternal:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ImagePromptInternal)
		end,
	},
}
CoD.ImagePrompt.__onClose = function(f8_arg0)
	f8_arg0.ImagePromptInternal:close()
end

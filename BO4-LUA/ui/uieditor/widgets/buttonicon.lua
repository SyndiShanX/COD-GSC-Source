CoD.ButtonIcon = InheritFrom(LUI.UIElement)
CoD.ButtonIcon.__defaultWidth = 48
CoD.ButtonIcon.__defaultHeight = 48
CoD.ButtonIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonIcon)
	self.id = "ButtonIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	buttonImage:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			buttonImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(buttonImage)
	self.buttonImage = buttonImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonIcon.__resetProperties = function(f3_arg0)
	f3_arg0.buttonImage:completeAnimation()
	f3_arg0.buttonImage:setAlpha(1)
end
CoD.ButtonIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.buttonImage:completeAnimation()
			f4_arg0.buttonImage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.buttonImage)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ButtonIcon.__onClose = function(f6_arg0)
	f6_arg0.buttonImage:close()
end

CoD.VoDPreviewWidgetImage = InheritFrom(LUI.UIElement)
CoD.VoDPreviewWidgetImage.__defaultWidth = 192
CoD.VoDPreviewWidgetImage.__defaultHeight = 108
CoD.VoDPreviewWidgetImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VoDPreviewWidgetImage)
	self.id = "VoDPreviewWidgetImage"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:linkToElementModel(self, "stillPreview", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VoDPreviewWidgetImage.__onClose = function(f3_arg0)
	f3_arg0.Image:close()
end

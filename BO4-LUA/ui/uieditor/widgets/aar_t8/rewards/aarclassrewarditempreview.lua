CoD.AARClassRewardItemPreview = InheritFrom(LUI.UIElement)
CoD.AARClassRewardItemPreview.__defaultWidth = 64
CoD.AARClassRewardItemPreview.__defaultHeight = 64
CoD.AARClassRewardItemPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARClassRewardItemPreview)
	self.id = "AARClassRewardItemPreview"
	self.soundSet = "none"
	local Image = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	Image:linkToElementModel(self, "image", true, function(model)
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
CoD.AARClassRewardItemPreview.__onClose = function(f3_arg0)
	f3_arg0.Image:close()
end

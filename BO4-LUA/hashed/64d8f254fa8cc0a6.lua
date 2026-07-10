CoD.LaboratoryListItemInternalIconAndText = InheritFrom(LUI.UIElement)
CoD.LaboratoryListItemInternalIconAndText.__defaultWidth = 109
CoD.LaboratoryListItemInternalIconAndText.__defaultHeight = 109
CoD.LaboratoryListItemInternalIconAndText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryListItemInternalIconAndText)
	self.id = "LaboratoryListItemInternalIconAndText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FixedAspectRatioImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -54.5, 54.5, 0.5, 0.5, -54.5, 54.5)
	FixedAspectRatioImage:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FixedAspectRatioImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FixedAspectRatioImage)
	self.FixedAspectRatioImage = FixedAspectRatioImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryListItemInternalIconAndText.__onClose = function(f3_arg0)
	f3_arg0.FixedAspectRatioImage:close()
end

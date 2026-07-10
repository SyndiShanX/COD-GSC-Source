require("x64:25f8507482399ff")
CoD.CodCasterLoadoutSecondaryAttachment = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutSecondaryAttachment.__defaultWidth = 60
CoD.CodCasterLoadoutSecondaryAttachment.__defaultHeight = 60
CoD.CodCasterLoadoutSecondaryAttachment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutSecondaryAttachment)
	self.id = "CodCasterLoadoutSecondaryAttachment"
	self.soundSet = "none"
	local AttachmentImage = LUI.UIImage.new(0, 0, -2, 62, 0, 0, 12, 50)
	AttachmentImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AttachmentImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(AttachmentImage)
	self.AttachmentImage = AttachmentImage
	local CodCasterLoadoutSelection = CoD.CodCasterLoadoutSelection.new(f1_arg0, f1_arg1, 0, 0, 0, 64, 0, 0, 0, 60)
	CodCasterLoadoutSelection:setAlpha(0)
	self:addElement(CodCasterLoadoutSelection)
	self.CodCasterLoadoutSelection = CodCasterLoadoutSelection
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutSecondaryAttachment.__onClose = function(f3_arg0)
	f3_arg0.AttachmentImage:close()
	f3_arg0.CodCasterLoadoutSelection:close()
end

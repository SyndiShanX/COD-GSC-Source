CoD.WeaponPickupAttachmentIcon = InheritFrom(LUI.UIElement)
CoD.WeaponPickupAttachmentIcon.__defaultWidth = 36
CoD.WeaponPickupAttachmentIcon.__defaultHeight = 25
CoD.WeaponPickupAttachmentIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPickupAttachmentIcon)
	self.id = "WeaponPickupAttachmentIcon"
	self.soundSet = "none"
	local BgImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgImage:setRGB(0, 0, 0)
	BgImage:setAlpha(0)
	self:addElement(BgImage)
	self.BgImage = BgImage
	local AttachmentImage = LUI.UIImage.new(0.5, 0.5, -21, 21, 0.5, 0.5, -12.5, 12.5)
	AttachmentImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AttachmentImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(AttachmentImage)
	self.AttachmentImage = AttachmentImage
	self:linkToElementModel(self, "image", true, function(model)
		local f3_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x7615068F50B3D66) then
			HideWidget(self)
		else
			ShowWidget(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPickupAttachmentIcon.__onClose = function(f4_arg0)
	f4_arg0.AttachmentImage:close()
end

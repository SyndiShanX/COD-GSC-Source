require("x64:e72aa2f9921543f")
require("x64:30c897ab331cd16")
CoD.AmmoWidgetWZ_WeaponInfo = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZ_WeaponInfo.__defaultWidth = 239
CoD.AmmoWidgetWZ_WeaponInfo.__defaultHeight = 97
CoD.AmmoWidgetWZ_WeaponInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetWZ_WeaponInfo)
	self.id = "AmmoWidgetWZ_WeaponInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponImage = CoD.AmmoWidgetWZ_WeaponImage.new(f1_arg0, f1_arg1, 0, 0, 3, 167, 0, 0, 15.5, 68.5)
	WeaponImage:linkToElementModel(self, nil, false, function(model)
		WeaponImage:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local WeaponAmmoCount = CoD.AmmoWidgetWZ_ClipInfo.new(f1_arg0, f1_arg1, 0, 0, -326, -262, 0, 0, -22, 39)
	WeaponAmmoCount:linkToElementModel(self, nil, false, function(model)
		WeaponAmmoCount:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponAmmoCount)
	self.WeaponAmmoCount = WeaponAmmoCount
	local grappleWeapon = LUI.UIImage.new(0, 0, 142, 207, 0, 0, -28, 2)
	grappleWeapon:setAlpha(0)
	grappleWeapon:setZRot(-70)
	grappleWeapon:linkToElementModel(self, "dwGrappleWeapon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			grappleWeapon:setImage(RegisterImage(GetHudImageFromItemIndex(f4_local0)))
		end
	end)
	self:addElement(grappleWeapon)
	self.grappleWeapon = grappleWeapon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetWZ_WeaponInfo.__onClose = function(f5_arg0)
	f5_arg0.WeaponImage:close()
	f5_arg0.WeaponAmmoCount:close()
	f5_arg0.grappleWeapon:close()
end

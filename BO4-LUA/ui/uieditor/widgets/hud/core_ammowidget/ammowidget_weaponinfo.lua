require("x64:8e954fb331b89f8")
require("x64:d72b72bc4de143f")
require("x64:a05d396c91b3e63")
CoD.AmmoWidget_WeaponInfo = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_WeaponInfo.__defaultWidth = 239
CoD.AmmoWidget_WeaponInfo.__defaultHeight = 97
CoD.AmmoWidget_WeaponInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_WeaponInfo)
	self.id = "AmmoWidget_WeaponInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponImage = CoD.AmmoWidget_WeaponImage.new(f1_arg0, f1_arg1, 0, 0, 0, 164, 0, 0, 16.5, 68.5)
	WeaponImage:linkToElementModel(self, nil, false, function(model)
		WeaponImage:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local WeaponAmmoCount2 = CoD.AmmoWidgetMP_ClipInfo.new(f1_arg0, f1_arg1, 0, 0, -326, -262, 0, 0, -3, 58)
	WeaponAmmoCount2:setAlpha(0.08)
	WeaponAmmoCount2:linkToElementModel(self, nil, false, function(model)
		WeaponAmmoCount2:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponAmmoCount2)
	self.WeaponAmmoCount2 = WeaponAmmoCount2
	local WeaponAmmoCount = CoD.AmmoWidgetMP_ClipInfo.new(f1_arg0, f1_arg1, 0, 0, -330, -266, 0, 0, 1, 62)
	WeaponAmmoCount:linkToElementModel(self, nil, false, function(model)
		WeaponAmmoCount:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponAmmoCount)
	self.WeaponAmmoCount = WeaponAmmoCount
	local grappleWeapon = LUI.UIImage.new(0, 0, 142, 207, 0, 0, -28, 2)
	grappleWeapon:setAlpha(0)
	grappleWeapon:setZRot(-70)
	grappleWeapon:linkToElementModel(self, "dwGrappleWeapon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			grappleWeapon:setImage(RegisterImage(GetHudImageFromItemIndex(f5_local0)))
		end
	end)
	self:addElement(grappleWeapon)
	self.grappleWeapon = grappleWeapon
	local AmmoHeal_Prompt = CoD.AmmoWidget_Prompt.new(f1_arg0, f1_arg1, 0, 0, -318, -254, 0, 0, 78, 90)
	AmmoHeal_Prompt:mergeStateConditions({
		{
			stateName = "LowAmmo",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "LowHealth",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	AmmoHeal_Prompt:setAlpha(0)
	self:addElement(AmmoHeal_Prompt)
	self.AmmoHeal_Prompt = AmmoHeal_Prompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_WeaponInfo.__resetProperties = function(f8_arg0)
	f8_arg0.WeaponAmmoCount:completeAnimation()
	f8_arg0.WeaponAmmoCount:setLeftRight(0, 0, -330, -266)
	f8_arg0.WeaponAmmoCount:setTopBottom(0, 0, 1, 62)
end
CoD.AmmoWidget_WeaponInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Warzone = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.WeaponAmmoCount:completeAnimation()
			f10_arg0.WeaponAmmoCount:setLeftRight(0, 0, -323, -259)
			f10_arg0.WeaponAmmoCount:setTopBottom(0, 0, -33.5, 27.5)
			f10_arg0.clipFinished(f10_arg0.WeaponAmmoCount)
		end,
	},
}
CoD.AmmoWidget_WeaponInfo.__onClose = function(f11_arg0)
	f11_arg0.WeaponImage:close()
	f11_arg0.WeaponAmmoCount2:close()
	f11_arg0.WeaponAmmoCount:close()
	f11_arg0.grappleWeapon:close()
	f11_arg0.AmmoHeal_Prompt:close()
end

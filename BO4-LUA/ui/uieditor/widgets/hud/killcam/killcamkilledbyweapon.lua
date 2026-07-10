CoD.KillcamKilledByWeapon = InheritFrom(LUI.UIElement)
CoD.KillcamKilledByWeapon.__defaultWidth = 500
CoD.KillcamKilledByWeapon.__defaultHeight = 50
CoD.KillcamKilledByWeapon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.KillcamKilledByWeapon)
	self.id = "KillcamKilledByWeapon"
	self.soundSet = "none"
	local KilledBy = LUI.UIText.new(0, 0, 56, 220, 0.5, 0.5, -15, 15)
	KilledBy:setText(Engine[0xF9F1239CFD921FE](0x69B24B4F4628C7C))
	KilledBy:setTTF("0arame_mono_stencil")
	KilledBy:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(KilledBy)
	self.KilledBy = KilledBy
	local KillcamWeaponIcon = LUI.UIFixedAspectRatioImage.new(0, 0, 230, 394, 0.5, 0.5, -25, 25)
	KillcamWeaponIcon:setStretchedDimension(2)
	KillcamWeaponIcon:setAutoSizeProperty(true)
	KillcamWeaponIcon:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.killfeedicon", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			KillcamWeaponIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(KillcamWeaponIcon)
	self.KillcamWeaponIcon = KillcamWeaponIcon
	local KillcamWeaponName = LUI.UIText.new(0, 0, 404, 500, 0.5, 0.5, -15, 15)
	KillcamWeaponName:setTTF("0arame_mono_stencil")
	KillcamWeaponName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	KillcamWeaponName:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.weaponName", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			KillcamWeaponName:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(KillcamWeaponName)
	self.KillcamWeaponName = KillcamWeaponName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	if IsCurrentLanguageReversed() then
		ReverseChildrenOrder(self)
	end
	return self
end
CoD.KillcamKilledByWeapon.__onClose = function(f4_arg0)
	f4_arg0.KillcamWeaponIcon:close()
	f4_arg0.KillcamWeaponName:close()
end

CoD.KillcamWeaponInfo = InheritFrom(LUI.UIElement)
CoD.KillcamWeaponInfo.__defaultWidth = 800
CoD.KillcamWeaponInfo.__defaultHeight = 40
CoD.KillcamWeaponInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.KillcamWeaponInfo)
	self.id = "KillcamWeaponInfo"
	self.soundSet = "default"
	local WeaponName = LUI.UIText.new(0, 0, 0, 108, 0, 0, 0, 24)
	WeaponName:setRGB(0.63, 0.63, 0.63)
	WeaponName:setTTF("default")
	WeaponName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WeaponName:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.weaponName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(WeaponName)
	self.WeaponName = WeaponName
	local Attachment0 = LUI.UIText.new(0, 0, 108, 216, 0, 0, 0, 24)
	Attachment0:setRGB(0.63, 0.63, 0.63)
	Attachment0:setTTF("default")
	Attachment0:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachment0:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment0", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Attachment0:setAlpha(HideIfEmptyString(f3_local0))
		end
	end)
	Attachment0:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment0", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Attachment0:setText(PrependToLocalizeStringIfNotEmpty("    ", f4_local0))
		end
	end)
	self:addElement(Attachment0)
	self.Attachment0 = Attachment0
	local Attachment1 = LUI.UIText.new(0, 0, 216, 324, 0, 0, 0, 24)
	Attachment1:setRGB(0.63, 0.63, 0.63)
	Attachment1:setTTF("default")
	Attachment1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachment1:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment1", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Attachment1:setAlpha(HideIfEmptyString(f5_local0))
		end
	end)
	Attachment1:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment1", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Attachment1:setText(PrependToLocalizeStringIfNotEmpty("    ", f6_local0))
		end
	end)
	self:addElement(Attachment1)
	self.Attachment1 = Attachment1
	local Attachment2 = LUI.UIText.new(0, 0, 324, 432, 0, 0, 0, 24)
	Attachment2:setRGB(0.63, 0.63, 0.63)
	Attachment2:setTTF("default")
	Attachment2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachment2:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment2", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Attachment2:setAlpha(HideIfEmptyString(f7_local0))
		end
	end)
	Attachment2:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment2", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Attachment2:setText(PrependToLocalizeStringIfNotEmpty("    ", f8_local0))
		end
	end)
	self:addElement(Attachment2)
	self.Attachment2 = Attachment2
	local Attachment3 = LUI.UIText.new(0, 0, 432, 540, 0, 0, 0, 24)
	Attachment3:setRGB(0.63, 0.63, 0.63)
	Attachment3:setTTF("default")
	Attachment3:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachment3:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment3", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Attachment3:setAlpha(HideIfEmptyString(f9_local0))
		end
	end)
	Attachment3:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment3", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Attachment3:setText(PrependToLocalizeStringIfNotEmpty("    ", f10_local0))
		end
	end)
	self:addElement(Attachment3)
	self.Attachment3 = Attachment3
	local Attachment4 = LUI.UIText.new(0, 0, 540, 648, 0, 0, 0, 24)
	Attachment4:setRGB(0.78, 0.78, 0.78)
	Attachment4:setTTF("default")
	Attachment4:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachment4:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment4", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Attachment4:setAlpha(HideIfEmptyString(f11_local0))
		end
	end)
	Attachment4:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment4", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Attachment4:setText(PrependToLocalizeStringIfNotEmpty("    ", f12_local0))
		end
	end)
	self:addElement(Attachment4)
	self.Attachment4 = Attachment4
	local Attachment5 = LUI.UIText.new(0, 0, 648, 756, 0, 0, 0, 24)
	Attachment5:setRGB(0.78, 0.78, 0.78)
	Attachment5:setTTF("default")
	Attachment5:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Attachment5:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment5", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Attachment5:setAlpha(HideIfEmptyString(f13_local0))
		end
	end)
	Attachment5:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment5", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Attachment5:setText(PrependToLocalizeStringIfNotEmpty("    ", f14_local0))
		end
	end)
	self:addElement(Attachment5)
	self.Attachment5 = Attachment5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamWeaponInfo.__onClose = function(f15_arg0)
	f15_arg0.WeaponName:close()
	f15_arg0.Attachment0:close()
	f15_arg0.Attachment1:close()
	f15_arg0.Attachment2:close()
	f15_arg0.Attachment3:close()
	f15_arg0.Attachment4:close()
	f15_arg0.Attachment5:close()
end

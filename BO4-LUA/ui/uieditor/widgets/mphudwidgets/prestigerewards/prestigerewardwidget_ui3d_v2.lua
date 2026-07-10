CoD.prestigeRewardWidget_UI3D_v2 = InheritFrom(LUI.UIElement)
CoD.prestigeRewardWidget_UI3D_v2.__defaultWidth = 229
CoD.prestigeRewardWidget_UI3D_v2.__defaultHeight = 37
CoD.prestigeRewardWidget_UI3D_v2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.prestigeRewardWidget_UI3D_v2)
	self.id = "prestigeRewardWidget_UI3D_v2"
	self.soundSet = "default"
	local digit1 = LUI.UIText.new(0.5, 0.5, -94, -63, 0.5, 0.5, -19, 19)
	digit1:setTTF("ttmussels_regular")
	digit1:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	digit1:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weaponPrestigeUI3DText", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			digit1:setText(SetValueIfEmptyString("-", GetRightAlignedCharacter(1, 6, f2_local0)))
		end
	end)
	self:addElement(digit1)
	self.digit1 = digit1
	local digit2 = LUI.UIText.new(0.5, 0.5, -62, -31, 0.5, 0.5, -19, 19)
	digit2:setTTF("ttmussels_regular")
	digit2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	digit2:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weaponPrestigeUI3DText", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			digit2:setText(SetValueIfEmptyString("-", GetRightAlignedCharacter(2, 6, f3_local0)))
		end
	end)
	self:addElement(digit2)
	self.digit2 = digit2
	local digit3 = LUI.UIText.new(0.5, 0.5, -31, 0, 0.5, 0.5, -19, 19)
	digit3:setTTF("ttmussels_regular")
	digit3:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	digit3:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weaponPrestigeUI3DText", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			digit3:setText(SetValueIfEmptyString("-", GetRightAlignedCharacter(3, 6, f4_local0)))
		end
	end)
	self:addElement(digit3)
	self.digit3 = digit3
	local digit4 = LUI.UIText.new(0.5, 0.5, 0, 31, 0.5, 0.5, -19, 19)
	digit4:setTTF("ttmussels_regular")
	digit4:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	digit4:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weaponPrestigeUI3DText", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			digit4:setText(SetValueIfEmptyString("-", GetRightAlignedCharacter(4, 6, f5_local0)))
		end
	end)
	self:addElement(digit4)
	self.digit4 = digit4
	local digit5 = LUI.UIText.new(0.5, 0.5, 31, 62, 0.5, 0.5, -19, 19)
	digit5:setTTF("ttmussels_regular")
	digit5:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	digit5:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weaponPrestigeUI3DText", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			digit5:setText(SetValueIfEmptyString("-", GetRightAlignedCharacter(5, 6, f6_local0)))
		end
	end)
	self:addElement(digit5)
	self.digit5 = digit5
	local digit6 = LUI.UIText.new(0.5, 0.5, 62, 93, 0.5, 0.5, -19, 19)
	digit6:setTTF("ttmussels_regular")
	digit6:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	digit6:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weaponPrestigeUI3DText", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			digit6:setText(SetValueIfEmptyString("-", GetRightAlignedCharacter(6, 6, f7_local0)))
		end
	end)
	self:addElement(digit6)
	self.digit6 = digit6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.prestigeRewardWidget_UI3D_v2.__onClose = function(f8_arg0)
	f8_arg0.digit1:close()
	f8_arg0.digit2:close()
	f8_arg0.digit3:close()
	f8_arg0.digit4:close()
	f8_arg0.digit5:close()
	f8_arg0.digit6:close()
end

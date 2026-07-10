require("x64:bd74b33a6fdff19")
CoD.WeaponLevelUpNotification_FooterLabel01 = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpNotification_FooterLabel01.__defaultWidth = 309
CoD.WeaponLevelUpNotification_FooterLabel01.__defaultHeight = 48
CoD.WeaponLevelUpNotification_FooterLabel01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpNotification_FooterLabel01)
	self.id = "WeaponLevelUpNotification_FooterLabel01"
	self.soundSet = "HUD"
	local WeaponLevelUpNotificationFooterBacking = CoD.WeaponLevelUpNotification_FooterBacking01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	WeaponLevelUpNotificationFooterBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(WeaponLevelUpNotificationFooterBacking)
	self.WeaponLevelUpNotificationFooterBacking = WeaponLevelUpNotificationFooterBacking
	local SubText = LUI.UIText.new(0.5, 0.5, -270, 270, 0, 0, 1, 46)
	SubText:setRGB(0, 0, 0)
	SubText:setTTF("default")
	SubText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SubText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LUI.OverrideFunction_CallOriginalFirst(SubText, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWrapped(self, element, 20, 0)
	end)
	self:addElement(SubText)
	self.SubText = SubText
	self.WeaponLevelUpNotificationFooterBacking:linkToElementModel(self, "color", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			WeaponLevelUpNotificationFooterBacking:setRGB(f3_local0)
		end
	end)
	self.SubText:linkToElementModel(self, "subtitle", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SubText:setText(f4_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelUpNotification_FooterLabel01.__onClose = function(f5_arg0)
	f5_arg0.WeaponLevelUpNotificationFooterBacking:close()
	f5_arg0.SubText:close()
end

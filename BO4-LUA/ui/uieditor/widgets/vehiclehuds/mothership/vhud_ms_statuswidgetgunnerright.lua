require("x64:ae2cf5ba65e8174")
require("x64:a1295ffce06997")
CoD.vhud_ms_StatusWidgetGunnerRight = InheritFrom(LUI.UIElement)
CoD.vhud_ms_StatusWidgetGunnerRight.__defaultWidth = 124
CoD.vhud_ms_StatusWidgetGunnerRight.__defaultHeight = 243
CoD.vhud_ms_StatusWidgetGunnerRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_StatusWidgetGunnerRight)
	self.id = "vhud_ms_StatusWidgetGunnerRight"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpeedNumbers = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -84, -60)
	SpeedNumbers:setTTF("default")
	SpeedNumbers:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	SpeedNumbers:setShaderVector(0, 0, 1, 0, 0)
	SpeedNumbers:setShaderVector(1, 0, 0, 0, 0)
	SpeedNumbers:setShaderVector(2, 0, 0, 0, 0)
	SpeedNumbers:setShaderVector(3, 0, 0, 0, 0)
	SpeedNumbers:setShaderVector(4, 0, 0, 0, 0)
	SpeedNumbers:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SpeedNumbers:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SpeedNumbers:linkToElementModel(self, "speed", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpeedNumbers:setText(f2_local0)
		end
	end)
	self:addElement(SpeedNumbers)
	self.SpeedNumbers = SpeedNumbers
	local vhudsentinelNotificationLine = CoD.vhud_sentinel_NotificationLine.new(f1_arg0, f1_arg1, 0, 0, 3, 121, 0, 0, 61, 73)
	vhudsentinelNotificationLine:setRGB(0.74, 0.94, 0.99)
	vhudsentinelNotificationLine:setAlpha(0.7)
	self:addElement(vhudsentinelNotificationLine)
	self.vhudsentinelNotificationLine = vhudsentinelNotificationLine
	local vhudmsNotificationBox = CoD.vhud_ms_NotificationBox.new(f1_arg0, f1_arg1, 0, 0, 0, 122, 0, 0, -0.5, 44.5)
	vhudmsNotificationBox.ALTtext:setText(Engine[0xF9F1239CFD921FE](0x3755C926654C027))
	self:addElement(vhudmsNotificationBox)
	self.vhudmsNotificationBox = vhudmsNotificationBox
	local vhudsentinelNotificationLine0 = CoD.vhud_sentinel_NotificationLine.new(f1_arg0, f1_arg1, 0, 0, 3, 121, 0, 0, 208, 220)
	vhudsentinelNotificationLine0:setRGB(0.74, 0.94, 0.99)
	vhudsentinelNotificationLine0:setAlpha(0.7)
	self:addElement(vhudsentinelNotificationLine0)
	self.vhudsentinelNotificationLine0 = vhudsentinelNotificationLine0
	local statusText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 221, 243)
	statusText:setText(Engine[0xF9F1239CFD921FE](0xE20BF67125A4903))
	statusText:setTTF("default")
	statusText:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	statusText:setShaderVector(0, 0, 1, 0, 0)
	statusText:setShaderVector(1, 0, 0, 0, 0)
	statusText:setShaderVector(2, 0, 0, 0, 0)
	statusText:setShaderVector(3, 0, 0, 0, 0)
	statusText:setShaderVector(4, 0, 0, 0, 0)
	statusText:setLetterSpacing(0.5)
	statusText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	statusText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(statusText)
	self.statusText = statusText
	local Bar0 = LUI.UIImage.new(0, 0, -7, 128, 0, 0, 126, 154)
	Bar0:setRGB(0.74, 0.94, 0.99)
	Bar0:setAlpha(0.15)
	Bar0:setZRot(90)
	Bar0:setZoom(-15)
	Bar0:setImage(RegisterImage(0x5534C48D872A06A))
	Bar0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Bar0)
	self.Bar0 = Bar0
	local Bar = LUI.UIImage.new(0, 0, -7, 128, 0, 0, 126, 154)
	Bar:setRGB(0.74, 0.94, 0.99)
	Bar:setZRot(90)
	Bar:setImage(RegisterImage(0x5534C48D872A06A))
	Bar:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Bar)
	self.Bar = Bar
	local solidbar = LUI.UIImage.new(0, 0, -7, 128, 0, 0, 126, 154)
	solidbar:setRGB(0.74, 0.94, 0.99)
	solidbar:setZRot(90)
	solidbar:setImage(RegisterImage(0x7EA3B14064D93ED))
	solidbar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	solidbar:setShaderVector(1, 0, 0, 0, 0)
	solidbar:setShaderVector(2, 1, 0, 0, 0)
	solidbar:setShaderVector(3, 0, 0, 0, 0)
	solidbar:setShaderVector(4, 0, 0, 0, 0)
	solidbar:linkToElementModel(self, "weaponHeat", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			solidbar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(solidbar)
	self.solidbar = solidbar
	self:mergeStateConditions({
		{
			stateName = "Overheating",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "weaponOverheating")
			end,
		},
	})
	self:linkToElementModel(self, "weaponOverheating", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponOverheating",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_StatusWidgetGunnerRight.__resetProperties = function(f6_arg0)
	f6_arg0.solidbar:completeAnimation()
	f6_arg0.solidbar:setRGB(0.74, 0.94, 0.99)
end
CoD.vhud_ms_StatusWidgetGunnerRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Overheating = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.solidbar:completeAnimation()
			f8_arg0.solidbar:setRGB(0.99, 0.2, 0.27)
			f8_arg0.clipFinished(f8_arg0.solidbar)
		end,
	},
}
CoD.vhud_ms_StatusWidgetGunnerRight.__onClose = function(f9_arg0)
	f9_arg0.SpeedNumbers:close()
	f9_arg0.vhudsentinelNotificationLine:close()
	f9_arg0.vhudmsNotificationBox:close()
	f9_arg0.vhudsentinelNotificationLine0:close()
	f9_arg0.solidbar:close()
end

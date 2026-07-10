require("x64:dc3dd71c5e39d42")
CoD.genericVHUDInfoArea = InheritFrom(LUI.UIElement)
CoD.genericVHUDInfoArea.__defaultWidth = 133
CoD.genericVHUDInfoArea.__defaultHeight = 63
CoD.genericVHUDInfoArea.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUDInfoArea)
	self.id = "genericVHUDInfoArea"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local value = LUI.UIText.new(1, 1, -133, 0, 0.5, 0.5, 7, 31)
	value:setText(0)
	value:setTTF("default")
	value:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	value:setShaderVector(0, 0, 1, 0, 0)
	value:setShaderVector(1, 0, 0, 0, 0)
	value:setShaderVector(2, 0, 0, 0, 0)
	value:setShaderVector(3, 0, 0, 0, 0)
	value:setShaderVector(4, 0, 0, 0, 0)
	value:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	value:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(value)
	self.value = value
	local vhudsentinelNotificationBox = CoD.vhud_sentinel_NotificationBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -66, 67, 0.5, 0.5, -31, 14)
	vhudsentinelNotificationBox.SignalText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_43755C926654C027"))
	self:addElement(vhudsentinelNotificationBox)
	self.vhudsentinelNotificationBox = vhudsentinelNotificationBox
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f2_arg2, f2_arg3, f2_arg4)
		if IsSelfInState(self, "Hidden") then
			SetHeight(self, 0)
		else
			RestoreWidgetHeight(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUDInfoArea.__resetProperties = function(f3_arg0)
	f3_arg0.value:completeAnimation()
	f3_arg0.vhudsentinelNotificationBox:completeAnimation()
	f3_arg0.value:setAlpha(1)
	f3_arg0.vhudsentinelNotificationBox:setAlpha(1)
end
CoD.genericVHUDInfoArea.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		StartUp = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Zoom = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.value:completeAnimation()
			f7_arg0.value:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.value)
			f7_arg0.vhudsentinelNotificationBox:completeAnimation()
			f7_arg0.vhudsentinelNotificationBox:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.vhudsentinelNotificationBox)
		end,
		DefaultState = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.genericVHUDInfoArea.__onClose = function(f9_arg0)
	f9_arg0.vhudsentinelNotificationBox:close()
end

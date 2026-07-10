require("x64:dc3dd71c5e39d42")
CoD.vhud_sentinel_AltitudeInfo = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_AltitudeInfo.__defaultWidth = 130
CoD.vhud_sentinel_AltitudeInfo.__defaultHeight = 63
CoD.vhud_sentinel_AltitudeInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_AltitudeInfo)
	self.id = "vhud_sentinel_AltitudeInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ALTnumbers = LUI.UIText.new(0.5, 0.5, -65, 57, 0.5, 0.5, 7, 31)
	ALTnumbers:setRGB(0.6, 0.82, 0.91)
	ALTnumbers:setYRot(40)
	ALTnumbers:setTTF("default")
	ALTnumbers:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	ALTnumbers:setShaderVector(0, 0, 1, 0, 0)
	ALTnumbers:setShaderVector(1, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(2, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(3, 0, 0, 0, 0)
	ALTnumbers:setShaderVector(4, 0, 0, 0, 0)
	ALTnumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ALTnumbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ALTnumbers:linkToElementModel(self, "altitude", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ALTnumbers:setText(f2_local0)
		end
	end)
	self:addElement(ALTnumbers)
	self.ALTnumbers = ALTnumbers
	local ALTBox = CoD.vhud_sentinel_NotificationBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -65, 57, 0.5, 0.5, -31, 14)
	ALTBox:setRGB(0.6, 0.82, 0.91)
	ALTBox:setYRot(50)
	ALTBox.SignalText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BD23A68618982EF"))
	self:addElement(ALTBox)
	self.ALTBox = ALTBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_sentinel_AltitudeInfo.__resetProperties = function(f3_arg0)
	f3_arg0.ALTnumbers:completeAnimation()
	f3_arg0.ALTBox:completeAnimation()
	f3_arg0.ALTnumbers:setAlpha(1)
	f3_arg0.ALTBox:setAlpha(1)
end
CoD.vhud_sentinel_AltitudeInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.ALTnumbers:completeAnimation()
			f5_arg0.ALTnumbers:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ALTnumbers)
			f5_arg0.ALTBox:completeAnimation()
			f5_arg0.ALTBox:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ALTBox)
		end,
	},
}
CoD.vhud_sentinel_AltitudeInfo.__onClose = function(f6_arg0)
	f6_arg0.ALTnumbers:close()
	f6_arg0.ALTBox:close()
end

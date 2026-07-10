require("x64:21dc7dffc65fa57")
CoD.vhud_sentinel_TimeBar = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_TimeBar.__defaultWidth = 327
CoD.vhud_sentinel_TimeBar.__defaultHeight = 13
CoD.vhud_sentinel_TimeBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_TimeBar)
	self.id = "vhud_sentinel_TimeBar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vhudModDNITime00 = CoD.vhud_ModDNITime.new(f1_arg0, f1_arg1, 0, 0, -44, 34, 0, 0, -36, 50)
	vhudModDNITime00:setAlpha(0.2)
	vhudModDNITime00:setZoom(-20)
	self:addElement(vhudModDNITime00)
	self.vhudModDNITime00 = vhudModDNITime00
	local Frame0 = LUI.UIImage.new(0, 0, 16, 328, 0, 0, 0, 12)
	Frame0:setAlpha(0.2)
	Frame0:setZoom(-15)
	Frame0:setImage(RegisterImage(0x5534C48D872A06A))
	Frame0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Frame0)
	self.Frame0 = Frame0
	local vhudModDNITime0 = CoD.vhud_ModDNITime.new(f1_arg0, f1_arg1, 0, 0, -44, 34, 0, 0, -36, 50)
	self:addElement(vhudModDNITime0)
	self.vhudModDNITime0 = vhudModDNITime0
	local Bar = LUI.UIImage.new(0, 0, 16, 328, 0, 0, 0, 12)
	Bar:setImage(RegisterImage(0x7EA3B14064D93ED))
	Bar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	Bar:setShaderVector(1, 0, 0, 0, 0)
	Bar:setShaderVector(2, 1, 0, 0, 0)
	Bar:setShaderVector(3, 0, 0, 0, 0)
	Bar:setShaderVector(4, 0, 0, 0, 0)
	Bar:linkToElementModel(self, "remainingTime", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Bar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(Bar)
	self.Bar = Bar
	local Frame = LUI.UIImage.new(0, 0, 16, 328, 0, 0, 0, 12)
	Frame:setImage(RegisterImage(0x5534C48D872A06A))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Frame)
	self.Frame = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_sentinel_TimeBar.__resetProperties = function(f3_arg0)
	f3_arg0.vhudModDNITime00:completeAnimation()
	f3_arg0.Frame0:completeAnimation()
	f3_arg0.vhudModDNITime0:completeAnimation()
	f3_arg0.Bar:completeAnimation()
	f3_arg0.Frame:completeAnimation()
	f3_arg0.vhudModDNITime00:setAlpha(0.2)
	f3_arg0.Frame0:setAlpha(0.2)
	f3_arg0.vhudModDNITime0:setAlpha(1)
	f3_arg0.Bar:setAlpha(1)
	f3_arg0.Frame:setAlpha(1)
end
CoD.vhud_sentinel_TimeBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.vhudModDNITime00:completeAnimation()
			f5_arg0.vhudModDNITime00:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.vhudModDNITime00)
			f5_arg0.Frame0:completeAnimation()
			f5_arg0.Frame0:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Frame0)
			f5_arg0.vhudModDNITime0:completeAnimation()
			f5_arg0.vhudModDNITime0:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.vhudModDNITime0)
			f5_arg0.Bar:completeAnimation()
			f5_arg0.Bar:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Bar)
			f5_arg0.Frame:completeAnimation()
			f5_arg0.Frame:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Frame)
		end,
	},
}
CoD.vhud_sentinel_TimeBar.__onClose = function(f6_arg0)
	f6_arg0.vhudModDNITime00:close()
	f6_arg0.vhudModDNITime0:close()
	f6_arg0.Bar:close()
end

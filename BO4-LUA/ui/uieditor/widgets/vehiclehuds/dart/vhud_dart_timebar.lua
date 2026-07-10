require("x64:21dc7dffc65fa57")
CoD.vhud_dart_Timebar = InheritFrom(LUI.UIElement)
CoD.vhud_dart_Timebar.__defaultWidth = 327
CoD.vhud_dart_Timebar.__defaultHeight = 13
CoD.vhud_dart_Timebar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_dart_Timebar)
	self.id = "vhud_dart_Timebar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local vhudModDNITime0 = CoD.vhud_ModDNITime.new(f1_arg0, f1_arg1, 0, 0, -44, 34, 0, 0, -36, 50)
	vhudModDNITime0:setRGB(1, 0.9, 0.51)
	self:addElement(vhudModDNITime0)
	self.vhudModDNITime0 = vhudModDNITime0
	local Bar = LUI.UIImage.new(0, 0, 16, 328, 0, 0, 0, 12)
	Bar:setRGB(1, 0.9, 0.51)
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
	Frame:setRGB(1, 0.9, 0.51)
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
CoD.vhud_dart_Timebar.__onClose = function(f3_arg0)
	f3_arg0.vhudModDNITime0:close()
	f3_arg0.Bar:close()
end

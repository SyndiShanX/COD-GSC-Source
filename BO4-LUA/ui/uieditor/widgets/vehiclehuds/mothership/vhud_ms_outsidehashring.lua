require("x64:d4ce3fa496074dc")
CoD.vhud_ms_OutsideHashRing = InheritFrom(LUI.UIElement)
CoD.vhud_ms_OutsideHashRing.__defaultWidth = 226
CoD.vhud_ms_OutsideHashRing.__defaultHeight = 645
CoD.vhud_ms_OutsideHashRing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_OutsideHashRing)
	self.id = "vhud_ms_OutsideHashRing"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VehicleGroundHashRingLarge000 = CoD.VehicleGround_HashRingLarge.new(f1_arg0, f1_arg1, 0, 0, -205, -9, 0.5, 0.5, -208, 224)
	VehicleGroundHashRingLarge000:setRGB(0.35, 0.35, 0.35)
	VehicleGroundHashRingLarge000:setZoom(800)
	VehicleGroundHashRingLarge000:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(VehicleGroundHashRingLarge000)
	self.VehicleGroundHashRingLarge000 = VehicleGroundHashRingLarge000
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_OutsideHashRing.__onClose = function(f2_arg0)
	f2_arg0.VehicleGroundHashRingLarge000:close()
end

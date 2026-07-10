require("x64:6ff19f931e27b1c")
CoD.vhud_turret_reticle_arrows = InheritFrom(LUI.UIElement)
CoD.vhud_turret_reticle_arrows.__defaultWidth = 96
CoD.vhud_turret_reticle_arrows.__defaultHeight = 103
CoD.vhud_turret_reticle_arrows.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_turret_reticle_arrows)
	self.id = "vhud_turret_reticle_arrows"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RingElement0 = CoD.VehicleGround_CenterInnerRingElement.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 48, 0.5, 0.5, -52, 52)
	RingElement0:setAlpha(0.5)
	RingElement0:setZRot(45)
	self:addElement(RingElement0)
	self.RingElement0 = RingElement0
	local RingElement00 = CoD.VehicleGround_CenterInnerRingElement.new(f1_arg0, f1_arg1, 0.5, 0.5, -48, 38, 0.5, 0.5, -52, 52)
	RingElement00:setAlpha(0.5)
	RingElement00:setYRot(180)
	RingElement00:setZRot(45)
	self:addElement(RingElement00)
	self.RingElement00 = RingElement00
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_turret_reticle_arrows.__onClose = function(f2_arg0)
	f2_arg0.RingElement0:close()
	f2_arg0.RingElement00:close()
end

CoD.VHUDHawkWeakSignalBox = InheritFrom(LUI.UIElement)
CoD.VHUDHawkWeakSignalBox.__defaultWidth = 502
CoD.VHUDHawkWeakSignalBox.__defaultHeight = 82
CoD.VHUDHawkWeakSignalBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VHUDHawkWeakSignalBox)
	self.id = "VHUDHawkWeakSignalBox"
	self.soundSet = "default"
	local messageWindowBg = LUI.UIImage.new(0, 0, 0, 504, 0, 0, 0, 84)
	messageWindowBg:setAlpha(0.8)
	messageWindowBg:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_message_bg"))
	messageWindowBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	messageWindowBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageWindowBg)
	self.messageWindowBg = messageWindowBg
	local messageTextBg = LUI.UIImage.new(0, 0, 138, 364, 0, 0, 16, 54)
	messageTextBg:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_message_text_bg"))
	self:addElement(messageTextBg)
	self.messageTextBg = messageTextBg
	local messageLayoutPipR = LUI.UIImage.new(0, 0, 354.5, 376.5, 0, 0, 31, 39)
	messageLayoutPipR:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_message_layout_addon"))
	messageLayoutPipR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	messageLayoutPipR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageLayoutPipR)
	self.messageLayoutPipR = messageLayoutPipR
	local messageLayoutPipL = LUI.UIImage.new(0, 0, 122.5, 144.5, 0, 0, 31, 39)
	messageLayoutPipL:setZRot(180)
	messageLayoutPipL:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_message_layout_addon"))
	messageLayoutPipL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	messageLayoutPipL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageLayoutPipL)
	self.messageLayoutPipL = messageLayoutPipL
	local messageLayoutStripe = LUI.UIImage.new(0, 0, 140.5, 360.5, 0, 0, 50.5, 70.5)
	messageLayoutStripe:setAlpha(0.5)
	messageLayoutStripe:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_message_layout_stripe"))
	messageLayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	messageLayoutStripe:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageLayoutStripe)
	self.messageLayoutStripe = messageLayoutStripe
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end

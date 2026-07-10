CoD.vhud_gunship_message = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_message.__defaultWidth = 502
CoD.vhud_gunship_message.__defaultHeight = 82
CoD.vhud_gunship_message.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_message)
	self.id = "vhud_gunship_message"
	self.soundSet = "default"
	local messageWindowBg = LUI.UIImage.new(0, 0, 0, 504, 0, 0, 0, 84)
	messageWindowBg:setAlpha(0.8)
	messageWindowBg:setImage(RegisterImage(0xF37CF6AEDF83747))
	messageWindowBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	messageWindowBg:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageWindowBg)
	self.messageWindowBg = messageWindowBg
	local messageTextBg = LUI.UIImage.new(0, 0, 138, 364, 0, 0, 16, 54)
	messageTextBg:setImage(RegisterImage(0x55446512BCC8AF7))
	self:addElement(messageTextBg)
	self.messageTextBg = messageTextBg
	local messageLayout = LUI.UIImage.new(0, 0, 140.5, 361.5, 0, 0, 14, 64)
	messageLayout:setImage(RegisterImage(0xE0B286976BA31B2))
	messageLayout:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	messageLayout:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageLayout)
	self.messageLayout = messageLayout
	local messageLayoutPipR = LUI.UIImage.new(0, 0, 354.5, 376.5, 0, 0, 31, 39)
	messageLayoutPipR:setImage(RegisterImage(0x3120E6A6307869B))
	messageLayoutPipR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	messageLayoutPipR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageLayoutPipR)
	self.messageLayoutPipR = messageLayoutPipR
	local messageLayoutPipL = LUI.UIImage.new(0, 0, 122.5, 144.5, 0, 0, 31, 39)
	messageLayoutPipL:setZRot(180)
	messageLayoutPipL:setImage(RegisterImage(0x3120E6A6307869B))
	messageLayoutPipL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	messageLayoutPipL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageLayoutPipL)
	self.messageLayoutPipL = messageLayoutPipL
	local messageLayoutStripe = LUI.UIImage.new(0, 0, 140.5, 360.5, 0, 0, 50.5, 70.5)
	messageLayoutStripe:setAlpha(0.5)
	messageLayoutStripe:setImage(RegisterImage(0x5AFE39B9B2E68FE))
	messageLayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	messageLayoutStripe:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(messageLayoutStripe)
	self.messageLayoutStripe = messageLayoutStripe
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end

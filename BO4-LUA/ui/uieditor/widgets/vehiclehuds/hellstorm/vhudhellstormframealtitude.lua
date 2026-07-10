CoD.vhudHellstormFrameAltitude = InheritFrom(LUI.UIElement)
CoD.vhudHellstormFrameAltitude.__defaultWidth = 20
CoD.vhudHellstormFrameAltitude.__defaultHeight = 450
CoD.vhudHellstormFrameAltitude.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhudHellstormFrameAltitude)
	self.id = "vhudHellstormFrameAltitude"
	self.soundSet = "default"
	local Top = LUI.UIImage.new(0, 0, 0, 20, 0, 0.04, 0, 0)
	Top:setImage(RegisterImage(0xDD7AABB9320F4BD))
	Top:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Top:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Top)
	self.Top = Top
	local Mid = LUI.UIImage.new(0, 0, 0, 20, 0, 0.92, 20, 20)
	Mid:setImage(RegisterImage(0x19A28B0832D46AA))
	Mid:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	Mid:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Mid)
	self.Mid = Mid
	local Bot = LUI.UIImage.new(0, 0, 0, 20, 1, 0.96, 4, 4)
	Bot:setImage(RegisterImage(0xDD7AABB9320F4BD))
	Bot:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Bot:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Bot)
	self.Bot = Bot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end

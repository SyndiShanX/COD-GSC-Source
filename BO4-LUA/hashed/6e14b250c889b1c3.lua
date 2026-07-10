CoD.vhud_lightningstrike_ambientgadget = InheritFrom(LUI.UIElement)
CoD.vhud_lightningstrike_ambientgadget.__defaultWidth = 100
CoD.vhud_lightningstrike_ambientgadget.__defaultHeight = 137
CoD.vhud_lightningstrike_ambientgadget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_lightningstrike_ambientgadget)
	self.id = "vhud_lightningstrike_ambientgadget"
	self.soundSet = "default"
	local Text = LUI.UIImage.new(0, 0, 80, 100, 0, 0, 27, 107)
	Text:setImage(RegisterImage(0x2485EA2ED785464))
	self:addElement(Text)
	self.Text = Text
	local AmbientSquare6 = LUI.UIImage.new(0, 0, 52, 78, 1, 1, -44, 0)
	AmbientSquare6:setAlpha(0.3)
	AmbientSquare6:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientSquare6)
	self.AmbientSquare6 = AmbientSquare6
	local AmbientSquare5 = LUI.UIImage.new(0, 0, 26, 52, 1, 1, -44, 0)
	AmbientSquare5:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientSquare5)
	self.AmbientSquare5 = AmbientSquare5
	local AmbientSquare4 = LUI.UIImage.new(0, 0, 0, 26, 1, 1, -44, 0)
	AmbientSquare4:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientSquare4)
	self.AmbientSquare4 = AmbientSquare4
	local GadgetR = LUI.UIImage.new(0, 0, 0, 80, 0.5, 0.5, -40, 40)
	GadgetR:setImage(RegisterImage(0x47DA5123F88DAAB))
	self:addElement(GadgetR)
	self.GadgetR = GadgetR
	local AmbientSquare3 = LUI.UIImage.new(0, 0, 52, 78, 0, 0, 0, 44)
	AmbientSquare3:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientSquare3)
	self.AmbientSquare3 = AmbientSquare3
	local AmbientSquare2 = LUI.UIImage.new(0, 0, 26, 52, 0, 0, 0, 44)
	AmbientSquare2:setAlpha(0.3)
	AmbientSquare2:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientSquare2)
	self.AmbientSquare2 = AmbientSquare2
	local AmbientSquare1 = LUI.UIImage.new(0, 0, 0, 26, 0, 0, 0, 44)
	AmbientSquare1:setImage(RegisterImage(0xF82D093E5F3C916))
	self:addElement(AmbientSquare1)
	self.AmbientSquare1 = AmbientSquare1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end

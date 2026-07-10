require("x64:9cb1900193778bc")
CoD.HUD_VehiclePrompt_Container = InheritFrom(LUI.UIElement)
CoD.HUD_VehiclePrompt_Container.__defaultWidth = 100
CoD.HUD_VehiclePrompt_Container.__defaultHeight = 50
CoD.HUD_VehiclePrompt_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_VehiclePrompt_Container)
	self.id = "HUD_VehiclePrompt_Container"
	self.soundSet = "none"
	local Blur = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Panel = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	Panel:setRGB(0.11, 0.11, 0.11)
	Panel:setAlpha(0.88)
	self:addElement(Panel)
	self.Panel = Panel
	local LED = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LED:setAlpha(0.02)
	LED:setImage(RegisterImage(0xDC42BC1DA3C1F61))
	self:addElement(LED)
	self.LED = LED
	local Frame = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setImage(RegisterImage(0x46E840787F07249))
	self:addElement(Frame)
	self.Frame = Frame
	local KBMText = nil
	KBMText = LUI.UIText.new(0.05, 0.95, 0, 0, 0.27, 0.27, -1, 22)
	KBMText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	KBMText:setTTF("notosans_bold")
	KBMText:setLetterSpacing(-2)
	KBMText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KBMText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(KBMText)
	self.KBMText = KBMText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end

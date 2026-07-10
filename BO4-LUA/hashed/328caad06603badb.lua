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
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
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
	LED:setImage(RegisterImage(@"uie_vehicleprompt_led"))
	self:addElement(LED)
	self.LED = LED
	local Frame = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setImage(RegisterImage(@"uie_vehicleprompt_frame"))
	self:addElement(Frame)
	self.Frame = Frame
	local KBMText = nil
	KBMText = LUI.UIText.new(0.05, 0.95, 0, 0, 0.27, 0.27, -1, 22)
	KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	KBMText:setTTF("notosans_bold")
	KBMText:setLetterSpacing(-2)
	KBMText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KBMText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(KBMText)
	self.KBMText = KBMText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end

CoD.WarzoneRedeployment = InheritFrom(LUI.UIElement)
CoD.WarzoneRedeployment.__defaultWidth = 360
CoD.WarzoneRedeployment.__defaultHeight = 80
CoD.WarzoneRedeployment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneRedeployment)
	self.id = "WarzoneRedeployment"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0.5, 0.5, -145.5, 145.5, 0.5, 0.5, -19, 19)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local bg = LUI.UIImage.new(0.5, 0.5, -145.5, 145.5, 0.5, 0.5, -19, 19)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0.8)
	self:addElement(bg)
	self.bg = bg
	local led = LUI.UIImage.new(0.5, 0.5, -146, 146, 0.5, 0.5, -20, 20)
	led:setAlpha(0.02)
	led:setImage(RegisterImage(0xC07F7432F86DA83))
	self:addElement(led)
	self.led = led
	local border = LUI.UIImage.new(0.5, 0.5, -151.5, 151.5, 0.5, 0.5, -23, 23)
	border:setRGB(0.07, 0.07, 0.07)
	border:setImage(RegisterImage(0xA3C76B80B69874D))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(18, 24)
	self:addElement(border)
	self.border = border
	local Message = LUI.UIText.new(0, 0, 47, 314, 0, 0, 31, 51)
	Message:setRGB(1, 0, 0)
	Message:setText(LocalizeToUpperString(0x441DCDDB6D233EF))
	Message:setTTF("ttmussels_regular")
	Message:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Message:setShaderVector(0, 1.02, 0, 0, 0)
	Message:setShaderVector(1, -0.23, 0, 0, 0)
	Message:setShaderVector(2, 1, 0, 0, 0.6)
	Message:setLetterSpacing(2)
	Message:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041]))
	Message:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7]))
	self:addElement(Message)
	self.Message = Message
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneRedeployment.__resetProperties = function(f2_arg0)
	f2_arg0.blur:completeAnimation()
	f2_arg0.bg:completeAnimation()
	f2_arg0.border:completeAnimation()
	f2_arg0.blur:setAlpha(1)
	f2_arg0.bg:setAlpha(0.8)
	f2_arg0.border:setAlpha(1)
end
CoD.WarzoneRedeployment.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.blur:completeAnimation()
			f3_arg0.blur:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.blur)
			f3_arg0.bg:completeAnimation()
			f3_arg0.bg:setAlpha(0.8)
			f3_arg0.clipFinished(f3_arg0.bg)
			f3_arg0.border:completeAnimation()
			f3_arg0.border:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.border)
		end,
	},
}

CoD.PrematchCountdown_NumbersSmall = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_NumbersSmall.__defaultWidth = 303
CoD.PrematchCountdown_NumbersSmall.__defaultHeight = 60
CoD.PrematchCountdown_NumbersSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_NumbersSmall)
	self.id = "PrematchCountdown_NumbersSmall"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0, 0, 6, 297, 0, 0, 4, 56)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local bg = LUI.UIImage.new(0, 0, 6, 297, 0, 0, 4, 56)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0.8)
	self:addElement(bg)
	self.bg = bg
	local LED = LUI.UIImage.new(0, 0, -6, 310, 0, 0, -6, 66)
	LED:setAlpha(0.02)
	LED:setImage(RegisterImage(0xE8F240771F2A09))
	self:addElement(LED)
	self.LED = LED
	local border = LUI.UIImage.new(0, 0, 0, 303, 0, 0, 0, 60)
	border:setRGB(0, 0, 0)
	border:setImage(RegisterImage(0xA3C76B80B69874D))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(18, 24)
	self:addElement(border)
	self.border = border
	local Timer = LUI.UIText.new(0, 0, 222, 291, 0, 0, 11, 51)
	Timer:setText("")
	Timer:setTTF("0arame_mono_stencil")
	Timer:setLetterSpacing(1)
	Timer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Timer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Timer)
	self.Timer = Timer
	local Message = LUI.UIText.new(0, 0, 14, 222, 0, 0, 17, 44)
	Message:setRGB(0, 0.56, 1)
	Message:setText(Engine[0xF9F1239CFD921FE](0x8E58CC95DB34427))
	Message:setTTF("ttmussels_regular")
	Message:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Message:setShaderVector(0, 1.02, 0, 0, 0)
	Message:setShaderVector(1, -0.23, 0, 0, 0)
	Message:setShaderVector(2, 0, 0, 1, 1)
	Message:setLetterSpacing(2)
	Message:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	Message:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7]))
	self:addElement(Message)
	self.Message = Message
	self:mergeStateConditions({
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageReversed()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PrematchCountdown_NumbersSmall.__resetProperties = function(f3_arg0)
	f3_arg0.Message:completeAnimation()
	f3_arg0.Timer:completeAnimation()
	f3_arg0.Message:setLeftRight(0, 0, 14, 222)
	f3_arg0.Timer:setLeftRight(0, 0, 222, 291)
end
CoD.PrematchCountdown_NumbersSmall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Arabic = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Timer:completeAnimation()
			f5_arg0.Timer:setLeftRight(0, 0, 14, 83)
			f5_arg0.clipFinished(f5_arg0.Timer)
			f5_arg0.Message:completeAnimation()
			f5_arg0.Message:setLeftRight(0, 0, 83, 291)
			f5_arg0.clipFinished(f5_arg0.Message)
		end,
	},
}

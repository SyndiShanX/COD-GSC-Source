CoD.PC_Notif_Background = InheritFrom(LUI.UIElement)
CoD.PC_Notif_Background.__defaultWidth = 440
CoD.PC_Notif_Background.__defaultHeight = 100
CoD.PC_Notif_Background.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Notif_Background)
	self.id = "PC_Notif_Background"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BgBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgBlur:setAlpha(0)
	BgBlur:setZRot(180)
	BgBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BgBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BgBlur)
	self.BgBlur = BgBlur
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.09, 0.09, 0.09)
	self:addElement(Backing)
	self.Backing = Backing
	local Texture = LUI.UIImage.new(0, 1, -13, 13, 0, 1, -7, 7)
	Texture:setRGB(0.09, 0.09, 0.09)
	Texture:setAlpha(0.75)
	Texture:setImage(RegisterImage(@"hash_475E9DD0A972CB56"))
	self:addElement(Texture)
	self.Texture = Texture
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Notif_Background.__resetProperties = function(f2_arg0)
	f2_arg0.Backing:completeAnimation()
	f2_arg0.Texture:completeAnimation()
	f2_arg0.BgBlur:completeAnimation()
	f2_arg0.Backing:setRGB(0.09, 0.09, 0.09)
	f2_arg0.Backing:setAlpha(1)
	f2_arg0.Texture:setAlpha(0.75)
	f2_arg0.BgBlur:setAlpha(0)
end
CoD.PC_Notif_Background.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	InGame = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.BgBlur:completeAnimation()
			f4_arg0.BgBlur:setAlpha(0.7)
			f4_arg0.clipFinished(f4_arg0.BgBlur)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setRGB(0.11, 0.11, 0.11)
			f4_arg0.Backing:setAlpha(0.95)
			f4_arg0.clipFinished(f4_arg0.Backing)
			f4_arg0.Texture:completeAnimation()
			f4_arg0.Texture:setAlpha(0.3)
			f4_arg0.clipFinished(f4_arg0.Texture)
		end,
	},
}

require("x64:acbf06924421e35")
CoD.LoadingScreenLoadbar = InheritFrom(LUI.UIElement)
CoD.LoadingScreenLoadbar.__defaultWidth = 1803
CoD.LoadingScreenLoadbar.__defaultHeight = 20
CoD.LoadingScreenLoadbar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadingScreenLoadbar)
	self.id = "LoadingScreenLoadbar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BgBar = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -4.5, 4.5)
	BgBar:setRGB(0, 0, 0)
	BgBar:setAlpha(0.8)
	self:addElement(BgBar)
	self.BgBar = BgBar
	local HeaderStripe1 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -4.5, 4.5)
	HeaderStripe1:setRGB(0.84, 0.84, 0.84)
	HeaderStripe1:setImage(RegisterImage(0xC7A051F5EFC70E5))
	HeaderStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	HeaderStripe1:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe1:setupNineSliceShader(60, 10)
	self:addElement(HeaderStripe1)
	self.HeaderStripe1 = HeaderStripe1
	local HeaderStripeAdd = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -4.5, 4.5)
	HeaderStripeAdd:setAlpha(0)
	HeaderStripeAdd:setImage(RegisterImage(0xC7A051F5EFC70E5))
	HeaderStripeAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	HeaderStripeAdd:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripeAdd:setupNineSliceShader(60, 10)
	self:addElement(HeaderStripeAdd)
	self.HeaderStripeAdd = HeaderStripeAdd
	local LoadingBar = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -6, 6)
	LoadingBar:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	LoadingBar:setImage(RegisterImage(0xB21B5CD5C5090B0))
	LoadingBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	LoadingBar:setShaderVector(0, 1, 0, 0, 0)
	LoadingBar:setShaderVector(1, 0, 0, 0, 0)
	LoadingBar:setShaderVector(2, 1, 0, 0, 0)
	LoadingBar:setShaderVector(3, 0, 0, 0, 0)
	LoadingBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LoadingBar)
	self.LoadingBar = LoadingBar
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, -2, 2, 0, 0, 4, 16)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local DividerSolidBot = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 2.5, 6.5)
	DividerSolidBot:setAlpha(0.5)
	DividerSolidBot:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolidBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolidBot:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidBot)
	self.DividerSolidBot = DividerSolidBot
	local DividerSolidBot2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 13.5, 17.5)
	DividerSolidBot2:setAlpha(0.5)
	DividerSolidBot2:setZRot(180)
	DividerSolidBot2:setImage(RegisterImage(0x84B43D5B04D263A))
	DividerSolidBot2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DividerSolidBot2:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot2:setupNineSliceShader(8, 4)
	self:addElement(DividerSolidBot2)
	self.DividerSolidBot2 = DividerSolidBot2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadingScreenLoadbar.__resetProperties = function(f2_arg0)
	f2_arg0.HeaderStripeAdd:completeAnimation()
	f2_arg0.LoadingBar:completeAnimation()
	f2_arg0.HeaderStripeAdd:setAlpha(0)
	f2_arg0.LoadingBar:setAlpha(1)
end
CoD.LoadingScreenLoadbar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1000)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.HeaderStripeAdd:beginAnimation(1000)
				f3_arg0.HeaderStripeAdd:setAlpha(0.8)
				f3_arg0.HeaderStripeAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.HeaderStripeAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.HeaderStripeAdd:completeAnimation()
			f3_arg0.HeaderStripeAdd:setAlpha(0)
			f3_local0(f3_arg0.HeaderStripeAdd)
			f3_arg0.LoadingBar:completeAnimation()
			f3_arg0.LoadingBar:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.LoadingBar)
			f3_arg0.nextClip = "DefaultClip"
		end,
		StartLoading = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(180)
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.LoadingBar:beginAnimation(2200)
				f6_arg0.LoadingBar:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.LoadingBar:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.LoadingBar:completeAnimation()
			f6_arg0.LoadingBar:setAlpha(0)
			f6_local0(f6_arg0.LoadingBar)
		end,
	},
}
CoD.LoadingScreenLoadbar.__onClose = function(f9_arg0)
	f9_arg0.CommonCornerPips:close()
end

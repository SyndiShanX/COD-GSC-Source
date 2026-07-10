CoD.BGBListItem_ConsumableCounter = InheritFrom(LUI.UIElement)
CoD.BGBListItem_ConsumableCounter.__defaultWidth = 38
CoD.BGBListItem_ConsumableCounter.__defaultHeight = 38
CoD.BGBListItem_ConsumableCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BGBListItem_ConsumableCounter)
	self.id = "BGBListItem_ConsumableCounter"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BannerBGGray = LUI.UIImage.new(0, 0, -2, 66, 0, 0, -1, 23)
	BannerBGGray:setRGB(0.8, 0.8, 0.8)
	BannerBGGray:setImage(RegisterImage(0x41C32854A426BD5))
	self:addElement(BannerBGGray)
	self.BannerBGGray = BannerBGGray
	local BannerBGRed = LUI.UIImage.new(0, 0, -2, 66, 0, 0, -1, 23)
	BannerBGRed:setAlpha(0)
	BannerBGRed:setImage(RegisterImage(0xB2C0FB408DF28E5))
	self:addElement(BannerBGRed)
	self.BannerBGRed = BannerBGRed
	local ElixirCount = LUI.UIText.new(0, 0, 5, 35, 0, 0, 3, 19)
	ElixirCount:setRGB(0.58, 0.58, 0.58)
	ElixirCount:setText(888)
	ElixirCount:setTTF("skorzhen")
	ElixirCount:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ElixirCount:setShaderVector(0, 1, 0, 0, 0)
	ElixirCount:setShaderVector(1, 0, 0, 0, 0)
	ElixirCount:setShaderVector(2, 0, 0, 0, 0.9)
	ElixirCount:setLetterSpacing(2)
	ElixirCount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ElixirCount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ElixirCount)
	self.ElixirCount = ElixirCount
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BGBListItem_ConsumableCounter.__resetProperties = function(f2_arg0)
	f2_arg0.ElixirCount:completeAnimation()
	f2_arg0.BannerBGRed:completeAnimation()
	f2_arg0.BannerBGGray:completeAnimation()
	f2_arg0.ElixirCount:setRGB(0.58, 0.58, 0.58)
	f2_arg0.ElixirCount:setAlpha(1)
	f2_arg0.BannerBGRed:setAlpha(0)
	f2_arg0.BannerBGGray:setAlpha(1)
end
CoD.BGBListItem_ConsumableCounter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.BannerBGGray:completeAnimation()
			f4_arg0.BannerBGGray:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.BannerBGGray)
			f4_arg0.BannerBGRed:completeAnimation()
			f4_arg0.BannerBGRed:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.BannerBGRed)
			f4_arg0.ElixirCount:completeAnimation()
			f4_arg0.ElixirCount:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.ElixirCount)
		end,
	},
	NoConsumablesRemaining = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.BannerBGGray:completeAnimation()
			f5_arg0.BannerBGGray:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BannerBGGray)
			f5_arg0.BannerBGRed:completeAnimation()
			f5_arg0.BannerBGRed:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.BannerBGRed)
			f5_arg0.ElixirCount:completeAnimation()
			f5_arg0.ElixirCount:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.ElixirCount)
		end,
	},
}

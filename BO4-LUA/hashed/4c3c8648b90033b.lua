require("x64:19c1945d2e472b0")
CoD.AARSquadStat = InheritFrom(LUI.UIElement)
CoD.AARSquadStat.__defaultWidth = 140
CoD.AARSquadStat.__defaultHeight = 60
CoD.AARSquadStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSquadStat)
	self.id = "AARSquadStat"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BarBot = LUI.UIImage.new(-0.03, 1.03, 2, 2, 0, 0, 54, 64)
	BarBot:setImage(RegisterImage(0xC6873B923C6686C))
	self:addElement(BarBot)
	self.BarBot = BarBot
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 56)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(26, 26)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local Value = LUI.UIText.new(0.5, 0.5, -42, 42, 0.5, 0.5, -13, 13)
	Value:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Value:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Value:setTTF("0arame_mono_stencil")
	Value:setLetterSpacing(1)
	Value:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Value:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Value)
	self.Value = Value
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSquadStat.__resetProperties = function(f2_arg0)
	f2_arg0.Value:completeAnimation()
	f2_arg0.BarBot:completeAnimation()
	f2_arg0.DotTiledBacking:completeAnimation()
	f2_arg0.Value:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f2_arg0.Value:setAlpha(1)
	f2_arg0.BarBot:setRGB(1, 1, 1)
	f2_arg0.DotTiledBacking:setAlpha(1)
end
CoD.AARSquadStat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Self = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.BarBot:completeAnimation()
			f4_arg0.BarBot:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.BarBot)
			f4_arg0.DotTiledBacking:completeAnimation()
			f4_arg0.DotTiledBacking:setAlpha(0.7)
			f4_arg0.clipFinished(f4_arg0.DotTiledBacking)
			f4_arg0.Value:completeAnimation()
			f4_arg0.Value:setRGB(1, 0.76, 0)
			f4_arg0.clipFinished(f4_arg0.Value)
		end,
	},
	StillAlive = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Value:completeAnimation()
			f5_arg0.Value:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Value)
		end,
	},
}
CoD.AARSquadStat.__onClose = function(f6_arg0)
	f6_arg0.DotTiledBacking:close()
end

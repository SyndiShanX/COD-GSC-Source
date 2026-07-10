require("x64:a9255c570c68aa8")
CoD.DemoTimelineInternal = InheritFrom(LUI.UIElement)
CoD.DemoTimelineInternal.__defaultWidth = 24
CoD.DemoTimelineInternal.__defaultHeight = 24
CoD.DemoTimelineInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoTimelineInternal)
	self.id = "DemoTimelineInternal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Base = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Base:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Base:setAlpha(0.05)
	self:addElement(Base)
	self.Base = Base
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.15)
	self:addElement(Frame)
	self.Frame = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoTimelineInternal.__resetProperties = function(f2_arg0)
	f2_arg0.Base:completeAnimation()
	f2_arg0.Frame:completeAnimation()
	f2_arg0.Base:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f2_arg0.Base:setAlpha(0.05)
	f2_arg0.Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f2_arg0.Frame:setAlpha(0.15)
end
CoD.DemoTimelineInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	SelectedState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Base:completeAnimation()
			f4_arg0.Base:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f4_arg0.Base:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Base)
			f4_arg0.Frame:completeAnimation()
			f4_arg0.Frame:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Frame)
		end,
	},
	FocusState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Base:completeAnimation()
			f5_arg0.Base:setAlpha(0.4)
			f5_arg0.clipFinished(f5_arg0.Base)
			f5_arg0.Frame:completeAnimation()
			f5_arg0.Frame:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f5_arg0.Frame:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Frame)
		end,
	},
}
CoD.DemoTimelineInternal.__onClose = function(f6_arg0)
	f6_arg0.Frame:close()
end

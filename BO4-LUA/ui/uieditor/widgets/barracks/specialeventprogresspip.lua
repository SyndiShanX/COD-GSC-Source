require("x64:19c1945d2e472b0")
CoD.SpecialEventProgressPip = InheritFrom(LUI.UIElement)
CoD.SpecialEventProgressPip.__defaultWidth = 19
CoD.SpecialEventProgressPip.__defaultHeight = 19
CoD.SpecialEventProgressPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialEventProgressPip)
	self.id = "SpecialEventProgressPip"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameBorder = LUI.UIImage.new(-0.02, 1.02, 0, 0, -0.02, 1.02, 0, 0)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local ImageX = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	ImageX:setAlpha(0)
	ImageX:setImage(RegisterImage(0xCCAE79885973D29))
	ImageX:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ImageX)
	self.ImageX = ImageX
	local Glow = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.5, 0.5, -14, 14)
	Glow:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(0xC58FF2328701EBA))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local Background = LUI.UIImage.new(0, 1, 1, -1, 0, 1, 1, -1)
	Background:setRGB(1, 0.93, 0)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 1, -1, 0, 1, 1, -1)
	DotTiledBacking:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	DotTiledBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FocusBorder = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FocusBorder:setRGB(ColorSet.WarzoneTeammate1.r, ColorSet.WarzoneTeammate1.g, ColorSet.WarzoneTeammate1.b)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(3, 3)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "CompletedState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "stepStatus", CoD.SpecialEventUtility.EventStepStatus.COMPLETED)
			end,
		},
		{
			stateName = "IncompleteState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "stepStatus", CoD.SpecialEventUtility.EventStepStatus.INCOMPLETE)
			end,
		},
	})
	self:linkToElementModel(self, "stepStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stepStatus",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialEventProgressPip.__resetProperties = function(f6_arg0)
	f6_arg0.Background:completeAnimation()
	f6_arg0.FocusBorder:completeAnimation()
	f6_arg0.DotTiledBacking:completeAnimation()
	f6_arg0.Glow:completeAnimation()
	f6_arg0.ImageX:completeAnimation()
	f6_arg0.FrameBorder:completeAnimation()
	f6_arg0.Background:setAlpha(0)
	f6_arg0.FocusBorder:setAlpha(0)
	f6_arg0.DotTiledBacking:setAlpha(0)
	f6_arg0.Glow:setAlpha(0)
	f6_arg0.ImageX:setAlpha(0)
	f6_arg0.FrameBorder:setAlpha(0.15)
end
CoD.SpecialEventProgressPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Background:completeAnimation()
			f7_arg0.Background:setAlpha(0.05)
			f7_arg0.clipFinished(f7_arg0.Background)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(6)
			f8_arg0.FrameBorder:completeAnimation()
			f8_arg0.FrameBorder:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FrameBorder)
			f8_arg0.ImageX:completeAnimation()
			f8_arg0.ImageX:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ImageX)
			f8_arg0.Glow:completeAnimation()
			f8_arg0.Glow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Glow)
			f8_arg0.Background:completeAnimation()
			f8_arg0.Background:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Background)
			f8_arg0.DotTiledBacking:completeAnimation()
			f8_arg0.DotTiledBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DotTiledBacking)
			f8_arg0.FocusBorder:completeAnimation()
			f8_arg0.FocusBorder:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FocusBorder)
		end,
	},
	CompletedState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.Glow:completeAnimation()
			f9_arg0.Glow:setAlpha(0.6)
			f9_arg0.clipFinished(f9_arg0.Glow)
			f9_arg0.Background:completeAnimation()
			f9_arg0.Background:setAlpha(0.7)
			f9_arg0.clipFinished(f9_arg0.Background)
			f9_arg0.DotTiledBacking:completeAnimation()
			f9_arg0.DotTiledBacking:setAlpha(0.25)
			f9_arg0.clipFinished(f9_arg0.DotTiledBacking)
			f9_arg0.FocusBorder:completeAnimation()
			f9_arg0.FocusBorder:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.FocusBorder)
		end,
	},
	IncompleteState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.SpecialEventProgressPip.__onClose = function(f11_arg0)
	f11_arg0.DotTiledBacking:close()
end

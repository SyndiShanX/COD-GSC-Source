CoD.WZTeamScoreboard_ColumnStatBox = InheritFrom(LUI.UIElement)
CoD.WZTeamScoreboard_ColumnStatBox.__defaultWidth = 140
CoD.WZTeamScoreboard_ColumnStatBox.__defaultHeight = 60
CoD.WZTeamScoreboard_ColumnStatBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamScoreboard_ColumnStatBox)
	self.id = "WZTeamScoreboard_ColumnStatBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0.93, 0, 0)
	NoiseBacking:setAlpha(0.85)
	NoiseBacking:setImage(RegisterImage(0xC082CFCA3C180E5))
	NoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseBacking:setupNineSliceShader(24, 24)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	local Tint = LUI.UIImage.new(0, 1, 0, 0, 0, 0.93, 0, 0)
	Tint:setAlpha(0.2)
	Tint:setImage(RegisterImage(0x4B6FFA90272070E))
	Tint:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Tint:setShaderVector(0, 0, 0, 0, 0)
	Tint:setupNineSliceShader(24, 24)
	self:addElement(Tint)
	self.Tint = Tint
	local BarBot = LUI.UIImage.new(0, 0, -3, 147, 0, 0, 54, 64)
	BarBot:setAlpha(0.4)
	BarBot:setImage(RegisterImage(0xC6873B923C6686C))
	BarBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BarBot)
	self.BarBot = BarBot
	local TintPC = nil
	TintPC = LUI.UIImage.new(0.5, 0.5, -72.5, 72.5, 0, 0, -0.5, 56.5)
	TintPC:setAlpha(0)
	TintPC:setImage(RegisterImage(0xC75052CB20103))
	self:addElement(TintPC)
	self.TintPC = TintPC
	local Value = LUI.UIText.new(0.5, 0.5, -69, 69, 0.5, 0.5, -13, 14)
	Value:setRGB(0.92, 0.92, 0.92)
	Value:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Value:setTTF("0arame_mono_stencil")
	Value:setLetterSpacing(1)
	Value:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Value:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Value)
	self.Value = Value
	self:mergeStateConditions({
		{
			stateName = "SelfPC",
			condition = function(menu, element, event)
				return IsPC() and IsSelfClient(f1_arg1, element)
			end,
		},
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, element)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamScoreboard_ColumnStatBox.__resetProperties = function(f6_arg0)
	f6_arg0.TintPC:completeAnimation()
	f6_arg0.Value:completeAnimation()
	f6_arg0.TintPC:setRGB(1, 1, 1)
	f6_arg0.TintPC:setAlpha(0)
	f6_arg0.Value:setRGB(0.92, 0.92, 0.92)
end
CoD.WZTeamScoreboard_ColumnStatBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	SelfPC = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.TintPC:completeAnimation()
			f8_arg0.TintPC:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.TintPC)
			f8_arg0.Value:completeAnimation()
			f8_arg0.Value:setRGB(1, 0.76, 0)
			f8_arg0.clipFinished(f8_arg0.Value)
		end,
	},
	Self = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Value:completeAnimation()
			f9_arg0.Value:setRGB(1, 0.76, 0)
			f9_arg0.clipFinished(f9_arg0.Value)
		end,
	},
	PC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.TintPC:completeAnimation()
			f10_arg0.TintPC:setRGB(1, 1, 1)
			f10_arg0.TintPC:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.TintPC)
			f10_arg0.Value:completeAnimation()
			f10_arg0.Value:setRGB(1, 1, 1)
			f10_arg0.clipFinished(f10_arg0.Value)
		end,
	},
}

CoD.WZTeamScoreboard_FooterStatBox = InheritFrom(LUI.UIElement)
CoD.WZTeamScoreboard_FooterStatBox.__defaultWidth = 150
CoD.WZTeamScoreboard_FooterStatBox.__defaultHeight = 86
CoD.WZTeamScoreboard_FooterStatBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamScoreboard_FooterStatBox)
	self.id = "WZTeamScoreboard_FooterStatBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BarBot = LUI.UIImage.new(0.5, 0.5, -78, 82, 0, 0, 79.5, 89.5)
	BarBot:setAlpha(0.5)
	BarBot:setImage(RegisterImage(0xC6873B923C6686C))
	BarBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BarBot)
	self.BarBot = BarBot
	local NoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 26, 82)
	NoiseBacking:setAlpha(0.85)
	NoiseBacking:setImage(RegisterImage(0xC082CFCA3C180E5))
	NoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseBacking:setupNineSliceShader(24, 24)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	local Tint2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 26, 82)
	Tint2:setAlpha(0.2)
	Tint2:setImage(RegisterImage(0x4B6FFA90272070E))
	Tint2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Tint2:setShaderVector(0, 0, 0, 0, 0)
	Tint2:setupNineSliceShader(24, 24)
	self:addElement(Tint2)
	self.Tint2 = Tint2
	local TintPC = nil
	TintPC = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 25.5, 82.5)
	TintPC:setAlpha(0)
	TintPC:setImage(RegisterImage(0xC75052CB20103))
	self:addElement(TintPC)
	self.TintPC = TintPC
	local Value = LUI.UIText.new(0.5, 0.5, -61.5, 61.5, 0.5, 0.5, -1.5, 25.5)
	Value:setRGB(0.92, 0.92, 0.92)
	Value:setText("")
	Value:setTTF("ttmussels_demibold")
	Value:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Value:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Value)
	self.Value = Value
	local Title = LUI.UIText.new(0.5, 0.5, -75, 75, 0, 0, 0, 15)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setText("")
	Title:setTTF("0arame_mono_stencil")
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Title)
	self.Title = Title
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
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return true
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
CoD.WZTeamScoreboard_FooterStatBox.__resetProperties = function(f7_arg0)
	f7_arg0.TintPC:completeAnimation()
	f7_arg0.Value:completeAnimation()
	f7_arg0.Title:completeAnimation()
	f7_arg0.TintPC:setRGB(1, 1, 1)
	f7_arg0.TintPC:setAlpha(0)
	f7_arg0.Value:setRGB(0.92, 0.92, 0.92)
	f7_arg0.Title:setTopBottom(0, 0, 0, 15)
	f7_arg0.Title:setLetterSpacing(0)
end
CoD.WZTeamScoreboard_FooterStatBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	SelfPC = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.TintPC:completeAnimation()
			f9_arg0.TintPC:setAlpha(0.2)
			f9_arg0.clipFinished(f9_arg0.TintPC)
			f9_arg0.Value:completeAnimation()
			f9_arg0.Value:setRGB(1, 0.76, 0)
			f9_arg0.clipFinished(f9_arg0.Value)
		end,
	},
	Self = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.TintPC:completeAnimation()
			f10_arg0.TintPC:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TintPC)
			f10_arg0.Value:completeAnimation()
			f10_arg0.Value:setRGB(1, 0.76, 0)
			f10_arg0.clipFinished(f10_arg0.Value)
		end,
	},
	PC = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.TintPC:completeAnimation()
			f11_arg0.TintPC:setRGB(1, 1, 1)
			f11_arg0.TintPC:setAlpha(0.2)
			f11_arg0.clipFinished(f11_arg0.TintPC)
			f11_arg0.Value:completeAnimation()
			f11_arg0.Value:setRGB(1, 1, 1)
			f11_arg0.clipFinished(f11_arg0.Value)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Title:completeAnimation()
			f12_arg0.Title:setTopBottom(0, 0, 0, 12)
			f12_arg0.Title:setLetterSpacing(1)
			f12_arg0.clipFinished(f12_arg0.Title)
		end,
	},
}

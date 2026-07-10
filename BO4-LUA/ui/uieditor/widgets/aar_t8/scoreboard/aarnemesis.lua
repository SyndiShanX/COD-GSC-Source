require("x64:cd411d79f2f54a5")
CoD.AARNemesis = InheritFrom(LUI.UIElement)
CoD.AARNemesis.__defaultWidth = 150
CoD.AARNemesis.__defaultHeight = 60
CoD.AARNemesis.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARNemesis)
	self.id = "AARNemesis"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.02, 0.02, 0.02)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local EnemeyBacking = LUI.UIImage.new(0.5, 0.5, -75, 75, -0.02, -0.02, -32, -1)
	EnemeyBacking:setImage(RegisterImage(0x20D05B34D3128F9))
	EnemeyBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	EnemeyBacking:setShaderVector(0, 0, 0, 0, 0)
	EnemeyBacking:setShaderVector(1, 1.01, 0.22, 0, 0)
	EnemeyBacking:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(EnemeyBacking)
	self.EnemeyBacking = EnemeyBacking
	local EnemyBotLineGlow = LUI.UIImage.new(0, 0, -8, 158, -0.03, -0.03, -13, 11)
	EnemyBotLineGlow:setAlpha(0.5)
	EnemyBotLineGlow:setImage(RegisterImage(0xA4F022E73A1CAC4))
	EnemyBotLineGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(EnemyBotLineGlow)
	self.EnemyBotLineGlow = EnemyBotLineGlow
	local TopBarRight = LUI.UIImage.new(0, 0, 0, 150, -0.01, -0.01, -1, 5)
	TopBarRight:setImage(RegisterImage(0x414B157493C31E2))
	TopBarRight:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	TopBarRight:setShaderVector(0, 0.13, -0.09, 0, 0)
	TopBarRight:setShaderVector(1, 2.01, 0.04, 0, 0)
	TopBarRight:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(TopBarRight)
	self.TopBarRight = TopBarRight
	local SelectedDotGlowAdd = LUI.UIImage.new(0, 0, 0, 150, 0, 0, 0, 60)
	SelectedDotGlowAdd:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	SelectedDotGlowAdd:setImage(RegisterImage(0xDE89A66BFC55B6D))
	SelectedDotGlowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	SelectedDotGlowAdd:setShaderVector(0, 0.2, 0, 0, 0)
	SelectedDotGlowAdd:setShaderVector(1, 5, 0.41, 0, 0)
	SelectedDotGlowAdd:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(SelectedDotGlowAdd)
	self.SelectedDotGlowAdd = SelectedDotGlowAdd
	local SelectedDotGlowAdd2 = LUI.UIImage.new(0, 0, 0, 150, 0, 0, 0, 60)
	SelectedDotGlowAdd2:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	SelectedDotGlowAdd2:setImage(RegisterImage(0xDE89A66BFC55B6D))
	SelectedDotGlowAdd2:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	SelectedDotGlowAdd2:setShaderVector(0, 0.2, 0, 0, 0)
	SelectedDotGlowAdd2:setShaderVector(1, 5, 0.41, 0, 0)
	SelectedDotGlowAdd2:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(SelectedDotGlowAdd2)
	self.SelectedDotGlowAdd2 = SelectedDotGlowAdd2
	local SelectedDotGlowAdd3 = LUI.UIImage.new(0, 0, 0, 150, 0, 0, 0, 60)
	SelectedDotGlowAdd3:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	SelectedDotGlowAdd3:setImage(RegisterImage(0xDE89A66BFC55B6D))
	SelectedDotGlowAdd3:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	SelectedDotGlowAdd3:setShaderVector(0, 0.2, 0, 0, 0)
	SelectedDotGlowAdd3:setShaderVector(1, 5, 0.41, 0, 0)
	SelectedDotGlowAdd3:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(SelectedDotGlowAdd3)
	self.SelectedDotGlowAdd3 = SelectedDotGlowAdd3
	local Line3 = LUI.UIImage.new(1, 1, -75, -74, 0, 0, 3, 57)
	Line3:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	Line3:setAlpha(0.03)
	self:addElement(Line3)
	self.Line3 = Line3
	local Line = LUI.UIImage.new(1, 1, -75, -74, 0, 0, 3, 57)
	Line:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	Line:setAlpha(0.1)
	self:addElement(Line)
	self.Line = Line
	local TopBarRight01 = LUI.UIImage.new(0, 0, 0, 150, 0, 0, 54, 60)
	TopBarRight01:setImage(RegisterImage(0x414B157493C31E2))
	TopBarRight01:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	TopBarRight01:setShaderVector(0, 0.13, -0.09, 0, 0)
	TopBarRight01:setShaderVector(1, 2.01, 0.07, 0, 0)
	TopBarRight01:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(TopBarRight01)
	self.TopBarRight01 = TopBarRight01
	local NemesisLabel = LUI.UIText.new(0, 0, 7, 207, 0, 0, -27, -5)
	NemesisLabel:setText(Engine[0xF9F1239CFD921FE](0xFAD031D22FA608C))
	NemesisLabel:setTTF("ttmussels_demibold")
	NemesisLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NemesisLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(NemesisLabel)
	self.NemesisLabel = NemesisLabel
	local NemesisKilledBy = CoD.AARNemesisStat.new(f1_arg0, f1_arg1, 0, 0, 73, 152, 0, 0, 7, 47)
	NemesisKilledBy.Label:setText(Engine[0xF9F1239CFD921FE](0x9266D7D9B2162F1))
	NemesisKilledBy:linkToElementModel(self, "killedBy", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NemesisKilledBy.Stat:setText(f2_local0)
		end
	end)
	self:addElement(NemesisKilledBy)
	self.NemesisKilledBy = NemesisKilledBy
	local NemesisKilled = CoD.AARNemesisStat.new(f1_arg0, f1_arg1, 0, 0, 7, 67, 0, 0, 7, 47)
	NemesisKilled.Label:setText(Engine[0xF9F1239CFD921FE](0x3B16F3D5BAEE9E4))
	NemesisKilled:linkToElementModel(self, "killed", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NemesisKilled.Stat:setText(f3_local0)
		end
	end)
	self:addElement(NemesisKilled)
	self.NemesisKilled = NemesisKilled
	local Skull = LUI.UIImage.new(0, 0, 102, 192, 0, 0, -34, 4)
	Skull:setImage(RegisterImage(0x5DC0AF629835B8A))
	self:addElement(Skull)
	self.Skull = Skull
	local arrow = LUI.UIImage.new(0, 0, -30, 2, 0, 0, 14, 46)
	arrow:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	arrow:setImage(RegisterImage(0x3E7760566946173))
	self:addElement(arrow)
	self.arrow = arrow
	self:mergeStateConditions({
		{
			stateName = "Nemesis",
			condition = function(menu, element, event)
				return CoD.AARUtility.ShouldShowNemesis(element, f1_arg1)
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsClientSelectedInScoreboard(element, f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18.currentFocusedClient, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "currentFocusedClient",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARNemesis.__resetProperties = function(f8_arg0)
	f8_arg0.EnemeyBacking:completeAnimation()
	f8_arg0.NemesisLabel:completeAnimation()
	f8_arg0.Skull:completeAnimation()
	f8_arg0.NemesisKilledBy:completeAnimation()
	f8_arg0.NemesisKilled:completeAnimation()
	f8_arg0.Backing:completeAnimation()
	f8_arg0.TopBarRight01:completeAnimation()
	f8_arg0.Line:completeAnimation()
	f8_arg0.Line3:completeAnimation()
	f8_arg0.SelectedDotGlowAdd3:completeAnimation()
	f8_arg0.SelectedDotGlowAdd2:completeAnimation()
	f8_arg0.SelectedDotGlowAdd:completeAnimation()
	f8_arg0.TopBarRight:completeAnimation()
	f8_arg0.EnemyBotLineGlow:completeAnimation()
	f8_arg0.arrow:completeAnimation()
	f8_arg0.EnemeyBacking:setAlpha(1)
	f8_arg0.NemesisLabel:setAlpha(1)
	f8_arg0.Skull:setAlpha(1)
	f8_arg0.NemesisKilledBy:setAlpha(1)
	f8_arg0.NemesisKilled:setAlpha(1)
	f8_arg0.Backing:setAlpha(0.5)
	f8_arg0.TopBarRight01:setAlpha(1)
	f8_arg0.Line:setAlpha(0.1)
	f8_arg0.Line3:setAlpha(0.03)
	f8_arg0.SelectedDotGlowAdd3:setAlpha(1)
	f8_arg0.SelectedDotGlowAdd2:setAlpha(1)
	f8_arg0.SelectedDotGlowAdd:setAlpha(1)
	f8_arg0.TopBarRight:setAlpha(1)
	f8_arg0.EnemyBotLineGlow:setAlpha(0.5)
	f8_arg0.arrow:setAlpha(1)
end
CoD.AARNemesis.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Nemesis = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Selected = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.EnemeyBacking:completeAnimation()
			f11_arg0.EnemeyBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.EnemeyBacking)
			f11_arg0.NemesisLabel:completeAnimation()
			f11_arg0.NemesisLabel:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.NemesisLabel)
			f11_arg0.Skull:completeAnimation()
			f11_arg0.Skull:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Skull)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(15)
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Backing)
			f12_arg0.EnemeyBacking:completeAnimation()
			f12_arg0.EnemeyBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.EnemeyBacking)
			f12_arg0.EnemyBotLineGlow:completeAnimation()
			f12_arg0.EnemyBotLineGlow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.EnemyBotLineGlow)
			f12_arg0.TopBarRight:completeAnimation()
			f12_arg0.TopBarRight:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TopBarRight)
			f12_arg0.SelectedDotGlowAdd:completeAnimation()
			f12_arg0.SelectedDotGlowAdd:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SelectedDotGlowAdd)
			f12_arg0.SelectedDotGlowAdd2:completeAnimation()
			f12_arg0.SelectedDotGlowAdd2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SelectedDotGlowAdd2)
			f12_arg0.SelectedDotGlowAdd3:completeAnimation()
			f12_arg0.SelectedDotGlowAdd3:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SelectedDotGlowAdd3)
			f12_arg0.Line3:completeAnimation()
			f12_arg0.Line3:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Line3)
			f12_arg0.Line:completeAnimation()
			f12_arg0.Line:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Line)
			f12_arg0.TopBarRight01:completeAnimation()
			f12_arg0.TopBarRight01:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TopBarRight01)
			f12_arg0.NemesisLabel:completeAnimation()
			f12_arg0.NemesisLabel:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.NemesisLabel)
			f12_arg0.NemesisKilledBy:completeAnimation()
			f12_arg0.NemesisKilledBy:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.NemesisKilledBy)
			f12_arg0.NemesisKilled:completeAnimation()
			f12_arg0.NemesisKilled:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.NemesisKilled)
			f12_arg0.Skull:completeAnimation()
			f12_arg0.Skull:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Skull)
			f12_arg0.arrow:completeAnimation()
			f12_arg0.arrow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.arrow)
		end,
	},
}
CoD.AARNemesis.__onClose = function(f13_arg0)
	f13_arg0.NemesisKilledBy:close()
	f13_arg0.NemesisKilled:close()
end

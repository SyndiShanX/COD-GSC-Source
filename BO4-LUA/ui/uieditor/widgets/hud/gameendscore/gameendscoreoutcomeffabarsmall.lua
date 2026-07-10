require("x64:a9255c570c68aa8")
CoD.GameEndScoreOutcomeFFABarSmall = InheritFrom(LUI.UIElement)
CoD.GameEndScoreOutcomeFFABarSmall.__defaultWidth = 826
CoD.GameEndScoreOutcomeFFABarSmall.__defaultHeight = 120
CoD.GameEndScoreOutcomeFFABarSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreOutcomeFFABarSmall)
	self.id = "GameEndScoreOutcomeFFABarSmall"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local DarkBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DarkBacking:setRGB(0, 0, 0)
	DarkBacking:setAlpha(0.4)
	self:addElement(DarkBacking)
	self.DarkBacking = DarkBacking
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
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
	local EmblemBacking1 = LUI.UIImage.new(0, 0, 3, 109, 0, 0, 3, 117)
	EmblemBacking1:setRGB(0, 0, 0)
	EmblemBacking1:setAlpha(0.3)
	self:addElement(EmblemBacking1)
	self.EmblemBacking1 = EmblemBacking1
	local EmblemBacking2 = LUI.UIImage.new(0, 0, 111, 680, 0, 0.95, 3, 3)
	EmblemBacking2:setRGB(0, 0, 0)
	EmblemBacking2:setAlpha(0.3)
	self:addElement(EmblemBacking2)
	self.EmblemBacking2 = EmblemBacking2
	local EmblemBacking3 = LUI.UIImage.new(0, 0, 683, 823, 0, 0.95, 3, 3)
	EmblemBacking3:setRGB(0, 0, 0)
	EmblemBacking3:setAlpha(0.3)
	self:addElement(EmblemBacking3)
	self.EmblemBacking3 = EmblemBacking3
	local GlowTexture = LUI.UIImage.new(0, 0, 6, 106, 0, 0, 10.5, 110.5)
	GlowTexture:setAlpha(0.1)
	GlowTexture:setImage(RegisterImage(0xC58FF2328701EBA))
	GlowTexture:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowTexture)
	self.GlowTexture = GlowTexture
	local Glow = LUI.UIImage.new(0, 0, 1, 111, 0, 0, 5.5, 115.5)
	Glow:setAlpha(0.6)
	Glow:setImage(RegisterImage(0xFAA6C81834660D3))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local Emblem = LUI.UIImage.new(0, 0, 124, 204, 0.5, 0.5, -40, 40)
	Emblem:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Emblem:setupPlayerEmblemByXUID(GetClientGameLobbyXUIDForClientNumString(f2_local0))
		end
	end)
	self:addElement(Emblem)
	self.Emblem = Emblem
	local Name = LUI.UIText.new(0.5, 0.5, -196, 222, 0.5, 0.5, -15, 15)
	Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Name:setTTF("notosans_regular")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Name:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local PlaceBanner = LUI.UIImage.new(0, 0, 16, 96, 0.5, 0.5, -39.5, 40.5)
	self:addElement(PlaceBanner)
	self.PlaceBanner = PlaceBanner
	local GlowSphere = LUI.UIImage.new(0, 0, 21, 92, 0, 0, 5.5, 115.5)
	GlowSphere:setAlpha(0.95)
	GlowSphere:setImage(RegisterImage(0x299DDAEBACCEECD))
	GlowSphere:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowSphere)
	self.GlowSphere = GlowSphere
	local GlowRing = LUI.UIImage.new(0, 0, 9, 103, 0, 0, 13, 107)
	GlowRing:setAlpha(0.15)
	GlowRing:setImage(RegisterImage(0x7A63CD655CD7572))
	GlowRing:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowRing)
	self.GlowRing = GlowRing
	local PlaceText = LUI.UIText.new(0, 0, 22, 90, 0.5, 0.5, -33, 35)
	PlaceText:setRGB(ColorSet.T8_FactionTier_Completed.r, ColorSet.T8_FactionTier_Completed.g, ColorSet.T8_FactionTier_Completed.b)
	PlaceText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PlaceText:setTTF("0arame_mono_stencil")
	PlaceText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlaceText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PlaceText)
	self.PlaceText = PlaceText
	local BGDotPatternLarge = LUI.UIImage.new(0, 0, 21, 91, 0, 0, 25, 95)
	BGDotPatternLarge:setAlpha(0.8)
	BGDotPatternLarge:setImage(RegisterImage(0xFC21A8215EA012B))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local Score = LUI.UIText.new(0, 0, 687.5, 821.5, 0.5, 0.5, -39, 40)
	Score:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Score:setTTF("0arame_mono_stencil")
	Score:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Score:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Score:linkToElementModel(self, "points", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Score:setText(f4_local0)
		end
	end)
	self:addElement(Score)
	self.Score = Score
	local TiledShaderImage1 = LUI.UIImage.new(0.2, 0.2, -163.5, -57.5, 0.02, 0.02, 0, 115)
	TiledShaderImage1:setAlpha(0.5)
	TiledShaderImage1:setImage(RegisterImage(0x4B6FFA90272070E))
	TiledShaderImage1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledShaderImage1:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage1:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage1)
	self.TiledShaderImage1 = TiledShaderImage1
	local TiledShaderImage2 = LUI.UIImage.new(0.2, 0.2, -55, 514, 0.02, 0.02, 0, 115)
	TiledShaderImage2:setAlpha(0.5)
	TiledShaderImage2:setImage(RegisterImage(0x4B6FFA90272070E))
	TiledShaderImage2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledShaderImage2:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage2:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage2)
	self.TiledShaderImage2 = TiledShaderImage2
	local TiledShaderImage3 = LUI.UIImage.new(0.2, 0.2, 516.5, 656.5, 0.02, 0.02, 0, 115)
	TiledShaderImage3:setAlpha(0.5)
	TiledShaderImage3:setImage(RegisterImage(0x4B6FFA90272070E))
	TiledShaderImage3:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledShaderImage3:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage3:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage3)
	self.TiledShaderImage3 = TiledShaderImage3
	local UnderLine1 = LUI.UIImage.new(0, 0, 3, 109, 0, 0, 113.5, 117.5)
	UnderLine1:setAlpha(0.2)
	UnderLine1:setImage(RegisterImage(0x7167D8C33A06020))
	UnderLine1:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	UnderLine1:setShaderVector(0, 0, 0, 0, 0)
	UnderLine1:setupNineSliceShader(64, 64)
	self:addElement(UnderLine1)
	self.UnderLine1 = UnderLine1
	local UnderLine2 = LUI.UIImage.new(0, 0, 111, 680, 0, 0, 113.5, 117.5)
	UnderLine2:setAlpha(0.2)
	UnderLine2:setImage(RegisterImage(0x7167D8C33A06020))
	UnderLine2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	UnderLine2:setShaderVector(0, 0, 0, 0, 0)
	UnderLine2:setupNineSliceShader(64, 64)
	self:addElement(UnderLine2)
	self.UnderLine2 = UnderLine2
	local UnderLine3 = LUI.UIImage.new(0, 0, 683, 823, 0, 0, 113.5, 117.5)
	UnderLine3:setAlpha(0.2)
	UnderLine3:setImage(RegisterImage(0x7167D8C33A06020))
	UnderLine3:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	UnderLine3:setShaderVector(0, 0, 0, 0, 0)
	UnderLine3:setupNineSliceShader(64, 64)
	self:addElement(UnderLine3)
	self.UnderLine3 = UnderLine3
	self:mergeStateConditions({
		{
			stateName = "NoPlayers",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("scoreboard.team1.count", 0) and CoD.ModelUtility.IsGlobalModelValueEqualTo("scoreboard.team2.count", 0)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hidden")
			end,
		},
		{
			stateName = "IsLocalPlayer",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocalPlayer")
			end,
		},
	})
	local f1_local24 = self
	local f1_local25 = self.subscribeToModel
	local f1_local26 = Engine[0x8DF2E5447F384B9]()
	f1_local25(f1_local24, f1_local26["scoreboard.team1.count"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	f1_local24 = self
	f1_local25 = self.subscribeToModel
	f1_local26 = Engine[0x8DF2E5447F384B9]()
	f1_local25(f1_local24, f1_local26["scoreboard.team2.count"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	self:linkToElementModel(self, "hidden", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hidden",
		})
	end)
	self:linkToElementModel(self, "isLocalPlayer", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocalPlayer",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreOutcomeFFABarSmall.__resetProperties = function(f12_arg0)
	f12_arg0.Emblem:completeAnimation()
	f12_arg0.Score:completeAnimation()
	f12_arg0.PlaceText:completeAnimation()
	f12_arg0.PlaceBanner:completeAnimation()
	f12_arg0.Name:completeAnimation()
	f12_arg0.Emblem:setAlpha(1)
	f12_arg0.Score:setAlpha(1)
	f12_arg0.PlaceText:setAlpha(1)
	f12_arg0.PlaceBanner:setAlpha(1)
	f12_arg0.Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f12_arg0.Name:setAlpha(1)
end
CoD.GameEndScoreOutcomeFFABarSmall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	NoPlayers = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Emblem:completeAnimation()
			f14_arg0.Emblem:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Emblem)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.Emblem:completeAnimation()
			f15_arg0.Emblem:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Emblem)
			f15_arg0.Name:completeAnimation()
			f15_arg0.Name:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Name)
			f15_arg0.PlaceBanner:completeAnimation()
			f15_arg0.PlaceBanner:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PlaceBanner)
			f15_arg0.PlaceText:completeAnimation()
			f15_arg0.PlaceText:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PlaceText)
			f15_arg0.Score:completeAnimation()
			f15_arg0.Score:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Score)
		end,
	},
	IsLocalPlayer = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Name:completeAnimation()
			f16_arg0.Name:setRGB(0.95, 0.9, 0.18)
			f16_arg0.clipFinished(f16_arg0.Name)
		end,
	},
}
CoD.GameEndScoreOutcomeFFABarSmall.__onClose = function(f17_arg0)
	f17_arg0.Frame:close()
	f17_arg0.Emblem:close()
	f17_arg0.Name:close()
	f17_arg0.Score:close()
end

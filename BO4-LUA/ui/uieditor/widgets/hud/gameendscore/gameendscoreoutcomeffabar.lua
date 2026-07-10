require("x64:a9255c570c68aa8")
CoD.GameEndScoreOutcomeFFABar = InheritFrom(LUI.UIElement)
CoD.GameEndScoreOutcomeFFABar.__defaultWidth = 959
CoD.GameEndScoreOutcomeFFABar.__defaultHeight = 160
CoD.GameEndScoreOutcomeFFABar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreOutcomeFFABar)
	self.id = "GameEndScoreOutcomeFFABar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
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
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.15)
	self:addElement(Frame)
	self.Frame = Frame
	local EmblemBacking = LUI.UIImage.new(0, 0, 3, 137, 0.03, 0.03, 0, 152)
	EmblemBacking:setRGB(0, 0, 0)
	EmblemBacking:setAlpha(0.3)
	self:addElement(EmblemBacking)
	self.EmblemBacking = EmblemBacking
	local EmblemBacking3 = LUI.UIImage.new(0, 0, 768, 956, 0, 0, 3, 156)
	EmblemBacking3:setRGB(0, 0, 0)
	EmblemBacking3:setAlpha(0.3)
	self:addElement(EmblemBacking3)
	self.EmblemBacking3 = EmblemBacking3
	local EmblemBacking2 = LUI.UIImage.new(0, 0, 140, 765, 0.03, 0.03, 0, 152)
	EmblemBacking2:setRGB(0, 0, 0)
	EmblemBacking2:setAlpha(0.3)
	self:addElement(EmblemBacking2)
	self.EmblemBacking2 = EmblemBacking2
	local GlowTexture = LUI.UIImage.new(0, 0, 6.5, 133.5, 0.5, 0.5, -63.5, 63.5)
	GlowTexture:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	GlowTexture:setAlpha(0.15)
	GlowTexture:setImage(RegisterImage(@"uie_ui_hud_core_no_ammo_glow"))
	GlowTexture:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowTexture)
	self.GlowTexture = GlowTexture
	local Glow = LUI.UIImage.new(0, 0, -2, 142, 0, 0, 8, 152)
	Glow:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	Glow:setImage(RegisterImage(@"uie_ui_menu_common_box_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local Emblem = LUI.UIImage.new(0, 0, 148, 248, 0.5, 0.5, -50, 50)
	Emblem:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Emblem:setupPlayerEmblemByXUID(GetClientGameLobbyXUIDForClientNumString(f2_local0))
		end
	end)
	self:addElement(Emblem)
	self.Emblem = Emblem
	local Name = LUI.UIText.new(0.5, 0.5, -226.5, 281.5, 0.5, 0.5, -15, 15)
	Name:setTTF("notosans_regular")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local PlaceBanner = LUI.UIImage.new(0, 0, 17.5, 122.5, 0.5, 0.5, -52.5, 52.5)
	PlaceBanner:setRGB(0.91, 0.78, 0.28)
	self:addElement(PlaceBanner)
	self.PlaceBanner = PlaceBanner
	local GlowSphere = LUI.UIImage.new(0, 0, 34.5, 105.5, 0, 0, 6, 156)
	GlowSphere:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	GlowSphere:setAlpha(0.95)
	GlowSphere:setImage(RegisterImage(@"uie_fire_glow"))
	GlowSphere:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowSphere)
	self.GlowSphere = GlowSphere
	local GlowRing = LUI.UIImage.new(0, 0, 6.5, 131.5, 0, 0, 17, 142)
	GlowRing:setRGB(0.91, 0.78, 0.28)
	GlowRing:setAlpha(0.15)
	GlowRing:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_qe_glow"))
	GlowRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowRing)
	self.GlowRing = GlowRing
	local PlaceText = LUI.UIText.new(0, 0, 25, 115, 0.5, 0.5, -44, 46)
	PlaceText:setRGB(ColorSet.T8_FactionTier_Completed.r, ColorSet.T8_FactionTier_Completed.g, ColorSet.T8_FactionTier_Completed.b)
	PlaceText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	PlaceText:setTTF("0arame_mono_stencil")
	PlaceText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlaceText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlaceText)
	self.PlaceText = PlaceText
	local BGDotPatternLarge = LUI.UIImage.new(0, 0, 22.5, 117.5, 0, 0, 32, 127)
	BGDotPatternLarge:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	BGDotPatternLarge:setAlpha(0.8)
	BGDotPatternLarge:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	BGDotPatternLarge:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	BGDotPatternLarge:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge:setupNineSliceShader(4, 4)
	self:addElement(BGDotPatternLarge)
	self.BGDotPatternLarge = BGDotPatternLarge
	local Score = LUI.UIText.new(0, 0, 772.5, 953.5, 0.5, 0.5, -39, 39)
	Score:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Score:setTTF("0arame_mono_stencil")
	Score:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Score:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Score:linkToElementModel(self, "points", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Score:setText(f4_local0)
		end
	end)
	self:addElement(Score)
	self.Score = Score
	local TiledShaderImage1 = LUI.UIImage.new(0.2, 0.2, -190, -56, 0.02, 0.02, 0.5, 152.5)
	TiledShaderImage1:setAlpha(0.5)
	TiledShaderImage1:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledShaderImage1:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage1:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage1)
	self.TiledShaderImage1 = TiledShaderImage1
	local TiledShaderImage2 = LUI.UIImage.new(0.2, 0.2, -53, 572, 0.02, 0.02, 0.5, 152.5)
	TiledShaderImage2:setAlpha(0.5)
	TiledShaderImage2:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledShaderImage2:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage2:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage2)
	self.TiledShaderImage2 = TiledShaderImage2
	local TiledShaderImage3 = LUI.UIImage.new(0.2, 0.2, 575, 763, 0.02, 0.02, 0, 152)
	TiledShaderImage3:setAlpha(0.5)
	TiledShaderImage3:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledShaderImage3:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage3:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage3)
	self.TiledShaderImage3 = TiledShaderImage3
	local UnderLine1 = LUI.UIImage.new(0, 0, 3, 137, 0, 0, 152, 156)
	UnderLine1:setAlpha(0.2)
	UnderLine1:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	UnderLine1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	UnderLine1:setShaderVector(0, 0, 0, 0, 0)
	UnderLine1:setupNineSliceShader(64, 64)
	self:addElement(UnderLine1)
	self.UnderLine1 = UnderLine1
	local UnderLine2 = LUI.UIImage.new(0, 0, 140, 765, 0, 0, 152, 156)
	UnderLine2:setAlpha(0.2)
	UnderLine2:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	UnderLine2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	UnderLine2:setShaderVector(0, 0, 0, 0, 0)
	UnderLine2:setupNineSliceShader(64, 64)
	self:addElement(UnderLine2)
	self.UnderLine2 = UnderLine2
	local UnderLine3 = LUI.UIImage.new(0, 0, 768, 956, 0, 0, 152, 156)
	UnderLine3:setAlpha(0.2)
	UnderLine3:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	UnderLine3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
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
	local f1_local26 = Engine[@"getglobalmodel"]()
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
	f1_local26 = Engine[@"getglobalmodel"]()
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
CoD.GameEndScoreOutcomeFFABar.__resetProperties = function(f12_arg0)
	f12_arg0.Emblem:completeAnimation()
	f12_arg0.Score:completeAnimation()
	f12_arg0.PlaceText:completeAnimation()
	f12_arg0.PlaceBanner:completeAnimation()
	f12_arg0.Name:completeAnimation()
	f12_arg0.Emblem:setAlpha(1)
	f12_arg0.Score:setAlpha(1)
	f12_arg0.PlaceText:setAlpha(1)
	f12_arg0.PlaceBanner:setAlpha(1)
	f12_arg0.Name:setRGB(1, 1, 1)
	f12_arg0.Name:setAlpha(1)
end
CoD.GameEndScoreOutcomeFFABar.__clipsPerState = {
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
CoD.GameEndScoreOutcomeFFABar.__onClose = function(f17_arg0)
	f17_arg0.Frame:close()
	f17_arg0.Emblem:close()
	f17_arg0.Name:close()
	f17_arg0.Score:close()
end

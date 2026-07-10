require("x64:41ad734fb8d6d92")
CoD.BountyHunterAmmoBuyInternal = InheritFrom(LUI.UIElement)
CoD.BountyHunterAmmoBuyInternal.__defaultWidth = 280
CoD.BountyHunterAmmoBuyInternal.__defaultHeight = 48
CoD.BountyHunterAmmoBuyInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterAmmoBuyInternal)
	self.id = "BountyHunterAmmoBuyInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local FocusGlow = LUI.UIImage.new(0, 1, -133, 133, 0, 1, -15, 15)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_large"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(300, 300)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local NoiseTiledBackingMain = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBackingMain:setAlpha(0.8)
	NoiseTiledBackingMain:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingMain:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBackingMain:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingMain:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingMain)
	self.NoiseTiledBackingMain = NoiseTiledBackingMain
	local SelectOvelay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectOvelay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectOvelay:setAlpha(0.01)
	self:addElement(SelectOvelay)
	self.SelectOvelay = SelectOvelay
	local ButtonBGTiled = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ButtonBGTiled:setRGB(0.28, 0.28, 0.28)
	ButtonBGTiled:setAlpha(0.8)
	ButtonBGTiled:setImage(RegisterImage(@"hash_7D78A9159503BFBB"))
	ButtonBGTiled:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	ButtonBGTiled:setShaderVector(0, 0, 0, 0, 0)
	ButtonBGTiled:setupNineSliceShader(16, 16)
	self:addElement(ButtonBGTiled)
	self.ButtonBGTiled = ButtonBGTiled
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGrid:setAlpha(0.05)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 55.5, 219.5, 0.5, 0.5, -12, 10)
	NoiseTiledBacking:setRGB(0.41, 0.55, 0.22)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBacking2 = LUI.UIImage.new(0, 0, 53.5, 55.5, 0.5, 0.5, -12, 10)
	NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	NoiseTiledBacking2:setImage(RegisterImage(@"hash_1519D21799A7D188"))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(16, 16)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local Refill = LUI.UIText.new(0, 0, 59.5, 161.5, 0.5, 0.5, -9.5, 9.5)
	Refill:setRGB(0.07, 0.09, 0.04)
	Refill:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3D5AA68BA080C3B6"))
	Refill:setTTF("ttmussels_demibold")
	Refill:setLetterSpacing(2)
	Refill:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Refill:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Refill)
	self.Refill = Refill
	local DollarSign = LUI.UIText.new(0, 0, 165.5, 181.5, 0.5, 0.5, -9.5, 9.5)
	DollarSign:setRGB(0.75, 0.92, 0.59)
	DollarSign:setText(CoD.BaseUtility.AlreadyLocalized("$"))
	DollarSign:setTTF("ttmussels_regular")
	DollarSign:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DollarSign:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DollarSign)
	self.DollarSign = DollarSign
	local Cost = LUI.UIText.new(0, 0, 177.5, 225.5, 0.5, 0.5, -9.5, 9.5)
	Cost:setRGB(0.75, 0.92, 0.59)
	Cost:setTTF("ttmussels_regular")
	Cost:setLetterSpacing(2)
	Cost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Cost:linkToElementModel(self, "refillCost", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Cost:setText(f2_local0)
		end
	end)
	self:addElement(Cost)
	self.Cost = Cost
	local Full = LUI.UIText.new(0, 0, 177.5, 225.5, 0.5, 0.5, -9.5, 9.5)
	Full:setRGB(0, 0, 0)
	Full:setAlpha(0)
	Full:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3FE53EF0EFB00EBB"))
	Full:setTTF("ttmussels_regular")
	Full:setLetterSpacing(2)
	Full:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Full)
	self.Full = Full
	local AmmoImage = LUI.UIImage.new(1, 1, -35.5, 1.5, 0.5, 0.5, -64, -27)
	AmmoImage:setImage(RegisterImage(@"uie_ui_icon_bounty_hunter_pickup_ammo"))
	self:addElement(AmmoImage)
	self.AmmoImage = AmmoImage
	local MaxAmmo2 = LUI.UIText.new(1, 1, -75.5, -21.5, 0.5, 0.5, -53, -32)
	MaxAmmo2:setTTF("ttmussels_regular")
	MaxAmmo2:setLetterSpacing(2)
	MaxAmmo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MaxAmmo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	MaxAmmo2:linkToElementModel(self, "ammoMax", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MaxAmmo2:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(MaxAmmo2)
	self.MaxAmmo2 = MaxAmmo2
	local CurrentAmmo = LUI.UIText.new(1, 1, -140.5, -88.5, 0.5, 0.5, -53, -32)
	CurrentAmmo:setTTF("ttmussels_regular")
	CurrentAmmo:setLetterSpacing(2)
	CurrentAmmo:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	CurrentAmmo:linkToElementModel(self, "ammoCurrent", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CurrentAmmo:setText(CoD.BaseUtility.AlreadyLocalized(f4_local0))
		end
	end)
	self:addElement(CurrentAmmo)
	self.CurrentAmmo = CurrentAmmo
	local MaxAmmoPreview = LUI.UIText.new(1, 1, -140.5, -88.5, 0.5, 0.5, -53, -32)
	MaxAmmoPreview:setRGB(0, 1, 0.04)
	MaxAmmoPreview:setAlpha(0)
	MaxAmmoPreview:setTTF("ttmussels_regular")
	MaxAmmoPreview:setLetterSpacing(2)
	MaxAmmoPreview:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	MaxAmmoPreview:linkToElementModel(self, "ammoMax", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MaxAmmoPreview:setText(CoD.BaseUtility.AlreadyLocalized(f5_local0))
		end
	end)
	self:addElement(MaxAmmoPreview)
	self.MaxAmmoPreview = MaxAmmoPreview
	local Slash = LUI.UIText.new(1, 1, -91.5, -72.5, 0.5, 0.5, -51.5, -33.5)
	Slash:setText(CoD.BaseUtility.AlreadyLocalized("/"))
	Slash:setTTF("ttmussels_regular")
	Slash:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Slash:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Slash)
	self.Slash = Slash
	local CommonButtonOutlineThin = CoD.CommonButtonOutlineThin.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutlineThin.FocusGlow:setScale(1, 0.9)
	self:addElement(CommonButtonOutlineThin)
	self.CommonButtonOutlineThin = CommonButtonOutlineThin
	self:mergeStateConditions({
		{
			stateName = "NoWeapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "packageID")
			end,
		},
		{
			stateName = "NoAmmoWeapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "ammoMax")
			end,
		},
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsAmmoAtMax(self, f1_arg1)
			end,
		},
		{
			stateName = "CannotAfford",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsRefillTooExpensive(self, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "packageID", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "packageID",
		})
	end)
	self:linkToElementModel(self, "ammoMax", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoMax",
		})
	end)
	self:linkToElementModel(self, "ammoCurrent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoCurrent",
		})
	end)
	self:linkToElementModel(self, "refillCost", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refillCost",
		})
	end)
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local20(f1_local19, f1_local21["luielement.BountyHunterLoadout.money"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "luielement.BountyHunterLoadout.money",
		})
	end, false)
	CommonButtonOutlineThin.id = "CommonButtonOutlineThin"
	self.__defaultFocus = CommonButtonOutlineThin
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterAmmoBuyInternal.__resetProperties = function(f15_arg0)
	f15_arg0.MaxAmmoPreview:completeAnimation()
	f15_arg0.CurrentAmmo:completeAnimation()
	f15_arg0.SelectOvelay:completeAnimation()
	f15_arg0.AmmoImage:completeAnimation()
	f15_arg0.Cost:completeAnimation()
	f15_arg0.DollarSign:completeAnimation()
	f15_arg0.Refill:completeAnimation()
	f15_arg0.NoiseTiledBacking:completeAnimation()
	f15_arg0.NoiseTiledBacking2:completeAnimation()
	f15_arg0.ButtonBGTiled:completeAnimation()
	f15_arg0.PixelGrid:completeAnimation()
	f15_arg0.Slash:completeAnimation()
	f15_arg0.MaxAmmo2:completeAnimation()
	f15_arg0.CommonButtonOutlineThin:completeAnimation()
	f15_arg0.NoiseTiledBackingMain:completeAnimation()
	f15_arg0.Full:completeAnimation()
	f15_arg0.MaxAmmoPreview:setAlpha(0)
	f15_arg0.CurrentAmmo:setAlpha(1)
	f15_arg0.SelectOvelay:setAlpha(0.01)
	f15_arg0.AmmoImage:setAlpha(1)
	f15_arg0.Cost:setRGB(0.75, 0.92, 0.59)
	f15_arg0.Cost:setAlpha(1)
	f15_arg0.DollarSign:setRGB(0.75, 0.92, 0.59)
	f15_arg0.DollarSign:setAlpha(1)
	f15_arg0.Refill:setRGB(0.07, 0.09, 0.04)
	f15_arg0.Refill:setAlpha(1)
	f15_arg0.NoiseTiledBacking:setRGB(0.41, 0.55, 0.22)
	f15_arg0.NoiseTiledBacking:setAlpha(0.5)
	f15_arg0.NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	f15_arg0.NoiseTiledBacking2:setAlpha(1)
	f15_arg0.ButtonBGTiled:setAlpha(0.8)
	f15_arg0.PixelGrid:setAlpha(0.05)
	f15_arg0.Slash:setAlpha(1)
	f15_arg0.MaxAmmo2:setAlpha(1)
	f15_arg0.CommonButtonOutlineThin:setAlpha(1)
	f15_arg0.NoiseTiledBackingMain:setAlpha(0.8)
	f15_arg0.Full:setAlpha(0)
end
CoD.BountyHunterAmmoBuyInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.SelectOvelay:completeAnimation()
			f17_arg0.SelectOvelay:setAlpha(0.04)
			f17_arg0.clipFinished(f17_arg0.SelectOvelay)
			f17_arg0.CurrentAmmo:completeAnimation()
			f17_arg0.CurrentAmmo:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.CurrentAmmo)
			f17_arg0.MaxAmmoPreview:completeAnimation()
			f17_arg0.MaxAmmoPreview:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.MaxAmmoPreview)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			local f18_local0 = function(f19_arg0)
				f18_arg0.SelectOvelay:beginAnimation(200)
				f18_arg0.SelectOvelay:setAlpha(0.04)
				f18_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.SelectOvelay:completeAnimation()
			f18_arg0.SelectOvelay:setAlpha(0.01)
			f18_local0(f18_arg0.SelectOvelay)
			local f18_local1 = function(f20_arg0)
				f18_arg0.CurrentAmmo:beginAnimation(200)
				f18_arg0.CurrentAmmo:setAlpha(0)
				f18_arg0.CurrentAmmo:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.CurrentAmmo:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.CurrentAmmo:completeAnimation()
			f18_arg0.CurrentAmmo:setAlpha(1)
			f18_local1(f18_arg0.CurrentAmmo)
			local f18_local2 = function(f21_arg0)
				f18_arg0.MaxAmmoPreview:beginAnimation(200)
				f18_arg0.MaxAmmoPreview:setAlpha(1)
				f18_arg0.MaxAmmoPreview:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.MaxAmmoPreview:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.MaxAmmoPreview:completeAnimation()
			f18_arg0.MaxAmmoPreview:setAlpha(0)
			f18_local2(f18_arg0.MaxAmmoPreview)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.SelectOvelay:beginAnimation(200)
				f22_arg0.SelectOvelay:setAlpha(0.01)
				f22_arg0.SelectOvelay:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.SelectOvelay:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.SelectOvelay:completeAnimation()
			f22_arg0.SelectOvelay:setAlpha(0.04)
			f22_local0(f22_arg0.SelectOvelay)
			local f22_local1 = function(f24_arg0)
				f22_arg0.CurrentAmmo:beginAnimation(200)
				f22_arg0.CurrentAmmo:setAlpha(1)
				f22_arg0.CurrentAmmo:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.CurrentAmmo:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.CurrentAmmo:completeAnimation()
			f22_arg0.CurrentAmmo:setAlpha(0)
			f22_local1(f22_arg0.CurrentAmmo)
			local f22_local2 = function(f25_arg0)
				f22_arg0.MaxAmmoPreview:beginAnimation(200)
				f22_arg0.MaxAmmoPreview:setAlpha(0)
				f22_arg0.MaxAmmoPreview:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.MaxAmmoPreview:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.MaxAmmoPreview:completeAnimation()
			f22_arg0.MaxAmmoPreview:setAlpha(1)
			f22_local2(f22_arg0.MaxAmmoPreview)
		end,
	},
	NoWeapon = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(13)
			f26_arg0.NoiseTiledBackingMain:completeAnimation()
			f26_arg0.NoiseTiledBackingMain:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.NoiseTiledBackingMain)
			f26_arg0.ButtonBGTiled:completeAnimation()
			f26_arg0.ButtonBGTiled:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ButtonBGTiled)
			f26_arg0.PixelGrid:completeAnimation()
			f26_arg0.PixelGrid:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PixelGrid)
			f26_arg0.NoiseTiledBacking:completeAnimation()
			f26_arg0.NoiseTiledBacking:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.NoiseTiledBacking)
			f26_arg0.NoiseTiledBacking2:completeAnimation()
			f26_arg0.NoiseTiledBacking2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.NoiseTiledBacking2)
			f26_arg0.Refill:completeAnimation()
			f26_arg0.Refill:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Refill)
			f26_arg0.DollarSign:completeAnimation()
			f26_arg0.DollarSign:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DollarSign)
			f26_arg0.Cost:completeAnimation()
			f26_arg0.Cost:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Cost)
			f26_arg0.AmmoImage:completeAnimation()
			f26_arg0.AmmoImage:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.AmmoImage)
			f26_arg0.MaxAmmo2:completeAnimation()
			f26_arg0.MaxAmmo2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.MaxAmmo2)
			f26_arg0.CurrentAmmo:completeAnimation()
			f26_arg0.CurrentAmmo:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CurrentAmmo)
			f26_arg0.Slash:completeAnimation()
			f26_arg0.Slash:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Slash)
			f26_arg0.CommonButtonOutlineThin:completeAnimation()
			f26_arg0.CommonButtonOutlineThin:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CommonButtonOutlineThin)
		end,
	},
	NoAmmoWeapon = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(13)
			f27_arg0.NoiseTiledBackingMain:completeAnimation()
			f27_arg0.NoiseTiledBackingMain:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.NoiseTiledBackingMain)
			f27_arg0.ButtonBGTiled:completeAnimation()
			f27_arg0.ButtonBGTiled:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ButtonBGTiled)
			f27_arg0.PixelGrid:completeAnimation()
			f27_arg0.PixelGrid:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.PixelGrid)
			f27_arg0.NoiseTiledBacking:completeAnimation()
			f27_arg0.NoiseTiledBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.NoiseTiledBacking)
			f27_arg0.NoiseTiledBacking2:completeAnimation()
			f27_arg0.NoiseTiledBacking2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.NoiseTiledBacking2)
			f27_arg0.Refill:completeAnimation()
			f27_arg0.Refill:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Refill)
			f27_arg0.DollarSign:completeAnimation()
			f27_arg0.DollarSign:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DollarSign)
			f27_arg0.Cost:completeAnimation()
			f27_arg0.Cost:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Cost)
			f27_arg0.AmmoImage:completeAnimation()
			f27_arg0.AmmoImage:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.AmmoImage)
			f27_arg0.MaxAmmo2:completeAnimation()
			f27_arg0.MaxAmmo2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.MaxAmmo2)
			f27_arg0.CurrentAmmo:completeAnimation()
			f27_arg0.CurrentAmmo:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.CurrentAmmo)
			f27_arg0.Slash:completeAnimation()
			f27_arg0.Slash:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Slash)
			f27_arg0.CommonButtonOutlineThin:completeAnimation()
			f27_arg0.CommonButtonOutlineThin:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.CommonButtonOutlineThin)
		end,
	},
	Purchased = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			f28_arg0.NoiseTiledBacking:completeAnimation()
			f28_arg0.NoiseTiledBacking:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.NoiseTiledBacking)
			f28_arg0.NoiseTiledBacking2:completeAnimation()
			f28_arg0.NoiseTiledBacking2:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.NoiseTiledBacking2)
			f28_arg0.DollarSign:completeAnimation()
			f28_arg0.DollarSign:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DollarSign)
			f28_arg0.Cost:completeAnimation()
			f28_arg0.Cost:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Cost)
			f28_arg0.Full:completeAnimation()
			f28_arg0.Full:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Full)
		end,
	},
	CannotAfford = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(5)
			f29_arg0.NoiseTiledBacking:completeAnimation()
			f29_arg0.NoiseTiledBacking:setRGB(0.55, 0.22, 0.22)
			f29_arg0.NoiseTiledBacking:setAlpha(0.75)
			f29_arg0.clipFinished(f29_arg0.NoiseTiledBacking)
			f29_arg0.NoiseTiledBacking2:completeAnimation()
			f29_arg0.NoiseTiledBacking2:setRGB(1, 0.14, 0.14)
			f29_arg0.clipFinished(f29_arg0.NoiseTiledBacking2)
			f29_arg0.Refill:completeAnimation()
			f29_arg0.Refill:setRGB(0.09, 0.04, 0.04)
			f29_arg0.clipFinished(f29_arg0.Refill)
			f29_arg0.DollarSign:completeAnimation()
			f29_arg0.DollarSign:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f29_arg0.clipFinished(f29_arg0.DollarSign)
			f29_arg0.Cost:completeAnimation()
			f29_arg0.Cost:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f29_arg0.clipFinished(f29_arg0.Cost)
		end,
	},
}
CoD.BountyHunterAmmoBuyInternal.__onClose = function(f30_arg0)
	f30_arg0.Cost:close()
	f30_arg0.MaxAmmo2:close()
	f30_arg0.CurrentAmmo:close()
	f30_arg0.MaxAmmoPreview:close()
	f30_arg0.CommonButtonOutlineThin:close()
end

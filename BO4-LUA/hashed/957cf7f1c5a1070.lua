require("x64:3e426332d66c91e")
require("x64:f78acfcbc465bba")
require("x64:fb1ca312b5b024e")
require("x64:be4ff35ca001915")
require("x64:dd2971a6510d135")
require("x64:f9f0e41049e1efe")
require("x64:9532492bc6fcfca")
CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal = InheritFrom(LUI.UIElement)
CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal.__defaultWidth = 482
CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal.__defaultHeight = 150
CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal)
	self.id = "LaboratoryListItemNebuliumPlasmaDiscount_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LaboratoryOfferNameAndDescription = CoD.LaboratoryOfferNameAndDescription.new(f1_arg0, f1_arg1, 0, 0, 0, 480, 0, 0, 195, 237)
	LaboratoryOfferNameAndDescription:setAlpha(0)
	LaboratoryOfferNameAndDescription:linkToElementModel(self, nil, false, function(model)
		LaboratoryOfferNameAndDescription:setModel(model, f1_arg1)
	end)
	LaboratoryOfferNameAndDescription:linkToElementModel(self, "labelName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LaboratoryOfferNameAndDescription.name:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(LaboratoryOfferNameAndDescription)
	self.LaboratoryOfferNameAndDescription = LaboratoryOfferNameAndDescription
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0.4, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local StoneTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	StoneTiledBacking:setAlpha(0.8)
	StoneTiledBacking:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonbgtile"))
	StoneTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	StoneTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	StoneTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(StoneTiledBacking)
	self.StoneTiledBacking = StoneTiledBacking
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.3)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlayRed = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlayRed:setRGB(0.89, 0.12, 0.12)
	SelectorOverlayRed:setAlpha(0)
	self:addElement(SelectorOverlayRed)
	self.SelectorOverlayRed = SelectorOverlayRed
	local SelectorOverlayWhite = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlayWhite:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlayWhite:setAlpha(0.01)
	self:addElement(SelectorOverlayWhite)
	self.SelectorOverlayWhite = SelectorOverlayWhite
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local LightFocus = LUI.UIImage.new(-0.05, 1.05, 0.5, 0.5, 0.5, 0.5, -74.5, 84.5)
	LightFocus:setAlpha(0)
	LightFocus:setImage(RegisterImage(@"uie_ui_menu_zombies_cac_special_weapon_light_focus"))
	self:addElement(LightFocus)
	self.LightFocus = LightFocus
	local FocusGlow = LUI.UIImage.new(0.19, 0.81, -240, 240, 0.2, 0.8, -74, 74)
	FocusGlow:setRGB(0.89, 0.12, 0.12)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_large"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(300, 300)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	Lines:setAlpha(0)
	self:addElement(Lines)
	self.Lines = Lines
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -10, 10)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local MetalFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	MetalFrame:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonframe"))
	MetalFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	MetalFrame:setShaderVector(0, 0, 0, 0, 0)
	MetalFrame:setupNineSliceShader(16, 16)
	self:addElement(MetalFrame)
	self.MetalFrame = MetalFrame
	local MetalFrameAdditive = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	MetalFrameAdditive:setRGB(0.89, 0.12, 0.12)
	MetalFrameAdditive:setAlpha(0)
	MetalFrameAdditive:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonframe"))
	MetalFrameAdditive:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	MetalFrameAdditive:setShaderVector(0, 0, 0, 0, 0)
	MetalFrameAdditive:setupNineSliceShader(16, 16)
	self:addElement(MetalFrameAdditive)
	self.MetalFrameAdditive = MetalFrameAdditive
	local metal = LUI.UIImage.new(0, 0, -5.5, 486.5, 0, 0, -7, 157)
	metal:setImage(RegisterImage(@"uie_ui_zm_laboratory_special_offer_metal"))
	self:addElement(metal)
	self.metal = metal
	local Glint = LUI.UIImage.new(0, 0, 3, 478, 0, 0, 4, 147)
	Glint:setRGB(0.37, 0.25, 0.7)
	Glint:setAlpha(0)
	Glint:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_glint_add"))
	Glint:setShaderVector(0, 1.24, 0, 0, 0)
	Glint:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(Glint)
	self.Glint = Glint
	local Smoke = LUI.UIImage.new(0, 0, 3, 478, 0, 0, 0.5, 137.5)
	Smoke:setRGB(0.15, 0.02, 0.95)
	Smoke:setImage(RegisterImage(@"uie_ui_zm_laboratory_special_offer_smoke"))
	Smoke:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Smoke:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Smoke)
	self.Smoke = Smoke
	local Smoke2 = LUI.UIImage.new(0, 0, 3, 478, 0, 0, 0.5, 137.5)
	Smoke2:setRGB(0.15, 0.02, 0.95)
	Smoke2:setZRot(180)
	Smoke2:setImage(RegisterImage(@"uie_ui_zm_laboratory_special_offer_smoke"))
	Smoke2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Smoke2:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Smoke2)
	self.Smoke2 = Smoke2
	local Banner = LUI.UIImage.new(0, 0, 133.5, 476.5, 0, 0, 109, 144)
	Banner:setRGB(0, 0, 0)
	Banner:setAlpha(0)
	self:addElement(Banner)
	self.Banner = Banner
	local limit = CoD.LaboratoryListItemInternalPurchaseLimit.new(f1_arg0, f1_arg1, 0, 1, 6, -6, 1, 1, -40, -6)
	limit:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "maxQuantity") then
					f4_local0 = CoD.ZMLaboratoryUtility.CanPurchaseMore(f1_arg1, element)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "VisibleCantPurchase",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "maxQuantity")
			end,
		},
	})
	limit:linkToElementModel(limit, "maxQuantity", true, function(model)
		f1_arg0:updateElementState(limit, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "maxQuantity",
		})
	end)
	limit:setAlpha(0)
	limit:linkToElementModel(self, nil, false, function(model)
		limit:setModel(model, f1_arg1)
	end)
	self:addElement(limit)
	self.limit = limit
	local Icon = CoD.LaboratoryListItemInternalIconAndText.new(f1_arg0, f1_arg1, 0, 0, 19, 119, 0, 0, 24, 124)
	Icon:mergeStateConditions({
		{
			stateName = "ShowTextRight",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "displayName")
			end,
		},
	})
	Icon:linkToElementModel(Icon, "displayName", true, function(model)
		f1_arg0:updateElementState(Icon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "displayName",
		})
	end)
	Icon:setScale(0.9, 1)
	Icon:linkToElementModel(self, nil, false, function(model)
		Icon:setModel(model, f1_arg1)
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local FocusBorder = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	FocusBorder:setRGB(0.89, 0.12, 0.12)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(6, 6)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local TopOrnament = CoD.zm_LaboratoryDescriptionDivider.new(f1_arg0, f1_arg1, 0, 1, -0.5, -0.5, 0, 0, -11, 15)
	TopOrnament.Center:setAlpha(0)
	TopOrnament.R:setScale(0.6, 0.6)
	TopOrnament.L:setScale(0.6, 0.6)
	self:addElement(TopOrnament)
	self.TopOrnament = TopOrnament
	local Timer = LUI.UIText.new(1, 1, -329.5, -14.5, 0, 0, 123.5, 137.5)
	Timer:setRGB(0.58, 0.85, 1)
	Timer:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_67E9AAD95DB4B21E"))
	Timer:setTTF("dinnext_regular")
	Timer:setLetterSpacing(2)
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Timer)
	self.Timer = Timer
	local Quantity = LUI.UIText.new(0, 0, 7.5, 133.5, 0, 0, 107, 143)
	Quantity:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Quantity:setTTF("skorzhen")
	Quantity:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Quantity:setShaderVector(0, 0.79, 0, 0, 0)
	Quantity:setShaderVector(1, 0, 0, 0, 0)
	Quantity:setShaderVector(2, 0, 0, 0, 1)
	Quantity:setLetterSpacing(2)
	Quantity:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Quantity:linkToElementModel(self, "displayName", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Quantity:setText(LocalizeIntoString(@"menu/multiplier_x", f11_local0))
		end
	end)
	self:addElement(Quantity)
	self.Quantity = Quantity
	local Discount = LUI.UIText.new(0, 0, 136, 467, 0, 0, 18, 38)
	Discount:setRGB(0, 0, 0)
	Discount:setText(LocalizeToUpperString(@"hash_3C0C634474914EA"))
	Discount:setTTF("ttmussels_demibold")
	Discount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Discount:setLetterSpacing(1)
	Discount:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Discount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Discount:setBackingType(1)
	Discount:setBackingWidget(CoD.ZM_Promo_Banner, f1_arg0, f1_arg1)
	Discount:setBackingColor(0, 0.87, 1)
	Discount:setBackingXPadding(9)
	Discount:setBackingYPadding(6)
	self:addElement(Discount)
	self.Discount = Discount
	local codpointCost = LUI.UIText.new(0.5, 0.5, -91.5, 218.5, 1, 1, -70.5, -44.5)
	codpointCost:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	codpointCost:setTTF("ttmussels_demibold")
	codpointCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	codpointCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	codpointCost:linkToElementModel(self, "price", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			codpointCost:setText(LocalizeIntoString(@"hash_56A3CC7BE3008989", f12_local0))
		end
	end)
	self:addElement(codpointCost)
	self.codpointCost = codpointCost
	local Name = LUI.UIText.new(0, 0, 152.5, 467.5, 0, 0, 47, 81)
	Name:setRGB(0.63, 0.49, 1)
	Name:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_633CCE15E5387569"))
	Name:setTTF("skorzhen")
	Name:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Name:setShaderVector(0, 1, 0, 0, 0)
	Name:setShaderVector(1, 0, 0, 0, 0)
	Name:setShaderVector(2, 0, 0, 0, 0.86)
	Name:setLetterSpacing(1)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Name)
	self.Name = Name
	local BannerWrap = LUI.UIImage.new(0, 0, 441, 485, 0, 0, 13, 46)
	BannerWrap:setRGB(0, 0.87, 1)
	BannerWrap:setImage(RegisterImage(@"uie_ui_zm_laboratory_promo_banner_wrap"))
	BannerWrap:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	BannerWrap:setShaderVector(0, 0.84, 1, 0, 0)
	BannerWrap:setShaderVector(1, 0, 0, 0, 0)
	BannerWrap:setShaderVector(2, 0, 1, 0, 0)
	BannerWrap:setShaderVector(3, 0, 0, 0, 0)
	BannerWrap:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(BannerWrap)
	self.BannerWrap = BannerWrap
	self:mergeStateConditions({
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f13_local0 = CoD.ZMLaboratoryUtility.CanPurchaseMore(f1_arg1, element)
				if f13_local0 then
					if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.disableInput", 1) then
						f13_local0 = CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING)
					else
						f13_local0 = false
					end
				end
				return f13_local0
			end,
		},
	})
	self:linkToElementModel(self, "maxQuantity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "maxQuantity",
		})
	end)
	local f1_local29 = self
	local f1_local30 = self.subscribeToModel
	local f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["Laboratory.disableInput"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "Laboratory.disableInput",
		})
	end, false)
	f1_local29 = self
	f1_local30 = self.subscribeToModel
	f1_local31 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local30(f1_local29, f1_local31["Laboratory.animState"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "Laboratory.animState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.ZMLaboratoryUtility.SetupEventCountdown(self, self.Timer)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal.__resetProperties = function(f18_arg0)
	f18_arg0.codpointCost:completeAnimation()
	f18_arg0.FocusBrackets:completeAnimation()
	f18_arg0.Glint:completeAnimation()
	f18_arg0.FocusGlow:completeAnimation()
	f18_arg0.Lines:completeAnimation()
	f18_arg0.FocusBorder:completeAnimation()
	f18_arg0.SelectorOverlayRed:completeAnimation()
	f18_arg0.LightFocus:completeAnimation()
	f18_arg0.MetalFrameAdditive:completeAnimation()
	f18_arg0.LaboratoryOfferNameAndDescription:completeAnimation()
	f18_arg0.codpointCost:setAlpha(1)
	f18_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
	f18_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
	f18_arg0.FocusBrackets:setAlpha(0)
	f18_arg0.Glint:setAlpha(0)
	f18_arg0.Glint:setShaderVector(0, 1.24, 0, 0, 0)
	f18_arg0.Glint:setShaderVector(1, -46.8, 0, 0, 0)
	f18_arg0.FocusGlow:setAlpha(0)
	f18_arg0.Lines:setAlpha(0)
	f18_arg0.FocusBorder:setAlpha(0)
	f18_arg0.SelectorOverlayRed:setAlpha(0)
	f18_arg0.LightFocus:setAlpha(0)
	f18_arg0.MetalFrameAdditive:setAlpha(0)
	f18_arg0.LaboratoryOfferNameAndDescription:setAlpha(0)
end
CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.FocusBrackets:completeAnimation()
			f19_arg0.FocusBrackets:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FocusBrackets)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						f22_arg0:beginAnimation(4040)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
					end
					f21_arg0:beginAnimation(510)
					f21_arg0:setAlpha(0)
					f21_arg0:setShaderVector(0, 1.18, 0, 0, 0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f19_arg0.Glint:beginAnimation(450)
				f19_arg0.Glint:setAlpha(0.08)
				f19_arg0.Glint:setShaderVector(0, 0.4, 0, 0, 0)
				f19_arg0.Glint:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Glint:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.Glint:completeAnimation()
			f19_arg0.Glint:setAlpha(0)
			f19_arg0.Glint:setShaderVector(0, -0.28, 0, 0, 0)
			f19_arg0.Glint:setShaderVector(1, -46.8, 0, 0, 0)
			f19_local0(f19_arg0.Glint)
			f19_arg0.codpointCost:completeAnimation()
			f19_arg0.codpointCost:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.codpointCost)
			f19_arg0.nextClip = "DefaultClip"
		end,
		Focus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(6)
			f23_arg0.SelectorOverlayRed:completeAnimation()
			f23_arg0.SelectorOverlayRed:setAlpha(0.02)
			f23_arg0.clipFinished(f23_arg0.SelectorOverlayRed)
			f23_arg0.LightFocus:completeAnimation()
			f23_arg0.LightFocus:setAlpha(0.15)
			f23_arg0.clipFinished(f23_arg0.LightFocus)
			f23_arg0.FocusGlow:completeAnimation()
			f23_arg0.FocusGlow:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.FocusGlow)
			f23_arg0.Lines:completeAnimation()
			f23_arg0.Lines:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Lines)
			f23_arg0.MetalFrameAdditive:completeAnimation()
			f23_arg0.MetalFrameAdditive:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.MetalFrameAdditive)
			f23_arg0.FocusBorder:completeAnimation()
			f23_arg0.FocusBorder:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FocusBorder)
		end,
		GainFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(7)
			local f24_local0 = function(f25_arg0)
				f24_arg0.SelectorOverlayRed:beginAnimation(200)
				f24_arg0.SelectorOverlayRed:setAlpha(0.02)
				f24_arg0.SelectorOverlayRed:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.SelectorOverlayRed:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.SelectorOverlayRed:completeAnimation()
			f24_arg0.SelectorOverlayRed:setAlpha(0)
			f24_local0(f24_arg0.SelectorOverlayRed)
			local f24_local1 = function(f26_arg0)
				f24_arg0.LightFocus:beginAnimation(200)
				f24_arg0.LightFocus:setAlpha(0.15)
				f24_arg0.LightFocus:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.LightFocus:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.LightFocus:completeAnimation()
			f24_arg0.LightFocus:setAlpha(0)
			f24_local1(f24_arg0.LightFocus)
			local f24_local2 = function(f27_arg0)
				f24_arg0.FocusGlow:beginAnimation(200)
				f24_arg0.FocusGlow:setAlpha(1)
				f24_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.FocusGlow:completeAnimation()
			f24_arg0.FocusGlow:setAlpha(0)
			f24_local2(f24_arg0.FocusGlow)
			local f24_local3 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(50)
					f29_arg0:setLeftRight(0, 1, -10, 10)
					f29_arg0:setTopBottom(0, 1, -10, 10)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.FocusBrackets:beginAnimation(100)
				f24_arg0.FocusBrackets:setLeftRight(0, 1, -8, 8)
				f24_arg0.FocusBrackets:setTopBottom(0, 1, -8, 8)
				f24_arg0.FocusBrackets:setAlpha(0.67)
				f24_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f24_arg0.FocusBrackets:completeAnimation()
			f24_arg0.FocusBrackets:setLeftRight(0, 1, -40, 40)
			f24_arg0.FocusBrackets:setTopBottom(0, 1, -40, 40)
			f24_arg0.FocusBrackets:setAlpha(0)
			f24_local3(f24_arg0.FocusBrackets)
			local f24_local4 = function(f30_arg0)
				f24_arg0.MetalFrameAdditive:beginAnimation(200)
				f24_arg0.MetalFrameAdditive:setAlpha(1)
				f24_arg0.MetalFrameAdditive:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.MetalFrameAdditive:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.MetalFrameAdditive:completeAnimation()
			f24_arg0.MetalFrameAdditive:setAlpha(0)
			f24_local4(f24_arg0.MetalFrameAdditive)
			f24_arg0.FocusBorder:completeAnimation()
			f24_arg0.FocusBorder:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.FocusBorder)
			f24_arg0.codpointCost:completeAnimation()
			f24_arg0.codpointCost:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.codpointCost)
		end,
		LoseFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(7)
			local f31_local0 = function(f32_arg0)
				f31_arg0.SelectorOverlayRed:beginAnimation(200)
				f31_arg0.SelectorOverlayRed:setAlpha(0)
				f31_arg0.SelectorOverlayRed:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.SelectorOverlayRed:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.SelectorOverlayRed:completeAnimation()
			f31_arg0.SelectorOverlayRed:setAlpha(0.02)
			f31_local0(f31_arg0.SelectorOverlayRed)
			local f31_local1 = function(f33_arg0)
				f31_arg0.LightFocus:beginAnimation(200)
				f31_arg0.LightFocus:setAlpha(0)
				f31_arg0.LightFocus:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.LightFocus:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.LightFocus:completeAnimation()
			f31_arg0.LightFocus:setAlpha(0.15)
			f31_local1(f31_arg0.LightFocus)
			local f31_local2 = function(f34_arg0)
				f31_arg0.FocusGlow:beginAnimation(200)
				f31_arg0.FocusGlow:setAlpha(0)
				f31_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FocusGlow:completeAnimation()
			f31_arg0.FocusGlow:setAlpha(1)
			f31_local2(f31_arg0.FocusGlow)
			local f31_local3 = function(f35_arg0)
				f31_arg0.FocusBrackets:beginAnimation(60)
				f31_arg0.FocusBrackets:setAlpha(0)
				f31_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FocusBrackets:completeAnimation()
			f31_arg0.FocusBrackets:setAlpha(1)
			f31_local3(f31_arg0.FocusBrackets)
			local f31_local4 = function(f36_arg0)
				f31_arg0.MetalFrameAdditive:beginAnimation(200)
				f31_arg0.MetalFrameAdditive:setAlpha(0)
				f31_arg0.MetalFrameAdditive:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.MetalFrameAdditive:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.MetalFrameAdditive:completeAnimation()
			f31_arg0.MetalFrameAdditive:setAlpha(1)
			f31_local4(f31_arg0.MetalFrameAdditive)
			f31_arg0.FocusBorder:completeAnimation()
			f31_arg0.FocusBorder:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.FocusBorder)
			f31_arg0.codpointCost:completeAnimation()
			f31_arg0.codpointCost:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.codpointCost)
		end,
	},
	Enabled = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			f37_arg0.FocusBrackets:completeAnimation()
			f37_arg0.FocusBrackets:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.FocusBrackets)
			local f37_local0 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						f40_arg0:beginAnimation(3970)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
					end
					f39_arg0:beginAnimation(520)
					f39_arg0:setAlpha(0)
					f39_arg0:setShaderVector(0, 1.24, 0, 0, 0)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f37_arg0.Glint:beginAnimation(450)
				f37_arg0.Glint:setAlpha(0.08)
				f37_arg0.Glint:setShaderVector(0, 0.49, 0, 0, 0)
				f37_arg0.Glint:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Glint:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f37_arg0.Glint:completeAnimation()
			f37_arg0.Glint:setAlpha(0)
			f37_arg0.Glint:setShaderVector(0, -0.17, 0, 0, 0)
			f37_arg0.Glint:setShaderVector(1, -46.8, 0, 0, 0)
			f37_local0(f37_arg0.Glint)
			f37_arg0.codpointCost:completeAnimation()
			f37_arg0.codpointCost:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.codpointCost)
			f37_arg0.nextClip = "DefaultClip"
		end,
		GainFocus = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(8)
			f41_arg0.LaboratoryOfferNameAndDescription:completeAnimation()
			f41_arg0.LaboratoryOfferNameAndDescription:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.LaboratoryOfferNameAndDescription)
			local f41_local0 = function(f42_arg0)
				f41_arg0.SelectorOverlayRed:beginAnimation(200)
				f41_arg0.SelectorOverlayRed:setAlpha(0.02)
				f41_arg0.SelectorOverlayRed:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.SelectorOverlayRed:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.SelectorOverlayRed:completeAnimation()
			f41_arg0.SelectorOverlayRed:setAlpha(0)
			f41_local0(f41_arg0.SelectorOverlayRed)
			local f41_local1 = function(f43_arg0)
				f41_arg0.LightFocus:beginAnimation(200)
				f41_arg0.LightFocus:setAlpha(0.15)
				f41_arg0.LightFocus:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.LightFocus:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.LightFocus:completeAnimation()
			f41_arg0.LightFocus:setAlpha(0)
			f41_local1(f41_arg0.LightFocus)
			local f41_local2 = function(f44_arg0)
				f41_arg0.FocusGlow:beginAnimation(200)
				f41_arg0.FocusGlow:setAlpha(1)
				f41_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.FocusGlow:completeAnimation()
			f41_arg0.FocusGlow:setAlpha(0)
			f41_local2(f41_arg0.FocusGlow)
			local f41_local3 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(50)
					f46_arg0:setLeftRight(0, 1, -10, 10)
					f46_arg0:setTopBottom(0, 1, -10, 10)
					f46_arg0:setAlpha(1)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
				end
				f41_arg0.FocusBrackets:beginAnimation(100)
				f41_arg0.FocusBrackets:setLeftRight(0, 1, -8, 8)
				f41_arg0.FocusBrackets:setTopBottom(0, 1, -8, 8)
				f41_arg0.FocusBrackets:setAlpha(0.67)
				f41_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f41_arg0.FocusBrackets:completeAnimation()
			f41_arg0.FocusBrackets:setLeftRight(0, 1, -40, 40)
			f41_arg0.FocusBrackets:setTopBottom(0, 1, -40, 40)
			f41_arg0.FocusBrackets:setAlpha(0)
			f41_local3(f41_arg0.FocusBrackets)
			local f41_local4 = function(f47_arg0)
				f41_arg0.MetalFrameAdditive:beginAnimation(200)
				f41_arg0.MetalFrameAdditive:setAlpha(1)
				f41_arg0.MetalFrameAdditive:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.MetalFrameAdditive:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.MetalFrameAdditive:completeAnimation()
			f41_arg0.MetalFrameAdditive:setAlpha(0)
			f41_local4(f41_arg0.MetalFrameAdditive)
			f41_arg0.FocusBorder:completeAnimation()
			f41_arg0.FocusBorder:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.FocusBorder)
			f41_arg0.codpointCost:completeAnimation()
			f41_arg0.codpointCost:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.codpointCost)
		end,
		Focus = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(8)
			f48_arg0.LaboratoryOfferNameAndDescription:completeAnimation()
			f48_arg0.LaboratoryOfferNameAndDescription:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.LaboratoryOfferNameAndDescription)
			f48_arg0.SelectorOverlayRed:completeAnimation()
			f48_arg0.SelectorOverlayRed:setAlpha(0.02)
			f48_arg0.clipFinished(f48_arg0.SelectorOverlayRed)
			f48_arg0.LightFocus:completeAnimation()
			f48_arg0.LightFocus:setAlpha(0.15)
			f48_arg0.clipFinished(f48_arg0.LightFocus)
			f48_arg0.FocusGlow:completeAnimation()
			f48_arg0.FocusGlow:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.FocusGlow)
			f48_arg0.Lines:completeAnimation()
			f48_arg0.Lines:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.Lines)
			f48_arg0.MetalFrameAdditive:completeAnimation()
			f48_arg0.MetalFrameAdditive:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.MetalFrameAdditive)
			f48_arg0.FocusBorder:completeAnimation()
			f48_arg0.FocusBorder:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.FocusBorder)
			f48_arg0.codpointCost:completeAnimation()
			f48_arg0.codpointCost:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.codpointCost)
		end,
		LoseFocus = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(7)
			f49_arg0.LaboratoryOfferNameAndDescription:completeAnimation()
			f49_arg0.LaboratoryOfferNameAndDescription:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.LaboratoryOfferNameAndDescription)
			local f49_local0 = function(f50_arg0)
				f49_arg0.SelectorOverlayRed:beginAnimation(200)
				f49_arg0.SelectorOverlayRed:setAlpha(0)
				f49_arg0.SelectorOverlayRed:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.SelectorOverlayRed:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.SelectorOverlayRed:completeAnimation()
			f49_arg0.SelectorOverlayRed:setAlpha(0.02)
			f49_local0(f49_arg0.SelectorOverlayRed)
			local f49_local1 = function(f51_arg0)
				f49_arg0.LightFocus:beginAnimation(200)
				f49_arg0.LightFocus:setAlpha(0)
				f49_arg0.LightFocus:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.LightFocus:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.LightFocus:completeAnimation()
			f49_arg0.LightFocus:setAlpha(0.15)
			f49_local1(f49_arg0.LightFocus)
			local f49_local2 = function(f52_arg0)
				f49_arg0.FocusGlow:beginAnimation(200)
				f49_arg0.FocusGlow:setAlpha(0)
				f49_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.FocusGlow:completeAnimation()
			f49_arg0.FocusGlow:setAlpha(1)
			f49_local2(f49_arg0.FocusGlow)
			local f49_local3 = function(f53_arg0)
				f49_arg0.FocusBrackets:beginAnimation(60)
				f49_arg0.FocusBrackets:setAlpha(0)
				f49_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.FocusBrackets:completeAnimation()
			f49_arg0.FocusBrackets:setAlpha(1)
			f49_local3(f49_arg0.FocusBrackets)
			local f49_local4 = function(f54_arg0)
				f49_arg0.MetalFrameAdditive:beginAnimation(200)
				f49_arg0.MetalFrameAdditive:setAlpha(0)
				f49_arg0.MetalFrameAdditive:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.MetalFrameAdditive:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.MetalFrameAdditive:completeAnimation()
			f49_arg0.MetalFrameAdditive:setAlpha(1)
			f49_local4(f49_arg0.MetalFrameAdditive)
			f49_arg0.codpointCost:completeAnimation()
			f49_arg0.codpointCost:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.codpointCost)
		end,
	},
}
CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal.__onClose = function(f55_arg0)
	f55_arg0.LaboratoryOfferNameAndDescription:close()
	f55_arg0.Lines:close()
	f55_arg0.FocusBrackets:close()
	f55_arg0.limit:close()
	f55_arg0.Icon:close()
	f55_arg0.TopOrnament:close()
	f55_arg0.Timer:close()
	f55_arg0.Quantity:close()
	f55_arg0.codpointCost:close()
end

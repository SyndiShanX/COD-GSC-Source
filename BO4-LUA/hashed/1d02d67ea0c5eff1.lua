require("x64:3e426332d66c91e")
require("x64:f78acfcbc465bba")
require("x64:fb1ca312b5b024e")
require("x64:be4ff35ca001915")
require("x64:f9f0e41049e1efe")
CoD.LaboratoryListItemInternal = InheritFrom(LUI.UIElement)
CoD.LaboratoryListItemInternal.__defaultWidth = 150
CoD.LaboratoryListItemInternal.__defaultHeight = 150
CoD.LaboratoryListItemInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryListItemInternal)
	self.id = "LaboratoryListItemInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
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
	local SelectorOverlayGray = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlayGray:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlayGray:setAlpha(0.01)
	self:addElement(SelectorOverlayGray)
	self.SelectorOverlayGray = SelectorOverlayGray
	local LightFocus = LUI.UIImage.new(-0.05, 1.05, 0.5, 0.5, 0.5, 0.5, -74.5, 84.5)
	LightFocus:setAlpha(0)
	LightFocus:setImage(RegisterImage(@"uie_ui_menu_zombies_cac_special_weapon_light_focus"))
	self:addElement(LightFocus)
	self.LightFocus = LightFocus
	local FocusGlow = LUI.UIImage.new(0.2, 0.8, -100, 100, 0.2, 0.8, -74, 74)
	FocusGlow:setRGB(0.89, 0.12, 0.12)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_large"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(300, 300)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.15)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	Lines:setAlpha(0)
	self:addElement(Lines)
	self.Lines = Lines
	local MetalFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	MetalFrame:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonframe"))
	MetalFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	MetalFrame:setShaderVector(0, 0, 0, 0, 0)
	MetalFrame:setupNineSliceShader(14, 14)
	self:addElement(MetalFrame)
	self.MetalFrame = MetalFrame
	local MetalFrameAdditive = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	MetalFrameAdditive:setRGB(1, 0, 0)
	MetalFrameAdditive:setAlpha(0)
	MetalFrameAdditive:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonframe"))
	MetalFrameAdditive:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	MetalFrameAdditive:setShaderVector(0, 0, 0, 0, 0)
	MetalFrameAdditive:setupNineSliceShader(14, 14)
	self:addElement(MetalFrameAdditive)
	self.MetalFrameAdditive = MetalFrameAdditive
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -10, 10)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local limit = CoD.LaboratoryListItemInternalPurchaseLimit.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 0, 111, 145)
	limit:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "maxQuantity") then
					f2_local0 = CoD.ZMLaboratoryUtility.CanPurchaseMore(f1_arg1, element)
				else
					f2_local0 = false
				end
				return f2_local0
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
	limit:linkToElementModel(self, nil, false, function(model)
		limit:setModel(model, f1_arg1)
	end)
	self:addElement(limit)
	self.limit = limit
	local npIcon = LUI.UIImage.new(0.5, 0.5, -32, -2, 1, 1, -37, -7)
	npIcon:setImage(RegisterImage(@"uie_t7_hud_zm_vial_256"))
	self:addElement(npIcon)
	self.npIcon = npIcon
	local codpointCost = LUI.UIText.new(-0, 1, 2, -2, 1, 1, -34, -4)
	codpointCost:setAlpha(0)
	codpointCost:setTTF("ttmussels_demibold")
	codpointCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	codpointCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	codpointCost:linkToElementModel(self, "price", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			codpointCost:setText(LocalizeIntoString(@"hash_56A3CC7BE3008989", f6_local0))
		end
	end)
	self:addElement(codpointCost)
	self.codpointCost = codpointCost
	local cost = LUI.UIText.new(0.5, 0.5, 0, 179, 1, 1, -32, -4)
	cost:setTTF("skorzhen")
	cost:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	cost:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	cost:linkToElementModel(self, "plasmaPrice", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			cost:setText(f7_local0)
		end
	end)
	self:addElement(cost)
	self.cost = cost
	local icon = CoD.LaboratoryListItemInternalIconAndText.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 50, 0, 0, 3, 103)
	icon:mergeStateConditions({
		{
			stateName = "ShowTextRight",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "displayName")
			end,
		},
	})
	icon:linkToElementModel(icon, "displayName", true, function(model)
		f1_arg0:updateElementState(icon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "displayName",
		})
	end)
	icon:setScale(0.8, 0.8)
	icon:linkToElementModel(self, nil, false, function(model)
		icon:setModel(model, f1_arg1)
	end)
	self:addElement(icon)
	self.icon = icon
	local FocusBorder = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	FocusBorder:setRGB(0.89, 0.12, 0.12)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(6, 6)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local TopOrnament = CoD.zm_LaboratoryDescriptionDivider.new(f1_arg0, f1_arg1, 0, 1, -0.5, -0.5, 0, 0, -12, 14)
	TopOrnament.R:setScale(0.6, 0.6)
	TopOrnament.L:setScale(0.6, 0.6)
	self:addElement(TopOrnament)
	self.TopOrnament = TopOrnament
	self:mergeStateConditions({
		{
			stateName = "DisabledCodPoints",
			condition = function(menu, element, event)
				local f11_local0
				if not CoD.ZMLaboratoryUtility.CanPurchaseMore(f1_arg1, element) and not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "price") then
					f11_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.disableInput", 1)
					if f11_local0 then
						f11_local0 = not CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING)
					end
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
		{
			stateName = "RequiresCoDPoints",
			condition = function(menu, element, event)
				local f12_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "price") and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.disableInput", 1) then
					f12_local0 = CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING)
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.disableInput", 1)
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
	self:linkToElementModel(self, "price", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "price",
		})
	end)
	local f1_local20 = self
	local f1_local21 = self.subscribeToModel
	local f1_local22 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local21(f1_local20, f1_local22["Laboratory.disableInput"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "Laboratory.disableInput",
		})
	end, false)
	f1_local20 = self
	f1_local21 = self.subscribeToModel
	f1_local22 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local21(f1_local20, f1_local22["Laboratory.animState"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "Laboratory.animState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryListItemInternal.__resetProperties = function(f18_arg0)
	f18_arg0.cost:completeAnimation()
	f18_arg0.npIcon:completeAnimation()
	f18_arg0.codpointCost:completeAnimation()
	f18_arg0.FocusBrackets:completeAnimation()
	f18_arg0.FocusGlow:completeAnimation()
	f18_arg0.FocusBorder:completeAnimation()
	f18_arg0.Lines:completeAnimation()
	f18_arg0.MetalFrameAdditive:completeAnimation()
	f18_arg0.SelectorOverlayRed:completeAnimation()
	f18_arg0.LightFocus:completeAnimation()
	f18_arg0.cost:setAlpha(1)
	f18_arg0.npIcon:setAlpha(1)
	f18_arg0.codpointCost:setAlpha(0)
	f18_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
	f18_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
	f18_arg0.FocusBrackets:setAlpha(1)
	f18_arg0.FocusGlow:setAlpha(0)
	f18_arg0.FocusBorder:setAlpha(0)
	f18_arg0.Lines:setAlpha(0)
	f18_arg0.MetalFrameAdditive:setAlpha(0)
	f18_arg0.SelectorOverlayRed:setAlpha(0)
	f18_arg0.LightFocus:setAlpha(0)
end
CoD.LaboratoryListItemInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	DisabledCodPoints = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.npIcon:completeAnimation()
			f20_arg0.npIcon:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.npIcon)
			f20_arg0.codpointCost:completeAnimation()
			f20_arg0.codpointCost:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.codpointCost)
			f20_arg0.cost:completeAnimation()
			f20_arg0.cost:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.cost)
		end,
	},
	RequiresCoDPoints = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			f21_arg0.FocusBrackets:completeAnimation()
			f21_arg0.FocusBrackets:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.FocusBrackets)
			f21_arg0.npIcon:completeAnimation()
			f21_arg0.npIcon:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.npIcon)
			f21_arg0.codpointCost:completeAnimation()
			f21_arg0.codpointCost:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.codpointCost)
			f21_arg0.cost:completeAnimation()
			f21_arg0.cost:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.cost)
		end,
		Focus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(9)
			f22_arg0.SelectorOverlayRed:completeAnimation()
			f22_arg0.SelectorOverlayRed:setAlpha(0.02)
			f22_arg0.clipFinished(f22_arg0.SelectorOverlayRed)
			f22_arg0.LightFocus:completeAnimation()
			f22_arg0.LightFocus:setAlpha(0.15)
			f22_arg0.clipFinished(f22_arg0.LightFocus)
			f22_arg0.FocusGlow:completeAnimation()
			f22_arg0.FocusGlow:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.FocusGlow)
			f22_arg0.Lines:completeAnimation()
			f22_arg0.Lines:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Lines)
			f22_arg0.MetalFrameAdditive:completeAnimation()
			f22_arg0.MetalFrameAdditive:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.MetalFrameAdditive)
			f22_arg0.npIcon:completeAnimation()
			f22_arg0.npIcon:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.npIcon)
			f22_arg0.codpointCost:completeAnimation()
			f22_arg0.codpointCost:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.codpointCost)
			f22_arg0.cost:completeAnimation()
			f22_arg0.cost:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.cost)
			f22_arg0.FocusBorder:completeAnimation()
			f22_arg0.FocusBorder:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.FocusBorder)
		end,
	},
	Enabled = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.FocusBrackets:completeAnimation()
			f23_arg0.FocusBrackets:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FocusBrackets)
		end,
		Focus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(6)
			f24_arg0.SelectorOverlayRed:completeAnimation()
			f24_arg0.SelectorOverlayRed:setAlpha(0.02)
			f24_arg0.clipFinished(f24_arg0.SelectorOverlayRed)
			f24_arg0.LightFocus:completeAnimation()
			f24_arg0.LightFocus:setAlpha(0.15)
			f24_arg0.clipFinished(f24_arg0.LightFocus)
			f24_arg0.FocusGlow:completeAnimation()
			f24_arg0.FocusGlow:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.FocusGlow)
			f24_arg0.Lines:completeAnimation()
			f24_arg0.Lines:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Lines)
			f24_arg0.MetalFrameAdditive:completeAnimation()
			f24_arg0.MetalFrameAdditive:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.MetalFrameAdditive)
			f24_arg0.FocusBorder:completeAnimation()
			f24_arg0.FocusBorder:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.FocusBorder)
		end,
		GainFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(5)
			local f25_local0 = function(f26_arg0)
				f25_arg0.SelectorOverlayRed:beginAnimation(200)
				f25_arg0.SelectorOverlayRed:setAlpha(0.02)
				f25_arg0.SelectorOverlayRed:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.SelectorOverlayRed:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.SelectorOverlayRed:completeAnimation()
			f25_arg0.SelectorOverlayRed:setAlpha(0)
			f25_local0(f25_arg0.SelectorOverlayRed)
			local f25_local1 = function(f27_arg0)
				f25_arg0.LightFocus:beginAnimation(200)
				f25_arg0.LightFocus:setAlpha(0.15)
				f25_arg0.LightFocus:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.LightFocus:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.LightFocus:completeAnimation()
			f25_arg0.LightFocus:setAlpha(0)
			f25_local1(f25_arg0.LightFocus)
			local f25_local2 = function(f28_arg0)
				f25_arg0.FocusGlow:beginAnimation(200)
				f25_arg0.FocusGlow:setAlpha(1)
				f25_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusGlow:completeAnimation()
			f25_arg0.FocusGlow:setAlpha(0)
			f25_local2(f25_arg0.FocusGlow)
			local f25_local3 = function(f29_arg0)
				f25_arg0.MetalFrameAdditive:beginAnimation(200)
				f25_arg0.MetalFrameAdditive:setAlpha(1)
				f25_arg0.MetalFrameAdditive:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.MetalFrameAdditive:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.MetalFrameAdditive:completeAnimation()
			f25_arg0.MetalFrameAdditive:setAlpha(0)
			f25_local3(f25_arg0.MetalFrameAdditive)
			local f25_local4 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(70)
					f31_arg0:setLeftRight(0, 1, -10, 10)
					f31_arg0:setTopBottom(0, 1, -10, 10)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.FocusBrackets:beginAnimation(80)
				f25_arg0.FocusBrackets:setLeftRight(0, 1, -8, 8)
				f25_arg0.FocusBrackets:setTopBottom(0, 1, -8, 8)
				f25_arg0.FocusBrackets:setAlpha(0.53)
				f25_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f25_arg0.FocusBrackets:completeAnimation()
			f25_arg0.FocusBrackets:setLeftRight(0, 1, -40, 40)
			f25_arg0.FocusBrackets:setTopBottom(0, 1, -40, 40)
			f25_arg0.FocusBrackets:setAlpha(0)
			f25_local4(f25_arg0.FocusBrackets)
		end,
		LoseFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			local f32_local0 = function(f33_arg0)
				f32_arg0.SelectorOverlayRed:beginAnimation(200)
				f32_arg0.SelectorOverlayRed:setAlpha(0)
				f32_arg0.SelectorOverlayRed:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.SelectorOverlayRed:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.SelectorOverlayRed:completeAnimation()
			f32_arg0.SelectorOverlayRed:setAlpha(0.02)
			f32_local0(f32_arg0.SelectorOverlayRed)
			local f32_local1 = function(f34_arg0)
				f32_arg0.LightFocus:beginAnimation(200)
				f32_arg0.LightFocus:setAlpha(0)
				f32_arg0.LightFocus:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.LightFocus:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.LightFocus:completeAnimation()
			f32_arg0.LightFocus:setAlpha(0.15)
			f32_local1(f32_arg0.LightFocus)
			local f32_local2 = function(f35_arg0)
				f32_arg0.FocusGlow:beginAnimation(200)
				f32_arg0.FocusGlow:setAlpha(0)
				f32_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.FocusGlow:completeAnimation()
			f32_arg0.FocusGlow:setAlpha(1)
			f32_local2(f32_arg0.FocusGlow)
			local f32_local3 = function(f36_arg0)
				f32_arg0.MetalFrameAdditive:beginAnimation(200)
				f32_arg0.MetalFrameAdditive:setAlpha(0)
				f32_arg0.MetalFrameAdditive:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.MetalFrameAdditive:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.MetalFrameAdditive:completeAnimation()
			f32_arg0.MetalFrameAdditive:setAlpha(1)
			f32_local3(f32_arg0.MetalFrameAdditive)
			local f32_local4 = function(f37_arg0)
				f32_arg0.FocusBrackets:beginAnimation(60)
				f32_arg0.FocusBrackets:setAlpha(0)
				f32_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.FocusBrackets:completeAnimation()
			f32_arg0.FocusBrackets:setAlpha(1)
			f32_local4(f32_arg0.FocusBrackets)
		end,
	},
}
CoD.LaboratoryListItemInternal.__onClose = function(f38_arg0)
	f38_arg0.Lines:close()
	f38_arg0.FocusBrackets:close()
	f38_arg0.limit:close()
	f38_arg0.codpointCost:close()
	f38_arg0.cost:close()
	f38_arg0.icon:close()
	f38_arg0.TopOrnament:close()
end

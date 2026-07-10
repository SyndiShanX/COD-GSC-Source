require("x64:6151942c381b5a6")
require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.CharacterSelection_CustomCharacterButton_Internal = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_CustomCharacterButton_Internal.__defaultWidth = 300
CoD.CharacterSelection_CustomCharacterButton_Internal.__defaultHeight = 480
CoD.CharacterSelection_CustomCharacterButton_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_CustomCharacterButton_Internal)
	self.id = "CharacterSelection_CustomCharacterButton_Internal"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 300, 0, 0, 0, 480)
	Background:setRGB(0.24, 0.26, 0.28)
	Background:setAlpha(0.5)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Background:setShaderVector(0, 0, 0.9, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local TitleBackgroundLED = LUI.UIImage.new(0, 0, 0, 300, 0, 0, 0, 480)
	TitleBackgroundLED:setRGB(0.9, 0.98, 1)
	TitleBackgroundLED:setAlpha(0.1)
	TitleBackgroundLED:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TitleBackgroundLED:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TitleBackgroundLED:setShaderVector(0, 0, 0, 0, 0)
	TitleBackgroundLED:setupNineSliceShader(24, 24)
	self:addElement(TitleBackgroundLED)
	self.TitleBackgroundLED = TitleBackgroundLED
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local FocusGlow = LUI.UIImage.new(0, 1, -142, 142, 0, 1, -110, 110)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(@"uie_ui_menu_common_focus_glow_large"))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_6DAB59B2CAE01851"))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(300, 300)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local SelectOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectOverlay:setAlpha(0.01)
	self:addElement(SelectOverlay)
	self.SelectOverlay = SelectOverlay
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 2, -2, 1, 1, -36, 0)
	DotTiledBacking:setAlpha(0.5)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local NameplateBars = LUI.UIImage.new(0.5, 0.5, -200, 192, 1, 1, -41, 4)
	NameplateBars:setRGB(0.13, 0.14, 0.18)
	NameplateBars:setAlpha(0)
	NameplateBars:setScale(0.98, 0.98)
	NameplateBars:setImage(RegisterImage(@"hash_729BE1DE77EE233C"))
	self:addElement(NameplateBars)
	self.NameplateBars = NameplateBars
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local Name = LUI.UIText.new(0.5, 0.5, -146, 146, 1, 1, -26, -6)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setScale(0.85, 0.85)
	Name:setTTF("notosans_regular")
	Name:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Name:setShaderVector(0, 0.4, 0, 0, 0)
	Name:setShaderVector(1, 0, 0, 0, 0)
	Name:setShaderVector(2, 1, 0.3, 0, 0.6)
	Name:setLetterSpacing(3)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local FullBodyPortrait = LUI.UIImage.new(0.5, 0.5, -150, 150, 0.5, 0.5, -203.5, 176.5)
	FullBodyPortrait:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FullBodyPortrait:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(FullBodyPortrait)
	self.FullBodyPortrait = FullBodyPortrait
	local ItemHintText = CoD.ItemHintTextBreadcrumb.new(f1_arg0, f1_arg1, 0.5, 0.5, -141, 205, 1, 1, 12, 46)
	ItemHintText:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemHintText:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ItemHintText, f5_arg1)
	end)
	local EquippedMarkerTickAdd = ItemHintText
	local EquippedMarkerTick = ItemHintText.subscribeToModel
	local f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	EquippedMarkerTick(EquippedMarkerTickAdd, f1_local14.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(ItemHintText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ItemHintText:linkToElementModel(self, "breadcrumb", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ItemHintText:setModel(f7_local0, f1_arg1)
		end
	end)
	ItemHintText.textCenterAlign.__Center_Text = function(f8_arg0)
		local f8_local0 = f8_arg0:get()
		if f8_local0 ~= nil then
			ItemHintText.textCenterAlign:setText(CoD.BreadcrumbUtility.UpdatePersonalizeStringIfNew(self:getModel(), f8_local0))
		end
	end
	ItemHintText:linkToElementModel(self, "breadcrumb", true, function(model, f9_arg1)
		if f9_arg1["__ItemHintText.textCenterAlign.__Center_Text_breadcrumb->breadcrumbCount"] then
			f9_arg1:removeSubscription(f9_arg1["__ItemHintText.textCenterAlign.__Center_Text_breadcrumb->breadcrumbCount"])
			f9_arg1["__ItemHintText.textCenterAlign.__Center_Text_breadcrumb->breadcrumbCount"] = nil
		end
		if model then
			local f9_local0 = model:get()
			local f9_local1 = model:get()
			model = f9_local0 and f9_local1.breadcrumbCount
		end
		if model then
			f9_arg1["__ItemHintText.textCenterAlign.__Center_Text_breadcrumb->breadcrumbCount"] = f9_arg1:subscribeToModel(model, ItemHintText.textCenterAlign.__Center_Text)
		end
	end)
	ItemHintText.textCenterAlign.__Center_Text_FullPath = function()
		local f10_local0 = self:getModel()
		if f10_local0 then
			f10_local0 = self:getModel()
			f10_local0 = f10_local0.breadcrumb
		end
		if f10_local0 then
			f10_local0 = f10_local0:get()
		end
		if f10_local0 then
			f10_local0 = f10_local0.breadcrumbCount
		end
		if f10_local0 then
			ItemHintText.textCenterAlign.__Center_Text(f10_local0)
		end
	end
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	EquippedMarkerTick = LUI.UIImage.new(0, 0, 260.5, 304.5, 0, 0, -3, 41)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	EquippedMarkerTickAdd = LUI.UIImage.new(0, 0, 260.5, 304.5, 0, 0, -3, 41)
	EquippedMarkerTickAdd:setAlpha(0)
	EquippedMarkerTickAdd:setZoom(4)
	EquippedMarkerTickAdd:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	EquippedMarkerTickAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(EquippedMarkerTickAdd)
	self.EquippedMarkerTickAdd = EquippedMarkerTickAdd
	ItemHintText:linkToElementModel(self, "breadcrumbCount", true, ItemHintText.textCenterAlign.__Center_Text_FullPath)
	self:mergeStateConditions({
		{
			stateName = "SelectedNoPersonalization",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsCurrentCharacterDefault(f1_arg1)
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsCurrentCharacterDefault(f1_arg1)
			end,
		},
		{
			stateName = "NoPersonalization",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_CustomCharacterButton_Internal.__resetProperties = function(f14_arg0)
	f14_arg0.EquippedMarkerTickAdd:completeAnimation()
	f14_arg0.EquippedMarkerTick:completeAnimation()
	f14_arg0.ItemHintText:completeAnimation()
	f14_arg0.FocusGlow:completeAnimation()
	f14_arg0.EquippedMarkerTickAdd:setAlpha(0)
	f14_arg0.EquippedMarkerTick:setAlpha(1)
	f14_arg0.ItemHintText:setAlpha(1)
	f14_arg0.FocusGlow:setAlpha(0)
end
CoD.CharacterSelection_CustomCharacterButton_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.ItemHintText:completeAnimation()
			f15_arg0.ItemHintText:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ItemHintText)
			f15_arg0.EquippedMarkerTick:completeAnimation()
			f15_arg0.EquippedMarkerTick:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.EquippedMarkerTick)
			f15_arg0.EquippedMarkerTickAdd:completeAnimation()
			f15_arg0.EquippedMarkerTickAdd:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.EquippedMarkerTickAdd)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.FocusGlow:completeAnimation()
			f16_arg0.FocusGlow:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.FocusGlow)
			f16_arg0.ItemHintText:completeAnimation()
			f16_arg0.ItemHintText:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.ItemHintText)
			f16_arg0.EquippedMarkerTick:completeAnimation()
			f16_arg0.EquippedMarkerTick:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.EquippedMarkerTick)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			local f17_local0 = function(f18_arg0)
				f17_arg0.FocusGlow:beginAnimation(200)
				f17_arg0.FocusGlow:setAlpha(1)
				f17_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FocusGlow:completeAnimation()
			f17_arg0.FocusGlow:setAlpha(0)
			f17_local0(f17_arg0.FocusGlow)
			local f17_local1 = function(f19_arg0)
				f17_arg0.ItemHintText:beginAnimation(200)
				f17_arg0.ItemHintText:setAlpha(1)
				f17_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ItemHintText:completeAnimation()
			f17_arg0.ItemHintText:setAlpha(0)
			f17_local1(f17_arg0.ItemHintText)
			f17_arg0.EquippedMarkerTick:completeAnimation()
			f17_arg0.EquippedMarkerTick:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.EquippedMarkerTick)
			f17_arg0.EquippedMarkerTickAdd:completeAnimation()
			f17_arg0.EquippedMarkerTickAdd:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.EquippedMarkerTickAdd)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			local f20_local0 = function(f21_arg0)
				f20_arg0.FocusGlow:beginAnimation(200)
				f20_arg0.FocusGlow:setAlpha(0)
				f20_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.FocusGlow:completeAnimation()
			f20_arg0.FocusGlow:setAlpha(1)
			f20_local0(f20_arg0.FocusGlow)
			local f20_local1 = function(f22_arg0)
				f20_arg0.ItemHintText:beginAnimation(200)
				f20_arg0.ItemHintText:setAlpha(0)
				f20_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ItemHintText:completeAnimation()
			f20_arg0.ItemHintText:setAlpha(1)
			f20_local1(f20_arg0.ItemHintText)
			f20_arg0.EquippedMarkerTick:completeAnimation()
			f20_arg0.EquippedMarkerTick:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.EquippedMarkerTick)
			f20_arg0.EquippedMarkerTickAdd:completeAnimation()
			f20_arg0.EquippedMarkerTickAdd:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.EquippedMarkerTickAdd)
		end,
	},
	SelectedNoPersonalization = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.ItemHintText:completeAnimation()
			f23_arg0.ItemHintText:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ItemHintText)
		end,
		ChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.ItemHintText:completeAnimation()
			f24_arg0.ItemHintText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ItemHintText)
		end,
		GainChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.ItemHintText:completeAnimation()
			f25_arg0.ItemHintText:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.ItemHintText)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.ItemHintText:completeAnimation()
			f26_arg0.ItemHintText:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ItemHintText)
		end,
	},
	Selected = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.ItemHintText:completeAnimation()
			f27_arg0.ItemHintText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ItemHintText)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.ItemHintText:completeAnimation()
			f28_arg0.ItemHintText:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.ItemHintText)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.ItemHintText:beginAnimation(200)
				f29_arg0.ItemHintText:setAlpha(1)
				f29_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.ItemHintText:completeAnimation()
			f29_arg0.ItemHintText:setAlpha(0)
			f29_local0(f29_arg0.ItemHintText)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ItemHintText:beginAnimation(200)
				f31_arg0.ItemHintText:setAlpha(0)
				f31_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ItemHintText:completeAnimation()
			f31_arg0.ItemHintText:setAlpha(1)
			f31_local0(f31_arg0.ItemHintText)
		end,
	},
	NoPersonalization = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			f33_arg0.ItemHintText:completeAnimation()
			f33_arg0.ItemHintText:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ItemHintText)
			f33_arg0.EquippedMarkerTick:completeAnimation()
			f33_arg0.EquippedMarkerTick:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.EquippedMarkerTick)
			f33_arg0.EquippedMarkerTickAdd:completeAnimation()
			f33_arg0.EquippedMarkerTickAdd:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.EquippedMarkerTickAdd)
		end,
		ChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			f34_arg0.FocusGlow:completeAnimation()
			f34_arg0.FocusGlow:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.FocusGlow)
			f34_arg0.ItemHintText:completeAnimation()
			f34_arg0.ItemHintText:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ItemHintText)
			f34_arg0.EquippedMarkerTick:completeAnimation()
			f34_arg0.EquippedMarkerTick:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.EquippedMarkerTick)
		end,
		GainChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(4)
			local f35_local0 = function(f36_arg0)
				f35_arg0.FocusGlow:beginAnimation(200)
				f35_arg0.FocusGlow:setAlpha(1)
				f35_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.FocusGlow:completeAnimation()
			f35_arg0.FocusGlow:setAlpha(0)
			f35_local0(f35_arg0.FocusGlow)
			f35_arg0.ItemHintText:completeAnimation()
			f35_arg0.ItemHintText:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ItemHintText)
			f35_arg0.EquippedMarkerTick:completeAnimation()
			f35_arg0.EquippedMarkerTick:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.EquippedMarkerTick)
			f35_arg0.EquippedMarkerTickAdd:completeAnimation()
			f35_arg0.EquippedMarkerTickAdd:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.EquippedMarkerTickAdd)
		end,
		LoseChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			local f37_local0 = function(f38_arg0)
				f37_arg0.FocusGlow:beginAnimation(200)
				f37_arg0.FocusGlow:setAlpha(0)
				f37_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.FocusGlow:completeAnimation()
			f37_arg0.FocusGlow:setAlpha(1)
			f37_local0(f37_arg0.FocusGlow)
			f37_arg0.ItemHintText:completeAnimation()
			f37_arg0.ItemHintText:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ItemHintText)
			f37_arg0.EquippedMarkerTick:completeAnimation()
			f37_arg0.EquippedMarkerTick:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.EquippedMarkerTick)
			f37_arg0.EquippedMarkerTickAdd:completeAnimation()
			f37_arg0.EquippedMarkerTickAdd:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.EquippedMarkerTickAdd)
		end,
	},
}
CoD.CharacterSelection_CustomCharacterButton_Internal.__onClose = function(f39_arg0)
	f39_arg0.DotTiledBacking:close()
	f39_arg0.CommonButtonOutline:close()
	f39_arg0.Name:close()
	f39_arg0.FullBodyPortrait:close()
	f39_arg0.ItemHintText:close()
end

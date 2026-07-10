require("x64:dbb04b55fa27ac6")
require("x64:3e426332d66c91e")
require("x64:f78acfcbc465bba")
require("x64:fd51e83e2e6dbd1")
require("x64:19c1945d2e472b0")
CoD.SpecialistOutfitCategory_Internal = InheritFrom(LUI.UIElement)
CoD.SpecialistOutfitCategory_Internal.__defaultWidth = 280
CoD.SpecialistOutfitCategory_Internal.__defaultHeight = 69
CoD.SpecialistOutfitCategory_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistOutfitCategory_Internal)
	self.id = "SpecialistOutfitCategory_Internal"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusGlow = LUI.UIImage.new(0, 1, -49, 49, 0, 1, -33, 33)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0xB8F10D49D85E9C4))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow:setShaderVector(0, 0, 0, 0.25, 0.25)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(100, 100)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setAlpha(0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local BlackBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBacking:setRGB(0, 0, 0)
	BlackBacking:setAlpha(0.9)
	self:addElement(BlackBacking)
	self.BlackBacking = BlackBacking
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local TiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBackingAdd:setAlpha(0)
	TiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingAdd)
	self.TiledBackingAdd = TiledBackingAdd
	local SelectionOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectionOverlay:setAlpha(0.01)
	self:addElement(SelectionOverlay)
	self.SelectionOverlay = SelectionOverlay
	local LEDPattern = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 7, -7, 0, 1, 7, -5)
	LEDPattern:setAlpha(0.4)
	LEDPattern.TiledShaderImage:setupNineSliceShader(42, 42)
	self:addElement(LEDPattern)
	self.LEDPattern = LEDPattern
	local LEDPatternAdd = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 7, -7, 0, 1, 7, -5)
	LEDPatternAdd:setAlpha(0)
	LEDPatternAdd.NoiseBacking:setAlpha(1)
	LEDPatternAdd.TiledShaderImage:setupNineSliceShader(42, 42)
	self:addElement(LEDPatternAdd)
	self.LEDPatternAdd = LEDPatternAdd
	local Header = LUI.UIText.new(0, 0, 17, 267, 0.5, 0.5, -11, 11)
	Header:setRGB(0.92, 0.92, 0.92)
	Header:setAlpha(0.75)
	Header:setTTF("dinnext_regular")
	Header:setLetterSpacing(2)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Header:linkToElementModel(self, "displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Header:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Header)
	self.Header = Header
	local BracketL = LUI.UIImage.new(1, 1, -82, -74, 0, 0, 23, 47)
	BracketL:setAlpha(0)
	BracketL:setImage(RegisterImage(0x6AA0A70F33D3978))
	BracketL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BracketL)
	self.BracketL = BracketL
	local LockedIcon = LUI.UIImage.new(1, 1, -113, 15, 0, 0, -32, 96)
	LockedIcon:setAlpha(0)
	LockedIcon:setScale(0.25, 0.25)
	LockedIcon:setImage(RegisterImage(0xE1E7C490B2BA4FB))
	LockedIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	LockedIcon:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local BracketR = LUI.UIImage.new(1, 1, -24, -16, 0, 0, 22, 46)
	BracketR:setAlpha(0)
	BracketR:setZRot(180)
	BracketR:setImage(RegisterImage(0x6AA0A70F33D3978))
	BracketR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BracketR)
	self.BracketR = BracketR
	local EquippedMarkerTick = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -35.5, 8.5, 0, 0, -9, 35)
	EquippedMarkerTick:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.IsSelectedOutfitIndex(element, f1_arg1)
			end,
		},
	})
	local Lines = EquippedMarkerTick
	local FrontendFrameThin = EquippedMarkerTick.subscribeToModel
	local LinesAdd = DataSources.MPSpecialistThemes.getModel(f1_arg1)
	FrontendFrameThin(Lines, LinesAdd.update, function(f4_arg0)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "update",
		})
	end, false)
	EquippedMarkerTick:linkToElementModel(EquippedMarkerTick, "outfitIndex", true, function(model)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outfitIndex",
		})
	end)
	Lines = EquippedMarkerTick
	FrontendFrameThin = EquippedMarkerTick.subscribeToModel
	LinesAdd = DataSources.MPOutfitCategories.getModel(f1_arg1)
	FrontendFrameThin(Lines, LinesAdd.selectedCategory, function(f6_arg0)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "selectedCategory",
		})
	end, false)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick.image:setImage(RegisterImage(0x9A8B26C9B001758))
	EquippedMarkerTick:linkToElementModel(self, nil, false, function(model)
		EquippedMarkerTick:setModel(model, f1_arg1)
	end)
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	FrontendFrameThin = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -1, 1)
	FrontendFrameThin:setAlpha(0.5)
	FrontendFrameThin:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrameThin:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameThin:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameThin:setupNineSliceShader(6, 6)
	self:addElement(FrontendFrameThin)
	self.FrontendFrameThin = FrontendFrameThin
	Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Lines:setRGB(0.64, 0.71, 0.78)
	self:addElement(Lines)
	self.Lines = Lines
	LinesAdd = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	LinesAdd:setRGB(0.64, 0.71, 0.78)
	LinesAdd:setAlpha(0)
	self:addElement(LinesAdd)
	self.LinesAdd = LinesAdd
	local FocusBorder = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(12, 12)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -28, 28, 0, 1, -28, 28)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	local breadcrumbCount = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 1, 1, -31, -4, 0, 0, 1, 28)
	breadcrumbCount:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	breadcrumbCount:linkToElementModel(breadcrumbCount, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(breadcrumbCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	breadcrumbCount:linkToElementModel(self, "breadcrumb", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			breadcrumbCount:setModel(f10_local0, f1_arg1)
		end
	end)
	self:addElement(breadcrumbCount)
	self.breadcrumbCount = breadcrumbCount
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "disabled")
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistOutfitCategory_Internal.__resetProperties = function(f13_arg0)
	f13_arg0.Header:completeAnimation()
	f13_arg0.FocusBrackets:completeAnimation()
	f13_arg0.FocusBorder:completeAnimation()
	f13_arg0.FocusGlow:completeAnimation()
	f13_arg0.LinesAdd:completeAnimation()
	f13_arg0.TiledBackingAdd:completeAnimation()
	f13_arg0.LEDPatternAdd:completeAnimation()
	f13_arg0.BracketL:completeAnimation()
	f13_arg0.BracketR:completeAnimation()
	f13_arg0.LockedIcon:completeAnimation()
	f13_arg0.Header:setRGB(0.92, 0.92, 0.92)
	f13_arg0.Header:setAlpha(0.75)
	f13_arg0.FocusBrackets:setLeftRight(0, 1, -28, 28)
	f13_arg0.FocusBrackets:setTopBottom(0, 1, -28, 28)
	f13_arg0.FocusBrackets:setAlpha(0)
	f13_arg0.FocusBorder:setAlpha(0)
	f13_arg0.FocusGlow:setAlpha(0)
	f13_arg0.LinesAdd:setAlpha(0)
	f13_arg0.TiledBackingAdd:setAlpha(0)
	f13_arg0.LEDPatternAdd:setAlpha(0)
	f13_arg0.BracketL:setAlpha(0)
	f13_arg0.BracketR:setAlpha(0)
	f13_arg0.LockedIcon:setAlpha(0)
end
CoD.SpecialistOutfitCategory_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Header:completeAnimation()
			f14_arg0.Header:setAlpha(0.2)
			f14_arg0.clipFinished(f14_arg0.Header)
		end,
		ActiveAndFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.FocusGlow:completeAnimation()
			f15_arg0.FocusGlow:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusGlow)
			f15_arg0.Header:completeAnimation()
			f15_arg0.Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f15_arg0.Header:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.Header)
			f15_arg0.FocusBorder:completeAnimation()
			f15_arg0.FocusBorder:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusBorder)
			f15_arg0.FocusBrackets:completeAnimation()
			f15_arg0.FocusBrackets:setLeftRight(0, 1, -9, 9)
			f15_arg0.FocusBrackets:setTopBottom(0, 1, -9, 9)
			f15_arg0.FocusBrackets:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.FocusBrackets)
		end,
		Active = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.TiledBackingAdd:completeAnimation()
			f16_arg0.TiledBackingAdd:setAlpha(0.05)
			f16_arg0.clipFinished(f16_arg0.TiledBackingAdd)
			f16_arg0.LEDPatternAdd:completeAnimation()
			f16_arg0.LEDPatternAdd:setAlpha(0.8)
			f16_arg0.clipFinished(f16_arg0.LEDPatternAdd)
			f16_arg0.Header:completeAnimation()
			f16_arg0.Header:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.Header)
			f16_arg0.LinesAdd:completeAnimation()
			f16_arg0.LinesAdd:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.LinesAdd)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.FocusGlow:completeAnimation()
			f17_arg0.FocusGlow:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusGlow)
			f17_arg0.Header:completeAnimation()
			f17_arg0.Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f17_arg0.Header:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.Header)
			f17_arg0.FocusBorder:completeAnimation()
			f17_arg0.FocusBorder:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusBorder)
			f17_arg0.FocusBrackets:completeAnimation()
			f17_arg0.FocusBrackets:setLeftRight(0, 1, -9, 9)
			f17_arg0.FocusBrackets:setTopBottom(0, 1, -9, 9)
			f17_arg0.FocusBrackets:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.FocusBrackets)
		end,
		GainFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			local f18_local0 = function(f19_arg0)
				f18_arg0.FocusGlow:beginAnimation(100)
				f18_arg0.FocusGlow:setAlpha(1)
				f18_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FocusGlow:completeAnimation()
			f18_arg0.FocusGlow:setAlpha(0)
			f18_local0(f18_arg0.FocusGlow)
			local f18_local1 = function(f20_arg0)
				f18_arg0.Header:beginAnimation(100)
				f18_arg0.Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f18_arg0.Header:setAlpha(1)
				f18_arg0.Header:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Header:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Header:completeAnimation()
			f18_arg0.Header:setRGB(0.92, 0.92, 0.92)
			f18_arg0.Header:setAlpha(0.2)
			f18_local1(f18_arg0.Header)
			local f18_local2 = function(f21_arg0)
				f18_arg0.FocusBorder:beginAnimation(100)
				f18_arg0.FocusBorder:setAlpha(1)
				f18_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.FocusBorder:completeAnimation()
			f18_arg0.FocusBorder:setAlpha(0)
			f18_local2(f18_arg0.FocusBorder)
			local f18_local3 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						f24_arg0:beginAnimation(30)
						f24_arg0:setLeftRight(0, 1, -9, 9)
						f24_arg0:setTopBottom(0, 1, -9, 9)
						f24_arg0:setAlpha(1)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
					end
					f23_arg0:beginAnimation(89)
					f23_arg0:setLeftRight(0, 1, -7, 7)
					f23_arg0:setTopBottom(0, 1, -7, 7)
					f23_arg0:setAlpha(0.75)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f18_arg0.FocusBrackets:beginAnimation(30)
				f18_arg0.FocusBrackets:setLeftRight(0, 1, -22.75, 22.75)
				f18_arg0.FocusBrackets:setTopBottom(0, 1, -22.75, 22.75)
				f18_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f18_arg0.FocusBrackets:completeAnimation()
			f18_arg0.FocusBrackets:setLeftRight(0, 1, -28, 28)
			f18_arg0.FocusBrackets:setTopBottom(0, 1, -28, 28)
			f18_arg0.FocusBrackets:setAlpha(0)
			f18_local3(f18_arg0.FocusBrackets)
		end,
		LoseFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			local f25_local0 = function(f26_arg0)
				f25_arg0.FocusGlow:beginAnimation(100)
				f25_arg0.FocusGlow:setAlpha(0)
				f25_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusGlow:completeAnimation()
			f25_arg0.FocusGlow:setAlpha(1)
			f25_local0(f25_arg0.FocusGlow)
			local f25_local1 = function(f27_arg0)
				f25_arg0.Header:beginAnimation(100)
				f25_arg0.Header:setRGB(0.92, 0.92, 0.92)
				f25_arg0.Header:setAlpha(0.2)
				f25_arg0.Header:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Header:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.Header:completeAnimation()
			f25_arg0.Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f25_arg0.Header:setAlpha(1)
			f25_local1(f25_arg0.Header)
			local f25_local2 = function(f28_arg0)
				f25_arg0.FocusBorder:beginAnimation(100)
				f25_arg0.FocusBorder:setAlpha(0)
				f25_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusBorder:completeAnimation()
			f25_arg0.FocusBorder:setAlpha(1)
			f25_local2(f25_arg0.FocusBorder)
			local f25_local3 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(40)
					f30_arg0:setLeftRight(0, 1, -28, 28)
					f30_arg0:setTopBottom(0, 1, -28, 28)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.FocusBrackets:beginAnimation(60)
				f25_arg0.FocusBrackets:setLeftRight(0, 1, -20.4, 20.4)
				f25_arg0.FocusBrackets:setTopBottom(0, 1, -20.4, 20.4)
				f25_arg0.FocusBrackets:setAlpha(0)
				f25_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f25_arg0.FocusBrackets:completeAnimation()
			f25_arg0.FocusBrackets:setLeftRight(0, 1, -9, 9)
			f25_arg0.FocusBrackets:setTopBottom(0, 1, -9, 9)
			f25_arg0.FocusBrackets:setAlpha(1)
			f25_local3(f25_arg0.FocusBrackets)
		end,
		GainActive = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(4)
			local f31_local0 = function(f32_arg0)
				f31_arg0.TiledBackingAdd:beginAnimation(100)
				f31_arg0.TiledBackingAdd:setAlpha(0.05)
				f31_arg0.TiledBackingAdd:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.TiledBackingAdd:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.TiledBackingAdd:completeAnimation()
			f31_arg0.TiledBackingAdd:setAlpha(0)
			f31_local0(f31_arg0.TiledBackingAdd)
			local f31_local1 = function(f33_arg0)
				f31_arg0.LEDPatternAdd:beginAnimation(100)
				f31_arg0.LEDPatternAdd:setAlpha(0.8)
				f31_arg0.LEDPatternAdd:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.LEDPatternAdd:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.LEDPatternAdd:completeAnimation()
			f31_arg0.LEDPatternAdd:setAlpha(0)
			f31_local1(f31_arg0.LEDPatternAdd)
			local f31_local2 = function(f34_arg0)
				f31_arg0.Header:beginAnimation(100)
				f31_arg0.Header:setAlpha(1)
				f31_arg0.Header:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Header:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.Header:completeAnimation()
			f31_arg0.Header:setAlpha(0.2)
			f31_local2(f31_arg0.Header)
			local f31_local3 = function(f35_arg0)
				f31_arg0.LinesAdd:beginAnimation(100)
				f31_arg0.LinesAdd:setAlpha(1)
				f31_arg0.LinesAdd:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.LinesAdd:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.LinesAdd:completeAnimation()
			f31_arg0.LinesAdd:setAlpha(0)
			f31_local3(f31_arg0.LinesAdd)
		end,
		LoseActive = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(4)
			local f36_local0 = function(f37_arg0)
				f36_arg0.TiledBackingAdd:beginAnimation(100)
				f36_arg0.TiledBackingAdd:setAlpha(0)
				f36_arg0.TiledBackingAdd:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.TiledBackingAdd:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.TiledBackingAdd:completeAnimation()
			f36_arg0.TiledBackingAdd:setAlpha(0.05)
			f36_local0(f36_arg0.TiledBackingAdd)
			local f36_local1 = function(f38_arg0)
				f36_arg0.LEDPatternAdd:beginAnimation(100)
				f36_arg0.LEDPatternAdd:setAlpha(0)
				f36_arg0.LEDPatternAdd:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.LEDPatternAdd:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.LEDPatternAdd:completeAnimation()
			f36_arg0.LEDPatternAdd:setAlpha(0.8)
			f36_local1(f36_arg0.LEDPatternAdd)
			local f36_local2 = function(f39_arg0)
				f36_arg0.Header:beginAnimation(100)
				f36_arg0.Header:setAlpha(0.2)
				f36_arg0.Header:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.Header:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.Header:completeAnimation()
			f36_arg0.Header:setAlpha(1)
			f36_local2(f36_arg0.Header)
			local f36_local3 = function(f40_arg0)
				f36_arg0.LinesAdd:beginAnimation(100)
				f36_arg0.LinesAdd:setAlpha(0)
				f36_arg0.LinesAdd:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.LinesAdd:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.LinesAdd:completeAnimation()
			f36_arg0.LinesAdd:setAlpha(1)
			f36_local3(f36_arg0.LinesAdd)
		end,
		GainActiveAndFocus = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(4)
			local f41_local0 = function(f42_arg0)
				f41_arg0.FocusGlow:beginAnimation(100)
				f41_arg0.FocusGlow:setAlpha(1)
				f41_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.FocusGlow:completeAnimation()
			f41_arg0.FocusGlow:setAlpha(0)
			f41_local0(f41_arg0.FocusGlow)
			local f41_local1 = function(f43_arg0)
				f41_arg0.Header:beginAnimation(100)
				f41_arg0.Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f41_arg0.Header:setAlpha(1)
				f41_arg0.Header:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.Header:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.Header:completeAnimation()
			f41_arg0.Header:setRGB(0.92, 0.92, 0.92)
			f41_arg0.Header:setAlpha(0.2)
			f41_local1(f41_arg0.Header)
			local f41_local2 = function(f44_arg0)
				f41_arg0.FocusBorder:beginAnimation(100)
				f41_arg0.FocusBorder:setAlpha(1)
				f41_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.FocusBorder:completeAnimation()
			f41_arg0.FocusBorder:setAlpha(0)
			f41_local2(f41_arg0.FocusBorder)
			local f41_local3 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					local f46_local0 = function(f47_arg0)
						f47_arg0:beginAnimation(30)
						f47_arg0:setLeftRight(0, 1, -9, 9)
						f47_arg0:setTopBottom(0, 1, -9, 9)
						f47_arg0:setAlpha(1)
						f47_arg0:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
					end
					f46_arg0:beginAnimation(89)
					f46_arg0:setLeftRight(0, 1, -7, 7)
					f46_arg0:setTopBottom(0, 1, -7, 7)
					f46_arg0:setAlpha(0.75)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
				end
				f41_arg0.FocusBrackets:beginAnimation(30)
				f41_arg0.FocusBrackets:setLeftRight(0, 1, -22.75, 22.75)
				f41_arg0.FocusBrackets:setTopBottom(0, 1, -22.75, 22.75)
				f41_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f41_arg0.FocusBrackets:completeAnimation()
			f41_arg0.FocusBrackets:setLeftRight(0, 1, -28, 28)
			f41_arg0.FocusBrackets:setTopBottom(0, 1, -28, 28)
			f41_arg0.FocusBrackets:setAlpha(0)
			f41_local3(f41_arg0.FocusBrackets)
		end,
		LoseActiveAndFocus = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(4)
			local f48_local0 = function(f49_arg0)
				f48_arg0.FocusGlow:beginAnimation(100)
				f48_arg0.FocusGlow:setAlpha(0)
				f48_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.FocusGlow:completeAnimation()
			f48_arg0.FocusGlow:setAlpha(1)
			f48_local0(f48_arg0.FocusGlow)
			local f48_local1 = function(f50_arg0)
				f48_arg0.Header:beginAnimation(100)
				f48_arg0.Header:setRGB(0.92, 0.92, 0.92)
				f48_arg0.Header:setAlpha(0.2)
				f48_arg0.Header:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.Header:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.Header:completeAnimation()
			f48_arg0.Header:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f48_arg0.Header:setAlpha(1)
			f48_local1(f48_arg0.Header)
			local f48_local2 = function(f51_arg0)
				f48_arg0.FocusBorder:beginAnimation(100)
				f48_arg0.FocusBorder:setAlpha(0)
				f48_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.FocusBorder:completeAnimation()
			f48_arg0.FocusBorder:setAlpha(1)
			f48_local2(f48_arg0.FocusBorder)
			local f48_local3 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					f53_arg0:beginAnimation(40)
					f53_arg0:setLeftRight(0, 1, -28, 28)
					f53_arg0:setTopBottom(0, 1, -28, 28)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.FocusBrackets:beginAnimation(60)
				f48_arg0.FocusBrackets:setLeftRight(0, 1, -20.4, 20.4)
				f48_arg0.FocusBrackets:setTopBottom(0, 1, -20.4, 20.4)
				f48_arg0.FocusBrackets:setAlpha(0)
				f48_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f48_arg0.FocusBrackets:completeAnimation()
			f48_arg0.FocusBrackets:setLeftRight(0, 1, -9, 9)
			f48_arg0.FocusBrackets:setTopBottom(0, 1, -9, 9)
			f48_arg0.FocusBrackets:setAlpha(1)
			f48_local3(f48_arg0.FocusBrackets)
		end,
	},
	Disabled = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(3)
			f54_arg0.BracketL:completeAnimation()
			f54_arg0.BracketL:setAlpha(0.5)
			f54_arg0.clipFinished(f54_arg0.BracketL)
			f54_arg0.LockedIcon:completeAnimation()
			f54_arg0.LockedIcon:setAlpha(0.02)
			f54_arg0.clipFinished(f54_arg0.LockedIcon)
			f54_arg0.BracketR:completeAnimation()
			f54_arg0.BracketR:setAlpha(0.5)
			f54_arg0.clipFinished(f54_arg0.BracketR)
		end,
	},
}
CoD.SpecialistOutfitCategory_Internal.__onClose = function(f55_arg0)
	f55_arg0.LEDPattern:close()
	f55_arg0.LEDPatternAdd:close()
	f55_arg0.Header:close()
	f55_arg0.EquippedMarkerTick:close()
	f55_arg0.Lines:close()
	f55_arg0.LinesAdd:close()
	f55_arg0.FocusBrackets:close()
	f55_arg0.breadcrumbCount:close()
end

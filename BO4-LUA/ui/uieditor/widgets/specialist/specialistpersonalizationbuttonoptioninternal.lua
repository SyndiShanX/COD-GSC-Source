require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.SpecialistPersonalizationButtonOptionInternal = InheritFrom(LUI.UIElement)
CoD.SpecialistPersonalizationButtonOptionInternal.__defaultWidth = 393
CoD.SpecialistPersonalizationButtonOptionInternal.__defaultHeight = 69
CoD.SpecialistPersonalizationButtonOptionInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistPersonalizationButtonOptionInternal)
	self.id = "SpecialistPersonalizationButtonOptionInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
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
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 6, -4, 0, 1, 7, -5)
	StoreCommonTextBacking:setAlpha(0.4)
	StoreCommonTextBacking.TiledShaderImage:setupNineSliceShader(42, 42)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local SelectionOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectionOverlay:setAlpha(0.01)
	self:addElement(SelectionOverlay)
	self.SelectionOverlay = SelectionOverlay
	local BracketL = LUI.UIImage.new(1, 1, -105.5, -97.5, 0.5, 0.5, -10.5, 13.5)
	BracketL:setAlpha(0)
	BracketL:setImage(RegisterImage(0x6AA0A70F33D3978))
	BracketL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BracketL)
	self.BracketL = BracketL
	local BracketR = LUI.UIImage.new(1, 1, -29.5, -21.5, 0.5, 0.5, -11.5, 12.5)
	BracketR:setAlpha(0)
	BracketR:setZRot(180)
	BracketR:setImage(RegisterImage(0x6AA0A70F33D3978))
	BracketR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BracketR)
	self.BracketR = BracketR
	local LockedIcon = LUI.UIImage.new(1, 1, -127.5, 0.5, 0.5, 0.5, -64, 64)
	LockedIcon:setAlpha(0)
	LockedIcon:setScale(0.25, 0.25)
	LockedIcon:setImage(RegisterImage(0xE1E7C490B2BA4FB))
	LockedIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	LockedIcon:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local Header = LUI.UIText.new(0, 0, 20, 200, 0.5, 0.5, -12, 12)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(LocalizeToUpperString(0x0))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Header:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Header)
	self.Header = Header
	local ButtonFrame = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonFrame)
	self.ButtonFrame = ButtonFrame
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
	ButtonFrame.id = "ButtonFrame"
	self.__defaultFocus = ButtonFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistPersonalizationButtonOptionInternal.__resetProperties = function(f4_arg0)
	f4_arg0.Header:completeAnimation()
	f4_arg0.SelectionOverlay:completeAnimation()
	f4_arg0.StoreCommonTextBacking:completeAnimation()
	f4_arg0.ButtonFrame:completeAnimation()
	f4_arg0.BracketL:completeAnimation()
	f4_arg0.BracketR:completeAnimation()
	f4_arg0.LockedIcon:completeAnimation()
	f4_arg0.Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f4_arg0.SelectionOverlay:setAlpha(0.01)
	f4_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
	f4_arg0.StoreCommonTextBacking:setAlpha(0.4)
	f4_arg0.ButtonFrame:setAlpha(1)
	f4_arg0.BracketL:setAlpha(0)
	f4_arg0.BracketR:setAlpha(0)
	f4_arg0.LockedIcon:setAlpha(0)
end
CoD.SpecialistPersonalizationButtonOptionInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.StoreCommonTextBacking:completeAnimation()
			f6_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f6_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f6_arg0.clipFinished(f6_arg0.StoreCommonTextBacking)
			f6_arg0.SelectionOverlay:completeAnimation()
			f6_arg0.SelectionOverlay:setAlpha(0.03)
			f6_arg0.clipFinished(f6_arg0.SelectionOverlay)
			f6_arg0.Header:completeAnimation()
			f6_arg0.Header:setRGB(0.92, 0.89, 0.72)
			f6_arg0.clipFinished(f6_arg0.Header)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				f7_arg0.StoreCommonTextBacking:beginAnimation(100)
				f7_arg0.StoreCommonTextBacking:setRGB(0.92, 0.61, 0.08)
				f7_arg0.StoreCommonTextBacking:setAlpha(0.6)
				f7_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.StoreCommonTextBacking:completeAnimation()
			f7_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
			f7_arg0.StoreCommonTextBacking:setAlpha(0.4)
			f7_local0(f7_arg0.StoreCommonTextBacking)
			local f7_local1 = function(f9_arg0)
				f7_arg0.SelectionOverlay:beginAnimation(100)
				f7_arg0.SelectionOverlay:setAlpha(0.03)
				f7_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SelectionOverlay:completeAnimation()
			f7_arg0.SelectionOverlay:setAlpha(0.01)
			f7_local1(f7_arg0.SelectionOverlay)
			local f7_local2 = function(f10_arg0)
				f7_arg0.Header:beginAnimation(100)
				f7_arg0.Header:setRGB(0.92, 0.89, 0.72)
				f7_arg0.Header:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Header:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Header:completeAnimation()
			f7_arg0.Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f7_local2(f7_arg0.Header)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f11_arg0.StoreCommonTextBacking:beginAnimation(100)
				f11_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
				f11_arg0.StoreCommonTextBacking:setAlpha(0.4)
				f11_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.StoreCommonTextBacking:completeAnimation()
			f11_arg0.StoreCommonTextBacking:setRGB(0.92, 0.61, 0.08)
			f11_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f11_local0(f11_arg0.StoreCommonTextBacking)
			local f11_local1 = function(f13_arg0)
				f11_arg0.SelectionOverlay:beginAnimation(100)
				f11_arg0.SelectionOverlay:setAlpha(0.01)
				f11_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.SelectionOverlay:completeAnimation()
			f11_arg0.SelectionOverlay:setAlpha(0.03)
			f11_local1(f11_arg0.SelectionOverlay)
			local f11_local2 = function(f14_arg0)
				f11_arg0.Header:beginAnimation(100)
				f11_arg0.Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f11_arg0.Header:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Header:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Header:completeAnimation()
			f11_arg0.Header:setRGB(0.92, 0.89, 0.72)
			f11_local2(f11_arg0.Header)
		end,
		Active = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.ButtonFrame:completeAnimation()
			f15_arg0.ButtonFrame:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.ButtonFrame)
		end,
		ActiveAndChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.StoreCommonTextBacking:completeAnimation()
			f16_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f16_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f16_arg0.clipFinished(f16_arg0.StoreCommonTextBacking)
			f16_arg0.SelectionOverlay:completeAnimation()
			f16_arg0.SelectionOverlay:setAlpha(0.03)
			f16_arg0.clipFinished(f16_arg0.SelectionOverlay)
			f16_arg0.Header:completeAnimation()
			f16_arg0.Header:setRGB(0.92, 0.89, 0.72)
			f16_arg0.clipFinished(f16_arg0.Header)
		end,
		ActiveToActiveAndChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			local f17_local0 = function(f18_arg0)
				f17_arg0.StoreCommonTextBacking:beginAnimation(100)
				f17_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
				f17_arg0.StoreCommonTextBacking:setAlpha(0.6)
				f17_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.StoreCommonTextBacking:completeAnimation()
			f17_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
			f17_arg0.StoreCommonTextBacking:setAlpha(0.4)
			f17_local0(f17_arg0.StoreCommonTextBacking)
			local f17_local1 = function(f19_arg0)
				f17_arg0.SelectionOverlay:beginAnimation(100)
				f17_arg0.SelectionOverlay:setAlpha(0.03)
				f17_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.SelectionOverlay:completeAnimation()
			f17_arg0.SelectionOverlay:setAlpha(0.01)
			f17_local1(f17_arg0.SelectionOverlay)
			local f17_local2 = function(f20_arg0)
				f17_arg0.Header:beginAnimation(100)
				f17_arg0.Header:setRGB(0.92, 0.89, 0.72)
				f17_arg0.Header:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Header:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Header:completeAnimation()
			f17_arg0.Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f17_local2(f17_arg0.Header)
			f17_arg0.ButtonFrame:completeAnimation()
			f17_arg0.ButtonFrame:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ButtonFrame)
		end,
		ActiveAndChildFocusToActive = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			local f21_local0 = function(f22_arg0)
				f21_arg0.StoreCommonTextBacking:beginAnimation(100)
				f21_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
				f21_arg0.StoreCommonTextBacking:setAlpha(0.4)
				f21_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.StoreCommonTextBacking:completeAnimation()
			f21_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f21_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f21_local0(f21_arg0.StoreCommonTextBacking)
			local f21_local1 = function(f23_arg0)
				f21_arg0.SelectionOverlay:beginAnimation(100)
				f21_arg0.SelectionOverlay:setAlpha(0.01)
				f21_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.SelectionOverlay:completeAnimation()
			f21_arg0.SelectionOverlay:setAlpha(0.03)
			f21_local1(f21_arg0.SelectionOverlay)
			local f21_local2 = function(f24_arg0)
				f21_arg0.Header:beginAnimation(100)
				f21_arg0.Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f21_arg0.Header:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Header:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Header:completeAnimation()
			f21_arg0.Header:setRGB(0.92, 0.89, 0.72)
			f21_local2(f21_arg0.Header)
			f21_arg0.ButtonFrame:completeAnimation()
			f21_arg0.ButtonFrame:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ButtonFrame)
		end,
	},
	Disabled = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.BracketL:completeAnimation()
			f25_arg0.BracketL:setAlpha(0.5)
			f25_arg0.clipFinished(f25_arg0.BracketL)
			f25_arg0.BracketR:completeAnimation()
			f25_arg0.BracketR:setAlpha(0.5)
			f25_arg0.clipFinished(f25_arg0.BracketR)
			f25_arg0.LockedIcon:completeAnimation()
			f25_arg0.LockedIcon:setAlpha(0.02)
			f25_arg0.clipFinished(f25_arg0.LockedIcon)
		end,
	},
}
if not CoD.isPC then
	CoD.SpecialistPersonalizationButtonOptionInternal.__clipsPerState.DefaultState.Active = nil
	CoD.SpecialistPersonalizationButtonOptionInternal.__clipsPerState.DefaultState.ActiveAndChildFocus = nil
	CoD.SpecialistPersonalizationButtonOptionInternal.__clipsPerState.DefaultState.ActiveToActiveAndChildFocus = nil
	CoD.SpecialistPersonalizationButtonOptionInternal.__clipsPerState.DefaultState.ActiveAndChildFocusToActive = nil
end
CoD.SpecialistPersonalizationButtonOptionInternal.__onClose = function(f26_arg0)
	f26_arg0.StoreCommonTextBacking:close()
	f26_arg0.ButtonFrame:close()
end

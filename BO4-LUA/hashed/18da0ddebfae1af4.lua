require("x64:5f8cf56752aa71b")
require("x64:19c1945d2e472b0")
CoD.ArchivesVideoButtonInternal = InheritFrom(LUI.UIElement)
CoD.ArchivesVideoButtonInternal.__defaultWidth = 510
CoD.ArchivesVideoButtonInternal.__defaultHeight = 42
CoD.ArchivesVideoButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArchivesVideoButtonInternal)
	self.id = "ArchivesVideoButtonInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setRGB(0, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
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
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local TiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBackingAdd:setAlpha(0)
	TiledBackingAdd:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
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
	BracketL:setImage(RegisterImage(@"hash_6AA0A70F33D3978"))
	BracketL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BracketL)
	self.BracketL = BracketL
	local BracketR = LUI.UIImage.new(1, 1, -29.5, -21.5, 0.5, 0.5, -11.5, 12.5)
	BracketR:setAlpha(0)
	BracketR:setZRot(180)
	BracketR:setImage(RegisterImage(@"hash_6AA0A70F33D3978"))
	BracketR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BracketR)
	self.BracketR = BracketR
	local LockedIcon = LUI.UIImage.new(1, 1, -127.5, 0.5, 0.5, 0.5, -64, 64)
	LockedIcon:setAlpha(0)
	LockedIcon:setScale(0.25, 0.25)
	LockedIcon:setImage(RegisterImage(@"uie_ui_icon_global_lock"))
	LockedIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	LockedIcon:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local ButtonFrame = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonFrame)
	self.ButtonFrame = ButtonFrame
	local ButtonText = LUI.UIText.new(0, 0, 10, 500, 0.5, 0.5, -10, 10)
	ButtonText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ButtonText:setTTF("ttmussels_regular")
	ButtonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ButtonText:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ButtonText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(ButtonText)
	self.ButtonText = ButtonText
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
CoD.ArchivesVideoButtonInternal.__resetProperties = function(f5_arg0)
	f5_arg0.SelectionOverlay:completeAnimation()
	f5_arg0.StoreCommonTextBacking:completeAnimation()
	f5_arg0.ButtonFrame:completeAnimation()
	f5_arg0.BracketL:completeAnimation()
	f5_arg0.BracketR:completeAnimation()
	f5_arg0.LockedIcon:completeAnimation()
	f5_arg0.SelectionOverlay:setAlpha(0.01)
	f5_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
	f5_arg0.StoreCommonTextBacking:setAlpha(0.4)
	f5_arg0.ButtonFrame:setAlpha(1)
	f5_arg0.BracketL:setAlpha(0)
	f5_arg0.BracketR:setAlpha(0)
	f5_arg0.LockedIcon:setAlpha(0)
end
CoD.ArchivesVideoButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.StoreCommonTextBacking:completeAnimation()
			f7_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f7_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f7_arg0.clipFinished(f7_arg0.StoreCommonTextBacking)
			f7_arg0.SelectionOverlay:completeAnimation()
			f7_arg0.SelectionOverlay:setAlpha(0.03)
			f7_arg0.clipFinished(f7_arg0.SelectionOverlay)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.StoreCommonTextBacking:beginAnimation(100)
				f8_arg0.StoreCommonTextBacking:setRGB(0.92, 0.61, 0.08)
				f8_arg0.StoreCommonTextBacking:setAlpha(0.6)
				f8_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.StoreCommonTextBacking:completeAnimation()
			f8_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
			f8_arg0.StoreCommonTextBacking:setAlpha(0.4)
			f8_local0(f8_arg0.StoreCommonTextBacking)
			local f8_local1 = function(f10_arg0)
				f8_arg0.SelectionOverlay:beginAnimation(100)
				f8_arg0.SelectionOverlay:setAlpha(0.03)
				f8_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SelectionOverlay:completeAnimation()
			f8_arg0.SelectionOverlay:setAlpha(0.01)
			f8_local1(f8_arg0.SelectionOverlay)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
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
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.ButtonFrame:completeAnimation()
			f14_arg0.ButtonFrame:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ButtonFrame)
		end,
		ActiveAndChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.StoreCommonTextBacking:completeAnimation()
			f15_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f15_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f15_arg0.clipFinished(f15_arg0.StoreCommonTextBacking)
			f15_arg0.SelectionOverlay:completeAnimation()
			f15_arg0.SelectionOverlay:setAlpha(0.03)
			f15_arg0.clipFinished(f15_arg0.SelectionOverlay)
		end,
		ActiveToActiveAndChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				f16_arg0.StoreCommonTextBacking:beginAnimation(100)
				f16_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
				f16_arg0.StoreCommonTextBacking:setAlpha(0.6)
				f16_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.StoreCommonTextBacking:completeAnimation()
			f16_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
			f16_arg0.StoreCommonTextBacking:setAlpha(0.4)
			f16_local0(f16_arg0.StoreCommonTextBacking)
			local f16_local1 = function(f18_arg0)
				f16_arg0.SelectionOverlay:beginAnimation(100)
				f16_arg0.SelectionOverlay:setAlpha(0.03)
				f16_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.SelectionOverlay:completeAnimation()
			f16_arg0.SelectionOverlay:setAlpha(0.01)
			f16_local1(f16_arg0.SelectionOverlay)
			f16_arg0.ButtonFrame:completeAnimation()
			f16_arg0.ButtonFrame:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.ButtonFrame)
		end,
		ActiveAndChildFocusToActive = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			local f19_local0 = function(f20_arg0)
				f19_arg0.StoreCommonTextBacking:beginAnimation(100)
				f19_arg0.StoreCommonTextBacking:setRGB(1, 1, 1)
				f19_arg0.StoreCommonTextBacking:setAlpha(0.4)
				f19_arg0.StoreCommonTextBacking:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.StoreCommonTextBacking:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.StoreCommonTextBacking:completeAnimation()
			f19_arg0.StoreCommonTextBacking:setRGB(1, 0.68, 0.12)
			f19_arg0.StoreCommonTextBacking:setAlpha(0.6)
			f19_local0(f19_arg0.StoreCommonTextBacking)
			local f19_local1 = function(f21_arg0)
				f19_arg0.SelectionOverlay:beginAnimation(100)
				f19_arg0.SelectionOverlay:setAlpha(0.01)
				f19_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.SelectionOverlay:completeAnimation()
			f19_arg0.SelectionOverlay:setAlpha(0.03)
			f19_local1(f19_arg0.SelectionOverlay)
			f19_arg0.ButtonFrame:completeAnimation()
			f19_arg0.ButtonFrame:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.ButtonFrame)
		end,
	},
	Disabled = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.BracketL:completeAnimation()
			f22_arg0.BracketL:setAlpha(0.5)
			f22_arg0.clipFinished(f22_arg0.BracketL)
			f22_arg0.BracketR:completeAnimation()
			f22_arg0.BracketR:setAlpha(0.5)
			f22_arg0.clipFinished(f22_arg0.BracketR)
			f22_arg0.LockedIcon:completeAnimation()
			f22_arg0.LockedIcon:setAlpha(0.02)
			f22_arg0.clipFinished(f22_arg0.LockedIcon)
		end,
	},
}
if not CoD.isPC then
	CoD.ArchivesVideoButtonInternal.__clipsPerState.DefaultState.Active = nil
	CoD.ArchivesVideoButtonInternal.__clipsPerState.DefaultState.ActiveAndChildFocus = nil
	CoD.ArchivesVideoButtonInternal.__clipsPerState.DefaultState.ActiveToActiveAndChildFocus = nil
	CoD.ArchivesVideoButtonInternal.__clipsPerState.DefaultState.ActiveAndChildFocusToActive = nil
end
CoD.ArchivesVideoButtonInternal.__onClose = function(f23_arg0)
	f23_arg0.StoreCommonTextBacking:close()
	f23_arg0.ButtonFrame:close()
	f23_arg0.ButtonText:close()
end

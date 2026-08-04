require("ui/uieditor/widgets/commonbuttonoutline")
CoD.DirectorButtonAdd = InheritFrom(LUI.UIElement)
CoD.DirectorButtonAdd.__defaultWidth = 280
CoD.DirectorButtonAdd.__defaultHeight = 214
CoD.DirectorButtonAdd.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorButtonAdd)
	self.id = "DirectorButtonAdd"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setRGB(0, 0, 0)
	SelectorOverlay:setAlpha(0.2)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage("uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local ButtonAddPlus = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	ButtonAddPlus:setImage(RegisterImage("uie_ui_menu_cac_button_add_plus"))
	self:addElement(ButtonAddPlus)
	self.ButtonAddPlus = ButtonAddPlus
	local ButtonAddPlusHighlighted = LUI.UIImage.new(0.5, 0.5, -22, 22, 0.5, 0.5, -22, 22)
	ButtonAddPlusHighlighted:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ButtonAddPlusHighlighted:setAlpha(0)
	ButtonAddPlusHighlighted:setImage(RegisterImage("uie_ui_menu_cac_button_add_plus_highlighted"))
	ButtonAddPlusHighlighted:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(ButtonAddPlusHighlighted)
	self.ButtonAddPlusHighlighted = ButtonAddPlusHighlighted
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorButtonAdd.__resetProperties = function(f2_arg0)
	f2_arg0.SelectorOverlay:completeAnimation()
	f2_arg0.ButtonAddPlusHighlighted:completeAnimation()
	f2_arg0.SelectorOverlay:setAlpha(0.2)
	f2_arg0.ButtonAddPlusHighlighted:setTopBottom(0.5, 0.5, -22, 22)
	f2_arg0.ButtonAddPlusHighlighted:setAlpha(0)
end
CoD.DirectorButtonAdd.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.SelectorOverlay:completeAnimation()
			f3_arg0.SelectorOverlay:setAlpha(0.01)
			f3_arg0.clipFinished(f3_arg0.SelectorOverlay)
			f3_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f3_arg0.ButtonAddPlusHighlighted:setTopBottom(0.5, 0.5, -22, 22)
			f3_arg0.ButtonAddPlusHighlighted:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.ButtonAddPlusHighlighted)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.SelectorOverlay:completeAnimation()
			f4_arg0.SelectorOverlay:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.SelectorOverlay)
			f4_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f4_arg0.ButtonAddPlusHighlighted:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.ButtonAddPlusHighlighted)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.SelectorOverlay:beginAnimation(200)
				f5_arg0.SelectorOverlay:setAlpha(0)
				f5_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.SelectorOverlay:completeAnimation()
			f5_arg0.SelectorOverlay:setAlpha(0.2)
			f5_local0(f5_arg0.SelectorOverlay)
			local f5_local1 = function(f7_arg0)
				f5_arg0.ButtonAddPlusHighlighted:beginAnimation(200)
				f5_arg0.ButtonAddPlusHighlighted:setAlpha(1)
				f5_arg0.ButtonAddPlusHighlighted:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ButtonAddPlusHighlighted:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f5_arg0.ButtonAddPlusHighlighted:setTopBottom(0.5, 0.5, -22, 22)
			f5_arg0.ButtonAddPlusHighlighted:setAlpha(0)
			f5_local1(f5_arg0.ButtonAddPlusHighlighted)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.SelectorOverlay:beginAnimation(200)
				f8_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SelectorOverlay:completeAnimation()
			f8_arg0.SelectorOverlay:setAlpha(0)
			f8_local0(f8_arg0.SelectorOverlay)
			local f8_local1 = function(f10_arg0)
				f8_arg0.ButtonAddPlusHighlighted:beginAnimation(200)
				f8_arg0.ButtonAddPlusHighlighted:setAlpha(0)
				f8_arg0.ButtonAddPlusHighlighted:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ButtonAddPlusHighlighted:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f8_arg0.ButtonAddPlusHighlighted:setTopBottom(0.5, 0.5, -22, 22)
			f8_arg0.ButtonAddPlusHighlighted:setAlpha(1)
			f8_local1(f8_arg0.ButtonAddPlusHighlighted)
		end,
	},
	Locked = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorButtonAdd.__onClose = function(f13_arg0)
	f13_arg0.CommonButtonOutline:close()
end

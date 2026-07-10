require("x64:7074d4a20877dae")
CoD.DemoSideBarButtonInternal = InheritFrom(LUI.UIElement)
CoD.DemoSideBarButtonInternal.__defaultWidth = 350
CoD.DemoSideBarButtonInternal.__defaultHeight = 70
CoD.DemoSideBarButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoSideBarButtonInternal)
	self.id = "DemoSideBarButtonInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0.01)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.4)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBackingAdd:setAlpha(0.35)
	NoiseTiledBackingAdd:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local FrontendFrameSelected = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FrontendFrameSelected:setAlpha(0)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	local FrontendFocusPip = LUI.UIImage.new(0, 1, -6, 6, 0, 1, -6, 6)
	FrontendFocusPip:setImage(RegisterImage(@"uie_ui_menu_store_focus_pips"))
	FrontendFocusPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFocusPip:setShaderVector(0, 0, 0, 0, 0)
	FrontendFocusPip:setupNineSliceShader(40, 40)
	self:addElement(FrontendFocusPip)
	self.FrontendFocusPip = FrontendFocusPip
	local FrontendFrameSelectedGlow = LUI.UIImage.new(0, 1, -8, 8, 0, 1, -8, 8)
	FrontendFrameSelectedGlow:setAlpha(0)
	FrontendFrameSelectedGlow:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelectedGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelectedGlow:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelectedGlow:setupNineSliceShader(28, 28)
	self:addElement(FrontendFrameSelectedGlow)
	self.FrontendFrameSelectedGlow = FrontendFrameSelectedGlow
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local Text = LUI.UIText.new(0, 0, 80, 334, 0.5, 0.5, -11, 11)
	Text:setTTF("ttmussels_regular")
	Text:setLetterSpacing(1)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Text)
	self.Text = Text
	local Icon = CoD.DemoSideBarButtonIcon.new(f1_arg0, f1_arg1, 0, 0, 22, 62, 0, 0, 15, 55)
	Icon:linkToElementModel(self, nil, false, function(model)
		Icon:setModel(model, f1_arg1)
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Lock = nil
	Lock = LUI.UIImage.new(0, 0, 31, 53, 0, 0, 22.5, 47.5)
	Lock:setAlpha(0)
	Lock:setImage(RegisterImage(@"uie_icon_locks_lock_01"))
	self:addElement(Lock)
	self.Lock = Lock
	self.Text:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Text:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self.Icon:linkToElementModel(self, "icon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Icon.Icon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(self, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "locked")
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
	self:linkToElementModel(self, "locked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoSideBarButtonInternal.__resetProperties = function(f9_arg0)
	f9_arg0.FrontendFocusPip:completeAnimation()
	f9_arg0.FrontendFrameSelected:completeAnimation()
	f9_arg0.Icon:completeAnimation()
	f9_arg0.Text:completeAnimation()
	f9_arg0.FrontendFrameSelectedGlow:completeAnimation()
	f9_arg0.SelectorOverlay:completeAnimation()
	f9_arg0.Lock:completeAnimation()
	f9_arg0.FrontendFocusPip:setRGB(1, 1, 1)
	f9_arg0.FrontendFocusPip:setAlpha(1)
	f9_arg0.FrontendFocusPip:setScale(1, 1)
	f9_arg0.FrontendFrameSelected:setAlpha(0)
	f9_arg0.Icon:setRGB(1, 1, 1)
	f9_arg0.Icon:setAlpha(1)
	f9_arg0.Text:setRGB(1, 1, 1)
	f9_arg0.Text:setAlpha(1)
	f9_arg0.FrontendFrameSelectedGlow:setAlpha(0)
	f9_arg0.SelectorOverlay:setAlpha(0.01)
	f9_arg0.Lock:setLeftRight(0, 0, 31, 53)
	f9_arg0.Lock:setTopBottom(0, 0, 22.5, 47.5)
	f9_arg0.Lock:setAlpha(0)
end
CoD.DemoSideBarButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.FrontendFrameSelected:completeAnimation()
			f10_arg0.FrontendFrameSelected:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FrontendFrameSelected)
			f10_arg0.FrontendFocusPip:completeAnimation()
			f10_arg0.FrontendFocusPip:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FrontendFocusPip)
			f10_arg0.Text:completeAnimation()
			f10_arg0.Text:setRGB(1, 1, 1)
			f10_arg0.clipFinished(f10_arg0.Text)
			f10_arg0.Icon:completeAnimation()
			f10_arg0.Icon:setRGB(1, 1, 1)
			f10_arg0.clipFinished(f10_arg0.Icon)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			f11_arg0.SelectorOverlay:completeAnimation()
			f11_arg0.SelectorOverlay:setAlpha(0.04)
			f11_arg0.clipFinished(f11_arg0.SelectorOverlay)
			f11_arg0.FrontendFrameSelected:completeAnimation()
			f11_arg0.FrontendFrameSelected:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FrontendFrameSelected)
			f11_arg0.FrontendFocusPip:completeAnimation()
			f11_arg0.FrontendFocusPip:setAlpha(0.3)
			f11_arg0.clipFinished(f11_arg0.FrontendFocusPip)
			f11_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f11_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
			f11_arg0.clipFinished(f11_arg0.FrontendFrameSelectedGlow)
			f11_arg0.Text:completeAnimation()
			f11_arg0.Text:setRGB(0.92, 0.89, 0.72)
			f11_arg0.clipFinished(f11_arg0.Text)
		end,
		GainFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			local f12_local0 = function(f13_arg0)
				f12_arg0.SelectorOverlay:beginAnimation(150)
				f12_arg0.SelectorOverlay:setAlpha(0.04)
				f12_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SelectorOverlay:completeAnimation()
			f12_arg0.SelectorOverlay:setAlpha(0.01)
			f12_local0(f12_arg0.SelectorOverlay)
			local f12_local1 = function(f14_arg0)
				f12_arg0.FrontendFrameSelected:beginAnimation(150)
				f12_arg0.FrontendFrameSelected:setAlpha(1)
				f12_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrontendFrameSelected:completeAnimation()
			f12_arg0.FrontendFrameSelected:setAlpha(0)
			f12_local1(f12_arg0.FrontendFrameSelected)
			local f12_local2 = function(f15_arg0)
				f12_arg0.FrontendFocusPip:beginAnimation(150)
				f12_arg0.FrontendFocusPip:setAlpha(0.3)
				f12_arg0.FrontendFocusPip:setScale(1, 1)
				f12_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrontendFocusPip:completeAnimation()
			f12_arg0.FrontendFocusPip:setRGB(1, 1, 1)
			f12_arg0.FrontendFocusPip:setAlpha(0)
			f12_arg0.FrontendFocusPip:setScale(1.04, 1.16)
			f12_local2(f12_arg0.FrontendFocusPip)
			local f12_local3 = function(f16_arg0)
				f12_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f12_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
				f12_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f12_arg0.FrontendFrameSelectedGlow:setAlpha(0)
			f12_local3(f12_arg0.FrontendFrameSelectedGlow)
			f12_arg0.Text:completeAnimation()
			f12_arg0.Text:setRGB(0.92, 0.89, 0.72)
			f12_arg0.clipFinished(f12_arg0.Text)
		end,
		LoseFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			local f17_local0 = function(f18_arg0)
				f17_arg0.SelectorOverlay:beginAnimation(150)
				f17_arg0.SelectorOverlay:setAlpha(0.01)
				f17_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.SelectorOverlay:completeAnimation()
			f17_arg0.SelectorOverlay:setAlpha(0.04)
			f17_local0(f17_arg0.SelectorOverlay)
			local f17_local1 = function(f19_arg0)
				f17_arg0.FrontendFrameSelected:beginAnimation(150)
				f17_arg0.FrontendFrameSelected:setAlpha(0)
				f17_arg0.FrontendFrameSelected:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FrontendFrameSelected:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FrontendFrameSelected:completeAnimation()
			f17_arg0.FrontendFrameSelected:setAlpha(1)
			f17_local1(f17_arg0.FrontendFrameSelected)
			local f17_local2 = function(f20_arg0)
				f17_arg0.FrontendFocusPip:beginAnimation(150)
				f17_arg0.FrontendFocusPip:setAlpha(0)
				f17_arg0.FrontendFocusPip:setScale(1.04, 1.16)
				f17_arg0.FrontendFocusPip:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FrontendFocusPip:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FrontendFocusPip:completeAnimation()
			f17_arg0.FrontendFocusPip:setAlpha(0.3)
			f17_arg0.FrontendFocusPip:setScale(1, 1)
			f17_local2(f17_arg0.FrontendFocusPip)
			local f17_local3 = function(f21_arg0)
				f17_arg0.FrontendFrameSelectedGlow:beginAnimation(150)
				f17_arg0.FrontendFrameSelectedGlow:setAlpha(0)
				f17_arg0.FrontendFrameSelectedGlow:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FrontendFrameSelectedGlow:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.FrontendFrameSelectedGlow:completeAnimation()
			f17_arg0.FrontendFrameSelectedGlow:setAlpha(0.05)
			f17_local3(f17_arg0.FrontendFrameSelectedGlow)
			f17_arg0.Text:completeAnimation()
			f17_arg0.Text:setRGB(1, 1, 1)
			f17_arg0.clipFinished(f17_arg0.Text)
		end,
	},
	Disabled = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.FrontendFrameSelected:completeAnimation()
			f22_arg0.FrontendFrameSelected:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.FrontendFrameSelected)
			f22_arg0.FrontendFocusPip:completeAnimation()
			f22_arg0.FrontendFocusPip:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.FrontendFocusPip)
			f22_arg0.Text:completeAnimation()
			f22_arg0.Text:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f22_arg0.clipFinished(f22_arg0.Text)
			f22_arg0.Icon:completeAnimation()
			f22_arg0.Icon:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f22_arg0.clipFinished(f22_arg0.Icon)
		end,
	},
	Locked = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			f23_arg0.FrontendFrameSelected:completeAnimation()
			f23_arg0.FrontendFrameSelected:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FrontendFrameSelected)
			f23_arg0.FrontendFocusPip:completeAnimation()
			f23_arg0.FrontendFocusPip:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.FrontendFocusPip)
			f23_arg0.Text:completeAnimation()
			f23_arg0.Text:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f23_arg0.Text:setAlpha(0.5)
			f23_arg0.clipFinished(f23_arg0.Text)
			f23_arg0.Icon:completeAnimation()
			f23_arg0.Icon:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f23_arg0.Icon:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Icon)
			f23_arg0.Lock:completeAnimation()
			f23_arg0.Lock:setLeftRight(0, 0, 31, 53)
			f23_arg0.Lock:setTopBottom(0, 0, 21.5, 46.5)
			f23_arg0.Lock:setAlpha(0.2)
			f23_arg0.clipFinished(f23_arg0.Lock)
		end,
	},
}
CoD.DemoSideBarButtonInternal.__onClose = function(f24_arg0)
	f24_arg0.Text:close()
	f24_arg0.Icon:close()
end

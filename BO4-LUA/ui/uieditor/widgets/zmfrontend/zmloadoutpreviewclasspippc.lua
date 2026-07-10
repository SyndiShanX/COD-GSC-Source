CoD.ZMLoadoutPreviewClassPipPC = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreviewClassPipPC.__defaultWidth = 32
CoD.ZMLoadoutPreviewClassPipPC.__defaultHeight = 15
CoD.ZMLoadoutPreviewClassPipPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreviewClassPipPC)
	self.id = "ZMLoadoutPreviewClassPipPC"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0.08, 0.93, 0, 0, 0.08, 0.93, 0, 0)
	BG:setRGB(0.22, 0.22, 0.22)
	self:addElement(BG)
	self.BG = BG
	local TiledBacking = LUI.UIImage.new(0.5, 0.5, -13, 13, 0.5, 0.5, -6, 6)
	TiledBacking:setAlpha(0.75)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(28, 12)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local Border = LUI.UIImage.new(0.08, 0.93, 0, 0, 0.08, 0.93, 0, 0)
	Border:setRGB(0.33, 0.33, 0.33)
	Border:setImage(RegisterImage(@"uie_highlight_border_line"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(7, 7)
	self:addElement(Border)
	self.Border = Border
	local Pip = LUI.UIImage.new(0.08, 0.93, 0, 0, 0.08, 0.93, 0, 0)
	Pip:setAlpha(0)
	Pip:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Pip)
	self.Pip = Pip
	local Glow = LUI.UIImage.new(-0.15, 1.15, 0, 0, -0.21, 1.21, 0, 0)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_ui_hud_core_no_ammo_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	Glow:setShaderVector(0, 0.05, 0.95, 0, 0)
	Glow:setShaderVector(1, 0.2, 0.2, 0, 0)
	Glow:setShaderVector(2, 0, 1, 0, 0)
	Glow:setShaderVector(3, 0, 0, 0, 0)
	Glow:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Glow)
	self.Glow = Glow
	self:mergeStateConditions({
		{
			stateName = "Chosen",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(self, f1_arg1, "selectedCustomClass", "classNum")
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.selectedCustomClass, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "selectedCustomClass",
		})
	end, false)
	self:linkToElementModel(self, "classNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "classNum",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.selectedCustomClass, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end, false)
	self:linkToElementModel(self, "classNum", true, function(model, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", function(element, menu, controller, model)
		if not CoD.ZMLoadoutUtility.ShouldHideLoadoutPreviewSelectButton(menu, element, controller, "selectedCustomClass", "classNum") then
			CoD.ZMLoadoutUtility.SetEquippedBubbleGumPackToSelectedClass(element, controller, menu)
			CoD.CACUtility.SelectCustomClass(controller, element)
			CoD.BaseUtility.SetControllerModelToSelfModelValue(controller, self, "selectedCustomClass", "classNum")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ZMLoadoutUtility.ShouldHideLoadoutPreviewSelectButton(menu, element, controller, "selectedCustomClass", "classNum") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.ZMLoadoutUtility.SetupPreviewPCPip(self, f1_arg1)
	return self
end
CoD.ZMLoadoutPreviewClassPipPC.__resetProperties = function(f12_arg0)
	f12_arg0.Pip:completeAnimation()
	f12_arg0.Glow:completeAnimation()
	f12_arg0.Pip:setRGB(1, 1, 1)
	f12_arg0.Pip:setAlpha(0)
	f12_arg0.Glow:setRGB(1, 1, 1)
	f12_arg0.Glow:setAlpha(0)
end
CoD.ZMLoadoutPreviewClassPipPC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Pip:beginAnimation(140)
				f14_arg0.Pip:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f14_arg0.Pip:setAlpha(0.35)
				f14_arg0.Pip:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Pip:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Pip:completeAnimation()
			f14_arg0.Pip:setRGB(1, 1, 1)
			f14_arg0.Pip:setAlpha(0.1)
			f14_local0(f14_arg0.Pip)
			local f14_local1 = function(f16_arg0)
				f14_arg0.Glow:beginAnimation(140)
				f14_arg0.Glow:setAlpha(0.5)
				f14_arg0.Glow:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Glow:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Glow:completeAnimation()
			f14_arg0.Glow:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f14_arg0.Glow:setAlpha(0)
			f14_local1(f14_arg0.Glow)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Pip:beginAnimation(140)
				f17_arg0.Pip:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f17_arg0.Pip:setAlpha(0.5)
				f17_arg0.Pip:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Pip:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Pip:completeAnimation()
			f17_arg0.Pip:setRGB(1, 1, 1)
			f17_arg0.Pip:setAlpha(0.1)
			f17_local0(f17_arg0.Pip)
			local f17_local1 = function(f19_arg0)
				f17_arg0.Glow:beginAnimation(140)
				f17_arg0.Glow:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
				f17_arg0.Glow:setAlpha(0.5)
				f17_arg0.Glow:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Glow:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Glow:completeAnimation()
			f17_arg0.Glow:setRGB(0.77, 0.28, 0.27)
			f17_arg0.Glow:setAlpha(0)
			f17_local1(f17_arg0.Glow)
		end,
	},
	Chosen = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.Pip:completeAnimation()
			f20_arg0.Pip:setRGB(1, 0, 0)
			f20_arg0.Pip:setAlpha(0.75)
			f20_arg0.clipFinished(f20_arg0.Pip)
			f20_arg0.Glow:completeAnimation()
			f20_arg0.Glow:setRGB(1, 0, 0)
			f20_arg0.Glow:setAlpha(0.7)
			f20_arg0.clipFinished(f20_arg0.Glow)
		end,
		Active = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.Pip:completeAnimation()
			f21_arg0.Pip:setRGB(1, 0, 0)
			f21_arg0.Pip:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Pip)
			f21_arg0.Glow:completeAnimation()
			f21_arg0.Glow:setRGB(1, 0, 0)
			f21_arg0.Glow:setAlpha(0.9)
			f21_arg0.clipFinished(f21_arg0.Glow)
		end,
	},
	Gamepad = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
		Active = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			local f23_local0 = function(f24_arg0)
				f23_arg0.Pip:beginAnimation(140)
				f23_arg0.Pip:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f23_arg0.Pip:setAlpha(1)
				f23_arg0.Pip:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Pip:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Pip:completeAnimation()
			f23_arg0.Pip:setRGB(1, 1, 1)
			f23_arg0.Pip:setAlpha(0.1)
			f23_local0(f23_arg0.Pip)
			local f23_local1 = function(f25_arg0)
				f23_arg0.Glow:beginAnimation(140)
				f23_arg0.Glow:setAlpha(0.5)
				f23_arg0.Glow:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Glow:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Glow:completeAnimation()
			f23_arg0.Glow:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f23_arg0.Glow:setAlpha(0)
			f23_local1(f23_arg0.Glow)
		end,
	},
}

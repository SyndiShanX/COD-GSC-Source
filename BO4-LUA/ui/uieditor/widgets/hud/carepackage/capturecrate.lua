require("x64:b6b5f594e0d79cf")
CoD.CaptureCrate = InheritFrom(LUI.UIElement)
CoD.CaptureCrate.__defaultWidth = 450
CoD.CaptureCrate.__defaultHeight = 96
CoD.CaptureCrate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "hudItems.captureCrateState")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "hudItems.captureCrateTotalTime")
	self:setClass(CoD.CaptureCrate)
	self.id = "CaptureCrate"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBarBGBlur = LUI.UIImage.new(0.5, 0.5, -218.5, 218.5, 0.5, 0.5, 10, 30)
	ProgressBarBGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	ProgressBarBGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ProgressBarBGBlur)
	self.ProgressBarBGBlur = ProgressBarBGBlur
	local ProgressBarBGTint = LUI.UIImage.new(0.5, 0.5, -221, 221, 0.5, 0.5, 10, 30)
	ProgressBarBGTint:setRGB(0, 0, 0)
	ProgressBarBGTint:setAlpha(0.7)
	self:addElement(ProgressBarBGTint)
	self.ProgressBarBGTint = ProgressBarBGTint
	local ProgressBarBacking = LUI.UIImage.new(0.5, 0.5, -216, 216, 0, 0, 62, 74)
	ProgressBarBacking:setRGB(0.47, 0.49, 0.53)
	ProgressBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	ProgressBarBacking:setShaderVector(0, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(1, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(2, 1, 0, 0, 0)
	ProgressBarBacking:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarBacking:setShaderVector(4, 1, 0.03, 1, 0)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local Cap = LUI.UIImage.new(0, 0, -0.5, 18.5, 0, 0, 63, 73)
	Cap:setZRot(90)
	Cap:setImage(RegisterImage(@"hash_7F3E81C52AE39D91"))
	Cap:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Cap)
	self.Cap = Cap
	local Cap2 = LUI.UIImage.new(0, 0, 430.5, 449.5, 0, 0, 63, 73)
	Cap2:setZRot(90)
	Cap2:setImage(RegisterImage(@"hash_7F3E81C52AE39D91"))
	Cap2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Cap2)
	self.Cap2 = Cap2
	local bar = LUI.UIImage.new(0, 0, 9, 441, 1, 1, -37, -19)
	bar:setRGB(0.92, 0.92, 0.92)
	bar:setImage(RegisterImage(@"uie_ui_hud_core_capture_bar"))
	bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	bar:setShaderVector(0, 1, 0, 0, 0)
	bar:setShaderVector(1, 0, 0, 0, 0)
	bar:setShaderVector(2, 1, 0, 0, 0)
	bar:setShaderVector(3, 0, 0, 0, 0)
	bar:setShaderVector(4, 0, 0, 0, 0)
	bar:subscribeToGlobalModel(f1_arg1, "HUDItems", "captureCrateTotalTime", function(model)
		CoD.HUDUtility.SetXFractionByModel(bar, f1_arg1, model)
	end)
	self:addElement(bar)
	self.bar = bar
	local text = LUI.UIText.new(0, 1, 0, 0, 0, 0, 24.5, 51.5)
	text:setRGB(0.92, 0.92, 0.92)
	text:setText(LocalizeToUpperString(@"hash_217565542D35AA75"))
	text:setTTF("ttmussels_demibold")
	text:setLetterSpacing(0.5)
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	text:setBackingType(1)
	text:setBackingWidget(CoD.Corner9SliceWithBlur, f1_arg0, f1_arg1)
	text:setBackingXPadding(12)
	text:setBackingYPadding(2)
	self:addElement(text)
	self.text = text
	local LED = LUI.UIImage.new(0, 0, 276, 457, 0, 0, 49.5, 89.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.18)
	LED:setScale(0.94, 0.94)
	LED:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED:setShaderVector(0, 0, 1, 0, 0)
	LED:setShaderVector(1, 0, 0, 0, 0)
	LED:setShaderVector(2, 0.24, 0.67, 0, 0)
	LED:setShaderVector(3, 0, 0, 0, 0)
	LED:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED)
	self.LED = LED
	local LED3 = LUI.UIImage.new(0, 0, -28, 153, 0, 0, 49.5, 89.5)
	LED3:setRGB(0, 0, 0)
	LED3:setAlpha(0.18)
	LED3:setScale(0.94, 0.94)
	LED3:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED3:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED3:setShaderVector(0, 0.19, 1, 0, 0)
	LED3:setShaderVector(1, 0, 0, 0, 0)
	LED3:setShaderVector(2, 0.24, 0.67, 0, 0)
	LED3:setShaderVector(3, 0, 0, 0, 0)
	LED3:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED3)
	self.LED3 = LED3
	local LED2 = LUI.UIImage.new(0, 0, 124, 305, 0, 0, 49.5, 89.5)
	LED2:setRGB(0, 0, 0)
	LED2:setAlpha(0.18)
	LED2:setScale(0.94, 0.94)
	LED2:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED2:setShaderVector(0, 0, 1, 0, 0)
	LED2:setShaderVector(1, 0, 0, 0, 0)
	LED2:setShaderVector(2, 0.24, 0.67, 0, 0)
	LED2:setShaderVector(3, 0, 0, 0, 0)
	LED2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED2)
	self.LED2 = LED2
	self:mergeStateConditions({
		{
			stateName = "Capture",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.captureCrateState", CoD.HUDUtility.SUPPLY_DROP_CRATE_STATE_CAPTURE)
			end,
		},
		{
			stateName = "Hack",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.captureCrateState", CoD.HUDUtility.SUPPLY_DROP_CRATE_STATE_HACK)
			end,
		},
		{
			stateName = "Disarm",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.captureCrateState", CoD.HUDUtility.SUPPLY_DROP_CRATE_STATE_DISARM)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.captureCrateState"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.captureCrateState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CaptureCrate.__resetProperties = function(f7_arg0)
	f7_arg0.text:completeAnimation()
	f7_arg0.bar:completeAnimation()
	f7_arg0.Cap2:completeAnimation()
	f7_arg0.Cap:completeAnimation()
	f7_arg0.LED3:completeAnimation()
	f7_arg0.LED2:completeAnimation()
	f7_arg0.LED:completeAnimation()
	f7_arg0.ProgressBarBGTint:completeAnimation()
	f7_arg0.ProgressBarBGBlur:completeAnimation()
	f7_arg0.ProgressBarBacking:completeAnimation()
	f7_arg0.text:setAlpha(1)
	f7_arg0.text:setText(LocalizeToUpperString(@"hash_217565542D35AA75"))
	f7_arg0.bar:setRGB(0.92, 0.92, 0.92)
	f7_arg0.bar:setAlpha(1)
	f7_arg0.Cap2:setAlpha(1)
	f7_arg0.Cap:setAlpha(1)
	f7_arg0.LED3:setAlpha(0.18)
	f7_arg0.LED2:setAlpha(0.18)
	f7_arg0.LED:setAlpha(0.18)
	f7_arg0.ProgressBarBGTint:setAlpha(0.7)
	f7_arg0.ProgressBarBGBlur:setAlpha(1)
	f7_arg0.ProgressBarBacking:setAlpha(1)
end
CoD.CaptureCrate.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(10)
			f8_arg0.ProgressBarBGBlur:completeAnimation()
			f8_arg0.ProgressBarBGBlur:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ProgressBarBGBlur)
			f8_arg0.ProgressBarBGTint:completeAnimation()
			f8_arg0.ProgressBarBGTint:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ProgressBarBGTint)
			f8_arg0.ProgressBarBacking:completeAnimation()
			f8_arg0.ProgressBarBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ProgressBarBacking)
			f8_arg0.Cap:completeAnimation()
			f8_arg0.Cap:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Cap)
			f8_arg0.Cap2:completeAnimation()
			f8_arg0.Cap2:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Cap2)
			f8_arg0.bar:completeAnimation()
			f8_arg0.bar:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.bar)
			f8_arg0.text:completeAnimation()
			f8_arg0.text:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.text)
			f8_arg0.LED:completeAnimation()
			f8_arg0.LED:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.LED)
			f8_arg0.LED3:completeAnimation()
			f8_arg0.LED3:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.LED3)
			f8_arg0.LED2:completeAnimation()
			f8_arg0.LED2:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.LED2)
		end,
	},
	Capture = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.bar:completeAnimation()
			f9_arg0.bar:setAlpha(0.95)
			f9_arg0.clipFinished(f9_arg0.bar)
		end,
	},
	Hack = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.bar:completeAnimation()
			f10_arg0.bar:setRGB(0.71, 0.18, 0.13)
			f10_arg0.bar:setAlpha(0.85)
			f10_arg0.clipFinished(f10_arg0.bar)
			f10_arg0.text:completeAnimation()
			f10_arg0.text:setText(LocalizeToUpperString(@"hash_7E83473CEA04BD5B"))
			f10_arg0.clipFinished(f10_arg0.text)
		end,
	},
	Disarm = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.bar:completeAnimation()
			f11_arg0.bar:setRGB(0.04, 0.65, 0.9)
			f11_arg0.bar:setAlpha(0.85)
			f11_arg0.clipFinished(f11_arg0.bar)
			f11_arg0.text:completeAnimation()
			f11_arg0.text:setText(LocalizeToUpperString(@"hash_35E4F35A99A1E628"))
			f11_arg0.clipFinished(f11_arg0.text)
		end,
	},
}
CoD.CaptureCrate.__onClose = function(f12_arg0)
	f12_arg0.bar:close()
end

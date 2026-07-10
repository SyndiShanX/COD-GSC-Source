require("x64:2e06eec4ea38539")
require("x64:298bd344d764bb6")
CoD.WZWeaponPickupHoldButtonIcons = InheritFrom(LUI.UIElement)
CoD.WZWeaponPickupHoldButtonIcons.__defaultWidth = 40
CoD.WZWeaponPickupHoldButtonIcons.__defaultHeight = 50
CoD.WZWeaponPickupHoldButtonIcons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZWeaponPickupHoldButtonIcons)
	self.id = "WZWeaponPickupHoldButtonIcons"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponPickupWarzoneSquareActionPC = nil
	WeaponPickupWarzoneSquareActionPC = LUI.UIText.new(0, 0, 45, 122, 0.5, 0.5, 36, 56)
	WeaponPickupWarzoneSquareActionPC:setRGB(0.79, 0.76, 0.58)
	WeaponPickupWarzoneSquareActionPC:setAlpha(0)
	WeaponPickupWarzoneSquareActionPC:setText(Engine[0xF9F1239CFD921FE](0x38B775D97E72F0C))
	WeaponPickupWarzoneSquareActionPC:setTTF("dinnext_regular")
	WeaponPickupWarzoneSquareActionPC:setLetterSpacing(0.5)
	WeaponPickupWarzoneSquareActionPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeaponPickupWarzoneSquareActionPC:setBackingType(1)
	WeaponPickupWarzoneSquareActionPC:setBackingWidget(CoD.WeaponPickupPrompt_Backing, f1_arg0, f1_arg1)
	WeaponPickupWarzoneSquareActionPC:setBackingXPadding(20)
	WeaponPickupWarzoneSquareActionPC:setBackingYPadding(9)
	self:addElement(WeaponPickupWarzoneSquareActionPC)
	self.WeaponPickupWarzoneSquareActionPC = WeaponPickupWarzoneSquareActionPC
	local WeaponPickupWarzoneActionPC = nil
	WeaponPickupWarzoneActionPC = LUI.UIText.new(0, 0, 45, 122, 0.5, 0.5, 36, 56)
	WeaponPickupWarzoneActionPC:setRGB(0.79, 0.76, 0.58)
	WeaponPickupWarzoneActionPC.__String_Reference = function()
		WeaponPickupWarzoneActionPC:setText(Engine[0xF9F1239CFD921FE](CoD.HUDUtility.Get3DWeaponHintAlsoPickupHintTextWithPickUpOptions(f1_arg1)))
	end
	WeaponPickupWarzoneActionPC.__String_Reference()
	WeaponPickupWarzoneActionPC:setTTF("dinnext_regular")
	WeaponPickupWarzoneActionPC:setLetterSpacing(0.5)
	WeaponPickupWarzoneActionPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WeaponPickupWarzoneActionPC:setBackingType(1)
	WeaponPickupWarzoneActionPC:setBackingWidget(CoD.WeaponPickupPrompt_Backing, f1_arg0, f1_arg1)
	WeaponPickupWarzoneActionPC:setBackingXPadding(20)
	WeaponPickupWarzoneActionPC:setBackingYPadding(9)
	self:addElement(WeaponPickupWarzoneActionPC)
	self.WeaponPickupWarzoneActionPC = WeaponPickupWarzoneActionPC
	local ButtonPrompt = CoD.WZHoldButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, -24.5, 64.5, 0, 0, 4, 46)
	ButtonPrompt:mergeStateConditions({
		{
			stateName = "HideHold",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsProfileIntValue(f1_arg1, "warzoneInstantPickups", 1)
			end,
		},
	})
	ButtonPrompt:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ButtonPrompt, f4_arg1)
	end)
	local f1_local4 = ButtonPrompt
	local ButtonPromptTriangle = ButtonPrompt.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ButtonPromptTriangle(f1_local4, f1_local6.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(ButtonPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local4 = ButtonPrompt
	ButtonPromptTriangle = ButtonPrompt.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	ButtonPromptTriangle(f1_local4, f1_local6["storageGlobalRoot.user_settings"], function(f6_arg0)
		f1_arg0:updateElementState(ButtonPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	ButtonPrompt.ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+activate}]"))
	ButtonPrompt.ControllerDependentTextBox.GamepadText:setText(CoD.BaseUtility.AlreadyLocalized("[{+usereload}]"))
	ButtonPrompt:subscribeToGlobalModel(f1_arg1, "HUDItems", "useHoldProgress", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ButtonPrompt.ButtonProgressRing.progressRing:setShaderVector(0, AdjustStartEnd(-1.5, 1.5, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4)))
		end
	end)
	self:addElement(ButtonPrompt)
	self.ButtonPrompt = ButtonPrompt
	ButtonPromptTriangle = CoD.WZHoldButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, -24.5, 64.5, 0, 0, 50, 92)
	ButtonPromptTriangle:mergeStateConditions({
		{
			stateName = "HideHold",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ButtonPromptTriangle:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ButtonPromptTriangle, f9_arg1)
	end)
	f1_local6 = ButtonPromptTriangle
	f1_local4 = ButtonPromptTriangle.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local6, f1_local7.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(ButtonPromptTriangle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ButtonPromptTriangle.ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+pickup}]"))
	ButtonPromptTriangle.ControllerDependentTextBox.GamepadText:setText(CoD.BaseUtility.AlreadyLocalized("[{+weapnext_inventory}]"))
	ButtonPromptTriangle:subscribeToGlobalModel(f1_arg1, "HUDItems", "heroHoldProgress", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			ButtonPromptTriangle.ButtonProgressRing.progressRing:setShaderVector(0, AdjustStartEnd(-1.5, 1.5, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4)))
		end
	end)
	self:addElement(ButtonPromptTriangle)
	self.ButtonPromptTriangle = ButtonPromptTriangle
	f1_local4 = nil
	self.WeaponPickupWarzoneSquareAction = LUI.UIElement.createFake()
	f1_local6 = nil
	f1_local6 = LUI.UIElement.createFake()
	self.WeaponPickupWarzoneAction = f1_local6
	local f1_local8 = WeaponPickupWarzoneActionPC
	f1_local7 = WeaponPickupWarzoneActionPC.subscribeToModel
	local f1_local9 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.weapon3dHintState, WeaponPickupWarzoneActionPC.__String_Reference)
	f1_local8 = WeaponPickupWarzoneActionPC
	f1_local7 = WeaponPickupWarzoneActionPC.subscribeToModel
	f1_local9 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.heroHoldProgress, WeaponPickupWarzoneActionPC.__String_Reference)
	f1_local8 = WeaponPickupWarzoneActionPC
	f1_local7 = WeaponPickupWarzoneActionPC.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local8, f1_local9["hudItems.inventory.filledSlots"], WeaponPickupWarzoneActionPC.__String_Reference)
	f1_local8 = f1_local6
	f1_local7 = f1_local6.subscribeToModel
	f1_local9 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.weapon3dHintState, f1_local6.__String_Reference)
	f1_local8 = f1_local6
	f1_local7 = f1_local6.subscribeToModel
	f1_local9 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.heroHoldProgress, f1_local6.__String_Reference)
	f1_local8 = f1_local6
	f1_local7 = f1_local6.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local8, f1_local9["hudItems.inventory.filledSlots"], f1_local6.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "ShowPickupPromptOnly",
			condition = function(menu, element, event)
				return CoD.HUDUtility.ShowTriangleFullInventoryPickupPrompt(f1_arg1)
			end,
		},
		{
			stateName = "ShowDualPromptsSwapped",
			condition = function(menu, element, event)
				local f13_local0 = CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(f1_arg1)
				if f13_local0 then
					f13_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.heroHoldProgress", 0)
					if f13_local0 then
						f13_local0 = not IsIntDvarNonZero("tabbedMultiItemPickup")
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "ShowDualPrompts",
			condition = function(menu, element, event)
				return CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(f1_arg1)
			end,
		},
	})
	f1_local8 = self
	f1_local7 = self.subscribeToModel
	f1_local9 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.weapon3dHintState, function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "weapon3dHintState",
		})
	end, false)
	f1_local8 = self
	f1_local7 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local8, f1_local9["hudItems.inventory.filledSlots"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "hudItems.inventory.filledSlots",
		})
	end, false)
	f1_local8 = self
	f1_local7 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local8, f1_local9["hudItems.heroHoldProgress"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "hudItems.heroHoldProgress",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZWeaponPickupHoldButtonIcons.__resetProperties = function(f18_arg0)
	f18_arg0.WeaponPickupWarzoneAction:completeAnimation()
	f18_arg0.ButtonPromptTriangle:completeAnimation()
	f18_arg0.WeaponPickupWarzoneActionPC:completeAnimation()
	f18_arg0.ButtonPrompt:completeAnimation()
	f18_arg0.WeaponPickupWarzoneSquareAction:completeAnimation()
	f18_arg0.WeaponPickupWarzoneSquareActionPC:completeAnimation()
	f18_arg0.WeaponPickupWarzoneAction:setTopBottom(0.5, 0.5, 36, 56)
	f18_arg0.WeaponPickupWarzoneAction:setAlpha(1)
	f18_arg0.WeaponPickupWarzoneAction:setBackingAlpha(1)
	f18_arg0.ButtonPromptTriangle:setTopBottom(0, 0, 50, 92)
	f18_arg0.ButtonPromptTriangle:setAlpha(1)
	f18_arg0.WeaponPickupWarzoneActionPC:setTopBottom(0.5, 0.5, 36, 56)
	f18_arg0.WeaponPickupWarzoneActionPC:setAlpha(1)
	f18_arg0.WeaponPickupWarzoneActionPC:setBackingAlpha(1)
	f18_arg0.ButtonPrompt:setTopBottom(0, 0, 4, 46)
	f18_arg0.ButtonPrompt:setAlpha(1)
	f18_arg0.WeaponPickupWarzoneSquareAction:setTopBottom(0.5, 0.5, 36, 56)
	f18_arg0.WeaponPickupWarzoneSquareAction:setAlpha(0)
	f18_arg0.WeaponPickupWarzoneSquareAction:setBackingAlpha(1)
	f18_arg0.WeaponPickupWarzoneSquareActionPC:setTopBottom(0.5, 0.5, 36, 56)
	f18_arg0.WeaponPickupWarzoneSquareActionPC:setAlpha(0)
	f18_arg0.WeaponPickupWarzoneSquareActionPC:setBackingAlpha(1)
end
CoD.WZWeaponPickupHoldButtonIcons.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.WeaponPickupWarzoneActionPC:completeAnimation()
			f19_arg0.WeaponPickupWarzoneActionPC:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.WeaponPickupWarzoneActionPC)
			f19_arg0.ButtonPromptTriangle:completeAnimation()
			f19_arg0.ButtonPromptTriangle:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ButtonPromptTriangle)
			f19_arg0.WeaponPickupWarzoneAction:completeAnimation()
			f19_arg0.WeaponPickupWarzoneAction:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.WeaponPickupWarzoneAction)
		end,
	},
	ShowPickupPromptOnly = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.ButtonPrompt:completeAnimation()
			f20_arg0.ButtonPrompt:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ButtonPrompt)
		end,
		ShowDualPromptsSwapped = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							f25_arg0:beginAnimation(39)
							f25_arg0:setTopBottom(0.5, 0.5, 35, 55)
							f25_arg0:setAlpha(1)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
						end
						f24_arg0:beginAnimation(9)
						f24_arg0:setTopBottom(0.5, 0.5, 17, 37)
						f24_arg0:setAlpha(0.36)
						f24_arg0:setBackingAlpha(1)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(50)
					f23_arg0:setTopBottom(0.5, 0.5, 12.5, 32.5)
					f23_arg0:setAlpha(0.2)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f21_arg0.WeaponPickupWarzoneSquareActionPC:beginAnimation(220)
				f21_arg0.WeaponPickupWarzoneSquareActionPC:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.WeaponPickupWarzoneSquareActionPC:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.WeaponPickupWarzoneSquareActionPC:completeAnimation()
			f21_arg0.WeaponPickupWarzoneSquareActionPC:setTopBottom(0.5, 0.5, -10, 10)
			f21_arg0.WeaponPickupWarzoneSquareActionPC:setAlpha(1)
			f21_arg0.WeaponPickupWarzoneSquareActionPC:setBackingAlpha(0)
			f21_local0(f21_arg0.WeaponPickupWarzoneSquareActionPC)
			local f21_local1 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(99)
					f27_arg0:setTopBottom(0.5, 0.5, -10, 10)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.WeaponPickupWarzoneActionPC:beginAnimation(220)
				f21_arg0.WeaponPickupWarzoneActionPC:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.WeaponPickupWarzoneActionPC:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f21_arg0.WeaponPickupWarzoneActionPC:completeAnimation()
			f21_arg0.WeaponPickupWarzoneActionPC:setTopBottom(0.5, 0.5, 36, 56)
			f21_local1(f21_arg0.WeaponPickupWarzoneActionPC)
			local f21_local2 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(99)
					f29_arg0:setTopBottom(0, 0, 50, 92)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.ButtonPrompt:beginAnimation(220)
				f21_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f21_arg0.ButtonPrompt:completeAnimation()
			f21_arg0.ButtonPrompt:setTopBottom(0, 0, 4, 46)
			f21_local2(f21_arg0.ButtonPrompt)
			local f21_local3 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(99)
					f31_arg0:setTopBottom(0, 0, 4, 46)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.ButtonPromptTriangle:beginAnimation(220)
				f21_arg0.ButtonPromptTriangle:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ButtonPromptTriangle:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f21_arg0.ButtonPromptTriangle:completeAnimation()
			f21_arg0.ButtonPromptTriangle:setTopBottom(0, 0, 50, 92)
			f21_local3(f21_arg0.ButtonPromptTriangle)
			local f21_local4 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							f35_arg0:beginAnimation(39)
							f35_arg0:setTopBottom(0.5, 0.5, 35, 55)
							f35_arg0:setAlpha(1)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
						end
						f34_arg0:beginAnimation(9)
						f34_arg0:setTopBottom(0.5, 0.5, 17, 37)
						f34_arg0:setAlpha(0.36)
						f34_arg0:setBackingAlpha(1)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(50)
					f33_arg0:setTopBottom(0.5, 0.5, 12.5, 32.5)
					f33_arg0:setAlpha(0.2)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f21_arg0.WeaponPickupWarzoneSquareAction:beginAnimation(220)
				f21_arg0.WeaponPickupWarzoneSquareAction:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.WeaponPickupWarzoneSquareAction:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f21_arg0.WeaponPickupWarzoneSquareAction:completeAnimation()
			f21_arg0.WeaponPickupWarzoneSquareAction:setTopBottom(0.5, 0.5, -10, 10)
			f21_arg0.WeaponPickupWarzoneSquareAction:setAlpha(1)
			f21_arg0.WeaponPickupWarzoneSquareAction:setBackingAlpha(0)
			f21_local4(f21_arg0.WeaponPickupWarzoneSquareAction)
			local f21_local5 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(99)
					f37_arg0:setTopBottom(0.5, 0.5, -10, 10)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.WeaponPickupWarzoneAction:beginAnimation(220)
				f21_arg0.WeaponPickupWarzoneAction:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.WeaponPickupWarzoneAction:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f21_arg0.WeaponPickupWarzoneAction:completeAnimation()
			f21_arg0.WeaponPickupWarzoneAction:setTopBottom(0.5, 0.5, 36, 56)
			f21_local5(f21_arg0.WeaponPickupWarzoneAction)
		end,
	},
	ShowDualPromptsSwapped = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(4)
			f38_arg0.WeaponPickupWarzoneSquareActionPC:completeAnimation()
			f38_arg0.WeaponPickupWarzoneSquareActionPC:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.WeaponPickupWarzoneSquareActionPC)
			f38_arg0.WeaponPickupWarzoneActionPC:completeAnimation()
			f38_arg0.WeaponPickupWarzoneActionPC:setTopBottom(0.5, 0.5, -10, 10)
			f38_arg0.WeaponPickupWarzoneActionPC:setAlpha(1)
			f38_arg0.WeaponPickupWarzoneActionPC:setBackingAlpha(0)
			f38_arg0.clipFinished(f38_arg0.WeaponPickupWarzoneActionPC)
			f38_arg0.ButtonPrompt:completeAnimation()
			f38_arg0.ButtonPrompt:setTopBottom(0, 0, 50, 92)
			f38_arg0.clipFinished(f38_arg0.ButtonPrompt)
			f38_arg0.ButtonPromptTriangle:completeAnimation()
			f38_arg0.ButtonPromptTriangle:setTopBottom(0, 0, 4, 46)
			f38_arg0.clipFinished(f38_arg0.ButtonPromptTriangle)
			f38_arg0.WeaponPickupWarzoneSquareAction:completeAnimation()
			f38_arg0.WeaponPickupWarzoneSquareAction:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.WeaponPickupWarzoneSquareAction)
			f38_arg0.WeaponPickupWarzoneAction:completeAnimation()
			f38_arg0.WeaponPickupWarzoneAction:setTopBottom(0.5, 0.5, -10, 10)
			f38_arg0.WeaponPickupWarzoneAction:setAlpha(1)
			f38_arg0.WeaponPickupWarzoneAction:setBackingAlpha(0)
			f38_arg0.clipFinished(f38_arg0.WeaponPickupWarzoneAction)
		end,
	},
	ShowDualPrompts = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(0)
		end,
		ShowDualPromptsSwapped = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(4)
			local f40_local0 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					local f42_local0 = function(f43_arg0)
						local f43_local0 = function(f44_arg0)
							f44_arg0:beginAnimation(39)
							f44_arg0:setTopBottom(0.5, 0.5, 35, 55)
							f44_arg0:setAlpha(1)
							f44_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
						end
						f43_arg0:beginAnimation(9)
						f43_arg0:setTopBottom(0.5, 0.5, 17, 37)
						f43_arg0:setAlpha(0.36)
						f43_arg0:setBackingAlpha(1)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
					end
					f42_arg0:beginAnimation(50)
					f42_arg0:setTopBottom(0.5, 0.5, 12.5, 32.5)
					f42_arg0:setAlpha(0.2)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f40_arg0.WeaponPickupWarzoneSquareActionPC:beginAnimation(220)
				f40_arg0.WeaponPickupWarzoneSquareActionPC:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.WeaponPickupWarzoneSquareActionPC:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f40_arg0.WeaponPickupWarzoneSquareActionPC:completeAnimation()
			f40_arg0.WeaponPickupWarzoneSquareActionPC:setTopBottom(0.5, 0.5, -10, 10)
			f40_arg0.WeaponPickupWarzoneSquareActionPC:setAlpha(1)
			f40_arg0.WeaponPickupWarzoneSquareActionPC:setBackingAlpha(0)
			f40_local0(f40_arg0.WeaponPickupWarzoneSquareActionPC)
			local f40_local1 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(99)
					f46_arg0:setTopBottom(0.5, 0.5, -10, 10)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.WeaponPickupWarzoneActionPC:beginAnimation(220)
				f40_arg0.WeaponPickupWarzoneActionPC:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.WeaponPickupWarzoneActionPC:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f40_arg0.WeaponPickupWarzoneActionPC:completeAnimation()
			f40_arg0.WeaponPickupWarzoneActionPC:setTopBottom(0.5, 0.5, 36, 56)
			f40_local1(f40_arg0.WeaponPickupWarzoneActionPC)
			local f40_local2 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(99)
					f48_arg0:setTopBottom(0, 0, 50, 92)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.ButtonPrompt:beginAnimation(220)
				f40_arg0.ButtonPrompt:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.ButtonPrompt:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f40_arg0.ButtonPrompt:completeAnimation()
			f40_arg0.ButtonPrompt:setTopBottom(0, 0, 4, 46)
			f40_local2(f40_arg0.ButtonPrompt)
			local f40_local3 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(99)
					f50_arg0:setTopBottom(0, 0, 4, 46)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.ButtonPromptTriangle:beginAnimation(220)
				f40_arg0.ButtonPromptTriangle:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.ButtonPromptTriangle:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f40_arg0.ButtonPromptTriangle:completeAnimation()
			f40_arg0.ButtonPromptTriangle:setTopBottom(0, 0, 50, 92)
			f40_local3(f40_arg0.ButtonPromptTriangle)
			local f40_local4 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					local f52_local0 = function(f53_arg0)
						local f53_local0 = function(f54_arg0)
							f54_arg0:beginAnimation(39)
							f54_arg0:setTopBottom(0.5, 0.5, 35, 55)
							f54_arg0:setAlpha(1)
							f54_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
						end
						f53_arg0:beginAnimation(9)
						f53_arg0:setTopBottom(0.5, 0.5, 17, 37)
						f53_arg0:setAlpha(0.36)
						f53_arg0:setBackingAlpha(1)
						f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
					end
					f52_arg0:beginAnimation(50)
					f52_arg0:setTopBottom(0.5, 0.5, 12.5, 32.5)
					f52_arg0:setAlpha(0.2)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
				end
				f40_arg0.WeaponPickupWarzoneSquareAction:beginAnimation(220)
				f40_arg0.WeaponPickupWarzoneSquareAction:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.WeaponPickupWarzoneSquareAction:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f40_arg0.WeaponPickupWarzoneSquareAction:completeAnimation()
			f40_arg0.WeaponPickupWarzoneSquareAction:setTopBottom(0.5, 0.5, -10, 10)
			f40_arg0.WeaponPickupWarzoneSquareAction:setAlpha(1)
			f40_arg0.WeaponPickupWarzoneSquareAction:setBackingAlpha(0)
			f40_local4(f40_arg0.WeaponPickupWarzoneSquareAction)
			local f40_local5 = function(f55_arg0)
				local f55_local0 = function(f56_arg0)
					f56_arg0:beginAnimation(99)
					f56_arg0:setTopBottom(0.5, 0.5, -10, 10)
					f56_arg0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
				end
				f40_arg0.WeaponPickupWarzoneAction:beginAnimation(220)
				f40_arg0.WeaponPickupWarzoneAction:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.WeaponPickupWarzoneAction:registerEventHandler("transition_complete_keyframe", f55_local0)
			end
			f40_arg0.WeaponPickupWarzoneAction:completeAnimation()
			f40_arg0.WeaponPickupWarzoneAction:setTopBottom(0.5, 0.5, 36, 56)
			f40_local5(f40_arg0.WeaponPickupWarzoneAction)
		end,
	},
}
CoD.WZWeaponPickupHoldButtonIcons.__onClose = function(f57_arg0)
	f57_arg0.WeaponPickupWarzoneActionPC:close()
	f57_arg0.ButtonPrompt:close()
	f57_arg0.ButtonPromptTriangle:close()
	f57_arg0.WeaponPickupWarzoneAction:close()
end

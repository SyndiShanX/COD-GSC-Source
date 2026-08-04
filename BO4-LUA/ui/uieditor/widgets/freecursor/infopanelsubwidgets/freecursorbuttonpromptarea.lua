require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursorbuttonpromptcontainer")
CoD.freeCursorButtonPromptArea = InheritFrom(LUI.UIElement)
CoD.freeCursorButtonPromptArea.__defaultWidth = 1044
CoD.freeCursorButtonPromptArea.__defaultHeight = 36
CoD.freeCursorButtonPromptArea.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorButtonPromptArea)
	self.id = "freeCursorButtonPromptArea"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonBacking = LUI.UIImage.new(0, 0, 0, 430, 0, 0, 0, 36)
	buttonBacking:setRGB(0.06, 0.06, 0.06)
	buttonBacking:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	buttonBacking:setShaderVector(0, 1, 0, 0, 0)
	buttonBacking:setShaderVector(1, 0, 0, 0, 0)
	buttonBacking:setShaderVector(2, 1, 0, 0, 0)
	buttonBacking:setShaderVector(3, 0, 0, 0, 0)
	buttonBacking:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(buttonBacking)
	self.buttonBacking = buttonBacking
	local buttonPrompts = CoD.freeCursorButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 36)
	self:addElement(buttonPrompts)
	self.buttonPrompts = buttonPrompts
	local warzonePickupHint = nil
	warzonePickupHint = LUI.UIText.new(0.03, 0.03, 0, 342, 0.5, 0.5, -10, 10)
	warzonePickupHint:setRGB(1, 0, 0)
	warzonePickupHint:setAlpha(0)
	warzonePickupHint:setTTF("dinnext_regular")
	warzonePickupHint:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	warzonePickupHint:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	warzonePickupHint:linkToElementModel(self, "pickupHintWarzone", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			warzonePickupHint:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(warzonePickupHint)
	self.warzonePickupHint = warzonePickupHint
	self:mergeStateConditions({
		{
			stateName = "ShowWarzoneHint",
			condition = function(menu, element, event)
				local f3_local0 = IsMouseOrKeyboard(f1_arg1)
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "pickupHintWarzone")
					if f3_local0 then
						f3_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isStashFocused")
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "ShowBacking",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "detailedDescription")
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "detailedView")
					if f4_local0 then
						f4_local0 = AnyContextualButtonPrompts(self, f1_arg1)
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "pickupHintWarzone", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "pickupHintWarzone",
		})
	end)
	self:linkToElementModel(self, "isStashFocused", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isStashFocused",
		})
	end)
	self:linkToElementModel(self, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	self:linkToElementModel(self, "detailedView", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedView",
		})
	end)
	self:linkToElementModel(self, "buttonPrompts", true, function(model)
		local f12_local0 = self
		CoD.FreeCursorUtility.RecreateButtonPromptContainerAndLinkToSelfModelValue(self, f1_arg1, f1_arg0, "buttonPrompts", model)
	end)
	buttonPrompts.id = "buttonPrompts"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	if IsPC() then
		SetElementProperty(self.buttonBacking, "skipHorizontalLayout", true)
		CoD.FreeCursorUtility.UseVisibleChildrenWidth(self)
		CoD.FreeCursorUtility.UseMaxVisibleChildHeight(self)
		CoD.HUDUtility.SetupWeaponHintPickupHintTextKBM(self, f1_local5, f1_arg1)
		CoD.FreeCursorUtility.SetIsShowingContextualPromptsModelPC(f1_local5, f1_arg1, f1_arg0)
	else
		SetElementProperty(self.buttonBacking, "skipHorizontalLayout", true)
		CoD.FreeCursorUtility.UseVisibleChildrenWidth(self)
		CoD.FreeCursorUtility.UseMaxVisibleChildHeight(self)
	end
	f1_local5 = warzonePickupHint
	if not CoD.HUDUtility.IsWarzone() then
		ReplaceElementWithFake(self, "warzonePickupHint")
	end
	return self
end
CoD.freeCursorButtonPromptArea.__resetProperties = function(f13_arg0)
	f13_arg0.buttonBacking:completeAnimation()
	f13_arg0.warzonePickupHint:completeAnimation()
	f13_arg0.buttonPrompts:completeAnimation()
	f13_arg0.buttonBacking:setTopBottom(0, 0, 0, 36)
	f13_arg0.buttonBacking:setRGB(0.06, 0.06, 0.06)
	f13_arg0.buttonBacking:setAlpha(1)
	f13_arg0.buttonBacking:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	f13_arg0.buttonBacking:setShaderVector(0, 1, 0, 0, 0)
	f13_arg0.buttonBacking:setShaderVector(1, 0, 0, 0, 0)
	f13_arg0.buttonBacking:setShaderVector(2, 1, 0, 0, 0)
	f13_arg0.buttonBacking:setShaderVector(3, 0, 0, 0, 0)
	f13_arg0.buttonBacking:setShaderVector(4, 0, 0, 0, 0)
	f13_arg0.warzonePickupHint:setAlpha(0)
	f13_arg0.buttonPrompts:setLeftRight(0, 1, 0, 0)
	f13_arg0.buttonPrompts:setTopBottom(0, 0, 0, 36)
	f13_arg0.buttonPrompts:setAlpha(1)
end
CoD.freeCursorButtonPromptArea.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.buttonBacking:completeAnimation()
			f14_arg0.buttonBacking:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.buttonBacking)
		end,
		ShowBacking = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.buttonBacking:beginAnimation(100)
				f15_arg0.buttonBacking:setShaderVector(0, 1, 0, 0, 0)
				f15_arg0.buttonBacking:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.buttonBacking:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.buttonBacking:completeAnimation()
			f15_arg0.buttonBacking:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
			f15_arg0.buttonBacking:setShaderVector(0, 0.1, 0, 0, 0)
			f15_arg0.buttonBacking:setShaderVector(1, 0, 0, 0, 0)
			f15_arg0.buttonBacking:setShaderVector(2, 1, 0, 0, 0)
			f15_arg0.buttonBacking:setShaderVector(3, 0, 0, 0, 0)
			f15_arg0.buttonBacking:setShaderVector(4, 0, 0, 0, 0)
			f15_local0(f15_arg0.buttonBacking)
		end,
	},
	ShowWarzoneHint = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.buttonBacking:completeAnimation()
			f17_arg0.buttonBacking:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.buttonBacking)
			f17_arg0.buttonPrompts:completeAnimation()
			f17_arg0.buttonPrompts:setLeftRight(0.36, 1.36, 0, 0)
			f17_arg0.clipFinished(f17_arg0.buttonPrompts)
			f17_arg0.warzonePickupHint:completeAnimation()
			f17_arg0.warzonePickupHint:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.warzonePickupHint)
		end,
	},
	ShowBacking = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.buttonBacking:completeAnimation()
			f18_arg0.buttonBacking:setTopBottom(0, 0, 0, 30)
			f18_arg0.buttonBacking:setRGB(0.14, 0.14, 0.14)
			f18_arg0.buttonBacking:setAlpha(0.98)
			f18_arg0.clipFinished(f18_arg0.buttonBacking)
			f18_arg0.buttonPrompts:completeAnimation()
			f18_arg0.buttonPrompts:setTopBottom(0, 0, 0, 30)
			f18_arg0.buttonPrompts:setAlpha(0.7)
			f18_arg0.clipFinished(f18_arg0.buttonPrompts)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.buttonBacking:completeAnimation()
			f19_arg0.buttonBacking:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.buttonBacking)
			f19_arg0.buttonPrompts:completeAnimation()
			f19_arg0.buttonPrompts:setLeftRight(0, 0, 0, 1044)
			f19_arg0.clipFinished(f19_arg0.buttonPrompts)
		end,
	},
}
CoD.freeCursorButtonPromptArea.__onClose = function(f20_arg0)
	f20_arg0.buttonBacking:close()
	f20_arg0.buttonPrompts:close()
	f20_arg0.warzonePickupHint:close()
end

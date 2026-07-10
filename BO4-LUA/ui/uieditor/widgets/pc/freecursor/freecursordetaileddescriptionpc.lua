require("x64:5b0746a4176f12b")
CoD.freeCursorDetailedDescriptionPC = InheritFrom(LUI.UIElement)
CoD.freeCursorDetailedDescriptionPC.__defaultWidth = 405
CoD.freeCursorDetailedDescriptionPC.__defaultHeight = 200
CoD.freeCursorDetailedDescriptionPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorDetailedDescriptionPC)
	self.id = "freeCursorDetailedDescriptionPC"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setImage(RegisterImage(@"hash_431AC999EEEB3C99"))
	BG:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BG:setShaderVector(0, 0, 0, 0, 0)
	BG:setupNineSliceShader(6, 6)
	self:addElement(BG)
	self.BG = BG
	local detailedDescription2 = LUI.UIText.new(0, 0, 10, 397, 0, 0, 10, 28)
	detailedDescription2:setRGB(0.75, 0.74, 0.73)
	detailedDescription2:setTTF("ttmussels_regular")
	detailedDescription2:setLetterSpacing(2)
	detailedDescription2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	detailedDescription2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	detailedDescription2:linkToElementModel(self, "detailedDescription", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			detailedDescription2:setText(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(detailedDescription2, "setText", function(element, controller)
		if IsTextEmpty(element) and IsGamepad(f1_arg1) then
			CollapseFreeCursorElement(self)
		elseif not IsTextEmpty(element) then
			UpdateWidgetHeightToMultilineText(self, self.detailedDescription2, 10)
			SetContainerHeightToMultilineText(self, self.detailedDescription2, 10)
		end
	end)
	self:addElement(detailedDescription2)
	self.detailedDescription2 = detailedDescription2
	local noLabelButtonPrompts2 = CoD.freeCursorNoLabelButtonPromptArea.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 1, 1, -42, -6)
	noLabelButtonPrompts2:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	noLabelButtonPrompts2:setAlpha(0)
	noLabelButtonPrompts2:linkToElementModel(self, nil, false, function(model)
		noLabelButtonPrompts2:setModel(model, f1_arg1)
	end)
	self:addElement(noLabelButtonPrompts2)
	self.noLabelButtonPrompts2 = noLabelButtonPrompts2
	self:mergeStateConditions({
		{
			stateName = "VisibleKBM",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "detailedDescription")
				if f6_local0 then
					f6_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "detailedViewPC")
					if f6_local0 then
						f6_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "VisibleGamepad",
			condition = function(menu, element, event)
				local f7_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "detailedDescription")
				if f7_local0 then
					f7_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "detailedView")
					if f7_local0 then
						f7_local0 = IsGamepad(f1_arg1)
					end
				end
				return f7_local0
			end,
		},
	})
	self:linkToElementModel(self, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	self:linkToElementModel(self, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f10_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "detailedView", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedView",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.FreeCursorUtility.UseLocalHeight(self)
	return self
end
CoD.freeCursorDetailedDescriptionPC.__resetProperties = function(f13_arg0)
	f13_arg0.detailedDescription2:completeAnimation()
	f13_arg0.BG:completeAnimation()
	f13_arg0.detailedDescription2:setAlpha(1)
	f13_arg0.BG:setTopBottom(0, 1, 0, 0)
	f13_arg0.BG:setRGB(1, 1, 1)
	f13_arg0.BG:setAlpha(1)
end
CoD.freeCursorDetailedDescriptionPC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.BG:completeAnimation()
			f14_arg0.BG:setTopBottom(0, 1, 0, 0)
			f14_arg0.BG:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BG)
			f14_arg0.detailedDescription2:completeAnimation()
			f14_arg0.detailedDescription2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.detailedDescription2)
		end,
	},
	VisibleKBM = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.BG:completeAnimation()
			f15_arg0.BG:setTopBottom(0, 1, 0, 0)
			f15_arg0.BG:setRGB(1, 1, 1)
			f15_arg0.BG:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.BG)
			f15_arg0.detailedDescription2:completeAnimation()
			f15_arg0.detailedDescription2:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.detailedDescription2)
		end,
	},
	VisibleGamepad = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.BG:completeAnimation()
			f16_arg0.BG:setTopBottom(0, 1, 0, 0)
			f16_arg0.BG:setRGB(1, 1, 1)
			f16_arg0.BG:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.BG)
			f16_arg0.detailedDescription2:completeAnimation()
			f16_arg0.detailedDescription2:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.detailedDescription2)
		end,
	},
}
CoD.freeCursorDetailedDescriptionPC.__onClose = function(f17_arg0)
	f17_arg0.detailedDescription2:close()
	f17_arg0.noLabelButtonPrompts2:close()
end

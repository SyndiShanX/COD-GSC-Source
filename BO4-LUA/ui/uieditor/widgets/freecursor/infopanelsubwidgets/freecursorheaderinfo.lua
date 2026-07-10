require("x64:990129a15a105f")
require("x64:5b0746a4176f12b")
require("x64:fd51e83e2e6dbd1")
require("x64:9d185ccb5a360a0")
CoD.freeCursorHeaderInfo = InheritFrom(LUI.UIElement)
CoD.freeCursorHeaderInfo.__defaultWidth = 756
CoD.freeCursorHeaderInfo.__defaultHeight = 41
CoD.freeCursorHeaderInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorHeaderInfo)
	self.id = "freeCursorHeaderInfo"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	self.backingDetailed = LUI.UIElement.createFake()
	local backingDetailedPC = nil
	backingDetailedPC = CoD.FooterButton_TooltipBG.new(f1_arg0, f1_arg1, 0, 0, 0, 430, 0, 0, 5, 41)
	backingDetailedPC:setAlpha(0)
	self:addElement(backingDetailedPC)
	self.backingDetailedPC = backingDetailedPC
	local noLabelButtonPrompts = CoD.freeCursorNoLabelButtonPromptArea.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 0, 0, 5, 41)
	noLabelButtonPrompts:linkToElementModel(self, nil, false, function(model)
		noLabelButtonPrompts:setModel(model, f1_arg1)
	end)
	self:addElement(noLabelButtonPrompts)
	self.noLabelButtonPrompts = noLabelButtonPrompts
	local titleContainer = CoD.freeCursorHeaderLabelContainer.new(f1_arg0, f1_arg1, 0, 0, 300, 705, 0, 0, 5, 41)
	titleContainer:linkToElementModel(self, nil, false, function(model)
		titleContainer:setModel(model, f1_arg1)
	end)
	self:addElement(titleContainer)
	self.titleContainer = titleContainer
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.detailsButton = f1_local5
	local cautionHint = CoD.onOffImage.new(f1_arg0, f1_arg1, 0, 1, 0, -32, 0, 0, 0, 5)
	cautionHint:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "cautionDescription")
				if f4_local0 then
					if not CoD.ModelUtility.AreButtonModelValueBitsSet(f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], Enum[@"luibuttonflags"][@"flag_down"]) then
						f4_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "detailedViewPC")
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
	})
	cautionHint:linkToElementModel(cautionHint, "cautionDescription", true, function(model)
		f1_arg0:updateElementState(cautionHint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cautionDescription",
		})
	end)
	local f1_local7 = cautionHint
	local f1_local8 = cautionHint.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["ButtonBits." .. Enum[@"luibutton"][@"lui_key_rtrig"]], function(f6_arg0)
		f1_arg0:updateElementState(cautionHint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "ButtonBits." .. Enum[@"luibutton"][@"lui_key_rtrig"],
		})
	end, false)
	cautionHint:linkToElementModel(cautionHint, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(cautionHint, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	cautionHint:setRGB(0.97, 0.92, 0.1)
	cautionHint:linkToElementModel(self, nil, false, function(model)
		cautionHint:setModel(model, f1_arg1)
	end)
	self:addElement(cautionHint)
	self.cautionHint = cautionHint
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.titleContainer, f1_arg1, "title") and not CoD.FreeCursorUtility.IsTooltipInDetailedView(self, f1_arg1)
			end,
		},
		{
			stateName = "VisibleDetailedKBM",
			condition = function(menu, element, event)
				local f10_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.titleContainer, f1_arg1, "title")
				if f10_local0 then
					f10_local0 = CoD.FreeCursorUtility.IsTooltipInDetailedView(self, f1_arg1)
					if f10_local0 then
						f10_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f10_local0
			end,
		},
		{
			stateName = "VisibleDetailed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.titleContainer, f1_arg1, "title") and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "title", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "title",
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
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["ButtonBits." .. Enum[@"luibutton"][@"lui_key_rtrig"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "ButtonBits." .. Enum[@"luibutton"][@"lui_key_rtrig"],
		})
	end, false)
	self:linkToElementModel(self, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f16_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.detailedView", function(model)
		local f18_local0 = self
		if IsGamepad(f1_arg1) then
			CoD.FreeCursorUtility.AnimateToHorizontalLeftLayout(self, 200)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.updated", function(model)
		local f19_local0 = self
		CoD.FreeCursorUtility.AnimateToHorizontalLeftLayout(self, 0)
	end)
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.detailedViewPC", function(model)
		local f20_local0 = self
		if IsMouseOrKeyboard(f1_arg1) then
			CoD.FreeCursorUtility.AnimateToHorizontalLeftLayout(self, 0)
		end
	end)
	f1_local5.id = "detailsButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	CoD.FreeCursorUtility.SetIgnoredByHorizontalLayout(self.backingDetailed)
	CoD.FreeCursorUtility.SetIgnoredByHorizontalLayout(self.cautionHint)
	CoD.FreeCursorUtility.SetIgnoredByHorizontalLayout(self.backingDetailedPC)
	CoD.FreeCursorUtility.UseVisibleChildrenWidth(self)
	SetElementProperty(self.titleContainer, "inCompactView", true)
	SetElementProperty(self.cautionHint, "inCompactView", true)
	return self
end
CoD.freeCursorHeaderInfo.__resetProperties = function(f21_arg0)
	f21_arg0.titleContainer:completeAnimation()
	f21_arg0.detailsButton:completeAnimation()
	f21_arg0.noLabelButtonPrompts:completeAnimation()
	f21_arg0.backingDetailed:completeAnimation()
	f21_arg0.backingDetailedPC:completeAnimation()
	f21_arg0.titleContainer:setAlpha(1)
	f21_arg0.detailsButton:setAlpha(1)
	f21_arg0.noLabelButtonPrompts:setAlpha(1)
	f21_arg0.backingDetailed:setAlpha(0)
	f21_arg0.backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	f21_arg0.backingDetailed:setShaderVector(0, 1, 0, 0, 0)
	f21_arg0.backingDetailed:setShaderVector(1, 0, 0, 0, 0)
	f21_arg0.backingDetailed:setShaderVector(2, 1, 0, 0, 0)
	f21_arg0.backingDetailed:setShaderVector(3, 0, 0, 0, 0)
	f21_arg0.backingDetailed:setShaderVector(4, 0, 0, 0, 0)
	f21_arg0.backingDetailedPC:setAlpha(0)
end
CoD.freeCursorHeaderInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.noLabelButtonPrompts:completeAnimation()
			f22_arg0.noLabelButtonPrompts:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.noLabelButtonPrompts)
			f22_arg0.titleContainer:completeAnimation()
			f22_arg0.titleContainer:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.titleContainer)
			f22_arg0.detailsButton:completeAnimation()
			f22_arg0.detailsButton:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.detailsButton)
		end,
		VisibleDetailed = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.backingDetailed:beginAnimation(100)
				f23_arg0.backingDetailed:setShaderVector(0, 1, 0, 0, 0)
				f23_arg0.backingDetailed:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.backingDetailed:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.backingDetailed:completeAnimation()
			f23_arg0.backingDetailed:setAlpha(1)
			f23_arg0.backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
			f23_arg0.backingDetailed:setShaderVector(0, 0, 0, 0, 0)
			f23_arg0.backingDetailed:setShaderVector(1, 0, 0, 0, 0)
			f23_arg0.backingDetailed:setShaderVector(2, 1, 0, 0, 0)
			f23_arg0.backingDetailed:setShaderVector(3, 0, 0, 0, 0)
			f23_arg0.backingDetailed:setShaderVector(4, 0, 0, 0, 0)
			f23_local0(f23_arg0.backingDetailed)
			f23_arg0.titleContainer:completeAnimation()
			f23_arg0.titleContainer:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.titleContainer)
		end,
	},
	Visible = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.titleContainer:completeAnimation()
			f25_arg0.titleContainer:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.titleContainer)
		end,
		VisibleDetailed = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.backingDetailed:beginAnimation(200)
				f26_arg0.backingDetailed:setShaderVector(0, 1, 0, 0, 0)
				f26_arg0.backingDetailed:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.backingDetailed:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.backingDetailed:completeAnimation()
			f26_arg0.backingDetailed:setAlpha(1)
			f26_arg0.backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
			f26_arg0.backingDetailed:setShaderVector(0, 0.16, 0, 0, 0)
			f26_arg0.backingDetailed:setShaderVector(1, 0, 0, 0, 0)
			f26_arg0.backingDetailed:setShaderVector(2, 1, 0, 0, 0)
			f26_arg0.backingDetailed:setShaderVector(3, 0, 0, 0, 0)
			f26_arg0.backingDetailed:setShaderVector(4, 0, 0, 0, 0)
			f26_local0(f26_arg0.backingDetailed)
			f26_arg0.titleContainer:completeAnimation()
			f26_arg0.titleContainer:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.titleContainer)
		end,
	},
	VisibleDetailedKBM = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.backingDetailed:completeAnimation()
			f28_arg0.backingDetailed:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.backingDetailed)
			f28_arg0.backingDetailedPC:completeAnimation()
			f28_arg0.backingDetailedPC:setAlpha(1)
			f28_arg0.backingDetailedPC:playClip("HideBorder")
			f28_arg0.clipFinished(f28_arg0.backingDetailedPC)
			f28_arg0.titleContainer:completeAnimation()
			f28_arg0.titleContainer:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.titleContainer)
		end,
	},
	VisibleDetailed = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.backingDetailed:completeAnimation()
			f29_arg0.backingDetailed:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.backingDetailed)
			f29_arg0.backingDetailedPC:completeAnimation()
			f29_arg0.backingDetailedPC:setAlpha(1)
			f29_arg0.backingDetailedPC:playClip("HideBorder")
			f29_arg0.clipFinished(f29_arg0.backingDetailedPC)
			f29_arg0.titleContainer:completeAnimation()
			f29_arg0.titleContainer:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.titleContainer)
		end,
	},
}
CoD.freeCursorHeaderInfo.__onClose = function(f30_arg0)
	f30_arg0.backingDetailed:close()
	f30_arg0.backingDetailedPC:close()
	f30_arg0.noLabelButtonPrompts:close()
	f30_arg0.titleContainer:close()
	f30_arg0.detailsButton:close()
	f30_arg0.cautionHint:close()
end

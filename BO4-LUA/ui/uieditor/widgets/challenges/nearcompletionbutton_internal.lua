require("x64:940f79fd8806311")
require("x64:5f8cf56752aa71b")
CoD.NearCompletionButton_Internal = InheritFrom(LUI.UIElement)
CoD.NearCompletionButton_Internal.__defaultWidth = 1175
CoD.NearCompletionButton_Internal.__defaultHeight = 280
CoD.NearCompletionButton_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NearCompletionButton_Internal)
	self.id = "NearCompletionButton_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local NearCompletionGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 10, 0, nil, nil, false, false, false, false)
	NearCompletionGrid:setLeftRight(0.49, 1.47, -556, -556)
	NearCompletionGrid:setTopBottom(0.5, 0.5, -130, 130)
	NearCompletionGrid:setAlpha(0.9)
	NearCompletionGrid:setWidgetType(CoD.ChallengesNearCompletionWidgetSummary)
	NearCompletionGrid:setVerticalCount(3)
	NearCompletionGrid:setSpacing(10)
	NearCompletionGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NearCompletionGrid:setDataSource("ChallengesNearCompletionList")
	self:addElement(NearCompletionGrid)
	self.NearCompletionGrid = NearCompletionGrid
	local CompletedIcon = LUI.UIImage.new(0.5, 0.5, -110, 110, 0.5, 0.5, -138, 82)
	CompletedIcon:setAlpha(0)
	CompletedIcon:setImage(RegisterImage(@"ui_icon_challenges_complete_large"))
	self:addElement(CompletedIcon)
	self.CompletedIcon = CompletedIcon
	local percentText = LUI.UIText.new(0.5, 0.5, -70, 70, 0.5, 0.5, 70.5, 103.5)
	percentText:setRGB(ColorSet.T8_PC_CHAT_PARTY.r, ColorSet.T8_PC_CHAT_PARTY.g, ColorSet.T8_PC_CHAT_PARTY.b)
	percentText:setAlpha(0)
	percentText:setTTF("0arame_mono_stencil")
	percentText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	percentText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	percentText:linkToElementModel(self, "percentComplete", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			percentText:setText(NumberAsPercentRounded(f2_local0))
		end
	end)
	self:addElement(percentText)
	self.percentText = percentText
	local CompleteText = LUI.UIText.new(0.5, 0.5, -500, 500, 1, 1, -31, -11)
	CompleteText:setRGB(ColorSet.T8_PC_CHAT_PARTY.r, ColorSet.T8_PC_CHAT_PARTY.g, ColorSet.T8_PC_CHAT_PARTY.b)
	CompleteText:setAlpha(0)
	CompleteText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D71FAC557D462BC"))
	CompleteText:setTTF("dinnext_regular")
	CompleteText:setLetterSpacing(2)
	CompleteText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CompleteText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CompleteText)
	self.CompleteText = CompleteText
	local ButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonOutline)
	self.ButtonOutline = ButtonOutline
	self:mergeStateConditions({
		{
			stateName = "AllChallengesComplete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "percentComplete", 1)
			end,
		},
	})
	self:linkToElementModel(self, "percentComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentComplete",
		})
	end)
	NearCompletionGrid.id = "NearCompletionGrid"
	ButtonOutline.id = "ButtonOutline"
	self.__defaultFocus = ButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NearCompletionButton_Internal.__resetProperties = function(f5_arg0)
	f5_arg0.SelectorOverlay:completeAnimation()
	f5_arg0.NearCompletionGrid:completeAnimation()
	f5_arg0.CompletedIcon:completeAnimation()
	f5_arg0.percentText:completeAnimation()
	f5_arg0.CompleteText:completeAnimation()
	f5_arg0.SelectorOverlay:setAlpha(0.01)
	f5_arg0.NearCompletionGrid:setAlpha(0.9)
	f5_arg0.CompletedIcon:setAlpha(0)
	f5_arg0.percentText:setAlpha(0)
	f5_arg0.CompleteText:setAlpha(0)
	f5_arg0.CompleteText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D71FAC557D462BC"))
end
CoD.NearCompletionButton_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.SelectorOverlay:completeAnimation()
			f7_arg0.SelectorOverlay:setAlpha(0.04)
			f7_arg0.clipFinished(f7_arg0.SelectorOverlay)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.SelectorOverlay:beginAnimation(200)
				f8_arg0.SelectorOverlay:setAlpha(0.04)
				f8_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SelectorOverlay:completeAnimation()
			f8_arg0.SelectorOverlay:setAlpha(0.01)
			f8_local0(f8_arg0.SelectorOverlay)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.SelectorOverlay:beginAnimation(200)
				f10_arg0.SelectorOverlay:setAlpha(0.01)
				f10_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.SelectorOverlay:completeAnimation()
			f10_arg0.SelectorOverlay:setAlpha(0.04)
			f10_local0(f10_arg0.SelectorOverlay)
		end,
	},
	AllChallengesComplete = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.NearCompletionGrid:completeAnimation()
			f12_arg0.NearCompletionGrid:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.NearCompletionGrid)
			f12_arg0.CompletedIcon:completeAnimation()
			f12_arg0.CompletedIcon:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.CompletedIcon)
			f12_arg0.percentText:completeAnimation()
			f12_arg0.percentText:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.percentText)
			f12_arg0.CompleteText:completeAnimation()
			f12_arg0.CompleteText:setAlpha(1)
			f12_arg0.CompleteText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D71FAC557D462BC"))
			f12_arg0.clipFinished(f12_arg0.CompleteText)
		end,
	},
}
CoD.NearCompletionButton_Internal.__onClose = function(f13_arg0)
	f13_arg0.NearCompletionGrid:close()
	f13_arg0.percentText:close()
	f13_arg0.ButtonOutline:close()
end

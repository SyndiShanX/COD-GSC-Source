CoD.VoDViewerSkipPrompt = InheritFrom(LUI.UIElement)
CoD.VoDViewerSkipPrompt.__defaultWidth = 1920
CoD.VoDViewerSkipPrompt.__defaultHeight = 1080
CoD.VoDViewerSkipPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VoDViewerSkipPrompt)
	self.id = "VoDViewerSkipPrompt"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local label = LUI.UIText.new(1, 1, -841, -60, 1, 1, -87, -50)
	label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"platform/skip"))
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(4)
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(label)
	self.label = label
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1) and CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable")
			end,
		},
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.ModelUtility.IsGlobalModelValueTrue("cutsceneSkippable")
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4.cutsceneSkippable, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "cutsceneSkippable",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VoDViewerSkipPrompt.__resetProperties = function(f7_arg0)
	f7_arg0.label:completeAnimation()
	f7_arg0.label:setLeftRight(1, 1, -841, -60)
	f7_arg0.label:setTopBottom(1, 1, -87, -50)
	f7_arg0.label:setAlpha(1)
	f7_arg0.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"platform/skip"))
end
CoD.VoDViewerSkipPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.label:completeAnimation()
			f8_arg0.label:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.label)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(1000)
						f12_arg0:setAlpha(0)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(4000)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.label:beginAnimation(1000)
				f9_arg0.label:setAlpha(1)
				f9_arg0.label:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.label:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.label:completeAnimation()
			f9_arg0.label:setAlpha(0)
			f9_local0(f9_arg0.label)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(1000)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(4000)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.label:beginAnimation(1000)
				f13_arg0.label:setAlpha(1)
				f13_arg0.label:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.label:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.label:completeAnimation()
			f13_arg0.label:setLeftRight(1, 1, -826, -45)
			f13_arg0.label:setTopBottom(1, 1, -65, -28)
			f13_arg0.label:setAlpha(0)
			f13_arg0.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_63135E00B961022B"))
			f13_local0(f13_arg0.label)
		end,
	},
}

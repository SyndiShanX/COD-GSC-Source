require("x64:846c5dfd075b628")
require("x64:b79410dc8d1ea84")
CoD.PC_StartMenu_Options_Controls_KeyBind = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_KeyBind.__defaultWidth = 168
CoD.PC_StartMenu_Options_Controls_KeyBind.__defaultHeight = 65
CoD.PC_StartMenu_Options_Controls_KeyBind.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_KeyBind)
	self.id = "PC_StartMenu_Options_Controls_KeyBind"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KeyVisual = CoD.PC_StartMenu_Options_Controls_KeyVisual.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -18.5, 18.5)
	KeyVisual:setRGB(0.76, 0.76, 0.76)
	self:addElement(KeyVisual)
	self.KeyVisual = KeyVisual
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0, 1, 0, 0)
	PCHighlightBorder:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	PCHighlightBorder:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PCHighlightBorder, f3_arg1)
	end)
	local f1_local3 = PCHighlightBorder
	local f1_local4 = PCHighlightBorder.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(PCHighlightBorder, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "Missing",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "IsBinding",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f8_arg1)
	end)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f10_arg2, f10_arg3, f10_arg4)
		if IsElementInState(self, "Disabled") then
			SetElementState(self, self.PCHighlightBorder, controller, "Disabled")
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_KeyBind.__resetProperties = function(f11_arg0)
	f11_arg0.PCHighlightBorder:completeAnimation()
	f11_arg0.KeyVisual:completeAnimation()
	f11_arg0.PCHighlightBorder:setAlpha(1)
	f11_arg0.KeyVisual:setRGB(0.76, 0.76, 0.76)
	f11_arg0.KeyVisual:setAlpha(1)
end
CoD.PC_StartMenu_Options_Controls_KeyBind.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.PCHighlightBorder:completeAnimation()
			f12_arg0.PCHighlightBorder:playClip("DefaultClip")
			f12_arg0.clipFinished(f12_arg0.PCHighlightBorder)
		end,
		Focus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.KeyVisual:completeAnimation()
			f13_arg0.KeyVisual:setRGB(1, 1, 1)
			f13_arg0.clipFinished(f13_arg0.KeyVisual)
			f13_arg0.PCHighlightBorder:completeAnimation()
			f13_arg0.PCHighlightBorder:playClip("cFocus")
			f13_arg0.clipFinished(f13_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.KeyVisual:beginAnimation(150)
				f14_arg0.KeyVisual:setRGB(1, 1, 1)
				f14_arg0.KeyVisual:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.KeyVisual:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.KeyVisual:completeAnimation()
			f14_arg0.KeyVisual:setRGB(0.76, 0.76, 0.76)
			f14_local0(f14_arg0.KeyVisual)
			f14_arg0.PCHighlightBorder:completeAnimation()
			f14_arg0.PCHighlightBorder:playClip("cGainFocus")
			f14_arg0.clipFinished(f14_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			local f16_local0 = function(f17_arg0)
				f16_arg0.KeyVisual:beginAnimation(150)
				f16_arg0.KeyVisual:setRGB(0.76, 0.76, 0.76)
				f16_arg0.KeyVisual:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.KeyVisual:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.KeyVisual:completeAnimation()
			f16_arg0.KeyVisual:setRGB(1, 1, 1)
			f16_local0(f16_arg0.KeyVisual)
			f16_arg0.PCHighlightBorder:completeAnimation()
			f16_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f16_arg0.clipFinished(f16_arg0.PCHighlightBorder)
		end,
	},
	Disabled = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.KeyVisual:completeAnimation()
			f18_arg0.KeyVisual:setAlpha(0.75)
			f18_arg0.clipFinished(f18_arg0.KeyVisual)
			f18_arg0.PCHighlightBorder:completeAnimation()
			f18_arg0.PCHighlightBorder:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.PCHighlightBorder)
		end,
	},
	Missing = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.KeyVisual:completeAnimation()
			f19_arg0.KeyVisual:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f19_arg0.clipFinished(f19_arg0.KeyVisual)
		end,
	},
	IsBinding = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							f24_arg0:beginAnimation(390)
							f24_arg0:setAlpha(0)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
						end
						f23_arg0:beginAnimation(380)
						f23_arg0:setAlpha(1)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(420)
					f22_arg0:setAlpha(0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f20_arg0.KeyVisual:beginAnimation(310)
				f20_arg0.KeyVisual:setAlpha(1)
				f20_arg0.KeyVisual:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.KeyVisual:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.KeyVisual:completeAnimation()
			f20_arg0.KeyVisual:setAlpha(0)
			f20_local0(f20_arg0.KeyVisual)
			f20_arg0.nextClip = "DefaultClip"
		end,
		Focus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						local f28_local0 = function(f29_arg0)
							f29_arg0:beginAnimation(390)
							f29_arg0:setAlpha(0)
							f29_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
						end
						f28_arg0:beginAnimation(380)
						f28_arg0:setAlpha(1)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
					end
					f27_arg0:beginAnimation(420)
					f27_arg0:setAlpha(0)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f25_arg0.KeyVisual:beginAnimation(310)
				f25_arg0.KeyVisual:setAlpha(1)
				f25_arg0.KeyVisual:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.KeyVisual:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.KeyVisual:completeAnimation()
			f25_arg0.KeyVisual:setAlpha(0)
			f25_local0(f25_arg0.KeyVisual)
			f25_arg0.nextClip = "Focus"
		end,
	},
}
CoD.PC_StartMenu_Options_Controls_KeyBind.__onClose = function(f30_arg0)
	f30_arg0.KeyVisual:close()
	f30_arg0.PCHighlightBorder:close()
end

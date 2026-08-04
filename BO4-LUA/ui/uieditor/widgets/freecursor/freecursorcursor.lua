CoD.freeCursorCursor = InheritFrom(LUI.UIElement)
CoD.freeCursorCursor.__defaultWidth = 140
CoD.freeCursorCursor.__defaultHeight = 140
CoD.freeCursorCursor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorCursor)
	self.id = "freeCursorCursor"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local middle_overlay = LUI.UIImage.new(0, 0, 42.5, 98.5, 0, 0, 40, 96)
	middle_overlay:setImage(RegisterImage("uie_ui_menu_cursor_middle_overlay"))
	self:addElement(middle_overlay)
	self.middle_overlay = middle_overlay
	local inner_ring = LUI.UIImage.new(0, 0, 42.5, 98.5, 0, 0, 40, 96)
	inner_ring:setAlpha(0.3)
	inner_ring:setImage(RegisterImage("uie_ui_menu_cursor_inner_ring"))
	self:addElement(inner_ring)
	self.inner_ring = inner_ring
	local innerring = LUI.UIImage.new(0, 0, 42.5, 98.5, 0, 0, 40, 96)
	innerring:setAlpha(0)
	innerring:setImage(RegisterImage("uie_ui_menu_cursor_focus_ring"))
	self:addElement(innerring)
	self.innerring = innerring
	local middle_ring = LUI.UIImage.new(0, 0, 42.5, 98.5, 0, 0, 40, 96)
	middle_ring:setAlpha(0.42)
	middle_ring:setImage(RegisterImage("uie_ui_menu_cursor_middle_ring"))
	self:addElement(middle_ring)
	self.middle_ring = middle_ring
	local outer_ring = LUI.UIImage.new(0, 0, 42.5, 98.5, 0, 0, 40, 96)
	outer_ring:setAlpha(0.4)
	outer_ring:setImage(RegisterImage("uie_ui_menu_cursor_outer_ring"))
	self:addElement(outer_ring)
	self.outer_ring = outer_ring
	local outerring2 = LUI.UIImage.new(0, 0, 42.5, 98.5, 0, 0, 40, 96)
	outerring2:setAlpha(0)
	outerring2:setScale(0.8, 0.8)
	outerring2:setImage(RegisterImage("uie_ui_menu_cursor_outer_ring"))
	self:addElement(outerring2)
	self.outerring2 = outerring2
	local outerring = LUI.UIImage.new(0, 0, 42.5, 98.5, 0, 0, 40, 96)
	outerring:setAlpha(0)
	outerring:setScale(0.8, 0.8)
	outerring:setImage(RegisterImage("uie_ui_menu_cursor_outer_ring"))
	self:addElement(outerring)
	self.outerring = outerring
	self:mergeStateConditions({
		{
			stateName = "UsingMouse",
			condition = function(menu, element, event)
				return IsPC() and IsMouse(f1_arg1)
			end,
		},
		{
			stateName = "HasLockedFocus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasLockedFocus")
			end,
		},
		{
			stateName = "HasFocus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasFocus")
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine.GetModelForController(f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "hasLockedFocus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasLockedFocus",
		})
	end)
	self:linkToElementModel(self, "hasFocus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasFocus",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.freeCursorCursor.__resetProperties = function(f9_arg0)
	f9_arg0.middle_overlay:completeAnimation()
	f9_arg0.outer_ring:completeAnimation()
	f9_arg0.middle_ring:completeAnimation()
	f9_arg0.inner_ring:completeAnimation()
	f9_arg0.innerring:completeAnimation()
	f9_arg0.middle_overlay:setRGB(1, 1, 1)
	f9_arg0.middle_overlay:setAlpha(1)
	f9_arg0.middle_overlay:setScale(1, 1)
	f9_arg0.outer_ring:setRGB(1, 1, 1)
	f9_arg0.outer_ring:setAlpha(0.4)
	f9_arg0.outer_ring:setScale(1, 1)
	f9_arg0.middle_ring:setAlpha(0.42)
	f9_arg0.middle_ring:setScale(1, 1)
	f9_arg0.inner_ring:setAlpha(0.3)
	f9_arg0.inner_ring:setScale(1, 1)
	f9_arg0.innerring:setAlpha(0)
	f9_arg0.innerring:setScale(1, 1)
end
CoD.freeCursorCursor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						f13_arg0:beginAnimation(2000)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
					end
					f12_arg0:beginAnimation(2000)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f10_arg0.middle_overlay:beginAnimation(2000)
				f10_arg0.middle_overlay:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.middle_overlay:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.middle_overlay:completeAnimation()
			f10_arg0.middle_overlay:setAlpha(0.05)
			f10_arg0.middle_overlay:setScale(0.66, 0.66)
			f10_local0(f10_arg0.middle_overlay)
			f10_arg0.outer_ring:completeAnimation()
			f10_arg0.outer_ring:setRGB(ColorSet.PartyOther.r, ColorSet.PartyOther.g, ColorSet.PartyOther.b)
			f10_arg0.outer_ring:setAlpha(1)
			f10_arg0.outer_ring:setScale(1, 1)
			f10_arg0.clipFinished(f10_arg0.outer_ring)
			f10_arg0.nextClip = "DefaultClip"
		end,
		HasFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			local f14_local0 = function(f15_arg0)
				f14_arg0.middle_overlay:beginAnimation(200)
				f14_arg0.middle_overlay:setRGB(0, 0, 0)
				f14_arg0.middle_overlay:setAlpha(1)
				f14_arg0.middle_overlay:setScale(0.59, 0.59)
				f14_arg0.middle_overlay:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.middle_overlay:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.middle_overlay:completeAnimation()
			f14_arg0.middle_overlay:setRGB(1, 1, 1)
			f14_arg0.middle_overlay:setAlpha(0.05)
			f14_arg0.middle_overlay:setScale(0.66, 0.66)
			f14_local0(f14_arg0.middle_overlay)
			local f14_local1 = function(f16_arg0)
				f16_arg0:beginAnimation(150)
				f16_arg0:setAlpha(0)
				f16_arg0:setScale(0.8, 0.8)
				f16_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.inner_ring:beginAnimation(50)
			f14_arg0.inner_ring:setAlpha(0.3)
			f14_arg0.inner_ring:setScale(1, 1)
			f14_arg0.inner_ring:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
			f14_arg0.inner_ring:registerEventHandler("transition_complete_keyframe", f14_local1)
			local f14_local2 = function(f17_arg0)
				f17_arg0:beginAnimation(150)
				f17_arg0:setAlpha(1)
				f17_arg0:setScale(0.8, 0.8)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.innerring:beginAnimation(50)
			f14_arg0.innerring:setAlpha(0)
			f14_arg0.innerring:setScale(1, 1)
			f14_arg0.innerring:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
			f14_arg0.innerring:registerEventHandler("transition_complete_keyframe", f14_local2)
			local f14_local3 = function(f18_arg0)
				f14_arg0.middle_ring:beginAnimation(200)
				f14_arg0.middle_ring:setAlpha(0)
				f14_arg0.middle_ring:setScale(0.7, 0.7)
				f14_arg0.middle_ring:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.middle_ring:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.middle_ring:completeAnimation()
			f14_arg0.middle_ring:setAlpha(0.35)
			f14_arg0.middle_ring:setScale(1, 1)
			f14_local3(f14_arg0.middle_ring)
			local f14_local4 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(150)
					f20_arg0:setAlpha(0)
					f20_arg0:setScale(0.8, 0.8)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.outer_ring:beginAnimation(50)
				f14_arg0.outer_ring:setAlpha(0.3)
				f14_arg0.outer_ring:setScale(0.81, 0.81)
				f14_arg0.outer_ring:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.outer_ring:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f14_arg0.outer_ring:completeAnimation()
			f14_arg0.outer_ring:setAlpha(0.4)
			f14_arg0.outer_ring:setScale(1, 1)
			f14_local4(f14_arg0.outer_ring)
		end,
	},
	UsingMouse = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	HasLockedFocus = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.middle_overlay:completeAnimation()
			f22_arg0.middle_overlay:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.middle_overlay)
			f22_arg0.inner_ring:completeAnimation()
			f22_arg0.inner_ring:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.inner_ring)
			f22_arg0.middle_ring:completeAnimation()
			f22_arg0.middle_ring:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.middle_ring)
			f22_arg0.outer_ring:completeAnimation()
			f22_arg0.outer_ring:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.outer_ring)
		end,
	},
	HasFocus = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			f23_arg0.middle_overlay:completeAnimation()
			f23_arg0.middle_overlay:setRGB(0, 0, 0)
			f23_arg0.middle_overlay:setAlpha(0.5)
			f23_arg0.middle_overlay:setScale(0.7, 0.7)
			f23_arg0.clipFinished(f23_arg0.middle_overlay)
			f23_arg0.inner_ring:completeAnimation()
			f23_arg0.inner_ring:setAlpha(0)
			f23_arg0.inner_ring:setScale(0.8, 0.8)
			f23_arg0.clipFinished(f23_arg0.inner_ring)
			f23_arg0.innerring:completeAnimation()
			f23_arg0.innerring:setAlpha(1)
			f23_arg0.innerring:setScale(0.8, 0.8)
			f23_arg0.clipFinished(f23_arg0.innerring)
			f23_arg0.middle_ring:completeAnimation()
			f23_arg0.middle_ring:setAlpha(0)
			f23_arg0.middle_ring:setScale(0.8, 0.8)
			f23_arg0.clipFinished(f23_arg0.middle_ring)
			f23_arg0.outer_ring:completeAnimation()
			f23_arg0.outer_ring:setRGB(1, 1, 1)
			f23_arg0.outer_ring:setAlpha(0)
			f23_arg0.outer_ring:setScale(0.8, 0.8)
			f23_arg0.clipFinished(f23_arg0.outer_ring)
			f23_arg0.nextClip = "DefaultClip"
		end,
		DefaultState = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(5)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f26_arg0:setScale(0.66, 0.66)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.middle_overlay:beginAnimation(150)
				f24_arg0.middle_overlay:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.middle_overlay:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.middle_overlay:completeAnimation()
			f24_arg0.middle_overlay:setAlpha(0.05)
			f24_arg0.middle_overlay:setScale(0.61, 0.61)
			f24_local0(f24_arg0.middle_overlay)
			local f24_local1 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f28_arg0:setAlpha(0.3)
					f28_arg0:setScale(1, 1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.inner_ring:beginAnimation(150)
				f24_arg0.inner_ring:setAlpha(0.45)
				f24_arg0.inner_ring:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.inner_ring:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f24_arg0.inner_ring:completeAnimation()
			f24_arg0.inner_ring:setAlpha(0.6)
			f24_arg0.inner_ring:setScale(0.92, 0.92)
			f24_local1(f24_arg0.inner_ring)
			local f24_local2 = function(f29_arg0)
				f24_arg0.innerring:beginAnimation(300)
				f24_arg0.innerring:setAlpha(0)
				f24_arg0.innerring:setScale(1, 1)
				f24_arg0.innerring:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.innerring:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.innerring:completeAnimation()
			f24_arg0.innerring:setAlpha(1)
			f24_arg0.innerring:setScale(0.8, 0.8)
			f24_local2(f24_arg0.innerring)
			local f24_local3 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f31_arg0:setAlpha(0.7)
					f31_arg0:setScale(1, 1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.middle_ring:beginAnimation(100)
				f24_arg0.middle_ring:setAlpha(0.28)
				f24_arg0.middle_ring:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.middle_ring:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f24_arg0.middle_ring:completeAnimation()
			f24_arg0.middle_ring:setAlpha(0)
			f24_arg0.middle_ring:setScale(0.87, 0.87)
			f24_local3(f24_arg0.middle_ring)
			local f24_local4 = function(f32_arg0)
				f24_arg0.outer_ring:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_out"])
				f24_arg0.outer_ring:setAlpha(0.4)
				f24_arg0.outer_ring:setScale(1, 1)
				f24_arg0.outer_ring:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.outer_ring:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.outer_ring:completeAnimation()
			f24_arg0.outer_ring:setAlpha(0.75)
			f24_arg0.outer_ring:setScale(0.9, 0.9)
			f24_local4(f24_arg0.outer_ring)
		end,
	},
}

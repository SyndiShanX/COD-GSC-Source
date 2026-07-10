CoD.CodCasterSupportButton = InheritFrom(LUI.UIElement)
CoD.CodCasterSupportButton.__defaultWidth = 40
CoD.CodCasterSupportButton.__defaultHeight = 24
CoD.CodCasterSupportButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterSupportButton)
	self.id = "CodCasterSupportButton"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -12, 12)
	bg:setImage(RegisterImage(@"hash_465F179D38251C83"))
	self:addElement(bg)
	self.bg = bg
	local blur = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -12, 12)
	blur:setImage(RegisterImage(@"hash_32FF86414B30BA29"))
	self:addElement(blur)
	self.blur = blur
	local scorestreakicon = LUI.UIImage.new(0.51, 0.51, -20, 20, 0.5, 0.5, -12, 12)
	scorestreakicon:setRGB(0, 0, 0)
	scorestreakicon:setAlpha(0.05)
	scorestreakicon:setImage(RegisterImage(@"hash_476182927422079D"))
	self:addElement(scorestreakicon)
	self.scorestreakicon = scorestreakicon
	self:mergeStateConditions({
		{
			stateName = "Usable",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "rewardImage")
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "rewardAmmo", 0)
					if f2_local0 then
						f2_local0 = IsGamepad(f1_arg1)
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "UsableKBM",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "rewardImage")
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "rewardAmmo", 0)
					if f3_local0 then
						f3_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f3_local0
			end,
		},
	})
	self:linkToElementModel(self, "rewardImage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardImage",
		})
	end)
	self:linkToElementModel(self, "rewardAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardAmmo",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		DispatchEventToParent(element, "scorestreak_state_update", controller)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterSupportButton.__resetProperties = function(f9_arg0)
	f9_arg0.scorestreakicon:completeAnimation()
	f9_arg0.blur:completeAnimation()
	f9_arg0.scorestreakicon:setLeftRight(0.51, 0.51, -20, 20)
	f9_arg0.scorestreakicon:setTopBottom(0.5, 0.5, -12, 12)
	f9_arg0.scorestreakicon:setRGB(0, 0, 0)
	f9_arg0.scorestreakicon:setAlpha(0.05)
	f9_arg0.blur:setRGB(1, 1, 1)
	f9_arg0.blur:setAlpha(1)
end
CoD.CodCasterSupportButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.scorestreakicon:completeAnimation()
			f10_arg0.scorestreakicon:setLeftRight(0.51, 0.51, -20, 20)
			f10_arg0.scorestreakicon:setTopBottom(0.5, 0.5, -12, 12)
			f10_arg0.clipFinished(f10_arg0.scorestreakicon)
		end,
	},
	Usable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.blur:beginAnimation(230)
				f11_arg0.blur:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.blur:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.blur:completeAnimation()
			f11_arg0.blur:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f11_arg0.blur:setAlpha(1)
			f11_local0(f11_arg0.blur)
			local f11_local1 = function(f13_arg0)
				f11_arg0.scorestreakicon:beginAnimation(230)
				f11_arg0.scorestreakicon:setRGB(1, 1, 1)
				f11_arg0.scorestreakicon:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.scorestreakicon:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.scorestreakicon:completeAnimation()
			f11_arg0.scorestreakicon:setLeftRight(0.51, 0.51, -20, 20)
			f11_arg0.scorestreakicon:setRGB(0, 0, 0)
			f11_arg0.scorestreakicon:setAlpha(1)
			f11_local1(f11_arg0.scorestreakicon)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.blur:beginAnimation(230)
				f14_arg0.blur:setAlpha(1)
				f14_arg0.blur:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.blur:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.blur:completeAnimation()
			f14_arg0.blur:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f14_arg0.blur:setAlpha(0)
			f14_local0(f14_arg0.blur)
			local f14_local1 = function(f16_arg0)
				f14_arg0.scorestreakicon:beginAnimation(230)
				f14_arg0.scorestreakicon:setAlpha(1)
				f14_arg0.scorestreakicon:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.scorestreakicon:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.scorestreakicon:completeAnimation()
			f14_arg0.scorestreakicon:setLeftRight(0.51, 0.51, -20, 20)
			f14_arg0.scorestreakicon:setAlpha(0.5)
			f14_local1(f14_arg0.scorestreakicon)
		end,
	},
	UsableKBM = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				f17_arg0.blur:beginAnimation(230)
				f17_arg0.blur:setAlpha(1)
				f17_arg0.blur:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.blur:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.blur:completeAnimation()
			f17_arg0.blur:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f17_arg0.blur:setAlpha(0)
			f17_local0(f17_arg0.blur)
			local f17_local1 = function(f19_arg0)
				f17_arg0.scorestreakicon:beginAnimation(230)
				f17_arg0.scorestreakicon:setRGB(1, 1, 1)
				f17_arg0.scorestreakicon:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.scorestreakicon:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.scorestreakicon:completeAnimation()
			f17_arg0.scorestreakicon:setLeftRight(0.51, 0.51, -20, 20)
			f17_arg0.scorestreakicon:setRGB(0, 0, 0)
			f17_arg0.scorestreakicon:setAlpha(1)
			f17_local1(f17_arg0.scorestreakicon)
		end,
	},
}

CoD.freeCursorCautionInfo = InheritFrom(LUI.UIElement)
CoD.freeCursorCautionInfo.__defaultWidth = 405
CoD.freeCursorCautionInfo.__defaultHeight = 100
CoD.freeCursorCautionInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorCautionInfo)
	self.id = "freeCursorCautionInfo"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0.97, 0.92, 0.1)
	background:setAlpha(0.9)
	self:addElement(background)
	self.background = background
	local cautionText = LUI.UIText.new(0, 0, 20, 400, 0, 0, 0, 18)
	cautionText:setRGB(0.29, 0.3, 0.31)
	cautionText:setTTF("ttmussels_demibold")
	cautionText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	cautionText:setLineSpacing(4)
	cautionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	cautionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	cautionText:linkToElementModel(self, "cautionDescription", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			cautionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(cautionText, "setText", function(element, controller)
		if IsTextEmpty(element) then
			CollapseFreeCursorElement(self)
		elseif not IsTextEmpty(element) and CoD.ModelUtility.AreButtonModelValueBitsSet(f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], Enum[@"luibuttonflags"][@"flag_down"]) then
			UpdateWidgetHeightToMultilineText(self, self.cautionText, 2)
		end
	end)
	self:addElement(cautionText)
	self.cautionText = cautionText
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "cautionDescription") and CoD.ModelUtility.AreButtonModelValueBitsSet(f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], Enum[@"luibuttonflags"][@"flag_down"])
			end,
		},
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "cautionDescription") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "detailedViewPC")
			end,
		},
	})
	self:linkToElementModel(self, "cautionDescription", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cautionDescription",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["ButtonBits." .. Enum[@"luibutton"][@"lui_key_rtrig"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
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
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsSelfInState(self, "Visible") then
			UpdateWidgetHeightToMultilineText(self, self.cautionText, 2)
		else
			CollapseFreeCursorElement(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	CoD.FreeCursorUtility.UseLocalHeight(self)
	return self
end
CoD.freeCursorCautionInfo.__resetProperties = function(f10_arg0)
	f10_arg0.background:completeAnimation()
	f10_arg0.cautionText:completeAnimation()
	f10_arg0.background:setLeftRight(0, 1, 0, 0)
	f10_arg0.background:setTopBottom(0, 1, 0, 0)
	f10_arg0.background:setAlpha(0.9)
	f10_arg0.cautionText:setAlpha(1)
end
CoD.freeCursorCautionInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.background:completeAnimation()
			f11_arg0.background:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.background)
			f11_arg0.cautionText:completeAnimation()
			f11_arg0.cautionText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.cautionText)
		end,
		Visible = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(50)
					f14_arg0:setTopBottom(0, 1, 0, 0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.background:beginAnimation(130)
				f12_arg0.background:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.background:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.background:completeAnimation()
			f12_arg0.background:setLeftRight(0, 1, 0, 0)
			f12_arg0.background:setTopBottom(0, 0, 0, 0)
			f12_local0(f12_arg0.background)
			local f12_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(20)
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.cautionText:beginAnimation(130)
				f12_arg0.cautionText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.cautionText:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f12_arg0.cautionText:completeAnimation()
			f12_arg0.cautionText:setAlpha(0)
			f12_local1(f12_arg0.cautionText)
		end,
		VisiblePC = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(50)
					f19_arg0:setTopBottom(0, 1, 0, 0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.background:beginAnimation(130)
				f17_arg0.background:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.background:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.background:completeAnimation()
			f17_arg0.background:setLeftRight(0, 1, 0, 0)
			f17_arg0.background:setTopBottom(0, 0, 0, 0)
			f17_local0(f17_arg0.background)
			local f17_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(20)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.cautionText:beginAnimation(130)
				f17_arg0.cautionText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.cautionText:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f17_arg0.cautionText:completeAnimation()
			f17_arg0.cautionText:setAlpha(0)
			f17_local1(f17_arg0.cautionText)
		end,
	},
	Visible = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.background:completeAnimation()
			f22_arg0.background:setAlpha(0.9)
			f22_arg0.clipFinished(f22_arg0.background)
			f22_arg0.cautionText:completeAnimation()
			f22_arg0.cautionText:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.cautionText)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.background:completeAnimation()
			f23_arg0.background:setAlpha(0.9)
			f23_arg0.clipFinished(f23_arg0.background)
			f23_arg0.cautionText:completeAnimation()
			f23_arg0.cautionText:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.cautionText)
		end,
	},
}
CoD.freeCursorCautionInfo.__onClose = function(f24_arg0)
	f24_arg0.cautionText:close()
end

CoD.freeCursorHeaderLabel = InheritFrom(LUI.UIElement)
CoD.freeCursorHeaderLabel.__defaultWidth = 405
CoD.freeCursorHeaderLabel.__defaultHeight = 36
CoD.freeCursorHeaderLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorHeaderLabel)
	self.id = "freeCursorHeaderLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backingDetailed = LUI.UIImage.new(0, 0, 0, 405, 0, 1, 0, 0)
	backingDetailed:setRGB(0.08, 0.08, 0.08)
	backingDetailed:setAlpha(0)
	backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	backingDetailed:setShaderVector(0, 1, 0, 0, 0)
	backingDetailed:setShaderVector(1, 0, 0, 0, 0)
	backingDetailed:setShaderVector(2, 1, 0, 0, 0)
	backingDetailed:setShaderVector(3, 0, 0, 0, 0)
	backingDetailed:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(backingDetailed)
	self.backingDetailed = backingDetailed
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.08, 0.08, 0.08)
	self:addElement(backing)
	self.backing = backing
	local title = LUI.UIText.new(0, 0, 7, 207, 0, 0, 7, 29)
	title:setRGB(0.86, 0.74, 0.25)
	title:setTTF("ttmussels_regular")
	title:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	title:setLetterSpacing(6)
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	title:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			title:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(title, "setText", function(element, controller)
		if not IsTextEmpty(element) then
			ScaleWidgetToLabel(self, self.title, 5)
			SetContainerWidthToText(self, element, 5)
		end
	end)
	self:addElement(title)
	self.title = title
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipTitleVisible(element, f1_arg1)
			end,
		},
		{
			stateName = "VisibleDetailed",
			condition = function(menu, element, event)
				return AlwaysFalse()
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
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["ButtonBits." .. Enum[@"luibutton"][@"lui_key_rtrig"]], function(f7_arg0)
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
		if IsInDefaultState(self) then
			CollapseFreeCursorElement(self)
			CollapseFreeCursorElementParent(self)
		else
			ExpandFreeCursorElement(self)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.FreeCursorUtility.SetIgnoredByHorizontalLayout(self.backing)
	CoD.FreeCursorUtility.SetIgnoredByHorizontalLayout(self.backingDetailed)
	SetElementProperty(f1_local5, "inCompactView", true)
	return self
end
CoD.freeCursorHeaderLabel.__resetProperties = function(f10_arg0)
	f10_arg0.title:completeAnimation()
	f10_arg0.backing:completeAnimation()
	f10_arg0.backingDetailed:completeAnimation()
	f10_arg0.title:setAlpha(1)
	f10_arg0.backing:setAlpha(1)
	f10_arg0.backingDetailed:setAlpha(0)
	f10_arg0.backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	f10_arg0.backingDetailed:setShaderVector(0, 1, 0, 0, 0)
	f10_arg0.backingDetailed:setShaderVector(1, 0, 0, 0, 0)
	f10_arg0.backingDetailed:setShaderVector(2, 1, 0, 0, 0)
	f10_arg0.backingDetailed:setShaderVector(3, 0, 0, 0, 0)
	f10_arg0.backingDetailed:setShaderVector(4, 0, 0, 0, 0)
end
CoD.freeCursorHeaderLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.backing:completeAnimation()
			f11_arg0.backing:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.backing)
			f11_arg0.title:completeAnimation()
			f11_arg0.title:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.title)
		end,
		VisibleDetailed = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.backingDetailed:beginAnimation(100)
				f12_arg0.backingDetailed:setShaderVector(0, 1, 0, 0, 0)
				f12_arg0.backingDetailed:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.backingDetailed:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.backingDetailed:completeAnimation()
			f12_arg0.backingDetailed:setAlpha(1)
			f12_arg0.backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
			f12_arg0.backingDetailed:setShaderVector(0, 0, 0, 0, 0)
			f12_arg0.backingDetailed:setShaderVector(1, 0, 0, 0, 0)
			f12_arg0.backingDetailed:setShaderVector(2, 1, 0, 0, 0)
			f12_arg0.backingDetailed:setShaderVector(3, 0, 0, 0, 0)
			f12_arg0.backingDetailed:setShaderVector(4, 0, 0, 0, 0)
			f12_local0(f12_arg0.backingDetailed)
			f12_arg0.backing:completeAnimation()
			f12_arg0.backing:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.backing)
			f12_arg0.title:completeAnimation()
			f12_arg0.title:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.title)
		end,
	},
	Visible = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.backing:completeAnimation()
			f14_arg0.backing:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.backing)
			f14_arg0.title:completeAnimation()
			f14_arg0.title:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.title)
		end,
		VisibleDetailed = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f15_arg0.backingDetailed:beginAnimation(100)
				f15_arg0.backingDetailed:setShaderVector(0, 1, 0, 0, 0)
				f15_arg0.backingDetailed:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.backingDetailed:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.backingDetailed:completeAnimation()
			f15_arg0.backingDetailed:setAlpha(1)
			f15_arg0.backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
			f15_arg0.backingDetailed:setShaderVector(0, 0, 0, 0, 0)
			f15_arg0.backingDetailed:setShaderVector(1, 0, 0, 0, 0)
			f15_arg0.backingDetailed:setShaderVector(2, 1, 0, 0, 0)
			f15_arg0.backingDetailed:setShaderVector(3, 0, 0, 0, 0)
			f15_arg0.backingDetailed:setShaderVector(4, 0, 0, 0, 0)
			f15_local0(f15_arg0.backingDetailed)
			f15_arg0.backing:completeAnimation()
			f15_arg0.backing:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.backing)
			f15_arg0.title:completeAnimation()
			f15_arg0.title:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.title)
		end,
	},
	VisibleDetailed = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.backingDetailed:completeAnimation()
			f17_arg0.backingDetailed:setAlpha(1)
			f17_arg0.backingDetailed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
			f17_arg0.backingDetailed:setShaderVector(0, 1, 0, 0, 0)
			f17_arg0.backingDetailed:setShaderVector(1, 0, 0, 0, 0)
			f17_arg0.backingDetailed:setShaderVector(2, 1, 0, 0, 0)
			f17_arg0.backingDetailed:setShaderVector(3, 0, 0, 0, 0)
			f17_arg0.backingDetailed:setShaderVector(4, 0, 0, 0, 0)
			f17_arg0.clipFinished(f17_arg0.backingDetailed)
			f17_arg0.backing:completeAnimation()
			f17_arg0.backing:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.backing)
			f17_arg0.title:completeAnimation()
			f17_arg0.title:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.title)
		end,
	},
}
CoD.freeCursorHeaderLabel.__onClose = function(f18_arg0)
	f18_arg0.backingDetailed:close()
	f18_arg0.backing:close()
	f18_arg0.title:close()
end

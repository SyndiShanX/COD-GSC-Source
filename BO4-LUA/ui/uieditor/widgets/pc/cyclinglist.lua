require("x64:2675595fa323085")
require("x64:ec2c7fb5a455c0a")
require("x64:1ba14a6a952408f")
CoD.CyclingList = InheritFrom(LUI.UIElement)
CoD.CyclingList.__defaultWidth = 810
CoD.CyclingList.__defaultHeight = 65
CoD.CyclingList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CyclingList)
	self.id = "CyclingList"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListItem = CoD.ListItem.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 65)
	ListItem:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
	})
	ListItem:linkToElementModel(ListItem, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(ListItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	ListItem:linkToElementModel(self, nil, false, function(model)
		ListItem:setModel(model, f1_arg1)
	end)
	ListItem:linkToElementModel(self, "name", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ListItem.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(ListItem)
	self.ListItem = ListItem
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 40, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local CyclingList = CoD.CyclingList_ItemControl.new(f1_arg0, f1_arg1, 1, 1, -348, 0, 0, 1, 0, 0)
	CyclingList:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "ArrowsHidden",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.ShouldHideArrows(self, f1_arg1, event)
			end,
		},
		{
			stateName = "LeftArrowHidden",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.ShouldHideLeftArrow(self, f1_arg1, event)
			end,
		},
		{
			stateName = "RightArrowHidden",
			condition = function(menu, element, event)
				return CoD.PCWidgetUtility.ShouldHideRightArrow(self, f1_arg1, event)
			end,
		},
	})
	CyclingList:linkToElementModel(CyclingList, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(CyclingList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	CyclingList:linkToElementModel(CyclingList, "currentValue", true, function(model)
		f1_arg0:updateElementState(CyclingList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "currentValue",
		})
	end)
	CyclingList:linkToElementModel(self, nil, false, function(model)
		CyclingList:setModel(model, f1_arg1)
	end)
	CyclingList:linkToElementModel(self, "currentValue", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			CyclingList.TextBox:setText(CoD.BaseUtility.LocalizeIfXHash(CoD.PCWidgetUtility.OptionValueToOptionName(self, f13_local0)))
		end
	end)
	self:addElement(CyclingList)
	self.CyclingList = CyclingList
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsUnavailable(self, f1_arg1)
			end,
		},
		{
			stateName = "FadedOut",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CoD.PCWidgetUtility.PrepareCyclingList(self, f1_arg1, f1_arg0, controller, self.CyclingList)
	end)
	self:linkToElementModel(self, "currentValue", true, function(model)
		local f18_local0 = self
		CoD.PCUtility.CallValueUpdateIfExist(self, f1_arg1)
	end)
	self:linkToElementModel(self, "refreshWidget", true, function(model)
		local f19_local0 = self
		CoD.PCWidgetUtility.UpdateOptionList(self, f1_arg1, true)
	end)
	emptyFocusable.id = "emptyFocusable"
	CyclingList.id = "CyclingList"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CyclingList.__resetProperties = function(f20_arg0)
	f20_arg0.ListItem:completeAnimation()
	f20_arg0.CyclingList:completeAnimation()
	f20_arg0.ListItem:setAlpha(1)
	f20_arg0.CyclingList:setAlpha(1)
	f20_arg0.CyclingList.right.Image:setRGB(0.58, 0.58, 0.58)
	f20_arg0.CyclingList.left.Image:setRGB(0.58, 0.58, 0.58)
end
CoD.CyclingList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.ListItem:completeAnimation()
			f21_arg0.ListItem:playClip("DefaultClip")
			f21_arg0.clipFinished(f21_arg0.ListItem)
		end,
		Active = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.ListItem:completeAnimation()
			f22_arg0.ListItem:playClip("cActive")
			f22_arg0.clipFinished(f22_arg0.ListItem)
			f22_arg0.CyclingList:completeAnimation()
			f22_arg0.CyclingList.right.Image:completeAnimation()
			f22_arg0.CyclingList.left.Image:completeAnimation()
			f22_arg0.CyclingList.right.Image:setRGB(1, 1, 1)
			f22_arg0.CyclingList.left.Image:setRGB(1, 1, 1)
			f22_arg0.clipFinished(f22_arg0.CyclingList)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.ListItem:completeAnimation()
			f23_arg0.ListItem:playClip("cFocus")
			f23_arg0.clipFinished(f23_arg0.ListItem)
			f23_arg0.CyclingList:completeAnimation()
			f23_arg0.CyclingList.right.Image:completeAnimation()
			f23_arg0.CyclingList.left.Image:completeAnimation()
			f23_arg0.CyclingList.right.Image:setRGB(0.81, 0.81, 0.81)
			f23_arg0.CyclingList.left.Image:setRGB(0.81, 0.81, 0.81)
			f23_arg0.clipFinished(f23_arg0.CyclingList)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.ListItem:playClip("cGainFocus")
				f24_arg0.ListItem:beginAnimation(150)
				f24_arg0.ListItem:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f24_arg0.clipFinished(element, event)
				end)
			end
			f24_arg0.ListItem:completeAnimation()
			f24_arg0.ListItem:setAlpha(1)
			f24_local0(f24_arg0.ListItem)
			local f24_local1 = function(f27_arg0)
				f24_arg0.CyclingList:beginAnimation(150)
				f24_arg0.CyclingList.right.Image:beginAnimation(150)
				f24_arg0.CyclingList.left.Image:beginAnimation(150)
				f24_arg0.CyclingList.right.Image:setRGB(0.81, 0.81, 0.81)
				f24_arg0.CyclingList.left.Image:setRGB(0.81, 0.81, 0.81)
				f24_arg0.CyclingList:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CyclingList:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.CyclingList:completeAnimation()
			f24_arg0.CyclingList.right.Image:completeAnimation()
			f24_arg0.CyclingList.left.Image:completeAnimation()
			f24_arg0.CyclingList.right.Image:setRGB(0.58, 0.58, 0.58)
			f24_arg0.CyclingList.left.Image:setRGB(0.58, 0.58, 0.58)
			f24_local1(f24_arg0.CyclingList)
		end,
		LoseChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			local f28_local0 = function(f29_arg0)
				f28_arg0.ListItem:playClip("cLoseFocus")
				f28_arg0.ListItem:beginAnimation(150)
				f28_arg0.ListItem:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f28_arg0.clipFinished(element, event)
				end)
			end
			f28_arg0.ListItem:completeAnimation()
			f28_arg0.ListItem:setAlpha(1)
			f28_local0(f28_arg0.ListItem)
			local f28_local1 = function(f31_arg0)
				f28_arg0.CyclingList:beginAnimation(150)
				f28_arg0.CyclingList.right.Image:beginAnimation(150)
				f28_arg0.CyclingList.left.Image:beginAnimation(150)
				f28_arg0.CyclingList.right.Image:setRGB(0.58, 0.58, 0.58)
				f28_arg0.CyclingList.left.Image:setRGB(0.58, 0.58, 0.58)
				f28_arg0.CyclingList:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.CyclingList:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.CyclingList:completeAnimation()
			f28_arg0.CyclingList.right.Image:completeAnimation()
			f28_arg0.CyclingList.left.Image:completeAnimation()
			f28_arg0.CyclingList.right.Image:setRGB(0.81, 0.81, 0.81)
			f28_arg0.CyclingList.left.Image:setRGB(0.81, 0.81, 0.81)
			f28_local1(f28_arg0.CyclingList)
		end,
		ActiveAndChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.ListItem:completeAnimation()
			f32_arg0.ListItem:playClip("cActiveAndFocus")
			f32_arg0.clipFinished(f32_arg0.ListItem)
			f32_arg0.CyclingList:completeAnimation()
			f32_arg0.CyclingList.right.Image:completeAnimation()
			f32_arg0.CyclingList.left.Image:completeAnimation()
			f32_arg0.CyclingList.right.Image:setRGB(1, 1, 1)
			f32_arg0.CyclingList.left.Image:setRGB(1, 1, 1)
			f32_arg0.clipFinished(f32_arg0.CyclingList)
		end,
		GainActiveAndChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.ListItem:completeAnimation()
			f33_arg0.ListItem:playClip("cGainActiveAndFocus")
			f33_arg0.clipFinished(f33_arg0.ListItem)
			local f33_local0 = function(f34_arg0)
				f33_arg0.CyclingList:beginAnimation(150)
				f33_arg0.CyclingList.right.Image:beginAnimation(150)
				f33_arg0.CyclingList.left.Image:beginAnimation(150)
				f33_arg0.CyclingList.right.Image:setRGB(1, 1, 1)
				f33_arg0.CyclingList.left.Image:setRGB(1, 1, 1)
				f33_arg0.CyclingList:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.CyclingList:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.CyclingList:completeAnimation()
			f33_arg0.CyclingList.right.Image:completeAnimation()
			f33_arg0.CyclingList.left.Image:completeAnimation()
			f33_arg0.CyclingList.right.Image:setRGB(0.58, 0.58, 0.58)
			f33_arg0.CyclingList.left.Image:setRGB(0.58, 0.58, 0.58)
			f33_local0(f33_arg0.CyclingList)
		end,
		LoseActiveAndChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.ListItem:completeAnimation()
			f35_arg0.ListItem:playClip("cLoseActiveAndFocus")
			f35_arg0.clipFinished(f35_arg0.ListItem)
			local f35_local0 = function(f36_arg0)
				f35_arg0.CyclingList:beginAnimation(150)
				f35_arg0.CyclingList.right.Image:beginAnimation(150)
				f35_arg0.CyclingList.left.Image:beginAnimation(150)
				f35_arg0.CyclingList.right.Image:setRGB(0.58, 0.58, 0.58)
				f35_arg0.CyclingList.left.Image:setRGB(0.58, 0.58, 0.58)
				f35_arg0.CyclingList:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.CyclingList:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.CyclingList:completeAnimation()
			f35_arg0.CyclingList.right.Image:completeAnimation()
			f35_arg0.CyclingList.left.Image:completeAnimation()
			f35_arg0.CyclingList.right.Image:setRGB(1, 1, 1)
			f35_arg0.CyclingList.left.Image:setRGB(1, 1, 1)
			f35_local0(f35_arg0.CyclingList)
		end,
		ActiveAndChildFocusToActive = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			f37_arg0.ListItem:completeAnimation()
			f37_arg0.ListItem:playClip("cActiveAndFocusToActive")
			f37_arg0.clipFinished(f37_arg0.ListItem)
			f37_arg0.CyclingList:completeAnimation()
			f37_arg0.CyclingList.right.Image:completeAnimation()
			f37_arg0.CyclingList.left.Image:completeAnimation()
			f37_arg0.CyclingList.right.Image:setRGB(1, 1, 1)
			f37_arg0.CyclingList.left.Image:setRGB(1, 1, 1)
			f37_arg0.clipFinished(f37_arg0.CyclingList)
		end,
		ActiveToActiveAndChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.ListItem:completeAnimation()
			f38_arg0.ListItem:playClip("cActiveToActiveAndFocus")
			f38_arg0.clipFinished(f38_arg0.ListItem)
			f38_arg0.CyclingList:completeAnimation()
			f38_arg0.CyclingList.right.Image:completeAnimation()
			f38_arg0.CyclingList.left.Image:completeAnimation()
			f38_arg0.CyclingList.right.Image:setRGB(1, 1, 1)
			f38_arg0.CyclingList.left.Image:setRGB(1, 1, 1)
			f38_arg0.clipFinished(f38_arg0.CyclingList)
		end,
		LoseActive = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.ListItem:completeAnimation()
			f39_arg0.ListItem:playClip("cLoseActive")
			f39_arg0.clipFinished(f39_arg0.ListItem)
			local f39_local0 = function(f40_arg0)
				f39_arg0.CyclingList:beginAnimation(150)
				f39_arg0.CyclingList.right.Image:beginAnimation(150)
				f39_arg0.CyclingList.left.Image:beginAnimation(150)
				f39_arg0.CyclingList.right.Image:setRGB(0.58, 0.58, 0.58)
				f39_arg0.CyclingList.left.Image:setRGB(0.58, 0.58, 0.58)
				f39_arg0.CyclingList:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.CyclingList:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.CyclingList:completeAnimation()
			f39_arg0.CyclingList.right.Image:completeAnimation()
			f39_arg0.CyclingList.left.Image:completeAnimation()
			f39_arg0.CyclingList.right.Image:setRGB(1, 1, 1)
			f39_arg0.CyclingList.left.Image:setRGB(1, 1, 1)
			f39_local0(f39_arg0.CyclingList)
		end,
	},
	Unavailable = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			f41_arg0.ListItem:completeAnimation()
			f41_arg0.ListItem:playClip("dDefault")
			f41_arg0.clipFinished(f41_arg0.ListItem)
			f41_arg0.CyclingList:completeAnimation()
			f41_arg0.CyclingList:setAlpha(0.2)
			f41_arg0.clipFinished(f41_arg0.CyclingList)
		end,
		Active = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.ListItem:completeAnimation()
			f42_arg0.ListItem:playClip("dActive")
			f42_arg0.clipFinished(f42_arg0.ListItem)
			f42_arg0.CyclingList:completeAnimation()
			f42_arg0.CyclingList:setAlpha(0.2)
			f42_arg0.clipFinished(f42_arg0.CyclingList)
		end,
		ChildFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			f43_arg0.ListItem:completeAnimation()
			f43_arg0.ListItem:playClip("dFocus")
			f43_arg0.clipFinished(f43_arg0.ListItem)
			f43_arg0.CyclingList:completeAnimation()
			f43_arg0.CyclingList:setAlpha(0.2)
			f43_arg0.clipFinished(f43_arg0.CyclingList)
		end,
		GainChildFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			local f44_local0 = function(f45_arg0)
				f44_arg0.ListItem:playClip("dGainFocus")
				f44_arg0.ListItem:beginAnimation(150)
				f44_arg0.ListItem:registerEventHandler("interrupted_keyframe", f44_arg0.clipInterrupted)
				f44_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dGainFocus")
					f44_arg0.clipFinished(element, event)
				end)
			end
			f44_arg0.ListItem:completeAnimation()
			f44_arg0.ListItem:setAlpha(1)
			f44_local0(f44_arg0.ListItem)
			f44_arg0.CyclingList:completeAnimation()
			f44_arg0.CyclingList:setAlpha(0.2)
			f44_arg0.clipFinished(f44_arg0.CyclingList)
		end,
		LoseChildFocus = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(2)
			local f47_local0 = function(f48_arg0)
				f47_arg0.ListItem:playClip("dLoseFocus")
				f47_arg0.ListItem:beginAnimation(150)
				f47_arg0.ListItem:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.ListItem:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("dLoseFocus")
					f47_arg0.clipFinished(element, event)
				end)
			end
			f47_arg0.ListItem:completeAnimation()
			f47_arg0.ListItem:setAlpha(1)
			f47_local0(f47_arg0.ListItem)
			f47_arg0.CyclingList:completeAnimation()
			f47_arg0.CyclingList:setAlpha(0.2)
			f47_arg0.clipFinished(f47_arg0.CyclingList)
		end,
		ActiveAndChildFocus = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(2)
			f50_arg0.ListItem:completeAnimation()
			f50_arg0.ListItem:playClip("dActiveAndFocus")
			f50_arg0.clipFinished(f50_arg0.ListItem)
			f50_arg0.CyclingList:completeAnimation()
			f50_arg0.CyclingList:setAlpha(0.2)
			f50_arg0.clipFinished(f50_arg0.CyclingList)
		end,
		GainActiveAndChildFocus = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(2)
			f51_arg0.ListItem:completeAnimation()
			f51_arg0.ListItem:playClip("dGainActiveAndFocus")
			f51_arg0.clipFinished(f51_arg0.ListItem)
			local f51_local0 = function(f52_arg0)
				f51_arg0.CyclingList:beginAnimation(150)
				f51_arg0.CyclingList:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.CyclingList:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.CyclingList:completeAnimation()
			f51_arg0.CyclingList:setAlpha(0.2)
			f51_local0(f51_arg0.CyclingList)
		end,
		LoseActive = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(2)
			f53_arg0.ListItem:completeAnimation()
			f53_arg0.ListItem:playClip("dLoseActive")
			f53_arg0.clipFinished(f53_arg0.ListItem)
			local f53_local0 = function(f54_arg0)
				f53_arg0.CyclingList:beginAnimation(150)
				f53_arg0.CyclingList:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.CyclingList:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
			end
			f53_arg0.CyclingList:completeAnimation()
			f53_arg0.CyclingList:setAlpha(0.2)
			f53_local0(f53_arg0.CyclingList)
		end,
		ActiveAndChildFocusToActive = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(2)
			f55_arg0.ListItem:completeAnimation()
			f55_arg0.ListItem:playClip("dActiveAndFocusToActive")
			f55_arg0.clipFinished(f55_arg0.ListItem)
			f55_arg0.CyclingList:completeAnimation()
			f55_arg0.CyclingList:setAlpha(0.2)
			f55_arg0.clipFinished(f55_arg0.CyclingList)
		end,
		ActiveToActiveAndChildFocus = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(2)
			f56_arg0.ListItem:completeAnimation()
			f56_arg0.ListItem:playClip("dActiveToActiveAndFocus")
			f56_arg0.clipFinished(f56_arg0.ListItem)
			f56_arg0.CyclingList:completeAnimation()
			f56_arg0.CyclingList:setAlpha(0.2)
			f56_arg0.clipFinished(f56_arg0.CyclingList)
		end,
		LoseActiveAndChildFocus = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(2)
			f57_arg0.ListItem:completeAnimation()
			f57_arg0.ListItem:playClip("dLoseActiveAndFocus")
			f57_arg0.clipFinished(f57_arg0.ListItem)
			f57_arg0.CyclingList:completeAnimation()
			f57_arg0.CyclingList:setAlpha(0.2)
			f57_arg0.clipFinished(f57_arg0.CyclingList)
		end,
	},
	FadedOut = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(2)
			f58_arg0.ListItem:completeAnimation()
			f58_arg0.ListItem:setAlpha(0.3)
			f58_arg0.clipFinished(f58_arg0.ListItem)
			f58_arg0.CyclingList:completeAnimation()
			f58_arg0.CyclingList:setAlpha(0.3)
			f58_arg0.clipFinished(f58_arg0.CyclingList)
		end,
	},
}
CoD.CyclingList.__onClose = function(f59_arg0)
	f59_arg0.ListItem:close()
	f59_arg0.emptyFocusable:close()
	f59_arg0.CyclingList:close()
end

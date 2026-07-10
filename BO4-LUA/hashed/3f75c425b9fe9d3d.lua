require("x64:2fb80c67dd95af6")
CoD.CalloutItem = InheritFrom(LUI.UIElement)
CoD.CalloutItem.__defaultWidth = 382
CoD.CalloutItem.__defaultHeight = 382
CoD.CalloutItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CalloutItem)
	self.id = "CalloutItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backingSolid = LUI.UIImage.new(-0.5, 1.5, 0, 0, -0.5, 0.5, -8, -8)
	backingSolid:setRGB(0, 0, 0)
	backingSolid:setAlpha(0.5)
	backingSolid:setMaterial(LUI.UIImage.GetCachedMaterial(0x27EBC307ABF865))
	backingSolid:setShaderVector(0, 0.1, 0.25, 0, 0)
	backingSolid:setShaderVector(2, 0, 0, 0, 0)
	backingSolid:linkToElementModel(self, "angleWidth", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			backingSolid:setShaderVector(1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(backingSolid)
	self.backingSolid = backingSolid
	local backing = LUI.UIImage.new(-0.5, 1.5, 0, 0, -0.5, 0.5, -8, -8)
	backing:setRGB(0, 0, 0)
	backing:setAlpha(0.5)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(0x27EBC307ABF865))
	backing:setShaderVector(0, 0.1, 0.25, 0, 0)
	backing:setShaderVector(2, 0, 0, 0, 0)
	backing:linkToElementModel(self, "angleWidth", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			backing:setShaderVector(1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(backing)
	self.backing = backing
	local Title = CoD.CalloutItemText.new(f1_arg0, f1_arg1, 0.5, 0.5, -91, 91, 0, 0, -122, -96)
	Title:linkToElementModel(self, "zRot", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Title:setZRot(Multiple(-1, f4_local0))
		end
	end)
	Title:linkToElementModel(self, nil, false, function(model)
		Title:setModel(model, f1_arg1)
	end)
	self:addElement(Title)
	self.Title = Title
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "disabled")
			end,
		},
		{
			stateName = "Chosen",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "chosen") and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "RightStick", "SelectedWedge", "index")
			end,
		},
		{
			stateName = "Highlighted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToSelfModelValue(element, f1_arg1, "RightStick", "SelectedWedge", "index")
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:linkToElementModel(self, "chosen", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "chosen",
		})
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.RightStick.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.SelectedWedge, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "SelectedWedge",
		})
	end, false)
	self:linkToElementModel(self, "index", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "index",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CalloutItem.__resetProperties = function(f13_arg0)
	f13_arg0.Title:completeAnimation()
	f13_arg0.backing:completeAnimation()
	f13_arg0.Title:setTopBottom(0, 0, -122, -96)
	f13_arg0.Title:setRGB(1, 1, 1)
	f13_arg0.Title:setAlpha(1)
	f13_arg0.backing:setTopBottom(-0.5, 0.5, -8, -8)
	f13_arg0.backing:setRGB(0, 0, 0)
	f13_arg0.backing:setAlpha(0.5)
	f13_arg0.backing:setScale(1, 1)
end
CoD.CalloutItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Title:completeAnimation()
			f14_arg0.Title:setRGB(0.78, 0.75, 0.62)
			f14_arg0.clipFinished(f14_arg0.Title)
		end,
		Selected = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.backing:beginAnimation(150)
				f15_arg0.backing:setRGB(0.57, 0.42, 0.03)
				f15_arg0.backing:setAlpha(0.6)
				f15_arg0.backing:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.backing:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.backing:completeAnimation()
			f15_arg0.backing:setRGB(0, 0, 0)
			f15_arg0.backing:setAlpha(0.5)
			f15_local0(f15_arg0.backing)
			local f15_local1 = function(f17_arg0)
				f15_arg0.Title:beginAnimation(150)
				f15_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f15_arg0.Title:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Title:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Title:completeAnimation()
			f15_arg0.Title:setRGB(0.78, 0.75, 0.62)
			f15_local1(f15_arg0.Title)
		end,
		Highlighted = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				f18_arg0.backing:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f18_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
				f18_arg0.backing:setRGB(0.57, 0.42, 0.03)
				f18_arg0.backing:setAlpha(1)
				f18_arg0.backing:setScale(1.2, 1.2)
				f18_arg0.backing:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.backing:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.backing:completeAnimation()
			f18_arg0.backing:setTopBottom(-0.5, 0.5, -8, -8)
			f18_arg0.backing:setRGB(0, 0, 0)
			f18_arg0.backing:setAlpha(0.5)
			f18_arg0.backing:setScale(1, 1)
			f18_local0(f18_arg0.backing)
			local f18_local1 = function(f20_arg0)
				f18_arg0.Title:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f18_arg0.Title:setTopBottom(0, 0, -132, -106)
				f18_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f18_arg0.Title:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Title:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Title:completeAnimation()
			f18_arg0.Title:setTopBottom(0, 0, -122, -96)
			f18_arg0.Title:setRGB(0.78, 0.75, 0.62)
			f18_local1(f18_arg0.Title)
		end,
		Chosen = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.backing:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
				f21_arg0.backing:setRGB(0.57, 0.42, 0.03)
				f21_arg0.backing:setAlpha(1)
				f21_arg0.backing:setScale(1.2, 1.2)
				f21_arg0.backing:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.backing:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.backing:completeAnimation()
			f21_arg0.backing:setTopBottom(-0.5, 0.5, -8, -8)
			f21_arg0.backing:setRGB(0, 0, 0)
			f21_arg0.backing:setAlpha(0.5)
			f21_arg0.backing:setScale(1, 1)
			f21_local0(f21_arg0.backing)
			local f21_local1 = function(f23_arg0)
				f21_arg0.Title:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.Title:setTopBottom(0, 0, -132, -106)
				f21_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
				f21_arg0.Title:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Title:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Title:completeAnimation()
			f21_arg0.Title:setTopBottom(0, 0, -122, -96)
			f21_arg0.Title:setRGB(0.78, 0.75, 0.62)
			f21_local1(f21_arg0.Title)
		end,
	},
	Disabled = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.backing:completeAnimation()
			f24_arg0.backing:setRGB(0.15, 0.15, 0.15)
			f24_arg0.clipFinished(f24_arg0.backing)
			f24_arg0.Title:completeAnimation()
			f24_arg0.Title:setRGB(0.78, 0.75, 0.62)
			f24_arg0.clipFinished(f24_arg0.Title)
		end,
	},
	Chosen = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.backing:completeAnimation()
			f25_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
			f25_arg0.backing:setRGB(0.57, 0.42, 0.03)
			f25_arg0.backing:setAlpha(1)
			f25_arg0.backing:setScale(1.2, 1.2)
			f25_arg0.clipFinished(f25_arg0.backing)
			f25_arg0.Title:completeAnimation()
			f25_arg0.Title:setTopBottom(0, 0, -132, -106)
			f25_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f25_arg0.clipFinished(f25_arg0.Title)
		end,
		DefaultState = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(240, Enum[@"luitween"][@"luitween_ease_both"])
					f28_arg0:setTopBottom(-0.5, 0.5, -8, -8)
					f28_arg0:setRGB(0, 0, 0)
					f28_arg0:setAlpha(0.5)
					f28_arg0:setScale(1, 1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.backing:beginAnimation(160)
				f26_arg0.backing:setRGB(0.92, 0.85, 0.67)
				f26_arg0.backing:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.backing:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.backing:completeAnimation()
			f26_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
			f26_arg0.backing:setRGB(0.57, 0.42, 0.03)
			f26_arg0.backing:setAlpha(1)
			f26_arg0.backing:setScale(1.2, 1.2)
			f26_local0(f26_arg0.backing)
			local f26_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(240, Enum[@"luitween"][@"luitween_ease_both"])
					f30_arg0:setTopBottom(0, 0, -122, -96)
					f30_arg0:setRGB(0.78, 0.75, 0.62)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.Title:beginAnimation(160)
				f26_arg0.Title:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Title:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f26_arg0.Title:completeAnimation()
			f26_arg0.Title:setTopBottom(0, 0, -132, -106)
			f26_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f26_arg0.Title:setAlpha(1)
			f26_local1(f26_arg0.Title)
		end,
		Highlighted = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.backing:completeAnimation()
			f31_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
			f31_arg0.backing:setRGB(0.57, 0.42, 0.03)
			f31_arg0.backing:setAlpha(1)
			f31_arg0.backing:setScale(1.2, 1.2)
			f31_arg0.clipFinished(f31_arg0.backing)
			f31_arg0.Title:completeAnimation()
			f31_arg0.Title:setTopBottom(0, 0, -132, -106)
			f31_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f31_arg0.clipFinished(f31_arg0.Title)
		end,
	},
	Highlighted = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.backing:completeAnimation()
			f32_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
			f32_arg0.backing:setRGB(0.57, 0.42, 0.03)
			f32_arg0.backing:setAlpha(1)
			f32_arg0.backing:setScale(1.2, 1.2)
			f32_arg0.clipFinished(f32_arg0.backing)
			f32_arg0.Title:completeAnimation()
			f32_arg0.Title:setTopBottom(0, 0, -132, -106)
			f32_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f32_arg0.clipFinished(f32_arg0.Title)
		end,
		DefaultState = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			local f33_local0 = function(f34_arg0)
				f33_arg0.backing:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f33_arg0.backing:setTopBottom(-0.5, 0.5, -8, -8)
				f33_arg0.backing:setRGB(0, 0, 0)
				f33_arg0.backing:setAlpha(0.5)
				f33_arg0.backing:setScale(1, 1)
				f33_arg0.backing:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.backing:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.backing:completeAnimation()
			f33_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
			f33_arg0.backing:setRGB(0.57, 0.42, 0.03)
			f33_arg0.backing:setAlpha(1)
			f33_arg0.backing:setScale(1.2, 1.2)
			f33_local0(f33_arg0.backing)
			local f33_local1 = function(f35_arg0)
				f33_arg0.Title:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f33_arg0.Title:setTopBottom(0, 0, -122, -96)
				f33_arg0.Title:setRGB(0.78, 0.75, 0.62)
				f33_arg0.Title:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Title:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Title:completeAnimation()
			f33_arg0.Title:setTopBottom(0, 0, -132, -106)
			f33_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f33_local1(f33_arg0.Title)
		end,
		Chosen = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.backing:completeAnimation()
			f36_arg0.backing:setTopBottom(-0.5, 0.5, -45, -45)
			f36_arg0.backing:setRGB(0.57, 0.42, 0.03)
			f36_arg0.backing:setAlpha(1)
			f36_arg0.backing:setScale(1.2, 1.2)
			f36_arg0.clipFinished(f36_arg0.backing)
			f36_arg0.Title:completeAnimation()
			f36_arg0.Title:setTopBottom(0, 0, -132, -106)
			f36_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f36_arg0.clipFinished(f36_arg0.Title)
		end,
	},
}
CoD.CalloutItem.__onClose = function(f37_arg0)
	f37_arg0.backingSolid:close()
	f37_arg0.backing:close()
	f37_arg0.Title:close()
end

require("x64:6ee96f124cfc384")
CoD.SupplyChainDetails_ButtonPromptContainer = InheritFrom(LUI.UIElement)
CoD.SupplyChainDetails_ButtonPromptContainer.__defaultWidth = 300
CoD.SupplyChainDetails_ButtonPromptContainer.__defaultHeight = 39
CoD.SupplyChainDetails_ButtonPromptContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 15, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.SupplyChainDetails_ButtonPromptContainer)
	self.id = "SupplyChainDetails_ButtonPromptContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ToggleOutfitPreview = CoD.SupplyChainDetails_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 100, 0, 0, 0, 39)
	ToggleOutfitPreview:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				local f2_local0 = IsMouseOrKeyboard(f1_arg1)
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allowTogglePreview")
					if f2_local0 then
						f2_local0 = not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCC13B0F8EEFF726)
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "VisibleNag",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allowTogglePreview") and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCC13B0F8EEFF726)
			end,
		},
	})
	ToggleOutfitPreview:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ToggleOutfitPreview, f5_arg1)
	end)
	local PreviewGesture = ToggleOutfitPreview
	local ToggleWeaponPreview = ToggleOutfitPreview.subscribeToModel
	local VideoPreview = Engine[0x4DF5CFBC1771947](f1_arg1)
	ToggleWeaponPreview(PreviewGesture, VideoPreview.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(ToggleOutfitPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ToggleOutfitPreview:linkToElementModel(ToggleOutfitPreview, "allowTogglePreview", true, function(model)
		f1_arg0:updateElementState(ToggleOutfitPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowTogglePreview",
		})
	end)
	ToggleOutfitPreview:linkToElementModel(ToggleOutfitPreview, "itemCategory", true, function(model)
		f1_arg0:updateElementState(ToggleOutfitPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	ToggleOutfitPreview.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_1}]"))
	ToggleOutfitPreview.togglePreviewLabel:setText(Engine[0xF9F1239CFD921FE](0x7C59A6407407976))
	ToggleOutfitPreview:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ToggleOutfitPreview.togglePreviewButton.GpadButtonImage:setImage(RegisterImage(f9_local0))
		end
	end)
	ToggleOutfitPreview:linkToElementModel(self, nil, false, function(model)
		ToggleOutfitPreview:setModel(model, f1_arg1)
	end)
	self:addElement(ToggleOutfitPreview)
	self.ToggleOutfitPreview = ToggleOutfitPreview
	ToggleWeaponPreview = CoD.SupplyChainDetails_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 115, 215, 0, 0, 0, 39)
	ToggleWeaponPreview:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				local f11_local0 = IsMouseOrKeyboard(f1_arg1)
				if f11_local0 then
					f11_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allowTogglePreview")
					if f11_local0 then
						f11_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCC13B0F8EEFF726)
					end
				end
				return f11_local0
			end,
		},
		{
			stateName = "VisibleNag",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allowTogglePreview") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemCategory", 0xCC13B0F8EEFF726)
			end,
		},
	})
	ToggleWeaponPreview:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ToggleWeaponPreview, f14_arg1)
	end)
	VideoPreview = ToggleWeaponPreview
	PreviewGesture = ToggleWeaponPreview.subscribeToModel
	local FrozenMomentPreview = Engine[0x4DF5CFBC1771947](f1_arg1)
	PreviewGesture(VideoPreview, FrozenMomentPreview.LastInput, function(f15_arg0)
		f1_arg0:updateElementState(ToggleWeaponPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ToggleWeaponPreview:linkToElementModel(ToggleWeaponPreview, "allowTogglePreview", true, function(model)
		f1_arg0:updateElementState(ToggleWeaponPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowTogglePreview",
		})
	end)
	ToggleWeaponPreview:linkToElementModel(ToggleWeaponPreview, "itemCategory", true, function(model)
		f1_arg0:updateElementState(ToggleWeaponPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	ToggleWeaponPreview.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_1}]"))
	ToggleWeaponPreview:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			ToggleWeaponPreview.togglePreviewButton.GpadButtonImage:setImage(RegisterImage(f18_local0))
		end
	end)
	ToggleWeaponPreview:linkToElementModel(self, nil, false, function(model)
		ToggleWeaponPreview:setModel(model, f1_arg1)
	end)
	self:addElement(ToggleWeaponPreview)
	self.ToggleWeaponPreview = ToggleWeaponPreview
	PreviewGesture = CoD.SupplyChainDetails_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 230, 330, 0, 0, 0, 39)
	PreviewGesture:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				local f20_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gesture_index", -1) then
					f20_local0 = IsMouseOrKeyboard(f1_arg1)
				else
					f20_local0 = false
				end
				return f20_local0
			end,
		},
		{
			stateName = "VisibleNag",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gesture_index", -1)
			end,
		},
	})
	PreviewGesture:linkToElementModel(PreviewGesture, "gesture_index", true, function(model)
		f1_arg0:updateElementState(PreviewGesture, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gesture_index",
		})
	end)
	PreviewGesture:appendEventHandler("input_source_changed", function(f24_arg0, f24_arg1)
		f24_arg1.menu = f24_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PreviewGesture, f24_arg1)
	end)
	FrozenMomentPreview = PreviewGesture
	VideoPreview = PreviewGesture.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	VideoPreview(FrozenMomentPreview, f1_local6.LastInput, function(f25_arg0)
		f1_arg0:updateElementState(PreviewGesture, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	PreviewGesture.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_2}]"))
	PreviewGesture.togglePreviewLabel:setText(Engine[0xF9F1239CFD921FE](0xDE61F05A2F38605))
	PreviewGesture:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_button_image", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			PreviewGesture.togglePreviewButton.GpadButtonImage:setImage(RegisterImage(f26_local0))
		end
	end)
	PreviewGesture:linkToElementModel(self, nil, false, function(model)
		PreviewGesture:setModel(model, f1_arg1)
	end)
	self:addElement(PreviewGesture)
	self.PreviewGesture = PreviewGesture
	VideoPreview = CoD.SupplyChainDetails_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 345, 445, 0, 0, 0, 39)
	VideoPreview:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "movieName") and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "VisibleNag",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "movieName")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	VideoPreview:linkToElementModel(VideoPreview, "movieName", true, function(model)
		f1_arg0:updateElementState(VideoPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "movieName",
		})
	end)
	VideoPreview:appendEventHandler("input_source_changed", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_arg0
		f1_arg0:updateElementState(VideoPreview, f32_arg1)
	end)
	f1_local6 = VideoPreview
	FrozenMomentPreview = VideoPreview.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	FrozenMomentPreview(f1_local6, f1_local7.LastInput, function(f33_arg0)
		f1_arg0:updateElementState(VideoPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	VideoPreview.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_remove}]"))
	VideoPreview.togglePreviewLabel:setText(Engine[0xF9F1239CFD921FE](0x612B1DD49195D5))
	VideoPreview:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			VideoPreview.togglePreviewButton.GpadButtonImage:setImage(RegisterImage(f34_local0))
		end
	end)
	VideoPreview:linkToElementModel(self, nil, false, function(model)
		VideoPreview:setModel(model, f1_arg1)
	end)
	self:addElement(VideoPreview)
	self.VideoPreview = VideoPreview
	FrozenMomentPreview = CoD.SupplyChainDetails_ButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 460, 560, 0, 0, 0, 39)
	FrozenMomentPreview:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				local f36_local0 = IsMouseOrKeyboard(f1_arg1)
				if f36_local0 then
					f36_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allowFrozenMoment")
					if f36_local0 then
						f36_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "shopPreview")
					end
				end
				return f36_local0
			end,
		},
		{
			stateName = "VisibleNag",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "allowFrozenMoment") and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "shopPreview")
			end,
		},
	})
	FrozenMomentPreview:appendEventHandler("input_source_changed", function(f39_arg0, f39_arg1)
		f39_arg1.menu = f39_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FrozenMomentPreview, f39_arg1)
	end)
	f1_local7 = FrozenMomentPreview
	f1_local6 = FrozenMomentPreview.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local7, f1_local8.LastInput, function(f40_arg0)
		f1_arg0:updateElementState(FrozenMomentPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f40_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	FrozenMomentPreview:linkToElementModel(FrozenMomentPreview, "allowFrozenMoment", true, function(model)
		f1_arg0:updateElementState(FrozenMomentPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "allowFrozenMoment",
		})
	end)
	FrozenMomentPreview:linkToElementModel(FrozenMomentPreview, "shopPreview", true, function(model)
		f1_arg0:updateElementState(FrozenMomentPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "shopPreview",
		})
	end)
	FrozenMomentPreview.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_remove}]"))
	FrozenMomentPreview.togglePreviewLabel:setText(Engine[0xF9F1239CFD921FE](0x23594B6BDE14144))
	FrozenMomentPreview:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f43_local0 = model:get()
		if f43_local0 ~= nil then
			FrozenMomentPreview.togglePreviewButton.GpadButtonImage:setImage(RegisterImage(f43_local0))
		end
	end)
	FrozenMomentPreview:linkToElementModel(self, nil, false, function(model)
		FrozenMomentPreview:setModel(model, f1_arg1)
	end)
	self:addElement(FrozenMomentPreview)
	self.FrozenMomentPreview = FrozenMomentPreview
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainDetails_ButtonPromptContainer.__onClose = function(f45_arg0)
	f45_arg0.ToggleOutfitPreview:close()
	f45_arg0.ToggleWeaponPreview:close()
	f45_arg0.PreviewGesture:close()
	f45_arg0.VideoPreview:close()
	f45_arg0.FrozenMomentPreview:close()
end

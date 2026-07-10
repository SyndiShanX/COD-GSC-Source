require("x64:cc9ca892a619096")
require("x64:262dfb7afe71b40")
require("x64:ec94048bad1fbac")
require("x64:2bf3da84e7ff2d3")
CoD.ItemNameDescUnlockText = InheritFrom(LUI.UIElement)
CoD.ItemNameDescUnlockText.__defaultWidth = 500
CoD.ItemNameDescUnlockText.__defaultHeight = 107
CoD.ItemNameDescUnlockText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemNameDescUnlockText)
	self.id = "ItemNameDescUnlockText"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Name = LUI.UIText.new(0, 0, 0, 505, 0, 0, 44.5, 76.5)
	Name:setRGB(0.92, 0.89, 0.72)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(14)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:linkToElementModel(self, "displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Description = LUI.UIText.new(0, 0, 2, 602, 0, 0, 88.5, 106.5)
	Description:setRGB(0.8, 0.79, 0.78)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local Divider = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 1, 401, 0, 0, 81, 82)
	Divider:setAlpha(0.25)
	self:addElement(Divider)
	self.Divider = Divider
	local UnlockDescription = CoD.onOffText.new(f1_arg0, f1_arg1, 0, 0, 0, 347, 0, 0, -16, 2)
	UnlockDescription:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
	})
	UnlockDescription:linkToElementModel(UnlockDescription, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(UnlockDescription, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	UnlockDescription:setRGB(0.86, 0.86, 0.86)
	UnlockDescription:linkToElementModel(self, nil, false, function(model)
		UnlockDescription:setModel(model, f1_arg1)
	end)
	UnlockDescription:linkToElementModel(self, "itemIndex", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			UnlockDescription.TextBox:setText(CoD.BaseUtility.AlreadyLocalized(CoD.CACUtility.GetUnlockDescription(f1_arg0, f1_arg1, f7_local0)))
		end
	end)
	self:addElement(UnlockDescription)
	self.UnlockDescription = UnlockDescription
	local MastercraftName = CoD.onOffText.new(f1_arg0, f1_arg1, 0, 0, 0, 347, 0, 0, 10, 28)
	MastercraftName:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isMastercraft")
			end,
		},
	})
	MastercraftName:linkToElementModel(MastercraftName, "isMastercraft", true, function(model)
		f1_arg0:updateElementState(MastercraftName, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isMastercraft",
		})
	end)
	MastercraftName:setRGB(0.86, 0.86, 0.86)
	MastercraftName.TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	MastercraftName:linkToElementModel(self, nil, false, function(model)
		MastercraftName:setModel(model, f1_arg1)
	end)
	MastercraftName:linkToElementModel(self, "signatureVariantName", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			MastercraftName.TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f11_local0))
		end
	end)
	self:addElement(MastercraftName)
	self.MastercraftName = MastercraftName
	local ItemInfoPanel = CoD.BM_ItemInfoCompactPanel.new(f1_arg0, f1_arg1, 1, 1, 540, 1080, 0, 0, 44.5, 169.5)
	ItemInfoPanel:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				local f12_local0
				if not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1) then
					f12_local0 = MenuPropertyIsTrue(menu, "_showWeaponVariantList")
					if f12_local0 then
						f12_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "weaponModelSlotIndex", 0)
					end
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
	})
	ItemInfoPanel:linkToElementModel(ItemInfoPanel, nil, false, function(model)
		f1_arg0:updateElementState(ItemInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model and model:get(),
			modelName = nil,
		})
	end)
	ItemInfoPanel:linkToElementModel(ItemInfoPanel, "alertMessage", true, function(model)
		f1_arg0:updateElementState(ItemInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "alertMessage",
		})
	end)
	ItemInfoPanel:linkToElementModel(ItemInfoPanel, "weaponModelSlotIndex", true, function(model)
		f1_arg0:updateElementState(ItemInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponModelSlotIndex",
		})
	end)
	ItemInfoPanel:linkToElementModel(self, "lootData", false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	ItemInfoPanel:subscribeToGlobalModel(f1_arg1, "PerController", "Unlockables.variantListShownUpdate", function(model)
		UpdateSelfElementState(f1_arg0, ItemInfoPanel, f1_arg1)
	end)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	local WeaponPersonalizationTextBreadcrumb = CoD.WeaponPersonalizationTextBreadcrumb.new(f1_arg0, f1_arg1, 0, 0, -2, 348, 0, 0, -61, -16)
	WeaponPersonalizationTextBreadcrumb:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNil(self, f1_arg1, "description")
			end,
		},
		{
			stateName = "ShowText",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
	})
	WeaponPersonalizationTextBreadcrumb:linkToElementModel(WeaponPersonalizationTextBreadcrumb, "description", true, function(model)
		f1_arg0:updateElementState(WeaponPersonalizationTextBreadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "description",
		})
	end)
	WeaponPersonalizationTextBreadcrumb:linkToElementModel(WeaponPersonalizationTextBreadcrumb, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(WeaponPersonalizationTextBreadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	WeaponPersonalizationTextBreadcrumb:linkToElementModel(self, nil, false, function(model)
		WeaponPersonalizationTextBreadcrumb:setModel(model, f1_arg1)
	end)
	WeaponPersonalizationTextBreadcrumb.textCenterAlign.__String_Reference = function(f23_arg0)
		local f23_local0 = f23_arg0:get()
		if f23_local0 ~= nil then
			WeaponPersonalizationTextBreadcrumb.textCenterAlign:setText(CoD.BreadcrumbUtility.UpdateNewBreadcrumbPersonalizationString(self, f1_arg1, f23_local0))
		end
	end
	WeaponPersonalizationTextBreadcrumb:linkToElementModel(self, "itemIndex", true, WeaponPersonalizationTextBreadcrumb.textCenterAlign.__String_Reference)
	WeaponPersonalizationTextBreadcrumb.textCenterAlign.__String_Reference_FullPath = function()
		local f24_local0 = self:getModel()
		if f24_local0 then
			f24_local0 = self:getModel()
			f24_local0 = f24_local0.itemIndex
		end
		if f24_local0 then
			WeaponPersonalizationTextBreadcrumb.textCenterAlign.__String_Reference(f24_local0)
		end
	end
	self:addElement(WeaponPersonalizationTextBreadcrumb)
	self.WeaponPersonalizationTextBreadcrumb = WeaponPersonalizationTextBreadcrumb
	WeaponPersonalizationTextBreadcrumb:linkToElementModel(self, "breadcrumbCount", true, WeaponPersonalizationTextBreadcrumb.textCenterAlign.__String_Reference_FullPath)
	self:linkToElementModel(self, "weaponModelSlotIndex", true, function(model)
		local f25_local0 = self
		UpdateElementState(self, "ItemInfoPanel", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemNameDescUnlockText.__resetProperties = function(f26_arg0)
	f26_arg0.Name:completeAnimation()
	f26_arg0.Description:completeAnimation()
	f26_arg0.UnlockDescription:completeAnimation()
	f26_arg0.Divider:completeAnimation()
	f26_arg0.ItemInfoPanel:completeAnimation()
	f26_arg0.MastercraftName:completeAnimation()
	f26_arg0.WeaponPersonalizationTextBreadcrumb:completeAnimation()
	f26_arg0.Name:setLeftRight(0, 0, 0, 505)
	f26_arg0.Name:setRGB(0.92, 0.89, 0.72)
	f26_arg0.Name:setAlpha(1)
	f26_arg0.Name:setLetterSpacing(14)
	f26_arg0.Description:setLeftRight(0, 0, 2, 602)
	f26_arg0.Description:setAlpha(1)
	f26_arg0.UnlockDescription:setTopBottom(0, 0, -16, 2)
	f26_arg0.UnlockDescription:setAlpha(1)
	f26_arg0.Divider:setAlpha(0.25)
	f26_arg0.ItemInfoPanel:setAlpha(1)
	f26_arg0.MastercraftName:setAlpha(1)
	f26_arg0.WeaponPersonalizationTextBreadcrumb:setAlpha(1)
end
CoD.ItemNameDescUnlockText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
	},
	ZombieCompact = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			f28_arg0.Name:completeAnimation()
			f28_arg0.Name:setLeftRight(0, 0, 0, 425)
			f28_arg0.Name:setRGB(0.58, 0.85, 1)
			f28_arg0.Name:setLetterSpacing(10)
			f28_arg0.Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
			f28_arg0.clipFinished(f28_arg0.Name)
			f28_arg0.Description:completeAnimation()
			f28_arg0.Description:setLeftRight(0, 0, 2, 427)
			f28_arg0.clipFinished(f28_arg0.Description)
			f28_arg0.UnlockDescription:completeAnimation()
			f28_arg0.UnlockDescription:setTopBottom(0, 0, -20, -2)
			f28_arg0.clipFinished(f28_arg0.UnlockDescription)
		end,
	},
	Zombie = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.Name:completeAnimation()
			f29_arg0.Name:setRGB(0.58, 0.85, 1)
			f29_arg0.clipFinished(f29_arg0.Name)
		end,
	},
	NotVisible = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(7)
			f30_arg0.Name:completeAnimation()
			f30_arg0.Name:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Name)
			f30_arg0.Description:completeAnimation()
			f30_arg0.Description:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Description)
			f30_arg0.Divider:completeAnimation()
			f30_arg0.Divider:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Divider)
			f30_arg0.UnlockDescription:completeAnimation()
			f30_arg0.UnlockDescription:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.UnlockDescription)
			f30_arg0.MastercraftName:completeAnimation()
			f30_arg0.MastercraftName:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.MastercraftName)
			f30_arg0.ItemInfoPanel:completeAnimation()
			f30_arg0.ItemInfoPanel:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ItemInfoPanel)
			f30_arg0.WeaponPersonalizationTextBreadcrumb:completeAnimation()
			f30_arg0.WeaponPersonalizationTextBreadcrumb:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.WeaponPersonalizationTextBreadcrumb)
		end,
	},
	WZArmory = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ItemNameDescUnlockText.__onClose = function(f32_arg0)
	f32_arg0.Name:close()
	f32_arg0.Description:close()
	f32_arg0.Divider:close()
	f32_arg0.UnlockDescription:close()
	f32_arg0.MastercraftName:close()
	f32_arg0.ItemInfoPanel:close()
	f32_arg0.WeaponPersonalizationTextBreadcrumb:close()
end

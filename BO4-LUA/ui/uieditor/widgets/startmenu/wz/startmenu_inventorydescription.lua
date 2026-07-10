require("x64:98f1288a89a9af6")
require("x64:6b6b417224e88ee")
require("x64:478f2bd71f935fd")
require("x64:6812bcd114f374e")
CoD.StartMenu_InventoryDescription = InheritFrom(LUI.UIElement)
CoD.StartMenu_InventoryDescription.__defaultWidth = 303
CoD.StartMenu_InventoryDescription.__defaultHeight = 310
CoD.StartMenu_InventoryDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_InventoryDescription)
	self.id = "StartMenu_InventoryDescription"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_arg0, f1_arg1, 0, 0, 0, 316, 0, 0, -48, 326)
	CommonDetailPanel:mergeStateConditions({
		{
			stateName = "HideBottom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name") and CoD.WZUtility.IsQuestItem(element, f1_arg1)
			end,
		},
	})
	CommonDetailPanel:linkToElementModel(CommonDetailPanel, "name", true, function(model)
		f1_arg0:updateElementState(CommonDetailPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	CommonDetailPanel:linkToElementModel(CommonDetailPanel, "type", true, function(model)
		f1_arg0:updateElementState(CommonDetailPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "type",
		})
	end)
	CommonDetailPanel:linkToElementModel(CommonDetailPanel, "unlockableItemRef", true, function(model)
		f1_arg0:updateElementState(CommonDetailPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlockableItemRef",
		})
	end)
	CommonDetailPanel.BackingBlur:setAlpha(0)
	CommonDetailPanel:linkToElementModel(self, nil, false, function(model)
		CommonDetailPanel:setModel(model, f1_arg1)
	end)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local headingBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 46)
	headingBackground:setRGB(0, 0, 0)
	headingBackground:setAlpha(0)
	self:addElement(headingBackground)
	self.headingBackground = headingBackground
	local Box = LUI.UIImage.new(0, 0, 0, 316, 0, 0, 119, 326)
	Box:setRGB(0.07, 0.07, 0.07)
	self:addElement(Box)
	self.Box = Box
	local titleBacking = LUI.UIImage.new(0, 0, 0, 316, 0, 0, -31, 5)
	titleBacking:setRGB(0.29, 0.29, 0.29)
	titleBacking:setAlpha(0)
	self:addElement(titleBacking)
	self.titleBacking = titleBacking
	local title = LUI.UIText.new(0, 0, 13, 280, 0, 0, 87, 114)
	title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(4)
	title:setLineSpacing(-1)
	title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_bottom"]))
	title:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			title:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self:addElement(title)
	self.title = title
	local details = CoD.StartMenu_InventoryDescription_Internal.new(f1_arg0, f1_arg1, 0.03, 1.03, 4, 4, 0, 0, 123, 469)
	details:linkToElementModel(self, nil, false, function(model)
		details:setModel(model, f1_arg1)
	end)
	self:addElement(details)
	self.details = details
	local ItemBase = LUI.UIImage.new(0, 0, 0, 317, 0, 0, -48, 58)
	ItemBase:setAlpha(0)
	self:addElement(ItemBase)
	self.ItemBase = ItemBase
	local count = CoD.WarzoneInventoryCounter.new(f1_arg0, f1_arg1, 1, 1, -31, 9, 0, 0, 30, 70)
	count:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "stackCount", 1) and not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "stackCount", 1)
			end,
		},
	})
	count:linkToElementModel(count, "stackCount", true, function(model)
		f1_arg0:updateElementState(count, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stackCount",
		})
	end)
	count.Counter:setBackingColor(0.07, 0.07, 0.07)
	count:linkToElementModel(self, nil, false, function(model)
		count:setModel(model, f1_arg1)
	end)
	count:linkToElementModel(self, "stackCount", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			count.Counter:setText(f12_local0)
		end
	end)
	self:addElement(count)
	self.count = count
	local icon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -43, 57, 0, 0, -42.5, 57.5)
	icon:linkToElementModel(self, "icon", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			icon:setImage(RegisterImage(f13_local0))
		end
	end)
	self:addElement(icon)
	self.icon = icon
	local IconWeapon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -147.5, 160.5, 0, 0, -33, 46)
	IconWeapon:setAlpha(0)
	IconWeapon:linkToElementModel(self, "icon", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			IconWeapon:setImage(RegisterImage(f14_local0))
		end
	end)
	self:addElement(IconWeapon)
	self.IconWeapon = IconWeapon
	local ArmorIcon = LUI.UIImage.new(0.5, 0.5, -43, 57, 0, 0, -42.5, 57.5)
	ArmorIcon:setAlpha(0)
	ArmorIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_animated"))
	ArmorIcon:setShaderVector(0, 10, 1, 0, 0)
	ArmorIcon.__Frame = function(f15_arg0)
		local f15_local0 = f15_arg0:get()
		if f15_local0 ~= nil then
			ArmorIcon:setShaderVector(1, CoD.WZUtility.GetArmorFlipbookFrame(self:getModel(), f1_arg1, CoD.GetVectorComponentFromString(f15_local0, 1), CoD.GetVectorComponentFromString(f15_local0, 2), CoD.GetVectorComponentFromString(f15_local0, 3), CoD.GetVectorComponentFromString(f15_local0, 4)))
		end
	end
	ArmorIcon:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f16_arg1)
		if f16_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"] then
			f16_arg1:removeSubscription(f16_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"])
			f16_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"] = nil
		end
		if model then
			local f16_local0 = model:get()
			local f16_local1 = model:get()
			model = f16_local0 and f16_local1.armor
		end
		if model then
			f16_arg1["__ArmorIcon.__Frame_predictedClientModel->armor"] = f16_arg1:subscribeToModel(model, ArmorIcon.__Frame)
		end
	end)
	ArmorIcon.__Frame_FullPath = function()
		local f17_local0 = DataSources.PerController.getModel(f1_arg1)
		f17_local0 = f17_local0.predictedClientModel
		if f17_local0 then
			f17_local0 = f17_local0:get()
		end
		if f17_local0 then
			f17_local0 = f17_local0.armor
		end
		if f17_local0 then
			ArmorIcon.__Frame(f17_local0)
		end
	end
	ArmorIcon:linkToElementModel(self, "icon", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			ArmorIcon:setImage(RegisterImage(f18_local0))
		end
	end)
	self:addElement(ArmorIcon)
	self.ArmorIcon = ArmorIcon
	local WarzoneInventoryUnlockMissionObjective = CoD.WarzoneInventoryUnlockMissionObjective.new(f1_arg0, f1_arg1, 0, 0, 4, 320, 0, 0, 124, 244)
	WarzoneInventoryUnlockMissionObjective:setAlpha(0)
	WarzoneInventoryUnlockMissionObjective:linkToElementModel(self, "description", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			WarzoneInventoryUnlockMissionObjective.description:setText(Engine[@"hash_4F9F1239CFD921FE"](f19_local0))
		end
	end)
	WarzoneInventoryUnlockMissionObjective:linkToElementModel(self, "unlockableItemRef", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			WarzoneInventoryUnlockMissionObjective.characterMissionLabel:setText(LocalizeToUpperString(CoD.WZUtility.GetUnlockMissionString(f20_local0)))
		end
	end)
	WarzoneInventoryUnlockMissionObjective:linkToElementModel(self, "unlockableItemRef", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			WarzoneInventoryUnlockMissionObjective.WarzoneInventoryUnlockMissionReward.unlockableIcon:setImage(CoD.BaseUtility.AlreadyRegistered(CoD.WZUtility.GetPreviewImageLargeFromRef(Enum[@"emodes"][@"mode_warzone"], f21_local0)))
		end
	end)
	WarzoneInventoryUnlockMissionObjective:linkToElementModel(self, "quote", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			WarzoneInventoryUnlockMissionObjective.WarzoneInventoryUnlockMissionReward.quote:setText(Engine[@"hash_4F9F1239CFD921FE"](f22_local0))
		end
	end)
	WarzoneInventoryUnlockMissionObjective:linkToElementModel(self, "rewardName", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			WarzoneInventoryUnlockMissionObjective.WarzoneInventoryUnlockMissionReward.rewardName:setText(Engine[@"hash_4F9F1239CFD921FE"](f23_local0))
		end
	end)
	self:addElement(WarzoneInventoryUnlockMissionObjective)
	self.WarzoneInventoryUnlockMissionObjective = WarzoneInventoryUnlockMissionObjective
	local alreadyUnlockedLabel = LUI.UIText.new(0, 0, 286, 486, 0, 0, 135.5, 165.5)
	alreadyUnlockedLabel:setAlpha(0)
	alreadyUnlockedLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1BA819F632BB248A"))
	alreadyUnlockedLabel:setTTF("default")
	alreadyUnlockedLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	alreadyUnlockedLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(alreadyUnlockedLabel)
	self.alreadyUnlockedLabel = alreadyUnlockedLabel
	ArmorIcon:linkToElementModel(self, "armorMax", true, ArmorIcon.__Frame_FullPath)
	self:mergeStateConditions({
		{
			stateName = "CharacterUnlockVisibleWeapon",
			condition = function(menu, element, event)
				local f24_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name")
				if f24_local0 then
					f24_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "type", "weapon")
					if f24_local0 then
						f24_local0 = CoD.WZUtility.IsQuestItem(element, f1_arg1)
					end
				end
				return f24_local0
			end,
		},
		{
			stateName = "CharacterUnlockVisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name") and CoD.WZUtility.IsQuestItem(element, f1_arg1)
			end,
		},
		{
			stateName = "Armor",
			condition = function(menu, element, event)
				local f26_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name")
				if f26_local0 then
					f26_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "type", "armor")
					if f26_local0 then
						f26_local0 = not IsPC()
					end
				end
				return f26_local0
			end,
		},
		{
			stateName = "VisibleWeapon",
			condition = function(menu, element, event)
				local f27_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name")
				if f27_local0 then
					f27_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "type", "weapon")
					if f27_local0 then
						f27_local0 = not IsPC()
					end
				end
				return f27_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "name") and not IsPC()
			end,
		},
		{
			stateName = "HiddenPC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelNil(element, f1_arg1) and IsPC()
			end,
		},
	})
	self:linkToElementModel(self, "name", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "name",
		})
	end)
	self:linkToElementModel(self, "type", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "type",
		})
	end)
	self:linkToElementModel(self, "unlockableItemRef", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlockableItemRef",
		})
	end)
	self:linkToElementModel(self, nil, false, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model and model:get(),
			modelName = nil,
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		UpdateElementDataSource(self, "objectiveList")
		CoD.WZUtility.SetupItemObjectives(f1_arg1, self, f1_arg0)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_InventoryDescription.__resetProperties = function(f35_arg0)
	f35_arg0.title:completeAnimation()
	f35_arg0.headingBackground:completeAnimation()
	f35_arg0.details:completeAnimation()
	f35_arg0.icon:completeAnimation()
	f35_arg0.ItemBase:completeAnimation()
	f35_arg0.count:completeAnimation()
	f35_arg0.CommonDetailPanel:completeAnimation()
	f35_arg0.Box:completeAnimation()
	f35_arg0.IconWeapon:completeAnimation()
	f35_arg0.WarzoneInventoryUnlockMissionObjective:completeAnimation()
	f35_arg0.ArmorIcon:completeAnimation()
	f35_arg0.title:setAlpha(1)
	f35_arg0.headingBackground:setAlpha(0)
	f35_arg0.details:setAlpha(1)
	f35_arg0.icon:setAlpha(1)
	f35_arg0.ItemBase:setAlpha(0)
	f35_arg0.count:setAlpha(1)
	f35_arg0.CommonDetailPanel:setAlpha(1)
	f35_arg0.Box:setAlpha(1)
	f35_arg0.IconWeapon:setAlpha(0)
	f35_arg0.WarzoneInventoryUnlockMissionObjective:setAlpha(0)
	f35_arg0.ArmorIcon:setAlpha(0)
end
CoD.StartMenu_InventoryDescription.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(8)
			f36_arg0.CommonDetailPanel:completeAnimation()
			f36_arg0.CommonDetailPanel:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.CommonDetailPanel)
			f36_arg0.headingBackground:completeAnimation()
			f36_arg0.headingBackground:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.headingBackground)
			f36_arg0.Box:completeAnimation()
			f36_arg0.Box:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Box)
			f36_arg0.title:completeAnimation()
			f36_arg0.title:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.title)
			f36_arg0.details:completeAnimation()
			f36_arg0.details:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.details)
			f36_arg0.ItemBase:completeAnimation()
			f36_arg0.ItemBase:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ItemBase)
			f36_arg0.count:completeAnimation()
			f36_arg0.count:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.count)
			f36_arg0.icon:completeAnimation()
			f36_arg0.icon:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.icon)
		end,
	},
	CharacterUnlockVisibleWeapon = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			f37_arg0.details:completeAnimation()
			f37_arg0.details:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.details)
			f37_arg0.icon:completeAnimation()
			f37_arg0.icon:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.icon)
			f37_arg0.IconWeapon:completeAnimation()
			f37_arg0.IconWeapon:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.IconWeapon)
			f37_arg0.WarzoneInventoryUnlockMissionObjective:completeAnimation()
			f37_arg0.WarzoneInventoryUnlockMissionObjective:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.WarzoneInventoryUnlockMissionObjective)
		end,
	},
	CharacterUnlockVisible = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.details:completeAnimation()
			f38_arg0.details:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.details)
			f38_arg0.WarzoneInventoryUnlockMissionObjective:completeAnimation()
			f38_arg0.WarzoneInventoryUnlockMissionObjective:setAlpha(1)
			f38_arg0.clipFinished(f38_arg0.WarzoneInventoryUnlockMissionObjective)
		end,
	},
	Armor = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.icon:completeAnimation()
			f39_arg0.icon:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.icon)
			f39_arg0.ArmorIcon:completeAnimation()
			f39_arg0.ArmorIcon:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.ArmorIcon)
		end,
	},
	VisibleWeapon = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			f40_arg0.icon:completeAnimation()
			f40_arg0.icon:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.icon)
			f40_arg0.IconWeapon:completeAnimation()
			f40_arg0.IconWeapon:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.IconWeapon)
		end,
	},
	Visible = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenPC = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(8)
			f42_arg0.CommonDetailPanel:completeAnimation()
			f42_arg0.CommonDetailPanel:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.CommonDetailPanel)
			f42_arg0.headingBackground:completeAnimation()
			f42_arg0.headingBackground:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.headingBackground)
			f42_arg0.Box:completeAnimation()
			f42_arg0.Box:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Box)
			f42_arg0.title:completeAnimation()
			f42_arg0.title:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.title)
			f42_arg0.details:completeAnimation()
			f42_arg0.details:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.details)
			f42_arg0.ItemBase:completeAnimation()
			f42_arg0.ItemBase:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ItemBase)
			f42_arg0.count:completeAnimation()
			f42_arg0.count:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.count)
			f42_arg0.icon:completeAnimation()
			f42_arg0.icon:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.icon)
		end,
	},
}
CoD.StartMenu_InventoryDescription.__onClose = function(f43_arg0)
	f43_arg0.CommonDetailPanel:close()
	f43_arg0.title:close()
	f43_arg0.details:close()
	f43_arg0.count:close()
	f43_arg0.icon:close()
	f43_arg0.IconWeapon:close()
	f43_arg0.ArmorIcon:close()
	f43_arg0.WarzoneInventoryUnlockMissionObjective:close()
end

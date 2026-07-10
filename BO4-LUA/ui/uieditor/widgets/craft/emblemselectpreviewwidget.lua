require("x64:fbffc86e9a93477")
require("x64:77520438c104615")
require("x64:c438d75d63d852f")
require("x64:a24b28b508f6914")
require("x64:c7e896ee4bc3f8")
CoD.EmblemSelectPreviewWidget = InheritFrom(LUI.UIElement)
CoD.EmblemSelectPreviewWidget.__defaultWidth = 540
CoD.EmblemSelectPreviewWidget.__defaultHeight = 725
CoD.EmblemSelectPreviewWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemSelectPreviewWidget)
	self.id = "EmblemSelectPreviewWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emblemDrawWidget = CoD.EmblemDrawWidgetPreview.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 13, 503)
	emblemDrawWidget:mergeStateConditions({
		{
			stateName = "Unfocusable",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblem_IsOccupied(element, f1_arg1)
			end,
		},
		{
			stateName = "EmptySlot",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.Emblem_IsOccupied(element, f1_arg1)
			end,
		},
	})
	emblemDrawWidget:linkToElementModel(emblemDrawWidget, "isLoot", true, function(model)
		f1_arg0:updateElementState(emblemDrawWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLoot",
		})
	end)
	emblemDrawWidget:linkToElementModel(emblemDrawWidget, "available", true, function(model)
		f1_arg0:updateElementState(emblemDrawWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	emblemDrawWidget:linkToElementModel(emblemDrawWidget, "emblemIndex", true, function(model)
		f1_arg0:updateElementState(emblemDrawWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "emblemIndex",
		})
	end)
	emblemDrawWidget:linkToElementModel(emblemDrawWidget, "storageFileType", true, function(model)
		f1_arg0:updateElementState(emblemDrawWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "storageFileType",
		})
	end)
	emblemDrawWidget:linkToElementModel(self, nil, false, function(model)
		emblemDrawWidget:setModel(model, f1_arg1)
	end)
	self:addElement(emblemDrawWidget)
	self.emblemDrawWidget = emblemDrawWidget
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 1, 113, 0, 0, -8, 8)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local ItemInfoPanel = CoD.BM_ItemInfoPanel.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 503, 653)
	ItemInfoPanel:mergeStateConditions({
		{
			stateName = "CustomEmblemTabSelected",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsCustomEmblemTabSelected(f1_arg1)
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
	ItemInfoPanel:linkToElementModel(ItemInfoPanel, "description", true, function(model)
		f1_arg0:updateElementState(ItemInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "description",
		})
	end)
	local TrialWidget = ItemInfoPanel
	local SelfIdentityBadge = ItemInfoPanel.subscribeToModel
	local f1_local6 = DataSources.SelectedStorageFileType.getModel(f1_arg1)
	SelfIdentityBadge(TrialWidget, f1_local6.storageFileType, function(f13_arg0)
		f1_arg0:updateElementState(ItemInfoPanel, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "storageFileType",
		})
	end, false)
	ItemInfoPanel:linkToElementModel(self, nil, false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	SelfIdentityBadge = CoD.SelfIdentityBadgePreview.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 698.5, 788.5)
	self:addElement(SelfIdentityBadge)
	self.SelfIdentityBadge = SelfIdentityBadge
	TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -257.5, 257.5, 1, 1, -44, -9)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
	})
	self:linkToElementModel(self, "trialLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	if CoD.isPC then
		emblemDrawWidget.id = "emblemDrawWidget"
	end
	SelfIdentityBadge.id = "SelfIdentityBadge"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemSelectPreviewWidget.__resetProperties = function(f17_arg0)
	f17_arg0.SelfIdentityBadge:completeAnimation()
	f17_arg0.TrialWidget:completeAnimation()
	f17_arg0.SelfIdentityBadge:setAlpha(1)
	f17_arg0.TrialWidget:setAlpha(0)
end
CoD.EmblemSelectPreviewWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.SelfIdentityBadge:completeAnimation()
			f19_arg0.SelfIdentityBadge:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.SelfIdentityBadge)
			f19_arg0.TrialWidget:completeAnimation()
			f19_arg0.TrialWidget:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.TrialWidget)
		end,
	},
}
CoD.EmblemSelectPreviewWidget.__onClose = function(f20_arg0)
	f20_arg0.emblemDrawWidget:close()
	f20_arg0.TabbedScoreboardFuiBox:close()
	f20_arg0.ItemInfoPanel:close()
	f20_arg0.SelfIdentityBadge:close()
	f20_arg0.TrialWidget:close()
end

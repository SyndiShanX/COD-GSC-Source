require("x64:fbffc86e9a93477")
require("x64:79fe6ac43673588")
require("x64:c4873e75b9cce20")
require("x64:2abfd6c268cb91b")
require("x64:38c11a77e96e48c")
CoD.DecalStickerSetFramePaintshop = InheritFrom(LUI.UIElement)
CoD.DecalStickerSetFramePaintshop.__defaultWidth = 1820
CoD.DecalStickerSetFramePaintshop.__defaultHeight = 965
CoD.DecalStickerSetFramePaintshop.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DecalStickerSetFramePaintshop)
	self.id = "DecalStickerSetFramePaintshop"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 1198, 1746, 0.5, 0.5, -415, 415)
	TitleBG:setAlpha(0)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local DecalPreview = CoD.DecalPreview.new(f1_arg0, f1_arg1, 0, 0, 1202, 1742, 0, 0, 71.5, 796.5)
	DecalPreview:setAlpha(0)
	self:addElement(DecalPreview)
	self.DecalPreview = DecalPreview
	local emblemIconList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, true, false, false, false)
	emblemIconList:setLeftRight(0, 0, 66, 1020)
	emblemIconList:setTopBottom(0, 0, 88, 718)
	emblemIconList:setWidgetType(CoD.StickerSetDecal)
	emblemIconList:setHorizontalCount(6)
	emblemIconList:setVerticalCount(4)
	emblemIconList:setSpacing(18)
	emblemIconList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	emblemIconList:setVerticalCounter(CoD.verticalCounter)
	emblemIconList:setDataSource("StickerSetList")
	emblemIconList:appendEventHandler("record_curr_focused_elem_id", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	emblemIconList:linkToElementModel(emblemIconList, "owned", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	emblemIconList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		if not CoD.CraftUtility.IsCraftClassified(element, f1_arg1) then
			CoD.CraftUtility.EmblemChooseIcon_SelectionChanged(self, element, f1_arg1)
			CoD.CraftUtility.EmblemEditor_SetEditMode(f1_arg1)
		end
		return f4_local0
	end)
	emblemIconList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f5_local0 = nil
		CoD.BreadcrumbUtility.SetEmblemStickerIconAsOld(f1_arg0, element, f1_arg1)
		return f5_local0
	end)
	emblemIconList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emblemIconList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsEmblemEditor(controller) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif IsPaintshop(controller) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			CoD.CraftUtility.EmblemChooseIcon_RevertPreviewDecalCamera(self, element, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsEmblemEditor(controller) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsPaintshop(controller) and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(emblemIconList)
	self.emblemIconList = emblemIconList
	local ItemInfoPanel = CoD.BM_ItemInfoPanel.new(f1_arg0, f1_arg1, 1, 1, -618, -78, 1, 1, -230.5, -80.5)
	self:addElement(ItemInfoPanel)
	self.ItemInfoPanel = ItemInfoPanel
	DecalPreview:linkToElementModel(emblemIconList, nil, false, function(model)
		DecalPreview:setModel(model, f1_arg1)
	end)
	ItemInfoPanel:linkToElementModel(emblemIconList, nil, false, function(model)
		ItemInfoPanel:setModel(model, f1_arg1)
	end)
	self:linkToElementModel(self, nil, true, function(model)
		local f11_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.emblemIconList, false, true, true)
	end)
	if CoD.isPC then
		DecalPreview.id = "DecalPreview"
	end
	emblemIconList.id = "emblemIconList"
	self.__defaultFocus = emblemIconList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = emblemIconList
	if IsPC() then
		CoD.GridAndListUtility.SetVerticalScrollbar(f1_local5, "verticalScrollbar")
	end
	return self
end
CoD.DecalStickerSetFramePaintshop.__onClose = function(f12_arg0)
	f12_arg0.DecalPreview:close()
	f12_arg0.ItemInfoPanel:close()
	f12_arg0.TitleBG:close()
	f12_arg0.emblemIconList:close()
end

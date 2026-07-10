require("x64:79fe6ac43673588")
require("x64:c4873e75b9cce20")
require("x64:ced311ffc9ac1de")
require("x64:38c11a77e96e48c")
CoD.DecalListFrame = InheritFrom(LUI.UIElement)
CoD.DecalListFrame.__defaultWidth = 1820
CoD.DecalListFrame.__defaultHeight = 965
CoD.DecalListFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DecalListFrame)
	self.id = "DecalListFrame"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local emblemIconList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, true, false, false, false)
	emblemIconList:setLeftRight(0, 0, 66, 1020)
	emblemIconList:setTopBottom(0, 0, 88, 718)
	emblemIconList:setWidgetType(CoD.EmblemIconNew)
	emblemIconList:setHorizontalCount(6)
	emblemIconList:setVerticalCount(4)
	emblemIconList:setSpacing(18)
	emblemIconList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	emblemIconList:setVerticalCounter(CoD.verticalCounter)
	emblemIconList:setDataSource("EmblemIconList")
	emblemIconList:linkToElementModel(emblemIconList, "owned", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	emblemIconList:appendEventHandler("record_curr_focused_elem_id", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	emblemIconList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		CoD.CraftUtility.EmblemChooseIcon_SelectionChanged(self, element, f1_arg1)
		CoD.CraftUtility.EmblemEditor_SetEditMode(f1_arg1)
		return f4_local0
	end)
	emblemIconList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f5_local0 = nil
		CoD.BreadcrumbUtility.SetDecalStickerIconAsOld(f1_arg0, element, f1_arg1)
		return f5_local0
	end)
	emblemIconList:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emblemIconList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsEmblemEditor(controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif IsPaintshop(controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			CoD.CraftUtility.EmblemChooseIcon_RevertPreviewDecalCamera(self, element, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsEmblemEditor(controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif IsPaintshop(controller) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(emblemIconList)
	self.emblemIconList = emblemIconList
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 1198, 1746, 0.5, 0.5, -415, 415)
	TitleBG:setAlpha(0)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local DecalPreview = CoD.DecalPreview.new(f1_arg0, f1_arg1, 0, 0, 1202, 1742, 0, 0, 71, 796)
	self:addElement(DecalPreview)
	self.DecalPreview = DecalPreview
	DecalPreview:linkToElementModel(emblemIconList, nil, false, function(model)
		DecalPreview:setModel(model, f1_arg1)
	end)
	self:linkToElementModel(self, nil, true, function(model)
		local f10_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.emblemIconList, false, true, true)
		CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.emblemIconList)
	end)
	emblemIconList.id = "emblemIconList"
	if CoD.isPC then
		DecalPreview.id = "DecalPreview"
	end
	self.__defaultFocus = emblemIconList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	f1_local4 = emblemIconList
	if IsPC() then
		CoD.GridAndListUtility.SetVerticalScrollbar(f1_local4, "verticalScrollbar")
		CoD.GridAndListUtility.SetFocusableBackingWidgetOnPC(f1_local4)
	end
	return self
end
CoD.DecalListFrame.__onClose = function(f11_arg0)
	f11_arg0.DecalPreview:close()
	f11_arg0.emblemIconList:close()
	f11_arg0.TitleBG:close()
end

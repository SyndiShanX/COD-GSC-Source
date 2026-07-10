require("x64:79fe6ac43673588")
require("x64:c4873e75b9cce20")
require("x64:959b3179a015708")
require("x64:ced311ffc9ac1de")
require("x64:38c11a77e96e48c")
CoD.DecalToolsFrame = InheritFrom(LUI.UIElement)
CoD.DecalToolsFrame.__defaultWidth = 1820
CoD.DecalToolsFrame.__defaultHeight = 965
CoD.DecalToolsFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DecalToolsFrame)
	self.id = "DecalToolsFrame"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 1198, 1746, 0.5, 0.5, -415, 415)
	TitleBG:setAlpha(0)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local ToolButtonList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, false, false, false, false)
	ToolButtonList:setLeftRight(0, 0, 66, 372)
	ToolButtonList:setTopBottom(0, 0, 88, 880)
	ToolButtonList:setWidgetType(CoD.DecalTypeButton)
	ToolButtonList:setVerticalCount(10)
	ToolButtonList:setSpacing(18)
	ToolButtonList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ToolButtonList:setDataSource("ToolDecalButtons")
	ToolButtonList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		if CoD.CraftUtility.EmblemChooseIcon_IsDecalTypeChanged(self, element, f1_arg1) then
			CoD.CraftUtility.EmblemChooseIcon_DecalTypeChanged(self, element, f1_arg1)
			UpdateElementDataSource(self, "emblemIconList")
		end
		return f2_local0
	end)
	self:addElement(ToolButtonList)
	self.ToolButtonList = ToolButtonList
	local emblemIconList = LUI.UIList.new(f1_arg0, f1_arg1, 18, 0, nil, true, false, false, false)
	emblemIconList:setLeftRight(0, 0, 390, 1020)
	emblemIconList:setTopBottom(0, 0, 88, 718)
	emblemIconList:setWidgetType(CoD.EmblemIconNew)
	emblemIconList:setHorizontalCount(4)
	emblemIconList:setVerticalCount(4)
	emblemIconList:setSpacing(18)
	emblemIconList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	emblemIconList:setVerticalCounter(CoD.verticalCounter)
	emblemIconList:setDataSource("EmblemIconList")
	emblemIconList:linkToElementModel(emblemIconList, "isBMClassified", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	emblemIconList:appendEventHandler("record_curr_focused_elem_id", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	emblemIconList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		if IsElementInState(element, "New") then
			CoD.CraftUtility.EmblemChooseIcon_SelectionChanged(self, element, f1_arg1)
			CoD.CraftUtility.Emblems_SetIconOld(f1_arg0, element, f1_arg1)
			UpdateSelfElementState(f1_arg0, element, f1_arg1)
		else
			CoD.CraftUtility.EmblemChooseIcon_SelectionChanged(self, element, f1_arg1)
			CoD.CraftUtility.EmblemEditor_SetEditMode(f1_arg1)
		end
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
		if IsEmblemEditor(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		elseif IsPaintshop(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.CraftUtility.EmblemChooseIcon_SelectionAccepted(self, element, controller)
			CoD.CraftUtility.EmblemEditor_SetEditMode(controller)
			CoD.CraftUtility.EmblemChooseIcon_RevertPreviewDecalCamera(self, element, controller)
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsEmblemEditor(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsPaintshop(controller) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isBMClassified") and CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "emblemIconList") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(emblemIconList)
	self.emblemIconList = emblemIconList
	local DecalPreview = CoD.DecalPreview.new(f1_arg0, f1_arg1, 0, 0, 1202, 1742, 0, 0, 71, 796)
	self:addElement(DecalPreview)
	self.DecalPreview = DecalPreview
	DecalPreview:linkToElementModel(emblemIconList, nil, false, function(model)
		DecalPreview:setModel(model, f1_arg1)
	end)
	ToolButtonList.id = "ToolButtonList"
	emblemIconList.id = "emblemIconList"
	if CoD.isPC then
		DecalPreview.id = "DecalPreview"
	end
	self.__defaultFocus = ToolButtonList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = emblemIconList
	if IsPC() then
		CoD.GridAndListUtility.SetVerticalScrollbar(f1_local5, "verticalScrollbar")
		CoD.GridAndListUtility.SetFocusableBackingWidgetOnPC(f1_local5)
	end
	return self
end
CoD.DecalToolsFrame.__onClose = function(f10_arg0)
	f10_arg0.DecalPreview:close()
	f10_arg0.TitleBG:close()
	f10_arg0.ToolButtonList:close()
	f10_arg0.emblemIconList:close()
end

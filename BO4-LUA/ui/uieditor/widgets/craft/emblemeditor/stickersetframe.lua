require("x64:89f0409f5c61d6a")
require("x64:2d64ca9d3c705ce")
require("x64:97ab439bf0305bd")
require("x64:2321aa5d656b975")
require("x64:38c11a77e96e48c")
CoD.StickerSetFrame = InheritFrom(LUI.UIElement)
CoD.StickerSetFrame.__defaultWidth = 1920
CoD.StickerSetFrame.__defaultHeight = 1080
CoD.StickerSetFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StickerSetFrame)
	self.id = "StickerSetFrame"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0, 0, 133, 1162, 0, 0, 146, 878)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local emblemListBg2 = LUI.UIImage.new(0, 0, 17.5, 1278.5, 0, 0, 81, 926)
	emblemListBg2:setScale(0.77, 0.77)
	emblemListBg2:setImage(RegisterImage(@"uie_ui_menu_emblem_empty_bg"))
	emblemListBg2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	emblemListBg2:setShaderVector(0, 0, 0, 0, 0)
	emblemListBg2:setupNineSliceShader(212, 212)
	self:addElement(emblemListBg2)
	self.emblemListBg2 = emblemListBg2
	local EmblemSelectPreviewWidget = CoD.EmblemSelectPreviewWidget.new(f1_arg0, f1_arg1, 0, 0, 1220, 1760, 0, 0, 167, 892)
	self:addElement(EmblemSelectPreviewWidget)
	self.EmblemSelectPreviewWidget = EmblemSelectPreviewWidget
	local stickerSetList = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, true, false, false, false)
	stickerSetList:setLeftRight(0, 0, 164, 1131)
	stickerSetList:setTopBottom(0, 0, 180, 821)
	stickerSetList:setWidgetType(CoD.StickerSetItem)
	stickerSetList:setHorizontalCount(6)
	stickerSetList:setVerticalCount(4)
	stickerSetList:setSpacing(11)
	stickerSetList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	stickerSetList:setVerticalCounter(CoD.verticalCounter)
	stickerSetList:setDataSource("StickerSetList")
	local DotLineBottom = stickerSetList
	local DotLineTop = stickerSetList.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	DotLineTop(DotLineBottom, f1_local7["lobbyRoot.lobbyNetworkMode"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	DotLineBottom = stickerSetList
	DotLineTop = stickerSetList.subscribeToModel
	f1_local7 = Engine[@"getglobalmodel"]()
	DotLineTop(DotLineBottom, f1_local7["lobbyRoot.lobbyNav"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	stickerSetList:linkToElementModel(stickerSetList, "isNonClickableEmblem", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	stickerSetList:linkToElementModel(stickerSetList, "trialLocked", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	stickerSetList:linkToElementModel(stickerSetList, "emblemIndex", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	stickerSetList:linkToElementModel(stickerSetList, "storageFileType", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	stickerSetList:linkToElementModel(stickerSetList, "owned", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	stickerSetList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		CoD.CraftUtility.EmblemSelect_GainFocus(self, element, f1_arg1)
		UpdateElementState(self, "emblemDrawWidget", f1_arg1)
		return f9_local0
	end)
	stickerSetList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f10_local0 = nil
		CoD.BreadcrumbUtility.SetEmblemStickerIconAsOld(f1_arg0, element, f1_arg1)
		return f10_local0
	end)
	stickerSetList:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(stickerSetList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsLive() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsElementInState(element, "BMClassified") and CoD.CraftUtility.Emblems_CanEnterEmblemEditor(element, controller) and not CraftItemIsReadOnly(element, controller) and not SelectingGroupEmblem(controller) and CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			OpenEmblemEditor(element, menu, controller, model)
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and not MenuPropertyIsTrue(menu, "_selectGroupEmblem") then
			CoD.CraftUtility.EmblemSelect_SetAsEmblem(self, element, controller)
			UpdateSelfState(self, controller)
			PlaySoundAlias("cac_equipment_add")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and MenuPropertyIsTrue(menu, "_selectGroupEmblem") then
			GoBack(self, controller)
			UpdateSelfState(self, controller)
			PlaySoundAlias("cac_equipment_add")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLive() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not IsElementInState(element, "BMClassified") and CoD.CraftUtility.Emblems_CanEnterEmblemEditor(element, controller) and not CraftItemIsReadOnly(element, controller) and not SelectingGroupEmblem(controller) and CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_71A05463D63F902", nil, "ui_confirm")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") and not MenuPropertyIsTrue(menu, "_selectGroupEmblem") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_A24F9854A60C871", nil, "ui_confirm")
			return true
		elseif CoD.CraftUtility.Emblem_IsOccupied(element, controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "isNonClickableEmblem", 0) and not CoD.CraftUtility.EmblemEditor_IsEditor(self, menu) and CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and MenuPropertyIsTrue(menu, "_selectGroupEmblem") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	stickerSetList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/delete", function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		if CoD.CraftUtility.Emblem_IsOccupied(f14_arg0, f14_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f14_arg0, f14_arg2, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(f14_arg2) and not SelectingGroupEmblem(f14_arg2) then
			return function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
				CoD.CraftUtility.EmblemClear(self, f15_arg0, f15_arg2, "", f15_arg1)
			end
		else
		end
	end)
	stickerSetList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/copy", function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if CoD.CraftUtility.Emblem_IsOccupied(f16_arg0, f16_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f16_arg0, f16_arg2, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(f16_arg2) and not SelectingGroupEmblem(f16_arg2) then
			return function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
				CoD.CraftUtility.EmblemSelect_CopyEmblem(self, f17_arg0, f17_arg2, f17_arg1)
			end
		else
		end
	end)
	stickerSetList:AddContextualMenuAction(f1_arg0, f1_arg1, @"menu/options", function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
		if CoD.CraftUtility.Emblem_IsOccupied(f18_arg0, f18_arg2) and CoD.ModelUtility.IsSelfModelValueEqualTo(f18_arg0, f18_arg2, "isNonClickableEmblem", 0) and not IsPreBuiltEmblemTab(f18_arg2) and not SelectingGroupEmblem(f18_arg2) then
			return function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
				OpenPopup(self, "EmblemSelectOptions", f19_arg2, nil)
			end
		else
		end
	end)
	self:addElement(stickerSetList)
	self.stickerSetList = stickerSetList
	DotLineTop = LUI.UIImage.new(0.5, 0.5, -799.5, 174.5, 0, 0, 161, 165)
	DotLineTop:setAlpha(0.4)
	DotLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineTop:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	DotLineBottom = LUI.UIImage.new(0.5, 0.5, -799.5, 174.5, 0, 0, 859, 863)
	DotLineBottom:setAlpha(0.4)
	DotLineBottom:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineBottom:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	EmblemSelectPreviewWidget:linkToElementModel(stickerSetList, nil, false, function(model)
		EmblemSelectPreviewWidget:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "JP",
			condition = function(menu, element, event)
				return IsJapaneseSku()
			end,
		},
	})
	EmblemSelectPreviewWidget.id = "EmblemSelectPreviewWidget"
	stickerSetList.id = "stickerSetList"
	self.__defaultFocus = stickerSetList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_arg0, f1_arg0, f1_arg1)
	ForceCheckDefaultPCFocus(f1_arg0, f1_arg0, f1_arg1)
	return self
end
CoD.StickerSetFrame.__resetProperties = function(f22_arg0)
	f22_arg0.emblemListBg2:completeAnimation()
	f22_arg0.emblemListBg2:setLeftRight(0, 0, 17.5, 1278.5)
	f22_arg0.emblemListBg2:setTopBottom(0, 0, 81, 926)
end
CoD.StickerSetFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	JP = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.emblemListBg2:completeAnimation()
			f24_arg0.emblemListBg2:setLeftRight(0, 0, 38.5, 1095.5)
			f24_arg0.emblemListBg2:setTopBottom(0, 0, 79, 924)
			f24_arg0.clipFinished(f24_arg0.emblemListBg2)
		end,
	},
}
CoD.StickerSetFrame.__onClose = function(f25_arg0)
	f25_arg0.EmblemSelectPreviewWidget:close()
	f25_arg0.FramingCornerBrackets:close()
	f25_arg0.stickerSetList:close()
end

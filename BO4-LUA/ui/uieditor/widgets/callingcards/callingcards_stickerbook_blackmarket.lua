require("x64:1bc90c00f660da8")
require("x64:6720e107945cf3b")
require("x64:79fe6ac43673588")
require("x64:c438d75d63d852f")
require("x64:38c11a77e96e48c")
CoD.CallingCards_Stickerbook_BlackMarket = InheritFrom(LUI.UIElement)
CoD.CallingCards_Stickerbook_BlackMarket.__defaultWidth = 1725
CoD.CallingCards_Stickerbook_BlackMarket.__defaultHeight = 780
CoD.CallingCards_Stickerbook_BlackMarket.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.evalEquippedCard", 0)
	self:setClass(CoD.CallingCards_Stickerbook_BlackMarket)
	self.id = "CallingCards_Stickerbook_BlackMarket"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CallingCardGrid = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, true, false, false, false)
	CallingCardGrid:setLeftRight(0, 0, 15, 1125)
	CallingCardGrid:setTopBottom(0, 0, 24, 744)
	CallingCardGrid:setWidgetType(CoD.CallingCards_BlackMarket_CardWidget)
	CallingCardGrid:setHorizontalCount(3)
	CallingCardGrid:setVerticalCount(7)
	CallingCardGrid:setSpacing(15)
	CallingCardGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardGrid:setVerticalCounter(CoD.verticalCounter)
	CallingCardGrid:setDataSource("CallingCardsBlackMarket")
	CallingCardGrid:linkToElementModel(CallingCardGrid, "owned", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	CallingCardGrid:registerEventHandler("list_item_lose_focus", function(element, event)
		local f3_local0 = nil
		CoD.BreadcrumbUtility.SetCallingCardsAsOld(f1_arg0, element, f1_arg1)
		return f3_local0
	end)
	CallingCardGrid:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CallingCardGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CallingCards_SetPlayerBackground(menu, element, controller)
			PlaySoundSetSound(self, "action")
			ForceNotifyModel(controller, "hudItems.evalEquippedCard")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CallingCardGrid)
	self.CallingCardGrid = CallingCardGrid
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 1177, 1710, 0, 0, 1, 645)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local CallingCardsBlackMarketProfiler = CoD.CallingCards_BlackMarket_Profiler.new(f1_arg0, f1_arg1, 0, 0, 1181, 1706, 0, 0.79, 20, 20)
	self:addElement(CallingCardsBlackMarketProfiler)
	self.CallingCardsBlackMarketProfiler = CallingCardsBlackMarketProfiler
	local SelfIdentityBadgePreview = CoD.SelfIdentityBadgePreview.new(f1_arg0, f1_arg1, 0, 0, 1181, 1705, 0, 0, 654, 744)
	self:addElement(SelfIdentityBadgePreview)
	self.SelfIdentityBadgePreview = SelfIdentityBadgePreview
	CallingCardsBlackMarketProfiler:linkToElementModel(CallingCardGrid, nil, false, function(model)
		CallingCardsBlackMarketProfiler:setModel(model, f1_arg1)
	end)
	CallingCardGrid.id = "CallingCardGrid"
	CallingCardsBlackMarketProfiler.id = "CallingCardsBlackMarketProfiler"
	SelfIdentityBadgePreview.id = "SelfIdentityBadgePreview"
	self.__defaultFocus = CallingCardGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Stickerbook_BlackMarket.__onClose = function(f8_arg0)
	f8_arg0.CallingCardsBlackMarketProfiler:close()
	f8_arg0.CallingCardGrid:close()
	f8_arg0.TitleBG:close()
	f8_arg0.SelfIdentityBadgePreview:close()
end

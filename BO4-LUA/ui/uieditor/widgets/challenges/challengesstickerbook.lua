require("x64:5e92c71fe0e5747")
require("x64:8efc7e786ceb01e")
require("x64:79fe6ac43673588")
require("x64:7a9db52b8255fe4")
CoD.ChallengesStickerbook = InheritFrom(LUI.UIElement)
CoD.ChallengesStickerbook.__defaultWidth = 1725
CoD.ChallengesStickerbook.__defaultHeight = 780
CoD.ChallengesStickerbook.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
	self:setClass(CoD.ChallengesStickerbook)
	self.id = "ChallengesStickerbook"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local MasterCallingCardWidget = CoD.Challenges_MasterCallingCardWidget.new(f1_arg0, f1_arg1, 0, 0, 15, 1140, 1, 1, -129.5, -29.5)
	MasterCallingCardWidget:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		MasterCallingCardWidget:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(MasterCallingCardWidget, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "CallingCardProfiler")
	end)
	self:addElement(MasterCallingCardWidget)
	self.MasterCallingCardWidget = MasterCallingCardWidget
	local CardGrid = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, true, false, false, false)
	CardGrid:setLeftRight(0, 0, 15, 1135)
	CardGrid:setTopBottom(0, 0, 19, 583)
	CardGrid:setWidgetType(CoD.Challenges_CallingCardWidget)
	CardGrid:setHorizontalCount(3)
	CardGrid:setVerticalCount(4)
	CardGrid:setSpacing(20)
	CardGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CardGrid:setDataSource("ChallengeCards")
	CardGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "CallingCardProfiler")
		return f4_local0
	end)
	self:addElement(CardGrid)
	self.CardGrid = CardGrid
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 0, 1177, 1710, 0, 0, 1, 769)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local CallingCardProfiler = CoD.Challenges_CallingCardProfiler.new(f1_arg0, f1_arg1, 0, 0, 1181, 1706, 0, 0, 20, 750)
	self:addElement(CallingCardProfiler)
	self.CallingCardProfiler = CallingCardProfiler
	CallingCardProfiler:linkToElementModel(CardGrid, nil, false, function(model)
		CallingCardProfiler:setModel(model, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "challengeCategory", function(model)
		local f6_local0 = self
		SetFocusToElement(self, "CardGrid", f1_arg1)
		SetLoseFocusToElement(self, "MasterCallingCardWidget", f1_arg1)
	end)
	MasterCallingCardWidget.id = "MasterCallingCardWidget"
	CardGrid.id = "CardGrid"
	CallingCardProfiler.id = "CallingCardProfiler"
	self.__defaultFocus = CardGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesStickerbook.__onClose = function(f7_arg0)
	f7_arg0.CallingCardProfiler:close()
	f7_arg0.MasterCallingCardWidget:close()
	f7_arg0.CardGrid:close()
	f7_arg0.TitleBG:close()
end

require("x64:8efc7e786ceb01e")
require("x64:79fe6ac43673588")
require("x64:7a9db52b8255fe4")
require("x64:76f82c814686c59")
CoD.ChallengesGlobalStickerbook = InheritFrom(LUI.UIElement)
CoD.ChallengesGlobalStickerbook.__defaultWidth = 1725
CoD.ChallengesGlobalStickerbook.__defaultHeight = 780
CoD.ChallengesGlobalStickerbook.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
	self:setClass(CoD.ChallengesGlobalStickerbook)
	self.id = "ChallengesGlobalStickerbook"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CallingCardGrid = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, true, false, false, false)
	CallingCardGrid:setLeftRight(0.5, 0.5, -847.5, 272.5)
	CallingCardGrid:setTopBottom(0.5, 0.5, -366, 198)
	CallingCardGrid:setWidgetType(CoD.Challenges_CallingCardWidget)
	CallingCardGrid:setHorizontalCount(3)
	CallingCardGrid:setVerticalCount(4)
	CallingCardGrid:setSpacing(20)
	CallingCardGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CallingCardGrid:setDataSource("CallingCardsGlobalChallenges")
	CallingCardGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		SetControllerModelValue(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "Profiler")
		return f2_local0
	end)
	self:addElement(CallingCardGrid)
	self.CallingCardGrid = CallingCardGrid
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0.5, 0.5, 314.5, 847.5, 0.5, 0.5, -389, 379)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local Profiler = CoD.ChallengesCallingCardProfilerGlobal.new(f1_arg0, f1_arg1, 0.5, 0.5, 318.5, 843.5, 0.5, 0.5, -366, 366)
	self:addElement(Profiler)
	self.Profiler = Profiler
	local MasterCallingCardWidget = CoD.Challenges_MasterCallingCardWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -847.5, 277.5, 0.5, 0.5, 260.5, 360.5)
	MasterCallingCardWidget:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		MasterCallingCardWidget:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(MasterCallingCardWidget, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "Profiler")
		SetControllerModelValue(f1_arg1, "hudItems.profilingMasterCallingCard", 1)
	end)
	self:addElement(MasterCallingCardWidget)
	self.MasterCallingCardWidget = MasterCallingCardWidget
	Profiler:linkToElementModel(CallingCardGrid, nil, false, function(model)
		Profiler:setModel(model, f1_arg1)
	end)
	CallingCardGrid.id = "CallingCardGrid"
	Profiler.id = "Profiler"
	MasterCallingCardWidget.id = "MasterCallingCardWidget"
	self.__defaultFocus = CallingCardGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesGlobalStickerbook.__onClose = function(f6_arg0)
	f6_arg0.Profiler:close()
	f6_arg0.CallingCardGrid:close()
	f6_arg0.TitleBG:close()
	f6_arg0.MasterCallingCardWidget:close()
end

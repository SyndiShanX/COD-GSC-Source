require("x64:61939784e7ff184")
require("x64:56fad2ca5ee75b7")
require("x64:ddaa512fdbb7ef6")
CoD.ZMInvQuestItemsContainer = InheritFrom(LUI.UIElement)
CoD.ZMInvQuestItemsContainer.__defaultWidth = 241
CoD.ZMInvQuestItemsContainer.__defaultHeight = 80
CoD.ZMInvQuestItemsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvQuestItemsContainer)
	self.id = "ZMInvQuestItemsContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local BG = CoD.ZMInventoryQuestBackingInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 241, 0, 0, 0, 80)
	BG:setAlpha(0.9)
	self:addElement(BG)
	self.BG = BG
	local Quest = CoD.ZMInvPhasedItemsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -132, 116, 0.5, 0.5, -40, 40)
	Quest.ItemsPhase0:setWidgetType(CoD.ZMInvQuestItem)
	Quest.ItemsPhase0:setDataSource("ZMInventoryQuest1")
	Quest.ItemsPhase1:setWidgetType(CoD.ZMInvQuestItem)
	Quest.ItemsPhase1:setDataSource("ZMInventoryQuest1")
	Quest.ItemsPhase2:setWidgetType(CoD.ZMInvQuestItem)
	Quest.ItemsPhase2:setDataSource("ZMInventoryQuest1")
	Quest.ItemsPhase3:setWidgetType(CoD.ZMInvQuestItem)
	Quest.ItemsPhase3:setDataSource("ZMInventoryQuest1")
	Quest:linkToElementModel(self, nil, false, function(model)
		Quest:setModel(model, f1_arg1)
	end)
	self:addElement(Quest)
	self.Quest = Quest
	Quest.id = "Quest"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInvQuestItemsContainer.__onClose = function(f3_arg0)
	f3_arg0.BG:close()
	f3_arg0.Quest:close()
end

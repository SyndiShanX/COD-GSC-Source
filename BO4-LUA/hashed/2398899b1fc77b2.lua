require("x64:6dc36905fd0797a")
CoD.ZMInvQuests = InheritFrom(LUI.UIElement)
CoD.ZMInvQuests.__defaultWidth = 241
CoD.ZMInvQuests.__defaultHeight = 330
CoD.ZMInvQuests.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ZMInventoryUtility.SetupMapInventoryQuests(self, f1_arg1)
	self:setClass(CoD.ZMInvQuests)
	self.id = "ZMInvQuests"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Quest1 = CoD.ZMInvQuestItemsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -120.5, 120.5, 0.5, 0.5, 99, 179)
	self:addElement(Quest1)
	self.Quest1 = Quest1
	local Quest2 = CoD.ZMInvQuestItemsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -120.5, 120.5, 0.5, 0.5, 11, 91)
	Quest2.Quest.ItemsPhase0:setDataSource("ZMInventoryQuest2")
	Quest2.Quest.ItemsPhase1:setDataSource("ZMInventoryQuest2")
	Quest2.Quest.ItemsPhase2:setDataSource("ZMInventoryQuest2")
	Quest2.Quest.ItemsPhase3:setDataSource("ZMInventoryQuest2")
	self:addElement(Quest2)
	self.Quest2 = Quest2
	local Quest3 = CoD.ZMInvQuestItemsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -120.5, 120.5, 0.5, 0.5, -77, 3)
	Quest3.Quest.ItemsPhase0:setDataSource("ZMInventoryQuest3")
	Quest3.Quest.ItemsPhase1:setDataSource("ZMInventoryQuest3")
	Quest3.Quest.ItemsPhase2:setDataSource("ZMInventoryQuest3")
	Quest3.Quest.ItemsPhase3:setDataSource("ZMInventoryQuest3")
	self:addElement(Quest3)
	self.Quest3 = Quest3
	local Quest4 = CoD.ZMInvQuestItemsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -120.5, 120.5, 0.5, 0.5, -165, -85)
	Quest4.Quest.ItemsPhase0:setDataSource("ZMInventoryQuest4")
	Quest4.Quest.ItemsPhase1:setDataSource("ZMInventoryQuest4")
	Quest4.Quest.ItemsPhase2:setDataSource("ZMInventoryQuest4")
	Quest4.Quest.ItemsPhase3:setDataSource("ZMInventoryQuest4")
	self:addElement(Quest4)
	self.Quest4 = Quest4
	local CornerTop = LUI.UIImage.new(1, 1, -41, 4, 0, 0, -4, 41)
	CornerTop:setImage(RegisterImage(@"uie_zm_hud_inventory_framecorner"))
	self:addElement(CornerTop)
	self.CornerTop = CornerTop
	local CornerBot = LUI.UIImage.new(1, 1, -41, 4, 0, 0, 302, 347)
	CornerBot:setXRot(180)
	CornerBot:setImage(RegisterImage(@"uie_zm_hud_inventory_framecorner"))
	self:addElement(CornerBot)
	self.CornerBot = CornerBot
	local DividerTop = LUI.UIImage.new(1, 1, -35, 35, 0, 0, 121, 135)
	DividerTop:setZRot(90)
	DividerTop:setImage(RegisterImage(@"uie_zm_hud_inventory_framedivider_horizontal"))
	self:addElement(DividerTop)
	self.DividerTop = DividerTop
	local DividerBot = LUI.UIImage.new(1, 1, -35, 35, 0, 0, 208, 222)
	DividerBot:setZRot(90)
	DividerBot:setImage(RegisterImage(@"uie_zm_hud_inventory_framedivider_horizontal"))
	self:addElement(DividerBot)
	self.DividerBot = DividerBot
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
		{
			stateName = "FourQuests",
			condition = function(menu, element, event)
				return CoD.ZMInventoryUtility.DoesQuestHaveItems(4)
			end,
		},
		{
			stateName = "ThreeQuests",
			condition = function(menu, element, event)
				return CoD.ZMInventoryUtility.DoesQuestHaveItems(3)
			end,
		},
		{
			stateName = "TwoQuests",
			condition = function(menu, element, event)
				return CoD.ZMInventoryUtility.DoesQuestHaveItems(2)
			end,
		},
		{
			stateName = "OneQuest",
			condition = function(menu, element, event)
				return CoD.ZMInventoryUtility.DoesQuestHaveItems(1)
			end,
		},
	})
	Quest1.id = "Quest1"
	Quest2.id = "Quest2"
	Quest3.id = "Quest3"
	Quest4.id = "Quest4"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	CoD.ZMInventoryUtility.SetQuestModels(self, f1_arg1)
	return self
end
CoD.ZMInvQuests.__resetProperties = function(f7_arg0)
	f7_arg0.DividerBot:completeAnimation()
	f7_arg0.DividerTop:completeAnimation()
	f7_arg0.CornerBot:completeAnimation()
	f7_arg0.CornerTop:completeAnimation()
	f7_arg0.Quest4:completeAnimation()
	f7_arg0.Quest3:completeAnimation()
	f7_arg0.Quest2:completeAnimation()
	f7_arg0.Quest1:completeAnimation()
	f7_arg0.DividerBot:setTopBottom(0, 0, 208, 222)
	f7_arg0.DividerBot:setAlpha(1)
	f7_arg0.DividerTop:setTopBottom(0, 0, 121, 135)
	f7_arg0.DividerTop:setAlpha(1)
	f7_arg0.CornerBot:setTopBottom(0, 0, 302, 347)
	f7_arg0.CornerBot:setAlpha(1)
	f7_arg0.CornerTop:setTopBottom(0, 0, -4, 41)
	f7_arg0.CornerTop:setAlpha(1)
	f7_arg0.Quest4:setAlpha(1)
	f7_arg0.Quest3:setTopBottom(0.5, 0.5, -77, 3)
	f7_arg0.Quest3:setAlpha(1)
	f7_arg0.Quest2:setTopBottom(0.5, 0.5, 11, 91)
	f7_arg0.Quest2:setAlpha(1)
	f7_arg0.Quest1:setTopBottom(0.5, 0.5, 99, 179)
	f7_arg0.Quest1:setAlpha(1)
end
CoD.ZMInvQuests.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(8)
			f8_arg0.Quest1:completeAnimation()
			f8_arg0.Quest1:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Quest1)
			f8_arg0.Quest2:completeAnimation()
			f8_arg0.Quest2:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Quest2)
			f8_arg0.Quest3:completeAnimation()
			f8_arg0.Quest3:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Quest3)
			f8_arg0.Quest4:completeAnimation()
			f8_arg0.Quest4:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Quest4)
			f8_arg0.CornerTop:completeAnimation()
			f8_arg0.CornerTop:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CornerTop)
			f8_arg0.CornerBot:completeAnimation()
			f8_arg0.CornerBot:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CornerBot)
			f8_arg0.DividerTop:completeAnimation()
			f8_arg0.DividerTop:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DividerTop)
			f8_arg0.DividerBot:completeAnimation()
			f8_arg0.DividerBot:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DividerBot)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(8)
			f9_arg0.Quest1:completeAnimation()
			f9_arg0.Quest1:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Quest1)
			f9_arg0.Quest2:completeAnimation()
			f9_arg0.Quest2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Quest2)
			f9_arg0.Quest3:completeAnimation()
			f9_arg0.Quest3:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Quest3)
			f9_arg0.Quest4:completeAnimation()
			f9_arg0.Quest4:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Quest4)
			f9_arg0.CornerTop:completeAnimation()
			f9_arg0.CornerTop:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CornerTop)
			f9_arg0.CornerBot:completeAnimation()
			f9_arg0.CornerBot:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CornerBot)
			f9_arg0.DividerTop:completeAnimation()
			f9_arg0.DividerTop:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DividerTop)
			f9_arg0.DividerBot:completeAnimation()
			f9_arg0.DividerBot:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DividerBot)
		end,
	},
	FourQuests = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	ThreeQuests = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(8)
			f11_arg0.Quest1:completeAnimation()
			f11_arg0.Quest1:setTopBottom(0.5, 0.5, 56, 136)
			f11_arg0.clipFinished(f11_arg0.Quest1)
			f11_arg0.Quest2:completeAnimation()
			f11_arg0.Quest2:setTopBottom(0.5, 0.5, -32, 48)
			f11_arg0.clipFinished(f11_arg0.Quest2)
			f11_arg0.Quest3:completeAnimation()
			f11_arg0.Quest3:setTopBottom(0.5, 0.5, -120, -40)
			f11_arg0.clipFinished(f11_arg0.Quest3)
			f11_arg0.Quest4:completeAnimation()
			f11_arg0.Quest4:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Quest4)
			f11_arg0.CornerTop:completeAnimation()
			f11_arg0.CornerTop:setTopBottom(0, 0, 40, 85)
			f11_arg0.clipFinished(f11_arg0.CornerTop)
			f11_arg0.CornerBot:completeAnimation()
			f11_arg0.CornerBot:setTopBottom(0, 0, 259, 304)
			f11_arg0.clipFinished(f11_arg0.CornerBot)
			f11_arg0.DividerTop:completeAnimation()
			f11_arg0.DividerTop:setTopBottom(0, 0, 78, 92)
			f11_arg0.DividerTop:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DividerTop)
			f11_arg0.DividerBot:completeAnimation()
			f11_arg0.DividerBot:setTopBottom(0, 0, 165, 179)
			f11_arg0.clipFinished(f11_arg0.DividerBot)
		end,
	},
	TwoQuests = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(8)
			f12_arg0.Quest1:completeAnimation()
			f12_arg0.Quest1:setTopBottom(0.5, 0.5, 0, 80)
			f12_arg0.clipFinished(f12_arg0.Quest1)
			f12_arg0.Quest2:completeAnimation()
			f12_arg0.Quest2:setTopBottom(0.5, 0.5, -88, -8)
			f12_arg0.clipFinished(f12_arg0.Quest2)
			f12_arg0.Quest3:completeAnimation()
			f12_arg0.Quest3:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Quest3)
			f12_arg0.Quest4:completeAnimation()
			f12_arg0.Quest4:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Quest4)
			f12_arg0.CornerTop:completeAnimation()
			f12_arg0.CornerTop:setTopBottom(0, 0, 72, 117)
			f12_arg0.clipFinished(f12_arg0.CornerTop)
			f12_arg0.CornerBot:completeAnimation()
			f12_arg0.CornerBot:setTopBottom(0, 0, 203, 248)
			f12_arg0.clipFinished(f12_arg0.CornerBot)
			f12_arg0.DividerTop:completeAnimation()
			f12_arg0.DividerTop:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DividerTop)
			f12_arg0.DividerBot:completeAnimation()
			f12_arg0.DividerBot:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DividerBot)
		end,
	},
	OneQuest = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(8)
			f13_arg0.Quest1:completeAnimation()
			f13_arg0.Quest1:setTopBottom(0.5, 0.5, -40, 40)
			f13_arg0.clipFinished(f13_arg0.Quest1)
			f13_arg0.Quest2:completeAnimation()
			f13_arg0.Quest2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Quest2)
			f13_arg0.Quest3:completeAnimation()
			f13_arg0.Quest3:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Quest3)
			f13_arg0.Quest4:completeAnimation()
			f13_arg0.Quest4:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Quest4)
			f13_arg0.CornerTop:completeAnimation()
			f13_arg0.CornerTop:setTopBottom(0, 0, 120, 165)
			f13_arg0.clipFinished(f13_arg0.CornerTop)
			f13_arg0.CornerBot:completeAnimation()
			f13_arg0.CornerBot:setTopBottom(0, 0, 165, 210)
			f13_arg0.clipFinished(f13_arg0.CornerBot)
			f13_arg0.DividerTop:completeAnimation()
			f13_arg0.DividerTop:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DividerTop)
			f13_arg0.DividerBot:completeAnimation()
			f13_arg0.DividerBot:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DividerBot)
		end,
	},
}
CoD.ZMInvQuests.__onClose = function(f14_arg0)
	f14_arg0.Quest1:close()
	f14_arg0.Quest2:close()
	f14_arg0.Quest3:close()
	f14_arg0.Quest4:close()
end

require("x64:29187ea00d726c3")
CoD.ArenaProgressWidgetRank = InheritFrom(LUI.UIElement)
CoD.ArenaProgressWidgetRank.__defaultWidth = 659
CoD.ArenaProgressWidgetRank.__defaultHeight = 72
CoD.ArenaProgressWidgetRank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ArenaProgressWidgetRank)
	self.id = "ArenaProgressWidgetRank"
	self.soundSet = "default"
	local PlacementText = LUI.UIText.new(0, 0, 0, 400, 0, 0, 0, 25)
	PlacementText:setRGB(0.67, 0.67, 0.67)
	PlacementText:setTTF("ttmussels_demibold")
	PlacementText:setLetterSpacing(2)
	PlacementText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlacementText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PlacementText:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayBannerName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlacementText:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(PlacementText)
	self.PlacementText = PlacementText
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 396, 420, 0, 0, 0, 50)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local TeamText = LUI.UIText.new(0, 0, 424, 624, 0, 0, 0, 25)
	TeamText:setRGB(0.92, 0.92, 0.92)
	TeamText:setText(LocalizeToUpperString(@"arena/rank"))
	TeamText:setTTF("ttmussels_demibold")
	TeamText:setLetterSpacing(2)
	TeamText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TeamText)
	self.TeamText = TeamText
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 628, 634, 0, 0, 0, 50)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local DisplayRank = LUI.UIText.new(0, 0, 638, 838, 0, 0, 0, 25)
	DisplayRank:setRGB(0.92, 0.92, 0.92)
	DisplayRank:setTTF("ttmussels_demibold")
	DisplayRank:setLetterSpacing(2)
	DisplayRank:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DisplayRank:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DisplayRank:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayRank", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DisplayRank:setText(f3_local0)
		end
	end)
	self:addElement(DisplayRank)
	self.DisplayRank = DisplayRank
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaProgressWidgetRank.__onClose = function(f4_arg0)
	f4_arg0.PlacementText:close()
	f4_arg0.VerticalListSpacer:close()
	f4_arg0.VerticalListSpacer2:close()
	f4_arg0.DisplayRank:close()
end

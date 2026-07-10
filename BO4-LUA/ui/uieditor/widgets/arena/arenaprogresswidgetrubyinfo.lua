CoD.ArenaProgressWidgetRubyInfo = InheritFrom(LUI.UIElement)
CoD.ArenaProgressWidgetRubyInfo.__defaultWidth = 339
CoD.ArenaProgressWidgetRubyInfo.__defaultHeight = 25
CoD.ArenaProgressWidgetRubyInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ArenaProgressWidgetRubyInfo)
	self.id = "ArenaProgressWidgetRubyInfo"
	self.soundSet = "default"
	local RubyProgress = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 18)
	RubyProgress:setRGB(0.82, 0.03, 0.03)
	RubyProgress:setTTF("ttmussels_regular")
	RubyProgress:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RubyProgress:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	RubyProgress:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayRubiesCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RubyProgress:setText(LocalizeToUpperString(CoD.ArenaLeaguePlayUtility.SetRubyCountText(f2_local0)))
		end
	end)
	self:addElement(RubyProgress)
	self.RubyProgress = RubyProgress
	local RubyProgressRequirement = LUI.UIText.new(0, 0, 202, 402, 0, 0, 0, 18)
	RubyProgressRequirement:setRGB(0.92, 0.92, 0.92)
	RubyProgressRequirement:setTTF("ttmussels_regular")
	RubyProgressRequirement:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RubyProgressRequirement:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	RubyProgressRequirement:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayRank", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RubyProgressRequirement:setText(Engine[@"hash_4F9F1239CFD921FE"](SetProgressTarget(CoD.ArenaLeaguePlayUtility.GetRubyRequirementFromRank(f3_local0))))
		end
	end)
	self:addElement(RubyProgressRequirement)
	self.RubyProgressRequirement = RubyProgressRequirement
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaProgressWidgetRubyInfo.__onClose = function(f4_arg0)
	f4_arg0.RubyProgress:close()
	f4_arg0.RubyProgressRequirement:close()
end

CoD.ArenaEventProgressButtonRank = InheritFrom(LUI.UIElement)
CoD.ArenaEventProgressButtonRank.__defaultWidth = 158
CoD.ArenaEventProgressButtonRank.__defaultHeight = 32
CoD.ArenaEventProgressButtonRank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 6, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ArenaEventProgressButtonRank)
	self.id = "ArenaEventProgressButtonRank"
	self.soundSet = "default"
	local Rank = LUI.UIText.new(0, 0, 0, 158, 0, 0, -7, 32)
	Rank:setRGB(0.87, 0.65, 0.01)
	Rank:setTTF("0arame_mono_stencil")
	Rank:setLetterSpacing(2)
	Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Rank:subscribeToGlobalModel(f1_arg1, "LeaguePlayLadder", "entityLadderRank", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Rank:setText(f2_local0)
		end
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local leagueOrdinalRank = LUI.UIText.new(0, 0, 164, 192, 0, 0, -7, 18)
	leagueOrdinalRank:setRGB(0.87, 0.65, 0.01)
	leagueOrdinalRank:setTTF("0arame_mono_stencil")
	leagueOrdinalRank:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	leagueOrdinalRank:setLetterSpacing(2)
	leagueOrdinalRank:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	leagueOrdinalRank:subscribeToGlobalModel(f1_arg1, "LeaguePlayLadder", "entityLadderRank", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			leagueOrdinalRank:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.ArenaUtility.GetLadderPositionOrdinal(f3_local0)))
		end
	end)
	self:addElement(leagueOrdinalRank)
	self.leagueOrdinalRank = leagueOrdinalRank
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventProgressButtonRank.__onClose = function(f4_arg0)
	f4_arg0.Rank:close()
	f4_arg0.leagueOrdinalRank:close()
end

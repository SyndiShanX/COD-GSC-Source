CoD.ArenaRankIconAndRankVertical = InheritFrom(LUI.UIElement)
CoD.ArenaRankIconAndRankVertical.__defaultWidth = 91
CoD.ArenaRankIconAndRankVertical.__defaultHeight = 63
CoD.ArenaRankIconAndRankVertical.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaRankIconAndRankVertical)
	self.id = "ArenaRankIconAndRankVertical"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeaguePlayRank = LUI.UIText.new(0, 0, 53, 91, 0.5, 0.5, -11, 11)
	LeaguePlayRank:setAlpha(0)
	LeaguePlayRank:setTTF("default")
	LeaguePlayRank:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	LeaguePlayRank:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	LeaguePlayRank:linkToElementModel(self, "displayRank", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LeaguePlayRank:setText(f2_local0)
		end
	end)
	self:addElement(LeaguePlayRank)
	self.LeaguePlayRank = LeaguePlayRank
	local LeaguePlayIcon = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	LeaguePlayIcon:setAlpha(0)
	LeaguePlayIcon:setupUIStreamedImage(0)
	LeaguePlayIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LeaguePlayIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(LeaguePlayIcon)
	self.LeaguePlayIcon = LeaguePlayIcon
	local SkillDivisionIcon = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	SkillDivisionIcon:setAlpha(0)
	SkillDivisionIcon:setupUIStreamedImage(0)
	SkillDivisionIcon:linkToElementModel(self, "skillDivisionIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SkillDivisionIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(SkillDivisionIcon)
	self.SkillDivisionIcon = SkillDivisionIcon
	local firestreakflipbook = LUI.UIImage.new(0.5, 0.5, -65.5, 28.5, 0.5, 0.5, -47, 47)
	firestreakflipbook:setAlpha(0)
	firestreakflipbook:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_add"))
	firestreakflipbook:setShaderVector(0, 4, 4, 0, 0)
	firestreakflipbook:setShaderVector(1, 8, 0, 0, 0)
	firestreakflipbook.__Image = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			firestreakflipbook:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetFirestreakFromSocialPlayerInfo(self, f5_local0)))
		end
	end
	firestreakflipbook:linkToElementModel(self, "arenaLeaguePlayFirstSubdivisionRankStreak", true, firestreakflipbook.__Image)
	firestreakflipbook.__Image_FullPath = function()
		local f6_local0 = self:getModel()
		if f6_local0 then
			f6_local0 = self:getModel()
			f6_local0 = f6_local0.arenaLeaguePlayFirstSubdivisionRankStreak
		end
		if f6_local0 then
			firestreakflipbook.__Image(f6_local0)
		end
	end
	self:addElement(firestreakflipbook)
	self.firestreakflipbook = firestreakflipbook
	local RankedPlayRank = LUI.UIText.new(0, 0, 53, 91, 0.5, 0.5, -11, 11)
	RankedPlayRank:setAlpha(0)
	RankedPlayRank:setTTF("default")
	RankedPlayRank:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	RankedPlayRank:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	RankedPlayRank:linkToElementModel(self, "displayRank", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RankedPlayRank:setText(f7_local0)
		end
	end)
	self:addElement(RankedPlayRank)
	self.RankedPlayRank = RankedPlayRank
	local RankedPlayIcon = LUI.UIImage.new(0, 0, 4, 54, 0.5, 0.5, -25, 25)
	RankedPlayIcon:setAlpha(0)
	RankedPlayIcon:setupUIStreamedImage(0)
	RankedPlayIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			RankedPlayIcon:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(RankedPlayIcon)
	self.RankedPlayIcon = RankedPlayIcon
	firestreakflipbook:linkToElementModel(self, "arenaLeaguePlayPoints", true, firestreakflipbook.__Image_FullPath)
	self:mergeStateConditions({
		{
			stateName = "LeaguePlayAndSkillDivisions",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"])
			end,
		},
		{
			stateName = "RankedPlay",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_4A9E0B7849B16CD2"])
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetGlobalModel()
	f1_local8(f1_local7, f1_local9["lobbyPlaylist.name"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine.GetGlobalModel()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaRankIconAndRankVertical.__resetProperties = function(f13_arg0)
	f13_arg0.LeaguePlayIcon:completeAnimation()
	f13_arg0.RankedPlayIcon:completeAnimation()
	f13_arg0.RankedPlayRank:completeAnimation()
	f13_arg0.LeaguePlayRank:completeAnimation()
	f13_arg0.firestreakflipbook:completeAnimation()
	f13_arg0.SkillDivisionIcon:completeAnimation()
	f13_arg0.LeaguePlayIcon:setAlpha(0)
	f13_arg0.RankedPlayIcon:setAlpha(0)
	f13_arg0.RankedPlayRank:setAlpha(0)
	f13_arg0.LeaguePlayRank:setAlpha(0)
	f13_arg0.firestreakflipbook:setLeftRight(0.5, 0.5, -65.5, 28.5)
	f13_arg0.firestreakflipbook:setAlpha(0)
	f13_arg0.SkillDivisionIcon:setAlpha(0)
end
CoD.ArenaRankIconAndRankVertical.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	LeaguePlayAndSkillDivisions = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(6)
			f15_arg0.LeaguePlayRank:completeAnimation()
			f15_arg0.LeaguePlayRank:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LeaguePlayRank)
			f15_arg0.LeaguePlayIcon:completeAnimation()
			f15_arg0.LeaguePlayIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.LeaguePlayIcon)
			f15_arg0.SkillDivisionIcon:completeAnimation()
			f15_arg0.SkillDivisionIcon:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.SkillDivisionIcon)
			f15_arg0.firestreakflipbook:completeAnimation()
			f15_arg0.firestreakflipbook:setLeftRight(0.5, 0.5, -47, 47)
			f15_arg0.firestreakflipbook:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.firestreakflipbook)
			f15_arg0.RankedPlayRank:completeAnimation()
			f15_arg0.RankedPlayRank:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.RankedPlayRank)
			f15_arg0.RankedPlayIcon:completeAnimation()
			f15_arg0.RankedPlayIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.RankedPlayIcon)
		end,
	},
	RankedPlay = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.LeaguePlayIcon:completeAnimation()
			f16_arg0.LeaguePlayIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.LeaguePlayIcon)
			f16_arg0.SkillDivisionIcon:completeAnimation()
			f16_arg0.SkillDivisionIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.SkillDivisionIcon)
			f16_arg0.RankedPlayRank:completeAnimation()
			f16_arg0.RankedPlayRank:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.RankedPlayRank)
			f16_arg0.RankedPlayIcon:completeAnimation()
			f16_arg0.RankedPlayIcon:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.RankedPlayIcon)
		end,
	},
}
CoD.ArenaRankIconAndRankVertical.__onClose = function(f17_arg0)
	f17_arg0.LeaguePlayRank:close()
	f17_arg0.LeaguePlayIcon:close()
	f17_arg0.SkillDivisionIcon:close()
	f17_arg0.firestreakflipbook:close()
	f17_arg0.RankedPlayRank:close()
	f17_arg0.RankedPlayIcon:close()
end

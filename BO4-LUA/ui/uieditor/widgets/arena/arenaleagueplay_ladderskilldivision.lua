require("x64:7ec6bc10fa8e6b3")
require("x64:1268a8e6dcdbc03")
require("x64:6aeaa2cf60227b7")
CoD.ArenaLeaguePlay_LadderSkillDivision = InheritFrom(LUI.UIElement)
CoD.ArenaLeaguePlay_LadderSkillDivision.__defaultWidth = 898
CoD.ArenaLeaguePlay_LadderSkillDivision.__defaultHeight = 96
CoD.ArenaLeaguePlay_LadderSkillDivision.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaLeaguePlay_LadderSkillDivision)
	self.id = "ArenaLeaguePlay_LadderSkillDivision"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SkillDivisionGem = LUI.UIImage.new(0, 0, 3, 93, 0, 0, 3, 93)
	SkillDivisionGem:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlaySkillDivisionGem", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SkillDivisionGem:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(SkillDivisionGem)
	self.SkillDivisionGem = SkillDivisionGem
	local ArenaEventTimerLarge = CoD.ArenaEventTimerLarge.new(f1_arg0, f1_arg1, 0, 0, 91, 351, 0, 0, 7, 32)
	ArenaEventTimerLarge:setScale(0.8, 0.8)
	ArenaEventTimerLarge:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventTimer", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ArenaEventTimerLarge.EventEndsIn:setText(f3_local0)
		end
	end)
	self:addElement(ArenaEventTimerLarge)
	self.ArenaEventTimerLarge = ArenaEventTimerLarge
	local SkillDivisionString = CoD.ArenaLeaguePlay_LadderSkillDivisionTitle.new(f1_arg0, f1_arg1, 0, 0, 114, 783, 0, 0, 26, 78)
	self:addElement(SkillDivisionString)
	self.SkillDivisionString = SkillDivisionString
	local Subdivision = CoD.ArenaLeaguePlay_LadderSkillDivisionSubTitle.new(f1_arg0, f1_arg1, 0, 0, 117, 783, 0, 0, 71, 89)
	self:addElement(Subdivision)
	self.Subdivision = Subdivision
	self:mergeStateConditions({
		{
			stateName = "CompetitorState",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsSkillDivisionTierEqual(f1_arg1, 1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaLeaguePlay_LadderSkillDivision.__resetProperties = function(f5_arg0)
	f5_arg0.SkillDivisionGem:completeAnimation()
	f5_arg0.ArenaEventTimerLarge:completeAnimation()
	f5_arg0.SkillDivisionString:completeAnimation()
	f5_arg0.Subdivision:completeAnimation()
	f5_arg0.SkillDivisionGem:setAlpha(1)
	f5_arg0.ArenaEventTimerLarge:setLeftRight(0, 0, 91, 351)
	f5_arg0.SkillDivisionString:setLeftRight(0, 0, 114, 783)
	f5_arg0.Subdivision:setLeftRight(0, 0, 117, 783)
end
CoD.ArenaLeaguePlay_LadderSkillDivision.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	CompetitorState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			f7_arg0.SkillDivisionGem:completeAnimation()
			f7_arg0.SkillDivisionGem:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.SkillDivisionGem)
			f7_arg0.ArenaEventTimerLarge:completeAnimation()
			f7_arg0.ArenaEventTimerLarge:setLeftRight(0, 0, -25, 235)
			f7_arg0.clipFinished(f7_arg0.ArenaEventTimerLarge)
			f7_arg0.SkillDivisionString:completeAnimation()
			f7_arg0.SkillDivisionString:setLeftRight(0, 0, -3, 666)
			f7_arg0.clipFinished(f7_arg0.SkillDivisionString)
			f7_arg0.Subdivision:completeAnimation()
			f7_arg0.Subdivision:setLeftRight(0, 0, 0, 666)
			f7_arg0.clipFinished(f7_arg0.Subdivision)
		end,
	},
}
CoD.ArenaLeaguePlay_LadderSkillDivision.__onClose = function(f8_arg0)
	f8_arg0.SkillDivisionGem:close()
	f8_arg0.ArenaEventTimerLarge:close()
	f8_arg0.SkillDivisionString:close()
	f8_arg0.Subdivision:close()
end

require("x64:68d2be12a9d6269")
CoD.LeaguePlayRubyList = InheritFrom(LUI.UIElement)
CoD.LeaguePlayRubyList.__defaultWidth = 150
CoD.LeaguePlayRubyList.__defaultHeight = 40
CoD.LeaguePlayRubyList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.LeaguePlayRubyList)
	self.id = "LeaguePlayRubyList"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Ruby1 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, -60, 0.5, 0.5, -20, 20)
	self:addElement(Ruby1)
	self.Ruby1 = Ruby1
	local Ruby2 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -60, -20, 0.5, 0.5, -20, 20)
	self:addElement(Ruby2)
	self.Ruby2 = Ruby2
	local Ruby3 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.5, 0.5, -20, 20)
	self:addElement(Ruby3)
	self.Ruby3 = Ruby3
	local Ruby4 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 20, 60, 0.5, 0.5, -20, 20)
	self:addElement(Ruby4)
	self.Ruby4 = Ruby4
	local Ruby5 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, 60, 100, 0.5, 0.5, -20, 20)
	self:addElement(Ruby5)
	self.Ruby5 = Ruby5
	self:mergeStateConditions({
		{
			stateName = "Tier1Rewards",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rubies", LuaUtils.GetRubiesForLeaguePlacementTier(1))
			end,
		},
		{
			stateName = "Tier2Rewards",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rubies", LuaUtils.GetRubiesForLeaguePlacementTier(2))
			end,
		},
		{
			stateName = "Tier3Rewards",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rubies", LuaUtils.GetRubiesForLeaguePlacementTier(3))
			end,
		},
		{
			stateName = "Tier4Rewards",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rubies", LuaUtils.GetRubiesForLeaguePlacementTier(4))
			end,
		},
		{
			stateName = "Tier5Rewards",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rubies", LuaUtils.GetRubiesForLeaguePlacementTier(5))
			end,
		},
	})
	self:linkToElementModel(self, "rubies", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rubies",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayRubyList.__resetProperties = function(f8_arg0)
	f8_arg0.Ruby1:completeAnimation()
	f8_arg0.Ruby2:completeAnimation()
	f8_arg0.Ruby4:completeAnimation()
	f8_arg0.Ruby3:completeAnimation()
	f8_arg0.Ruby5:completeAnimation()
	f8_arg0.Ruby1:setAlpha(1)
	f8_arg0.Ruby2:setAlpha(1)
	f8_arg0.Ruby4:setAlpha(1)
	f8_arg0.Ruby3:setAlpha(1)
	f8_arg0.Ruby5:setAlpha(1)
end
CoD.LeaguePlayRubyList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.Ruby1:completeAnimation()
			f9_arg0.Ruby1:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Ruby1)
			f9_arg0.Ruby2:completeAnimation()
			f9_arg0.Ruby2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Ruby2)
			f9_arg0.Ruby3:completeAnimation()
			f9_arg0.Ruby3:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Ruby3)
			f9_arg0.Ruby4:completeAnimation()
			f9_arg0.Ruby4:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Ruby4)
			f9_arg0.Ruby5:completeAnimation()
			f9_arg0.Ruby5:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Ruby5)
		end,
	},
	Tier1Rewards = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Tier2Rewards = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Ruby5:completeAnimation()
			f11_arg0.Ruby5:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Ruby5)
		end,
	},
	Tier3Rewards = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Ruby4:completeAnimation()
			f12_arg0.Ruby4:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Ruby4)
			f12_arg0.Ruby5:completeAnimation()
			f12_arg0.Ruby5:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Ruby5)
		end,
	},
	Tier4Rewards = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.Ruby3:completeAnimation()
			f13_arg0.Ruby3:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Ruby3)
			f13_arg0.Ruby4:completeAnimation()
			f13_arg0.Ruby4:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Ruby4)
			f13_arg0.Ruby5:completeAnimation()
			f13_arg0.Ruby5:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Ruby5)
		end,
	},
	Tier5Rewards = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.Ruby1:completeAnimation()
			f14_arg0.Ruby1:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Ruby1)
			f14_arg0.Ruby2:completeAnimation()
			f14_arg0.Ruby2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Ruby2)
			f14_arg0.Ruby3:completeAnimation()
			f14_arg0.Ruby3:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Ruby3)
			f14_arg0.Ruby4:completeAnimation()
			f14_arg0.Ruby4:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Ruby4)
			f14_arg0.Ruby5:completeAnimation()
			f14_arg0.Ruby5:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Ruby5)
		end,
	},
}
CoD.LeaguePlayRubyList.__onClose = function(f15_arg0)
	f15_arg0.Ruby1:close()
	f15_arg0.Ruby2:close()
	f15_arg0.Ruby3:close()
	f15_arg0.Ruby4:close()
	f15_arg0.Ruby5:close()
end

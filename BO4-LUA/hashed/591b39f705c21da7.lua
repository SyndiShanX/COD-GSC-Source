require("x64:fe61418119efa8")
require("x64:34a5eda5a37725f")
CoD.AARSquadRow = InheritFrom(LUI.UIElement)
CoD.AARSquadRow.__defaultWidth = 1258
CoD.AARSquadRow.__defaultHeight = 70
CoD.AARSquadRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSquadRow)
	self.id = "AARSquadRow"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Place = CoD.AARSquadStat.new(f1_arg0, f1_arg1, 0, 0, 0.5, 62.5, 0, 0, 6, 66)
	Place:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	Place:linkToElementModel(Place, "clientNum", true, function(model)
		f1_arg0:updateElementState(Place, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	Place:linkToElementModel(Place, "stillAlive", true, function(model)
		f1_arg0:updateElementState(Place, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	Place:linkToElementModel(self, "echelon", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Place.Value:setText(f6_local0)
		end
	end)
	self:addElement(Place)
	self.Place = Place
	local Player = CoD.AARSquadPlayer.new(f1_arg0, f1_arg1, 0, 0, 66.5, 537.5, 0, 0, 6, 66)
	Player:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isSelf")
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	Player:linkToElementModel(Player, "isSelf", true, function(model)
		f1_arg0:updateElementState(Player, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isSelf",
		})
	end)
	Player:linkToElementModel(Player, "stillAlive", true, function(model)
		f1_arg0:updateElementState(Player, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	Player:linkToElementModel(self, "playerName", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Player.ClanAndGamerName:setText(f11_local0)
		end
	end)
	self:addElement(Player)
	self.Player = Player
	local KillStat = CoD.AARSquadStat.new(f1_arg0, f1_arg1, 0, 0, 540.5, 680.5, 0, 0, 6, 66)
	KillStat:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	KillStat:linkToElementModel(KillStat, "clientNum", true, function(model)
		f1_arg0:updateElementState(KillStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	KillStat:linkToElementModel(KillStat, "stillAlive", true, function(model)
		f1_arg0:updateElementState(KillStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	KillStat:linkToElementModel(self, "kills", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			KillStat.Value:setText(f16_local0)
		end
	end)
	self:addElement(KillStat)
	self.KillStat = KillStat
	local LongestKillStat = CoD.AARSquadStat.new(f1_arg0, f1_arg1, 0, 0, 683.5, 823.5, 0, 0, 6, 66)
	LongestKillStat:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	LongestKillStat:linkToElementModel(LongestKillStat, "clientNum", true, function(model)
		f1_arg0:updateElementState(LongestKillStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	LongestKillStat:linkToElementModel(LongestKillStat, "stillAlive", true, function(model)
		f1_arg0:updateElementState(LongestKillStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	LongestKillStat:linkToElementModel(self, "longestKill", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			LongestKillStat.Value:setText(LocalizeStringWithParameter(0x2EAE727E6AD7528, UnitsToMeters(f21_local0)))
		end
	end)
	self:addElement(LongestKillStat)
	self.LongestKillStat = LongestKillStat
	local CashDeposited = CoD.AARSquadStat.new(f1_arg0, f1_arg1, 0, 0, 683.5, 823.5, 0, 0, 6, 66)
	CashDeposited:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	CashDeposited:linkToElementModel(CashDeposited, "clientNum", true, function(model)
		f1_arg0:updateElementState(CashDeposited, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	CashDeposited:linkToElementModel(CashDeposited, "stillAlive", true, function(model)
		f1_arg0:updateElementState(CashDeposited, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	CashDeposited:setAlpha(0)
	CashDeposited:linkToElementModel(self, "score", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			CashDeposited.Value:setText(f26_local0)
		end
	end)
	self:addElement(CashDeposited)
	self.CashDeposited = CashDeposited
	local DamageStat = CoD.AARSquadStat.new(f1_arg0, f1_arg1, 0, 0, 826.5, 966.5, 0, 0, 6, 66)
	DamageStat:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	DamageStat:linkToElementModel(DamageStat, "clientNum", true, function(model)
		f1_arg0:updateElementState(DamageStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	DamageStat:linkToElementModel(DamageStat, "stillAlive", true, function(model)
		f1_arg0:updateElementState(DamageStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	DamageStat:linkToElementModel(self, "damage", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			DamageStat.Value:setText(f31_local0)
		end
	end)
	self:addElement(DamageStat)
	self.DamageStat = DamageStat
	local RevivesStat = CoD.AARSquadStat.new(f1_arg0, f1_arg1, 0, 0, 969.5, 1109.5, 0, 0, 6, 66)
	RevivesStat:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	RevivesStat:linkToElementModel(RevivesStat, "clientNum", true, function(model)
		f1_arg0:updateElementState(RevivesStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	RevivesStat:linkToElementModel(RevivesStat, "stillAlive", true, function(model)
		f1_arg0:updateElementState(RevivesStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	RevivesStat:linkToElementModel(self, "revives", true, function(model)
		local f36_local0 = model:get()
		if f36_local0 ~= nil then
			RevivesStat.Value:setText(f36_local0)
		end
	end)
	self:addElement(RevivesStat)
	self.RevivesStat = RevivesStat
	local CleanUpsStat = CoD.AARSquadStat.new(f1_arg0, f1_arg1, 0, 0, 1112.5, 1252.5, 0, 0, 6, 66)
	CleanUpsStat:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, self)
			end,
		},
		{
			stateName = "StillAlive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "stillAlive")
			end,
		},
	})
	CleanUpsStat:linkToElementModel(CleanUpsStat, "clientNum", true, function(model)
		f1_arg0:updateElementState(CleanUpsStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	CleanUpsStat:linkToElementModel(CleanUpsStat, "stillAlive", true, function(model)
		f1_arg0:updateElementState(CleanUpsStat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stillAlive",
		})
	end)
	CleanUpsStat:linkToElementModel(self, "cleanUps", true, function(model)
		local f41_local0 = model:get()
		if f41_local0 ~= nil then
			CleanUpsStat.Value:setText(f41_local0)
		end
	end)
	self:addElement(CleanUpsStat)
	self.CleanUpsStat = CleanUpsStat
	local RankIcon = LUI.UIImage.new(0.5, 0.5, -556, -511, 0, 0, 12.5, 57.5)
	RankIcon:linkToElementModel(self, "echelonIcon", true, function(model)
		local f42_local0 = model:get()
		if f42_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f42_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	self:mergeStateConditions({
		{
			stateName = "Deposit",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("warzone_deposit", f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSquadRow.__resetProperties = function(f44_arg0)
	f44_arg0.CashDeposited:completeAnimation()
	f44_arg0.LongestKillStat:completeAnimation()
	f44_arg0.CashDeposited:setAlpha(0)
	f44_arg0.LongestKillStat:setAlpha(1)
end
CoD.AARSquadRow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(0)
		end,
	},
	Deposit = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(2)
			f46_arg0.LongestKillStat:completeAnimation()
			f46_arg0.LongestKillStat:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.LongestKillStat)
			f46_arg0.CashDeposited:completeAnimation()
			f46_arg0.CashDeposited:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.CashDeposited)
		end,
	},
}
CoD.AARSquadRow.__onClose = function(f47_arg0)
	f47_arg0.Place:close()
	f47_arg0.Player:close()
	f47_arg0.KillStat:close()
	f47_arg0.LongestKillStat:close()
	f47_arg0.CashDeposited:close()
	f47_arg0.DamageStat:close()
	f47_arg0.RevivesStat:close()
	f47_arg0.CleanUpsStat:close()
	f47_arg0.RankIcon:close()
end

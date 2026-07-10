require("x64:4422213aec30beb")
CoD.WZTeamScoreboardStatBoxes = InheritFrom(LUI.UIElement)
CoD.WZTeamScoreboardStatBoxes.__defaultWidth = 569
CoD.WZTeamScoreboardStatBoxes.__defaultHeight = 60
CoD.WZTeamScoreboardStatBoxes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamScoreboardStatBoxes)
	self.id = "WZTeamScoreboardStatBoxes"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatBox1 = CoD.WZTeamScoreboard_ColumnStatBox.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 60)
	StatBox1:linkToElementModel(self, nil, false, function(model)
		StatBox1:setModel(model, f1_arg1)
	end)
	StatBox1:linkToElementModel(self, "scoreboard.col1", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StatBox1.Value:setText(f3_local0)
		end
	end)
	self:addElement(StatBox1)
	self.StatBox1 = StatBox1
	local StatBox2 = CoD.WZTeamScoreboard_ColumnStatBox.new(f1_arg0, f1_arg1, 0, 0, 143, 283, 0, 0, 0, 60)
	StatBox2:linkToElementModel(self, nil, false, function(model)
		StatBox2:setModel(model, f1_arg1)
	end)
	StatBox2:linkToElementModel(self, "scoreboard.col2", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			StatBox2.Value:setText(f5_local0)
		end
	end)
	self:addElement(StatBox2)
	self.StatBox2 = StatBox2
	local StatBox3 = CoD.WZTeamScoreboard_ColumnStatBox.new(f1_arg0, f1_arg1, 0, 0, 286, 426, 0, 0, 0, 60)
	StatBox3:linkToElementModel(self, nil, false, function(model)
		StatBox3:setModel(model, f1_arg1)
	end)
	StatBox3:linkToElementModel(self, "scoreboard.col3", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StatBox3.Value:setText(f7_local0)
		end
	end)
	self:addElement(StatBox3)
	self.StatBox3 = StatBox3
	local StatBoxDeposit = CoD.WZTeamScoreboard_ColumnStatBox.new(f1_arg0, f1_arg1, 0, 0, 429, 569, 0, 0, 0, 60)
	StatBoxDeposit:setAlpha(0)
	StatBoxDeposit:linkToElementModel(self, nil, false, function(model)
		StatBoxDeposit:setModel(model, f1_arg1)
	end)
	StatBoxDeposit:linkToElementModel(self, "scoreboard.footer7", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			StatBoxDeposit.Value:setText(f9_local0)
		end
	end)
	self:addElement(StatBoxDeposit)
	self.StatBoxDeposit = StatBoxDeposit
	self:mergeStateConditions({
		{
			stateName = "Deposit",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("warzone_deposit")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamScoreboardStatBoxes.__resetProperties = function(f11_arg0)
	f11_arg0.StatBoxDeposit:completeAnimation()
	f11_arg0.StatBox2:completeAnimation()
	f11_arg0.StatBox3:completeAnimation()
	f11_arg0.StatBoxDeposit:setLeftRight(0, 0, 429, 569)
	f11_arg0.StatBoxDeposit:setAlpha(0)
	f11_arg0.StatBox2:setLeftRight(0, 0, 143, 283)
	f11_arg0.StatBox3:setLeftRight(0, 0, 286, 426)
end
CoD.WZTeamScoreboardStatBoxes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Deposit = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.StatBox2:completeAnimation()
			f13_arg0.StatBox2:setLeftRight(0, 0, 286, 426)
			f13_arg0.clipFinished(f13_arg0.StatBox2)
			f13_arg0.StatBox3:completeAnimation()
			f13_arg0.StatBox3:setLeftRight(0, 0, 429, 569)
			f13_arg0.clipFinished(f13_arg0.StatBox3)
			f13_arg0.StatBoxDeposit:completeAnimation()
			f13_arg0.StatBoxDeposit:setLeftRight(0, 0, 143, 283)
			f13_arg0.StatBoxDeposit:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.StatBoxDeposit)
		end,
	},
}
CoD.WZTeamScoreboardStatBoxes.__onClose = function(f14_arg0)
	f14_arg0.StatBox1:close()
	f14_arg0.StatBox2:close()
	f14_arg0.StatBox3:close()
	f14_arg0.StatBoxDeposit:close()
end

require("x64:fb3b8c05a446f3c")
CoD.remote_missile_targets = InheritFrom(CoD.Menu)
LUI.createMenu.remote_missile_targets = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("remote_missile_targets", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.remote_missile_targets)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local remoteMissileTarget_player0 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player0:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 0)
			end,
		},
	})
	remoteMissileTarget_player0:linkToElementModel(remoteMissileTarget_player0, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player0, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player0:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player0:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player0)
	self.remoteMissileTarget_player0 = remoteMissileTarget_player0
	local remoteMissileTarget_player1 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player1:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 1)
			end,
		},
	})
	remoteMissileTarget_player1:linkToElementModel(remoteMissileTarget_player1, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player1, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player1.target:setupRemoteMissileTarget(1)
	remoteMissileTarget_player1:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player1:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player1)
	self.remoteMissileTarget_player1 = remoteMissileTarget_player1
	local remoteMissileTarget_player2 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player2:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 2)
			end,
		},
	})
	remoteMissileTarget_player2:linkToElementModel(remoteMissileTarget_player2, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player2, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player2.target:setupRemoteMissileTarget(2)
	remoteMissileTarget_player2:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player2:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player2)
	self.remoteMissileTarget_player2 = remoteMissileTarget_player2
	local remoteMissileTarget_player3 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player3:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 3)
			end,
		},
	})
	remoteMissileTarget_player3:linkToElementModel(remoteMissileTarget_player3, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player3, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player3.target:setupRemoteMissileTarget(3)
	remoteMissileTarget_player3:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player3:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player3)
	self.remoteMissileTarget_player3 = remoteMissileTarget_player3
	local remoteMissileTarget_player4 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player4:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 4)
			end,
		},
	})
	remoteMissileTarget_player4:linkToElementModel(remoteMissileTarget_player4, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player4, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player4.target:setupRemoteMissileTarget(4)
	remoteMissileTarget_player4:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player4:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player4)
	self.remoteMissileTarget_player4 = remoteMissileTarget_player4
	local remoteMissileTarget_player5 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player5:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 5)
			end,
		},
	})
	remoteMissileTarget_player5:linkToElementModel(remoteMissileTarget_player5, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player5, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player5.target:setupRemoteMissileTarget(5)
	remoteMissileTarget_player5:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player5:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player5)
	self.remoteMissileTarget_player5 = remoteMissileTarget_player5
	local remoteMissileTarget_player6 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player6:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 6)
			end,
		},
	})
	remoteMissileTarget_player6:linkToElementModel(remoteMissileTarget_player6, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player6, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player6.target:setupRemoteMissileTarget(6)
	remoteMissileTarget_player6:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player6:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player6)
	self.remoteMissileTarget_player6 = remoteMissileTarget_player6
	local remoteMissileTarget_player7 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player7:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 7)
			end,
		},
	})
	remoteMissileTarget_player7:linkToElementModel(remoteMissileTarget_player7, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player7, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player7.target:setupRemoteMissileTarget(7)
	remoteMissileTarget_player7:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player7:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player7)
	self.remoteMissileTarget_player7 = remoteMissileTarget_player7
	local remoteMissileTarget_player8 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player8:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 8)
			end,
		},
	})
	remoteMissileTarget_player8:linkToElementModel(remoteMissileTarget_player8, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player8, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player8.target:setupRemoteMissileTarget(8)
	remoteMissileTarget_player8:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player8:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player8)
	self.remoteMissileTarget_player8 = remoteMissileTarget_player8
	local remoteMissileTarget_player9 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player9:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 9)
			end,
		},
	})
	remoteMissileTarget_player9:linkToElementModel(remoteMissileTarget_player9, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player9, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player9.target:setupRemoteMissileTarget(9)
	remoteMissileTarget_player9:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player9:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player9)
	self.remoteMissileTarget_player9 = remoteMissileTarget_player9
	local remoteMissileTarget_player10 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player10:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 10)
			end,
		},
	})
	remoteMissileTarget_player10:linkToElementModel(remoteMissileTarget_player10, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player10, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player10.target:setupRemoteMissileTarget(10)
	remoteMissileTarget_player10:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player10:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player10)
	self.remoteMissileTarget_player10 = remoteMissileTarget_player10
	local remoteMissileTarget_player11 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player11:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 11)
			end,
		},
	})
	remoteMissileTarget_player11:linkToElementModel(remoteMissileTarget_player11, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player11, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player11.target:setupRemoteMissileTarget(11)
	remoteMissileTarget_player11:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player11:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player11)
	self.remoteMissileTarget_player11 = remoteMissileTarget_player11
	local remoteMissileTarget_player12 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player12:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 12)
			end,
		},
	})
	remoteMissileTarget_player12:linkToElementModel(remoteMissileTarget_player12, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player12, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player12.target:setupRemoteMissileTarget(12)
	remoteMissileTarget_player12:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player12:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player12)
	self.remoteMissileTarget_player12 = remoteMissileTarget_player12
	local remoteMissileTarget_player13 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player13:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 13)
			end,
		},
	})
	remoteMissileTarget_player13:linkToElementModel(remoteMissileTarget_player13, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player13, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player13.target:setupRemoteMissileTarget(13)
	remoteMissileTarget_player13:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player13:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player13)
	self.remoteMissileTarget_player13 = remoteMissileTarget_player13
	local remoteMissileTarget_player14 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player14:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 14)
			end,
		},
	})
	remoteMissileTarget_player14:linkToElementModel(remoteMissileTarget_player14, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player14, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player14.target:setupRemoteMissileTarget(14)
	remoteMissileTarget_player14:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player14:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player14)
	self.remoteMissileTarget_player14 = remoteMissileTarget_player14
	local remoteMissileTarget_player15 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_player15:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueBitSet(element, f1_arg0, "player_target_active", 15)
			end,
		},
	})
	remoteMissileTarget_player15:linkToElementModel(remoteMissileTarget_player15, "player_target_active", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_player15, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "player_target_active",
		})
	end)
	remoteMissileTarget_player15.target:setupRemoteMissileTarget(15)
	remoteMissileTarget_player15:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_player15:setModel(model, f1_arg0)
	end)
	self:addElement(remoteMissileTarget_player15)
	self.remoteMissileTarget_player15 = remoteMissileTarget_player15
	local remoteMissileTarget_other1 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_other1:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "extra_target_1", 0)
			end,
		},
	})
	remoteMissileTarget_other1:linkToElementModel(remoteMissileTarget_other1, "extra_target_1", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_other1, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "extra_target_1",
		})
	end)
	remoteMissileTarget_other1:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_other1:setModel(model, f1_arg0)
	end)
	remoteMissileTarget_other1:linkToElementModel(self, "extra_target_1", true, function(model)
		local f53_local0 = model:get()
		if f53_local0 ~= nil then
			remoteMissileTarget_other1.target:setupRemoteMissileTarget(f53_local0)
		end
	end)
	self:addElement(remoteMissileTarget_other1)
	self.remoteMissileTarget_other1 = remoteMissileTarget_other1
	local remoteMissileTarget_other2 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_other2:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "extra_target_2", 0)
			end,
		},
	})
	remoteMissileTarget_other2:linkToElementModel(remoteMissileTarget_other2, "extra_target_2", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_other2, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "extra_target_2",
		})
	end)
	remoteMissileTarget_other2:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_other2:setModel(model, f1_arg0)
	end)
	remoteMissileTarget_other2:linkToElementModel(self, "extra_target_2", true, function(model)
		local f57_local0 = model:get()
		if f57_local0 ~= nil then
			remoteMissileTarget_other2.target:setupRemoteMissileTarget(f57_local0)
		end
	end)
	self:addElement(remoteMissileTarget_other2)
	self.remoteMissileTarget_other2 = remoteMissileTarget_other2
	local remoteMissileTarget_other3 = CoD.remoteMissileTarget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	remoteMissileTarget_other3:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "extra_target_3", 0)
			end,
		},
	})
	remoteMissileTarget_other3:linkToElementModel(remoteMissileTarget_other3, "extra_target_3", true, function(model)
		f1_local1:updateElementState(remoteMissileTarget_other3, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "extra_target_3",
		})
	end)
	remoteMissileTarget_other3:linkToElementModel(self, nil, false, function(model)
		remoteMissileTarget_other3:setModel(model, f1_arg0)
	end)
	remoteMissileTarget_other3:linkToElementModel(self, "extra_target_3", true, function(model)
		local f61_local0 = model:get()
		if f61_local0 ~= nil then
			remoteMissileTarget_other3.target:setupRemoteMissileTarget(f61_local0)
		end
	end)
	self:addElement(remoteMissileTarget_other3)
	self.remoteMissileTarget_other3 = remoteMissileTarget_other3
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.remote_missile_targets.__onClose = function(f62_arg0)
	f62_arg0.remoteMissileTarget_player0:close()
	f62_arg0.remoteMissileTarget_player1:close()
	f62_arg0.remoteMissileTarget_player2:close()
	f62_arg0.remoteMissileTarget_player3:close()
	f62_arg0.remoteMissileTarget_player4:close()
	f62_arg0.remoteMissileTarget_player5:close()
	f62_arg0.remoteMissileTarget_player6:close()
	f62_arg0.remoteMissileTarget_player7:close()
	f62_arg0.remoteMissileTarget_player8:close()
	f62_arg0.remoteMissileTarget_player9:close()
	f62_arg0.remoteMissileTarget_player10:close()
	f62_arg0.remoteMissileTarget_player11:close()
	f62_arg0.remoteMissileTarget_player12:close()
	f62_arg0.remoteMissileTarget_player13:close()
	f62_arg0.remoteMissileTarget_player14:close()
	f62_arg0.remoteMissileTarget_player15:close()
	f62_arg0.remoteMissileTarget_other1:close()
	f62_arg0.remoteMissileTarget_other2:close()
	f62_arg0.remoteMissileTarget_other3:close()
end

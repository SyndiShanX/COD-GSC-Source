require("x64:4b7495930782b1d")
require("x64:dd231f8dbd1bf8")
require("x64:893bae73a3c202d")
CoD.WarScoreInfo_Notifications_ThreeStage = InheritFrom(LUI.UIElement)
CoD.WarScoreInfo_Notifications_ThreeStage.__defaultWidth = 435
CoD.WarScoreInfo_Notifications_ThreeStage.__defaultHeight = 80
CoD.WarScoreInfo_Notifications_ThreeStage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarScoreInfo_Notifications_ThreeStage)
	self.id = "WarScoreInfo_Notifications_ThreeStage"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StageNotification1 = CoD.WarScoreInfo_StageNotificationLeft.new(f1_arg0, f1_arg1, 0, 0, 108, 428, 0, 0, 0, 60)
	StageNotification1:mergeStateConditions({
		{
			stateName = "Collapsed",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZone", 1)
			end,
		},
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
	})
	local StageNotification3 = StageNotification1
	local StageNotification2 = StageNotification1.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	StageNotification2(StageNotification3, f1_local4["hudItems.war.currentZone"], function(f4_arg0)
		f1_arg0:updateElementState(StageNotification1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.war.currentZone",
		})
	end, false)
	StageNotification3 = StageNotification1
	StageNotification2 = StageNotification1.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	StageNotification2(StageNotification3, f1_local4["hudItems.war.objectiveHeldByAttackingTeam"], function(f5_arg0)
		f1_arg0:updateElementState(StageNotification1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	StageNotification3 = StageNotification1
	StageNotification2 = StageNotification1.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	StageNotification2(StageNotification3, f1_local4["hudItems.war.objectiveHeldByDefendingTeam"], function(f6_arg0)
		f1_arg0:updateElementState(StageNotification1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	StageNotification1:subscribeToGlobalModel(f1_arg1, "WarData", "zone1.progressWidget", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StageNotification1.ObjectiveProgressionFrame:changeFrameWidget(f7_local0)
		end
	end)
	StageNotification1:subscribeToGlobalModel(f1_arg1, "WarData", "zone1.objectiveIcon", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			StageNotification1.CaptureIcon:setImage(RegisterImage(f8_local0))
		end
	end)
	StageNotification1:subscribeToGlobalModel(f1_arg1, "WarData", "zone1.teamObjective", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			StageNotification1.ObjectiveTextBox:setText(Engine[0xF9F1239CFD921FE](f9_local0))
		end
	end)
	self:addElement(StageNotification1)
	self.StageNotification1 = StageNotification1
	StageNotification2 = CoD.WarScoreInfo_StageNotification.new(f1_arg0, f1_arg1, 0, 0, 109, 429, 0, 0, 0, 60)
	StageNotification2:mergeStateConditions({
		{
			stateName = "CollapsedRight",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZone", 1)
			end,
		},
		{
			stateName = "CollapsedLeft",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZone", 3)
			end,
		},
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
	})
	f1_local4 = StageNotification2
	StageNotification3 = StageNotification2.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	StageNotification3(f1_local4, f1_local5["hudItems.war.currentZone"], function(f13_arg0)
		f1_arg0:updateElementState(StageNotification2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "hudItems.war.currentZone",
		})
	end, false)
	f1_local4 = StageNotification2
	StageNotification3 = StageNotification2.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	StageNotification3(f1_local4, f1_local5["hudItems.war.objectiveHeldByAttackingTeam"], function(f14_arg0)
		f1_arg0:updateElementState(StageNotification2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	f1_local4 = StageNotification2
	StageNotification3 = StageNotification2.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	StageNotification3(f1_local4, f1_local5["hudItems.war.objectiveHeldByDefendingTeam"], function(f15_arg0)
		f1_arg0:updateElementState(StageNotification2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	StageNotification2:subscribeToGlobalModel(f1_arg1, "WarData", "zone2.progressWidget", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			StageNotification2.ObjectiveProgressionFrame:changeFrameWidget(f16_local0)
		end
	end)
	StageNotification2:subscribeToGlobalModel(f1_arg1, "WarData", "zone2.objectiveIcon", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			StageNotification2.FuelCellIcon:setImage(RegisterImage(f17_local0))
		end
	end)
	StageNotification2:subscribeToGlobalModel(f1_arg1, "WarData", "zone2.teamObjective", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			StageNotification2.ObjectiveTextBox:setText(Engine[0xF9F1239CFD921FE](f18_local0))
		end
	end)
	self:addElement(StageNotification2)
	self.StageNotification2 = StageNotification2
	StageNotification3 = CoD.WarScoreInfo_StageNotificationRight.new(f1_arg0, f1_arg1, 0, 0, 111, 431, 0, 0, 0, 60)
	StageNotification3:mergeStateConditions({
		{
			stateName = "Collapsed",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZone", 3)
			end,
		},
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
	})
	f1_local5 = StageNotification3
	f1_local4 = StageNotification3.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["hudItems.war.currentZone"], function(f21_arg0)
		f1_arg0:updateElementState(StageNotification3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "hudItems.war.currentZone",
		})
	end, false)
	f1_local5 = StageNotification3
	f1_local4 = StageNotification3.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["hudItems.war.objectiveHeldByAttackingTeam"], function(f22_arg0)
		f1_arg0:updateElementState(StageNotification3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	f1_local5 = StageNotification3
	f1_local4 = StageNotification3.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["hudItems.war.objectiveHeldByDefendingTeam"], function(f23_arg0)
		f1_arg0:updateElementState(StageNotification3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	StageNotification3:subscribeToGlobalModel(f1_arg1, "WarData", "zone3.progressWidget", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			StageNotification3.ObjectiveProgressionFrame:changeFrameWidget(f24_local0)
		end
	end)
	StageNotification3:subscribeToGlobalModel(f1_arg1, "WarData", "zone3.objectiveIcon", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			StageNotification3.BotIcon:setImage(RegisterImage(f25_local0))
		end
	end)
	StageNotification3:subscribeToGlobalModel(f1_arg1, "WarData", "zone3.teamObjective", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			StageNotification3.ObjectiveTextBox:setText(Engine[0xF9F1239CFD921FE](f26_local0))
		end
	end)
	self:addElement(StageNotification3)
	self.StageNotification3 = StageNotification3
	self:mergeStateConditions({
		{
			stateName = "Stage1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZone", 1)
			end,
		},
		{
			stateName = "Stage2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZone", 2)
			end,
		},
		{
			stateName = "Stage3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZone", 3)
			end,
		},
	})
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["hudItems.war.currentZone"], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "hudItems.war.currentZone",
		})
	end, false)
	StageNotification1.id = "StageNotification1"
	StageNotification2.id = "StageNotification2"
	StageNotification3.id = "StageNotification3"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarScoreInfo_Notifications_ThreeStage.__onClose = function(f31_arg0)
	f31_arg0.StageNotification1:close()
	f31_arg0.StageNotification2:close()
	f31_arg0.StageNotification3:close()
end

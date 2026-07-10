require("x64:37b342fbfcf0bf6")
require("x64:187db8450da061a")
local PostLoadFunc = function(self, controller)
	self.ProgressMarker:subscribeToGlobalModel(controller, "WarData", "currentZoneProgress", function(model)
		local f2_local0, f2_local1, f2_local2, f2_local3 = self.ProgressMarker:getLocalRect()
		local f2_local4 = Engine[@"getmodelvalue"](model)
		if f2_local4 and f2_local0 and f2_local2 then
			self.ProgressMarker:setLeftRight(f2_local4, f2_local4, f2_local0, f2_local2)
		end
	end)
end
CoD.WarScoreInfo_Capture_ProgressBar = InheritFrom(LUI.UIElement)
CoD.WarScoreInfo_Capture_ProgressBar.__defaultWidth = 400
CoD.WarScoreInfo_Capture_ProgressBar.__defaultHeight = 15
CoD.WarScoreInfo_Capture_ProgressBar.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	self:setClass(CoD.WarScoreInfo_Capture_ProgressBar)
	self.id = "WarScoreInfo_Capture_ProgressBar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ProgressMarker = CoD.WarScoreInfo_Capture_ProgressMarker.new(f3_arg0, f3_arg1, 0, 0, -2, 3, 0, 0, 0, 15)
	ProgressMarker:mergeStateConditions({
		{
			stateName = "LeftArrow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and not CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
		{
			stateName = "RightArrow",
			condition = function(menu, element, event)
				local f5_local0
				if not CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") then
					f5_local0 = CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
	})
	local Segment2 = ProgressMarker
	local Segment1 = ProgressMarker.subscribeToModel
	local Segment3 = Engine[@"getglobalmodel"]()
	Segment1(Segment2, Segment3["hudItems.war.objectiveHeldByAttackingTeam"], function(f6_arg0)
		f3_arg0:updateElementState(ProgressMarker, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	Segment2 = ProgressMarker
	Segment1 = ProgressMarker.subscribeToModel
	Segment3 = Engine[@"getglobalmodel"]()
	Segment1(Segment2, Segment3["hudItems.war.objectiveHeldByDefendingTeam"], function(f7_arg0)
		f3_arg0:updateElementState(ProgressMarker, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	ProgressMarker:setAlpha(0)
	self:addElement(ProgressMarker)
	self.ProgressMarker = ProgressMarker
	Segment1 = CoD.WarScoreInfo_Capture_ProgressBarSegment.new(f3_arg0, f3_arg1, 0, 0, 0, 132, 0, 0, 0, 13)
	Segment1:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("hudItems.war.currentZoneProgress", 0.33)
			end,
		},
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
	})
	Segment3 = Segment1
	Segment2 = Segment1.subscribeToModel
	local f3_local5 = Engine[@"getglobalmodel"]()
	Segment2(Segment3, f3_local5["hudItems.war.currentZoneProgress"], function(f10_arg0)
		f3_arg0:updateElementState(Segment1, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.war.currentZoneProgress",
		})
	end, false)
	Segment3 = Segment1
	Segment2 = Segment1.subscribeToModel
	f3_local5 = Engine[@"getglobalmodel"]()
	Segment2(Segment3, f3_local5["hudItems.war.objectiveHeldByAttackingTeam"], function(f11_arg0)
		f3_arg0:updateElementState(Segment1, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f11_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	Segment3 = Segment1
	Segment2 = Segment1.subscribeToModel
	f3_local5 = Engine[@"getglobalmodel"]()
	Segment2(Segment3, f3_local5["hudItems.war.objectiveHeldByDefendingTeam"], function(f12_arg0)
		f3_arg0:updateElementState(Segment1, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	Segment1:subscribeToGlobalModel(f3_arg1, "WarData", "currentZoneProgress", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Segment1.ProgressBar:setShaderVector(0, AdjustStartEnd(0, 3, CoD.GetVectorComponentFromString(f13_local0, 1), CoD.GetVectorComponentFromString(f13_local0, 2), CoD.GetVectorComponentFromString(f13_local0, 3), CoD.GetVectorComponentFromString(f13_local0, 4)))
		end
	end)
	self:addElement(Segment1)
	self.Segment1 = Segment1
	Segment2 = CoD.WarScoreInfo_Capture_ProgressBarSegment.new(f3_arg0, f3_arg1, 0, 0, 134, 266, 0, 0, 0, 13)
	Segment2:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("hudItems.war.currentZoneProgress", 0.67)
			end,
		},
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
	})
	f3_local5 = Segment2
	Segment3 = Segment2.subscribeToModel
	local f3_local6 = Engine[@"getglobalmodel"]()
	Segment3(f3_local5, f3_local6["hudItems.war.currentZoneProgress"], function(f16_arg0)
		f3_arg0:updateElementState(Segment2, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f16_arg0:get(),
			modelName = "hudItems.war.currentZoneProgress",
		})
	end, false)
	f3_local5 = Segment2
	Segment3 = Segment2.subscribeToModel
	f3_local6 = Engine[@"getglobalmodel"]()
	Segment3(f3_local5, f3_local6["hudItems.war.objectiveHeldByAttackingTeam"], function(f17_arg0)
		f3_arg0:updateElementState(Segment2, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f17_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	f3_local5 = Segment2
	Segment3 = Segment2.subscribeToModel
	f3_local6 = Engine[@"getglobalmodel"]()
	Segment3(f3_local5, f3_local6["hudItems.war.objectiveHeldByDefendingTeam"], function(f18_arg0)
		f3_arg0:updateElementState(Segment2, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	Segment2:subscribeToGlobalModel(f3_arg1, "WarData", "currentZoneProgress", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			Segment2.ProgressBar:setShaderVector(0, AdjustStartEnd(0, 3, AddToVector(-0.33, 0, 0, 0, CoD.GetVectorComponentFromString(f19_local0, 1), CoD.GetVectorComponentFromString(f19_local0, 2), CoD.GetVectorComponentFromString(f19_local0, 3), CoD.GetVectorComponentFromString(f19_local0, 4))))
		end
	end)
	self:addElement(Segment2)
	self.Segment2 = Segment2
	Segment3 = CoD.WarScoreInfo_Capture_ProgressBarSegment.new(f3_arg0, f3_arg1, 0, 0, 268, 400, 0, 0, 0, 13)
	Segment3:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.currentZoneProgress", 1)
			end,
		},
		{
			stateName = "Contested",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByAttackingTeam") and CoD.ModelUtility.IsGlobalModelValueTrue("hudItems.war.objectiveHeldByDefendingTeam")
			end,
		},
	})
	f3_local6 = Segment3
	f3_local5 = Segment3.subscribeToModel
	local f3_local7 = Engine[@"getglobalmodel"]()
	f3_local5(f3_local6, f3_local7["hudItems.war.currentZoneProgress"], function(f22_arg0)
		f3_arg0:updateElementState(Segment3, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f22_arg0:get(),
			modelName = "hudItems.war.currentZoneProgress",
		})
	end, false)
	f3_local6 = Segment3
	f3_local5 = Segment3.subscribeToModel
	f3_local7 = Engine[@"getglobalmodel"]()
	f3_local5(f3_local6, f3_local7["hudItems.war.objectiveHeldByAttackingTeam"], function(f23_arg0)
		f3_arg0:updateElementState(Segment3, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f23_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByAttackingTeam",
		})
	end, false)
	f3_local6 = Segment3
	f3_local5 = Segment3.subscribeToModel
	f3_local7 = Engine[@"getglobalmodel"]()
	f3_local5(f3_local6, f3_local7["hudItems.war.objectiveHeldByDefendingTeam"], function(f24_arg0)
		f3_arg0:updateElementState(Segment3, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f24_arg0:get(),
			modelName = "hudItems.war.objectiveHeldByDefendingTeam",
		})
	end, false)
	Segment3:subscribeToGlobalModel(f3_arg1, "WarData", "currentZoneProgress", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			Segment3.ProgressBar:setShaderVector(0, AdjustStartEnd(0, 3, AddToVector(-0.67, 0, 0, 0, CoD.GetVectorComponentFromString(f25_local0, 1), CoD.GetVectorComponentFromString(f25_local0, 2), CoD.GetVectorComponentFromString(f25_local0, 3), CoD.GetVectorComponentFromString(f25_local0, 4))))
		end
	end)
	self:addElement(Segment3)
	self.Segment3 = Segment3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.WarScoreInfo_Capture_ProgressBar.__onClose = function(f26_arg0)
	f26_arg0.ProgressMarker:close()
	f26_arg0.Segment1:close()
	f26_arg0.Segment2:close()
	f26_arg0.Segment3:close()
end

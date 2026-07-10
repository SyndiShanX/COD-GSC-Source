require("x64:92408d21d25c715")
require("x64:bceacea0be98d9f")
require("x64:22cb65cb2800b84")
require("x64:931b099d7cc0ee5")
require("x64:a8d8a002b60eb15")
CoD.DeployableNotifications = InheritFrom(LUI.UIElement)
CoD.DeployableNotifications.__defaultWidth = 800
CoD.DeployableNotifications.__defaultHeight = 400
CoD.DeployableNotifications.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "hudItems.miniTurretCount", 0)
	self:setClass(CoD.DeployableNotifications)
	self.id = "DeployableNotifications"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProximityAlarm = CoD.DeployableNotifications_ProximityAlarm.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0.5, 0.5, -200, 200)
	ProximityAlarm:mergeStateConditions({
		{
			stateName = "Offline",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "EnemyDetected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Destroyed",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Replacing",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ProximityAlarm:setYRot(180)
	self:addElement(ProximityAlarm)
	self.ProximityAlarm = ProximityAlarm
	local SpawnBeacon = CoD.DeployableNotifications_SpawnBeacon.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 400)
	SpawnBeacon:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:addElement(SpawnBeacon)
	self.SpawnBeacon = SpawnBeacon
	local SensorDart = CoD.DeployableNotifications_SensorDart.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0.5, 0.5, -200, 200)
	SensorDart:mergeStateConditions({
		{
			stateName = "OneDart",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "TwoDarts",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SensorDart:setYRot(180)
	self:addElement(SensorDart)
	self.SensorDart = SensorDart
	local MiniTurret = CoD.DeployableNotifications_MiniTurret.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 400)
	MiniTurret:mergeStateConditions({
		{
			stateName = "OneTurret",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "TwoTurrets",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ThreeTurrets",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:addElement(MiniTurret)
	self.MiniTurret = MiniTurret
	local MedicCleanse = CoD.DeployableNotifications_MedicCleanse.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 400)
	self:addElement(MedicCleanse)
	self.MedicCleanse = MedicCleanse
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DeployableNotifications.__resetProperties = function(f13_arg0)
	f13_arg0.SensorDart:completeAnimation()
	f13_arg0.SpawnBeacon:completeAnimation()
	f13_arg0.ProximityAlarm:completeAnimation()
	f13_arg0.MiniTurret:completeAnimation()
	f13_arg0.MedicCleanse:completeAnimation()
	f13_arg0.SensorDart:setAlpha(1)
	f13_arg0.SpawnBeacon:setAlpha(1)
	f13_arg0.ProximityAlarm:setAlpha(1)
	f13_arg0.MiniTurret:setAlpha(1)
	f13_arg0.MedicCleanse:setAlpha(1)
end
CoD.DeployableNotifications.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.ProximityAlarm:completeAnimation()
			f14_arg0.ProximityAlarm:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ProximityAlarm)
			f14_arg0.SpawnBeacon:completeAnimation()
			f14_arg0.SpawnBeacon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.SpawnBeacon)
			f14_arg0.SensorDart:completeAnimation()
			f14_arg0.SensorDart:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.SensorDart)
			f14_arg0.MiniTurret:completeAnimation()
			f14_arg0.MiniTurret:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.MiniTurret)
			f14_arg0.MedicCleanse:completeAnimation()
			f14_arg0.MedicCleanse:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.MedicCleanse)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.ProximityAlarm:completeAnimation()
			f15_arg0.ProximityAlarm:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ProximityAlarm)
			f15_arg0.SpawnBeacon:completeAnimation()
			f15_arg0.SpawnBeacon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SpawnBeacon)
			f15_arg0.SensorDart:completeAnimation()
			f15_arg0.SensorDart:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SensorDart)
			f15_arg0.MiniTurret:completeAnimation()
			f15_arg0.MiniTurret:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.MiniTurret)
			f15_arg0.MedicCleanse:completeAnimation()
			f15_arg0.MedicCleanse:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.MedicCleanse)
		end,
	},
}
CoD.DeployableNotifications.__onClose = function(f16_arg0)
	f16_arg0.ProximityAlarm:close()
	f16_arg0.SpawnBeacon:close()
	f16_arg0.SensorDart:close()
	f16_arg0.MiniTurret:close()
	f16_arg0.MedicCleanse:close()
end

require("x64:6733462913727bd")
require("x64:2cd5497a304c464")
require("x64:de3749bfc0efb9e")
require("x64:8c4201a81f383d5")
require("x64:3cceba23a026334")
require("x64:52a0ad3ca7ca7b4")
require("x64:dba761763bfd768")
require("x64:326bf4ddf2d5186")
require("x64:14999ad4356466")
require("x64:93547a1e84ec106")
require("x64:d24e4a6046a91b2")
CoD.vhud_attack_helicopter_reticle = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_reticle.__defaultWidth = 1920
CoD.vhud_attack_helicopter_reticle.__defaultHeight = 1080
CoD.vhud_attack_helicopter_reticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_reticle)
	self.id = "vhud_attack_helicopter_reticle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Reticle = CoD.vhud_hellstorm_CenterReticleWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -110, 110, 0.5, 0.5, -110, 110)
	Reticle:mergeStateConditions({
		{
			stateName = "enemyInReticle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "luielement.remote_missile_target_lockon.target_locked", 1)
			end,
		},
	})
	local CenterFrame = Reticle
	local RingL = Reticle.subscribeToModel
	local AltMeterL = Engine[0x4DF5CFBC1771947](f1_arg1)
	RingL(CenterFrame, AltMeterL["luielement.remote_missile_target_lockon.target_locked"], function(f3_arg0)
		f1_arg0:updateElementState(Reticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "luielement.remote_missile_target_lockon.target_locked",
		})
	end, false)
	self:addElement(Reticle)
	self.Reticle = Reticle
	RingL = CoD.vhud_HellstormRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -368, 368, 0.5, 0.5, -368, 368)
	RingL:setAlpha(0.06)
	RingL:setZoom(20)
	RingL:setScale(0.61, 0.61)
	self:addElement(RingL)
	self.RingL = RingL
	CenterFrame = CoD.vhud_HellstormCenterFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -412.5, 412.5, 0.5, 0.5, -449, 469)
	CenterFrame:setAlpha(0.8)
	CenterFrame:setScale(0.62, 0.62)
	self:addElement(CenterFrame)
	self.CenterFrame = CenterFrame
	AltMeterL = CoD.vhud_hellstorm_AltWidget.new(f1_arg0, f1_arg1, 0, 0, 1218, 1438, 0.5, 0.5, -23, 10)
	AltMeterL:setYRot(6)
	AltMeterL:linkToElementModel(self, nil, false, function(model)
		AltMeterL:setModel(model, f1_arg1)
	end)
	self:addElement(AltMeterL)
	self.AltMeterL = AltMeterL
	local Speed = CoD.vhud_hellstorm_SpeedWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -110, 110, 0.5, 0.5, 163.5, 196.5)
	Speed:linkToElementModel(self, nil, false, function(model)
		Speed:setModel(model, f1_arg1)
	end)
	self:addElement(Speed)
	self.Speed = Speed
	local RocketCounter = CoD.vhud_attack_helicopter_rocket_counter.new(f1_arg0, f1_arg1, 0, 0, 1196.5, 1346.5, 0, 0, 603.5, 703.5)
	self:addElement(RocketCounter)
	self.RocketCounter = RocketCounter
	local FlareCounter = CoD.vhud_attack_helicopter_flare_counter.new(f1_arg0, f1_arg1, 0, 0, 604.5, 752.5, 0, 0, 600, 718)
	self:addElement(FlareCounter)
	self.FlareCounter = FlareCounter
	local SpreadReticle = CoD.vhud_attack_helicopter_minigun_reticle.new(f1_arg0, f1_arg1, 0.5, 0.5, -5, 5, 0.5, 0.5, -5, 5)
	self:addElement(SpreadReticle)
	self.SpreadReticle = SpreadReticle
	local missileProximityAlert = CoD.missileProximityAlert.new(f1_arg0, f1_arg1, 0, 0, 810, 1130, 0, 0, 770.5, 811.5)
	missileProximityAlert:linkToElementModel(self, nil, false, function(model)
		missileProximityAlert:setModel(model, f1_arg1)
	end)
	self:addElement(missileProximityAlert)
	self.missileProximityAlert = missileProximityAlert
	local Health = CoD.vhud_attack_helicopter_health.new(f1_arg0, f1_arg1, 0, 0, 126, 428, 0, 0, 811.5, 989.5)
	Health:linkToElementModel(self, nil, false, function(model)
		Health:setModel(model, f1_arg1)
	end)
	self:addElement(Health)
	self.Health = Health
	local vhudmsTimebar = CoD.vhud_ms_Timebar.new(f1_arg0, f1_arg1, 1, 1, -1819, -1469, 0, 0, 908, 921)
	vhudmsTimebar:linkToElementModel(self, nil, false, function(model)
		vhudmsTimebar:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsTimebar)
	self.vhudmsTimebar = vhudmsTimebar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_reticle.__onClose = function(f9_arg0)
	f9_arg0.Reticle:close()
	f9_arg0.RingL:close()
	f9_arg0.CenterFrame:close()
	f9_arg0.AltMeterL:close()
	f9_arg0.Speed:close()
	f9_arg0.RocketCounter:close()
	f9_arg0.FlareCounter:close()
	f9_arg0.SpreadReticle:close()
	f9_arg0.missileProximityAlert:close()
	f9_arg0.Health:close()
	f9_arg0.vhudmsTimebar:close()
end

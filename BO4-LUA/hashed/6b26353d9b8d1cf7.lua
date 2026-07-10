require("x64:6733462913727bd")
require("x64:c625dbd32f58fad")
CoD.vhud_gunship_flare_dock = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_flare_dock.__defaultWidth = 256
CoD.vhud_gunship_flare_dock.__defaultHeight = 134
CoD.vhud_gunship_flare_dock.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_flare_dock)
	self.id = "vhud_gunship_flare_dock"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 0, 0, 256, 0, 0, 0, 136)
	Backing:setYRot(180)
	Backing:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_weapon_bg"))
	self:addElement(Backing)
	self.Backing = Backing
	local FlareCounter = CoD.vhud_attack_helicopter_flare_counter.new(f1_arg0, f1_arg1, 0, 0, 92, 240, 0, 0, 7, 125)
	FlareCounter.FlareName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_9B0F35B7B023E8F"))
	FlareCounter:linkToElementModel(self, nil, false, function(model)
		FlareCounter:setModel(model, f1_arg1)
	end)
	self:addElement(FlareCounter)
	self.FlareCounter = FlareCounter
	local FlareStatusIndicator = LUI.UIImage.new(0, 0, 16, 80, 0, 0, 45.5, 77.5)
	FlareStatusIndicator:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_flare_icon"))
	FlareStatusIndicator:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(FlareStatusIndicator)
	self.FlareStatusIndicator = FlareStatusIndicator
	local FlareStatusIndicator2 = LUI.UIImage.new(0, 0, 16, 80, 0, 0, 45.5, 77.5)
	FlareStatusIndicator2:setAlpha(0.2)
	FlareStatusIndicator2:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_flare_icon"))
	FlareStatusIndicator2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(FlareStatusIndicator2)
	self.FlareStatusIndicator2 = FlareStatusIndicator2
	local FlareStatusText = CoD.vhud_gunship_flare_indicator.new(f1_arg0, f1_arg1, 0, 0, 7, 87, 0, 0, 52, 70)
	self:addElement(FlareStatusText)
	self.FlareStatusText = FlareStatusText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_flare_dock.__onClose = function(f3_arg0)
	f3_arg0.FlareCounter:close()
	f3_arg0.FlareStatusText:close()
end

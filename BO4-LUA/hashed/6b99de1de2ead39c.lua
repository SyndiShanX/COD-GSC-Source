require("x64:315a48f43c443a5")
require("x64:ce2f5f6849507b6")
CoD.vhud_gunship_105mm_ammocounter = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_105mm_ammocounter.__defaultWidth = 148
CoD.vhud_gunship_105mm_ammocounter.__defaultHeight = 118
CoD.vhud_gunship_105mm_ammocounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_105mm_ammocounter)
	self.id = "vhud_gunship_105mm_ammocounter"
	self.soundSet = "none"
	local BackingFrame = CoD.vhud_gunship_ammocounterframe.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	BackingFrame.AmmoName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_55EB1B65C9E8E54"))
	BackingFrame:linkToElementModel(self, nil, false, function(model)
		BackingFrame:setModel(model, f1_arg1)
	end)
	BackingFrame:linkToElementModel(self, "bindingCooldown0.cooldown", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BackingFrame.BackingFillAnim:setShaderVector(2, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(BackingFrame)
	self.BackingFrame = BackingFrame
	local AmmoCounterInternal = CoD.vhud_gunship_ammo_count_internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -26, 28, 0.4, 0.4, -32, 42)
	AmmoCounterInternal.ammoBack:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_105mm_icon"))
	AmmoCounterInternal.ammoFront:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_105mm_icon"))
	AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			AmmoCounterInternal.ammoFront:setShaderVector(1, CoD.VehicleUtility.AC130MainCannonAmmoToWipeProgress(self:getModel(), CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end
	AmmoCounterInternal:linkToElementModel(self, "rocketAmmo", true, AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End)
	AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.rocketAmmo
		end
		if f5_local0 then
			AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End(f5_local0)
		end
	end
	self:addElement(AmmoCounterInternal)
	self.AmmoCounterInternal = AmmoCounterInternal
	AmmoCounterInternal:linkToElementModel(self, "bindingCooldown0.cooldown", true, AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_105mm_ammocounter.__onClose = function(f6_arg0)
	f6_arg0.BackingFrame:close()
	f6_arg0.AmmoCounterInternal:close()
end

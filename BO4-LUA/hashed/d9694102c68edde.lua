require("x64:315a48f43c443a5")
require("x64:ce2f5f6849507b6")
CoD.vhud_gunship_40mm_ammocounter = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_40mm_ammocounter.__defaultWidth = 148
CoD.vhud_gunship_40mm_ammocounter.__defaultHeight = 118
CoD.vhud_gunship_40mm_ammocounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_40mm_ammocounter)
	self.id = "vhud_gunship_40mm_ammocounter"
	self.soundSet = "none"
	local BackingFrame = CoD.vhud_gunship_ammocounterframe.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	BackingFrame.AmmoName:setText(Engine[0xF9F1239CFD921FE](0x38ED6914A2BC298))
	BackingFrame:linkToElementModel(self, "bindingCooldown1.cooldown", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BackingFrame.BackingFillAnim:setShaderVector(2, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(BackingFrame)
	self.BackingFrame = BackingFrame
	local AmmoCounterInternal = CoD.vhud_gunship_ammo_count_internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -39, 41, 0.4, 0.4, -19, 27)
	AmmoCounterInternal.ammoBack:setImage(RegisterImage(0x484DB9CB2A7C17A))
	AmmoCounterInternal.ammoBack:setShaderVector(0, 4, 1, 0, 0)
	AmmoCounterInternal.ammoFront:setImage(RegisterImage(0x484DB9CB2A7C17A))
	AmmoCounterInternal.ammoFront:setShaderVector(0, 4, 1, 0, 0)
	AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			AmmoCounterInternal.ammoFront:setShaderVector(1, CoD.VehicleUtility.AC130AutoCannonToWipeProgress(self:getModel(), CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end
	AmmoCounterInternal:linkToElementModel(self, "ammoCount", true, AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End)
	AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.ammoCount
		end
		if f4_local0 then
			AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End(f4_local0)
		end
	end
	self:addElement(AmmoCounterInternal)
	self.AmmoCounterInternal = AmmoCounterInternal
	AmmoCounterInternal:linkToElementModel(self, "bindingCooldown1.cooldown", true, AmmoCounterInternal.ammoFront.__ammoFront_Wipe_X_Start_X_End_Y_Start_Y_End_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_40mm_ammocounter.__onClose = function(f5_arg0)
	f5_arg0.BackingFrame:close()
	f5_arg0.AmmoCounterInternal:close()
end

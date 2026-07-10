CoD.AARRewardsEquipmentRow = InheritFrom(LUI.UIElement)
CoD.AARRewardsEquipmentRow.__defaultWidth = 150
CoD.AARRewardsEquipmentRow.__defaultHeight = 64
CoD.AARRewardsEquipmentRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardsEquipmentRow)
	self.id = "AARRewardsEquipmentRow"
	self.soundSet = "default"
	local Grenade = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	Grenade:linkToElementModel(self, "grenadeImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Grenade:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Grenade)
	self.Grenade = Grenade
	local Gear = LUI.UIFixedAspectRatioImage.new(0, 0, 86, 150, 0, 0, 0, 64)
	Gear:linkToElementModel(self, "tacticalGearImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Gear:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(Gear)
	self.Gear = Gear
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARRewardsEquipmentRow.__onClose = function(f4_arg0)
	f4_arg0.Grenade:close()
	f4_arg0.Gear:close()
end

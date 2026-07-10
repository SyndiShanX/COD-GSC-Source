require("x64:b7e92846213afa1")
CoD.KillcamKilledByEquipment = InheritFrom(LUI.UIElement)
CoD.KillcamKilledByEquipment.__defaultWidth = 495
CoD.KillcamKilledByEquipment.__defaultHeight = 520
CoD.KillcamKilledByEquipment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamKilledByEquipment)
	self.id = "KillcamKilledByEquipment"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local EquipmentGroups = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 5, 0, nil, nil, false, false, false, false)
	EquipmentGroups:setLeftRight(0, 0, 0, 495)
	EquipmentGroups:setTopBottom(0, 0, 0, 520)
	EquipmentGroups:setWidgetType(CoD.KillcamKilledByEquipmentList)
	EquipmentGroups:setVerticalCount(5)
	EquipmentGroups:setSpacing(5)
	EquipmentGroups:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EquipmentGroups:setDataSource("KillcamEquipment")
	self:addElement(EquipmentGroups)
	self.EquipmentGroups = EquipmentGroups
	EquipmentGroups.id = "EquipmentGroups"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamKilledByEquipment.__onClose = function(f2_arg0)
	f2_arg0.EquipmentGroups:close()
end

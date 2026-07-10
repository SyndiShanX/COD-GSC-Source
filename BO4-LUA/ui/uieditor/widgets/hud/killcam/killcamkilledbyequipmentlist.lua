require("x64:12998a17a57f686")
CoD.KillcamKilledByEquipmentList = InheritFrom(LUI.UIElement)
CoD.KillcamKilledByEquipmentList.__defaultWidth = 495
CoD.KillcamKilledByEquipmentList.__defaultHeight = 100
CoD.KillcamKilledByEquipmentList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamKilledByEquipmentList)
	self.id = "KillcamKilledByEquipmentList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local EquipmentList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 5, 0, nil, nil, false, false, false, false)
	EquipmentList:setLeftRight(1, 1, -495, 0)
	EquipmentList:setTopBottom(0, 0, 0, 100)
	EquipmentList:setWidgetType(CoD.KillcamKilledByEquipmentItem)
	EquipmentList:setHorizontalCount(4)
	EquipmentList:setSpacing(5)
	EquipmentList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EquipmentList:linkToElementModel(self, "groupDatasource", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EquipmentList:setDataSource(f2_local0)
		end
	end)
	self:addElement(EquipmentList)
	self.EquipmentList = EquipmentList
	EquipmentList.id = "EquipmentList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamKilledByEquipmentList.__onClose = function(f3_arg0)
	f3_arg0.EquipmentList:close()
end

require("x64:4723da3cbc3f3f5")
CoD.SpecialistIssueEquipmentWidget = InheritFrom(LUI.UIElement)
CoD.SpecialistIssueEquipmentWidget.__defaultWidth = 400
CoD.SpecialistIssueEquipmentWidget.__defaultHeight = 400
CoD.SpecialistIssueEquipmentWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistIssueEquipmentWidget)
	self.id = "SpecialistIssueEquipmentWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialIssueEquipment = CoD.SpecialistIssueEquipmentWidgetInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 401, 0, 0, 0, 400)
	self:addElement(SpecialIssueEquipment)
	self.SpecialIssueEquipment = SpecialIssueEquipment
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistIssueEquipmentWidget.__resetProperties = function(f2_arg0)
	f2_arg0.SpecialIssueEquipment:completeAnimation()
	f2_arg0.SpecialIssueEquipment:setLeftRight(0, 0, 0, 401)
	f2_arg0.SpecialIssueEquipment:setAlpha(1)
end
CoD.SpecialistIssueEquipmentWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.SpecialIssueEquipment:completeAnimation()
			f3_arg0.SpecialIssueEquipment:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.SpecialIssueEquipment)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.SpecialIssueEquipment:completeAnimation()
			f4_arg0.SpecialIssueEquipment:setLeftRight(0, 0, 0, 400)
			f4_arg0.SpecialIssueEquipment:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.SpecialIssueEquipment)
		end,
	},
}
CoD.SpecialistIssueEquipmentWidget.__onClose = function(f5_arg0)
	f5_arg0.SpecialIssueEquipment:close()
end

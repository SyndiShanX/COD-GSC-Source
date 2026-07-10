require("x64:3b07bb59f93eadd")
CoD.SpecialistIssueEquipmentWidgetInternal = InheritFrom(LUI.UIElement)
CoD.SpecialistIssueEquipmentWidgetInternal.__defaultWidth = 401
CoD.SpecialistIssueEquipmentWidgetInternal.__defaultHeight = 400
CoD.SpecialistIssueEquipmentWidgetInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistIssueEquipmentWidgetInternal)
	self.id = "SpecialistIssueEquipmentWidgetInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IconImage = LUI.UIImage.new(0.5, 0.5, -200.5, 199.5, 0, 0, 0, 400)
	IconImage:setImage(RegisterImage(@"uie_ui_icon_gear_specialist_eq_wire"))
	self:addElement(IconImage)
	self.IconImage = IconImage
	local SpecialIssueBacking = CoD.SpecialistIssueEquipmentBacking.new(f1_arg0, f1_arg1, 0, 0, -45, 445, 0, 0, 118, 207)
	self:addElement(SpecialIssueBacking)
	self.SpecialIssueBacking = SpecialIssueBacking
	local NoCosDescription = LUI.UIText.new(0.5, 0.5, -200, 200, 1, 1, -182, -164)
	NoCosDescription:setRGB(0.8, 0.79, 0.78)
	NoCosDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_488B7950288BF6EC"))
	NoCosDescription:setTTF("dinnext_regular")
	NoCosDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NoCosDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	NoCosDescription:setBackingType(2)
	NoCosDescription:setBackingColor(0.09, 0.09, 0.09)
	NoCosDescription:setBackingXPadding(4)
	NoCosDescription:setBackingYPadding(3)
	NoCosDescription:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"hash_69B9049CF3C351D4"))
	NoCosDescription:setBackingShaderVector(0, 0, 0.5, 0, 0)
	self:addElement(NoCosDescription)
	self.NoCosDescription = NoCosDescription
	local NoCostText = LUI.UIText.new(0.5, 0.5, -63, 62, 1, 1, -230, -214)
	NoCostText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	NoCostText:setText(LocalizeToUpperString(@"mpui/no_cost"))
	NoCostText:setTTF("ttmussels_regular")
	NoCostText:setLetterSpacing(4)
	NoCostText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(NoCostText)
	self.NoCostText = NoCostText
	local Header = LUI.UIText.new(0.5, 0.5, -63, 62, 1, 1, -262.5, -235.5)
	Header:setRGB(0.92, 0.92, 0.92)
	Header:setText(LocalizeToUpperString(@"hash_62E4979E1A30E8C5"))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(Header)
	self.Header = Header
	self:mergeStateConditions({
		{
			stateName = "ShowDescription",
			condition = function(menu, element, event)
				return IsCurrentMenu(menu, "SpecialistEquipmentSelect")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistIssueEquipmentWidgetInternal.__resetProperties = function(f3_arg0)
	f3_arg0.NoCosDescription:completeAnimation()
	f3_arg0.NoCosDescription:setAlpha(1)
end
CoD.SpecialistIssueEquipmentWidgetInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.NoCosDescription:completeAnimation()
			f4_arg0.NoCosDescription:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.NoCosDescription)
		end,
	},
	ShowDescription = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.NoCosDescription:completeAnimation()
			f5_arg0.NoCosDescription:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.NoCosDescription)
		end,
	},
}
CoD.SpecialistIssueEquipmentWidgetInternal.__onClose = function(f6_arg0)
	f6_arg0.SpecialIssueBacking:close()
end

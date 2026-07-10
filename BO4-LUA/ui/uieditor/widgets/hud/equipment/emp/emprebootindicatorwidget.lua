require("x64:d7e092479c7b82c")
CoD.EmpRebootIndicatorWidget = InheritFrom(LUI.UIElement)
CoD.EmpRebootIndicatorWidget.__defaultWidth = 301
CoD.EmpRebootIndicatorWidget.__defaultHeight = 58
CoD.EmpRebootIndicatorWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmpRebootIndicatorWidget)
	self.id = "EmpRebootIndicatorWidget"
	self.soundSet = "HUD"
	local ArmorFrame = LUI.UIImage.new(0.5, 0.5, -132, 130, 0.5, 0.5, -4, 29)
	ArmorFrame:setAlpha(0.4)
	ArmorFrame:setImage(RegisterImage(@"uie_t7_hud_armorcontainer"))
	self:addElement(ArmorFrame)
	self.ArmorFrame = ArmorFrame
	local BlackFrame = LUI.UIImage.new(0.5, 0.5, -150, 149, 0.5, 0.5, -29, -3)
	BlackFrame:setRGB(0, 0, 0)
	BlackFrame:setAlpha(0.4)
	self:addElement(BlackFrame)
	self.BlackFrame = BlackFrame
	local armorBorder = CoD.Border.new(f1_arg0, f1_arg1, 0.5, 0.5, -137, 134, 0.5, 0.5, -18, -13)
	armorBorder:setAlpha(0.4)
	self:addElement(armorBorder)
	self.armorBorder = armorBorder
	local ProgressBar = LUI.UIImage.new(0.5, 0.5, -136, 132, 0.5, 0.5, -16, -14)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	ProgressBar:setShaderVector(0, 1, 0, 0, 0)
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local RebootText = LUI.UIText.new(0.5, 0.5, -117, 113, 0.5, 0.5, -4, 22)
	RebootText:setText(Engine[@"hash_4F9F1239CFD921FE"](0xBD2AB55ABF4ECF))
	RebootText:setTTF("ttmussels_demibold")
	RebootText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RebootText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RebootText)
	self.RebootText = RebootText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmpRebootIndicatorWidget.__onClose = function(f2_arg0)
	f2_arg0.armorBorder:close()
end

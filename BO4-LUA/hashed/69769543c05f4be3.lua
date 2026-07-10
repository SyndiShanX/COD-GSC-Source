CoD.OverheadNamePlatoonReviveIcon = InheritFrom(LUI.UIElement)
CoD.OverheadNamePlatoonReviveIcon.__defaultWidth = 75
CoD.OverheadNamePlatoonReviveIcon.__defaultHeight = 105
CoD.OverheadNamePlatoonReviveIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OverheadNamePlatoonReviveIcon)
	self.id = "OverheadNamePlatoonReviveIcon"
	self.soundSet = "default"
	local WaypointBackerBlur = LUI.UIImage.new(0, 1, 0, 0, 0.14, 0.86, -15, -15)
	WaypointBackerBlur:setImage(RegisterImage(0x8DDD1FDE43242E1))
	WaypointBackerBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	WaypointBackerBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(WaypointBackerBlur)
	self.WaypointBackerBlur = WaypointBackerBlur
	local WaypointBacker2 = LUI.UIImage.new(0, 1, 0, 0, 0.14, 0.86, -15, -15)
	WaypointBacker2:setImage(RegisterImage(0x8DDD1FDE43242E1))
	self:addElement(WaypointBacker2)
	self.WaypointBacker2 = WaypointBacker2
	local WaypointProgressMeterEmpty = LUI.UIImage.new(0, 1, 0, 0, 0.14, 0.86, -15, -15)
	WaypointProgressMeterEmpty:setRGB(1, 0.98, 0.91)
	WaypointProgressMeterEmpty:setAlpha(0.35)
	WaypointProgressMeterEmpty:setImage(RegisterImage(0x2608D8F924FABD2))
	self:addElement(WaypointProgressMeterEmpty)
	self.WaypointProgressMeterEmpty = WaypointProgressMeterEmpty
	local WaypointPattern2 = LUI.UIImage.new(0.07, 0.93, 0, 0, 0.19, 0.81, -13, -13)
	WaypointPattern2:setAlpha(0.35)
	WaypointPattern2:setImage(RegisterImage(0x159D9B7B7294C91))
	WaypointPattern2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	WaypointPattern2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(WaypointPattern2)
	self.WaypointPattern2 = WaypointPattern2
	local ReviveIcon = LUI.UIImage.new(0.2, 0.8, 0, 0, 0.29, 0.71, -15, -15)
	ReviveIcon:setImage(RegisterImage(0x13132272AD6B56C))
	self:addElement(ReviveIcon)
	self.ReviveIcon = ReviveIcon
	local Arrows2 = LUI.UIImage.new(0.29, 0.71, 0, 0, 0.83, 1.13, -14, -14)
	Arrows2:setImage(RegisterImage(0xAB17136E34541E3))
	Arrows2:linkToElementModel(self, "platoonIndicatorScale", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Arrows2:setScale(f2_local0)
		end
	end)
	self:addElement(Arrows2)
	self.Arrows2 = Arrows2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OverheadNamePlatoonReviveIcon.__onClose = function(f3_arg0)
	f3_arg0.Arrows2:close()
end

require("x64:7f5d82ee0ad504b")
CoD.WeaponAttributesBar = InheritFrom(LUI.UIElement)
CoD.WeaponAttributesBar.__defaultWidth = 243
CoD.WeaponAttributesBar.__defaultHeight = 16
CoD.WeaponAttributesBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, -2, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.WeaponAttributesBar)
	self.id = "WeaponAttributesBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Dash1 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 0, 27, 0, 0, 0, 16)
	self:addElement(Dash1)
	self.Dash1 = Dash1
	local Dash2 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 24, 51, 0, 0, 0, 16)
	self:addElement(Dash2)
	self.Dash2 = Dash2
	local Dash3 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 48, 75, 0, 0, 0, 16)
	self:addElement(Dash3)
	self.Dash3 = Dash3
	local Dash4 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 72, 99, 0, 0, 0, 16)
	self:addElement(Dash4)
	self.Dash4 = Dash4
	local Dash5 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 96, 123, 0, 0, 0, 16)
	self:addElement(Dash5)
	self.Dash5 = Dash5
	local Dash6 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 120, 147, 0, 0, 0, 16)
	self:addElement(Dash6)
	self.Dash6 = Dash6
	local Dash7 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 144, 171, 0, 0, 0, 16)
	self:addElement(Dash7)
	self.Dash7 = Dash7
	local Dash9 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 168, 195, 0, 0, 0, 16)
	self:addElement(Dash9)
	self.Dash9 = Dash9
	local Dash8 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 192, 219, 0, 0, 0, 16)
	self:addElement(Dash8)
	self.Dash8 = Dash8
	local Dash10 = CoD.WeaponAttributesEmptyBar.new(f1_arg0, f1_arg1, 0, 0, 216, 243, 0, 0, 0, 16)
	self:addElement(Dash10)
	self.Dash10 = Dash10
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponAttributesBar.__onClose = function(f2_arg0)
	f2_arg0.Dash1:close()
	f2_arg0.Dash2:close()
	f2_arg0.Dash3:close()
	f2_arg0.Dash4:close()
	f2_arg0.Dash5:close()
	f2_arg0.Dash6:close()
	f2_arg0.Dash7:close()
	f2_arg0.Dash9:close()
	f2_arg0.Dash8:close()
	f2_arg0.Dash10:close()
end

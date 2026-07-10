require("x64:556bdfb6ae48283")
CoD.AllocationSpentWidget = InheritFrom(LUI.UIElement)
CoD.AllocationSpentWidget.__defaultWidth = 402
CoD.AllocationSpentWidget.__defaultHeight = 17
CoD.AllocationSpentWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AllocationSpentWidget)
	self.id = "AllocationSpentWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AllocationBar0 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 0, 17, 0, 0, 0, 17)
	self:addElement(AllocationBar0)
	self.AllocationBar0 = AllocationBar0
	local AllocationBar1 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 25, 42, 0, 0, 0, 17)
	self:addElement(AllocationBar1)
	self.AllocationBar1 = AllocationBar1
	local AllocationBar2 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 50, 67, 0, 0, 0, 17)
	self:addElement(AllocationBar2)
	self.AllocationBar2 = AllocationBar2
	local AllocationBar3 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 75, 92, 0, 0, 0, 17)
	self:addElement(AllocationBar3)
	self.AllocationBar3 = AllocationBar3
	local AllocationBar4 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 100, 117, 0, 0, 0, 17)
	self:addElement(AllocationBar4)
	self.AllocationBar4 = AllocationBar4
	local AllocationBar5 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 125, 142, 0, 0, 0, 17)
	self:addElement(AllocationBar5)
	self.AllocationBar5 = AllocationBar5
	local AllocationBar6 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 150, 167, 0, 0, 0, 17)
	self:addElement(AllocationBar6)
	self.AllocationBar6 = AllocationBar6
	local AllocationBar7 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 175, 192, 0, 0, 0, 17)
	self:addElement(AllocationBar7)
	self.AllocationBar7 = AllocationBar7
	local AllocationBar8 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 200, 217, 0, 0, 0, 17)
	self:addElement(AllocationBar8)
	self.AllocationBar8 = AllocationBar8
	local AllocationBar9 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 225, 242, 0, 0, 0, 17)
	self:addElement(AllocationBar9)
	self.AllocationBar9 = AllocationBar9
	local AllocationBar10 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 250, 267, 0, 0, 0, 17)
	self:addElement(AllocationBar10)
	self.AllocationBar10 = AllocationBar10
	local AllocationBar11 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 275, 292, 0, 0, 0, 17)
	self:addElement(AllocationBar11)
	self.AllocationBar11 = AllocationBar11
	local AllocationBar12 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 300, 317, 0, 0, 0, 17)
	self:addElement(AllocationBar12)
	self.AllocationBar12 = AllocationBar12
	local AllocationBar13 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 325, 342, 0, 0, 0, 17)
	self:addElement(AllocationBar13)
	self.AllocationBar13 = AllocationBar13
	local AllocationBar14 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 350, 367, 0, 0, 0, 17)
	self:addElement(AllocationBar14)
	self.AllocationBar14 = AllocationBar14
	local AllocationBar15 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 375, 392, 0, 0, 0, 17)
	self:addElement(AllocationBar15)
	self.AllocationBar15 = AllocationBar15
	local AllocationBar16 = CoD.AllocationBar.new(f1_arg0, f1_arg1, 0, 0, 400, 417, 0, 0, 0, 17)
	self:addElement(AllocationBar16)
	self.AllocationBar16 = AllocationBar16
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AllocationSpentWidget.__onClose = function(f2_arg0)
	f2_arg0.AllocationBar0:close()
	f2_arg0.AllocationBar1:close()
	f2_arg0.AllocationBar2:close()
	f2_arg0.AllocationBar3:close()
	f2_arg0.AllocationBar4:close()
	f2_arg0.AllocationBar5:close()
	f2_arg0.AllocationBar6:close()
	f2_arg0.AllocationBar7:close()
	f2_arg0.AllocationBar8:close()
	f2_arg0.AllocationBar9:close()
	f2_arg0.AllocationBar10:close()
	f2_arg0.AllocationBar11:close()
	f2_arg0.AllocationBar12:close()
	f2_arg0.AllocationBar13:close()
	f2_arg0.AllocationBar14:close()
	f2_arg0.AllocationBar15:close()
	f2_arg0.AllocationBar16:close()
end

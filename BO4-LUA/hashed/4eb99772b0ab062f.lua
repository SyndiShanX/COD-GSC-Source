require("x64:3b08a00709267c0")
CoD.ZMInvNonlinearObjectProgressRing = InheritFrom(LUI.UIElement)
CoD.ZMInvNonlinearObjectProgressRing.__defaultWidth = 384
CoD.ZMInvNonlinearObjectProgressRing.__defaultHeight = 400
CoD.ZMInvNonlinearObjectProgressRing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInvNonlinearObjectProgressRing)
	self.id = "ZMInvNonlinearObjectProgressRing"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ObjectiveProgItem1 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, 13, 113, 0.5, 0.5, -229, -129)
	self:addElement(ObjectiveProgItem1)
	self.ObjectiveProgItem1 = ObjectiveProgItem1
	local ObjectiveProgItem2 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, 53, 153, 0.5, 0.5, -153, -53)
	self:addElement(ObjectiveProgItem2)
	self.ObjectiveProgItem2 = ObjectiveProgItem2
	local ObjectiveProgItem3 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, 116, 216, 0.5, 0.5, -170, -70)
	self:addElement(ObjectiveProgItem3)
	self.ObjectiveProgItem3 = ObjectiveProgItem3
	local ObjectiveProgItem4 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, 123, 223, 0.5, 0.5, -87, 13)
	self:addElement(ObjectiveProgItem4)
	self.ObjectiveProgItem4 = ObjectiveProgItem4
	local ObjectiveProgItem5 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, 83, 183, 0.5, 0.5, 50, 150)
	self:addElement(ObjectiveProgItem5)
	self.ObjectiveProgItem5 = ObjectiveProgItem5
	local ObjectiveProgItem6 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, 20, 120, 0.5, 0.5, 93, 193)
	self:addElement(ObjectiveProgItem6)
	self.ObjectiveProgItem6 = ObjectiveProgItem6
	local ObjectiveProgItem7 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, -85, 15, 0.5, 0.5, 105, 205)
	self:addElement(ObjectiveProgItem7)
	self.ObjectiveProgItem7 = ObjectiveProgItem7
	local ObjectiveProgItem8 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, -185, -85, 0.5, 0.5, 58, 158)
	self:addElement(ObjectiveProgItem8)
	self.ObjectiveProgItem8 = ObjectiveProgItem8
	local ObjectiveProgItem9 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, -242, -142, 0.5, 0.5, -50, 50)
	self:addElement(ObjectiveProgItem9)
	self.ObjectiveProgItem9 = ObjectiveProgItem9
	local ObjectiveProgItem10 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, -233, -133, 0.5, 0.5, -141, -41)
	self:addElement(ObjectiveProgItem10)
	self.ObjectiveProgItem10 = ObjectiveProgItem10
	local ObjectiveProgItem11 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, -166, -66, 0.5, 0.5, -124, -24)
	self:addElement(ObjectiveProgItem11)
	self.ObjectiveProgItem11 = ObjectiveProgItem11
	local ObjectiveProgItem12 = CoD.ZMInvObjectiveProgressItemSingle.new(f1_arg0, f1_arg1, 0.5, 0.5, -122, -22, 0.5, 0.5, -241, -141)
	self:addElement(ObjectiveProgItem12)
	self.ObjectiveProgItem12 = ObjectiveProgItem12
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local13 = self
	CoD.ZMInventoryUtility.SetupNonlinearObjectiveProgressRingItems(self, f1_arg1)
	return self
end
CoD.ZMInvNonlinearObjectProgressRing.__onClose = function(f2_arg0)
	f2_arg0.ObjectiveProgItem1:close()
	f2_arg0.ObjectiveProgItem2:close()
	f2_arg0.ObjectiveProgItem3:close()
	f2_arg0.ObjectiveProgItem4:close()
	f2_arg0.ObjectiveProgItem5:close()
	f2_arg0.ObjectiveProgItem6:close()
	f2_arg0.ObjectiveProgItem7:close()
	f2_arg0.ObjectiveProgItem8:close()
	f2_arg0.ObjectiveProgItem9:close()
	f2_arg0.ObjectiveProgItem10:close()
	f2_arg0.ObjectiveProgItem11:close()
	f2_arg0.ObjectiveProgItem12:close()
end

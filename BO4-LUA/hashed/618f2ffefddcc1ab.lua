require("x64:5a4f90d93917af8")
CoD.AARTierRewardSlotEmptyContainer = InheritFrom(LUI.UIElement)
CoD.AARTierRewardSlotEmptyContainer.__defaultWidth = 1685
CoD.AARTierRewardSlotEmptyContainer.__defaultHeight = 631
CoD.AARTierRewardSlotEmptyContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardSlotEmptyContainer)
	self.id = "AARTierRewardSlotEmptyContainer"
	self.soundSet = "default"
	local EmptySlot12 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 229, 334, 0, 0, 495, 631)
	self:addElement(EmptySlot12)
	self.EmptySlot12 = EmptySlot12
	local EmptySlot11 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 229, 334, 0, 0, 348, 484)
	self:addElement(EmptySlot11)
	self.EmptySlot11 = EmptySlot11
	local EmptySlot10 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 229, 334, 0, 0, 201, 337)
	self:addElement(EmptySlot10)
	self.EmptySlot10 = EmptySlot10
	local EmptySlot09 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 229, 334, 0, 0, 54, 190)
	self:addElement(EmptySlot09)
	self.EmptySlot09 = EmptySlot09
	local EmptySlot08 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 114, 219, 0, 0, 495, 631)
	self:addElement(EmptySlot08)
	self.EmptySlot08 = EmptySlot08
	local EmptySlot07 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 114, 219, 0, 0, 201, 337)
	self:addElement(EmptySlot07)
	self.EmptySlot07 = EmptySlot07
	local EmptySlot06 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 114, 219, 0, 0, 348, 484)
	self:addElement(EmptySlot06)
	self.EmptySlot06 = EmptySlot06
	local EmptySlot05 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 114, 219, 0, 0, 54, 190)
	self:addElement(EmptySlot05)
	self.EmptySlot05 = EmptySlot05
	local EmptySlot04 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 0, 105, 0, 0, 495, 631)
	self:addElement(EmptySlot04)
	self.EmptySlot04 = EmptySlot04
	local EmptySlot03 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 0, 105, 0, 0, 348, 484)
	self:addElement(EmptySlot03)
	self.EmptySlot03 = EmptySlot03
	local EmptySlot02 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 0, 105, 0, 0, 201, 337)
	self:addElement(EmptySlot02)
	self.EmptySlot02 = EmptySlot02
	local EmptySlot01 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 0, 105, 0, 0, 54, 190)
	self:addElement(EmptySlot01)
	self.EmptySlot01 = EmptySlot01
	local EmptyCard04 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 1375, 1685, 0, 0, 0, 631)
	self:addElement(EmptyCard04)
	self.EmptyCard04 = EmptyCard04
	local EmptyCard03 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 1035, 1345, 0, 0, 0, 631)
	self:addElement(EmptyCard03)
	self.EmptyCard03 = EmptyCard03
	local EmptyCard02 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 695, 1005, 0, 0, 0, 631)
	self:addElement(EmptyCard02)
	self.EmptyCard02 = EmptyCard02
	local EmptyCard01 = CoD.AARTierRewardSlotEmpty.new(f1_arg0, f1_arg1, 0, 0, 355, 665, 0, 0, 0, 631)
	self:addElement(EmptyCard01)
	self.EmptyCard01 = EmptyCard01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardSlotEmptyContainer.__onClose = function(f2_arg0)
	f2_arg0.EmptySlot12:close()
	f2_arg0.EmptySlot11:close()
	f2_arg0.EmptySlot10:close()
	f2_arg0.EmptySlot09:close()
	f2_arg0.EmptySlot08:close()
	f2_arg0.EmptySlot07:close()
	f2_arg0.EmptySlot06:close()
	f2_arg0.EmptySlot05:close()
	f2_arg0.EmptySlot04:close()
	f2_arg0.EmptySlot03:close()
	f2_arg0.EmptySlot02:close()
	f2_arg0.EmptySlot01:close()
	f2_arg0.EmptyCard04:close()
	f2_arg0.EmptyCard03:close()
	f2_arg0.EmptyCard02:close()
	f2_arg0.EmptyCard01:close()
end

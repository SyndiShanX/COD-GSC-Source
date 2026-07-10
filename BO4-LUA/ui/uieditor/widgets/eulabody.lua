require("x64:d7e092479c7b82c")
CoD.eulaBody = InheritFrom(LUI.UIElement)
CoD.eulaBody.__defaultWidth = 1728
CoD.eulaBody.__defaultHeight = 700
CoD.eulaBody.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 15, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.eulaBody)
	self.id = "eulaBody"
	self.soundSet = "none"
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 1, -5, 5, 0, 0, -5, 705)
	self:addElement(Border)
	self.Border = Border
	local textEntry0 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 30)
	textEntry0:setText("")
	textEntry0:setTTF("dinnext_regular")
	textEntry0:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	textEntry0:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(textEntry0)
	self.textEntry0 = textEntry0
	local textEntry1 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 45, 75)
	textEntry1:setText("")
	textEntry1:setTTF("dinnext_regular")
	textEntry1:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	textEntry1:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(textEntry1)
	self.textEntry1 = textEntry1
	local textEntry2 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 90, 120)
	textEntry2:setText("")
	textEntry2:setTTF("dinnext_regular")
	textEntry2:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	textEntry2:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(textEntry2)
	self.textEntry2 = textEntry2
	local textEntry3 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 135, 165)
	textEntry3:setText("")
	textEntry3:setTTF("dinnext_regular")
	textEntry3:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	textEntry3:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(textEntry3)
	self.textEntry3 = textEntry3
	local textEntry4 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 180, 210)
	textEntry4:setText("")
	textEntry4:setTTF("dinnext_regular")
	textEntry4:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	textEntry4:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(textEntry4)
	self.textEntry4 = textEntry4
	local textEntry5 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 225, 255)
	textEntry5:setText("")
	textEntry5:setTTF("dinnext_regular")
	textEntry5:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	textEntry5:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(textEntry5)
	self.textEntry5 = textEntry5
	local textEntry6 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 270, 300)
	textEntry6:setText("")
	textEntry6:setTTF("dinnext_regular")
	textEntry6:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	textEntry6:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(textEntry6)
	self.textEntry6 = textEntry6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.eulaBody.__onClose = function(f2_arg0)
	f2_arg0.Border:close()
end

require("x64:acf82a98718baa9")
CoD.PurchasedContractsEmptySlots = InheritFrom(LUI.UIElement)
CoD.PurchasedContractsEmptySlots.__defaultWidth = 1288
CoD.PurchasedContractsEmptySlots.__defaultHeight = 601
CoD.PurchasedContractsEmptySlots.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PurchasedContractsEmptySlots)
	self.id = "PurchasedContractsEmptySlots"
	self.soundSet = "default"
	local EmptySlot02 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 435, 853, 0, 0, 0, 189)
	EmptySlot02:linkToElementModel(self, nil, false, function(model)
		EmptySlot02:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot02)
	self.EmptySlot02 = EmptySlot02
	local EmptySlot03 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 870, 1288, 0, 0, 0, 189)
	EmptySlot03:linkToElementModel(self, nil, false, function(model)
		EmptySlot03:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot03)
	self.EmptySlot03 = EmptySlot03
	local EmptySlot04 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 0, 418, 0, 0, 206, 395)
	EmptySlot04:linkToElementModel(self, nil, false, function(model)
		EmptySlot04:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot04)
	self.EmptySlot04 = EmptySlot04
	local EmptySlot05 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 435, 853, 0, 0, 206, 395)
	EmptySlot05:linkToElementModel(self, nil, false, function(model)
		EmptySlot05:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot05)
	self.EmptySlot05 = EmptySlot05
	local EmptySlot06 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 870, 1288, 0, 0, 206, 395)
	EmptySlot06:linkToElementModel(self, nil, false, function(model)
		EmptySlot06:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot06)
	self.EmptySlot06 = EmptySlot06
	local EmptySlot07 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 0, 418, 0, 0, 412, 601)
	EmptySlot07:linkToElementModel(self, nil, false, function(model)
		EmptySlot07:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot07)
	self.EmptySlot07 = EmptySlot07
	local EmptySlot08 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 435, 853, 0, 0, 412, 601)
	EmptySlot08:linkToElementModel(self, nil, false, function(model)
		EmptySlot08:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot08)
	self.EmptySlot08 = EmptySlot08
	local EmptySlot09 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 870, 1288, 0, 0, 412, 601)
	EmptySlot09:linkToElementModel(self, nil, false, function(model)
		EmptySlot09:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot09)
	self.EmptySlot09 = EmptySlot09
	local EmptySlot01 = CoD.CommonEmptySlot01.new(f1_arg0, f1_arg1, 0, 0, 0, 418, 0, 0, 0, 189)
	EmptySlot01:linkToElementModel(self, nil, false, function(model)
		EmptySlot01:setModel(model, f1_arg1)
	end)
	self:addElement(EmptySlot01)
	self.EmptySlot01 = EmptySlot01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PurchasedContractsEmptySlots.__onClose = function(f11_arg0)
	f11_arg0.EmptySlot02:close()
	f11_arg0.EmptySlot03:close()
	f11_arg0.EmptySlot04:close()
	f11_arg0.EmptySlot05:close()
	f11_arg0.EmptySlot06:close()
	f11_arg0.EmptySlot07:close()
	f11_arg0.EmptySlot08:close()
	f11_arg0.EmptySlot09:close()
	f11_arg0.EmptySlot01:close()
end

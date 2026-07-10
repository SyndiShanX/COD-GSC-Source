require("x64:cde4eb6b60deb3a")
CoD.WarzoneUseTimerDeposit = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerDeposit.__defaultWidth = 600
CoD.WarzoneUseTimerDeposit.__defaultHeight = 36
CoD.WarzoneUseTimerDeposit.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.WarzoneUseTimerDeposit)
	self.id = "WarzoneUseTimerDeposit"
	self.soundSet = "default"
	local ItemName = LUI.UIText.new(0, 0, 41.5, 558.5, 0, 0, 3, 33)
	ItemName:setText(Engine[0xF9F1239CFD921FE](0xB34D57746F21FD3))
	ItemName:setTTF("ttmussels_regular")
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ItemName:setBackingType(1)
	ItemName:setBackingWidget(CoD.WarzoneUseTimerRevivePlayerBG, f1_arg0, f1_arg1)
	ItemName:setBackingXPadding(8)
	ItemName:setBackingYPadding(2)
	self:addElement(ItemName)
	self.ItemName = ItemName
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end

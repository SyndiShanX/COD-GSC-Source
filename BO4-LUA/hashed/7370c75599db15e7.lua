require("x64:cde4eb6b60deb3a")
CoD.WarzoneUseTimerUsing = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerUsing.__defaultWidth = 600
CoD.WarzoneUseTimerUsing.__defaultHeight = 36
CoD.WarzoneUseTimerUsing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.WarzoneUseTimerUsing)
	self.id = "WarzoneUseTimerUsing"
	self.soundSet = "default"
	local ItemName = LUI.UIText.new(0, 0, 41.5, 558.5, 0, 0, 3, 33)
	ItemName:setTTF("ttmussels_regular")
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ItemName:setBackingType(1)
	ItemName:setBackingWidget(CoD.WarzoneUseTimerRevivePlayerBG, f1_arg0, f1_arg1)
	ItemName:setBackingXPadding(8)
	ItemName:setBackingYPadding(2)
	ItemName:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget1.name", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ItemName:setText(LocalizeIntoStringIfNotEmpty(0x2F42EC88F0ED2EC, f2_local0))
		end
	end)
	self:addElement(ItemName)
	self.ItemName = ItemName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneUseTimerUsing.__onClose = function(f3_arg0)
	f3_arg0.ItemName:close()
end

require("x64:c55b707438f4ac1")
require("x64:fbdc5cfbf53edf1")
CoD.MP_HardcoreInventoryWidget = InheritFrom(LUI.UIElement)
CoD.MP_HardcoreInventoryWidget.__defaultWidth = 117
CoD.MP_HardcoreInventoryWidget.__defaultHeight = 141
CoD.MP_HardcoreInventoryWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MP_HardcoreInventoryWidget)
	self.id = "MP_HardcoreInventoryWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HardcoreInventory = CoD.AmmoWidgetMP_HeldItem.new(f1_arg0, f1_arg1, 1, 1, -117, 0, 1, 1, -140, 0)
	HardcoreInventory:mergeStateConditions({
		{
			stateName = "WeaponDual",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	HardcoreInventory:setZoom(1)
	self:addElement(HardcoreInventory)
	self.HardcoreInventory = HardcoreInventory
	local HardcoreScorestreakWidget = CoD.MP_HardcoreScorestreakWidget.new(f1_arg0, f1_arg1, 1, 1, -300, 0, 1, 1, -191, -153)
	self:addElement(HardcoreScorestreakWidget)
	self.HardcoreScorestreakWidget = HardcoreScorestreakWidget
	self:mergeStateConditions({
		{
			stateName = "NotHardcore",
			condition = function(menu, element, event)
				return not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_hud_hardcore"])
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_hardcore"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MP_HardcoreInventoryWidget.__resetProperties = function(f5_arg0)
	f5_arg0.HardcoreInventory:completeAnimation()
	f5_arg0.HardcoreScorestreakWidget:completeAnimation()
	f5_arg0.HardcoreInventory:setAlpha(1)
	f5_arg0.HardcoreScorestreakWidget:setAlpha(1)
end
CoD.MP_HardcoreInventoryWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	NotHardcore = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.HardcoreInventory:completeAnimation()
			f7_arg0.HardcoreInventory:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.HardcoreInventory)
			f7_arg0.HardcoreScorestreakWidget:completeAnimation()
			f7_arg0.HardcoreScorestreakWidget:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.HardcoreScorestreakWidget)
		end,
	},
}
CoD.MP_HardcoreInventoryWidget.__onClose = function(f8_arg0)
	f8_arg0.HardcoreInventory:close()
	f8_arg0.HardcoreScorestreakWidget:close()
end

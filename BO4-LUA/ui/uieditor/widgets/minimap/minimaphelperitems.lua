CoD.MinimapHelperItems = InheritFrom(LUI.UIElement)
CoD.MinimapHelperItems.__defaultWidth = 1081
CoD.MinimapHelperItems.__defaultHeight = 1081
CoD.MinimapHelperItems.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MinimapHelperItems)
	self.id = "MinimapHelperItems"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local items = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	items:setupCompassItems(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(items)
	self.items = items
	self:mergeStateConditions({
		{
			stateName = "CounterUAV",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_counter_uav_active"])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_counter_uav_active"]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_counter_uav_active"],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MinimapHelperItems.__resetProperties = function(f4_arg0)
	f4_arg0.items:completeAnimation()
	f4_arg0.items:setAlpha(1)
end
CoD.MinimapHelperItems.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.items:completeAnimation()
			f5_arg0.items:setAlpha(0.95)
			f5_arg0.clipFinished(f5_arg0.items)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	CounterUAV = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.items:completeAnimation()
			f6_arg0.items:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.items)
		end,
	},
}

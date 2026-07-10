CoD.Rush_playercard_position_indicator = InheritFrom(LUI.UIElement)
CoD.Rush_playercard_position_indicator.__defaultWidth = 15
CoD.Rush_playercard_position_indicator.__defaultHeight = 36
CoD.Rush_playercard_position_indicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Rush_playercard_position_indicator)
	self.id = "Rush_playercard_position_indicator"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NumberBg = LUI.UIImage.new(0, 0, -19.5, 25.5, 0, 0, -13, 47)
	NumberBg:setImage(RegisterImage(0x75D661B612187DF))
	self:addElement(NumberBg)
	self.NumberBg = NumberBg
	local PositionText = LUI.UIText.new(0, 0, -1, 14, 0, 0, 7, 40)
	PositionText:setText(CoD.ZombieUtility.GetZombiesRushPositionForIndex(f1_arg1, 1))
	PositionText:setTTF("skorzhen")
	PositionText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(PositionText)
	self.PositionText = PositionText
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "Clients.clientCount", 1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["Clients.clientCount"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "Clients.clientCount",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Rush_playercard_position_indicator.__resetProperties = function(f4_arg0)
	f4_arg0.PositionText:completeAnimation()
	f4_arg0.NumberBg:completeAnimation()
	f4_arg0.PositionText:setAlpha(1)
	f4_arg0.NumberBg:setAlpha(1)
end
CoD.Rush_playercard_position_indicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.NumberBg:completeAnimation()
			f5_arg0.NumberBg:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.NumberBg)
			f5_arg0.PositionText:completeAnimation()
			f5_arg0.PositionText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PositionText)
		end,
	},
	Show = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}

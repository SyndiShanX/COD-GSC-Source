CoD.PrematchCountdown_2xpBadge = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_2xpBadge.__defaultWidth = 192
CoD.PrematchCountdown_2xpBadge.__defaultHeight = 192
CoD.PrematchCountdown_2xpBadge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_2xpBadge)
	self.id = "PrematchCountdown_2xpBadge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPIcon = LUI.UIImage.new(0, 0, 0, 192, 0, 0, 0, 192)
	DoubleXPIcon:setImage(RegisterImage(@"ui_icon_2xp_large"))
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	self:mergeStateConditions({
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PrematchCountdown_2xpBadge.__resetProperties = function(f4_arg0)
	f4_arg0.DoubleXPIcon:completeAnimation()
	f4_arg0.DoubleXPIcon:setImage(RegisterImage(@"ui_icon_2xp_large"))
end
CoD.PrematchCountdown_2xpBadge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	WZ = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DoubleXPIcon:completeAnimation()
			f6_arg0.DoubleXPIcon:setImage(RegisterImage(@"ui_icon_2xp_warzone_large"))
			f6_arg0.clipFinished(f6_arg0.DoubleXPIcon)
		end,
	},
}

CoD.Notification2xpReward = InheritFrom(LUI.UIElement)
CoD.Notification2xpReward.__defaultWidth = 72
CoD.Notification2xpReward.__defaultHeight = 72
CoD.Notification2xpReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Notification2xpReward)
	self.id = "Notification2xpReward"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XpSmall = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	XpSmall:setImage(RegisterImage("ui_icon_2xp"))
	self:addElement(XpSmall)
	self.XpSmall = XpSmall
	self:mergeStateConditions({
		{
			stateName = "VisibleWZ",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1) and IsWarzone()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if not CoD.BaseUtility.IsSelfInEitherState(self, "Visible", "VisibleWZ") then
			HideWidget(self)
		else
			ShowWidget(self)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Notification2xpReward.__resetProperties = function(f6_arg0)
	f6_arg0.XpSmall:completeAnimation()
	f6_arg0.XpSmall:setAlpha(1)
	f6_arg0.XpSmall:setImage(RegisterImage("ui_icon_2xp"))
end
CoD.Notification2xpReward.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.XpSmall:completeAnimation()
			f7_arg0.XpSmall:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.XpSmall)
		end,
	},
	VisibleWZ = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.XpSmall:completeAnimation()
			f8_arg0.XpSmall:setImage(RegisterImage("ui_icon_2xp_warzone"))
			f8_arg0.clipFinished(f8_arg0.XpSmall)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.XpSmall:completeAnimation()
			f9_arg0.XpSmall:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.XpSmall)
		end,
	},
}

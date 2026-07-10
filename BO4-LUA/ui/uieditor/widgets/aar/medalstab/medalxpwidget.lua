require("x64:f72d4606ccc678a")
CoD.MedalXpWidget = InheritFrom(LUI.UIElement)
CoD.MedalXpWidget.__defaultWidth = 400
CoD.MedalXpWidget.__defaultHeight = 69
CoD.MedalXpWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MedalXpWidget)
	self.id = "MedalXpWidget"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XpIcon = LUI.UIImage.new(0, 0, 0, 69, 0, 0, 0, 69)
	XpIcon:setImage(RegisterImage(@"uie_t7_hud_mp_notifications_xp"))
	self:addElement(XpIcon)
	self.XpIcon = XpIcon
	local XpValue = LUI.UIText.new(0, 0, 84, 376, 0, 0, 12, 57)
	XpValue:setRGB(0.98, 0.77, 0.2)
	XpValue:setText("")
	XpValue:setTTF("ttmussels_demibold")
	XpValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	XpValue:setShaderVector(0, 0.71, 0, 0, 0)
	XpValue:setShaderVector(1, 0, 0, 0, 0)
	XpValue:setShaderVector(2, 1, 0.88, 0.01, 0.12)
	XpValue:setLetterSpacing(4)
	XpValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(XpValue)
	self.XpValue = XpValue
	local Notification2xpReward = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, -2, 70, 0, 0, -2, 70)
	Notification2xpReward:setAlpha(0)
	self:addElement(Notification2xpReward)
	self.Notification2xpReward = Notification2xpReward
	local MeritIcon = LUI.UIImage.new(0, 0, -1.5, 70.5, 0, 0, -1.5, 70.5)
	MeritIcon:setAlpha(0)
	MeritIcon:setImage(RegisterImage(@"ui_icon_wz_merrit_small"))
	self:addElement(MeritIcon)
	self.MeritIcon = MeritIcon
	self:mergeStateConditions({
		{
			stateName = "VisibleWarzone",
			condition = function(menu, element, event)
				local f2_local0 = IsPublicOnlineGame()
				if f2_local0 then
					if not IsDoubleXP(f1_arg1) then
						f2_local0 = IsWarzone()
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsPublicOnlineGame() and not IsDoubleXP(f1_arg1)
			end,
		},
		{
			stateName = "DoubleXP",
			condition = function(menu, element, event)
				return IsPublicOnlineGame() and IsDoubleXP(f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MedalXpWidget.__resetProperties = function(f6_arg0)
	f6_arg0.XpIcon:completeAnimation()
	f6_arg0.XpValue:completeAnimation()
	f6_arg0.MeritIcon:completeAnimation()
	f6_arg0.Notification2xpReward:completeAnimation()
	f6_arg0.XpIcon:setAlpha(1)
	f6_arg0.XpValue:setAlpha(1)
	f6_arg0.MeritIcon:setAlpha(0)
	f6_arg0.Notification2xpReward:setAlpha(0)
end
CoD.MedalXpWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.XpIcon:completeAnimation()
			f7_arg0.XpIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.XpIcon)
			f7_arg0.XpValue:completeAnimation()
			f7_arg0.XpValue:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.XpValue)
		end,
	},
	VisibleWarzone = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.XpIcon:completeAnimation()
			f8_arg0.XpIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.XpIcon)
			f8_arg0.XpValue:completeAnimation()
			f8_arg0.XpValue:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
			f8_arg0.clipFinished(f8_arg0.XpValue)
			f8_arg0.MeritIcon:completeAnimation()
			f8_arg0.MeritIcon:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.MeritIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	DoubleXP = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.XpIcon:completeAnimation()
			f10_arg0.XpIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.XpIcon)
			f10_arg0.Notification2xpReward:completeAnimation()
			f10_arg0.Notification2xpReward:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Notification2xpReward)
		end,
	},
}
CoD.MedalXpWidget.__onClose = function(f11_arg0)
	f11_arg0.Notification2xpReward:close()
end

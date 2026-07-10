require("x64:a5e90c41ecad3fd")
CoD.wz_wingsuit_hud = InheritFrom(CoD.Menu)
LUI.createMenu.wz_wingsuit_hud = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("wz_wingsuit_hud", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.wz_wingsuit_hud)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local f1_local2 = nil
	self.Backing = LUI.UIElement.createFake()
	local f1_local3 = nil
	self.RightStick = LUI.UIElement.createFake()
	local f1_local4 = nil
	self.LeftTrigger = LUI.UIElement.createFake()
	local f1_local5 = nil
	self.LeftStick = LUI.UIElement.createFake()
	local hudPC = nil
	hudPC = CoD.HUD_PC_Wingsuit.new(f1_local1, f1_arg0, 0.5, 0.5, -247.5, 247.5, 1, 1, -275, -210)
	self:addElement(hudPC)
	self.hudPC = hudPC
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0
				if Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					if not f2_local0 then
						f2_local0 = Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
					end
				else
					f2_local0 = true
				end
				return f2_local0
			end,
		},
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg0, "wzHideOnScreenButtonsUI", "warzoneHideOnScreenButtons")
			end,
		},
		{
			stateName = "TheaterMode",
			condition = function(menu, element, event)
				return IsInTheaterMode() and IsPC()
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, f1_local9.PlayerSettingsUpdate, function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.wz_wingsuit_hud.__resetProperties = function(f10_arg0)
	f10_arg0.Backing:completeAnimation()
	f10_arg0.RightStick:completeAnimation()
	f10_arg0.LeftTrigger:completeAnimation()
	f10_arg0.LeftStick:completeAnimation()
	f10_arg0.hudPC:completeAnimation()
	f10_arg0.Backing:setAlpha(1)
	f10_arg0.RightStick:setAlpha(1)
	f10_arg0.LeftTrigger:setAlpha(1)
	f10_arg0.LeftStick:setAlpha(1)
	f10_arg0.hudPC:setAlpha(1)
end
CoD.wz_wingsuit_hud.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(279)
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.Backing:beginAnimation(8020)
				f11_arg0.Backing:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Backing:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(1)
			f11_local0(f11_arg0.Backing)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(279)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.RightStick:beginAnimation(8020)
				f11_arg0.RightStick:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.RightStick:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.RightStick:completeAnimation()
			f11_arg0.RightStick:setAlpha(1)
			f11_local1(f11_arg0.RightStick)
			local f11_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(279)
					f17_arg0:setAlpha(0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.LeftTrigger:beginAnimation(8020)
				f11_arg0.LeftTrigger:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LeftTrigger:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f11_arg0.LeftTrigger:completeAnimation()
			f11_arg0.LeftTrigger:setAlpha(1)
			f11_local2(f11_arg0.LeftTrigger)
			local f11_local3 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(279)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.LeftStick:beginAnimation(8020)
				f11_arg0.LeftStick:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LeftStick:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f11_arg0.LeftStick:completeAnimation()
			f11_arg0.LeftStick:setAlpha(1)
			f11_local3(f11_arg0.LeftStick)
		end,
	},
	Hidden = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.Backing:completeAnimation()
			f20_arg0.Backing:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Backing)
			f20_arg0.RightStick:completeAnimation()
			f20_arg0.RightStick:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.RightStick)
			f20_arg0.LeftTrigger:completeAnimation()
			f20_arg0.LeftTrigger:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.LeftTrigger)
			f20_arg0.LeftStick:completeAnimation()
			f20_arg0.LeftStick:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.LeftStick)
			f20_arg0.hudPC:completeAnimation()
			f20_arg0.hudPC:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.hudPC)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.Backing:completeAnimation()
			f21_arg0.Backing:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Backing)
			f21_arg0.RightStick:completeAnimation()
			f21_arg0.RightStick:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.RightStick)
			f21_arg0.LeftTrigger:completeAnimation()
			f21_arg0.LeftTrigger:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.LeftTrigger)
			f21_arg0.LeftStick:completeAnimation()
			f21_arg0.LeftStick:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.LeftStick)
			f21_arg0.hudPC:completeAnimation()
			f21_arg0.hudPC:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.hudPC)
		end,
	},
	TheaterMode = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.Backing:completeAnimation()
			f22_arg0.Backing:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Backing)
			f22_arg0.RightStick:completeAnimation()
			f22_arg0.RightStick:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.RightStick)
			f22_arg0.LeftTrigger:completeAnimation()
			f22_arg0.LeftTrigger:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LeftTrigger)
			f22_arg0.LeftStick:completeAnimation()
			f22_arg0.LeftStick:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.LeftStick)
			f22_arg0.hudPC:completeAnimation()
			f22_arg0.hudPC:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.hudPC)
		end,
	},
}
CoD.wz_wingsuit_hud.__onClose = function(f23_arg0)
	f23_arg0.Backing:close()
	f23_arg0.RightStick:close()
	f23_arg0.LeftTrigger:close()
	f23_arg0.LeftStick:close()
	f23_arg0.hudPC:close()
end

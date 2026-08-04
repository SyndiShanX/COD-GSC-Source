CoD.CommonXpIcon = InheritFrom(LUI.UIElement)
CoD.CommonXpIcon.__defaultWidth = 50
CoD.CommonXpIcon.__defaultHeight = 50
CoD.CommonXpIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonXpIcon)
	self.id = "CommonXpIcon"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Icon:setImage(RegisterImage("t7_hud_mp_notifications_xp_blue"))
	self:addElement(Icon)
	self.Icon = Icon
	self:mergeStateConditions({
		{
			stateName = "DoubleXPWZ",
			condition = function(menu, element, event)
				return IsWarzone() and CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f1_arg1)
			end,
		},
		{
			stateName = "DoubleXP",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f1_arg1)
			end,
		},
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4["lobbyRoot.playlistId"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.playlistId",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.cycled, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonXpIcon.__resetProperties = function(f8_arg0)
	f8_arg0.Icon:completeAnimation()
	f8_arg0.Icon:setImage(RegisterImage("t7_hud_mp_notifications_xp_blue"))
end
CoD.CommonXpIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	DoubleXPWZ = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Icon:completeAnimation()
			f10_arg0.Icon:setImage(RegisterImage("ui_icon_2xp_warzone"))
			f10_arg0.clipFinished(f10_arg0.Icon)
		end,
	},
	DoubleXP = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Icon:completeAnimation()
			f11_arg0.Icon:setImage(RegisterImage("ui_icon_2xp"))
			f11_arg0.clipFinished(f11_arg0.Icon)
		end,
	},
	WZ = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Icon:completeAnimation()
			f12_arg0.Icon:setImage(RegisterImage("ui_icon_wz_merrit_small"))
			f12_arg0.clipFinished(f12_arg0.Icon)
		end,
	},
}

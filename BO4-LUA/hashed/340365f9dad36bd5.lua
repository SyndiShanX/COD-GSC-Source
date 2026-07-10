CoD.self_revive_visuals_rush = InheritFrom(CoD.Menu)
LUI.createMenu.self_revive_visuals_rush = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("self_revive_visuals_rush", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.self_revive_visuals_rush)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local countdownText = LUI.UIText.new(0, 0, 860, 1060, 0, 0, 586, 623)
	countdownText:setTTF("skorzhen")
	countdownText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	countdownText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	countdownText:linkToElementModel(self, "revive_time", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			countdownText:setText(FormatAutoReviveCountdown(f2_local0))
		end
	end)
	self:addElement(countdownText)
	self.countdownText = countdownText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6])
				if not f3_local0 then
					f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					if not f3_local0 then
						f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
						if not f3_local0 then
							f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
							if not f3_local0 then
								f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xC57360571B0917E])
							end
						end
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6]], function(f4_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
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
CoD.self_revive_visuals_rush.__resetProperties = function(f9_arg0)
	f9_arg0.countdownText:completeAnimation()
	f9_arg0.countdownText:setAlpha(1)
end
CoD.self_revive_visuals_rush.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.countdownText:completeAnimation()
			f11_arg0.countdownText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.countdownText)
		end,
	},
}
CoD.self_revive_visuals_rush.__onClose = function(f12_arg0)
	f12_arg0.countdownText:close()
end

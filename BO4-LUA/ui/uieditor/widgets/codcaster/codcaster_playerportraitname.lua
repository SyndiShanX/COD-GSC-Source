CoD.codcaster_playerPortraitName = InheritFrom(LUI.UIElement)
CoD.codcaster_playerPortraitName.__defaultWidth = 120
CoD.codcaster_playerPortraitName.__defaultHeight = 17
CoD.codcaster_playerPortraitName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcaster_playerPortraitName)
	self.id = "codcaster_playerPortraitName"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerListEntryPlayerName = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 17)
	PlayerListEntryPlayerName:setTTF("notosans_bold")
	PlayerListEntryPlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerListEntryPlayerName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	PlayerListEntryPlayerName:linkToElementModel(self, "playerName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerListEntryPlayerName:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(PlayerListEntryPlayerName)
	self.PlayerListEntryPlayerName = PlayerListEntryPlayerName
	self:mergeStateConditions({
		{
			stateName = "PlayerDead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return IsScoreboardPlayerSelf(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["deadSpectator.playerIndex"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcaster_playerPortraitName.__resetProperties = function(f9_arg0)
	f9_arg0.PlayerListEntryPlayerName:completeAnimation()
	f9_arg0.PlayerListEntryPlayerName:setRGB(1, 1, 1)
	f9_arg0.PlayerListEntryPlayerName:setAlpha(1)
end
CoD.codcaster_playerPortraitName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.PlayerListEntryPlayerName:completeAnimation()
			f10_arg0.PlayerListEntryPlayerName:setRGB(1, 1, 1)
			f10_arg0.clipFinished(f10_arg0.PlayerListEntryPlayerName)
		end,
	},
	PlayerDead = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.PlayerListEntryPlayerName:completeAnimation()
			f11_arg0.PlayerListEntryPlayerName:setAlpha(0.1)
			f11_arg0.clipFinished(f11_arg0.PlayerListEntryPlayerName)
		end,
	},
	Selected = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.PlayerListEntryPlayerName:completeAnimation()
			f12_arg0.PlayerListEntryPlayerName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f12_arg0.clipFinished(f12_arg0.PlayerListEntryPlayerName)
		end,
	},
}
CoD.codcaster_playerPortraitName.__onClose = function(f13_arg0)
	f13_arg0.PlayerListEntryPlayerName:close()
end

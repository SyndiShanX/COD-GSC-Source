require("x64:649d831248f76c2")
CoD.PlayerCard_Callout = InheritFrom(LUI.UIElement)
CoD.PlayerCard_Callout.__defaultWidth = 414
CoD.PlayerCard_Callout.__defaultHeight = 88
CoD.PlayerCard_Callout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerCard_Callout)
	self.id = "PlayerCard_Callout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerCard = CoD.PlayerCard.new(f1_arg0, f1_arg1, 0, 0, 0, 414, 0, 0, 0, 88)
	PlayerCard:mergeStateConditions({
		{
			stateName = "Emblem",
			condition = function(menu, element, event)
				local f2_local0
				if not IsLobbyNetworkModeLAN() then
					f2_local0 = AlwaysFalse()
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "Calingcard",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN() and AlwaysTrue()
			end,
		},
	})
	local f1_local2 = PlayerCard
	local f1_local3 = PlayerCard.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(PlayerCard, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	PlayerCard:subscribeToGlobalModel(f1_arg1, "PlayerCallout", nil, function(model)
		PlayerCard:setModel(model, f1_arg1)
	end)
	PlayerCard:linkToElementModel(self, "playerName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			PlayerCard.GamerTag.itemName:setText(CoD.SocialUtility.CleanGamerTag(f6_local0))
		end
	end)
	self:addElement(PlayerCard)
	self.PlayerCard = PlayerCard
	self:mergeStateConditions({
		{
			stateName = "HideForCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_calloutcards", 1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f8_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"])
				if not f8_local0 then
					f8_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"])
				end
				return f8_local0
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["factions.isCoDCaster"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.profileSettingsUpdated, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f13_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"player_callout") then
			CoD.HUDUtility.ProcessPlayerCallout(f13_local0, f1_arg1, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_22B5B25BE43AD2D7") then
			CoD.HUDUtility.ProcessPlayerCalloutWithColon(f13_local0, f1_arg1, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_2A3C608F65B1CEAD") then
			CoD.HUDUtility.ProcessPlayerCalloutWithNumber(f13_local0, f1_arg1, model)
		end
	end)
	PlayerCard.id = "PlayerCard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerCard_Callout.__resetProperties = function(f14_arg0)
	f14_arg0.PlayerCard:completeAnimation()
	f14_arg0.PlayerCard:setLeftRight(0, 0, 0, 414)
	f14_arg0.PlayerCard:setTopBottom(0, 0, 0, 88)
	f14_arg0.PlayerCard:setAlpha(1)
end
CoD.PlayerCard_Callout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.PlayerCard:completeAnimation()
			f15_arg0.PlayerCard:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PlayerCard)
		end,
		Side = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							local f20_local0 = function(f21_arg0)
								f21_arg0:beginAnimation(39)
								f21_arg0:setAlpha(0)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
							end
							f20_arg0:beginAnimation(50)
							f20_arg0:setAlpha(1)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(49, Enum[@"luitween"][@"luitween_ease_both"])
						f19_arg0:setAlpha(0)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(2280)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f16_arg0.PlayerCard:beginAnimation(270, Enum[@"luitween"][@"luitween_ease_out"])
				f16_arg0.PlayerCard:setLeftRight(0, 0, 0, 414)
				f16_arg0.PlayerCard:setAlpha(1)
				f16_arg0.PlayerCard:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.PlayerCard:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.PlayerCard:completeAnimation()
			f16_arg0.PlayerCard:setLeftRight(0, 0, -348, 66)
			f16_arg0.PlayerCard:setTopBottom(0, 0, 0, 88)
			f16_arg0.PlayerCard:setAlpha(0)
			f16_local0(f16_arg0.PlayerCard)
		end,
	},
	HideForCodCaster = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.PlayerCard:completeAnimation()
			f22_arg0.PlayerCard:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.PlayerCard)
		end,
	},
	Hidden = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.PlayerCard:completeAnimation()
			f23_arg0.PlayerCard:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PlayerCard)
		end,
	},
}
CoD.PlayerCard_Callout.__onClose = function(f24_arg0)
	f24_arg0.PlayerCard:close()
end

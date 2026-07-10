require("x64:8293fdfde8af5f3")
require("x64:76cc25e6b842a01")
CoD.revive_hud = InheritFrom(CoD.Menu)
LUI.createMenu.revive_hud = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("revive_hud", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.revive_hud)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0.5, 0.5, -960, 960, 1, 1, -284, -248)
	TextBox:setTTF("notosans_regular")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TextBox:setBackingType(1)
	TextBox:setBackingWidget(CoD.ObituaryBlurBacking, f1_local1, f1_arg0)
	TextBox:setBackingColor(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TextBox:setBackingAlpha(0.99)
	TextBox:setBackingXPadding(14)
	TextBox:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	local UseTimer = CoD.WarzoneUseTimer.new(f1_local1, f1_arg0, 0.5, 0.5, -300, 300, 1, 1, -370, -290)
	UseTimer:mergeStateConditions({
		{
			stateName = "Healing",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg0, "playerAbilities.PlayerGadget1.powerRatio", 0)
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg0, "playerAbilities.playerGadget1.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
					if f3_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_player_dead"]) then
							f3_local0 = not IsZombies()
						else
							f3_local0 = false
						end
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Reviving",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg0, "hudItems.laststand.reviveProgress", 0) and not IsZombies()
			end,
		},
		{
			stateName = "BeingRevived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "hudItems.laststand.beingRevived", 1) and not IsZombies()
			end,
		},
		{
			stateName = "Deposit",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg0, "hudItems.dynEntUseHoldProgress", 0)
				if f6_local0 then
					f6_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg0, "hudItems.depositing", 0)
					if f6_local0 then
						f6_local0 = not IsZombies()
					end
				end
				return f6_local0
			end,
		},
	})
	local f1_local4 = UseTimer
	local f1_local5 = UseTimer.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["playerAbilities.PlayerGadget1.powerRatio"], function(f7_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "playerAbilities.PlayerGadget1.powerRatio",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["playerAbilities.playerGadget1.state"], function(f8_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "playerAbilities.playerGadget1.state",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f9_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.laststand.reviveProgress"], function(f11_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "hudItems.laststand.reviveProgress",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.laststand.beingRevived"], function(f12_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.laststand.beingRevived",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.lastStand.progress"], function(f13_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "hudItems.lastStand.progress",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.lastStand.beingRevived"], function(f14_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "hudItems.lastStand.beingRevived",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f15_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.beingFinished"], function(f16_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "hudItems.beingFinished",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.dynEntUseHoldProgress"], function(f17_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "hudItems.dynEntUseHoldProgress",
		})
	end, false)
	f1_local4 = UseTimer
	f1_local5 = UseTimer.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["hudItems.depositing"], function(f18_arg0)
		f1_local1:updateElementState(UseTimer, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.depositing",
		})
	end, false)
	self:addElement(UseTimer)
	self.UseTimer = UseTimer
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
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
	f1_local5 = self
	CoD.HUDUtility.SetupReviveHud(self, self.TextBox, f1_arg0)
	return self
end
CoD.revive_hud.__resetProperties = function(f21_arg0)
	f21_arg0.TextBox:completeAnimation()
	f21_arg0.TextBox:setAlpha(1)
end
CoD.revive_hud.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.TextBox:completeAnimation()
			f22_arg0.TextBox:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.TextBox)
		end,
		Visible = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.TextBox:beginAnimation(200, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f23_arg0.TextBox:setAlpha(1)
				f23_arg0.TextBox:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.TextBox:completeAnimation()
			f23_arg0.TextBox:setAlpha(0)
			f23_local0(f23_arg0.TextBox)
		end,
	},
	Visible = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.TextBox:completeAnimation()
			f25_arg0.TextBox:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.TextBox)
		end,
		DefaultState = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.TextBox:beginAnimation(400)
				f26_arg0.TextBox:setAlpha(0)
				f26_arg0.TextBox:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.TextBox:completeAnimation()
			f26_arg0.TextBox:setAlpha(1)
			f26_local0(f26_arg0.TextBox)
		end,
	},
}
CoD.revive_hud.__onClose = function(f28_arg0)
	f28_arg0.TextBox:close()
	f28_arg0.UseTimer:close()
end

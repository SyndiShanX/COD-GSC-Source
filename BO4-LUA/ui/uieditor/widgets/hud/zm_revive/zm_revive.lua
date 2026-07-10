require("x64:98e888b7d3db378")
require("x64:7d31d988677643")
CoD.ZM_Revive = InheritFrom(LUI.UIElement)
CoD.ZM_Revive.__defaultWidth = 1
CoD.ZM_Revive.__defaultHeight = 1
CoD.ZM_Revive.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZM_Revive)
	self.id = "ZM_Revive"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local playerName = LUI.UIText.new(0, 0, 134, 402, 0, 0, -66, 9)
	playerName:setRGB(1, 0.75, 0.44)
	playerName:setTTF("notosans_regular")
	playerName:setLetterSpacing(1)
	playerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	playerName:linkToElementModel(self, "playerName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			playerName:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(playerName)
	self.playerName = playerName
	local prompt = LUI.UIText.new(0, 0, 133, 267, 0, 0, 4, 64)
	prompt:setTTF("dinnext_regular")
	prompt:setLetterSpacing(1)
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	prompt:linkToElementModel(self, "prompt", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			prompt:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(prompt)
	self.prompt = prompt
	local ZMReviveWidget = CoD.ZM_ReviveWidget.new(f1_arg0, f1_arg1, 0, 0, -164, 166, 0, 0, -165, 165)
	ZMReviveWidget:linkToElementModel(self, nil, false, function(model)
		ZMReviveWidget:setModel(model, f1_arg1)
	end)
	self:addElement(ZMReviveWidget)
	self.ZMReviveWidget = ZMReviveWidget
	local ZMReviveClampedArrow = CoD.ZM_ReviveClampedArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -178, 212, 0.5, 0.5, -48, 48)
	ZMReviveClampedArrow:linkToElementModel(self, "arrowAngle", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ZMReviveClampedArrow:setZRot(f5_local0)
		end
	end)
	self:addElement(ZMReviveClampedArrow)
	self.ZMReviveClampedArrow = ZMReviveClampedArrow
	local revivingText = LUI.UIText.new(0, 0, -300, 300, 0, 0, 180, 260)
	revivingText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/reviving"))
	revivingText:setTTF("notosans_bold")
	revivingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	revivingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(revivingText)
	self.revivingText = revivingText
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "hide", 1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f7_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
				if f7_local0 then
					f7_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
					if f7_local0 then
						f7_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden")
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "Clamped",
			condition = function(menu, element, event)
				local f8_local0 = IsBleedOutVisible(element, f1_arg1)
				if f8_local0 then
					f8_local0 = CoD.ModelUtility.IsSelfModelValueEnumBitSet(element, f1_arg1, "stateFlags", Enum[@"bleedoutstateflags"][@"bleedout_state_flag_clamped"])
					if f8_local0 then
						f8_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("zstandard")
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "Visible_Reviving",
			condition = function(menu, element, event)
				local f9_local0 = IsBleedOutVisible(element, f1_arg1)
				if f9_local0 then
					f9_local0 = CoD.ModelUtility.IsSelfModelValueEnumBitSet(element, f1_arg1, "stateFlags", Enum[@"bleedoutstateflags"][@"bleedout_state_flag_being_revived"])
					if f9_local0 then
						f9_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("zstandard")
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsBleedOutVisible(element, f1_arg1) and not CoD.HUDUtility.IsGameTypeEqualToString("zstandard")
			end,
		},
	})
	self:linkToElementModel(self, "hide", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hide",
		})
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["ZMHudGlobal.trials.hudDeactivated"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ZMHudGlobal.trials.hudDeactivated",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["ZMHudGlobal.trials.infoHidden"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "ZMHudGlobal.trials.infoHidden",
		})
	end, false)
	self:linkToElementModel(self, "bleedingOut", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bleedingOut",
		})
	end)
	self:linkToElementModel(self, "beingRevived", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "beingRevived",
		})
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	self:linkToElementModel(self, "stateFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stateFlags",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZM_Revive.__resetProperties = function(f18_arg0)
	f18_arg0.playerName:completeAnimation()
	f18_arg0.prompt:completeAnimation()
	f18_arg0.ZMReviveClampedArrow:completeAnimation()
	f18_arg0.revivingText:completeAnimation()
	f18_arg0.ZMReviveWidget:completeAnimation()
	f18_arg0.playerName:setAlpha(1)
	f18_arg0.prompt:setAlpha(1)
	f18_arg0.ZMReviveClampedArrow:setAlpha(1)
	f18_arg0.revivingText:setAlpha(1)
	f18_arg0.ZMReviveWidget:setAlpha(1)
end
CoD.ZM_Revive.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.playerName:completeAnimation()
			f19_arg0.playerName:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.playerName)
			f19_arg0.prompt:completeAnimation()
			f19_arg0.prompt:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.prompt)
			f19_arg0.ZMReviveClampedArrow:completeAnimation()
			f19_arg0.ZMReviveClampedArrow:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ZMReviveClampedArrow)
			f19_arg0.revivingText:completeAnimation()
			f19_arg0.revivingText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.revivingText)
		end,
	},
	Hide = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.playerName:completeAnimation()
			f20_arg0.playerName:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.playerName)
			f20_arg0.prompt:completeAnimation()
			f20_arg0.prompt:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.prompt)
			f20_arg0.ZMReviveWidget:completeAnimation()
			f20_arg0.ZMReviveWidget:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ZMReviveWidget)
			f20_arg0.ZMReviveClampedArrow:completeAnimation()
			f20_arg0.ZMReviveClampedArrow:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ZMReviveClampedArrow)
			f20_arg0.revivingText:completeAnimation()
			f20_arg0.revivingText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.revivingText)
		end,
	},
	Hidden = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(5)
			f21_arg0.playerName:completeAnimation()
			f21_arg0.playerName:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.playerName)
			f21_arg0.prompt:completeAnimation()
			f21_arg0.prompt:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.prompt)
			f21_arg0.ZMReviveWidget:completeAnimation()
			f21_arg0.ZMReviveWidget:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ZMReviveWidget)
			f21_arg0.ZMReviveClampedArrow:completeAnimation()
			f21_arg0.ZMReviveClampedArrow:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ZMReviveClampedArrow)
			f21_arg0.revivingText:completeAnimation()
			f21_arg0.revivingText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.revivingText)
		end,
	},
	Clamped = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.playerName:completeAnimation()
			f22_arg0.playerName:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.playerName)
			f22_arg0.prompt:completeAnimation()
			f22_arg0.prompt:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.prompt)
			f22_arg0.revivingText:completeAnimation()
			f22_arg0.revivingText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.revivingText)
		end,
	},
	Visible_Reviving = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.playerName:completeAnimation()
			f23_arg0.playerName:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.playerName)
			f23_arg0.prompt:completeAnimation()
			f23_arg0.prompt:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.prompt)
			f23_arg0.ZMReviveClampedArrow:completeAnimation()
			f23_arg0.ZMReviveClampedArrow:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ZMReviveClampedArrow)
		end,
	},
	Visible = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.ZMReviveClampedArrow:completeAnimation()
			f24_arg0.ZMReviveClampedArrow:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ZMReviveClampedArrow)
			f24_arg0.revivingText:completeAnimation()
			f24_arg0.revivingText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.revivingText)
		end,
	},
}
CoD.ZM_Revive.__onClose = function(f25_arg0)
	f25_arg0.playerName:close()
	f25_arg0.prompt:close()
	f25_arg0.ZMReviveWidget:close()
	f25_arg0.ZMReviveClampedArrow:close()
end

require("x64:d6f270af29a0a26")
require("x64:9b3bd854cbba790")
CoD.wz_revive_prompt = InheritFrom(CoD.Menu)
LUI.createMenu.wz_revive_prompt = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("wz_revive_prompt", f1_arg0)
	local f1_local1 = self
	CoD.HUDUtility.InitLuiElemSelfModel(self, "clamped", false)
	CoD.HUDUtility.InitLuiElemSelfModel(self, "direction", 0)
	self:setClass(CoD.wz_revive_prompt)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local playerName = LUI.UIText.new(0.5, 0.5, -134, 134, 0, 0, -177, -147)
	playerName:setTTF("notosans_bold")
	playerName:setLetterSpacing(1)
	playerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	playerName:linkToElementModel(self, "clientnum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			playerName:setText(GetClientNameAndClanTag(f1_arg0, f2_local0))
		end
	end)
	self:addElement(playerName)
	self.playerName = playerName
	local bleedOutHealth0 = CoD.bleedOutHealthWZ.new(f1_local1, f1_arg0, 0, 1, -105, 105, 0, 1, -187.5, 22.5)
	bleedOutHealth0:setScale(0.5, 0.5)
	bleedOutHealth0:linkToElementModel(self, nil, false, function(model)
		bleedOutHealth0:setModel(model, f1_arg0)
	end)
	self:addElement(bleedOutHealth0)
	self.bleedOutHealth0 = bleedOutHealth0
	local clamparrow = CoD.bleedOutClampedArrow.new(f1_local1, f1_arg0, 0.5, 0.5, -195, 195, 0.5, 0.5, -143.5, -47.5)
	clamparrow:setAlpha(0.4)
	clamparrow:setScale(0.5, 0.5)
	clamparrow:linkToElementModel(self, "direction", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			clamparrow:setZRot(f4_local0)
		end
	end)
	self:addElement(clamparrow)
	self.clamparrow = clamparrow
	local iconarrow = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -48, 16)
	iconarrow:setAlpha(0.55)
	iconarrow:setScale(0.75, 0.75)
	iconarrow:setImage(RegisterImage(@"uie_ui_hud_revive_arrow"))
	self:addElement(iconarrow)
	self.iconarrow = iconarrow
	self:mergeStateConditions({
		{
			stateName = "Hidden_Self",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToClientModelValue(f1_arg0, element, "clientnum", "clientNum")
			end,
		},
		{
			stateName = "Clamped",
			condition = function(menu, element, event)
				local f6_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "clamped")
				if f6_local0 then
					if not CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(element, f1_arg0, "hudItems.laststand.revivingClientNum", "clientNum") and not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"]) then
						f6_local0 = not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
					else
						f6_local0 = false
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f7_local0
				if not CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(element, f1_arg0, "hudItems.laststand.revivingClientNum", "clientNum") and not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"]) then
					f7_local0 = not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	self:linkToElementModel(self, "clientnum", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clientnum",
		})
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg0))
	f1_local7(f1_local6, f1_local8.clientNum, function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "clientNum",
		})
	end, false)
	self:linkToElementModel(self, "clamped", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local7(f1_local6, f1_local8["hudItems.laststand.revivingClientNum"], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "hudItems.laststand.revivingClientNum",
		})
	end, false)
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
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
	f1_local7 = self
	CoD.HUDUtility.LinkSetupEntityContainerToModel(self, "clientnum", true, true, 0, 0, 25)
	CoD.WZUtility.SetupLastStandClientModelUpdate(f1_local1, self, f1_arg0)
	return self
end
CoD.wz_revive_prompt.__resetProperties = function(f15_arg0)
	f15_arg0.playerName:completeAnimation()
	f15_arg0.bleedOutHealth0:completeAnimation()
	f15_arg0.clamparrow:completeAnimation()
	f15_arg0.iconarrow:completeAnimation()
	f15_arg0.playerName:setAlpha(1)
	f15_arg0.bleedOutHealth0:setAlpha(1)
	f15_arg0.clamparrow:setAlpha(0.4)
	f15_arg0.iconarrow:setAlpha(0.55)
end
CoD.wz_revive_prompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.playerName:completeAnimation()
			f16_arg0.playerName:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.playerName)
			f16_arg0.bleedOutHealth0:completeAnimation()
			f16_arg0.bleedOutHealth0:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.bleedOutHealth0)
			f16_arg0.clamparrow:completeAnimation()
			f16_arg0.clamparrow:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.clamparrow)
			f16_arg0.iconarrow:completeAnimation()
			f16_arg0.iconarrow:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.iconarrow)
		end,
	},
	Hidden_Self = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.playerName:completeAnimation()
			f17_arg0.playerName:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.playerName)
			f17_arg0.bleedOutHealth0:completeAnimation()
			f17_arg0.bleedOutHealth0:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.bleedOutHealth0)
			f17_arg0.clamparrow:completeAnimation()
			f17_arg0.clamparrow:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.clamparrow)
			f17_arg0.iconarrow:completeAnimation()
			f17_arg0.iconarrow:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.iconarrow)
		end,
	},
	Clamped = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.playerName:completeAnimation()
			f18_arg0.playerName:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.playerName)
			f18_arg0.iconarrow:completeAnimation()
			f18_arg0.iconarrow:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.iconarrow)
		end,
	},
	Visible = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.clamparrow:completeAnimation()
			f19_arg0.clamparrow:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.clamparrow)
		end,
	},
}
CoD.wz_revive_prompt.__onClose = function(f20_arg0)
	f20_arg0.playerName:close()
	f20_arg0.bleedOutHealth0:close()
	f20_arg0.clamparrow:close()
end

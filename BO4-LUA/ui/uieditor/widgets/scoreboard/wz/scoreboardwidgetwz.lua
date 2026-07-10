require("x64:209a8467f45b10a")
require("x64:20acfdece814a2a")
require("x64:ff2ee65fc4b9370")
CoD.ScoreboardWidgetWZ = InheritFrom(LUI.UIElement)
CoD.ScoreboardWidgetWZ.__defaultWidth = 1920
CoD.ScoreboardWidgetWZ.__defaultHeight = 1080
CoD.ScoreboardWidgetWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ScoreboardUtility.SetScoreboardUIModels(f1_arg1)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "CodCaster")
	CoD.BaseUtility.InitControllerModel(f1_arg1, "CodCaster.showCodCasterScoreboard", false)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_MAP)
	SetElementProperty(f1_arg0, "__ignoreContextualMenu", true)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ScoreboardWidgetWZ)
	self.id = "ScoreboardWidgetWZ"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WZTeamScoreboard = nil
	WZTeamScoreboard = CoD.StartMenu_WZTeamScoreboard.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	WZTeamScoreboard:setAlpha(0)
	self:addElement(WZTeamScoreboard)
	self.WZTeamScoreboard = WZTeamScoreboard
	local ScoreboardGameMap = CoD.ScoreboardMapWZ.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(ScoreboardGameMap)
	self.ScoreboardGameMap = ScoreboardGameMap
	local Background = nil
	Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.04, 0.04, 0.04)
	Background:setAlpha(0.4)
	self:addElement(Background)
	self.Background = Background
	local ScoreboardInventory = nil
	ScoreboardInventory = CoD.StartMenu_Inventory.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ScoreboardInventory)
	self.ScoreboardInventory = ScoreboardInventory
	self:mergeStateConditions({
		{
			stateName = "InventoryVisiblePC",
			condition = function(menu, element, event)
				local f2_local0 = IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_INVENTORY)
					if f2_local0 then
						f2_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "MapVisiblePC",
			condition = function(menu, element, event)
				local f3_local0 = IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_MAP)
					if f3_local0 then
						f3_local0 = IsMouseOrKeyboard(f1_arg1)
						if f3_local0 then
							f3_local0 = not IsGametypeSettingsValue("wzHardcore", 1)
						end
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "ScoreboardVisiblePC",
			condition = function(menu, element, event)
				local f4_local0 = IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
					if f4_local0 then
						f4_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "ForceVisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "forceScoreboard", 1) and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["scoreboardInfo.activeTab"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.forceScoreboard, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f13_arg2, f13_arg3, f13_arg4)
		if IsSelfInState(self, "InventoryVisiblePC") then
			EnableMouseLockInputForInventory(f1_arg0, controller, true)
			CloseContextualMenu(f1_arg0, controller)
			CoD.WZUtility.SetInventoryIsOpen(controller, true)
			CoD.WZUtility.ClearInventoryNag(controller)
			CoD.FreeCursorUtility.RegisterButtonPromptsForMenu(f1_arg0, controller)
		elseif IsSelfInState(self, "MapVisiblePC") then
			CoD.WZUtility.SetInventoryIsOpen(controller, false)
			SetFocusToElement(self, "ScoreboardGameMap", controller)
			EnableMouseLockInputForMap(f1_arg0, controller, true)
			CloseContextualMenu(f1_arg0, controller)
			CoD.WZUtility.ClearInventoryNag(controller)
		elseif IsSelfInState(self, "ScoreboardVisiblePC") then
			CoD.WZUtility.SetInventoryIsOpen(controller, false)
			SetFocusToElement(self, "WZTeamScoreboard", controller)
			EnableMouseLockInputBinding(f1_arg0, controller, true, false)
			CloseContextualMenu(f1_arg0, controller)
			CoD.WZUtility.ClearInventoryNag(controller)
		elseif IsSelfInState(self, "Visible") then
			CoD.WZUtility.SetInventoryIsOpen(controller, false)
			SetFocusToElement(self, "ScoreboardGameMap", controller)
			EnableMouseLockInputBinding(f1_arg0, controller, false, true)
			CloseContextualMenu(f1_arg0, controller)
		elseif IsSelfInState(self, "ForceInventoryPC") then
			EnableMouseLockInputBinding(f1_arg0, controller, true, true)
			CoD.WZUtility.SetInventoryIsOpen(controller, true)
			CoD.FreeCursorUtility.RegisterButtonPromptsForMenu(f1_arg0, controller)
		else
			CoD.WZUtility.SetInventoryIsOpen(controller, false)
			CoD.WZUtility.ClosePCSplitterWidget(self, f1_arg0, controller)
			SetLoseFocusToSelf(self, controller)
			CoD.HUDUtility.GiveFocusToMenu(f1_arg0, controller)
			EnableMouseLockInputBinding(f1_arg0, controller, false, true)
			CloseContextualMenu(f1_arg0, controller)
			CoD.WZUtility.CloseMultiItemPickup(controller)
			CoD.WZUtility.HackCheckWZNeedsCursorMovement(controller, f1_arg0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "status", function(model)
		local f14_local0 = self
		if IsMouseOrKeyboard(f1_arg1) then
			CoD.WZUtility.UpdateMultiItemPickupInventoryVisibilityPC(f1_arg0, self, f1_arg1, model)
		end
	end)
	if CoD.isPC then
		WZTeamScoreboard.id = "WZTeamScoreboard"
	end
	ScoreboardGameMap.id = "ScoreboardGameMap"
	if CoD.isPC then
		ScoreboardInventory.id = "ScoreboardInventory"
	end
	self.__defaultFocus = ScoreboardGameMap
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.ScoreboardGameMap)
	f1_local6 = Background
	if IsPC() then
		SizeToSafeArea(f1_local6, f1_arg1)
	end
	return self
end
CoD.ScoreboardWidgetWZ.__resetProperties = function(f15_arg0)
	f15_arg0.ScoreboardGameMap:completeAnimation()
	f15_arg0.ScoreboardInventory:completeAnimation()
	f15_arg0.Background:completeAnimation()
	f15_arg0.WZTeamScoreboard:completeAnimation()
	f15_arg0.ScoreboardGameMap:setAlpha(1)
	f15_arg0.ScoreboardInventory:setAlpha(1)
	f15_arg0.Background:setAlpha(0.4)
	f15_arg0.WZTeamScoreboard:setAlpha(0)
end
CoD.ScoreboardWidgetWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.ScoreboardGameMap:completeAnimation()
			f16_arg0.ScoreboardGameMap:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ScoreboardGameMap)
			f16_arg0.Background:completeAnimation()
			f16_arg0.Background:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Background)
			f16_arg0.ScoreboardInventory:completeAnimation()
			f16_arg0.ScoreboardInventory:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ScoreboardInventory)
		end,
	},
	InventoryVisiblePC = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ScoreboardGameMap:completeAnimation()
			f17_arg0.ScoreboardGameMap:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ScoreboardGameMap)
		end,
	},
	MapVisiblePC = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.Background:completeAnimation()
			f18_arg0.Background:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Background)
			f18_arg0.ScoreboardInventory:completeAnimation()
			f18_arg0.ScoreboardInventory:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ScoreboardInventory)
		end,
	},
	ScoreboardVisiblePC = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.WZTeamScoreboard:completeAnimation()
			f19_arg0.WZTeamScoreboard:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.WZTeamScoreboard)
			f19_arg0.ScoreboardGameMap:completeAnimation()
			f19_arg0.ScoreboardGameMap:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ScoreboardGameMap)
			f19_arg0.ScoreboardInventory:completeAnimation()
			f19_arg0.ScoreboardInventory:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ScoreboardInventory)
		end,
	},
	Visible = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.Background:completeAnimation()
			f20_arg0.Background:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Background)
			f20_arg0.ScoreboardInventory:completeAnimation()
			f20_arg0.ScoreboardInventory:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ScoreboardInventory)
		end,
	},
	ForceVisible = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.Background:completeAnimation()
			f21_arg0.Background:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Background)
			f21_arg0.ScoreboardInventory:completeAnimation()
			f21_arg0.ScoreboardInventory:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ScoreboardInventory)
		end,
	},
}
CoD.ScoreboardWidgetWZ.__onClose = function(f22_arg0)
	f22_arg0.WZTeamScoreboard:close()
	f22_arg0.ScoreboardGameMap:close()
	f22_arg0.Background:close()
	f22_arg0.ScoreboardInventory:close()
end

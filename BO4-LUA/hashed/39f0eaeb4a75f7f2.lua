require("x64:ca310f46698271f")
require("x64:77e3114fb93636e")
require("x64:f730b248d7b643")
require("x64:e44d4ee75261cd2")
require("x64:5ee2a7efbd7bef7")
require("x64:eea35e191ee4086")
require("x64:a6a317daadcf9c6")
CoD.ZMInventory = InheritFrom(LUI.UIElement)
CoD.ZMInventory.__defaultWidth = 1920
CoD.ZMInventory.__defaultHeight = 1080
CoD.ZMInventory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ScoreboardUtility.SetScoreboardUIModels(f1_arg1)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_MAP)
	self:setClass(CoD.ZMInventory)
	self.id = "ZMInventory"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local guide = LUI.UIImage.new(0, 0, -89, 39, 0, 0, 0, 1080)
	guide:setAlpha(0)
	self:addElement(guide)
	self.guide = guide
	local guide2 = LUI.UIImage.new(0, 0, 1891, 2019, 0, 0, 0, 1080)
	guide2:setAlpha(0)
	self:addElement(guide2)
	self.guide2 = guide2
	local guide3 = LUI.UIImage.new(0, 0, -89, 2019, 0, 0, 1041, 1098)
	guide3:setAlpha(0)
	self:addElement(guide3)
	self.guide3 = guide3
	local ShieldComponents = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	ShieldComponents:setLeftRight(1, 1, -558, -318)
	ShieldComponents:setTopBottom(1, 1, -139, -59)
	ShieldComponents:setAlpha(0)
	ShieldComponents:setWidgetType(CoD.ZMInvShieldItem)
	ShieldComponents:setHorizontalCount(3)
	ShieldComponents:setSpacing(0)
	ShieldComponents:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ShieldComponents:setDataSource("ZMInventoryShieldPieces")
	self:addElement(ShieldComponents)
	self.ShieldComponents = ShieldComponents
	local ExtraQuests = CoD.ZMInvQuests.new(f1_arg0, f1_arg1, 1, 1, -270, -29, 0, 0, 175.5, 505.5)
	self:addElement(ExtraQuests)
	self.ExtraQuests = ExtraQuests
	local Challenges = CoD.ZMInvChallenges.new(f1_arg0, f1_arg1, 0, 0, 62, 382, 0, 0, 518, 588)
	self:addElement(Challenges)
	self.Challenges = Challenges
	local ObjectiveProgress = CoD.ZMInvObjectiveProgress.new(f1_arg0, f1_arg1, 0, 0, 30, 414, 1, 1, -492, -3)
	ObjectiveProgress:subscribeToGlobalModel(f1_arg1, "ZMObjectiveProgressInfo", nil, function(model)
		ObjectiveProgress:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveProgress)
	self.ObjectiveProgress = ObjectiveProgress
	local Talisman = CoD.ZMInvTalisman.new(f1_arg0, f1_arg1, 0, 0, 1763, 1891, 0, 0, 24.5, 152.5)
	self:addElement(Talisman)
	self.Talisman = Talisman
	local ZMInventoryList = CoD.ZMInventoryList.new(f1_arg0, f1_arg1, 1, 1, -1354, 46, 1, 1, -119, -39)
	self:addElement(ZMInventoryList)
	self.ZMInventoryList = ZMInventoryList
	local ScoreboardPC = nil
	ScoreboardPC = CoD.StartMenu_GameOptions_ZM.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ScoreboardPC:setAlpha(0)
	self:addElement(ScoreboardPC)
	self.ScoreboardPC = ScoreboardPC
	self:mergeStateConditions({
		{
			stateName = "ScoreboardVisiblePC",
			condition = function(menu, element, event)
				local f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
				if f3_local0 then
					f3_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
					if f3_local0 then
						f3_local0 = IsMouseOrKeyboard(f1_arg1)
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["scoreboardInfo.activeTab"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f7_arg1)
	end)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsSelfInState(self, "Visible") and IsPC() and IsInTheaterMode() then
			CoD.ModelUtility.SetGlobalDatasourceModelValue(controller, "ZMHudGlobal", "isScoreboardPCOpen", false)
			SendOwnMenuResponse(f1_arg0, controller, "zm_inventory_opened")
		elseif IsSelfInState(self, "Visible") then
			CoD.ModelUtility.SetGlobalDatasourceModelValue(controller, "ZMHudGlobal", "isScoreboardPCOpen", false)
			SendOwnMenuResponse(f1_arg0, controller, "zm_inventory_opened")
			SetMenuProperty(f1_arg0, "m_inputDisabled", true)
		elseif CoD.BaseUtility.IsSelfInState(self, "ScoreboardVisiblePC") then
			CoD.ModelUtility.SetGlobalDatasourceModelValue(controller, "ZMHudGlobal", "isScoreboardPCOpen", true)
			SetMenuProperty(f1_arg0, "m_inputDisabled", false)
			EnableMouseLockInputBinding(f1_arg0, controller, true, false)
			DataSourceHelperGetModel(controller, "XPProgressionBar")
		elseif IsPC() and IsInTheaterMode() then
			CoD.ModelUtility.SetGlobalDatasourceModelValue(controller, "ZMHudGlobal", "isScoreboardPCOpen", false)
		else
			CoD.ModelUtility.SetGlobalDatasourceModelValue(controller, "ZMHudGlobal", "isScoreboardPCOpen", false)
			SetMenuProperty(f1_arg0, "m_inputDisabled", true)
			EnableMouseLockInputBinding(f1_arg0, controller, false, false)
			CloseContextualMenu(f1_arg0, controller)
		end
	end)
	ShieldComponents.id = "ShieldComponents"
	ExtraQuests.id = "ExtraQuests"
	ZMInventoryList.id = "ZMInventoryList"
	if CoD.isPC then
		ScoreboardPC.id = "ScoreboardPC"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	CoD.ZMInventoryUtility.SetupInventoryModels(f1_arg1, self.ObjectiveProgress, self.Challenges)
	return self
end
CoD.ZMInventory.__resetProperties = function(f10_arg0)
	f10_arg0.ExtraQuests:completeAnimation()
	f10_arg0.ObjectiveProgress:completeAnimation()
	f10_arg0.Talisman:completeAnimation()
	f10_arg0.ZMInventoryList:completeAnimation()
	f10_arg0.Challenges:completeAnimation()
	f10_arg0.ShieldComponents:completeAnimation()
	f10_arg0.guide3:completeAnimation()
	f10_arg0.guide2:completeAnimation()
	f10_arg0.guide:completeAnimation()
	f10_arg0.ScoreboardPC:completeAnimation()
	f10_arg0.ExtraQuests:setAlpha(1)
	f10_arg0.ObjectiveProgress:setAlpha(1)
	f10_arg0.Talisman:setAlpha(1)
	f10_arg0.ZMInventoryList:setAlpha(1)
	f10_arg0.Challenges:setAlpha(1)
	f10_arg0.ShieldComponents:setAlpha(0)
	f10_arg0.guide3:setAlpha(0)
	f10_arg0.guide2:setAlpha(0)
	f10_arg0.guide:setAlpha(0)
	f10_arg0.ScoreboardPC:setAlpha(0)
end
CoD.ZMInventory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.ExtraQuests:completeAnimation()
			f11_arg0.ExtraQuests:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ExtraQuests)
			f11_arg0.ObjectiveProgress:completeAnimation()
			f11_arg0.ObjectiveProgress:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ObjectiveProgress)
			f11_arg0.Talisman:completeAnimation()
			f11_arg0.Talisman:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Talisman)
			f11_arg0.ZMInventoryList:completeAnimation()
			f11_arg0.ZMInventoryList:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ZMInventoryList)
		end,
		Visible = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ExtraQuests:beginAnimation(150)
				f12_arg0.ExtraQuests:setAlpha(1)
				f12_arg0.ExtraQuests:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ExtraQuests:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ExtraQuests:completeAnimation()
			f12_arg0.ExtraQuests:setAlpha(0)
			f12_local0(f12_arg0.ExtraQuests)
			local f12_local1 = function(f14_arg0)
				f12_arg0.ObjectiveProgress:beginAnimation(150)
				f12_arg0.ObjectiveProgress:setAlpha(1)
				f12_arg0.ObjectiveProgress:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ObjectiveProgress:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ObjectiveProgress:completeAnimation()
			f12_arg0.ObjectiveProgress:setAlpha(0)
			f12_local1(f12_arg0.ObjectiveProgress)
			local f12_local2 = function(f15_arg0)
				f12_arg0.ZMInventoryList:beginAnimation(150)
				f12_arg0.ZMInventoryList:setAlpha(1)
				f12_arg0.ZMInventoryList:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ZMInventoryList:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ZMInventoryList:completeAnimation()
			f12_arg0.ZMInventoryList:setAlpha(0)
			f12_local2(f12_arg0.ZMInventoryList)
		end,
	},
	ScoreboardVisiblePC = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(10)
			f16_arg0.guide:completeAnimation()
			f16_arg0.guide:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.guide)
			f16_arg0.guide2:completeAnimation()
			f16_arg0.guide2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.guide2)
			f16_arg0.guide3:completeAnimation()
			f16_arg0.guide3:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.guide3)
			f16_arg0.ShieldComponents:completeAnimation()
			f16_arg0.ShieldComponents:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ShieldComponents)
			f16_arg0.ExtraQuests:completeAnimation()
			f16_arg0.ExtraQuests:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ExtraQuests)
			f16_arg0.Challenges:completeAnimation()
			f16_arg0.Challenges:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Challenges)
			f16_arg0.ObjectiveProgress:completeAnimation()
			f16_arg0.ObjectiveProgress:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ObjectiveProgress)
			f16_arg0.Talisman:completeAnimation()
			f16_arg0.Talisman:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Talisman)
			f16_arg0.ZMInventoryList:completeAnimation()
			f16_arg0.ZMInventoryList:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ZMInventoryList)
			f16_arg0.ScoreboardPC:completeAnimation()
			f16_arg0.ScoreboardPC:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.ScoreboardPC)
		end,
		Visible = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				f17_arg0.ExtraQuests:beginAnimation(150)
				f17_arg0.ExtraQuests:setAlpha(1)
				f17_arg0.ExtraQuests:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ExtraQuests:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ExtraQuests:completeAnimation()
			f17_arg0.ExtraQuests:setAlpha(0)
			f17_local0(f17_arg0.ExtraQuests)
			local f17_local1 = function(f19_arg0)
				f17_arg0.ObjectiveProgress:beginAnimation(150)
				f17_arg0.ObjectiveProgress:setAlpha(1)
				f17_arg0.ObjectiveProgress:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ObjectiveProgress:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ObjectiveProgress:completeAnimation()
			f17_arg0.ObjectiveProgress:setAlpha(0)
			f17_local1(f17_arg0.ObjectiveProgress)
			local f17_local2 = function(f20_arg0)
				f17_arg0.ZMInventoryList:beginAnimation(150)
				f17_arg0.ZMInventoryList:setAlpha(1)
				f17_arg0.ZMInventoryList:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ZMInventoryList:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ZMInventoryList:completeAnimation()
			f17_arg0.ZMInventoryList:setAlpha(0)
			f17_local2(f17_arg0.ZMInventoryList)
		end,
	},
	Visible = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			local f22_local0 = function(f23_arg0)
				f22_arg0.ExtraQuests:beginAnimation(150)
				f22_arg0.ExtraQuests:setAlpha(0)
				f22_arg0.ExtraQuests:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ExtraQuests:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.ExtraQuests:completeAnimation()
			f22_arg0.ExtraQuests:setAlpha(1)
			f22_local0(f22_arg0.ExtraQuests)
			local f22_local1 = function(f24_arg0)
				f22_arg0.ObjectiveProgress:beginAnimation(150)
				f22_arg0.ObjectiveProgress:setAlpha(0)
				f22_arg0.ObjectiveProgress:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ObjectiveProgress:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.ObjectiveProgress:completeAnimation()
			f22_arg0.ObjectiveProgress:setAlpha(1)
			f22_local1(f22_arg0.ObjectiveProgress)
			local f22_local2 = function(f25_arg0)
				f22_arg0.Talisman:beginAnimation(150)
				f22_arg0.Talisman:setAlpha(0)
				f22_arg0.Talisman:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Talisman:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Talisman:completeAnimation()
			f22_arg0.Talisman:setAlpha(1)
			f22_local2(f22_arg0.Talisman)
			local f22_local3 = function(f26_arg0)
				f22_arg0.ZMInventoryList:beginAnimation(150)
				f22_arg0.ZMInventoryList:setAlpha(0)
				f22_arg0.ZMInventoryList:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ZMInventoryList:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.ZMInventoryList:completeAnimation()
			f22_arg0.ZMInventoryList:setAlpha(1)
			f22_local3(f22_arg0.ZMInventoryList)
		end,
	},
}
CoD.ZMInventory.__onClose = function(f27_arg0)
	f27_arg0.ShieldComponents:close()
	f27_arg0.ExtraQuests:close()
	f27_arg0.Challenges:close()
	f27_arg0.ObjectiveProgress:close()
	f27_arg0.Talisman:close()
	f27_arg0.ZMInventoryList:close()
	f27_arg0.ScoreboardPC:close()
end

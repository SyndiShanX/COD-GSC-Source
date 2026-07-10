require("x64:81a5d58a3dd611f")
require("x64:d6fd11959dd6f5f")
CoD.zm_red_challenges_hud = InheritFrom(CoD.Menu)
CoD.zm_red_challenges_hud.__stateMap = {
	"DefaultState",
	"Visible",
	"VisiblePC",
	"Trials",
}
LUI.createMenu.zm_red_challenges_hud = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_red_challenges_hud", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_red_challenges_hud)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local zmredchallengeswidget = CoD.zm_red_challenges_widget.new(f1_local1, f1_arg0, 0, 0, 77, 437, 0.5, 0.5, -133.5, -33.5)
	zmredchallengeswidget:mergeStateConditions({
		{
			stateName = "ClaimItem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "tributeAvailable", 4)
			end,
		},
	})
	zmredchallengeswidget:linkToElementModel(zmredchallengeswidget, "tributeAvailable", true, function(model)
		f1_local1:updateElementState(zmredchallengeswidget, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "tributeAvailable",
		})
	end)
	zmredchallengeswidget:setScale(0.89, 0.89)
	zmredchallengeswidget:linkToElementModel(self, nil, false, function(model)
		zmredchallengeswidget:setModel(model, f1_arg0)
	end)
	zmredchallengeswidget:linkToElementModel(self, "challengeText", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			zmredchallengeswidget.ChallengeText.ChallengeText:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	zmredchallengeswidget:linkToElementModel(self, "bottomText", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			zmredchallengeswidget.LocationText.LocationTextDark:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	zmredchallengeswidget:linkToElementModel(self, "bottomText", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			zmredchallengeswidget.LocationText.LocationText:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(zmredchallengeswidget)
	self.zmredchallengeswidget = zmredchallengeswidget
	local AvailableItemText = CoD.zm_red_available_item_text.new(f1_local1, f1_arg0, 0, 0, 77, 437, 0.5, 0.5, -26, -6)
	AvailableItemText:mergeStateConditions({
		{
			stateName = "RewardWhite",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "tributeAvailable", 1) and CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg0, "rewardHidden", 0, nil)
			end,
		},
		{
			stateName = "RewardBlue",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "tributeAvailable", 2) and CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg0, "rewardHidden", 0, nil)
			end,
		},
		{
			stateName = "RewardPurple",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "tributeAvailable", 3) and CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg0, "rewardHidden", 0, nil)
			end,
		},
		{
			stateName = "RewardOrange",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg0, "tributeAvailable", 4) and CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg0, "rewardHidden", 0, nil)
			end,
		},
	})
	AvailableItemText:linkToElementModel(AvailableItemText, "tributeAvailable", true, function(model)
		f1_local1:updateElementState(AvailableItemText, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "tributeAvailable",
		})
	end)
	AvailableItemText:linkToElementModel(AvailableItemText, "rewardHidden", true, function(model)
		f1_local1:updateElementState(AvailableItemText, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "rewardHidden",
		})
	end)
	AvailableItemText:setScale(0.89, 0.89)
	AvailableItemText:linkToElementModel(self, nil, false, function(model)
		AvailableItemText:setModel(model, f1_arg0)
	end)
	self:addElement(AvailableItemText)
	self.AvailableItemText = AvailableItemText
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_none"], nil, function(element, menu, controller, model)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, nil)
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		if IsSelfInState(self, "Visible") and IsPC() then
			SetState(self, "VisiblePC", controller)
		end
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	local f1_local4 = self
	if not IsPC() then
		SizeToSafeArea(self, f1_arg0)
	end
	return self
end
CoD.zm_red_challenges_hud.__resetProperties = function(f18_arg0)
	f18_arg0.zmredchallengeswidget:completeAnimation()
	f18_arg0.AvailableItemText:completeAnimation()
	f18_arg0.zmredchallengeswidget:setLeftRight(0, 0, 77, 437)
	f18_arg0.zmredchallengeswidget:setTopBottom(0.5, 0.5, -133.5, -33.5)
	f18_arg0.zmredchallengeswidget:setAlpha(1)
	f18_arg0.AvailableItemText:setLeftRight(0, 0, 77, 437)
	f18_arg0.AvailableItemText:setTopBottom(0.5, 0.5, -26, -6)
end
CoD.zm_red_challenges_hud.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.zmredchallengeswidget:completeAnimation()
			f19_arg0.zmredchallengeswidget:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.zmredchallengeswidget)
		end,
	},
	Visible = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.zmredchallengeswidget:completeAnimation()
			f20_arg0.zmredchallengeswidget:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.zmredchallengeswidget)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.zmredchallengeswidget:completeAnimation()
			f21_arg0.zmredchallengeswidget:setLeftRight(0.5, 0.5, -883, -523)
			f21_arg0.zmredchallengeswidget:setTopBottom(0.5, 0.5, 10, 110)
			f21_arg0.zmredchallengeswidget:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.zmredchallengeswidget)
			f21_arg0.AvailableItemText:completeAnimation()
			f21_arg0.AvailableItemText:setLeftRight(0.5, 0.5, -883, -523)
			f21_arg0.AvailableItemText:setTopBottom(0.5, 0.5, 117, 137)
			f21_arg0.clipFinished(f21_arg0.AvailableItemText)
		end,
	},
	Trials = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.zmredchallengeswidget:completeAnimation()
			f22_arg0.zmredchallengeswidget:setTopBottom(0.5, 0.5, -73.5, 26.5)
			f22_arg0.clipFinished(f22_arg0.zmredchallengeswidget)
			f22_arg0.AvailableItemText:completeAnimation()
			f22_arg0.AvailableItemText:setTopBottom(0.5, 0.5, 34, 54)
			f22_arg0.clipFinished(f22_arg0.AvailableItemText)
		end,
	},
}
CoD.zm_red_challenges_hud.__onClose = function(f23_arg0)
	f23_arg0.zmredchallengeswidget:close()
	f23_arg0.AvailableItemText:close()
end

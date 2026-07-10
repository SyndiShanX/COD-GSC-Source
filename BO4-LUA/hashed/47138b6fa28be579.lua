require("x64:353fedd804c5d3")
require("x64:95eddaed66d3425")
require("x64:84c3b03ac8b3569")
require("x64:78ae4ff448c6d52")
require("x64:12d3ff0a1b8cdca")
require("x64:145ddbfa32b2781")
require("x64:e5bbf49aab89fa3")
CoD.WarzoneUseTimer = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimer.__defaultWidth = 600
CoD.WarzoneUseTimer.__defaultHeight = 80
CoD.WarzoneUseTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.laststand.reviveProgress", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.laststand.beingRevived", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.dynEntUseHoldProgress", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.depositing", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.laststand.progress", 0)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.beingFinished", 0)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.WarzoneUseTimer)
	self.id = "WarzoneUseTimer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local dynentUseProgress = CoD.WarzoneUseTimerDynentProgress.new(f1_arg0, f1_arg1, 0, 0, 60, 540, 0, 0, 53.5, 71.5)
	dynentUseProgress:setAlpha(0)
	self:addElement(dynentUseProgress)
	self.dynentUseProgress = dynentUseProgress
	local healProgress = CoD.WarzoneUseTimerProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -240, 240, 0.5, 0.5, 13.5, 31.5)
	healProgress:setAlpha(0)
	healProgress:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget1.powerRatio", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			healProgress.progressBar:setShaderVector(0, SubtractVectorComponentFrom(1, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(healProgress)
	self.healProgress = healProgress
	local beingRevivedProgress = CoD.WarzoneUseTimerProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -240, 240, 0.5, 0.5, 13.5, 31.5)
	beingRevivedProgress:setAlpha(0)
	beingRevivedProgress.progressBar:setShaderVector(0, SubtractVectorComponentFrom(1, 1, 0.64, 0, 0, 0))
	self:addElement(beingRevivedProgress)
	self.beingRevivedProgress = beingRevivedProgress
	local bleedoutProgress = CoD.WarzoneUseTimerProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -240, 240, 0.5, 0.5, 13.5, 31.5)
	bleedoutProgress:setAlpha(0)
	bleedoutProgress.progressBar:setRGB(ColorSet.HealthBarForegroundEnemy.r, ColorSet.HealthBarForegroundEnemy.g, ColorSet.HealthBarForegroundEnemy.b)
	bleedoutProgress.progressBar:setShaderVector(0, SubtractVectorComponentFrom(1, 1, 0.64, 0, 0, 0))
	self:addElement(bleedoutProgress)
	self.bleedoutProgress = bleedoutProgress
	local reviveProgress = CoD.WarzoneUseTimerProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -240, 240, 0.5, 0.5, 13.5, 31.5)
	reviveProgress:setAlpha(0)
	reviveProgress:subscribeToGlobalModel(f1_arg1, "HUDItems", "laststand.reviveProgress", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CoD.BaseUtility.SmoothLinearInterpolateClientTime(f1_arg1, "reviveProgress", model, f3_local0)
			reviveProgress.progressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(reviveProgress)
	self.reviveProgress = reviveProgress
	local DepositText = CoD.WarzoneUseTimerDeposit.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.5, 0.5, -40, -4)
	DepositText:setAlpha(0)
	self:addElement(DepositText)
	self.DepositText = DepositText
	local UsingText = CoD.WarzoneUseTimerUsing.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.5, 0.5, -40, -4)
	UsingText:setAlpha(0)
	self:addElement(UsingText)
	self.UsingText = UsingText
	local ReviveText = CoD.WarzoneUseTimerRevivePlayer.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.5, 0.5, -40, -4)
	ReviveText:setAlpha(0)
	self:addElement(ReviveText)
	self.ReviveText = ReviveText
	local BeingRevivedText = CoD.WarzoneUseTimerBeingRevived.new(f1_arg0, f1_arg1, 0.5, 0.5, -121, 129, 0.5, 0.5, -37, -7)
	BeingRevivedText:setAlpha(0)
	self:addElement(BeingRevivedText)
	self.BeingRevivedText = BeingRevivedText
	local CowardsWayPrompt = CoD.WarzoneUseTimerCowardsWay.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 300, 0.5, 0.5, -40, -4)
	CowardsWayPrompt:setAlpha(0)
	self:addElement(CowardsWayPrompt)
	self.CowardsWayPrompt = CowardsWayPrompt
	self:mergeStateConditions({
		{
			stateName = "Healing",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "playerAbilities.PlayerGadget1.powerRatio", 0)
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "playerAbilities.playerGadget1.state", Enum[@"weapongadgetstates"][@"player_ability_state_inuse"])
					if f4_local0 then
						f4_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"])
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Reviving",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.laststand.reviveProgress", 0)
			end,
		},
		{
			stateName = "BeingRevived",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.laststand.beingRevived", 1)
			end,
		},
		{
			stateName = "CowardsWayOut",
			condition = function(menu, element, event)
				local f7_local0 = IsGametypeSettingsValue("wzEnableCowardsWayOut", 1)
				if f7_local0 then
					f7_local0 = CoD.WZUtility.IsInLastStand(f1_arg1, "hudItems.lastStand")
					if f7_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) then
							f7_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.beingFinished", 0)
						else
							f7_local0 = false
						end
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "Deposit",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.dynEntUseHoldProgress", 0) and CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.depositing", 0)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["playerAbilities.PlayerGadget1.powerRatio"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "playerAbilities.PlayerGadget1.powerRatio",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["playerAbilities.playerGadget1.state"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "playerAbilities.playerGadget1.state",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.laststand.reviveProgress"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.laststand.reviveProgress",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.laststand.beingRevived"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "hudItems.laststand.beingRevived",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.lastStand.progress"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "hudItems.lastStand.progress",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.lastStand.beingRevived"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "hudItems.lastStand.beingRevived",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.beingFinished"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "hudItems.beingFinished",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.dynEntUseHoldProgress"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.dynEntUseHoldProgress",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.depositing"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "hudItems.depositing",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	CoD.WZUtility.SetupReviveProgressBar(f1_arg0, f1_arg1, self.beingRevivedProgress)
	CoD.WZUtility.SetupBleedoutProgressBar(f1_arg0, f1_arg1, self.bleedoutProgress)
	return self
end
CoD.WarzoneUseTimer.__resetProperties = function(f20_arg0)
	f20_arg0.UsingText:completeAnimation()
	f20_arg0.healProgress:completeAnimation()
	f20_arg0.ReviveText:completeAnimation()
	f20_arg0.reviveProgress:completeAnimation()
	f20_arg0.beingRevivedProgress:completeAnimation()
	f20_arg0.BeingRevivedText:completeAnimation()
	f20_arg0.bleedoutProgress:completeAnimation()
	f20_arg0.CowardsWayPrompt:completeAnimation()
	f20_arg0.dynentUseProgress:completeAnimation()
	f20_arg0.DepositText:completeAnimation()
	f20_arg0.UsingText:setAlpha(0)
	f20_arg0.healProgress:setAlpha(0)
	f20_arg0.ReviveText:setAlpha(0)
	f20_arg0.reviveProgress:setAlpha(0)
	f20_arg0.beingRevivedProgress:setAlpha(0)
	f20_arg0.BeingRevivedText:setAlpha(0)
	f20_arg0.bleedoutProgress:setAlpha(0)
	f20_arg0.CowardsWayPrompt:setAlpha(0)
	f20_arg0.dynentUseProgress:setAlpha(0)
	f20_arg0.DepositText:setAlpha(0)
end
CoD.WarzoneUseTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	Healing = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.healProgress:completeAnimation()
			f22_arg0.healProgress:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.healProgress)
			f22_arg0.UsingText:completeAnimation()
			f22_arg0.UsingText:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.UsingText)
		end,
	},
	Reviving = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.reviveProgress:completeAnimation()
			f23_arg0.reviveProgress:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.reviveProgress)
			f23_arg0.ReviveText:completeAnimation()
			f23_arg0.ReviveText:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.ReviveText)
		end,
	},
	BeingRevived = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.beingRevivedProgress:completeAnimation()
			f24_arg0.beingRevivedProgress:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.beingRevivedProgress)
			f24_arg0.BeingRevivedText:completeAnimation()
			f24_arg0.BeingRevivedText:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.BeingRevivedText)
		end,
	},
	CowardsWayOut = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.bleedoutProgress:completeAnimation()
			f25_arg0.bleedoutProgress:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.bleedoutProgress)
			f25_arg0.CowardsWayPrompt:completeAnimation()
			f25_arg0.CowardsWayPrompt:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.CowardsWayPrompt)
		end,
	},
	Deposit = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.dynentUseProgress:completeAnimation()
			f26_arg0.dynentUseProgress:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.dynentUseProgress)
			f26_arg0.DepositText:completeAnimation()
			f26_arg0.DepositText:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.DepositText)
		end,
	},
}
CoD.WarzoneUseTimer.__onClose = function(f27_arg0)
	f27_arg0.dynentUseProgress:close()
	f27_arg0.healProgress:close()
	f27_arg0.beingRevivedProgress:close()
	f27_arg0.bleedoutProgress:close()
	f27_arg0.reviveProgress:close()
	f27_arg0.DepositText:close()
	f27_arg0.UsingText:close()
	f27_arg0.ReviveText:close()
	f27_arg0.BeingRevivedText:close()
	f27_arg0.CowardsWayPrompt:close()
end

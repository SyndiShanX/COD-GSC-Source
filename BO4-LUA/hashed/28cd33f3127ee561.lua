require("x64:38c2d6f8294f7ce")
require("x64:e7f6b39a66d621f")
require("x64:9292b5bf13a9e5e")
require("x64:7f155449efe7c6a")
require("x64:6cc0e30194887fc")
require("x64:fc306767dffb0c")
CoD.ArenaGauntletTierProgress = InheritFrom(LUI.UIElement)
CoD.ArenaGauntletTierProgress.__defaultWidth = 150
CoD.ArenaGauntletTierProgress.__defaultHeight = 300
CoD.ArenaGauntletTierProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaGauntletTierProgress)
	self.id = "ArenaGauntletTierProgress"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaGauntletTierProgressInactive = CoD.ArenaGauntletTierProgressInactive.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, 0, 200)
	ArenaGauntletTierProgressInactive:linkToElementModel(self, "currentTierWinRequirement", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArenaGauntletTierProgressInactive.WinTargetCount:setText(f2_local0)
		end
	end)
	self:addElement(ArenaGauntletTierProgressInactive)
	self.ArenaGauntletTierProgressInactive = ArenaGauntletTierProgressInactive
	local ArenaGauntletTierProgressBacking = CoD.ArenaGauntletTierProgressBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, 0, 200)
	self:addElement(ArenaGauntletTierProgressBacking)
	self.ArenaGauntletTierProgressBacking = ArenaGauntletTierProgressBacking
	local ArenaGauntletWinCounter = CoD.ArenaGauntletWinCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, -40, 40, 0, 0, 43, 143)
	ArenaGauntletWinCounter:linkToElementModel(self, "wins", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ArenaGauntletWinCounter.WinCount:setText(f3_local0)
		end
	end)
	self:addElement(ArenaGauntletWinCounter)
	self.ArenaGauntletWinCounter = ArenaGauntletWinCounter
	local ArenaGauntletProgressBar = CoD.ArenaGauntletProgressBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -58, -48, 0, 0, 41, 191)
	ArenaGauntletProgressBar:linkToElementModel(self, "currentTierWinRequirement", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ArenaGauntletProgressBar.ProgressBacking:setShaderVector(1, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))))
		end
	end)
	ArenaGauntletProgressBar:linkToElementModel(self, "currentTierWinRequirement", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ArenaGauntletProgressBar.ProgressFill:setShaderVector(1, SetVectorComponent(1, 1, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))))
		end
	end)
	ArenaGauntletProgressBar.ProgressFill.__ProgressFill_Wipe_X_Start_X_End_Y_Start_Y_End = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			ArenaGauntletProgressBar.ProgressFill:setShaderVector(2, CoD.ArenaLeaguePlayUtility.GetArenaGauntletWinFillShaderVector(f1_arg1, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end
	ArenaGauntletProgressBar:linkToElementModel(self, "wins", true, ArenaGauntletProgressBar.ProgressFill.__ProgressFill_Wipe_X_Start_X_End_Y_Start_Y_End)
	ArenaGauntletProgressBar.ProgressFill.__ProgressFill_Wipe_X_Start_X_End_Y_Start_Y_End_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.wins
		end
		if f7_local0 then
			ArenaGauntletProgressBar.ProgressFill.__ProgressFill_Wipe_X_Start_X_End_Y_Start_Y_End(f7_local0)
		end
	end
	ArenaGauntletProgressBar:linkToElementModel(self, "currentTierWinRequirement", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ArenaGauntletProgressBar.Count:setText(f8_local0)
		end
	end)
	self:addElement(ArenaGauntletProgressBar)
	self.ArenaGauntletProgressBar = ArenaGauntletProgressBar
	local ArenaGauntletLossTracker = CoD.ArenaGauntletLossTracker.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 0, 0, 204.5, 284.5)
	ArenaGauntletLossTracker:linkToElementModel(self, "lossesListDataSource", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ArenaGauntletLossTracker.LossesList:setDataSource(f9_local0)
		end
	end)
	self:addElement(ArenaGauntletLossTracker)
	self.ArenaGauntletLossTracker = ArenaGauntletLossTracker
	local ArenaSlottedRuby = CoD.ArenaSlottedRuby.new(f1_arg0, f1_arg1, 0, 0, 55, 95, 0, 0, 6, 46)
	ArenaSlottedRuby:mergeStateConditions({
		{
			stateName = "Filled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "rubyActive")
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ArenaSlottedRuby:linkToElementModel(ArenaSlottedRuby, "rubyActive", true, function(model)
		f1_arg0:updateElementState(ArenaSlottedRuby, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rubyActive",
		})
	end)
	ArenaSlottedRuby:linkToElementModel(self, nil, false, function(model)
		ArenaSlottedRuby:setModel(model, f1_arg1)
	end)
	self:addElement(ArenaSlottedRuby)
	self.ArenaSlottedRuby = ArenaSlottedRuby
	local TierTitle = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, -12, 12)
	TierTitle:setTTF("ttmussels_demibold")
	TierTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TierTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TierTitle:linkToElementModel(self, "title", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			TierTitle:setText(LocalizeToUpperString(f14_local0))
		end
	end)
	self:addElement(TierTitle)
	self.TierTitle = TierTitle
	local f1_local8 = ArenaGauntletProgressBar
	local f1_local9 = ArenaGauntletProgressBar.subscribeToModel
	local f1_local10 = DataSources.ArenaGauntlet.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.wins, ArenaGauntletProgressBar.ProgressFill.__ProgressFill_Wipe_X_Start_X_End_Y_Start_Y_End_FullPath)
	f1_local8 = ArenaGauntletProgressBar
	f1_local9 = ArenaGauntletProgressBar.subscribeToModel
	f1_local10 = DataSources.ArenaGauntlet.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.currentTierWinRequirement, ArenaGauntletProgressBar.ProgressFill.__ProgressFill_Wipe_X_Start_X_End_Y_Start_Y_End_FullPath)
	ArenaGauntletLossTracker.id = "ArenaGauntletLossTracker"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaGauntletTierProgress.__resetProperties = function(f15_arg0)
	f15_arg0.ArenaGauntletLossTracker:completeAnimation()
	f15_arg0.ArenaGauntletProgressBar:completeAnimation()
	f15_arg0.ArenaGauntletWinCounter:completeAnimation()
	f15_arg0.ArenaGauntletTierProgressBacking:completeAnimation()
	f15_arg0.ArenaGauntletTierProgressInactive:completeAnimation()
	f15_arg0.ArenaSlottedRuby:completeAnimation()
	f15_arg0.TierTitle:completeAnimation()
	f15_arg0.ArenaGauntletLossTracker:setAlpha(1)
	f15_arg0.ArenaGauntletProgressBar:setAlpha(1)
	f15_arg0.ArenaGauntletWinCounter:setAlpha(1)
	f15_arg0.ArenaGauntletTierProgressBacking:setAlpha(1)
	f15_arg0.ArenaGauntletTierProgressInactive:setAlpha(1)
	f15_arg0.ArenaSlottedRuby:setAlpha(1)
	f15_arg0.TierTitle:setAlpha(1)
end
CoD.ArenaGauntletTierProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(7)
			f17_arg0.ArenaGauntletTierProgressInactive:completeAnimation()
			f17_arg0.ArenaGauntletTierProgressInactive:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaGauntletTierProgressInactive)
			f17_arg0.ArenaGauntletTierProgressBacking:completeAnimation()
			f17_arg0.ArenaGauntletTierProgressBacking:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaGauntletTierProgressBacking)
			f17_arg0.ArenaGauntletWinCounter:completeAnimation()
			f17_arg0.ArenaGauntletWinCounter:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaGauntletWinCounter)
			f17_arg0.ArenaGauntletProgressBar:completeAnimation()
			f17_arg0.ArenaGauntletProgressBar:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaGauntletProgressBar)
			f17_arg0.ArenaGauntletLossTracker:completeAnimation()
			f17_arg0.ArenaGauntletLossTracker:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaGauntletLossTracker)
			f17_arg0.ArenaSlottedRuby:completeAnimation()
			f17_arg0.ArenaSlottedRuby:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ArenaSlottedRuby)
			f17_arg0.TierTitle:completeAnimation()
			f17_arg0.TierTitle:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TierTitle)
		end,
	},
	Inactive = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.ArenaGauntletTierProgressBacking:completeAnimation()
			f18_arg0.ArenaGauntletTierProgressBacking:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ArenaGauntletTierProgressBacking)
			f18_arg0.ArenaGauntletWinCounter:completeAnimation()
			f18_arg0.ArenaGauntletWinCounter:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ArenaGauntletWinCounter)
			f18_arg0.ArenaGauntletProgressBar:completeAnimation()
			f18_arg0.ArenaGauntletProgressBar:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ArenaGauntletProgressBar)
			f18_arg0.ArenaGauntletLossTracker:completeAnimation()
			f18_arg0.ArenaGauntletLossTracker:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ArenaGauntletLossTracker)
		end,
	},
}
CoD.ArenaGauntletTierProgress.__onClose = function(f19_arg0)
	f19_arg0.ArenaGauntletTierProgressInactive:close()
	f19_arg0.ArenaGauntletTierProgressBacking:close()
	f19_arg0.ArenaGauntletWinCounter:close()
	f19_arg0.ArenaGauntletProgressBar:close()
	f19_arg0.ArenaGauntletLossTracker:close()
	f19_arg0.ArenaSlottedRuby:close()
	f19_arg0.TierTitle:close()
end

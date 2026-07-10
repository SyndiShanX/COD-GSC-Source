require("x64:8d2cf73e51e9eb2")
require("x64:445c36edf7e511d")
require("x64:20629a2e70ddf60")
CoD.ButtonFrame_Progress = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_Progress.__defaultWidth = 647
CoD.ButtonFrame_Progress.__defaultHeight = 381
CoD.ButtonFrame_Progress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PrestigeUtility.ClearHasPrestigedStatus(self, f1_arg1)
	self:setClass(CoD.ButtonFrame_Progress)
	self.id = "ButtonFrame_Progress"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RankInfo = CoD.ButtonFrame_RankInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0.5, 0.5, -165, 35)
	RankInfo.LevelText:setText(LocalizeToUpperString(@"menu/level"))
	RankInfo:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankInfo.RankText:setText(CoD.PlayerStatsUtility.GetRank(f1_arg0, f2_local0))
		end
	end)
	RankInfo:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankInfo.RankIconLarge:setImage(RegisterImage(CoD.PlayerStatsUtility.GetRankIconLarge(f1_arg0, f1_arg1, f3_local0)))
		end
	end)
	RankInfo:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RankInfo.RankTitle:setText(ConvertToUpperString(CoD.PlayerStatsUtility.GetRankTitle(f1_arg0, f4_local0)))
		end
	end)
	self:addElement(RankInfo)
	self.RankInfo = RankInfo
	local RankProgress = CoD.ButtonFrame_XPMeterInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 302, 0.5, 0.5, 45.5, 96.5)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RankProgress.CurrentXPMeter.Meter:setShaderVector(0, CoD.PlayerStatsUtility.GetCurrentRankProgress(f1_arg0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RankProgress.CurrentXPMeter.MeterGlow:setShaderVector(0, CoD.PlayerStatsUtility.GetCurrentRankProgress(f1_arg0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RankProgress.CurrentXPText:setText(CoD.PlayerStatsUtility.GetCurrentXPForRank(f1_arg0, f7_local0))
		end
	end)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			RankProgress.NeededXPText:setText(CoD.RankUtility.GetNextRankXPString(f1_arg0, f8_local0))
		end
	end)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			RankProgress.RankIcon:setImage(RegisterImage(CoD.PlayerStatsUtility.GetNextRankIcon(f1_arg0, f9_local0)))
		end
	end)
	self:addElement(RankProgress)
	self.RankProgress = RankProgress
	local PrestigeProgress = CoD.ButtonFrame_XPMeterInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 302, 0.5, 0.5, 118.5, 169.5)
	PrestigeProgress:mergeStateConditions({
		{
			stateName = "Prestige",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	PrestigeProgress.CurrentXPText:setText("")
	PrestigeProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			PrestigeProgress.CurrentXPMeter.Meter:setShaderVector(0, CoD.PlayerStatsUtility.GetPrestigeProgress(f1_arg0, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4)))
		end
	end)
	PrestigeProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			PrestigeProgress.CurrentXPMeter.MeterGlow:setShaderVector(0, CoD.PlayerStatsUtility.GetPrestigeProgress(f1_arg0, CoD.GetVectorComponentFromString(f12_local0, 1), CoD.GetVectorComponentFromString(f12_local0, 2), CoD.GetVectorComponentFromString(f12_local0, 3), CoD.GetVectorComponentFromString(f12_local0, 4)))
		end
	end)
	PrestigeProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			PrestigeProgress.NeededXPText:setText(ConvertToUpperString(CoD.PlayerStatsUtility.GetNextPrestigeTitle(f1_arg0, f13_local0)))
		end
	end)
	PrestigeProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			PrestigeProgress.RankIcon:setImage(RegisterImage(CoD.PlayerStatsUtility.GetNextPrestigeIcon(f1_arg0, false, f14_local0)))
		end
	end)
	self:addElement(PrestigeProgress)
	self.PrestigeProgress = PrestigeProgress
	local MaxLevelNotify = CoD.ButtonFrame_MaxLevelNotify.new(f1_arg0, f1_arg1, 0, 0, 23.5, 623.5, 0, 0, 247, 347)
	MaxLevelNotify:setAlpha(0)
	self:addElement(MaxLevelNotify)
	self.MaxLevelNotify = MaxLevelNotify
	self:mergeStateConditions({
		{
			stateName = "PrestigeReady",
			condition = function(menu, element, event)
				local f15_local0 = IsAtXPCap(f1_arg1)
				if f15_local0 then
					if not IsMaxPrestigeLevel(f1_arg1) and not IsWarzone() then
						f15_local0 = not IsArenaMode()
					else
						f15_local0 = false
					end
				end
				return f15_local0
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
		{
			stateName = "MaxPrestige",
			condition = function(menu, element, event)
				return IsMaxPrestigeLevel(f1_arg1) and CoD.PrestigeUtility.isMaxRank(menu)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f19_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_Progress.__resetProperties = function(f20_arg0)
	f20_arg0.RankProgress:completeAnimation()
	f20_arg0.PrestigeProgress:completeAnimation()
	f20_arg0.MaxLevelNotify:completeAnimation()
	f20_arg0.RankInfo:completeAnimation()
	f20_arg0.RankProgress:setAlpha(1)
	f20_arg0.PrestigeProgress:setAlpha(1)
	f20_arg0.MaxLevelNotify:setAlpha(0)
	f20_arg0.RankInfo:setAlpha(1)
end
CoD.ButtonFrame_Progress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	PrestigeReady = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.RankProgress:completeAnimation()
			f22_arg0.RankProgress:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.RankProgress)
			f22_arg0.PrestigeProgress:completeAnimation()
			f22_arg0.PrestigeProgress:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.PrestigeProgress)
			f22_arg0.MaxLevelNotify:completeAnimation()
			f22_arg0.MaxLevelNotify:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.MaxLevelNotify)
		end,
	},
	Arena = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.RankInfo:completeAnimation()
			f23_arg0.RankInfo:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.RankInfo)
			f23_arg0.RankProgress:completeAnimation()
			f23_arg0.RankProgress:setAlpha(0.01)
			f23_arg0.clipFinished(f23_arg0.RankProgress)
			f23_arg0.PrestigeProgress:completeAnimation()
			f23_arg0.PrestigeProgress:setAlpha(0.01)
			f23_arg0.clipFinished(f23_arg0.PrestigeProgress)
			f23_arg0.MaxLevelNotify:completeAnimation()
			f23_arg0.MaxLevelNotify:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MaxLevelNotify)
		end,
	},
	MaxPrestige = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.RankProgress:completeAnimation()
			f24_arg0.RankProgress:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RankProgress)
		end,
	},
}
CoD.ButtonFrame_Progress.__onClose = function(f25_arg0)
	f25_arg0.RankInfo:close()
	f25_arg0.RankProgress:close()
	f25_arg0.PrestigeProgress:close()
	f25_arg0.MaxLevelNotify:close()
end

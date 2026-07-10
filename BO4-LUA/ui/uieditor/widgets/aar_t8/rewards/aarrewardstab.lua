require("x64:f00a10fc8301da2")
require("x64:ae8904a5f5f8ec0")
require("x64:8d9203449623ab5")
require("x64:194a3c2b978e81")
CoD.AARRewardsTab = InheritFrom(LUI.UIElement)
CoD.AARRewardsTab.__defaultWidth = 1920
CoD.AARRewardsTab.__defaultHeight = 900
CoD.AARRewardsTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardsTab)
	self.id = "AARRewardsTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -1100, 1100, 0, 0, 43, 878)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local RewardsList = LUI.UIList.new(f1_arg0, f1_arg1, 30, 0, nil, false, false, false, false)
	RewardsList:setLeftRight(0, 0, 83, 1821)
	RewardsList:setTopBottom(0, 0, 80, 852)
	RewardsList:setScale(0.92, 0.92)
	RewardsList:setWidgetType(CoD.AARWeaponReward)
	RewardsList:setHorizontalCount(4)
	RewardsList:setSpacing(30)
	RewardsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RewardsList:setDataSource("AARRewards")
	RewardsList:subscribeToGlobalModel(f1_arg1, "PerController", "AAR.rewards.newPage", function(model)
		CoD.AARUtility.UpdateRewardListView(f1_arg1, RewardsList)
	end)
	self:addElement(RewardsList)
	self.RewardsList = RewardsList
	local CommonSecondaryTabBar = CoD.CommonSecondaryTabBar.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 47.5, 108.5)
	CommonSecondaryTabBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "AAR.rewards.multiPage")
			end,
		},
	})
	local f1_local4 = CommonSecondaryTabBar
	local f1_local5 = CommonSecondaryTabBar.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["AAR.rewards.multiPage"], function(f4_arg0)
		f1_arg0:updateElementState(CommonSecondaryTabBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "AAR.rewards.multiPage",
		})
	end, false)
	CommonSecondaryTabBar.Tabs.grid:setWidgetType(CoD.AARStatTypeTabHeader)
	CommonSecondaryTabBar.Tabs.grid:setHorizontalCount(8)
	CommonSecondaryTabBar.Tabs.grid:setDataSource("AARRewardPages")
	CommonSecondaryTabBar:registerEventHandler("list_active_changed", function(element, event)
		local f5_local0 = nil
		CoD.AARUtility.AARRewardPageChanged(f1_arg1, self, element, event)
		return f5_local0
	end)
	self:addElement(CommonSecondaryTabBar)
	self.CommonSecondaryTabBar = CommonSecondaryTabBar
	self:mergeStateConditions({
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_REWARDS) and IsZombies()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_REWARDS)
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["AAR.activeTab"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RewardsList.id = "RewardsList"
	CommonSecondaryTabBar.id = "CommonSecondaryTabBar"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.AARUtility.RegisterForTriggerNavigation(f1_arg0, CommonSecondaryTabBar, f1_arg1, "Tabs.grid", CoD.AARUtility.AARTabs.AAR_REWARDS)
	return self
end
CoD.AARRewardsTab.__resetProperties = function(f10_arg0)
	f10_arg0.RewardsList:completeAnimation()
	f10_arg0.CommonSecondaryTabBar:completeAnimation()
	f10_arg0.AarMpBacking:completeAnimation()
	f10_arg0.RewardsList:setAlpha(1)
	f10_arg0.CommonSecondaryTabBar:setAlpha(1)
	f10_arg0.AarMpBacking:setAlpha(1)
	f10_arg0.AarMpBacking.Backer:setRGB(0.67, 0.67, 0.67)
	f10_arg0.AarMpBacking.Backer:setAlpha(0.02)
end
CoD.AARRewardsTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.AarMpBacking:completeAnimation()
			f11_arg0.AarMpBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.AarMpBacking)
			f11_arg0.RewardsList:completeAnimation()
			f11_arg0.RewardsList:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.RewardsList)
			f11_arg0.CommonSecondaryTabBar:completeAnimation()
			f11_arg0.CommonSecondaryTabBar:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CommonSecondaryTabBar)
		end,
	},
	ZM = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.AarMpBacking:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f12_arg0.AarMpBacking:setAlpha(1)
				f12_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.AarMpBacking:completeAnimation()
			f12_arg0.AarMpBacking.Backer:completeAnimation()
			f12_arg0.AarMpBacking:setAlpha(0)
			f12_arg0.AarMpBacking.Backer:setRGB(0.02, 0, 0)
			f12_arg0.AarMpBacking.Backer:setAlpha(0.4)
			f12_local0(f12_arg0.AarMpBacking)
			local f12_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.RewardsList:beginAnimation(350)
				f12_arg0.RewardsList:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.RewardsList:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f12_arg0.RewardsList:completeAnimation()
			f12_arg0.RewardsList:setAlpha(0)
			f12_local1(f12_arg0.RewardsList)
			local f12_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(100)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.CommonSecondaryTabBar:beginAnimation(200)
				f12_arg0.CommonSecondaryTabBar:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CommonSecondaryTabBar:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f12_arg0.CommonSecondaryTabBar:completeAnimation()
			f12_arg0.CommonSecondaryTabBar:setAlpha(0)
			f12_local2(f12_arg0.CommonSecondaryTabBar)
		end,
	},
	Visible = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			local f18_local0 = function(f19_arg0)
				f18_arg0.AarMpBacking:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f18_arg0.AarMpBacking:setAlpha(1)
				f18_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.AarMpBacking:completeAnimation()
			f18_arg0.AarMpBacking:setAlpha(0)
			f18_local0(f18_arg0.AarMpBacking)
			local f18_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.RewardsList:beginAnimation(300)
				f18_arg0.RewardsList:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.RewardsList:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f18_arg0.RewardsList:completeAnimation()
			f18_arg0.RewardsList:setAlpha(0)
			f18_local1(f18_arg0.RewardsList)
			local f18_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(100)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.CommonSecondaryTabBar:beginAnimation(200)
				f18_arg0.CommonSecondaryTabBar:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.CommonSecondaryTabBar:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f18_arg0.CommonSecondaryTabBar:completeAnimation()
			f18_arg0.CommonSecondaryTabBar:setAlpha(0)
			f18_local2(f18_arg0.CommonSecondaryTabBar)
		end,
	},
}
CoD.AARRewardsTab.__onClose = function(f24_arg0)
	f24_arg0.AarMpBacking:close()
	f24_arg0.RewardsList:close()
	f24_arg0.CommonSecondaryTabBar:close()
end

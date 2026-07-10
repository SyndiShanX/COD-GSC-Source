require("x64:7efaf2f566c4e95")
require("x64:d6ecdf7755aeddc")
require("x64:bc6e2379d2241fb")
require("x64:e41af73729601d6")
require("x64:a38a98b7d7843d5")
CoD.Laboratory_SafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.Laboratory_SafeAreaContainer.__defaultWidth = 1920
CoD.Laboratory_SafeAreaContainer.__defaultHeight = 1080
CoD.Laboratory_SafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Laboratory_SafeAreaContainer)
	self.id = "Laboratory_SafeAreaContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CACHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x96D9A8F7540D6B6))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local StartMenuCurrencyCounts = CoD.StartMenu_CurrencyCounts.new(f1_arg0, f1_arg1, 1, 1, -651, -341, 0, 0, 9, 89)
	StartMenuCurrencyCounts:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				local f3_local0 = IsLootReady(f1_arg1)
				if f3_local0 then
					f3_local0 = IsCommerceEnabledOnPC()
					if f3_local0 then
						f3_local0 = IsBooleanDvarSet("laboratory_codpoints_enabled")
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "ShownOnlyCODPoints",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ShownOnlyVials",
			condition = function(menu, element, event)
				return IsLootReady(f1_arg1) and not IsBooleanDvarSet("laboratory_codpoints_enabled")
			end,
		},
	})
	local CommonIdentityWidgetStreamlined = StartMenuCurrencyCounts
	local SelfIdentityBadge = StartMenuCurrencyCounts.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	SelfIdentityBadge(CommonIdentityWidgetStreamlined, f1_local6["LootStreamProgress.currentLootXP"], function(f6_arg0)
		f1_arg0:updateElementState(StartMenuCurrencyCounts, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LootStreamProgress.currentLootXP",
		})
	end, false)
	StartMenuCurrencyCounts:setAlpha(0)
	StartMenuCurrencyCounts:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "plasma", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StartMenuCurrencyCounts.vialCount:setText(SetValueIfNumberEqualTo(-1, "-", f7_local0))
		end
	end)
	self:addElement(StartMenuCurrencyCounts)
	self.StartMenuCurrencyCounts = StartMenuCurrencyCounts
	SelfIdentityBadge = CoD.IdentityBadgeUpperRightSafe.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	SelfIdentityBadge:setAlpha(0)
	SelfIdentityBadge:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		SelfIdentityBadge:setModel(model, f1_arg1)
	end)
	self:addElement(SelfIdentityBadge)
	self.SelfIdentityBadge = SelfIdentityBadge
	CommonIdentityWidgetStreamlined = CoD.CommonIdentityWidgetStreamlined.new(f1_arg0, f1_arg1, 0.5, 0.5, 280, 810, 0, 0, 9, 49)
	CommonIdentityWidgetStreamlined:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlined:setModel(model, f1_arg1)
	end)
	self:addElement(CommonIdentityWidgetStreamlined)
	self.CommonIdentityWidgetStreamlined = CommonIdentityWidgetStreamlined
	self:mergeStateConditions({
		{
			stateName = "AnimStateMixAgain",
			condition = function(menu, element, event)
				return CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN)
			end,
		},
		{
			stateName = "AnimStateMixAgainToNotPlaying",
			condition = function(menu, element, event)
				return CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.MIX_AGAIN_TO_NOT_PLAYING)
			end,
		},
		{
			stateName = "AnimStatePlaying",
			condition = function(menu, element, event)
				return not CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING)
			end,
		},
	})
	local f1_local7 = self
	f1_local6 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local7, f1_local8["Laboratory.animState"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "Laboratory.animState",
		})
	end, false)
	SelfIdentityBadge.id = "SelfIdentityBadge"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Laboratory_SafeAreaContainer.__resetProperties = function(f14_arg0)
	f14_arg0.CACHeader:completeAnimation()
	f14_arg0.BackingGrayMediumLeft:completeAnimation()
	f14_arg0.SelfIdentityBadge:completeAnimation()
	f14_arg0.StartMenuCurrencyCounts:completeAnimation()
	f14_arg0.CACHeader:setLeftRight(0.5, 0.5, -960, 960)
	f14_arg0.CACHeader:setTopBottom(0, 0, 0, 67)
	f14_arg0.CACHeader:setAlpha(1)
	f14_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, 0, 42)
	f14_arg0.BackingGrayMediumLeft:setAlpha(1)
	f14_arg0.SelfIdentityBadge:setTopBottom(0, 1, 0, 0)
	f14_arg0.SelfIdentityBadge:setAlpha(0)
	f14_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, 9, 89)
	f14_arg0.StartMenuCurrencyCounts:setAlpha(0)
end
CoD.Laboratory_SafeAreaContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		AnimStatePlaying = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				f16_arg0.CACHeader:beginAnimation(350)
				f16_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
				f16_arg0.CACHeader:setAlpha(0)
				f16_arg0.CACHeader:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.CACHeader:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.CACHeader:completeAnimation()
			f16_arg0.CACHeader:setLeftRight(0.5, 0.5, -960, 960)
			f16_arg0.CACHeader:setTopBottom(0, 0, 0, 67)
			f16_arg0.CACHeader:setAlpha(1)
			f16_local0(f16_arg0.CACHeader)
			local f16_local1 = function(f18_arg0)
				f16_arg0.BackingGrayMediumLeft:beginAnimation(350)
				f16_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, -85, -43)
				f16_arg0.BackingGrayMediumLeft:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.BackingGrayMediumLeft:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.BackingGrayMediumLeft:completeAnimation()
			f16_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, 0, 42)
			f16_local1(f16_arg0.BackingGrayMediumLeft)
			local f16_local2 = function(f19_arg0)
				f16_arg0.StartMenuCurrencyCounts:beginAnimation(350)
				f16_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, -76, 4)
				f16_arg0.StartMenuCurrencyCounts:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.StartMenuCurrencyCounts:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.StartMenuCurrencyCounts:completeAnimation()
			f16_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, 9, 89)
			f16_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f16_local2(f16_arg0.StartMenuCurrencyCounts)
			local f16_local3 = function(f20_arg0)
				f16_arg0.SelfIdentityBadge:beginAnimation(350)
				f16_arg0.SelfIdentityBadge:setTopBottom(0, 1, -85, -85)
				f16_arg0.SelfIdentityBadge:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SelfIdentityBadge:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.SelfIdentityBadge:completeAnimation()
			f16_arg0.SelfIdentityBadge:setTopBottom(0, 1, 0, 0)
			f16_arg0.SelfIdentityBadge:setAlpha(0)
			f16_local3(f16_arg0.SelfIdentityBadge)
		end,
	},
	AnimStateMixAgain = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.CACHeader:completeAnimation()
			f21_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f21_arg0.CACHeader:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CACHeader)
			f21_arg0.BackingGrayMediumLeft:completeAnimation()
			f21_arg0.BackingGrayMediumLeft:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.BackingGrayMediumLeft)
			f21_arg0.StartMenuCurrencyCounts:completeAnimation()
			f21_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.StartMenuCurrencyCounts)
		end,
		AnimStatePlaying = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.CACHeader:completeAnimation()
			f22_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f22_arg0.CACHeader:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CACHeader)
			f22_arg0.BackingGrayMediumLeft:completeAnimation()
			f22_arg0.BackingGrayMediumLeft:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BackingGrayMediumLeft)
			local f22_local0 = function(f23_arg0)
				f22_arg0.StartMenuCurrencyCounts:beginAnimation(350)
				f22_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, -76, 4)
				f22_arg0.StartMenuCurrencyCounts:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.StartMenuCurrencyCounts:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.StartMenuCurrencyCounts:completeAnimation()
			f22_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, 9, 89)
			f22_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f22_local0(f22_arg0.StartMenuCurrencyCounts)
			local f22_local1 = function(f24_arg0)
				f22_arg0.SelfIdentityBadge:beginAnimation(350)
				f22_arg0.SelfIdentityBadge:setTopBottom(0, 1, -85, -85)
				f22_arg0.SelfIdentityBadge:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.SelfIdentityBadge:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.SelfIdentityBadge:completeAnimation()
			f22_arg0.SelfIdentityBadge:setTopBottom(0, 1, 0, 0)
			f22_arg0.SelfIdentityBadge:setAlpha(0)
			f22_local1(f22_arg0.SelfIdentityBadge)
		end,
		AnimStateMixAgainToNotPlaying = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.CACHeader:completeAnimation()
			f25_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f25_arg0.CACHeader:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CACHeader)
			f25_arg0.BackingGrayMediumLeft:completeAnimation()
			f25_arg0.BackingGrayMediumLeft:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.BackingGrayMediumLeft)
			f25_arg0.StartMenuCurrencyCounts:completeAnimation()
			f25_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, 9, 89)
			f25_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.StartMenuCurrencyCounts)
		end,
	},
	AnimStateMixAgainToNotPlaying = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.CACHeader:completeAnimation()
			f26_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f26_arg0.CACHeader:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CACHeader)
			f26_arg0.BackingGrayMediumLeft:completeAnimation()
			f26_arg0.BackingGrayMediumLeft:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.BackingGrayMediumLeft)
			f26_arg0.StartMenuCurrencyCounts:completeAnimation()
			f26_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, 9, 89)
			f26_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.StartMenuCurrencyCounts)
		end,
		DefaultState = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.CACHeader:beginAnimation(350)
				f27_arg0.CACHeader:setTopBottom(0, 0, 0, 67)
				f27_arg0.CACHeader:setAlpha(1)
				f27_arg0.CACHeader:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.CACHeader:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.CACHeader:completeAnimation()
			f27_arg0.CACHeader:setLeftRight(0.5, 0.5, -960, 960)
			f27_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f27_arg0.CACHeader:setAlpha(0)
			f27_local0(f27_arg0.CACHeader)
			local f27_local1 = function(f29_arg0)
				f27_arg0.BackingGrayMediumLeft:beginAnimation(350)
				f27_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, 0, 42)
				f27_arg0.BackingGrayMediumLeft:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.BackingGrayMediumLeft:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.BackingGrayMediumLeft:completeAnimation()
			f27_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, -85, -43)
			f27_local1(f27_arg0.BackingGrayMediumLeft)
		end,
	},
	AnimStatePlaying = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			f30_arg0.CACHeader:completeAnimation()
			f30_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f30_arg0.CACHeader:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.CACHeader)
			f30_arg0.BackingGrayMediumLeft:completeAnimation()
			f30_arg0.BackingGrayMediumLeft:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.BackingGrayMediumLeft)
			f30_arg0.StartMenuCurrencyCounts:completeAnimation()
			f30_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, -76, 4)
			f30_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.StartMenuCurrencyCounts)
			f30_arg0.SelfIdentityBadge:completeAnimation()
			f30_arg0.SelfIdentityBadge:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.SelfIdentityBadge)
		end,
		DefaultState = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(4)
			local f31_local0 = function(f32_arg0)
				f31_arg0.CACHeader:beginAnimation(350)
				f31_arg0.CACHeader:setTopBottom(0, 0, 0, 67)
				f31_arg0.CACHeader:setAlpha(1)
				f31_arg0.CACHeader:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.CACHeader:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.CACHeader:completeAnimation()
			f31_arg0.CACHeader:setLeftRight(0.5, 0.5, -960, 960)
			f31_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f31_arg0.CACHeader:setAlpha(0)
			f31_local0(f31_arg0.CACHeader)
			local f31_local1 = function(f33_arg0)
				f31_arg0.BackingGrayMediumLeft:beginAnimation(350)
				f31_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, 0, 42)
				f31_arg0.BackingGrayMediumLeft:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BackingGrayMediumLeft:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.BackingGrayMediumLeft:completeAnimation()
			f31_arg0.BackingGrayMediumLeft:setTopBottom(0, 0, -85, -43)
			f31_local1(f31_arg0.BackingGrayMediumLeft)
			local f31_local2 = function(f34_arg0)
				f31_arg0.StartMenuCurrencyCounts:beginAnimation(350)
				f31_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, 9, 89)
				f31_arg0.StartMenuCurrencyCounts:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.StartMenuCurrencyCounts:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.StartMenuCurrencyCounts:completeAnimation()
			f31_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, -76, 4)
			f31_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f31_local2(f31_arg0.StartMenuCurrencyCounts)
			local f31_local3 = function(f35_arg0)
				f31_arg0.SelfIdentityBadge:beginAnimation(350)
				f31_arg0.SelfIdentityBadge:setTopBottom(0, 1, 0, 0)
				f31_arg0.SelfIdentityBadge:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.SelfIdentityBadge:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.SelfIdentityBadge:completeAnimation()
			f31_arg0.SelfIdentityBadge:setTopBottom(0, 1, -85, -85)
			f31_arg0.SelfIdentityBadge:setAlpha(0)
			f31_local3(f31_arg0.SelfIdentityBadge)
		end,
		AnimStateMixAgain = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(4)
			f36_arg0.CACHeader:completeAnimation()
			f36_arg0.CACHeader:setTopBottom(0, 0, -85, -18)
			f36_arg0.CACHeader:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.CACHeader)
			f36_arg0.BackingGrayMediumLeft:completeAnimation()
			f36_arg0.BackingGrayMediumLeft:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.BackingGrayMediumLeft)
			local f36_local0 = function(f37_arg0)
				f36_arg0.StartMenuCurrencyCounts:beginAnimation(350)
				f36_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, 9, 89)
				f36_arg0.StartMenuCurrencyCounts:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.StartMenuCurrencyCounts:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.StartMenuCurrencyCounts:completeAnimation()
			f36_arg0.StartMenuCurrencyCounts:setTopBottom(0, 0, -76, 4)
			f36_arg0.StartMenuCurrencyCounts:setAlpha(0)
			f36_local0(f36_arg0.StartMenuCurrencyCounts)
			local f36_local1 = function(f38_arg0)
				f36_arg0.SelfIdentityBadge:beginAnimation(350)
				f36_arg0.SelfIdentityBadge:setTopBottom(0, 1, 0, 0)
				f36_arg0.SelfIdentityBadge:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.SelfIdentityBadge:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.SelfIdentityBadge:completeAnimation()
			f36_arg0.SelfIdentityBadge:setTopBottom(0, 1, -85, -85)
			f36_arg0.SelfIdentityBadge:setAlpha(0)
			f36_local1(f36_arg0.SelfIdentityBadge)
		end,
	},
}
CoD.Laboratory_SafeAreaContainer.__onClose = function(f39_arg0)
	f39_arg0.CACHeader:close()
	f39_arg0.BackingGrayMediumLeft:close()
	f39_arg0.StartMenuCurrencyCounts:close()
	f39_arg0.SelfIdentityBadge:close()
	f39_arg0.CommonIdentityWidgetStreamlined:close()
end

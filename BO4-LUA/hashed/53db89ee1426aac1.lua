require("x64:c45396f7013b2c4")
require("x64:2dd0805105021ee")
require("x64:2c66d084109a1d3")
require("x64:71ed8b3e4859248")
CoD.Prestige_WLRewardsWidget = InheritFrom(LUI.UIElement)
CoD.Prestige_WLRewardsWidget.__defaultWidth = 128
CoD.Prestige_WLRewardsWidget.__defaultHeight = 440
CoD.Prestige_WLRewardsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_WLRewardsWidget)
	self.id = "Prestige_WLRewardsWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BodyBg = CoD.Prestige_LevelRewardsBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 40.5, 486.5)
	BodyBg:linkToElementModel(self, nil, false, function(model)
		BodyBg:setModel(model, f1_arg1)
	end)
	self:addElement(BodyBg)
	self.BodyBg = BodyBg
	local BodyBgAdd = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 41, 486)
	BodyBgAdd:setRGB(0.92, 0.92, 0.92)
	BodyBgAdd:setAlpha(0)
	self:addElement(BodyBgAdd)
	self.BodyBgAdd = BodyBgAdd
	local sizeElement = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 444)
	sizeElement:setAlpha(0)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	local RankImage = CoD.Prestige_WLReward.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 41.5, 195.5)
	RankImage:linkToElementModel(self, "reward1", false, function(model)
		RankImage:setModel(model, f1_arg1)
	end)
	RankImage:linkToElementModel(self, "iconLarge", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RankImage.RewardImage:setImage(RegisterImage(f4_local0))
		end
	end)
	RankImage:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfo(self, f1_arg1, element)
		return f5_local0
	end)
	self:addElement(RankImage)
	self.RankImage = RankImage
	local infoBracketTop = LUI.UIImage.new(0, 0, -1, 129, 0, 0, 39.5, 47.5)
	infoBracketTop:setAlpha(0.2)
	infoBracketTop:setZRot(180)
	infoBracketTop:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketTop:setShaderVector(0, 0, 0, 0, 0)
	infoBracketTop:setupNineSliceShader(16, 4)
	self:addElement(infoBracketTop)
	self.infoBracketTop = infoBracketTop
	local HeaderBackground = CoD.Prestige_LevelRewardsHeader.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 0, 37)
	HeaderBackground:linkToElementModel(self, nil, false, function(model)
		HeaderBackground:setModel(model, f1_arg1)
	end)
	self:addElement(HeaderBackground)
	self.HeaderBackground = HeaderBackground
	local RewardLevel = LUI.UIText.new(0, 0, 0, 200, 0, 0, 7, 32)
	RewardLevel:setRGB(0.92, 0.92, 0.92)
	RewardLevel:setTTF("ttmussels_demibold")
	RewardLevel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RewardLevel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	RewardLevel:linkToElementModel(self, "displayLevel", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RewardLevel:setText(CoD.PrestigeUtility.LocalizeIfMaxRank(@"hash_54008CE61FE52DCD", f7_local0))
		end
	end)
	self:addElement(RewardLevel)
	self.RewardLevel = RewardLevel
	local infoBracketBot = LUI.UIImage.new(0, 0, -1, 129, 0, 0, 188.5, 196.5)
	infoBracketBot:setAlpha(0.2)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local GridBodyBg = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 199, 506)
	GridBodyBg:setAlpha(0.02)
	GridBodyBg:setImage(RegisterImage(@"uie_ui_hud_vehicle_lightstrike_grid"))
	GridBodyBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridBodyBg:setShaderVector(0, 0, 0, 0, 0)
	GridBodyBg:setupNineSliceShader(22, 22)
	self:addElement(GridBodyBg)
	self.GridBodyBg = GridBodyBg
	local Rewards = LUI.UIText.new(0, 0, -36, 164, 0, 0, 410.5, 428.5)
	Rewards:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Rewards:setText(LocalizeToUpperString(@"menu/rewards"))
	Rewards:setTTF("ttmussels_regular")
	Rewards:setLetterSpacing(1)
	Rewards:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Rewards:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Rewards)
	self.Rewards = Rewards
	local ArenaProgressionRubies = CoD.ArenaProgressionRubies.new(f1_arg0, f1_arg1, 0, 0, -6, 134, 0, 0, 207, 281)
	ArenaProgressionRubies:mergeStateConditions({
		{
			stateName = "FourRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyRequirementForModelEqualValue(element, f1_arg1, "leagueRank", 4)
			end,
		},
		{
			stateName = "FiveRubies",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.DoesRubyRequirementForModelEqualValue(element, f1_arg1, "leagueRank", 5)
			end,
		},
	})
	ArenaProgressionRubies:linkToElementModel(self, nil, false, function(model)
		ArenaProgressionRubies:setModel(model, f1_arg1)
	end)
	ArenaProgressionRubies:linkToElementModel(self, nil, false, function(model)
		ArenaProgressionRubies.threeRubyLayout:setModel(model, f1_arg1)
	end)
	ArenaProgressionRubies:linkToElementModel(self, nil, false, function(model)
		ArenaProgressionRubies.fourRubyLayout:setModel(model, f1_arg1)
	end)
	ArenaProgressionRubies:linkToElementModel(self, nil, false, function(model)
		ArenaProgressionRubies.fiveRubyLayout:setModel(model, f1_arg1)
	end)
	self:addElement(ArenaProgressionRubies)
	self.ArenaProgressionRubies = ArenaProgressionRubies
	local DailyBonusArrow = LUI.UIImage.new(0, 0, 60, 68, 0, 0, 394.5, 410.5)
	DailyBonusArrow:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	DailyBonusArrow:setAlpha(0)
	DailyBonusArrow:setZRot(90)
	DailyBonusArrow:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	self:addElement(DailyBonusArrow)
	self.DailyBonusArrow = DailyBonusArrow
	self:mergeStateConditions({
		{
			stateName = "WideState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "wideLayout")
			end,
		},
		{
			stateName = "RewardsState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "rewardsLayout")
			end,
		},
	})
	self:linkToElementModel(self, "wideLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "wideLayout",
		})
	end)
	self:linkToElementModel(self, "rewardsLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rewardsLayout",
		})
	end)
	RankImage.id = "RankImage"
	self.__defaultFocus = RankImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_WLRewardsWidget.__resetProperties = function(f18_arg0)
	f18_arg0.RewardLevel:completeAnimation()
	f18_arg0.Rewards:completeAnimation()
	f18_arg0.HeaderBackground:completeAnimation()
	f18_arg0.sizeElement:completeAnimation()
	f18_arg0.RankImage:completeAnimation()
	f18_arg0.infoBracketBot:completeAnimation()
	f18_arg0.infoBracketTop:completeAnimation()
	f18_arg0.DailyBonusArrow:completeAnimation()
	f18_arg0.RewardLevel:setLeftRight(0, 0, 0, 200)
	f18_arg0.Rewards:setAlpha(1)
	f18_arg0.HeaderBackground:setLeftRight(0, 0, 0, 128)
	f18_arg0.sizeElement:setLeftRight(0, 0, 0, 128)
	f18_arg0.RankImage:setLeftRight(0, 0, 0, 128)
	f18_arg0.RankImage:setTopBottom(0, 0, 41.5, 195.5)
	f18_arg0.infoBracketBot:setLeftRight(0, 0, -1, 129)
	f18_arg0.infoBracketBot:setTopBottom(0, 0, 188.5, 196.5)
	f18_arg0.infoBracketTop:setLeftRight(0, 0, -1, 129)
	f18_arg0.DailyBonusArrow:setAlpha(0)
end
CoD.Prestige_WLRewardsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.RewardLevel:completeAnimation()
			f19_arg0.RewardLevel:setLeftRight(0, 0, 0, 128)
			f19_arg0.clipFinished(f19_arg0.RewardLevel)
			f19_arg0.Rewards:completeAnimation()
			f19_arg0.Rewards:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Rewards)
		end,
	},
	WideState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
			f20_arg0.sizeElement:completeAnimation()
			f20_arg0.sizeElement:setLeftRight(0, 0, 0, 256)
			f20_arg0.clipFinished(f20_arg0.sizeElement)
			f20_arg0.RankImage:completeAnimation()
			f20_arg0.RankImage:setLeftRight(0, 0, 0, 256)
			f20_arg0.RankImage:setTopBottom(0, 0, 41.5, 437.5)
			f20_arg0.clipFinished(f20_arg0.RankImage)
			f20_arg0.infoBracketTop:completeAnimation()
			f20_arg0.infoBracketTop:setLeftRight(0, 0, -1, 257)
			f20_arg0.clipFinished(f20_arg0.infoBracketTop)
			f20_arg0.HeaderBackground:completeAnimation()
			f20_arg0.HeaderBackground:setLeftRight(0, 0, 0, 256)
			f20_arg0.clipFinished(f20_arg0.HeaderBackground)
			f20_arg0.RewardLevel:completeAnimation()
			f20_arg0.RewardLevel:setLeftRight(0, 0, 0, 256)
			f20_arg0.clipFinished(f20_arg0.RewardLevel)
			f20_arg0.infoBracketBot:completeAnimation()
			f20_arg0.infoBracketBot:setLeftRight(0, 0, -1, 257)
			f20_arg0.infoBracketBot:setTopBottom(0, 0, 427, 435)
			f20_arg0.clipFinished(f20_arg0.infoBracketBot)
			f20_arg0.Rewards:completeAnimation()
			f20_arg0.Rewards:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Rewards)
		end,
	},
	RewardsState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.RewardLevel:completeAnimation()
			f21_arg0.RewardLevel:setLeftRight(0, 0, -36, 164)
			f21_arg0.clipFinished(f21_arg0.RewardLevel)
			f21_arg0.Rewards:completeAnimation()
			f21_arg0.Rewards:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Rewards)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							f25_arg0:beginAnimation(200)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
						end
						f24_arg0:beginAnimation(1999)
						f24_arg0:setAlpha(0.2)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(200)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f21_arg0.DailyBonusArrow:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_out"])
				f21_arg0.DailyBonusArrow:setAlpha(1)
				f21_arg0.DailyBonusArrow:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.DailyBonusArrow:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.DailyBonusArrow:completeAnimation()
			f21_arg0.DailyBonusArrow:setAlpha(0.2)
			f21_local0(f21_arg0.DailyBonusArrow)
		end,
	},
}
CoD.Prestige_WLRewardsWidget.__onClose = function(f26_arg0)
	f26_arg0.BodyBg:close()
	f26_arg0.RankImage:close()
	f26_arg0.HeaderBackground:close()
	f26_arg0.RewardLevel:close()
	f26_arg0.ArenaProgressionRubies:close()
end

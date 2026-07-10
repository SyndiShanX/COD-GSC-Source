require("x64:68d2be12a9d6269")
require("x64:228a7baa572b047")
require("x64:46728994d8c06c0")
require("x64:7e4e02d14f58fd3")
require("x64:52c00340376bb87")
CoD.Prestige_DetailsPanel = InheritFrom(LUI.UIElement)
CoD.Prestige_DetailsPanel.__defaultWidth = 400
CoD.Prestige_DetailsPanel.__defaultHeight = 530
CoD.Prestige_DetailsPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_DetailsPanel)
	self.id = "Prestige_DetailsPanel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 530)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setRGB(0, 0, 0)
	CommonDetailPanel2.BackingTint:setAlpha(0.85)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local bgEkia = LUI.UIImage.new(0.5, 0.5, -192, 192, 0, 0, 265.5, 522.5)
	bgEkia:setRGB(0.23, 0.23, 0.23)
	bgEkia:setAlpha(0.25)
	self:addElement(bgEkia)
	self.bgEkia = bgEkia
	local DetailsPanelMainImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -190, 190, 0, 0, 113, 423)
	DetailsPanelMainImage:setStretchedDimension(6)
	DetailsPanelMainImage:linkToElementModel(self, "imageLarge", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DetailsPanelMainImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserDataOrCallingCard(f2_local0))
		end
	end)
	self:addElement(DetailsPanelMainImage)
	self.DetailsPanelMainImage = DetailsPanelMainImage
	local SecondaryWZRewardImage = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -187.5, 187.5, 0, 0, 283, 373)
	SecondaryWZRewardImage:setAlpha(0)
	SecondaryWZRewardImage:linkToElementModel(self, nil, false, function(model)
		SecondaryWZRewardImage:setModel(model, f1_arg1)
	end)
	self:addElement(SecondaryWZRewardImage)
	self.SecondaryWZRewardImage = SecondaryWZRewardImage
	local PrimaryWZRewardImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -187.5, 187.5, 0, 0, 127, 217)
	PrimaryWZRewardImage:setAlpha(0)
	PrimaryWZRewardImage:linkToElementModel(self, "image", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PrimaryWZRewardImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f4_local0))
		end
	end)
	self:addElement(PrimaryWZRewardImage)
	self.PrimaryWZRewardImage = PrimaryWZRewardImage
	local WorldLeagueRankText = LUI.UIText.new(0, 0, 100.5, 300.5, 0, 0, 442, 472)
	WorldLeagueRankText:setTTF("ttmussels_demibold")
	WorldLeagueRankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	WorldLeagueRankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	WorldLeagueRankText:linkToElementModel(self, "rankDisplay", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			WorldLeagueRankText:setText(ConvertToUpperString(LocalizeIntoString(@"menu/rank_n", f5_local0)))
		end
	end)
	self:addElement(WorldLeagueRankText)
	self.WorldLeagueRankText = WorldLeagueRankText
	local EchelonText = LUI.UIText.new(0, 0, 20, 381, 0, 0, 404.5, 439.5)
	EchelonText:setAlpha(0)
	EchelonText:setTTF("ttmussels_demibold")
	EchelonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EchelonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	EchelonText:linkToElementModel(self, "rankDisplay", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			EchelonText:setText(LocalizeToUpperString(LocalizeIntoString(@"hash_2294790D215078A9", f6_local0)))
		end
	end)
	self:addElement(EchelonText)
	self.EchelonText = EchelonText
	local GridLayout = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 3, 0, nil, nil, false, false, false, false)
	GridLayout:setLeftRight(0, 0, 0, 400)
	GridLayout:setTopBottom(0, 0, 272, 476)
	GridLayout:setWidgetType(CoD.Prestige_LoadoutInfoRow)
	GridLayout:setVerticalCount(9)
	GridLayout:setSpacing(3)
	GridLayout:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GridLayout:setDataSource("LevelRewardLoadoutInfo")
	GridLayout:linkToElementModel(self, "itemIndex", true, function(model)
		CoD.GridAndListUtility.UpdateDataSource(GridLayout, true, true, true)
	end)
	self:addElement(GridLayout)
	self.GridLayout = GridLayout
	local LevelRequirementText = CoD.Prestige_DetailsUnlockedIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 471.5, 523.5)
	LevelRequirementText:linkToElementModel(self, nil, false, function(model)
		LevelRequirementText:setModel(model, f1_arg1)
	end)
	self:addElement(LevelRequirementText)
	self.LevelRequirementText = LevelRequirementText
	local LoadoutImage1 = LUI.UIImage.new(0, 0, 29, 200, 0, 0, 111.5, 239.5)
	LoadoutImage1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	LoadoutImage1:setShaderVector(0, 0.5, 0.5, 0, 0)
	LoadoutImage1:setShaderVector(1, 1, 1, 0, 0)
	LoadoutImage1:setShaderVector(2, 0, 0, 0, 0)
	LoadoutImage1:linkToElementModel(self, "image", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			LoadoutImage1:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f9_local0))
		end
	end)
	self:addElement(LoadoutImage1)
	self.LoadoutImage1 = LoadoutImage1
	local DetailsPanelSubTitle = LUI.UIText.new(0.5, 0.5, -198, 198, 0, 0, 68, 86)
	DetailsPanelSubTitle:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	DetailsPanelSubTitle:setAlpha(0.5)
	DetailsPanelSubTitle:setTTF("ttmussels_regular")
	DetailsPanelSubTitle:setLetterSpacing(2)
	DetailsPanelSubTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DetailsPanelSubTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	DetailsPanelSubTitle:linkToElementModel(self, "itemGroupName", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			DetailsPanelSubTitle:setText(CoD.BaseUtility.LocalizeIfXHash(f10_local0))
		end
	end)
	self:addElement(DetailsPanelSubTitle)
	self.DetailsPanelSubTitle = DetailsPanelSubTitle
	local DetailsPanelTitle = LUI.UIText.new(0.5, 0.5, -197.5, 198.5, 0, 0, 26, 61)
	DetailsPanelTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	DetailsPanelTitle:setTTF("ttmussels_demibold")
	DetailsPanelTitle:setLetterSpacing(2)
	DetailsPanelTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DetailsPanelTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	DetailsPanelTitle:linkToElementModel(self, "displayName", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DetailsPanelTitle:setText(LocalizeToUpperString(f11_local0))
		end
	end)
	self:addElement(DetailsPanelTitle)
	self.DetailsPanelTitle = DetailsPanelTitle
	local DetailsPanelHeader = LUI.UIText.new(0.5, 0.5, -199.5, 200.5, 0, 0, 3.5, 28.5)
	DetailsPanelHeader:setRGB(0.78, 0.78, 0.78)
	DetailsPanelHeader:setAlpha(0)
	DetailsPanelHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2871519113740169"))
	DetailsPanelHeader:setTTF("ttmussels_regular")
	DetailsPanelHeader:setLetterSpacing(2)
	DetailsPanelHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DetailsPanelHeader:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(DetailsPanelHeader)
	self.DetailsPanelHeader = DetailsPanelHeader
	local FuiBox02Right = LUI.UIImage.new(0, 0, 364, 398, 0, 0, 37, 3)
	FuiBox02Right:setAlpha(0.15)
	FuiBox02Right:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local FuiBox02Left = LUI.UIImage.new(0, 0, 37, 3, 0, 0, 37, 3)
	FuiBox02Left:setAlpha(0.15)
	FuiBox02Left:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Left:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Left:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Left)
	self.FuiBox02Left = FuiBox02Left
	local ZMLoadoutImage = LUI.UIFixedAspectRatioImage.new(0, 0, 136.5, 264.5, 0, 0, 108, 236)
	ZMLoadoutImage:setAlpha(0)
	ZMLoadoutImage:linkToElementModel(self, "image", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ZMLoadoutImage:setImage(CoD.BaseUtility.AlreadyRegisteredIfUserData(f12_local0))
		end
	end)
	self:addElement(ZMLoadoutImage)
	self.ZMLoadoutImage = ZMLoadoutImage
	local Ruby4 = CoD.LeaguePlayRuby.new(f1_arg0, f1_arg1, 0.5, 0.5, -20, 20, 0.5, 0.5, 221, 261)
	Ruby4:setAlpha(0)
	Ruby4:setScale(0.8, 0.8)
	self:addElement(Ruby4)
	self.Ruby4 = Ruby4
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rankIndex", 0)
			end,
		},
		{
			stateName = "LoadoutView",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "itemIndex", CoD.CACUtility.EmptyItemIndex) and not IsZombies()
			end,
		},
		{
			stateName = "WZRewardsState",
			condition = function(menu, element, event)
				local f15_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "useWideLayout")
				if f15_local0 then
					f15_local0 = IsWarzone()
					if f15_local0 then
						f15_local0 = IsPrestigeLevelAtZero(f1_arg1)
					end
				end
				return f15_local0
			end,
		},
		{
			stateName = "WZEmptyState",
			condition = function(menu, element, event)
				local f16_local0
				if not IsPrestigeLevelAtZero(f1_arg1) then
					f16_local0 = IsWarzone()
					if f16_local0 then
						f16_local0 = AlwaysFalse()
					end
				else
					f16_local0 = false
				end
				return f16_local0
			end,
		},
		{
			stateName = "WZState",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
		{
			stateName = "ZMLoadoutView",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "itemIndex", CoD.CACUtility.EmptyItemIndex) and IsZombies()
			end,
		},
		{
			stateName = "WLRewardsState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "useRewardLayout") and IsArenaMode()
			end,
		},
		{
			stateName = "WLState",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
	})
	self:linkToElementModel(self, "rankIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rankIndex",
		})
	end)
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[@"getglobalmodel"]()
	f1_local19(f1_local18, f1_local20["lobbyRoot.lobbyNav"], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "useWideLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "useWideLayout",
		})
	end)
	self:linkToElementModel(self, "useRewardLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "useRewardLayout",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f26_arg2, f26_arg3, f26_arg4)
		if IsSelfInState(self, "WZState") then
			CoD.BaseUtility.UpdateFixedRatioImageDimensions(self.DetailsPanelMainImage)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.ModelUtility.SetGlobalDatasourceModelValue(f1_arg1, "PrestigeMenuInfo", "currentHighlightedItem.rankIndex", -1)
	end)
	SecondaryWZRewardImage.id = "SecondaryWZRewardImage"
	GridLayout.id = "GridLayout"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_DetailsPanel.__resetProperties = function(f28_arg0)
	f28_arg0.GridLayout:completeAnimation()
	f28_arg0.LoadoutImage1:completeAnimation()
	f28_arg0.DetailsPanelMainImage:completeAnimation()
	f28_arg0.DetailsPanelTitle:completeAnimation()
	f28_arg0.DetailsPanelSubTitle:completeAnimation()
	f28_arg0.bgEkia:completeAnimation()
	f28_arg0.WorldLeagueRankText:completeAnimation()
	f28_arg0.LevelRequirementText:completeAnimation()
	f28_arg0.FuiBox02Left:completeAnimation()
	f28_arg0.FuiBox02Right:completeAnimation()
	f28_arg0.ZMLoadoutImage:completeAnimation()
	f28_arg0.DetailsPanelHeader:completeAnimation()
	f28_arg0.EchelonText:completeAnimation()
	f28_arg0.PrimaryWZRewardImage:completeAnimation()
	f28_arg0.SecondaryWZRewardImage:completeAnimation()
	f28_arg0.CommonDetailPanel2:completeAnimation()
	f28_arg0.Ruby4:completeAnimation()
	f28_arg0.GridLayout:setTopBottom(0, 0, 272, 476)
	f28_arg0.GridLayout:setAlpha(1)
	f28_arg0.LoadoutImage1:setLeftRight(0, 0, 29, 200)
	f28_arg0.LoadoutImage1:setAlpha(1)
	f28_arg0.DetailsPanelMainImage:setLeftRight(0.5, 0.5, -190, 190)
	f28_arg0.DetailsPanelMainImage:setTopBottom(0, 0, 113, 423)
	f28_arg0.DetailsPanelMainImage:setAlpha(1)
	f28_arg0.DetailsPanelTitle:setAlpha(1)
	f28_arg0.DetailsPanelSubTitle:setTopBottom(0, 0, 68, 86)
	f28_arg0.DetailsPanelSubTitle:setAlpha(0.5)
	f28_arg0.bgEkia:setTopBottom(0, 0, 265.5, 522.5)
	f28_arg0.bgEkia:setAlpha(0.25)
	f28_arg0.WorldLeagueRankText:setTopBottom(0, 0, 442, 472)
	f28_arg0.WorldLeagueRankText:setAlpha(1)
	f28_arg0.WorldLeagueRankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	f28_arg0.LevelRequirementText:setAlpha(1)
	f28_arg0.FuiBox02Left:setAlpha(0.15)
	f28_arg0.FuiBox02Right:setAlpha(0.15)
	f28_arg0.ZMLoadoutImage:setLeftRight(0, 0, 136.5, 264.5)
	f28_arg0.ZMLoadoutImage:setAlpha(0)
	f28_arg0.DetailsPanelHeader:setAlpha(0)
	f28_arg0.EchelonText:setTopBottom(0, 0, 404.5, 439.5)
	f28_arg0.EchelonText:setAlpha(0)
	f28_arg0.PrimaryWZRewardImage:setAlpha(0)
	f28_arg0.SecondaryWZRewardImage:setAlpha(0)
	f28_arg0.CommonDetailPanel2:setAlpha(1)
	f28_arg0.Ruby4:setAlpha(0)
end
CoD.Prestige_DetailsPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(8)
			f29_arg0.bgEkia:completeAnimation()
			f29_arg0.bgEkia:setTopBottom(0, 0, 97.5, 521.5)
			f29_arg0.clipFinished(f29_arg0.bgEkia)
			local f29_local0 = function(f30_arg0)
				f29_arg0.DetailsPanelMainImage:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f29_arg0.DetailsPanelMainImage:setAlpha(1)
				f29_arg0.DetailsPanelMainImage:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DetailsPanelMainImage:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DetailsPanelMainImage:completeAnimation()
			f29_arg0.DetailsPanelMainImage:setAlpha(0)
			f29_local0(f29_arg0.DetailsPanelMainImage)
			f29_arg0.WorldLeagueRankText:completeAnimation()
			f29_arg0.WorldLeagueRankText:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.WorldLeagueRankText)
			f29_arg0.GridLayout:completeAnimation()
			f29_arg0.GridLayout:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.GridLayout)
			local f29_local1 = function(f31_arg0)
				f31_arg0:beginAnimation(150)
				f31_arg0:setAlpha(1)
				f31_arg0:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.LevelRequirementText:beginAnimation(50)
			f29_arg0.LevelRequirementText:setAlpha(0)
			f29_arg0.LevelRequirementText:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
			f29_arg0.LevelRequirementText:registerEventHandler("transition_complete_keyframe", f29_local1)
			f29_arg0.LoadoutImage1:completeAnimation()
			f29_arg0.LoadoutImage1:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.LoadoutImage1)
			local f29_local2 = function(f32_arg0)
				f29_arg0.DetailsPanelSubTitle:beginAnimation(150)
				f29_arg0.DetailsPanelSubTitle:setAlpha(0.5)
				f29_arg0.DetailsPanelSubTitle:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DetailsPanelSubTitle:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DetailsPanelSubTitle:completeAnimation()
			f29_arg0.DetailsPanelSubTitle:setAlpha(0)
			f29_local2(f29_arg0.DetailsPanelSubTitle)
			local f29_local3 = function(f33_arg0)
				f29_arg0.DetailsPanelTitle:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f29_arg0.DetailsPanelTitle:setAlpha(1)
				f29_arg0.DetailsPanelTitle:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DetailsPanelTitle:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DetailsPanelTitle:completeAnimation()
			f29_arg0.DetailsPanelTitle:setAlpha(0)
			f29_local3(f29_arg0.DetailsPanelTitle)
		end,
	},
	Hidden = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(16)
			f34_arg0.CommonDetailPanel2:completeAnimation()
			f34_arg0.CommonDetailPanel2:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.CommonDetailPanel2)
			f34_arg0.bgEkia:completeAnimation()
			f34_arg0.bgEkia:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.bgEkia)
			f34_arg0.DetailsPanelMainImage:completeAnimation()
			f34_arg0.DetailsPanelMainImage:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DetailsPanelMainImage)
			f34_arg0.SecondaryWZRewardImage:completeAnimation()
			f34_arg0.SecondaryWZRewardImage:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.SecondaryWZRewardImage)
			f34_arg0.PrimaryWZRewardImage:completeAnimation()
			f34_arg0.PrimaryWZRewardImage:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.PrimaryWZRewardImage)
			f34_arg0.WorldLeagueRankText:completeAnimation()
			f34_arg0.WorldLeagueRankText:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.WorldLeagueRankText)
			f34_arg0.EchelonText:completeAnimation()
			f34_arg0.EchelonText:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.EchelonText)
			f34_arg0.GridLayout:completeAnimation()
			f34_arg0.GridLayout:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.GridLayout)
			f34_arg0.LevelRequirementText:completeAnimation()
			f34_arg0.LevelRequirementText:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.LevelRequirementText)
			f34_arg0.LoadoutImage1:completeAnimation()
			f34_arg0.LoadoutImage1:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.LoadoutImage1)
			f34_arg0.DetailsPanelSubTitle:completeAnimation()
			f34_arg0.DetailsPanelSubTitle:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DetailsPanelSubTitle)
			f34_arg0.DetailsPanelTitle:completeAnimation()
			f34_arg0.DetailsPanelTitle:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DetailsPanelTitle)
			f34_arg0.DetailsPanelHeader:completeAnimation()
			f34_arg0.DetailsPanelHeader:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DetailsPanelHeader)
			f34_arg0.FuiBox02Right:completeAnimation()
			f34_arg0.FuiBox02Right:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.FuiBox02Right)
			f34_arg0.FuiBox02Left:completeAnimation()
			f34_arg0.FuiBox02Left:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.FuiBox02Left)
			f34_arg0.ZMLoadoutImage:completeAnimation()
			f34_arg0.ZMLoadoutImage:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ZMLoadoutImage)
		end,
	},
	LoadoutView = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(8)
			f35_arg0.bgEkia:completeAnimation()
			f35_arg0.bgEkia:setTopBottom(0, 0, 97.5, 521.5)
			f35_arg0.clipFinished(f35_arg0.bgEkia)
			f35_arg0.DetailsPanelMainImage:completeAnimation()
			f35_arg0.DetailsPanelMainImage:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.DetailsPanelMainImage)
			f35_arg0.WorldLeagueRankText:completeAnimation()
			f35_arg0.WorldLeagueRankText:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.WorldLeagueRankText)
			local f35_local0 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(150)
					f37_arg0:setAlpha(1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
				end
				f35_arg0.GridLayout:beginAnimation(50)
				f35_arg0.GridLayout:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.GridLayout:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f35_arg0.GridLayout:completeAnimation()
			f35_arg0.GridLayout:setAlpha(0)
			f35_local0(f35_arg0.GridLayout)
			local f35_local1 = function(f38_arg0)
				f38_arg0:beginAnimation(150)
				f38_arg0:setAlpha(1)
				f38_arg0:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.LevelRequirementText:beginAnimation(50)
			f35_arg0.LevelRequirementText:setAlpha(0)
			f35_arg0.LevelRequirementText:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
			f35_arg0.LevelRequirementText:registerEventHandler("transition_complete_keyframe", f35_local1)
			local f35_local2 = function(f39_arg0)
				f35_arg0.LoadoutImage1:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f35_arg0.LoadoutImage1:setAlpha(1)
				f35_arg0.LoadoutImage1:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.LoadoutImage1:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.LoadoutImage1:completeAnimation()
			f35_arg0.LoadoutImage1:setLeftRight(0, 0, 29.5, 371.5)
			f35_arg0.LoadoutImage1:setAlpha(0)
			f35_local2(f35_arg0.LoadoutImage1)
			local f35_local3 = function(f40_arg0)
				f35_arg0.DetailsPanelSubTitle:beginAnimation(150)
				f35_arg0.DetailsPanelSubTitle:setAlpha(0.5)
				f35_arg0.DetailsPanelSubTitle:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.DetailsPanelSubTitle:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.DetailsPanelSubTitle:completeAnimation()
			f35_arg0.DetailsPanelSubTitle:setAlpha(0)
			f35_local3(f35_arg0.DetailsPanelSubTitle)
			local f35_local4 = function(f41_arg0)
				f35_arg0.DetailsPanelTitle:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f35_arg0.DetailsPanelTitle:setAlpha(1)
				f35_arg0.DetailsPanelTitle:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.DetailsPanelTitle:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.DetailsPanelTitle:completeAnimation()
			f35_arg0.DetailsPanelTitle:setAlpha(0)
			f35_local4(f35_arg0.DetailsPanelTitle)
		end,
	},
	WZRewardsState = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(10)
			f42_arg0.bgEkia:completeAnimation()
			f42_arg0.bgEkia:setTopBottom(0, 0, 433.5, 521.5)
			f42_arg0.clipFinished(f42_arg0.bgEkia)
			f42_arg0.DetailsPanelMainImage:completeAnimation()
			f42_arg0.DetailsPanelMainImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.DetailsPanelMainImage)
			local f42_local0 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					f44_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
				end
				f42_arg0.SecondaryWZRewardImage:beginAnimation(50)
				f42_arg0.SecondaryWZRewardImage:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.SecondaryWZRewardImage:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f42_arg0.SecondaryWZRewardImage:completeAnimation()
			f42_arg0.SecondaryWZRewardImage:setAlpha(0)
			f42_local0(f42_arg0.SecondaryWZRewardImage)
			local f42_local1 = function(f45_arg0)
				f42_arg0.PrimaryWZRewardImage:beginAnimation(150)
				f42_arg0.PrimaryWZRewardImage:setAlpha(1)
				f42_arg0.PrimaryWZRewardImage:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.PrimaryWZRewardImage:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.PrimaryWZRewardImage:completeAnimation()
			f42_arg0.PrimaryWZRewardImage:setAlpha(0)
			f42_local1(f42_arg0.PrimaryWZRewardImage)
			f42_arg0.WorldLeagueRankText:completeAnimation()
			f42_arg0.WorldLeagueRankText:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.WorldLeagueRankText)
			f42_arg0.GridLayout:completeAnimation()
			f42_arg0.GridLayout:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.GridLayout)
			f42_arg0.LevelRequirementText:completeAnimation()
			f42_arg0.LevelRequirementText:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.LevelRequirementText)
			f42_arg0.LoadoutImage1:completeAnimation()
			f42_arg0.LoadoutImage1:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.LoadoutImage1)
			local f42_local2 = function(f46_arg0)
				f42_arg0.DetailsPanelSubTitle:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
				f42_arg0.DetailsPanelSubTitle:setAlpha(0.5)
				f42_arg0.DetailsPanelSubTitle:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.DetailsPanelSubTitle:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.DetailsPanelSubTitle:completeAnimation()
			f42_arg0.DetailsPanelSubTitle:setTopBottom(0, 0, 469.5, 489.5)
			f42_arg0.DetailsPanelSubTitle:setAlpha(0)
			f42_local2(f42_arg0.DetailsPanelSubTitle)
			local f42_local3 = function(f47_arg0)
				f42_arg0.DetailsPanelTitle:beginAnimation(150)
				f42_arg0.DetailsPanelTitle:setAlpha(1)
				f42_arg0.DetailsPanelTitle:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.DetailsPanelTitle:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.DetailsPanelTitle:completeAnimation()
			f42_arg0.DetailsPanelTitle:setAlpha(0)
			f42_local3(f42_arg0.DetailsPanelTitle)
		end,
	},
	WZEmptyState = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(10)
			f48_arg0.bgEkia:completeAnimation()
			f48_arg0.bgEkia:setTopBottom(0, 0, 433.5, 521.5)
			f48_arg0.clipFinished(f48_arg0.bgEkia)
			f48_arg0.DetailsPanelMainImage:completeAnimation()
			f48_arg0.DetailsPanelMainImage:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.DetailsPanelMainImage)
			f48_arg0.SecondaryWZRewardImage:completeAnimation()
			f48_arg0.SecondaryWZRewardImage:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.SecondaryWZRewardImage)
			f48_arg0.PrimaryWZRewardImage:completeAnimation()
			f48_arg0.PrimaryWZRewardImage:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.PrimaryWZRewardImage)
			f48_arg0.WorldLeagueRankText:completeAnimation()
			f48_arg0.WorldLeagueRankText:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.WorldLeagueRankText)
			f48_arg0.GridLayout:completeAnimation()
			f48_arg0.GridLayout:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.GridLayout)
			f48_arg0.LevelRequirementText:completeAnimation()
			f48_arg0.LevelRequirementText:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.LevelRequirementText)
			f48_arg0.LoadoutImage1:completeAnimation()
			f48_arg0.LoadoutImage1:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.LoadoutImage1)
			f48_arg0.DetailsPanelSubTitle:completeAnimation()
			f48_arg0.DetailsPanelSubTitle:setTopBottom(0, 0, 469.5, 489.5)
			f48_arg0.DetailsPanelSubTitle:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.DetailsPanelSubTitle)
			f48_arg0.DetailsPanelTitle:completeAnimation()
			f48_arg0.DetailsPanelTitle:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.DetailsPanelTitle)
		end,
	},
	WZState = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(9)
			f49_arg0.bgEkia:completeAnimation()
			f49_arg0.bgEkia:setTopBottom(0, 0, 433.5, 521.5)
			f49_arg0.clipFinished(f49_arg0.bgEkia)
			local f49_local0 = function(f50_arg0)
				f49_arg0.DetailsPanelMainImage:beginAnimation(200)
				f49_arg0.DetailsPanelMainImage:setAlpha(1)
				f49_arg0.DetailsPanelMainImage:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.DetailsPanelMainImage:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.DetailsPanelMainImage:completeAnimation()
			f49_arg0.DetailsPanelMainImage:setLeftRight(0.5, 0.5, -174, 174)
			f49_arg0.DetailsPanelMainImage:setTopBottom(0, 0, 112.5, 396.5)
			f49_arg0.DetailsPanelMainImage:setAlpha(0)
			f49_local0(f49_arg0.DetailsPanelMainImage)
			f49_arg0.WorldLeagueRankText:completeAnimation()
			f49_arg0.WorldLeagueRankText:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.WorldLeagueRankText)
			local f49_local1 = function(f51_arg0)
				f49_arg0.EchelonText:beginAnimation(150)
				f49_arg0.EchelonText:setAlpha(1)
				f49_arg0.EchelonText:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.EchelonText:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.EchelonText:completeAnimation()
			f49_arg0.EchelonText:setTopBottom(0, 0, 396.5, 433.5)
			f49_arg0.EchelonText:setAlpha(0)
			f49_local1(f49_arg0.EchelonText)
			f49_arg0.GridLayout:completeAnimation()
			f49_arg0.GridLayout:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.GridLayout)
			f49_arg0.LevelRequirementText:completeAnimation()
			f49_arg0.LevelRequirementText:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.LevelRequirementText)
			f49_arg0.LoadoutImage1:completeAnimation()
			f49_arg0.LoadoutImage1:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.LoadoutImage1)
			local f49_local2 = function(f52_arg0)
				f49_arg0.DetailsPanelSubTitle:beginAnimation(150)
				f49_arg0.DetailsPanelSubTitle:setAlpha(0.5)
				f49_arg0.DetailsPanelSubTitle:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.DetailsPanelSubTitle:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.DetailsPanelSubTitle:completeAnimation()
			f49_arg0.DetailsPanelSubTitle:setTopBottom(0, 0, 469.5, 489.5)
			f49_arg0.DetailsPanelSubTitle:setAlpha(0)
			f49_local2(f49_arg0.DetailsPanelSubTitle)
			local f49_local3 = function(f53_arg0)
				f49_arg0.DetailsPanelTitle:beginAnimation(150)
				f49_arg0.DetailsPanelTitle:setAlpha(1)
				f49_arg0.DetailsPanelTitle:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.DetailsPanelTitle:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.DetailsPanelTitle:completeAnimation()
			f49_arg0.DetailsPanelTitle:setAlpha(0)
			f49_local3(f49_arg0.DetailsPanelTitle)
		end,
	},
	ZMLoadoutView = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(9)
			f54_arg0.bgEkia:completeAnimation()
			f54_arg0.bgEkia:setTopBottom(0, 0, 97.5, 521.5)
			f54_arg0.clipFinished(f54_arg0.bgEkia)
			f54_arg0.DetailsPanelMainImage:completeAnimation()
			f54_arg0.DetailsPanelMainImage:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.DetailsPanelMainImage)
			f54_arg0.WorldLeagueRankText:completeAnimation()
			f54_arg0.WorldLeagueRankText:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.WorldLeagueRankText)
			local f54_local0 = function(f55_arg0)
				local f55_local0 = function(f56_arg0)
					f56_arg0:beginAnimation(150)
					f56_arg0:setAlpha(1)
					f56_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
				end
				f54_arg0.GridLayout:beginAnimation(50)
				f54_arg0.GridLayout:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.GridLayout:registerEventHandler("transition_complete_keyframe", f55_local0)
			end
			f54_arg0.GridLayout:completeAnimation()
			f54_arg0.GridLayout:setTopBottom(0, 0, 241, 295)
			f54_arg0.GridLayout:setAlpha(0)
			f54_local0(f54_arg0.GridLayout)
			local f54_local1 = function(f57_arg0)
				f57_arg0:beginAnimation(150)
				f57_arg0:setAlpha(1)
				f57_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.LevelRequirementText:beginAnimation(50)
			f54_arg0.LevelRequirementText:setAlpha(0)
			f54_arg0.LevelRequirementText:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
			f54_arg0.LevelRequirementText:registerEventHandler("transition_complete_keyframe", f54_local1)
			f54_arg0.LoadoutImage1:completeAnimation()
			f54_arg0.LoadoutImage1:setAlpha(0)
			f54_arg0.clipFinished(f54_arg0.LoadoutImage1)
			local f54_local2 = function(f58_arg0)
				f54_arg0.DetailsPanelSubTitle:beginAnimation(190)
				f54_arg0.DetailsPanelSubTitle:setAlpha(0.5)
				f54_arg0.DetailsPanelSubTitle:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.DetailsPanelSubTitle:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.DetailsPanelSubTitle:completeAnimation()
			f54_arg0.DetailsPanelSubTitle:setAlpha(0)
			f54_local2(f54_arg0.DetailsPanelSubTitle)
			local f54_local3 = function(f59_arg0)
				f54_arg0.DetailsPanelTitle:beginAnimation(190)
				f54_arg0.DetailsPanelTitle:setAlpha(1)
				f54_arg0.DetailsPanelTitle:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.DetailsPanelTitle:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.DetailsPanelTitle:completeAnimation()
			f54_arg0.DetailsPanelTitle:setAlpha(0)
			f54_local3(f54_arg0.DetailsPanelTitle)
			local f54_local4 = function(f60_arg0)
				f54_arg0.ZMLoadoutImage:beginAnimation(200)
				f54_arg0.ZMLoadoutImage:setAlpha(1)
				f54_arg0.ZMLoadoutImage:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.ZMLoadoutImage:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.ZMLoadoutImage:completeAnimation()
			f54_arg0.ZMLoadoutImage:setLeftRight(0, 0, 136.5, 264.5)
			f54_arg0.ZMLoadoutImage:setAlpha(0)
			f54_local4(f54_arg0.ZMLoadoutImage)
		end,
	},
	WLRewardsState = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(11)
			f61_arg0.bgEkia:completeAnimation()
			f61_arg0.bgEkia:setTopBottom(0, 0, 433.5, 521.5)
			f61_arg0.clipFinished(f61_arg0.bgEkia)
			f61_arg0.DetailsPanelMainImage:completeAnimation()
			f61_arg0.DetailsPanelMainImage:setLeftRight(0.5, 0.5, -174, 174)
			f61_arg0.DetailsPanelMainImage:setTopBottom(0, 0, 112.5, 396.5)
			f61_arg0.DetailsPanelMainImage:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.DetailsPanelMainImage)
			local f61_local0 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					f63_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f63_arg0:setAlpha(1)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
				end
				f61_arg0.SecondaryWZRewardImage:beginAnimation(50)
				f61_arg0.SecondaryWZRewardImage:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.SecondaryWZRewardImage:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f61_arg0.SecondaryWZRewardImage:completeAnimation()
			f61_arg0.SecondaryWZRewardImage:setAlpha(0)
			f61_local0(f61_arg0.SecondaryWZRewardImage)
			local f61_local1 = function(f64_arg0)
				f61_arg0.PrimaryWZRewardImage:beginAnimation(150)
				f61_arg0.PrimaryWZRewardImage:setAlpha(1)
				f61_arg0.PrimaryWZRewardImage:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.PrimaryWZRewardImage:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.PrimaryWZRewardImage:completeAnimation()
			f61_arg0.PrimaryWZRewardImage:setAlpha(0)
			f61_local1(f61_arg0.PrimaryWZRewardImage)
			local f61_local2 = function(f65_arg0)
				f61_arg0.WorldLeagueRankText:beginAnimation(150)
				f61_arg0.WorldLeagueRankText:setAlpha(1)
				f61_arg0.WorldLeagueRankText:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.WorldLeagueRankText:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.WorldLeagueRankText:completeAnimation()
			f61_arg0.WorldLeagueRankText:setTopBottom(0, 0, 442, 472)
			f61_arg0.WorldLeagueRankText:setAlpha(0)
			f61_arg0.WorldLeagueRankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
			f61_local2(f61_arg0.WorldLeagueRankText)
			f61_arg0.GridLayout:completeAnimation()
			f61_arg0.GridLayout:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.GridLayout)
			f61_arg0.LevelRequirementText:completeAnimation()
			f61_arg0.LevelRequirementText:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.LevelRequirementText)
			f61_arg0.LoadoutImage1:completeAnimation()
			f61_arg0.LoadoutImage1:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.LoadoutImage1)
			local f61_local3 = function(f66_arg0)
				f61_arg0.DetailsPanelSubTitle:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
				f61_arg0.DetailsPanelSubTitle:setAlpha(0.5)
				f61_arg0.DetailsPanelSubTitle:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.DetailsPanelSubTitle:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.DetailsPanelSubTitle:completeAnimation()
			f61_arg0.DetailsPanelSubTitle:setTopBottom(0, 0, 475, 495)
			f61_arg0.DetailsPanelSubTitle:setAlpha(0)
			f61_local3(f61_arg0.DetailsPanelSubTitle)
			local f61_local4 = function(f67_arg0)
				f61_arg0.DetailsPanelTitle:beginAnimation(150)
				f61_arg0.DetailsPanelTitle:setAlpha(1)
				f61_arg0.DetailsPanelTitle:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.DetailsPanelTitle:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.DetailsPanelTitle:completeAnimation()
			f61_arg0.DetailsPanelTitle:setAlpha(0)
			f61_local4(f61_arg0.DetailsPanelTitle)
			local f61_local5 = function(f68_arg0)
				f61_arg0.Ruby4:beginAnimation(150)
				f61_arg0.Ruby4:setAlpha(1)
				f61_arg0.Ruby4:registerEventHandler("interrupted_keyframe", f61_arg0.clipInterrupted)
				f61_arg0.Ruby4:registerEventHandler("transition_complete_keyframe", f61_arg0.clipFinished)
			end
			f61_arg0.Ruby4:completeAnimation()
			f61_arg0.Ruby4:setAlpha(0)
			f61_local5(f61_arg0.Ruby4)
		end,
	},
	WLState = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(9)
			f69_arg0.bgEkia:completeAnimation()
			f69_arg0.bgEkia:setTopBottom(0, 0, 433.5, 521.5)
			f69_arg0.clipFinished(f69_arg0.bgEkia)
			local f69_local0 = function(f70_arg0)
				f69_arg0.DetailsPanelMainImage:beginAnimation(200)
				f69_arg0.DetailsPanelMainImage:setAlpha(1)
				f69_arg0.DetailsPanelMainImage:registerEventHandler("interrupted_keyframe", f69_arg0.clipInterrupted)
				f69_arg0.DetailsPanelMainImage:registerEventHandler("transition_complete_keyframe", f69_arg0.clipFinished)
			end
			f69_arg0.DetailsPanelMainImage:completeAnimation()
			f69_arg0.DetailsPanelMainImage:setLeftRight(0.5, 0.5, -174, 174)
			f69_arg0.DetailsPanelMainImage:setTopBottom(0, 0, 112.5, 396.5)
			f69_arg0.DetailsPanelMainImage:setAlpha(0)
			f69_local0(f69_arg0.DetailsPanelMainImage)
			local f69_local1 = function(f71_arg0)
				f69_arg0.WorldLeagueRankText:beginAnimation(150)
				f69_arg0.WorldLeagueRankText:setAlpha(1)
				f69_arg0.WorldLeagueRankText:registerEventHandler("interrupted_keyframe", f69_arg0.clipInterrupted)
				f69_arg0.WorldLeagueRankText:registerEventHandler("transition_complete_keyframe", f69_arg0.clipFinished)
			end
			f69_arg0.WorldLeagueRankText:completeAnimation()
			f69_arg0.WorldLeagueRankText:setTopBottom(0, 0, 442, 472)
			f69_arg0.WorldLeagueRankText:setAlpha(0)
			f69_local1(f69_arg0.WorldLeagueRankText)
			f69_arg0.GridLayout:completeAnimation()
			f69_arg0.GridLayout:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.GridLayout)
			f69_arg0.LevelRequirementText:completeAnimation()
			f69_arg0.LevelRequirementText:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.LevelRequirementText)
			f69_arg0.LoadoutImage1:completeAnimation()
			f69_arg0.LoadoutImage1:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.LoadoutImage1)
			local f69_local2 = function(f72_arg0)
				f69_arg0.DetailsPanelSubTitle:beginAnimation(150)
				f69_arg0.DetailsPanelSubTitle:setAlpha(0.5)
				f69_arg0.DetailsPanelSubTitle:registerEventHandler("interrupted_keyframe", f69_arg0.clipInterrupted)
				f69_arg0.DetailsPanelSubTitle:registerEventHandler("transition_complete_keyframe", f69_arg0.clipFinished)
			end
			f69_arg0.DetailsPanelSubTitle:completeAnimation()
			f69_arg0.DetailsPanelSubTitle:setTopBottom(0, 0, 475, 495)
			f69_arg0.DetailsPanelSubTitle:setAlpha(0)
			f69_local2(f69_arg0.DetailsPanelSubTitle)
			local f69_local3 = function(f73_arg0)
				f69_arg0.DetailsPanelTitle:beginAnimation(150)
				f69_arg0.DetailsPanelTitle:setAlpha(1)
				f69_arg0.DetailsPanelTitle:registerEventHandler("interrupted_keyframe", f69_arg0.clipInterrupted)
				f69_arg0.DetailsPanelTitle:registerEventHandler("transition_complete_keyframe", f69_arg0.clipFinished)
			end
			f69_arg0.DetailsPanelTitle:completeAnimation()
			f69_arg0.DetailsPanelTitle:setAlpha(0)
			f69_local3(f69_arg0.DetailsPanelTitle)
			local f69_local4 = function(f74_arg0)
				f69_arg0.Ruby4:beginAnimation(150)
				f69_arg0.Ruby4:setAlpha(1)
				f69_arg0.Ruby4:registerEventHandler("interrupted_keyframe", f69_arg0.clipInterrupted)
				f69_arg0.Ruby4:registerEventHandler("transition_complete_keyframe", f69_arg0.clipFinished)
			end
			f69_arg0.Ruby4:completeAnimation()
			f69_arg0.Ruby4:setAlpha(0)
			f69_local4(f69_arg0.Ruby4)
		end,
	},
}
CoD.Prestige_DetailsPanel.__onClose = function(f75_arg0)
	f75_arg0.CommonDetailPanel2:close()
	f75_arg0.DetailsPanelMainImage:close()
	f75_arg0.SecondaryWZRewardImage:close()
	f75_arg0.PrimaryWZRewardImage:close()
	f75_arg0.WorldLeagueRankText:close()
	f75_arg0.EchelonText:close()
	f75_arg0.GridLayout:close()
	f75_arg0.LevelRequirementText:close()
	f75_arg0.LoadoutImage1:close()
	f75_arg0.DetailsPanelSubTitle:close()
	f75_arg0.DetailsPanelTitle:close()
	f75_arg0.ZMLoadoutImage:close()
	f75_arg0.Ruby4:close()
end

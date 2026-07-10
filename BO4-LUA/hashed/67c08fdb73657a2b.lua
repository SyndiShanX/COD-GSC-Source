require("x64:5c1b2674e9ec1c6")
require("x64:159133a45744012")
require("x64:a00a13515982adb")
require("x64:49b26c3b2f26629")
require("x64:2c4e36180a1b124")
require("x64:e8b5cf05cc8b369")
CoD.Prestige_LevelContentWidget = InheritFrom(LUI.UIElement)
CoD.Prestige_LevelContentWidget.__defaultWidth = 1920
CoD.Prestige_LevelContentWidget.__defaultHeight = 530
CoD.Prestige_LevelContentWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_LevelContentWidget)
	self.id = "Prestige_LevelContentWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BodyBacker = LUI.UIImage.new(0, 0, 128, 1230, 0, 0, -40, 522)
	BodyBacker:setRGB(0.1, 0.1, 0.1)
	BodyBacker:setAlpha(0.5)
	self:addElement(BodyBacker)
	self.BodyBacker = BodyBacker
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 128, 1230, 0, 0, -40, 522)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 0, 128, 1230, 0, 0, 506, 522)
	NoiseTiledBackingAdd:setAlpha(0.5)
	NoiseTiledBackingAdd:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local RewardsTitle = LUI.UIText.new(0, 0, 30, 1328, 0, 0, -34, -9)
	RewardsTitle:setRGB(0.92, 0.92, 0.92)
	RewardsTitle:setAlpha(0.5)
	RewardsTitle:setText(LocalizeToUpperString(@"menu/level_content"))
	RewardsTitle:setTTF("ttmussels_regular")
	RewardsTitle:setLetterSpacing(2)
	RewardsTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RewardsTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(RewardsTitle)
	self.RewardsTitle = RewardsTitle
	local DotGrid = LUI.UIImage.new(0, 0, 128, 1230, 0, 0, 0, 506)
	DotGrid:setAlpha(0.01)
	DotGrid:setImage(RegisterImage(@"uie_ui_menu_aar_info_grid_sub"))
	DotGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DotGrid:setShaderVector(0, 0, 0, 0, 0)
	DotGrid:setupNineSliceShader(292, 236)
	self:addElement(DotGrid)
	self.DotGrid = DotGrid
	local Scrollbar = CoD.Prestige_LevelProgressBar.new(f1_arg0, f1_arg1, 0, 0, 128, 1230, 0, 0, 506, 522)
	self:addElement(Scrollbar)
	self.Scrollbar = Scrollbar
	local ScrollbarWZ = CoD.Prestige_LevelProgressBar.new(f1_arg0, f1_arg1, 0, 0, 128, 1230, 0, 0, 506, 522)
	ScrollbarWZ:setAlpha(0)
	self:addElement(ScrollbarWZ)
	self.ScrollbarWZ = ScrollbarWZ
	local ScrollbarWL = CoD.Prestige_LevelProgressBar.new(f1_arg0, f1_arg1, 0, 0, 128, 1230, 0, 0, 506, 522)
	ScrollbarWL:setAlpha(0)
	self:addElement(ScrollbarWL)
	self.ScrollbarWL = ScrollbarWL
	local PCScrollbar = nil
	PCScrollbar = CoD.PC_Prestige_Scrollbar.new(f1_arg0, f1_arg1, 0, 0, 72, 1287, 0, 0, -5, 523)
	self:addElement(PCScrollbar)
	self.PCScrollbar = PCScrollbar
	local PCScrollbarWL = nil
	PCScrollbarWL = CoD.PC_Prestige_Scrollbar.new(f1_arg0, f1_arg1, 0, 0, 72, 1287, 0, 0, -5, 523)
	PCScrollbarWL:setAlpha(0)
	self:addElement(PCScrollbarWL)
	self.PCScrollbarWL = PCScrollbarWL
	local PCScrollbarWZ = nil
	PCScrollbarWZ = CoD.PC_Prestige_ScrollbarWZ.new(f1_arg0, f1_arg1, 0, 0, 72, 1287, 0, 0, -5, 523)
	PCScrollbarWZ:setAlpha(0)
	self:addElement(PCScrollbarWZ)
	self.PCScrollbarWZ = PCScrollbarWZ
	local WLRewardList = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, true)
	WLRewardList:setLeftRight(0, 0, 146, 1212)
	WLRewardList:setTopBottom(0, 0, 0, 440)
	WLRewardList:setAlpha(0)
	WLRewardList:setWidgetType(CoD.Prestige_WLRewardsWidget)
	WLRewardList:setHorizontalCount(8)
	WLRewardList:setSpacing(6)
	WLRewardList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WLRewardList:setDataSource("WorldLeagueRankInfo")
	self:addElement(WLRewardList)
	self.WLRewardList = WLRewardList
	local WZRewardsList = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, true)
	WZRewardsList:setLeftRight(0, 0, 146, 1212)
	WZRewardsList:setTopBottom(0, 0, 0, 440)
	WZRewardsList:setAlpha(0)
	WZRewardsList:setWidgetType(CoD.Prestige_WZRewardsWidget)
	WZRewardsList:setHorizontalCount(8)
	WZRewardsList:setSpacing(6)
	WZRewardsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WZRewardsList:setDataSource("PrestigeRankInfo")
	self:addElement(WZRewardsList)
	self.WZRewardsList = WZRewardsList
	local RewardsList = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, true)
	RewardsList:setLeftRight(0, 0, 146, 1212)
	RewardsList:setTopBottom(0, 0, 0, 440)
	RewardsList:setWidgetType(CoD.Prestige_LevelRewardsWidget)
	RewardsList:setHorizontalCount(8)
	RewardsList:setSpacing(6)
	RewardsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RewardsList:setDataSource("PrestigeRankInfo")
	RewardsList:subscribeToGlobalModel(f1_arg1, "GlobalModel", "RefreshDWInventoryMenu", function(model)
		UpdateDataSource(self, RewardsList, f1_arg1)
	end)
	RewardsList:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		UpdateDataSource(self, RewardsList, f1_arg1)
	end)
	self:addElement(RewardsList)
	self.RewardsList = RewardsList
	local LeftTriggerText = LUI.UIText.new(0, 0, 79.5, 124.5, 0, 0, 0, 37)
	LeftTriggerText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/l_trigger"))
	LeftTriggerText:setTTF("default")
	LeftTriggerText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	LeftTriggerText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(LeftTriggerText)
	self.LeftTriggerText = LeftTriggerText
	local RightTriggerText = LUI.UIText.new(0, 0, 1230, 1275, 0, 0, -0.5, 36.5)
	RightTriggerText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/r_trigger"))
	RightTriggerText:setTTF("default")
	RightTriggerText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RightTriggerText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RightTriggerText)
	self.RightTriggerText = RightTriggerText
	local ArrowL = LUI.UIImage.new(0, 0, 124.5, 156.5, 0, 0, -3, 39)
	ArrowL:setImage(RegisterImage(@"uie_ui_menu_item_shop_tier_pointer"))
	ArrowL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	ArrowL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ArrowL)
	self.ArrowL = ArrowL
	local dotlineR = LUI.UIImage.new(0, 0, 146, 1212, 0, 0, -6, -2)
	dotlineR:setAlpha(0.2)
	dotlineR:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotlineR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotlineR:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotlineR)
	self.dotlineR = dotlineR
	local ArrowR = LUI.UIImage.new(0, 0, 1233.5, 1201.5, 0, 0, -3, 39)
	ArrowR:setImage(RegisterImage(@"uie_ui_menu_item_shop_tier_pointer"))
	ArrowR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	ArrowR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ArrowR)
	self.ArrowR = ArrowR
	local infoBracketTop = LUI.UIImage.new(0, 0, 126.5, 1230.5, 0, 0, -41, -33)
	infoBracketTop:setAlpha(0.05)
	infoBracketTop:setZRot(180)
	infoBracketTop:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketTop:setShaderVector(0, 0, 0, 0, 0)
	infoBracketTop:setupNineSliceShader(16, 4)
	self:addElement(infoBracketTop)
	self.infoBracketTop = infoBracketTop
	self:mergeStateConditions({
		{
			stateName = "WZKeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and IsWarzone()
			end,
		},
		{
			stateName = "WZState",
			condition = function(menu, element, event)
				return IsWarzone() and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "WLKeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and IsArenaMode()
			end,
		},
		{
			stateName = "WLState",
			condition = function(menu, element, event)
				local f7_local0
				if not IsMouseOrKeyboard(f1_arg1) then
					f7_local0 = IsArenaMode()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	local f1_local21 = self
	local f1_local22 = self.subscribeToModel
	local f1_local23 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local22(f1_local21, f1_local23.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local21 = self
	f1_local22 = self.subscribeToModel
	f1_local23 = Engine[@"getglobalmodel"]()
	f1_local22(f1_local21, f1_local23["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "currentTargetPageIndex", function(model)
		local f12_local0 = self
		if IsWarzone() then
			CoD.GridAndListUtility.UpdateDataSource(self.WZRewardsList, true, true, true)
			CoD.PrestigeUtility.UpdateTargetPageIndexScroll(self, self.ScrollbarWZ, f1_arg1, model)
		elseif IsArenaMode() then
			CoD.GridAndListUtility.UpdateDataSource(self.WLRewardList, true, true, true)
			CoD.PrestigeUtility.UpdateTargetPageIndexScroll(self, self.ScrollbarWL, f1_arg1, model)
		else
			CoD.GridAndListUtility.UpdateDataSource(self.RewardsList, true, true, true)
			CoD.PrestigeUtility.UpdateTargetPageIndexScroll(self, self.Scrollbar, f1_arg1, model)
		end
	end)
	if CoD.isPC then
		PCScrollbar.id = "PCScrollbar"
	end
	if CoD.isPC then
		PCScrollbarWL.id = "PCScrollbarWL"
	end
	if CoD.isPC then
		PCScrollbarWZ.id = "PCScrollbarWZ"
	end
	WLRewardList.id = "WLRewardList"
	WZRewardsList.id = "WZRewardsList"
	RewardsList.id = "RewardsList"
	self.__defaultFocus = RewardsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local22 = self
	if IsPC() and not IsWarzone() and not IsArenaMode() then
		CoD.PrestigeUtility.InitScrollbarForDrag(self, self.PCScrollbar, f1_arg1, f1_arg0)
	elseif IsPC() and IsWarzone() then
		CoD.PrestigeUtility.InitScrollbarForDrag(self, self.PCScrollbarWZ, f1_arg1, f1_arg0)
		CoD.BaseUtility.SetDefaultFocusToElement(self, self.WZRewardsList)
	elseif not IsPC() and IsWarzone() then
		CoD.GridAndListUtility.MakeStencilAutoScaleWidth(self.WZRewardsList)
		CoD.BaseUtility.SetDefaultFocusToElement(self, self.WZRewardsList)
	elseif not IsPC() and IsArenaMode() then
		CoD.GridAndListUtility.MakeStencilAutoScaleWidth(self.WLRewardList)
		CoD.BaseUtility.SetDefaultFocusToElement(self, self.WLRewardList)
	elseif IsPC() and IsArenaMode() then
		CoD.PrestigeUtility.InitScrollbarForDrag(self, self.PCScrollbarWL, f1_arg1, f1_arg0)
		CoD.BaseUtility.SetDefaultFocusToElement(self, self.WLRewardList)
	end
	return self
end
CoD.Prestige_LevelContentWidget.__resetProperties = function(f13_arg0)
	f13_arg0.DotGrid:completeAnimation()
	f13_arg0.PCScrollbar:completeAnimation()
	f13_arg0.RightTriggerText:completeAnimation()
	f13_arg0.LeftTriggerText:completeAnimation()
	f13_arg0.ArrowL:completeAnimation()
	f13_arg0.ArrowR:completeAnimation()
	f13_arg0.RewardsList:completeAnimation()
	f13_arg0.WZRewardsList:completeAnimation()
	f13_arg0.Scrollbar:completeAnimation()
	f13_arg0.ScrollbarWZ:completeAnimation()
	f13_arg0.PCScrollbarWZ:completeAnimation()
	f13_arg0.WLRewardList:completeAnimation()
	f13_arg0.PCScrollbarWL:completeAnimation()
	f13_arg0.ScrollbarWL:completeAnimation()
	f13_arg0.DotGrid:setTopBottom(0, 0, 0, 506)
	f13_arg0.DotGrid:setAlpha(0.01)
	f13_arg0.PCScrollbar:setLeftRight(0, 0, 72, 1287)
	f13_arg0.PCScrollbar:setTopBottom(0, 0, -5, 523)
	f13_arg0.PCScrollbar:setAlpha(1)
	f13_arg0.RightTriggerText:setLeftRight(0, 0, 1230, 1275)
	f13_arg0.RightTriggerText:setAlpha(1)
	f13_arg0.LeftTriggerText:setLeftRight(0, 0, 79.5, 124.5)
	f13_arg0.LeftTriggerText:setAlpha(1)
	f13_arg0.ArrowL:setAlpha(1)
	f13_arg0.ArrowL:setShaderVector(0, 1, 0, 0, 0)
	f13_arg0.ArrowR:setAlpha(1)
	f13_arg0.ArrowR:setShaderVector(0, 1, 0, 0, 0)
	f13_arg0.RewardsList:setAlpha(1)
	f13_arg0.WZRewardsList:setAlpha(0)
	f13_arg0.Scrollbar:setAlpha(1)
	f13_arg0.ScrollbarWZ:setAlpha(0)
	f13_arg0.PCScrollbarWZ:setAlpha(0)
	f13_arg0.WLRewardList:setAlpha(0)
	f13_arg0.PCScrollbarWL:setAlpha(0)
	f13_arg0.ScrollbarWL:setAlpha(0)
end
CoD.Prestige_LevelContentWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(6)
			f14_arg0.DotGrid:completeAnimation()
			f14_arg0.DotGrid:setTopBottom(0, 0, 0, 506)
			f14_arg0.DotGrid:setAlpha(0.02)
			f14_arg0.clipFinished(f14_arg0.DotGrid)
			f14_arg0.PCScrollbar:completeAnimation()
			f14_arg0.PCScrollbar:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PCScrollbar)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(500)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f16_arg0:setAlpha(1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f14_arg0.LeftTriggerText:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.LeftTriggerText:setAlpha(0.5)
				f14_arg0.LeftTriggerText:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.LeftTriggerText:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.LeftTriggerText:completeAnimation()
			f14_arg0.LeftTriggerText:setAlpha(1)
			f14_local0(f14_arg0.LeftTriggerText)
			local f14_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(500)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f14_arg0.RightTriggerText:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.RightTriggerText:setAlpha(0.5)
				f14_arg0.RightTriggerText:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.RightTriggerText:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f14_arg0.RightTriggerText:completeAnimation()
			f14_arg0.RightTriggerText:setAlpha(1)
			f14_local1(f14_arg0.RightTriggerText)
			local f14_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(500)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f22_arg0:setShaderVector(0, 1, 0, 0, 0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f14_arg0.ArrowL:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.ArrowL:setShaderVector(0, 2, 0, 0, 0)
				f14_arg0.ArrowL:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ArrowL:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f14_arg0.ArrowL:completeAnimation()
			f14_arg0.ArrowL:setShaderVector(0, 1, 0, 0, 0)
			f14_local2(f14_arg0.ArrowL)
			local f14_local3 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						f26_arg0:beginAnimation(500)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f25_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f25_arg0:setShaderVector(0, 1, 0, 0, 0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f14_arg0.ArrowR:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.ArrowR:setShaderVector(0, 2, 0, 0, 0)
				f14_arg0.ArrowR:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ArrowR:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f14_arg0.ArrowR:completeAnimation()
			f14_arg0.ArrowR:setShaderVector(0, 1, 0, 0, 0)
			f14_local3(f14_arg0.ArrowR)
			f14_arg0.nextClip = "DefaultClip"
		end,
	},
	WZKeyboardAndMouse = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(11)
			f27_arg0.DotGrid:completeAnimation()
			f27_arg0.DotGrid:setTopBottom(0, 0, 0, 506)
			f27_arg0.DotGrid:setAlpha(0.03)
			f27_arg0.clipFinished(f27_arg0.DotGrid)
			f27_arg0.Scrollbar:completeAnimation()
			f27_arg0.Scrollbar:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Scrollbar)
			f27_arg0.ScrollbarWZ:completeAnimation()
			f27_arg0.ScrollbarWZ:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ScrollbarWZ)
			f27_arg0.PCScrollbar:completeAnimation()
			f27_arg0.PCScrollbar:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.PCScrollbar)
			f27_arg0.PCScrollbarWZ:completeAnimation()
			f27_arg0.PCScrollbarWZ:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.PCScrollbarWZ)
			f27_arg0.WZRewardsList:completeAnimation()
			f27_arg0.WZRewardsList:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.WZRewardsList)
			f27_arg0.RewardsList:completeAnimation()
			f27_arg0.RewardsList:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RewardsList)
			f27_arg0.LeftTriggerText:completeAnimation()
			f27_arg0.LeftTriggerText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.LeftTriggerText)
			f27_arg0.RightTriggerText:completeAnimation()
			f27_arg0.RightTriggerText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RightTriggerText)
			f27_arg0.ArrowL:completeAnimation()
			f27_arg0.ArrowL:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ArrowL)
			f27_arg0.ArrowR:completeAnimation()
			f27_arg0.ArrowR:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ArrowR)
		end,
	},
	WZState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(11)
			f28_arg0.DotGrid:completeAnimation()
			f28_arg0.DotGrid:setTopBottom(0, 0, 0, 506)
			f28_arg0.DotGrid:setAlpha(0.03)
			f28_arg0.clipFinished(f28_arg0.DotGrid)
			f28_arg0.Scrollbar:completeAnimation()
			f28_arg0.Scrollbar:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Scrollbar)
			f28_arg0.ScrollbarWZ:completeAnimation()
			f28_arg0.ScrollbarWZ:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.ScrollbarWZ)
			f28_arg0.PCScrollbar:completeAnimation()
			f28_arg0.PCScrollbar:setLeftRight(0, 0, 0, 1298)
			f28_arg0.PCScrollbar:setTopBottom(0, 0, 477, 499)
			f28_arg0.PCScrollbar:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.PCScrollbar)
			f28_arg0.PCScrollbarWZ:completeAnimation()
			f28_arg0.PCScrollbarWZ:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.PCScrollbarWZ)
			f28_arg0.WZRewardsList:completeAnimation()
			f28_arg0.WZRewardsList:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.WZRewardsList)
			f28_arg0.RewardsList:completeAnimation()
			f28_arg0.RewardsList:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.RewardsList)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						f31_arg0:beginAnimation(500)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f30_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f28_arg0.LeftTriggerText:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f28_arg0.LeftTriggerText:setAlpha(0.5)
				f28_arg0.LeftTriggerText:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.LeftTriggerText:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.LeftTriggerText:completeAnimation()
			f28_arg0.LeftTriggerText:setLeftRight(0, 0, 79.5, 124.5)
			f28_arg0.LeftTriggerText:setAlpha(1)
			f28_local0(f28_arg0.LeftTriggerText)
			local f28_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						f34_arg0:beginAnimation(500)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f33_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f28_arg0.RightTriggerText:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f28_arg0.RightTriggerText:setAlpha(0.5)
				f28_arg0.RightTriggerText:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.RightTriggerText:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f28_arg0.RightTriggerText:completeAnimation()
			f28_arg0.RightTriggerText:setLeftRight(0, 0, 1230, 1275)
			f28_arg0.RightTriggerText:setAlpha(1)
			f28_local1(f28_arg0.RightTriggerText)
			local f28_local2 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						f37_arg0:beginAnimation(500)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f36_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f36_arg0:setShaderVector(0, 1, 0, 0, 0)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f28_arg0.ArrowL:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f28_arg0.ArrowL:setShaderVector(0, 2, 0, 0, 0)
				f28_arg0.ArrowL:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ArrowL:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f28_arg0.ArrowL:completeAnimation()
			f28_arg0.ArrowL:setShaderVector(0, 1, 0, 0, 0)
			f28_local2(f28_arg0.ArrowL)
			local f28_local3 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						f40_arg0:beginAnimation(500)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f39_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f39_arg0:setShaderVector(0, 1, 0, 0, 0)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f28_arg0.ArrowR:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f28_arg0.ArrowR:setShaderVector(0, 2, 0, 0, 0)
				f28_arg0.ArrowR:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ArrowR:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f28_arg0.ArrowR:completeAnimation()
			f28_arg0.ArrowR:setShaderVector(0, 1, 0, 0, 0)
			f28_local3(f28_arg0.ArrowR)
			f28_arg0.nextClip = "DefaultClip"
		end,
	},
	WLKeyboardAndMouse = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(13)
			f41_arg0.DotGrid:completeAnimation()
			f41_arg0.DotGrid:setTopBottom(0, 0, 0, 506)
			f41_arg0.DotGrid:setAlpha(0.03)
			f41_arg0.clipFinished(f41_arg0.DotGrid)
			f41_arg0.Scrollbar:completeAnimation()
			f41_arg0.Scrollbar:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.Scrollbar)
			f41_arg0.ScrollbarWZ:completeAnimation()
			f41_arg0.ScrollbarWZ:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ScrollbarWZ)
			f41_arg0.PCScrollbar:completeAnimation()
			f41_arg0.PCScrollbar:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PCScrollbar)
			f41_arg0.PCScrollbarWL:completeAnimation()
			f41_arg0.PCScrollbarWL:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.PCScrollbarWL)
			f41_arg0.PCScrollbarWZ:completeAnimation()
			f41_arg0.PCScrollbarWZ:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.PCScrollbarWZ)
			f41_arg0.WLRewardList:completeAnimation()
			f41_arg0.WLRewardList:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.WLRewardList)
			f41_arg0.WZRewardsList:completeAnimation()
			f41_arg0.WZRewardsList:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.WZRewardsList)
			f41_arg0.RewardsList:completeAnimation()
			f41_arg0.RewardsList:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.RewardsList)
			f41_arg0.LeftTriggerText:completeAnimation()
			f41_arg0.LeftTriggerText:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.LeftTriggerText)
			f41_arg0.RightTriggerText:completeAnimation()
			f41_arg0.RightTriggerText:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.RightTriggerText)
			f41_arg0.ArrowL:completeAnimation()
			f41_arg0.ArrowL:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ArrowL)
			f41_arg0.ArrowR:completeAnimation()
			f41_arg0.ArrowR:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ArrowR)
		end,
	},
	WLState = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(12)
			f42_arg0.DotGrid:completeAnimation()
			f42_arg0.DotGrid:setTopBottom(0, 0, 0, 506)
			f42_arg0.DotGrid:setAlpha(0.03)
			f42_arg0.clipFinished(f42_arg0.DotGrid)
			f42_arg0.Scrollbar:completeAnimation()
			f42_arg0.Scrollbar:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.Scrollbar)
			f42_arg0.ScrollbarWL:completeAnimation()
			f42_arg0.ScrollbarWL:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.ScrollbarWL)
			f42_arg0.PCScrollbar:completeAnimation()
			f42_arg0.PCScrollbar:setLeftRight(0, 0, 0, 1298)
			f42_arg0.PCScrollbar:setTopBottom(0, 0, 477, 499)
			f42_arg0.PCScrollbar:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.PCScrollbar)
			f42_arg0.PCScrollbarWZ:completeAnimation()
			f42_arg0.PCScrollbarWZ:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.PCScrollbarWZ)
			f42_arg0.WLRewardList:completeAnimation()
			f42_arg0.WLRewardList:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.WLRewardList)
			f42_arg0.WZRewardsList:completeAnimation()
			f42_arg0.WZRewardsList:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.WZRewardsList)
			f42_arg0.RewardsList:completeAnimation()
			f42_arg0.RewardsList:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.RewardsList)
			local f42_local0 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					local f44_local0 = function(f45_arg0)
						f45_arg0:beginAnimation(500)
						f45_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
					end
					f44_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
				end
				f42_arg0.LeftTriggerText:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f42_arg0.LeftTriggerText:setAlpha(0.5)
				f42_arg0.LeftTriggerText:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.LeftTriggerText:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f42_arg0.LeftTriggerText:completeAnimation()
			f42_arg0.LeftTriggerText:setLeftRight(0, 0, 79.5, 124.5)
			f42_arg0.LeftTriggerText:setAlpha(1)
			f42_local0(f42_arg0.LeftTriggerText)
			local f42_local1 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					local f47_local0 = function(f48_arg0)
						f48_arg0:beginAnimation(500)
						f48_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
					end
					f47_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f47_arg0:setAlpha(1)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
				end
				f42_arg0.RightTriggerText:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f42_arg0.RightTriggerText:setAlpha(0.5)
				f42_arg0.RightTriggerText:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.RightTriggerText:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f42_arg0.RightTriggerText:completeAnimation()
			f42_arg0.RightTriggerText:setLeftRight(0, 0, 1230, 1275)
			f42_arg0.RightTriggerText:setAlpha(1)
			f42_local1(f42_arg0.RightTriggerText)
			local f42_local2 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					local f50_local0 = function(f51_arg0)
						f51_arg0:beginAnimation(500)
						f51_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
					end
					f50_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f50_arg0:setShaderVector(0, 1, 0, 0, 0)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
				end
				f42_arg0.ArrowL:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f42_arg0.ArrowL:setShaderVector(0, 2, 0, 0, 0)
				f42_arg0.ArrowL:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.ArrowL:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f42_arg0.ArrowL:completeAnimation()
			f42_arg0.ArrowL:setShaderVector(0, 1, 0, 0, 0)
			f42_local2(f42_arg0.ArrowL)
			local f42_local3 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					local f53_local0 = function(f54_arg0)
						f54_arg0:beginAnimation(500)
						f54_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
					end
					f53_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
					f53_arg0:setShaderVector(0, 1, 0, 0, 0)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
				end
				f42_arg0.ArrowR:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f42_arg0.ArrowR:setShaderVector(0, 2, 0, 0, 0)
				f42_arg0.ArrowR:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.ArrowR:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f42_arg0.ArrowR:completeAnimation()
			f42_arg0.ArrowR:setShaderVector(0, 1, 0, 0, 0)
			f42_local3(f42_arg0.ArrowR)
			f42_arg0.nextClip = "DefaultClip"
		end,
	},
	KeyboardAndMouse = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(8)
			f55_arg0.DotGrid:completeAnimation()
			f55_arg0.DotGrid:setTopBottom(0, 0, 0, 506)
			f55_arg0.DotGrid:setAlpha(0.02)
			f55_arg0.clipFinished(f55_arg0.DotGrid)
			f55_arg0.Scrollbar:completeAnimation()
			f55_arg0.Scrollbar:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.Scrollbar)
			f55_arg0.PCScrollbar:completeAnimation()
			f55_arg0.PCScrollbar:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.PCScrollbar)
			f55_arg0.PCScrollbarWZ:completeAnimation()
			f55_arg0.PCScrollbarWZ:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.PCScrollbarWZ)
			f55_arg0.LeftTriggerText:completeAnimation()
			f55_arg0.LeftTriggerText:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.LeftTriggerText)
			f55_arg0.RightTriggerText:completeAnimation()
			f55_arg0.RightTriggerText:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.RightTriggerText)
			f55_arg0.ArrowL:completeAnimation()
			f55_arg0.ArrowL:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ArrowL)
			f55_arg0.ArrowR:completeAnimation()
			f55_arg0.ArrowR:setAlpha(0)
			f55_arg0.clipFinished(f55_arg0.ArrowR)
		end,
	},
}
CoD.Prestige_LevelContentWidget.__onClose = function(f56_arg0)
	f56_arg0.Scrollbar:close()
	f56_arg0.ScrollbarWZ:close()
	f56_arg0.ScrollbarWL:close()
	f56_arg0.PCScrollbar:close()
	f56_arg0.PCScrollbarWL:close()
	f56_arg0.PCScrollbarWZ:close()
	f56_arg0.WLRewardList:close()
	f56_arg0.WZRewardsList:close()
	f56_arg0.RewardsList:close()
end

require("x64:6fd55bf8b90635b")
require("x64:12c969e93cb6be2")
require("x64:42f4e7dac175b95")
CoD.LeaguePlayLeaderboardEntry = InheritFrom(LUI.UIElement)
CoD.LeaguePlayLeaderboardEntry.__defaultWidth = 898
CoD.LeaguePlayLeaderboardEntry.__defaultHeight = 48
CoD.LeaguePlayLeaderboardEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayLeaderboardEntry)
	self.id = "LeaguePlayLeaderboardEntry"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RankDotBg = LUI.UIImage.new(0, 0, 0, 88, 0, 1, 1, -1)
	RankDotBg:setRGB(0.92, 0.92, 0.92)
	RankDotBg:setAlpha(0.8)
	RankDotBg:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	RankDotBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RankDotBg:setShaderVector(0, 0, 0, 0, 0)
	RankDotBg:setupNineSliceShader(48, 48)
	self:addElement(RankDotBg)
	self.RankDotBg = RankDotBg
	local RankMovementDotBg = LUI.UIImage.new(0, 0, 96, 144, 0, 1, 1, -1)
	RankMovementDotBg:setRGB(0.92, 0.92, 0.92)
	RankMovementDotBg:setAlpha(0.8)
	RankMovementDotBg:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	RankMovementDotBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RankMovementDotBg:setShaderVector(0, 0, 0, 0, 0)
	RankMovementDotBg:setupNineSliceShader(48, 48)
	self:addElement(RankMovementDotBg)
	self.RankMovementDotBg = RankMovementDotBg
	local NameDotBg = LUI.UIImage.new(0, 0, 152, 570, 0, 1, 1, -1)
	NameDotBg:setRGB(0.92, 0.92, 0.92)
	NameDotBg:setAlpha(0.8)
	NameDotBg:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	NameDotBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	NameDotBg:setShaderVector(0, 0, 0, 0, 0)
	NameDotBg:setupNineSliceShader(48, 48)
	self:addElement(NameDotBg)
	self.NameDotBg = NameDotBg
	local PointsDotBg = LUI.UIImage.new(0, 0, 578, 710, 0, 1, 1, -1)
	PointsDotBg:setRGB(0.92, 0.92, 0.92)
	PointsDotBg:setAlpha(0.8)
	PointsDotBg:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	PointsDotBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PointsDotBg:setShaderVector(0, 0, 0, 0, 0)
	PointsDotBg:setupNineSliceShader(48, 48)
	self:addElement(PointsDotBg)
	self.PointsDotBg = PointsDotBg
	local RubiesDotBg = LUI.UIImage.new(0, 0, 718, 898, 0, 1, 1, -1)
	RubiesDotBg:setRGB(0.92, 0.92, 0.92)
	RubiesDotBg:setAlpha(0.8)
	RubiesDotBg:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	RubiesDotBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	RubiesDotBg:setShaderVector(0, 0, 0, 0, 0)
	RubiesDotBg:setupNineSliceShader(48, 48)
	self:addElement(RubiesDotBg)
	self.RubiesDotBg = RubiesDotBg
	local NoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseBacking:setAlpha(0.6)
	NoiseBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	local Selection = CoD.LeaguePlayLeaderboardEntrySelection.new(f1_arg0, f1_arg1, 0, 0, 0, 898, 0, 0, 0, 48)
	self:addElement(Selection)
	self.Selection = Selection
	local RubiesBg = LUI.UIImage.new(0, 0, 718, 898, 0, 0, 0, 48)
	RubiesBg:setRGB(0, 0, 0)
	RubiesBg:setAlpha(0.3)
	self:addElement(RubiesBg)
	self.RubiesBg = RubiesBg
	local RankPointBg = LUI.UIImage.new(0, 0, 578, 710, 0, 0, 0, 48)
	RankPointBg:setRGB(0, 0, 0)
	RankPointBg:setAlpha(0.3)
	self:addElement(RankPointBg)
	self.RankPointBg = RankPointBg
	local NameBg = LUI.UIImage.new(0, 0, 152, 570, 0, 0, 0, 48)
	NameBg:setRGB(0, 0, 0)
	NameBg:setAlpha(0.3)
	self:addElement(NameBg)
	self.NameBg = NameBg
	local RankMovementBg = LUI.UIImage.new(0, 0, 96, 144, 0, 0, 0, 48)
	RankMovementBg:setRGB(0, 0, 0)
	RankMovementBg:setAlpha(0.3)
	self:addElement(RankMovementBg)
	self.RankMovementBg = RankMovementBg
	local RankBg = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0, 48)
	RankBg:setRGB(0, 0, 0)
	RankBg:setAlpha(0.3)
	self:addElement(RankBg)
	self.RankBg = RankBg
	local Tied = LUI.UIText.new(0, 0, 459, 569, 0, 0, 10, 40)
	Tied:setRGB(0.92, 0.92, 0.92)
	Tied:setAlpha(0)
	Tied:setText(LocalizeToUpperString(@"menu/new"))
	Tied:setTTF("ttmussels_regular")
	Tied:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Tied:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Tied)
	self.Tied = Tied
	local RubiesList = CoD.LeaguePlayRubyList.new(f1_arg0, f1_arg1, 0, 0, 733, 883, 0, 0, 4, 44)
	RubiesList:setScale(0.8, 0.8)
	RubiesList:linkToElementModel(self, nil, false, function(model)
		RubiesList:setModel(model, f1_arg1)
	end)
	self:addElement(RubiesList)
	self.RubiesList = RubiesList
	local RankPoints = LUI.UIText.new(0, 0, 582, 706, 0, 0, 10, 40)
	RankPoints:setRGB(0.92, 0.92, 0.92)
	RankPoints:setTTF("0arame_mono_stencil")
	RankPoints:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RankPoints:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	RankPoints:linkToElementModel(self, "ladderPoints", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankPoints:setText(f3_local0)
		end
	end)
	self:addElement(RankPoints)
	self.RankPoints = RankPoints
	local Name = CoD.LeaguePlayLeaderboardEntryClanName.new(f1_arg0, f1_arg1, 0, 0, 165, 557, 0, 0, 10, 40)
	Name:setRGB(0.92, 0.92, 0.92)
	Name:linkToElementModel(self, nil, false, function(model)
		Name:setModel(model, f1_arg1)
	end)
	self:addElement(Name)
	self.Name = Name
	local RankMovement = LUI.UIImage.new(0, 0, 106, 134, 0, 0, 10, 38)
	RankMovement:linkToElementModel(self, "arrow", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RankMovement:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(RankMovement)
	self.RankMovement = RankMovement
	local Rank = LUI.UIText.new(0, 0, 19.5, 68.5, 0, 0, 10, 40)
	Rank:setRGB(0.92, 0.92, 0.92)
	Rank:setTTF("0arame_mono_stencil")
	Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Rank:linkToElementModel(self, "position", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Rank:setText(f6_local0)
		end
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local infoBracketBot = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 42, 50)
	infoBracketBot:setAlpha(0.1)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	self:mergeStateConditions({
		{
			stateName = "CurrentPlayerState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueMyXuid(self, f1_arg1, "xuid")
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "LeaguePlayLadderMemberList", "allXuidInfoLoaded", function(model)
		if CoD.ModelUtility.IsSelfModelValueMyXuid(self, f1_arg1, "xuid") then
			SetState(self, "CurrentPlayerState", f1_arg1)
		end
	end)
	Selection.id = "Selection"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	if CoD.ModelUtility.IsSelfModelValueMyXuid(self, f1_arg1, "xuid") then
		SetState(self, "CurrentPlayerState", f1_arg1)
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuLeaderboard(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayLeaderboardEntry.__resetProperties = function(f10_arg0)
	f10_arg0.Name:completeAnimation()
	f10_arg0.infoBracketBot:completeAnimation()
	f10_arg0.Selection:completeAnimation()
	f10_arg0.Rank:completeAnimation()
	f10_arg0.Tied:completeAnimation()
	f10_arg0.RankPoints:completeAnimation()
	f10_arg0.RankDotBg:completeAnimation()
	f10_arg0.Name:setRGB(0.92, 0.92, 0.92)
	f10_arg0.infoBracketBot:setRGB(1, 1, 1)
	f10_arg0.infoBracketBot:setAlpha(0.1)
	f10_arg0.Selection:setAlpha(1)
	f10_arg0.Rank:setRGB(0.92, 0.92, 0.92)
	f10_arg0.Tied:setRGB(0.92, 0.92, 0.92)
	f10_arg0.RankPoints:setRGB(0.92, 0.92, 0.92)
	f10_arg0.RankDotBg:setRGB(0.92, 0.92, 0.92)
	f10_arg0.RankDotBg:setAlpha(0.8)
end
CoD.LeaguePlayLeaderboardEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Name:completeAnimation()
			f11_arg0.Name:setRGB(1, 1, 1)
			f11_arg0.clipFinished(f11_arg0.Name)
		end,
		ShowInfoBracket = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.infoBracketBot:completeAnimation()
			f12_arg0.infoBracketBot:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.infoBracketBot)
		end,
	},
	CurrentPlayerState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(7)
			f13_arg0.RankDotBg:completeAnimation()
			f13_arg0.RankDotBg:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f13_arg0.clipFinished(f13_arg0.RankDotBg)
			f13_arg0.Selection:completeAnimation()
			f13_arg0.Selection:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Selection)
			f13_arg0.Tied:completeAnimation()
			f13_arg0.Tied:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f13_arg0.clipFinished(f13_arg0.Tied)
			f13_arg0.RankPoints:completeAnimation()
			f13_arg0.RankPoints:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f13_arg0.clipFinished(f13_arg0.RankPoints)
			f13_arg0.Name:completeAnimation()
			f13_arg0.Name:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f13_arg0.clipFinished(f13_arg0.Name)
			f13_arg0.Rank:completeAnimation()
			f13_arg0.Rank:setRGB(1, 0.82, 0)
			f13_arg0.clipFinished(f13_arg0.Rank)
			f13_arg0.infoBracketBot:completeAnimation()
			f13_arg0.infoBracketBot:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f13_arg0.infoBracketBot:setAlpha(0.1)
			f13_arg0.clipFinished(f13_arg0.infoBracketBot)
		end,
		Active = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.RankDotBg:completeAnimation()
			f14_arg0.RankDotBg:setAlpha(0.8)
			f14_arg0.clipFinished(f14_arg0.RankDotBg)
			f14_arg0.RankPoints:completeAnimation()
			f14_arg0.RankPoints:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f14_arg0.clipFinished(f14_arg0.RankPoints)
			f14_arg0.Name:completeAnimation()
			f14_arg0.Name:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f14_arg0.clipFinished(f14_arg0.Name)
			f14_arg0.Rank:completeAnimation()
			f14_arg0.Rank:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f14_arg0.clipFinished(f14_arg0.Rank)
			f14_arg0.infoBracketBot:completeAnimation()
			f14_arg0.infoBracketBot:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
			f14_arg0.infoBracketBot:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.infoBracketBot)
		end,
	},
}
CoD.LeaguePlayLeaderboardEntry.__onClose = function(f15_arg0)
	f15_arg0.Selection:close()
	f15_arg0.RubiesList:close()
	f15_arg0.RankPoints:close()
	f15_arg0.Name:close()
	f15_arg0.RankMovement:close()
	f15_arg0.Rank:close()
end

require("x64:62adff09117f331")
CoD.CompetitiveOverviewRankBanner = InheritFrom(LUI.UIElement)
CoD.CompetitiveOverviewRankBanner.__defaultWidth = 200
CoD.CompetitiveOverviewRankBanner.__defaultHeight = 500
CoD.CompetitiveOverviewRankBanner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompetitiveOverviewRankBanner)
	self.id = "CompetitiveOverviewRankBanner"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local banner = LUI.UIImage.new(0, 0, 0, 200, 0, 0, 0, 500)
	banner:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayBanner", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			banner:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(banner)
	self.banner = banner
	local color = LUI.UIText.new(0.5, 0.5, -76, 76, 0, 0, 291, 316)
	color:setAlpha(0)
	color:setTTF("ttmussels_demibold")
	color:setLetterSpacing(2)
	color:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	color:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	color:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayBannerName", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			color:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(color)
	self.color = color
	local rank = LUI.UIText.new(0.5, 0.5, -84, 84, 0, 0, 291, 316)
	rank:setTTF("ttmussels_demibold")
	rank:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	rank:setLetterSpacing(2)
	rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	rank:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	rank:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayRank", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			rank:setText(ToUpper(LocalizeStringWithParameter(@"hash_447AC0462E4B2132", f4_local0)))
		end
	end)
	self:addElement(rank)
	self.rank = rank
	local firestreakflipbook = LUI.UIImage.new(0.5, 0.5, -170, 170, 0.5, 0.5, -274, 66)
	firestreakflipbook:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	firestreakflipbook:setShaderVector(0, 4, 4, 0, 0)
	firestreakflipbook:setShaderVector(1, 8, 0, 0, 0)
	firestreakflipbook:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayFirestreakIcon", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			firestreakflipbook:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(firestreakflipbook)
	self.firestreakflipbook = firestreakflipbook
	local badge = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -204, -4)
	badge:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayIconLarge", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			badge:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(badge)
	self.badge = badge
	local rubies = CoD.ArenaRubies.new(f1_arg0, f1_arg1, 0, 0, 30, 170, 0, 0, 319.5, 393.5)
	rubies:setScale(0.85, 0.85)
	self:addElement(rubies)
	self.rubies = rubies
	local DivisionSkillIcon = LUI.UIImage.new(0.5, 0.5, -97.5, 97.5, 0, 0, 170.5, 365.5)
	DivisionSkillIcon:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlaySkillDivisionBannerLarge", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			DivisionSkillIcon:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(DivisionSkillIcon)
	self.DivisionSkillIcon = DivisionSkillIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Lobby",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompetitiveOverviewRankBanner.__resetProperties = function(f11_arg0)
	f11_arg0.rubies:completeAnimation()
	f11_arg0.badge:completeAnimation()
	f11_arg0.rank:completeAnimation()
	f11_arg0.color:completeAnimation()
	f11_arg0.banner:completeAnimation()
	f11_arg0.firestreakflipbook:completeAnimation()
	f11_arg0.DivisionSkillIcon:completeAnimation()
	f11_arg0.rubies:setTopBottom(0, 0, 319.5, 393.5)
	f11_arg0.rubies:setAlpha(1)
	f11_arg0.badge:setTopBottom(0.5, 0.5, -204, -4)
	f11_arg0.badge:setAlpha(1)
	f11_arg0.rank:setTopBottom(0, 0, 291, 316)
	f11_arg0.rank:setAlpha(1)
	f11_arg0.color:setTopBottom(0, 0, 291, 316)
	f11_arg0.color:setAlpha(0)
	f11_arg0.banner:setAlpha(1)
	f11_arg0.firestreakflipbook:setTopBottom(0.5, 0.5, -274, 66)
	f11_arg0.firestreakflipbook:setAlpha(1)
	f11_arg0.DivisionSkillIcon:setAlpha(1)
end
CoD.CompetitiveOverviewRankBanner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(7)
			f13_arg0.banner:completeAnimation()
			f13_arg0.banner:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.banner)
			f13_arg0.color:completeAnimation()
			f13_arg0.color:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.color)
			f13_arg0.rank:completeAnimation()
			f13_arg0.rank:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.rank)
			f13_arg0.firestreakflipbook:completeAnimation()
			f13_arg0.firestreakflipbook:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.firestreakflipbook)
			f13_arg0.badge:completeAnimation()
			f13_arg0.badge:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.badge)
			f13_arg0.rubies:completeAnimation()
			f13_arg0.rubies:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.rubies)
			f13_arg0.DivisionSkillIcon:completeAnimation()
			f13_arg0.DivisionSkillIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DivisionSkillIcon)
		end,
	},
	HiddenCopy = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(7)
			f14_arg0.banner:completeAnimation()
			f14_arg0.banner:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.banner)
			f14_arg0.color:completeAnimation()
			f14_arg0.color:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.color)
			f14_arg0.rank:completeAnimation()
			f14_arg0.rank:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.rank)
			f14_arg0.firestreakflipbook:completeAnimation()
			f14_arg0.firestreakflipbook:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.firestreakflipbook)
			f14_arg0.badge:completeAnimation()
			f14_arg0.badge:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.badge)
			f14_arg0.rubies:completeAnimation()
			f14_arg0.rubies:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.rubies)
			f14_arg0.DivisionSkillIcon:completeAnimation()
			f14_arg0.DivisionSkillIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.DivisionSkillIcon)
		end,
	},
	Lobby = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.color:completeAnimation()
			f15_arg0.color:setTopBottom(0, 0, 372, 397)
			f15_arg0.clipFinished(f15_arg0.color)
			f15_arg0.rank:completeAnimation()
			f15_arg0.rank:setTopBottom(0, 0, 379.5, 400.5)
			f15_arg0.clipFinished(f15_arg0.rank)
			f15_arg0.firestreakflipbook:completeAnimation()
			f15_arg0.firestreakflipbook:setTopBottom(0.5, 0.5, -156, 184)
			f15_arg0.clipFinished(f15_arg0.firestreakflipbook)
			f15_arg0.badge:completeAnimation()
			f15_arg0.badge:setTopBottom(0.5, 0.5, -80, 120)
			f15_arg0.clipFinished(f15_arg0.badge)
			f15_arg0.rubies:completeAnimation()
			f15_arg0.rubies:setTopBottom(0, 0, 402, 442)
			f15_arg0.clipFinished(f15_arg0.rubies)
		end,
	},
}
CoD.CompetitiveOverviewRankBanner.__onClose = function(f16_arg0)
	f16_arg0.banner:close()
	f16_arg0.color:close()
	f16_arg0.rank:close()
	f16_arg0.firestreakflipbook:close()
	f16_arg0.badge:close()
	f16_arg0.rubies:close()
	f16_arg0.DivisionSkillIcon:close()
end

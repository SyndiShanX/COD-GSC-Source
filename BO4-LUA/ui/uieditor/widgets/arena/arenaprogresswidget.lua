require("x64:c7393046816f760")
require("x64:11189e39122045c")
require("x64:804ba90b949afea")
require("x64:b5b62ca685f6792")
CoD.ArenaProgressWidget = InheritFrom(LUI.UIElement)
CoD.ArenaProgressWidget.__defaultWidth = 1110
CoD.ArenaProgressWidget.__defaultHeight = 200
CoD.ArenaProgressWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaProgressWidget)
	self.id = "ArenaProgressWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local BodyBacker = LUI.UIImage.new(0, 0, 75, 1109, 0, 0, 0, 124)
	BodyBacker:setRGB(0.1, 0.1, 0.1)
	BodyBacker:setAlpha(0.2)
	self:addElement(BodyBacker)
	self.BodyBacker = BodyBacker
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 75, 1109, 0, 0, 2, 122)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SquareOthers = CoD.AARLevelCommonBoxes.new(f1_arg0, f1_arg1, 0, 0, 1054, 1102, 0, 0, 8.5, 21.5)
	SquareOthers:setAlpha(0.2)
	self:addElement(SquareOthers)
	self.SquareOthers = SquareOthers
	local CornerBottomRight = LUI.UIImage.new(1, 1, -3, 1, 1, 1, -78, -74)
	CornerBottomRight:setAlpha(0.2)
	CornerBottomRight:setImage(RegisterImage(@"hash_6CD2D51C614BCB51"))
	self:addElement(CornerBottomRight)
	self.CornerBottomRight = CornerBottomRight
	local CornerTopRight = LUI.UIImage.new(1, 1, -3, 1, 0, 0, -2, 2)
	CornerTopRight:setAlpha(0.2)
	CornerTopRight:setImage(RegisterImage(@"hash_6CD2D51C614BCB51"))
	self:addElement(CornerTopRight)
	self.CornerTopRight = CornerTopRight
	local firestreakflipbook = LUI.UIImage.new(0.5, 0.5, -665, -295, 0.5, 0.5, -223, 147)
	firestreakflipbook:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	firestreakflipbook:setShaderVector(0, 4, 4, 0, 0)
	firestreakflipbook:setShaderVector(1, 8, 0, 0, 0)
	firestreakflipbook:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayFirestreakIcon", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			firestreakflipbook:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(firestreakflipbook)
	self.firestreakflipbook = firestreakflipbook
	local RankIcon = LUI.UIImage.new(0, 0, -15, 165, 0, 0, -28, 152)
	RankIcon:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayIconLarge", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local NextRank = LUI.UIText.new(0, 0, 901, 1101, 0, 0, 93.5, 111.5)
	NextRank:setTTF("ttmussels_regular")
	NextRank:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	NextRank:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	NextRank:subscribeToGlobalModel(f1_arg1, "LeaguePlay", "leaguePlayRank", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NextRank:setText(LocalizeToUpperString(CoD.ArenaLeaguePlayUtility.GetNextLeagueRank(f4_local0)))
		end
	end)
	self:addElement(NextRank)
	self.NextRank = NextRank
	local ArenaRubyProgressWidget = CoD.ArenaRubyProgressWidget.new(f1_arg0, f1_arg1, 0, 0, 175, 1101, 0, 0, 42, 82)
	self:addElement(ArenaRubyProgressWidget)
	self.ArenaRubyProgressWidget = ArenaRubyProgressWidget
	local PlacementText = CoD.ArenaProgressWidgetRank.new(f1_arg0, f1_arg1, 0, 0, 174, 833, 0, 0, 8, 80)
	self:addElement(PlacementText)
	self.PlacementText = PlacementText
	local RubyProgress = CoD.ArenaProgressWidgetRubyInfo.new(f1_arg0, f1_arg1, 0, 0, 174, 513, 0, 0, 93.5, 118.5)
	self:addElement(RubyProgress)
	self.RubyProgress = RubyProgress
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaProgressWidget.__onClose = function(f5_arg0)
	f5_arg0.SquareOthers:close()
	f5_arg0.firestreakflipbook:close()
	f5_arg0.RankIcon:close()
	f5_arg0.NextRank:close()
	f5_arg0.ArenaRubyProgressWidget:close()
	f5_arg0.PlacementText:close()
	f5_arg0.RubyProgress:close()
end

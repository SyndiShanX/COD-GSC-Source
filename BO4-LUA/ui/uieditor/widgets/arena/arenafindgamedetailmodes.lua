require("x64:8f23f7c1fb7a83b")
require("x64:872cba4251b73ea")
CoD.ArenaFindGameDetailModes = InheritFrom(LUI.UIElement)
CoD.ArenaFindGameDetailModes.__defaultWidth = 460
CoD.ArenaFindGameDetailModes.__defaultHeight = 210
CoD.ArenaFindGameDetailModes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaFindGameDetailModes)
	self.id = "ArenaFindGameDetailModes"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local AARPerformBg = LUI.UIImage.new(0, 0, 0, 460, 0, 0, 0, 210)
	AARPerformBg:setAlpha(0.5)
	AARPerformBg:setImage(RegisterImage(@"uie_ui_menu_aar_perform_repeat_bg"))
	AARPerformBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	AARPerformBg:setShaderVector(0, 0, 0, 0, 0)
	AARPerformBg:setupNineSliceShader(344, 136)
	self:addElement(AARPerformBg)
	self.AARPerformBg = AARPerformBg
	local TiledBg = LUI.UIImage.new(0, 0, 0, 460, 0, 0, 0, 210)
	TiledBg:setAlpha(0.02)
	TiledBg:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	TiledBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBg:setShaderVector(0, 0, 0, 0, 0)
	TiledBg:setupNineSliceShader(64, 64)
	self:addElement(TiledBg)
	self.TiledBg = TiledBg
	local infoBracketBot = LUI.UIImage.new(0, 0, -1, 461, 0, 0, 203.5, 211.5)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local title = CoD.DirectorPlaylistHeaderB.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 0, 24)
	title:setAlpha(0)
	title:linkToElementModel(self, "modesTitleString", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			title.description4:setText(f2_local0)
		end
	end)
	self:addElement(title)
	self.title = title
	local MapList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 0, 0, nil, nil, false, false, false, false)
	MapList:setLeftRight(0, 0, 172, 472)
	MapList:setTopBottom(0, 0, 73, 199)
	MapList:setWidgetType(CoD.LeaguePlayListTextBox)
	MapList:setVerticalCount(6)
	MapList:setSpacing(0)
	MapList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MapList:linkToElementModel(self, "mapList", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MapList:setDataSource(f3_local0)
		end
	end)
	self:addElement(MapList)
	self.MapList = MapList
	local modeMaps = LUI.UIText.new(0, 0, 172, 461, 0, 0, 52, 70)
	modeMaps:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	modeMaps:setText(LocalizeToUpperString(@"hash_77114287D168D9DA"))
	modeMaps:setTTF("ttmussels_regular")
	modeMaps:setLetterSpacing(2)
	modeMaps:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	modeMaps:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(modeMaps)
	self.modeMaps = modeMaps
	local ModeDescription = LUI.UIText.new(0, 0, 172, 460, 0, 0, 15, 39)
	ModeDescription:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ModeDescription:setTTF("ttmussels_demibold")
	ModeDescription:setLetterSpacing(2)
	ModeDescription:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	ModeDescription:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_middle"]))
	ModeDescription:linkToElementModel(self, "modesTitleString", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ModeDescription:setText(f4_local0)
		end
	end)
	self:addElement(ModeDescription)
	self.ModeDescription = ModeDescription
	local Gamemode = LUI.UIImage.new(0, 0, -15, 185, 0, 0, 5, 205)
	Gamemode:linkToElementModel(self, "modesIcon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Gamemode:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(Gamemode)
	self.Gamemode = Gamemode
	MapList.id = "MapList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaFindGameDetailModes.__onClose = function(f6_arg0)
	f6_arg0.title:close()
	f6_arg0.MapList:close()
	f6_arg0.ModeDescription:close()
	f6_arg0.Gamemode:close()
end

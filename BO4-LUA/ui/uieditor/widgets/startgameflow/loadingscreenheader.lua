require("x64:4141c0118a5ab1d")
CoD.LoadingScreenHeader = InheritFrom(LUI.UIElement)
CoD.LoadingScreenHeader.__defaultWidth = 1129
CoD.LoadingScreenHeader.__defaultHeight = 200
CoD.LoadingScreenHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadingScreenHeader)
	self.id = "LoadingScreenHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledBackingTop = LUI.UIImage.new(0.5, 0.5, -542.5, 48.5, 0, 0, 2, 200)
	TiledBackingTop:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBackingTop:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingTop:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingTop)
	self.TiledBackingTop = TiledBackingTop
	local TiledBackingTop2 = LUI.UIImage.new(0.5, 0.5, -542.5, 48.5, 0, 0, 41, 91)
	TiledBackingTop2:setRGB(0.11, 0.11, 0.11)
	TiledBackingTop2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingTop2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBackingTop2:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingTop2:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingTop2)
	self.TiledBackingTop2 = TiledBackingTop2
	local BACKINGMapName = LUI.UIImage.new(0, 0, 22, 613, 0, 0, 2, 42)
	BACKINGMapName:setRGB(0.04, 0.04, 0.04)
	BACKINGMapName:setAlpha(0.8)
	self:addElement(BACKINGMapName)
	self.BACKINGMapName = BACKINGMapName
	local DiagonalLine = LUI.UIImage.new(0, 0, 22, 613, 0, 0, 2, 42)
	DiagonalLine:setRGB(0.25, 0.25, 0.25)
	DiagonalLine:setImage(RegisterImage(@"uie_ui_menu_common_repeat_stripe"))
	DiagonalLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	DiagonalLine:setShaderVector(0, 8, 1, 0, 0)
	DiagonalLine:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(DiagonalLine)
	self.DiagonalLine = DiagonalLine
	local LoadingScreenPlayerStats = CoD.LoadingScreenPlayerStats.new(f1_arg0, f1_arg1, 0.5, 0.5, -426.5, 38.5, 0, 0, 122, 192)
	LoadingScreenPlayerStats:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", nil, function(model)
		LoadingScreenPlayerStats:setModel(model, f1_arg1)
	end)
	self:addElement(LoadingScreenPlayerStats)
	self.LoadingScreenPlayerStats = LoadingScreenPlayerStats
	local GamemodeName = LUI.UIText.new(0, 0, 133, 603, 0, 0, 53, 91)
	GamemodeName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GamemodeName:setTTF("ttmussels_demibold")
	GamemodeName:setLetterSpacing(5)
	GamemodeName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GamemodeName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	GamemodeName:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "gameType", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GamemodeName:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f3_local0)))
		end
	end)
	self:addElement(GamemodeName)
	self.GamemodeName = GamemodeName
	local MapNameShadow = LUI.UIText.new(0.5, 0.5, -431.5, 528.5, 0, 0, 8, 38)
	MapNameShadow:setRGB(0, 0, 0)
	MapNameShadow:setAlpha(0.25)
	MapNameShadow:setTTF("ttmussels_regular")
	MapNameShadow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	MapNameShadow:setShaderVector(0, 0.4, 0, 0, 0)
	MapNameShadow:setShaderVector(1, 0, 0, 0, 0)
	MapNameShadow:setShaderVector(2, 1, 0, 0, 0)
	MapNameShadow:setLetterSpacing(6)
	MapNameShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MapNameShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	MapNameShadow:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "mapName", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MapNameShadow:setText(ToUpper(CoD.BaseUtility.AlreadyLocalized(f4_local0)))
		end
	end)
	self:addElement(MapNameShadow)
	self.MapNameShadow = MapNameShadow
	local MapName = LUI.UIText.new(0, 0, 133, 603, 0, 0, 8, 38)
	MapName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	MapName:setTTF("ttmussels_regular")
	MapName:setLetterSpacing(6)
	MapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MapName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	MapName:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "mapName", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MapName:setText(ToUpper(CoD.BaseUtility.AlreadyLocalized(f5_local0)))
		end
	end)
	self:addElement(MapName)
	self.MapName = MapName
	self:mergeStateConditions({
		{
			stateName = "CodCaster",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsCodCasterOrAssigned(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadingScreenHeader.__resetProperties = function(f7_arg0)
	f7_arg0.LoadingScreenPlayerStats:completeAnimation()
	f7_arg0.LoadingScreenPlayerStats:setAlpha(1)
end
CoD.LoadingScreenHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	CodCaster = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.LoadingScreenPlayerStats:completeAnimation()
			f9_arg0.LoadingScreenPlayerStats:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LoadingScreenPlayerStats)
		end,
	},
}
CoD.LoadingScreenHeader.__onClose = function(f10_arg0)
	f10_arg0.LoadingScreenPlayerStats:close()
	f10_arg0.GamemodeName:close()
	f10_arg0.MapNameShadow:close()
	f10_arg0.MapName:close()
end

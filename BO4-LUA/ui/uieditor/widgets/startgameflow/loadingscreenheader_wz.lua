CoD.LoadingScreenHeader_WZ = InheritFrom(LUI.UIElement)
CoD.LoadingScreenHeader_WZ.__defaultWidth = 1129
CoD.LoadingScreenHeader_WZ.__defaultHeight = 128
CoD.LoadingScreenHeader_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadingScreenHeader_WZ)
	self.id = "LoadingScreenHeader_WZ"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledBackingTop = LUI.UIImage.new(0.5, 0.5, -542.5, 48.5, 0, 0, 1, 128)
	TiledBackingTop:setAlpha(0.9)
	TiledBackingTop:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBackingTop:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingTop:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingTop)
	self.TiledBackingTop = TiledBackingTop
	local TiledBackingTop2 = LUI.UIImage.new(0.5, 0.5, -542.5, 48.5, 0, 0, 59, 109)
	TiledBackingTop2:setRGB(0.11, 0.11, 0.11)
	TiledBackingTop2:setAlpha(0)
	TiledBackingTop2:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingTop2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBackingTop2:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingTop2:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingTop2)
	self.TiledBackingTop2 = TiledBackingTop2
	local BACKINGMapName = LUI.UIImage.new(0, 0, 21.5, 612.5, 0, 0, 1, 23)
	BACKINGMapName:setRGB(0.04, 0.04, 0.04)
	BACKINGMapName:setAlpha(0.8)
	self:addElement(BACKINGMapName)
	self.BACKINGMapName = BACKINGMapName
	local DiagonalLine = LUI.UIImage.new(0, 0, 21.5, 612.5, 0, 0, 1, 23)
	DiagonalLine:setRGB(0.25, 0.25, 0.25)
	DiagonalLine:setImage(RegisterImage("uie_ui_menu_common_repeat_stripe"))
	DiagonalLine:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	DiagonalLine:setShaderVector(0, 8, 1, 0, 0)
	DiagonalLine:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(DiagonalLine)
	self.DiagonalLine = DiagonalLine
	local GamemodeName = LUI.UIText.new(0, 0, 120, 603, 0, 0, 58, 96)
	GamemodeName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GamemodeName:setTTF("ttmussels_demibold")
	GamemodeName:setLetterSpacing(5)
	GamemodeName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GamemodeName:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	GamemodeName:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "gameType", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GamemodeName:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f2_local0)))
		end
	end)
	self:addElement(GamemodeName)
	self.GamemodeName = GamemodeName
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
CoD.LoadingScreenHeader_WZ.__onClose = function(f4_arg0)
	f4_arg0.GamemodeName:close()
end

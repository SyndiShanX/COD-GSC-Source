require("x64:19c1945d2e472b0")
CoD.DirectorSelectButtonMode = InheritFrom(LUI.UIElement)
CoD.DirectorSelectButtonMode.__defaultWidth = 300
CoD.DirectorSelectButtonMode.__defaultHeight = 56
CoD.DirectorSelectButtonMode.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorSelectButtonMode)
	self.id = "DirectorSelectButtonMode"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextBacking:setRGB(0, 0, 0)
	TextBacking:setAlpha(0.65)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setAlpha(0.5)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(32, 32)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local GamemodeIcon = LUI.UIImage.new(0, 0, 103, 197, 0, 0, -41, 53)
	GamemodeIcon:setAlpha(0)
	GamemodeIcon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GamemodeIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(GamemodeIcon)
	self.GamemodeIcon = GamemodeIcon
	local GameModeText = LUI.UIText.new(0, 1, 8, -8, 0.5, 0.5, -12, 12)
	GameModeText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	GameModeText:setText(ToUpper(CoD.BaseUtility.LocalizeIfXHash(@"hash_A43B10D9DA121A")))
	GameModeText:setTTF("ttmussels_demibold")
	GameModeText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	GameModeText:setLetterSpacing(3)
	GameModeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GameModeText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(GameModeText)
	self.GameModeText = GameModeText
	local TabBottomLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -2, 2)
	TabBottomLine:setAlpha(0.09)
	TabBottomLine:setImage(RegisterImage(@"uie_ui_menu_common_tab_line_bottom"))
	TabBottomLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
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
CoD.DirectorSelectButtonMode.__resetProperties = function(f5_arg0)
	f5_arg0.GameModeText:completeAnimation()
	f5_arg0.TabBottomLine:completeAnimation()
	f5_arg0.GamemodeIcon:completeAnimation()
	f5_arg0.DotTiledBacking:completeAnimation()
	f5_arg0.TextBacking:completeAnimation()
	f5_arg0.GameModeText:setAlpha(1)
	f5_arg0.TabBottomLine:setAlpha(0.09)
	f5_arg0.GamemodeIcon:setAlpha(0)
	f5_arg0.DotTiledBacking:setAlpha(1)
	f5_arg0.TextBacking:setAlpha(0.65)
end
CoD.DirectorSelectButtonMode.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.GameModeText:completeAnimation()
			f7_arg0.GameModeText:setAlpha(0.2)
			f7_arg0.clipFinished(f7_arg0.GameModeText)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.TextBacking:completeAnimation()
			f8_arg0.TextBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TextBacking)
			f8_arg0.DotTiledBacking:completeAnimation()
			f8_arg0.DotTiledBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DotTiledBacking)
			f8_arg0.GamemodeIcon:completeAnimation()
			f8_arg0.GamemodeIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GamemodeIcon)
			f8_arg0.GameModeText:completeAnimation()
			f8_arg0.GameModeText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GameModeText)
			f8_arg0.TabBottomLine:completeAnimation()
			f8_arg0.TabBottomLine:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TabBottomLine)
		end,
	},
}
CoD.DirectorSelectButtonMode.__onClose = function(f9_arg0)
	f9_arg0.DotTiledBacking:close()
	f9_arg0.GamemodeIcon:close()
end

CoD.LeaderboardHeader = InheritFrom(LUI.UIElement)
CoD.LeaderboardHeader.__defaultWidth = 1170
CoD.LeaderboardHeader.__defaultHeight = 36
CoD.LeaderboardHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaderboardHeader)
	self.id = "LeaderboardHeader"
	self.soundSet = "FrontendMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 36)
	BG:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	BG:setAlpha(0.05)
	self:addElement(BG)
	self.BG = BG
	local PixelGridTiledBacking = LUI.UIImage.new(0.02, 0.02, -24, 1150, 0.31, 0.31, -10.5, 24.5)
	PixelGridTiledBacking:setAlpha(0.08)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local Position = LUI.UIText.new(0, 0, 8, 118, 0.5, 0.5, -9, 9)
	Position:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Position:setTTF("ttmussels_regular")
	Position:setLetterSpacing(1)
	Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Position:linkToElementModel(self, "position", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Position:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(Position)
	self.Position = Position
	local Rank = LUI.UIText.new(0, 0, 124, 192, 0.5, 0.5, -9, 9)
	Rank:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Rank:setTTF("ttmussels_regular")
	Rank:setLetterSpacing(1)
	Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Rank:linkToElementModel(self, "rank", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Rank:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local Name = LUI.UIText.new(0, 0, 210.5, 465.5, 0.5, 0.5, -9, 9)
	Name:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(1)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Name:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Column0 = LUI.UIText.new(0, 0, 469, 599, 0.5, 0.5, -9, 9)
	Column0:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Column0:setTTF("ttmussels_regular")
	Column0:setLetterSpacing(1)
	Column0:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Column0:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Column0:linkToElementModel(self, "column0", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Column0:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(Column0)
	self.Column0 = Column0
	local Column1 = LUI.UIText.new(0, 0, 607, 737, 0.5, 0.5, -9, 9)
	Column1:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Column1:setTTF("ttmussels_regular")
	Column1:setLetterSpacing(1)
	Column1:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Column1:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Column1:linkToElementModel(self, "column1", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Column1:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(Column1)
	self.Column1 = Column1
	local Column2 = LUI.UIText.new(0, 0, 748, 878, 0.5, 0.5, -9, 9)
	Column2:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Column2:setTTF("ttmussels_regular")
	Column2:setLetterSpacing(1)
	Column2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Column2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Column2:linkToElementModel(self, "column2", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Column2:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(Column2)
	self.Column2 = Column2
	local Column3 = LUI.UIText.new(0, 0, 888, 1018, 0.5, 0.5, -9, 9)
	Column3:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Column3:setTTF("ttmussels_regular")
	Column3:setLetterSpacing(1)
	Column3:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Column3:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Column3:linkToElementModel(self, "column3", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Column3:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	self:addElement(Column3)
	self.Column3 = Column3
	local Column4 = LUI.UIText.new(1, 1, -138, -8, 0.5, 0.5, -9, 9)
	Column4:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Column4:setTTF("ttmussels_regular")
	Column4:setLetterSpacing(1)
	Column4:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Column4:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Column4:linkToElementModel(self, "column4", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Column4:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	self:addElement(Column4)
	self.Column4 = Column4
	local TopFrame = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 8)
	TopFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TopFrame:setZRot(180)
	TopFrame:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	TopFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	TopFrame:setShaderVector(0, 0, 0, 0, 0)
	TopFrame:setupNineSliceShader(16, 4)
	self:addElement(TopFrame)
	self.TopFrame = TopFrame
	self:mergeStateConditions({
		{
			stateName = "DefaultStateArabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaderboardHeader.__resetProperties = function(f12_arg0)
	f12_arg0.Rank:completeAnimation()
	f12_arg0.Name:completeAnimation()
	f12_arg0.Position:completeAnimation()
	f12_arg0.Column0:completeAnimation()
	f12_arg0.Column1:completeAnimation()
	f12_arg0.Column2:completeAnimation()
	f12_arg0.Column3:completeAnimation()
	f12_arg0.Column4:completeAnimation()
	f12_arg0.Rank:setTopBottom(0.5, 0.5, -9, 9)
	f12_arg0.Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	f12_arg0.Name:setTopBottom(0.5, 0.5, -9, 9)
	f12_arg0.Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f12_arg0.Position:setTopBottom(0.5, 0.5, -9, 9)
	f12_arg0.Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f12_arg0.Column0:setTopBottom(0.5, 0.5, -9, 9)
	f12_arg0.Column1:setTopBottom(0.5, 0.5, -9, 9)
	f12_arg0.Column2:setTopBottom(0.5, 0.5, -9, 9)
	f12_arg0.Column3:setTopBottom(0.5, 0.5, -9, 9)
	f12_arg0.Column4:setLeftRight(1, 1, -138, -8)
	f12_arg0.Column4:setTopBottom(0.5, 0.5, -9, 9)
end
CoD.LeaderboardHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStateArabic = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.Position:completeAnimation()
			f14_arg0.Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f14_arg0.clipFinished(f14_arg0.Position)
			f14_arg0.Rank:completeAnimation()
			f14_arg0.Rank:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f14_arg0.clipFinished(f14_arg0.Rank)
			f14_arg0.Name:completeAnimation()
			f14_arg0.Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f14_arg0.clipFinished(f14_arg0.Name)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(8)
			f15_arg0.Position:completeAnimation()
			f15_arg0.Position:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Position)
			f15_arg0.Rank:completeAnimation()
			f15_arg0.Rank:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Rank)
			f15_arg0.Name:completeAnimation()
			f15_arg0.Name:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Name)
			f15_arg0.Column0:completeAnimation()
			f15_arg0.Column0:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Column0)
			f15_arg0.Column1:completeAnimation()
			f15_arg0.Column1:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Column1)
			f15_arg0.Column2:completeAnimation()
			f15_arg0.Column2:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Column2)
			f15_arg0.Column3:completeAnimation()
			f15_arg0.Column3:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Column3)
			f15_arg0.Column4:completeAnimation()
			f15_arg0.Column4:setLeftRight(1, 1, -137, -7)
			f15_arg0.Column4:setTopBottom(0.5, 0.5, -2.5, 12.5)
			f15_arg0.clipFinished(f15_arg0.Column4)
		end,
	},
}
CoD.LeaderboardHeader.__onClose = function(f16_arg0)
	f16_arg0.Position:close()
	f16_arg0.Rank:close()
	f16_arg0.Name:close()
	f16_arg0.Column0:close()
	f16_arg0.Column1:close()
	f16_arg0.Column2:close()
	f16_arg0.Column3:close()
	f16_arg0.Column4:close()
end

require("ui/uieditor/widgets/challenges/challenges_framewidget_titlebackground")
require("ui/uieditor/widgets/fileshare/filesharebookmarkeditem")
require("ui/uieditor/widgets/fileshare/selectedfilmsummaryinformation")
CoD.SelectedFilmInformation = InheritFrom(LUI.UIElement)
CoD.SelectedFilmInformation.__defaultWidth = 525
CoD.SelectedFilmInformation.__defaultHeight = 792
CoD.SelectedFilmInformation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SelectedFilmInformation)
	self.id = "SelectedFilmInformation"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, -0, 1, -1, 1, 0.5, 0.5, -417, 417)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local MapImage = LUI.UIImage.new(0.5, 0.5, -262, 262, 0, 0, 0, 386)
	MapImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	MapImage:setShaderVector(0, 0, 0, 0, 0)
	MapImage:setShaderVector(1, 1, 1, 0, 0)
	MapImage:setShaderVector(2, 0, 0, 0, 0)
	MapImage:linkToElementModel(self, "mapName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage:setImage(RegisterImage(MapNameToMapImage(f2_local0)))
		end
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local Thumbnail = LUI.UIElement.new(0.5, 0.5, -258, 264, 0, 0, 0, 297)
	Thumbnail:linkToElementModel(self, "fileId", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Thumbnail:setupImageViewer(GetImageViewerParams("UI_SCREENSHOT_TYPE_THUMBNAIL", f3_local0))
		end
	end)
	self:addElement(Thumbnail)
	self.Thumbnail = Thumbnail
	local AuthorName = LUI.UIText.new(0, 1, 16, -16, 1, 1, -410, -374)
	AuthorName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	AuthorName:setTTF("ttmussels_regular")
	AuthorName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	AuthorName:setShaderVector(0, 0.04, 0, 0, 0)
	AuthorName:setShaderVector(1, 0.02, 0, 0, 0)
	AuthorName:setShaderVector(2, 1, 0, 0, 0)
	AuthorName:setLetterSpacing(3)
	AuthorName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	AuthorName:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	AuthorName:linkToElementModel(self, "fileAuthorName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			AuthorName:setText(CoD.SocialUtility.CleanGamerTag(f4_local0))
		end
	end)
	self:addElement(AuthorName)
	self.AuthorName = AuthorName
	local CreateTime = LUI.UIText.new(0, 1, 17, -17, 1, 1, -370, -352)
	CreateTime:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	CreateTime:setTTF("dinnext_regular")
	CreateTime:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	CreateTime:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	CreateTime:linkToElementModel(self, "fileCreateTime", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CreateTime:setText(f5_local0)
		end
	end)
	self:addElement(CreateTime)
	self.CreateTime = CreateTime
	local MatchType = LUI.UIText.new(0.58, 1.58, -287, -321, 1, 1, -349, -331)
	MatchType:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	MatchType:setTTF("dinnext_regular")
	MatchType:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	MatchType:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	MatchType:linkToElementModel(self, "matchmakingMode", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MatchType:setText(CoD.FileshareUtility.FileshareGetMatchmakingMode(f6_local0))
		end
	end)
	self:addElement(MatchType)
	self.MatchType = MatchType
	local SelectedFilmSummaryInformation = CoD.SelectedFilmSummaryInformation.new(f1_arg0, f1_arg1, 0, 1, 16, -16, 1, 1, -313, -195)
	SelectedFilmSummaryInformation:linkToElementModel(self, "summary", false, function(model)
		SelectedFilmSummaryInformation:setModel(model, f1_arg1)
	end)
	SelectedFilmSummaryInformation:subscribeToGlobalModel(f1_arg1, "GlobalModel", "fileshareRoot.summaryDownloadTask.state", function(model)
		local f8_local0 = SelectedFilmSummaryInformation
		if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("fileshareRoot.summaryDownloadTask.state", Enum.FileshareTaskUIState[@"fileshare_task_ui_done"]) and CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.summaryDownloadTask.success") then
			CoD.FileshareUtility.FileshareHandleDownloadSummary(self)
		end
	end)
	self:addElement(SelectedFilmSummaryInformation)
	self.SelectedFilmSummaryInformation = SelectedFilmSummaryInformation
	local BookmarkedItem = CoD.FileshareBookmarkedItem.new(f1_arg0, f1_arg1, 0, 0, 4, 198, 0, 0, 3.5, 29.5)
	BookmarkedItem:mergeStateConditions({
		{
			stateName = "IconOnly",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "IconWithText",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBookmarked")
			end,
		},
	})
	BookmarkedItem:linkToElementModel(BookmarkedItem, "isBookmarked", true, function(model)
		f1_arg0:updateElementState(BookmarkedItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBookmarked",
		})
	end)
	BookmarkedItem:linkToElementModel(self, nil, false, function(model)
		BookmarkedItem:setModel(model, f1_arg1)
	end)
	self:addElement(BookmarkedItem)
	self.BookmarkedItem = BookmarkedItem
	local GametypeOnMapName = LUI.UIText.new(0, 1, 20, -20, 1, 1, -451, -433)
	GametypeOnMapName:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	GametypeOnMapName:setTTF("dinnext_regular")
	GametypeOnMapName:setLetterSpacing(2)
	GametypeOnMapName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GametypeOnMapName:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	GametypeOnMapName:setBackingType(2)
	GametypeOnMapName:setBackingColor(0, 0, 0)
	GametypeOnMapName:setBackingAlpha(0.9)
	GametypeOnMapName:setBackingXPadding(4)
	GametypeOnMapName:setBackingYPadding(1)
	GametypeOnMapName:linkToElementModel(self, "fileDescription", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			GametypeOnMapName:setText(f13_local0)
		end
	end)
	self:addElement(GametypeOnMapName)
	self.GametypeOnMapName = GametypeOnMapName
	local GameModeTitle = LUI.UIText.new(0, 1, 20, -20, 0, 0, 316, 352)
	GameModeTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GameModeTitle:setTTF("ttmussels_regular")
	GameModeTitle:setLetterSpacing(2)
	GameModeTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GameModeTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	GameModeTitle:setBackingType(2)
	GameModeTitle:setBackingColor(0, 0, 0)
	GameModeTitle:setBackingAlpha(0.9)
	GameModeTitle:setBackingXPadding(4)
	GameModeTitle:setBackingYPadding(1)
	GameModeTitle:linkToElementModel(self, "fileName", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			GameModeTitle:setText(f14_local0)
		end
	end)
	self:addElement(GameModeTitle)
	self.GameModeTitle = GameModeTitle
	local GameTypeImage = LUI.UIImage.new(0, 0, 398.5, 534.5, 0, 0, 260, 396)
	GameTypeImage:linkToElementModel(self, "gameTypeImage", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			GameTypeImage:setImage(RegisterImage(f15_local0))
		end
	end)
	self:addElement(GameTypeImage)
	self.GameTypeImage = GameTypeImage
	local DurationText = LUI.UIText.new(0, 0, 428, 518, 0, 0, 7.5, 34.5)
	DurationText:setTTF("dinnext_regular")
	DurationText:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	DurationText:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	DurationText:setBackingType(2)
	DurationText:setBackingColor(0, 0, 0)
	DurationText:setBackingAlpha(0.9)
	DurationText:setBackingXPadding(2)
	DurationText:linkToElementModel(self, "duration", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			DurationText:setText(MillisecondsAsMinAndSeconds(f16_local0))
		end
	end)
	self:addElement(DurationText)
	self.DurationText = DurationText
	self:mergeStateConditions({
		{
			stateName = "Film",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "fileCategory", "film", "recentgames")
			end,
		},
		{
			stateName = "Screenshot",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "fileCategory", "screenshot", "screenshot_private")
			end,
		},
		{
			stateName = "Clip",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "fileCategory", "clip", "clip_private")
			end,
		},
	})
	self:linkToElementModel(self, "fileCategory", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "fileCategory",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SelectedFilmInformation.__resetProperties = function(f21_arg0)
	f21_arg0.MatchType:completeAnimation()
	f21_arg0.MapImage:completeAnimation()
	f21_arg0.GameTypeImage:completeAnimation()
	f21_arg0.Thumbnail:completeAnimation()
	f21_arg0.AuthorName:completeAnimation()
	f21_arg0.DurationText:completeAnimation()
	f21_arg0.BookmarkedItem:completeAnimation()
	f21_arg0.SelectedFilmSummaryInformation:completeAnimation()
	f21_arg0.MatchType:setAlpha(1)
	f21_arg0.MapImage:setAlpha(1)
	f21_arg0.GameTypeImage:setAlpha(1)
	f21_arg0.Thumbnail:setAlpha(1)
	f21_arg0.AuthorName:setAlpha(1)
	f21_arg0.DurationText:setAlpha(1)
	f21_arg0.BookmarkedItem:setAlpha(1)
	f21_arg0.SelectedFilmSummaryInformation:setAlpha(1)
end
CoD.SelectedFilmInformation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.MapImage:completeAnimation()
			f22_arg0.MapImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.MapImage)
			f22_arg0.Thumbnail:completeAnimation()
			f22_arg0.Thumbnail:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.Thumbnail)
			f22_arg0.MatchType:completeAnimation()
			f22_arg0.MatchType:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.MatchType)
			f22_arg0.GameTypeImage:completeAnimation()
			f22_arg0.GameTypeImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.GameTypeImage)
		end,
	},
	Film = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(5)
			f23_arg0.MapImage:completeAnimation()
			f23_arg0.MapImage:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.MapImage)
			f23_arg0.Thumbnail:completeAnimation()
			f23_arg0.Thumbnail:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Thumbnail)
			f23_arg0.AuthorName:completeAnimation()
			f23_arg0.AuthorName:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.AuthorName)
			f23_arg0.MatchType:completeAnimation()
			f23_arg0.MatchType:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MatchType)
			f23_arg0.GameTypeImage:completeAnimation()
			f23_arg0.GameTypeImage:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.GameTypeImage)
		end,
	},
	Screenshot = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(8)
			f24_arg0.MapImage:completeAnimation()
			f24_arg0.MapImage:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.MapImage)
			f24_arg0.Thumbnail:completeAnimation()
			f24_arg0.Thumbnail:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Thumbnail)
			f24_arg0.AuthorName:completeAnimation()
			f24_arg0.AuthorName:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.AuthorName)
			f24_arg0.MatchType:completeAnimation()
			f24_arg0.MatchType:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.MatchType)
			f24_arg0.SelectedFilmSummaryInformation:completeAnimation()
			f24_arg0.SelectedFilmSummaryInformation:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.SelectedFilmSummaryInformation)
			f24_arg0.BookmarkedItem:completeAnimation()
			f24_arg0.BookmarkedItem:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.BookmarkedItem)
			f24_arg0.GameTypeImage:completeAnimation()
			f24_arg0.GameTypeImage:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.GameTypeImage)
			f24_arg0.DurationText:completeAnimation()
			f24_arg0.DurationText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DurationText)
		end,
	},
	Clip = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(8)
			f25_arg0.MapImage:completeAnimation()
			f25_arg0.MapImage:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.MapImage)
			f25_arg0.Thumbnail:completeAnimation()
			f25_arg0.Thumbnail:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Thumbnail)
			f25_arg0.AuthorName:completeAnimation()
			f25_arg0.AuthorName:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.AuthorName)
			f25_arg0.MatchType:completeAnimation()
			f25_arg0.MatchType:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.MatchType)
			f25_arg0.SelectedFilmSummaryInformation:completeAnimation()
			f25_arg0.SelectedFilmSummaryInformation:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.SelectedFilmSummaryInformation)
			f25_arg0.BookmarkedItem:completeAnimation()
			f25_arg0.BookmarkedItem:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.BookmarkedItem)
			f25_arg0.GameTypeImage:completeAnimation()
			f25_arg0.GameTypeImage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.GameTypeImage)
			f25_arg0.DurationText:completeAnimation()
			f25_arg0.DurationText:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.DurationText)
		end,
	},
}
CoD.SelectedFilmInformation.__onClose = function(f26_arg0)
	f26_arg0.TitleBG:close()
	f26_arg0.MapImage:close()
	f26_arg0.Thumbnail:close()
	f26_arg0.AuthorName:close()
	f26_arg0.CreateTime:close()
	f26_arg0.MatchType:close()
	f26_arg0.SelectedFilmSummaryInformation:close()
	f26_arg0.BookmarkedItem:close()
	f26_arg0.GametypeOnMapName:close()
	f26_arg0.GameModeTitle:close()
	f26_arg0.GameTypeImage:close()
	f26_arg0.DurationText:close()
end

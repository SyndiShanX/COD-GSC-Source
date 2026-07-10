require("x64:79fe6ac43673588")
CoD.FileshareSelectedItemPreview = InheritFrom(LUI.UIElement)
CoD.FileshareSelectedItemPreview.__defaultWidth = 500
CoD.FileshareSelectedItemPreview.__defaultHeight = 380
CoD.FileshareSelectedItemPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FileshareSelectedItemPreview)
	self.id = "FileshareSelectedItemPreview"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f1_arg0, f1_arg1, 0, 1, -1, 1, 0, 0, 0, 380)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local MapImage = LUI.UIImage.new(0.5, 0.5, -227.5, 232.5, 0, 0, 26, 307)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local GameTypeImage = LUI.UIImage.new(0, 0, 372, 480, 0, 0, 176, 284)
	GameTypeImage:setAlpha(0)
	self:addElement(GameTypeImage)
	self.GameTypeImage = GameTypeImage
	local Thumbnail = LUI.UIElement.new(0.5, 0.5, -227.5, 232.5, 0, 0, 26, 284)
	Thumbnail:linkToElementModel(self, "fileId", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Thumbnail:setupImageViewer(GetImageViewerParams("UI_SCREENSHOT_TYPE_THUMBNAIL", f2_local0))
		end
	end)
	self:addElement(Thumbnail)
	self.Thumbnail = Thumbnail
	local AuthorName = LUI.UIText.new(0.02, 0.99, 16, -16, 1, 1, -78, -42)
	AuthorName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	AuthorName:setTTF("ttmussels_regular")
	AuthorName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	AuthorName:setShaderVector(0, 0.04, 0, 0, 0)
	AuthorName:setShaderVector(1, 0.02, 0, 0, 0)
	AuthorName:setShaderVector(2, 1, 0, 0, 0)
	AuthorName:setLetterSpacing(3)
	AuthorName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AuthorName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	AuthorName:linkToElementModel(self, "fileAuthorName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AuthorName:setText(f3_local0)
		end
	end)
	self:addElement(AuthorName)
	self.AuthorName = AuthorName
	local CreateTime = LUI.UIText.new(0.02, 0.99, 17, -17, 1, 1, -42, -24)
	CreateTime:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	CreateTime:setTTF("dinnext_regular")
	CreateTime:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CreateTime:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CreateTime:linkToElementModel(self, "fileCreateTime", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CreateTime:setText(f4_local0)
		end
	end)
	self:addElement(CreateTime)
	self.CreateTime = CreateTime
	local GametypeOnMapName = LUI.UIText.new(-0, 1, 26, -14, 1, 1, -96, -78)
	GametypeOnMapName:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	GametypeOnMapName:setTTF("dinnext_regular")
	GametypeOnMapName:setLetterSpacing(2)
	GametypeOnMapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GametypeOnMapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	GametypeOnMapName:setBackingType(2)
	GametypeOnMapName:setBackingColor(0, 0, 0)
	GametypeOnMapName:setBackingAlpha(0.9)
	GametypeOnMapName:setBackingXPadding(4)
	GametypeOnMapName:setBackingYPadding(1)
	GametypeOnMapName:linkToElementModel(self, "fileDescription", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GametypeOnMapName:setText(f5_local0)
		end
	end)
	self:addElement(GametypeOnMapName)
	self.GametypeOnMapName = GametypeOnMapName
	local GameModeTitle = LUI.UIText.new(0.01, 0.99, 20, -20, 0, 0, 248, 284)
	GameModeTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GameModeTitle:setTTF("ttmussels_regular")
	GameModeTitle:setLetterSpacing(2)
	GameModeTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameModeTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	GameModeTitle:setBackingType(2)
	GameModeTitle:setBackingColor(0, 0, 0)
	GameModeTitle:setBackingAlpha(0.9)
	GameModeTitle:setBackingXPadding(4)
	GameModeTitle:setBackingYPadding(1)
	GameModeTitle:linkToElementModel(self, "fileName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			GameModeTitle:setText(f6_local0)
		end
	end)
	self:addElement(GameModeTitle)
	self.GameModeTitle = GameModeTitle
	local DurationText = LUI.UIText.new(0, 0, 384.5, 474.5, 0, 0, 34.5, 61.5)
	DurationText:setTTF("dinnext_regular")
	DurationText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	DurationText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	DurationText:setBackingType(2)
	DurationText:setBackingColor(0, 0, 0)
	DurationText:setBackingAlpha(0.9)
	DurationText:setBackingXPadding(2)
	DurationText:linkToElementModel(self, "duration", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			DurationText:setText(MillisecondsAsMinAndSeconds(f7_local0))
		end
	end)
	self:addElement(DurationText)
	self.DurationText = DurationText
	self.MapImage:linkToElementModel(self, "mapName", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			MapImage:setImage(RegisterImage(MapNameToMapImage(f8_local0)))
		end
	end)
	self.GameTypeImage:linkToElementModel(self, "gameTypeImage", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			GameTypeImage:setImage(RegisterImage(f9_local0))
		end
	end)
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
CoD.FileshareSelectedItemPreview.__resetProperties = function(f14_arg0)
	f14_arg0.Thumbnail:completeAnimation()
	f14_arg0.MapImage:completeAnimation()
	f14_arg0.GameTypeImage:completeAnimation()
	f14_arg0.DurationText:completeAnimation()
	f14_arg0.Thumbnail:setAlpha(1)
	f14_arg0.MapImage:setAlpha(1)
	f14_arg0.GameTypeImage:setAlpha(0)
	f14_arg0.DurationText:setAlpha(1)
end
CoD.FileshareSelectedItemPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.Thumbnail:completeAnimation()
			f15_arg0.Thumbnail:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.Thumbnail)
		end,
	},
	Film = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.MapImage:completeAnimation()
			f16_arg0.MapImage:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.MapImage)
			f16_arg0.GameTypeImage:completeAnimation()
			f16_arg0.GameTypeImage:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.GameTypeImage)
			f16_arg0.Thumbnail:completeAnimation()
			f16_arg0.Thumbnail:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Thumbnail)
		end,
	},
	Screenshot = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.MapImage:completeAnimation()
			f17_arg0.MapImage:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.MapImage)
			f17_arg0.GameTypeImage:completeAnimation()
			f17_arg0.GameTypeImage:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.GameTypeImage)
			f17_arg0.Thumbnail:completeAnimation()
			f17_arg0.Thumbnail:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Thumbnail)
			f17_arg0.DurationText:completeAnimation()
			f17_arg0.DurationText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.DurationText)
		end,
	},
	Clip = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.MapImage:completeAnimation()
			f18_arg0.MapImage:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.MapImage)
			f18_arg0.GameTypeImage:completeAnimation()
			f18_arg0.GameTypeImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.GameTypeImage)
			f18_arg0.Thumbnail:completeAnimation()
			f18_arg0.Thumbnail:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Thumbnail)
			f18_arg0.DurationText:completeAnimation()
			f18_arg0.DurationText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.DurationText)
		end,
	},
}
CoD.FileshareSelectedItemPreview.__onClose = function(f19_arg0)
	f19_arg0.TitleBG:close()
	f19_arg0.MapImage:close()
	f19_arg0.GameTypeImage:close()
	f19_arg0.Thumbnail:close()
	f19_arg0.AuthorName:close()
	f19_arg0.CreateTime:close()
	f19_arg0.GametypeOnMapName:close()
	f19_arg0.GameModeTitle:close()
	f19_arg0.DurationText:close()
end

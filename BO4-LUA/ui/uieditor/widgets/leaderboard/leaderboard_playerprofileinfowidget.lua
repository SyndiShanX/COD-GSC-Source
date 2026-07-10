require("x64:228a7baa572b047")
require("x64:a9255c570c68aa8")
CoD.Leaderboard_PlayerProfileInfoWidget = InheritFrom(LUI.UIElement)
CoD.Leaderboard_PlayerProfileInfoWidget.__defaultWidth = 360
CoD.Leaderboard_PlayerProfileInfoWidget.__defaultHeight = 490
CoD.Leaderboard_PlayerProfileInfoWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Leaderboard_PlayerProfileInfoWidget)
	self.id = "Leaderboard_PlayerProfileInfoWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TitleBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 36)
	TitleBacking:setRGB(0, 0, 0)
	TitleBacking:setAlpha(0.9)
	self:addElement(TitleBacking)
	self.TitleBacking = TitleBacking
	local Title = LUI.UIText.new(0, 1, 4, -4, 0, 0.08, 4, -4)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setTTF("notosans_regular")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Title:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local EmblemSpinner = LUI.UIImage.new(0, 0, 150.5, 209.5, 0, 0, 187.5, 246.5)
	EmblemSpinner:setupSpinner()
	self:addElement(EmblemSpinner)
	self.EmblemSpinner = EmblemSpinner
	local GamerCardSpinner = LUI.UIImage.new(0, 0, 150.5, 209.5, 0, 0, 416, 475)
	GamerCardSpinner:setupSpinner()
	self:addElement(GamerCardSpinner)
	self.GamerCardSpinner = GamerCardSpinner
	local CallingCardFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -89, 0)
	CallingCardFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CallingCardFrame:setAlpha(0.02)
	self:addElement(CallingCardFrame)
	self.CallingCardFrame = CallingCardFrame
	local EmblemFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 360, 0, 0, 37, 397)
	EmblemFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmblemFrame:setAlpha(0.02)
	self:addElement(EmblemFrame)
	self.EmblemFrame = EmblemFrame
	local emblem = LUI.UIImage.new(0, 1, 4, -4, 0.08, 0.81, 3, -5)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f3_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local GamerCard = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 1, 1.18, -85, -93)
	GamerCard:linkToElementModel(self, nil, false, function(model)
		GamerCard:setModel(model, f1_arg1)
	end)
	self:addElement(GamerCard)
	self.GamerCard = GamerCard
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 0, 360, 0, 0, 0, 37)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	GamerCard.id = "GamerCard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Leaderboard_PlayerProfileInfoWidget.__resetProperties = function(f5_arg0)
	f5_arg0.emblem:completeAnimation()
	f5_arg0.GamerCard:completeAnimation()
	f5_arg0.EmblemSpinner:completeAnimation()
	f5_arg0.GamerCardSpinner:completeAnimation()
	f5_arg0.emblem:setAlpha(1)
	f5_arg0.GamerCard:setAlpha(1)
	f5_arg0.EmblemSpinner:setAlpha(1)
	f5_arg0.GamerCardSpinner:setAlpha(1)
end
CoD.Leaderboard_PlayerProfileInfoWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.EmblemSpinner:completeAnimation()
			f6_arg0.EmblemSpinner:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.EmblemSpinner)
			f6_arg0.GamerCardSpinner:completeAnimation()
			f6_arg0.GamerCardSpinner:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GamerCardSpinner)
			f6_arg0.emblem:completeAnimation()
			f6_arg0.emblem:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.emblem)
			f6_arg0.GamerCard:completeAnimation()
			f6_arg0.GamerCard:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GamerCard)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.EmblemSpinner:completeAnimation()
			f7_arg0.EmblemSpinner:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.EmblemSpinner)
			f7_arg0.GamerCardSpinner:completeAnimation()
			f7_arg0.GamerCardSpinner:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GamerCardSpinner)
		end,
	},
	PCacheBuffer = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.emblem:completeAnimation()
			f8_arg0.emblem:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.emblem)
			f8_arg0.GamerCard:completeAnimation()
			f8_arg0.GamerCard:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GamerCard)
		end,
	},
}
CoD.Leaderboard_PlayerProfileInfoWidget.__onClose = function(f9_arg0)
	f9_arg0.Title:close()
	f9_arg0.CallingCardFrame:close()
	f9_arg0.EmblemFrame:close()
	f9_arg0.emblem:close()
	f9_arg0.GamerCard:close()
end

require("x64:19c1945d2e472b0")
CoD.AARSquadPlayer = InheritFrom(LUI.UIElement)
CoD.AARSquadPlayer.__defaultWidth = 470
CoD.AARSquadPlayer.__defaultHeight = 60
CoD.AARSquadPlayer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSquadPlayer)
	self.id = "AARSquadPlayer"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerNameBotStripe = LUI.UIImage.new(0.5, 0.5, -239.5, 239.5, 1, 1, -6, 5)
	PlayerNameBotStripe:setAlpha(0.5)
	PlayerNameBotStripe:setImage(RegisterImage(@"uie_ui_menu_mp_scoreboard_list_name_stripe"))
	self:addElement(PlayerNameBotStripe)
	self.PlayerNameBotStripe = PlayerNameBotStripe
	local GUIDE = LUI.UIImage.new(0, 0, 3, 48, 0, 0, 5, 50)
	GUIDE:setAlpha(0)
	self:addElement(GUIDE)
	self.GUIDE = GUIDE
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -235, 235, 0, 0, 0, 56)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(28, 28)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local StillAlive = LUI.UIText.new(0, 0, 60, 260, 0, 0, 38, 50)
	StillAlive:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	StillAlive:setAlpha(0)
	StillAlive:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C5CEA5C9CCDA5DD"))
	StillAlive:setTTF("ttmussels_regular")
	StillAlive:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StillAlive:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StillAlive)
	self.StillAlive = StillAlive
	local ClanAndGamerName = LUI.UIText.new(0, 0, 60, 453, 0, 0, 5, 33)
	ClanAndGamerName:setAlpha(0.8)
	ClanAndGamerName:setText("")
	ClanAndGamerName:setTTF("notosans_regular")
	ClanAndGamerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClanAndGamerName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(ClanAndGamerName)
	self.ClanAndGamerName = ClanAndGamerName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSquadPlayer.__resetProperties = function(f2_arg0)
	f2_arg0.ClanAndGamerName:completeAnimation()
	f2_arg0.PlayerNameBotStripe:completeAnimation()
	f2_arg0.StillAlive:completeAnimation()
	f2_arg0.ClanAndGamerName:setTopBottom(0, 0, 5, 33)
	f2_arg0.ClanAndGamerName:setRGB(1, 1, 1)
	f2_arg0.PlayerNameBotStripe:setRGB(1, 1, 1)
	f2_arg0.StillAlive:setAlpha(0)
end
CoD.AARSquadPlayer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.ClanAndGamerName:completeAnimation()
			f3_arg0.ClanAndGamerName:setTopBottom(0, 0, 15, 43)
			f3_arg0.clipFinished(f3_arg0.ClanAndGamerName)
		end,
	},
	Self = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.PlayerNameBotStripe:completeAnimation()
			f4_arg0.PlayerNameBotStripe:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.PlayerNameBotStripe)
			f4_arg0.ClanAndGamerName:completeAnimation()
			f4_arg0.ClanAndGamerName:setTopBottom(0, 0, 15, 43)
			f4_arg0.ClanAndGamerName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f4_arg0.clipFinished(f4_arg0.ClanAndGamerName)
		end,
	},
	StillAlive = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.StillAlive:completeAnimation()
			f5_arg0.StillAlive:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.StillAlive)
		end,
	},
}
CoD.AARSquadPlayer.__onClose = function(f6_arg0)
	f6_arg0.DotTiledBacking:close()
end

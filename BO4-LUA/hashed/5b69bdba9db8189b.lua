CoD.GameEndScore_TeamRanking = InheritFrom(LUI.UIElement)
CoD.GameEndScore_TeamRanking.__defaultWidth = 340
CoD.GameEndScore_TeamRanking.__defaultHeight = 204
CoD.GameEndScore_TeamRanking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_TeamRanking)
	self.id = "GameEndScore_TeamRanking"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 2, 337, 0.09, 0.09, -14.5, 184.5)
	NoiseTiledBacking:setAlpha(0.2)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local RankBg = LUI.UIImage.new(0, 0, 0, 340, 0, 0, 0, 204)
	RankBg:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_rank_bg"))
	self:addElement(RankBg)
	self.RankBg = RankBg
	local PlaceLabel = LUI.UIText.new(0, 0, 15, 319, 0, 0, 160.5, 190.5)
	PlaceLabel:setRGB(0.92, 0.92, 0.92)
	PlaceLabel:setAlpha(0)
	PlaceLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"ui/you_placed"))
	PlaceLabel:setTTF("ttmussels_regular")
	PlaceLabel:setLetterSpacing(6)
	PlaceLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlaceLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(PlaceLabel)
	self.PlaceLabel = PlaceLabel
	local TeamRank = LUI.UIText.new(0, 0, 14.5, 318.5, 0, 0, 27.5, 187.5)
	TeamRank:setRGB(0.92, 0.92, 0.92)
	TeamRank:setAlpha(0)
	TeamRank:setTTF("0arame_mono_stencil")
	TeamRank:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TeamRank:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	TeamRank:subscribeToGlobalModel(f1_arg1, "GameScore", "teamRanking", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamRank:setText(LocalizeStringWithParameter(@"ui/warzone_placement", f2_local0))
		end
	end)
	self:addElement(TeamRank)
	self.TeamRank = TeamRank
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_TeamRanking.__resetProperties = function(f3_arg0)
	f3_arg0.PlaceLabel:completeAnimation()
	f3_arg0.TeamRank:completeAnimation()
	f3_arg0.PlaceLabel:setAlpha(0)
	f3_arg0.PlaceLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"ui/you_placed"))
	f3_arg0.TeamRank:setAlpha(0)
end
CoD.GameEndScore_TeamRanking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.PlaceLabel:completeAnimation()
			f4_arg0.PlaceLabel:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.PlaceLabel)
			f4_arg0.TeamRank:completeAnimation()
			f4_arg0.TeamRank:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TeamRank)
		end,
	},
	Squad = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.PlaceLabel:completeAnimation()
			f5_arg0.PlaceLabel:setAlpha(0)
			f5_arg0.PlaceLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"ui/squad_placed"))
			f5_arg0.clipFinished(f5_arg0.PlaceLabel)
			f5_arg0.TeamRank:completeAnimation()
			f5_arg0.TeamRank:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TeamRank)
		end,
	},
}
CoD.GameEndScore_TeamRanking.__onClose = function(f6_arg0)
	f6_arg0.TeamRank:close()
end

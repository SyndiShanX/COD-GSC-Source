CoD.LeaderboardRow = InheritFrom(LUI.UIElement)
CoD.LeaderboardRow.__defaultWidth = 1170
CoD.LeaderboardRow.__defaultHeight = 36
CoD.LeaderboardRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaderboardRow)
	self.id = "LeaderboardRow"
	self.soundSet = "FrontendMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBox:setRGB(0, 0, 0)
	BlackBox:setAlpha(0.4)
	self:addElement(BlackBox)
	self.BlackBox = BlackBox
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.6)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local SelectorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectorOverlay:setAlpha(0.01)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local Position = LUI.UIText.new(0, 0, 8, 108, 0.5, 0.5, -9.5, 9.5)
	Position:setTTF("dinnext_regular")
	Position:setLetterSpacing(1)
	Position:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Position:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Position:linkToElementModel(self, "rowColor", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Position:setRGB(f2_local0)
		end
	end)
	Position:linkToElementModel(self, "positionUI", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Position:setText(f3_local0)
		end
	end)
	self:addElement(Position)
	self.Position = Position
	local Rank = LUI.UIText.new(0, 0, 115, 161, 0.5, 0.5, -9.5, 9.5)
	Rank:setTTF("0arame_mono_stencil")
	Rank:setLetterSpacing(1)
	Rank:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Rank:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Rank:linkToElementModel(self, "rank", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Rank:setText(f4_local0)
		end
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local RankIcon = LUI.UIImage.new(0, 0, 160.5, 190.5, 0.5, 0.5, -15, 15)
	RankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local Name = LUI.UIText.new(0, 0, 210.5, 465.5, 0.5, 0.5, -9.5, 9.5)
	Name:setTTF("notosans_regular")
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Name:linkToElementModel(self, "rowColor", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Name:setRGB(f6_local0)
		end
	end)
	Name:linkToElementModel(self, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Name:setText(CoD.SocialUtility.CleanGamerTag(f7_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Column0 = LUI.UIText.new(0, 0, 467, 597, 0.5, 0.5, -9.5, 9.5)
	Column0:setTTF("dinnext_regular")
	Column0:setLetterSpacing(1)
	Column0:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Column0:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Column0:linkToElementModel(self, "column0color", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Column0:setRGB(f8_local0)
		end
	end)
	Column0:linkToElementModel(self, "column0", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Column0:setText(f9_local0)
		end
	end)
	self:addElement(Column0)
	self.Column0 = Column0
	local Column1 = LUI.UIText.new(0, 0, 607, 737, 0.5, 0.5, -9.5, 9.5)
	Column1:setTTF("dinnext_regular")
	Column1:setLetterSpacing(1)
	Column1:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Column1:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Column1:linkToElementModel(self, "column1color", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Column1:setRGB(f10_local0)
		end
	end)
	Column1:linkToElementModel(self, "column1", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Column1:setText(f11_local0)
		end
	end)
	self:addElement(Column1)
	self.Column1 = Column1
	local Column2 = LUI.UIText.new(0, 0, 748, 878, 0.5, 0.5, -9.5, 9.5)
	Column2:setTTF("dinnext_regular")
	Column2:setLetterSpacing(1)
	Column2:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Column2:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Column2:linkToElementModel(self, "column2color", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Column2:setRGB(f12_local0)
		end
	end)
	Column2:linkToElementModel(self, "column2", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Column2:setText(f13_local0)
		end
	end)
	self:addElement(Column2)
	self.Column2 = Column2
	local Column3 = LUI.UIText.new(0, 0, 888, 1018, 0.5, 0.5, -9.5, 9.5)
	Column3:setTTF("dinnext_regular")
	Column3:setLetterSpacing(1)
	Column3:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Column3:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Column3:linkToElementModel(self, "column3color", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Column3:setRGB(f14_local0)
		end
	end)
	Column3:linkToElementModel(self, "column3", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			Column3:setText(f15_local0)
		end
	end)
	self:addElement(Column3)
	self.Column3 = Column3
	local Column4 = LUI.UIText.new(0, 0, 1028, 1158, 0.5, 0.5, -9.5, 9.5)
	Column4:setTTF("dinnext_regular")
	Column4:setLetterSpacing(1)
	Column4:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Column4:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Column4:linkToElementModel(self, "column4color", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			Column4:setRGB(f16_local0)
		end
	end)
	Column4:linkToElementModel(self, "column4", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			Column4:setText(f17_local0)
		end
	end)
	self:addElement(Column4)
	self.Column4 = Column4
	local FocusBorder = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(6, 6)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	self.Rank:linkToElementModel(self, "rankColor", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			Rank:setRGB(f18_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local14 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuLeaderboard(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaderboardRow.__resetProperties = function(f19_arg0)
	f19_arg0.SelectorOverlay:completeAnimation()
	f19_arg0.FocusBorder:completeAnimation()
	f19_arg0.SelectorOverlay:setAlpha(0.01)
	f19_arg0.FocusBorder:setAlpha(0)
end
CoD.LeaderboardRow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.SelectorOverlay:completeAnimation()
			f21_arg0.SelectorOverlay:setAlpha(0.04)
			f21_arg0.clipFinished(f21_arg0.SelectorOverlay)
			f21_arg0.FocusBorder:completeAnimation()
			f21_arg0.FocusBorder:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.FocusBorder)
		end,
		GainFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.SelectorOverlay:beginAnimation(200)
				f22_arg0.SelectorOverlay:setAlpha(0.04)
				f22_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.SelectorOverlay:completeAnimation()
			f22_arg0.SelectorOverlay:setAlpha(0.01)
			f22_local0(f22_arg0.SelectorOverlay)
			local f22_local1 = function(f24_arg0)
				f22_arg0.FocusBorder:beginAnimation(200)
				f22_arg0.FocusBorder:setAlpha(1)
				f22_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.FocusBorder:completeAnimation()
			f22_arg0.FocusBorder:setAlpha(0)
			f22_local1(f22_arg0.FocusBorder)
		end,
		LoseFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.SelectorOverlay:beginAnimation(200)
				f25_arg0.SelectorOverlay:setAlpha(0.01)
				f25_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.SelectorOverlay:completeAnimation()
			f25_arg0.SelectorOverlay:setAlpha(0.04)
			f25_local0(f25_arg0.SelectorOverlay)
			local f25_local1 = function(f27_arg0)
				f25_arg0.FocusBorder:beginAnimation(200)
				f25_arg0.FocusBorder:setAlpha(0)
				f25_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.FocusBorder:completeAnimation()
			f25_arg0.FocusBorder:setAlpha(1)
			f25_local1(f25_arg0.FocusBorder)
		end,
	},
}
CoD.LeaderboardRow.__onClose = function(f28_arg0)
	f28_arg0.Position:close()
	f28_arg0.Rank:close()
	f28_arg0.RankIcon:close()
	f28_arg0.Name:close()
	f28_arg0.Column0:close()
	f28_arg0.Column1:close()
	f28_arg0.Column2:close()
	f28_arg0.Column3:close()
	f28_arg0.Column4:close()
end

require("x64:1ef3663f11c21fa")
CoD.Rush_Gameover_Score_Entry = InheritFrom(LUI.UIElement)
CoD.Rush_Gameover_Score_Entry.__defaultWidth = 1000
CoD.Rush_Gameover_Score_Entry.__defaultHeight = 88
CoD.Rush_Gameover_Score_Entry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Rush_Gameover_Score_Entry)
	self.id = "Rush_Gameover_Score_Entry"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, 900, 941, 0, 0, 24, 65)
	Image:setRGB(0, 0, 0)
	Image:setZRot(45)
	self:addElement(Image)
	self.Image = Image
	local blackBg = LUI.UIImage.new(0, 0, 309.5, 920.5, 0, 0, 15.5, 73.5)
	blackBg:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	self:addElement(blackBg)
	self.blackBg = blackBg
	local teamPlayercard = LUI.UIImage.new(0, 0, 198, 426, 0, 0, 0, 88)
	teamPlayercard:setImage(RegisterImage(@"hash_357737C6CB8A7315"))
	self:addElement(teamPlayercard)
	self.teamPlayercard = teamPlayercard
	local teamPlayercardGold = LUI.UIImage.new(0, 0, 201, 426, 0, 0, 2, 84)
	teamPlayercardGold:setAlpha(0)
	teamPlayercardGold:setZRot(180)
	teamPlayercardGold:setImage(RegisterImage(0xF9B1B03667EE62))
	self:addElement(teamPlayercardGold)
	self.teamPlayercardGold = teamPlayercardGold
	local ZombiesPortrait = CoD.ZombiesPortrait.new(f1_arg0, f1_arg1, 0, 0, 201, 281, 0, 0, 3, 83)
	ZombiesPortrait:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2D79DB5C45AD6024"))
	ZombiesPortrait:setShaderVector(0, 34, 6, 0, 0)
	ZombiesPortrait:setShaderVector(1, 80, 80, 0, 0)
	ZombiesPortrait:setShaderVector(2, 0, 0.05, 0, 0)
	ZombiesPortrait.Portrait:setShaderVector(0, 0.4, 0, 0, 0)
	ZombiesPortrait:linkToElementModel(self, "zombiePlayerIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ZombiesPortrait.Portrait:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ZombiesPortrait)
	self.ZombiesPortrait = ZombiesPortrait
	local GamerTagShadow = LUI.UIText.new(0, 0, 54, 191, 0, 0, 53.5, 74.5)
	GamerTagShadow:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	GamerTagShadow:setTTF("notosans_regular")
	GamerTagShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GamerTagShadow:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	GamerTagShadow:linkToElementModel(self, "playerName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GamerTagShadow:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end)
	self:addElement(GamerTagShadow)
	self.GamerTagShadow = GamerTagShadow
	local GamerTag = LUI.UIText.new(0, 0, 54, 191, 0, 0, 53.5, 74.5)
	GamerTag:setTTF("notosans_regular")
	GamerTag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GamerTag:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	GamerTag:linkToElementModel(self, "clientNum", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GamerTag:setRGB(ZombieClientScoreboardColor(f4_local0))
		end
	end)
	GamerTag:linkToElementModel(self, "playerName", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GamerTag:setText(CoD.SocialUtility.CleanGamerTag(f5_local0))
		end
	end)
	self:addElement(GamerTag)
	self.GamerTag = GamerTag
	local Col1 = LUI.UIText.new(0, 0, 287, 423, 0, 0, 27, 71)
	Col1:setTTF("skorzhen")
	Col1:setLetterSpacing(0.5)
	Col1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Col1:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Col1:linkToElementModel(self, "clientNum", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Col1:setRGB(ZombieClientScoreboardColor(f6_local0))
		end
	end)
	Col1:linkToElementModel(self, "col1", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Col1:setText(CoD.TextUtility.FormatNumberWithDelimiters(f7_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(Col1, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 0)
	end)
	self:addElement(Col1)
	self.Col1 = Col1
	local Col2 = LUI.UIText.new(0, 0, 440, 521, 0, 0, 33.5, 58.5)
	Col2:setTTF("skorzhen")
	Col2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Col2:linkToElementModel(self, "clientNum", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Col2:setRGB(ZombieClientScoreboardColor(f9_local0))
		end
	end)
	Col2:linkToElementModel(self, "col2", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Col2:setText(f10_local0)
		end
	end)
	self:addElement(Col2)
	self.Col2 = Col2
	local Col3 = LUI.UIText.new(0, 0, 542, 667, 0, 0, 33.5, 58.5)
	Col3:setTTF("skorzhen")
	Col3:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Col3:linkToElementModel(self, "clientNum", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Col3:setRGB(ZombieClientScoreboardColor(f11_local0))
		end
	end)
	Col3:linkToElementModel(self, "col3", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Col3:setText(f12_local0)
		end
	end)
	self:addElement(Col3)
	self.Col3 = Col3
	local Col4 = LUI.UIText.new(0, 0, 684, 809, 0, 0, 33.5, 58.5)
	Col4:setTTF("skorzhen")
	Col4:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Col4:linkToElementModel(self, "clientNum", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Col4:setRGB(ZombieClientScoreboardColor(f13_local0))
		end
	end)
	Col4:linkToElementModel(self, "col4", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Col4:setText(CoD.ZombieUtility.GetZombieScoreboardColumnRushMultiplierTreatment(f1_arg1, f14_local0))
		end
	end)
	self:addElement(Col4)
	self.Col4 = Col4
	local Col5 = LUI.UIText.new(0, 0, 822, 947, 0, 0, 33.5, 58.5)
	Col5:setTTF("skorzhen")
	Col5:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Col5:linkToElementModel(self, "clientNum", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			Col5:setRGB(ZombieClientScoreboardColor(f15_local0))
		end
	end)
	Col5:linkToElementModel(self, "col5", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			Col5:setText(f16_local0)
		end
	end)
	self:addElement(Col5)
	self.Col5 = Col5
	local PositionShadow = LUI.UIText.new(0, 0, 57, 178, 0, 0, 20.5, 59.5)
	PositionShadow:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	PositionShadow:setAlpha(0.5)
	PositionShadow:setTTF("default")
	PositionShadow:setLetterSpacing(2)
	PositionShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PositionShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PositionShadow:linkToElementModel(self, "position", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			PositionShadow:setText(CoD.ZombieUtility.GetStringPositionForIndex(f17_local0))
		end
	end)
	self:addElement(PositionShadow)
	self.PositionShadow = PositionShadow
	local Position = LUI.UIText.new(0, 0, 54, 175, 0, 0, 16.5, 55.5)
	Position:setTTF("default")
	Position:setLetterSpacing(2)
	Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Position:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Position:linkToElementModel(self, "position", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			Position:setText(CoD.ZombieUtility.GetStringPositionForIndex(f18_local0))
		end
	end)
	self:addElement(Position)
	self.Position = Position
	local FrameEnd = LUI.UIImage.new(0, 0, 863.5, 969.5, 0.5, 0.5, -46.5, 46.5)
	FrameEnd:setImage(RegisterImage(@"uie_zm_hud_scoreboard_frame_end"))
	self:addElement(FrameEnd)
	self.FrameEnd = FrameEnd
	self:mergeStateConditions({
		{
			stateName = "IsSelf",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsClientnumFromElementEqualToOurs(f1_arg1, element)
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Rush_Gameover_Score_Entry.__resetProperties = function(f21_arg0)
	f21_arg0.teamPlayercardGold:completeAnimation()
	f21_arg0.Col1:completeAnimation()
	f21_arg0.teamPlayercard:completeAnimation()
	f21_arg0.blackBg:completeAnimation()
	f21_arg0.teamPlayercardGold:setLeftRight(0, 0, 201, 426)
	f21_arg0.teamPlayercardGold:setTopBottom(0, 0, 2, 84)
	f21_arg0.teamPlayercardGold:setAlpha(0)
	f21_arg0.Col1:setLeftRight(0, 0, 287, 423)
	f21_arg0.Col1:setTopBottom(0, 0, 27, 71)
	f21_arg0.Col1:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	f21_arg0.teamPlayercard:setAlpha(1)
	f21_arg0.blackBg:setLeftRight(0, 0, 309.5, 920.5)
	f21_arg0.blackBg:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
end
CoD.Rush_Gameover_Score_Entry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.teamPlayercardGold:completeAnimation()
			f22_arg0.teamPlayercardGold:setLeftRight(0, 0, 201, 431)
			f22_arg0.teamPlayercardGold:setTopBottom(0, 0, 1, 86)
			f22_arg0.teamPlayercardGold:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.teamPlayercardGold)
			f22_arg0.Col1:completeAnimation()
			f22_arg0.Col1:setLeftRight(0, 0, 287, 418)
			f22_arg0.Col1:setTopBottom(0, 0, 23.5, 67.5)
			f22_arg0.clipFinished(f22_arg0.Col1)
		end,
	},
	IsSelf = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.blackBg:completeAnimation()
			f23_arg0.blackBg:setLeftRight(0, 0, 281.5, 920.5)
			f23_arg0.blackBg:setRGB(0, 0, 0)
			f23_arg0.clipFinished(f23_arg0.blackBg)
			f23_arg0.teamPlayercard:completeAnimation()
			f23_arg0.teamPlayercard:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.teamPlayercard)
			f23_arg0.teamPlayercardGold:completeAnimation()
			f23_arg0.teamPlayercardGold:setLeftRight(0, 0, 201, 426)
			f23_arg0.teamPlayercardGold:setTopBottom(0, 0, 2, 84)
			f23_arg0.teamPlayercardGold:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.teamPlayercardGold)
			f23_arg0.Col1:completeAnimation()
			f23_arg0.Col1:setLeftRight(0, 0, 290, 426)
			f23_arg0.Col1:setTopBottom(0, 0, 29.5, 73.5)
			f23_arg0.clipFinished(f23_arg0.Col1)
		end,
	},
}
CoD.Rush_Gameover_Score_Entry.__onClose = function(f24_arg0)
	f24_arg0.ZombiesPortrait:close()
	f24_arg0.GamerTagShadow:close()
	f24_arg0.GamerTag:close()
	f24_arg0.Col1:close()
	f24_arg0.Col2:close()
	f24_arg0.Col3:close()
	f24_arg0.Col4:close()
	f24_arg0.Col5:close()
	f24_arg0.PositionShadow:close()
	f24_arg0.Position:close()
end

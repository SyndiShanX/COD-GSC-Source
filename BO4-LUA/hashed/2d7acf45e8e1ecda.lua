CoD.PositionDraft_SearchingForPlayers = InheritFrom(LUI.UIElement)
CoD.PositionDraft_SearchingForPlayers.__defaultWidth = 326
CoD.PositionDraft_SearchingForPlayers.__defaultHeight = 37
CoD.PositionDraft_SearchingForPlayers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_SearchingForPlayers)
	self.id = "PositionDraft_SearchingForPlayers"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.21, 0.2, 0.2)
	Background:setAlpha(0.8)
	self:addElement(Background)
	self.Background = Background
	local BackgroundAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundAdd:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	BackgroundAdd:setAlpha(0.1)
	BackgroundAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x92F09074FB20E6D))
	BackgroundAdd:setShaderVector(0, 0.31, 0, 0, 0)
	BackgroundAdd:setShaderVector(1, 0.84, 0, 0, 0)
	BackgroundAdd:setShaderVector(2, 0.05, 0, 0, 0)
	self:addElement(BackgroundAdd)
	self.BackgroundAdd = BackgroundAdd
	local PositionDraftSearchingForPlayers = LUI.UIText.new(0.02, 0.97, 0, 0, 0.16, 0.86, 0, 0)
	PositionDraftSearchingForPlayers:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PositionDraftSearchingForPlayers:setText(Engine[0xF9F1239CFD921FE](0xB0DCC02393CEC4E))
	PositionDraftSearchingForPlayers:setTTF("ttmussels_regular")
	PositionDraftSearchingForPlayers:setLetterSpacing(4)
	PositionDraftSearchingForPlayers:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(PositionDraftSearchingForPlayers)
	self.PositionDraftSearchingForPlayers = PositionDraftSearchingForPlayers
	local barTop = LUI.UIImage.new(0, 1, 24, 0, 0, 0, -7, 0)
	barTop:setRGB(0.28, 0.27, 0.27)
	self:addElement(barTop)
	self.barTop = barTop
	local barTop3 = LUI.UIImage.new(0, 0, 0, 24, 0, 0, -7, 0)
	barTop3:setRGB(0.16, 0.15, 0.15)
	self:addElement(barTop3)
	self.barTop3 = barTop3
	local LineTop01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 36, 37)
	LineTop01:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LineTop01:setAlpha(0.5)
	self:addElement(LineTop01)
	self.LineTop01 = LineTop01
	local Corner01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 24, 25)
	Corner01:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner01:setAlpha(0.5)
	self:addElement(Corner01)
	self.Corner01 = Corner01
	local Corner = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 25, 26)
	Corner:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner:setAlpha(0.5)
	self:addElement(Corner)
	self.Corner = Corner
	local Corner2 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 30, 36)
	Corner2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner2:setAlpha(0.5)
	self:addElement(Corner2)
	self.Corner2 = Corner2
	local Corner3 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 30, 36)
	Corner3:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner3:setAlpha(0.5)
	self:addElement(Corner3)
	self.Corner3 = Corner3
	local arrow = LUI.UIImage.new(0, 0, 9.5, 14.5, 0, 0, -6, -1)
	arrow:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	arrow:setImage(RegisterImage(0x19A57A2805CEECA))
	self:addElement(arrow)
	self.arrow = arrow
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueEqualTo("PositionDraft.waitingForPlayers", 0)
			end,
		},
	})
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[0x8DF2E5447F384B9]()
	f1_local13(f1_local12, f1_local14["PositionDraft.waitingForPlayers"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "PositionDraft.waitingForPlayers",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_SearchingForPlayers.__resetProperties = function(f4_arg0)
	f4_arg0.PositionDraftSearchingForPlayers:completeAnimation()
	f4_arg0.arrow:completeAnimation()
	f4_arg0.Corner3:completeAnimation()
	f4_arg0.Corner2:completeAnimation()
	f4_arg0.Corner:completeAnimation()
	f4_arg0.Corner01:completeAnimation()
	f4_arg0.LineTop01:completeAnimation()
	f4_arg0.barTop3:completeAnimation()
	f4_arg0.barTop:completeAnimation()
	f4_arg0.BackgroundAdd:completeAnimation()
	f4_arg0.Background:completeAnimation()
	f4_arg0.PositionDraftSearchingForPlayers:setAlpha(1)
	f4_arg0.arrow:setAlpha(1)
	f4_arg0.Corner3:setAlpha(0.5)
	f4_arg0.Corner2:setAlpha(0.5)
	f4_arg0.Corner:setAlpha(0.5)
	f4_arg0.Corner01:setAlpha(0.5)
	f4_arg0.LineTop01:setAlpha(0.5)
	f4_arg0.barTop3:setAlpha(1)
	f4_arg0.barTop:setAlpha(1)
	f4_arg0.BackgroundAdd:setAlpha(0.1)
	f4_arg0.Background:setAlpha(0.8)
end
CoD.PositionDraft_SearchingForPlayers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(11)
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Background)
			f5_arg0.BackgroundAdd:completeAnimation()
			f5_arg0.BackgroundAdd:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.BackgroundAdd)
			f5_arg0.PositionDraftSearchingForPlayers:completeAnimation()
			f5_arg0.PositionDraftSearchingForPlayers:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PositionDraftSearchingForPlayers)
			f5_arg0.barTop:completeAnimation()
			f5_arg0.barTop:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.barTop)
			f5_arg0.barTop3:completeAnimation()
			f5_arg0.barTop3:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.barTop3)
			f5_arg0.LineTop01:completeAnimation()
			f5_arg0.LineTop01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.LineTop01)
			f5_arg0.Corner01:completeAnimation()
			f5_arg0.Corner01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Corner01)
			f5_arg0.Corner:completeAnimation()
			f5_arg0.Corner:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Corner)
			f5_arg0.Corner2:completeAnimation()
			f5_arg0.Corner2:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Corner2)
			f5_arg0.Corner3:completeAnimation()
			f5_arg0.Corner3:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Corner3)
			f5_arg0.arrow:completeAnimation()
			f5_arg0.arrow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.arrow)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(9)
			f6_arg0.PositionDraftSearchingForPlayers:completeAnimation()
			f6_arg0.PositionDraftSearchingForPlayers:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PositionDraftSearchingForPlayers)
			f6_arg0.barTop:completeAnimation()
			f6_arg0.barTop:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.barTop)
			f6_arg0.barTop3:completeAnimation()
			f6_arg0.barTop3:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.barTop3)
			f6_arg0.LineTop01:completeAnimation()
			f6_arg0.LineTop01:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.LineTop01)
			f6_arg0.Corner01:completeAnimation()
			f6_arg0.Corner01:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.Corner01)
			f6_arg0.Corner:completeAnimation()
			f6_arg0.Corner:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.Corner)
			f6_arg0.Corner2:completeAnimation()
			f6_arg0.Corner2:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.Corner2)
			f6_arg0.Corner3:completeAnimation()
			f6_arg0.Corner3:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.Corner3)
			f6_arg0.arrow:completeAnimation()
			f6_arg0.arrow:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.arrow)
		end,
	},
}

CoD.PCSocialMenu_PlayerListItem_Empty = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayerListItem_Empty.__defaultWidth = 460
CoD.PCSocialMenu_PlayerListItem_Empty.__defaultHeight = 85
CoD.PCSocialMenu_PlayerListItem_Empty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayerListItem_Empty)
	self.id = "PCSocialMenu_PlayerListItem_Empty"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local teamColoredBG = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	teamColoredBG:setRGB(0.13, 0.12, 0.12)
	self:addElement(teamColoredBG)
	self.teamColoredBG = teamColoredBG
	local bg = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 2, -2)
	bg:setRGB(0.15, 0.15, 0.15)
	bg:setAlpha(0)
	self:addElement(bg)
	self.bg = bg
	local EmptyText = LUI.UIText.new(0, 0, 24, 224, 0, 0, 30, 52)
	EmptyText:setRGB(0.33, 0.3, 0.25)
	EmptyText:setAlpha(0.9)
	EmptyText:setText(Engine[0xF9F1239CFD921FE](0x6ADB318F8178FC))
	EmptyText:setTTF("ttmussels_regular")
	EmptyText:setLetterSpacing(10)
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(EmptyText)
	self.EmptyText = EmptyText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_PlayerListItem_Empty.__resetProperties = function(f2_arg0)
	f2_arg0.bg:completeAnimation()
	f2_arg0.teamColoredBG:completeAnimation()
	f2_arg0.EmptyText:completeAnimation()
	f2_arg0.bg:setAlpha(0)
	f2_arg0.teamColoredBG:setRGB(0.13, 0.12, 0.12)
	f2_arg0.teamColoredBG:setAlpha(1)
	f2_arg0.EmptyText:setAlpha(0.9)
end
CoD.PCSocialMenu_PlayerListItem_Empty.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.teamColoredBG:completeAnimation()
			f3_arg0.teamColoredBG:setRGB(0.13, 0.12, 0.12)
			f3_arg0.teamColoredBG:setAlpha(0.9)
			f3_arg0.clipFinished(f3_arg0.teamColoredBG)
			f3_arg0.bg:completeAnimation()
			f3_arg0.bg:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.bg)
			f3_arg0.EmptyText:completeAnimation()
			f3_arg0.EmptyText:setAlpha(0.5)
			f3_arg0.clipFinished(f3_arg0.EmptyText)
		end,
	},
}

CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty.__defaultWidth = 80
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty.__defaultHeight = 30
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty)
	self.id = "PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.98, 1, 0)
	Border:setImage(RegisterImage(0xF1E3082B39E99BB))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(12, 12)
	self:addElement(Border)
	self.Border = Border
	local TextBox = LUI.UIText.new(0, 0, 5, 78, 0, 0, 5, 23)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x7581D6816D39A58))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setRGB(1, 1, 1)
end
CoD.PCSocialMenu_PlayerListItem_PlayerInfos_AcceptInviteToParty.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TextBox:completeAnimation()
			f4_arg0.TextBox:setRGB(1, 0.92, 0)
			f4_arg0.clipFinished(f4_arg0.TextBox)
		end,
	},
}

CoD.PC_Battlenet_AddFriend_Information_Description = InheritFrom(LUI.UIElement)
CoD.PC_Battlenet_AddFriend_Information_Description.__defaultWidth = 330
CoD.PC_Battlenet_AddFriend_Information_Description.__defaultHeight = 110
CoD.PC_Battlenet_AddFriend_Information_Description.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Battlenet_AddFriend_Information_Description)
	self.id = "PC_Battlenet_AddFriend_Information_Description"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BorderInfobox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BorderInfobox:setImage(RegisterImage(@"hash_431AC999EEEB3C99"))
	BorderInfobox:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	BorderInfobox:setShaderVector(0, 0, 0, 0, 0)
	BorderInfobox:setupNineSliceShader(6, 6)
	self:addElement(BorderInfobox)
	self.BorderInfobox = BorderInfobox
	local TextureInfobox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextureInfobox:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	TextureInfobox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TextureInfobox:setShaderVector(0, 0, 0, 0, 0)
	TextureInfobox:setupNineSliceShader(64, 64)
	self:addElement(TextureInfobox)
	self.TextureInfobox = TextureInfobox
	local InformationDescriptionText = LUI.UIText.new(0.5, 0.5, -157, 157, 0.5, 0.5, -7.5, 7.5)
	InformationDescriptionText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E3C597D83BC0CFA"))
	InformationDescriptionText:setTTF("ttmussels_regular")
	InformationDescriptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	InformationDescriptionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(InformationDescriptionText)
	self.InformationDescriptionText = InformationDescriptionText
	self:mergeStateConditions({
		{
			stateName = "DefaultState_Loc",
			condition = function(menu, element, event)
				return IsCurrentLanguageKoreanOrTraditionalChinese()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Battlenet_AddFriend_Information_Description.__resetProperties = function(f3_arg0)
	f3_arg0.InformationDescriptionText:completeAnimation()
	f3_arg0.InformationDescriptionText:setTopBottom(0.5, 0.5, -7.5, 7.5)
end
CoD.PC_Battlenet_AddFriend_Information_Description.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultState_Loc = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.InformationDescriptionText:completeAnimation()
			f5_arg0.InformationDescriptionText:setTopBottom(0.5, 0.5, -6, 6)
			f5_arg0.clipFinished(f5_arg0.InformationDescriptionText)
		end,
	},
}

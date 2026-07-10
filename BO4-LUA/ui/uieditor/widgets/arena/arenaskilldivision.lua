CoD.ArenaSkillDivision = InheritFrom(LUI.UIElement)
CoD.ArenaSkillDivision.__defaultWidth = 411
CoD.ArenaSkillDivision.__defaultHeight = 94
CoD.ArenaSkillDivision.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaSkillDivision)
	self.id = "ArenaSkillDivision"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SkillBadge = LUI.UIImage.new(0, 0, 7, 89, 0.5, 0.5, -41, 41)
	self:addElement(SkillBadge)
	self.SkillBadge = SkillBadge
	local Title = LUI.UIText.new(0, 0, 103, 403, 0, 0, 20, 53)
	Title:setText(LocalizeToUpperString(0x93E719493E9E18F))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0, 0, 103, 403, 0, 0, 53, 73)
	Description:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Description:setTTF("ttmussels_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	self:mergeStateConditions({
		{
			stateName = "NoSkillBadge",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaSkillDivision.__resetProperties = function(f3_arg0)
	f3_arg0.SkillBadge:completeAnimation()
	f3_arg0.SkillBadge:setAlpha(1)
end
CoD.ArenaSkillDivision.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	NoSkillBadge = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.SkillBadge:completeAnimation()
			f5_arg0.SkillBadge:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.SkillBadge)
		end,
	},
}

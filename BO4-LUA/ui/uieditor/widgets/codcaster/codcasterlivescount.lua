CoD.CodCasterLivesCount = InheritFrom(LUI.UIElement)
CoD.CodCasterLivesCount.__defaultWidth = 100
CoD.CodCasterLivesCount.__defaultHeight = 18
CoD.CodCasterLivesCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLivesCount)
	self.id = "CodCasterLivesCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local teamLivesCount = LUI.UIText.new(0.03, 0.03, -3, 97, 0.52, 0.52, -9.5, 8.5)
	teamLivesCount:setText(99)
	teamLivesCount:setTTF("ttmussels_demibold")
	teamLivesCount:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	teamLivesCount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(teamLivesCount)
	self.teamLivesCount = teamLivesCount
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLivesCount.__resetProperties = function(f3_arg0)
	f3_arg0.teamLivesCount:completeAnimation()
	f3_arg0.teamLivesCount:setTopBottom(0.52, 0.52, -9.5, 8.5)
	f3_arg0.teamLivesCount:setRGB(1, 1, 1)
	f3_arg0.teamLivesCount:setAlpha(1)
end
CoD.CodCasterLivesCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.teamLivesCount:completeAnimation()
			f4_arg0.teamLivesCount:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.teamLivesCount)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.teamLivesCount:completeAnimation()
			f5_arg0.teamLivesCount:setTopBottom(0.52, 0.52, -4, 9)
			f5_arg0.teamLivesCount:setRGB(1, 1, 1)
			f5_arg0.teamLivesCount:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.teamLivesCount)
		end,
	},
}

CoD.CodCasterLivesCount2 = InheritFrom(LUI.UIElement)
CoD.CodCasterLivesCount2.__defaultWidth = 100
CoD.CodCasterLivesCount2.__defaultHeight = 18
CoD.CodCasterLivesCount2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLivesCount2)
	self.id = "CodCasterLivesCount2"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local teamLivesCount = LUI.UIText.new(0.66, 0.66, -64, 36, 0.08, 0.08, -1.5, 16.5)
	teamLivesCount:setText(99)
	teamLivesCount:setTTF("ttmussels_demibold")
	teamLivesCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	teamLivesCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
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
CoD.CodCasterLivesCount2.__resetProperties = function(f3_arg0)
	f3_arg0.teamLivesCount:completeAnimation()
	f3_arg0.teamLivesCount:setTopBottom(0.08, 0.08, -1.5, 16.5)
	f3_arg0.teamLivesCount:setRGB(1, 1, 1)
end
CoD.CodCasterLivesCount2.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.teamLivesCount:completeAnimation()
			f4_arg0.teamLivesCount:setRGB(1, 1, 1)
			f4_arg0.clipFinished(f4_arg0.teamLivesCount)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.teamLivesCount:completeAnimation()
			f5_arg0.teamLivesCount:setTopBottom(0.08, 0.08, 5.5, 17.5)
			f5_arg0.teamLivesCount:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.teamLivesCount)
		end,
	},
}

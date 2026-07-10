CoD.ZMAARTrialTabRoundStatDescription = InheritFrom(LUI.UIElement)
CoD.ZMAARTrialTabRoundStatDescription.__defaultWidth = 337
CoD.ZMAARTrialTabRoundStatDescription.__defaultHeight = 18
CoD.ZMAARTrialTabRoundStatDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTrialTabRoundStatDescription)
	self.id = "ZMAARTrialTabRoundStatDescription"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Desc = LUI.UIText.new(0, 0, 0, 337, 1, 1, -16, -2)
	Desc:setRGB(0.92, 0.92, 0.92)
	Desc:setText(Engine[0xF9F1239CFD921FE](0xF762115B6FAF2DB))
	Desc:setTTF("skorzhen")
	Desc:setLineSpacing(1)
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Desc)
	self.Desc = Desc
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
CoD.ZMAARTrialTabRoundStatDescription.__resetProperties = function(f3_arg0)
	f3_arg0.Desc:completeAnimation()
	f3_arg0.Desc:setTopBottom(1, 1, -16, -2)
	f3_arg0.Desc:setLetterSpacing(0)
end
CoD.ZMAARTrialTabRoundStatDescription.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Desc:completeAnimation()
			f5_arg0.Desc:setTopBottom(1, 1, -10, 0)
			f5_arg0.Desc:setLetterSpacing(1)
			f5_arg0.clipFinished(f5_arg0.Desc)
		end,
	},
}

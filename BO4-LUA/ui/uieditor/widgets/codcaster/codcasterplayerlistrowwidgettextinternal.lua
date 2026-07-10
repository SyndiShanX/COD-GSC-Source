CoD.CodCasterPlayerListRowWidgetTextInternal = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerListRowWidgetTextInternal.__defaultWidth = 165
CoD.CodCasterPlayerListRowWidgetTextInternal.__defaultHeight = 15
CoD.CodCasterPlayerListRowWidgetTextInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPlayerListRowWidgetTextInternal)
	self.id = "CodCasterPlayerListRowWidgetTextInternal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Gamertag = LUI.UIText.new(0, 0, 0, 165, 0.5, 0.5, -7.5, 7.5)
	Gamertag:setText(Engine[0xF9F1239CFD921FE](0xA67CAA5982ED86C))
	Gamertag:setTTF("notosans_regular")
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
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
CoD.CodCasterPlayerListRowWidgetTextInternal.__resetProperties = function(f3_arg0)
	f3_arg0.Gamertag:completeAnimation()
	f3_arg0.Gamertag:setTopBottom(0.5, 0.5, -7.5, 7.5)
end
CoD.CodCasterPlayerListRowWidgetTextInternal.__clipsPerState = {
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
			f5_arg0.Gamertag:completeAnimation()
			f5_arg0.Gamertag:setTopBottom(0.5, 0.5, -2.5, 7.5)
			f5_arg0.clipFinished(f5_arg0.Gamertag)
		end,
	},
}

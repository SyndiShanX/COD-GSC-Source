CoD.SpecialistExtraItemsSpacerEntry = InheritFrom(LUI.UIElement)
CoD.SpecialistExtraItemsSpacerEntry.__defaultWidth = 180
CoD.SpecialistExtraItemsSpacerEntry.__defaultHeight = 69
CoD.SpecialistExtraItemsSpacerEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistExtraItemsSpacerEntry)
	self.id = "SpecialistExtraItemsSpacerEntry"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -4, 4)
	backing:setRGB(0.2, 0.2, 0.2)
	backing:setAlpha(0.6)
	self:addElement(backing)
	self.backing = backing
	local TextBox = LUI.UIText.new(0, 0, 4, 175, 0, 0, 3, 25)
	TextBox:setAlpha(0.74)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x843D640BA217F60))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "FirstHeader",
			condition = function(menu, element, event)
				return PropertyIsTrue(self, "firstExtraItemHeader")
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistExtraItemsSpacerEntry.__resetProperties = function(f3_arg0)
	f3_arg0.TextBox:completeAnimation()
	f3_arg0.TextBox:setAlpha(0.74)
end
CoD.SpecialistExtraItemsSpacerEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TextBox:completeAnimation()
			f4_arg0.TextBox:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TextBox)
		end,
	},
	FirstHeader = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}

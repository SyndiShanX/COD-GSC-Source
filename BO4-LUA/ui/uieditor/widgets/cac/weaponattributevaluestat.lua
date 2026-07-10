CoD.WeaponAttributeValueStat = InheritFrom(LUI.UIElement)
CoD.WeaponAttributeValueStat.__defaultWidth = 100
CoD.WeaponAttributeValueStat.__defaultHeight = 18
CoD.WeaponAttributeValueStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 3, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.WeaponAttributeValueStat)
	self.id = "WeaponAttributeValueStat"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AttributeBaseValue = LUI.UIText.new(0, 0, 0, 32, 0, 1, 0, 0)
	AttributeBaseValue:setText("")
	AttributeBaseValue:setTTF("ttmussels_demibold")
	AttributeBaseValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(AttributeBaseValue)
	self.AttributeBaseValue = AttributeBaseValue
	local AttributeAddedValue = LUI.UIText.new(0, 0, 35, 67, 0, 0, 0, 18)
	AttributeAddedValue:setRGB(0, 1, 0)
	AttributeAddedValue:setText("")
	AttributeAddedValue:setTTF("ttmussels_demibold")
	AttributeAddedValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(AttributeAddedValue)
	self.AttributeAddedValue = AttributeAddedValue
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponAttributeValueStat.__resetProperties = function(f2_arg0)
	f2_arg0.AttributeAddedValue:completeAnimation()
	f2_arg0.AttributeAddedValue:setRGB(0, 1, 0)
end
CoD.WeaponAttributeValueStat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.AttributeAddedValue:completeAnimation()
			f3_arg0.AttributeAddedValue:setRGB(1, 0, 0)
			f3_arg0.clipFinished(f3_arg0.AttributeAddedValue)
		end,
	},
	PositiveAddValue = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.AttributeAddedValue:completeAnimation()
			f4_arg0.AttributeAddedValue:setRGB(0, 1, 0)
			f4_arg0.clipFinished(f4_arg0.AttributeAddedValue)
		end,
	},
}

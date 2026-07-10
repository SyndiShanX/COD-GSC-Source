CoD.WeaponSelectGridItemInternalName = InheritFrom(LUI.UIElement)
CoD.WeaponSelectGridItemInternalName.__defaultWidth = 260
CoD.WeaponSelectGridItemInternalName.__defaultHeight = 18
CoD.WeaponSelectGridItemInternalName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponSelectGridItemInternalName)
	self.id = "WeaponSelectGridItemInternalName"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponName = LUI.UIText.new(0, 0, 0, 260, 0, 0, 0, 18)
	WeaponName:setRGB(0.58, 0.58, 0.58)
	WeaponName:setZoom(3)
	WeaponName:setText("")
	WeaponName:setTTF("ttmussels_demibold")
	WeaponName:setLetterSpacing(2)
	WeaponName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WeaponName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	WeaponName:setBackingType(2)
	WeaponName:setBackingColor(0.08, 0.08, 0.08)
	WeaponName:setBackingXPadding(3)
	self:addElement(WeaponName)
	self.WeaponName = WeaponName
	self:mergeStateConditions({
		{
			stateName = "AsianLang",
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
CoD.WeaponSelectGridItemInternalName.__resetProperties = function(f3_arg0)
	f3_arg0.WeaponName:completeAnimation()
	f3_arg0.WeaponName:setTopBottom(0, 0, 0, 18)
end
CoD.WeaponSelectGridItemInternalName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLang = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.WeaponName:completeAnimation()
			f5_arg0.WeaponName:setTopBottom(0, 0, 5, 18)
			f5_arg0.clipFinished(f5_arg0.WeaponName)
		end,
	},
}

CoD.zm_red_available_item_text_internal = InheritFrom(LUI.UIElement)
CoD.zm_red_available_item_text_internal.__defaultWidth = 252
CoD.zm_red_available_item_text_internal.__defaultHeight = 20
CoD.zm_red_available_item_text_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_red_available_item_text_internal)
	self.id = "zm_red_available_item_text_internal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ItemText = LUI.UIText.new(0, 0, 145, 252, 0, 0, 0, 20)
	ItemText:setText(Engine[0xF9F1239CFD921FE](0xBF4567204B3D868))
	ItemText:setTTF("skorzhen")
	ItemText:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	ItemText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(ItemText)
	self.ItemText = ItemText
	local AvailableItemText = LUI.UIText.new(0, 0, 0, 145, 0, 0, 0, 20)
	AvailableItemText:setText(Engine[0xF9F1239CFD921FE](0x7F2DBA0199373EE))
	AvailableItemText:setTTF("skorzhen")
	AvailableItemText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AvailableItemText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(AvailableItemText)
	self.AvailableItemText = AvailableItemText
	self:mergeStateConditions({
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.zm_red_available_item_text_internal.__resetProperties = function(f3_arg0)
	f3_arg0.AvailableItemText:completeAnimation()
	f3_arg0.ItemText:completeAnimation()
	f3_arg0.AvailableItemText:setLeftRight(0, 0, 0, 145)
	f3_arg0.ItemText:setLeftRight(0, 0, 145, 252)
end
CoD.zm_red_available_item_text_internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Arabic = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.ItemText:completeAnimation()
			f5_arg0.ItemText:setLeftRight(0, 0, 0, 107)
			f5_arg0.clipFinished(f5_arg0.ItemText)
			f5_arg0.AvailableItemText:completeAnimation()
			f5_arg0.AvailableItemText:setLeftRight(0, 0, 107, 252)
			f5_arg0.clipFinished(f5_arg0.AvailableItemText)
		end,
	},
}

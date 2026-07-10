require("x64:76fa323de4745ba")
CoD.HubEquipmentItem = InheritFrom(LUI.UIElement)
CoD.HubEquipmentItem.__defaultWidth = 200
CoD.HubEquipmentItem.__defaultHeight = 346
CoD.HubEquipmentItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubEquipmentItem)
	self.id = "HubEquipmentItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0.5, 0.5, -75, 75, 0, 0, 20, 170)
	self:addElement(Icon)
	self.Icon = Icon
	local name = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 209, 230)
	name:setRGB(0.92, 0.92, 0.92)
	name:setAlpha(0.5)
	name:setText("")
	name:setTTF("dinnext_regular")
	name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(name)
	self.name = name
	local categoryHeader = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 182, 200)
	categoryHeader:setRGB(0.92, 0.92, 0.92)
	categoryHeader:setAlpha(0.15)
	categoryHeader:setText("")
	categoryHeader:setTTF("ttmussels_regular")
	categoryHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	categoryHeader:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(categoryHeader)
	self.categoryHeader = categoryHeader
	local statHeader = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 278, 296)
	statHeader:setRGB(0.92, 0.92, 0.92)
	statHeader:setAlpha(0.15)
	statHeader:setText("")
	statHeader:setTTF("ttmussels_regular")
	statHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	statHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(statHeader)
	self.statHeader = statHeader
	local statValue = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 301, 341)
	statValue:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	statValue:setAlpha(0.5)
	statValue:setText("")
	statValue:setTTF("ttmussels_demibold")
	statValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(statValue)
	self.statValue = statValue
	local RestrictedItemWarning = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0, 0, 70, 130, 0, 0, 70, 120)
	self:addElement(RestrictedItemWarning)
	self.RestrictedItemWarning = RestrictedItemWarning
	self:mergeStateConditions({
		{
			stateName = "NoStats",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubEquipmentItem.__resetProperties = function(f3_arg0)
	f3_arg0.statHeader:completeAnimation()
	f3_arg0.statValue:completeAnimation()
	f3_arg0.statHeader:setAlpha(0.15)
	f3_arg0.statValue:setAlpha(0.5)
end
CoD.HubEquipmentItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	NoStats = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.statHeader:completeAnimation()
			f5_arg0.statHeader:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.statHeader)
			f5_arg0.statValue:completeAnimation()
			f5_arg0.statValue:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.statValue)
		end,
	},
}
CoD.HubEquipmentItem.__onClose = function(f6_arg0)
	f6_arg0.RestrictedItemWarning:close()
end

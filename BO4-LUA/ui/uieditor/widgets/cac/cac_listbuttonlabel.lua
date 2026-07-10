require("x64:f6482b855bfca9f")
require("x64:1d8e482adfc7305")
CoD.cac_ListButtonLabel = InheritFrom(LUI.UIElement)
CoD.cac_ListButtonLabel.__defaultWidth = 162
CoD.cac_ListButtonLabel.__defaultHeight = 30
CoD.cac_ListButtonLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.cac_ListButtonLabel)
	self.id = "cac_ListButtonLabel"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local itemName = LUI.UIText.new(0, 1.07, 0, -12, 1, 1, -29, -2)
	itemName:setRGB(0.82, 0.85, 0.88)
	itemName:setScale(LanguageOverrideNumber("german", 0.9, LanguageOverrideNumber("italian", 0.9, 1, 1)))
	itemName:setTTF("dinnext_regular")
	itemName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	itemName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	itemName:setBackingType(1)
	itemName:setBackingWidget(CoD.FE_PanelNoBlur, f1_arg0, f1_arg1)
	itemName:setBackingColor(0, 0, 0)
	itemName:setBackingAlpha(0.7)
	itemName:setBackingXPadding(2)
	itemName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			itemName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(itemName)
	self.itemName = itemName
	local newIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 1, 1, 4, 22, 0.5, 0.5, -7, 11)
	newIcon:setAlpha(0)
	self:addElement(newIcon)
	self.newIcon = newIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "HasNew",
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
CoD.cac_ListButtonLabel.__resetProperties = function(f5_arg0)
	f5_arg0.itemName:completeAnimation()
	f5_arg0.newIcon:completeAnimation()
	f5_arg0.itemName:setAlpha(1)
	f5_arg0.newIcon:setAlpha(0)
end
CoD.cac_ListButtonLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.itemName:completeAnimation()
			f7_arg0.itemName:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.itemName)
		end,
	},
	HasNew = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.newIcon:completeAnimation()
			f8_arg0.newIcon:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.newIcon)
		end,
	},
}
CoD.cac_ListButtonLabel.__onClose = function(f9_arg0)
	f9_arg0.itemName:close()
	f9_arg0.newIcon:close()
end

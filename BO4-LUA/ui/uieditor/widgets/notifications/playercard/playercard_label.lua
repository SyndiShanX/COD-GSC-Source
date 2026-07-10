require("x64:1d8e482adfc7305")
CoD.PlayerCard_Label = InheritFrom(LUI.UIElement)
CoD.PlayerCard_Label.__defaultWidth = 170
CoD.PlayerCard_Label.__defaultHeight = 28
CoD.PlayerCard_Label.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerCard_Label)
	self.id = "PlayerCard_Label"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Panel = CoD.FE_PanelNoBlur.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Panel:setRGB(0, 0, 0)
	Panel:setAlpha(0.7)
	self:addElement(Panel)
	self.Panel = Panel
	local itemName = LUI.UIText.new(0, 0, 0, 240, 0.5, 0.5, -10.5, 10.5)
	itemName:setRGB(0.92, 0.92, 0.92)
	itemName:setTTF("notosans_regular")
	itemName:setLetterSpacing(1.5)
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	itemName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			itemName:setText(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(itemName, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 2)
	end)
	self:addElement(itemName)
	self.itemName = itemName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerCard_Label.__resetProperties = function(f4_arg0)
	f4_arg0.itemName:completeAnimation()
	f4_arg0.itemName:setRGB(0.92, 0.92, 0.92)
end
CoD.PlayerCard_Label.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	PlayerYellow = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.itemName:completeAnimation()
			f6_arg0.itemName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f6_arg0.clipFinished(f6_arg0.itemName)
		end,
	},
}
CoD.PlayerCard_Label.__onClose = function(f7_arg0)
	f7_arg0.Panel:close()
	f7_arg0.itemName:close()
end

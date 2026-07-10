CoD.MultiItemPickupWaypoint_HeaderInfo = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupWaypoint_HeaderInfo.__defaultWidth = 158
CoD.MultiItemPickupWaypoint_HeaderInfo.__defaultHeight = 20
CoD.MultiItemPickupWaypoint_HeaderInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 14, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.MultiItemPickupWaypoint_HeaderInfo)
	self.id = "MultiItemPickupWaypoint_HeaderInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local text = LUI.UIText.new(0, 0, 0, 75, 1, 1, -20, 0)
	text:setRGB(0.79, 0.76, 0.58)
	text.__Alpha = function()
		text:setAlpha(CoD.HUDUtility.PickupPromptOpacity(f1_arg1))
	end
	text.__Alpha()
	text.__String_Reference = function()
		text:setText(Engine[0xF9F1239CFD921FE](CoD.HUDUtility.Get3DWeaponHintPickupHintTextWithPickUpOptions(f1_arg1)))
	end
	text.__String_Reference()
	text:setTTF("dinnext_regular")
	text:setLetterSpacing(0.5)
	text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(text)
	self.text = text
	local Line = LUI.UIImage.new(0, 0, 178, 179, 0, 0, -5, 25)
	Line:setAlpha(0.15)
	self:addElement(Line)
	self.Line = Line
	local CursorHintText = LUI.UIText.new(0, 0, 89, 164, 0.5, 0.5, -11, 9)
	CursorHintText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CursorHintText:setTTF("ttmussels_demibold")
	CursorHintText:setLetterSpacing(0.5)
	CursorHintText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CursorHintText:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CursorHintText:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(CursorHintText)
	self.CursorHintText = CursorHintText
	local f1_local4 = text
	local f1_local5 = text.subscribeToModel
	local f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.weapon3dHintState, text.__Alpha)
	f1_local4 = text
	f1_local5 = text.subscribeToModel
	f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.heroHoldProgress, text.__Alpha)
	f1_local4 = text
	f1_local5 = text.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.inventory.filledSlots"], text.__Alpha)
	f1_local4 = text
	f1_local5 = text.subscribeToModel
	f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.weapon3dHintState, text.__String_Reference)
	f1_local4 = text
	f1_local5 = text.subscribeToModel
	f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.heroHoldProgress, text.__String_Reference)
	f1_local4 = text
	f1_local5 = text.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.inventory.filledSlots"], text.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "PromptDisabled",
			condition = function(menu, element, event)
				return CoD.HUDUtility.Disable3DWeaponHintButton(f1_arg1)
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.weapon3dHintState, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "weapon3dHintState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	if IsCurrentLanguageReversed() then
		ReverseChildrenOrder(self)
	end
	return self
end
CoD.MultiItemPickupWaypoint_HeaderInfo.__resetProperties = function(f7_arg0)
	f7_arg0.text:completeAnimation()
	f7_arg0.text:setRGB(0.79, 0.76, 0.58)
end
CoD.MultiItemPickupWaypoint_HeaderInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	PromptDisabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.text:completeAnimation()
			f9_arg0.text:setRGB(0.87, 0.08, 0.08)
			f9_arg0.clipFinished(f9_arg0.text)
		end,
	},
}
CoD.MultiItemPickupWaypoint_HeaderInfo.__onClose = function(f10_arg0)
	f10_arg0.text:close()
	f10_arg0.CursorHintText:close()
end

require("x64:d019ee604df7ce4")
require("x64:64be6dca9fd74cd")
require("x64:def253c83146ac7")
require("x64:2776b818a4ef8ef")
require("x64:656f14ecd42bb4c")
require("x64:c7319f416a557d6")
require("x64:d6f896aad1ae0c7")
require("x64:b8eb0fb2c6cf956")
require("x64:fe6668522639885")
require("x64:2d994185d4a874a")
CoD.TabletLocationSelector_Internal = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector_Internal.__defaultWidth = 1140
CoD.TabletLocationSelector_Internal.__defaultHeight = 740
CoD.TabletLocationSelector_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletLocationSelector_Internal)
	self.id = "TabletLocationSelector_Internal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MinimapHelper = CoD.MinimapHelper.new(f1_arg0, f1_arg1, 0, 0, 0, 1140, 0.5, 0.5, -321, 321)
	self:addElement(MinimapHelper)
	self.MinimapHelper = MinimapHelper
	local MinimapHelperItems = CoD.MinimapHelperItems.new(f1_arg0, f1_arg1, 0, 0, 0, 1140, 0.5, 0.5, -321, 321)
	self:addElement(MinimapHelperItems)
	self.MinimapHelperItems = MinimapHelperItems
	local LocationMarker = CoD.TabletLocationSelector_PointMarker.new(f1_arg0, f1_arg1, 0.5, 0.5, -630, -580, 0.5, 0.5, 254, 304)
	self:addElement(LocationMarker)
	self.LocationMarker = LocationMarker
	local PatrolMarker = CoD.TabletLocationSelector_PatrolMarker.new(f1_arg0, f1_arg1, 0, 0, -90, -40, 0, 0, 487, 543)
	self:addElement(PatrolMarker)
	self.PatrolMarker = PatrolMarker
	local PlayerMarker = CoD.TabletLocationSelector_PlayerMarker.new(f1_arg0, f1_arg1, 0, 0, -90, -40, 0, 0, 431.5, 481.5)
	self:addElement(PlayerMarker)
	self.PlayerMarker = PlayerMarker
	local MarkerCursor = CoD.TabletLocationSelector_MarkerCursor.new(f1_arg0, f1_arg1, 0, 0, -90, -40, 0, 0, 558, 608)
	self:addElement(MarkerCursor)
	self.MarkerCursor = MarkerCursor
	local TabletFrame = CoD.TabletLocationSelector_Frame.new(f1_arg0, f1_arg1, 0, 0, 17, 1125, 0, 0, 15, 729)
	self:addElement(TabletFrame)
	self.TabletFrame = TabletFrame
	local MessagePromptStandard = CoD.TabletLocationSelector_HintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -540, 540, 0, 0, 492, 528)
	MessagePromptStandard:setAlpha(0)
	MessagePromptStandard.CursorHintText:setText("")
	self:addElement(MessagePromptStandard)
	self.MessagePromptStandard = MessagePromptStandard
	local buttonprompt = CoD.buttonprompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -45, 125, 0, 0, 558, 603)
	buttonprompt:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	buttonprompt:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(buttonprompt, f3_arg1)
	end)
	local f1_local10 = buttonprompt
	local MessagePromptPlaneMortar = buttonprompt.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	MessagePromptPlaneMortar(f1_local10, f1_local12.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(buttonprompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	buttonprompt:setAlpha(0)
	buttonprompt.label:setText(Engine[0xF9F1239CFD921FE](0x7905825FED0EBD8))
	buttonprompt:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			buttonprompt.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(buttonprompt)
	self.buttonprompt = buttonprompt
	MessagePromptPlaneMortar = CoD.TabletLocationSelector_MessagePrompt_Planemortar.new(f1_arg0, f1_arg1, 0.5, 0.5, -298, 282, 0, 0, 510, 550)
	MessagePromptPlaneMortar:setAlpha(0)
	self:addElement(MessagePromptPlaneMortar)
	self.MessagePromptPlaneMortar = MessagePromptPlaneMortar
	self:mergeStateConditions({
		{
			stateName = "Mortar",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tabletLocationSelectorType", Enum[0xE2C7BBF6E260E20][0x904CE4D0F802D96])
			end,
		},
		{
			stateName = "Comlink",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tabletLocationSelectorType", Enum[0xE2C7BBF6E260E20][0x4336D8FF9031118])
			end,
		},
		{
			stateName = "Napalm",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tabletLocationSelectorType", Enum[0xE2C7BBF6E260E20][0x8760DA1682812FA])
			end,
		},
		{
			stateName = "Artillery",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tabletLocationSelectorType", Enum[0xE2C7BBF6E260E20][0x290413573874733])
			end,
		},
		{
			stateName = "Fixed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "hudItems.tabletLocationSelectorType", Enum[0xE2C7BBF6E260E20][0x99A6C784DDD3D07])
			end,
		},
	})
	f1_local12 = self
	f1_local10 = self.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local12, f1_local13["hudItems.tabletLocationSelectorType"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "hudItems.tabletLocationSelectorType",
		})
	end, false)
	LocationMarker.id = "LocationMarker"
	PatrolMarker.id = "PatrolMarker"
	PlayerMarker.id = "PlayerMarker"
	self.__defaultFocus = PatrolMarker
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	if CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "locSel.snapTo", 0) then
		CoD.LocationSelectorUtility.SetupDatapadLocationMap(self, f1_arg1, f1_arg0)
		CoD.LocationSelectorUtility.SetupLocationSelectorControls(self, f1_arg1, f1_arg0, self)
	end
	return self
end
CoD.TabletLocationSelector_Internal.__resetProperties = function(f12_arg0)
	f12_arg0.MessagePromptStandard:completeAnimation()
	f12_arg0.buttonprompt:completeAnimation()
	f12_arg0.MessagePromptPlaneMortar:completeAnimation()
	f12_arg0.MessagePromptStandard:setAlpha(0)
	f12_arg0.MessagePromptStandard.CursorHintText:setText("")
	f12_arg0.buttonprompt:setTopBottom(0, 0, 558, 603)
	f12_arg0.buttonprompt:setAlpha(0)
	f12_arg0.MessagePromptPlaneMortar:setTopBottom(0, 0, 510, 550)
	f12_arg0.MessagePromptPlaneMortar:setAlpha(0)
end
CoD.TabletLocationSelector_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Mortar = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.MessagePromptStandard:completeAnimation()
			f14_arg0.MessagePromptStandard.CursorHintText:completeAnimation()
			f14_arg0.MessagePromptStandard:setAlpha(0)
			f14_arg0.MessagePromptStandard.CursorHintText:setText(Engine[0xF9F1239CFD921FE](0x397C7860EF08AA3))
			f14_arg0.clipFinished(f14_arg0.MessagePromptStandard)
			f14_arg0.buttonprompt:completeAnimation()
			f14_arg0.buttonprompt:setTopBottom(0, 0, 682, 727)
			f14_arg0.buttonprompt:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.buttonprompt)
			f14_arg0.MessagePromptPlaneMortar:completeAnimation()
			f14_arg0.MessagePromptPlaneMortar:setTopBottom(0, 0, 642, 682)
			f14_arg0.MessagePromptPlaneMortar:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.MessagePromptPlaneMortar)
		end,
	},
	Comlink = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.MessagePromptStandard:completeAnimation()
			f15_arg0.MessagePromptStandard.CursorHintText:completeAnimation()
			f15_arg0.MessagePromptStandard:setAlpha(1)
			f15_arg0.MessagePromptStandard.CursorHintText:setText(Engine[0xF9F1239CFD921FE](0x5E69975EAC86CC7))
			f15_arg0.clipFinished(f15_arg0.MessagePromptStandard)
		end,
	},
	Napalm = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.MessagePromptStandard:completeAnimation()
			f16_arg0.MessagePromptStandard.CursorHintText:completeAnimation()
			f16_arg0.MessagePromptStandard:setAlpha(1)
			f16_arg0.MessagePromptStandard.CursorHintText:setText(Engine[0xF9F1239CFD921FE](0xC1D1D888C9B0714))
			f16_arg0.clipFinished(f16_arg0.MessagePromptStandard)
		end,
	},
	Artillery = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.MessagePromptStandard:completeAnimation()
			f17_arg0.MessagePromptStandard.CursorHintText:completeAnimation()
			f17_arg0.MessagePromptStandard:setAlpha(1)
			f17_arg0.MessagePromptStandard.CursorHintText:setText(Engine[0xF9F1239CFD921FE](0x81367119583BEBC))
			f17_arg0.clipFinished(f17_arg0.MessagePromptStandard)
		end,
	},
	Fixed = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.MessagePromptStandard:completeAnimation()
			f18_arg0.MessagePromptStandard.CursorHintText:completeAnimation()
			f18_arg0.MessagePromptStandard:setAlpha(1)
			f18_arg0.MessagePromptStandard.CursorHintText:setText(Engine[0xF9F1239CFD921FE](0x50D1022CB609A5D))
			f18_arg0.clipFinished(f18_arg0.MessagePromptStandard)
		end,
	},
}
CoD.TabletLocationSelector_Internal.__onClose = function(f19_arg0)
	f19_arg0.MinimapHelper:close()
	f19_arg0.MinimapHelperItems:close()
	f19_arg0.LocationMarker:close()
	f19_arg0.PatrolMarker:close()
	f19_arg0.PlayerMarker:close()
	f19_arg0.MarkerCursor:close()
	f19_arg0.TabletFrame:close()
	f19_arg0.MessagePromptStandard:close()
	f19_arg0.buttonprompt:close()
	f19_arg0.MessagePromptPlaneMortar:close()
end

require("x64:656f14ecd42bb4c")
CoD.TabletLocationSelector_MessagePrompt_Planemortar = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector_MessagePrompt_Planemortar.__defaultWidth = 580
CoD.TabletLocationSelector_MessagePrompt_Planemortar.__defaultHeight = 40
CoD.TabletLocationSelector_MessagePrompt_Planemortar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.TabletLocationSelector_MessagePrompt_Planemortar)
	self.id = "TabletLocationSelector_MessagePrompt_Planemortar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local TabletLocationSelectorHintText = CoD.TabletLocationSelector_HintText.new(f1_arg0, f1_arg1, 0.5, 0.5, -285, 245, 0.5, 0.5, -20, 20)
	TabletLocationSelectorHintText.CursorHintText:setText(Engine[0xF9F1239CFD921FE](0x397C7860EF08AA3))
	self:addElement(TabletLocationSelectorHintText)
	self.TabletLocationSelectorHintText = TabletLocationSelectorHintText
	local SelectionCountText = LUI.UIText.new(0.5, 0.5, 245, 285, 0.5, 0.5, -12, 6)
	SelectionCountText:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	SelectionCountText:setTTF("0arame_mono_stencil")
	SelectionCountText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SelectionCountText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SelectionCountText:subscribeToGlobalModel(f1_arg1, "HUDItems", "tabletLocationSelectorText", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SelectionCountText:setText(f2_local0)
		end
	end)
	self:addElement(SelectionCountText)
	self.SelectionCountText = SelectionCountText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletLocationSelector_MessagePrompt_Planemortar.__onClose = function(f3_arg0)
	f3_arg0.TabletLocationSelectorHintText:close()
	f3_arg0.SelectionCountText:close()
end

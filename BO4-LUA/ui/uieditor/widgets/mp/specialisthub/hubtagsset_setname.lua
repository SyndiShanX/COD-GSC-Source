CoD.HubTagsSet_SetName = InheritFrom(LUI.UIElement)
CoD.HubTagsSet_SetName.__defaultWidth = 128
CoD.HubTagsSet_SetName.__defaultHeight = 128
CoD.HubTagsSet_SetName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubTagsSet_SetName)
	self.id = "HubTagsSet_SetName"
	self.soundSet = "default"
	local TextBox = LUI.UIText.new(0, 1, 0, 0, 0, 0, 45.5, 82.5)
	TextBox:setTTF("ttmussels_demibold")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	TextBox:linkToElementModel(self, "setName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubTagsSet_SetName.__onClose = function(f3_arg0)
	f3_arg0.TextBox:close()
end

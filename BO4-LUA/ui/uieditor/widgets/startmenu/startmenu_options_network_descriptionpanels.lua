require("x64:cf5b4cc5bf2971b")
require("x64:e201e7e41431aa7")
require("x64:63355d9a3377f1d")
CoD.StartMenu_Options_Network_DescriptionPanels = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Network_DescriptionPanels.__defaultWidth = 880
CoD.StartMenu_Options_Network_DescriptionPanels.__defaultHeight = 775
CoD.StartMenu_Options_Network_DescriptionPanels.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Network_DescriptionPanels)
	self.id = "StartMenu_Options_Network_DescriptionPanels"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local NetworkPanel = CoD.FE_ButtonPanel.new(f1_arg0, f1_arg1, 0, 1, 19, -17, 0, 1, 15, -15)
	NetworkPanel:setRGB(0.24, 0.24, 0.26)
	NetworkPanel:setAlpha(0)
	self:addElement(NetworkPanel)
	self.NetworkPanel = NetworkPanel
	local NetworkBox4 = CoD.cac_ButtonBoxLrgInactiveStroke.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	NetworkBox4:setAlpha(0)
	self:addElement(NetworkBox4)
	self.NetworkBox4 = NetworkBox4
	local aboutTitle = LUI.UIText.new(0.5, 0.5, -360.5, 360.5, 0, 0, 26.5, 56.5)
	aboutTitle:setRGB(0.63, 0.57, 0.2)
	aboutTitle:setTTF("ttmussels_regular")
	aboutTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	aboutTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	aboutTitle:linkToElementModel(self, "aboutTitle", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			aboutTitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(aboutTitle)
	self.aboutTitle = aboutTitle
	local description = CoD.verticalScrollingTextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -360.5, 360.5, 0.5, 0.5, -308, 312)
	description.textBox.text:setRGB(0.78, 0.74, 0.67)
	description.textBox.text.__String_Reference = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			description.textBox.text:setText(Engine[0xF9F1239CFD921FE](CheckForKeyboardMouseDescriptionInList(self, f1_arg1, f3_local0)))
		end
	end
	description:linkToElementModel(self, "desc", true, description.textBox.text.__String_Reference)
	description.textBox.text.__String_Reference_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.desc
		end
		if f4_local0 then
			description.textBox.text.__String_Reference(f4_local0)
		end
	end
	self:addElement(description)
	self.description = description
	description:appendEventHandler("input_source_changed", description.textBox.text.__String_Reference_FullPath)
	local f1_local5 = description
	local f1_local6 = description.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, description.textBox.text.__String_Reference_FullPath)
	description:linkToElementModel(self, "desc", true, description.textBox.text.__String_Reference_FullPath)
	description:linkToElementModel(self, "descKBM", true, description.textBox.text.__String_Reference_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Network_DescriptionPanels.__onClose = function(f5_arg0)
	f5_arg0.NetworkPanel:close()
	f5_arg0.NetworkBox4:close()
	f5_arg0.aboutTitle:close()
	f5_arg0.description:close()
end

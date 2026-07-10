require("x64:47803d0fb7647f2")
require("x64:84662ffcdea628")
CoD.StartMenu_Options_PC_Voice_Text = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_Voice_Text.__defaultWidth = 1650
CoD.StartMenu_Options_PC_Voice_Text.__defaultHeight = 900
CoD.StartMenu_Options_PC_Voice_Text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_Voice_Text)
	self.id = "StartMenu_Options_PC_Voice_Text"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local optionInfo = CoD.OptionInfoWidget.new(f1_arg0, f1_arg1, 0, 0, 825, 1425, 0, 0, 45, 495)
	self:addElement(optionInfo)
	self.optionInfo = optionInfo
	local textOptionsList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	textOptionsList:setLeftRight(0, 0, 0, 750)
	textOptionsList:setTopBottom(0, 0, 45, 555)
	textOptionsList:setWidgetType(CoD.OptionDropdown)
	textOptionsList:setVerticalCount(10)
	textOptionsList:setSpacing(0)
	textOptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	textOptionsList:setDataSource("OptionVoiceText")
	self:addElement(textOptionsList)
	self.textOptionsList = textOptionsList
	local ChannelText = LUI.UIText.new(0, 0, 0, 750, 0, 0, 99, 144)
	ChannelText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_211E89D549AAECEF"))
	ChannelText:setTTF("default")
	ChannelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ChannelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ChannelText)
	self.ChannelText = ChannelText
	local PrefixText = LUI.UIText.new(0, 0, 0, 750, 0, 0, 301, 346)
	PrefixText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_71D7E52384712586"))
	PrefixText:setTTF("default")
	PrefixText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PrefixText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PrefixText)
	self.PrefixText = PrefixText
	optionInfo:linkToElementModel(textOptionsList, "description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			optionInfo.description:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	optionInfo:linkToElementModel(textOptionsList, "label", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			optionInfo.title.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	textOptionsList.id = "textOptionsList"
	self.__defaultFocus = textOptionsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_Voice_Text.__onClose = function(f4_arg0)
	f4_arg0.optionInfo:close()
	f4_arg0.textOptionsList:close()
end

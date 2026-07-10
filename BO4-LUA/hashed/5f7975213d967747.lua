require("x64:f85d1adfa3a0c8e")
require("x64:b3af0fce9f653ed")
CoD.Archives_Audio = InheritFrom(LUI.UIElement)
CoD.Archives_Audio.__defaultWidth = 1920
CoD.Archives_Audio.__defaultHeight = 780
CoD.Archives_Audio.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Archives_Audio)
	self.id = "Archives_Audio"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local AudioList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	AudioList:setLeftRight(0.5, 0.5, -760, -250)
	AudioList:setTopBottom(0.5, 0.5, -339.5, 326.5)
	AudioList:setWidgetType(CoD.ArchivesVideoButton)
	AudioList:setVerticalCount(13)
	AudioList:setSpacing(10)
	AudioList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AudioList:setDataSource("ArchivesAudioList")
	AudioList:linkToElementModel(AudioList, "alias", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AudioList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AudioList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "alias") and not IsElementInState(element, "MatureContentFiltered") then
			CoD.CTUtility.PlayArchivesAudio(menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "alias") and not IsElementInState(element, "MatureContentFiltered") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xDDDA371285672BD, nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(AudioList, "close", function(element)
		CoD.CTUtility.StopArchivesAudio(f1_arg0, f1_arg1, element)
	end)
	self:addElement(AudioList)
	self.AudioList = AudioList
	local ArchivesIntelPreview = CoD.ArchivesIntelPreview.new(f1_arg0, f1_arg1, 0.5, 0.5, 248, 758, 0.5, 0.5, -339.5, 160.5)
	self:addElement(ArchivesIntelPreview)
	self.ArchivesIntelPreview = ArchivesIntelPreview
	ArchivesIntelPreview:linkToElementModel(AudioList, nil, false, function(model)
		ArchivesIntelPreview:setModel(model, f1_arg1)
	end)
	AudioList.id = "AudioList"
	self.__defaultFocus = AudioList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Archives_Audio.__onClose = function(f8_arg0)
	f8_arg0.ArchivesIntelPreview:close()
	f8_arg0.AudioList:close()
end

require("x64:d7e092479c7b82c")
CoD.LegalTextViewerBody = InheritFrom(LUI.UIElement)
CoD.LegalTextViewerBody.__defaultWidth = 1728
CoD.LegalTextViewerBody.__defaultHeight = 900
CoD.LegalTextViewerBody.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LegalTextViewerBody)
	self.id = "LegalTextViewerBody"
	self.soundSet = "default"
	local textEntry = LUI.UIText.new(0, 1, 0, 0, 0, 0, 15, 45)
	textEntry:setTTF("dinnext_regular")
	textEntry:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	textEntry:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	textEntry:subscribeToGlobalModel(f1_arg1, "CODAccountLegalInfo", "currentLegalInfoText", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			textEntry:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(textEntry)
	self.textEntry = textEntry
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 1, -10, 0, 0, 0, 0, 900)
	self:addElement(Border)
	self.Border = Border
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LegalTextViewerBody.__onClose = function(f3_arg0)
	f3_arg0.textEntry:close()
	f3_arg0.Border:close()
end

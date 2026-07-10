require("x64:278721ff61dca1c")
require("x64:379001ae517dfa6")
require("x64:a8c6f5d1845bdd6")
require("x64:dd0e1cefc02c892")
CoD.PC_StartMenu_Options_Controls_Description = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_Description.__defaultWidth = 675
CoD.PC_StartMenu_Options_Controls_Description.__defaultHeight = 540
CoD.PC_StartMenu_Options_Controls_Description.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_Description)
	self.id = "PC_StartMenu_Options_Controls_Description"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local DescriptionTextBox = CoD.PC_StartMenu_Options_Controls_DescriptionText.new(f1_arg0, f1_arg1, 0, 0, 0, 673, 0, 0, 338, 540)
	DescriptionTextBox.OptionName:setText(LocalizeToUpperString(0x93E719493E9E18F))
	self:addElement(DescriptionTextBox)
	self.DescriptionTextBox = DescriptionTextBox
	local PlaceHolderImage = CoD.PC_StartMenu_Options_Controls_DescriptionImage.new(f1_arg0, f1_arg1, 0, 0, 0, 675, 0, 0, 4.5, 384.5)
	PlaceHolderImage.PlaceHolderImage:setImage(RegisterImage(0xD94A99F28B028CF))
	self:addElement(PlaceHolderImage)
	self.PlaceHolderImage = PlaceHolderImage
	local Line = CoD.SeperationLine.new(f1_arg0, f1_arg1, 0, 0, 0, 673, 0, 0, 0, 1)
	self:addElement(Line)
	self.Line = Line
	local testdescriptionpointer = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0, 0, 367.5, 397.5, 0, 0, 510, 528)
	self:addElement(testdescriptionpointer)
	self.testdescriptionpointer = testdescriptionpointer
	local testdescriptionpointer6 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0, 0, 413.5, 443.5, 0, 0, 510, 528)
	self:addElement(testdescriptionpointer6)
	self.testdescriptionpointer6 = testdescriptionpointer6
	local testdescriptionpointer5 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0, 0, 367.5, 397.5, 0, 0, 510, 528)
	self:addElement(testdescriptionpointer5)
	self.testdescriptionpointer5 = testdescriptionpointer5
	local testdescriptionpointer3 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0, 0, 322.5, 352.5, 0, 0, 510, 528)
	self:addElement(testdescriptionpointer3)
	self.testdescriptionpointer3 = testdescriptionpointer3
	local testdescriptionpointer2 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0, 0, 277.5, 307.5, 0, 0, 510, 528)
	self:addElement(testdescriptionpointer2)
	self.testdescriptionpointer2 = testdescriptionpointer2
	local testdescriptionpointer4 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0, 0, 232.5, 262.5, 0, 0, 510, 528)
	self:addElement(testdescriptionpointer4)
	self.testdescriptionpointer4 = testdescriptionpointer4
	self.DescriptionTextBox:linkToElementModel(self, "desc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DescriptionTextBox.detailedDescription:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	testdescriptionpointer.id = "testdescriptionpointer"
	testdescriptionpointer6.id = "testdescriptionpointer6"
	testdescriptionpointer5.id = "testdescriptionpointer5"
	testdescriptionpointer3.id = "testdescriptionpointer3"
	testdescriptionpointer2.id = "testdescriptionpointer2"
	testdescriptionpointer4.id = "testdescriptionpointer4"
	self.__defaultFocus = testdescriptionpointer3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_Description.__onClose = function(f3_arg0)
	f3_arg0.DescriptionTextBox:close()
	f3_arg0.PlaceHolderImage:close()
	f3_arg0.Line:close()
	f3_arg0.testdescriptionpointer:close()
	f3_arg0.testdescriptionpointer6:close()
	f3_arg0.testdescriptionpointer5:close()
	f3_arg0.testdescriptionpointer3:close()
	f3_arg0.testdescriptionpointer2:close()
	f3_arg0.testdescriptionpointer4:close()
end

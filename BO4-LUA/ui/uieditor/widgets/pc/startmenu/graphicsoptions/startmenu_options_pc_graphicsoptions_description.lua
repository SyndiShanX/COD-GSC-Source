require("ui/uieditor/widgets/pc/presetsquare")
require("ui/uieditor/widgets/pc/seperationline")
require("ui/uieditor/widgets/pc/startmenu/graphicsoptions/startmenu_options_pc_graphicsoptions_descriptionimage")
require("ui/uieditor/widgets/pc/startmenu/graphicsoptions/startmenu_options_pc_graphicsoptions_descriptiontextbox")
CoD.StartMenu_Options_PC_GraphicsOptions_Description = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_GraphicsOptions_Description.__defaultWidth = 672
CoD.StartMenu_Options_PC_GraphicsOptions_Description.__defaultHeight = 540
CoD.StartMenu_Options_PC_GraphicsOptions_Description.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_GraphicsOptions_Description)
	self.id = "StartMenu_Options_PC_GraphicsOptions_Description"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local DescriptionTextBox = CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionTextBox.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.63, 1, 0, 0)
	self:addElement(DescriptionTextBox)
	self.DescriptionTextBox = DescriptionTextBox
	local PlaceHolderImage = CoD.StartMenu_Options_PC_GraphicsOptions_DescriptionImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.01, 0.62, 0, 0)
	self:addElement(PlaceHolderImage)
	self.PlaceHolderImage = PlaceHolderImage
	local Line = CoD.SeperationLine.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 1)
	self:addElement(Line)
	self.Line = Line
	local testdescriptionpointer = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0.5, 0.5, -15, 15, 0.95, 0.95, -13, 5)
	self:addElement(testdescriptionpointer)
	self.testdescriptionpointer = testdescriptionpointer
	local testdescriptionpointer6 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0.56, 0.56, -15, 15, 0.95, 0.95, -13, 5)
	self:addElement(testdescriptionpointer6)
	self.testdescriptionpointer6 = testdescriptionpointer6
	local testdescriptionpointer5 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0.44, 0.44, -15, 15, 0.95, 0.95, -13, 5)
	self:addElement(testdescriptionpointer5)
	self.testdescriptionpointer5 = testdescriptionpointer5
	local testdescriptionpointer3 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0.62, 0.62, -15, 15, 0.95, 0.95, -13, 5)
	self:addElement(testdescriptionpointer3)
	self.testdescriptionpointer3 = testdescriptionpointer3
	local testdescriptionpointer2 = CoD.PresetSquare.new(f1_arg0, f1_arg1, 0.38, 0.38, -15, 15, 0.95, 0.95, -13, 5)
	self:addElement(testdescriptionpointer2)
	self.testdescriptionpointer2 = testdescriptionpointer2
	testdescriptionpointer.id = "testdescriptionpointer"
	testdescriptionpointer6.id = "testdescriptionpointer6"
	testdescriptionpointer5.id = "testdescriptionpointer5"
	testdescriptionpointer3.id = "testdescriptionpointer3"
	testdescriptionpointer2.id = "testdescriptionpointer2"
	self.__defaultFocus = testdescriptionpointer5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_GraphicsOptions_Description.__onClose = function(f2_arg0)
	f2_arg0.DescriptionTextBox:close()
	f2_arg0.PlaceHolderImage:close()
	f2_arg0.Line:close()
	f2_arg0.testdescriptionpointer:close()
	f2_arg0.testdescriptionpointer6:close()
	f2_arg0.testdescriptionpointer5:close()
	f2_arg0.testdescriptionpointer3:close()
	f2_arg0.testdescriptionpointer2:close()
end

require("x64:a1e2d7b19f5deb0")
CoD.EmblemEditorFrame = InheritFrom(LUI.UIElement)
CoD.EmblemEditorFrame.__defaultWidth = 201
CoD.EmblemEditorFrame.__defaultHeight = 193
CoD.EmblemEditorFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorFrame)
	self.id = "EmblemEditorFrame"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuframenoBG0 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG0)
	self.StartMenuframenoBG0 = StartMenuframenoBG0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorFrame.__onClose = function(f2_arg0)
	f2_arg0.StartMenuframenoBG0:close()
end

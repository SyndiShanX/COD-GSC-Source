require("x64:a9255c570c68aa8")
CoD.Social_EmptyFrame = InheritFrom(LUI.UIElement)
CoD.Social_EmptyFrame.__defaultWidth = 1920
CoD.Social_EmptyFrame.__defaultHeight = 1080
CoD.Social_EmptyFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_EmptyFrame)
	self.id = "Social_EmptyFrame"
	self.soundSet = "none"
	local infoBracketBot2 = LUI.UIImage.new(0, 0, 161, 462, 0, 0, 222, 230)
	infoBracketBot2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot2:setZRot(180)
	infoBracketBot2:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot2:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot2:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot2)
	self.infoBracketBot2 = infoBracketBot2
	local infoBracketBot = LUI.UIImage.new(0, 0, 481, 964, 0, 0, 222, 230)
	infoBracketBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot:setZRot(180)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local infoBracketBot3 = LUI.UIImage.new(0, 0, 999, 1459, 0, 0, 222, 230)
	infoBracketBot3:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	infoBracketBot3:setZRot(180)
	infoBracketBot3:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot3:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot3:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot3:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot3)
	self.infoBracketBot3 = infoBracketBot3
	local EmptyBox1 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1479, 1782, 0, 0, 236.5, 454.5)
	EmptyBox1:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(EmptyBox1)
	self.EmptyBox1 = EmptyBox1
	local EmptyBox2 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1479, 1782, 0, 0, 463.5, 681.5)
	EmptyBox2:setRGB(0.92, 0.92, 0.92)
	self:addElement(EmptyBox2)
	self.EmptyBox2 = EmptyBox2
	local EmptyBox3 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1479, 1782, 0, 0, 690, 936)
	EmptyBox3:setRGB(0.92, 0.92, 0.92)
	self:addElement(EmptyBox3)
	self.EmptyBox3 = EmptyBox3
	local StartMenuOptionsMainFrame5 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1007, 1135, 0, 0, 800, 928)
	StartMenuOptionsMainFrame5:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(StartMenuOptionsMainFrame5)
	self.StartMenuOptionsMainFrame5 = StartMenuOptionsMainFrame5
	local StartMenuOptionsMainFrame4 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1007, 1451, 0, 0, 690, 791)
	StartMenuOptionsMainFrame4:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(StartMenuOptionsMainFrame4)
	self.StartMenuOptionsMainFrame4 = StartMenuOptionsMainFrame4
	local EmptyBoxEmblem = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1007, 1451, 0, 0, 236.5, 681.5)
	EmptyBoxEmblem:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(EmptyBoxEmblem)
	self.EmptyBoxEmblem = EmptyBoxEmblem
	local EmptyBoxManageParty = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 481, 964, 0, 0, 236.5, 314.5)
	EmptyBoxManageParty:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(EmptyBoxManageParty)
	self.EmptyBoxManageParty = EmptyBoxManageParty
	local EmptyBoxPartySettings = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 161, 462, 0, 0, 236.5, 454.5)
	EmptyBoxPartySettings:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(EmptyBoxPartySettings)
	self.EmptyBoxPartySettings = EmptyBoxPartySettings
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_EmptyFrame.__onClose = function(f2_arg0)
	f2_arg0.EmptyBox1:close()
	f2_arg0.EmptyBox2:close()
	f2_arg0.EmptyBox3:close()
	f2_arg0.StartMenuOptionsMainFrame5:close()
	f2_arg0.StartMenuOptionsMainFrame4:close()
	f2_arg0.EmptyBoxEmblem:close()
	f2_arg0.EmptyBoxManageParty:close()
	f2_arg0.EmptyBoxPartySettings:close()
end

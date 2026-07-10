require("x64:513bfe044a7756d")
require("x64:e7e273f135073e1")
CoD.StartMenu_WZTeamScoreboard = InheritFrom(LUI.UIElement)
CoD.StartMenu_WZTeamScoreboard.__defaultWidth = 1920
CoD.StartMenu_WZTeamScoreboard.__defaultHeight = 1080
CoD.StartMenu_WZTeamScoreboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_WZTeamScoreboard)
	self.id = "StartMenu_WZTeamScoreboard"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(-0.25, 1.25, 0, 0, 1, 1, -165, -65)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.2)
	self:addElement(Background)
	self.Background = Background
	local BlurTint01 = LUI.UIImage.new(-0.25, 1.25, 0, 0, 1, 1, -177, -165)
	BlurTint01:setRGB(0, 0, 0)
	BlurTint01:setAlpha(0.3)
	self:addElement(BlurTint01)
	self.BlurTint01 = BlurTint01
	local BackingNoise = LUI.UIImage.new(-0.25, 1.25, 0, 0, 1, 1, -165, -65)
	BackingNoise:setAlpha(0.5)
	BackingNoise:setImage(RegisterImage(0x34839E8065B1E53))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local WZTeamScoreboardFooter = CoD.WZTeamScoreboard_Footer.new(f1_arg0, f1_arg1, 0.5, 0.5, -524, 676, 1, 1, -165, -65)
	self:addElement(WZTeamScoreboardFooter)
	self.WZTeamScoreboardFooter = WZTeamScoreboardFooter
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.QuitButton = f1_local5
	local WZTeamScoreboard = CoD.WZTeamScoreboard.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -420, 330)
	self:addElement(WZTeamScoreboard)
	self.WZTeamScoreboard = WZTeamScoreboard
	local FuiBox02Right = LUI.UIImage.new(1, 1, -50, -16, 1, 1, -122, -156)
	FuiBox02Right:setAlpha(0.2)
	FuiBox02Right:setImage(RegisterImage(0x811A80C0AADA825))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	WZTeamScoreboardFooter:linkToElementModel(WZTeamScoreboard.WZTeamScoreboard, nil, false, function(model)
		WZTeamScoreboardFooter:setModel(model, f1_arg1)
	end)
	f1_local5:appendEventHandler("menu_loaded", function()
		f1_local5:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	f1_local5.id = "QuitButton"
	WZTeamScoreboard.id = "WZTeamScoreboard"
	self.__defaultFocus = WZTeamScoreboard
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_WZTeamScoreboard.__onClose = function(f4_arg0)
	f4_arg0.WZTeamScoreboardFooter:close()
	f4_arg0.QuitButton:close()
	f4_arg0.WZTeamScoreboard:close()
end

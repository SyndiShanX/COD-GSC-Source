require("x64:246178cf189051b")
require("x64:29187ea00d726c3")
CoD.Barracks_StatsOverview_WZ_FilterPCString = InheritFrom(LUI.UIElement)
CoD.Barracks_StatsOverview_WZ_FilterPCString.__defaultWidth = 200
CoD.Barracks_StatsOverview_WZ_FilterPCString.__defaultHeight = 18
CoD.Barracks_StatsOverview_WZ_FilterPCString.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.Barracks_StatsOverview_WZ_FilterPCString)
	self.id = "Barracks_StatsOverview_WZ_FilterPCString"
	self.soundSet = "default"
	local WZGameModeFilterButtonPC = LUI.UIText.new(0, 0, 111, 200, 0.5, 0.5, -9, 9)
	WZGameModeFilterButtonPC:setText(Engine[0xF9F1239CFD921FE](0x2077705355095C1))
	WZGameModeFilterButtonPC:setTTF("ttmussels_regular")
	WZGameModeFilterButtonPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(WZGameModeFilterButtonPC)
	self.WZGameModeFilterButtonPC = WZGameModeFilterButtonPC
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 101, 111, 0.5, 0.5, -13.5, 13.5)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 61, 101, 0.5, 0.5, -13, 9)
	KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_1}]"))
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Barracks_StatsOverview_WZ_FilterPCString.__onClose = function(f2_arg0)
	f2_arg0.VerticalListSpacer:close()
	f2_arg0.KeyPrompt:close()
end

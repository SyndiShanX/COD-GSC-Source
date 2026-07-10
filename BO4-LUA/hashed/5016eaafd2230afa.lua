require("x64:8c081eae077f5fd")
CoD.SubtitlesContainer = InheritFrom(LUI.UIElement)
CoD.SubtitlesContainer.__defaultWidth = 1110
CoD.SubtitlesContainer.__defaultHeight = 147
CoD.SubtitlesContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SubtitlesContainer)
	self.id = "SubtitlesContainer"
	self.soundSet = "HUD"
	local SubtitleEntry0 = CoD.SubtitleEntryContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0)
	SubtitleEntry0:subscribeToGlobalModel(f1_arg1, "HUDItems", "subtitles.line0", function(model)
		SubtitleEntry0:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry0)
	self.SubtitleEntry0 = SubtitleEntry0
	local SubtitleEntry1 = CoD.SubtitleEntryContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0)
	SubtitleEntry1:subscribeToGlobalModel(f1_arg1, "HUDItems", "subtitles.line1", function(model)
		SubtitleEntry1:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry1)
	self.SubtitleEntry1 = SubtitleEntry1
	local SubtitleEntry2 = CoD.SubtitleEntryContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0)
	SubtitleEntry2:subscribeToGlobalModel(f1_arg1, "HUDItems", "subtitles.line2", function(model)
		SubtitleEntry2:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry2)
	self.SubtitleEntry2 = SubtitleEntry2
	local SubtitleEntry3 = CoD.SubtitleEntryContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0)
	SubtitleEntry3:subscribeToGlobalModel(f1_arg1, "HUDItems", "subtitles.line3", function(model)
		SubtitleEntry3:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry3)
	self.SubtitleEntry3 = SubtitleEntry3
	local SubtitleEntry4 = CoD.SubtitleEntryContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0)
	SubtitleEntry4:subscribeToGlobalModel(f1_arg1, "HUDItems", "subtitles.line4", function(model)
		SubtitleEntry4:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry4)
	self.SubtitleEntry4 = SubtitleEntry4
	local SubtitleEntry5 = CoD.SubtitleEntryContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0)
	SubtitleEntry5:subscribeToGlobalModel(f1_arg1, "HUDItems", "subtitles.line5", function(model)
		SubtitleEntry5:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry5)
	self.SubtitleEntry5 = SubtitleEntry5
	local SubtitleEntry6 = CoD.SubtitleEntryContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1110, 1, 1, -30, 0)
	SubtitleEntry6:subscribeToGlobalModel(f1_arg1, "HUDItems", "subtitles.line6", function(model)
		SubtitleEntry6:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry6)
	self.SubtitleEntry6 = SubtitleEntry6
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	CoD.SubtitleUtility.Init(self, f1_arg1, "subtitles", nil)
	return self
end
CoD.SubtitlesContainer.__onClose = function(f9_arg0)
	f9_arg0.SubtitleEntry0:close()
	f9_arg0.SubtitleEntry1:close()
	f9_arg0.SubtitleEntry2:close()
	f9_arg0.SubtitleEntry3:close()
	f9_arg0.SubtitleEntry4:close()
	f9_arg0.SubtitleEntry5:close()
	f9_arg0.SubtitleEntry6:close()
end

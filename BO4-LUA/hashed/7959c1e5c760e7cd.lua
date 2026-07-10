require("x64:a60157a4aabb40e")
CoD.SubtitleEntryContainer = InheritFrom(LUI.UIElement)
CoD.SubtitleEntryContainer.__defaultWidth = 1110
CoD.SubtitleEntryContainer.__defaultHeight = 33
CoD.SubtitleEntryContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SubtitleEntryContainer)
	self.id = "SubtitleEntryContainer"
	self.soundSet = "HUD"
	local SubtitleEntry = CoD.SubtitleEntry.new(f1_arg0, f1_arg1, 0.5, 0.5, -555, 555, 1, 1, -33, 6)
	SubtitleEntry:linkToElementModel(self, nil, false, function(model)
		SubtitleEntry:setModel(model, f1_arg1)
	end)
	self:addElement(SubtitleEntry)
	self.SubtitleEntry = SubtitleEntry
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.SubtitleUtility.EntryInit(self, f1_arg1, Enum[@"luialignment"][@"lui_alignment_center"])
	return self
end
CoD.SubtitleEntryContainer.__onClose = function(f3_arg0)
	f3_arg0.SubtitleEntry:close()
end

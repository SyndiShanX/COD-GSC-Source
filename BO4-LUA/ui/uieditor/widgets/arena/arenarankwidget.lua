require("x64:606f9d8814cb296")
CoD.ArenaRankWidget = InheritFrom(LUI.UIElement)
CoD.ArenaRankWidget.__defaultWidth = 128
CoD.ArenaRankWidget.__defaultHeight = 128
CoD.ArenaRankWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaRankWidget)
	self.id = "ArenaRankWidget"
	self.soundSet = "none"
	local ArenaRankWidgetInternal = CoD.ArenaRankWidgetInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ArenaRankWidgetInternal:linkToElementModel(self, nil, false, function(model)
		ArenaRankWidgetInternal:setModel(model, f1_arg1)
	end)
	ArenaRankWidgetInternal:linkToElementModel(self, "leaguePlayFirestreakIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ArenaRankWidgetInternal.FireStreakIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(ArenaRankWidgetInternal)
	self.ArenaRankWidgetInternal = ArenaRankWidgetInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaRankWidget.__onClose = function(f4_arg0)
	f4_arg0.ArenaRankWidgetInternal:close()
end

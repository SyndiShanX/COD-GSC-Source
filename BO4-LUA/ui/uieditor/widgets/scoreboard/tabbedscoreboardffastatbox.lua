require("x64:c12ff2bdd075f2c")
CoD.TabbedScoreboardFFAStatBox = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardFFAStatBox.__defaultWidth = 82
CoD.TabbedScoreboardFFAStatBox.__defaultHeight = 60
CoD.TabbedScoreboardFFAStatBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardFFAStatBox)
	self.id = "TabbedScoreboardFFAStatBox"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatBoxFFA = CoD.TabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 1, 1, -82, 0, 0.5, 0.5, -30, 30)
	StatBoxFFA:linkToElementModel(self, nil, false, function(model)
		StatBoxFFA:setModel(model, f1_arg1)
	end)
	StatBoxFFA:linkToElementModel(self, "scoreboard.footer1", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StatBoxFFA.Value:setText(f3_local0)
		end
	end)
	self:addElement(StatBoxFFA)
	self.StatBoxFFA = StatBoxFFA
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not IsTeamBasedGame(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["MapVote.mapVoteMapPreviousGametype"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "MapVote.mapVoteMapPreviousGametype",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardFFAStatBox.__resetProperties = function(f6_arg0)
	f6_arg0.StatBoxFFA:completeAnimation()
	f6_arg0.StatBoxFFA:setAlpha(1)
end
CoD.TabbedScoreboardFFAStatBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.StatBoxFFA:completeAnimation()
			f7_arg0.StatBoxFFA:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.StatBoxFFA)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.TabbedScoreboardFFAStatBox.__onClose = function(f9_arg0)
	f9_arg0.StatBoxFFA:close()
end

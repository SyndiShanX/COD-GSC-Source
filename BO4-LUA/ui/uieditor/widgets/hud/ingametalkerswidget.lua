require("ui/uieditor/widgets/startgameflow/loadingscreentalkerwidgetcpzm")
CoD.InGameTalkersWidget = InheritFrom(LUI.UIElement)
CoD.InGameTalkersWidget.__defaultWidth = 285
CoD.InGameTalkersWidget.__defaultHeight = 130
CoD.InGameTalkersWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InGameTalkersWidget)
	self.id = "InGameTalkersWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Talkers = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	Talkers:setLeftRight(0, 0, 0, 330)
	Talkers:setTopBottom(0, 0, 0, 132)
	Talkers:setWidgetType(CoD.LoadingScreenTalkerWidgetCPZM)
	Talkers:setVerticalCount(4)
	Talkers:setSpacing(8)
	Talkers:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Talkers:setDataSource("LoadingScreenPlayerListTeam1")
	self:addElement(Talkers)
	self.Talkers = Talkers
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not Engine.IsVisibilityBitSet(f1_arg1, Enum.UIVisibilityBit[@"bit_hud_visible"])
			end,
		},
		{
			stateName = "VisibleHardcore",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum.UIVisibilityBit[@"bit_hud_visible"],
		})
	end, false)
	Talkers.id = "Talkers"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InGameTalkersWidget.__resetProperties = function(f5_arg0)
	f5_arg0.Talkers:completeAnimation()
	f5_arg0.Talkers:setAlpha(1)
end
CoD.InGameTalkersWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Talkers:completeAnimation()
			f6_arg0.Talkers:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Talkers)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	VisibleHardcore = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.InGameTalkersWidget.__onClose = function(f9_arg0)
	f9_arg0.Talkers:close()
end

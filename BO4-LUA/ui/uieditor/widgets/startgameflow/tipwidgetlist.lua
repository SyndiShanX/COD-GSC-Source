require("ui/uieditor/widgets/startgameflow/tipwidgetbacking")
CoD.TipWidgetList = InheritFrom(LUI.UIElement)
CoD.TipWidgetList.__defaultWidth = 1735
CoD.TipWidgetList.__defaultHeight = 134
CoD.TipWidgetList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TipWidgetList)
	self.id = "TipWidgetList"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TipLabel = LUI.UIText.new(0, 1, 1, 1, 0, 0, 15, 60)
	TipLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TipLabel:setText(LocalizeToUpperString(@"mpui/tip"))
	TipLabel:setTTF("ttmussels_demibold")
	TipLabel:setLetterSpacing(5.5)
	TipLabel:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum.LUIAlignment[@"lui_alignment_left"]))
	self:addElement(TipLabel)
	self.TipLabel = TipLabel
	local TipWidgetBacking = CoD.TipWidgetBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 66, 126)
	TipWidgetBacking:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "tip", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TipWidgetBacking.Tip:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(TipWidgetBacking)
	self.TipWidgetBacking = TipWidgetBacking
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsInTheaterMode()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine.GetGlobalModel()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TipWidgetList.__resetProperties = function(f5_arg0)
	f5_arg0.TipLabel:completeAnimation()
	f5_arg0.TipWidgetBacking:completeAnimation()
	f5_arg0.TipLabel:setAlpha(1)
	f5_arg0.TipWidgetBacking:setAlpha(1)
end
CoD.TipWidgetList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.TipLabel:completeAnimation()
			f7_arg0.TipLabel:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TipLabel)
			f7_arg0.TipWidgetBacking:completeAnimation()
			f7_arg0.TipWidgetBacking:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TipWidgetBacking)
		end,
	},
}
CoD.TipWidgetList.__onClose = function(f8_arg0)
	f8_arg0.TipWidgetBacking:close()
end

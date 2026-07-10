require("x64:7ecf7294ec3064f")
require("x64:2d361ac3553c22a")
CoD.TipWidgetList_WZ = InheritFrom(LUI.UIElement)
CoD.TipWidgetList_WZ.__defaultWidth = 1735
CoD.TipWidgetList_WZ.__defaultHeight = 134
CoD.TipWidgetList_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TipWidgetList_WZ)
	self.id = "TipWidgetList_WZ"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TipLabel = LUI.UIText.new(0, 1, 1, 1, 0, 0, 15, 60)
	TipLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TipLabel:setText(LocalizeToUpperString(@"mpui/tip"))
	TipLabel:setTTF("ttmussels_demibold")
	TipLabel:setLetterSpacing(5.5)
	TipLabel:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	self:addElement(TipLabel)
	self.TipLabel = TipLabel
	local TipWidgetBacking = CoD.TipWidgetBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 67, 127)
	TipWidgetBacking:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "tip", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TipWidgetBacking.Tip:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(TipWidgetBacking)
	self.TipWidgetBacking = TipWidgetBacking
	local TrialTipWidgetBacking = CoD.TipWidgetBacking.new(f1_arg0, f1_arg1, 0, 0.97, 50, 50, 0, 0, 67, 127)
	TrialTipWidgetBacking:setAlpha(0)
	TrialTipWidgetBacking.Tip:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29BEC82F67E8F516"))
	self:addElement(TrialTipWidgetBacking)
	self.TrialTipWidgetBacking = TrialTipWidgetBacking
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0, 0, 77, 117)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "WZTrial",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TipWidgetList_WZ.__resetProperties = function(f4_arg0)
	f4_arg0.TipWidgetBacking:completeAnimation()
	f4_arg0.TrialTipWidgetBacking:completeAnimation()
	f4_arg0.TrialWidget:completeAnimation()
	f4_arg0.TipWidgetBacking:setAlpha(1)
	f4_arg0.TrialTipWidgetBacking:setAlpha(0)
	f4_arg0.TrialWidget:setAlpha(0)
end
CoD.TipWidgetList_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	WZTrial = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.TipWidgetBacking:completeAnimation()
			f6_arg0.TipWidgetBacking:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.TipWidgetBacking)
			f6_arg0.TrialTipWidgetBacking:completeAnimation()
			f6_arg0.TrialTipWidgetBacking:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TrialTipWidgetBacking)
			f6_arg0.TrialWidget:completeAnimation()
			f6_arg0.TrialWidget:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TrialWidget)
		end,
	},
}
CoD.TipWidgetList_WZ.__onClose = function(f7_arg0)
	f7_arg0.TipWidgetBacking:close()
	f7_arg0.TrialTipWidgetBacking:close()
	f7_arg0.TrialWidget:close()
end

require("x64:fd51e83e2e6dbd1")
require("x64:8f24caf62e0fdce")
CoD.TabbedScoreboardRowLeft = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardRowLeft.__defaultWidth = 684
CoD.TabbedScoreboardRowLeft.__defaultHeight = 60
CoD.TabbedScoreboardRowLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardRowLeft)
	self.id = "TabbedScoreboardRowLeft"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScoreboardRowInternal = CoD.TabbedScoreboardRowInternal.new(f1_arg0, f1_arg1, 0, 0, -36, 688, 0, 0, -4, 64)
	ScoreboardRowInternal:linkToElementModel(self, nil, false, function(model)
		ScoreboardRowInternal:setModel(model, f1_arg1)
	end)
	ScoreboardRowInternal:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		return f3_local0
	end)
	self:addElement(ScoreboardRowInternal)
	self.ScoreboardRowInternal = ScoreboardRowInternal
	local deadSkull = CoD.onOffImage.new(f1_arg0, f1_arg1, 0, 0, 390, 422, 0, 0, 14, 46)
	deadSkull:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dead")
			end,
		},
	})
	deadSkull:linkToElementModel(deadSkull, "dead", true, function(model)
		f1_arg0:updateElementState(deadSkull, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dead",
		})
	end)
	deadSkull.image:setImage(RegisterImage(0xB73FD6B1D4A1BAF))
	deadSkull:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveFriendlyColor", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			deadSkull:setRGB(f6_local0)
		end
	end)
	deadSkull:linkToElementModel(self, nil, false, function(model)
		deadSkull:setModel(model, f1_arg1)
	end)
	self:addElement(deadSkull)
	self.deadSkull = deadSkull
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xuid", LuaDefine.INVALID_XUID_X64) and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBot")
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	self:linkToElementModel(self, "isBot", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBot",
		})
	end)
	ScoreboardRowInternal.id = "ScoreboardRowInternal"
	self.__defaultFocus = ScoreboardRowInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	f1_local3 = ScoreboardRowInternal
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuScoreboard(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardRowLeft.__resetProperties = function(f11_arg0)
	f11_arg0.deadSkull:completeAnimation()
	f11_arg0.ScoreboardRowInternal:completeAnimation()
	f11_arg0.deadSkull:setAlpha(1)
	f11_arg0.ScoreboardRowInternal:setAlpha(1)
end
CoD.TabbedScoreboardRowLeft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.ScoreboardRowInternal:completeAnimation()
			f13_arg0.ScoreboardRowInternal:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ScoreboardRowInternal)
			f13_arg0.deadSkull:completeAnimation()
			f13_arg0.deadSkull:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.deadSkull)
		end,
	},
}
CoD.TabbedScoreboardRowLeft.__onClose = function(f14_arg0)
	f14_arg0.ScoreboardRowInternal:close()
	f14_arg0.deadSkull:close()
end

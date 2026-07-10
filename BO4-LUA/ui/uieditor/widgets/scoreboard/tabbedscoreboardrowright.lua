require("x64:fd51e83e2e6dbd1")
require("x64:8f24caf62e0fdce")
CoD.TabbedScoreboardRowRight = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardRowRight.__defaultWidth = 684
CoD.TabbedScoreboardRowRight.__defaultHeight = 60
CoD.TabbedScoreboardRowRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardRowRight)
	self.id = "TabbedScoreboardRowRight"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TabbedScoreboardRowInternal = CoD.TabbedScoreboardRowInternal.new(f1_arg0, f1_arg1, 0, 0, -36, 688, 0, 0, -4, 64)
	TabbedScoreboardRowInternal:linkToElementModel(self, nil, false, function(model)
		TabbedScoreboardRowInternal:setModel(model, f1_arg1)
	end)
	self:addElement(TabbedScoreboardRowInternal)
	self.TabbedScoreboardRowInternal = TabbedScoreboardRowInternal
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
	deadSkull:subscribeToGlobalModel(f1_arg1, "HUDItems", "colorBlindSensitiveEnemyColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			deadSkull:setRGB(f5_local0)
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
	TabbedScoreboardRowInternal.id = "TabbedScoreboardRowInternal"
	self.__defaultFocus = TabbedScoreboardRowInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	f1_local3 = TabbedScoreboardRowInternal
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenuScoreboard(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardRowRight.__resetProperties = function(f10_arg0)
	f10_arg0.deadSkull:completeAnimation()
	f10_arg0.TabbedScoreboardRowInternal:completeAnimation()
	f10_arg0.deadSkull:setAlpha(1)
	f10_arg0.TabbedScoreboardRowInternal:setAlpha(1)
end
CoD.TabbedScoreboardRowRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.TabbedScoreboardRowInternal:completeAnimation()
			f12_arg0.TabbedScoreboardRowInternal:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TabbedScoreboardRowInternal)
			f12_arg0.deadSkull:completeAnimation()
			f12_arg0.deadSkull:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.deadSkull)
		end,
	},
}
CoD.TabbedScoreboardRowRight.__onClose = function(f13_arg0)
	f13_arg0.TabbedScoreboardRowInternal:close()
	f13_arg0.deadSkull:close()
end

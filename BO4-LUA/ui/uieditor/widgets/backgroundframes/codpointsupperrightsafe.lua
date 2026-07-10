require("x64:4cee61320cd1f1b")
CoD.CoDPointsUpperRightSafe = InheritFrom(LUI.UIElement)
CoD.CoDPointsUpperRightSafe.__defaultWidth = 1920
CoD.CoDPointsUpperRightSafe.__defaultHeight = 1080
CoD.CoDPointsUpperRightSafe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CoDPointsUpperRightSafe)
	self.id = "CoDPointsUpperRightSafe"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_arg0, f1_arg1, 1, 1, -566, -462, 0, 0, 30, 95)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "codPoints", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f2_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	self:mergeStateConditions({
		{
			stateName = "ShowCoDPoints",
			condition = function(menu, element, event)
				return AreCodPointsEnabled(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNetworkMode"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	self.__on_menuOpened_self = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = self
		SizeToSafeArea(self, f5_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CoDPointsUpperRightSafe.__resetProperties = function(f7_arg0)
	f7_arg0.StartMenuCODpoints:completeAnimation()
	f7_arg0.StartMenuCODpoints:setAlpha(1)
end
CoD.CoDPointsUpperRightSafe.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.StartMenuCODpoints:completeAnimation()
			f8_arg0.StartMenuCODpoints:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.StartMenuCODpoints)
		end,
	},
	ShowCoDPoints = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CoDPointsUpperRightSafe.__onClose = function(f10_arg0)
	f10_arg0.__on_close_removeOverrides()
	f10_arg0.StartMenuCODpoints:close()
end

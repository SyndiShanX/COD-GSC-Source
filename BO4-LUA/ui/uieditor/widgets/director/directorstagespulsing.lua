require("x64:42afe23d51bcfd4")
CoD.DirectorStagesPulsing = InheritFrom(LUI.UIElement)
CoD.DirectorStagesPulsing.__defaultWidth = 602
CoD.DirectorStagesPulsing.__defaultHeight = 24
CoD.DirectorStagesPulsing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorStagesPulsing)
	self.id = "DirectorStagesPulsing"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Stage6 = CoD.DirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 394, 602, 0, 0, 0, 24)
	Stage6:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueLessThan("lobbyRoot.publicLobby.stage", 3)
			end,
		},
	})
	local Stage4 = Stage6
	local Stage5 = Stage6.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	Stage5(Stage4, f1_local4["lobbyRoot.publicLobby.stage"], function(f3_arg0)
		f1_arg0:updateElementState(Stage6, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:addElement(Stage6)
	self.Stage6 = Stage6
	Stage5 = CoD.DirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 197, 405, 0, 0, 0, 24)
	Stage5:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueLessThan("lobbyRoot.publicLobby.stage", 2)
			end,
		},
	})
	f1_local4 = Stage5
	Stage4 = Stage5.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	Stage4(f1_local4, f1_local5["lobbyRoot.publicLobby.stage"], function(f5_arg0)
		f1_arg0:updateElementState(Stage5, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:addElement(Stage5)
	self.Stage5 = Stage5
	Stage4 = CoD.DirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 0, 208, 0, 0, 0, 24)
	Stage4:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueLessThan("lobbyRoot.publicLobby.stage", 1)
			end,
		},
	})
	f1_local5 = Stage4
	f1_local4 = Stage4.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.publicLobby.stage"], function(f7_arg0)
		f1_arg0:updateElementState(Stage4, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:addElement(Stage4)
	self.Stage4 = Stage4
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.publicLobby.waitingAnimation")
			end,
		},
	})
	f1_local5 = self
	f1_local4 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.publicLobby.waitingAnimation"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.publicLobby.waitingAnimation",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorStagesPulsing.__resetProperties = function(f10_arg0)
	f10_arg0.Stage4:completeAnimation()
	f10_arg0.Stage5:completeAnimation()
	f10_arg0.Stage6:completeAnimation()
	f10_arg0.Stage4:setAlpha(1)
	f10_arg0.Stage5:setAlpha(1)
	f10_arg0.Stage6:setAlpha(1)
end
CoD.DirectorStagesPulsing.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Stage6:completeAnimation()
			f11_arg0.Stage6:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Stage6)
			f11_arg0.Stage5:completeAnimation()
			f11_arg0.Stage5:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Stage5)
			f11_arg0.Stage4:completeAnimation()
			f11_arg0.Stage4:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Stage4)
		end,
	},
	Visible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorStagesPulsing.__onClose = function(f13_arg0)
	f13_arg0.Stage6:close()
	f13_arg0.Stage5:close()
	f13_arg0.Stage4:close()
end

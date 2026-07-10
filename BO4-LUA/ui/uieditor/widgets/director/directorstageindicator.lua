require("x64:42afe23d51bcfd4")
require("x64:87ae3dbc4c1c4da")
CoD.DirectorStageIndicator = InheritFrom(LUI.UIElement)
CoD.DirectorStageIndicator.__defaultWidth = 860
CoD.DirectorStageIndicator.__defaultHeight = 40
CoD.DirectorStageIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorStageIndicator)
	self.id = "DirectorStageIndicator"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Stage1 = CoD.DirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 5, 213, 0, 0, 8, 32)
	Stage1:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueLessThan("lobbyRoot.publicLobby.stage", 1)
			end,
		},
	})
	local Stage3 = Stage1
	local Stage2 = Stage1.subscribeToModel
	local Stage4 = Engine[@"getglobalmodel"]()
	Stage2(Stage3, Stage4["lobbyRoot.publicLobby.stage"], function(f3_arg0)
		f1_arg0:updateElementState(Stage1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:addElement(Stage1)
	self.Stage1 = Stage1
	Stage2 = CoD.DirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 202, 410, 0, 0, 8, 32)
	Stage2:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueLessThan("lobbyRoot.publicLobby.stage", 2)
			end,
		},
	})
	Stage4 = Stage2
	Stage3 = Stage2.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	Stage3(Stage4, f1_local5["lobbyRoot.publicLobby.stage"], function(f5_arg0)
		f1_arg0:updateElementState(Stage2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:addElement(Stage2)
	self.Stage2 = Stage2
	Stage3 = CoD.DirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 399, 607, 0, 0, 8, 32)
	Stage3:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueLessThan("lobbyRoot.publicLobby.stage", 3)
			end,
		},
	})
	f1_local5 = Stage3
	Stage4 = Stage3.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	Stage4(f1_local5, f1_local6["lobbyRoot.publicLobby.stage"], function(f7_arg0)
		f1_arg0:updateElementState(Stage3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	self:addElement(Stage3)
	self.Stage3 = Stage3
	Stage4 = CoD.DirectorStagesPulsing.new(f1_arg0, f1_arg1, 0, 0, 5, 607, 0, 0, 8, 32)
	Stage4:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_51DE43899593E67E"))
	Stage4:setShaderVector(0, 0, 1, 0, 0)
	Stage4:setShaderVector(1, 1, 1, 1, 0)
	Stage4:setShaderVector(2, 0, 1, 0, 0)
	Stage4:setShaderVector(3, 0, 0, 0, 0)
	self:addElement(Stage4)
	self.Stage4 = Stage4
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThanEnum(f1_arg1, "lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_2)
			end,
		},
		{
			stateName = "PlayWaitingAnimation",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.publicLobby.waitingAnimation")
			end,
		},
	})
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local6, f1_local7["lobbyRoot.publicLobby.stage"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local6, f1_local7["lobbyRoot.publicLobby.waitingAnimation"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.publicLobby.waitingAnimation",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorStageIndicator.__resetProperties = function(f12_arg0)
	f12_arg0.Stage3:completeAnimation()
	f12_arg0.Stage2:completeAnimation()
	f12_arg0.Stage1:completeAnimation()
	f12_arg0.Stage4:completeAnimation()
	f12_arg0.Stage3:setAlpha(1)
	f12_arg0.Stage2:setAlpha(1)
	f12_arg0.Stage1:setAlpha(1)
	f12_arg0.Stage4:setAlpha(1)
	f12_arg0.Stage4:setShaderVector(0, 0, 1, 0, 0)
	f12_arg0.Stage4:setShaderVector(1, 1, 1, 1, 0)
	f12_arg0.Stage4:setShaderVector(2, 0, 1, 0, 0)
	f12_arg0.Stage4:setShaderVector(3, 0, 0, 0, 0)
end
CoD.DirectorStageIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.Stage1:completeAnimation()
			f14_arg0.Stage1:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Stage1)
			f14_arg0.Stage2:completeAnimation()
			f14_arg0.Stage2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Stage2)
			f14_arg0.Stage3:completeAnimation()
			f14_arg0.Stage3:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Stage3)
			f14_arg0.Stage4:completeAnimation()
			f14_arg0.Stage4:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Stage4)
		end,
	},
	PlayWaitingAnimation = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(750)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.Stage4:beginAnimation(750)
				f15_arg0.Stage4:setShaderVector(0, 1, 1.2, 0, 0)
				f15_arg0.Stage4:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Stage4:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.Stage4:completeAnimation()
			f15_arg0.Stage4:setShaderVector(0, -0.2, 0, 0, 0)
			f15_arg0.Stage4:setShaderVector(1, 0.1, 0.1, 0, 0)
			f15_arg0.Stage4:setShaderVector(2, 0, 1, 0, 0)
			f15_arg0.Stage4:setShaderVector(3, 0, 0, 0, 0)
			f15_local0(f15_arg0.Stage4)
			f15_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.DirectorStageIndicator.__onClose = function(f18_arg0)
	f18_arg0.Stage1:close()
	f18_arg0.Stage2:close()
	f18_arg0.Stage3:close()
	f18_arg0.Stage4:close()
end

require("ui/uieditor/widgets/battlenet/frontendbattlenet")
require("ui/uieditor/widgets/emptyfocusable")
CoD.FrontendBattlenetContainer = InheritFrom(LUI.UIElement)
CoD.FrontendBattlenetContainer.__defaultWidth = 436
CoD.FrontendBattlenetContainer.__defaultHeight = 780
CoD.FrontendBattlenetContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PCUtility.StartAddingSticky(f1_arg0, self)
	CoD.PCBattlenetUtility.PreSetupMenuBattlenet(self, f1_arg0, f1_arg1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.FrontendBattlenetContainer)
	self.id = "FrontendBattlenetContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, -0.5, 444.5, 0, 0, 0, 780)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local FrontendBattlenet = CoD.FrontendBattlenet.new(f1_arg0, f1_arg1, 0, 0, 0, 436, 0, 0, 0, 780)
	self:addElement(FrontendBattlenet)
	self.FrontendBattlenet = FrontendBattlenet
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCBattlenetUtility.MenuBattlenetIsActive(f1_arg1)
			end,
		},
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine.GetModelForController(f1_arg1)
	f1_local4(f1_local3, f1_local5["PC.BattlenetGlobal.BattlenetMenuVisibility"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "PC.BattlenetGlobal.BattlenetMenuVisibility",
		})
	end, false)
	self.__on_menuOpened_self = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = self
		if IsElementReceivingMenuOpenEventForTheFirstTime(self) then
			CoD.PCUtility.SetupPositionOverrideForWZEndGame(self)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	emptyFocusable.id = "emptyFocusable"
	FrontendBattlenet.id = "FrontendBattlenet"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	CoD.PCUtility.StopAddingSticky(f1_arg0)
	return self
end
CoD.FrontendBattlenetContainer.__resetProperties = function(f7_arg0)
	f7_arg0.FrontendBattlenet:completeAnimation()
	f7_arg0.emptyFocusable:completeAnimation()
	f7_arg0.FrontendBattlenet:setAlpha(1)
	f7_arg0.emptyFocusable:setAlpha(1)
end
CoD.FrontendBattlenetContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.emptyFocusable:completeAnimation()
			f9_arg0.emptyFocusable:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.emptyFocusable)
			f9_arg0.FrontendBattlenet:completeAnimation()
			f9_arg0.FrontendBattlenet:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.FrontendBattlenet)
		end,
	},
	Invisible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.emptyFocusable:completeAnimation()
			f10_arg0.emptyFocusable:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.emptyFocusable)
			f10_arg0.FrontendBattlenet:completeAnimation()
			f10_arg0.FrontendBattlenet:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FrontendBattlenet)
		end,
	},
}
CoD.FrontendBattlenetContainer.__onClose = function(f11_arg0)
	f11_arg0.__on_close_removeOverrides()
	f11_arg0.emptyFocusable:close()
	f11_arg0.FrontendBattlenet:close()
end

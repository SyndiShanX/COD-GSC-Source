require("ui/uieditor/widgets/systemoverlays/featureoverlay_button_container")
CoD.featureOverlay_Button_MouseOnly = InheritFrom(LUI.UIElement)
CoD.featureOverlay_Button_MouseOnly.__defaultWidth = 160
CoD.featureOverlay_Button_MouseOnly.__defaultHeight = 60
CoD.featureOverlay_Button_MouseOnly.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.featureOverlay_Button_MouseOnly)
	self.id = "featureOverlay_Button_MouseOnly"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local featureOverlayButtonContainer = CoD.featureOverlay_Button_Container.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	featureOverlayButtonContainer:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			featureOverlayButtonContainer.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(featureOverlayButtonContainer)
	self.featureOverlayButtonContainer = featureOverlayButtonContainer
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	featureOverlayButtonContainer.id = "featureOverlayButtonContainer"
	self.__defaultFocus = featureOverlayButtonContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.featureOverlay_Button_MouseOnly.__resetProperties = function(f6_arg0)
	f6_arg0.featureOverlayButtonContainer:completeAnimation()
	f6_arg0.featureOverlayButtonContainer:setAlpha(1)
end
CoD.featureOverlay_Button_MouseOnly.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.featureOverlayButtonContainer:completeAnimation()
			f7_arg0.featureOverlayButtonContainer:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.featureOverlayButtonContainer)
		end,
	},
	Hide = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.featureOverlayButtonContainer:completeAnimation()
			f8_arg0.featureOverlayButtonContainer:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.featureOverlayButtonContainer)
		end,
	},
}
CoD.featureOverlay_Button_MouseOnly.__onClose = function(f9_arg0)
	f9_arg0.featureOverlayButtonContainer:close()
end

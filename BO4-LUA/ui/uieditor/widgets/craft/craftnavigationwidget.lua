require("x64:a86bdd41c06859a")
require("x64:2174e18747a4d29")
CoD.CraftNavigationWidget = InheritFrom(LUI.UIElement)
CoD.CraftNavigationWidget.__defaultWidth = 400
CoD.CraftNavigationWidget.__defaultHeight = 50
CoD.CraftNavigationWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftNavigationWidget)
	self.id = "CraftNavigationWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeftStickPagination = CoD.LeftStickPagination.new(f1_arg0, f1_arg1, 0, 0, 160, 240, 0, 0, 10, 40)
	self:addElement(LeftStickPagination)
	self.LeftStickPagination = LeftStickPagination
	local ChangeLayerPrompt = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 7, 43)
	ChangeLayerPrompt:setAlpha(0)
	ChangeLayerPrompt.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_674E5E31461D378F"))
	ChangeLayerPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_lr_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ChangeLayerPrompt.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ChangeLayerPrompt)
	self.ChangeLayerPrompt = ChangeLayerPrompt
	self:mergeStateConditions({
		{
			stateName = "EditMode",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEditMode(f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["Emblem.EmblemProperties.editorMode"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CraftNavigationWidget.__resetProperties = function(f5_arg0)
	f5_arg0.ChangeLayerPrompt:completeAnimation()
	f5_arg0.LeftStickPagination:completeAnimation()
	f5_arg0.ChangeLayerPrompt:setAlpha(0)
	f5_arg0.LeftStickPagination:setAlpha(1)
end
CoD.CraftNavigationWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	EditMode = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.LeftStickPagination:completeAnimation()
			f7_arg0.LeftStickPagination:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.LeftStickPagination)
			f7_arg0.ChangeLayerPrompt:completeAnimation()
			f7_arg0.ChangeLayerPrompt:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.ChangeLayerPrompt)
		end,
	},
}
CoD.CraftNavigationWidget.__onClose = function(f8_arg0)
	f8_arg0.LeftStickPagination:close()
	f8_arg0.ChangeLayerPrompt:close()
end

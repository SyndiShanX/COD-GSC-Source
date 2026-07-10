CoD.MinimapDetected = InheritFrom(LUI.UIElement)
CoD.MinimapDetected.__defaultWidth = 56
CoD.MinimapDetected.__defaultHeight = 56
CoD.MinimapDetected.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "huditems.isExposedOnMinimap", 0)
	self:setClass(CoD.MinimapDetected)
	self.id = "MinimapDetected"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IconDetected = LUI.UIImage.new(0.5, 0.5, -28, 28, 0.5, 0.5, -28, 28)
	IconDetected:setImage(RegisterImage(@"uie_icon_minimap_detected"))
	self:addElement(IconDetected)
	self.IconDetected = IconDetected
	self:mergeStateConditions({
		{
			stateName = "Detected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "huditems.isExposedOnMinimap", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["huditems.isExposedOnMinimap"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "huditems.isExposedOnMinimap",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MinimapDetected.__resetProperties = function(f4_arg0)
	f4_arg0.IconDetected:completeAnimation()
	f4_arg0.IconDetected:setAlpha(1)
end
CoD.MinimapDetected.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.IconDetected:completeAnimation()
			f5_arg0.IconDetected:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.IconDetected)
		end,
	},
	Detected = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}

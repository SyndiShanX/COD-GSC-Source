CoD.DemoHighlightReel = InheritFrom(LUI.UIElement)
CoD.DemoHighlightReel.__defaultWidth = 1920
CoD.DemoHighlightReel.__defaultHeight = 1080
CoD.DemoHighlightReel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoHighlightReel)
	self.id = "DemoHighlightReel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PreviewWindow = LUI.UIImage.new(0, 0, 441.5, 1478.5, 0, 0, 227, 818)
	PreviewWindow:setAlpha(0)
	self:addElement(PreviewWindow)
	self.PreviewWindow = PreviewWindow
	self:mergeStateConditions({
		{
			stateName = "CreatingHighlightReel",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToEnum("demo.highlightReelState", Enum[@"hash_4EB82E0DD701A3F3"][@"hash_2F7198EF39E4E502"])
			end,
		},
		{
			stateName = "PreviewingHighlightReel",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToEnum("demo.highlightReelState", Enum[@"hash_4EB82E0DD701A3F3"][@"hash_7C9A4DA5E1B04A3B"])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["demo.highlightReelState"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "demo.highlightReelState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsSelfInState(self, "CreatingHighlightReel") then
			CoD.DemoUtility.SetupHighlightReelPreviewWindow(self, self.PreviewWindow, controller)
		elseif IsSelfInState(self, "PreviewingHighlightReel") then
			CoD.DemoUtility.RestoreNormalViewport(self, controller)
		elseif IsSelfInState(self, "DefaultState") then
			CoD.DemoUtility.RestoreNormalViewport(self, controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = PreviewWindow
	return self
end
CoD.DemoHighlightReel.__onClose = function(f6_arg0)
	f6_arg0.PreviewWindow:close()
end

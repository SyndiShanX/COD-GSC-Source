require("x64:12d3ff0a1b8cdca")
CoD.WarzoneUseTimerDynentProgress = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerDynentProgress.__defaultWidth = 480
CoD.WarzoneUseTimerDynentProgress.__defaultHeight = 18
CoD.WarzoneUseTimerDynentProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneUseTimerDynentProgress)
	self.id = "WarzoneUseTimerDynentProgress"
	self.soundSet = "default"
	local useProgress = CoD.WarzoneUseTimerProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -240, 240, 0.5, 0.5, -9, 9)
	useProgress:subscribeToGlobalModel(f1_arg1, "HUDItems", "dynEntUseHoldProgress", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			useProgress.progressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(useProgress)
	self.useProgress = useProgress
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneUseTimerDynentProgress.__onClose = function(f3_arg0)
	f3_arg0.useProgress:close()
end

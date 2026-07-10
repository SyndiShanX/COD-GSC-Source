require("x64:43a18b0c952dcc0")
CoD.DupeMeterSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.DupeMeterSafeAreaContainer.__defaultWidth = 1920
CoD.DupeMeterSafeAreaContainer.__defaultHeight = 1080
CoD.DupeMeterSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DupeMeterSafeAreaContainer)
	self.id = "DupeMeterSafeAreaContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DupeMeter = CoD.DupeMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -835, -486, 1, 1, -115, -81)
	self:addElement(DupeMeter)
	self.DupeMeter = DupeMeter
	self:mergeStateConditions({
		{
			stateName = "PCKorea",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.IsInKorea()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DupeMeterSafeAreaContainer.__resetProperties = function(f3_arg0)
	f3_arg0.DupeMeter:completeAnimation()
	f3_arg0.DupeMeter:setTopBottom(1, 1, -115, -81)
end
CoD.DupeMeterSafeAreaContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	PCKorea = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.DupeMeter:completeAnimation()
			f5_arg0.DupeMeter:setTopBottom(1, 1, -98, -64)
			f5_arg0.clipFinished(f5_arg0.DupeMeter)
		end,
	},
}
CoD.DupeMeterSafeAreaContainer.__onClose = function(f6_arg0)
	f6_arg0.DupeMeter:close()
end

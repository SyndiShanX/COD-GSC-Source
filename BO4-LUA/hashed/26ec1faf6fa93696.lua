CoD.timerWidget = InheritFrom(LUI.UIElement)
CoD.timerWidget.__defaultWidth = 248
CoD.timerWidget.__defaultHeight = 138
CoD.timerWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.timerWidget)
	self.id = "timerWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local timerBG = LUI.UIImage.new(0.5, 0.5, -152, 152, 0, 0, 7.5, 115.5)
	timerBG:setAlpha(0.75)
	timerBG:setImage(RegisterImage(@"uie_zm_timer_bg"))
	self:addElement(timerBG)
	self.timerBG = timerBG
	local Timer = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 39, 99)
	Timer:setRGB(0.96, 0.66, 0)
	Timer:setTTF("skorzhen")
	Timer:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	Timer:setShaderVector(0, 0.13, 0, 0, 0)
	Timer:setShaderVector(1, 0, 0, 0, 1)
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Timer:subscribeToGlobalModel(f1_arg1, "WarzoneGlobal", "srProtoTimer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Timer:setupEndTimer(f2_local0)
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	self:mergeStateConditions({
		{
			stateName = "CenteredTimerText",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.timerWidget.__onClose = function(f4_arg0)
	f4_arg0.Timer:close()
end

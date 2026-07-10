require("x64:cde4eb6b60deb3a")
CoD.WarzoneUseTimerBeingRevived = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerBeingRevived.__defaultWidth = 250
CoD.WarzoneUseTimerBeingRevived.__defaultHeight = 30
CoD.WarzoneUseTimerBeingRevived.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneUseTimerBeingRevived)
	self.id = "WarzoneUseTimerBeingRevived"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BeingRevivedText = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	BeingRevivedText:setText(Engine[0xF9F1239CFD921FE](0x632C924F3D7483F))
	BeingRevivedText:setTTF("ttmussels_regular")
	BeingRevivedText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	BeingRevivedText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	BeingRevivedText:setBackingType(1)
	BeingRevivedText:setBackingWidget(CoD.WarzoneUseTimerRevivePlayerBG, f1_arg0, f1_arg1)
	BeingRevivedText:setBackingXPadding(43)
	BeingRevivedText:setBackingYPadding(2)
	self.__on_menuOpened_BeingRevivedText = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = BeingRevivedText
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_BeingRevivedText)
	self:addElement(BeingRevivedText)
	self.BeingRevivedText = BeingRevivedText
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_BeingRevivedText)
	end
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneUseTimerBeingRevived.__resetProperties = function(f4_arg0)
	f4_arg0.BeingRevivedText:completeAnimation()
	f4_arg0.BeingRevivedText:setAlpha(1)
end
CoD.WarzoneUseTimerBeingRevived.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.BeingRevivedText:completeAnimation()
			f5_arg0.BeingRevivedText:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.BeingRevivedText)
		end,
	},
}

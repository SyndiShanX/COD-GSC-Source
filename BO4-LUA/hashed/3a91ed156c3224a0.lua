require("x64:94dab3a4d2d79b2")
CoD.WarzoneInventoryPickupNotification = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryPickupNotification.__defaultWidth = 910
CoD.WarzoneInventoryPickupNotification.__defaultHeight = 32
CoD.WarzoneInventoryPickupNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryPickupNotification)
	self.id = "WarzoneInventoryPickupNotification"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PickedUpText = LUI.UIText.new(0.5, 1.5, -455, -455, 1, 2, -37, -37)
	PickedUpText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PickedUpText:setTTF("ttmussels_regular")
	PickedUpText:setLetterSpacing(1)
	PickedUpText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PickedUpText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	PickedUpText:setBackingType(1)
	PickedUpText:setBackingWidget(CoD.Corner9Slice, f1_arg0, f1_arg1)
	PickedUpText:setBackingColor(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PickedUpText:setBackingAlpha(0.75)
	PickedUpText:setBackingXPadding(10)
	self:addElement(PickedUpText)
	self.PickedUpText = PickedUpText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.WZUtility.AddPickupNotificationWatcher(f1_arg1, self, self.PickedUpText)
	return self
end
CoD.WarzoneInventoryPickupNotification.__resetProperties = function(f2_arg0)
	f2_arg0.PickedUpText:completeAnimation()
	f2_arg0.PickedUpText:setAlpha(1)
end
CoD.WarzoneInventoryPickupNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.PickedUpText:completeAnimation()
			f3_arg0.PickedUpText:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.PickedUpText)
		end,
		PickUp = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						f7_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f7_arg0:setAlpha(0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f6_arg0:beginAnimation(700)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.PickedUpText:beginAnimation(300, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f4_arg0.PickedUpText:setAlpha(1)
				f4_arg0.PickedUpText:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.PickedUpText:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.PickedUpText:completeAnimation()
			f4_arg0.PickedUpText:setAlpha(0)
			f4_local0(f4_arg0.PickedUpText)
		end,
	},
}
CoD.WarzoneInventoryPickupNotification.__onClose = function(f8_arg0)
	f8_arg0.PickedUpText:close()
end

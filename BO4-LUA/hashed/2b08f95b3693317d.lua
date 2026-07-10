require("x64:5f52f313dfd0fe8")
CoD.BountyHunterAmmoBuy = InheritFrom(LUI.UIElement)
CoD.BountyHunterAmmoBuy.__defaultWidth = 280
CoD.BountyHunterAmmoBuy.__defaultHeight = 48
CoD.BountyHunterAmmoBuy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterAmmoBuy)
	self.id = "BountyHunterAmmoBuy"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BountyHunterAmmoBuyInternal = CoD.BountyHunterAmmoBuyInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	BountyHunterAmmoBuyInternal:linkToElementModel(self, nil, false, function(model)
		BountyHunterAmmoBuyInternal:setModel(model, f1_arg1)
	end)
	self:addElement(BountyHunterAmmoBuyInternal)
	self.BountyHunterAmmoBuyInternal = BountyHunterAmmoBuyInternal
	BountyHunterAmmoBuyInternal.id = "BountyHunterAmmoBuyInternal"
	self.__defaultFocus = BountyHunterAmmoBuyInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterAmmoBuy.__resetProperties = function(f3_arg0)
	f3_arg0.BountyHunterAmmoBuyInternal:completeAnimation()
	f3_arg0.BountyHunterAmmoBuyInternal:setScale(1, 1)
end
CoD.BountyHunterAmmoBuy.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.BountyHunterAmmoBuyInternal:completeAnimation()
			f5_arg0.BountyHunterAmmoBuyInternal:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.BountyHunterAmmoBuyInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.BountyHunterAmmoBuyInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f6_arg0.BountyHunterAmmoBuyInternal:setScale(1.05, 1.05)
				f6_arg0.BountyHunterAmmoBuyInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.BountyHunterAmmoBuyInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.BountyHunterAmmoBuyInternal:completeAnimation()
			f6_arg0.BountyHunterAmmoBuyInternal:setScale(1, 1)
			f6_local0(f6_arg0.BountyHunterAmmoBuyInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.BountyHunterAmmoBuyInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f8_arg0.BountyHunterAmmoBuyInternal:setScale(1, 1)
				f8_arg0.BountyHunterAmmoBuyInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.BountyHunterAmmoBuyInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.BountyHunterAmmoBuyInternal:completeAnimation()
			f8_arg0.BountyHunterAmmoBuyInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.BountyHunterAmmoBuyInternal)
		end,
	},
}
CoD.BountyHunterAmmoBuy.__onClose = function(f10_arg0)
	f10_arg0.BountyHunterAmmoBuyInternal:close()
end

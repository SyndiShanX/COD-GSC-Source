require("x64:2c1cd57a4156647")
CoD.BountyHunterGenericBuy = InheritFrom(LUI.UIElement)
CoD.BountyHunterGenericBuy.__defaultWidth = 127
CoD.BountyHunterGenericBuy.__defaultHeight = 127
CoD.BountyHunterGenericBuy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterGenericBuy)
	self.id = "BountyHunterGenericBuy"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BountyHunterGenericBuyInternal = CoD.BountyHunterGenericBuyInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	BountyHunterGenericBuyInternal:linkToElementModel(self, nil, false, function(model)
		BountyHunterGenericBuyInternal:setModel(model, f1_arg1)
	end)
	self:addElement(BountyHunterGenericBuyInternal)
	self.BountyHunterGenericBuyInternal = BountyHunterGenericBuyInternal
	local Header = LUI.UIText.new(0, 0, 3, 127, 0, 0, -21, -4)
	Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Header:setTTF("ttmussels_demibold")
	Header:setLetterSpacing(2)
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Header)
	self.Header = Header
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.BountyHunterUtility.SetCurrentPreviewedPackage(self, f1_arg0)
	end)
	BountyHunterGenericBuyInternal.id = "BountyHunterGenericBuyInternal"
	self.__defaultFocus = BountyHunterGenericBuyInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterGenericBuy.__resetProperties = function(f4_arg0)
	f4_arg0.BountyHunterGenericBuyInternal:completeAnimation()
	f4_arg0.BountyHunterGenericBuyInternal:setScale(1, 1)
end
CoD.BountyHunterGenericBuy.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.BountyHunterGenericBuyInternal:completeAnimation()
			f6_arg0.BountyHunterGenericBuyInternal:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.BountyHunterGenericBuyInternal)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.BountyHunterGenericBuyInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f7_arg0.BountyHunterGenericBuyInternal:setScale(1.05, 1.05)
				f7_arg0.BountyHunterGenericBuyInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.BountyHunterGenericBuyInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.BountyHunterGenericBuyInternal:completeAnimation()
			f7_arg0.BountyHunterGenericBuyInternal:setScale(1, 1)
			f7_local0(f7_arg0.BountyHunterGenericBuyInternal)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.BountyHunterGenericBuyInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f9_arg0.BountyHunterGenericBuyInternal:setScale(1, 1)
				f9_arg0.BountyHunterGenericBuyInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.BountyHunterGenericBuyInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.BountyHunterGenericBuyInternal:completeAnimation()
			f9_arg0.BountyHunterGenericBuyInternal:setScale(1.05, 1.05)
			f9_local0(f9_arg0.BountyHunterGenericBuyInternal)
		end,
	},
}
CoD.BountyHunterGenericBuy.__onClose = function(f11_arg0)
	f11_arg0.BountyHunterGenericBuyInternal:close()
end

require("x64:b7f9d0122db590")
CoD.LoadoutClassItemContainerSecondary = InheritFrom(LUI.UIElement)
CoD.LoadoutClassItemContainerSecondary.__defaultWidth = 374
CoD.LoadoutClassItemContainerSecondary.__defaultHeight = 310
CoD.LoadoutClassItemContainerSecondary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadoutClassItemContainerSecondary)
	self.id = "LoadoutClassItemContainerSecondary"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backgroundBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 13, 295)
	backgroundBlur:setRGB(0, 0, 0)
	backgroundBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	backgroundBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backgroundBlur)
	self.backgroundBlur = backgroundBlur
	local glow3 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 293, 362)
	glow3:setAlpha(0)
	glow3:setZRot(180)
	glow3:setImage(RegisterImage(@"hash_27B23E8B1ACF3472"))
	self:addElement(glow3)
	self.glow3 = glow3
	local ButtonImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 13, 295)
	ButtonImage:setRGB(0.07, 0.07, 0.07)
	ButtonImage:setAlpha(0.99)
	self:addElement(ButtonImage)
	self.ButtonImage = ButtonImage
	local itemImage = LUI.UIImage.new(0.5, 0.5, -186, 186, 0, 0, 81.5, 273.5)
	itemImage:linkToElementModel(self, "imageLarge", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			itemImage:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(itemImage)
	self.itemImage = itemImage
	local itemName = CoD.LoadoutClassItemName.new(f1_arg0, f1_arg1, 0, 0, 23, 407, 0, 0, 30, 74)
	itemName:linkToElementModel(self, nil, false, function(model)
		itemName:setModel(model, f1_arg1)
	end)
	self:addElement(itemName)
	self.itemName = itemName
	local ButtonTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 7)
	ButtonTop:setRGB(0.78, 0.74, 0.67)
	ButtonTop:setAlpha(0.4)
	self:addElement(ButtonTop)
	self.ButtonTop = ButtonTop
	local CornerLineTL01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 14, 20)
	CornerLineTL01:setRGB(0.38, 0.36, 0.33)
	self:addElement(CornerLineTL01)
	self.CornerLineTL01 = CornerLineTL01
	local CornerLineTR01 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 14, 20)
	CornerLineTR01:setRGB(0.38, 0.36, 0.33)
	self:addElement(CornerLineTR01)
	self.CornerLineTR01 = CornerLineTR01
	local LineTop01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 13, 14)
	LineTop01:setRGB(0.38, 0.36, 0.33)
	self:addElement(LineTop01)
	self.LineTop01 = LineTop01
	local LineBottom01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 294, 295)
	LineBottom01:setRGB(0.38, 0.36, 0.33)
	self:addElement(LineBottom01)
	self.LineBottom01 = LineBottom01
	local CornerDotBR02 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 294, 295)
	self:addElement(CornerDotBR02)
	self.CornerDotBR02 = CornerDotBR02
	local CornerDotBL02 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 294, 295)
	self:addElement(CornerDotBL02)
	self.CornerDotBL02 = CornerDotBL02
	local CornerDotTL01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 25, 26)
	self:addElement(CornerDotTL01)
	self.CornerDotTL01 = CornerDotTL01
	local CornerDotTR01 = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 25, 26)
	self:addElement(CornerDotTR01)
	self.CornerDotTR01 = CornerDotTR01
	local glow2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -61, 8)
	glow2:setAlpha(0)
	glow2:setImage(RegisterImage(@"hash_6C3B2316BAE91099"))
	self:addElement(glow2)
	self.glow2 = glow2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadoutClassItemContainerSecondary.__resetProperties = function(f4_arg0)
	f4_arg0.itemName:completeAnimation()
	f4_arg0.glow2:completeAnimation()
	f4_arg0.glow3:completeAnimation()
	f4_arg0.ButtonImage:completeAnimation()
	f4_arg0.itemName:setRGB(1, 1, 1)
	f4_arg0.glow2:setAlpha(0)
	f4_arg0.glow3:setAlpha(0)
	f4_arg0.ButtonImage:setRGB(0.07, 0.07, 0.07)
	f4_arg0.ButtonImage:setAlpha(0.99)
end
CoD.LoadoutClassItemContainerSecondary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.glow3:completeAnimation()
			f6_arg0.glow3:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.glow3)
			f6_arg0.ButtonImage:completeAnimation()
			f6_arg0.ButtonImage:setRGB(0.1, 0.1, 0.1)
			f6_arg0.ButtonImage:setAlpha(0.99)
			f6_arg0.clipFinished(f6_arg0.ButtonImage)
			f6_arg0.itemName:completeAnimation()
			f6_arg0.itemName:setRGB(0.92, 0.89, 0.72)
			f6_arg0.clipFinished(f6_arg0.itemName)
			f6_arg0.glow2:completeAnimation()
			f6_arg0.glow2:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.glow2)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			local f7_local0 = function(f8_arg0)
				f7_arg0.glow3:beginAnimation(100)
				f7_arg0.glow3:setAlpha(1)
				f7_arg0.glow3:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.glow3:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.glow3:completeAnimation()
			f7_arg0.glow3:setAlpha(0)
			f7_local0(f7_arg0.glow3)
			local f7_local1 = function(f9_arg0)
				f7_arg0.ButtonImage:beginAnimation(100)
				f7_arg0.ButtonImage:setRGB(0.1, 0.1, 0.1)
				f7_arg0.ButtonImage:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ButtonImage:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ButtonImage:completeAnimation()
			f7_arg0.ButtonImage:setRGB(0.07, 0.07, 0.07)
			f7_arg0.ButtonImage:setAlpha(0.99)
			f7_local1(f7_arg0.ButtonImage)
			local f7_local2 = function(f10_arg0)
				f7_arg0.itemName:beginAnimation(100)
				f7_arg0.itemName:setRGB(0.92, 0.89, 0.72)
				f7_arg0.itemName:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.itemName:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.itemName:completeAnimation()
			f7_arg0.itemName:setRGB(1, 1, 1)
			f7_local2(f7_arg0.itemName)
			local f7_local3 = function(f11_arg0)
				f7_arg0.glow2:beginAnimation(100)
				f7_arg0.glow2:setAlpha(1)
				f7_arg0.glow2:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.glow2:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.glow2:completeAnimation()
			f7_arg0.glow2:setAlpha(0)
			f7_local3(f7_arg0.glow2)
		end,
		LoseFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			local f12_local0 = function(f13_arg0)
				f12_arg0.glow3:beginAnimation(100)
				f12_arg0.glow3:setAlpha(0)
				f12_arg0.glow3:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.glow3:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.glow3:completeAnimation()
			f12_arg0.glow3:setAlpha(1)
			f12_local0(f12_arg0.glow3)
			local f12_local1 = function(f14_arg0)
				f12_arg0.ButtonImage:beginAnimation(100)
				f12_arg0.ButtonImage:setRGB(0.07, 0.07, 0.07)
				f12_arg0.ButtonImage:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ButtonImage:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ButtonImage:completeAnimation()
			f12_arg0.ButtonImage:setRGB(0.1, 0.1, 0.1)
			f12_arg0.ButtonImage:setAlpha(0.99)
			f12_local1(f12_arg0.ButtonImage)
			local f12_local2 = function(f15_arg0)
				f12_arg0.itemName:beginAnimation(100)
				f12_arg0.itemName:setRGB(1, 1, 1)
				f12_arg0.itemName:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.itemName:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.itemName:completeAnimation()
			f12_arg0.itemName:setRGB(0.92, 0.89, 0.72)
			f12_local2(f12_arg0.itemName)
			local f12_local3 = function(f16_arg0)
				f12_arg0.glow2:beginAnimation(100)
				f12_arg0.glow2:setAlpha(0)
				f12_arg0.glow2:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.glow2:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.glow2:completeAnimation()
			f12_arg0.glow2:setAlpha(1)
			f12_local3(f12_arg0.glow2)
		end,
	},
}
CoD.LoadoutClassItemContainerSecondary.__onClose = function(f17_arg0)
	f17_arg0.itemImage:close()
	f17_arg0.itemName:close()
end

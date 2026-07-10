require("x64:19c1945d2e472b0")
CoD.MOTD_BannerImageText = InheritFrom(LUI.UIElement)
CoD.MOTD_BannerImageText.__defaultWidth = 356
CoD.MOTD_BannerImageText.__defaultHeight = 28
CoD.MOTD_BannerImageText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MOTD_BannerImageText)
	self.id = "MOTD_BannerImageText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local Title = LUI.UIText.new(0, 0, 3, 356, 0, 0, 3, 24)
	Title:setRGB(0.92, 0.92, 0.92)
	Title:setText("")
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(4)
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Title:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_middle"]))
	self:addElement(Title)
	self.Title = Title
	self:mergeStateConditions({
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_BannerImageText.__resetProperties = function(f3_arg0)
	f3_arg0.Title:completeAnimation()
	f3_arg0.Title:setLeftRight(0, 0, 3, 356)
	f3_arg0.Title:setAlpha(1)
end
CoD.MOTD_BannerImageText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Arabic = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Title:completeAnimation()
			f5_arg0.Title:setLeftRight(0, 0, -37, 316)
			f5_arg0.Title:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Title)
		end,
	},
}
CoD.MOTD_BannerImageText.__onClose = function(f6_arg0)
	f6_arg0.StoreCommonTextBacking:close()
end

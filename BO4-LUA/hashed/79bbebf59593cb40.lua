require("x64:55ac40d6fae7fb0")
CoD.MysteryItem = InheritFrom(LUI.UIElement)
CoD.MysteryItem.__defaultWidth = 240
CoD.MysteryItem.__defaultHeight = 510
CoD.MysteryItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MysteryItem)
	self.id = "MysteryItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OfferCard = LUI.UIImage.new(0.5, 0.5, -130, 130, 0.5, 0.5, -266, 266)
	OfferCard:setImage(RegisterImage(@"uie_ui_menu_mtx_card_offer"))
	self:addElement(OfferCard)
	self.OfferCard = OfferCard
	local RightPageOver = CoD.BumperButtonWithKeyMouseNoFocus.new(f1_arg0, f1_arg1, 0.5, 0.5, -33.5, 33.5, 0, 0, 436.5, 471.5)
	RightPageOver:setScale(0.8, 0.8)
	RightPageOver.KeyMouseImage:setImage(RegisterImage(@"uie_bumperright"))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	local RevealOfferText = LUI.UIText.new(0.5, 0.5, -112.5, 112.5, 0, 0, 417, 437)
	RevealOfferText:setText(LocalizeToUpperString(@"menu/reveal"))
	RevealOfferText:setTTF("ttmussels_demibold")
	RevealOfferText:setLetterSpacing(2)
	RevealOfferText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RevealOfferText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(RevealOfferText)
	self.RevealOfferText = RevealOfferText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MysteryItem.__resetProperties = function(f3_arg0)
	f3_arg0.RightPageOver:completeAnimation()
	f3_arg0.RevealOfferText:completeAnimation()
	f3_arg0.RightPageOver:setAlpha(1)
	f3_arg0.RevealOfferText:setAlpha(1)
end
CoD.MysteryItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	NoButtonPrompt = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.RightPageOver:completeAnimation()
			f5_arg0.RightPageOver:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RightPageOver)
			f5_arg0.RevealOfferText:completeAnimation()
			f5_arg0.RevealOfferText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RevealOfferText)
		end,
	},
}
CoD.MysteryItem.__onClose = function(f6_arg0)
	f6_arg0.RightPageOver:close()
end

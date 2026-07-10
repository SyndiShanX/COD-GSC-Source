require("x64:17c02756d343654")
CoD.ItemShopWeaponBribePreviewWidget = InheritFrom(LUI.UIElement)
CoD.ItemShopWeaponBribePreviewWidget.__defaultWidth = 450
CoD.ItemShopWeaponBribePreviewWidget.__defaultHeight = 500
CoD.ItemShopWeaponBribePreviewWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopWeaponBribePreviewWidget)
	self.id = "ItemShopWeaponBribePreviewWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local VideoPreview = LUI.UIImage.new(0, 0, 0, 450, 0, 0, 50, 500)
	VideoPreview:setImage(RegisterImage(@"hash_9FE3918D24562"))
	self:addElement(VideoPreview)
	self.VideoPreview = VideoPreview
	local WeaponBribePreviewPrompt = CoD.WeaponBribePreview.new(f1_arg0, f1_arg1, 0, 0, 19, 469, 0, 0, 461, 493)
	WeaponBribePreviewPrompt.Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WeaponBribePreviewPrompt.Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	WeaponBribePreviewPrompt.TitlePC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WeaponBribePreviewPrompt.TitlePC:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(WeaponBribePreviewPrompt)
	self.WeaponBribePreviewPrompt = WeaponBribePreviewPrompt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopWeaponBribePreviewWidget.__onClose = function(f2_arg0)
	f2_arg0.WeaponBribePreviewPrompt:close()
end

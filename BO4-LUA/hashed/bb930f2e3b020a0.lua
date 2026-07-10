require("x64:4d6f34106b3a73")
require("x64:c35813e5a1c5447")
require("x64:76fa323de4745ba")
CoD.ClassMiniPreviewWeaponItem = InheritFrom(LUI.UIElement)
CoD.ClassMiniPreviewWeaponItem.__defaultWidth = 240
CoD.ClassMiniPreviewWeaponItem.__defaultHeight = 70
CoD.ClassMiniPreviewWeaponItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClassMiniPreviewWeaponItem)
	self.id = "ClassMiniPreviewWeaponItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local noslotIcon = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	noslotIcon:setAlpha(0.02)
	noslotIcon:setScale(0.4, 0.4)
	noslotIcon:setImage(RegisterImage(@"uie_ui_menu_draft_attachment_noslot"))
	self:addElement(noslotIcon)
	self.noslotIcon = noslotIcon
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -19, 19)
	WeaponImage:setStretchedDimension(4)
	WeaponImage:linkToElementModel(self, "imageLarge", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local PrimaryAttachments = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	PrimaryAttachments:setLeftRight(0, 0, 65, 135)
	PrimaryAttachments:setTopBottom(0, 0, 60, 70)
	PrimaryAttachments:setAlpha(0)
	PrimaryAttachments:setScale(0.7, 0.7)
	PrimaryAttachments:setWidgetType(CoD.ClassMiniPreviewAttachmentPip)
	PrimaryAttachments:setHorizontalCount(6)
	PrimaryAttachments:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(PrimaryAttachments)
	self.PrimaryAttachments = PrimaryAttachments
	local RestrictedIcon = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -29, 21)
	RestrictedIcon:linkToElementModel(self, nil, false, function(model)
		RestrictedIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictedIcon)
	self.RestrictedIcon = RestrictedIcon
	local Mark2BonusExpBadgeInGame = CoD.Mark2BonusExpBadgeInGame.new(f1_arg0, f1_arg1, 0.5, 0.5, -97.5, 97.5, 0.5, 0.5, 16, 34)
	Mark2BonusExpBadgeInGame:linkToElementModel(self, nil, false, function(model)
		Mark2BonusExpBadgeInGame:setModel(model, f1_arg1)
	end)
	self:addElement(Mark2BonusExpBadgeInGame)
	self.Mark2BonusExpBadgeInGame = Mark2BonusExpBadgeInGame
	PrimaryAttachments.id = "PrimaryAttachments"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ClassMiniPreviewWeaponItem.__resetProperties = function(f5_arg0)
	f5_arg0.noslotIcon:completeAnimation()
	f5_arg0.WeaponImage:completeAnimation()
	f5_arg0.noslotIcon:setAlpha(0.02)
	f5_arg0.WeaponImage:setAlpha(1)
end
CoD.ClassMiniPreviewWeaponItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.noslotIcon:completeAnimation()
			f6_arg0.noslotIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.noslotIcon)
		end,
	},
	Unavailable = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.noslotIcon:completeAnimation()
			f7_arg0.noslotIcon:setAlpha(0.02)
			f7_arg0.clipFinished(f7_arg0.noslotIcon)
			f7_arg0.WeaponImage:completeAnimation()
			f7_arg0.WeaponImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.WeaponImage)
		end,
	},
}
CoD.ClassMiniPreviewWeaponItem.__onClose = function(f8_arg0)
	f8_arg0.WeaponImage:close()
	f8_arg0.PrimaryAttachments:close()
	f8_arg0.RestrictedIcon:close()
	f8_arg0.Mark2BonusExpBadgeInGame:close()
end

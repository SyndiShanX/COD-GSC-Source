require("x64:76fa323de4745ba")
CoD.ClassMiniPreviewEquipmentItem = InheritFrom(LUI.UIElement)
CoD.ClassMiniPreviewEquipmentItem.__defaultWidth = 80
CoD.ClassMiniPreviewEquipmentItem.__defaultHeight = 70
CoD.ClassMiniPreviewEquipmentItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClassMiniPreviewEquipmentItem)
	self.id = "ClassMiniPreviewEquipmentItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Dual1 = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 40, 0.5, 0.5, -15, 15)
	Dual1:setAlpha(0)
	Dual1:linkToElementModel(self, "primarygrenade.imageLarge", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Dual1:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(Dual1)
	self.Dual1 = Dual1
	local Single = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -35, 35)
	Single:linkToElementModel(self, "primarygrenade.imageLarge", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Single:setImage(CoD.BaseUtility.AlreadyRegistered(f3_local0))
		end
	end)
	self:addElement(Single)
	self.Single = Single
	local Dual2 = LUI.UIFixedAspectRatioImage.new(0, 0, 40, 80, 0.5, 0.5, -15, 15)
	Dual2:setAlpha(0)
	Dual2:linkToElementModel(self, "primarygrenadecount.imageLarge", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Dual2:setImage(CoD.BaseUtility.AlreadyRegistered(f4_local0))
		end
	end)
	self:addElement(Dual2)
	self.Dual2 = Dual2
	local noslotIcon = LUI.UIImage.new(0.5, 0.5, -25, 25, 0, 0, 10, 60)
	noslotIcon:setAlpha(0)
	noslotIcon:setScale(0.4, 0.4)
	noslotIcon:setImage(RegisterImage(0x35CB0919FD78E83))
	self:addElement(noslotIcon)
	self.noslotIcon = noslotIcon
	local noslotIcon2 = LUI.UIImage.new(0, 0, 34, 84, 0, 0, 10, 60)
	noslotIcon2:setAlpha(0)
	noslotIcon2:setScale(0.4, 0.4)
	noslotIcon2:setImage(RegisterImage(0x35CB0919FD78E83))
	self:addElement(noslotIcon2)
	self.noslotIcon2 = noslotIcon2
	local restrictedIcon = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -32.5, 32.5, 0.5, 0.5, -31.5, 23.5)
	self:addElement(restrictedIcon)
	self.restrictedIcon = restrictedIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ClassMiniPreviewEquipmentItem.__resetProperties = function(f5_arg0)
	f5_arg0.noslotIcon:completeAnimation()
	f5_arg0.noslotIcon2:completeAnimation()
	f5_arg0.Single:completeAnimation()
	f5_arg0.Dual1:completeAnimation()
	f5_arg0.Dual2:completeAnimation()
	f5_arg0.noslotIcon:setLeftRight(0.5, 0.5, -25, 25)
	f5_arg0.noslotIcon:setAlpha(0)
	f5_arg0.noslotIcon2:setLeftRight(0, 0, 34, 84)
	f5_arg0.noslotIcon2:setAlpha(0)
	f5_arg0.Single:setAlpha(1)
	f5_arg0.Dual1:setAlpha(0)
	f5_arg0.Dual2:setAlpha(0)
end
CoD.ClassMiniPreviewEquipmentItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Unavailable_Dual = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.Single:completeAnimation()
			f7_arg0.Single:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Single)
			f7_arg0.noslotIcon:completeAnimation()
			f7_arg0.noslotIcon:setLeftRight(0, 0, -4, 46)
			f7_arg0.noslotIcon:setAlpha(0.02)
			f7_arg0.clipFinished(f7_arg0.noslotIcon)
			f7_arg0.noslotIcon2:completeAnimation()
			f7_arg0.noslotIcon2:setLeftRight(0, 0, 34, 84)
			f7_arg0.noslotIcon2:setAlpha(0.02)
			f7_arg0.clipFinished(f7_arg0.noslotIcon2)
		end,
	},
	UnavailableSingle = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Single:completeAnimation()
			f8_arg0.Single:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Single)
			f8_arg0.noslotIcon:completeAnimation()
			f8_arg0.noslotIcon:setLeftRight(0, 0, 15, 65)
			f8_arg0.noslotIcon:setAlpha(0.02)
			f8_arg0.clipFinished(f8_arg0.noslotIcon)
		end,
	},
	TakeTwo = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.Dual1:completeAnimation()
			f9_arg0.Dual1:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Dual1)
			f9_arg0.Single:completeAnimation()
			f9_arg0.Single:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Single)
			f9_arg0.Dual2:completeAnimation()
			f9_arg0.Dual2:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Dual2)
		end,
	},
}
CoD.ClassMiniPreviewEquipmentItem.__onClose = function(f10_arg0)
	f10_arg0.Dual1:close()
	f10_arg0.Single:close()
	f10_arg0.Dual2:close()
	f10_arg0.restrictedIcon:close()
end

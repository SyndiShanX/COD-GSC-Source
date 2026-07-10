require("x64:1dd430b3d1a3a65")
CoD.AmmoWidget_OIC_Bullets = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_OIC_Bullets.__defaultWidth = 100
CoD.AmmoWidget_OIC_Bullets.__defaultHeight = 50
CoD.AmmoWidget_OIC_Bullets.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_OIC_Bullets)
	self.id = "AmmoWidget_OIC_Bullets"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AmmoCount = LUI.UIText.new(0, 0, 6, 94, 0, 0, 6.5, 43.5)
	AmmoCount:setRGB(1, 0.68, 0)
	AmmoCount.__String_Reference = function()
		AmmoCount:setText(CoD.HUDUtility.WeaponAmmoClipStockCombined(f1_arg1, 34))
	end
	AmmoCount.__String_Reference()
	AmmoCount:setTTF("default")
	AmmoCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	AmmoCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AmmoCount)
	self.AmmoCount = AmmoCount
	local BulletList = LUI.UIList.new(f1_arg0, f1_arg1, -2, 0, nil, false, false, false, false)
	BulletList:setLeftRight(0.5, 0.5, -46, 46)
	BulletList:setTopBottom(0, 0, 5, 45)
	BulletList:setWidgetType(CoD.AmmoWidget_OIC_bulletPip)
	BulletList:setHorizontalCount(5)
	BulletList:setSpacing(-2)
	BulletList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	BulletList:setDataSource("OneInTheChamberBulletList")
	self:addElement(BulletList)
	self.BulletList = BulletList
	local f1_local3 = AmmoCount
	local f1_local4 = AmmoCount.subscribeToModel
	local f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.ammoStock, AmmoCount.__String_Reference)
	f1_local3 = AmmoCount
	f1_local4 = AmmoCount.subscribeToModel
	f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.ammoInClip, AmmoCount.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "SurplusAmmo",
			condition = function(menu, element, event)
				return CoD.HUDUtility.TooMuchAmmo(f1_arg1, 5)
			end,
		},
	})
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.ammoStock, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ammoStock",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.ammoInClip, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ammoInClip",
		})
	end, false)
	BulletList.id = "BulletList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_OIC_Bullets.__resetProperties = function(f6_arg0)
	f6_arg0.AmmoCount:completeAnimation()
	f6_arg0.BulletList:completeAnimation()
	f6_arg0.AmmoCount:setAlpha(1)
	f6_arg0.BulletList:setAlpha(1)
end
CoD.AmmoWidget_OIC_Bullets.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.AmmoCount:completeAnimation()
			f7_arg0.AmmoCount:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.AmmoCount)
		end,
	},
	SurplusAmmo = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.BulletList:completeAnimation()
			f8_arg0.BulletList:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.BulletList)
		end,
	},
}
CoD.AmmoWidget_OIC_Bullets.__onClose = function(f9_arg0)
	f9_arg0.AmmoCount:close()
	f9_arg0.BulletList:close()
end

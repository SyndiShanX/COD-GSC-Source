require("x64:8024461f7066d0b")
require("x64:17c02756d343654")
CoD.ReservesPreviewContainer = InheritFrom(LUI.UIElement)
CoD.ReservesPreviewContainer.__defaultWidth = 400
CoD.ReservesPreviewContainer.__defaultHeight = 24
CoD.ReservesPreviewContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesPreviewContainer)
	self.id = "ReservesPreviewContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReservesPreview = CoD.ReservesPreview.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0.5, 0.5, -16, 16)
	self:addElement(ReservesPreview)
	self.ReservesPreview = ReservesPreview
	local WeaponBribePreview = CoD.WeaponBribePreview.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0.5, 0.5, -16, 16)
	WeaponBribePreview:setAlpha(0)
	self:addElement(WeaponBribePreview)
	self.WeaponBribePreview = WeaponBribePreview
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.CanShowReservesPreview(f1_arg1)
			end,
		},
		{
			stateName = "WeaponBribePreview",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.cycled, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesPreviewContainer.__resetProperties = function(f5_arg0)
	f5_arg0.ReservesPreview:completeAnimation()
	f5_arg0.WeaponBribePreview:completeAnimation()
	f5_arg0.ReservesPreview:setAlpha(1)
	f5_arg0.WeaponBribePreview:setAlpha(0)
end
CoD.ReservesPreviewContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ReservesPreview:completeAnimation()
			f7_arg0.ReservesPreview:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ReservesPreview)
		end,
	},
	WeaponBribePreview = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.ReservesPreview:completeAnimation()
			f8_arg0.ReservesPreview:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ReservesPreview)
			f8_arg0.WeaponBribePreview:completeAnimation()
			f8_arg0.WeaponBribePreview:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.WeaponBribePreview)
		end,
	},
}
CoD.ReservesPreviewContainer.__onClose = function(f9_arg0)
	f9_arg0.ReservesPreview:close()
	f9_arg0.WeaponBribePreview:close()
end

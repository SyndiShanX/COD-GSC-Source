require("x64:74862184d365f30")
require("x64:c9a3c9eb5d5ac59")
CoD.InspectionWeaponWidget = InheritFrom(LUI.UIElement)
CoD.InspectionWeaponWidget.__defaultWidth = 720
CoD.InspectionWeaponWidget.__defaultHeight = 331
CoD.InspectionWeaponWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionWeaponWidget)
	self.id = "InspectionWeaponWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBar = CoD.CommonSearchingBar.new(f1_arg0, f1_arg1, 0, 0, 505.5, 627.5, 0, 0, -5.5, 14.5)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local LayoutElement01 = CoD.CommonBgLayoutElement01.new(f1_arg0, f1_arg1, 0, 0, 483.5, 627.5, 0, 0, 288, 324)
	self:addElement(LayoutElement01)
	self.LayoutElement01 = LayoutElement01
	local GunRackTitleText = LUI.UIText.new(0, 0, 0, 250, 0, 0, -39, -18)
	GunRackTitleText:setRGB(0.92, 0.92, 0.92)
	GunRackTitleText:setAlpha(0.5)
	GunRackTitleText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/gun_rack"))
	GunRackTitleText:setTTF("ttmussels_regular")
	GunRackTitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GunRackTitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GunRackTitleText)
	self.GunRackTitleText = GunRackTitleText
	local WeaponName = LUI.UIText.new(0, 0, 1, 365, 0, 0, -12, 21)
	WeaponName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	WeaponName:setTTF("ttmussels_demibold")
	WeaponName:setLetterSpacing(12)
	WeaponName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WeaponName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	WeaponName:subscribeToGlobalModel(f1_arg1, "InspectionWeapon", "weaponIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponName:setText(GetLocalizedWeaponName(f2_local0))
		end
	end)
	self:addElement(WeaponName)
	self.WeaponName = WeaponName
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.None)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.rankMode"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.rankMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionWeaponWidget.__resetProperties = function(f5_arg0)
	f5_arg0.WeaponName:completeAnimation()
	f5_arg0.GunRackTitleText:completeAnimation()
	f5_arg0.WeaponName:setAlpha(1)
	f5_arg0.GunRackTitleText:setAlpha(0.5)
end
CoD.InspectionWeaponWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.GunRackTitleText:completeAnimation()
			f6_arg0.GunRackTitleText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GunRackTitleText)
			f6_arg0.WeaponName:completeAnimation()
			f6_arg0.WeaponName:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.WeaponName)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.GunRackTitleText:completeAnimation()
			f7_arg0.GunRackTitleText:setAlpha(0.5)
			f7_arg0.clipFinished(f7_arg0.GunRackTitleText)
			f7_arg0.WeaponName:completeAnimation()
			f7_arg0.WeaponName:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.WeaponName)
		end,
	},
}
CoD.InspectionWeaponWidget.__onClose = function(f8_arg0)
	f8_arg0.ProgressBar:close()
	f8_arg0.LayoutElement01:close()
	f8_arg0.WeaponName:close()
end

require("x64:99fcad07720b995")
require("x64:d5280de4167d115")
require("x64:a0759ae102bd981")
CoD.vhud_ms_Seating = InheritFrom(LUI.UIElement)
CoD.vhud_ms_Seating.__defaultWidth = 151
CoD.vhud_ms_Seating.__defaultHeight = 159
CoD.vhud_ms_Seating.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_Seating)
	self.id = "vhud_ms_Seating"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local msDamageFillBar = LUI.UIImage.new(0.5, 0.5, -58.5, 58.5, 0.5, 0.5, -55, 62)
	msDamageFillBar:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_damagefillbar"))
	msDamageFillBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	msDamageFillBar:setShaderVector(0, 0, 1, 0, 0)
	msDamageFillBar:setShaderVector(1, 0, 0, 0, 0)
	msDamageFillBar:setShaderVector(3, 0, 0, 0, 0)
	msDamageFillBar:setShaderVector(4, 0, 0, 0, 0)
	msDamageFillBar:linkToElementModel(self, "damage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			msDamageFillBar:setShaderVector(2, SetVectorComponent(2, 1, SubtractVectorComponentFrom(1, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))))
		end
	end)
	self:addElement(msDamageFillBar)
	self.msDamageFillBar = msDamageFillBar
	local damagedSideContainer = CoD.vhud_ms_DamageSideContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -47, 44, 0.5, 0.5, -38, 0)
	damagedSideContainer:linkToElementModel(self, "partDestroyed", false, function(model)
		damagedSideContainer:setModel(model, f1_arg1)
	end)
	self:addElement(damagedSideContainer)
	self.damagedSideContainer = damagedSideContainer
	local msSeating1 = LUI.UIImage.new(0.5, 0.5, -58.5, 58.5, 0.5, 0.5, -55, 62)
	msSeating1:setAlpha(0.3)
	msSeating1:setZoom(-15)
	msSeating1:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_damageline"))
	msSeating1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(msSeating1)
	self.msSeating1 = msSeating1
	local msSeating = LUI.UIImage.new(0.5, 0.5, -58.5, 58.5, 0.5, 0.5, -55, 62)
	msSeating:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_damageline"))
	msSeating:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(msSeating)
	self.msSeating = msSeating
	local msSeating0 = LUI.UIImage.new(0.5, 0.5, -58.5, 58.5, 0.5, 0.5, -55, 62)
	msSeating0:setAlpha(0.25)
	msSeating0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_damageline"))
	msSeating0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(msSeating0)
	self.msSeating0 = msSeating0
	local vhudmsNotificationSeatingSide = CoD.vhud_ms_NotificationSeatingSide.new(f1_arg0, f1_arg1, 0.5, 0.5, 13, 62, 0.5, 0.5, -30, -8)
	vhudmsNotificationSeatingSide:setAlpha(0)
	self:addElement(vhudmsNotificationSeatingSide)
	self.vhudmsNotificationSeatingSide = vhudmsNotificationSeatingSide
	local vhudmsNotificationSeatingSide0 = CoD.vhud_ms_NotificationSeatingSide.new(f1_arg0, f1_arg1, 0.5, 0.5, -66, -17, 0.5, 0.5, -30, -8)
	vhudmsNotificationSeatingSide0:setAlpha(0)
	vhudmsNotificationSeatingSide0:setYRot(180)
	self:addElement(vhudmsNotificationSeatingSide0)
	self.vhudmsNotificationSeatingSide0 = vhudmsNotificationSeatingSide0
	local vhudmsNotificationSeatingTop = CoD.vhud_ms_NotificationSeatingTop.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 12, 0.5, 0.5, -71, -29)
	self:addElement(vhudmsNotificationSeatingTop)
	self.vhudmsNotificationSeatingTop = vhudmsNotificationSeatingTop
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_Seating.__onClose = function(f4_arg0)
	f4_arg0.msDamageFillBar:close()
	f4_arg0.damagedSideContainer:close()
	f4_arg0.vhudmsNotificationSeatingSide:close()
	f4_arg0.vhudmsNotificationSeatingSide0:close()
	f4_arg0.vhudmsNotificationSeatingTop:close()
end

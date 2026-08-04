require("ui/uieditor/widgets/callingcards/callingcards_asset_dirtcar_shooter")
CoD.callingcards_ground_assault_master = InheritFrom(LUI.UIElement)
CoD.callingcards_ground_assault_master.__defaultWidth = 960
CoD.callingcards_ground_assault_master.__defaultHeight = 240
CoD.callingcards_ground_assault_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_ground_assault_master)
	self.id = "CallingCards_Ground_Assault_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	CardIcon:setImage(RegisterImage("uie_t7_icon_callingcard_temp2_lrg"))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial("uie_feather_blend"))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage("uie_driver_bg"))
	self:addElement(background)
	self.background = background
	local Dust = LUI.UIImage.new(0, 0, 160, 600, 0, 0, -325, 395)
	Dust:setZRot(57)
	Dust:setImage(RegisterImage("uie_dust_flow"))
	Dust:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	Dust:setShaderVector(0, 1, 1, 0, 0)
	Dust:setShaderVector(1, 0, 2, 0, 0)
	self:addElement(Dust)
	self.Dust = Dust
	local speedlines3 = LUI.UIImage.new(0, 0, -177, 960, 0, 0, -74.5, 314.5)
	speedlines3:setAlpha(0.5)
	speedlines3:setImage(RegisterImage("uie_3row_speedlines"))
	speedlines3:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	speedlines3:setShaderVector(0, 0, 2, 0, 0)
	speedlines3:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(speedlines3)
	self.speedlines3 = speedlines3
	local carSmoke = LUI.UIImage.new(0, 0, 247, 713, 0, 0, -198, 268)
	carSmoke:setZRot(67)
	carSmoke:setImage(RegisterImage("uie_car_smoke"))
	carSmoke:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_add"))
	carSmoke:setShaderVector(0, 0, 4, 0, 0)
	carSmoke:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(carSmoke)
	self.carSmoke = carSmoke
	local dude2 = CoD.CallingCards_Asset_dirtcar_shooter.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 250)
	self:addElement(dude2)
	self.dude2 = dude2
	local speedlines1 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	speedlines1:setAlpha(0.4)
	speedlines1:setImage(RegisterImage("uie_1row_speedlines"))
	speedlines1:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	speedlines1:setShaderVector(0, 0, 2, 0, 0)
	speedlines1:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(speedlines1)
	self.speedlines1 = speedlines1
	local speedlines2 = LUI.UIImage.new(0, 0, -169, 1623, 0, 0, -127, 125)
	speedlines2:setAlpha(0.4)
	speedlines2:setScale(1.25, 1.25)
	speedlines2:setImage(RegisterImage("uie_1row_speedlines"))
	speedlines2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	speedlines2:setShaderVector(0, 0, 2, 0, 0)
	speedlines2:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(speedlines2)
	self.speedlines2 = speedlines2
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage("uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_ground_assault_master.__resetProperties = function(f2_arg0)
	f2_arg0.dude2:completeAnimation()
	f2_arg0.dude2:setTopBottom(0, 0, 0, 250)
end
CoD.callingcards_ground_assault_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.dude2:playClip("DefaultClip")
				f3_arg0.dude2:beginAnimation(240)
				f3_arg0.dude2:setTopBottom(0, 0, -6, 244)
				f3_arg0.dude2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dude2:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f3_arg0.clipFinished(element, event)
				end)
			end
			f3_arg0.dude2:completeAnimation()
			f3_arg0.dude2:setTopBottom(0, 0, 0, 250)
			f3_local0(f3_arg0.dude2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_ground_assault_master.__onClose = function(f6_arg0)
	f6_arg0.dude2:close()
end

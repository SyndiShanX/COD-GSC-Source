require("x64:3eb34e82acd68cf")
CoD[0x12E15CAA184F593] = InheritFrom(LUI.UIElement)
CoD[0x12E15CAA184F593].__defaultWidth = 960
CoD[0x12E15CAA184F593].__defaultHeight = 240
CoD[0x12E15CAA184F593].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x12E15CAA184F593])
	self.id = "CallingCards_Ground_Assault_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIcon = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	CardIcon:setImage(RegisterImage(0x434A15996B65B48))
	CardIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0xD9DF933E7B717C9))
	self:addElement(background)
	self.background = background
	local Dust = LUI.UIImage.new(0, 0, 160, 600, 0, 0, -325, 395)
	Dust:setZRot(57)
	Dust:setImage(RegisterImage(0xAC4442169034D4))
	Dust:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	Dust:setShaderVector(0, 1, 1, 0, 0)
	Dust:setShaderVector(1, 0, 2, 0, 0)
	self:addElement(Dust)
	self.Dust = Dust
	local speedlines3 = LUI.UIImage.new(0, 0, -177, 960, 0, 0, -74.5, 314.5)
	speedlines3:setAlpha(0.5)
	speedlines3:setImage(RegisterImage(0x79638A2BCFAC8A3))
	speedlines3:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	speedlines3:setShaderVector(0, 0, 2, 0, 0)
	speedlines3:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(speedlines3)
	self.speedlines3 = speedlines3
	local carSmoke = LUI.UIImage.new(0, 0, 247, 713, 0, 0, -198, 268)
	carSmoke:setZRot(67)
	carSmoke:setImage(RegisterImage(0x40903C2A0783D51))
	carSmoke:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	carSmoke:setShaderVector(0, 0, 4, 0, 0)
	carSmoke:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(carSmoke)
	self.carSmoke = carSmoke
	local dude2 = CoD.CallingCards_Asset_dirtcar_shooter.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 250)
	self:addElement(dude2)
	self.dude2 = dude2
	local speedlines1 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	speedlines1:setAlpha(0.4)
	speedlines1:setImage(RegisterImage(0xD56D3EAF53D26DD))
	speedlines1:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	speedlines1:setShaderVector(0, 0, 2, 0, 0)
	speedlines1:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(speedlines1)
	self.speedlines1 = speedlines1
	local speedlines2 = LUI.UIImage.new(0, 0, -169, 1623, 0, 0, -127, 125)
	speedlines2:setAlpha(0.4)
	speedlines2:setScale(1.25, 1.25)
	speedlines2:setImage(RegisterImage(0xD56D3EAF53D26DD))
	speedlines2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	speedlines2:setShaderVector(0, 0, 2, 0, 0)
	speedlines2:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(speedlines2)
	self.speedlines2 = speedlines2
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x12E15CAA184F593].__resetProperties = function(f2_arg0)
	f2_arg0.dude2:completeAnimation()
	f2_arg0.dude2:setTopBottom(0, 0, 0, 250)
end
CoD[0x12E15CAA184F593].__clipsPerState = {
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
CoD[0x12E15CAA184F593].__onClose = function(f6_arg0)
	f6_arg0.dude2:close()
end

CoD.vhud_tank_robot_target_status = InheritFrom(LUI.UIElement)
CoD.vhud_tank_robot_target_status.__defaultWidth = 300
CoD.vhud_tank_robot_target_status.__defaultHeight = 100
CoD.vhud_tank_robot_target_status.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_tank_robot_target_status)
	self.id = "vhud_tank_robot_target_status"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TargetLockedBacking = LUI.UIImage.new(0, 0, 0, 300, 0, 0, 53.5, 92.5)
	TargetLockedBacking:setRGB(0, 0, 0)
	TargetLockedBacking:setAlpha(0.25)
	self:addElement(TargetLockedBacking)
	self.TargetLockedBacking = TargetLockedBacking
	local TargetIdentifiedBacking = LUI.UIImage.new(0, 0, 0, 300, 0, 0, 10.5, 49.5)
	TargetIdentifiedBacking:setRGB(0, 0, 0)
	TargetIdentifiedBacking:setAlpha(0.25)
	self:addElement(TargetIdentifiedBacking)
	self.TargetIdentifiedBacking = TargetIdentifiedBacking
	local TargetIdentified = LUI.UIText.new(0, 0, 0.5, 300.5, 0, 0, 13, 45)
	TargetIdentified:setText(Engine[0xF9F1239CFD921FE](0x2721ED0264B5F06))
	TargetIdentified:setTTF("ttmussels_regular")
	TargetIdentified:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TargetIdentified:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TargetIdentified)
	self.TargetIdentified = TargetIdentified
	local TargetLocked = LUI.UIText.new(0, 0, 0.5, 300.5, 0, 0, 57, 89)
	TargetLocked:setText(Engine[0xF9F1239CFD921FE](0xD2DCC0FA9B3BC61))
	TargetLocked:setTTF("ttmussels_regular")
	TargetLocked:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TargetLocked:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TargetLocked)
	self.TargetLocked = TargetLocked
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_tank_robot_target_status.__resetProperties = function(f2_arg0)
	f2_arg0.TargetLockedBacking:completeAnimation()
	f2_arg0.TargetIdentifiedBacking:completeAnimation()
	f2_arg0.TargetLockedBacking:setRGB(0, 0, 0)
	f2_arg0.TargetIdentifiedBacking:setRGB(0, 0, 0)
end
CoD.vhud_tank_robot_target_status.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	TargetLocked = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TargetLockedBacking:completeAnimation()
			f4_arg0.TargetLockedBacking:setRGB(1, 0, 0)
			f4_arg0.clipFinished(f4_arg0.TargetLockedBacking)
		end,
	},
	TargetIdentified = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.TargetIdentifiedBacking:completeAnimation()
			f5_arg0.TargetIdentifiedBacking:setRGB(1, 0, 0)
			f5_arg0.clipFinished(f5_arg0.TargetIdentifiedBacking)
		end,
	},
}

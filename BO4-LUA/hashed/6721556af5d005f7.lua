CoD.SpawnRegionAutoSpawn = InheritFrom(LUI.UIElement)
CoD.SpawnRegionAutoSpawn.__defaultWidth = 80
CoD.SpawnRegionAutoSpawn.__defaultHeight = 80
CoD.SpawnRegionAutoSpawn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnRegionAutoSpawn)
	self.id = "SpawnRegionAutoSpawn"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DangerBacking = LUI.UIImage.new(0, 0, -16.5, 96.5, 0, 0, 66, 90)
	DangerBacking:setRGB(0.1, 0.1, 0.1)
	DangerBacking:setAlpha(0)
	self:addElement(DangerBacking)
	self.DangerBacking = DangerBacking
	local DangerText = LUI.UIText.new(0, 0, -39.5, 119.5, 0, 0, 68, 88)
	DangerText:setRGB(1, 0, 0)
	DangerText:setAlpha(0)
	DangerText:setText(Engine[0xF9F1239CFD921FE](0x57915A72383BA7C))
	DangerText:setTTF("ttmussels_demibold")
	DangerText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DangerText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DangerText)
	self.DangerText = DangerText
	local iconFrameBacking = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	iconFrameBacking:setAlpha(0)
	iconFrameBacking:setImage(RegisterImage(0x6BAB388F74F4130))
	self:addElement(iconFrameBacking)
	self.iconFrameBacking = iconFrameBacking
	local iconFrameSelected = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	iconFrameSelected:setAlpha(0)
	iconFrameSelected:setImage(RegisterImage(0xBDB803803D3EBB8))
	self:addElement(iconFrameSelected)
	self.iconFrameSelected = iconFrameSelected
	local iconFrame = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	iconFrame:setAlpha(0)
	iconFrame:setImage(RegisterImage(0xC8EC26A4504B31))
	iconFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(iconFrame)
	self.iconFrame = iconFrame
	local AutoSpawnIcon = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	AutoSpawnIcon:setImage(RegisterImage(0x453ECA2D605AA1E))
	self:addElement(AutoSpawnIcon)
	self.AutoSpawnIcon = AutoSpawnIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnRegionAutoSpawn.__resetProperties = function(f2_arg0)
	f2_arg0.iconFrame:completeAnimation()
	f2_arg0.iconFrameSelected:completeAnimation()
	f2_arg0.iconFrameBacking:completeAnimation()
	f2_arg0.iconFrame:setAlpha(0)
	f2_arg0.iconFrameSelected:setAlpha(0)
	f2_arg0.iconFrameBacking:setAlpha(0)
end
CoD.SpawnRegionAutoSpawn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.iconFrameBacking:completeAnimation()
			f3_arg0.iconFrameBacking:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.iconFrameBacking)
			f3_arg0.iconFrameSelected:completeAnimation()
			f3_arg0.iconFrameSelected:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.iconFrameSelected)
			f3_arg0.iconFrame:completeAnimation()
			f3_arg0.iconFrame:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.iconFrame)
		end,
	},
}

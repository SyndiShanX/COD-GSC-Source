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
	DangerText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_357915A72383BA7C"))
	DangerText:setTTF("ttmussels_demibold")
	DangerText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DangerText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DangerText)
	self.DangerText = DangerText
	local iconFrameBacking = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	iconFrameBacking:setAlpha(0)
	iconFrameBacking:setImage(RegisterImage(@"uie_ui_hud_selectspawn_point_bg"))
	self:addElement(iconFrameBacking)
	self.iconFrameBacking = iconFrameBacking
	local iconFrameSelected = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	iconFrameSelected:setAlpha(0)
	iconFrameSelected:setImage(RegisterImage(@"uie_ui_hud_selectspawn_point_pulse"))
	self:addElement(iconFrameSelected)
	self.iconFrameSelected = iconFrameSelected
	local iconFrame = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	iconFrame:setAlpha(0)
	iconFrame:setImage(RegisterImage(@"uie_ui_hud_selectspawn_point_boundary"))
	iconFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(iconFrame)
	self.iconFrame = iconFrame
	local AutoSpawnIcon = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	AutoSpawnIcon:setImage(RegisterImage(@"uie_ui_hud_selectspawn_point_icon"))
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

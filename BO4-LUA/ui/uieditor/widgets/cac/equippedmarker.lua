CoD.EquippedMarker = InheritFrom(LUI.UIElement)
CoD.EquippedMarker.__defaultWidth = 44
CoD.EquippedMarker.__defaultHeight = 44
CoD.EquippedMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EquippedMarker)
	self.id = "EquippedMarker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -44, 0, 0, 0, 0, 44)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_bg"))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -44, 0, 0, 0, 0, 44)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EquippedMarker.__resetProperties = function(f2_arg0)
	f2_arg0.EquippedMarkerBG:completeAnimation()
	f2_arg0.EquippedMarkerTick:completeAnimation()
	f2_arg0.EquippedMarkerBG:setAlpha(0)
	f2_arg0.EquippedMarkerTick:setAlpha(0)
end
CoD.EquippedMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Equipped = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.EquippedMarkerBG:completeAnimation()
			f4_arg0.EquippedMarkerBG:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.EquippedMarkerBG)
			f4_arg0.EquippedMarkerTick:completeAnimation()
			f4_arg0.EquippedMarkerTick:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.EquippedMarkerTick)
		end,
	},
}

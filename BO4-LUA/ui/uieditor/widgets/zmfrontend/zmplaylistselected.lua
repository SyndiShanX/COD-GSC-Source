CoD.ZMPlaylistSelected = InheritFrom(LUI.UIElement)
CoD.ZMPlaylistSelected.__defaultWidth = 17
CoD.ZMPlaylistSelected.__defaultHeight = 16
CoD.ZMPlaylistSelected.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMPlaylistSelected)
	self.id = "ZMPlaylistSelected"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local equippedIcon = LUI.UIImage.new(0.5, 0.5, -8.5, 8.5, 0.5, 0.5, -8, 8)
	equippedIcon:setRGB(0.56, 0.68, 0.27)
	equippedIcon:setAlpha(0)
	equippedIcon:setImage(RegisterImage(@"hash_1B0337CBFC61A7A2"))
	self:addElement(equippedIcon)
	self.equippedIcon = equippedIcon
	local EquippedMarkerTick2 = LUI.UIImage.new(1, 1, -146, 14, 0, 0, -21, 139)
	EquippedMarkerTick2:setAlpha(0)
	EquippedMarkerTick2:setImage(RegisterImage(@"uie_ui_menu_zombies_cac_elixir_slot_check"))
	self:addElement(EquippedMarkerTick2)
	self.EquippedMarkerTick2 = EquippedMarkerTick2
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMPlaylistSelected.__resetProperties = function(f3_arg0)
	f3_arg0.equippedIcon:completeAnimation()
	f3_arg0.EquippedMarkerTick2:completeAnimation()
	f3_arg0.equippedIcon:setAlpha(0)
	f3_arg0.EquippedMarkerTick2:setAlpha(0)
end
CoD.ZMPlaylistSelected.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.equippedIcon:completeAnimation()
			f5_arg0.equippedIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.equippedIcon)
			f5_arg0.EquippedMarkerTick2:completeAnimation()
			f5_arg0.EquippedMarkerTick2:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.EquippedMarkerTick2)
		end,
	},
}

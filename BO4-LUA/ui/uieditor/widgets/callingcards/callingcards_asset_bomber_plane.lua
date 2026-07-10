CoD.CallingCards_Asset_Bomber_Plane = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Bomber_Plane.__defaultWidth = 256
CoD.CallingCards_Asset_Bomber_Plane.__defaultHeight = 600
CoD.CallingCards_Asset_Bomber_Plane.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Bomber_Plane)
	self.id = "CallingCards_Asset_Bomber_Plane"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bomberPlane = LUI.UIImage.new(0, 0, 0, 256, 0, 0, 0, 88)
	bomberPlane:setAlpha(0.4)
	bomberPlane:setImage(RegisterImage(@"uie_ui_icon_callingcards_zm_weapons_equipment_bomberplane"))
	self:addElement(bomberPlane)
	self.bomberPlane = bomberPlane
	local bombsDropping = LUI.UIImage.new(0, 0, 76, 140, 0, 0, 88, 600)
	bombsDropping:setAlpha(0.3)
	bombsDropping:setImage(RegisterImage(@"uie_ui_icon_callingcards_zm_weapons_equipment_bombsaway"))
	bombsDropping:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	bombsDropping:setShaderVector(0, 1, 1, 0, 0)
	bombsDropping:setShaderVector(1, 0, -0.25, 0, 0)
	self:addElement(bombsDropping)
	self.bombsDropping = bombsDropping
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_Bomber_Plane.__resetProperties = function(f2_arg0)
	f2_arg0.bomberPlane:completeAnimation()
	f2_arg0.bombsDropping:completeAnimation()
	f2_arg0.bomberPlane:setTopBottom(0, 0, 0, 88)
	f2_arg0.bombsDropping:setTopBottom(0, 0, 88, 600)
end
CoD.CallingCards_Asset_Bomber_Plane.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(500)
					f5_arg0:setTopBottom(0, 0, 0, 88)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bomberPlane:beginAnimation(500)
				f3_arg0.bomberPlane:setTopBottom(0, 0, 8, 96)
				f3_arg0.bomberPlane:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bomberPlane:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bomberPlane:completeAnimation()
			f3_arg0.bomberPlane:setTopBottom(0, 0, 0, 88)
			f3_local0(f3_arg0.bomberPlane)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(500)
					f7_arg0:setTopBottom(0, 0, 88, 600)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bombsDropping:beginAnimation(500)
				f3_arg0.bombsDropping:setTopBottom(0, 0, 96, 608)
				f3_arg0.bombsDropping:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bombsDropping:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.bombsDropping:completeAnimation()
			f3_arg0.bombsDropping:setTopBottom(0, 0, 88, 600)
			f3_local1(f3_arg0.bombsDropping)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}

require("x64:d7e092479c7b82c")
CoD.DossierProgressBulletPoint = InheritFrom(LUI.UIElement)
CoD.DossierProgressBulletPoint.__defaultWidth = 250
CoD.DossierProgressBulletPoint.__defaultHeight = 30
CoD.DossierProgressBulletPoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DossierProgressBulletPoint)
	self.id = "DossierProgressBulletPoint"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DossierProgressBulletPoint = LUI.UIText.new(0, 0, 37, 250, 0, 0, 5, 26)
	DossierProgressBulletPoint:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DossierProgressBulletPoint:setAlpha(0.5)
	DossierProgressBulletPoint:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	DossierProgressBulletPoint:setTTF("ttmussels_regular")
	DossierProgressBulletPoint:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(DossierProgressBulletPoint)
	self.DossierProgressBulletPoint = DossierProgressBulletPoint
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 0, 3, 29, 0, 0, 2, 28)
	self:addElement(Border)
	self.Border = Border
	local BorderAdd = CoD.Border.new(f1_arg0, f1_arg1, 0, 0, 3, 29, 0, 0, 2, 28)
	self:addElement(BorderAdd)
	self.BorderAdd = BorderAdd
	local Empty = LUI.UIImage.new(0, 0, 0.5, 33.5, 0, 0, -1.5, 31.5)
	Empty:setScale(0.67, 0.67)
	Empty:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_selectbox_empty"))
	Empty:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Empty)
	self.Empty = Empty
	local dashBacking = LUI.UIImage.new(0, 0, 2, 32, 0, 0, 0.5, 30.5)
	dashBacking:setScale(1.5, 1.5)
	dashBacking:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_empty"))
	self:addElement(dashBacking)
	self.dashBacking = dashBacking
	local dash = LUI.UIImage.new(0, 0, 2, 32, 0, 0, 0.5, 30.5)
	dash:setScale(1.5, 1.5)
	dash:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_full"))
	self:addElement(dash)
	self.dash = dash
	local Glow = LUI.UIImage.new(0, 0, -3.5, 38.5, 0, 0, -20.5, 52.5)
	Glow:setRGB(0.88, 0.8, 0.45)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_t7_menu_cac_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local CornerDots = LUI.UIImage.new(0, 0, 3.5, 30.5, 0, 0, 1.5, 28.5)
	CornerDots:setScale(1.5, 1.5)
	CornerDots:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_dots"))
	self:addElement(CornerDots)
	self.CornerDots = CornerDots
	local CursorOver = LUI.UIImage.new(0, 0, -5, 39, 0, 0, -6.5, 37.5)
	CursorOver:setAlpha(0)
	CursorOver:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_over"))
	self:addElement(CursorOver)
	self.CursorOver = CursorOver
	self:mergeStateConditions({
		{
			stateName = "CheckedKR15",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.ShowKorea15Plus()
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DossierProgressBulletPoint.__resetProperties = function(f4_arg0)
	f4_arg0.CornerDots:completeAnimation()
	f4_arg0.dash:completeAnimation()
	f4_arg0.dashBacking:completeAnimation()
	f4_arg0.Glow:completeAnimation()
	f4_arg0.CornerDots:setAlpha(1)
	f4_arg0.dash:setAlpha(1)
	f4_arg0.dashBacking:setAlpha(1)
	f4_arg0.Glow:setAlpha(0)
end
CoD.DossierProgressBulletPoint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.dashBacking:completeAnimation()
			f5_arg0.dashBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.dashBacking)
			f5_arg0.dash:completeAnimation()
			f5_arg0.dash:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.dash)
			f5_arg0.CornerDots:completeAnimation()
			f5_arg0.CornerDots:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.CornerDots)
		end,
	},
	CheckedKR15 = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(500)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(1000)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.Glow:beginAnimation(1000)
				f6_arg0.Glow:setAlpha(0.2)
				f6_arg0.Glow:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Glow:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.Glow:completeAnimation()
			f6_arg0.Glow:setAlpha(0)
			f6_local0(f6_arg0.Glow)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
	Checked = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						f13_arg0:beginAnimation(500)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
					end
					f12_arg0:beginAnimation(1000)
					f12_arg0:setAlpha(0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f10_arg0.Glow:beginAnimation(1000)
				f10_arg0.Glow:setAlpha(0.2)
				f10_arg0.Glow:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Glow:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.Glow:completeAnimation()
			f10_arg0.Glow:setAlpha(0)
			f10_local0(f10_arg0.Glow)
			f10_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.DossierProgressBulletPoint.__onClose = function(f14_arg0)
	f14_arg0.Border:close()
	f14_arg0.BorderAdd:close()
end

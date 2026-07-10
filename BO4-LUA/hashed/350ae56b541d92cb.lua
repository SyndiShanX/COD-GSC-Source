CoD.HUD_ZM_Rush_Point_Award = InheritFrom(LUI.UIElement)
CoD.HUD_ZM_Rush_Point_Award.__defaultWidth = 400
CoD.HUD_ZM_Rush_Point_Award.__defaultHeight = 250
CoD.HUD_ZM_Rush_Point_Award.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HUD_ZM_Rush_Point_Award)
	self.id = "HUD_ZM_Rush_Point_Award"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GLowMultiply = LUI.UIImage.new(0, 1, -82, 62, 0.5, 0.5, -70, 37)
	GLowMultiply:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	GLowMultiply:setAlpha(0)
	GLowMultiply:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	self:addElement(GLowMultiply)
	self.GLowMultiply = GLowMultiply
	local PointAmount = LUI.UIText.new(0, 0, 0.5, 400.5, 0, 0, 86, 146)
	PointAmount:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	PointAmount:setTTF("skorzhen")
	PointAmount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	PointAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PointAmount:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(PointAmount)
	self.PointAmount = PointAmount
	local Title = LUI.UIText.new(0, 0, 0.5, 400.5, 0, 0, 148, 184)
	Title:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"zombie/points_pickup"))
	Title:setTTF("skorzhen")
	Title:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(Title)
	self.Title = Title
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HUD_ZM_Rush_Point_Award.__resetProperties = function(f2_arg0)
	f2_arg0.Title:completeAnimation()
	f2_arg0.PointAmount:completeAnimation()
	f2_arg0.GLowMultiply:completeAnimation()
	f2_arg0.Title:setAlpha(1)
	f2_arg0.PointAmount:setAlpha(1)
	f2_arg0.GLowMultiply:setAlpha(0)
end
CoD.HUD_ZM_Rush_Point_Award.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.PointAmount:completeAnimation()
			f3_arg0.PointAmount:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.PointAmount)
			f3_arg0.Title:completeAnimation()
			f3_arg0.Title:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Title)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.PointAmount:completeAnimation()
			f4_arg0.PointAmount:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.PointAmount)
			f4_arg0.Title:completeAnimation()
			f4_arg0.Title:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Title)
		end,
	},
	Active = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.PointAmount:completeAnimation()
			f5_arg0.PointAmount:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PointAmount)
			f5_arg0.Title:completeAnimation()
			f5_arg0.Title:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Title)
		end,
		AwardPoints = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(250)
						f9_arg0:setAlpha(0)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(250)
					f8_arg0:setAlpha(0.65)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.GLowMultiply:beginAnimation(250)
				f6_arg0.GLowMultiply:setAlpha(0.4)
				f6_arg0.GLowMultiply:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.GLowMultiply:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.GLowMultiply:completeAnimation()
			f6_arg0.GLowMultiply:setAlpha(0)
			f6_local0(f6_arg0.GLowMultiply)
			local f6_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(250)
						f12_arg0:setAlpha(0)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(250)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f6_arg0.PointAmount:beginAnimation(250)
				f6_arg0.PointAmount:setAlpha(1)
				f6_arg0.PointAmount:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.PointAmount:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f6_arg0.PointAmount:completeAnimation()
			f6_arg0.PointAmount:setAlpha(0)
			f6_local1(f6_arg0.PointAmount)
			local f6_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(250)
						f15_arg0:setAlpha(0)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(250)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f6_arg0.Title:beginAnimation(250)
				f6_arg0.Title:setAlpha(1)
				f6_arg0.Title:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Title:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f6_arg0.Title:completeAnimation()
			f6_arg0.Title:setAlpha(0)
			f6_local2(f6_arg0.Title)
		end,
	},
}

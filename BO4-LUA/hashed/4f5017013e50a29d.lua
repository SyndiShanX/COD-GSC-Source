CoD.WZAAR_MeritFlare = InheritFrom(LUI.UIElement)
CoD.WZAAR_MeritFlare.__defaultWidth = 256
CoD.WZAAR_MeritFlare.__defaultHeight = 256
CoD.WZAAR_MeritFlare.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_MeritFlare)
	self.id = "WZAAR_MeritFlare"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local flare = LUI.UIImage.new(0, 0, 0, 256, 0, 0, 0, 256)
	flare:setRGB(1, 0.39, 0)
	flare:setAlpha(0)
	flare:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_flare"))
	self:addElement(flare)
	self.flare = flare
	local flare2 = LUI.UIImage.new(0, 0, 0, 256, 0, 0, 0, 256)
	flare2:setRGB(0.98, 1, 0)
	flare2:setAlpha(0)
	flare2:setZRot(180)
	flare2:setScale(0.5, 0.5)
	flare2:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_flare"))
	flare2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(flare2)
	self.flare2 = flare2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_MeritFlare.__resetProperties = function(f2_arg0)
	f2_arg0.flare2:completeAnimation()
	f2_arg0.flare:completeAnimation()
	f2_arg0.flare2:setAlpha(0)
	f2_arg0.flare2:setScale(0.5, 0.5)
	f2_arg0.flare:setAlpha(0)
	f2_arg0.flare:setScale(1, 1)
end
CoD.WZAAR_MeritFlare.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(180)
					f5_arg0:setAlpha(0)
					f5_arg0:setScale(0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.flare:beginAnimation(150)
				f3_arg0.flare:setAlpha(1)
				f3_arg0.flare:setScale(1.8, 1.4)
				f3_arg0.flare:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.flare:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.flare:completeAnimation()
			f3_arg0.flare:setAlpha(0)
			f3_arg0.flare:setScale(0, 0)
			f3_local0(f3_arg0.flare)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(180)
					f7_arg0:setAlpha(0)
					f7_arg0:setScale(0, 0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.flare2:beginAnimation(150)
				f3_arg0.flare2:setAlpha(1)
				f3_arg0.flare2:setScale(1, 1)
				f3_arg0.flare2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.flare2:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.flare2:completeAnimation()
			f3_arg0.flare2:setAlpha(0)
			f3_arg0.flare2:setScale(0.5, 0.5)
			f3_local1(f3_arg0.flare2)
		end,
	},
}

require("ui/uieditor/widgets/callingcards/callingcards_asset_birds")
CoD.callingcards_mode_killer_master = InheritFrom(LUI.UIElement)
CoD.callingcards_mode_killer_master.__defaultWidth = 960
CoD.callingcards_mode_killer_master.__defaultHeight = 240
CoD.callingcards_mode_killer_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_mode_killer_master)
	self.id = "CallingCards_Mode_Killer_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fog = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	fog:setAlpha(0.8)
	fog:setImage(RegisterImage("uie_mode_background"))
	fog:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	fog:setShaderVector(0, 1, 1, 0, 0)
	fog:setShaderVector(1, -0.01, 0, 0, 0)
	self:addElement(fog)
	self.fog = fog
	local birds = CoD.CallingCards_Asset_birds.new(f1_arg0, f1_arg1, 0, 0, 587.5, 969.5, 0, 0, -107.5, 587.5)
	birds:setZRot(18)
	self:addElement(birds)
	self.birds = birds
	local pirateship = LUI.UIImage.new(0, 0, -90, 870, 0, 0, 0, 240)
	pirateship:setImage(RegisterImage("uie_pirate_ship"))
	self:addElement(pirateship)
	self.pirateship = pirateship
	local boatHighlight = LUI.UIImage.new(0, 0, 198, 574, 0, 0, 90, 240)
	boatHighlight:setRGB(0.37, 0.06, 0.06)
	boatHighlight:setImage(RegisterImage("uie_boat_highlights"))
	self:addElement(boatHighlight)
	self.boatHighlight = boatHighlight
	local skelly = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	skelly:setImage(RegisterImage("uie_skeleton"))
	self:addElement(skelly)
	self.skelly = skelly
	local lightOverlay = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightOverlay:setImage(RegisterImage("uie_skelly_highlight"))
	self:addElement(lightOverlay)
	self.lightOverlay = lightOverlay
	local eyeFlareImage = LUI.UIImage.new(0, 0, 687, 1042, 0, 0, -9, 189)
	eyeFlareImage:setImage(RegisterImage("uie_eye_flare"))
	self:addElement(eyeFlareImage)
	self.eyeFlareImage = eyeFlareImage
	local eyeFlareImage2 = LUI.UIImage.new(0, 0, 792, 1147, 0, 0, -9, 189)
	eyeFlareImage2:setImage(RegisterImage("uie_eye_flare"))
	self:addElement(eyeFlareImage2)
	self.eyeFlareImage2 = eyeFlareImage2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_mode_killer_master.__resetProperties = function(f2_arg0)
	f2_arg0.lightOverlay:completeAnimation()
	f2_arg0.eyeFlareImage:completeAnimation()
	f2_arg0.eyeFlareImage2:completeAnimation()
	f2_arg0.boatHighlight:completeAnimation()
	f2_arg0.birds:completeAnimation()
	f2_arg0.lightOverlay:setAlpha(1)
	f2_arg0.eyeFlareImage:setAlpha(1)
	f2_arg0.eyeFlareImage:setMaterial(LUI.UIImage.GetCachedMaterial("ui_normal"))
	f2_arg0.eyeFlareImage2:setAlpha(1)
	f2_arg0.boatHighlight:setRGB(0.37, 0.06, 0.06)
	f2_arg0.boatHighlight:setAlpha(1)
	f2_arg0.birds:setLeftRight(0, 0, 587.5, 969.5)
	f2_arg0.birds:setTopBottom(0, 0, -107.5, 587.5)
	f2_arg0.birds:setScale(1, 1)
end
CoD.callingcards_mode_killer_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:playClip("DefaultClip")
					f5_arg0:beginAnimation(3070)
					f5_arg0:setLeftRight(0, 0, 341, 525)
					f5_arg0:setTopBottom(0, 0, -61, 299)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.birds:beginAnimation(630)
				f3_arg0.birds:setLeftRight(0, 0, 500.31, 668.55)
				f3_arg0.birds:setTopBottom(0, 0, -39.01, 290.29)
				f3_arg0.birds:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.birds:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.birds:completeAnimation()
			f3_arg0.birds:setLeftRight(0, 0, 533, 698)
			f3_arg0.birds:setTopBottom(0, 0, -34.5, 288.5)
			f3_arg0.birds:setScale(1.25, 1.25)
			f3_local0(f3_arg0.birds)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1990)
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.boatHighlight:beginAnimation(2010)
				f3_arg0.boatHighlight:setAlpha(0.5)
				f3_arg0.boatHighlight:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.boatHighlight:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.boatHighlight:completeAnimation()
			f3_arg0.boatHighlight:setRGB(0.37, 0.06, 0.06)
			f3_arg0.boatHighlight:setAlpha(1)
			f3_local1(f3_arg0.boatHighlight)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(2000)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.lightOverlay:beginAnimation(2000)
				f3_arg0.lightOverlay:setAlpha(0)
				f3_arg0.lightOverlay:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lightOverlay:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.lightOverlay:completeAnimation()
			f3_arg0.lightOverlay:setAlpha(1)
			f3_local2(f3_arg0.lightOverlay)
			local f3_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(2000)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.eyeFlareImage:beginAnimation(2000)
				f3_arg0.eyeFlareImage:setAlpha(0)
				f3_arg0.eyeFlareImage:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.eyeFlareImage:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.eyeFlareImage:completeAnimation()
			f3_arg0.eyeFlareImage:setAlpha(1)
			f3_arg0.eyeFlareImage:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
			f3_local3(f3_arg0.eyeFlareImage)
			local f3_local4 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(2000)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.eyeFlareImage2:beginAnimation(2000)
				f3_arg0.eyeFlareImage2:setAlpha(0)
				f3_arg0.eyeFlareImage2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.eyeFlareImage2:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.eyeFlareImage2:completeAnimation()
			f3_arg0.eyeFlareImage2:setAlpha(1)
			f3_local4(f3_arg0.eyeFlareImage2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_mode_killer_master.__onClose = function(f15_arg0)
	f15_arg0.birds:close()
end

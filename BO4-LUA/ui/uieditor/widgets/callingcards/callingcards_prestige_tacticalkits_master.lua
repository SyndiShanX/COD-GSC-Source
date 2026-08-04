require("ui/uieditor/widgets/callingcards/callingcards_asset_mech")
CoD.callingcards_prestige_tacticalkits_master = InheritFrom(LUI.UIElement)
CoD.callingcards_prestige_tacticalkits_master.__defaultWidth = 960
CoD.callingcards_prestige_tacticalkits_master.__defaultHeight = 240
CoD.callingcards_prestige_tacticalkits_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_prestige_tacticalkits_master)
	self.id = "CallingCards_Prestige_Tacticalkits_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local mechBackground = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	mechBackground:setImage(RegisterImage("uie_mech_background"))
	self:addElement(mechBackground)
	self.mechBackground = mechBackground
	local mecha = CoD.CallingCards_Asset_mech.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 1, 241)
	self:addElement(mecha)
	self.mecha = mecha
	local smoke = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	smoke:setImage(RegisterImage("uie_smoke"))
	smoke:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	smoke:setShaderVector(0, 1, 3.03, 0, 0)
	smoke:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(smoke)
	self.smoke = smoke
	local rockets = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	rockets:setImage(RegisterImage("uie_rockets"))
	self:addElement(rockets)
	self.rockets = rockets
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_prestige_tacticalkits_master.__resetProperties = function(f2_arg0)
	f2_arg0.rockets:completeAnimation()
	f2_arg0.mecha:completeAnimation()
	f2_arg0.rockets:setTopBottom(0, 0, 0, 240)
end
CoD.callingcards_prestige_tacticalkits_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.mecha:completeAnimation()
			f3_arg0.mecha:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.mecha)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(500)
							f7_arg0:setTopBottom(0, 0, 0, 180)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setTopBottom(0, 0, -5, 175)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setTopBottom(0, 0, 0, 180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.rockets:beginAnimation(500)
				f3_arg0.rockets:setTopBottom(0, 0, -5, 175)
				f3_arg0.rockets:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.rockets:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.rockets:completeAnimation()
			f3_arg0.rockets:setTopBottom(0, 0, 0, 180)
			f3_local0(f3_arg0.rockets)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_prestige_tacticalkits_master.__onClose = function(f8_arg0)
	f8_arg0.mecha:close()
end

CoD.CallingCards_Asset_Stingertail = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Stingertail.__defaultWidth = 264
CoD.CallingCards_Asset_Stingertail.__defaultHeight = 233
CoD.CallingCards_Asset_Stingertail.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Stingertail)
	self.id = "CallingCards_Asset_Stingertail"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Stinger = LUI.UIImage.new(0, 0, 0, 264, 0, 0, 0, 232)
	Stinger:setImage(RegisterImage("uie_callingcards_mp_loot_master_lionstinger"))
	self:addElement(Stinger)
	self.Stinger = Stinger
	local StingerShimmer = LUI.UIImage.new(0, 0, 0, 264, 0, 0, 1, 233)
	StingerShimmer:setAlpha(0.65)
	StingerShimmer:setImage(RegisterImage("uie_callingcards_mp_loot_master_lionstinger_sheen"))
	StingerShimmer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_delta_normal"))
	StingerShimmer:setShaderVector(0, -0.03, 0.07, 0, 0)
	StingerShimmer:setShaderVector(1, 0.03, 0.03, 0, 0)
	StingerShimmer:setShaderVector(2, 0, 1, 0, 0)
	StingerShimmer:setShaderVector(3, 0, 0, 0, 0)
	StingerShimmer:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(StingerShimmer)
	self.StingerShimmer = StingerShimmer
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_Stingertail.__resetProperties = function(f2_arg0)
	f2_arg0.StingerShimmer:completeAnimation()
	f2_arg0.StingerShimmer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_delta_normal"))
	f2_arg0.StingerShimmer:setShaderVector(0, -0.03, 0.07, 0, 0)
	f2_arg0.StingerShimmer:setShaderVector(1, 0.03, 0.03, 0, 0)
	f2_arg0.StingerShimmer:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.StingerShimmer:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.StingerShimmer:setShaderVector(4, 0, 0, 0, 0)
end
CoD.CallingCards_Asset_Stingertail.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(440)
						f6_arg0:setShaderVector(0, 0.76, 0.93, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(579)
					f5_arg0:setShaderVector(0, 0.42, 0.55, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.StingerShimmer:beginAnimation(980)
				f3_arg0.StingerShimmer:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.StingerShimmer:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.StingerShimmer:completeAnimation()
			f3_arg0.StingerShimmer:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_delta_normal"))
			f3_arg0.StingerShimmer:setShaderVector(0, -0.03, 0.07, 0, 0)
			f3_arg0.StingerShimmer:setShaderVector(1, 0.03, 0.03, 0, 0)
			f3_arg0.StingerShimmer:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.StingerShimmer:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.StingerShimmer:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.StingerShimmer)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}

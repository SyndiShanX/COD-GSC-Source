require("x64:24adaf674659a70")
CoD.ContractCompleteBanner = InheritFrom(LUI.UIElement)
CoD.ContractCompleteBanner.__defaultWidth = 150
CoD.ContractCompleteBanner.__defaultHeight = 25
CoD.ContractCompleteBanner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractCompleteBanner)
	self.id = "ContractCompleteBanner"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CompeletedBanner = LUI.UIText.new(0.5, 0.5, -73, 73, 0.5, 0.5, -9, 9)
	CompeletedBanner:setRGB(ColorSet.EnemyOrange_Base.r, ColorSet.EnemyOrange_Base.g, ColorSet.EnemyOrange_Base.b)
	CompeletedBanner:setText(LocalizeToUpperString(0xC249C368451D708))
	CompeletedBanner:setTTF("ttmussels_demibold")
	CompeletedBanner:setLetterSpacing(4)
	CompeletedBanner:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CompeletedBanner:setBackingType(1)
	CompeletedBanner:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	CompeletedBanner:setBackingXPadding(8)
	CompeletedBanner:setBackingYPadding(2)
	CompeletedBanner._backingElement.Frame:setRGB(ColorSet.EnemyOrange_Base.r, ColorSet.EnemyOrange_Base.g, ColorSet.EnemyOrange_Base.b)
	self:addElement(CompeletedBanner)
	self.CompeletedBanner = CompeletedBanner
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractCompleteBanner.__resetProperties = function(f2_arg0)
	f2_arg0.CompeletedBanner:completeAnimation()
	f2_arg0.CompeletedBanner:setAlpha(1)
end
CoD.ContractCompleteBanner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.CompeletedBanner:completeAnimation()
			f3_arg0.CompeletedBanner:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.CompeletedBanner)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						f7_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
						f7_arg0:setAlpha(1)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
					end
					f6_arg0:beginAnimation(100)
					f6_arg0:setAlpha(0)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.CompeletedBanner:beginAnimation(100)
				f4_arg0.CompeletedBanner:setAlpha(1)
				f4_arg0.CompeletedBanner:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.CompeletedBanner:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.CompeletedBanner:completeAnimation()
			f4_arg0.CompeletedBanner:setAlpha(0)
			f4_local0(f4_arg0.CompeletedBanner)
		end,
	},
}

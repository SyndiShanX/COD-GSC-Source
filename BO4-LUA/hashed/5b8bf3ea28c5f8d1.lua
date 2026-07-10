require("x64:3a5ede94234809")
require("x64:b34a1785fca272a")
require("x64:6fe8e87c3a6babf")
CoD.vhud_gunship_multi_reticle = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_multi_reticle.__defaultWidth = 200
CoD.vhud_gunship_multi_reticle.__defaultHeight = 200
CoD.vhud_gunship_multi_reticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_multi_reticle)
	self.id = "vhud_gunship_multi_reticle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local reticle25mm = CoD.vhud_gunship_recticle_25mm.new(f1_arg0, f1_arg1, 0, 0, -35, 235, 0, 0, -28, 228)
	reticle25mm:setAlpha(0)
	self:addElement(reticle25mm)
	self.reticle25mm = reticle25mm
	local reticle40mm = CoD.vhud_gunship_recticle_40mm.new(f1_arg0, f1_arg1, 0, 0, -119, 319, 0, 0, -117, 319)
	reticle40mm:setAlpha(0)
	self:addElement(reticle40mm)
	self.reticle40mm = reticle40mm
	local reticle105mm = CoD.vhud_gunship_recticle_105mm.new(f1_arg0, f1_arg1, 0, 0, -234, 434, 0, 0, -156, 356)
	self:addElement(reticle105mm)
	self.reticle105mm = reticle105mm
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_multi_reticle.__resetProperties = function(f2_arg0)
	f2_arg0.reticle105mm:completeAnimation()
	f2_arg0.reticle40mm:completeAnimation()
	f2_arg0.reticle25mm:completeAnimation()
	f2_arg0.reticle105mm:setAlpha(1)
	f2_arg0.reticle40mm:setAlpha(0)
	f2_arg0.reticle25mm:setAlpha(0)
end
CoD.vhud_gunship_multi_reticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.reticle105mm:playClip("DefaultClip")
				f3_arg0.reticle105mm:beginAnimation(50)
				f3_arg0.reticle105mm:setAlpha(1)
				f3_arg0.reticle105mm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.reticle105mm:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f3_arg0.clipFinished(element, event)
				end)
			end
			f3_arg0.reticle105mm:completeAnimation()
			f3_arg0.reticle105mm:setAlpha(0)
			f3_local0(f3_arg0.reticle105mm)
		end,
	},
	Ammo40mm = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.reticle25mm:completeAnimation()
			f6_arg0.reticle25mm:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.reticle25mm)
			local f6_local0 = function(f7_arg0)
				f6_arg0.reticle40mm:playClip("DefaultClip")
				f6_arg0.reticle40mm:beginAnimation(50)
				f6_arg0.reticle40mm:setAlpha(1)
				f6_arg0.reticle40mm:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.reticle40mm:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f6_arg0.clipFinished(element, event)
				end)
			end
			f6_arg0.reticle40mm:completeAnimation()
			f6_arg0.reticle40mm:setAlpha(0)
			f6_local0(f6_arg0.reticle40mm)
			f6_arg0.reticle105mm:completeAnimation()
			f6_arg0.reticle105mm:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.reticle105mm)
		end,
	},
	Ammo25mm = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				f9_arg0.reticle25mm:playClip("DefaultClip")
				f9_arg0.reticle25mm:beginAnimation(50)
				f9_arg0.reticle25mm:setAlpha(1)
				f9_arg0.reticle25mm:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.reticle25mm:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f9_arg0.clipFinished(element, event)
				end)
			end
			f9_arg0.reticle25mm:completeAnimation()
			f9_arg0.reticle25mm:setAlpha(0)
			f9_local0(f9_arg0.reticle25mm)
			f9_arg0.reticle40mm:completeAnimation()
			f9_arg0.reticle40mm:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.reticle40mm)
			f9_arg0.reticle105mm:completeAnimation()
			f9_arg0.reticle105mm:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.reticle105mm)
		end,
	},
}
CoD.vhud_gunship_multi_reticle.__onClose = function(f12_arg0)
	f12_arg0.reticle25mm:close()
	f12_arg0.reticle40mm:close()
	f12_arg0.reticle105mm:close()
end

CoD.CACWildcardSelectionAnimContainer = InheritFrom(LUI.UIElement)
CoD.CACWildcardSelectionAnimContainer.__defaultWidth = 84
CoD.CACWildcardSelectionAnimContainer.__defaultHeight = 52
CoD.CACWildcardSelectionAnimContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACWildcardSelectionAnimContainer)
	self.id = "CACWildcardSelectionAnimContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UpgradePathBG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -4, 19)
	UpgradePathBG:setAlpha(0.2)
	UpgradePathBG:setImage(RegisterImage(0x16F59B11B25425F))
	self:addElement(UpgradePathBG)
	self.UpgradePathBG = UpgradePathBG
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CACWildcardSelectionAnimContainer.__resetProperties = function(f2_arg0)
	f2_arg0.UpgradePathBG:completeAnimation()
	f2_arg0.UpgradePathBG:setRGB(1, 1, 1)
	f2_arg0.UpgradePathBG:setAlpha(0.2)
end
CoD.CACWildcardSelectionAnimContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(6000)
					f5_arg0:setAlpha(0.02)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.UpgradePathBG:beginAnimation(6000)
				f3_arg0.UpgradePathBG:setAlpha(0.04)
				f3_arg0.UpgradePathBG:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.UpgradePathBG:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.UpgradePathBG:completeAnimation()
			f3_arg0.UpgradePathBG:setRGB(0.97, 0.98, 0.85)
			f3_arg0.UpgradePathBG:setAlpha(0.02)
			f3_local0(f3_arg0.UpgradePathBG)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}

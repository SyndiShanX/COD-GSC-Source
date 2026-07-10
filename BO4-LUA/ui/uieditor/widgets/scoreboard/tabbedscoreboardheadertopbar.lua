CoD.TabbedScoreboardHeaderTopbar = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderTopbar.__defaultWidth = 688
CoD.TabbedScoreboardHeaderTopbar.__defaultHeight = 10
CoD.TabbedScoreboardHeaderTopbar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardHeaderTopbar)
	self.id = "TabbedScoreboardHeaderTopbar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TopBar = LUI.UIImage.new(0.5, 0.5, -344, 344, 0, 0, 0, 10)
	TopBar:setRGB(0.95, 0.95, 0.95)
	TopBar:setImage(RegisterImage(@"hash_259D632AC9663362"))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local TopBarWipe = LUI.UIImage.new(0.5, 0.5, -344, 344, 0, 0, 0, 10)
	TopBarWipe:setRGB(0.95, 0.95, 0.95)
	TopBarWipe:setImage(RegisterImage(@"hash_259D632AC9663362"))
	TopBarWipe:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	TopBarWipe:setShaderVector(0, 0, 1, 0, 0)
	TopBarWipe:setShaderVector(1, 0, 0, 0, 0)
	TopBarWipe:setShaderVector(2, 0, 1, 0, 0)
	TopBarWipe:setShaderVector(3, 0, 0, 0, 0)
	TopBarWipe:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(TopBarWipe)
	self.TopBarWipe = TopBarWipe
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeaderTopbar.__resetProperties = function(f2_arg0)
	f2_arg0.TopBarWipe:completeAnimation()
	f2_arg0.TopBarWipe:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	f2_arg0.TopBarWipe:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.TopBarWipe:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.TopBarWipe:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.TopBarWipe:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.TopBarWipe:setShaderVector(4, 0, 0, 0, 0)
end
CoD.TabbedScoreboardHeaderTopbar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.TopBarWipe:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.TopBarWipe:setShaderVector(0, 0, 1, 0, 0)
				f3_arg0.TopBarWipe:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TopBarWipe:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TopBarWipe:completeAnimation()
			f3_arg0.TopBarWipe:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
			f3_arg0.TopBarWipe:setShaderVector(0, 1, 1, 0, 0)
			f3_arg0.TopBarWipe:setShaderVector(1, 0, 0, 0, 0)
			f3_arg0.TopBarWipe:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.TopBarWipe:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.TopBarWipe:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.TopBarWipe)
		end,
	},
}

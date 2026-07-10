CoD.CustomGames_OptionCategoryCustomLabel = InheritFrom(LUI.UIElement)
CoD.CustomGames_OptionCategoryCustomLabel.__defaultWidth = 220
CoD.CustomGames_OptionCategoryCustomLabel.__defaultHeight = 18
CoD.CustomGames_OptionCategoryCustomLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_OptionCategoryCustomLabel)
	self.id = "CustomGames_OptionCategoryCustomLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Default = LUI.UIText.new(0, 0, 0, 220, 0, 0, 0, 18)
	Default:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/default"))
	Default:setTTF("ttmussels_regular")
	Default:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Default:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(Default)
	self.Default = Default
	local Custom = LUI.UIText.new(0, 0, 0, 220, 0, 0, 0, 18)
	Custom:setRGB(0.93, 0.45, 0.05)
	Custom:setAlpha(0)
	Custom:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/custom"))
	Custom:setTTF("ttmussels_regular")
	Custom:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	Custom:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(Custom)
	self.Custom = Custom
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_OptionCategoryCustomLabel.__resetProperties = function(f2_arg0)
	f2_arg0.Default:completeAnimation()
	f2_arg0.Custom:completeAnimation()
	f2_arg0.Default:setAlpha(1)
	f2_arg0.Custom:setAlpha(0)
end
CoD.CustomGames_OptionCategoryCustomLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Default:completeAnimation()
			f4_arg0.Default:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Default)
		end,
	},
	Custom = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Default:completeAnimation()
			f5_arg0.Default:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Default)
			f5_arg0.Custom:completeAnimation()
			f5_arg0.Custom:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Custom)
		end,
	},
}

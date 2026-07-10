CoD.WarzoneDBNOText = InheritFrom(LUI.UIElement)
CoD.WarzoneDBNOText.__defaultWidth = 1323
CoD.WarzoneDBNOText.__defaultHeight = 90
CoD.WarzoneDBNOText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDBNOText)
	self.id = "WarzoneDBNOText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DeathCamLabel2 = LUI.UIText.new(0.5, 0.5, -661.5, 661.5, 0.5, 0.5, -41, 49)
	DeathCamLabel2:setRGB(1, 0.9, 0.9)
	DeathCamLabel2:setText(LocalizeToUpperString(@"hash_5C50DE254023889B"))
	DeathCamLabel2:setTTF("ttmussels_demibold")
	DeathCamLabel2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	DeathCamLabel2:setShaderVector(0, 1, 0, 0, 0)
	DeathCamLabel2:setShaderVector(1, 0, 0, 0, 0)
	DeathCamLabel2:setShaderVector(2, 1, 0, 0, 0.2)
	DeathCamLabel2:setLetterSpacing(20)
	DeathCamLabel2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DeathCamLabel2:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(DeathCamLabel2)
	self.DeathCamLabel2 = DeathCamLabel2
	self:mergeStateConditions({
		{
			stateName = "Pandemic",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad")
			end,
		},
		{
			stateName = "HeavyMetalHeroes",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("warzone_heavy_metal_heroes")
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneDBNOText.__resetProperties = function(f4_arg0)
	f4_arg0.DeathCamLabel2:completeAnimation()
	f4_arg0.DeathCamLabel2:setText(LocalizeToUpperString(@"hash_5C50DE254023889B"))
end
CoD.WarzoneDBNOText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Pandemic = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DeathCamLabel2:completeAnimation()
			f6_arg0.DeathCamLabel2:setText(LocalizeToUpperString(@"wz/pandemic_dbno"))
			f6_arg0.clipFinished(f6_arg0.DeathCamLabel2)
		end,
	},
	HeavyMetalHeroes = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.DeathCamLabel2:completeAnimation()
			f7_arg0.DeathCamLabel2:setText(LocalizeToUpperString(@"hash_39385DC963AF6F3B"))
			f7_arg0.clipFinished(f7_arg0.DeathCamLabel2)
		end,
	},
}

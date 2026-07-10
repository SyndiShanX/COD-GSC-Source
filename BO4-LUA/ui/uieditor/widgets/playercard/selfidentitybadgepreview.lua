require("x64:f035e2b6323687d")
CoD.SelfIdentityBadgePreview = InheritFrom(LUI.UIElement)
CoD.SelfIdentityBadgePreview.__defaultWidth = 462
CoD.SelfIdentityBadgePreview.__defaultHeight = 90
CoD.SelfIdentityBadgePreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SelfIdentityBadgePreview)
	self.id = "SelfIdentityBadgePreview"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBorder = LUI.UIImage.new(0.5, 0.5, -219, 219, 0.5, 0.5, -45, 45)
	BackingBorder:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingBorder:setShaderVector(0, 0, 0, 0, 0)
	BackingBorder:setupNineSliceShader(196, 88)
	self:addElement(BackingBorder)
	self.BackingBorder = BackingBorder
	local SelfIdentityBadge = CoD.SelfIdentityBadge.new(f1_arg0, f1_arg1, 0.5, 0.5, -168, 160, 0.5, 0.5, -32.5, 32.5)
	SelfIdentityBadge:setScale(1.34, 1.34)
	SelfIdentityBadge:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		SelfIdentityBadge:setModel(model, f1_arg1)
	end)
	self:addElement(SelfIdentityBadge)
	self.SelfIdentityBadge = SelfIdentityBadge
	local DotLineTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -6, -2)
	DotLineTop:setAlpha(0.4)
	DotLineTop:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineTop:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	local DotLineBottom = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 93, 97)
	DotLineBottom:setAlpha(0.4)
	DotLineBottom:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DotLineBottom:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SelfIdentityBadge.id = "SelfIdentityBadge"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SelfIdentityBadgePreview.__resetProperties = function(f4_arg0)
	f4_arg0.BackingBorder:completeAnimation()
	f4_arg0.SelfIdentityBadge:completeAnimation()
	f4_arg0.DotLineTop:completeAnimation()
	f4_arg0.DotLineBottom:completeAnimation()
	f4_arg0.BackingBorder:setAlpha(1)
	f4_arg0.SelfIdentityBadge:setAlpha(1)
	f4_arg0.DotLineTop:setAlpha(0.4)
	f4_arg0.DotLineBottom:setAlpha(0.4)
end
CoD.SelfIdentityBadgePreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.BackingBorder:completeAnimation()
			f6_arg0.BackingBorder:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BackingBorder)
			f6_arg0.SelfIdentityBadge:completeAnimation()
			f6_arg0.SelfIdentityBadge:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.SelfIdentityBadge)
			f6_arg0.DotLineTop:completeAnimation()
			f6_arg0.DotLineTop:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DotLineTop)
			f6_arg0.DotLineBottom:completeAnimation()
			f6_arg0.DotLineBottom:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DotLineBottom)
		end,
	},
}
CoD.SelfIdentityBadgePreview.__onClose = function(f7_arg0)
	f7_arg0.SelfIdentityBadge:close()
end

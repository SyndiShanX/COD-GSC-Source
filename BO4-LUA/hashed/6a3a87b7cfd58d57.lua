require("x64:e201e7e41431aa7")
CoD.FactionInfo = InheritFrom(LUI.UIElement)
CoD.FactionInfo.__defaultWidth = 426
CoD.FactionInfo.__defaultHeight = 276
CoD.FactionInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FactionInfo)
	self.id = "FactionInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FactionIconFront = LUI.UIImage.new(0.5, 0.5, -96, 96, 0.5, 0.5, -138, 54)
	FactionIconFront:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	FactionIconFront:subscribeToGlobalModel(f1_arg1, "Factions", "playerFactionIcon", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FactionIconFront:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FactionIconFront)
	self.FactionIconFront = FactionIconFront
	local FactionIconBack = LUI.UIImage.new(0.5, 0.5, -96, 96, 0.5, 0.5, -138, 54)
	FactionIconBack:setRGB(0, 0, 0)
	FactionIconBack:subscribeToGlobalModel(f1_arg1, "Factions", "playerFactionIcon", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FactionIconBack:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(FactionIconBack)
	self.FactionIconBack = FactionIconBack
	local NameBackground = CoD.FE_ButtonPanel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, 93, 141)
	NameBackground:setRGB(0, 0, 0)
	NameBackground:setAlpha(0.4)
	self:addElement(NameBackground)
	self.NameBackground = NameBackground
	local Name = LUI.UIText.new(0, 0, 0, 426, 0, 0, 229, 276)
	Name:setTTF("ttmussels_demibold")
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Name:subscribeToGlobalModel(f1_arg1, "Factions", "playerFactionDisplayName", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Name:setText(CoD.BaseUtility.LocalizeIfNotCodcaster(f1_arg1, f4_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FactionInfo.__resetProperties = function(f5_arg0)
	f5_arg0.Name:completeAnimation()
	f5_arg0.NameBackground:completeAnimation()
	f5_arg0.FactionIconFront:completeAnimation()
	f5_arg0.FactionIconBack:completeAnimation()
	f5_arg0.Name:setAlpha(1)
	f5_arg0.NameBackground:setAlpha(0.4)
	f5_arg0.FactionIconFront:setAlpha(1)
	f5_arg0.FactionIconBack:setAlpha(1)
end
CoD.FactionInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.FactionIconFront:completeAnimation()
			f6_arg0.FactionIconFront:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FactionIconFront)
			f6_arg0.FactionIconBack:completeAnimation()
			f6_arg0.FactionIconBack:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FactionIconBack)
			f6_arg0.NameBackground:completeAnimation()
			f6_arg0.NameBackground:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NameBackground)
			f6_arg0.Name:completeAnimation()
			f6_arg0.Name:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Name)
		end,
	},
}
CoD.FactionInfo.__onClose = function(f7_arg0)
	f7_arg0.FactionIconFront:close()
	f7_arg0.FactionIconBack:close()
	f7_arg0.NameBackground:close()
	f7_arg0.Name:close()
end

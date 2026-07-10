CoD.DirectorLaboratoryButtonElixerOffer = InheritFrom(LUI.UIElement)
CoD.DirectorLaboratoryButtonElixerOffer.__defaultWidth = 442
CoD.DirectorLaboratoryButtonElixerOffer.__defaultHeight = 40
CoD.DirectorLaboratoryButtonElixerOffer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLaboratoryButtonElixerOffer)
	self.id = "DirectorLaboratoryButtonElixerOffer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StoneTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 40)
	StoneTiledBacking:setAlpha(0.7)
	StoneTiledBacking:setImage(RegisterImage(0x33757173B476ACD))
	StoneTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	StoneTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	StoneTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(StoneTiledBacking)
	self.StoneTiledBacking = StoneTiledBacking
	local Bg = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 40)
	Bg:setAlpha(0.5)
	Bg:setImage(RegisterImage(0xE87D886CBFA3F3B))
	self:addElement(Bg)
	self.Bg = Bg
	local ElixerOfferBanner = LUI.UIFixedAspectRatioImage.new(0, 1, 4, -4, 0, 0, 0, 40)
	ElixerOfferBanner.__Image = function()
		ElixerOfferBanner:setImage(RegisterImage(CoD.ZMLaboratoryUtility.GetLaboratoryBannerImage(0x7615068F50B3D66)))
	end
	ElixerOfferBanner.__Image()
	ElixerOfferBanner:setStretchedDimension(4)
	self:addElement(ElixerOfferBanner)
	self.ElixerOfferBanner = ElixerOfferBanner
	local Image = LUI.UIImage.new(0, 1, -1, 1, 0.5, 0.5, -20, 20)
	Image:setImage(RegisterImage(0x2259DB5D4EC19BF))
	self:addElement(Image)
	self.Image = Image
	local ElixerOffer = LUI.UIText.new(0.5, 0.5, -136, 136, 0, 0, 13, 28)
	ElixerOffer:setRGB(0.92, 0.92, 0.92)
	ElixerOffer.__String_Reference = function()
		ElixerOffer:setText(LocalizeToUpperString(CoD.ZMLaboratoryUtility.GetLaboratoryBannerTitle(0xAFAC9502ECC81A5)))
	end
	ElixerOffer.__String_Reference()
	ElixerOffer:setTTF("ttmussels_regular")
	ElixerOffer:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	ElixerOffer:setLetterSpacing(2)
	ElixerOffer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ElixerOffer:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(ElixerOffer)
	self.ElixerOffer = ElixerOffer
	local f1_local6 = ElixerOfferBanner
	local f1_local7 = ElixerOfferBanner.subscribeToModel
	local f1_local8 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.cycled, ElixerOfferBanner.__Image)
	f1_local6 = ElixerOffer
	f1_local7 = ElixerOffer.subscribeToModel
	f1_local8 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.cycled, ElixerOffer.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "NoOffer",
			condition = function(menu, element, event)
				return IsDvarValueEqualTo("laboratory_banner_offer", "")
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "AutoEvents", "cycled", function(model)
		local f5_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLaboratoryButtonElixerOffer.__resetProperties = function(f6_arg0)
	f6_arg0.StoneTiledBacking:completeAnimation()
	f6_arg0.Bg:completeAnimation()
	f6_arg0.ElixerOffer:completeAnimation()
	f6_arg0.ElixerOfferBanner:completeAnimation()
	f6_arg0.Image:completeAnimation()
	f6_arg0.StoneTiledBacking:setAlpha(0.7)
	f6_arg0.Bg:setAlpha(0.5)
	f6_arg0.ElixerOffer:setAlpha(1)
	f6_arg0.ElixerOfferBanner:setAlpha(1)
	f6_arg0.Image:setAlpha(1)
end
CoD.DirectorLaboratoryButtonElixerOffer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.StoneTiledBacking:completeAnimation()
			f7_arg0.StoneTiledBacking:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.StoneTiledBacking)
			f7_arg0.Bg:completeAnimation()
			f7_arg0.Bg:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Bg)
		end,
	},
	NoOffer = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(500)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f10_arg0:setAlpha(0.5)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.StoneTiledBacking:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f8_arg0.StoneTiledBacking:setAlpha(0.3)
				f8_arg0.StoneTiledBacking:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.StoneTiledBacking:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.StoneTiledBacking:completeAnimation()
			f8_arg0.StoneTiledBacking:setAlpha(0.5)
			f8_local0(f8_arg0.StoneTiledBacking)
			local f8_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(500)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f13_arg0:setAlpha(0.5)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f8_arg0.Bg:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f8_arg0.Bg:setAlpha(0.6)
				f8_arg0.Bg:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Bg:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f8_arg0.Bg:completeAnimation()
			f8_arg0.Bg:setAlpha(0.5)
			f8_local1(f8_arg0.Bg)
			f8_arg0.ElixerOfferBanner:completeAnimation()
			f8_arg0.ElixerOfferBanner:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ElixerOfferBanner)
			f8_arg0.Image:completeAnimation()
			f8_arg0.Image:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Image)
			f8_arg0.ElixerOffer:completeAnimation()
			f8_arg0.ElixerOffer:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ElixerOffer)
			f8_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.DirectorLaboratoryButtonElixerOffer.__onClose = function(f15_arg0)
	f15_arg0.ElixerOfferBanner:close()
	f15_arg0.ElixerOffer:close()
end

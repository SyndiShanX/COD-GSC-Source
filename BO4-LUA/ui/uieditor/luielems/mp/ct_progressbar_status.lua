CoD.ct_progressbar_status = InheritFrom(CoD.Menu)
CoD.ct_progressbar_status.__stateMap = {
	"DefaultState",
	"download_complete",
	"downloading",
	"connection_lost",
	"downloading1",
	"connection_lost1",
	"awaitingConnection",
	"awaitingConnection1",
	"sabotageData",
	"sabotageData1",
	"sabotageData_complete",
}
LUI.createMenu.ct_progressbar_status = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_progressbar_status", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_progressbar_status)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIText.new(0.5, 0.5, -1593, 327, 0.5, 0.5, -35, 0)
	backing:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	backing:setScale(1.5, 1.2)
	backing:setText(Engine[0xF9F1239CFD921FE](0xB99FB9E6E5A4D96))
	backing:setTTF("ttmussels_regular")
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	backing:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	backing:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	backing:setBackingType(2)
	backing:setBackingColor(0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local InGameHint = LUI.UIText.new(0.5, 0.5, -1593, 327, 0.5, 0.5, -35, 0)
	InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	InGameHint:setScale(1.04, 1.04)
	InGameHint:setText(Engine[0xF9F1239CFD921FE](0xEA9D05FBEB780CF))
	InGameHint:setTTF("ttmussels_regular")
	InGameHint:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	InGameHint:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	InGameHint:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	InGameHint:setBackingType(2)
	InGameHint:setBackingColor(0, 0, 0)
	self:addElement(InGameHint)
	self.InGameHint = InGameHint
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.ct_progressbar_status.__resetProperties = function(f2_arg0)
	f2_arg0.InGameHint:completeAnimation()
	f2_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	f2_arg0.InGameHint:setAlpha(1)
	f2_arg0.InGameHint:setScale(1.04, 1.04)
	f2_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0xEA9D05FBEB780CF))
end
CoD.ct_progressbar_status.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.InGameHint:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.InGameHint:setAlpha(1)
				f3_arg0.InGameHint:setScale(0.9, 0.9)
				f3_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.InGameHint:completeAnimation()
			f3_arg0.InGameHint:setAlpha(0)
			f3_arg0.InGameHint:setScale(0.7, 0.7)
			f3_local0(f3_arg0.InGameHint)
		end,
	},
	download_complete = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.InGameHint:completeAnimation()
			f5_arg0.InGameHint:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
			f5_arg0.InGameHint:setAlpha(1)
			f5_arg0.InGameHint:setScale(1, 1)
			f5_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x846B38B79C0E04A))
			f5_arg0.clipFinished(f5_arg0.InGameHint)
		end,
	},
	downloading = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(500)
					f8_arg0:setScale(1, 1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.InGameHint:beginAnimation(500)
				f6_arg0.InGameHint:setScale(1.2, 1.2)
				f6_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.InGameHint:completeAnimation()
			f6_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f6_arg0.InGameHint:setAlpha(1)
			f6_arg0.InGameHint:setScale(1, 1)
			f6_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0xEA9D05FBEB780CF))
			f6_local0(f6_arg0.InGameHint)
		end,
	},
	connection_lost = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.InGameHint:beginAnimation(1000)
				f9_arg0.InGameHint:setAlpha(0.5)
				f9_arg0.InGameHint:setScale(0.7, 0.7)
				f9_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.InGameHint:completeAnimation()
			f9_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f9_arg0.InGameHint:setAlpha(1)
			f9_arg0.InGameHint:setScale(1, 1)
			f9_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x4A870996652669F))
			f9_local0(f9_arg0.InGameHint)
		end,
	},
	downloading1 = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(500)
					f13_arg0:setScale(1, 1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.InGameHint:beginAnimation(500)
				f11_arg0.InGameHint:setScale(1.2, 1.2)
				f11_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.InGameHint:completeAnimation()
			f11_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f11_arg0.InGameHint:setAlpha(1)
			f11_arg0.InGameHint:setScale(1, 1)
			f11_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0xEA9D05FBEB780CF))
			f11_local0(f11_arg0.InGameHint)
		end,
	},
	connection_lost1 = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.InGameHint:beginAnimation(1000)
				f14_arg0.InGameHint:setAlpha(0.5)
				f14_arg0.InGameHint:setScale(0.7, 0.7)
				f14_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.InGameHint:completeAnimation()
			f14_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f14_arg0.InGameHint:setAlpha(1)
			f14_arg0.InGameHint:setScale(1, 1)
			f14_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x4A870996652669F))
			f14_local0(f14_arg0.InGameHint)
		end,
	},
	awaitingConnection = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(500)
					f18_arg0:setScale(1, 1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.InGameHint:beginAnimation(500)
				f16_arg0.InGameHint:setScale(1.2, 1.2)
				f16_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.InGameHint:completeAnimation()
			f16_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f16_arg0.InGameHint:setAlpha(1)
			f16_arg0.InGameHint:setScale(1, 1)
			f16_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x704E4AF4B420D7A))
			f16_local0(f16_arg0.InGameHint)
		end,
	},
	awaitingConnection1 = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(500)
					f21_arg0:setScale(1, 1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.InGameHint:beginAnimation(500)
				f19_arg0.InGameHint:setScale(1.2, 1.2)
				f19_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.InGameHint:completeAnimation()
			f19_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f19_arg0.InGameHint:setAlpha(1)
			f19_arg0.InGameHint:setScale(1, 1)
			f19_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x704E4AF4B420D7A))
			f19_local0(f19_arg0.InGameHint)
		end,
	},
	sabotageData = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(500)
					f24_arg0:setScale(1, 1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.InGameHint:beginAnimation(500)
				f22_arg0.InGameHint:setScale(1.2, 1.2)
				f22_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.InGameHint:completeAnimation()
			f22_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f22_arg0.InGameHint:setAlpha(1)
			f22_arg0.InGameHint:setScale(1, 1)
			f22_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x7A31535DCB25D50))
			f22_local0(f22_arg0.InGameHint)
		end,
	},
	sabotageData1 = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(500)
					f27_arg0:setScale(1, 1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.InGameHint:beginAnimation(500)
				f25_arg0.InGameHint:setScale(1.2, 1.2)
				f25_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.InGameHint:completeAnimation()
			f25_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f25_arg0.InGameHint:setAlpha(1)
			f25_arg0.InGameHint:setScale(1, 1)
			f25_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x7A31535DCB25D50))
			f25_local0(f25_arg0.InGameHint)
		end,
	},
	sabotageData_complete = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.InGameHint:completeAnimation()
			f28_arg0.InGameHint:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
			f28_arg0.InGameHint:setAlpha(1)
			f28_arg0.InGameHint:setScale(1, 1)
			f28_arg0.InGameHint:setText(Engine[0xF9F1239CFD921FE](0x9B80CA7DBB3A50E))
			f28_arg0.clipFinished(f28_arg0.InGameHint)
		end,
	},
}
CoD.ct_progressbar_status.__onClose = function(f29_arg0) end

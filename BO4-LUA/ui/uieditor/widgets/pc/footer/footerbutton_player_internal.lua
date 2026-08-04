require("ui/uieditor/widgets/common/commonpixelbacking")
require("ui/uieditor/widgets/pc/footer/footerbutton_tooltip")
CoD.FooterButton_Player_Internal = InheritFrom(LUI.UIElement)
CoD.FooterButton_Player_Internal.__defaultWidth = 150
CoD.FooterButton_Player_Internal.__defaultHeight = 54
CoD.FooterButton_Player_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButton_Player_Internal)
	self.id = "FooterButton_Player_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingTint:setRGB(0.26, 0.09, 0.01)
	BackingTint:setAlpha(0)
	BackingTint:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BackingTint:setShaderVector(0, 1.3, 0, 0, 0)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local GlowAdd = LUI.UIImage.new(0, 0.87, 30, 30, 1, 1, -60, 0)
	GlowAdd:setAlpha(0)
	GlowAdd:setImage(RegisterImage("uie_circularglow"))
	GlowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(GlowAdd)
	self.GlowAdd = GlowAdd
	local BigBarGlow = LUI.UIImage.new(-0.5, 1.5, 0, 0, 1, 1, -20, 15)
	BigBarGlow:setAlpha(0)
	BigBarGlow:setImage(RegisterImage("uie_ui_menu_common_tab_glow"))
	BigBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BigBarGlow:setShaderVector(0, 1.36, 0, 0, 0)
	self:addElement(BigBarGlow)
	self.BigBarGlow = BigBarGlow
	local BigBarBacking = LUI.UIImage.new(-0.25, 1.25, 0, 0, 1, 1, -9, 4)
	BigBarBacking:setAlpha(0)
	BigBarBacking:setImage(RegisterImage("uie_ui_menu_common_tab_backing"))
	BigBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BigBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	self:addElement(BigBarBacking)
	self.BigBarBacking = BigBarBacking
	local SmallBarGlow = LUI.UIImage.new(-0.5, 1.5, 0, 0, 1, 1, -17, 1)
	SmallBarGlow:setAlpha(0)
	SmallBarGlow:setImage(RegisterImage("uie_ui_menu_common_tab_glow"))
	SmallBarGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SmallBarGlow:setShaderVector(0, 1.36, 0, 0, 0)
	self:addElement(SmallBarGlow)
	self.SmallBarGlow = SmallBarGlow
	local SmallBarBacking = LUI.UIImage.new(-0.25, 1.25, 0, 0, 1, 1, -11, -5)
	SmallBarBacking:setAlpha(0)
	SmallBarBacking:setImage(RegisterImage("uie_ui_menu_common_tab_backing"))
	SmallBarBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SmallBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	self:addElement(SmallBarBacking)
	self.SmallBarBacking = SmallBarBacking
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.28, 0.28, 0.28)
	DotTiledBacking.TiledShaderImage:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local footerTooltip = CoD.FooterButton_Tooltip.new(f1_arg0, f1_arg1, 0, 0, 0, 262, 0, 0, -36, 0)
	footerTooltip:setAlpha(0)
	footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/select"))
	self:addElement(footerTooltip)
	self.footerTooltip = footerTooltip
	local EmblemBG = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 45)
	EmblemBG:setRGB(0.05, 0.05, 0.05)
	EmblemBG:setAlpha(0.9)
	self:addElement(EmblemBG)
	self.EmblemBG = EmblemBG
	local TopBar = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 3)
	TopBar:setRGB(0.63, 0.63, 0.67)
	TopBar:setAlpha(0.95)
	TopBar:setImage(RegisterImage("uie_ui_menu_cac_primary_button_top_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TopBar:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local BorderL = LUI.UIImage.new(0, 0, -1, 0, 0, 1, 0, 0)
	BorderL:setRGB(0, 0, 0)
	self:addElement(BorderL)
	self.BorderL = BorderL
	local BorderL2 = LUI.UIImage.new(0, 0, -2, -1, 0, 1, 1, 1)
	BorderL2:setAlpha(0.01)
	self:addElement(BorderL2)
	self.BorderL2 = BorderL2
	local BorderR = LUI.UIImage.new(1, 1, 0, 1, 0, 1, 0, 0)
	BorderR:setRGB(0, 0, 0)
	self:addElement(BorderR)
	self.BorderR = BorderR
	local BorderR2 = LUI.UIImage.new(1, 1, -1, 0, 0, 1, 1, 1)
	BorderR2:setAlpha(0.01)
	self:addElement(BorderR2)
	self.BorderR2 = BorderR2
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1)
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine.GetModelForController(f1_arg1)
	f1_local16(f1_local15, f1_local17.LockUIShortcutInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_Player_Internal.__resetProperties = function(f6_arg0)
	f6_arg0.footerTooltip:completeAnimation()
	f6_arg0.BackingTint:completeAnimation()
	f6_arg0.SmallBarBacking:completeAnimation()
	f6_arg0.BigBarBacking:completeAnimation()
	f6_arg0.BigBarGlow:completeAnimation()
	f6_arg0.SmallBarGlow:completeAnimation()
	f6_arg0.GlowAdd:completeAnimation()
	f6_arg0.DotTiledBacking:completeAnimation()
	f6_arg0.footerTooltip:setAlpha(0)
	f6_arg0.BackingTint:setAlpha(0)
	f6_arg0.SmallBarBacking:setAlpha(0)
	f6_arg0.SmallBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	f6_arg0.BigBarBacking:setAlpha(0)
	f6_arg0.BigBarBacking:setShaderVector(0, 0.9, 0, 0, 0)
	f6_arg0.BigBarGlow:setAlpha(0)
	f6_arg0.SmallBarGlow:setAlpha(0)
	f6_arg0.GlowAdd:setAlpha(0)
	f6_arg0.GlowAdd:setScale(1, 1)
	f6_arg0.DotTiledBacking:setAlpha(0)
	f6_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0)
end
CoD.FooterButton_Player_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.footerTooltip:completeAnimation()
			f8_arg0.footerTooltip:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.footerTooltip)
		end,
	},
	Enabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.footerTooltip:completeAnimation()
			f9_arg0.footerTooltip:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.footerTooltip)
		end,
		Hide = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.footerTooltip:completeAnimation()
			f10_arg0.footerTooltip:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.footerTooltip)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(8)
			f11_arg0.BackingTint:completeAnimation()
			f11_arg0.BackingTint:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.BackingTint)
			f11_arg0.GlowAdd:completeAnimation()
			f11_arg0.GlowAdd:setAlpha(0.1)
			f11_arg0.clipFinished(f11_arg0.GlowAdd)
			f11_arg0.BigBarGlow:completeAnimation()
			f11_arg0.BigBarGlow:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.BigBarGlow)
			f11_arg0.BigBarBacking:completeAnimation()
			f11_arg0.BigBarBacking:setAlpha(0.5)
			f11_arg0.BigBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f11_arg0.clipFinished(f11_arg0.BigBarBacking)
			f11_arg0.SmallBarGlow:completeAnimation()
			f11_arg0.SmallBarGlow:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.SmallBarGlow)
			f11_arg0.SmallBarBacking:completeAnimation()
			f11_arg0.SmallBarBacking:setAlpha(0.5)
			f11_arg0.SmallBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f11_arg0.clipFinished(f11_arg0.SmallBarBacking)
			f11_arg0.DotTiledBacking:completeAnimation()
			f11_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f11_arg0.DotTiledBacking:setAlpha(1)
			f11_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.35)
			f11_arg0.clipFinished(f11_arg0.DotTiledBacking)
			f11_arg0.footerTooltip:completeAnimation()
			f11_arg0.footerTooltip:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.footerTooltip)
		end,
		GainFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(8)
			local f12_local0 = function(f13_arg0)
				f12_arg0.BackingTint:beginAnimation(200)
				f12_arg0.BackingTint:setAlpha(0.5)
				f12_arg0.BackingTint:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BackingTint:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.BackingTint:completeAnimation()
			f12_arg0.BackingTint:setAlpha(0)
			f12_local0(f12_arg0.BackingTint)
			local f12_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(80)
					f15_arg0:setAlpha(0.1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.GlowAdd:beginAnimation(120)
				f12_arg0.GlowAdd:setAlpha(0.06)
				f12_arg0.GlowAdd:setScale(1, 1)
				f12_arg0.GlowAdd:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.GlowAdd:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f12_arg0.GlowAdd:completeAnimation()
			f12_arg0.GlowAdd:setAlpha(0)
			f12_arg0.GlowAdd:setScale(0, 0.5)
			f12_local1(f12_arg0.GlowAdd)
			local f12_local2 = function(f16_arg0)
				f12_arg0.BigBarGlow:beginAnimation(200)
				f12_arg0.BigBarGlow:setAlpha(1)
				f12_arg0.BigBarGlow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BigBarGlow:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.BigBarGlow:completeAnimation()
			f12_arg0.BigBarGlow:setAlpha(0)
			f12_local2(f12_arg0.BigBarGlow)
			local f12_local3 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(49)
					f18_arg0:setAlpha(0.5)
					f18_arg0:setShaderVector(0, 1, 0, 0, 0)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f17_arg0:beginAnimation(50)
				f17_arg0:setAlpha(0.25)
				f17_arg0:setShaderVector(0, 2, 0, 0, 0)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f12_arg0.BigBarBacking:beginAnimation(100)
			f12_arg0.BigBarBacking:setAlpha(0)
			f12_arg0.BigBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f12_arg0.BigBarBacking:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
			f12_arg0.BigBarBacking:registerEventHandler("transition_complete_keyframe", f12_local3)
			local f12_local4 = function(f19_arg0)
				f12_arg0.SmallBarGlow:beginAnimation(200)
				f12_arg0.SmallBarGlow:setAlpha(1)
				f12_arg0.SmallBarGlow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.SmallBarGlow:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.SmallBarGlow:completeAnimation()
			f12_arg0.SmallBarGlow:setAlpha(0)
			f12_local4(f12_arg0.SmallBarGlow)
			local f12_local5 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(49)
					f21_arg0:setAlpha(0.5)
					f21_arg0:setShaderVector(0, 1, 0, 0, 0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f20_arg0:beginAnimation(50)
				f20_arg0:setAlpha(0.25)
				f20_arg0:setShaderVector(0, 2, 0, 0, 0)
				f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f12_arg0.SmallBarBacking:beginAnimation(100)
			f12_arg0.SmallBarBacking:setAlpha(0)
			f12_arg0.SmallBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f12_arg0.SmallBarBacking:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
			f12_arg0.SmallBarBacking:registerEventHandler("transition_complete_keyframe", f12_local5)
			local f12_local6 = function(f22_arg0)
				f12_arg0.DotTiledBacking:beginAnimation(200)
				f12_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f12_arg0.DotTiledBacking:setAlpha(1)
				f12_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.35)
				f12_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.DotTiledBacking:completeAnimation()
			f12_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f12_arg0.DotTiledBacking:setAlpha(0)
			f12_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0)
			f12_local6(f12_arg0.DotTiledBacking)
			local f12_local7 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(490)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.footerTooltip:beginAnimation(500)
				f12_arg0.footerTooltip:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.footerTooltip:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f12_arg0.footerTooltip:completeAnimation()
			f12_arg0.footerTooltip:setAlpha(0)
			f12_local7(f12_arg0.footerTooltip)
		end,
		LoseFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(8)
			local f25_local0 = function(f26_arg0)
				f25_arg0.BackingTint:beginAnimation(200)
				f25_arg0.BackingTint:setAlpha(0)
				f25_arg0.BackingTint:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BackingTint:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.BackingTint:completeAnimation()
			f25_arg0.BackingTint:setAlpha(0.5)
			f25_local0(f25_arg0.BackingTint)
			local f25_local1 = function(f27_arg0)
				f25_arg0.GlowAdd:beginAnimation(200)
				f25_arg0.GlowAdd:setAlpha(0)
				f25_arg0.GlowAdd:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.GlowAdd:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.GlowAdd:completeAnimation()
			f25_arg0.GlowAdd:setAlpha(0.1)
			f25_local1(f25_arg0.GlowAdd)
			local f25_local2 = function(f28_arg0)
				f25_arg0.BigBarGlow:beginAnimation(200)
				f25_arg0.BigBarGlow:setAlpha(0)
				f25_arg0.BigBarGlow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BigBarGlow:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.BigBarGlow:completeAnimation()
			f25_arg0.BigBarGlow:setAlpha(1)
			f25_local2(f25_arg0.BigBarGlow)
			local f25_local3 = function(f29_arg0)
				f25_arg0.BigBarBacking:beginAnimation(200)
				f25_arg0.BigBarBacking:setAlpha(0)
				f25_arg0.BigBarBacking:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.BigBarBacking:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.BigBarBacking:completeAnimation()
			f25_arg0.BigBarBacking:setAlpha(0.5)
			f25_arg0.BigBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f25_local3(f25_arg0.BigBarBacking)
			local f25_local4 = function(f30_arg0)
				f25_arg0.SmallBarGlow:beginAnimation(200)
				f25_arg0.SmallBarGlow:setAlpha(0)
				f25_arg0.SmallBarGlow:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.SmallBarGlow:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.SmallBarGlow:completeAnimation()
			f25_arg0.SmallBarGlow:setAlpha(1)
			f25_local4(f25_arg0.SmallBarGlow)
			local f25_local5 = function(f31_arg0)
				f25_arg0.SmallBarBacking:beginAnimation(200)
				f25_arg0.SmallBarBacking:setAlpha(0)
				f25_arg0.SmallBarBacking:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.SmallBarBacking:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.SmallBarBacking:completeAnimation()
			f25_arg0.SmallBarBacking:setAlpha(0.5)
			f25_arg0.SmallBarBacking:setShaderVector(0, 1, 0, 0, 0)
			f25_local5(f25_arg0.SmallBarBacking)
			local f25_local6 = function(f32_arg0)
				f25_arg0.DotTiledBacking:beginAnimation(200)
				f25_arg0.DotTiledBacking.TiledShaderImage:beginAnimation(200)
				f25_arg0.DotTiledBacking:setAlpha(0)
				f25_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0)
				f25_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.DotTiledBacking:completeAnimation()
			f25_arg0.DotTiledBacking.TiledShaderImage:completeAnimation()
			f25_arg0.DotTiledBacking:setAlpha(1)
			f25_arg0.DotTiledBacking.TiledShaderImage:setAlpha(0.35)
			f25_local6(f25_arg0.DotTiledBacking)
			f25_arg0.footerTooltip:completeAnimation()
			f25_arg0.footerTooltip:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.footerTooltip)
		end,
	},
	Hidden = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(8)
			f33_arg0.BackingTint:completeAnimation()
			f33_arg0.BackingTint:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.BackingTint)
			f33_arg0.GlowAdd:completeAnimation()
			f33_arg0.GlowAdd:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.GlowAdd)
			f33_arg0.BigBarGlow:completeAnimation()
			f33_arg0.BigBarGlow:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.BigBarGlow)
			f33_arg0.BigBarBacking:completeAnimation()
			f33_arg0.BigBarBacking:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.BigBarBacking)
			f33_arg0.SmallBarGlow:completeAnimation()
			f33_arg0.SmallBarGlow:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.SmallBarGlow)
			f33_arg0.SmallBarBacking:completeAnimation()
			f33_arg0.SmallBarBacking:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.SmallBarBacking)
			f33_arg0.DotTiledBacking:completeAnimation()
			f33_arg0.DotTiledBacking:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.DotTiledBacking)
			f33_arg0.footerTooltip:completeAnimation()
			f33_arg0.footerTooltip:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.footerTooltip)
		end,
	},
}
if not CoD.isPC then
	CoD.FooterButton_Player_Internal.__clipsPerState.Enabled.Focus = nil
	CoD.FooterButton_Player_Internal.__clipsPerState.Enabled.GainFocus = nil
	CoD.FooterButton_Player_Internal.__clipsPerState.Enabled.LoseFocus = nil
end
CoD.FooterButton_Player_Internal.__onClose = function(f34_arg0)
	f34_arg0.DotTiledBacking:close()
	f34_arg0.footerTooltip:close()
end

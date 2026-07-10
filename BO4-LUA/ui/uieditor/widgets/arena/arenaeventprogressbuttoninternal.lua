require("x64:faccd1dfad2ed9b")
require("x64:5766c26af1418aa")
require("x64:5f8cf56752aa71b")
CoD.ArenaEventProgressButtonInternal = InheritFrom(LUI.UIElement)
CoD.ArenaEventProgressButtonInternal.__defaultWidth = 382
CoD.ArenaEventProgressButtonInternal.__defaultHeight = 70
CoD.ArenaEventProgressButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventProgressButtonInternal)
	self.id = "ArenaEventProgressButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local BgTintAll = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BgTintAll:setRGB(0, 0, 0)
	BgTintAll:setAlpha(0.2)
	self:addElement(BgTintAll)
	self.BgTintAll = BgTintAll
	local BgTint = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	BgTint:setRGB(0, 0, 0)
	BgTint:setAlpha(0.25)
	self:addElement(BgTint)
	self.BgTint = BgTint
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.05)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.05)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local ArenaEventProgressButtonInternalLeaguePlay = CoD.ArenaEventProgressButtonInternalLeaguePlay.new(f1_arg0, f1_arg1, 0.5, 0.5, -191, 191, 0.5, 0.5, -35, 35)
	self:addElement(ArenaEventProgressButtonInternalLeaguePlay)
	self.ArenaEventProgressButtonInternalLeaguePlay = ArenaEventProgressButtonInternalLeaguePlay
	local ArenaEventProgressButtonInternalGauntlet = CoD.ArenaEventProgressButtonInternalGauntlet.new(f1_arg0, f1_arg1, 0.5, 0.5, -191, 191, 0.5, 0.5, -35, 35)
	ArenaEventProgressButtonInternalGauntlet:setAlpha(0)
	self:addElement(ArenaEventProgressButtonInternalGauntlet)
	self.ArenaEventProgressButtonInternalGauntlet = ArenaEventProgressButtonInternalGauntlet
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	self:mergeStateConditions({
		{
			stateName = "LeaguePlay",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"])
			end,
		},
		{
			stateName = "Gauntlet",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getglobalmodel"]()
	f1_local10(f1_local9, f1_local11["lobbyPlaylist.name"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	f1_local10(f1_local9, f1_local11["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ArenaEventProgressButtonInternalLeaguePlay.id = "ArenaEventProgressButtonInternalLeaguePlay"
	ArenaEventProgressButtonInternalGauntlet.id = "ArenaEventProgressButtonInternalGauntlet"
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventProgressButtonInternal.__resetProperties = function(f6_arg0)
	f6_arg0.ArenaEventProgressButtonInternalLeaguePlay:completeAnimation()
	f6_arg0.ArenaEventProgressButtonInternalGauntlet:completeAnimation()
	f6_arg0.BlurBg:completeAnimation()
	f6_arg0.BgTintAll:completeAnimation()
	f6_arg0.BgTint:completeAnimation()
	f6_arg0.CommonButtonOutline:completeAnimation()
	f6_arg0.FrameBorder:completeAnimation()
	f6_arg0.FrontendFrame:completeAnimation()
	f6_arg0.ArenaEventProgressButtonInternalLeaguePlay:setAlpha(1)
	f6_arg0.ArenaEventProgressButtonInternalGauntlet:setAlpha(0)
	f6_arg0.BlurBg:setAlpha(1)
	f6_arg0.BgTintAll:setAlpha(0.2)
	f6_arg0.BgTint:setAlpha(0.25)
	f6_arg0.CommonButtonOutline:setAlpha(1)
	f6_arg0.FrameBorder:setAlpha(0.05)
	f6_arg0.FrontendFrame:setAlpha(0.05)
end
CoD.ArenaEventProgressButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(8)
			f7_arg0.BlurBg:completeAnimation()
			f7_arg0.BlurBg:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BlurBg)
			f7_arg0.BgTintAll:completeAnimation()
			f7_arg0.BgTintAll:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BgTintAll)
			f7_arg0.BgTint:completeAnimation()
			f7_arg0.BgTint:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BgTint)
			f7_arg0.FrameBorder:completeAnimation()
			f7_arg0.FrameBorder:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.FrameBorder)
			f7_arg0.FrontendFrame:completeAnimation()
			f7_arg0.FrontendFrame:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.FrontendFrame)
			f7_arg0.ArenaEventProgressButtonInternalLeaguePlay:completeAnimation()
			f7_arg0.ArenaEventProgressButtonInternalLeaguePlay:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ArenaEventProgressButtonInternalLeaguePlay)
			f7_arg0.ArenaEventProgressButtonInternalGauntlet:completeAnimation()
			f7_arg0.ArenaEventProgressButtonInternalGauntlet:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ArenaEventProgressButtonInternalGauntlet)
			f7_arg0.CommonButtonOutline:completeAnimation()
			f7_arg0.CommonButtonOutline:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CommonButtonOutline)
		end,
	},
	LeaguePlay = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.ArenaEventProgressButtonInternalLeaguePlay:completeAnimation()
			f8_arg0.ArenaEventProgressButtonInternalLeaguePlay:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.ArenaEventProgressButtonInternalLeaguePlay)
			f8_arg0.ArenaEventProgressButtonInternalGauntlet:completeAnimation()
			f8_arg0.ArenaEventProgressButtonInternalGauntlet:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ArenaEventProgressButtonInternalGauntlet)
		end,
	},
	Gauntlet = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.ArenaEventProgressButtonInternalLeaguePlay:completeAnimation()
			f9_arg0.ArenaEventProgressButtonInternalLeaguePlay:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ArenaEventProgressButtonInternalLeaguePlay)
			f9_arg0.ArenaEventProgressButtonInternalGauntlet:completeAnimation()
			f9_arg0.ArenaEventProgressButtonInternalGauntlet:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ArenaEventProgressButtonInternalGauntlet)
		end,
	},
}
CoD.ArenaEventProgressButtonInternal.__onClose = function(f10_arg0)
	f10_arg0.ArenaEventProgressButtonInternalLeaguePlay:close()
	f10_arg0.ArenaEventProgressButtonInternalGauntlet:close()
	f10_arg0.CommonButtonOutline:close()
end

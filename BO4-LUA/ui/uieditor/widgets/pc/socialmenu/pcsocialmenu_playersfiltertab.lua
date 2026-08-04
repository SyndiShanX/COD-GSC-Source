require("ui/uieditor/widgets/rightstickpagination")
CoD.PCSocialMenu_PlayersFilterTab = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_PlayersFilterTab.__defaultWidth = 200
CoD.PCSocialMenu_PlayersFilterTab.__defaultHeight = 26
CoD.PCSocialMenu_PlayersFilterTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_PlayersFilterTab)
	self.id = "PCSocialMenu_PlayersFilterTab"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Sound = LUI.UIElement.new(0, 0, 84, 116, 0, 0, -49, -17)
	self:addElement(Sound)
	self.Sound = Sound
	local GlowPC = nil
	GlowPC = LUI.UIImage.new(0, 1, 17, -17, 0, 0, 8, 34)
	GlowPC:setAlpha(0)
	GlowPC:setImage(RegisterImage("uie_director_mode_text_tab_glow_pc"))
	self:addElement(GlowPC)
	self.GlowPC = GlowPC
	local Name = LUI.UIText.new(0, 0, 0, 200, 0, 0, 7, 25)
	Name:setRGB(0.92, 0.92, 0.92)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(4)
	Name:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Name:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local RightStickPagination = CoD.RightStickPagination.new(f1_arg0, f1_arg1, 0.5, 0.5, -62, 62, 0, 0, 19, 49)
	RightStickPagination:setRGB(0.92, 0.92, 0.92)
	RightStickPagination:setAlpha(0)
	RightStickPagination:setScale(0.85, 0.85)
	self:addElement(RightStickPagination)
	self.RightStickPagination = RightStickPagination
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	EnableMouseButton(self, f1_arg1)
	EnableMouseMove(self, f1_arg1)
	return self
end
CoD.PCSocialMenu_PlayersFilterTab.__resetProperties = function(f3_arg0)
	f3_arg0.Name:completeAnimation()
	f3_arg0.RightStickPagination:completeAnimation()
	f3_arg0.GlowPC:completeAnimation()
	f3_arg0.Name:setRGB(0.92, 0.92, 0.92)
	f3_arg0.Name:setAlpha(1)
	f3_arg0.RightStickPagination:setRGB(0.92, 0.92, 0.92)
	f3_arg0.RightStickPagination:setAlpha(0)
	f3_arg0.GlowPC:setAlpha(0)
end
CoD.PCSocialMenu_PlayersFilterTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Active = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Name:completeAnimation()
			f5_arg0.Name:setRGB(0.92, 0.89, 0.72)
			f5_arg0.clipFinished(f5_arg0.Name)
			f5_arg0.RightStickPagination:completeAnimation()
			f5_arg0.RightStickPagination:setRGB(0.92, 0.92, 0.92)
			f5_arg0.RightStickPagination:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.RightStickPagination)
		end,
		ActiveAndFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.GlowPC:completeAnimation()
			f6_arg0.GlowPC:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.GlowPC)
			f6_arg0.Name:completeAnimation()
			f6_arg0.Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f6_arg0.clipFinished(f6_arg0.Name)
			f6_arg0.RightStickPagination:completeAnimation()
			f6_arg0.RightStickPagination:setRGB(0.92, 0.92, 0.92)
			f6_arg0.RightStickPagination:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.RightStickPagination)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.GlowPC:completeAnimation()
			f7_arg0.GlowPC:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.GlowPC)
			f7_arg0.Name:completeAnimation()
			f7_arg0.Name:setRGB(0.92, 0.92, 0.92)
			f7_arg0.Name:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Name)
		end,
	},
	Disabled = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Name:completeAnimation()
			f8_arg0.Name:setAlpha(0.1)
			f8_arg0.clipFinished(f8_arg0.Name)
		end,
	},
}
if not CoD.isPC then
	CoD.PCSocialMenu_PlayersFilterTab.__clipsPerState.DefaultState.ActiveAndFocus = nil
	CoD.PCSocialMenu_PlayersFilterTab.__clipsPerState.DefaultState.Focus = nil
end
CoD.PCSocialMenu_PlayersFilterTab.__onClose = function(f9_arg0)
	f9_arg0.Name:close()
	f9_arg0.RightStickPagination:close()
end

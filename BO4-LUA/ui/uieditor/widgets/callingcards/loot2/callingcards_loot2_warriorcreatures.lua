require("x64:53a1a33ed8c3d04")
CoD[@"hash_1687E459DB800FBA"] = InheritFrom(LUI.UIElement)
CoD[@"hash_1687E459DB800FBA"].__defaultWidth = 960
CoD[@"hash_1687E459DB800FBA"].__defaultHeight = 240
CoD[@"hash_1687E459DB800FBA"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_1687E459DB800FBA"])
	self.id = "callingcards_loot2_warriorcreatures"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_bg"))
	self:addElement(bg)
	self.bg = bg
	local character02 = LUI.UIImage.new(0, 0, 93, 157, 0, 0, 20, 108)
	character02:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_char2"))
	self:addElement(character02)
	self.character02 = character02
	local helmet = LUI.UIImage.new(0, 0, 0, 272, 0, 0, 48, 240)
	helmet:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_helmet"))
	self:addElement(helmet)
	self.helmet = helmet
	local arrow = LUI.UIImage.new(0, 0, 101, 397, 0, 0, -72, 120)
	arrow:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_arrow"))
	self:addElement(arrow)
	self.arrow = arrow
	local character01 = CoD.callingcards_loot2_warriorcreatures_character.new(f1_arg0, f1_arg1, 0, 0, 294, 933, 0, 0, -88, 240)
	self:addElement(character01)
	self.character01 = character01
	local arrow01 = LUI.UIImage.new(0, 0, -55, 305, 0, 0, -144, -88)
	arrow01:setZRot(-38)
	arrow01:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_arrow02"))
	self:addElement(arrow01)
	self.arrow01 = arrow01
	local arrow02 = LUI.UIImage.new(0, 0, -379, -19, 0, 0, -124, -68)
	arrow02:setZRot(-29)
	arrow02:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_arrow02"))
	self:addElement(arrow02)
	self.arrow02 = arrow02
	local arrow03 = LUI.UIImage.new(0, 0, -55, 305, 0, 0, -144, -88)
	arrow03:setZRot(-38)
	arrow03:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_arrow02"))
	self:addElement(arrow03)
	self.arrow03 = arrow03
	local arrow04 = LUI.UIImage.new(0, 0, -379, -19, 0, 0, -124, -68)
	arrow04:setZRot(-29)
	arrow04:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_arrow02"))
	self:addElement(arrow04)
	self.arrow04 = arrow04
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_1687E459DB800FBA"].__resetProperties = function(f2_arg0)
	f2_arg0.character01:completeAnimation()
	f2_arg0.arrow01:completeAnimation()
	f2_arg0.arrow02:completeAnimation()
	f2_arg0.arrow04:completeAnimation()
	f2_arg0.arrow03:completeAnimation()
	f2_arg0.character01:setLeftRight(0, 0, 294, 933)
	f2_arg0.arrow01:setLeftRight(0, 0, -55, 305)
	f2_arg0.arrow01:setTopBottom(0, 0, -144, -88)
	f2_arg0.arrow02:setLeftRight(0, 0, -379, -19)
	f2_arg0.arrow02:setTopBottom(0, 0, -124, -68)
	f2_arg0.arrow04:setLeftRight(0, 0, -379, -19)
	f2_arg0.arrow04:setTopBottom(0, 0, -124, -68)
	f2_arg0.arrow03:setLeftRight(0, 0, -55, 305)
	f2_arg0.arrow03:setTopBottom(0, 0, -144, -88)
end
CoD[@"hash_1687E459DB800FBA"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:setLeftRight(0, 0, 320, 959)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.character01:playClip("DefaultClip")
				f3_arg0.character01:beginAnimation(1500, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.character01:setLeftRight(0, 0, 260, 899)
				f3_arg0.character01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.character01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.character01:completeAnimation()
			f3_arg0.character01:setLeftRight(0, 0, 320, 959)
			f3_local0(f3_arg0.character01)
			local f3_local1 = function(f7_arg0)
				f7_arg0:beginAnimation(390, Enum[@"luitween"][@"luitween_ease_in"])
				f7_arg0:setLeftRight(0, 0, 440, 800)
				f7_arg0:setTopBottom(0, 0, 330, 386)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.arrow01:beginAnimation(310)
			f3_arg0.arrow01:setLeftRight(0, 0, -55, 305)
			f3_arg0.arrow01:setTopBottom(0, 0, -144, -88)
			f3_arg0.arrow01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.arrow01:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f8_arg0)
				f8_arg0:beginAnimation(399, Enum[@"luitween"][@"luitween_ease_in"])
				f8_arg0:setLeftRight(0, 0, 341, 701)
				f8_arg0:setTopBottom(0, 0, 308, 364)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.arrow02:beginAnimation(600)
			f3_arg0.arrow02:setLeftRight(0, 0, -339, 21)
			f3_arg0.arrow02:setTopBottom(0, 0, -130, -74)
			f3_arg0.arrow02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.arrow02:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f9_arg0)
				f9_arg0:beginAnimation(399)
				f9_arg0:setLeftRight(0, 0, 341, 701)
				f9_arg0:setTopBottom(0, 0, 308, 364)
				f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.arrow03:beginAnimation(1720)
			f3_arg0.arrow03:setLeftRight(0, 0, -253, 107)
			f3_arg0.arrow03:setTopBottom(0, 0, -148, -92)
			f3_arg0.arrow03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.arrow03:registerEventHandler("transition_complete_keyframe", f3_local3)
			local f3_local4 = function(f10_arg0)
				f10_arg0:beginAnimation(399)
				f10_arg0:setLeftRight(0, 0, 341, 701)
				f10_arg0:setTopBottom(0, 0, 308, 364)
				f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.arrow04:beginAnimation(1390)
			f3_arg0.arrow04:setLeftRight(0, 0, -339, 21)
			f3_arg0.arrow04:setTopBottom(0, 0, -130, -74)
			f3_arg0.arrow04:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.arrow04:registerEventHandler("transition_complete_keyframe", f3_local4)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_1687E459DB800FBA"].__onClose = function(f11_arg0)
	f11_arg0.character01:close()
end

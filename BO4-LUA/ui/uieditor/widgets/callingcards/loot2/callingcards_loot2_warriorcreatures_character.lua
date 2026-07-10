require("x64:384afdd08f080ae")
require("x64:cd4dbef75b3411f")
CoD.callingcards_loot2_warriorcreatures_character = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_warriorcreatures_character.__defaultWidth = 639
CoD.callingcards_loot2_warriorcreatures_character.__defaultHeight = 328
CoD.callingcards_loot2_warriorcreatures_character.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_warriorcreatures_character)
	self.id = "callingcards_loot2_warriorcreatures_character"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local shield = LUI.UIImage.new(0, 0, 0, 416, 0, 0, 0, 328)
	shield:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_shield"))
	self:addElement(shield)
	self.shield = shield
	local tail = CoD.callingcards_loot2_warriorcreatures_tail.new(f1_arg0, f1_arg1, 0, 0, 477, 487, 0, 0, 285, 295)
	self:addElement(tail)
	self.tail = tail
	local hat = CoD.callingcards_loot2_warriorcreatures_hat.new(f1_arg0, f1_arg1, 0, 0, 335, 345, 0, 0, 92, 102)
	self:addElement(hat)
	self.hat = hat
	local character01 = LUI.UIImage.new(0, 0, 91, 555, 0, 0, 72, 328)
	character01:setImage(RegisterImage(@"uie_ui_menu_callingcards_warriorcreatures_char"))
	self:addElement(character01)
	self.character01 = character01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_loot2_warriorcreatures_character.__resetProperties = function(f2_arg0)
	f2_arg0.tail:completeAnimation()
	f2_arg0.shield:completeAnimation()
	f2_arg0.hat:completeAnimation()
	f2_arg0.tail:setZRot(0)
	f2_arg0.shield:setLeftRight(0, 0, 0, 416)
	f2_arg0.shield:setTopBottom(0, 0, 0, 328)
	f2_arg0.shield:setZRot(0)
	f2_arg0.hat:setZRot(0)
end
CoD.callingcards_loot2_warriorcreatures_character.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setLeftRight(0, 0, 5, 421)
					f5_arg0:setTopBottom(0, 0, 0, 328)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.shield:beginAnimation(1500)
				f3_arg0.shield:setLeftRight(0, 0, -15, 401)
				f3_arg0.shield:setTopBottom(0, 0, 20, 348)
				f3_arg0.shield:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.shield:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.shield:completeAnimation()
			f3_arg0.shield:setLeftRight(0, 0, 5, 421)
			f3_arg0.shield:setTopBottom(0, 0, 0, 328)
			f3_arg0.shield:setZRot(0)
			f3_local0(f3_arg0.shield)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500)
					f7_arg0:setZRot(10)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.tail:beginAnimation(1500)
				f3_arg0.tail:setZRot(-10)
				f3_arg0.tail:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.tail:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.tail:completeAnimation()
			f3_arg0.tail:setZRot(10)
			f3_local1(f3_arg0.tail)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1500)
					f9_arg0:setZRot(-15)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.hat:beginAnimation(1500)
				f3_arg0.hat:setZRot(0)
				f3_arg0.hat:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hat:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.hat:completeAnimation()
			f3_arg0.hat:setZRot(-15)
			f3_local2(f3_arg0.hat)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_loot2_warriorcreatures_character.__onClose = function(f10_arg0)
	f10_arg0.tail:close()
	f10_arg0.hat:close()
end

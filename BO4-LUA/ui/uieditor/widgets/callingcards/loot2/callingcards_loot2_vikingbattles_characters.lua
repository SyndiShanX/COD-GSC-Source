require("x64:61dbb20c95d491d")
CoD.callingcards_loot2_vikingbattles_characters = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_vikingbattles_characters.__defaultWidth = 748
CoD.callingcards_loot2_vikingbattles_characters.__defaultHeight = 450
CoD.callingcards_loot2_vikingbattles_characters.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_vikingbattles_characters)
	self.id = "callingcards_loot2_vikingbattles_characters"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local helmet = LUI.UIImage.new(0, 0, 0, 152, 0, 0, 0, 184)
	helmet:setImage(RegisterImage(0xF1B80FD6E4AF03C))
	self:addElement(helmet)
	self.helmet = helmet
	local character02lefthand = LUI.UIImage.new(0, 0, 301.5, 421.5, 0, 0, 59, 139)
	character02lefthand:setImage(RegisterImage(0x283E927768570A6))
	self:addElement(character02lefthand)
	self.character02lefthand = character02lefthand
	local character02 = LUI.UIImage.new(0, 0, 114, 356, 0, 0, 50, 450)
	character02:setZRot(51)
	character02:setImage(RegisterImage(0xDC302B66FA10222))
	self:addElement(character02)
	self.character02 = character02
	local character01 = LUI.UIImage.new(0, 0, 163.5, 747.5, 0, 0, 0, 360)
	character01:setImage(RegisterImage(0xDC301B66FA1006F))
	self:addElement(character01)
	self.character01 = character01
	local character02righthand = CoD.callingcards_loot2_vikingbattles_righthand.new(f1_arg0, f1_arg1, 0, 0, 119, 129, 0, 0, 267, 277)
	self:addElement(character02righthand)
	self.character02righthand = character02righthand
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_loot2_vikingbattles_characters.__resetProperties = function(f2_arg0)
	f2_arg0.helmet:completeAnimation()
	f2_arg0.character02:completeAnimation()
	f2_arg0.character02lefthand:completeAnimation()
	f2_arg0.character02righthand:completeAnimation()
	f2_arg0.helmet:setLeftRight(0, 0, 0, 152)
	f2_arg0.helmet:setTopBottom(0, 0, 0, 184)
	f2_arg0.helmet:setZRot(0)
	f2_arg0.character02:setLeftRight(0, 0, 114, 356)
	f2_arg0.character02:setTopBottom(0, 0, 50, 450)
	f2_arg0.character02lefthand:setLeftRight(0, 0, 301.5, 421.5)
	f2_arg0.character02lefthand:setTopBottom(0, 0, 59, 139)
	f2_arg0.character02lefthand:setZRot(0)
	f2_arg0.character02righthand:setLeftRight(0, 0, 119, 129)
	f2_arg0.character02righthand:setTopBottom(0, 0, 267, 277)
	f2_arg0.character02righthand:setZRot(0)
end
CoD.callingcards_loot2_vikingbattles_characters.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setLeftRight(0, 0, 0, 152)
					f5_arg0:setTopBottom(0, 0, 0, 184)
					f5_arg0:setZRot(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.helmet:beginAnimation(1500)
				f3_arg0.helmet:setLeftRight(0, 0, -28, 124)
				f3_arg0.helmet:setTopBottom(0, 0, 9, 193)
				f3_arg0.helmet:setZRot(15)
				f3_arg0.helmet:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.helmet:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.helmet:completeAnimation()
			f3_arg0.helmet:setLeftRight(0, 0, 0, 152)
			f3_arg0.helmet:setTopBottom(0, 0, 0, 184)
			f3_arg0.helmet:setZRot(0)
			f3_local0(f3_arg0.helmet)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(2010)
					f7_arg0:setLeftRight(0, 0, 301, 421)
					f7_arg0:setTopBottom(0, 0, 59, 139)
					f7_arg0:setZRot(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.character02lefthand:beginAnimation(990)
				f3_arg0.character02lefthand:setLeftRight(0, 0, 267.5, 387.5)
				f3_arg0.character02lefthand:setTopBottom(0, 0, 27, 107)
				f3_arg0.character02lefthand:setZRot(20)
				f3_arg0.character02lefthand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.character02lefthand:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.character02lefthand:completeAnimation()
			f3_arg0.character02lefthand:setLeftRight(0, 0, 301, 421)
			f3_arg0.character02lefthand:setTopBottom(0, 0, 59, 139)
			f3_arg0.character02lefthand:setZRot(0)
			f3_local1(f3_arg0.character02lefthand)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1500)
					f9_arg0:setLeftRight(0, 0, 112, 354)
					f9_arg0:setTopBottom(0, 0, 50, 450)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.character02:beginAnimation(1500)
				f3_arg0.character02:setLeftRight(0, 0, 130, 372)
				f3_arg0.character02:setTopBottom(0, 0, 45, 445)
				f3_arg0.character02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.character02:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.character02:completeAnimation()
			f3_arg0.character02:setLeftRight(0, 0, 112, 354)
			f3_arg0.character02:setTopBottom(0, 0, 50, 450)
			f3_local2(f3_arg0.character02)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1500)
					f11_arg0:setLeftRight(0, 0, 119, 129)
					f11_arg0:setTopBottom(0, 0, 267, 277)
					f11_arg0:setZRot(0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.character02righthand:beginAnimation(1500)
				f3_arg0.character02righthand:setLeftRight(0, 0, 143, 153)
				f3_arg0.character02righthand:setTopBottom(0, 0, 257, 267)
				f3_arg0.character02righthand:setZRot(19)
				f3_arg0.character02righthand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.character02righthand:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.character02righthand:completeAnimation()
			f3_arg0.character02righthand:setLeftRight(0, 0, 119, 129)
			f3_arg0.character02righthand:setTopBottom(0, 0, 267, 277)
			f3_arg0.character02righthand:setZRot(0)
			f3_local3(f3_arg0.character02righthand)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_loot2_vikingbattles_characters.__onClose = function(f12_arg0)
	f12_arg0.character02righthand:close()
end

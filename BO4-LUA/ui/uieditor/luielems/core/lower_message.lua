CoD.lower_message = InheritFrom(CoD.Menu)
CoD.lower_message.__stateMap = {
	"DefaultState",
	"Visible",
	"VisibleMessageOnly",
}
LUI.createMenu.lower_message = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("lower_message", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.lower_message)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local message = LUI.UIText.new(0.5, 0.5, -400, 400, 0, 0, 638, 666)
	message:setTTF("ttmussels_regular")
	message:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	message:setShaderVector(0, 0.1, 0, 0, 0)
	message:setShaderVector(1, 0, 0, 0, 1)
	message:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	message:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	message:linkToElementModel(self, "message", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			message:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(message)
	self.message = message
	local timer = LUI.UIText.new(0.5, 0.5, -400, 400, 0, 0, 668, 700)
	timer:setText(NumberAsTime(5))
	timer:setTTF("0arame_mono_stencil")
	timer:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	timer:setShaderVector(0, 0.1, 0, 0, 0)
	timer:setShaderVector(1, 0, 0, 0, 1)
	timer:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	timer:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(timer)
	self.timer = timer
	self:linkToElementModel(self, "countdownTimeSeconds", true, function(model)
		local f3_local0 = self
		CoD.HUDUtility.UpdateMessageTimer(self.timer, model)
	end)
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
CoD.lower_message.__resetProperties = function(f4_arg0)
	f4_arg0.message:completeAnimation()
	f4_arg0.timer:completeAnimation()
	f4_arg0.message:setAlpha(1)
	f4_arg0.timer:setAlpha(1)
end
CoD.lower_message.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.message:completeAnimation()
			f5_arg0.message:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.message)
			f5_arg0.timer:completeAnimation()
			f5_arg0.timer:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.timer)
		end,
		Visible = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f6_arg0.message:beginAnimation(500)
				f6_arg0.message:setAlpha(1)
				f6_arg0.message:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.message:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.message:completeAnimation()
			f6_arg0.message:setAlpha(0)
			f6_local0(f6_arg0.message)
			local f6_local1 = function(f8_arg0)
				f6_arg0.timer:beginAnimation(500)
				f6_arg0.timer:setAlpha(1)
				f6_arg0.timer:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.timer:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.timer:completeAnimation()
			f6_arg0.timer:setAlpha(0)
			f6_local1(f6_arg0.timer)
		end,
		VisibleMessageOnly = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.message:beginAnimation(500)
				f9_arg0.message:setAlpha(1)
				f9_arg0.message:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.message:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.message:completeAnimation()
			f9_arg0.message:setAlpha(0)
			f9_local0(f9_arg0.message)
			f9_arg0.timer:completeAnimation()
			f9_arg0.timer:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.timer)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.message:beginAnimation(500)
				f12_arg0.message:setAlpha(0)
				f12_arg0.message:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.message:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.message:completeAnimation()
			f12_arg0.message:setAlpha(1)
			f12_local0(f12_arg0.message)
			local f12_local1 = function(f14_arg0)
				f12_arg0.timer:beginAnimation(500)
				f12_arg0.timer:setAlpha(0)
				f12_arg0.timer:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.timer:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.timer:completeAnimation()
			f12_arg0.timer:setAlpha(1)
			f12_local1(f12_arg0.timer)
		end,
	},
	VisibleMessageOnly = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.timer:completeAnimation()
			f15_arg0.timer:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.timer)
		end,
		DefaultState = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			local f16_local0 = function(f17_arg0)
				f16_arg0.message:beginAnimation(500)
				f16_arg0.message:setAlpha(0)
				f16_arg0.message:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.message:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.message:completeAnimation()
			f16_arg0.message:setAlpha(1)
			f16_local0(f16_arg0.message)
			f16_arg0.timer:completeAnimation()
			f16_arg0.timer:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.timer)
		end,
	},
}
CoD.lower_message.__onClose = function(f18_arg0)
	f18_arg0.message:close()
end

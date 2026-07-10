CoD.DirectorFullscreenBlack = InheritFrom(LUI.UIElement)
CoD.DirectorFullscreenBlack.__defaultWidth = 1920
CoD.DirectorFullscreenBlack.__defaultHeight = 1080
CoD.DirectorFullscreenBlack.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFullscreenBlack)
	self.id = "DirectorFullscreenBlack"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FullScreenBlack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FullScreenBlack:setRGB(0, 0, 0)
	FullScreenBlack:setAlpha(0)
	self:addElement(FullScreenBlack)
	self.FullScreenBlack = FullScreenBlack
	self:mergeStateConditions({
		{
			stateName = "Black",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.fullscreenBlackCount", 0)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.fullscreenBlackCount"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.fullscreenBlackCount",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorFullscreenBlack.__resetProperties = function(f4_arg0)
	f4_arg0.FullScreenBlack:completeAnimation()
	f4_arg0.FullScreenBlack:setAlpha(0)
end
CoD.DirectorFullscreenBlack.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Black = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.FullScreenBlack:beginAnimation(200)
				f6_arg0.FullScreenBlack:setAlpha(1)
				f6_arg0.FullScreenBlack:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.FullScreenBlack:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.FullScreenBlack:completeAnimation()
			f6_arg0.FullScreenBlack:setAlpha(0)
			f6_local0(f6_arg0.FullScreenBlack)
		end,
	},
	Black = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(200)
					f10_arg0:setAlpha(0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.FullScreenBlack:beginAnimation(2000)
				f8_arg0.FullScreenBlack:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FullScreenBlack:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.FullScreenBlack:completeAnimation()
			f8_arg0.FullScreenBlack:setAlpha(1)
			f8_local0(f8_arg0.FullScreenBlack)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.FullScreenBlack:beginAnimation(200)
				f11_arg0.FullScreenBlack:setAlpha(0)
				f11_arg0.FullScreenBlack:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FullScreenBlack:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FullScreenBlack:completeAnimation()
			f11_arg0.FullScreenBlack:setAlpha(1)
			f11_local0(f11_arg0.FullScreenBlack)
		end,
	},
}

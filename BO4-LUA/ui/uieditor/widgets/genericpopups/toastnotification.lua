require("x64:cbc3d81e3f40cac")
CoD.ToastNotification = InheritFrom(LUI.UIElement)
CoD.ToastNotification.__defaultWidth = 1920
CoD.ToastNotification.__defaultHeight = 1080
CoD.ToastNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "FrontendToast.notify", false)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "FrontendToast.state")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "FrontendToast.kicker")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "FrontendToast.description")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "FrontendToast.contentIcon")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "FrontendToast.functionIcon")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "FrontendToast.emblemDecal")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "FrontendToast.backgroundId")
	self:setClass(CoD.ToastNotification)
	self.id = "ToastNotification"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ToastContainer = CoD.Toast_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, -197, 143, 1, 1, -145, -65)
	ToastContainer:setAlpha(0)
	self:addElement(ToastContainer)
	self.ToastContainer = ToastContainer
	local Sound = LUI.UIElement.new(0, 0, -363, -291, 0, 0, 495, 567)
	self:addElement(Sound)
	self.Sound = Sound
	ToastContainer.id = "ToastContainer"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.NotificationUtility.InitToastContainer(self, f1_arg1, f1_arg0, self.ToastContainer)
	return self
end
CoD.ToastNotification.__resetProperties = function(f2_arg0)
	f2_arg0.ToastContainer:completeAnimation()
	f2_arg0.Sound:completeAnimation()
	f2_arg0.ToastContainer:setLeftRight(0.5, 0.5, -197, 143)
	f2_arg0.ToastContainer:setTopBottom(1, 1, -145, -65)
	f2_arg0.ToastContainer:setAlpha(0)
	f2_arg0.Sound:setPlaySoundDirect(false)
end
CoD.ToastNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Show = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								f9_arg0:beginAnimation(229)
								f9_arg0:setTopBottom(1, 1, 56.5, 143.5)
								f9_arg0:setAlpha(0)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f8_arg0:beginAnimation(40)
							f8_arg0:setTopBottom(1, 1, -158.5, -71.5)
							f8_arg0:setAlpha(0.85)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(2830)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(40)
					f6_arg0:setTopBottom(1, 1, -148.5, -61.5)
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.ToastContainer:beginAnimation(230, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f4_arg0.ToastContainer:setTopBottom(1, 1, -158.5, -71.5)
				f4_arg0.ToastContainer:setAlpha(0.85)
				f4_arg0.ToastContainer:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ToastContainer:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.ToastContainer:completeAnimation()
			f4_arg0.ToastContainer:setLeftRight(0.5, 0.5, -225, 225)
			f4_arg0.ToastContainer:setTopBottom(1, 1, 56.5, 143.5)
			f4_arg0.ToastContainer:setAlpha(0)
			f4_local0(f4_arg0.ToastContainer)
			f4_arg0.Sound:completeAnimation()
			f4_arg0.Sound:setPlaySoundDirect(true)
			f4_arg0.Sound:playSound("uin_bm_popup", f4_arg1)
			f4_arg0.clipFinished(f4_arg0.Sound)
		end,
	},
}
CoD.ToastNotification.__onClose = function(f10_arg0)
	f10_arg0.ToastContainer:close()
end

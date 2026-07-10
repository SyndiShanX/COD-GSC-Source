CoD.PositionDraft_StatusBannerFui = InheritFrom(LUI.UIElement)
CoD.PositionDraft_StatusBannerFui.__defaultWidth = 88
CoD.PositionDraft_StatusBannerFui.__defaultHeight = 54
CoD.PositionDraft_StatusBannerFui.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_StatusBannerFui)
	self.id = "PositionDraft_StatusBannerFui"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LayoutLineBR = LUI.UIImage.new(0, 0, 20, 88, 0, 0, 15, 39)
	LayoutLineBR:setAlpha(0.4)
	LayoutLineBR:setImage(RegisterImage(0xE44ABB390F5F528))
	LayoutLineBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	LayoutLineBR:setShaderVector(0, 0, 1, 0, 0)
	LayoutLineBR:setShaderVector(1, 0, 0, 0, 0)
	LayoutLineBR:setShaderVector(2, 0, 1, 0, 0)
	LayoutLineBR:setShaderVector(3, 0, 0, 0, 0)
	LayoutLineBR:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LayoutLineBR)
	self.LayoutLineBR = LayoutLineBR
	local LayoutLineBRAdd = LUI.UIImage.new(0, 0, 20, 88, 0, 0, 15, 39)
	LayoutLineBRAdd:setAlpha(0.4)
	LayoutLineBRAdd:setImage(RegisterImage(0xE44ABB390F5F528))
	LayoutLineBRAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	LayoutLineBRAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(LayoutLineBRAdd)
	self.LayoutLineBRAdd = LayoutLineBRAdd
	local microtextImage2 = LUI.UIImage.new(0, 0, 0, 18, 0, 0, 24.5, 28.5)
	microtextImage2:setAlpha(0.2)
	microtextImage2:setZRot(180)
	microtextImage2:setImage(RegisterImage(0x16C3274D8031268))
	self:addElement(microtextImage2)
	self.microtextImage2 = microtextImage2
	local Pip = LUI.UIImage.new(0, 0, 80, 88, 0, 0, 0, 8)
	Pip:setImage(RegisterImage(0x364778639313CE9))
	Pip:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Pip)
	self.Pip = Pip
	local Pip02 = LUI.UIImage.new(0, 0, 80, 88, 0, 0, 46, 54)
	Pip02:setImage(RegisterImage(0x364778639313CE9))
	Pip02:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Pip02)
	self.Pip02 = Pip02
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_StatusBannerFui.__resetProperties = function(f2_arg0)
	f2_arg0.LayoutLineBR:completeAnimation()
	f2_arg0.microtextImage2:completeAnimation()
	f2_arg0.LayoutLineBR:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.LayoutLineBR:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.LayoutLineBR:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.LayoutLineBR:setShaderVector(3, 0, 0, 0, 0)
	f2_arg0.LayoutLineBR:setShaderVector(4, 0, 0, 0, 0)
	f2_arg0.microtextImage2:setAlpha(0.2)
end
CoD.PositionDraft_StatusBannerFui.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(299)
							f7_arg0:setShaderVector(0, 0, 0, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(100)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(300)
					f5_arg0:setShaderVector(0, 0, 1, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.LayoutLineBR:beginAnimation(200)
				f3_arg0.LayoutLineBR:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.LayoutLineBR:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.LayoutLineBR:completeAnimation()
			f3_arg0.LayoutLineBR:setShaderVector(0, 1, 1, 0, 0)
			f3_arg0.LayoutLineBR:setShaderVector(1, 0, 0, 0, 0)
			f3_arg0.LayoutLineBR:setShaderVector(2, 0, 1, 0, 0)
			f3_arg0.LayoutLineBR:setShaderVector(3, 0, 0, 0, 0)
			f3_arg0.LayoutLineBR:setShaderVector(4, 0, 0, 0, 0)
			f3_local0(f3_arg0.LayoutLineBR)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(100)
							f11_arg0:setAlpha(0.2)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(299)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(100)
					f9_arg0:setAlpha(0.4)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.microtextImage2:beginAnimation(500)
				f3_arg0.microtextImage2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.microtextImage2:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.microtextImage2:completeAnimation()
			f3_arg0.microtextImage2:setAlpha(0.2)
			f3_local1(f3_arg0.microtextImage2)
		end,
	},
}

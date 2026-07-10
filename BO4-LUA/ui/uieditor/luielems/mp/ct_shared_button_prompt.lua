CoD.ct_shared_button_prompt = InheritFrom(CoD.Menu)
CoD.ct_shared_button_prompt.__stateMap = {
	"DefaultState",
	"smoke_button",
	"frag_button",
	"smoke_button_off",
	"frag_button_off",
	"x_button",
	"x_button_off",
	"smoke_button_paused",
	"frag_button_paused",
	"x_button_paused",
	"x_button_paused_off",
	"smoke_button_paused_off",
	"frag_button_paused_off",
	"square_button",
	"square_button_paused",
	"square_button_paused_off",
	"square_button_off",
}
LUI.createMenu.ct_shared_button_prompt = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_shared_button_prompt", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_shared_button_prompt)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Prompt = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, 265, 300)
	Prompt:setAlpha(0)
	Prompt:setText(Engine[0xF9F1239CFD921FE](0xD9839F8FF9FDC54))
	Prompt:setTTF("default")
	Prompt:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Prompt:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Prompt:setBackingType(2)
	Prompt:setBackingAlpha(0.75)
	Prompt:setBackingXPadding(14)
	Prompt:setBackingYPadding(8)
	Prompt:setBackingImage(RegisterImage(0xF5B05C37854785F))
	self:addElement(Prompt)
	self.Prompt = Prompt
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
CoD.ct_shared_button_prompt.__resetProperties = function(f2_arg0)
	f2_arg0.Prompt:completeAnimation()
	f2_arg0.Prompt:setTopBottom(0.5, 0.5, 265, 300)
	f2_arg0.Prompt:setAlpha(0)
	f2_arg0.Prompt:setScale(1, 1)
	f2_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0xD9839F8FF9FDC54))
end
CoD.ct_shared_button_prompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.Prompt:beginAnimation(500)
				f3_arg0.Prompt:setAlpha(1)
				f3_arg0.Prompt:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Prompt:completeAnimation()
			f3_arg0.Prompt:setAlpha(0)
			f3_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x1B01416865ABF59))
			f3_local0(f3_arg0.Prompt)
		end,
	},
	smoke_button = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Prompt:beginAnimation(500)
				f5_arg0.Prompt:setAlpha(1)
				f5_arg0.Prompt:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Prompt:completeAnimation()
			f5_arg0.Prompt:setAlpha(0)
			f5_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0xD0184DBAD302D84))
			f5_local0(f5_arg0.Prompt)
		end,
	},
	frag_button = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Prompt:beginAnimation(500)
				f7_arg0.Prompt:setAlpha(1)
				f7_arg0.Prompt:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Prompt:completeAnimation()
			f7_arg0.Prompt:setAlpha(0)
			f7_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x46C773F79101F9F))
			f7_local0(f7_arg0.Prompt)
		end,
	},
	smoke_button_off = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Prompt:beginAnimation(500)
				f9_arg0.Prompt:setScale(0.1, 0.1)
				f9_arg0.Prompt:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Prompt:completeAnimation()
			f9_arg0.Prompt:setAlpha(1)
			f9_arg0.Prompt:setScale(1, 1)
			f9_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x46C773F79101F9F))
			f9_local0(f9_arg0.Prompt)
		end,
	},
	frag_button_off = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Prompt:beginAnimation(500)
				f11_arg0.Prompt:setScale(0.1, 0.1)
				f11_arg0.Prompt:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Prompt:completeAnimation()
			f11_arg0.Prompt:setAlpha(1)
			f11_arg0.Prompt:setScale(1, 1)
			f11_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0xD0184DBAD302D84))
			f11_local0(f11_arg0.Prompt)
		end,
	},
	x_button = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.Prompt:beginAnimation(500)
				f13_arg0.Prompt:setAlpha(1)
				f13_arg0.Prompt:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Prompt:completeAnimation()
			f13_arg0.Prompt:setTopBottom(0, 0, 805, 840)
			f13_arg0.Prompt:setAlpha(0)
			f13_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x1B01416865ABF59))
			f13_local0(f13_arg0.Prompt)
		end,
	},
	x_button_off = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Prompt:beginAnimation(500)
				f15_arg0.Prompt:setScale(0.1, 0.1)
				f15_arg0.Prompt:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Prompt:completeAnimation()
			f15_arg0.Prompt:setAlpha(1)
			f15_arg0.Prompt:setScale(1, 1)
			f15_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x1B01416865ABF59))
			f15_local0(f15_arg0.Prompt)
		end,
	},
	smoke_button_paused = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Prompt:beginAnimation(500)
				f17_arg0.Prompt:setAlpha(1)
				f17_arg0.Prompt:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Prompt:completeAnimation()
			f17_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f17_arg0.Prompt:setAlpha(0)
			f17_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0xD0184DBAD302D84))
			f17_local0(f17_arg0.Prompt)
		end,
	},
	frag_button_paused = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.Prompt:beginAnimation(500)
				f19_arg0.Prompt:setAlpha(1)
				f19_arg0.Prompt:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.Prompt:completeAnimation()
			f19_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f19_arg0.Prompt:setAlpha(0)
			f19_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x46C773F79101F9F))
			f19_local0(f19_arg0.Prompt)
		end,
	},
	x_button_paused = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.Prompt:beginAnimation(500)
				f21_arg0.Prompt:setAlpha(1)
				f21_arg0.Prompt:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Prompt:completeAnimation()
			f21_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f21_arg0.Prompt:setAlpha(0)
			f21_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x1B01416865ABF59))
			f21_local0(f21_arg0.Prompt)
		end,
	},
	x_button_paused_off = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.Prompt:beginAnimation(500)
				f23_arg0.Prompt:setScale(0.1, 0.1)
				f23_arg0.Prompt:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Prompt:completeAnimation()
			f23_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f23_arg0.Prompt:setAlpha(1)
			f23_arg0.Prompt:setScale(1, 1)
			f23_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x1B01416865ABF59))
			f23_local0(f23_arg0.Prompt)
		end,
	},
	smoke_button_paused_off = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.Prompt:beginAnimation(500)
				f25_arg0.Prompt:setScale(0.1, 0.1)
				f25_arg0.Prompt:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.Prompt:completeAnimation()
			f25_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f25_arg0.Prompt:setAlpha(1)
			f25_arg0.Prompt:setScale(1, 1)
			f25_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x46C773F79101F9F))
			f25_local0(f25_arg0.Prompt)
		end,
	},
	frag_button_paused_off = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			local f27_local0 = function(f28_arg0)
				f27_arg0.Prompt:beginAnimation(500)
				f27_arg0.Prompt:setScale(0.1, 0.1)
				f27_arg0.Prompt:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.Prompt:completeAnimation()
			f27_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f27_arg0.Prompt:setAlpha(1)
			f27_arg0.Prompt:setScale(1, 1)
			f27_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0xD0184DBAD302D84))
			f27_local0(f27_arg0.Prompt)
		end,
	},
	square_button = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.Prompt:beginAnimation(500)
				f29_arg0.Prompt:setAlpha(1)
				f29_arg0.Prompt:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.Prompt:completeAnimation()
			f29_arg0.Prompt:setTopBottom(0, 0, 805, 840)
			f29_arg0.Prompt:setAlpha(0)
			f29_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x56002C860F8700C))
			f29_local0(f29_arg0.Prompt)
		end,
	},
	square_button_paused = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.Prompt:beginAnimation(500)
				f31_arg0.Prompt:setAlpha(1)
				f31_arg0.Prompt:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.Prompt:completeAnimation()
			f31_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f31_arg0.Prompt:setAlpha(0)
			f31_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x56002C860F8700C))
			f31_local0(f31_arg0.Prompt)
		end,
	},
	square_button_paused_off = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			local f33_local0 = function(f34_arg0)
				f33_arg0.Prompt:beginAnimation(500)
				f33_arg0.Prompt:setScale(0.1, 0.1)
				f33_arg0.Prompt:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.Prompt:completeAnimation()
			f33_arg0.Prompt:setTopBottom(0, 0, 700, 735)
			f33_arg0.Prompt:setAlpha(1)
			f33_arg0.Prompt:setScale(1, 1)
			f33_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x56002C860F8700C))
			f33_local0(f33_arg0.Prompt)
		end,
	},
	square_button_off = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			local f35_local0 = function(f36_arg0)
				f35_arg0.Prompt:beginAnimation(500)
				f35_arg0.Prompt:setScale(0.1, 0.1)
				f35_arg0.Prompt:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Prompt:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Prompt:completeAnimation()
			f35_arg0.Prompt:setAlpha(1)
			f35_arg0.Prompt:setScale(1, 1)
			f35_arg0.Prompt:setText(Engine[0xF9F1239CFD921FE](0x56002C860F8700C))
			f35_local0(f35_arg0.Prompt)
		end,
	},
}
CoD.ct_shared_button_prompt.__onClose = function(f37_arg0) end

CoD.zm_hint_text = InheritFrom(CoD.Menu)
CoD.zm_hint_text.__stateMap = {
	"DefaultState",
	"Visible",
}
LUI.createMenu.zm_hint_text = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_hint_text", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_hint_text)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local txtHintText = LUI.UIText.new(0, 1, 96, -96, 0.5, 0.5, -58.5, -25.5)
	txtHintText:setTTF("skorzhen")
	txtHintText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	txtHintText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	txtHintText:setBackingType(2)
	txtHintText:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	txtHintText:setBackingXPadding(6)
	txtHintText:setBackingYPadding(4)
	txtHintText:setBackingImage(RegisterImage(0x75D661B612187DF))
	txtHintText:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			txtHintText:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(txtHintText)
	self.txtHintText = txtHintText
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
CoD.zm_hint_text.__resetProperties = function(f3_arg0)
	f3_arg0.txtHintText:completeAnimation()
	f3_arg0.txtHintText:setAlpha(1)
end
CoD.zm_hint_text.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.txtHintText:completeAnimation()
			f4_arg0.txtHintText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.txtHintText)
		end,
		Visible = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.txtHintText:beginAnimation(250)
				f5_arg0.txtHintText:setAlpha(1)
				f5_arg0.txtHintText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.txtHintText:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.txtHintText:completeAnimation()
			f5_arg0.txtHintText:setAlpha(0)
			f5_local0(f5_arg0.txtHintText)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.txtHintText:beginAnimation(250)
				f8_arg0.txtHintText:setAlpha(0)
				f8_arg0.txtHintText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.txtHintText:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.txtHintText:completeAnimation()
			f8_arg0.txtHintText:setAlpha(1)
			f8_local0(f8_arg0.txtHintText)
		end,
	},
}
CoD.zm_hint_text.__onClose = function(f10_arg0)
	f10_arg0.txtHintText:close()
end

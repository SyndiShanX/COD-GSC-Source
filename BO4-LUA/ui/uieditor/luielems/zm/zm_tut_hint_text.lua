CoD.zm_tut_hint_text = InheritFrom(CoD.Menu)
CoD.zm_tut_hint_text.__stateMap = {
	"DefaultState",
	"Visible",
}
LUI.createMenu.zm_tut_hint_text = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_tut_hint_text", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_tut_hint_text)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local txtHintText = LUI.UIText.new(0, 1, 96, -96, 0.5, 0.5, -58.5, -25.5)
	txtHintText:setTTF("skorzhen")
	txtHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	txtHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	txtHintText:setBackingType(2)
	txtHintText:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	txtHintText:setBackingAlpha(0.4)
	txtHintText:setBackingXPadding(8)
	txtHintText:setBackingYPadding(4)
	txtHintText.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			txtHintText:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.ZombieUtility.SetTutorialHintStringControllerDependant(self, f1_arg0, f2_local0)))
		end
	end
	txtHintText:linkToElementModel(self, "text", true, txtHintText.__String_Reference)
	txtHintText.__String_Reference_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.text
		end
		if f3_local0 then
			txtHintText.__String_Reference(f3_local0)
		end
	end
	self:addElement(txtHintText)
	self.txtHintText = txtHintText
	txtHintText:appendEventHandler("input_source_changed", txtHintText.__String_Reference_FullPath)
	local f1_local3 = txtHintText
	local f1_local4 = txtHintText.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local4(f1_local3, f1_local5.LastInput, txtHintText.__String_Reference_FullPath)
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
CoD.zm_tut_hint_text.__resetProperties = function(f4_arg0)
	f4_arg0.txtHintText:completeAnimation()
	f4_arg0.txtHintText:setAlpha(1)
end
CoD.zm_tut_hint_text.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.txtHintText:completeAnimation()
			f5_arg0.txtHintText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.txtHintText)
		end,
		Visible = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.txtHintText:beginAnimation(250)
				f6_arg0.txtHintText:setAlpha(1)
				f6_arg0.txtHintText:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.txtHintText:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.txtHintText:completeAnimation()
			f6_arg0.txtHintText:setAlpha(0)
			f6_local0(f6_arg0.txtHintText)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.txtHintText:beginAnimation(250)
				f9_arg0.txtHintText:setAlpha(0)
				f9_arg0.txtHintText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.txtHintText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.txtHintText:completeAnimation()
			f9_arg0.txtHintText:setAlpha(1)
			f9_local0(f9_arg0.txtHintText)
		end,
	},
}
CoD.zm_tut_hint_text.__onClose = function(f11_arg0)
	f11_arg0.txtHintText:close()
end

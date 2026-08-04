require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmaincorners")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
require("ui/uieditor/widgets/startmenu/startmenu_frame_nobg")
CoD.StartMenu_Options_ButtonOption = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_ButtonOption.__defaultWidth = 760
CoD.StartMenu_Options_ButtonOption.__defaultHeight = 60
CoD.StartMenu_Options_ButtonOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_ButtonOption)
	self.id = "StartMenu_Options_ButtonOption"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.13, 0.12, 0.12)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 0, 0, 760, 0, 0, 0, 60)
	self:addElement(Corner)
	self.Corner = Corner
	local actionText = LUI.UIText.new(0, 0, 12, 352, 0, 0, 19.5, 40.5)
	actionText:setRGB(0.78, 0.74, 0.67)
	actionText:setTTF("ttmussels_regular")
	actionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	actionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	actionText:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			actionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(actionText)
	self.actionText = actionText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "disabled")
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_ButtonOption.__resetProperties = function(f5_arg0)
	f5_arg0.Backing:completeAnimation()
	f5_arg0.Corner:completeAnimation()
	f5_arg0.Frame:completeAnimation()
	f5_arg0.actionText:completeAnimation()
	f5_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f5_arg0.Backing:setAlpha(0.5)
	f5_arg0.Corner:setScale(1, 1)
	f5_arg0.Frame:setAlpha(0.04)
	f5_arg0.actionText:setRGB(0.78, 0.74, 0.67)
end
CoD.StartMenu_Options_ButtonOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f7_arg0.Backing:setAlpha(0.2)
			f7_arg0.clipFinished(f7_arg0.Backing)
			f7_arg0.Frame:completeAnimation()
			f7_arg0.Frame:setAlpha(0.6)
			f7_arg0.clipFinished(f7_arg0.Frame)
			f7_arg0.Corner:completeAnimation()
			f7_arg0.Corner:setScale(0.98, 0.83)
			f7_arg0.clipFinished(f7_arg0.Corner)
		end,
		GainFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Backing:beginAnimation(200)
				f8_arg0.Backing:setRGB(0.78, 0.74, 0.67)
				f8_arg0.Backing:setAlpha(0.2)
				f8_arg0.Backing:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Backing:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setRGB(0.13, 0.12, 0.12)
			f8_arg0.Backing:setAlpha(0.5)
			f8_local0(f8_arg0.Backing)
			local f8_local1 = function(f10_arg0)
				f8_arg0.Frame:beginAnimation(200)
				f8_arg0.Frame:setAlpha(0.6)
				f8_arg0.Frame:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Frame:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Frame:completeAnimation()
			f8_arg0.Frame:setAlpha(0.04)
			f8_local1(f8_arg0.Frame)
			local f8_local2 = function(f11_arg0)
				f8_arg0.Corner:beginAnimation(200)
				f8_arg0.Corner:setScale(0.98, 0.83)
				f8_arg0.Corner:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Corner:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Corner:completeAnimation()
			f8_arg0.Corner:setScale(1, 1)
			f8_local2(f8_arg0.Corner)
		end,
		LoseFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Backing:beginAnimation(200)
				f12_arg0.Backing:setRGB(0.13, 0.12, 0.12)
				f12_arg0.Backing:setAlpha(0.5)
				f12_arg0.Backing:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Backing:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f12_arg0.Backing:setAlpha(0.2)
			f12_local0(f12_arg0.Backing)
			local f12_local1 = function(f14_arg0)
				f12_arg0.Frame:beginAnimation(200)
				f12_arg0.Frame:setAlpha(0.04)
				f12_arg0.Frame:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Frame:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Frame:completeAnimation()
			f12_arg0.Frame:setAlpha(0.6)
			f12_local1(f12_arg0.Frame)
			local f12_local2 = function(f15_arg0)
				f12_arg0.Corner:beginAnimation(200)
				f12_arg0.Corner:setScale(1, 1)
				f12_arg0.Corner:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Corner:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Corner:completeAnimation()
			f12_arg0.Corner:setScale(0.98, 0.83)
			f12_local2(f12_arg0.Corner)
		end,
	},
	Disabled = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.actionText:completeAnimation()
			f16_arg0.actionText:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f16_arg0.clipFinished(f16_arg0.actionText)
		end,
	},
}
CoD.StartMenu_Options_ButtonOption.__onClose = function(f17_arg0)
	f17_arg0.Frame:close()
	f17_arg0.Corner:close()
	f17_arg0.actionText:close()
	f17_arg0.StartMenuframenoBG00:close()
end

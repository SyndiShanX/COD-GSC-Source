CoD.StartMenu_Options_PC_KeyBinderTooltip = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PC_KeyBinderTooltip.__defaultWidth = 300
CoD.StartMenu_Options_PC_KeyBinderTooltip.__defaultHeight = 150
CoD.StartMenu_Options_PC_KeyBinderTooltip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PC_KeyBinderTooltip)
	self.id = "StartMenu_Options_PC_KeyBinderTooltip"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fullBacking = LUI.UIImage.new(0, 0, 0, 300, 0, 0, 0, 150)
	fullBacking:setRGB(0, 0, 0)
	self:addElement(fullBacking)
	self.fullBacking = fullBacking
	local headerText = LUI.UIText.new(0, 0, 11, 300, 0, 0, 9, 47)
	headerText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	headerText:setTTF("dinnext_regular")
	headerText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	headerText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(headerText)
	self.headerText = headerText
	local descText = LUI.UIText.new(0, 0, 11, 300, 0, 0, 47, 77)
	descText:setRGB(0.78, 0.78, 0.78)
	descText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	descText:setTTF("dinnext_regular")
	descText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	descText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(descText)
	self.descText = descText
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not ShouldOpenGraphicsAndSoundOptions()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PC_KeyBinderTooltip.__resetProperties = function(f3_arg0)
	f3_arg0.descText:completeAnimation()
	f3_arg0.headerText:completeAnimation()
	f3_arg0.fullBacking:completeAnimation()
	f3_arg0.descText:setAlpha(1)
	f3_arg0.headerText:setAlpha(1)
	f3_arg0.fullBacking:setAlpha(1)
end
CoD.StartMenu_Options_PC_KeyBinderTooltip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.fullBacking:completeAnimation()
			f5_arg0.fullBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.fullBacking)
			f5_arg0.headerText:completeAnimation()
			f5_arg0.headerText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.headerText)
			f5_arg0.descText:completeAnimation()
			f5_arg0.descText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.descText)
		end,
	},
}

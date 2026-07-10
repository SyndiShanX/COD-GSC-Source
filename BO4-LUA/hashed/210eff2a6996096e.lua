require("x64:bdc4956715f81d7")
CoD.PC_PaintjobEditor_View = InheritFrom(LUI.UIElement)
CoD.PC_PaintjobEditor_View.__defaultWidth = 250
CoD.PC_PaintjobEditor_View.__defaultHeight = 45
CoD.PC_PaintjobEditor_View.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_PaintjobEditor_View)
	self.id = "PC_PaintjobEditor_View"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0.5)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.75)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local ViewName = LUI.UIText.new(0.5, 0.5, -71, 71, 0.5, 0.5, -7.5, 7.5)
	ViewName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ViewName:setTTF("ttmussels_demibold")
	ViewName:setLetterSpacing(6)
	ViewName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ViewName:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	ViewName:subscribeToGlobalModel(f1_arg1, "Customization", "view_string_ref", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ViewName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(ViewName)
	self.ViewName = ViewName
	local ChangeViewRight = CoD.CyclingList_Arrow.new(f1_arg0, f1_arg1, 1, 1, -45, 0, 0.5, 0.5, -22.5, 22.5)
	ChangeViewRight.Image:setRGB(1, 1, 1)
	ChangeViewRight:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ChangeViewRight, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.Paintshop_ChangeViewRightBumper(menu, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(ChangeViewRight)
	self.ChangeViewRight = ChangeViewRight
	local ChangeViewLeft = CoD.CyclingList_Arrow.new(f1_arg0, f1_arg1, 0, 0, 0, 45, 0.5, 0.5, -22.5, 22.5)
	ChangeViewLeft:setZRot(180)
	ChangeViewLeft.Image:setRGB(1, 1, 1)
	ChangeViewLeft:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ChangeViewLeft, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.CraftUtility.Paintshop_ChangeViewLeftBumper(menu, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(ChangeViewLeft)
	self.ChangeViewLeft = ChangeViewLeft
	ChangeViewRight.id = "ChangeViewRight"
	ChangeViewLeft.id = "ChangeViewLeft"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_PaintjobEditor_View.__onClose = function(f9_arg0)
	f9_arg0.ViewName:close()
	f9_arg0.ChangeViewRight:close()
	f9_arg0.ChangeViewLeft:close()
end

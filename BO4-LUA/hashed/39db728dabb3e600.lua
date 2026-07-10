require("x64:8fd69737f859814")
CoD.VHUD_Gunship = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_Gunship = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_Gunship", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_Gunship)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local vhudgunshipinternal = CoD.vhud_gunship_internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudgunshipinternal:linkToElementModel(self, nil, false, function(model)
		vhudgunshipinternal:setModel(model, f1_arg0)
	end)
	self:addElement(vhudgunshipinternal)
	self.vhudgunshipinternal = vhudgunshipinternal
	local f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.AspectRatioBorder = f1_local3
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.AspectRatioBorder2 = f1_local4
	self:mergeStateConditions({
		{
			stateName = "Splitscreen",
			condition = function(menu, element, event)
				return IsSplitscreenAndInGame(f1_arg0)
			end,
		},
	})
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	local f1_local5 = self
	f1_local5 = f1_local3
	if IsSplitscreenAndInGame(f1_arg0) then
		ShowWidget(f1_local5)
	end
	f1_local5 = f1_local4
	if IsSplitscreenAndInGame(f1_arg0) then
		ShowWidget(f1_local5)
	end
	return self
end
CoD.VHUD_Gunship.__resetProperties = function(f4_arg0)
	f4_arg0.AspectRatioBorder2:completeAnimation()
	f4_arg0.AspectRatioBorder:completeAnimation()
	f4_arg0.AspectRatioBorder2:setLeftRight(0.46, 0.98, 910, 1010)
	f4_arg0.AspectRatioBorder:setLeftRight(0.02, 0.54, -1010, -910)
end
CoD.VHUD_Gunship.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Splitscreen = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
			f6_arg0.AspectRatioBorder:completeAnimation()
			f6_arg0.AspectRatioBorder:setLeftRight(-0.98, -0.46, -1010, -910)
			f6_arg0.clipFinished(f6_arg0.AspectRatioBorder)
			f6_arg0.AspectRatioBorder2:completeAnimation()
			f6_arg0.AspectRatioBorder2:setLeftRight(1.47, 1.99, 910, 1010)
			f6_arg0.clipFinished(f6_arg0.AspectRatioBorder2)
		end,
	},
}
CoD.VHUD_Gunship.__onClose = function(f7_arg0)
	f7_arg0.vhudgunshipinternal:close()
	f7_arg0.AspectRatioBorder:close()
	f7_arg0.AspectRatioBorder2:close()
end

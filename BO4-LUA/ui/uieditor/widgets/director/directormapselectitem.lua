require("x64:88c6f65f2dd32da")
CoD.DirectorMapSelectItem = InheritFrom(LUI.UIElement)
CoD.DirectorMapSelectItem.__defaultWidth = 246
CoD.DirectorMapSelectItem.__defaultHeight = 104
CoD.DirectorMapSelectItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorMapSelectItem)
	self.id = "DirectorMapSelectItem"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.DirectorZMMapSelectItemOffline_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 246, 0, 0, 0, 104)
	Button.FeaturedTag:setText(LocalizeToUpperString(0x7E251454EDF7A26))
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	Button:linkToElementModel(self, "id", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Button.MapImage:setImage(RegisterImage(MapNameToMapImage(f3_local0)))
		end
	end)
	Button:linkToElementModel(self, "id", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Button.MapName:setText(MapNameToLocalizedMapName(f4_local0))
		end
	end)
	Button:linkToElementModel(self, "id", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Button.TeamName:setText(Engine[0xF9F1239CFD921FE](CoD.MapUtility.GetMapTeamNameFromMapID(f5_local0)))
		end
	end)
	self:addElement(Button)
	self.Button = Button
	Button.id = "Button"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorMapSelectItem.__resetProperties = function(f6_arg0)
	f6_arg0.Button:completeAnimation()
	f6_arg0.Button:setScale(1, 1)
end
CoD.DirectorMapSelectItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Button:completeAnimation()
			f8_arg0.Button:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.Button)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Button:beginAnimation(200)
				f9_arg0.Button:setScale(1.05, 1.05)
				f9_arg0.Button:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Button:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Button:completeAnimation()
			f9_arg0.Button:setScale(1, 1)
			f9_local0(f9_arg0.Button)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Button:beginAnimation(200)
				f11_arg0.Button:setScale(1, 1)
				f11_arg0.Button:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Button:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Button:completeAnimation()
			f11_arg0.Button:setScale(1.05, 1.05)
			f11_local0(f11_arg0.Button)
		end,
	},
}
CoD.DirectorMapSelectItem.__onClose = function(f13_arg0)
	f13_arg0.Button:close()
end

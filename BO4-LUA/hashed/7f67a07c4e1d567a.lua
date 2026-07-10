CoD.self_revive_visuals = InheritFrom(CoD.Menu)
LUI.createMenu.self_revive_visuals = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("self_revive_visuals", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.self_revive_visuals)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local self_revive_progress_bar_fill = LUI.UIImage.new(0.5, 0.5, -348, 348, 0.5, 0.5, 52.5, 86.5)
	self_revive_progress_bar_fill:setRGB(0.45, 1, 0)
	self_revive_progress_bar_fill:setImage(RegisterImage(0x72AF76649EA8E9B))
	self_revive_progress_bar_fill:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	self_revive_progress_bar_fill:setShaderVector(1, 0, 0, 0, 0)
	self_revive_progress_bar_fill:setShaderVector(2, 1, 0, 0, 0)
	self_revive_progress_bar_fill:setShaderVector(3, 0, 0, 0, 0)
	self_revive_progress_bar_fill:setShaderVector(4, 0, 0, 0, 0)
	self_revive_progress_bar_fill:linkToElementModel(self, "revive_progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			self_revive_progress_bar_fill:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(self_revive_progress_bar_fill)
	self.self_revive_progress_bar_fill = self_revive_progress_bar_fill
	local self_revive_progress_text = LUI.UIText.new(0.5, 0.5, -218.5, 218.5, 0.5, 0.5, 15.5, 52.5)
	self_revive_progress_text:setText(Engine[0xF9F1239CFD921FE](0x923A71AA4A500E1))
	self_revive_progress_text:setTTF("ttmussels_regular")
	self_revive_progress_text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self_revive_progress_text:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(self_revive_progress_text)
	self.self_revive_progress_text = self_revive_progress_text
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
				if not f3_local0 then
					f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
					if not f3_local0 then
						f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f4_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
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
CoD.self_revive_visuals.__resetProperties = function(f7_arg0)
	f7_arg0.self_revive_progress_text:completeAnimation()
	f7_arg0.self_revive_progress_bar_fill:completeAnimation()
	f7_arg0.self_revive_progress_text:setAlpha(1)
	f7_arg0.self_revive_progress_bar_fill:setAlpha(1)
end
CoD.self_revive_visuals.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.self_revive_progress_bar_fill:completeAnimation()
			f9_arg0.self_revive_progress_bar_fill:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.self_revive_progress_bar_fill)
			f9_arg0.self_revive_progress_text:completeAnimation()
			f9_arg0.self_revive_progress_text:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.self_revive_progress_text)
		end,
	},
}
CoD.self_revive_visuals.__onClose = function(f10_arg0)
	f10_arg0.self_revive_progress_bar_fill:close()
end

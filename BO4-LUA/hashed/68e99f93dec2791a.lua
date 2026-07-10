require("x64:94dab3a4d2d79b2")
CoD.PositionDraft_AutoDrafted = InheritFrom(LUI.UIElement)
CoD.PositionDraft_AutoDrafted.__defaultWidth = 270
CoD.PositionDraft_AutoDrafted.__defaultHeight = 26
CoD.PositionDraft_AutoDrafted.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_AutoDrafted)
	self.id = "PositionDraft_AutoDrafted"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AutoSelected = LUI.UIText.new(-0.02, 0.98, 5, 5, 0, 0, 2, 24)
	AutoSelected:setText(LocalizeToUpperString(LocalizeToUpperString(0xE19E40808DC7CF1)))
	AutoSelected:setTTF("ttmussels_demibold")
	AutoSelected:setLetterSpacing(3)
	AutoSelected:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AutoSelected:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	AutoSelected:setBackingType(1)
	AutoSelected:setBackingWidget(CoD.Corner9Slice, f1_arg0, f1_arg1)
	AutoSelected:setBackingAlpha(0.4)
	AutoSelected:setBackingXPadding(10)
	AutoSelected:setBackingYPadding(4)
	self:addElement(AutoSelected)
	self.AutoSelected = AutoSelected
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "PositionDraft.autoSelected", 0)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["PositionDraft.autoSelected"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "PositionDraft.autoSelected",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_AutoDrafted.__resetProperties = function(f4_arg0)
	f4_arg0.AutoSelected:completeAnimation()
	f4_arg0.AutoSelected:setAlpha(1)
end
CoD.PositionDraft_AutoDrafted.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.AutoSelected:completeAnimation()
			f5_arg0.AutoSelected:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.AutoSelected)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.AutoSelected:completeAnimation()
			f6_arg0.AutoSelected:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.AutoSelected)
		end,
	},
}

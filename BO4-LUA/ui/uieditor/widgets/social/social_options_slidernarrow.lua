require("x64:4ae13663d90032b")
require("x64:40364d3854ac209")
require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.Social_Options_SliderNarrow = InheritFrom(LUI.UIElement)
CoD.Social_Options_SliderNarrow.__defaultWidth = 530
CoD.Social_Options_SliderNarrow.__defaultHeight = 60
CoD.Social_Options_SliderNarrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_Options_SliderNarrow)
	self.id = "Social_Options_SliderNarrow"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LabelBacking = LUI.UIImage.new(0, 0, 0, 202, 0, 0, -1, 54)
	LabelBacking:setRGB(0.13, 0.12, 0.12)
	LabelBacking:setAlpha(0.5)
	self:addElement(LabelBacking)
	self.LabelBacking = LabelBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 202, 0, 0, 7, 51)
	Frame:setAlpha(0.01)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 0, 0, 202, 0, 0, 7, 51)
	Corner:setAlpha(0)
	self:addElement(Corner)
	self.Corner = Corner
	local SettingLabel = LUI.UIText.new(0, 0, 11.5, 193.5, 0, 0, 20.5, 39.5)
	SettingLabel:setRGB(0.78, 0.74, 0.67)
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SettingLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	SettingLabel:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SettingLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	local SettingsList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	SettingsList:mergeStateConditions({
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SettingsList:setLeftRight(0, 0, 202, 526)
	SettingsList:setTopBottom(0, 0, -1, 59)
	SettingsList:setWidgetType(CoD.StartMenu_Options_SettingSliderList)
	SettingsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SettingsList:linkToElementModel(self, "optionsDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SettingsList:setDataSource(f4_local0)
		end
	end)
	SettingsList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		ProcessListAction(self, element, f1_arg1, f1_arg0)
		return f5_local0
	end)
	self:addElement(SettingsList)
	self.SettingsList = SettingsList
	local Button = CoD.Social_Options_SliderNarrowButton.new(f1_arg0, f1_arg1, 0, 0, 208.5, 397.5, 0, 0, 7, 51)
	Button:setAlpha(0)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	self:mergeStateConditions({
		{
			stateName = "ButtonOnly",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "buttonOnly")
			end,
		},
	})
	self:linkToElementModel(self, "buttonOnly", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "buttonOnly",
		})
	end)
	SettingsList.id = "SettingsList"
	Button.id = "Button"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	f1_local7 = SettingsList
	if not IsPC() then
		CoD.GridAndListUtility.AddRightStickSingleItemControl(f1_arg0, f1_local7, f1_arg1)
	end
	return self
end
CoD.Social_Options_SliderNarrow.__resetProperties = function(f9_arg0)
	f9_arg0.SettingsList:completeAnimation()
	f9_arg0.Button:completeAnimation()
	f9_arg0.SettingsList:setAlpha(1)
	f9_arg0.Button:setAlpha(0)
end
CoD.Social_Options_SliderNarrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	ButtonOnly = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.SettingsList:completeAnimation()
			f11_arg0.SettingsList:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.SettingsList)
			f11_arg0.Button:completeAnimation()
			f11_arg0.Button:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Button)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.SettingsList:completeAnimation()
			f12_arg0.SettingsList:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SettingsList)
			f12_arg0.Button:completeAnimation()
			f12_arg0.Button:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Button)
		end,
	},
}
CoD.Social_Options_SliderNarrow.__onClose = function(f13_arg0)
	f13_arg0.Frame:close()
	f13_arg0.Corner:close()
	f13_arg0.SettingLabel:close()
	f13_arg0.SettingsList:close()
	f13_arg0.Button:close()
end

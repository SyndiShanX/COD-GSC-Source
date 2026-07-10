require("x64:a3d805c7a482528")
require("x64:dbc15352d51d8af")
CoD.PC_Korea_ContentDescriptors_Container = InheritFrom(LUI.UIElement)
CoD.PC_Korea_ContentDescriptors_Container.__defaultWidth = 189
CoD.PC_Korea_ContentDescriptors_Container.__defaultHeight = 336
CoD.PC_Korea_ContentDescriptors_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_ContentDescriptors_Container)
	self.id = "PC_Korea_ContentDescriptors_Container"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCKoreaContentDescriptorsIcons = CoD.PC_Korea_ContentDescriptors_Icons.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	PCKoreaContentDescriptorsIcons:setAlpha(0)
	self:addElement(PCKoreaContentDescriptorsIcons)
	self.PCKoreaContentDescriptorsIcons = PCKoreaContentDescriptorsIcons
	local PCKoreaMenus15ContentDescriptorsIcons = CoD.PC_Korea_Menus_15ContentDescriptors_Icons.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	PCKoreaMenus15ContentDescriptorsIcons:setAlpha(0)
	self:addElement(PCKoreaMenus15ContentDescriptorsIcons)
	self.PCKoreaMenus15ContentDescriptorsIcons = PCKoreaMenus15ContentDescriptorsIcons
	self:mergeStateConditions({
		{
			stateName = "Is15PlusFrontend",
			condition = function(menu, element, event)
				local f2_local0 = IsPC()
				if f2_local0 then
					f2_local0 = InFrontend()
					if f2_local0 then
						f2_local0 = CoD.PCKoreaUtility.IsInKorea()
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Is15Plus",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.IsInKorea()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_ContentDescriptors_Container.__resetProperties = function(f4_arg0)
	f4_arg0.PCKoreaMenus15ContentDescriptorsIcons:completeAnimation()
	f4_arg0.PCKoreaContentDescriptorsIcons:completeAnimation()
	f4_arg0.PCKoreaMenus15ContentDescriptorsIcons:setTopBottom(0, 1, 0, 0)
	f4_arg0.PCKoreaMenus15ContentDescriptorsIcons:setAlpha(0)
	f4_arg0.PCKoreaMenus15ContentDescriptorsIcons:setScale(1, 1)
	f4_arg0.PCKoreaContentDescriptorsIcons:setAlpha(0)
end
CoD.PC_Korea_ContentDescriptors_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Is15PlusFrontend = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.PCKoreaMenus15ContentDescriptorsIcons:completeAnimation()
			f6_arg0.PCKoreaMenus15ContentDescriptorsIcons:setTopBottom(0.63, 1.63, 1, 1)
			f6_arg0.PCKoreaMenus15ContentDescriptorsIcons:setAlpha(1)
			f6_arg0.PCKoreaMenus15ContentDescriptorsIcons:setScale(0.85, 0.85)
			f6_arg0.clipFinished(f6_arg0.PCKoreaMenus15ContentDescriptorsIcons)
		end,
	},
	Is15Plus = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.PCKoreaContentDescriptorsIcons:completeAnimation()
			f7_arg0.PCKoreaContentDescriptorsIcons:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PCKoreaContentDescriptorsIcons)
			f7_arg0.PCKoreaMenus15ContentDescriptorsIcons:completeAnimation()
			f7_arg0.PCKoreaMenus15ContentDescriptorsIcons:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PCKoreaMenus15ContentDescriptorsIcons)
		end,
	},
}
CoD.PC_Korea_ContentDescriptors_Container.__onClose = function(f8_arg0)
	f8_arg0.PCKoreaContentDescriptorsIcons:close()
	f8_arg0.PCKoreaMenus15ContentDescriptorsIcons:close()
end

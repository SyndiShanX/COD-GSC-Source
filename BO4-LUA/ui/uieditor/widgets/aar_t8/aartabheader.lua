CoD.AARTabHeader = InheritFrom(LUI.UIElement)
CoD.AARTabHeader.__defaultWidth = 500
CoD.AARTabHeader.__defaultHeight = 120
CoD.AARTabHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTabHeader)
	self.id = "AARTabHeader"
	self.soundSet = "none"
	local GametypeImage = LUI.UIImage.new(0, 0, 0, 113, 0, 0, 0, 113)
	GametypeImage:setAlpha(0.5)
	GametypeImage:linkToElementModel(self, "gametypeIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GametypeImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	local GametypeAndMap = LUI.UIText.new(0, 0, 113, 967, 0, 0, 0, 21)
	GametypeAndMap:setRGB(0.9, 0.89, 0.78)
	GametypeAndMap:setAlpha(0.2)
	GametypeAndMap:setTTF("dinnext_regular")
	GametypeAndMap:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GametypeAndMap:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	GametypeAndMap:linkToElementModel(self, "gametypeAndMap", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GametypeAndMap:setText(f3_local0)
		end
	end)
	self:addElement(GametypeAndMap)
	self.GametypeAndMap = GametypeAndMap
	local TabTitle = LUI.UIText.new(0, 0, 113, 968, 0, 0, 30, 105)
	TabTitle:setRGB(0.9, 0.89, 0.78)
	TabTitle:setAlpha(0.3)
	TabTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/victory"))
	TabTitle:setTTF("ttmussels_demibold")
	TabTitle:setLetterSpacing(10)
	TabTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TabTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TabTitle)
	self.TabTitle = TabTitle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTabHeader.__onClose = function(f4_arg0)
	f4_arg0.GametypeImage:close()
	f4_arg0.GametypeAndMap:close()
end

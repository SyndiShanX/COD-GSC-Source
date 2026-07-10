require("x64:a5aca312227765b")
require("x64:70f9f39fc048c29")
CoD.FallMeter_PlayerInfo = InheritFrom(LUI.UIElement)
CoD.FallMeter_PlayerInfo.__defaultWidth = 38
CoD.FallMeter_PlayerInfo.__defaultHeight = 8
CoD.FallMeter_PlayerInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FallMeter_PlayerInfo)
	self.id = "FallMeter_PlayerInfo"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local PositionLine = LUI.UIImage.new(0, 1, 0, 0, -0.03, 1.03, 0, 0)
	self:addElement(PositionLine)
	self.PositionLine = PositionLine
	local PositionLineTextureOverlay = LUI.UIImage.new(0.5, 0.5, -20.5, 20.5, 0.5, 0.5, -16, 16)
	PositionLineTextureOverlay:setImage(RegisterImage(@"uie_ui_hud_wz_indicatorbar"))
	self:addElement(PositionLineTextureOverlay)
	self.PositionLineTextureOverlay = PositionLineTextureOverlay
	local PositionLineGlow = LUI.UIImage.new(0.5, 0.5, -20.5, 20.5, 0.5, 0.5, -10, 10)
	PositionLineGlow:setImage(RegisterImage(@"uie_ui_hud_wz_indicatorbar"))
	PositionLineGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PositionLineGlow)
	self.PositionLineGlow = PositionLineGlow
	local Bloom = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -10, 10)
	Bloom:setAlpha(0.5)
	Bloom:setImage(RegisterImage(@"uie_ui_menu_cac_preview_class_highlight_glow"))
	Bloom:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bloom)
	self.Bloom = Bloom
	local PositionDot = LUI.UIImage.new(1.08, 1.08, 0, 2, 0.5, 0.5, -1, 1)
	PositionDot:setRGB(0, 0, 0)
	self:addElement(PositionDot)
	self.PositionDot = PositionDot
	local AscentArrow = CoD.FallMeter_Arrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 0, 0, -21, -5)
	AscentArrow:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan(f1_arg1, "HUDItems", "fallVelocity", -5)
			end,
		},
	})
	local DescentArrow2 = AscentArrow
	local DescentArrow1 = AscentArrow.subscribeToModel
	local DescentArrow3 = DataSources.HUDItems.getModel(f1_arg1)
	DescentArrow1(DescentArrow2, DescentArrow3.fallVelocity, function(f3_arg0)
		f1_arg0:updateElementState(AscentArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "fallVelocity",
		})
	end, false)
	AscentArrow:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	AscentArrow:setZRot(180)
	self:addElement(AscentArrow)
	self.AscentArrow = AscentArrow
	DescentArrow1 = CoD.FallMeter_Arrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 1, 1, 5, 21)
	DescentArrow1:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "fallVelocity", 5)
			end,
		},
	})
	DescentArrow3 = DescentArrow1
	DescentArrow2 = DescentArrow1.subscribeToModel
	local Speed = DataSources.HUDItems.getModel(f1_arg1)
	DescentArrow2(DescentArrow3, Speed.fallVelocity, function(f5_arg0)
		f1_arg0:updateElementState(DescentArrow1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "fallVelocity",
		})
	end, false)
	DescentArrow1:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(DescentArrow1)
	self.DescentArrow1 = DescentArrow1
	DescentArrow2 = CoD.FallMeter_Arrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 1, 1, 21, 37)
	DescentArrow2:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "fallVelocity", 75)
			end,
		},
	})
	Speed = DescentArrow2
	DescentArrow3 = DescentArrow2.subscribeToModel
	local ArrowFrameL = DataSources.HUDItems.getModel(f1_arg1)
	DescentArrow3(Speed, ArrowFrameL.fallVelocity, function(f7_arg0)
		f1_arg0:updateElementState(DescentArrow2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "fallVelocity",
		})
	end, false)
	DescentArrow2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(DescentArrow2)
	self.DescentArrow2 = DescentArrow2
	DescentArrow3 = CoD.FallMeter_Arrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -16, 16, 1, 1, 37, 53)
	DescentArrow3:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "fallVelocity", 110)
			end,
		},
	})
	ArrowFrameL = DescentArrow3
	Speed = DescentArrow3.subscribeToModel
	local ArrowL = DataSources.HUDItems.getModel(f1_arg1)
	Speed(ArrowFrameL, ArrowL.fallVelocity, function(f9_arg0)
		f1_arg0:updateElementState(DescentArrow3, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "fallVelocity",
		})
	end, false)
	DescentArrow3:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(DescentArrow3)
	self.DescentArrow3 = DescentArrow3
	Speed = CoD.FallMeter_Speed.new(f1_arg0, f1_arg1, 0, 0, -85, -15, 0.5, 0.5, -19, 21)
	self:addElement(Speed)
	self.Speed = Speed
	ArrowFrameL = LUI.UIImage.new(0, 0, -19.5, -4.5, 0, 0, -3.5, 11.5)
	ArrowFrameL:setRGB(0, 0, 0)
	ArrowFrameL:setZRot(-45)
	ArrowFrameL:setImage(RegisterImage(@"hash_662E760CB652A6EE"))
	self:addElement(ArrowFrameL)
	self.ArrowFrameL = ArrowFrameL
	ArrowL = LUI.UIImage.new(0, 0, -15, -10, 0.5, 0.5, -5.5, 5.5)
	ArrowL:setRGB(0, 0, 0)
	ArrowL:setScale(1.4, 1.4)
	ArrowL:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	self:addElement(ArrowL)
	self.ArrowL = ArrowL
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FallMeter_PlayerInfo.__onClose = function(f10_arg0)
	f10_arg0.AscentArrow:close()
	f10_arg0.DescentArrow1:close()
	f10_arg0.DescentArrow2:close()
	f10_arg0.DescentArrow3:close()
	f10_arg0.Speed:close()
end

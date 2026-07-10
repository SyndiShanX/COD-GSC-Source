CoD.CodCasterMap = InheritFrom(LUI.UIElement)
CoD.CodCasterMap.__defaultWidth = 1920
CoD.CodCasterMap.__defaultHeight = 1080
CoD.CodCasterMap.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterMap)
	self.id = "CodCasterMap"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local minimapMap = LUI.UIImage.new(-0.17, 1.17, 328, -328, 0, 1, -7, 7)
	minimapMap:setAlpha(0.21)
	minimapMap:setupCompassMap(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(minimapMap)
	self.minimapMap = minimapMap
	local minimapOverlay = LUI.UIImage.new(-0.17, 1.17, 328, -328, 0, 1, -7, 7)
	minimapOverlay:setAlpha(0.19)
	minimapOverlay:setupCompassOverlay(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(minimapOverlay)
	self.minimapOverlay = minimapOverlay
	local minimapItems = LUI.UIImage.new(-0.17, 1.17, 328, -328, 0, 1, -7, 7)
	minimapItems:setAlpha(0.2)
	minimapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_full"])
	self:addElement(minimapItems)
	self.minimapItems = minimapItems
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "CodCaster.showFullScreenMap")
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["CodCaster.showFullScreenMap"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "CodCaster.showFullScreenMap",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterMap.__resetProperties = function(f4_arg0)
	f4_arg0.minimapOverlay:completeAnimation()
	f4_arg0.minimapItems:completeAnimation()
	f4_arg0.minimapMap:completeAnimation()
	f4_arg0.minimapOverlay:setAlpha(0.19)
	f4_arg0.minimapItems:setAlpha(0.2)
	f4_arg0.minimapMap:setAlpha(0.21)
end
CoD.CodCasterMap.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.minimapMap:completeAnimation()
			f5_arg0.minimapMap:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.minimapMap)
			f5_arg0.minimapOverlay:completeAnimation()
			f5_arg0.minimapOverlay:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.minimapOverlay)
			f5_arg0.minimapItems:completeAnimation()
			f5_arg0.minimapItems:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.minimapItems)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.minimapMap:completeAnimation()
			f6_arg0.minimapMap:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.minimapMap)
			f6_arg0.minimapOverlay:completeAnimation()
			f6_arg0.minimapOverlay:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.minimapOverlay)
			f6_arg0.minimapItems:completeAnimation()
			f6_arg0.minimapItems:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.minimapItems)
		end,
	},
}

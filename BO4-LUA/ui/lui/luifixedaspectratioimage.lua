LUI.UIFixedAspectRatioImage = InheritFrom(LUI.UIElement)
LUI.UIFixedAspectRatioImage.Dimensions = LuaEnum.createEnum("STRETCH_H_FROM_LEFT", "STRETCH_H_FROM_CENTER", "STRETCH_H_FROM_RIGHT", "STRETCH_V_FROM_TOP", "STRETCH_V_FROM_MIDDLE", "STRETCH_V_FROM_BOTTOM", "FIT_INSIDE")
LUI.UIFixedAspectRatioImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	local self = LUI.UIElement.new(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	self:setClass(LUI.UIFixedAspectRatioImage)
	self.imageElement = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(self.imageElement)
	self.__dimension = LUI.UIFixedAspectRatioImage.Dimensions.Center
	return self
end
LUI.UIFixedAspectRatioImage.updateImageDimensions = function(f2_arg0)
	local f2_local0, f2_local1 = nil
	if f2_arg0._autoSize then
		if not f2_arg0._autoSize.lp then
			local f2_local2 = f2_arg0._autoSize
			local f2_local3 = f2_arg0._autoSize
			local f2_local4 = f2_arg0._autoSize
			local f2_local5 = f2_arg0._autoSize
			f2_local2.lp, f2_local3.rp, f2_local4.lpx, f2_local5.rpx = f2_arg0:getLocalLeftRight()
			f2_local2 = f2_arg0._autoSize
			f2_local3 = f2_arg0._autoSize
			f2_local4 = f2_arg0._autoSize
			f2_local5 = f2_arg0._autoSize
			f2_local2.tp, f2_local3.bp, f2_local4.tpx, f2_local5.bpx = f2_arg0:getLocalTopBottom()
		end
		f2_local0 = f2_arg0._autoSize.rpx - f2_arg0._autoSize.lpx
		f2_local1 = f2_arg0._autoSize.bpx - f2_arg0._autoSize.tpx
	else
		f2_local0, f2_local1 = f2_arg0:getLocalSize()
	end
	local f2_local2, f2_local3 = f2_arg0.imageElement:getImageDimensions()
	if f2_local2 == 0 or f2_local3 == 0 then
		return
	end
	local f2_local4 = f2_local2 * f2_local1 / f2_local3
	local f2_local5 = f2_local3 * f2_local0 / f2_local2
	if f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_H_FROM_LEFT then
		f2_arg0.imageElement:setLeftRight(0, 0, 0, f2_local4)
		f2_arg0.imageElement:setTopBottom(0, 1, 0, 0)
	elseif f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_H_FROM_RIGHT then
		f2_arg0.imageElement:setLeftRight(1, 1, -f2_local4, 0)
		f2_arg0.imageElement:setTopBottom(0, 1, 0, 0)
	elseif f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_V_FROM_TOP then
		f2_arg0.imageElement:setLeftRight(0, 1, 0, 0)
		f2_arg0.imageElement:setTopBottom(0, 0, 0, f2_local5)
	elseif f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_V_FROM_MIDDLE then
		f2_arg0.imageElement:setLeftRight(0, 1, 0, 0)
		f2_arg0.imageElement:setTopBottom(0.5, 0.5, -f2_local5 / 2, f2_local5 / 2)
	elseif f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_V_FROM_BOTTOM then
		f2_arg0.imageElement:setLeftRight(0, 1, 0, 0)
		f2_arg0.imageElement:setTopBottom(1, 1, -f2_local5, 0)
	elseif f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.FIT_INSIDE then
		if f2_local3 > 0 and f2_local1 > 0 then
			local f2_local6 = f2_local2 / f2_local3
			local f2_local7 = f2_local0 / f2_local1
			if f2_local6 < f2_local7 then
				local f2_local8 = f2_local2 * f2_local1 / f2_local3
				f2_arg0.imageElement:setLeftRight(0.5, 0.5, -f2_local8 / 2, f2_local8 / 2)
				f2_arg0.imageElement:setTopBottom(0, 1, 0, 0)
			elseif f2_local7 < f2_local6 then
				local f2_local8 = f2_local3 * f2_local0 / f2_local2
				f2_arg0.imageElement:setLeftRight(0, 1, 0, 0)
				f2_arg0.imageElement:setTopBottom(0.5, 0.5, -f2_local8 / 2, f2_local8 / 2)
			elseif f2_local2 % f2_local0 == 0 and f2_local3 % f2_local1 == 0 then
				f2_arg0.imageElement:setLeftRight(0, 1, 0, 0)
				f2_arg0.imageElement:setTopBottom(0, 1, 0, 0)
			elseif f2_local1 < f2_local0 then
				f2_arg0.imageElement:setLeftRight(0.5, 0.5, -f2_local1 / 2, f2_local1 / 2)
				f2_arg0.imageElement:setTopBottom(0, 1, 0, 0)
			else
				f2_arg0.imageElement:setLeftRight(0, 1, 0, 0)
				f2_arg0.imageElement:setTopBottom(0.5, 0.5, -f2_local0 / 2, f2_local0 / 2)
			end
		end
	else
		f2_arg0.imageElement:setLeftRight(0.5, 0.5, -f2_local4 / 2, f2_local4 / 2)
		f2_arg0.imageElement:setTopBottom(0, 1, 0, 0)
	end
	if f2_arg0._autoSize then
		if f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_H_FROM_LEFT or f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_H_FROM_CENTER or f2_arg0.__dimension == LUI.UIFixedAspectRatioImage.Dimensions.STRETCH_H_FROM_RIGHT then
			f2_arg0:setLeftRight(f2_arg0._autoSize.lp, f2_arg0._autoSize.rp, f2_arg0._autoSize.lpx, f2_arg0._autoSize.lpx + f2_local4)
		else
			f2_arg0:setTopBottom(f2_arg0._autoSize.tp, f2_arg0._autoSize.bp, f2_arg0._autoSize.tpx, f2_arg0._autoSize.bpx + f2_local5)
		end
	end
end
LUI.UIFixedAspectRatioImage.setImage = function(f3_arg0, f3_arg1)
	f3_arg0.imageElement:setImage(f3_arg1)
	f3_arg0:updateImageDimensions()
end
LUI.UIFixedAspectRatioImage.setAutoSizeProperty = function(f4_arg0, f4_arg1)
	local f4_local0
	if f4_arg1 then
		f4_local0 = {}
		if not f4_local0 then
		else
			f4_arg0._autoSize = f4_local0
		end
	end
	f4_local0 = nil
end
LUI.UIFixedAspectRatioImage.setMaterial = function(f5_arg0, f5_arg1)
	f5_arg0.imageElement:setMaterial(f5_arg1)
end
LUI.UIFixedAspectRatioImage.setRTTMaterial = function(f6_arg0, f6_arg1)
	f6_arg0.imageElement:setRTTMaterial(f6_arg1)
end
LUI.UIFixedAspectRatioImage.setStretchedDimension = function(f7_arg0, f7_arg1)
	f7_arg0.__dimension = f7_arg1
	f7_arg0:updateImageDimensions()
end
LUI.UIFixedAspectRatioImage.id = "LUIFixedAspectRatioImage"

/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_growhouse\mp_growhouse\.csc.gsc
*************************************************************/

main() {
  scripts\mp\lighting::init();
  scripts\common\trigger::_id_80A3();
  thread scripts\common\fx_zones::fx_zone_watcher("interior", "msg_fx_zone_interior");

  if(_func_009F() || _func_009C()) {
    _func_00DF("sm_spotshadowquality", 0);
    _func_00DF("r_shadowtileresolution", 2);
    _func_00DF("r_screenspaceshadowsspotsceneenabled", 0);
    _func_00DF("r_screenspaceshadowssunsceneenabled", 0);
    _func_00DF("r_mbvelocityscale", 1);
    _func_00DF("r_screenspaceshadowsspotscenesamples", 8);
    _func_00DF("r_screenSpaceShadowsSpotSceneTraceAuto", 1);
    _func_00DF("r_screenSpaceShadowsSpotSceneTraceDistance", 8);
    _func_00DF("sm_spotUpdateLimit", 6);
    _func_00DF("sm_spotUpdateLimitDynLight", 2);
    _func_00DF("r_volumetricDepth", "128 384 640 1024");
    _func_00DF("sm_sunsamplesizenear", 0.35);
    _func_00DF("sm_sunCascadeSizeMultiplier1", 2);
    _func_00DF("sm_sunCascadeSizeMultiplier2", 3);
    _func_00DF("sm_sundistantshadows", 0);
    _func_00DF("sm_spotDistCull", 700);
    _func_00DF("r_spotLightEntityShadows", 0);
    _func_00DF("sm_roundRobinPrioritySpotShadows", 8);
    _func_00DF("r_usePrebuiltSunShadow", 1);
    _func_00DF("sm_spotDeferred", 1);
    _func_00DF("r_compressedSunShadowClipPlanes", 1);
    _func_00DF("r_compressedSunShadowFiltering", 0);
    _func_00DF("sm_spotShadowScoreSystem", 1);
    _func_00DF("sm_spotUpdateMoreDynEnt", 0);
    _func_00DF("sm_spotUpdateMoreDynObj", 0);
    _func_00DF("r_dynLight_cullDist", 999999);
    _func_00DF("r_sunIntensityHeatOverride", 0);
    _func_00DF("r_useShadowGeomOpt", 1);
    _func_00DF("r_shaderLodSecondarySpecularHQ", 2);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("r_screenspaceshadowsspotsceneenabled", 1);
    _func_00DF("r_screenspaceshadowssunsceneenabled", 1);
    _func_00DF("r_mbvelocityscale", 1);
    _func_00DF("r_screenspaceshadowsspotscenesamples", 8);
    _func_00DF("r_screenSpaceShadowsSpotSceneTraceAuto", 1);
    _func_00DF("r_screenSpaceShadowsSpotSceneTraceDistance", 8);
    _func_00DF("sm_spotUpdateLimit", 6);
    _func_00DF("sm_spotUpdateLimitDynLight", 2);
    _func_00DF("r_volumetricDepth", "128 384 640 1024");
    _func_00DF("sm_sunsamplesizenear", 0.35);
    _func_00DF("sm_sunCascadeSizeMultiplier1", 2);
    _func_00DF("sm_sunCascadeSizeMultiplier2", 3);
    _func_00DF("sm_sundistantshadows", 0);
    _func_00DF("sm_spotDistCull", 700);
    _func_00DF("r_spotLightEntityShadows", 0);
    _func_00DF("sm_roundRobinPrioritySpotShadows", 8);
    _func_00DF("r_usePrebuiltSunShadow", 1);
    _func_00DF("sm_spotDeferred", 1);
    _func_00DF("r_compressedSunShadowClipPlanes", 1);
    _func_00DF("r_compressedSunShadowFiltering", 0);
    _func_00DF("sm_spotShadowScoreSystem", 1);
    _func_00DF("sm_spotUpdateMoreDynEnt", 0);
    _func_00DF("sm_spotUpdateMoreDynObj", 0);
    _func_00DF("r_dynLight_cullDist", 999999);
    _func_00DF("r_sunIntensityHeatOverride", 0);
    _func_00DF("r_useShadowGeomOpt", 1);
    _func_00DF("r_shaderLodSecondarySpecularHQ", 2);
  }

  if(_func_00A0() || _func_009D()) {
    _func_00DF("sm_spotshadowquality", 1);
    _func_00DF("r_shadowtileresolution", 2);
  }
}
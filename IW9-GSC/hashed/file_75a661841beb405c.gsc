/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_75a661841beb405c.gsc
***********************************************/

main() {
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 1);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotUpdateMoreDynObj", 0);
  setDvar("sm_sunSampleSizeNear", 0.35);
  setDvar("sm_sunCascadeSizeMultiplier1", 3);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("r_screenspaceshadowsspotsceneenabled", 0);
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_spotUpdateLimit", 6);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotShadowScoreSystem", 0);
  setDvar("sm_spotUpdateMoreDynEnt", 1);
  setDvar("sm_spotUpdateMoreDynObj", 1);
  setDvar("r_umbraShadowCasters", 1);
  setDvar("sm_sunSampleSizeNear", 0.35);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 2);
  setDvar("sm_sunDistantShadows", 1);
  setDvar("r_screenspaceshadowssunsceneenabled", 1);
  setDvar("r_usePrebuiltSunShadow", 1);
  setDvar("r_useShadowGeomOpt", 0);
  _id_3DBF5D2BCCCA4809();
}

_id_3DBF5D2BCCCA4809() {
  if(getdvarint("r_reflectionprobegenerate", 0) == 0) {
    _id_0152974660457623 = getEnt("c130_capture_model", "targetname");

    if(isDefined(_id_0152974660457623))
      _id_0152974660457623 hide();
  }

  level._id_9CD5F8A263931890 = spawnStruct();
  level._id_9CD5F8A263931890.lights = getEntArray("c130_script_light", "targetname");
  level._id_9CD5F8A263931890.probe = getEnt("c130_reflection_probe", "targetname");

  foreach(light in level._id_9CD5F8A263931890.lights) {
    light.og_intensity = light getlightintensity();
    light setlightintensity(0.0);
  }

  if(isDefined(level._id_9CD5F8A263931890.probe))
    level._id_9CD5F8A263931890.probe hide();
}

_id_EAA62570A3C904BE() {
  if(!_id_3E9EFF2FDE7A967E(level._id_9CD5F8A263931890)) {
    return;
  }
  level._id_9CD5F8A263931890.probe linkTo(self);
  level._id_9CD5F8A263931890.probe show();

  foreach(light in level._id_9CD5F8A263931890.lights) {
    light setlightintensity(light.og_intensity);
    light linkTo(self);
  }
}

_id_358012DE52787F8F() {
  if(!_id_3E9EFF2FDE7A967E(level._id_9CD5F8A263931890)) {
    return;
  }
  level._id_9CD5F8A263931890.probe unlink();
  level._id_9CD5F8A263931890.probe hide();

  foreach(light in level._id_9CD5F8A263931890.lights) {
    light setlightintensity(0.0);
    light unlink();
  }
}

_id_3E9EFF2FDE7A967E(_id_23260208B218780E) {
  if(!isDefined(_id_23260208B218780E))
    return 0;

  if(!isDefined(_id_23260208B218780E.lights) || !isDefined(level._id_9CD5F8A263931890.probe))
    return 0;

  return 1;
}
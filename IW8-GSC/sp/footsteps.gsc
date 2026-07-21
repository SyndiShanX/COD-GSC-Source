/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\footsteps.gsc
***********************************************/

default_footsteps() {
  var_0 = "soldier";
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "default", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "asphalt_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "brick", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "carpet", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "cloth", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "concrete_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "cushion", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "dirt", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "foliage", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "grass", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "gravel", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "mud", loadfx("vfx/core/impacts/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "rock", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "sand", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "wood", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "water", loadfx("vfx/core/impacts/footstep_water.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "snow", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "ice", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "default", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "asphalt_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "brick", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "carpet", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "cloth", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "concrete_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "cushion", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "dirt", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "foliage", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "grass", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "gravel", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "mud", loadfx("vfx/core/impacts/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "rock", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "sand", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "wood", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "water", loadfx("vfx/core/impacts/footstep_water.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "snow", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "ice", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  var_1 = "bodyfall small";
  var_2 = "J_SpineLower";
  var_3 = "bodyfall_";
  var_4 = "_small";
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "dirt", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "concrete_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "asphalt_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "rock", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);
  var_5 = ["brick", "carpet", "foliage", "grass", "gravel", "ice", "metal", "painted metal", "mud", "plaster", "sand", "snow", "slush", "water", "wood", "ceramic"];

  foreach(var_7 in var_5)
  scripts\anim\utility.gsc::setnotetracksound(var_1, var_7, var_3, var_4);

  var_1 = "bodyfall small";
  var_2 = "J_SpineLower";
  var_3 = "bodyfall_";
  var_4 = "_large";
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "dirt", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "concrete_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "asphalt_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);
  scripts\anim\utility.gsc::setnotetrackeffect(var_1, var_2, "rock", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var_3, var_4);

  foreach(var_7 in var_5)
  scripts\anim\utility.gsc::setnotetracksound(var_1, var_7, var_3, var_4);

  if(!isDefined(level.planet)) {
    return;
  }
  switch (level.planet) {
    case "titan":
      titan();
      break;
    case "mars":
      mars();
      break;
  }
}

titan() {
  var_0 = "soldier";
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  var_0 = "c6i";
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  var_0 = "c12";
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_wet_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_wet_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "brick", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "foliage", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "grass", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "gravel", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
}

mars() {
  var_0 = "soldier";
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "dirt", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility.gsc::setfootstepeffect(var_0, "sand", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "dirt", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility.gsc::setfootstepeffectsmall(var_0, "sand", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\footsteps.gsc
***********************************************/

function default_footsteps() {
  var0 = "soldier";
  scripts\anim\utility::setfootstepeffect(var0, "default", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "asphalt_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "brick", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "carpet", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "cloth", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "concrete_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "cushion", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "dirt", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "foliage", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "grass", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "gravel", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "mud", loadfx("vfx/core/impacts/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "rock", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "sand", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "wood", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "water", loadfx("vfx/core/impacts/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "snow", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "ice", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "default", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "asphalt_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "brick", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "carpet", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "cloth", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "concrete_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "cushion", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "dirt", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "foliage", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "grass", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "gravel", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "mud", loadfx("vfx/core/impacts/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "rock", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "sand", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "wood", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "water", loadfx("vfx/core/impacts/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "snow", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "ice", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  var1 = "bodyfall small";
  var2 = "J_SpineLower";
  var3 = "bodyfall_";
  var4 = "_small";
  scripts\anim\utility::setnotetrackeffect(var1, var2, "dirt", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);
  scripts\anim\utility::setnotetrackeffect(var1, var2, "concrete_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);
  scripts\anim\utility::setnotetrackeffect(var1, var2, "asphalt_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);
  scripts\anim\utility::setnotetrackeffect(var1, var2, "rock", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);
  var5 = ["brick", "carpet", "foliage", "grass", "gravel", "ice", "metal", "painted metal", "mud", "plaster", "sand", "snow", "slush", "water", "wood", "ceramic"];

  foreach(var7 in var5) {
    scripts\anim\utility::setnotetracksound(var1, var7, var3, var4);
  }

  var1 = "bodyfall small";
  var2 = "J_SpineLower";
  var3 = "bodyfall_";
  var4 = "_large";
  scripts\anim\utility::setnotetrackeffect(var1, var2, "dirt", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);
  scripts\anim\utility::setnotetrackeffect(var1, var2, "concrete_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);
  scripts\anim\utility::setnotetrackeffect(var1, var2, "asphalt_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);
  scripts\anim\utility::setnotetrackeffect(var1, var2, "rock", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), var3, var4);

  foreach(var7 in var5) {
    scripts\anim\utility::setnotetracksound(var1, var7, var3, var4);
  }

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

function titan() {
  var0 = "soldier";
  scripts\anim\utility::setfootstepeffect(var0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  var0 = "c6i";
  scripts\anim\utility::setfootstepeffect(var0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  var0 = "c12";
  scripts\anim\utility::setfootstepeffect(var0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_wet_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_wet_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "brick", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "foliage", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "grass", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "gravel", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
}

function mars() {
  var0 = "soldier";
  scripts\anim\utility::setfootstepeffect(var0, "dirt", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility::setfootstepeffect(var0, "sand", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "dirt", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(var0, "sand", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
}
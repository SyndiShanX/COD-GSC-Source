/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\footsteps.gsc
***********************************************/

#using scripts\anim\utility;
#namespace footsteps;

function default_footsteps() {
  type = "soldier";
  scripts\anim\utility::setfootstepeffect(type, "default", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "asphalt_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "brick", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "carpet", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "cloth", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "concrete_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "cushion", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "dirt", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "foliage", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "grass", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "gravel", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "mud", loadfx("vfx/core/impacts/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "rock", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "sand", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "wood", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "water", loadfx("vfx/core/impacts/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "snow", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "ice", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "default", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "asphalt_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "brick", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "carpet", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "cloth", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "concrete_dry", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "cushion", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "dirt", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "foliage", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "grass", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "gravel", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "mud", loadfx("vfx/core/impacts/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "rock", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "sand", loadfx("vfx/core/impacts/footstep_dust.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "wood", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "water", loadfx("vfx/core/impacts/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "snow", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "ice", loadfx("vfx/iw8/char/footsteps/vfx_footstep_default.vfx"));
  note = "bodyfall small";
  tag = "J_SpineLower";
  prefix = "bodyfall_";
  suffix = "_small";
  scripts\anim\utility::setnotetrackeffect(note, tag, "dirt", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);
  scripts\anim\utility::setnotetrackeffect(note, tag, "concrete_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);
  scripts\anim\utility::setnotetrackeffect(note, tag, "asphalt_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);
  scripts\anim\utility::setnotetrackeffect(note, tag, "rock", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);
  var_fcca120079df27d0 = ["brick", "carpet", "foliage", "grass", "gravel", "ice", "metal", "painted metal", "mud", "plaster", "sand", "snow", "slush", "water", "wood", "ceramic"];

  foreach(surface in var_fcca120079df27d0) {
    scripts\anim\utility::setnotetracksound(note, surface, prefix, suffix);
  }

  note = "bodyfall small";
  tag = "J_SpineLower";
  prefix = "bodyfall_";
  suffix = "_large";
  scripts\anim\utility::setnotetrackeffect(note, tag, "dirt", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);
  scripts\anim\utility::setnotetrackeffect(note, tag, "concrete_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);
  scripts\anim\utility::setnotetrackeffect(note, tag, "asphalt_dry", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);
  scripts\anim\utility::setnotetrackeffect(note, tag, "rock", loadfx("vfx/core/impacts/bodyfall_default_large_runner.vfx"), prefix, suffix);

  foreach(surface in var_fcca120079df27d0) {
    scripts\anim\utility::setnotetracksound(note, surface, prefix, suffix);
  }

  if(!isDefined(level.planet)) {
    return;
  }

  switch (level.planet) {
    case #"hash_3c3b207c2c840d39":
      titan();
      break;
    case #"hash_faccfa34e48588c8":
      mars();
      break;
  }
}

function titan() {
  type = "soldier";
  scripts\anim\utility::setfootstepeffect(type, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  type = "c6i";
  scripts\anim\utility::setfootstepeffect(type, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud.vfx"));
  type = "c12";
  scripts\anim\utility::setfootstepeffect(type, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "asphalt_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "concrete_dry", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "asphalt_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_wet_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "concrete_wet", loadfx("vfx/iw7/levels/titan/footsteps/footstep_concrete_wet_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "brick", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "foliage", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "grass", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "gravel", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "mud", loadfx("vfx/iw7/levels/titan/footsteps/footstep_water_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "rock", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "sand", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "water", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "default", loadfx("vfx/iw7/levels/titan/footsteps/footstep_blank.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "dirt", loadfx("vfx/iw7/levels/titan/footsteps/footstep_mud_c12_titan.vfx"));
}

function mars() {
  type = "soldier";
  scripts\anim\utility::setfootstepeffect(type, "dirt", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility::setfootstepeffect(type, "sand", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "dirt", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
  scripts\anim\utility::setfootstepeffectsmall(type, "sand", loadfx("vfx/core/impacts/footstep_dust_mars.vfx"));
}
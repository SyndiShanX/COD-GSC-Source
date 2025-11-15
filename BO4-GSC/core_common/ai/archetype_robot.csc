/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_robot.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace archetype_robot;

autoexec __init__system__() {
  system::register(#"robot", &__init__, undefined, undefined);
}

autoexec precache() {
  level._effect[#"fx_ability_elec_surge_short_robot"] = "electric/fx8_surge_short_robot";
  level._effect[#"fx_exp_robot_stage3_evb"] = "explosions/fx_exp_robot_stage3_evb";
}

__init__() {
  if(ai::shouldregisterclientfieldforarchetype(#"robot")) {
    clientfield::register("actor", "robot_mind_control", 1, 2, "int", &robotclientutils::robotmindcontrolhandler, 0, 1);
    clientfield::register("actor", "robot_mind_control_explosion", 1, 1, "int", &robotclientutils::robotmindcontrolexplosionhandler, 0, 0);
    clientfield::register("actor", "robot_lights", 1, 3, "int", &robotclientutils::robotlightshandler, 0, 0);
    clientfield::register("actor", "robot_EMP", 1, 1, "int", &robotclientutils::robotemphandler, 0, 0);
  }

  ai::add_archetype_spawn_function(#"robot", &robotclientutils::robotsoldierspawnsetup);
}

#namespace robotclientutils;

private robotsoldierspawnsetup(localclientnum) {
  entity = self;
}

private robotlighting(localclientnum, entity, flicker, mindcontrolstate) {
  switch (mindcontrolstate) {
    case 0:
      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef3);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.fxdef);
      }

      break;
    case 1:
      fxclientutils::stopallfxbundles(localclientnum, entity);

      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef4);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef1);
      }

      if(!gibclientutils::isgibbed(localclientnum, entity, 8)) {
        entity playSound(localclientnum, #"fly_bot_ctrl_lvl_01_start", entity.origin);
      }

      break;
    case 2:
      fxclientutils::stopallfxbundles(localclientnum, entity);

      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef4);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef1);
      }

      if(!gibclientutils::isgibbed(localclientnum, entity, 8)) {
        entity playSound(localclientnum, #"fly_bot_ctrl_lvl_02_start", entity.origin);
      }

      break;
    case 3:
      fxclientutils::stopallfxbundles(localclientnum, entity);

      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef5);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef2);
      }

      entity playSound(localclientnum, #"fly_bot_ctrl_lvl_03_start", entity.origin);
      break;
  }
}

private robotlightshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;

  if(!isDefined(entity) || !entity isai() || isDefined(entity.archetype) && entity.archetype != "robot") {
    return;
  }

  fxclientutils::stopallfxbundles(localclientnum, entity);
  flicker = newvalue == 1;

  if(newvalue == 0 || newvalue == 3 || flicker) {
    robotlighting(localclientnum, entity, flicker, clientfield::get("robot_mind_control"));
    return;
  }

  if(newvalue == 4) {
    fxclientutils::playfxbundle(localclientnum, entity, entity.deathfxdef);
  }
}

private robotemphandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;

  if(!isDefined(entity) || !entity isai() || isDefined(entity.archetype) && entity.archetype != "robot") {
    return;
  }

  if(isDefined(entity.empfx)) {
    stopfx(localclientnum, entity.empfx);
  }

  switch (newvalue) {
    case 0:
      break;
    case 1:
      entity.empfx = util::playFXOnTag(localclientnum, level._effect[#"fx_ability_elec_surge_short_robot"], entity, "j_spine4");
      break;
  }
}

private robotmindcontrolhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;

  if(!isDefined(entity) || !entity isai() || isDefined(entity.archetype) && entity.archetype != "robot") {
    return;
  }

  lights = clientfield::get("robot_lights");
  flicker = lights == 1;

  if(lights == 0 || flicker) {
    robotlighting(localclientnum, entity, flicker, newvalue);
  }
}

robotmindcontrolexplosionhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;

  if(!isDefined(entity) || !entity isai() || isDefined(entity.archetype) && entity.archetype != "robot") {
    return;
  }

  switch (newvalue) {
    case 1:
      entity.explosionfx = util::playFXOnTag(localclientnum, level._effect[#"fx_exp_robot_stage3_evb"], entity, "j_spineupper");
      break;
  }
}
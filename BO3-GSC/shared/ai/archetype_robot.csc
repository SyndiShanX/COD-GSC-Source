/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_robot.csc
*************************************************/

#using scripts\shared\ai\systems\fx_character;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace archetype_robot;

function autoexec __init__sytem__() {
  system::register("robot", &__init__, undefined, undefined);
}

function autoexec precache() {
  level._effect["fx_ability_elec_surge_short_robot"] = "electric/fx_ability_elec_surge_short_robot";
  level._effect["fx_exp_robot_stage3_evb"] = "explosions/fx_exp_robot_stage3_evb";
}

function __init__() {
  if(ai::shouldregisterclientfieldforarchetype("robot")) {
    clientfield::register("actor", "robot_mind_control", 1, 2, "int", &robotclientutils::robotmindcontrolhandler, 0, 1);
    clientfield::register("actor", "robot_mind_control_explosion", 1, 1, "int", &robotclientutils::robotmindcontrolexplosionhandler, 0, 0);
    clientfield::register("actor", "robot_lights", 1, 3, "int", &robotclientutils::robotlightshandler, 0, 0);
    clientfield::register("actor", "robot_EMP", 1, 1, "int", &robotclientutils::robotemphandler, 0, 0);
  }
  ai::add_archetype_spawn_function("robot", &robotclientutils::robotsoldierspawnsetup);
}

#namespace robotclientutils;

function private robotsoldierspawnsetup(localclientnum) {
  entity = self;
}

function private robotlighting(localclientnum, entity, flicker, mindcontrolstate) {
  switch (mindcontrolstate) {
    case 0: {
      entity tmodeclearflag(0);
      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef3);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.fxdef);
      }
      break;
    }
    case 1: {
      entity tmodeclearflag(0);
      fxclientutils::stopallfxbundles(localclientnum, entity);
      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef4);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef1);
      }
      if(!gibclientutils::isgibbed(localclientnum, entity, 8)) {
        entity playSound(localclientnum, "fly_bot_ctrl_lvl_01_start", entity.origin);
      }
      break;
    }
    case 2: {
      entity tmodesetflag(0);
      fxclientutils::stopallfxbundles(localclientnum, entity);
      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef4);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef1);
      }
      if(!gibclientutils::isgibbed(localclientnum, entity, 8)) {
        entity playSound(localclientnum, "fly_bot_ctrl_lvl_02_start", entity.origin);
      }
      break;
    }
    case 3: {
      entity tmodesetflag(0);
      fxclientutils::stopallfxbundles(localclientnum, entity);
      if(flicker) {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef5);
      } else {
        fxclientutils::playfxbundle(localclientnum, entity, entity.altfxdef2);
      }
      entity playSound(localclientnum, "fly_bot_ctrl_lvl_03_start", entity.origin);
      break;
    }
  }
}

function private robotlightshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(!isDefined(entity) || !entity isai() || (isDefined(entity.archetype) && entity.archetype != "robot")) {
    return;
  }
  fxclientutils::stopallfxbundles(localclientnum, entity);
  flicker = newvalue == 1;
  if(newvalue == 0 || newvalue == 3 || flicker) {
    robotlighting(localclientnum, entity, flicker, clientfield::get("robot_mind_control"));
  } else if(newvalue == 4) {
    fxclientutils::playfxbundle(localclientnum, entity, entity.deathfxdef);
  }
}

function private robotemphandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(!isDefined(entity) || !entity isai() || (isDefined(entity.archetype) && entity.archetype != "robot")) {
    return;
  }
  if(isDefined(entity.empfx)) {
    stopfx(localclientnum, entity.empfx);
  }
  switch (newvalue) {
    case 0: {
      break;
    }
    case 1: {
      entity.empfx = playFXOnTag(localclientnum, level._effect["fx_ability_elec_surge_short_robot"], entity, "j_spine4");
      break;
    }
  }
}

function private robotmindcontrolhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(!isDefined(entity) || !entity isai() || (isDefined(entity.archetype) && entity.archetype != "robot")) {
    return;
  }
  lights = clientfield::get("robot_lights");
  flicker = lights == 1;
  if(lights == 0 || flicker) {
    robotlighting(localclientnum, entity, flicker, newvalue);
  }
}

function robotmindcontrolexplosionhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(!isDefined(entity) || !entity isai() || (isDefined(entity.archetype) && entity.archetype != "robot")) {
    return;
  }
  switch (newvalue) {
    case 1: {
      entity.explosionfx = playFXOnTag(localclientnum, level._effect["fx_exp_robot_stage3_evb"], entity, "j_spineupper");
      break;
    }
  }
}
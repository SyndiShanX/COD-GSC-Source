/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\warlord.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace warlord;

function autoexec __init__sytem__() {
  system::register("warlord", & __init__, undefined, undefined);
}

function autoexec precache() {
  level._effect["fx_elec_warlord_damage_1"] = "electric/fx_elec_warlord_damage_1";
  level._effect["fx_elec_warlord_damage_2"] = "electric/fx_elec_warlord_damage_2";
  level._effect["fx_elec_warlord_lower_damage_1"] = "electric/fx_elec_warlord_lower_damage_1";
  level._effect["fx_elec_warlord_lower_damage_2"] = "electric/fx_elec_warlord_lower_damage_2";
  level._effect["fx_exp_warlord_death"] = "explosions/fx_exp_warlord_death";
  level._effect["fx_exhaust_jetpack_warlord_juke"] = "vehicle/fx_exhaust_jetpack_warlord_juke";
  level._effect["fx_light_eye_glow_warlord"] = "light/fx_light_eye_glow_warlord";
  level._effect["fx_light_body_glow_warlord"] = "light/fx_light_body_glow_warlord";
}

function __init__() {
  if(ai::shouldregisterclientfieldforarchetype("warlord")) {
    clientfield::register("actor", "warlord_type", 1, 2, "int", & warlordclientutils::warlordtypehandler, 0, 0);
    clientfield::register("actor", "warlord_damage_state", 1, 2, "int", & warlordclientutils::warlorddamagestatehandler, 0, 0);
    clientfield::register("actor", "warlord_thruster_direction", 1, 3, "int", & warlordclientutils::warlordthrusterhandler, 0, 0);
    clientfield::register("actor", "warlord_lights_state", 1, 1, "int", & warlordclientutils::warlordlightshandler, 0, 0);
  }
}

#namespace warlordclientutils;

function warlorddamagestatehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(isDefined(entity.damagestatefx)) {
    stopfx(localclientnum, entity.damagestatefx);
    entity.damagestatefx = undefined;
  }
  if(isDefined(entity.damageheavystatefx)) {
    stopfx(localclientnum, entity.damageheavystatefx);
    entity.damageheavystatefx = undefined;
  }
  switch (newvalue) {
    case 0: {
      break;
    }
    case 2: {
      entity.damageheavystatefx = playFXOnTag(localclientnum, level._effect["fx_elec_warlord_damage_2"], entity, "j_spine4");
      playFXOnTag(localclientnum, level._effect["fx_elec_warlord_lower_damage_2"], entity, "j_mainroot");
    }
    case 1: {
      entity.damagestatefx = playFXOnTag(localclientnum, level._effect["fx_elec_warlord_damage_1"], entity, "j_spine4");
      playFXOnTag(localclientnum, level._effect["fx_elec_warlord_lower_damage_1"], entity, "j_mainroot");
      break;
    }
    case 3: {
      playFXOnTag(localclientnum, level._effect["fx_exp_warlord_death"], entity, "j_spine4");
      break;
    }
  }
}

function warlordtypehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  entity.warlordtype = newvalue;
}

function warlordthrusterhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(isDefined(entity.thrusterfx)) {
    assert(isarray(entity.thrusterfx));
    for(index = 0; index < entity.thrusterfx.size; index++) {
      stopfx(localclientnum, entity.thrusterfx[index]);
    }
  }
  entity.thrusterfx = [];
  tags = [];
  switch (newvalue) {
    case 0: {
      break;
    }
    case 1: {
      tags = array("tag_jets_left_front", "tag_jets_right_front");
      break;
    }
    case 2: {
      tags = array("tag_jets_left_back", "tag_jets_right_back");
      break;
    }
    case 3: {
      tags = array("tag_jets_left_side");
      break;
    }
    case 4: {
      tags = array("tag_jets_right_side");
      break;
    }
  }
  for(index = 0; index < tags.size; index++) {
    entity.thrusterfx[entity.thrusterfx.size] = playFXOnTag(localclientnum, level._effect["fx_exhaust_jetpack_warlord_juke"], entity, tags[index]);
  }
}

function warlordlightshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(newvalue == 1) {
    playFXOnTag(localclientnum, level._effect["fx_light_eye_glow_warlord"], entity, "tag_eye");
    playFXOnTag(localclientnum, level._effect["fx_light_body_glow_warlord"], entity, "j_spine4");
  }
}
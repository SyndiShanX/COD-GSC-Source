/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\archetype_zod_companion.csc
*************************************************/

#using scripts\shared\ai\systems\fx_character;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zodcompanionclientutils;

function autoexec __init__sytem__() {
  system::register("zm_zod_companion", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "being_robot_revived", 1, 1, "int", & play_revival_fx, 0, 0);
  ai::add_archetype_spawn_function("zod_companion", & zodcompanionspawnsetup);
  level._effect["fx_dest_robot_head_sparks"] = "destruct/fx_dest_robot_head_sparks";
  level._effect["fx_dest_robot_body_sparks"] = "destruct/fx_dest_robot_body_sparks";
  level._effect["companion_revive_effect"] = "zombie/fx_robot_helper_revive_player_zod_zmb";
  ai::add_archetype_spawn_function("robot", & zodcompanionspawnsetup);
}

function private zodcompanionspawnsetup(localclientnum) {
  entity = self;
  gibclientutils::addgibcallback(localclientnum, entity, 8, & zodcompanionheadgibfx);
  gibclientutils::addgibcallback(localclientnum, entity, 8, & _gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 16, & _gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 32, & _gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 128, & _gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 256, & _gibcallback);
  fxclientutils::playfxbundle(localclientnum, entity, entity.fxdef);
}

function zodcompanionheadgibfx(localclientnum, entity, gibflag) {
  if(!isDefined(entity) || !entity isai() || !isalive(entity)) {
    return;
  }
  if(isDefined(entity.mindcontrolheadfx)) {
    stopfx(localclientnum, entity.mindcontrolheadfx);
    entity.mindcontrolheadfx = undefined;
  }
  entity.headgibfx = playFXOnTag(localclientnum, level._effect["fx_dest_robot_head_sparks"], entity, "j_neck");
  playSound(0, "prj_bullet_impact_robot_headshot", entity.origin);
}

function zodcompaniondamagedfx(localclientnum, entity) {
  if(!isDefined(entity) || !entity isai() || !isalive(entity)) {
    return;
  }
  entity.damagedfx = playFXOnTag(localclientnum, level._effect["fx_dest_robot_body_sparks"], entity, "j_spine4");
}

function zodcompanionclearfx(localclientnum, entity) {
  if(!isDefined(entity) || !entity isai()) {
    return;
  }
}

function private _gibcallback(localclientnum, entity, gibflag) {
  if(!isDefined(entity) || !entity isai()) {
    return;
  }
  switch (gibflag) {
    case 8: {
      break;
    }
    case 16: {
      break;
    }
    case 32: {
      break;
    }
    case 128: {
      break;
    }
    case 256: {
      break;
    }
  }
}

function play_revival_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.robot_revival_fx) && oldval == 1 && newval == 0) {
    stopfx(localclientnum, self.robot_revival_fx);
  }
  if(newval === 1) {
    self playSound(0, "evt_civil_protector_revive_plr");
    self.robot_revival_fx = playFXOnTag(localclientnum, level._effect["companion_revive_effect"], self, "j_spineupper");
  }
}
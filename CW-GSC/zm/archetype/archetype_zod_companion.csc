/****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\archetype\archetype_zod_companion.csc
****************************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zodcompanionclientutils;

function private autoexec __init__system__() {
  system::register(#"zm_zod_companion", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("allplayers", "" + # "being_robot_revived", 24000, 1, "int", &play_revival_fx, 0, 0);
  ai::add_archetype_spawn_function(#"zod_companion", &zodcompanionspawnsetup);
  level._effect[# "fx_dest_robot_head_sparks"] = "destruct/fx_dest_robot_head_sparks";
  level._effect[# "fx_dest_robot_body_sparks"] = "destruct/fx_dest_robot_body_sparks";
  level._effect[# "companion_revive_effect"] = # "hash_3adc423957988632";
  ai::add_archetype_spawn_function(#"robot", &zodcompanionspawnsetup);
}

function private zodcompanionspawnsetup(localclientnum) {
  entity = self;
  gibclientutils::addgibcallback(localclientnum, entity, 8, &zodcompanionheadgibfx);
  gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 128, &_gibcallback);
  gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
  fxclientutils::playfxbundle(localclientnum, entity, entity.fxdef);
}

function zodcompanionheadgibfx(localclientnum, entity, gibflag) {
  if(!isDefined(gibflag) || !gibflag isai() || !isalive(gibflag)) {
    return;
  }

  if(isDefined(gibflag.mindcontrolheadfx)) {
    stopfx(entity, gibflag.mindcontrolheadfx);
    gibflag.mindcontrolheadfx = undefined;
  }

  gibflag.headgibfx = util::playFXOnTag(entity, level._effect[# "fx_dest_robot_head_sparks"], gibflag, "j_neck");
  playSound(0, #"prj_bullet_impact_robot_headshot", gibflag.origin);
}

function zodcompaniondamagedfx(localclientnum, entity) {
  if(!isDefined(entity) || !entity isai() || !isalive(entity)) {
    return;
  }

  entity.damagedfx = util::playFXOnTag(localclientnum, level._effect[# "fx_dest_robot_body_sparks"], entity, "j_spine4");
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
    case 8:
      break;
    case 16:
      break;
    case 32:
      break;
    case 128:
      break;
    case 256:
      break;
  }
}

function play_revival_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.robot_revival_fx) && fieldname == 1 && bwastimejump == 0) {
    stopfx(binitialsnap, self.robot_revival_fx);
  }

  if(bwastimejump === 1) {
    self playSound(0, #"evt_civil_protector_revive_plr");
    self.robot_revival_fx = util::playFXOnTag(binitialsnap, level._effect[# "companion_revive_effect"], self, "j_spine4");
  }
}
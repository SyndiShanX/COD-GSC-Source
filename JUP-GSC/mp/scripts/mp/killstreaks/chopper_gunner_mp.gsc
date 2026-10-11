/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\chopper_gunner_mp.gsc
***********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\print;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#namespace chopper_gunner_mp;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("chopper_gunner", &scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunnerfromstruct);
  scripts\engine\utility::registersharedfunc("chopper_gunner", "set_vehicle_hit_damage_data", &chopper_gunner_set_vehicle_hit_damage_data);
  scripts\engine\utility::registersharedfunc("chopper_gunner", "findTargetStruct", &chopper_gunner_findtargetstruct);
  scripts\engine\utility::registersharedfunc("chopper_gunner", "assignTargetMarkers", &chopper_gunner_assigntargetmarkers);
  scripts\engine\utility::registersharedfunc("chopper_gunner", "attachXRays", &function_dacd2cee9c44366f);
}

function chopper_gunner_set_vehicle_hit_damage_data(ref, hitstokill) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(ref, hitstokill);
}

function chopper_gunner_findtargetStruct(structlinkname, var_6e1e1e75fc237eb1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(structlinkname, var_6e1e1e75fc237eb1);
}

function chopper_gunner_assigntargetmarkers() {
  var_2cd52bbc2a67b7cf = [];
  var_5408012d0aed529a = [];
  character_array = level.players;

  foreach(player in character_array) {
    if(level.teambased && player.team == self.team || player == self.owner) {
      var_5408012d0aed529a[var_5408012d0aed529a.size] = player;
      continue;
    }

    if(player scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_2cd52bbc2a67b7cf[var_2cd52bbc2a67b7cf.size] = player;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self.owner, var_2cd52bbc2a67b7cf, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerfriendly", self.owner, var_5408012d0aed529a, self.owner, 1, 1);
}

function function_dacd2cee9c44366f(choppergunner) {
  choppergunner setentityhudoutlinedata(3, choppergunner.team);
  return choppergunner;
}
/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_juggernaut.gsc
***********************************************************/

function init() {
  thread disablepersupdates();
  thread disableplayerkillrewards();
  thread disableonemilannounce();
  thread disablepersonalnuke();
}

function disablepersupdates() {
  if(getdvarint("scr_brjugg_debug", 0) == 1) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropbag");
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
    scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("tabletReplace");
}

function disableplayerkillrewards() {
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerWelcomeSplashes", &disableteamkillrewards);
  waittillframeend();
  scripts\mp\flags::gameflaginit("start_jugg_delivery", 0);
  level.ontimelimit = &disabletargetmarkergroups;
  scripts\mp\gametypes\br_gametypes::ref_12B11("onJuggCrateActivate", &disablespawncamera);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onJuggCrateUse", &disablespawningforplayerfunc);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onJuggCrateDestroy", &disablespawningforplayer);
  scripts\mp\gametypes\br_gametypes::ref_12B11("onJuggDropOnDeath", &disablelootbunkercachelocations);
  disablefeature();
  level.ref_140D9 = [];
  level.ref_140D9[0] = "assassination";
  level.ref_140D9[1] = "domination";
  level.ref_140D9[2] = "scavenger";
  level.ref_1385F = 0;
  thread disableplayerrewards();
}

function disableonemilannounce() {
  wait 1;
  game["dialog"]["match_start"] = "gametype_juggernautroyale";
}

function disablefeature() {
  scripts\cp_mp\utility\game_utility::ref_12C10("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::ref_12C11("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::ref_12C11("me_electrical_box_street_01", 1);
}

function disablepersonalnuke() {}

function disableteamkillrewards(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_juggernaut_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground()) {
      waitframe();
    }
  } else {
    level waittill("prematch_done");
  }

  scripts\mp\gametypes\br_analytics::detachriotshield(self);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_juggernaut_welcome");
  scripts\mp\gametypes\br_public::dmztut_endgamewithreward("primary_objective", self, 0);
}

function disabletargetmarkergroups() {
  if(isDefined(level.numendgame)) {
    level thread scripts\mp\gametypes\br::startendgame(1);
  }

  level.numendgame = undefined;
}

function disableplayerrewards() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return;
  }

  level waittill("br_prematchEnded");
  thread display_already_have_weapon_message();
  thread display_current_cypher_to_player();
  var_0 = 1;

  for(;;) {
    var_1 = getdvarint("scr_br_jugg_active", 1);

    if(!var_1) {
      waitframe();
      continue;
    }

    var_2 = scripts\mp\gametypes\br_jugg_common::resetafkchecks();

    if(level.ref_11F2C > 0) {
      var_2 -= level.ref_11F2C;
    }

    level.vehicle_isneutraltoplayer = scripts\engine\utility::array_randomize(level.vehicle_isneutraltoplayer);
    var_3 = scripts\mp\gametypes\br_jugg_common::ref_1334B(var_2, var_0);

    while(!istrue(level.ref_1385F)) {
      waitframe();
    }

    var_0 = 0;
    level thread scripts\mp\gametypes\br_jugg_common::ref_1383F(var_3, "gametype_juggernaut");
    level waittill("continue_jugg_drops");
    var_4 = getdvarint("scr_br_jugg_delivery_interval", 20);
    wait var_4;
  }
}

function display_already_have_weapon_message() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("start_jugg_delivery");
  level.ref_1385F = 1;
}

function dismount_after_accum_damage_internal(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("br_player_eliminated");
    var_1 = scripts\mp\gametypes\br::reinforcement_type();

    if(var_1.size <= var_0) {
      scripts\mp\flags::gameflagset("start_jugg_delivery");
      break;
    }
  }
}

function display_current_cypher_to_player() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_jugg_time_start", 10);
  wait var_0;
  scripts\mp\flags::gameflagset("start_jugg_delivery");
}

function disablespawncamera(var_0) {}

function disablespawningforplayerfunc(var_0) {}

function disablespawningforplayer(var_0) {
  level notify("continue_jugg_drops");
}

function disablelootbunkercachelocations(var_0) {
  level notify("continue_jugg_drops");
  scripts\mp\gametypes\br_plunder::dropplunderbyrarity(100, var_0);
  var_1 = getdvarint("scr_br_jugg_drop_minigun", 1);

  if(var_1) {
    scripts\mp\gametypes\br_pickups::ml_p1_func("brloot_weapon_lm_dblmg_lege", var_0);
    return;
  }
}
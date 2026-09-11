/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_bblitz.gsc
*******************************************************/

function init() {
  if(!getdvarint("scr_br_alt_mode_bblitz", 0)) {
    return;
  }

  level.clear_cypher_icon = 0;
  level.clear_and_give_killstreak_loadout_assault = getdvarint("scr_br_alt_mode_bblitz_goal", 3);
  thread impactfunc_null();
}

function impactfunc_null() {
  level endon("game_ended");
  level waittill("prematch_done");
  var0 = getarraykeys(level.teamdata);

  foreach(var2 in var0) {
    level.teamdata[var2]["bblitzCounter"] = 0;
  }

  jumpiftrue(getdvarint("scr_br_alt_mode_bblitz_shutdown_check", 1)) LOC_00000058;
  return;
}

function clear_cypher_icon() {
  if(level.clear_cypher_icon) {
    return;
  }

  level.clear_cypher_icon = 1;

  foreach(var1 in level.teamdata) {
    clear_bomb_vest_controller_holder(var2, -1);
  }

  scripts\mp\gametypes\br_publicevents::ref_13371("br_bblitz_shutdown");
}

function clear_all_remaining(var0) {
  if(!getdvarint("scr_br_alt_mode_bblitz", 0)) {
    return 0;
  }

  if(level.clear_cypher_icon) {
    return 0;
  }

  var1 = var0.team;

  if(!isDefined(var1)) {
    return 0;
  }

  var2 = scripts\mp\utility\teams::getteamdata(var1, "bblitzCounter") + 1;
  clear_bomb_vest_controller_holder(var1, var2);

  if(var2 == level.clear_and_give_killstreak_loadout_assault) {
    clear_bomb_vest_controller_holder(var1, 0);

    if(getdvarint("scr_br_alt_mode_bblitz_consolation", 1) && !scripts\mp\gametypes\br_extract_quest::outofboundstriggersplanetrace(var0.origin)) {
      thread clear_and_give_killstreak_loadout_demo(var0);
      return var2;
    }

    var3 = spawnStruct();
    var3.ml_p3_to_safehouse_transition = 0;
    var4 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var3, var0.origin, (0, 0, 0), undefined, 0, 0, 35);
    var5 = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_blueprintextract_tablet", var4, 0, 1);
  }

  return var2;
}

function clear_bomb_vest_controller_holder(var0, var1) {
  scripts\mp\utility\teams::setteamdata(var0, "bblitzCounter", var1);

  foreach(var3 in scripts\mp\utility\teams::getteamdata(var0, "players")) {
    var3 setclientomnvar("ui_br_bblitz", var1);
  }
}

function clear_and_give_killstreak_loadout_support() {
  return getdvarfloat("scr_br_alt_mode_bblitz_search_travel_speed", 0);
}

function clear_and_give_killstreak_loadout_recon() {
  return getdvarfloat("scr_br_alt_mode_bblitz_search_min_time", 120);
}

function clear_and_give_killstreak_loadout_demo(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, var0.squadindex);

  foreach(var3 in var1) {
    var3 scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
  }

  var5 = "mp/loot/br/default/lootset_cache_lege.csv";
  var6 = [];
  GscBinSkip0(0x2e, var6.size, registerscriptedspawnpoints("weapon", 3, 4, var5));
}
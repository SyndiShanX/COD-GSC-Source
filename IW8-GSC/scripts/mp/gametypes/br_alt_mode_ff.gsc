/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_ff.gsc
***************************************************/

function init() {
  if(getdvarint("scr_br_alt_mode_ff", 0) == 0) {
    return;
  }

  if(getdvarint("scr_br_ff_fists", 0) > 0) {
    play_animation();
  }

  if(getdvarint("scr_br_ff_mask", 0) > 0) {
    play_armor_bink();
    return;
  }
}

function play_animation() {
  level.player_equip_regen = 2;
}

function play_alert_music_to_player() {}

function play_bcs() {}

function play_alarms_onto() {}

function play_airstrike_sequence() {}

function play_armor_bink() {
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ai_juggernaut_think);
}

function ai_juggernaut_think() {
  scripts\mp\gametypes\br::ref_11e23();
  var_0 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_equip_gasmask", 1, undefined, 0);
}

function play_battle_chatter_vo() {}

function play_airport_success_vo(var_0) {
  if(getdvarint("scr_br_alt_mode_ff", 0) == 0 || getdvarint("scr_br_ff_amped", 0) == 0 || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(!isDefined(var_0) || !isPlayer(var_0) || istrue(var_0.inlaststand) || !var_0 scripts\cp_mp\utility\player_utility::_isalive() || var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || istrue(var_0.isjuggernaut)) {
    return;
  }

  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var_3) || scripts\mp\utility\weapon::issuperweapon(var_3) || scripts\mp\utility\weapon::iskillstreakweapon(var_3) || scripts\mp\utility\weapon::isgamemodeweapon(var_3)) {
      continue;
    }

    var_4 = scripts\mp\utility\weapon::getweapongroup(var_3);
    var_5 = 3;
    var_6 = scripts\mp\weapons::getammooverride(var_3) * var_5;

    if(var_3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_3.underbarrel) == "ubshtgn") {
      var_7 = var_0 getweaponammoclip(var_3);
      var_8 = int(var_7 + var_6);
      var_0 setweaponammoclip(var_3, var_8);
      continue;
    }

    var_9 = var_0 getweaponammostock(var_3);
    var_8 = int(var_9 + var_6);
    var_0 setweaponammostock(var_3, var_8);
  }

  var_11 = var_0 scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(var_11)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_11);
  }

  var_12 = var_0 scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(var_12)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_12);
  }

  var_0.health = var_0.maxhealth;
  var_0.br_armorhealth = var_0.br_maxarmorhealth;
  var_0 setclientomnvar("ui_br_armor_damage", 1);
  var_0 scripts\mp\equipment\armor_plate::debug_state(var_0.br_armorhealth);
  var_0 playsoundtoplayer("ammo_crate_use", var_0);
}

function play_authentication_error_window() {}

function play_approach_building_two() {}

function play_animation_old(var_0, var_1) {
  if(getdvarint("scr_br_alt_mode_ff", 0) == 0 || getdvarint("scr_br_ff_fountain", 0) == 0 || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(!isDefined(var_0) || !isPlayer(var_0) || !isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }

  if(var_0 == var_1 || !var_0 scripts\cp_mp\utility\player_utility::_isalive() || scripts\mp\utility\player::unset_relic_trex(var_0) || var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return;
  }

  var_0 scripts\mp\gametypes\br_plunder::ref_12627(1);
  var_2 = "combat";
  scripts\mp\gametypes\br_analytics::ref_13c44(var_0, var_2, 1);
}

function play_bank_intro_vo() {}

function play_breach_anim() {}
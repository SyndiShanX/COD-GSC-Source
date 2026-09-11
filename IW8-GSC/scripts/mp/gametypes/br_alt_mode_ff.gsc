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
  var0 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_equip_gasmask", 1, undefined, 0);
}

function play_battle_chatter_vo() {}

function play_airport_success_vo(var0) {
  if(getdvarint("scr_br_alt_mode_ff", 0) == 0 || getdvarint("scr_br_ff_amped", 0) == 0 || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(!isDefined(var0) || !isPlayer(var0) || istrue(var0.inlaststand) || !var0 scripts\cp_mp\utility\player_utility::_isalive() || var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || istrue(var0.isjuggernaut)) {
    return;
  }

  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var3) || scripts\mp\utility\weapon::issuperweapon(var3) || scripts\mp\utility\weapon::iskillstreakweapon(var3) || scripts\mp\utility\weapon::isgamemodeweapon(var3)) {
      continue;
    }

    var4 = scripts\mp\utility\weapon::getweapongroup(var3);
    var5 = 3;
    var6 = scripts\mp\weapons::getammooverride(var3) * var5;

    if(var3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var3.underbarrel) == "ubshtgn") {
      var7 = var0 getweaponammoclip(var3);
      var8 = int(var7 + var6);
      var0 setweaponammoclip(var3, var8);
      continue;
    }

    var9 = var0 getweaponammostock(var3);
    var8 = int(var9 + var6);
    var0 setweaponammostock(var3, var8);
  }

  var11 = var0 scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(var11)) {
    var0 scripts\mp\equipment::incrementequipmentammo(var11);
  }

  var12 = var0 scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(var12)) {
    var0 scripts\mp\equipment::incrementequipmentammo(var12);
  }

  var0.health = var0.maxhealth;
  var0.br_armorhealth = var0.br_maxarmorhealth;
  var0 setclientomnvar("ui_br_armor_damage", 1);
  var0 scripts\mp\equipment\armor_plate::debug_state(var0.br_armorhealth);
  var0 playsoundtoplayer("ammo_crate_use", var0);
}

function play_authentication_error_window() {}

function play_approach_building_two() {}

function play_animation_old(var0, var1) {
  if(getdvarint("scr_br_alt_mode_ff", 0) == 0 || getdvarint("scr_br_ff_fountain", 0) == 0 || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(!isDefined(var0) || !isPlayer(var0) || !isDefined(var1) || !isPlayer(var1)) {
    return;
  }

  if(var0 == var1 || !var0 scripts\cp_mp\utility\player_utility::_isalive() || scripts\mp\utility\player::unset_relic_trex(var0) || var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
    return;
  }

  var0 scripts\mp\gametypes\br_plunder::ref_12627(1);
  var2 = "combat";
  scripts\mp\gametypes\br_analytics::ref_13c44(var0, var2, 1);
}

function play_bank_intro_vo() {}

function play_breach_anim() {}
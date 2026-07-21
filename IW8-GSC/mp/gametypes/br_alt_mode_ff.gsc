/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_ff.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_928413BBE1B6EF0E081FC9DC51399567D559F172E9", 0) == 0) {
    return;
  }
  if(getdvarint("_encstr_B10A104A267D69C2EB512B233901B1D31946", 0) > 0)
    play_animation();

  if(getdvarint("_encstr_A1EF0F584FB2567D937994AC415A431B03", 0) > 0)
    play_armor_bink();
}

play_animation() {
  level.player_equip_regen = 2.0;
}

play_alert_music_to_player() {}

play_bcs() {}

play_alarms_onto() {}

play_airstrike_sequence() {}

play_armor_bink() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::ai_juggernaut_think);
}

ai_juggernaut_think() {
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11E23();
  var_0 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(self, "_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28", 1, undefined, 0);
}

play_battle_chatter_vo() {}

play_airport_success_vo(var_0) {
  if(getdvarint("_encstr_928413BBE1B6EF0E081FC9DC51399567D559F172E9", 0) == 0 || getdvarint("_encstr_851A10B39F361738A20918BA8141C07750BD", 0) == 0 || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  if(!isDefined(var_0) || !isPlayer(var_0) || istrue(var_0.inlaststand) || !var_0 scripts\cp_mp\utility\player_utility::_isalive() || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() || istrue(var_0.isjuggernaut)) {
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

    if(var_3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_3.underbarrel) == "_encstr_BE9708CBAB13138857AD") {
      var_7 = var_0 getweaponammoclip(var_3);
      var_8 = int(var_7 + var_6);
      var_0 setweaponammoclip(var_3, var_8);
      continue;
    }

    var_9 = var_0 getweaponammostock(var_3);
    var_8 = int(var_9 + var_6);
    var_0 setweaponammostock(var_3, var_8);
  }

  var_11 = var_0 scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(var_11))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_11);

  var_12 = var_0 scripts\mp\equipment::getcurrentequipment("_encstr_AC8F0AE74163F85AAA380AD8");

  if(isDefined(var_12))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_12);

  var_0.health = var_0.maxhealth;
  var_0.br_armorhealth = var_0.br_maxarmorhealth;
  var_0 setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", 1);
  var_0 scripts\mp\equipment\armor_plate::debug_state(var_0.br_armorhealth);
  var_0 playsoundtoplayer("_encstr_A3C80F4AF0E9DFB1709519F44369C36705", var_0);
}

play_authentication_error_window() {}

play_approach_building_two() {}

play_animation_old(var_0, var_1) {
  if(getdvarint("_encstr_928413BBE1B6EF0E081FC9DC51399567D559F172E9", 0) == 0 || getdvarint("_encstr_813A13635FA3BF364DBF9D7847FEC030087BB6EA65", 0) == 0 || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  if(!isDefined(var_0) || !isPlayer(var_0) || !isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(var_0 == var_1 || !var_0 scripts\cp_mp\utility\player_utility::_isalive() || scripts\mp\utility\player::unset_relic_trex(var_0) || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal()) {
    return;
  }
  var_0 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(1);
  var_2 = "_encstr_AA7C07466F9DA30713";
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_id_13C44(var_0, var_2, 1);
}

play_bank_intro_vo() {}

play_breach_anim() {}
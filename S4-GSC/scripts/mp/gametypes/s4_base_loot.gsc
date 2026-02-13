/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\s4_base_loot.gsc
*************************************************/

_id_985B() {
  scripts\mp\gametypes\br_weapons::_id_29FC();
  scripts\mp\gametypes\br_pickups::_id_2A96();
  scripts\mp\gametypes\br_lootcache::_id_2BE7();
  _id_07A1::_id_CECB(::_id_989B);
  _id_07A1::_id_CEC6(::_id_989B);
  _id_0AA3::_id_C28D(::onplayerspawnedbaseperks);
  level._id_CAB3 = "s4_base_plunder_box";
  level._id_CAB5 = "scriptable_loot_s4_plunder_box";
  level.s4_armory_kiosk_scriptable_names = ["scriptable_s4_base_plunder_box_support", "scriptable_s4_base_plunder_box_weapons", "scriptable_s4_base_plunder_box_equipment", "scriptable_s4_base_plunder_box_perks", "scriptable_s4_base_plunder_box_vehicles", "scriptable_s4_base_plunder_box_loadouts", "scriptable_s4_base_plunder_box_redeploy"];
  level._id_CAB1 = ::is_enemy_base;
  level._id_1A93 = ["comm", "unco", "rare", "epic", "lege"];
  var_0 = [];

  if(isDefined(level.s4_armory_kiosk_scriptable_names)) {
    foreach(var_2 in level.s4_armory_kiosk_scriptable_names) {
      var_0 = scripts\engine\utility::array_combine(var_0, _func_03C0(var_2, "classname"));
    }
  } else
    var_0 = _func_03C0(level._id_CAB5, "classname");

  var_4 = 0;
  var_5 = [2, 3, 4, 5, 6, 7, 8];

  foreach(var_7 in var_0) {
    var_8 = var_5[var_4 % var_5.size];

    switch (var_7.classname) {
      case "scriptable_s4_base_plunder_box_weapons":
        var_8 = 2;
        break;
      case "scriptable_s4_base_plunder_box_equipment":
        var_8 = 3;
        break;
      case "scriptable_s4_base_plunder_box_perks":
        var_8 = 4;
        break;
      case "scriptable_s4_base_plunder_box_support":
        var_8 = 5;
        break;
      case "scriptable_s4_base_plunder_box_vehicles":
        var_8 = 6;
        break;
      case "scriptable_s4_base_plunder_box_loadouts":
        var_8 = 7;
        break;
      case "scriptable_s4_base_plunder_box_redeploy":
        var_8 = 8;
        break;
      default:
        var_8 = 2;
        break;
    }

    if(isDefined(var_8)) {
      var_7._id_AC30 = var_8;
    }

    var_7 setscriptablepartstate(level._id_CAB3, "visible");
    var_7._id_10417 = 1;
  }

  foreach(var_7 in var_0) {
    var_11 = "v_ui_icon_championhill_buystations_equipment_01";

    if(isDefined(var_7._id_AC30)) {
      switch (var_7._id_AC30) {
        case 2:
          var_11 = "v_ui_icon_championhill_buystations_weapons_01";
          break;
        case 4:
          var_11 = "v_ui_icon_championhill_buystations_perk_01";
          break;
        case 5:
          var_11 = "v_ui_icon_championhill_buystations_killstreak_01";
          break;
        case 6:
          var_11 = "v_ui_icon_championhill_buystations_killstreak_01";
          break;
        case 7:
          var_11 = "v_ui_icon_championhill_buystations_weapons_01";
          break;
        case 8:
          var_11 = "v_ui_icon_championhill_buystations_weapons_01";
          break;
        case 3:
          var_11 = "v_ui_icon_championhill_buystations_equipment_01";
          break;
      }
    }

    var_12 = var_7.origin + (0, 0, 50);
  }

  _id_8112();
  _id_38C5();
  level._id_1A90 = [];
  s4_base_register_loot_item("brloot_armor_plate_full", "groundLoot_special", ::s4_base_loot_give_player_armor);
  s4_base_register_loot_item("s4_base_loot_armor", "groundLoot", ::s4_base_loot_give_player_armor_single);
  s4_base_register_loot_item("s4_base_loot_cash", "groundLoot", ::s4_base_loot_give_player_cash);
  s4_base_register_loot_item("s4_base_loot_cash_extra", "groundLoot_handicap", ::s4_baset_loot_give_player_cash_extra);
  s4_base_register_loot_item("s4_base_loot_ammo", "groundLoot", ::s4_base_loot_give_player_ammo);
  s4_base_register_loot_item("s4_sm_wecho43_mp", "weaponLoot", "chloot_weapon_s4_sh_becho");
  s4_base_register_loot_item("s4_sm_tyankee100_mp", "weaponLoot", "chloot_weapon_s4_sh_becho");
  s4_base_register_loot_item("s4_ar_hyankee44_mp", "weaponLoot", "chloot_weapon_s4_sh_becho");
  s4_base_register_loot_item("s4_ar_fecho_mp", "weaponLoot", "chloot_weapon_s4_sh_becho");
  s4_base_register_loot_item("s4_mg_mgolf42_mp", "weaponLoot", "chloot_weapon_s4_mg_mgolf42");
  s4_base_register_loot_item("s4_mr_ptango41_mp", "weaponLoot", "chloot_weapon_s4_sh_becho");
  s4_base_register_loot_item("s4_la_m1bravo_mp", "weaponLoot");
  s4_base_register_loot_item("s4_la_palpha_mp", "weaponLoot");
  s4_base_register_loot_item("equip_frag", "equipmentLoot");
  s4_base_register_loot_item("equip_c4", "equipmentLoot");
  s4_base_register_loot_item("equip_sticky_grenade", "equipmentLoot");
  s4_base_register_loot_item("equip_concussion", "tacticalLoot");
  s4_base_register_loot_item("equip_smoke", "tacticalLoot");
  s4_base_register_loot_item("super_field_mic", "superLoot");
  s4_base_register_loot_item("super_tac_cover", "superLoot");
  s4_base_register_loot_item("super_tac_insert", "superLoot");
  s4_base_register_loot_item("super_equipment_resupply_drop", "superLoot");
  s4_base_register_loot_item("super_pac_sentry", "superLoot");
  s4_base_register_loot_item("uav", "killstreak", ::s4_base_loot_give_uav);
  s4_base_register_loot_item("s4_la_walpha2_mp", "killstreak", ::s4_base_loot_give_player_warmachine);
  s4_base_register_loot_item("glide_bomb", "killstreak", ::s4_base_loot_give_player_glidebomb);
  s4_base_register_loot_item("precision_airstrike", "killstreak", ::s4_base_loot_give_player_strafing_run);
  s4_base_register_loot_item("custom1", "loadout");
  s4_base_register_loot_item("custom2", "loadout");
  s4_base_register_loot_item("custom3", "loadout");
  s4_base_register_loot_item("custom4", "loadout");
  s4_base_register_loot_item("custom5", "loadout");
  s4_base_register_loot_item("custom6", "loadout");
  s4_base_register_loot_item("custom7", "loadout");
  s4_base_register_loot_item("custom8", "loadout");
  s4_base_register_loot_item("custom9", "loadout");
  s4_base_register_loot_item("custom10", "loadout");
  s4_base_register_loot_item("custom11", "loadout");
  s4_base_register_loot_item("custom12", "loadout");
  s4_base_register_loot_item("redeploy", "specialLoot", ::s4_base_loot_redeploy);
  s4_base_register_loot_item("veh_jeep_mp", "vehicleLoot");
  level._id_2A95._id_2A42["brloot_armor_plate"] = "equip_armorplate";
}

onplayerspawnedbaseperks() {
  var_0 = self;

  if(!isDefined(var_0.base_perks)) {
    return;
  }
  foreach(var_2 in var_0.base_perks) {
    s4_base_loot_give_player_perk(var_0, var_2);
  }
}

_id_0EBF(var_0, var_1) {
  var_2 = level.s4_base_loot_item_defs[var_1]._id_989A;

  if(var_2 == "groundLoot" || var_2 == "killstreak" || var_2 == "groundLoot_handicap" || var_2 == "groundLoot_special") {
    [[level.s4_base_loot_item_defs[var_1]._id_FE73]](var_0);
  }

  if(var_2 == "weaponLoot") {
    var_0 _id_6F09(var_1);
  }

  if(var_2 == "equipmentLoot") {
    var_0 _id_D160(var_1, "arena_evo_loadout_override_equipment_primary");
    var_0 scripts\mp\equipment::giveequipment(var_1, "primary");
    var_0 scripts\mp\gametypes\s4_base_util::_id_B61B(1, "primary");
  }

  if(var_2 == "tacticalLoot") {
    var_0 _id_D160(var_1, "arena_evo_loadout_override_equipment_secondary");
    var_0 scripts\mp\equipment::giveequipment(var_1, "secondary");
    var_0 scripts\mp\gametypes\s4_base_util::_id_B61B(1, "secondary");
  }

  if(var_2 == "superLoot") {
    var_0 _id_D160(var_1, "arena_evo_loadout_override_equipment_super");
    var_0 scripts\mp\supers::givesuper(var_1, 0, 1);
    var_0 scripts\mp\gametypes\s4_base_util::_id_B61B();
    var_3 = scripts\mp\supers::_id_6DA1(var_1);
    scripts\mp\equipment::_id_D5AA("super", var_3);
  }

  if(var_2 == "perkLoot") {
    s4_base_loot_give_player_perk(var_0, var_1);
    var_0 setclientomnvar("ui_arena_evo_display_perk_info", gettime());
  }

  if(var_2 == "loadout") {
    s4_base_loot_give_player_loadout(var_0, var_1);
  }
}

_id_38B6() {
  var_0 = self;
  var_0 _id_D160("s4_me_fists", "arena_evo_loadout_override_primary");
  var_0 _id_D160("none", "arena_evo_loadout_override_secondary");
  var_0 _id_D160("none", "arena_evo_loadout_override_equipment_primary");
  var_0 _id_D160("none", "arena_evo_loadout_override_equipment_secondary");
}

_id_D160(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2._id_1A7E)) {
    var_2._id_1A7E = [];
  }

  var_2._id_1A7E[var_1] = var_0;
  var_2 setclientomnvar("ui_base_equipped_loadout", -1);
}

_id_6365(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_1A7E)) {
    return undefined;
  }

  if(!isDefined(var_1._id_1A7E[var_0])) {
    return undefined;
  }

  return var_1._id_1A7E[var_0];
}

s4_base_register_loot_item(var_0, var_1, var_2) {
  if(!isDefined(level.s4_base_loot_item_defs)) {
    level.s4_base_loot_item_defs = [];
  }

  if(!isDefined(level.s4_base_loot_item_defs["groundLoot"])) {
    level.s4_base_loot_item_defs["groundLoot"] = [];
  }

  if(!isDefined(level.s4_base_loot_item_defs["groundLoot_handicap"])) {
    level.s4_base_loot_item_defs["groundLoot_handicap"] = [];
  }

  if(!isDefined(level.s4_base_loot_item_defs["weaponLoot"])) {
    level.s4_base_loot_item_defs["weaponLoot"] = [];
  }

  if(!isDefined(level.s4_base_loot_item_defs["vehicleLoot"])) {
    level.s4_base_loot_item_defs["vehicleLoot"] = [];
  }

  if(!s4_base_itemenabled(var_0)) {
    return;
  }
  if(_id_8B09(var_1)) {
    if(!isDefined(level._id_10CE3)) {
      level._id_10CE3 = [];
    }

    level._id_10CE3[var_0] = var_2;
  }

  level.s4_base_loot_item_defs[var_0] = spawnStruct();
  level.s4_base_loot_item_defs[var_0]._id_CF25 = var_0;
  level.s4_base_loot_item_defs[var_0]._id_989A = var_1;

  if(!_id_8B09(var_1)) {
    level.s4_base_loot_item_defs[var_0]._id_FE73 = var_2;
  }

  if(scripts\engine\utility::is_equal(var_1, "groundLoot")) {
    level.s4_base_loot_item_defs["groundLoot"] = ::scripts\engine\utility::array_add(level.s4_base_loot_item_defs["groundLoot"], level.s4_base_loot_item_defs[var_0]);
  }

  if(scripts\engine\utility::is_equal(var_1, "groundLoot_handicap")) {
    level.s4_base_loot_item_defs["groundLoot_handicap"] = ::scripts\engine\utility::array_add(level.s4_base_loot_item_defs["groundLoot_handicap"], level.s4_base_loot_item_defs[var_0]);
  }

  if(scripts\engine\utility::is_equal(var_1, "weaponLoot")) {
    level.s4_base_loot_item_defs["weaponLoot"] = ::scripts\engine\utility::array_add(level.s4_base_loot_item_defs["weaponLoot"], level.s4_base_loot_item_defs[var_0]);
  }
}

s4_base_itemenabled(var_0) {
  return !getdvarint(_func_0483("#x363dda4a060914f74", var_0), 0);
}

_id_989B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(_func_010D(var_1, "chloot_weapon")) {
    thread _id_0848::_id_DEF9(var_1, var_3);
  }

  if(!isDefined(level.s4_base_loot_item_defs[var_1])) {
    return;
  }
  if(var_1 == "s4_base_loot_armor" && scripts\engine\utility::is_equal(var_3._id_9457, var_3._id_9459)) {
    return;
  }
  var_6 = level.s4_base_loot_item_defs[var_1];

  if(_id_8883(var_6._id_989A) || _id_88F2(var_6._id_989A) || var_6._id_989A == "groundLoot_handicap") {
    if(var_6._id_CF25 == "s4_base_loot_cash" || var_6._id_CF25 == "s4_base_loot") {
      var_3 playlocalsound("ui_mp_ch_money_pickup");
    } else if(var_6._id_CF25 == "s4_base_loot_ammo") {
      var_3 playlocalsound("ui_mp_ch_ammo_pickup");
    } else {
      var_3 playlocalsound("ui_mp_ch_grenade_pickup");
    }
  }

  if(isDefined(var_6._id_FE73)) {
    level thread _id_0EBF(var_3, var_6._id_CF25);
  } else {
    var_3 scripts\mp\gametypes\s4_base_util::_id_B61B();
  }

  if(!_func_0458(var_0) && isDefined(var_0._id_2C2C)) {
    var_0 scripts\mp\gametypes\br_pickups::_id_478B();
  }
}

_id_8883(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "groundLoot":
      var_1 = 1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_88F2(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "killstreak":
      var_1 = 1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_8B09(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "weaponLoot":
      var_1 = 1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_0CEB(var_0, var_1) {
  var_2 = self;
  var_3 = -1;

  switch (var_0) {
    case "uav":
      var_3 = 0;
      break;
    case "s4_la_walpha2_mp":
      var_3 = 1;
      break;
    case "glide_bomb":
      var_3 = 2;
      break;
    case "precision_airstrike":
      var_3 = 3;
      break;
    case "white_phosphorus":
      var_3 = 4;
      break;
    case "loadouts":
      var_3 = 5;
      break;
  }

  if(var_3 != -1) {
    var_2 _meth_82F8("ui_arena_evo_active_killstreak", var_3, var_1);
  }
}

s4_base_loot_give_perk(var_0) {
  var_0 scripts\mp\utility\perk::_id_6FC2("specialty_tracker");
  var_0 thread scripts\mp\hud_message::showsplash("br_specialty_tracker");
}

s4_base_loot_give_uav(var_0) {
  var_0 _id_0CEB("uav", 1);
  var_0 thread scripts\mp\killstreaks\killstreaks::_id_1FC8("uav");
}

s4_base_loot_give_player_armor(var_0) {
  var_0 _id_B3A0(3);
  var_0 setclientomnvar("ui_arena_armor_picked_up", gettime());
}

s4_base_loot_give_player_armor_single(var_0) {
  var_0 _id_B3A0(1);
  var_0 setclientomnvar("ui_arena_armor_picked_up", gettime());
}

s4_base_loot_give_player_cash(var_0) {
  var_1 = getdvarint("#x3fda357592b753ddc", 100);
  var_1 = var_1 * getdvarfloat("#x36805ca4fc9d7f61e", 1.0);
  var_0 scripts\mp\gametypes\base::_id_6FCA(var_1);
}

s4_baset_loot_give_player_cash_extra(var_0) {
  var_1 = getdvarint("#x360b7644578aa5165", 500);
  var_1 = var_1 * getdvarfloat("#x36805ca4fc9d7f61e", 1.0);
  var_0 scripts\mp\gametypes\base::_id_6FCA(var_1);
}

s4_base_loot_give_player_ammo(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = var_3.basename;

    if(var_4 == "s4_mg_streak_mp" || var_4 == "s4_la_walpha2_mp") {
      continue;
    }
    var_5 = weaponmaxammo(var_3);
    var_6 = var_5 * randomfloatrange(0.2, 0.3);
    var_6 = scripts\common\utility::_id_C94D(var_6);
    var_7 = var_0 getweaponammostock(var_3);
    var_8 = var_7 + var_6;

    if(var_8 < var_5) {
      var_0 setweaponammostock(var_3, var_8);
      continue;
    }

    var_0 setweaponammostock(var_3, var_5);
  }

  var_9 = [];
  var_9[0] = var_0 scripts\mp\equipment::_id_69A4("primary");
  var_9[1] = var_0 scripts\mp\equipment::_id_69A4("secondary");

  foreach(var_11 in var_9) {
    if(isDefined(var_11)) {
      var_0 scripts\mp\equipment::incrementequipmentammo(var_11, 1);
    }
  }
}

s4_base_loot_give_player_loadout(var_0, var_1) {
  var_0.class = var_1;
  var_0.ispurchasingloadout = 1;
  var_2 = var_0 getweaponslistprimaries();

  foreach(var_4 in var_2) {
    var_0 takeweapon(var_4);
  }

  var_0 scripts\mp\class::_id_6FB1(var_0.pers["team"], var_1, undefined, 1);
  var_6 = scripts\mp\class::_id_962A();
  var_6 = var_0 scripts\mp\class::_id_963A(var_6, var_1);
  var_0.pers["classCache"][self.class] = var_6;
  var_0 _id_D160(var_6._id_966A, "arena_evo_loadout_override_equipment_primary");
  var_0 _id_D160(var_6._id_966B, "arena_evo_loadout_override_equipment_secondary");
  var_0.ispurchasingloadout = 0;
}

s4_base_loot_redeploy(var_0) {}

s4_base_loot_give_player_warmachine(var_0) {
  var_0 _id_0CEB("s4_la_walpha2_mp", 1);
  var_0.pers["wmStreakAmmo"] = _id_0A66::wmgetclipsize();
  var_0 thread scripts\mp\killstreaks\killstreaks::_id_1FC8("warmachine");
}

s4_base_loot_give_player_glidebomb(var_0) {
  var_0 _id_0CEB("glide_bomb", 1);
  var_0 thread scripts\mp\killstreaks\killstreaks::_id_1FC8("glide_bomb");
}

s4_base_loot_give_player_strafing_run(var_0) {
  var_0 _id_0CEB("precision_airstrike", 1);
  var_0 thread scripts\mp\killstreaks\killstreaks::_id_1FC8("precision_airstrike");
}

s4_base_killstreak_finished(var_0) {
  if(var_0 == "warmachine") {
    var_0 = "s4_la_walpha2_mp";
  }

  _id_0CEB(var_0, 0);
}

_setperkuiomnvars() {
  var_0 = self;

  for(var_1 = 0; var_1 < 7; var_1++) {
    var_0 setclientomnvar("ui_spawn_perk_" + var_1, -1);
  }

  if(isDefined(var_0.base_perks)) {
    var_2 = 0;

    foreach(var_4 in var_0.base_perks) {
      var_5 = scripts\mp\perks\perks::_id_6C26(var_4);
      var_0 setclientomnvar("ui_spawn_perk_" + var_2, var_5);
      var_2++;
    }
  } else
    var_0.base_perks = [];
}

s4_base_loot_give_player_perk(var_0, var_1) {
  if(!var_0 scripts\mp\utility\perk::_hasperk(var_1)) {
    var_0 scripts\mp\utility\perk::_id_6FC2(var_1);
  }

  if(!isDefined(var_0.base_perks)) {
    var_0.base_perks = [var_1];
  }

  if(!scripts\engine\utility::array_contains(var_0.base_perks, var_1)) {
    var_0.base_perks = scripts\engine\utility::array_add(var_0.base_perks, var_1);
  }

  var_0 _setperkuiomnvars();

  if(scripts\engine\utility::is_equal(var_1, "specialty_van_demolition")) {
    var_0 _id_0A6B::_id_D8D6();
  }

  var_0 setclientomnvar("ui_base_equipped_loadout", -1);
}

_id_CA47(var_0) {
  var_1 = self;
  var_1 thread scripts\mp\hud_message::showsplash(var_0);
}

_id_10B0(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_3._id_A4AC)) {
    var_3._id_A4AC = [];
  }

  if(!isDefined(var_3._id_60B8)) {
    var_3._id_60B8 = [];
  }

  var_4 = spawnStruct();
  var_4._id_6016 = var_0;
  var_4._id_AE40 = var_2;

  if(istrue(var_1)) {
    var_3._id_60B8 = scripts\engine\utility::array_add(var_3._id_60B8, var_4);
  } else {
    var_3._id_A4AC = scripts\engine\utility::array_add(var_3._id_A4AC, var_4);
  }
}

_id_C4EA() {
  var_0 = self;
  var_0 _id_0CEB("uav", 0);
  var_0 _id_0CEB("s4_la_walpha2_mp", 0);
  var_0 _id_0CEB("glide_bomb", 0);
  var_0 _id_0CEB("precision_airstrike", 0);
  var_0 _id_0CEB("white_phosphorus", 0);
  var_0 _id_0CEB("loadouts", 0);
  var_0._id_A4AC = [];
}

_id_B3A0(var_0) {
  var_1 = self;
  var_0 = var_0 * 50;

  if(!isDefined(var_1._id_9457) || var_1._id_9457 == 0) {
    _id_07EA::_id_9453(var_1, var_0, 0);
    self setclientomnvar("ui_light_armor_state", 1);
    thread _id_0A15::_id_E806();
  } else {
    var_2 = var_1._id_9457 + var_0;

    if(var_2 > 150) {
      var_2 = 150;
    }

    _id_07EA::_id_9453(var_1, var_2, 0);
  }
}

_id_8112() {
  var_0 = "mp/upgradetable_arena_evo.csv";
  var_1 = 1;
  var_2 = 1;

  if(!_func_0221(var_0)) {
    return;
  }
  if(!isDefined(level._id_1A8F)) {
    level._id_1A8F = [];
    level._id_1A90 = [];

    for(var_3 = var_1; var_3 < _func_0225(var_0); var_3 = var_3 + 2) {
      var_4 = tablelookupbyrow(var_0, 0, var_3);
      var_5 = tablelookupbyrow(var_0, 0, var_3 + 1);

      if(!isDefined(level._id_1A8F[var_4])) {
        level._id_1A8F[var_4] = [var_4];
      }

      for(var_6 = var_2; var_6 < tablelookupgetnumrows(var_0); var_6++) {
        if(!isDefined(level._id_1A90[var_4])) {
          level._id_1A90[var_4] = [];
        }

        var_7 = tablelookupbyrow(var_0, var_6, var_3);

        if(scripts\engine\utility::is_equal(var_7, "none")) {
          break;
        }

        level._id_1A8F[var_4][level._id_1A8F[var_4].size] = var_7;
        var_8 = int(tablelookupbyrow(var_0, var_6, var_3 + 1));

        if(!isDefined(level._id_1A90[var_4][var_7])) {
          level._id_1A90[var_4][var_7] = var_8;
        }

        level._id_1A90[var_4]["weapon_level_" + var_6] = level._id_1A93[var_8 - 1];
      }
    }
  }
}

is_valid_loadout_weapon(var_0) {
  var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");
  return isDefined(level._id_1A8F[var_0]);
}

_id_38C5() {
  foreach(var_14, var_1 in level._id_2A77) {
    if(isDefined(level._id_1A8F[var_1._id_232D])) {
      var_2 = var_1._id_5FFA;
      var_3 = level._id_2A95._id_2A65[var_14];
      var_4 = strtok(var_2, "+");
      var_5 = [];

      foreach(var_7 in level._id_1A8F[var_1._id_232D]) {
        if(var_7 == var_1._id_232D) {
          continue;
        }
        var_8 = level._id_1A90[var_1._id_232D][var_7] - 1;

        if(var_8 > var_3 && scripts\engine\utility::array_contains(var_4, var_7)) {
          var_5[var_5.size] = var_7;
        }
      }

      var_10 = var_1._id_5FFB;

      foreach(var_12 in var_5) {
        var_10 = var_10 _meth_866A(var_12);
      }

      level._id_2A77[var_14]._id_5FFB = var_10;
      level._id_2A77[var_14]._id_5FFA = getcompleteweaponname(var_10);
    }
  }
}

_id_6F09(var_0) {
  var_1 = self;
  var_2 = _func_0222(level._id_CAB4, 2, var_0, 11);
  var_3 = makeweaponfromstring(var_2);

  if(var_1 getweaponslistprimaries().size >= 2) {
    var_1 takeweapon(var_1 getcurrentprimaryweapon());
  }

  var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);
  var_4 = var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_3, 1);
  var_5 = getcompleteweaponname(var_3 _meth_8625());
  var_5 = scripts\mp\utility\script::_id_EA63(var_5, "_mp");
  var_1.mostrecentweaponpurchased = var_5;

  if(getdvarint("#x3166c31c346f72f7d", 1)) {
    var_1 setweaponammostock(var_3, var_3._id_0298);
  }

  if(!var_1 s4_base_has_used_weapon(var_0)) {
    var_1 s4_base_set_weapon_level(var_0, 0);
    var_1 scripts\mp\gametypes\s4_base_util::s4_baset_set_weapon_level_omnvars(var_0);
  }

  var_1 scripts\mp\gametypes\s4_base_util::_id_B61B();
  var_1 setclientomnvar("ui_base_equipped_loadout", -1);
}

_id_683A(var_0, var_1) {
  var_2 = getDvar("#x39a37f9ec09d582cc", "");

  if(var_2 != "" && isDefined(level._id_10CE3[var_2])) {
    return level._id_10CE3[var_2];
  }

  if(isDefined(var_1)) {
    if(!isDefined(var_1.weapons) || var_1.weapons.size == 0) {
      return undefined;
    }

    if(isDefined(var_1._id_338E) && var_1._id_338E != "") {
      var_3 = var_1._id_338E;
      var_1._id_338E = undefined;
      return level._id_10CE3[var_3];
    }

    if(isDefined(var_1.weapons)) {
      var_1._id_10DD8++;

      if(isDefined(var_1._id_9C5F) && var_1._id_9C5F != -1 && var_1._id_10DD8 >= var_1._id_9C5F) {
        return undefined;
      }

      var_4 = var_1.weapons[var_1._id_10DD0];
      var_1._id_10DD0++;

      if(var_1._id_10DD0 >= var_1.weapons.size) {
        var_1._id_10DD0 = 0;
      }

      return level._id_10CE3[var_4];
    }
  }

  return scripts\engine\utility::random(level._id_10CE3);
}

_id_1013(var_0) {
  if(!isDefined(self._id_7E9E)) {
    self._id_7E9E = [];
  }

  var_1 = 0;
  var_2 = [];

  for(var_3 = 0; var_3 < 8; var_3++) {
    var_4 = getDvar(_func_0483("#x34668a3291ada4a1d", scripts\engine\utility::_id_EA52(var_0), "_", scripts\engine\utility::_id_EA52(var_3 + 1)), "");

    if(var_4 != "") {
      if(!var_1) {
        var_2 = [];
        var_1 = 1;
      }

      var_2[var_2.size] = var_4;
    }
  }

  var_5 = getdvarint(_func_0483("#x34668a3291ada4a1d", scripts\engine\utility::_id_EA52(var_0), "_count"), -1);
  var_6 = getDvar(_func_0483("#x34668a3291ada4a1d", scripts\engine\utility::_id_EA52(var_0), "_center"), "");
  self._id_7E9E[var_0] = spawnStruct();
  self._id_7E9E[var_0].weapons = var_2;
  self._id_7E9E[var_0]._id_9C5F = var_5;
  self._id_7E9E[var_0]._id_338E = var_6;
  self._id_7E9E[var_0]._id_10DD8 = 0;
  self._id_7E9E[var_0]._id_10DD0 = 0;
}

_id_6856(var_0) {
  var_1 = spawnStruct();
  var_1.weapons = var_0.weapons;
  var_1._id_9C5F = var_0._id_9C5F;
  var_1._id_338E = var_0._id_338E;
  var_1._id_10DD8 = 0;
  var_1._id_10DD0 = 0;
  return var_1;
}

_id_B3F5() {
  var_0 = self;
  var_0 setclientomnvar("ui_base_purchase_menu_response", 2);
  var_0 setclientomnvar("ui_base_open_purchase_menu", 0);
}

_id_E1C0(var_0, var_1) {
  var_2 = self;
  var_3 = getgroundposition(var_2.origin + (0, 0, 12), 4) + (0, 0, 12);
  var_4 = 0;
  var_5 = [];
  var_6 = 32;
  var_7 = randomint(360);

  if(level.s4_base_loot_item_defs["groundLoot"].size == 0) {
    return;
  }
  var_8 = var_2 _id_6565();
  var_9 = 6;
  var_10 = 0;
  var_11 = [];

  for(var_12 = 0; var_12 < var_8.size; var_12++) {
    if(!isDefined(var_11[var_10])) {
      var_11[var_10] = [];
    }

    var_11[var_10][var_11[var_10].size] = var_8[var_12];

    if(var_11[var_10].size >= var_9) {
      var_10++;
    }
  }

  if(var_8.size > 0) {
    for(var_13 = 0; var_13 < var_11.size; var_13++) {
      var_14 = 360 / var_11[var_13].size;
      var_4 = var_13 * 32;

      foreach(var_12, var_16 in scripts\engine\utility::array_randomize(var_11[var_13])) {
        var_17 = (var_6 + var_4) * cos(var_14 * var_12 + var_7);
        var_18 = (var_6 + var_4) * sin(var_14 * var_12 + var_7);
        var_19 = 0;
        var_20 = var_3 + (var_17, var_18, var_19);

        if(var_16._id_989A == "weaponLoot") {
          _id_E184(_id_6739(var_16._id_CF25, scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_rarity_from_level(var_16._id_CF25, var_16.weaponlevel)), var_20, (0, randomint(360), 0), undefined, var_2, var_12);
          continue;
        }

        var_21 = undefined;

        if(!isDefined(var_1) || var_1 == self || !isDefined(var_1.pers) || !isDefined(var_1.pers["team"])) {
          var_21 = var_2.pers["team"];
        } else {
          var_21 = var_1.pers["team"];
        }

        _id_E184(var_16._id_CF25, var_20, (0, randomint(360), 0), var_21, var_2, var_12);
      }
    }
  }
}

_id_6565() {
  var_0 = self;
  var_1 = scripts\engine\utility::_id_1BD4(scripts\engine\utility::array_randomize(level.s4_base_loot_item_defs["groundLoot"]), 0, randomint(level.s4_base_loot_item_defs["groundLoot"].size + 1));

  if(var_1.size == 0) {
    var_1 = [scripts\engine\utility::random(level.s4_base_loot_item_defs["groundLoot"])];
  }

  return var_1;
}

_id_6739(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = ["epic", "lege"];
  }

  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");
  var_0 = "chloot_weapon_" + var_0 + "_" + scripts\engine\utility::random(var_1);
  return var_0;
}

_id_E184(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = (0, randomint(360), 0);
  }

  if(isDefined(var_3)) {
    var_6 = _func_0200(var_3) + 1;
  } else {
    var_6 = undefined;
  }

  if(isDefined(var_4)) {
    var_1 = var_4.origin;
    var_2 = scripts\engine\utility::_id_5CD9(var_4 getplayerangles());
  }

  if(should_adjust_drop_origin(var_0)) {
    if(isDefined(var_5)) {
      [var_1, var_2, var_8] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(var_5, var_1, var_2, var_4);
    } else {
      var_1 = scripts\engine\utility::_id_5000(var_1 + (0, 0, 8), 50, -200, (0, 0, 1)) + (0, 0, 12);
    }
  }

  var_9 = scripts\mp\gametypes\br_pickups::_id_E336(var_0, var_1, var_2, 0, 1, var_6);

  if(isDefined(var_3)) {
    var_9 thread scripts\mp\gametypes\s4_base_util::disablescriptableforotherteam(var_3);
  }

  return var_9;
}

should_adjust_drop_origin(var_0) {
  if(scripts\engine\utility::is_equal(var_0, "s4_base_loot_extra_life")) {
    return 0;
  }

  return 1;
}

_id_0C30(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_1AA4)) {
    var_1._id_1AA4 = [];
  }

  if(!isDefined(var_1._id_1AA4[var_0])) {
    var_1._id_1AA4[var_0] = 0;
  }
}

s4_base_has_used_weapon(var_0) {
  var_1 = self;

  if(!isDefined(var_1.arenaevousedweapons)) {
    return 0;
  }

  return isDefined(var_1.arenaevousedweapons[var_0]);
}

s4_base_set_weapon_level(var_0, var_1) {
  var_2 = self;
  var_2 _id_0C30(var_0);
  var_2._id_1AA4[var_0] = var_1;
  var_2.arenaevousedweapons[var_0] = 1;
}

_id_7DC6(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(var_1)) {
    var_3 s4_base_set_weapon_level(var_0, var_1);
  } else {
    var_3 s4_base_set_weapon_level(var_0, var_3 scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_0) + 1);
  }

  if(istrue(var_2)) {
    var_3 s4_base_set_weapon_level(var_0, 9);
  }

  var_3 scripts\mp\gametypes\s4_base_util::s4_baset_set_weapon_level_omnvars(var_0);
}

s4_base_upgrade_weapon(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = getweaponbasename(var_0);
  var_5 = 0;

  foreach(var_7 in var_3 getweaponslistprimaries()) {
    if(scripts\engine\utility::is_equal(getweaponbasename(var_7), var_4)) {
      var_3 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_7);
      var_5 = 1;
    }
  }

  var_3 _id_7DC6(var_4, var_1);

  if(var_5) {
    var_3 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
    var_9 = var_3 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
  }

  var_3 scripts\mp\gametypes\s4_base_util::_id_B61B();

  if(isDefined(var_2) && var_2 == 1) {
    var_10 = _func_00D6(var_4, 0, var_4.size - 3);
    var_11 = var_3 scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_4);
    var_12 = level._id_1A8F[var_10][var_11];
    var_13 = level._id_1A90[var_10][var_12];
    thread _id_0848::snd_mp_champ_hill_weapon_upgrade_sound(var_13, var_3);
  }
}

s4_base_add_kill_credit(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = getdvarint("#x37ce273a6e8e42cbd", 100);
  }

  if(!isDefined(var_0._id_8D70)) {
    var_0._id_8D70 = 0;
  }

  if(!isDefined(var_0._id_E772)) {
    var_0._id_E772 = 0;
  }

  var_0._id_8D70 = var_0._id_8D70 + var_1;
  var_0._id_E772 = var_0._id_E772 + var_1;

  if(!istrue(var_3)) {
    var_0 s4_base_player_check_upgrade_reminder();
  }

  if(istrue(var_4)) {
    var_0._id_8D70 = var_1;
  }

  if(isDefined(var_2)) {
    var_5 = 0;

    if(var_2 == "firstblood") {
      var_5 = 1;
      var_0 thread scripts\mp\hud_message::showsplash("firstblood");
    }

    var_0 thread _id_07CE::_id_8D83(var_2, var_5);
  }

  var_0 thread scripts\mp\rank::_id_CC13(var_1, 0);
  var_0 setclientomnvar("ui_base_current_cash", var_0._id_8D70);
  var_0 setclientomnvar("ui_arena_evo_stat_total_cash", var_0._id_E772);
}

_id_871F(var_0, var_1) {
  var_2 = getweaponbasename(var_1);
  var_3 = _func_00D6(var_2, 0, var_2.size - 3);

  if(!isDefined(level._id_1A8F[var_3])) {
    return 1;
  }

  var_4 = scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_2);

  if(var_4 >= level._id_1A8F[var_3].size - 1 || isDefined(level._id_1A8F[var_3][var_4 + 1]) && level._id_1A8F[var_3][var_4 + 1] == "none") {
    return 1;
  }

  return 0;
}

_id_AD46(var_0, var_1, var_2) {
  var_0 = self;
  var_3 = getweaponbasename(var_1);
  var_4 = var_0 scripts\mp\gametypes\s4_base_weapon_util::s4_base_player_has_weapon(var_1);

  if(getdvarint("#x373feb694bcb2309a", 1)) {
    var_5 = scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level_from_object(var_1);
    var_6 = 1;

    if(var_0 scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_3) < var_5) {
      var_7 = var_0 s4_base_get_weapon_upgrade_for_player(var_1, var_2, var_5);
    } else if(var_4 && !_id_871F(var_0, var_1)) {
      var_7 = var_0 s4_base_get_weapon_upgrade_for_player(var_1, var_2);
      var_5 = undefined;
    } else {
      var_7 = var_0 s4_base_get_weapon_for_player(var_1, var_2);
      var_6 = 0;
    }

    if(var_6) {
      if(isDefined(var_5)) {
        var_0 s4_base_upgrade_weapon(var_7, var_5);
      } else {
        var_0 s4_base_upgrade_weapon(var_7);
      }

      var_0._id_DCE5 = 1;
    } else
      var_0 scripts\mp\gametypes\s4_base_util::s4_baset_set_weapon_level_omnvars(var_3);
  } else
    var_7 = var_0 s4_base_get_weapon_for_player(var_1, var_2);

  var_0._id_1A88 = 1;
  return var_7;
}

_id_AD47(var_0, var_1) {
  var_0 = self;
  return _id_AD46(var_0, var_1, 1);
}

s4_base_spend_kill_credit(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_8D70)) {
    var_0._id_8D70 = 0;
  }

  var_1 = var_0 getcurrentprimaryweapon();
  var_2 = getweaponbasename(var_1);

  if(!isDefined(var_0._id_1AA4[var_2])) {
    return;
  }
  var_3 = var_0 scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_2);
  var_4 = getdvarint("#x384ad4c25068a990", 100) * (var_3 + 1);

  if(var_0._id_8D70 < var_4) {
    return;
  }
  var_5 = var_0 s4_base_get_weapon_upgrade_for_player(var_1, 0);

  if(!isDefined(var_5)) {
    return;
  }
  var_0 s4_base_upgrade_weapon(var_5, undefined, 1);
  var_0 s4_base_player_take_cash(var_4);
  var_0 s4_base_player_check_upgrade_reminder();
  var_6 = var_0 scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_2);

  if(isDefined(var_6)) {
    var_0 scripts\mp\hud_message::showsplash("weapon_upgrade", var_6);
  }
}

s4_base_player_can_afford_upgrade(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();
  var_2 = getweaponbasename(var_1);
  var_3 = _func_00D6(var_2, 0, var_2.size - 3);

  if(!isDefined(level._id_1A8F) || !isDefined(level._id_1A8F[var_3])) {
    return 0;
  }

  var_4 = var_0 scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_2);
  var_5 = getdvarint("#x384ad4c25068a990", 100) * (var_4 + 1);
  return var_4 < level._id_1A8F[var_3].size - 1 && var_0._id_8D70 >= var_5;
}

s4_base_player_check_upgrade_reminder() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }
  if(!istrue(level._id_BB9D)) {
    return;
  }
  var_1 = s4_base_player_can_afford_upgrade(var_0);

  if(!istrue(var_0._id_C330) && var_1) {
    var_0._id_C330 = 1;
    var_0 thread scripts\mp\gametypes\arena_evo_tourney::_id_1AFC();
  } else if(istrue(var_0._id_C330) && !var_1) {
    var_0._id_C330 = 0;
    var_0 setclientomnvar("ui_arena_remind_upgrades", 0);
    var_0 notify("noLongerAffordUpgrade");
  }
}

s4_base_player_take_cash(var_0) {
  var_1 = self;
  var_1._id_8D70 = var_1._id_8D70 - var_0;
  var_1 setclientomnvar("ui_base_current_cash", var_1._id_8D70);
}

s4_base_get_player_cash() {
  var_0 = self;

  if(!isDefined(var_0._id_8D70)) {
    var_0._id_8D70 = 0;
  }

  return var_0._id_8D70;
}

s4_base_get_weapon_for_player(var_0, var_1) {
  var_2 = self;
  var_3 = getweaponbasename(var_0);
  var_4 = _func_00D6(var_3, 0, var_3.size - 3);
  var_5 = [];

  if(!istrue(var_1)) {
    if(var_2 s4_base_has_used_weapon(var_3)) {
      for(var_6 = 0; var_6 < level._id_1A8F[var_4].size; var_6++) {
        var_7 = level._id_1A8F[var_4][var_6 + 1];

        if(!isDefined(var_7) || var_7 == "none") {
          break;
        }

        var_5[var_5.size] = var_7;
      }
    }
  }

  var_8 = scripts\mp\class::buildweapon(var_4, var_5, "none", "none", -1);
  return var_8;
}

s4_base_get_weapon_upgrade_for_player(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = getweaponbasename(var_0);
  var_5 = scripts\mp\utility\script::_id_EA63(var_4, "_mp");

  if(!isDefined(level._id_1A8F[var_5])) {
    return;
  }
  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = var_3 scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_4) + 1;
  }

  if(_id_871F(var_3, var_0) && !istrue(level._id_5BB5)) {
    level._id_5BB5 = 1;
    var_3 thread _id_0A8D::_id_9137("first_legendary");
  }

  if(var_6 > level._id_1A8F[var_5].size) {
    var_6 = level._id_1A8F[var_5].size;
  }

  var_7 = [];

  if(!istrue(var_1)) {
    for(var_8 = 0; var_8 < var_6; var_8++) {
      var_9 = level._id_1A8F[var_5][var_8 + 1];

      if(!isDefined(var_9) || var_9 == "none") {
        return undefined;
      }

      var_7[var_7.size] = var_9;
    }
  }

  var_10 = scripts\mp\class::buildweapon(var_5, var_7, "none", "none", -1);
  return var_10;
}

_id_AD3D(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4._id_1A7E)) {
    var_5 = strtok(getDvar("scr_base_default_loadout", "s4_ar_stango44_mp,s4_pi_ttango33_mp"), ",");
    var_6 = scripts\mp\utility\script::_id_EA63(var_5[0], "_mp");
    var_7 = scripts\mp\utility\script::_id_EA63(var_5[1], "_mp");
    var_4 _id_D160(var_6, "arena_evo_loadout_override_primary");
    var_4 _id_D160(var_7, "arena_evo_loadout_override_secondary");
    var_4 _id_D160("equip_frag", "arena_evo_loadout_override_equipment_primary");
    var_4 _id_D160("none", "arena_evo_loadout_override_equipment_secondary");
  }

  var_8 = _id_6365("arena_evo_loadout_override_primary");
  var_9 = _id_6365("arena_evo_loadout_override_secondary");
  var_0._id_9683 = scripts\mp\utility\weapon::getweaponrootname(var_8);
  var_0._id_9692 = scripts\mp\utility\weapon::getweaponrootname(var_9);

  if(!isDefined(var_0._id_9685)) {
    var_0._id_9685 = [];
  }

  if(!isDefined(var_0._id_9694)) {
    var_0._id_9694 = [];
  }

  if(var_0._id_9683 != "none" && var_0._id_9685.size <= 0) {
    var_10 = var_0._id_9683 + "_mp";
    var_11 = _func_0222("mp/s4baseKioskPurchases.csv", 2, var_10, 11);

    if(var_11 != "") {
      var_0._id_9685 = var_4 _id_656E(var_0._id_9683);
    }
  }

  if(var_0._id_9692 != "none" && var_0._id_9694.size <= 0) {
    var_10 = var_0._id_9692 + "_mp";
    var_11 = _func_0222("mp/s4baseKioskPurchases.csv", 2, var_10, 11);

    if(var_11 != "") {
      var_0._id_9694 = var_4 _id_656E(var_0._id_9692);
    }
  }

  var_0._id_966A = _id_6365("arena_evo_loadout_override_equipment_primary");
  var_0._id_966B = _id_6365("arena_evo_loadout_override_equipment_secondary");

  if(istrue(var_2)) {
    var_4 scripts\mp\class::_id_964E(var_0, var_3);
  }

  var_4 _id_9641(var_0);
}

override_loadout_updateclassdefault_equipment(var_0, var_1) {
  var_2 = self;
  var_0._id_966A = _id_6365("arena_evo_loadout_override_equipment_primary");
  var_0._id_966E = 0;
  var_0._id_966B = _id_6365("arena_evo_loadout_override_equipment_secondary");
  var_0._id_966F = 0;

  if(!isDefined(var_0._id_966A) || !isDefined(var_0._id_966B)) {
    [var_0._id_966A, var_0._id_966B] = get_default_equipment();
  }

  var_2 scripts\mp\class::_id_964E(var_0);
}

get_default_equipment() {
  return ["equip_frag", "none"];
}

_id_9641(var_0) {
  var_0._id_968A = scripts\mp\class::buildweapon(var_0._id_9683, var_0._id_9685, var_0._id_9686, var_0._id_968C, var_0._id_968E, var_0._id_9684, var_0._id_9687, var_0._id_968D);
  var_0._id_9688 = getcompleteweaponname(var_0._id_968A);

  if(var_0._id_9692 == "none") {
    var_0._id_9699 = undefined;
    var_0._id_9697 = "none";
  } else {
    var_0._id_9699 = scripts\mp\class::buildweapon(var_0._id_9692, var_0._id_9694, var_0._id_9695, var_0._id_969A, var_0._id_969C, var_0._id_9693, var_0._id_9696, var_0._id_969B);
    var_0._id_9697 = getcompleteweaponname(var_0._id_9699);
  }

  if(var_0._id_967D != "none") {
    self giveweapon(var_0._id_967D);
    self _meth_8514(var_0._id_967D);
  }
}

_id_656E(var_0) {
  var_1 = self;
  var_2 = var_0 + "_mp";
  var_3 = _func_0222("mp/s4baseKioskPurchases.csv", 2, var_2, 11);
  var_4 = strtok(var_3, "+");
  var_4 = scripts\engine\utility::array_remove(var_4, "");
  var_4 = scripts\engine\utility::array_remove(var_4, var_2);
  var_4 = scripts\engine\utility::array_remove(var_4, "loot0");
  var_5 = scripts\mp\class::buildweapon(var_0, var_4, "none", "none");
  return getweaponattachments(var_5);
}

_id_8629(var_0) {
  return scripts\engine\utility::is_equal(var_0, "loadouts") || scripts\engine\utility::is_equal(var_0, "glide_bomb") || scripts\engine\utility::is_equal(var_0, "precision_airstrike") || scripts\engine\utility::is_equal(var_0, "s4_la_walpha2_mp") || scripts\engine\utility::is_equal(var_0, "white_phosphorus");
}

_id_314F(var_0) {
  var_1 = self;

  if(var_0._id_C189 == "flamethrower" && !var_1 _id_0A50::jugg_arena_evo_canpurchasejuggernaut()) {
    return 0;
  }

  if(var_0._id_C189 == "uav" && !var_1 s4_base_player_can_purchase_uav()) {
    return 0;
  }

  if(!isDefined(var_1._id_A4AC)) {
    return 1;
  }

  foreach(var_3 in var_1._id_A4AC) {
    var_4 = level.s4_base_loot_item_defs[var_3._id_AE40];

    if(_id_8629(var_4._id_CF25) && _id_8629(var_0._id_C189)) {
      return 0;
    }
  }

  return 1;
}

s4_base_at_max_flamenauts() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 scripts\mp\gametypes\arena_evo_tourney_loot::playerhasitem("flamethrower")) {
      var_0++;
    }
  }

  return var_0 >= s4_base_max_flamethrowers();
}

s4_base_max_flamethrowers() {
  return getdvarint("#x3c3f262aaeffd6a86", 4);
}

s4_base_player_can_purchase_uav() {
  return !s4_base_at_max_uavs(self.pers["team"]);
}

s4_base_at_max_uavs(var_0) {
  var_1 = s4_base_get_item_count_for_team(var_0, "uav");
  return var_1 >= s4_base_max_uavs();
}

s4_base_max_uavs() {
  return getdvarint("#x399052d57f61f5031", 3);
}

s4_base_get_item_count_for_team(var_0, var_1) {
  if(!isDefined(level.arena_evo_team_activate_funcs)) {
    return 0;
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0])) {
    return 0;
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0]._id_A4AC)) {
    return 0;
  }

  if(!isDefined(level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_1])) {
    return 0;
  }

  return level.arena_evo_team_activate_funcs[var_0]._id_A4AC[var_1]._id_011A;
}

is_enemy_base(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_14F5) {
    if(var_0 istouching(var_3.trigger)) {
      var_1 = var_3;
      break;
    }
  }

  var_5 = var_1.trigger._id_60D8;

  if(var_5._id_ADAE == var_0.team) {
    return 0;
  } else {
    return 1;
  }
}
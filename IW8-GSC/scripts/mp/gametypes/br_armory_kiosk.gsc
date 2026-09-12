/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armory_kiosk.gsc
****************************************************/

function init() {
  level.br_armory_kiosk = spawnStruct();
  level.br_armory_kiosk.scriptables = [];
  level.br_armory_kiosk_enabled = getdvarint("scr_br_armory_kiosk", 1) != 0;
  level.delay_put_vehicles_on_compass = getdvarint("scr_loadout_purchase_restricted", 0);
  level.br_armory_kiosk_close_menu_fix = getdvarint("scr_br_armory_kiosk_close_menu_fix", 1);
  level.br_armory_kiosk_close_menu_timeout = getdvarfloat("scr_br_armory_kiosk_close_menu_timeout", 0.5);

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("kiosk")) {
    level.br_armory_kiosk_enabled = 0;
    return;
  }

  if(level.br_armory_kiosk_enabled) {
    scripts\engine\scriptable::ref_12F5B("br_plunder_box", &armorykioskused);
    scripts\engine\scriptable::ref_12F5B("br_portable_kiosk", &armorykioskused);
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&onarmorykioskpurchase);
    allassassin_applyquest();
    _parsepurchaseitemtables();
    thread apc_shoot_at_target();
  }

  scripts\mp\gametypes\br_gametypes::ref_12B11("getIdFromRefInPurchaseTable", &_getidfromref);
  scripts\mp\gametypes\br_gametypes::ref_12B11("getScriptedDiscountId", &callback_getscripteddiscountid);
  scripts\mp\gametypes\br_gametypes::ref_12B11("setScriptedDiscountId", &callback_setscripteddiscountid);
}

function all_waves() {
  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
    setDvar("br_kiosk_ignored_tab_nums", "2,5");
    return;
  }

  setDvar("br_kiosk_ignored_tab_nums", "3,4,5");
}

function allassassin_applyquest() {
  var_0 = getdvarint("br_kiosk_sales_discount", 0);
  level.br_armory_kiosk.ref_12E7B = int(clamp(var_0, 0, 100));
  var_1 = getDvar("br_kiosk_sales_discount_items", "");
  level.br_armory_kiosk.ref_12E7C = strtok(var_1, ",");
  var_2 = 20;
  var_3 = level.br_armory_kiosk.ref_12E7B % var_2;

  if(var_3 > 0) {
    var_4 = int(floor(level.br_armory_kiosk.ref_12E7B / var_2) * var_2);
    var_5 = var_3 / var_2 >= 0.5;

    if(var_5) {
      var_4 += var_2;
    }

    level.br_armory_kiosk.ref_12E7B = int(var_4);
  }

  if(var_0 != level.br_armory_kiosk.ref_12E7B) {
    setDvar("br_kiosk_sales_discount", level.br_armory_kiosk.ref_12E7B);
    return;
  }
}

function add_collision_to_hack_point(var_0, var_1) {
  if(!isDefined(var_1) || var_1 == 0) {
    return var_0;
  } else if(var_1 == 100) {
    return 0;
  }

  var_2 = (100 - var_1) * 0.01;
  return int(ceil(var_0 * var_2 - 0.5));
}

function _parsepurchaseitemtables() {
  var_0 = getDvar("br_kiosk_items_filename", "mp/brKioskPurchases.csv");

  if(var_0 == "") {
    var_0 = "mp/brKioskPurchases.csv";
  }

  if(getdvarint("scr_br_alt_mode_ff", 0) == 1) {
    if(getdvarint("scr_br_ff_buyback", 0) == 1 || getdvarint("scr_br_ff_killstreaks", 0) == 1) {
      level.dialog_wait_ready_civ = 7;
    }
  }

  level.br_armory_kiosk.items = [];
  var_1 = tablelookupgetnumrows(var_0);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = int(tablelookupbyrow(var_0, var_2, 0));
    var_4 = spawnStruct();
    var_4.type = tablelookupbyrow(var_0, var_2, 1);
    var_4.ref = tablelookupbyrow(var_0, var_2, 2);
    var_4.cost = int(tablelookupbyrow(var_0, var_2, 3));
    var_4.playboxuseanimation = int(tablelookupbyrow(var_0, var_2, 9));
    var_4.ref_122FC = int(tablelookupbyrow(var_0, var_2, 10));
    var_4.circlediscount = int(tablelookupbyrow(var_0, var_2, 12));

    if(var_4.ref == "supply_drop") {
      var_5 = getdvarint("scr_br_kiosk_supdropcost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(var_4.ref == "specialist_perk") {
      var_6 = getdvarint("scr_br_kiosk_specialistcost", 500);

      if(var_6 != 0) {
        var_4.cost = var_6;
      }
    }

    if(var_4.ref == "vehicle_refill_trophy") {
      var_5 = getdvarint("scr_br_kiosk_truckwar_refill_trophy_cost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(var_4.ref == "vehicle_repair") {
      var_5 = getdvarint("scr_br_kiosk_truckwar_repair_cost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(var_4.ref == "vehicle_replace") {
      var_5 = getdvarint("scr_br_kiosk_truckwar_replace_cost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(var_4.ref == "vehicle_upgrade_armor") {
      var_5 = getdvarint("scr_br_kiosk_truckwar_armor_cost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(var_4.ref == "vehicle_upgrade_trophy") {
      var_5 = getdvarint("scr_br_kiosk_truckwar_trophy_cost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(var_4.ref == "vehicle_upgrade_uav") {
      var_5 = getdvarint("scr_br_kiosk_truckwar_uav_cost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(var_4.ref == "vehicle_upgrade_barrel") {
      var_5 = getdvarint("scr_br_kiosk_truckwar_barrel_cost", 0);

      if(var_5 != 0) {
        var_4.cost = var_5;
      }
    }

    if(level.br_armory_kiosk.ref_12E7B > 0) {
      var_7 = level.br_armory_kiosk.ref_12E7C.size == 0 || scripts\engine\utility::array_contains(level.br_armory_kiosk.ref_12E7C, var_4.ref);

      if(var_7) {
        var_4.cost = add_collision_to_hack_point(var_4.cost, level.br_armory_kiosk.ref_12E7B);
      }
    }

    if(var_4.type == "loadout_default") {
      level.br_armory_kiosk.ref_11958 = var_4.cost;
      level.br_armory_kiosk.ref_11959 = var_4.playboxuseanimation;
      level.br_armory_kiosk.ref_1195A = var_4.ref_122FC;
      continue;
    }

    if(var_4.type == "loadout_custom") {
      level.br_armory_kiosk.ref_11955 = var_4.cost;
      level.br_armory_kiosk.ref_11956 = var_4.playboxuseanimation;
      level.br_armory_kiosk.ref_11957 = var_4.ref_122FC;
      continue;
    }

    if(var_4.type == "teamrevive") {
      level.br_armory_kiosk.ref_13AC2 = var_4.cost;
      level.br_armory_kiosk.ref_13AC3 = var_4.playboxuseanimation;
      level.br_armory_kiosk.ref_13AC4 = var_4.ref_122FC;
      continue;
    }

    level.br_armory_kiosk.items[var_3] = var_4;
  }
}

function ai_push_to_position(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [scripts\engine\utility::ter_op(isDefined(var_6), var_6, 0), scripts\engine\utility::ter_op(var_2, var_3, 0), scripts\engine\utility::ter_op(var_4, var_5, 0)];
  var_8 = _getbestdiscount(var_7);
  var_9 = add_collision_to_hack_point(var_1, var_8);

  if(isDefined(var_0) && var_0.ref == "supply_drop" && getdvarint("br_use_circle_percent_discount", 0) == 1) {
    var_10 = getomnvar("ui_br_circle_num") - 1;

    if(var_10 >= 1) {
      var_11 = var_0.circlediscount;

      if(var_11 > 0) {
        var_11 *= var_10;
        var_9 = add_collision_to_hack_point(var_9, var_11);
      }
    }
  }

  return var_9;
}

function _getbestdiscount(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3 > var_1) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function apc_shoot_at_target() {
  level endon("game_ended");
  setdvarifuninitialized("scr_br_disable_kiosk_by_circle", 0);

  for(;;) {
    level waittill("br_circle_set");
    var_0 = getdvarint("scr_br_disable_kiosk_by_circle", 0);

    if(var_0 == 0) {
      continue;
    }

    if(level.br_circle.circleindex + 1 >= var_0) {
      little_bird_mg_initomnvars();

      foreach(var_2 in level.players) {
        if(!isDefined(var_2) || !isalive(var_2)) {
          continue;
        }

        var_2 thread scripts\mp\hud_message::showsplash("br_kiosks_disabled");
      }

      break;
    }
  }
}

function ref_1334A(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  level endon("game_ended");

  if(istrue(var_1.shoulddopublicevent)) {
    return;
  }

  if(!isDefined(level.br_armory_kiosk.ref_12E7B)) {
    return;
  }

  if(level.br_armory_kiosk.ref_12E7B == 0) {
    return;
  }

  var_1.shoulddopublicevent = 1;

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  if(level.br_armory_kiosk.ref_12E7C.size == 0) {
    var_1 thread scripts\mp\hud_message::showsplash("br_sales_event_all");
    return;
  }

  var_1 thread scripts\mp\hud_message::showsplash("br_sales_event_selective");
}

function onprematchdone() {
  if(level.delay_put_vehicles_on_compass) {
    ref_13169("supply_drop", 1);
    level.ref_12931 = "br_pe_loadout_drop_start";
  }

  foreach(var_1 in level.br_armory_kiosk.scriptables) {
    var_1 setscriptablepartstate("br_plunder_box", "visible");
    var_1.visible = 1;
  }
}

function dangercircletick(var_0, var_1) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("kiosk") || getdvarint("scr_br_kiosk_ignore_circle", 0) == 1) {
    return;
  }

  var_2 = var_1 * var_1;

  foreach(var_4 in level.br_armory_kiosk.scriptables) {
    if(isDefined(var_4.visible) && distance2dsquared(var_4.origin, var_0) > var_2) {
      little_bird_mg_mp_initmines(var_4);
    }
  }
}

function little_bird_mg_initomnvars() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("kiosk")) {
    return;
  }

  foreach(var_1 in level.br_armory_kiosk.scriptables) {
    if(isDefined(var_1.visible)) {
      little_bird_mg_mp_initmines(var_1);
    }
  }
}

function little_bird_mg_mp_initmines(var_0) {
  var_0 setscriptablepartstate("br_plunder_box", "disabled");
  var_0.visible = undefined;
  var_0.disabled = 1;
  var_0 notify("kiosk_disabled");

  if(var_0 scripts\mp\gametypes\br_quest_util::gethelispawns()) {
    var_0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
    return;
  }
}

function registeraccesscardlocs() {
  if(!level.br_armory_kiosk_enabled) {
    return;
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("placedKiosks"))) {
    return;
  }

  var_0 = getentitylessscriptablearrayinradius("scriptable_br_plunder_box", "classname");
  return var_0;
}

function relic_bang_and_boom_wait_for_pickup(var_0) {
  var_1 = level.br_armory_kiosk.scriptables;
  var_2 = 1e+12;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!istrue(var_5.disabled)) {
      var_6 = distance2dsquared(var_0, var_5.origin);

      if(var_6 < var_2) {
        var_3 = var_5;
        var_2 = var_6;
      }
    }
  }

  return var_3;
}

function ref_131C0(var_0) {
  level.br_armory_kiosk.scriptables = var_0;
}

function armorykioskused(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.gameended)) {
    return;
  }

  if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_3.inlaststand)) {
    return;
  }

  if(var_3 scripts\cp_mp\utility\player_utility::isusingremote()) {
    return;
  }

  if(var_3 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return;
  }

  if(istrue(var_3 scripts\mp\gametypes\br_gametypes::ref_12E05("playerSkipKioskUse", var_0))) {
    return;
  }

  if(istrue(var_3.iscarrying) && !isDefined(var_3.get_search_turret_target_player)) {
    var_3 scripts\mp\hud_message::showerrormessage("MP/FIELD_UPGRADE_CANNOT_USE");
    return;
  }

  if(istrue(var_3.tracking_max_health)) {
    var_3 notify("br_try_armor_cancel");
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_120A8("kiosk");

  if(var_2 == "visible") {
    if(var_0.type != "br_portable_kiosk") {
      var_0 setscriptablepartstate("br_plunder_box", "opening");
    }

    thread wait_for_anyone_nearby_hint();
    thread _runpurchasemenu(var_3);
    return;
  }

  if(var_2 == "opening" || var_2 == "open") {
    thread _runpurchasemenu(var_3);
    return;
  }
}

function wait_for_anyone_nearby_hint() {
  if(!getdvarint("scr_br_kiosk_fix_prone_players", 1)) {
    return;
  }

  var_0 = getdvarfloat("scr_br_kiosk_fix_prone_players_radius", 300);
  scripts\mp\gametypes\br_functional_poi::player_give_intel_1_ks(var_0);
}

function wait_for_enemies_inarea(var_0, var_1) {
  if(!isDefined(var_0.playdeathanim_groundturret)) {
    var_0.playdeathanim_groundturret = [var_1];
  } else if(!scripts\engine\utility::array_contains(var_0.playdeathanim_groundturret, var_1)) {
    var_0.playdeathanim_groundturret = scripts\engine\utility::array_add(var_0.playdeathanim_groundturret, var_1);
  }

  if(!var_0 scripts\mp\gametypes\br_quest_util::gethelispawns()) {
    var_0 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", var_0.origin);
  }

  var_0 scripts\mp\gametypes\br_quest_util::ref_1336C(var_1);
}

function unstable_gauge_timer_active(var_0, var_1) {
  if(scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(2)) {
    return 1;
  }

  if(!isDefined(var_0) || !isDefined(var_0.playdeathanim_groundturret)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(var_0.playdeathanim_groundturret, var_1);
}

function wait_for_all_traps_disabled(var_0, var_1) {
  if(!isDefined(var_0.playdeathanim_groundturret)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_1);
  var_0.playdeathanim_groundturret = scripts\engine\utility::array_remove(var_0.playdeathanim_groundturret, var_1);
}

function removefromdismembermentlist() {
  return 180 + randomfloatrange(-10, 10);
}

function ref_13169(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_4 = "ui_br_kiosk_ban_" + var_0;

    if(var_4 == "ui_br_kiosk_ban_supply_drop") {
      var_5 = scripts\engine\utility::ter_op(var_1, 1, 0);
      ref_1260D(var_3, var_4, var_5, 0, 1);
      continue;
    }

    var_3 setclientomnvar(var_4, var_1);
  }
}

function _runpurchasemenu(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 endon("death");
  var_2.delay_kick_inactive_player = var_0;

  if(scripts\mp\gametypes\br_public::tutorial_playSound()) {
    var_2 notify("kiosk_used");
  }

  var_3 = unstable_gauge_timer_active(var_0, var_2);
  var_4 = var_2 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
  applyscripteddiscounts(var_2);

  if(istrue(var_1)) {
    var_3 = 0;
    var_4 = 0;
  }

  if(isDefined(level.dialog_wait_ready_civ) && !istrue(var_2.delete_silo_lights)) {
    var_2 setclientomnvar("ui_br_purchase_file_override", level.dialog_wait_ready_civ);
  }

  var_2 setclientomnvar("ui_br_purchase_killstreak_response", 0);

  if(var_3) {
    var_2 setclientomnvar("ui_br_open_purchase_killstreak", 2);
  } else if(var_4) {
    var_2 setclientomnvar("ui_br_open_purchase_killstreak", 3);
  } else {
    var_2 setclientomnvar("ui_br_open_purchase_killstreak", 1);
  }

  var_2.armorykioskpurchaseallowed = 1;
  scripts\mp\gametypes\br_analytics::destructable_car(var_2, "menu_open");
  thread apc_target_enemies(var_2);
  var_2 setsoundsubmix("iw8_br_plunder_kiosk_menu");
}

function addtop3brcharge(var_0) {
  var_1 = self;
  var_1 setclientomnvar("ui_br_purchase_killstreak_response", var_0);
  var_1 setclientomnvar("ui_br_open_purchase_killstreak", 0);
  var_1 setclientomnvar("ui_br_purchase_file_override", -1);
  var_1 clearsoundsubmix("iw8_br_plunder_kiosk_menu");
  scripts\cp_mp\vehicles\vehicle_interact::ref_141A8(var_1.ref_1424D, var_1);
  var_1.delay_kick_inactive_player = undefined;
  var_1.delete_silo_lights = undefined;
  var_1.ref_1424D = undefined;
  var_1.armorykioskpurchaseallowed = undefined;
  var_1 notify("purchase_menu_closed", var_0);
  scripts\mp\gametypes\br_analytics::destructable_car(var_1, "menu_close", "reason: " + var_0);
}

function ally_charge_dialogue(var_0) {
  addtop3brcharge(var_0, 0);
  var_0 notify("_watchToAutoCloseMenu_end");
}

function apc_target_enemies(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 notify("_watchToAutoCloseMenu_end");
  var_1 endon("_watchToAutoCloseMenu_end");
  GscBinSkip4(0x6e, var_1, var_0);
}

function ally1_intro_dialogue(var_0) {
  var_1 = self;
  var_2 = 64;
  var_3 = getdvarfloat("player_itemUseRadius", 128) + var_2;
  var_4 = var_3 * var_3;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_1) || !isDefined(var_0)) {
      break;
    }

    var_5 = distancesquared(var_1.origin, var_0.origin);

    if(isDefined(var_5) && var_5 > var_4) {
      var_1 notify("pushed_too_far");
      break;
    }
  }
}

function ai_rush_players_thread(var_0) {
  var_1 = self;

  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = var_1 scripts\mp\equipment::getequipmentammo(var_0);
  var_3 = var_1 scripts\mp\equipment::getequipmentmaxammo(var_0);
  return max(0, var_3 - var_2);
}

function allowattackfromexposednonode(var_0) {
  var_1 = self;

  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = var_1 scripts\mp\equipment::getequipmentammo(var_0);
  var_3 = var_1 scripts\mp\equipment::getequipmentmaxammo(var_0);

  if(var_2 < var_3) {
    var_1 scripts\mp\equipment::setequipmentammo(var_0, var_3);
    return;
  }
}

function ai_molotov_swap(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 scripts\mp\equipment::getequipmentslotammo("health");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = var_2 scripts\mp\equipment::getequipmentmaxammo("equip_armorplate");

  if(getdvarint("scr_br_alt_mode_gg", 0)) {
    var_5 = 2;
  } else {
    var_5 = 5;
  }

  var_6 = int(clamp(var_5, 0, var_5 - var_4));
  var_7 = var_5 - var_6;

  if(var_7 > 0 && !istrue(var_2)) {
    var_8 = undefined;

    if(istrue(var_1)) {
      var_8 = removefromdismembermentlist();
    }

    var_9 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var_10 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_9, var_3.origin, var_3.angles, var_3, var_8);
    scripts\mp\gametypes\br_pickups::spawnpickup("brloot_armor_plate", var_10, var_7, 1);
  }

  return var_6;
}

function apc_rus_initdamage(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = getbestscripteddiscount(var_0.ref);
  var_5 = unstable_gauge_timer_active(var_3.delay_kick_inactive_player, var_3);
  var_6 = var_3 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
  var_7 = ai_push_to_position(var_0, var_0.cost, var_5, var_0.playboxuseanimation, var_6, var_0.ref_122FC, var_4);

  if(!isDefined(var_3.plundercount)) {
    var_3.plundercount = 0;
  }

  if(var_3.plundercount < var_7) {
    addtop3brcharge(var_3, 3);
    return false;
  }

  if(var_0.type == "killstreak") {
    if(var_0.ref == "juggernaut") {
      if(var_3 scripts\mp\utility\killstreak::isjuggernaut()) {
        addtop3brcharge(var_3, 4);
        return false;
      } else if(var_3 scripts\mp\juggernaut::changecirclestateatlowtime()) {
        addtop3brcharge(var_3, 27);
        return false;
      }
    }

    if(!istrue(var_1)) {
      if(var_3 scripts\mp\gametypes\br_pickups::haskillstreak(var_0.ref)) {
        addtop3brcharge(var_3, 4);
        return false;
      }
    }
  } else if(var_0.type == "fieldupgrade") {
    if(var_3 scripts\mp\supers::issuperinuse()) {
      addtop3brcharge(var_3, 6);
      return false;
    }

    if(!istrue(var_1)) {
      var_8 = var_3 scripts\mp\supers::getcurrentsuperref();

      if(isDefined(var_8) && var_0.ref == var_8) {
        addtop3brcharge(var_3, 5);
        return false;
      }
    }
  } else if(var_0.type == "special") {
    switch (var_0.ref) {
      case "armor_bundle":
      case "armor":
        break;
      case "gas_mask":
        if(istrue(var_2)) {
          return true;
        }

        var_9 = spawnStruct();
        var_9.scriptablename = "brloot_equip_gasmask";
        var_10 = scripts\mp\gametypes\br_pickups::cantakepickup(var_9);
        break;
      case "gas_mask_durable":
        if(istrue(var_2)) {
          return true;
        }

        var_9 = spawnStruct();
        var_9.scriptablename = "brloot_equip_gasmask_durable";
        var_10 = scripts\mp\gametypes\br_pickups::cantakepickup(var_9);
        break;
      case "ammo_refill":
        if(istrue(var_2)) {
          return true;
        }

        var_11 = 0;

        if(ai_rush_players_thread(var_3, var_3.equipment["primary"]) > 0) {
          var_11 = 1;
        } else if(ai_rush_players_thread(var_3, var_3.equipment["secondary"]) > 0) {
          var_11 = 1;
        } else if(!var_3 scripts\mp\gametypes\br_weapons::debug_spawnallaccesscards()) {
          var_11 = 1;
        }

        if(!var_11) {
          addtop3brcharge(var_3, 8);
          return false;
        }

        break;
      case "respawn_token":
        if(scripts\mp\gametypes\br_pickups::ref_12CB6()) {
          addtop3brcharge(var_3, 9);
          return false;
        }

        if(istrue(var_2)) {
          return true;
        }

        if(istrue(var_3.hasrespawntoken)) {
          addtop3brcharge(var_3, 10);
          return false;
        }

        break;
      case "self_revive_token":
        if(var_3 scripts\mp\utility\killstreak::isjuggernaut()) {
          addtop3brcharge(var_3, 24);
          return false;
        }

        if(istrue(var_2)) {
          return true;
        }

        if(var_3 scripts\mp\gametypes\br_public::shouldgetnewspawnpoint()) {
          addtop3brcharge(var_3, 10);
          return false;
        }

        break;
      case "supply_drop":
        if(istrue(var_2)) {
          return true;
        }

        var_9 = spawnStruct();
        var_9.scriptablename = "brloot_offhand_advancedsupplydrop";
        var_9.count = 1;
        var_10 = scripts\mp\gametypes\br_pickups::cantakepickup(var_9);

        if(var_10 != 1) {
          addtop3brcharge(var_3, 7);
          return false;
        }

        break;
      case "circle_pick":
        if(isDefined(level.br_circle)) {
          addtop3brcharge(var_3, 17);
          return false;
        }

        break;
      case "redeploy":
        if(!istrue(level.brking_initdialog) && (isDefined(level.br_circle) || istrue(level.disable_super_in_turret.gulagfixuparena))) {
          addtop3brcharge(var_3, 9);
          return false;
        }

        break;
      case "vehicle_repair":
        if(!addspecialistbonuspickup(var_3)) {
          addtop3brcharge(var_3, 21);
          return false;
        }

        break;
      case "vehicle_upgrade_armor":
        if(!addteabagcharge(var_3, "armor")) {
          addtop3brcharge(var_3, 20);
          return false;
        }

        break;
      case "vehicle_refill_trophy":
        if(!addtenkillcharge(var_3)) {
          addtop3brcharge(var_3, 19);
          return false;
        }

        break;
      case "vehicle_upgrade_trophy":
        if(!addteabagcharge(var_3, "trophy")) {
          addtop3brcharge(var_3, 20);
          return false;
        }

        break;
      case "vehicle_upgrade_uav":
        if(!addteabagcharge(var_3, "uav")) {
          addtop3brcharge(var_3, 20);
          return false;
        }

        break;
      case "vehicle_upgrade_barrel":
        if(!addteabagcharge(var_3, "barrel")) {
          addtop3brcharge(var_3, 20);
          return false;
        }

        break;
      case "vehicle_replace":
        if(var_3 scripts\mp\supers::issuperinuse()) {
          addtop3brcharge(var_3, 6);
          return false;
        }

        if(announcedomplatespawns(var_3)) {
          addtop3brcharge(var_3, 23);
          return false;
        }

        if(!addspecialistdialog(var_3)) {
          addtop3brcharge(var_3, 22);
          return false;
        }

        break;
      case "specialist_perk":
        if(var_3 scripts\mp\gametypes\br_public::shouldlink()) {
          addtop3brcharge(var_3, 26);
          return false;
        }

        break;
    }
  }

  return true;
}

function allow_ascender_use(var_0) {
  switch (var_0) {
    case "toma_strike":
    case "precision_airstrike":
      return 1;
    case "uav":
      return 0;
    case "juggernaut":
      return 0;
    default:
      return 0;
  }
}

function allow_deleteme_path() {
  var_0 = self;
  scripts\engine\utility::waittill_any_ents(var_0, "death", level, "game_ended");
  var_0 notify("cancel_location");
}

function _preventrepeatingsplash(var_0) {
  var_1 = "NewLimitedSplash" + var_0;
  self notify(var_1);
  self endon(var_1);
  self.limitedsplashref = var_0;
  wait 2;
  self.limitedsplashref = undefined;
}

function _showsplashlimited(var_0) {
  var_1 = isDefined(self.limitedsplashref) && self.limitedsplashref == var_0;
  thread _preventrepeatingsplash(var_0);

  if(var_1) {
    return;
  }

  thread scripts\mp\hud_message::showsplash(var_0);
}

function aigroundturret_shouldmountturret(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("disconnect");
  var_4 = getdvarint("scr_br_activateKSOnPurchase", 0);

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("activateKillstreakOnPurchase")) {
    var_5 = scripts\mp\gametypes\br_gametypes::ref_12E05("activateKillstreakOnPurchase", var_0.ref);

    if(isDefined(var_5)) {
      var_4 = var_5;
    }
  }

  if(!var_4) {
    var_3 scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(var_0.ref, var_1, 1, var_2);
    _makekioskpurchase(var_3, var_0, var_0.cost, var_0.playboxuseanimation, var_0.ref_122FC, var_0.scripteddiscount);
    var_3 thread scripts\mp\hud_message::showsplash("br_killstreak_purchased");
    var_3 scripts\cp\vehicles\vehicle_compass_cp::ref_1204B("killstreak", var_0.ref);
    scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(self, var_0.cost, "killstreak", var_0.ref);
    return;
  }

  if(allow_ascender_use(var_0.ref)) {
    var_6 = var_3.delay_kick_inactive_player;
    addtop3brcharge(var_3, 16);
    var_3 scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
    var_3 beginlocationselection(0, 0, 0, 0, 4);
    GscBinSkip4(0x6e, var_3);
  }

  var_9 = var_4 scripts\mp\gametypes\br_pickups::forceusekillstreak(var_1.ref);

  if(istrue(var_9)) {
    _makekioskpurchase(var_4, var_1, var_1.cost, var_1.playboxuseanimation, var_1.ref_122FC, var_1.scripteddiscount);
    var_4 thread scripts\mp\hud_message::showsplash("br_killstreak_purchased_and_activated");
    scripts\cp\vehicles\vehicle_compass_cp::ref_1204B("killstreak", var_1.ref);
    scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(self, var_1.cost, "killstreak", var_1.ref);
    return;
  }
}

function aigroundturret_shouldcompletedismount(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_pickups::forcegivesuper(var_0.ref, var_1, 1, var_2);
  _makekioskpurchase(var_0, var_0.cost, var_0.playboxuseanimation, var_0.ref_122FC, var_0.scripteddiscount);
  thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");
  scripts\cp\vehicles\vehicle_compass_cp::ref_1204B("fieldUpgrade", var_0.ref);
  scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(self, var_0.cost, "fieldUpgrade", var_0.ref);

  if(level.allowsupers && !istrue(var_2)) {
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
  }
}

function aigroundturretref(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 1;
  var_5 = 1;
  var_6 = undefined;

  switch (var_0.ref) {
    case "armor":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_armor_plate", 1, undefined, 1, var_2);
      break;
    case "armor_bundle":
      var_7 = ai_molotov_swap(var_3, 1);

      if(var_7 <= 0) {
        var_4 = 1;
      } else {
        var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_armor_plate", 1, var_7, 1, var_2);
      }

      break;
    case "gas_mask":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_equip_gasmask", 1, undefined, 1, var_2);
      break;
    case "gas_mask_durable":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_equip_gasmask_durable", 1, undefined, 1, var_2);
      break;
    case "ammo_refill":
      var_3 scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
      allowattackfromexposednonode(var_3, var_3.equipment["primary"]);
      allowattackfromexposednonode(var_3, var_3.equipment["secondary"]);
      break;
    case "respawn_token":
      var_3 scripts\mp\gametypes\br_pickups::addrespawntoken();
      var_5 = 0;
      break;
    case "self_revive_token":
      if(istrue(var_2)) {
        var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_self_revive", 1, undefined, 1, var_2);
      } else {
        var_3 scripts\mp\gametypes\br_pickups::bdroppingshield();
      }

      var_5 = 0;
      break;
    case "zxp_stim":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_zmb_stim", 1, undefined, 1, 1);
      break;
    case "supply_drop":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_offhand_advancedsupplydrop", 1, undefined, 1, var_2);
      break;
    case "circle_pick":
      var_4 = ref_125C1(var_3);
      break;
    case "redeploy":
      var_4 = ref_125C4(var_3);
      break;
    case "vehicle_repair":
      var_4 = airdrop_applyimmediatejuggernaut(var_3);
      break;
    case "vehicle_upgrade_armor":
      var_4 = airdrop_bronloadoutcratedestroyed(var_3, "armor");
      break;
    case "vehicle_refill_trophy":
      var_4 = airdop_brloadoutcratefirstactivation(var_3, "trophy");
      break;
    case "vehicle_upgrade_trophy":
      var_4 = airdrop_bronloadoutcratedestroyed(var_3, "trophy");
      break;
    case "vehicle_upgrade_uav":
      var_4 = airdrop_bronloadoutcratedestroyed(var_3, "uav");
      break;
    case "vehicle_upgrade_barrel":
      var_4 = airdrop_bronloadoutcratedestroyed(var_3, "barrel");
      break;
    case "vehicle_replace":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_offhand_advancedvehicledrop", 1, undefined, 1, var_2);
      break;
    case "bombardment_ltm":
      var_8 = getdvarfloat("scr_bombardment_duration", 60);
      var_9 = getdvarfloat("scr_bombardment_radius", 4112);

      if(isDefined(level.create_exfil_animstruct) && isDefined(level.ref_14687) && isDefined(level.ref_14687.ref_11AE9)) {
        var_10 = undefined;

        foreach(var_12 in level.create_exfil_animstruct) {
          if(var_12.refname == level.ref_14687.ref_11AE9) {
            var_10 = var_12;
          }
        }

        if(isDefined(var_10)) {
          level.create_ai_type_override = var_10.ref_119A7;
          var_9 = var_10.ref_119A8;
        }
      }

      var_4 = level _hidesafecircleui::changetimertoovertimetimer(level.create_ai_type_override, var_3, var_8, var_9);

      if(var_4) {
        var_3 scripts\mp\gametypes\br_pickups::ref_12BFC();
      }

      break;
    case "build_checkpoint":
      var_4 = scripts\mp\gametypes\br_gametype_payload::firesalediscount(var_3, var_3.delay_kick_inactive_player);
      break;
    case "build_tower":
      var_4 = scripts\mp\gametypes\br_gametype_payload::fix_wall_traversal(var_3, var_3.delay_kick_inactive_player);
      break;
    case "random_powerup":
      var_3 _keypadscriptableused_bunkeralt::script_model_spawn_and_use_logic();
      var_5 = 0;
      break;
    case "specialist_perk":
      var_3 scripts\mp\gametypes\br_pickups::bearsetup(0);
      var_4 = 1;

      if(var_3 calloutmarkerping_entityzoffset("ui_br_purchase_file_override") == 8) {
        var_3 reportchallengeuserevent("collect_item", "dragons_den_blackmarket");
      }

      break;
    case "pac_sentry_kiosk":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_killstreak_sentrygun", 1, undefined, 1, var_2);
      break;
    case "circle_bombardment":
      if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
        var_4 = level _hidesafecircleui::changing_loadout(var_3);
      } else {
        scripts\mp\utility\script::laststand_dogtags("No safe circle ent defined");
        var_4 = 0;
      }

      if(!var_4) {
        addtop3brcharge(var_3, 28);
      }

      break;
    case "kiosk_drop":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_offhand_kioskdrop", 1, undefined, 1, var_2);
      break;
    case "numbers_grenade":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_offhand_numbers_grenade", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("ui_br_purchase_file_override") == 8) {
        var_3 reportchallengeuserevent("collect_item", "dragons_den_blackmarket");
      }

      break;
    case "nebula_v_rounds":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_super_nova_rounds", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("ui_br_purchase_file_override") == 8) {
        var_3 reportchallengeuserevent("collect_item", "dragons_den_blackmarket");
      }

      break;
    case "pds":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_offhand_decon_station", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("ui_br_purchase_file_override") == 8) {
        var_3 reportchallengeuserevent("collect_item", "dragons_den_blackmarket");
      }

      break;
    case "redacted_ar":
      var_4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase(var_3, "brloot_weapon_s4_ar_asierra44_ultr", 1, undefined, 1, var_2);
      break;
    case "redacted_smg":
      var_4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase(var_3, "brloot_weapon_s4_sm_owhiskey_ultr", 1, undefined, 1, var_2);
      break;
    case "redacted_shotgun":
      var_4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase(var_3, "brloot_weapon_s4_sh_bromeo5_ultr", 1, undefined, 1, var_2);
      break;
    case "redacted_sniper":
      var_4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase(var_3, "brloot_weapon_s4_mr_moscar_ultr", 1, undefined, 1, var_2);
      break;
    case "redacted_lmg":
      var_4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase(var_3, "brloot_weapon_s4_mg_mgolf42_ultr", 1, undefined, 1, var_2);
      break;
    case "nebula_v_special":
      var_4 = scripts\mp\gametypes\br_black_market_quest::redacted_weapon_purchase(var_3, "brloot_weapon_lm_dblmg_lege", 1, undefined, 1, var_2);
      break;
    case "circle_peek":
      var_4 = scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(var_3, "brloot_killstreak_circle_peek", 1, undefined, 1, var_2);

      if(var_3 calloutmarkerping_entityzoffset("ui_br_purchase_file_override") == 8) {
        var_3 reportchallengeuserevent("collect_item", "dragons_den_blackmarket");
      }

      break;
    case "contribute_heroes":
      var_5 = 0;
      _showsplashlimited(var_3, "br_hero_bundle");
      break;
    case "contribute_villains":
      var_5 = 0;
      _showsplashlimited(var_3, "br_villain_bundle");
      break;
    case "br_bomb":
      var_5 = 0;
      _showsplashlimited(var_3, "br_villain_bundle");
      break;
    case "br_defusekit":
      var_5 = 0;
      _showsplashlimited(var_3, "br_hero_bundle");
      break;
    default:
      break;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("kiosk_onPurchase")) {
    scripts\mp\gametypes\br_gametypes::ref_12E05("kiosk_onPurchase", var_3, var_0.ref);
  }

  if(var_4) {
    _makekioskpurchase(var_3, var_0, var_0.cost, var_0.playboxuseanimation, var_0.ref_122FC, var_0.scripteddiscount);

    if(var_5) {
      var_3 thread scripts\mp\hud_message::showsplash("br_item_purchased");
    }

    scripts\cp\vehicles\vehicle_compass_cp::ref_1204B("special", var_0.ref);
    scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(self, var_0.cost, "special", var_0.ref);
    return;
  }
}

function aigroundturretstate(var_0, var_1) {
  var_2 = (1, 1, 1);
  var_3 = (1, 0, 0);
  var_4 = (0, 1, 0);
  var_5 = (0, 1, 1);
  var_6 = 3;
  var_7 = 8;
  var_8 = self.delay_kick_inactive_player.origin;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::canspawnVehicle()) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  var_9 = physics_createcontents(["physicscontents_solid", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicleclip"]);
  var_10 = 300;
  var_11 = 90;
  var_12 = 300;
  var_13 = 150;
  var_14 = var_13 + var_10;
  var_15 = 0;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = undefined;

  while(var_15 < 360) {
    var_19 = var_8 + (sin(var_15) * var_10, cos(var_15) * var_10, 0);
    var_16 = (var_19[0], var_19[1], var_19[2] + var_14);
    var_17 = (var_19[0], var_19[1], var_19[2] - var_14);
    var_20 = physics_spherecast(var_16, var_17, var_12, var_9, undefined, "physicsquery_closest");

    if(var_20.size > 0) {
      var_21 = var_20[0]["position"];
      var_17 = (var_16[0], var_16[1], var_20[0]["shape_position"][2] - var_10);

      if(!isDefined(var_20[0]["entity"]) && abs(var_17[2] - var_19[2]) < var_13) {
        if(!isDefined(var_18)) {
          var_18 = var_17 + (0, 0, var_10);

          if(!getdvarint("scr_vehicleKioskFindAllSpawns", 0) > 0) {
            break;
          }
        }
      }
    }

    var_14 += var_10;
  }

  if(!isDefined(var_17)) {
    return false;
  }

  var_22 = 150;
  var_23 = spawnStruct();
  var_23.origin = var_17 + (0, 0, var_22);
  var_23.angles = (0, randomintrange(0, 360), 0);
  var_23.owner = self;
  var_23.spawntype = "GAME_MODE";
  var_24 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle( < error > .ref, var_23);

  if(!isDefined(var_24)) {
    return false;
  }

  var_25 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat(var_24);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_24, var_25, self);
  scripts\cp_mp\vehicles\vehicle_spawn::ref_14219(var_24);
  return true;
}

function addspecialistbonuspickup() {
  var_0 = self;
  var_1 = var_0.ref_1424D;

  if(isDefined(var_1)) {
    if(var_1.health == var_1.maxhealth) {
      return false;
    }

    return true;
  }

  return false;
}

function addtenkillcharge() {
  var_0 = self;
  var_1 = var_0.ref_1424D;

  if(isDefined(var_1)) {
    if(isDefined(var_1.ref_13DDF) && isDefined(var_1.ref_11B7B) && var_1.ref_13DDF == var_1.ref_11B7B) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function addteabagcharge(var_0) {
  var_1 = self;
  var_2 = var_1.ref_1424D;

  if(isDefined(var_2)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141AC(var_2, var_0)) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function airdrop_applyimmediatejuggernaut(var_0, var_1) {
  var_2 = self;
  var_3 = var_2.ref_1424D;

  if(isDefined(var_3)) {
    if(var_3.health == var_3.maxhealth) {
      return false;
    }

    var_4 = getdvarfloat("truck_repair_health_percent", 0.25);
    var_5 = int(var_3.maxhealth * var_4);
    var_3 scripts\cp_mp\vehicles\vehicle_damage::ref_1413C(var_5);
    var_6 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(var_2 in var_6) {
      if(getdvarint("scr_truckwar_repair_show_player_feedback", 1) == 1) {
        var_2 scripts\mp\damagefeedback::hudicontype("truckheal");
      }

      var_2 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_pockets", var_3.health);
      var_2 _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_team_cash_banked", var_3.maxhealth);
    }

    return true;
  }

  return false;
}

function airdop_brloadoutcratefirstactivation(var_0) {
  var_1 = self;
  var_2 = var_1.ref_1424D;

  if(isDefined(var_2)) {
    scripts\cp_mp\vehicles\vehicle_interact::ref_141A4(var_2, var_0, var_1);
    return true;
  }

  return false;
}

function airdrop_bronloadoutcratedestroyed(var_0) {
  var_1 = self;
  var_2 = var_1.ref_1424D;

  if(isDefined(var_2)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::ref_141AC(var_2, var_0)) {
      return false;
    } else {
      scripts\cp_mp\vehicles\vehicle_interact::ref_141A4(var_2, var_0, var_1);
      return true;
    }
  }

  return false;
}

function announcedomplatespawns() {
  var_0 = self;
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_4 = var_3 scripts\mp\supers::getcurrentsuperref();

      if(isDefined(var_4) && var_4 == "super_vehicle_drop") {
        if(var_3 getammocount(var_3.super.staticdata.weapon) > 0) {
          return true;
        }
      }
    }
  }

  if(isDefined(level.ref_13ACD) && istrue(level.ref_13ACD[var_0.team])) {
    return true;
  }

  return false;
}

function addspecialistdialog() {
  if(isDefined(level.ref_13ACE) && !isDefined(level.ref_13ACE[self.team])) {
    return true;
  }

  return false;
}

function onarmorykioskpurchase(var_0, var_1) {
  var_2 = self;
  var_3 = var_2.delay_kick_inactive_player;

  if(!istrue(var_2.armorykioskpurchaseallowed)) {
    return;
  }

  var_4 = "channel: " + var_0;

  if(isDefined(var_1)) {
    var_4 = var_4 + ", index: " + var_1;
  }

  scripts\mp\gametypes\br_analytics::destructable_car(var_2, "menu_purchase", var_4);
  var_5 = getdvarint("scr_br_kioskPurchaseDropItems", 1);
  var_6 = getdvarint("scr_br_kioskPurchaseDropPurchasedItem", 0);

  if(var_2 scripts\mp\utility\killstreak::isjuggernaut()) {
    var_6 = 1;
  }

  if(var_0 == "br_cancel_purchase") {
    ally_charge_dialogue(var_2);
    return;
  }

  if(var_0 == "br_item_purchase") {
    var_7 = var_1;
    var_8 = level.br_armory_kiosk.items[var_7];
    var_9 = apc_rus_initdamage(var_2, var_8, var_5, var_6);
    var_8.scripteddiscount = getbestscripteddiscount(var_2, var_8.ref);

    if(var_9) {
      if(var_8.type == "killstreak") {
        thread aigroundturret_shouldmountturret(var_2, var_8, var_5);
      } else if(var_8.type == "fieldupgrade") {
        aigroundturret_shouldcompletedismount(var_2, var_8, var_5, var_6);
      } else if(var_8.type == "special") {
        aigroundturretref(var_2, var_8, var_5, var_6);
      } else if(var_8.type == "vehicle") {
        var_10 = aigroundturretstate(var_2, var_8, var_5);

        if(var_10) {
          _makekioskpurchase(var_2, var_8, var_8.cost, var_8.playboxuseanimation, var_8.ref_122FC, var_8.scriptediscount, var_0);
          var_2 thread scripts\mp\hud_message::showsplash("br_vehicle_purchased");
          scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(self, var_8.cost, "vehicle", var_8.ref);
        } else {
          var_2 scripts\mp\hud_message::showerrormessage("MP/VEHICLE_PURCHASE_FAILED");
        }
      }
    }

    return;
  }

  if(var_0 == "br_loadout_purchase") {
    var_7 = var_1;
    var_8 = level.br_armory_kiosk.items[var_7];
    var_11 = unstable_gauge_timer_active(var_2.delay_kick_inactive_player, var_2);
    var_12 = var_2 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
    var_13 = 0;
    var_14 = var_1;
    var_15 = level.br_armory_kiosk.ref_11955;
    var_16 = level.br_armory_kiosk.ref_11956;
    var_17 = level.br_armory_kiosk.ref_11957;
    var_18 = getbestscripteddiscount(var_2, var_8.ref);

    if(scripts\mp\menus::update_enemies_remaining(var_14)) {
      var_15 = level.br_armory_kiosk.ref_11958;
      var_16 = level.br_armory_kiosk.ref_11959;
      var_17 = level.br_armory_kiosk.ref_1195A;
      var_13 = 1;
    }

    var_19 = ai_push_to_position(var_8, var_15, var_11, var_16, var_12, var_17, var_18);

    if(var_2.plundercount < var_19) {
      addtop3brcharge(var_2, 3);
      return;
    }

    var_20 = scripts\mp\menus::getclasschoice(var_14);
    scripts\mp\gametypes\br_analytics::destroyscorelaunchonly(self, "purchasing_new_loadout");
    var_2.pers["class"] = var_20;
    var_2.class = var_20;
    var_21 = var_2 scripts\mp\class::preloadandqueueclass(var_20);
    scripts\mp\gametypes\br::delay_delete_reinforcement_called_icon(var_2, var_5);
    _makekioskpurchase(var_2, var_8, var_15, var_16, var_17, var_18, var_0);
    var_2 thread scripts\mp\hud_message::showsplash("br_loadout_purchased");

    if(istrue(var_13)) {
      scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(self, var_19, "defaultLoadout", "loadout_" + var_14);
    } else {
      scripts\mp\gametypes\br_analytics::destructiblevehiclesetup(self, var_19, var_21);
    }

    return;
  }

  if(var_0 == "br_team_revive") {
    var_22 = var_1;
    var_11 = unstable_gauge_timer_active(var_2.delay_kick_inactive_player, var_2);
    var_16 = level.br_armory_kiosk.ref_13AC3;
    var_12 = var_2 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
    var_17 = level.br_armory_kiosk.ref_13AC4;
    var_23 = "teamrevive";
    var_18 = getbestscripteddiscount(var_2, var_23);
    var_24 = ai_push_to_position(undefined, level.br_armory_kiosk.ref_13AC2, var_11, var_16, var_12, var_17, var_18);
    var_25 = !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("useTokenToReviveTeammate");
    var_26 = istrue(var_2.hasrespawntoken) && var_25 && var_2.plundercount < var_24;

    if(!var_26 && var_2.plundercount < var_24) {
      addtop3brcharge(var_2, 3);
      return 0;
    }

    var_27 = undefined;
    var_28 = scripts\mp\utility\teams::getteamdata(var_2.team, "players");

    foreach(var_30 in var_28) {
      if(isDefined(var_30.pers["squadMemberIndex"]) && var_30.pers["squadMemberIndex"] == var_22) {
        var_27 = var_30;
        break;
      }
      LOC_00000424:
    }

    if(!isDefined(var_27)) {
      addtop3brcharge(var_2, 12);
      return;
    }

    if(!var_27 scripts\mp\gametypes\br_public::unlockscriptabledoors() && !getdvarint("scr_br_all_assassin_version", 0)) {
      if(scripts\mp\gametypes\br_public::use_csm(var_27)) {
        addtop3brcharge(var_2, 14);
        return;
      }

      if(isalive(var_27)) {
        addtop3brcharge(var_2, 15);
        return;
      }

      addtop3brcharge(var_2, 13);
      return;
    }

    var_32 = 0;

    if(!var_26) {
      var_33 = level.br_armory_kiosk.ref_13AC2;
      var_16 = level.br_armory_kiosk.ref_13AC3;
      var_17 = level.br_armory_kiosk.ref_13AC4;
      _makekioskpurchase(var_2, undefined, var_33, var_16, var_17, var_18, var_0);

      if(istrue(var_2.hasrespawntoken)) {
        var_32 = 1;
      } else {
        var_2 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
      }

      var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_1204B("teamrevive", "teamrevive");
      scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(var_2, var_24, "teamrevive_money", "teamrevive");
    } else {
      _makekioskpurchase(var_2, undefined, 0, 0, 0, 0, var_0);
      var_2 scripts\cp\vehicles\vehicle_compass_cp::ref_1204B("teamrevive", "teamrevive");
      scripts\mp\gametypes\br_analytics::destructiblecarlightssetup(var_2, 0, "teamrevive_token", "teamrevive");
    }

    if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("kioskRevivePlayer")) {
      var_27 thread scripts\mp\gametypes\br_gametypes::ref_12E05("kioskRevivePlayer", var_2, var_26);
    } else {
      var_27 thread scripts\mp\gametypes\br_gulag::playergulagautowin("br_team_revive", var_2, var_26);
    }

    if(var_32) {
      var_2 scripts\mp\gametypes\br_pickups::addrespawntoken(1);
    }

    level thread scripts\mp\gametypes\br_quest_util::ref_140B1(var_3.origin, "revive");
    var_2 thread scripts\mp\hud_message::showsplash("br_squadmate_revived");

    if(getdvarint("OMSQPMNQLS", 0) && var_2 scripts\mp\utility\game::onlinestatsenabled()) {
      var_2 setplayerdata("mp", "use_buy_back_history", 0, 1);
    }
  }
}

function _makekioskpurchase(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = unstable_gauge_timer_active(var_6.delay_kick_inactive_player, var_6);
  var_8 = var_6 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");

  if(var_7 && var_2 > 0) {
    wait_for_all_traps_disabled(var_6.delay_kick_inactive_player, var_6);
  }

  if(!(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("kioskXP") || scripts\mp\gametypes\br_public::turret_headicon())) {
    var_6 thread scripts\mp\utility\points::giveunifiedpoints("br_kioskBuy", undefined, scripts\mp\gametypes\br::freeze_bomb_vest_timer(var_1), undefined, undefined, undefined, undefined, var_5);
  }

  var_1 = ai_push_to_position(var_0, var_1, var_7, var_2, var_8, var_3, var_4);

  if(var_1 > 0) {
    var_6 scripts\mp\gametypes\br_plunder::ref_12622(var_1);
  }

  if(!isDefined(level.br_plunder)) {
    level.br_plunder = spawnStruct();
  }

  if(!isDefined(level.br_plunder.wait_for_all_players_in_airlock)) {
    level.br_plunder.wait_for_all_players_in_airlock = 0;
  }

  level.br_plunder.wait_for_all_players_in_airlock += var_1;

  if(!isDefined(level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes)) {
    level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes = 0;
  }

  level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes++;

  if(!level.br_armory_kiosk_close_menu_fix) {
    if(var_6 scripts\engine\utility::ref_12C44("buystationCloseMenuOnPurchase")) {
      addtop3brcharge(var_6, 1);
    }

    return;
  }

  thread playerclosebuystationmenu();
}

function playerclosebuystationmenu() {
  self endon("disconnect");
  self notify("playerCloseBuyStationMenu");
  self endon("playerCloseBuyStationMenu");
  var_0 = requestgamerprofiletimeout("buystationCloseMenuOnPurchase", level.br_armory_kiosk_close_menu_timeout);

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    addtop3brcharge(1);
    return;
  }
}

function requestgamerprofiletimeout(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("requestGamerProfileTimeout" + var_0);
  self setpredictedstreamloaddist(var_0);
  scripts\engine\utility::delaythread(var_1, &scripts\engine\utility::send_notify, "requestGamerProfileTimeout" + var_0);

  for(;;) {
    self waittill("luinotifyserver", var_2, var_3);

    if(var_2 == "gamerprofile_request") {
      return var_3;
    }
  }
}

function ref_125FD() {
  var_0 = self;
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("confirm_location");
  scripts\engine\utility::waittill_any_ents(var_0, "death", level, "game_ended");
  var_0 notify("cancel_location");
}

function ref_125C1() {
  self setclientomnvar("ui_br_purchase_killstreak_response", 1);
  self setclientomnvar("ui_br_open_purchase_killstreak", 0);
  self setclientomnvar("ui_br_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
  self beginlocationselection(0, 0, 0, 0, 4);
  thread ref_125FD();
  var_0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
  var_1 = 0;
  self endlocationselection();

  if(isDefined(var_0) && var_0.string == "confirm_location") {
    if(scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_0.location, 1)) {
      var_2 = scripts\mp\gametypes\br::ref_13C34(var_0.location);
      var_3 = var_2["position"];

      if(scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_3, 1)) {
        thread ref_12CBD(var_3);
        var_1 = 1;
      } else {
        addtop3brcharge(18);
      }
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "kiosk");
  self setclientomnvar("ui_br_show_tac_map", 0);
  return var_1;
}

function ref_12CBD(var_0) {
  level endon("game_ended");
  level notify("restartCircleElimination");
  var_1 = 60;
  var_2 = 4;
  var_3 = -1;
  var_4 = 15;
  var_5 = getdvarint("scr_br_late_circle_delay", var_1);
  var_6 = getdvarint("scr_br_late_circle_index", var_2);
  var_7 = getdvarint("scr_br_late_circle_close", var_3);
  var_8 = getdvarint("scr_br_late_circle_last", var_4);

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("restartCircleElimination")) {
    thread scripts\mp\gametypes\br_gametypes::ref_12E05("restartCircleElimination", var_0, var_5);
  }

  foreach(var_10 in level.players) {
    var_10 scripts\mp\hud_message::showsplash("br_late_circle_soon");
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("circle")) {
    scripts\mp\gametypes\br_circle::teleport_players_inside_subway_car(var_0, var_5, var_6, var_7);
    level.disable_super_in_turret.lmg_guys["circle"] = undefined;
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("allowLateJoiners")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  var_12 = max(0, var_5 - var_8);
  wait var_12;

  foreach(var_10 in level.players) {
    var_10 scripts\mp\hud_message::showsplash("br_late_circle_now");
  }

  var_15 = var_5 - var_12;
  wait var_15;

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("teamSpectate")) {
    level thread scripts\mp\gametypes\br_spectate::spectate_init();
    level.disable_super_in_turret.lmg_guys["teamSpectate"] = undefined;
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_" + scripts\mp\utility\game::getgametype() + "_numLives", 1);
    return;
  }
}

function ref_125C4() {
  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerHandleRedeploy")) {
    return scripts\mp\gametypes\br_gametypes::ref_12E05("playerHandleRedeploy");
  }

  self setclientomnvar("ui_br_purchase_killstreak_response", 1);
  self setclientomnvar("ui_br_open_purchase_killstreak", 0);
  self setclientomnvar("ui_br_show_tac_map", 1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "kiosk");
  self beginlocationselection(0, 0, 0, 0, 4);
  thread ref_125FD();
  var_0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
  var_1 = 0;
  self endlocationselection();

  if(isDefined(var_0) && var_0.string == "confirm_location") {
    if(scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_0.location, 1)) {
      var_2 = scripts\mp\gametypes\br::ref_13C34(var_0.location);
      var_3 = var_2["position"];

      if(scripts\mp\gametypes\br_circle::vandalize_minigun_speed(var_3, 1)) {
        self notify("_watchToAutoCloseMenu_end");
        ref_12647(var_3);
        var_1 = 1;
      } else {
        addtop3brcharge(18);
      }
    }
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "kiosk");
  self setclientomnvar("ui_br_show_tac_map", 0);
  return var_1;
}

function resetarenaomnvardata() {
  var_0 = 0;

  foreach(var_2 in level.br_armory_kiosk.scriptables) {
    if(scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(var_2.origin)) {
      var_0++;
    }
  }

  return var_0;
}

function ref_12647(var_0, var_1, var_2) {
  var_3 = self;
  level endon("game_ended");
  var_3 endon("disconnect");
  var_4 = 12000;
  var_5 = var_1;

  if(!isDefined(var_5)) {
    var_5 = var_4;
  }

  var_6 = var_2;

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_7 = spawnStruct();
  var_7.origin = var_0 + (0, 0, var_5);
  var_7.angles = (0, var_6, 0);
  var_7.height = var_5;
  var_8 = var_3 scripts\mp\gametypes\br_gulag::ref_1263E(var_7);
  var_3.forcespawnorigin = var_8;
  var_9 = 1;
  var_3 scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  wait var_9;
  var_10 = var_7.origin;
  var_11 = var_7.angles;
  var_12 = var_10;

  if(isDefined(var_8)) {
    var_12 = var_8;
  }

  var_3 scripts\mp\gametypes\br_gulag::set_scriptable_states();
  var_3 scripts\mp\gametypes\br_gulag::ref_126C3(var_12, var_11);
  var_13 = spawn("script_model", var_12);
  var_13 setModel("tag_origin");
  var_13.angles = var_11;
  var_13 hide();
  var_13 showtoplayer(var_3);
  var_3 playerlinktoabsolute(var_13, "tag_origin");
  var_3 playerhide();
  var_3 thread scripts\mp\gametypes\br_gulag::ref_12524(var_13);
  waitframe();
  var_3 scripts\mp\gametypes\br_public::ref_126ED();
  var_3 scripts\mp\gametypes\br_public::ref_1252B();

  if(isDefined(var_8)) {
    var_13.origin = var_10;
  }

  var_13 playsoundtoplayer("br_ac130_flyby", var_3);
  wait 1.5;
  var_3 unlink();
  var_3 clearsoundsubmix("deaths_door_mp");
  var_3 clearclienttriggeraudiozone(1);
  var_3 playershow();
  var_14 = 0;

  if(isDefined(level.ref_121CC)) {
    var_14 = level.ref_121CC;
  }

  var_3.use_armor = 1;
  var_3 thread scripts\cp_mp\parachute::startfreefall(var_14, 0, undefined, undefined, 1);
  var_3 setclientomnvar("ui_br_transition_type", 0);
  var_3 setclientomnvar("ui_show_spectateHud", -1);
  var_3 scripts\mp\gametypes\br_gulag::ref_12C7A();
  wait 0.5;
  var_3 scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  waitframe();
  var_13 delete();
}

function callback_setscripteddiscountid(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    _setplayerscripteddiscount(var_0, var_1, var_2);
    return;
  }

  _setlevelscripteddiscount(var_1, var_2);
}

function callback_getscripteddiscountid(var_0, var_1) {
  return _getscripteddiscountid(var_0, var_1);
}

function arescripteddiscountsenabled() {
  return getdvarint("scr_br_enable_hvv_discounts", 0) > 0;
}

function applyscripteddiscounts() {
  for(var_0 = 0; var_0 < 3; var_0++) {
    _applyscripteddiscount(var_0);
  }
}

function getbestscripteddiscount(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_3 = _getscripteddiscountvalue(var_2, var_0);
    var_1 = max(var_1, var_3);
  }

  return var_1;
}

function _applyscripteddiscount(var_0) {
  var_1 = _getscripteddiscountid(var_0);
  var_2 = 1 + var_0 * 5;
  var_3 = 5;
  ref_1260D("ui_br_kiosk_ban_supply_drop", var_1, var_2, var_3);
}

function _setplayerscripteddiscount(var_0, var_1) {
  if(!isDefined(self.scripteddiscountids)) {
    self.scripteddiscountids = [];
  }

  self.scripteddiscountids[var_0] = var_1;
}

function _setlevelscripteddiscount(var_0, var_1) {
  if(!isDefined(level.disable_super_in_turret.scripteddiscountids)) {
    level.disable_super_in_turret.scripteddiscountids = [];
  }

  level.disable_super_in_turret.scripteddiscountids[var_0] = var_1;
}

function _getscripteddiscountid(var_0) {
  if(isDefined(self.scripteddiscountids)) {
    if(isDefined(self.scripteddiscountids[var_0])) {
      return self.scripteddiscountids[var_0];
    }
  }

  if(isDefined(level.disable_super_in_turret.scripteddiscountids)) {
    if(isDefined(level.disable_super_in_turret.scripteddiscountids[var_0])) {
      return level.disable_super_in_turret.scripteddiscountids[var_0];
    }
  }

  return -1;
}

function _getscripteddiscountvalue(var_0, var_1) {
  var_2 = _isscripteddiscount(var_0, var_1);

  if(!var_2) {
    return 0;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getScriptedDiscount")) {
    return scripts\mp\gametypes\br_gametypes::ref_12E05("getScriptedDiscount", var_0, var_1);
  }

  return 0;
}

function _isscripteddiscount(var_0, var_1) {
  var_2 = _getidfromref(var_1);
  var_3 = _getscripteddiscountid(var_0);
  return var_2 == var_3 && var_2 != -1;
}

function _getidfromref(var_0) {
  var_1 = getDvar("br_kiosk_items_filename", "mp/brKioskPurchases.csv");

  if(var_1 == "") {
    var_1 = "mp/brKioskPurchases.csv";
  }

  return int(_vlookup(var_1, 2, 0, var_0, -1));
}

function _vlookup(var_0, var_1, var_2, var_3, var_4) {
  var_5 = tablelookupgetnumrows(var_0);
  var_6 = 0;

  while(var_6 < var_5) {
    var_7 = tablelookupbyrow(var_0, var_6, var_1);

    if(var_7 != scripts\engine\utility::string(var_3)) {} else {
      var_8 = tablelookupbyrow(var_0, var_6, var_2);
      return var_8;
    }

    var_7++;
  }

  return var_5;
}

function ref_1260D(var_0, var_1, var_2, var_3) {
  if(var_1 == -1) {
    var_1 = (1 << var_3) - 1;
  }

  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_1 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset(var_0);
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;

  if(var_9 != var_7) {
    self setclientomnvar(var_0, var_9);
    return;
  }
}
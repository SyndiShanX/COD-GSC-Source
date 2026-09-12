/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armory_trader.gsc
*****************************************************/

function init() {
  level.debug_trap_room = spawnStruct();
  level.debug_trap_room.scriptables = [];
  level.debug_trap_toggle = getdvarint("scr_br_armory_trader", 0) != 0;

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("trader")) {
    level.debug_trap_toggle = 0;
  } else {
    var_0 = registeraccesscardlocs();

    if(!isDefined(var_0) || var_0.size == 0) {
      level.debug_trap_toggle = 0;
    }
  }

  if(!level.debug_trap_toggle) {
    return;
  }

  scripts\engine\scriptable::ref_12f5b("br_armory_trader", &camera_loadout_showcase_preview_large_sticker_alt1);
  level.debug_trap_room.ref_11a20 = strtok(getDvar("loot_table_filter", ""), "|");
  level.debug_trap_room.play_lighting_sequence = strtok(getDvar("scr_br_armory_trader_filter", "brloot_offhand_advancedsupplydrop|brloot_plunder_extract|brloot_perk_point_overkill"), "|");
  logtraderfilter();
  tr_detectwinners();
  level.debug_trap_room.xp = [0, 100, 200, 300, 500];
  level.debug_trap_room.ref_140a2 = [1, 2.5, 3, 3.5, 5];
  level.debug_trap_room.ref_1409a = ["WTS_rarity_common", "WTS_rarity_uncommon", "WTS_rarity_rare", "WTS_rarity_epic", "WTS_rarity_legendary"];
}

function logtraderfilter() {
  var_0 = getDvar("scr_br_armory_trader_filter", "undefined_default");
  logstring("br_armory_trader scr_br_armory_trader_filter value is: " + var_0);
  var_1 = "";

  foreach(var_3 in level.debug_trap_room.play_lighting_sequence) {
    var_1 += var_3 + " ";
  }

  logstring("br_armory_trader level.br_armory_trader.filteredItems value is: " + var_1);
}

function tr_detectwinners() {
  level.debug_trap_room.ref_13c65 = [];
  level.debug_trap_room.ref_13c65["default"] = tmtyl_bomber_squadafterspawnfunc(getDvar("scr_br_armory_trader_options", "mp/brTraderOptions.csv"));
}

function tmtyl_bomber_squadafterspawnfunc(var_0) {
  var_1 = [];
  var_2 = undefined;
  var_3 = undefined;
  var_4 = tablelookupgetnumrows(var_0);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = tablelookupbyrow(var_0, var_5, 0);

    if(!isDefined(var_6) || var_6 == "") {
      continue;
    }

    if(var_6 == "1") {
      if(!isDefined(var_3) || var_3 != var_6) {
        var_2 = spawnStruct();
        var_2.ref_13a31 = [];
        var_2.entries = [];
        var_1 = scripts\engine\utility::array_add(var_1, var_2);
      }

      var_2.ref_13a31[var_2.ref_13a31.size] = tablelookupbyrow(var_0, var_5, 1);
    } else if(var_6 == "2" && isDefined(var_2)) {
      var_7 = spawnStruct();
      var_7.weight = int(tablelookupbyrow(var_0, var_5, 1));
      var_8 = [];
      var_9 = 7;

      for(var_10 = 2; var_10 < var_9; var_10++) {
        var_6 = tablelookupbyrow(var_0, var_5, var_10);

        if(!isDefined(var_6) || var_6 == "") {
          continue;
        }

        var_8 = tablelookupbyrow(var_0, var_5, var_10);
      }

      var_7.ref_12a7f = var_8;
      var_2.entries[var_2.entries.size] = var_7;
    } else {
      continue;
    }

    var_3 = var_6;
  }

  return var_1;
}

function tr_entergulag() {
  return randomint(getdvarint("scr_br_armory_trader_randomizer", 32767));
}

function onprematchdone() {
  foreach(var_1 in level.debug_trap_room.scriptables) {
    var_1 setscriptablepartstate("br_armory_trader", "visible");
    var_1.visible = 1;
    var_1.ref_13c6b = "default";
    var_1.forceextractscriptable = tr_entergulag();
    var_1.ref_11b72 = int(pow(2, 4)) - 1;
    toma_strike_trace_offset(var_1);
    initdropgrid(var_1);
    thread x1ops7();
  }
}

function toma_strike_trace_offset() {
  var_0 = spawn("trigger_radius", self.origin, 0, 500, 500);
  var_0.playersintrigger = [];
  thread ref_14500(var_0);
  thread ref_14501(var_0);
  thread ref_14369();
  self.ref_1292c = var_0;
}

function ref_14500(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var_2 = var_1 getentitynumber();

    if(isDefined(self.playersintrigger[var_2])) {
      continue;
    }

    self.playersintrigger[var_2] = var_1;
    thread ref_12027(var_1, self);
  }
}

function ref_14501(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    foreach(var_2 in self.playersintrigger) {
      if(isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive() && var_2 istouching(self)) {
        continue;
      }

      self.playersintrigger[var_3] = undefined;
      ref_12030(var_2, var_0);
    }

    waitframe();
  }
}

function ref_14369() {
  self endon("death");
  level waittill("game_ended");
  lb_mg_impulse_dmg_threshold_top();
}

function lb_mg_impulse_dmg_threshold_top() {
  self delete();
}

function ref_12027(var_0, var_1) {
  thread monitorweaponchange(var_1);
}

function ref_12030(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 notify("weapon_trader_trigger_exited_" + var_1.ref_1292c getentitynumber());
}

function monitorweaponchange(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("weapon_trader_trigger_exited_" + var_0.ref_1292c getentitynumber());
  var_1 = scripts\mp\gametypes\br_weapons::router_use_obj();

  for(;;) {
    if(!isDefined(var_1) || var_1.basename != "ks_use_crate_mp" && var_1.basename != "none") {
      ref_1400e(var_0, self, var_1);
    }

    self waittill("weapon_change", var_1);
    waitframe();
  }
}

function x1ops7() {
  level endon("game_ended");
  self endon("death");
  self endon("disabled");

  for(;;) {
    level scripts\engine\utility::ref_143a5("public_event_firesale_start", "public_event_firesale_end");
    self.playcrateimpactfx = [];
    ref_1400d();
  }
}

function ref_1400d() {
  if(isDefined(self.ref_1292c) && isDefined(self.ref_1292c.playersintrigger)) {
    foreach(var_1 in self.ref_1292c.playersintrigger) {
      var_2 = var_1.lastdroppableweaponobj;

      if(!isDefined(var_2) || var_2.basename != "ks_use_crate_mp" && var_2.basename != "none") {
        ref_1400e(var_1, var_2);
      }
    }

    return;
  }
}

function dangercircletick(var_0, var_1) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("trader") || getdvarint("scr_br_trader_ignore_circle", 0) == 1) {
    return;
  }

  var_2 = var_1 * var_1;

  foreach(var_4 in level.debug_trap_room.scriptables) {
    if(isDefined(var_4.visible) && distance2dsquared(var_4.origin, var_0) > var_2) {
      little_bird_mg_mp_ondeathrespawncallback(var_4);
    }
  }
}

function little_bird_mg_initspawning() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("trader")) {
    return;
  }

  foreach(var_1 in level.debug_trap_room.scriptables) {
    if(isDefined(var_1.visible)) {
      little_bird_mg_mp_ondeathrespawncallback(var_1);
    }
  }
}

function little_bird_mg_mp_ondeathrespawncallback(var_0) {
  var_0 setscriptablepartstate("br_armory_trader", "disabled");
  var_0.visible = undefined;
  var_0.disabled = 1;

  if(var_0 scripts\mp\gametypes\br_quest_util::gethelispawns()) {
    var_0 scripts\mp\gametypes\br_quest_util::lastdropedtime();
  }

  if(isDefined(var_0.ref_1292c)) {
    lb_mg_impulse_dmg_threshold_top(var_0.ref_1292c);
  }

  var_0 notify("disabled");
}

function registeraccesscardlocs() {
  if(!level.debug_trap_toggle) {
    return;
  }

  if(istrue(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("placedTraders"))) {
    return;
  }

  var_0 = getentitylessscriptablearrayinradius("scriptable_br_armory_trader", "classname");
  return var_0;
}

function ref_131c0(var_0) {
  level.debug_trap_room.scriptables = var_0;
}

function run_module_pause_funcs(var_0, var_1) {
  var_2 = var_0;

  if(updatecollectionuiforplayer(var_1)) {
    var_2 = 11;
  } else if(var_0 == 5 || var_0 == 6) {
    var_2 = 4;
  }

  return var_2;
}

function ref_1400e(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;

  if(vars_print(var_0, var_1)) {
    var_5 = restore_ai_weapon(var_0, var_1);
    var_2 = var_5[0];
    var_3 = var_5[1];
    var_4 = var_5[2];
    var_5 = undefined;
  }

  if(!isDefined(var_2)) {
    var_6 = ref_13ffe(0, undefined, 0, 4);
    var_0 setclientomnvar("ui_br_weapon_trader_trade_data0", var_6);
    return;
  }

  var_7 = run_module_pause_funcs(var_3, var_1);
  var_8 = [];

  for(var_9 = 0; var_9 < 2; var_9++) {
    var_8 = -1;
  }

  if(!istrue(var_1.van_blocker_moves)) {
    var_10 = 134217728;
    var_10 = ~var_10;
    var_8 = var_8[1] &var_10;
  }

  var_11 = 0;
  var_8 = ref_13ffe(var_8[var_11], var_7, 0, 4);
  var_12 = run_maze_ai_common_function_stealth(var_1, level.debug_trap_room.ref_13c65[self.ref_13c6b], var_7);

  if(isDefined(var_12)) {
    var_13 = 4;
    var_8 = ref_13ffe(var_8[var_11], var_4, var_13, 4);
    var_13 += 4;
    var_8 = ref_13ffe(var_8[var_11], var_6, var_13, 4);
    var_13 += 4;

    foreach(var_15 in var_12) {
      var_16 = removenonvipteamlocations(var_15);
      var_8 = ref_13ffe(var_8[var_11], var_16, var_13, 9);
      var_13 += 9;

      if(var_13 + 9 >= 32) {
        var_13 = 0;
        var_11++;
      }
    }
  }

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_1 setclientomnvar("ui_br_weapon_trader_trade_data" + var_9, var_8[var_9]);
  }
}

function updatecollectionuiforplayer(var_0) {
  if(!scripts\mp\gametypes\br_publicevents::upload_station_interact_used_think(2)) {
    return false;
  }

  return !scripts\engine\utility::array_contains(self.playcrateimpactfx, var_0);
}

function removenonvipteamlocations(var_0) {
  return level.br_pickups.br_itemrow[var_0];
}

function relic_vampire_feedback(var_0) {
  if(isDefined(var_0) && isDefined(level.br_lootiteminfo[var_0]) && isDefined(level.br_lootiteminfo[var_0].playerstartbesttimeupdate)) {
    return level.br_lootiteminfo[var_0].playerstartbesttimeupdate;
  }

  return undefined;
}

function ref_13ffe(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = int(pow(2, var_3 + 1) - 1);
  }

  var_4 = int(pow(2, var_3)) - 1;
  var_4 <<= var_2;
  var_5 = ~var_4;
  var_0 &= var_5;
  var_6 = var_1 << var_2;
  var_0 |= var_6;
  return var_0;
}

function get_car_stop_struct(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return false;
  }

  if(istrue(level.gameended)) {
    return false;
  }

  if(!var_1 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_1.inlaststand)) {
    return false;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isusingremote()) {
    return false;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(istrue(var_1 scripts\mp\gametypes\br_gametypes::ref_12e05("playerSkipKioskUse", var_0))) {
    return false;
  }

  if(istrue(var_1.iscarrying) && !isDefined(var_1.get_search_turret_target_player)) {
    var_1 scripts\mp\hud_message::showerrormessage("MP/FIELD_UPGRADE_CANNOT_USE");
    return false;
  }

  if(!vars_print(var_1, var_2)) {
    return false;
  }

  return true;
}

function vars_print(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.inventorytype) || var_0 != self getcurrentweapon() && var_0 != self getcurrentprimaryweapon()) {
    return false;
  }

  if(var_0.inventorytype != "primary" && var_0.inventorytype != "altmode") {
    return false;
  }

  return true;
}

function camera_loadout_showcase_preview_large_sticker_alt1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3 scripts\mp\gametypes\br_weapons::router_use_obj();

  if(!get_car_stop_struct(var_0, var_3, var_5)) {
    return;
  }

  var_6 = restore_ai_weapon(var_3, var_5);
  var_7 = var_6[0];
  var_8 = var_6[1];
  var_9 = var_6[2];
  var_6 = undefined;

  if(!isDefined(var_7)) {
    return;
  }

  var_0 notify("trader_use_start");
  thread ref_13c6c();

  if(var_2 == "visible") {
    var_0 setscriptablepartstate("br_armory_trader", "opening");
    thread ref_13c66();
  }

  if(istrue(var_3.tracking_max_health)) {
    var_3 notify("br_try_armor_cancel");
  }

  var_10 = run_module_pause_funcs(var_0, var_7, var_3);
  var_3.camera_character_preview_select_detail = spawnStruct();
  var_3.camera_character_preview_select_detail.curprogress = 0;
  var_3.camera_character_preview_select_detail.usetime = run_to_retreat_spot(var_0, var_3, var_10);
  var_3.camera_character_preview_select_detail.ref_14099 = rooftop_crate_usefunc(var_0, var_3, var_10);
  var_3.camera_character_preview_select_detail.ref_145a2 = var_5;
  ref_1387e(var_3, var_0, var_5);
  var_11 = ref_1448c(var_3, var_0);

  if(isDefined(var_3)) {
    ref_138f4(var_3, var_0, var_11);
  }

  if(istrue(var_11)) {
    var_3 scripts\cp\vehicles\vehicle_compass_cp::ref_120a8("trader");
    thread advance_bomb_wire_list(var_3, var_0, var_5, var_7);
  }

  var_3.camera_character_preview_select_detail = undefined;
}

function ref_13c6c() {
  self endon("trader_use_start");
  level endon("game_ended");

  for(var_0 = 0; var_0 < 30; var_0 = 0) {
    wait 1.5;
    var_0 += 1.5;
    var_1 = scripts\mp\utility\player::getplayersinradius(self.origin, 175);

    if(var_1.size > 0) {}
  }

  self setscriptablepartstate("br_armory_trader", "closing");
  self.forceextractscriptable = tr_entergulag();
  ref_1400d();
  thread ref_13c67();
}

function ref_13c67() {
  self endon("trader_use_start");
  level endon("game_ended");

  for(var_0 = 1; var_0; var_0 = var_1.size > 0) {
    wait 2;
    var_1 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);
  }

  heatcounter();
}

function heatcounter() {
  wait 2;
  var_0 = getdvarfloat("player_itemUseRadius", 128) + 16;
  var_1 = canceljoins(undefined, undefined, self.origin, var_0);

  if(getdvarint("scr_armory_trader_use_drop_grid", 1)) {
    var_1 = scripts\engine\utility::array_combine_unique(var_1, getlootscriptablearraydropgridshape());
  }

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(!scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var_3, 0)) {
        continue;
      }

      if(var_3 getscriptableisreserved() && !isDefined(var_3.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11a21(var_3);
    }

    return;
  }
}

function ref_1448c(var_0, var_1) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1.id = "weapon_trade";
  var_1.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);
  playusesound(var_0, var_0.camera_character_preview_select_detail.ref_14099);

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && get_aitypes_and_weights_from_call_counter(var_0, var_1) && var_0 useButtonPressed()) {
    var_0.camera_character_preview_select_detail.curprogress += level.framedurationseconds * var_1.userate;

    if(var_0.camera_character_preview_select_detail.curprogress >= var_0.camera_character_preview_select_detail.usetime) {
      var_0.camera_character_preview_select_detail.curprogress = 0;
      return true;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 1, var_0.camera_character_preview_select_detail);
    waitframe();
  }

  if(isDefined(var_0.camera_character_preview_select_detail) && isDefined(var_0.camera_character_preview_select_detail.curprogress)) {
    var_0.camera_character_preview_select_detail.curprogress = 0;
  }

  return false;
}

function get_aitypes_and_weights_from_call_counter(var_0, var_1) {
  if(!scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 meleeButtonPressed()) {
    return false;
  }

  if(var_0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  if(!isDefined(var_0.camera_character_preview_select_detail) || !var_0 hasweapon(var_0.camera_character_preview_select_detail.ref_145a2)) {
    return false;
  }

  var_2 = getdvarfloat("player_itemUseRadius", 128) + 16;
  var_3 = var_2 * var_2;

  if(distancesquared(var_0.origin, var_1.origin) > var_3) {
    return false;
  }

  return true;
}

function ref_1387e(var_0, var_1, var_2) {
  thread camera_loadout_showcase_preview_charm_alt4(var_0);
  var_0 scripts\mp\playeractions::allowactionset("crateUse", 0);
  var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0, var_0.camera_character_preview_select_detail);
  var_0 setclientomnvarbit("ui_br_weapon_trader_trade_data1", 27, 1);
  var_0.van_blocker_moves = 1;
}

function ref_138f4(var_0, var_1, var_2) {
  var_0 scripts\mp\playeractions::allowactionset("crateUse", 1);

  if(isDefined(var_0.camera_character_preview_select_detail)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(var_1, 0, var_0.camera_character_preview_select_detail);
    stopusesound(var_0, var_0.camera_character_preview_select_detail.ref_14099);
  }

  var_0 setclientomnvarbit("ui_br_weapon_trader_trade_data1", 27, 0);
  var_0 notify("trader_use_end", var_2);
  var_0.van_blocker_moves = undefined;
}

function playusesound(var_0, var_1) {
  var_0 playlocalsound(var_1);
}

function stopusesound(var_0, var_1) {
  var_0 stoplocalsound(var_1);

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 playsoundonmovingent("WTS_gear_spurts_out");
    return;
  }
}

function camera_loadout_showcase_preview_charm_alt4(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  var_1 = getcompleteweaponname("ks_use_crate_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
  thread camera_loadout_showcase_preview_large_sticker(var_1, var_0);
  self switchtoweapon(var_1);
}

function camera_loadout_showcase_preview_large_sticker(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("trader_use_end", var_2);

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  if(!istrue(var_2) && isDefined(var_1)) {
    var_3 = scripts\cp_mp\utility\weapon_utility::ref_12cc7(var_1);
    self switchtoweapon(var_3);
    thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_3);
    return;
  }
}

function ref_13c66() {
  if(!getdvarint("scr_br_trader_fix_prone_players", 1)) {
    return;
  }

  var_0 = getdvarfloat("scr_br_trader_fix_prone_players_radius", 300);
  scripts\mp\gametypes\br_functional_poi::player_give_intel_1_ks(var_0);
}

function advance_bomb_wire_list(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) || !isDefined(var_3)) {
    return;
  }

  ref_121e6(var_2);

  if(var_3 == 11) {
    var_0.playcrateimpactfx = scripts\engine\utility::array_add(var_0.playcrateimpactfx, self);
  }

  self takeweapon(var_1);

  if(!self hasweapon("iw8_fists_mp")) {
    self giveweapon("iw8_fists_mp");
  }

  self switchtoweapon("iw8_fists_mp");
  var_4 = ref_13657(var_0, self, level.debug_trap_room.ref_13c65[var_0.ref_13c6b], var_3);

  if(level.debug_trap_toggle && !scripts\mp\gametypes\br_public::turret_headicon()) {
    thread scripts\mp\utility\points::giveunifiedpoints("br_armory_trader_use", undefined, safehouse_spawn(var_2));
  }

  if(!isDefined(var_4)) {
    var_4 = [];
  }

  var_5 = 0;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
    var_5 = level.br_circle.circleindex;
  }

  self dlog_recordplayerevent("dlog_event_armory_trade", ["weapon_rarity", var_2, "trade_rarity", var_3, "circle_index", var_5, "received_items", var_4]);
}

function run_to_retreat_spot(var_0, var_1) {
  if(!isDefined(var_1)) {
    return getdvarfloat("scr_br_trader_use_time_0", level.debug_trap_room.ref_140a2[0]);
  } else if(var_1 == 11) {
    return getdvarfloat("scr_br_trader_firesale_use_time", 3);
  }

  var_1 = int(clamp(var_1, 0, 4));
  return getdvarfloat("scr_br_trader_use_time_" + var_1, level.debug_trap_room.ref_140a2[var_1]);
}

function rooftop_crate_usefunc(var_0, var_1) {
  if(!isDefined(var_1)) {
    return "WTS_rarity_common";
  } else if(var_1 == 11) {
    return "WTS_rarity_firesale";
  }

  var_1 = int(clamp(var_1, 0, 4));
  return level.debug_trap_room.ref_1409a[var_1];
}

function safehouse_spawn(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  } else if(var_0 == 11) {
    return 100;
  }

  var_0 = int(clamp(var_0, 0, 4));
  return level.debug_trap_room.xp[var_0];
}

function restore_ai_weapon(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = createheadicon(var_0 getnoaltweapon());

  if(isDefined(level.br_pickups.br_weapontoscriptable[var_5])) {
    var_6 = level.br_pickups.br_weapontoscriptable[var_5];

    if(isDefined(var_6)) {
      var_2 = level.br_pickups.delay_hide_player_clip[var_6];
      var_3 = original_health(var_0);
      var_7 = scripts\mp\utility\weapon::relic_nuketimer_globalthread(var_0.basename);
      var_4 = removespecialistbonuspickup(var_7);
    }
  } else if(scripts\mp\gametypes\br_weapons::vandalize_attack_max_cooldown(var_0)) {
    var_2 = restorekillstreakplayerangles(var_5);

    if(!isDefined(var_2)) {
      var_3 = original_health(var_0);
      var_7 = scripts\mp\utility\weapon::relic_nuketimer_globalthread(var_0.basename);
      var_4 = removespecialistbonuspickup(var_7);
      var_2 = getcustomweaponrarity(var_3, var_4);
    }
  }

  return [var_2, var_3, var_4];
}

function getcustomweaponrarity(var_0, var_1) {
  var_2 = 0;

  if(var_0 == var_1) {
    var_2 = 5;
  } else if(var_0 == 0) {
    var_2 = 0;
  } else if(var_1 == 0) {
    var_2 = 0;
  } else if(var_1 > 5) {
    var_3 = [3, 5, 6, 8, 10];

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_0 <= var_3[var_4]) {
        var_2 = var_4;
        break;
      }
    }
  } else {
    var_5 = float(var_0 - 1) / float(var_1);
    var_2 = int(var_5 / 0.2);
  }

  return var_2;
}

function restorekillstreakplayerangles(var_0) {
  var_1 = strtok(var_0, "_");

  if(var_1.size > 1) {
    if(var_1[1] == "me") {
      return 2;
    } else if(var_1[1] == "la") {
      return 2;
    }
  }

  return undefined;
}

function original_health(var_0) {
  var_1 = scripts\cp\vehicles\vehicle_compass_cp::runleadmarkers(var_0);
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4 != "") {
      var_2++;
    }
  }

  return var_2;
}

function removespecialistbonuspickup(var_0) {
  var_1 = tablelookup("mp/statstable.csv", 5, var_0, 18);

  if(isDefined(var_1) && var_1 != "") {
    var_1 = int(var_1);
  } else {
    var_1 = 0;
  }

  return var_1;
}

function ref_13c68(var_0, var_1) {
  var_2 = self.forceextractscriptable;

  if(var_1 != 0) {
    var_2 = scripts\engine\utility::ter_op(var_2 > self.ref_11b72, var_2 >> var_1, var_2 << var_1);
  }

  return var_2 % var_0;
}

function ref_13c69(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_2 += var_4.weight;
  }

  if(var_2 == 0) {
    return undefined;
  }

  var_6 = ref_13c68(var_2, var_1);
  var_7 = 0;

  foreach(var_4 in var_0) {
    var_7 += var_4.weight;

    if(var_7 >= var_6) {
      return var_4.ref_12a7f;
    }
  }

  return undefined;
}

function run_maze_ai_common_function_stealth(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return undefined;
  }

  var_3 = run_lbravos_safehouse(var_2, var_1);
  var_4 = var_1[var_3];
  var_5 = ref_13c69(var_4.entries, 0);
  var_5 = vehicle_collision_update(var_5, var_2);
  return scripts\engine\utility::array_removeundefined(var_5);
}

function registerbrgametypefunc(var_0) {
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  return scripts\mp\gametypes\br_weapons::debug_spawning(var_1, var_0);
}

function battle_tracks_onentervehicle(var_0, var_1) {
  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      if(isDefined(level.br_lootiteminfo[var_3]) && isDefined(level.br_lootiteminfo[var_3].baseweapon)) {
        var_0 = registerbrgametypefunc(level.br_lootiteminfo[var_3].baseweapon);
      }
    }
  }

  return var_0;
}

function dialog_play_shieldstow(var_0, var_1) {
  if(scripts\mp\gametypes\br_weapons::trial_vehicle(var_0)) {
    var_2 = getdvarint("scr_br_armory_trader_received_ammo_stack_count", 2);
    var_1 *= var_2;
  }

  return var_1;
}

function ref_13657(var_0, var_1, var_2) {
  var_3 = run_maze_ai_common_function_stealth(var_0, var_1, var_2);

  if(!isDefined(var_3) || var_3.size == 0) {
    return var_3;
  }

  var_3 = battle_tracks_onentervehicle(var_3, var_2);
  var_4 = spawnStruct();
  var_5 = anglesToForward((0, self.angles[1], 0));
  var_4.origin = self.origin + var_5 * 25;
  var_4.angles = (0, self.angles[1], 0);
  var_4.itemsdropped = 0;
  var_4.intro_ride = &dialog_reachnextcheckpoint;
  var_4.intro_moveplayercliphack = &dialog_play_shieldstow;
  var_4.ref_13a77 = var_0;
  var_4.intro_heli_add_player = 60;
  var_4.trader = self;
  var_6 = var_4 scripts\mp\gametypes\br_lootcache::ref_11a42(var_3, 0, undefined);
  return var_3;
}

function lootspawndefault(var_0, var_1) {
  var_2 = [0, 50, -50, 25, -25, 80, -80];
  var_3 = self.ref_13a77.origin - var_0;
  var_4 = max(length2d(var_3) - 15, 30);
  var_5 = vectorcross(var_3, (0, 0, 1));
  var_5 = vectorNormalize(var_5);
  var_6 = randomfloatrange(-5, 5);
  var_7 = var_2[var_1.ml_p3_to_safehouse_transition % var_2.size] + var_6;
  var_8 = var_5 * var_7;
  var_8 = var_0 + var_3 + var_8;
  return [var_8, var_6, var_4];
}

function lootspawndropgrid(var_0, var_1) {
  var_2 = 32.5;
  var_3 = 360 / var_1.totaldropcount * var_1.ml_p3_to_safehouse_transition;
  var_4 = vectorNormalize(self.ref_13a77.origin - var_0);
  var_4 *= var_2;
  var_4 += var_0;
  self.dropgrid = sortpointsbydistance(self.trader.dropgrid, var_4);
  var_5 = undefined;

  foreach(var_7 in self.dropgrid) {
    var_8 = canceljoins(undefined, undefined, var_7, var_2);

    if(isDefined(var_8) && var_8.size == 0) {
      var_9 = scripts\mp\utility\player::getplayersinradius(var_7, var_2);

      if(var_9.size == 0 || var_9.size == 1 && var_9[0] == self.ref_13a77) {
        var_5 = var_7;
        break;
      }
    }
  }

  var_5 = undefined;
  var_8 = undefined;

  if(!isDefined(var_4)) {
    var_4 = self.dropgrid[0];
  }

  if(var_0.totaldropcount > 1) {
    var_11 = randomfloatrange(-15, 15);
    var_4 += rotatevector((-20, 0, 0), (0, var_2 + var_11, 0));
  }

  var_12 = var_4 - < error > ;
  var_13 = max(length2d(var_12), 30);
  return [var_4, 0, var_13];
}

function dialog_reachnextcheckpoint(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  jumpiffalse(getdvarint("scr_armory_trader_use_drop_grid", 1)) LOC_00000040;
  var_8 = lootspawndropgrid(var_2, var_1);
  var_9 = var_8[0];
  var_10 = var_8[1];
  var_11 = var_8[2];
  var_8 = undefined;
  goto LOC_00000064;
}

function sortpointsbydistance(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = spawnStruct();
    var_5.point = var_4;
    var_5.loot_choppers = distancesquared(var_4, var_1);
    var_2 = var_5;
  }

  var_2 = scripts\mp\utility\script::quicksort(var_2, &comparepointdistance);
  var_7 = [];

  foreach(var_9 in var_2) {
    var_7 = var_9.point;
  }

  return var_7;
}

function comparepointdistance(var_0, var_1) {
  return var_0.loot_choppers <= var_1.loot_choppers;
}

function initdropgrid() {
  var_0 = 32.5;
  var_1 = [];
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);

  for(var_4 = -3; var_4 < 3; var_4++) {
    for(var_5 = 0; var_5 < 3; var_5++) {
      var_6 = var_5 * 65 + var_0 + 30;
      var_7 = var_4 * 65 + var_0;
      var_8 = self.origin + var_6 * var_2 + var_7 * var_3;

      if(scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, 20), var_8 + (0, 0, 20))) {
        var_1 = var_8;
      }
    }
  }

  self.dropgrid = var_1;
}

function getdropgridshape() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = var_0 * 225;
  var_3 = var_1 * 195;
  var_4 = self.origin - var_3;
  var_5 = var_4 + var_2;
  var_6 = self.origin + var_3;
  var_7 = var_6 + var_2;
  return [var_4, var_5, var_7, var_6];
}

function isinsidedropgridshape(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = (var_2 + 1) % var_1.size;

    if(!use_nvg_think(var_0, var_1[var_2], var_1[var_3])) {
      return false;
    }
  }

  return true;
}

function use_nvg_think(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]) < 0;
}

function getlootscriptablearraydropgridshape() {
  var_0 = getdropgridshape();
  var_1 = var_0[1];
  var_2 = distance(var_1, self.origin);
  var_3 = canceljoins(undefined, undefined, self.origin, var_2);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(abs(var_6.origin[2] - self.origin[2]) < 30 && isinsidedropgridshape(var_6.origin, var_0)) {
      var_4 = var_6;
    }
  }

  return var_4;
}

function run_lbravos_safehouse(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_1) {
    foreach(var_6 in var_4.ref_13a31) {
      var_7 = risktokenstokeep(var_6);
      var_8 = isint(var_7) && isint(var_0);
      var_8 |= isstring(var_7) && isstring(var_0);

      if(var_8 && var_7 == var_0) {
        var_2 = var_10;
      }
    }
  }

  return var_2;
}

function risktokenstokeep(var_0) {
  var_1 = undefined;
  var_2 = strtok(var_0, "_");

  if(var_2.size == 1) {
    var_1 = var_2;
  } else if(var_2.size == 2) {
    var_1 = int(var_2[0]);
  }

  return var_1;
}

function get_bombzone_node_to_plant_on(var_0) {
  return !level.br_pickups.delay_give_lethal_grenade[var_0] && !scripts\engine\utility::array_contains(level.debug_trap_room.ref_11a20, var_0) && !scripts\engine\utility::array_contains(level.debug_trap_room.play_lighting_sequence, var_0);
}

function ref_12e83(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = 1;

    if(isDefined(level.br_lootiteminfo[var_3])) {
      var_5 = weaponclass(level.br_lootiteminfo[var_3].playerstartjailsetcontrols);
      var_4 = !isDefined(var_5) || var_5 != "pistol";
    }

    if(var_4 && get_bombzone_node_to_plant_on(var_3)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

function ref_12e84(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(get_bombzone_node_to_plant_on(var_4)) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function play_music_on_wave_reinforce(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(level.br_pickups.delay_hide_player_clip[var_5] == var_1) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function filterpickupitembyrarity_intindexed(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(level.br_pickups.delay_hide_player_clip[var_4] == var_1) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function vehicle_collision_update(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(level.br_pickups.br_itemtype[var_4])) {
      if(getdvarint("scr_br_armory_trader_allow_plunder", 1) == 0 && isstartstr(var_4, "brloot_plunder_cash_")) {
        continue;
      }

      if(get_bombzone_node_to_plant_on(var_4)) {
        var_2 = var_4;
      }

      continue;
    }

    var_5 = strtok(var_4, "_");
    var_6 = int(var_5[0]);

    if(var_5.size > 1 && isnumber(var_6)) {
      if(var_5[1] == "weapon") {
        var_7 = ref_12e83(level.br_pickups.delay_safe_spawn_chopper_boss[var_6]);
        var_2 = risk_flagspawnminactivetospawn(var_7, var_1);
      } else if(var_5[1] == "super") {
        var_7 = ref_12e84(level.br_pickups.br_superreference);
        var_7 = play_music_on_wave_reinforce(var_7, var_6);
        var_2 = risk_flagspawnmincount(var_7, var_1);

        if(!istrue(level.debug_trap_room.advancedsupplydroperror) && getdvarint("scr_advancedSupplyDropErrorCheck", 1)) {
          doadvancedsupplydroperrorcheck(var_7, var_2);
        }
      } else if(var_5[1] == "killstreak") {
        var_7 = ref_12e84(level.br_pickups.br_killstreakreference);
        var_7 = ref_12c29(var_7);
        var_7 = play_music_on_wave_reinforce(var_7, var_6);
        var_2 = risk_flagspawnmincount(var_7, var_1);
      } else if(var_5[1] == "perkpoint") {
        var_7 = ref_12e83(level.br_pickups.br_perkpoints);
        var_7 = filterpickupitembyrarity_intindexed(var_7, var_6);
        var_2 = risk_flagspawnminactivetospawn(var_7, var_1);
      }
    } else if(var_5[0] == "lethal") {
      var_7 = ref_12e83(level.br_pickups.delay_push_player_clear_door_way);
      var_2 = risk_flagspawnminactivetospawn(var_7, var_1);
    } else if(var_5[0] == "tactical") {
      var_7 = ref_12e83(level.br_pickups.deletesoundents);
      var_2 = risk_flagspawnminactivetospawn(var_7, var_1);
    }
  }

  return var_2;
}

function doadvancedsupplydroperrorcheck(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4 == "super_supply_drop" || var_4 == "brloot_offhand_advancedsupplydrop") {
      var_2 = "br_armory_trader can give a super_supply_drop which shouldn't. FilterItem size : " + level.debug_trap_room.play_lighting_sequence.size + " item: " + var_4;
      break;
    }
  }

  var_6 = var_1[var_1.size - 1];

  if(var_6 == "super_supply_drop" || var_6 == "brloot_offhand_advancedsupplydrop") {
    if(!isDefined(var_2)) {
      var_2 = "";
    }

    var_2 += " br_armory_trader is giving " + var_6 + " which shouldn't.";
  }

  if(isDefined(var_2)) {
    level.debug_trap_room.advancedsupplydroperror = 1;
    logtraderfilter();
    scripts\mp\utility\script::laststand_dogtags(var_2);
    return;
  }
}

function ref_12c29(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_4 != "brloot_specialist_bonus") {
      var_1 = var_3;
    }
  }

  return var_1;
}

function risk_flagspawnminactivetospawn(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && var_0.size > 0) {
    var_3 = ref_13c68(var_0.size, var_1);
    var_2 = var_0[var_3];
  }

  return var_2;
}

function risk_flagspawnmincount(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && var_0.size > 0) {
    var_3 = ref_13c68(var_0.size, var_1);
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_4 == var_3) {
        var_2 = var_7;
        break;
      }

      var_4++;
    }
  }

  return var_2;
}

function ref_121e6(var_0) {
  if(var_0 == 4) {
    scripts\cp\vehicles\vehicle_compass_cp::ref_12004("tw_leg");
    return;
  }
}
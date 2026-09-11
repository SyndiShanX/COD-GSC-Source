/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bunker_utility.gsc
******************************************************/

function init() {
  teamrevivefiresalediscount();
  teamsplashbr();
  teamreviveperkdiscount();
  top_roof_enemy_watcher();
}

#using_animtree("");

function teamrevivefiresalediscount() {
  level.scr_animtree["bunker_door"] = #animtree;
  level.scr_anim["bunker_door"]["door_open"] = $mp_verdansk_bunkerdoor_open;
  level.scr_animname["bunker_door"]["door_open"] = "mp_verdansk_bunkerdoor_open";
  level.scr_anim["bunker_door"]["door_open_puzzle"] = % mp_verdansk_bunkerdoor_open_puzzle;
  level.scr_animname["bunker_door"]["door_open_puzzle"] = "mp_verdansk_bunkerdoor_open_puzzle";
}

function teamsplashbr() {}

function teamsassigned(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    if(var_5.script_noteworthy == "right_door_clip") {
      var_0.heli_anim = var_5;
      var_0.heli_anim setnonstick(1);
      continue;
    }

    if(var_5.script_noteworthy == "left_door_clip") {
      var_0.heli_approach_instruct = var_5;
      var_0.heli_approach_instruct setnonstick(1);
    }
  }

  var_0.animname = "bunker_door";
  var_0 scripts\common\anim::setanimtree();

  if(!istrue(var_2)) {
    thread teamspawnfunc(level, var_0);
  }

  var_7 = anglesToForward(var_0.angles);
  var_8 = var_0.origin + (0, 0, -110) + var_7 * -128;
  var_9 = getEnt("clip256x256x256", "targetname");
  var_10 = spawn("script_model", var_8);
  var_10.angles = var_0.angles;
  var_10 clonebrushmodeltoscriptmodel(var_9);
  var_0.battle_tracks_isbattletracksowner = var_10;
}

function teamspawnfunc(var_0, var_1) {}

function ref_12121(var_0, var_1, var_2, var_3) {}

function ref_13619(var_0, var_1) {
  if(!isDefined(level.br_pickups)) {
    return;
  }

  var_2 = relic_bullet_reward_hud_display(var_0, var_1);
  var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = getdvarint("scr_br_bunkerCache_Lege_Min", 0);
  var_9 = getdvarint("scr_br_bunkerCache_Lege_Max", 1);
  var_10 = getdvarint("scr_br_bunkerCache_Basic_Min", 1);
  var_11 = getdvarint("scr_br_bunkerCache_Basic_Max", 2);

  foreach(var_13 in var_3) {
    if(var_13.script_noteworthy == "br_loot_cache_lege") {
      var_4 = var_13;
      continue;
    }

    if(var_13.script_noteworthy == "br_loot_cache") {
      var_5 = var_13;
      continue;
    }

    if(issubstr(var_13.script_noteworthy, "uniqueLootItem")) {
      var_6 = var_13;
      continue;
    }

    var_7 = var_13;
  }

  var_15 = randomintrange(var_8, var_9);
  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_5 = scripts\engine\utility::array_randomize(var_5);

  for(var_16 = 0; var_16 < var_15; var_16++) {
    if(isDefined(var_4[var_16])) {
      var_17 = easepower(var_4[var_16].script_noteworthy, var_4[var_16].origin, var_4[var_16].angles);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var_17);
    }
  }

  var_15 = randomintrange(var_10, var_11);

  for(var_16 = 0; var_16 < var_15; var_16++) {
    if(isDefined(var_5[var_16])) {
      var_17 = easepower(var_5[var_16].script_noteworthy, var_5[var_16].origin, var_5[var_16].angles);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var_17);
    }
  }

  foreach(var_13 in var_6) {
    if(isDefined(var_13.script_noteworthy)) {
      var_19 = ref_13f0b(var_13.script_noteworthy);
      var_20 = remove_reduce_recoil(var_19);
      var_21 = var_13.origin;
      var_22 = var_13.angles;

      if(var_13.script_noteworthy == "uniqueLootItem_1") {
        if(level.mapname == "mp_bm_bunker01") {
          switch (var_24) {
            case 0:
              continue;
            case 1:
              var_21 = (1969, 639, 68);
              var_22 = (0, 106.6, 75);
              break;
            case 2:
              var_21 = (1962, 665, 68);
              var_22 = (0, 106.6, 75);
              break;
          }
        } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
          switch (var_24) {
            case 0:
              continue;
            case 1:
              var_21 = (-3858, 62596, 573);
              var_22 = (0, 106.6, 75);
              break;
            case 2:
              var_21 = (-3850, 62571, 573);
              var_22 = (0, 106.6, 75);
              break;
          }
        }
      }

      var_23 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_21, var_22);
      var_17 = scripts\mp\gametypes\br_pickups::spawnpickup(var_19, var_23, var_20, 0);

      if(isDefined(var_17)) {
        var_17.ref_13f0a = var_13.script_noteworthy;
      }
    }
  }

  foreach(var_13 in var_7) {
    if(isDefined(var_13.script_noteworthy)) {
      var_26 = var_13.script_noteworthy;

      if(var_13.script_noteworthy == "jugg_minigun") {
        if(getdvarint("scr_br_spawnBunkerMiniGun", 1) == 0) {
          continue;
        }

        var_26 = "brloot_weapon_lm_dblmg_lege";
      } else if(var_13.script_noteworthy == "jugg_minigun_chance") {
        var_27 = randomintrange(1, 100);

        if(var_27 > getdvarint("scr_br_chanceForBunkerSpecialLoot", 60)) {
          continue;
        } else {
          var_26 = safehouse_hotjoin_func();
        }
      }

      var_20 = remove_reduce_recoil(var_26);
      var_23 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_13.origin, var_13.angles);
      var_17 = scripts\mp\gametypes\br_pickups::spawnpickup(var_26, var_23, var_20, 0);
    }
  }
}

function remove_reduce_recoil(var_0) {
  if(isDefined(level.br_pickups.counts[var_0])) {
    return level.br_pickups.counts[var_0];
  } else if(isDefined(level.br_lootiteminfo[var_0])) {
    return level.br_lootiteminfo[var_0].playerstartjailsetcontrols.clipsize;
  } else if(isDefined(level.br_ammo_clipsize[var_0])) {
    return level.br_ammo_clipsize[var_0];
  }

  return 1;
}

function ref_13f0b(var_0) {
  switch (var_0) {
    case "uniqueLootItem_2":
    case "uniqueLootItem_1":
    default:
      break;
  }
}

function safehouse_hotjoin_func() {
  var_0 = 0;
  var_1 = 0;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(level.gametype == "br" && (var_2 == "br" || var_2 == "jugg" || var_2 == "mini")) {
    var_0 = 2;
    var_1 = 2;
  }

  var_3 = getdvarint("scr_br_lootbunkerChance_AUAV", 0);
  var_4 = getdvarint("scr_br_lootBunkerChance_Specialist", 0);
  var_5 = getdvarint("scr_br_lootBunkerChance_LoadoutDrop", 0);
  var_6 = getdvarint("scr_br_lootBunkerChance_Gasmask", 0);
  var_7 = getdvarint("scr_br_lootBunkerChance_MiniGun", 0);
  var_8 = getdvarint("scr_br_lootBunkerChance_JuggDrop", 0);
  var_9 = getdvarint("scr_br_lootBunkerChance_AssaultDrone", 0);
  var_10 = getdvarint("scr_br_lootBunkerChance_CirclePeek", 0);
  var_11 = 1 + var_3 + var_4 + var_5 + var_6 + var_7 + var_8 + var_9 + var_10;
  var_12 = randomintrange(1, var_11);

  if(var_12 <= var_3) {
    return "brloot_killstreak_auav";
  }

  if(var_12 <= var_3 + var_4) {
    return "brloot_specialist_bonus";
  }

  if(var_12 <= var_3 + var_4 + var_5) {
    return "brloot_offhand_advancedsupplydrop";
  }

  if(var_12 <= var_3 + var_4 + var_5 + var_6) {
    return "brloot_equip_gasmask_durable";
  }

  if(var_12 <= var_3 + var_4 + var_5 + var_6 + var_7) {
    return "brloot_weapon_lm_dblmg_lege";
  }

  if(var_12 <= var_3 + var_4 + var_5 + var_6 + var_7 + var_8) {
    return "brloot_killstreak_juggernaut";
  }

  if(var_12 <= var_3 + var_4 + var_5 + var_6 + var_7 + var_8 + var_9) {
    return "brloot_killstreak_assaultdrone";
  }

  return "brloot_killstreak_circle_peek";
}

function relic_bullet_reward_hud_display(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_1, "targetname");

  if(isDefined(var_2)) {
    if(var_2.size == 1) {
      return var_2[0];
    } else {
      var_3 = undefined;
      var_4 = undefined;

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        var_6 = distance2dsquared(var_0, var_2[var_5].origin);

        if(!isDefined(var_4) || var_6 < var_4) {
          var_4 = var_6;
          var_3 = var_2[var_5];
        }
      }

      return var_3;
    }
  }

  return undefined;
}

function binoculars_endadslogic(var_0) {
  if(tv_station_marker_player_connect_monitor(var_0.angles[1], 106, 1)) {
    var_1 = anglesToForward(var_0.angles);
    return [var_0.origin + var_1 * 30, (var_0.angles[0], 106, 90)];
  } else if(tv_station_marker_player_connect_monitor(var_1.angles[1], 90, 1)) {
    var_1 = anglesToForward(var_1.angles);
    return [var_1.origin - var_1 * 10, var_1.angles];
  } else if(tv_station_marker_player_connect_monitor(var_1.angles[1], 70, 1)) {
    return [var_1.origin, (var_1.angles[0], var_1.angles[1], 0)];
  }

  return [var_1.origin, var_1.angles];
}

function tv_station_marker_player_connect_monitor(var_0, var_1, var_2) {
  return abs(var_0 - var_1) <= var_2;
}

function loadout_given() {
  little_bird_mg_playercontrolmg((-17923, -42192, -252));
  little_bird_mg_playercontrolmg((-15045, 45467, -186));
  little_bird_mg_playercontrolmg((1992, 38955, 1378));
  little_bird_mg_playercontrolmg((49764, 34322, 206));
  little_bird_mg_playercontrolmg((52510, -32696, -119));
  little_bird_mg_playercontrolmg((47158, -10562, 131));
  little_bird_mg_playercontrolmg((-39282, -2005, -78));
  little_bird_mg_playercontrolmg((41919, -41349, -580));
  little_bird_mg_playercontrolmg((-38426, -19360, 403));
  little_bird_mg_playercontrolmg((21085, 16700, 246));
  little_bird_mg_playercontrolmg((17893, -34039, -561));
}

function little_bird_mg_onenterheavydamagestate() {
  little_bird_mg_playercontrolmg((-4337, 62466, 580));
}

function little_bird_mg_playercontrolmg(var_0, var_1) {
  var_2 = 2000;

  if(!isDefined(var_1)) {
    var_1 = var_2;
  }

  scripts\mp\gametypes\br_quest_util::little_bird_mg_playercontrolmg(var_0, var_1, 100);
}

function teamreviveperkdiscount() {
  level.flaglockedtimer = [];
  var_0 = scripts\engine\utility::getStructArray("bunker_back_keypad", "targetname");

  foreach(var_2 in var_0) {
    var_3 = easepower("maphint_keypad_bunker_interior", var_2.origin);
    var_3.chopper_glow_sticks = 1;

    if(isDefined(var_2.script_noteworthy)) {
      var_3.flagpickupchecks = int(var_2.script_noteworthy);
      level.flaglockedtimer[var_3.flagpickupchecks] = var_3;
    }
  }
}

function vehicleparent(var_0, var_1, var_2, var_3, var_4) {
  thread allies_spawn_function(level, var_0, var_1, var_2, var_3);
}

function allies_spawn_function(var_0, var_1, var_2, var_3, var_4) {
  var_0 setscriptablepartstate(var_1, "off");

  if(isDefined(var_0.ks_killleaders)) {
    thread vehicleaniminit(level, var_0);
  }

  vehiclelinkTo(var_3, var_0);

  if(isDefined(var_3)) {
    var_3 scripts\mp\gametypes\br_keypad_util::ref_12685(0);
  }

  wait 1;

  if(!isDefined(var_0.ks_killleaders) && !(istrue(var_0.opened) && istrue(var_0.little_bird_mg_initoccupancy))) {
    var_0 setscriptablepartstate(var_1, "on");
    return;
  }
}

function vehiclelinkTo(var_0) {
  level endon("game_ended");
  self endon("keypad_kickPlayerFromKeypadMSG");
  thread vehicle_watchmarkedtankdeath(var_0);
  thread vehiclegod(var_0);
  thread vehicleindangertracking(var_0);
  scripts\mp\gametypes\br_keypad_util::ref_12685(1);
  var_1 = 8;

  if(isDefined(var_0.helihint_activate_vo)) {
    var_1 = var_0.helihint_activate_vo;
  }

  scripts\mp\gametypes\br_keypad_util::ref_12683(var_1);
  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  jumpiffalse(istrue(var_0.helihint_wait) && var_0.helihint_activate_vo <= 5) LOC_00000080;
  scripts\mp\gametypes\br_keypad_util::ref_12684(var_0.helidrivablemission["array"]);

  while(isDefined(self) && scripts\mp\gametypes\br_keypad_util::removedeathicon() != 0) {
    self waittill("luinotifyserver", var_2, var_3);

    if(isDefined(var_2)) {
      if(var_2 == "submit_br_keypad") {
        if(getdvarint("scr_br_bunker_keypad_refresh_idle_timer_on_try", 0)) {
          thread vehicleindangertracking(var_0);
        }

        if(isDefined(var_0.helidrivablemission) && tv_station_reinforcement_spawn_logic(var_0, var_3)) {
          scripts\mp\gametypes\br_keypad_util::ref_12685(2);
          var_0.helileave = 2;

          if(isDefined(var_0.ref_1395d)) {
            [[var_0.ref_1395d]](var_0);
          }

          break;
        } else {
          if(soundexists("br_keypad_deny")) {
            playsoundatpos(self.origin, "br_keypad_deny");
          }

          var_0.helileave = 3;
          scripts\mp\gametypes\br_keypad_util::ref_12685(3);
          waitframe();

          if(isDefined(self)) {
            scripts\mp\gametypes\br_keypad_util::ref_12685(1);
          }
        }

        continue;
      }

      if(var_2 == "exit_br_keypad") {
        var_0.helileave = 3;

        if(isDefined(var_0.ks_killleaders)) {
          level notify(var_0.ks_killleaders);
        }

        break;
      }
    }
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("doneWithKeypad");
}

function vehicle_watchmarkedtankdeath(var_0) {
  self endon("keypad_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  self waittill("death_or_disconnect");

  if(isDefined(var_0.ks_killleaders)) {
    level notify(var_0.ks_killleaders);
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("keypad_kickPlayerFromKeypadMSG");
}

function vehiclegod(var_0) {
  self endon("keypad_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  self waittill("last_stand_start");

  if(isDefined(var_0.ks_killleaders)) {
    level notify(var_0.ks_killleaders);
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("keypad_kickPlayerFromKeypadMSG");
}

function vehicleindangertracking(var_0) {
  self endon("keypad_kickPlayerFromKeypadMSG");
  self notify("keypad_playerIdleWatch");
  self endon("keypad_playerIdleWatch");
  wait getdvarint("scr_br_bunker_keypad_idle_timer", 60);

  if(isDefined(var_0.ks_killleaders)) {
    level notify(var_0.ks_killleaders);
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("keypad_kickPlayerFromKeypadMSG");
}

function vehicleaniminit(var_0, var_1) {
  if(isDefined(var_0.ks_killleaders)) {
    level waittill(var_0.ks_killleaders);
  }

  var_0 setscriptablepartstate(var_1, "on");
}

function tv_station_reinforcement_spawn_logic(var_0, var_1) {
  if(!isDefined(var_0.helidrivablemission["string"])) {
    return false;
  }

  if(var_1 == -1) {
    return false;
  }

  var_2 = int(var_0.helidrivablemission["string"]);

  if(var_1 == var_2) {
    return true;
  }

  return false;
}

function pre_laserpanel_weapon(var_0, var_1) {
  var_2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_2 = scripts\engine\utility::array_randomize(var_2);
    var_1.helidrivablemission[var_3] = var_2[0];
    var_2 = scripts\engine\utility::array_remove(var_2, var_2[0]);
  }
}

function pre_get_in_anim_wait(var_0, var_1, var_2, var_3) {
  var_4 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var_1.helidrivablemission = [];

  if(!isDefined(var_2)) {
    var_2 = 0;
  } else {
    var_1.helidrivablemission["doubles"] = [];
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  } else {
    var_1.helidrivablemission["triples"] = [];
  }

  var_5 = var_0 - var_2 - var_3 * 2;
  var_6 = scripts\engine\utility::array_randomize(var_4);
  var_4 = [];
  var_7 = randomintrange(1, 9);

  foreach(var_9 in var_6) {
    if(var_10 == var_7) {
      var_4 = 0;
      continue;
    }

    var_4 = var_9;
  }

  for(var_11 = 0; var_11 < var_5; var_11++) {
    var_1.helidrivablemission["array"][var_11] = var_4[var_11];
  }

  var_12 = var_1.helidrivablemission["array"];

  for(var_11 = 0; var_11 < var_2; var_11++) {
    var_13 = var_12[var_11];
    var_1.helidrivablemission["array"][var_1.helidrivablemission["array"].size] = var_13;
    var_1.helidrivablemission["doubles"][var_1.helidrivablemission["doubles"].size] = var_13;
    var_12 = scripts\engine\utility::array_remove(var_12, var_12[var_11]);
  }

  for(var_11 = 0; var_11 < var_3; var_11++) {
    var_14 = var_12[var_11];

    for(var_15 = 0; var_15 < 2; var_15++) {
      var_1.helidrivablemission["array"][var_1.helidrivablemission["array"].size] = var_14;
    }

    var_1.helidrivablemission["triples"][var_1.helidrivablemission["triples"].size] = var_14;
    var_12 = scripts\engine\utility::array_remove(var_12, var_12[var_11]);
  }

  var_1.helidrivablemission["array"] = scripts\engine\utility::array_randomize(var_1.helidrivablemission["array"]);
  var_1.helidrivablemission["string"] = "";

  foreach(var_9 in var_1.helidrivablemission["array"]) {
    var_17 = "" + var_9;
    var_1.helidrivablemission["string"] = var_1.helidrivablemission["string"] + var_17;
  }
}

function ppkteamwithflag(var_0, var_1, var_2, var_3) {
  if(var_2 > var_0["doubles"].size) {
    var_2 = 0;
  }

  if(var_3 > var_0["triples"].size) {
    var_3 = 0;
  }

  var_4 = 0;
  var_5 = 0;
  var_6 = scripts\engine\utility::array_randomize(scripts\engine\utility::array_remove_duplicates(var_0["array"]));
  var_7 = [];

  for(var_8 = 0; var_8 < var_1; var_8++) {
    if(var_4 < var_2) {
      var_9 = var_0["doubles"][var_4];
      var_4++;
    } else if(var_5 < var_3) {
      var_9 = var_0["triples"][var_5];
      var_5++;
    } else {
      var_9 = var_6[0];
    }

    var_7 = var_8 + 1;
    var_6 = scripts\engine\utility::array_remove(var_6, var_9);
  }

  var_10 = [];
  var_11 = getarraykeys(var_7);

  foreach(var_19, var_13 in var_11) {
    var_10 = var_0["array"];
    var_14 = 0;

    foreach(var_18, var_16 in var_10[var_19]) {
      if(var_16 == var_13 && var_14) {
        var_10[var_18] = "symbol" + var_7[var_13];
        var_17 = 1;
        continue;
      }

      if(var_16 == var_13 && !var_14) {
        var_14 = 1;
        continue;
      }

      if(scripts\engine\utility::array_contains(var_11, var_16)) {
        var_10[var_18] = "symbol" + var_7[var_16];
      }
    }
  }

  return var_10;
}

function cargo_truck_mg_getspawnstructscallback(var_0, var_1) {
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_4, var_3 in var_0) {
    if(var_4 > var_1.size) {
      var_4 = 0;
    }

    var_3.scriptable.logplayermatchend = var_4;
  }
}

function relic_dogtags(var_0, var_1) {
  return var_0.logplayermatchstart[var_1];
}

function ref_119a3(var_0) {
  if(isDefined(var_0.doors)) {
    foreach(var_2 in var_0.doors) {
      var_2 scriptabledoorfreeze(1);
    }

    return;
  }
}

function ref_13f1e(var_0) {
  if(isDefined(var_0.doors)) {
    foreach(var_2 in var_0.doors) {
      var_2 scriptabledoorfreeze(0);
    }

    return;
  }
}

function ref_1212e(var_0, var_1) {
  foreach(var_3 in var_0.doors) {
    var_3 constraintoscriptgoalRadius("away", var_0.origin);
  }

  if(istrue(var_1)) {
    wait 1;
    ref_119a3(var_0);
    return;
  }
}

function heli_screenshake(var_0, var_1) {
  foreach(var_3 in var_0.doors) {
    var_3 vehicle_getinputvalue(1);
  }

  if(istrue(var_1)) {
    var_5 = 0;

    while(!var_5) {
      var_6 = 0;

      foreach(var_3 in var_0.doors) {
        if(!var_3 scriptabledoorisclosed()) {
          var_6 = 1;
        }
      }

      if(!var_6) {
        var_5 = 1;
      }

      waitframe();
    }

    ref_119a3(var_0);
    return;
  }
}

function top_roof_enemy_watcher() {
  level.max_pt = getdvarint("NROSLKMMQQ", 0) > 0;
  scripts\mp\gamelogic::ref_12c4c(9);
  level.max_extra_enemies = getEnt("clip128x128x8", "targetname");
}

function ref_12f70(var_0) {
  foreach(var_2 in var_0) {
    thread ref_12f6f();
  }

  var_4 = 0;

  for(;;) {
    var_4 = 1;

    foreach(var_2 in var_0) {
      if(ref_12f75(var_2)) {
        var_4 = 0;
        break;
      }
    }

    waitframe();
  }

  LOC_00000073:
    return true;
}

function ref_12f71(var_0) {
  foreach(var_2 in var_0) {
    ref_12f72(var_2);
  }
}

function ref_12f6f() {
  self endon("door_cl_end");

  if(istrue(self.max_dist_sq_from_node)) {
    return;
  }

  self.max_dist_sq_from_node = 1;
  var_0 = combineangles(self.angles, (0, -1 * self scriptabledoorangle(), 0));
  var_1 = self.origin;
  var_2 = anglesToForward(var_0);
  var_3 = anglestoup(self.angles);
  var_4 = 28;
  var_5 = 48;
  var_1 += var_2 * var_4;
  var_1 += var_3 * var_5;
  var_6 = sqrt(pow(28, 2) + pow(48, 2)) + 20;
  var_7 = var_1 + var_3 * 128 * -0.5;
  var_8 = combineangles(var_0, (0, -90, 0));

  if(1 && isDefined(level.max_extra_enemies)) {
    var_9 = spawn("script_model", (0, 0, 0));
    var_9 clonebrushmodeltoscriptmodel(level.max_extra_enemies);
    var_9.origin = var_7;
    var_9.angles = var_8;
    self.max_groups_per_player = var_9;
  }

  self.max_projectile_check = [];

  while(!self scriptabledoorisclosed()) {
    self vehicle_getinputvalue();

    if(true) {
      var_10 = scripts\mp\utility\player::getplayersinradius(var_1, var_6);

      foreach(var_12 in var_10) {
        var_13 = var_12 getentitynumber();

        if(!var_12 scripts\cp_mp\utility\player_utility::_isalive()) {
          self.max_projectile_check[var_13] = undefined;
          continue;
        }

        if(!isDefined(self.max_projectile_check[var_13])) {
          ref_12f73(var_12, 1);
          self.max_projectile_check[var_13] = var_12;
        }
      }

      foreach(var_13, var_12 in self.max_projectile_check) {
        if(!isDefined(var_12) || !var_12 scripts\cp_mp\utility\player_utility::_isalive()) {
          self.max_projectile_check[var_13] = undefined;
          continue;
        }

        var_16 = 1;

        foreach(var_18 in var_10) {
          if(var_18 == var_12) {
            var_16 = 0;
            break;
          }
        }

        if(var_16) {
          ref_12f73(var_12, 0);
          self.max_projectile_check[var_13] = undefined;
        }
      }
    }

    waitframe();
  }

  self scriptabledoorfreeze();
  thread ref_12f72();
}

function ref_12f72() {
  self notify("door_cl_end");
  self.max_dist_sq_from_node = undefined;

  if(isDefined(self.max_groups_per_player)) {
    self.max_groups_per_player delete();
    self.max_groups_per_player = undefined;
  }

  if(isDefined(self.max_projectile_check)) {
    foreach(var_1 in self.max_projectile_check) {
      if(!isDefined(var_1) || !var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      ref_12f73(var_1, 0);
    }
  }

  self.max_projectile_check = undefined;
}

function ref_12f73(var_0) {
  scripts\common\utility::allow_melee(!var_0, "door_cl");
  scripts\common\utility::allow_usability(!var_0, "door_cl");
}

function ref_12f75() {
  return istrue(self.max_dist_sq_from_node);
}

function ref_12f74() {
  return istrue(level.max_pt);
}

function hitsperattackforvehicle(var_0) {
  playsoundatpos(var_0.origin, "br_computer_deny");
  var_0 setscriptablepartstate(var_0.type, "off");
  wait 3;
  var_0 setscriptablepartstate(var_0.type, "on");
}
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

function teamsassigned(var0, var1, var2) {
  var3 = getEntArray(var0.target, "targetname");

  foreach(var5 in var3) {
    if(var5.script_noteworthy == "right_door_clip") {
      var0.heli_anim = var5;
      var0.heli_anim setnonstick(1);
      continue;
    }

    if(var5.script_noteworthy == "left_door_clip") {
      var0.heli_approach_instruct = var5;
      var0.heli_approach_instruct setnonstick(1);
    }
  }

  var0.animname = "bunker_door";
  var0 scripts\common\anim::setanimtree();

  if(!istrue(var2)) {
    thread teamspawnfunc(level, var0);
  }

  var7 = anglesToForward(var0.angles);
  var8 = var0.origin + (0, 0, -110) + var7 * -128;
  var9 = getEnt("clip256x256x256", "targetname");
  var10 = spawn("script_model", var8);
  var10.angles = var0.angles;
  var10 clonebrushmodeltoscriptmodel(var9);
  var0.battle_tracks_isbattletracksowner = var10;
}

function teamspawnfunc(var0, var1) {}

function ref_12121(var0, var1, var2, var3) {}

function ref_13619(var0, var1) {
  if(!isDefined(level.br_pickups)) {
    return;
  }

  var2 = relic_bullet_reward_hud_display(var0, var1);
  var3 = scripts\engine\utility::getStructArray(var2.target, "targetname");
  var4 = [];
  var5 = [];
  var6 = [];
  var7 = [];
  var8 = getdvarint("scr_br_bunkerCache_Lege_Min", 0);
  var9 = getdvarint("scr_br_bunkerCache_Lege_Max", 1);
  var10 = getdvarint("scr_br_bunkerCache_Basic_Min", 1);
  var11 = getdvarint("scr_br_bunkerCache_Basic_Max", 2);

  foreach(var13 in var3) {
    if(var13.script_noteworthy == "br_loot_cache_lege") {
      var4 = var13;
      continue;
    }

    if(var13.script_noteworthy == "br_loot_cache") {
      var5 = var13;
      continue;
    }

    if(issubstr(var13.script_noteworthy, "uniqueLootItem")) {
      var6 = var13;
      continue;
    }

    var7 = var13;
  }

  var15 = randomintrange(var8, var9);
  var4 = scripts\engine\utility::array_randomize(var4);
  var5 = scripts\engine\utility::array_randomize(var5);

  for(var16 = 0; var16 < var15; var16++) {
    if(isDefined(var4[var16])) {
      var17 = easepower(var4[var16].script_noteworthy, var4[var16].origin, var4[var16].angles);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var17);
    }
  }

  var15 = randomintrange(var10, var11);

  for(var16 = 0; var16 < var15; var16++) {
    if(isDefined(var5[var16])) {
      var17 = easepower(var5[var16].script_noteworthy, var5[var16].origin, var5[var16].angles);
      scripts\mp\gametypes\br_pickups::ref_12b3a(var17);
    }
  }

  foreach(var13 in var6) {
    if(isDefined(var13.script_noteworthy)) {
      var19 = ref_13f0b(var13.script_noteworthy);
      var20 = remove_reduce_recoil(var19);
      var21 = var13.origin;
      var22 = var13.angles;

      if(var13.script_noteworthy == "uniqueLootItem_1") {
        if(level.mapname == "mp_bm_bunker01") {
          switch (var24) {
            case 0:
              continue;
            case 1:
              var21 = (1969, 639, 68);
              var22 = (0, 106.6, 75);
              break;
            case 2:
              var21 = (1962, 665, 68);
              var22 = (0, 106.6, 75);
              break;
          }
        } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
          switch (var24) {
            case 0:
              continue;
            case 1:
              var21 = (-3858, 62596, 573);
              var22 = (0, 106.6, 75);
              break;
            case 2:
              var21 = (-3850, 62571, 573);
              var22 = (0, 106.6, 75);
              break;
          }
        }
      }

      var23 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var21, var22);
      var17 = scripts\mp\gametypes\br_pickups::spawnpickup(var19, var23, var20, 0);

      if(isDefined(var17)) {
        var17.ref_13f0a = var13.script_noteworthy;
      }
    }
  }

  foreach(var13 in var7) {
    if(isDefined(var13.script_noteworthy)) {
      var26 = var13.script_noteworthy;

      if(var13.script_noteworthy == "jugg_minigun") {
        if(getdvarint("scr_br_spawnBunkerMiniGun", 1) == 0) {
          continue;
        }

        var26 = "brloot_weapon_lm_dblmg_lege";
      } else if(var13.script_noteworthy == "jugg_minigun_chance") {
        var27 = randomintrange(1, 100);

        if(var27 > getdvarint("scr_br_chanceForBunkerSpecialLoot", 60)) {
          continue;
        } else {
          var26 = safehouse_hotjoin_func();
        }
      }

      var20 = remove_reduce_recoil(var26);
      var23 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var13.origin, var13.angles);
      var17 = scripts\mp\gametypes\br_pickups::spawnpickup(var26, var23, var20, 0);
    }
  }
}

function remove_reduce_recoil(var0) {
  if(isDefined(level.br_pickups.counts[var0])) {
    return level.br_pickups.counts[var0];
  } else if(isDefined(level.br_lootiteminfo[var0])) {
    return level.br_lootiteminfo[var0].playerstartjailsetcontrols.clipsize;
  } else if(isDefined(level.br_ammo_clipsize[var0])) {
    return level.br_ammo_clipsize[var0];
  }

  return 1;
}

function ref_13f0b(var0) {
  switch (var0) {
    case "uniqueLootItem_2":
    case "uniqueLootItem_1":
    default:
      break;
  }
}

function safehouse_hotjoin_func() {
  var0 = 0;
  var1 = 0;
  var2 = scripts\mp\utility\game::round_vehicle_logic();

  if(level.gametype == "br" && (var2 == "br" || var2 == "jugg" || var2 == "mini")) {
    var0 = 2;
    var1 = 2;
  }

  var3 = getdvarint("scr_br_lootbunkerChance_AUAV", 0);
  var4 = getdvarint("scr_br_lootBunkerChance_Specialist", 0);
  var5 = getdvarint("scr_br_lootBunkerChance_LoadoutDrop", 0);
  var6 = getdvarint("scr_br_lootBunkerChance_Gasmask", 0);
  var7 = getdvarint("scr_br_lootBunkerChance_MiniGun", 0);
  var8 = getdvarint("scr_br_lootBunkerChance_JuggDrop", 0);
  var9 = getdvarint("scr_br_lootBunkerChance_AssaultDrone", 0);
  var10 = getdvarint("scr_br_lootBunkerChance_CirclePeek", 0);
  var11 = 1 + var3 + var4 + var5 + var6 + var7 + var8 + var9 + var10;
  var12 = randomintrange(1, var11);

  if(var12 <= var3) {
    return "brloot_killstreak_auav";
  }

  if(var12 <= var3 + var4) {
    return "brloot_specialist_bonus";
  }

  if(var12 <= var3 + var4 + var5) {
    return "brloot_offhand_advancedsupplydrop";
  }

  if(var12 <= var3 + var4 + var5 + var6) {
    return "brloot_equip_gasmask_durable";
  }

  if(var12 <= var3 + var4 + var5 + var6 + var7) {
    return "brloot_weapon_lm_dblmg_lege";
  }

  if(var12 <= var3 + var4 + var5 + var6 + var7 + var8) {
    return "brloot_killstreak_juggernaut";
  }

  if(var12 <= var3 + var4 + var5 + var6 + var7 + var8 + var9) {
    return "brloot_killstreak_assaultdrone";
  }

  return "brloot_killstreak_circle_peek";
}

function relic_bullet_reward_hud_display(var0, var1) {
  var2 = scripts\engine\utility::getStructArray(var1, "targetname");

  if(isDefined(var2)) {
    if(var2.size == 1) {
      return var2[0];
    } else {
      var3 = undefined;
      var4 = undefined;

      for(var5 = 0; var5 < var2.size; var5++) {
        var6 = distance2dsquared(var0, var2[var5].origin);

        if(!isDefined(var4) || var6 < var4) {
          var4 = var6;
          var3 = var2[var5];
        }
      }

      return var3;
    }
  }

  return undefined;
}

function binoculars_endadslogic(var0) {
  if(tv_station_marker_player_connect_monitor(var0.angles[1], 106, 1)) {
    var1 = anglesToForward(var0.angles);
    return [var0.origin + var1 * 30, (var0.angles[0], 106, 90)];
  } else if(tv_station_marker_player_connect_monitor(var1.angles[1], 90, 1)) {
    var1 = anglesToForward(var1.angles);
    return [var1.origin - var1 * 10, var1.angles];
  } else if(tv_station_marker_player_connect_monitor(var1.angles[1], 70, 1)) {
    return [var1.origin, (var1.angles[0], var1.angles[1], 0)];
  }

  return [var1.origin, var1.angles];
}

function tv_station_marker_player_connect_monitor(var0, var1, var2) {
  return abs(var0 - var1) <= var2;
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

function little_bird_mg_playercontrolmg(var0, var1) {
  var2 = 2000;

  if(!isDefined(var1)) {
    var1 = var2;
  }

  scripts\mp\gametypes\br_quest_util::little_bird_mg_playercontrolmg(var0, var1, 100);
}

function teamreviveperkdiscount() {
  level.flaglockedtimer = [];
  var0 = scripts\engine\utility::getStructArray("bunker_back_keypad", "targetname");

  foreach(var2 in var0) {
    var3 = easepower("maphint_keypad_bunker_interior", var2.origin);
    var3.chopper_glow_sticks = 1;

    if(isDefined(var2.script_noteworthy)) {
      var3.flagpickupchecks = int(var2.script_noteworthy);
      level.flaglockedtimer[var3.flagpickupchecks] = var3;
    }
  }
}

function vehicleparent(var0, var1, var2, var3, var4) {
  thread allies_spawn_function(level, var0, var1, var2, var3);
}

function allies_spawn_function(var0, var1, var2, var3, var4) {
  var0 setscriptablepartstate(var1, "off");

  if(isDefined(var0.ks_killleaders)) {
    thread vehicleaniminit(level, var0);
  }

  vehiclelinkTo(var3, var0);

  if(isDefined(var3)) {
    var3 scripts\mp\gametypes\br_keypad_util::ref_12685(0);
  }

  wait 1;

  if(!isDefined(var0.ks_killleaders) && !(istrue(var0.opened) && istrue(var0.little_bird_mg_initoccupancy))) {
    var0 setscriptablepartstate(var1, "on");
    return;
  }
}

function vehiclelinkTo(var0) {
  level endon("game_ended");
  self endon("keypad_kickPlayerFromKeypadMSG");
  thread vehicle_watchmarkedtankdeath(var0);
  thread vehiclegod(var0);
  thread vehicleindangertracking(var0);
  scripts\mp\gametypes\br_keypad_util::ref_12685(1);
  var1 = 8;

  if(isDefined(var0.helihint_activate_vo)) {
    var1 = var0.helihint_activate_vo;
  }

  scripts\mp\gametypes\br_keypad_util::ref_12683(var1);
  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  jumpiffalse(istrue(var0.helihint_wait) && var0.helihint_activate_vo <= 5) LOC_00000080;
  scripts\mp\gametypes\br_keypad_util::ref_12684(var0.helidrivablemission["array"]);

  while(isDefined(self) && scripts\mp\gametypes\br_keypad_util::removedeathicon() != 0) {
    self waittill("luinotifyserver", var2, var3);

    if(isDefined(var2)) {
      if(var2 == "submit_br_keypad") {
        if(getdvarint("scr_br_bunker_keypad_refresh_idle_timer_on_try", 0)) {
          thread vehicleindangertracking(var0);
        }

        if(isDefined(var0.helidrivablemission) && tv_station_reinforcement_spawn_logic(var0, var3)) {
          scripts\mp\gametypes\br_keypad_util::ref_12685(2);
          var0.helileave = 2;

          if(isDefined(var0.ref_1395d)) {
            [[var0.ref_1395d]](var0);
          }

          break;
        } else {
          if(soundexists("br_keypad_deny")) {
            playsoundatpos(self.origin, "br_keypad_deny");
          }

          var0.helileave = 3;
          scripts\mp\gametypes\br_keypad_util::ref_12685(3);
          waitframe();

          if(isDefined(self)) {
            scripts\mp\gametypes\br_keypad_util::ref_12685(1);
          }
        }

        continue;
      }

      if(var2 == "exit_br_keypad") {
        var0.helileave = 3;

        if(isDefined(var0.ks_killleaders)) {
          level notify(var0.ks_killleaders);
        }

        break;
      }
    }
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("doneWithKeypad");
}

function vehicle_watchmarkedtankdeath(var0) {
  self endon("keypad_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  self waittill("death_or_disconnect");

  if(isDefined(var0.ks_killleaders)) {
    level notify(var0.ks_killleaders);
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("keypad_kickPlayerFromKeypadMSG");
}

function vehiclegod(var0) {
  self endon("keypad_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  self waittill("last_stand_start");

  if(isDefined(var0.ks_killleaders)) {
    level notify(var0.ks_killleaders);
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("keypad_kickPlayerFromKeypadMSG");
}

function vehicleindangertracking(var0) {
  self endon("keypad_kickPlayerFromKeypadMSG");
  self notify("keypad_playerIdleWatch");
  self endon("keypad_playerIdleWatch");
  wait getdvarint("scr_br_bunker_keypad_idle_timer", 60);

  if(isDefined(var0.ks_killleaders)) {
    level notify(var0.ks_killleaders);
  }

  scripts\mp\gametypes\br_keypad_util::ref_12684([0]);
  self notify("keypad_kickPlayerFromKeypadMSG");
}

function vehicleaniminit(var0, var1) {
  if(isDefined(var0.ks_killleaders)) {
    level waittill(var0.ks_killleaders);
  }

  var0 setscriptablepartstate(var1, "on");
}

function tv_station_reinforcement_spawn_logic(var0, var1) {
  if(!isDefined(var0.helidrivablemission["string"])) {
    return false;
  }

  if(var1 == -1) {
    return false;
  }

  var2 = int(var0.helidrivablemission["string"]);

  if(var1 == var2) {
    return true;
  }

  return false;
}

function pre_laserpanel_weapon(var0, var1) {
  var2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  for(var3 = 0; var3 < var0; var3++) {
    var2 = scripts\engine\utility::array_randomize(var2);
    var1.helidrivablemission[var3] = var2[0];
    var2 = scripts\engine\utility::array_remove(var2, var2[0]);
  }
}

function pre_get_in_anim_wait(var0, var1, var2, var3) {
  var4 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var1.helidrivablemission = [];

  if(!isDefined(var2)) {
    var2 = 0;
  } else {
    var1.helidrivablemission["doubles"] = [];
  }

  if(!isDefined(var3)) {
    var3 = 0;
  } else {
    var1.helidrivablemission["triples"] = [];
  }

  var5 = var0 - var2 - var3 * 2;
  var6 = scripts\engine\utility::array_randomize(var4);
  var4 = [];
  var7 = randomintrange(1, 9);

  foreach(var9 in var6) {
    if(var10 == var7) {
      var4 = 0;
      continue;
    }

    var4 = var9;
  }

  for(var11 = 0; var11 < var5; var11++) {
    var1.helidrivablemission["array"][var11] = var4[var11];
  }

  var12 = var1.helidrivablemission["array"];

  for(var11 = 0; var11 < var2; var11++) {
    var13 = var12[var11];
    var1.helidrivablemission["array"][var1.helidrivablemission["array"].size] = var13;
    var1.helidrivablemission["doubles"][var1.helidrivablemission["doubles"].size] = var13;
    var12 = scripts\engine\utility::array_remove(var12, var12[var11]);
  }

  for(var11 = 0; var11 < var3; var11++) {
    var14 = var12[var11];

    for(var15 = 0; var15 < 2; var15++) {
      var1.helidrivablemission["array"][var1.helidrivablemission["array"].size] = var14;
    }

    var1.helidrivablemission["triples"][var1.helidrivablemission["triples"].size] = var14;
    var12 = scripts\engine\utility::array_remove(var12, var12[var11]);
  }

  var1.helidrivablemission["array"] = scripts\engine\utility::array_randomize(var1.helidrivablemission["array"]);
  var1.helidrivablemission["string"] = "";

  foreach(var9 in var1.helidrivablemission["array"]) {
    var17 = "" + var9;
    var1.helidrivablemission["string"] = var1.helidrivablemission["string"] + var17;
  }
}

function ppkteamwithflag(var0, var1, var2, var3) {
  if(var2 > var0["doubles"].size) {
    var2 = 0;
  }

  if(var3 > var0["triples"].size) {
    var3 = 0;
  }

  var4 = 0;
  var5 = 0;
  var6 = scripts\engine\utility::array_randomize(scripts\engine\utility::array_remove_duplicates(var0["array"]));
  var7 = [];

  for(var8 = 0; var8 < var1; var8++) {
    if(var4 < var2) {
      var9 = var0["doubles"][var4];
      var4++;
    } else if(var5 < var3) {
      var9 = var0["triples"][var5];
      var5++;
    } else {
      var9 = var6[0];
    }

    var7 = var8 + 1;
    var6 = scripts\engine\utility::array_remove(var6, var9);
  }

  var10 = [];
  var11 = getarraykeys(var7);

  foreach(var19, var13 in var11) {
    var10 = var0["array"];
    var14 = 0;

    foreach(var18, var16 in var10[var19]) {
      if(var16 == var13 && var14) {
        var10[var18] = "symbol" + var7[var13];
        var17 = 1;
        continue;
      }

      if(var16 == var13 && !var14) {
        var14 = 1;
        continue;
      }

      if(scripts\engine\utility::array_contains(var11, var16)) {
        var10[var18] = "symbol" + var7[var16];
      }
    }
  }

  return var10;
}

function cargo_truck_mg_getspawnstructscallback(var0, var1) {
  var0 = scripts\engine\utility::array_randomize(var0);

  foreach(var4, var3 in var0) {
    if(var4 > var1.size) {
      var4 = 0;
    }

    var3.scriptable.logplayermatchend = var4;
  }
}

function relic_dogtags(var0, var1) {
  return var0.logplayermatchstart[var1];
}

function ref_119a3(var0) {
  if(isDefined(var0.doors)) {
    foreach(var2 in var0.doors) {
      var2 scriptabledoorfreeze(1);
    }

    return;
  }
}

function ref_13f1e(var0) {
  if(isDefined(var0.doors)) {
    foreach(var2 in var0.doors) {
      var2 scriptabledoorfreeze(0);
    }

    return;
  }
}

function ref_1212e(var0, var1) {
  foreach(var3 in var0.doors) {
    var3 constraintoscriptgoalRadius("away", var0.origin);
  }

  if(istrue(var1)) {
    wait 1;
    ref_119a3(var0);
    return;
  }
}

function heli_screenshake(var0, var1) {
  foreach(var3 in var0.doors) {
    var3 vehicle_getinputvalue(1);
  }

  if(istrue(var1)) {
    var5 = 0;

    while(!var5) {
      var6 = 0;

      foreach(var3 in var0.doors) {
        if(!var3 scriptabledoorisclosed()) {
          var6 = 1;
        }
      }

      if(!var6) {
        var5 = 1;
      }

      waitframe();
    }

    ref_119a3(var0);
    return;
  }
}

function top_roof_enemy_watcher() {
  level.max_pt = getdvarint("NROSLKMMQQ", 0) > 0;
  scripts\mp\gamelogic::ref_12c4c(9);
  level.max_extra_enemies = getEnt("clip128x128x8", "targetname");
}

function ref_12f70(var0) {
  foreach(var2 in var0) {
    thread ref_12f6f();
  }

  var4 = 0;

  for(;;) {
    var4 = 1;

    foreach(var2 in var0) {
      if(ref_12f75(var2)) {
        var4 = 0;
        break;
      }
    }

    waitframe();
  }

  LOC_00000073:
    return true;
}

function ref_12f71(var0) {
  foreach(var2 in var0) {
    ref_12f72(var2);
  }
}

function ref_12f6f() {
  self endon("door_cl_end");

  if(istrue(self.max_dist_sq_from_node)) {
    return;
  }

  self.max_dist_sq_from_node = 1;
  var0 = combineangles(self.angles, (0, -1 * self scriptabledoorangle(), 0));
  var1 = self.origin;
  var2 = anglesToForward(var0);
  var3 = anglestoup(self.angles);
  var4 = 28;
  var5 = 48;
  var1 += var2 * var4;
  var1 += var3 * var5;
  var6 = sqrt(pow(28, 2) + pow(48, 2)) + 20;
  var7 = var1 + var3 * 128 * -0.5;
  var8 = combineangles(var0, (0, -90, 0));

  if(1 && isDefined(level.max_extra_enemies)) {
    var9 = spawn("script_model", (0, 0, 0));
    var9 clonebrushmodeltoscriptmodel(level.max_extra_enemies);
    var9.origin = var7;
    var9.angles = var8;
    self.max_groups_per_player = var9;
  }

  self.max_projectile_check = [];

  while(!self scriptabledoorisclosed()) {
    self vehicle_getinputvalue();

    if(true) {
      var10 = scripts\mp\utility\player::getplayersinradius(var1, var6);

      foreach(var12 in var10) {
        var13 = var12 getentitynumber();

        if(!var12 scripts\cp_mp\utility\player_utility::_isalive()) {
          self.max_projectile_check[var13] = undefined;
          continue;
        }

        if(!isDefined(self.max_projectile_check[var13])) {
          ref_12f73(var12, 1);
          self.max_projectile_check[var13] = var12;
        }
      }

      foreach(var13, var12 in self.max_projectile_check) {
        if(!isDefined(var12) || !var12 scripts\cp_mp\utility\player_utility::_isalive()) {
          self.max_projectile_check[var13] = undefined;
          continue;
        }

        var16 = 1;

        foreach(var18 in var10) {
          if(var18 == var12) {
            var16 = 0;
            break;
          }
        }

        if(var16) {
          ref_12f73(var12, 0);
          self.max_projectile_check[var13] = undefined;
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
    foreach(var1 in self.max_projectile_check) {
      if(!isDefined(var1) || !var1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      ref_12f73(var1, 0);
    }
  }

  self.max_projectile_check = undefined;
}

function ref_12f73(var0) {
  scripts\common\utility::allow_melee(!var0, "door_cl");
  scripts\common\utility::allow_usability(!var0, "door_cl");
}

function ref_12f75() {
  return istrue(self.max_dist_sq_from_node);
}

function ref_12f74() {
  return istrue(level.max_pt);
}

function hitsperattackforvehicle(var0) {
  playsoundatpos(var0.origin, "br_computer_deny");
  var0 setscriptablepartstate(var0.type, "off");
  wait 3;
  var0 setscriptablepartstate(var0.type, "on");
}
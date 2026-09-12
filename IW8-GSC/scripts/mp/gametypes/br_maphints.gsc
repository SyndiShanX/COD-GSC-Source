/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_maphints.gsc
************************************************/

function init() {
  if(getdvarint("scr_mapHints", 0) == 0) {
    thread linker();
    return;
  }

  level.ref_11ae4 = [];
  level.ref_11ae4["keypads"] = [];
  level.ref_11ae4["phones"] = [];
  level.ref_11ae4["computers"] = [];
  thread onplayerconnect();
  thread tank_death();

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_br_mechanics") {
    times_shot();
  } else {
    timer_sequence();
  }

  scripts\engine\scriptable::ref_12f5b("maphint_computer", &ref_11adf);

  if(false) {
    thread ref_11ae0();
    return;
  }
}

function linker() {
  wait 1;
  var_0 = tablelookupgetnumrows("mp/intel_challenges.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("mp/intel_challenges.csv", var_1, 0);

    if(isDefined(var_2) && var_2 != "") {
      var_3 = getentitylessscriptablearrayinradius(var_2, "script_noteworthy");

      foreach(var_5 in var_3) {
        var_5 setscriptablepartstate("hint", "off", 1);
      }
    }
  }
}

function timeremaining() {
  level.ref_11ae4["keypads"] = [];
  level.ref_11ae4["keypads"][0] = spawnStruct();
  level.ref_11ae4["keypads"][0].origin = (-17261, -44265, 40);
  level.ref_11ae4["keypads"][1] = spawnStruct();
  level.ref_11ae4["keypads"][1].origin = (-37520, -19013, 237);
  level.ref_11ae4["keypads"][2] = spawnStruct();
  level.ref_11ae4["keypads"][2].origin = (-39523, -2395, 30);
  level.ref_11ae4["keypads"][3] = spawnStruct();
  level.ref_11ae4["keypads"][3].origin = (-38640, -1902, -103);
  level.ref_11ae4["keypads"][4] = spawnStruct();
  level.ref_11ae4["keypads"][4].origin = (-15513, 43307, 105);
  level.ref_11ae4["keypads"][5] = spawnStruct();
  level.ref_11ae4["keypads"][5].origin = (2495, 41096, 1670);
  level.ref_11ae4["keypads"][6] = spawnStruct();
  level.ref_11ae4["keypads"][6].origin = (47600, 34582, 500);
  level.ref_11ae4["keypads"][7] = spawnStruct();
  level.ref_11ae4["keypads"][7].origin = (18622, -34634, -478);
  level.ref_11ae4["keypads"][8] = spawnStruct();
  level.ref_11ae4["keypads"][8].origin = (54279, -33994, 173);
  level.ref_11ae4["keypads"][9] = spawnStruct();
  level.ref_11ae4["keypads"][9].origin = (36350, 13586, 26);
  level.ref_11ae4["keypads"][10] = spawnStruct();
  level.ref_11ae4["keypads"][10].origin = (37390, 13383, -117);

  foreach(var_1 in level.ref_11ae4["keypads"]) {
    level.ref_11ae4["keypads"][var_2].scriptable = easepower("maphint_keypad", var_1.origin);
  }
}

function times_in_b() {
  level.ref_11ae4["phones"] = [];

  foreach(var_1 in level.ref_11ae4["phones"]) {
    level.ref_11ae4["phones"][var_2].scriptable = easepower("maphint_phone", var_1.origin);
  }
}

function timer_sequence() {
  level.ref_11ae4["computers"] = [];
  level.ref_11ae4["computers"][0] = spawnStruct();
  level.ref_11ae4["computers"][0].origin = (8490, -11874, -239);
  level.ref_11ae4["computers"][1] = spawnStruct();
  level.ref_11ae4["computers"][1].origin = (-14585, 7982, -175);
  level.ref_11ae4["computers"][2] = spawnStruct();
  level.ref_11ae4["computers"][2].origin = (-34140, 3815, -55);
  level.ref_11ae4["computers"][3] = spawnStruct();
  level.ref_11ae4["computers"][3].origin = (5358, 51419, 1080);
  level.ref_11ae4["computers"][4] = spawnStruct();
  level.ref_11ae4["computers"][4].origin = (51078, -39445, 1125);
  level.ref_11ae4["computers"][5] = spawnStruct();
  level.ref_11ae4["computers"][5].origin = (17796, -8300, 1349);
  level.ref_11ae4["computers"][6] = spawnStruct();
  level.ref_11ae4["computers"][6].origin = (37275, -26745, -472);

  foreach(var_1 in level.ref_11ae4["computers"]) {
    level.ref_11ae4["computers"][var_2].scriptable = easepower("maphint_computer", var_1.origin);
  }
}

function times_in_c() {
  level.ref_11ae4["radios"] = [];
  level.ref_11ae4["radios"][0] = spawnStruct();
  level.ref_11ae4["radios"][0].origin = (-21440, 19434, -252);
  level.ref_11ae4["radios"][1] = spawnStruct();
  level.ref_11ae4["radios"][1].origin = (2896, 45445, 1630);

  foreach(var_1 in level.ref_11ae4["radios"]) {
    level.ref_11ae4["radios"][var_2].scriptable = easepower("maphint_radio", var_1.origin);
  }
}

function ref_11ae1(var_0, var_1, var_2, var_3, var_4) {
  thread allow_player_skip_deathshield(level, var_0, var_1, var_2, var_3);
}

function allow_player_skip_deathshield(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    playsoundatpos(var_3.origin, "br_keypad_deny");
    var_0 setscriptablepartstate("maphint_keypad", "off");
    wait 3;
    var_0 setscriptablepartstate("maphint_keypad", "on");
    return;
  }
}

function ref_11ae3(var_0, var_1, var_2, var_3, var_4) {
  thread allowassassinationdamage(level, var_0, var_1, var_2, var_3);
}

function allowassassinationdamage(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    playsoundatpos(var_3.origin, "br_phone_deny");
    var_0 setscriptablepartstate("maphint_phone", "off");
    wait 3;
    var_0 setscriptablepartstate("maphint_phone", "on");
    return;
  }
}

function ref_11adf(var_0, var_1, var_2, var_3, var_4) {
  thread allow_player_minimapforcedisable(level, var_0, var_1, var_2, var_3);
}

function allow_player_minimapforcedisable(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    playsoundatpos(var_3.origin, "br_computer_deny");
    var_0 setscriptablepartstate("maphint_computer", "off");
    wait 3;
    var_0 setscriptablepartstate("maphint_computer", "on");
    return;
  }
}

function times_shot() {
  wait 5;
  level.ref_11ae4["keypads"] = [];
  level.ref_11ae4["keypads"][0] = spawnStruct();
  level.ref_11ae4["keypads"][0].origin = (-237, -2721, 60);
  level.ref_11ae4["keypads"][1] = spawnStruct();
  level.ref_11ae4["keypads"][1].origin = (-237, -2721, 260);

  foreach(var_1 in level.ref_11ae4["keypads"]) {
    var_2 = easepower("maphint_keypad", var_1.origin);
  }

  level.ref_11ae4["phones"] = [];
  level.ref_11ae4["phones"][0] = spawnStruct();
  level.ref_11ae4["phones"][0].origin = (-21, -2721, 60);
  level.ref_11ae4["phones"][1] = spawnStruct();
  level.ref_11ae4["phones"][1].origin = (-21, -2721, 260);

  foreach(var_1 in level.ref_11ae4["phones"]) {
    var_2 = easepower("maphint_phone", var_1.origin);
  }

  level.ref_11ae4["computers"] = [];
  level.ref_11ae4["computers"][0] = spawnStruct();
  level.ref_11ae4["computers"][0].origin = (100, -2721, 60);
  level.ref_11ae4["computers"][1] = spawnStruct();
  level.ref_11ae4["computers"][1].origin = (100, -2721, 260);

  foreach(var_1 in level.ref_11ae4["computers"]) {
    var_2 = easepower("maphint_computer", var_1.origin);
  }
}

function ref_11ae0() {
  var_0 = 1;

  for(;;) {
    if(var_0) {
      foreach(var_2 in level.ref_11ae4["phones"]) {
        thread scripts\mp\utility\debug::drawsphere(var_2.scriptable.origin, 64, 1, (0, 1, 0));
      }
    }

    if(getdvarint("scr_mapHint_debugReset", 0) == 1) {
      foreach(var_2 in level.ref_11ae4["keypads"]) {
        var_2.scriptable freescriptable();
      }

      foreach(var_2 in level.ref_11ae4["phones"]) {
        var_2.scriptable freescriptable();
      }

      foreach(var_2 in level.ref_11ae4["computers"]) {
        var_2.scriptable freescriptable();
      }

      timeremaining();
      times_in_b();
      timer_sequence();
    }

    wait 1;
  }
}

function tank_death() {
  level.trial_enemies_killed = [];
  scripts\mp\flags::gameflaginit("intel_challenges_setup_complete", 0);
  var_0 = getdvarint("online_challenge_season_and_week", 0);
  level.ref_129cc = getentitylessscriptablearrayinradius("intel_challenge", "targetname");

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow("mp/intel_challenges.csv", var_1, 0);
    var_3 = tablelookupbyrow("mp/intel_challenges.csv", var_1, 1);

    if(!isDefined(var_3) || var_3 == "") {
      break;
    }

    var_4 = int(tablelookupbyrow("mp/intel_challenges.csv", var_1, 3));
    var_5 = int(tablelookupbyrow("mp/intel_challenges.csv", var_1, 2));

    if(var_5 > var_0 && getdvarint("scr_intel_challenges_debug", 0) == 0) {
      var_1++;
      continue;
    }

    var_6 = tablelookupbyrow("mp/intel_challenges.csv", var_1, 4);
    var_7 = tablelookupbyrow("mp/intel_challenges.csv", var_1, 5);
    var_8 = float(tablelookupbyrow("mp/intel_challenges.csv", var_1, 6));
    var_9 = float(tablelookupbyrow("mp/intel_challenges.csv", var_1, 7));
    var_10 = float(tablelookupbyrow("mp/intel_challenges.csv", var_1, 8));
    var_11 = (var_8, var_9, var_10);
    var_12 = float(tablelookupbyrow("mp/intel_challenges.csv", var_1, 9));
    var_13 = float(tablelookupbyrow("mp/intel_challenges.csv", var_1, 10));
    var_14 = float(tablelookupbyrow("mp/intel_challenges.csv", var_1, 11));
    var_15 = (var_12, var_13, var_14);
    var_16 = tablelookupbyrow("mp/intel_challenges.csv", var_1, 13);

    if(!isDefined(level.trial_enemies_killed[var_3])) {
      var_17 = spawnStruct();
      var_17.ref = var_3;
      var_17.stopdragonsbreath = var_4;
      var_17.ref_145a6 = var_5;
      var_17.chopper_boss_player_monitor = var_6;
      var_17.origin = var_11;
      var_17.helis_assault3_fob = var_16;
      var_17.scriptables = [];
      level.trial_enemies_killed[var_3] = var_17;
    }

    if(var_4) {
      var_18 = getentitylessscriptablearrayinradius(var_2, "script_noteworthy");
      var_19 = var_18[0];

      if(!isDefined(var_19)) {
        var_19 = easepower("intel", var_11, var_15);
      }

      var_19.ref_11c74 = var_7;
      var_19.iscash = var_3;
      level.trial_enemies_killed[var_3].scriptables[var_2] = var_19;
    }
  }

  thread cargo_truck_mg_initspawning();
  scripts\engine\scriptable::scriptable_addusedcallback(&trial_headicon);
  var_20 = getentitylessscriptablearrayinradius("intel_challenge", "targetname");
  scripts\mp\flags::gameflagset("intel_challenges_setup_complete");
}

function cargo_truck_mg_initspawning() {
  wait 1;

  foreach(var_1 in level.trial_enemies_killed) {
    if(!var_1.stopdragonsbreath) {
      continue;
    }

    foreach(var_3 in level.trial_enemies_killed[var_5].scriptables) {
      var_3 setscriptablepartstate("model", var_3.ref_11c74);
    }
  }
}

function ref_1335c(var_0, var_1) {
  foreach(var_3 in level.trial_enemies_killed[var_1].scriptables) {
    var_3 enablescriptableplayeruse(var_0);
  }

  if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
    foreach(var_6 in level.battle_tracks_shouldstartbattletracks) {
      if(var_6.iscash == var_1) {
        var_6 showtoplayer(var_0);
      }
    }

    return;
  }
}

function spawn_compound_final_push(var_0, var_1) {
  foreach(var_3 in level.trial_enemies_killed[var_1].scriptables) {
    var_3 disablescriptableplayeruse(var_0);
  }

  if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
    foreach(var_6 in level.battle_tracks_shouldstartbattletracks) {
      if(var_6.iscash == var_1) {
        var_6 hidefromplayer(var_0);
      }
    }

    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    thread cargo_truck_mg_initlate();
  }
}

function cargo_truck_mg_initlate() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("intel_challenges_setup_complete");

  foreach(var_1 in level.ref_129cc) {
    var_1 disablescriptableplayeruse(self);
  }

  foreach(var_5, var_4 in level.trial_enemies_killed) {
    if(!var_4.stopdragonsbreath) {
      continue;
    }

    spawn_compound_final_push(self, var_5);
  }

  self.audio_panodes = [];

  if(getdvarint("scr_intel_challenges_debug", 0) == 1) {
    var_6 = [];

    foreach(var_5, var_4 in level.trial_enemies_killed) {
      if(!var_4.stopdragonsbreath) {
        continue;
      }

      var_6 = var_5;
    }

    self.audio_panodes = var_6;
  } else {
    var_8 = 3001;
    var_9 = undefined;

    foreach(var_5, var_4 in level.trial_enemies_killed) {
      if(var_4.ref_145a6 < var_8) {
        continue;
      }

      if(var_8 < var_4.ref_145a6) {
        var_8 = var_4.ref_145a6;
      }

      if(isDefined(var_9) && var_9 < var_4.ref_145a6) {
        var_9 = undefined;
      }

      var_11 = self getplayerdata("mp", "missionComplete", var_5);

      if(!isDefined(var_9) && !var_11) {
        var_9 = var_4.ref_145a6;
        var_8++;
        self.audio_panodes[self.audio_panodes.size] = var_5;
      }
    }
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_5, var_4 in level.trial_enemies_killed) {
    if(!var_4.stopdragonsbreath) {
      continue;
    }

    if(scripts\engine\utility::array_contains(self.audio_panodes, var_5)) {
      ref_1335c(self, var_5);
    }
  }
}

function trial_headicon(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_0.type) && var_0.type == "intel") {
    var_5 = 1;

    if(!scripts\engine\utility::array_contains(var_3.audio_panodes, var_0.iscash)) {
      var_5 = 0;
    }

    if(var_0.iscash == "ch_intel_season3_2_5") {
      if(!var_3 scripts\mp\utility\perk::_hasperk("specialty_hack")) {
        var_5 = 0;
        playsoundatpos(var_3.origin, "br_computer_deny");
      }
    }

    if(var_5) {
      if(level.trial_enemies_killed[var_0.iscash].scriptables.size > 1 && istrue(level.trial_enemies_killed[var_0.iscash].helis_assault3_fob)) {
        if(!isDefined(var_3.pers[var_0.iscash])) {
          var_3.pers[var_0.iscash] = 1;
        } else {
          var_3.pers[var_0.iscash]++;
        }

        var_6 = level.trial_enemies_killed[var_0.iscash].scriptables.size;

        if(var_3.pers[var_0.iscash] < var_6) {
          var_0 disablescriptableplayeruse(var_3);
          var_3 playsoundtoplayer("ui_intel_interact", var_3);
          return;
        }
      }

      spawn_compound_final_push(var_3, var_0.iscash);
      var_3 reportchallengeuserevent("collect_item", level.trial_enemies_killed[var_0.iscash].chopper_boss_player_monitor);
      var_3 playsoundtoplayer("ui_intel_interact", var_3);
      return;
    }

    return;
  }
}

function updatematchstatushintonnoflag(var_0, var_1) {
  return isDefined(var_0.audio_panodes) && scripts\engine\utility::array_contains(var_0.audio_panodes, var_1);
}

function ref_11b12(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

  foreach(var_4 in var_2) {
    if(updatematchstatushintonnoflag(var_4, var_1.iscash)) {
      trial_headicon(var_1, undefined, undefined, var_4);
    }
  }
}

function x1opsbink() {
  level endon("game_ended");

  for(;;) {
    self waittill("emp_applied", var_0);
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.attacker, 0);

    foreach(var_3 in var_1) {
      if(updatematchstatushintonnoflag(var_3, self.iscash)) {
        trial_headicon(self.scriptable, undefined, undefined, var_3);
      }
    }
  }
}
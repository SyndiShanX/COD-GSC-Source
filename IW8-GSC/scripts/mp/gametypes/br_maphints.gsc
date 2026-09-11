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
  var0 = tablelookupgetnumrows("mp/intel_challenges.csv");

  for(var1 = 0; var1 < var0; var1++) {
    var2 = tablelookupbyrow("mp/intel_challenges.csv", var1, 0);

    if(isDefined(var2) && var2 != "") {
      var3 = getentitylessscriptablearrayinradius(var2, "script_noteworthy");

      foreach(var5 in var3) {
        var5 setscriptablepartstate("hint", "off", 1);
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

  foreach(var1 in level.ref_11ae4["keypads"]) {
    level.ref_11ae4["keypads"][var2].scriptable = easepower("maphint_keypad", var1.origin);
  }
}

function times_in_b() {
  level.ref_11ae4["phones"] = [];

  foreach(var1 in level.ref_11ae4["phones"]) {
    level.ref_11ae4["phones"][var2].scriptable = easepower("maphint_phone", var1.origin);
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

  foreach(var1 in level.ref_11ae4["computers"]) {
    level.ref_11ae4["computers"][var2].scriptable = easepower("maphint_computer", var1.origin);
  }
}

function times_in_c() {
  level.ref_11ae4["radios"] = [];
  level.ref_11ae4["radios"][0] = spawnStruct();
  level.ref_11ae4["radios"][0].origin = (-21440, 19434, -252);
  level.ref_11ae4["radios"][1] = spawnStruct();
  level.ref_11ae4["radios"][1].origin = (2896, 45445, 1630);

  foreach(var1 in level.ref_11ae4["radios"]) {
    level.ref_11ae4["radios"][var2].scriptable = easepower("maphint_radio", var1.origin);
  }
}

function ref_11ae1(var0, var1, var2, var3, var4) {
  thread allow_player_skip_deathshield(level, var0, var1, var2, var3);
}

function allow_player_skip_deathshield(var0, var1, var2, var3, var4) {
  if(var2 == "on") {
    playsoundatpos(var3.origin, "br_keypad_deny");
    var0 setscriptablepartstate("maphint_keypad", "off");
    wait 3;
    var0 setscriptablepartstate("maphint_keypad", "on");
    return;
  }
}

function ref_11ae3(var0, var1, var2, var3, var4) {
  thread allowassassinationdamage(level, var0, var1, var2, var3);
}

function allowassassinationdamage(var0, var1, var2, var3, var4) {
  if(var2 == "on") {
    playsoundatpos(var3.origin, "br_phone_deny");
    var0 setscriptablepartstate("maphint_phone", "off");
    wait 3;
    var0 setscriptablepartstate("maphint_phone", "on");
    return;
  }
}

function ref_11adf(var0, var1, var2, var3, var4) {
  thread allow_player_minimapforcedisable(level, var0, var1, var2, var3);
}

function allow_player_minimapforcedisable(var0, var1, var2, var3, var4) {
  if(var2 == "on") {
    playsoundatpos(var3.origin, "br_computer_deny");
    var0 setscriptablepartstate("maphint_computer", "off");
    wait 3;
    var0 setscriptablepartstate("maphint_computer", "on");
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

  foreach(var1 in level.ref_11ae4["keypads"]) {
    var2 = easepower("maphint_keypad", var1.origin);
  }

  level.ref_11ae4["phones"] = [];
  level.ref_11ae4["phones"][0] = spawnStruct();
  level.ref_11ae4["phones"][0].origin = (-21, -2721, 60);
  level.ref_11ae4["phones"][1] = spawnStruct();
  level.ref_11ae4["phones"][1].origin = (-21, -2721, 260);

  foreach(var1 in level.ref_11ae4["phones"]) {
    var2 = easepower("maphint_phone", var1.origin);
  }

  level.ref_11ae4["computers"] = [];
  level.ref_11ae4["computers"][0] = spawnStruct();
  level.ref_11ae4["computers"][0].origin = (100, -2721, 60);
  level.ref_11ae4["computers"][1] = spawnStruct();
  level.ref_11ae4["computers"][1].origin = (100, -2721, 260);

  foreach(var1 in level.ref_11ae4["computers"]) {
    var2 = easepower("maphint_computer", var1.origin);
  }
}

function ref_11ae0() {
  var0 = 1;

  for(;;) {
    if(var0) {
      foreach(var2 in level.ref_11ae4["phones"]) {
        thread scripts\mp\utility\debug::drawsphere(var2.scriptable.origin, 64, 1, (0, 1, 0));
      }
    }

    if(getdvarint("scr_mapHint_debugReset", 0) == 1) {
      foreach(var2 in level.ref_11ae4["keypads"]) {
        var2.scriptable freescriptable();
      }

      foreach(var2 in level.ref_11ae4["phones"]) {
        var2.scriptable freescriptable();
      }

      foreach(var2 in level.ref_11ae4["computers"]) {
        var2.scriptable freescriptable();
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
  var0 = getdvarint("LSQRKOSLTP", 0);
  level.ref_129cc = getentitylessscriptablearrayinradius("intel_challenge", "targetname");

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow("mp/intel_challenges.csv", var1, 0);
    var3 = tablelookupbyrow("mp/intel_challenges.csv", var1, 1);

    if(!isDefined(var3) || var3 == "") {
      break;
    }

    var4 = int(tablelookupbyrow("mp/intel_challenges.csv", var1, 3));
    var5 = int(tablelookupbyrow("mp/intel_challenges.csv", var1, 2));

    if(var5 > var0 && getdvarint("scr_intel_challenges_debug", 0) == 0) {
      var1++;
      continue;
    }

    var6 = tablelookupbyrow("mp/intel_challenges.csv", var1, 4);
    var7 = tablelookupbyrow("mp/intel_challenges.csv", var1, 5);
    var8 = float(tablelookupbyrow("mp/intel_challenges.csv", var1, 6));
    var9 = float(tablelookupbyrow("mp/intel_challenges.csv", var1, 7));
    var10 = float(tablelookupbyrow("mp/intel_challenges.csv", var1, 8));
    var11 = (var8, var9, var10);
    var12 = float(tablelookupbyrow("mp/intel_challenges.csv", var1, 9));
    var13 = float(tablelookupbyrow("mp/intel_challenges.csv", var1, 10));
    var14 = float(tablelookupbyrow("mp/intel_challenges.csv", var1, 11));
    var15 = (var12, var13, var14);
    var16 = tablelookupbyrow("mp/intel_challenges.csv", var1, 13);

    if(!isDefined(level.trial_enemies_killed[var3])) {
      var17 = spawnStruct();
      var17.ref = var3;
      var17.stopdragonsbreath = var4;
      var17.ref_145a6 = var5;
      var17.chopper_boss_player_monitor = var6;
      var17.origin = var11;
      var17.helis_assault3_fob = var16;
      var17.scriptables = [];
      level.trial_enemies_killed[var3] = var17;
    }

    if(var4) {
      var18 = getentitylessscriptablearrayinradius(var2, "script_noteworthy");
      var19 = var18[0];

      if(!isDefined(var19)) {
        var19 = easepower("intel", var11, var15);
      }

      var19.ref_11c74 = var7;
      var19.iscash = var3;
      level.trial_enemies_killed[var3].scriptables[var2] = var19;
    }
  }

  thread cargo_truck_mg_initspawning();
  scripts\engine\scriptable::scriptable_addusedcallback(&trial_headicon);
  var20 = getentitylessscriptablearrayinradius("intel_challenge", "targetname");
  scripts\mp\flags::gameflagset("intel_challenges_setup_complete");
}

function cargo_truck_mg_initspawning() {
  wait 1;

  foreach(var1 in level.trial_enemies_killed) {
    if(!var1.stopdragonsbreath) {
      continue;
    }

    foreach(var3 in level.trial_enemies_killed[var5].scriptables) {
      var3 setscriptablepartstate("model", var3.ref_11c74);
    }
  }
}

function ref_1335c(var0, var1) {
  foreach(var3 in level.trial_enemies_killed[var1].scriptables) {
    var3 enablescriptableplayeruse(var0);
  }

  if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
    foreach(var6 in level.battle_tracks_shouldstartbattletracks) {
      if(var6.iscash == var1) {
        var6 showtoplayer(var0);
      }
    }

    return;
  }
}

function spawn_compound_final_push(var0, var1) {
  foreach(var3 in level.trial_enemies_killed[var1].scriptables) {
    var3 disablescriptableplayeruse(var0);
  }

  if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
    foreach(var6 in level.battle_tracks_shouldstartbattletracks) {
      if(var6.iscash == var1) {
        var6 hidefromplayer(var0);
      }
    }

    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    thread cargo_truck_mg_initlate();
  }
}

function cargo_truck_mg_initlate() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("intel_challenges_setup_complete");

  foreach(var1 in level.ref_129cc) {
    var1 disablescriptableplayeruse(self);
  }

  foreach(var5, var4 in level.trial_enemies_killed) {
    if(!var4.stopdragonsbreath) {
      continue;
    }

    spawn_compound_final_push(self, var5);
  }

  self.audio_panodes = [];

  if(getdvarint("scr_intel_challenges_debug", 0) == 1) {
    var6 = [];

    foreach(var5, var4 in level.trial_enemies_killed) {
      if(!var4.stopdragonsbreath) {
        continue;
      }

      var6 = var5;
    }

    self.audio_panodes = var6;
  } else {
    var8 = 3001;
    var9 = undefined;

    foreach(var5, var4 in level.trial_enemies_killed) {
      if(var4.ref_145a6 < var8) {
        continue;
      }

      if(var8 < var4.ref_145a6) {
        var8 = var4.ref_145a6;
      }

      if(isDefined(var9) && var9 < var4.ref_145a6) {
        var9 = undefined;
      }

      var11 = self getplayerdata("mp", "missionComplete", var5);

      if(!isDefined(var9) && !var11) {
        var9 = var4.ref_145a6;
        var8++;
        self.audio_panodes[self.audio_panodes.size] = var5;
      }
    }
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var5, var4 in level.trial_enemies_killed) {
    if(!var4.stopdragonsbreath) {
      continue;
    }

    if(scripts\engine\utility::array_contains(self.audio_panodes, var5)) {
      ref_1335c(self, var5);
    }
  }
}

function trial_headicon(var0, var1, var2, var3, var4) {
  if(isDefined(var0) && isDefined(var0.type) && var0.type == "intel") {
    var5 = 1;

    if(!scripts\engine\utility::array_contains(var3.audio_panodes, var0.iscash)) {
      var5 = 0;
    }

    if(var0.iscash == "ch_intel_season3_2_5") {
      if(!var3 scripts\mp\utility\perk::_hasperk("specialty_hack")) {
        var5 = 0;
        playsoundatpos(var3.origin, "br_computer_deny");
      }
    }

    if(var5) {
      if(level.trial_enemies_killed[var0.iscash].scriptables.size > 1 && istrue(level.trial_enemies_killed[var0.iscash].helis_assault3_fob)) {
        if(!isDefined(var3.pers[var0.iscash])) {
          var3.pers[var0.iscash] = 1;
        } else {
          var3.pers[var0.iscash]++;
        }

        var6 = level.trial_enemies_killed[var0.iscash].scriptables.size;

        if(var3.pers[var0.iscash] < var6) {
          var0 disablescriptableplayeruse(var3);
          var3 playsoundtoplayer("ui_intel_interact", var3);
          return;
        }
      }

      spawn_compound_final_push(var3, var0.iscash);
      var3 reportchallengeuserevent("collect_item", level.trial_enemies_killed[var0.iscash].chopper_boss_player_monitor);
      var3 playsoundtoplayer("ui_intel_interact", var3);
      return;
    }

    return;
  }
}

function updatematchstatushintonnoflag(var0, var1) {
  return isDefined(var0.audio_panodes) && scripts\engine\utility::array_contains(var0.audio_panodes, var1);
}

function ref_11b12(var0, var1) {
  var2 = scripts\mp\utility\teams::getfriendlyplayers(var0.team, 0);

  foreach(var4 in var2) {
    if(updatematchstatushintonnoflag(var4, var1.iscash)) {
      trial_headicon(var1, undefined, undefined, var4);
    }
  }
}

function x1opsbink() {
  level endon("game_ended");

  for(;;) {
    self waittill("emp_applied", var0);
    var1 = scripts\mp\utility\teams::getfriendlyplayers(var0.attacker, 0);

    foreach(var3 in var1) {
      if(updatematchstatushintonnoflag(var3, self.iscash)) {
        trial_headicon(self.scriptable, undefined, undefined, var3);
      }
    }
  }
}
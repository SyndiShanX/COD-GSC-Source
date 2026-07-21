/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58305.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_8A1804DAAB75"] = ::init;
}

init() {
  level._id_13D7B = ::spawn_first_leads_early;
  level._id_13D71 = ::civvies_killed_calculate;
  level._id_13D73 = ::targets_missed_calculate;
  level._id_13D81 = ::_id_13DAF;
  build_vehicle_drop_off_list();
  dialog_init();

  while(!isDefined(level.struct_class_names))
    waitframe();

  level.course_triggers = getEntArray("_encstr_81F20CA34DEDEF635F1296D1C755", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.course_targets = _stop_spawn_modules::gettargetarray();
  level.course_movers = scripts\engine\utility::getStructArray("_encstr_8D6A0CDAEDECCA93EBCDD12C39D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.start_area_fx = loadfx("_encstr_958334D999F0E5D2DD1CBEDA075ED1E44B16B1E65ECD0E2B95914C858DC6CBCE330FF51D2796C2C6DCEB4BDA07F536B12C9717ECCC3C");

  foreach(var_1 in level.course_triggers)
  var_1 thread _stop_spawn_modules::_id_13D82();

  foreach(var_1 in level.course_targets)
  var_1 thread _stop_spawn_modules::_id_13D79();

  thread game_start();
  thread game_end();
  var_8 = getEntArray("_encstr_B4D6103A272DB036BE2C6B6B7B8D4E85A3CA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_8, ::brplayerkilledspawn);
  level._id_13D85 = ::_id_13E6D;

  while(!istrue(level._id_13022))
    waitframe();

  foreach(var_10 in level._id_13D65)
  var_10 setCanDamage(0);
}

game_start() {
  thread _id_1382B();
  var_0 = getEntArray("_encstr_99AD06D3A5B1538B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(;;) {
    level._id_13D6A = 0;
    _tablethide::trial_ui_set_subtime(0);
    level._id_13D6F = 1;
    _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13D6F, "_encstr_82DD09CFCB90B55651A6EB", 0, 0);
    level._id_13D6F++;

    if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] != "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0") {
      level._id_13A88 = level._id_13D6F;
      level._id_13D6F++;
      _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13A88, "_encstr_9A161859B956D6F2EB3AB093CEB21D9BFA349647D727B08E4B7B", 0, 0);
    }

    if(level.civilian_targets.size) {
      level.hacking_vo = level._id_13D6F;
      level._id_13D6F++;
      _tablethide::trial_ui_set_stat_and_bonus_time(level.hacking_vo, "_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547", 0, 0);
    }

    _tablethide::trial_ui_set_objective_progress(0, level.enemy_targets.size);
    _tablethide::trial_ui_set_reward_tier_preview(3);

    for(;;) {
      var_1 = 0;

      foreach(var_3 in var_0) {
        if(var_3.activated) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        break;
      }

      waitframe();
    }

    level notify("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");

    foreach(var_6 in level._id_13D65)
    var_6 setCanDamage(1);

    level.player playSound("_encstr_974910030BF3CF55A9BF0610CFE09B17A623");
    thread tierfailure_countdown_think();
    _tablethide::_id_13D88();
    _tablethide::_id_13D89(0);
    level._id_13D6A = 1;
    thread accuracy_think();
    thread time_think();
    _tablethide::trial_ui_waittill_retry();
  }
}

game_end() {
  if(game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"] == -1)
    level.player_best_time = 0;
  else
    level.player_best_time = game["_encstr_8CA606F38878410D"]["_encstr_B1270A86DD77337FDB5AB8F0"];

  var_0 = getEnt("_encstr_961804BD954A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(;;) {
    level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");

    switch (level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"]) {
      case "_encstr_8A1804DAAB75":
        var_0 waittill_trigger_activated_or_player_death();
        break;
      case "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0":
        _id_143A3();
        thread _id_12CBC();
        break;
      default:
        break;
    }

    level notify("_encstr_B8D80D131723B292AB2759B2975BA0");
    _tablethide::_id_13D89(1);

    if(!level.player_died_during_course && (!level.player_best_time || level.player_best_time > level.trial_main_time)) {
      level.player_best_time = level.trial_main_time;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B40108EEB2B00EEDB9C4"] = level.player.primaryweapons[0].basename;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B2010820C5337B67C815"] = level.player.primaryweapons[1].basename;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_82DD09CFCB90B55651A6EB"] = level.course_accuracy;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_ABDA07EA10868F1F68"] = level.enemies_missed;
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"] = level.civs_killed;
    }

    level.score["_encstr_BE7D0633C08849E2"] = level.trial_main_time;
    level.player_best_time = level.player_best_time - level.player_best_time % 100;
    _tablethide::trial_ui_set_best_time(level.player_best_time);

    if(level.player_best_time == 0 || level.player_best_time > level.trial["_encstr_816C069599555DA7"]) {
      _tablethide::trial_ui_set_reward_tier(0);
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_2]);
    } else if(level.player_best_time <= level.trial["_encstr_966C066BF011B2F7"]) {
      _tablethide::trial_ui_set_reward_tier(3);
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A38210E84E2D0B1BDCAFDD2D9BD7435AD91A"][var_2]);
    } else if(level.player_best_time <= level.trial["_encstr_876C06B1FF0A66F2"]) {
      _tablethide::trial_ui_set_reward_tier(2);
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2EA0FC3105326CB1BC01F0960A6F76CE1"][var_2]);
    } else {
      _tablethide::trial_ui_set_reward_tier(1);
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A7EA0FA395DB7A04F8B68B1488C15CD2AC"][var_2]);
    }

    foreach(var_4 in level.course_triggers)
    var_4.activated = 0;

    foreach(var_7 in level.course_targets) {
      var_7.activated = 0;
      var_7 thread _stop_spawn_modules::_id_13D74("_encstr_9767056D0FBFA8");
    }

    setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 0);

    if(level.player_died_during_course) {
      setomnvar("_encstr_96D3107308481B83430991495D26D0EB8B33", 1);
      var_1 = game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_B2F50C0B1AE180B9A3E779777F8B"][var_2]);
      level.player stoplocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
      level.player clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
      thread _id_12CBC();
    }

    if(istrue(level._id_13D6C))
      wait 3;

    _tablethide::trial_ui_open_results_screen();
  }
}

waittill_trigger_activated_or_player_death() {
  level.player_died_during_course = 1;
  level.player endon("_encstr_AD75063D571AE108");

  while(!self.activated)
    waitframe();

  level.player_died_during_course = 0;
}

_id_143A3() {
  level.player_died_during_course = 1;
  level.player endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = 1;

    foreach(var_2 in level.enemy_targets) {
      if(!var_2.activated)
        var_0 = 0;
    }

    if(var_0) {
      level.player_died_during_course = 0;
      waitframe();
      return;
    }

    waitframe();
  }
}

_id_12CBC() {
  level._id_13D60 = 1;
  _tablethide::trial_ui_waittill_retry();
  _tablethide::_id_13D5E();
}

_id_1382B() {
  var_0 = scripts\engine\utility::getStruct("_encstr_8F2416980DD5470BE80B601788974FCB32BD241EC36F38D6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 = deleteheadicon(var_1);
  setheadiconfriendlyimage(var_2, "_encstr_AFD015B4C6BDDCF5DD2C5EC1B7D2E6A3AFB516276DACC9");
  setheadiconzoffset(var_2, 1);
  setheadiconsnaptoedges(var_2, 0);
  setheadicondrawthroughgeo(var_2, 1);
  _tablethide::waittill_player_isDefined();

  for(;;) {
    addteamtoheadiconmask(var_2, level.player);
    level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
    removeteamfromheadiconmask(var_2, level.player);
    _tablethide::trial_ui_waittill_retry();
  }
}

spawn_first_leads_early() {
  if(self.is_civilian || level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] != "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0") {
    return;
  }
  while(!isDefined(level.enemies_killed))
    waitframe();

  while(level.enemies_killed < level.enemy_targets.size - 10)
    waitframe();

  while(level.trial_subtime <= level.trial["_encstr_876C06B1FF0A66F2"])
    waitframe();

  scripts\mp\utility\outline::outlineenableforplayer(self.plate, level.player, "_encstr_8D8621C85D0BD3C826151928A241D7EB6267B9F84F23329B3B3F385FB047D25DE333E1", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
}

_id_13DAF() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("_encstr_92FC151B0801E96F60921E830F08AAA1876F4B575F284A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::array_intersection(var_0, var_1);

  foreach(var_4 in var_2)
  magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_4.origin, (0, 0, -1), 0.05);
}

time_think() {
  level endon("_encstr_B8D80D131723B292AB2759B2975BA0");
  level.start_time = gettime();
  level.civs_killed = 0;
  level.enemies_killed = 0;
  level.enemies_missed = level.enemy_targets.size;
  level.civ_time_penalty = 0;
  level.missed_time_penalty = 0;
  level.trial_accuracy_bonus = 0;
  targets_missed_calculate();
  civvies_killed_calculate(1);
  _tablethide::trial_ui_set_objective_progress(level.enemies_killed, level.enemy_targets.size);

  for(;;) {
    time_calculate();
    waitframe();
  }
}

civvies_killed_calculate(var_0) {
  if(!level.civilian_targets.size) {
    return;
  }
  level.civs_killed = 0;

  foreach(var_2 in level.civilian_targets) {
    if(var_2.activated)
      level.civs_killed++;
  }

  level.civ_time_penalty = level.civs_killed * 5000;
  _tablethide::trial_ui_set_stat_and_bonus_time(level.hacking_vo, "_encstr_B4CD15C6A5B3D28D96C2B9AFA3584EECCA1DE67DA1A547", level.civs_killed, level.civ_time_penalty);

  if(!istrue(var_0)) {
    level.player thread scripts\mp\rank::scoreeventpopup("_encstr_850616EBDD83225CD149448B206091FAE86F6F1779B92A0C");
    self playSound("_encstr_9B2017BDC63A5785BED74D9A778A753260F5CBEF2BF1D2F81B");
  }
}

targets_missed_calculate() {
  level.enemies_missed = 0;

  foreach(var_1 in level.enemy_targets) {
    if(!var_1.activated)
      level.enemies_missed++;
  }

  level.enemies_killed = level.enemy_targets.size - level.enemies_missed;
  level.missed_time_penalty = level.enemies_missed * 5000;
  _tablethide::trial_ui_set_objective_progress(level.enemies_killed, level.enemy_targets.size);

  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] != "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0")
    _tablethide::trial_ui_set_stat_and_bonus_time(level._id_13A88, "_encstr_9A161859B956D6F2EB3AB093CEB21D9BFA349647D727B08E4B7B", level.enemy_targets.size - level.enemies_missed, level.missed_time_penalty);
}

time_calculate() {
  level.trial_subtime = gettime() - level.start_time;
  level.trial_main_time = level.trial_subtime + level.civ_time_penalty + level.missed_time_penalty + level.trial_accuracy_bonus;
  _tablethide::trial_ui_set_subtime(level.trial_subtime);
  _tablethide::trial_ui_set_main_time(level.trial_main_time);

  if(!isDefined(level.reward_tier))
    level.reward_tier = 3;

  var_0 = level.reward_tier;

  if(level.trial_subtime <= level.trial["_encstr_966C066BF011B2F7"]) {
    _tablethide::trial_ui_set_reward_tier_preview(3);
    level.reward_tier = 3;
  } else if(level.trial_subtime <= level.trial["_encstr_876C06B1FF0A66F2"]) {
    _tablethide::trial_ui_set_reward_tier_preview(2);
    level.reward_tier = 2;
  } else if(level.trial_subtime <= level.trial["_encstr_816C069599555DA7"]) {
    _tablethide::trial_ui_set_reward_tier_preview(1);
    level.reward_tier = 1;
  } else {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    level.reward_tier = 0;
  }

  if(level.reward_tier < var_0)
    level.player playSound("_encstr_937A12E84E2D85B1F5E699C3BE330B96B1AE9395");
}

tierfailure_countdown_think(var_0, var_1) {
  self endon("_encstr_B8D80D131723B292AB2759B2975BA0");
  var_2 = [];
  var_2[0] = undefined;
  var_2[1] = level.trial["_encstr_816C069599555DA7"] / 1000;
  var_2[2] = level.trial["_encstr_876C06B1FF0A66F2"] / 1000;
  var_2[3] = level.trial["_encstr_966C066BF011B2F7"] / 1000;
  wait 1;

  for(var_3 = 3; var_3 >= 0; var_3--) {
    var_4 = var_3;

    if(isDefined(var_2[var_3])) {
      while(level.trial_subtime / 1000 < var_2[var_3] - 5)
        wait 0.05;

      for(var_5 = 5; var_5 > 2; var_5--) {
        level.player playSound("_encstr_BAF61CE8939616C67DB9331EF5CC85A563D539ACD7C6F6ABB94723BD7773");
        wait 1;
      }

      for(var_5 = 2; var_5 > 0; var_5--) {
        level.player playSound("_encstr_91271F50D3AC3B707F7B3C2B7FB31993550BF85079466F6B638435A84FEB86537A");
        wait 1;
      }
    }
  }
}

accuracy_think() {
  level endon("_encstr_B8D80D131723B292AB2759B2975BA0");
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_82DD09CFCB90B55651A6EB", 0, 0);
  level.shots_fired = 0;
  level.course_accuracy = 0;

  for(;;) {
    level.player scripts\engine\utility::_id_143A5("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_81D812992CB5567D7756C20EDECDFACC964ECA8C");
    level.shots_fired++;
    var_0 = level.player getcurrentweapon();
    var_1 = weaponfiretime(var_0);

    if(isDefined(var_1)) {
      if(var_1 > 0.05)
        wait(var_1);
    }

    waitframe();
    level.course_accuracy = (level.enemy_targets.size - level.enemies_missed) / clamp(level.shots_fired, 1, 99999);
    var_2 = -1 * level.course_accuracy * 5000;
    level.trial_accuracy_bonus = var_2 - var_2 % 100;
    _tablethide::trial_ui_set_stat_and_bonus_time(1, "_encstr_82DD09CFCB90B55651A6EB", 100 * level.course_accuracy, level.trial_accuracy_bonus);
  }
}

dialog_init() {
  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] != "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0") {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_A37B136F1110CACDC0C17DC3DB10E581D3859BF3F7";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_9B80195BD0EB76EA736CDEAEC96E2BAFA5B9474EBDD76E0DDEC9A3";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_A7D313B50DF53B5DDCD8DEBA9CB9597D9BE858E481";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_A1D313D6D0EBCEAE37B1ED57C93759EB37A316394C";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_93D313184147473B701BE0C382BB4DC730DC17C842";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_A3D3135BD0FAB35DCD8DDBBAC9CD2BAF6EA3B04ECC";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_975B13FAF1370743231E2890FDD8DD8728B00BC268";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AC60D1BA7D0E24F3566A3DB89966B"] = "_encstr_AAD313D6D0D7ECBA37D8DE5D9CE6597DB91DB027D1";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD"] = "_encstr_A5451684888F8F507029D70302079809AF57872148696278";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B80D15A2C763DBC85F7773990B37B4B7EF8838637397BB"] = "_encstr_A2F217BFCB99DCD816A668230AD38018F2732B37AF7293A835";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF441079205DE317CF69485362FEEBF78B8B"] = "_encstr_880715DA7499A7CB0ED728E08B4B819F925BCEDE889351";
  } else {
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B150C2306935224A618E3B3F898"] = "_encstr_829A15B79A49BD5E6873837051E5E8D8838F70D5315A30";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_994612186A739139E9C84609D8D831F3722FB8D3"] = "_encstr_95941B781FD8ABB77BDFAD2F9CC5EB9BF2B1F1ED558B7F376360470518";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_B1E1196B0EAFDAF59B3895CA32C4B0C61BBE569BC8FA819B478527";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_830C19ADE0FA6BAFDC075656C83158D8C6AF95CDC8F5C4CD47B09C";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_BD2819F05B27E1A992388BF354BE1039B301491882CF86106B01AD";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_8743192D63C7C0CEB39B526A3232961042F7CFC8C4B163CFAD8725";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAC30CB5E0384E6BD74B5D8BBBF8"] = "_encstr_BDC918D97299B38E139B7860D35A01F9D2D140D64C317DB1E1C3";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AC60D1BA7D0E24F3566A3DB89966B"] = "_encstr_ADDC1D83288138E0874391996AABA768E5AF3F15AA79E837EFA92BA30233E5";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD"] = "_encstr_85B01C6D3BC95DD99EC18F87C1CEE284B8266536D0711672FC879BAF3765";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B80D15A2C763DBC85F7773990B37B4B7EF8838637397BB"] = "_encstr_A2F217BFCB99DCD816A668230AD38018F2732B37AF7293A835";
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF441079205DE317CF69485362FEEBF78B8B"] = "_encstr_BE211D450F08A8B702197D191C528FB3A1D777AEE8A7E3A33B818BA37B0220";
  }

  thread dialog_hurry_up_watcher();
  thread dialog_kill_watcher();
}

dialog_hurry_up_watcher() {
  for(;;) {
    level waittill("_encstr_8C3D12A0235CC7E1876AB09753EB68BD062B50A8");
    thread dialog_hurry_up_thread();
  }
}

dialog_hurry_up_thread() {
  level endon("_encstr_8C3D12A0235CC7E1876AB09753EB68BD062B50A8");
  level endon("_encstr_B8D80D131723B292AB2759B2975BA0");
  wait 9;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AF441079205DE317CF69485362FEEBF78B8B");
}

dialog_kill_watcher() {
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  var_0 = 0;
  var_1 = 0;
  var_2 = gettime();
  var_3 = gettime();
  var_4 = 5000;

  for(;;) {
    if(level.civs_killed > var_1 && gettime() > var_3 + var_4) {
      level.player scripts\engine\utility::delaythread(0.5, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_B80D15A2C763DBC85F7773990B37B4B7EF8838637397BB");
      var_3 = gettime();
    } else if(level.enemies_killed > var_0 + 1 && gettime() > var_2 + var_4) {
      level.player scripts\engine\utility::delaythread(0.25, scripts\mp\utility\dialog::leaderdialogonplayer, "_encstr_951F11DE1FA73B9F2771F8D8AAFF0FD36BB7DD");
      var_2 = gettime();
    }

    var_1 = level.civs_killed;
    var_0 = level.enemies_killed;
    waitframe();
  }
}

brplayerkilledspawn() {
  self.headicon = deleteheadicon(self);
  setheadiconfriendlyimage(self.headicon, "_encstr_AD6E13B11CF51B27C2E895AF4BC6DB37F585D6B5BD");
  setheadiconmaxdistance(self.headicon, 800);
  addclienttoheadiconmask(self.headicon, 50);
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 50), (0, 0, 0));
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 setHintString(&"_encstr_877B1B286827614037D53101797048344120E265A74C69193FA9371FC8");
  var_0 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_0 sethintdisplayrange(200);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(80);
  var_0 setusefov(120);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  for(;;) {
    var_0 makeusable();
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
    var_1 = level.player getcurrentweapon();
    var_2 = level.player getcurrentweaponclipammo();
    level.player setweaponammoclip(var_1, var_2);

    if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A31C07E04BD8ADABE0") {
      var_3 = level.player getweaponammostock(var_1) + 1;
      var_4 = 1;
    } else {
      var_3 = weaponclipsize(var_1) - var_2;
      var_4 = 5;
    }

    level.player setweaponammostock(var_1, var_3);
    var_0 makeunusable();
    setheadiconteam(self.headicon);
    wait(var_4);
    hideheadiconfromplayersinmask(self.headicon);
  }
}

_id_13E6D() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  var_0 = scripts\mp\utility\outline::outlineenableforplayer(self, level.player, "_encstr_82441AB2373FBC589D33A101813A1FE7AB7990038D839BB875DDA19F", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  thread _id_13E6C();

  while(isalive(self))
    waitframe();

  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

_id_13E6C() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");

  if(isalive(self))
    self notify("_encstr_AD75063D571AE108");
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D33;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B40108EEB2B00EEDB9C4"] = "_encstr_811804E565FC";
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B2010820C5337B67C815"] = "_encstr_811804E565FC";
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_82DD09CFCB90B55651A6EB"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_ABDA07EA10868F1F68"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"] = 0;
  }
}

_id_13D33() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_AF8F13DB2C27D846120F49272BFA0E608FC3C05057");
  var_3 = "_encstr_B40101" + game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B40108EEB2B00EEDB9C4"];
  var_4 = "_encstr_B40101" + game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B2010820C5337B67C815"];
  var_5 = float(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_82DD09CFCB90B55651A6EB"]);
  var_6 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_ABDA07EA10868F1F68"]);
  var_7 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_A7980A6E84BB0B58B94FB020"]);
  level.player dlog_recordplayerevent("_encstr_97301E248DDF67F7D56B012383380BCE8B788CE927E0F780CC613B510162E338", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_84EF055338A18F", var_2, "_encstr_B40108EEB2B00EEDB9C4", var_3, "_encstr_B2010820C5337B67C815", var_4, "_encstr_82DD09CFCB90B55651A6EB", var_5, "_encstr_ABDA07EA10868F1F68", var_6, "_encstr_A7980A6E84BB0B58B94FB020", var_7]);
}
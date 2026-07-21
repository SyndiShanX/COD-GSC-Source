/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_trigger_spawn.gsc
***********************************************/

init_trigger_spawns() {
  scripts\engine\utility::flag_init("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  var_0 = getEntArray("_encstr_84640E5C1E08BFC7D380F93378333B63", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_0, ::setup_trigger_spawn);
  var_0 = getEntArray("_encstr_8F7E1AAD2B5A01B7557B691AE0716360C824679271A718116368F5F3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_0, ::kill_flood_spawner);
}

setup_trigger_spawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_A31A14E62B1DD583BE8EE45AD9D9AC9CEBE68358BB73");
  self endon("_encstr_A31A14E62B1DD583BE8EE45AD9D9AC9CEBE68358BB73");
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::ent_flag_init("_encstr_8CE912CDC1C2EE9B4BE6B3AFB17BD60E1B958E2B");
  scripts\engine\utility::ent_flag_init("_encstr_BA341053C128FB939BF84AB143E7B7B25041");
  default_trigger_loop();
  wait 1;

  if(!istrue(self.dont_delete))
    self delete();
}

default_trigger_loop() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA391551A7E7FB53E9E3419C229BE82AD540292147089B");
  self endon("_encstr_BA391551A7E7FB53E9E3419C229BE82AD540292147089B");
  self.spawnpoints = undefined;
  self.guys_spawned = 0;

  if(isDefined(self.target))
    self.spawnpoints = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_0 = [];
  var_1 = undefined;

  if(isDefined(self.spawnpoints)) {
    foreach(var_3 in self.spawnpoints) {
      if(!isDefined(var_3.script_label)) {
        continue;
      }
      if(var_3.script_label == "_encstr_BD12065B20DB1B26")
        var_0[var_0.size] = var_3;
    }

    var_1 = self.spawnpoints;
  }

  scripts\engine\utility::ent_flag_clear("_encstr_8CE912CDC1C2EE9B4BE6B3AFB17BD60E1B958E2B");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_5);

    if(scripts\cp\cp_modular_spawning::isambientspawningpaused()) {
      wait 1;
      continue;
    }

    if(!var_5 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(getdvarint("_encstr_85F01A2646BB2719F9478868C30DB6B9636C94A45FD35FA3C8273073", 0) == 1) {
      break;
    }

    level thread on_trigger_actions(self, var_5);

    if(!isDefined(var_1)) {
      self notify("_encstr_B224162BB95083DB5F80E29A0B36E73DC8298F862FA88DBB");
      return;
    }

    if(scripts\engine\utility::ent_flag_exist("_encstr_BA341053C128FB939BF84AB143E7B7B25041") && scripts\engine\utility::ent_flag("_encstr_BA341053C128FB939BF84AB143E7B7B25041"))
      scripts\engine\utility::ent_flag_waitopen("_encstr_BA341053C128FB939BF84AB143E7B7B25041");

    switch (level.players.size) {
      case 1:
        var_1 = scripts\engine\utility::array_remove_array(var_1, var_0);
        break;
      case 2:
        var_0 = scripts\engine\utility::array_randomize(var_0);
        var_0 = [var_0[0], var_0[1]];
        var_1 = scripts\engine\utility::array_combine(var_1, var_0);
        break;
      default:
        break;
    }

    var_6 = 0;

    foreach(var_3 in var_1) {
      var_8 = _spawnsoldier(var_3);

      if(!isDefined(var_8)) {
        continue;
      }
      var_8 thread notify_trigger_on_death(self, var_8);
      var_3.lastspawntime = gettime();
      var_8.killofftime = gettime() + 10000;

      if(isDefined(level.enemy_monitor_func) && !istrue(level.disable_enemy_monitor))
        var_8 thread[[level.enemy_monitor_func]]("_encstr_958C08CDDBD8325A959C");

      var_8 thread respawn_on_death(var_3);
      var_6++;

      if(var_6 % 4 == 0)
        wait 0.05;
    }

    break;
  }
}

notify_trigger_on_death(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.guys_spawned++;
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0.guys_spawned--;

  if(var_0.guys_spawned <= 0)
    var_0 scripts\engine\utility::ent_flag_set("_encstr_8CE912CDC1C2EE9B4BE6B3AFB17BD60E1B958E2B");
}

respawn_on_death(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8A860EF157AD1880E72331FBEAA7C0D0");

  if(!isDefined(var_0.count)) {
    return;
  }
  var_0.count = int(var_0.count);
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0.count) && var_0.count > 0) {
    var_0.count--;
    wait_to_spawn(var_0);
    thread script_spawnsoldiers(var_0);
  }
}

wait_to_spawn(var_0) {
  if(isDefined(var_0.script_wait)) {
    var_0.script_wait = int(var_0.script_wait);
    wait(var_0.script_wait);
  } else
    wait 0.1;
}

on_trigger_actions(var_0, var_1) {
  if(isDefined(var_0.script_label))
    level notify("_encstr_99EA0963DBD25FE4D146C7" + var_0.script_label);

  if(isDefined(var_0.script_function) && isDefined(level.trigger_spawn_func[var_0.script_function]))
    level thread[[level.trigger_spawn_func[var_0.script_function]]](var_0, var_1);

  if(isDefined(var_0.script_flag)) {
    if(!scripts\engine\utility::flag_exist(var_0.script_flag))
      scripts\engine\utility::flag_init(var_0.script_flag);

    scripts\engine\utility::flag_set(var_0.script_flag);
  }
}

spawn_enemy(var_0, var_1) {
  var_2 = ["_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588", "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1", "_encstr_93D811967783AFB9DAEB5BC1C2E0B0D4F5AD83", "_encstr_AFD81196BB83FADCDA7D0785832C9C817DAD83", "_encstr_B8AB117B772FAF28D569E9630F8F88C4F1A7C1"];
  var_3 = ["_encstr_8D06112DDDE0EB6EE6BEB5B463BD271CFAD61C"];
  var_4 = ["_encstr_8DE1122D770EFA9BA1AF46832CC1C22664BEB5C1"];
  var_5 = ["_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937"];
  var_6 = ["_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8"];
  var_7 = undefined;

  if(!isDefined(var_0.script_noteworthy))
    var_0.script_noteworthy = "_encstr_958C08CDDBD8325A959C";

  var_8 = undefined;
  var_9 = undefined;

  if(!isDefined(var_1)) {
    switch (var_0.script_noteworthy) {
      case "_encstr_A11904E483B3":
        var_1 = scripts\engine\utility::random(var_6);
        var_8 = ::set_default_rpg_values;
        break;
      case "_encstr_A65B084B38A76BEFC350":
        var_1 = scripts\engine\utility::random(var_4);
        var_9 = ::hunt_player;
        break;
      case "_encstr_850707F7E5833355B8":
        var_1 = scripts\engine\utility::random(var_3);
        var_8 = ::set_default_sniper_values;
        break;
      case "_encstr_9A190463ADB3":
        var_1 = scripts\engine\utility::random(var_5);
        var_8 = ::set_default_sniper_values;
        break;
      default:
        var_1 = scripts\engine\utility::random(var_2);
    }
  }

  var_1 = scripts\cp\cp_weapon::getcompletenameforweapon(var_1);
  var_7 = spawn_enemy_soldier(var_0, var_1);

  if(isDefined(var_7)) {
    var_7.spawnpoint = var_0;
    var_7.spawnfunc = var_8;
    var_7.combatfunc = var_9;
  }

  return var_7;
}

spawn_enemy_soldier(var_0, var_1) {
  var_2 = "_encstr_8E8405EA382B2A";

  if(isDefined(level.agentteamarray)) {
    if(isDefined(level.agentteamarray["_encstr_958C08CDDBD8325A959C"]))
      var_2 = level.agentteamarray["_encstr_958C08CDDBD8325A959C"];
  }

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_3 = (0, var_0.angles[1], 0);
  var_4 = var_0.origin;
  var_5 = undefined;
  var_6 = 0;
  var_7 = "_encstr_82581D851BD1BD93D79573B26B2FF51B83FA0BC6B8BE91AC372B4E1DD7B09C";

  if(var_0.script_noteworthy == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
    var_7 = "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC";

  for(;;) {
    var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_7, var_4, var_3);

    if(isDefined(var_5)) {
      break;
    }

    var_6++;

    if(var_6 > 2)
      return undefined;

    wait 0.05;
    continue;
  }

  var_5.spawnpoint = var_0;
  return var_5;
}

go_fight(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA460A801FCE13550257B345");
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  scripts\asm\asm_bb::bb_requestmovetype("_encstr_AA7C07466F9DA30713");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self setgoalpos(getclosestpointonnavmesh(var_1.origin));
  scripts\engine\utility::_id_143A5("_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958");

  if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
    scripts\cp\cp_agent_patrol::enter_combat();
  else
    enter_combat();
}

set_default_values(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.groupname))
    self.groupname = var_0.groupname;

  if(isDefined(var_1.script_groupname))
    self.groupname = var_1.script_groupname;

  if(isDefined(self.unittype) && self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    return;
  }
  self.health = 125;
  self.maxhealth = 125;
  self.og_health = 125;
  self.goalradius = 4096;
  self.og_goalradius = self.goalradius;
  self.spawnpoint = var_1;
  self.sidearm = scripts\cp\cp_weapon::buildweapon("_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.sidearm);
  thread delay_values();

  if(isDefined(self.spawnfunc))
    self thread[[self.spawnfunc]]();

  if(istrue(level.use_temp_bc)) {
    self.next_dmg_sound = gettime();
    var_2 = randomintrange(1, 7);
    self.painsound = "_encstr_A60E1401071DFB2398E1EF823ADB951F159A5057A08F" + var_2;
    self.deathsound = "_encstr_861C153B95379539D2C6EBC8B2C2A3A1FA56372BDA5EAF" + var_2;
  }
}

delay_values() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.1;
  self.dropweapon = 0;
  self.a.disablelongdeath = 1;
}

set_default_patrol_values() {
  scripts\asm\asm_bb::bb_requestmovetype("_encstr_96080730D8534E0A28");
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  thread exit_patrol_mode();
  thread scripts\cp\cp_modular_spawning::fake_flashlight();
  self.stealth_initialized = 1;
}

set_default_rpg_values() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  self.goalradius = 300;
  self.og_goalradius = self.goalradius;
  self.rocketammo = 100;
  self.accuracy = 2;
}

set_default_sniper_values() {
  self endon("_encstr_AD75063D571AE108");
  self.no_fallback = 1;
  wait 0.5;
  self.goalradius = 250;
  self.og_goalradius = self.goalradius;
}

target_patrol_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    self setgoalpos(getclosestpointonnavmesh(var_1.origin));
    scripts\engine\utility::_id_143A5("_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958");

    if(isDefined(var_1.target)) {
      var_2 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_1 = var_2;
      continue;
    }

    break;
  }
}

getscoredpatrolpoint(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_2 = [var_2];
  else
    var_2 = [];

  foreach(var_4 in var_1) {
    if(istrue(var_4.cooldown))
      var_5 = 999;
    else if(istrue(var_4.halfcooldown))
      var_5 = 500;
    else
      var_5 = 99;

    var_6 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\cp\cp_agent_utils::getactiveagentsoftype("_encstr_A7E80E1818902B623DBA872BD4C1184C"), var_2, 5, 512);

    if(var_6.size >= 1)
      var_5 = var_5 * (100 * var_6.size);

    var_5 = clamp(var_5, 0, 999);
    var_4.patrolscore = int(var_5);
  }

  var_8 = scripts\cp\utility::quicksort(var_1);

  foreach(var_4 in var_8)
  var_4.patrolscore = 0;

  return var_8[0];
}

setcooldown(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 0.5 * var_1;
  var_0.cooldown = 1;
  wait(var_2);
  var_0.cooldown = undefined;
  var_0.halfcooldown = 1;
  wait(var_2);
  var_0.halfcooldown = undefined;
}

patrol_path(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  var_2 = scripts\engine\utility::getStructArray("_encstr_A36E0FE6EDD8C8B4B24EAF3816A339F6C6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray("_encstr_A36E0FE6EDD8C8B4B24EAF3816A339F6C6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"), [var_0], 15);

  if(var_3.size < 1) {
    var_2 = scripts\engine\utility::getStructArray(var_0.targetname, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray(var_0.targetname, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), [var_0], 15);
  }

  var_4 = scripts\engine\utility::getclosest(var_0.origin, var_3, 256);

  if(isDefined(var_4))
    var_5 = var_4;
  else
    var_5 = getscoredpatrolpoint(self, var_3);

  for(;;) {
    var_5 thread setcooldown(var_5, 99);
    self setgoalpos(getclosestpointonnavmesh(var_5.origin));
    scripts\engine\utility::_id_143BA(15, "_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958");

    if(scripts\engine\utility::cointoss())
      wait(randomfloatrange(2.5, 5));

    if(isDefined(var_5.target)) {
      var_6 = scripts\engine\utility::getStructArray(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0];

      if(isDefined(var_6)) {
        var_5 = var_6;
        continue;
      } else if(istrue(var_1)) {
        break;
      }
    } else if(istrue(var_1)) {
      break;
    }

    var_5 = getscoredpatrolpoint(self, var_3, var_5);
  }
}

exit_patrol_mode() {
  self notify("_encstr_9BB4110F8BF731319A43AB28C7E2AF78ADF342");
  self endon("_encstr_9BB4110F8BF731319A43AB28C7E2AF78ADF342");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");

  if(scripts\engine\utility::flag_exist("_encstr_A2D20FE4880D52A426C867576878654BD3"))
    scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  thread watch_for_bulletwhizby();
  thread watch_for_weaponsfire();
  thread soldier_player_listener();
  scripts\engine\utility::waittill_any_ents(self, "_encstr_B2BE0788BAF573592F", level, "_encstr_8D9112B327ACB9588C59F5CAF083B1BD9B96DBE6", self, "_encstr_AD171358D85693D1B219EB26CBF59BF61B32D2B2E4");

  if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
    scripts\cp\cp_agent_patrol::enter_combat();
  else
    enter_combat();

  wait 2.4;
  alert_all_nearby_enemies("_encstr_B2470D1239275387A261D1D503F08F");
}

watch_for_bulletwhizby() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");
  var_0 = "_encstr_B40101";
  var_1 = 0;
  var_2 = scripts\engine\utility::waittill_any_ents_return(self, "_encstr_A5490D5E05C3F8B363F3C8D83B3E43", self, "_encstr_B62D0EF1483D9B1F1E291798DFE378C3");

  if(var_2 == "_encstr_A5490D5E05C3F8B363F3C8D83B3E43") {
    var_0 = "_encstr_A6160C1F902D50566A6271F9EB53";
    var_1 = 0;
  } else if(var_2 == "_encstr_B62D0EF1483D9B1F1E291798DFE378C3") {
    var_0 = "_encstr_92FD0B1AE0074BE10885D9932B";
    var_1 = 0;
  }

  if(trigger_temp_stealth_meter(5.1, undefined, var_2, var_1)) {
    if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
      scripts\cp\cp_agent_patrol::enter_combat();
    else
      enter_combat();

    wait 2.4;
    alert_all_nearby_enemies(var_0);
  } else
    thread watch_for_bulletwhizby();
}

watch_for_weaponsfire() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA22087EA808525BA5D9");

  for(;;) {
    level waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_0, var_1, var_2);
    var_3 = 0;

    foreach(var_5 in var_1.attachments) {
      if(issubstr(var_5, "_encstr_AD3E09B95A632BDC6CCA27"))
        var_3 = 1;
    }

    if(var_3) {
      continue;
    }
    break;
  }

  if(trigger_temp_stealth_meter(2.6, undefined, "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", 1)) {
    if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
      scripts\cp\cp_agent_patrol::enter_combat();
    else
      enter_combat();

    wait 2.4;
    alert_all_nearby_enemies("_encstr_A6160C1F902D50566A6271F9EB53");
  }
}

trigger_temp_stealth_meter(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    return 0;

  self endon("_encstr_BA22087EA808525BA5D9");

  if(!isDefined(level.is_stealthy))
    return 1;

  if(!isDefined(var_1))
    var_1 = 0.25;

  if(!istrue(self.has_alert_icon)) {
    self.has_alert_icon = 1;
    wait 0.05;
    var_4 = deleteheadicon(self);
    setheadiconfriendlyimage(var_4, "_encstr_9377179843DF1391223651654CB9935947A3F1603FAB2E57FB");
    setheadicondrawthroughgeo(var_4, 1);
    setheadiconsnaptoedges(var_4, 29000);
    setheadiconmaxdistance(var_4, 425);
    addclienttoheadiconmask(var_4, 25);
    self.alert_icon = var_4;
    thread temp_stealthicon_initiate(10);
    thread temp_stealth_meter_delete_on_death(var_4);
    var_5 = undefined;

    if(!istrue(var_3)) {
      wait(var_1);

      if(var_2 == "_encstr_9BF808B10B9BD7CD562B") {
        foreach(var_7 in level.players) {
          if(ifcanseeplayer(self, var_7)) {
            var_5 = "_encstr_9BF808B10B9BD7CD562B";
            thread temp_player_debug_whotriggered(var_7);
          }

          wait 0.05;
        }
      } else
        var_5 = "_encstr_8B1608EC43B8D647A113";

      if(isDefined(var_5) && var_5 != "_encstr_9BF808B10B9BD7CD562B")
        var_5 = scripts\engine\utility::_id_143BE(var_0, var_2, "_encstr_9BF808B10B9BD7CD562B", "_encstr_AD75063D571AE108", "_encstr_ADC3080EAB68FA17D9D9", "_encstr_B2BE0788BAF573592F", "_encstr_8E9C0CA1595827FAA35D934E59E8");
    }

    if(isDefined(var_5) && (var_5 == var_2 || var_5 == "_encstr_9BF808B10B9BD7CD562B" || var_5 == "_encstr_ADC3080EAB68FA17D9D9") || istrue(var_3)) {
      thread temp_stealthicon_changecolor(var_0, 2, "_encstr_867B15E63FB8867DB9B0234B7B89E0BE9FC0B62F8F63B8");
      return 1;
    } else {
      thread detected_temp_stealth_meter(self.alert_icon, 0.01);
      return 0;
    }
  }

  return 0;
}

temp_stealthicon_initiate(var_0) {
  self endon("_encstr_ABEB0DD2589FA547B99D44452DA193");
  self endon("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self.has_alert_icon) || isDefined(self.alert_icon) && self.alert_icon == 0) {
    if(isalive(self)) {
      var_1 = var_0;
      var_2 = 0;

      while(var_1 > 0) {
        var_1--;
        var_2 = !var_2;

        if(var_2 == 1)
          setheadiconfriendlyimage(self.alert_icon, "_encstr_867B15E63FB8867DB9B0234B7B89E0BE9FC0B62F8F63B8");
        else
          setheadiconfriendlyimage(self.alert_icon, "_encstr_9377179843DF1391223651654CB9935947A3F1603FAB2E57FB");

        wait 0.05;
        wait 0.05;
      }

      if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
        setheadiconfriendlyimage(self.alert_icon, "_encstr_B24717A29B385783886BDCCC11318C6F5830F9FAC005F7FFB0");
      else if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && !scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
        setheadiconfriendlyimage(self.alert_icon, "_encstr_9377179843DF1391223651654CB9935947A3F1603FAB2E57FB");
    }
  }
}

temp_stealthicon_changecolor(var_0, var_1, var_2) {
  self endon("_encstr_ABEB0DD2589FA547B99D44452DA193");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_AD75063D571AE108");
  var_3 = 1;

  if(isDefined(var_1))
    var_3 = var_1;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(istrue(self.has_alert_icon) || isDefined(self.alert_icon) && self.alert_icon == 0) {
      if(isalive(self)) {
        self notify("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");
        setheadiconfriendlyimage(self.alert_icon, var_2);
        thread detected_temp_stealth_meter(self.alert_icon, var_0 * 5.5);
      }
    }

    wait 0.05;
  }
}

detected_temp_stealth_meter(var_0, var_1) {
  self notify("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");
  self endon("_encstr_ABEB0DD2589FA547B99D44452DA193");
  scripts\engine\utility::_id_143BA(var_1, "_encstr_AD75063D571AE108", "_encstr_BA22087EA808525BA5D9");
  wait 0.5;
  thread detected_temp_stealth_meter_delete(var_0);
}

detected_temp_stealth_meter_delete(var_0) {
  self notify("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");
  self endon("_encstr_ABEB0DD2589FA547B99D44452DA193");
  self endon("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");

  if(istrue(self.has_alert_icon) && istrue(self.alert_icon) && istrue(var_0)) {
    self.has_alert_icon = 0;
    setheadiconimage(var_0);
    var_0 = undefined;
    self notify("_encstr_ABEB0DD2589FA547B99D44452DA193");
  } else if(istrue(self.has_alert_icon)) {
    self.has_alert_icon = 0;
    setheadiconimage(var_0);
    var_0 = undefined;
    self notify("_encstr_ABEB0DD2589FA547B99D44452DA193");
  }
}

temp_stealth_meter_delete_on_death(var_0) {
  self endon("_encstr_ABEB0DD2589FA547B99D44452DA193");
  self waittill("_encstr_AD75063D571AE108");
  self notify("_encstr_8F3B130F7EFFBDA1580FC886EDC0916177EAAF1310");
  var_1 = 0.45;

  if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    var_1 = var_1 * 5.5;

  wait(var_1);

  if(isDefined(var_0)) {
    self.has_alert_icon = 0;
    setheadiconimage(var_0);
    var_0 = undefined;
    self notify("_encstr_ABEB0DD2589FA547B99D44452DA193");
  }
}

temp_player_debug_whotriggered(var_0) {
  if(!scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0")) {
    return;
  }
  self notify("_encstr_96ED13732BDDD736586E47F5E89C4BCE76594EB232");
  self endon("_encstr_96ED13732BDDD736586E47F5E89C4BCE76594EB232");
  var_1 = undefined;

  for(;;) {
    if(!scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
      var_1 = var_0;
    else {
      level.debug_last_triggered = var_1;
      return;
    }

    wait 0.1;
  }
}

enter_combat() {
  self notify("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self.scripted_mode = 0;
  self.ignoreall = 0;

  if(isDefined(self.ismarked))
    self hudoutlinedisable();

  if(isDefined(self.spawnpoint.script_goalvolume)) {
    var_0 = getEnt(self.spawnpoint.script_goalvolume, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

    if(!isDefined(var_0))
      var_0 = getEnt(self.spawnpoint.script_goalvolume, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_0))
      self setgoalvolumeauto(var_0);
  }

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self getenemyinfo(var_2);
  }

  if(isDefined(self.og_goalradius))
    self.goalradius = self.og_goalradius;
  else
    self.goalradius = 4096;

  scripts\asm\asm_bb::bb_requestmovetype("_encstr_AA7C07466F9DA30713");

  if(isDefined(self.combatfunc))
    self thread[[self.combatfunc]]();

  thread temp_sound_init();
}

temp_sound_init() {
  if(istrue(level.use_temp_bc) && soundexists("_encstr_88F71AB76937F853690F869BC77FAF70F3389BF5A329BA891BCACE77")) {
    if(randomint(100) > 50)
      self playSound("_encstr_88F71AB76937F853690F869BC77FAF70F3389BF5A329BA891BCACE77");

    self.next_dmg_sound = gettime() + randomintrange(1000, 3000);
    thread temp_sound_watcher();
  }
}

temp_sound_watcher() {
  self notify("_encstr_B222133A2BB5E0AFDCED57DC32D7EE16A36CA1ACC9");
  self endon("_encstr_B222133A2BB5E0AFDCED57DC32D7EE16A36CA1ACC9");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 5;
  var_1 = 25;

  if(istrue(self.hunting_player)) {
    var_0 = 3;
    var_1 = 5;
  }

  for(;;) {
    wait(randomintrange(var_0, var_1));
    var_2 = scripts\engine\utility::random(["_encstr_88F71AB76937F853690F869BC77FAF70F3389BF5A329BA891BCACE77", "_encstr_8204194372C9A7F381E1264D3BA98E5F76D96FBB996A34EF07F2F9" + randomintrange(1, 13), "_encstr_8CE11D3722D14B02AEA7DBDF63587A8EE0282AFD7E18055B7FD58FCF0F7DF2"]);

    if(soundexists(var_2))
      self playSound(var_2);
  }
}

soldier_player_listener() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_929018AB88296973B85266097027AA101E3FF58A2B38535ED0CB");
  self endon("_encstr_929018AB88296973B85266097027AA101E3FF58A2B38535ED0CB");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");
  soldier_player_listener_checker();

  if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
    scripts\cp\cp_agent_patrol::enter_combat();
  else
    enter_combat();

  wait 6.96;
  alert_all_nearby_enemies("_encstr_BE5F0CE0359632265AC1B2FB6BB0");
}

soldier_player_listener_checker() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_97B22037DEB1192DAC937DC1635897CA93AFB196DC8E56E6CA4EAFB186ACD85BB227");
  self endon("_encstr_97B22037DEB1192DAC937DC1635897CA93AFB196DC8E56E6CA4EAFB186ACD85BB227");
  self endon("_encstr_BA22087EA808525BA5D9");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_82CA0D07613BCBD718F32F36E8F838");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isplayernearme(self, var_1)) {
        self notify("_encstr_ADC3080EAB68FA17D9D9");

        if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
          scripts\cp\cp_agent_patrol::enter_combat();
        else
          enter_combat();

        wait 0.05;

        if(trigger_temp_stealth_meter(2.6, undefined, "_encstr_ADC3080EAB68FA17D9D9", 1)) {
          wait 2.4;
          alert_all_nearby_enemies("_encstr_BE5F0CE0359632265AC1B2FB6BB0");
        }
      } else if(ifcanseeplayer(self, var_1)) {
        self notify("_encstr_9BF808B10B9BD7CD562B");
        wait 0.05;
        var_2 = scripts\engine\utility::distance_2d_squared(self.origin, var_1.origin);
        var_3 = var_2 / 160000;

        if(var_3 < 0.9)
          var_3 = 0.9;

        if(trigger_temp_stealth_meter(2.6, var_3, "_encstr_9BF808B10B9BD7CD562B")) {
          if(isDefined(self.alert_icon))
            thread temp_stealthicon_changecolor(2.6, 2, "_encstr_867B15E63FB8867DB9B0234B7B89E0BE9FC0B62F8F63B8");

          if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
            scripts\cp\cp_agent_patrol::enter_combat();
          else
            enter_combat();

          wait 2.4;
          alert_all_nearby_enemies("_encstr_AF010BC8C73549A982668B9DBA");
        }
      }

      wait 0.05;
    }

    wait 0.1;
  }
}

isplayernearme(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(istrue(var_1.ignoreme))
    return 0;

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0.damaged);

  if(var_1 getstance() == "_encstr_B13D076BED70539F23") {
    if(var_3 > 35)
      return 0;
  } else if(var_3 > 96)
    return 0;

  var_5 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

  if(!var_5)
    return 0;

  var_6 = scripts\engine\trace::create_solid_ai_contents(1);

  if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_6))
    return 0;

  return 1;
}

ifcanseeplayer(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(istrue(var_1.ignoreme))
    return 0;

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0.damaged);
  var_5 = 1;
  var_6 = var_1 getvelocity();
  var_7 = length(var_6);

  if(var_7 < 128)
    var_5 = 0.75;
  else if(var_7 < 200 || var_2 && var_1.perk_data["_encstr_BAB41A1F8CAFF8D93B62361B9A73B7B0C4E473CF0FD3101EDB6A6961"])
    var_5 = 1;
  else
    var_5 = 1.25;

  if(var_3 > 1500 * var_5)
    return 0;

  var_8 = var_0 cansee(var_1);

  if(var_8) {
    var_9 = cos(75);
    var_10 = scripts\engine\utility::within_fov(var_0 getEye(), var_0 getplayerangles(1), var_1.origin + (0, 0, 40), var_9);

    if(!var_10)
      return 0;

    var_11 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

    if(!var_11)
      return 0;

    var_12 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_12))
      return 0;

    var_13 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_1.origin);
    var_5 = 1;

    if(var_13 >= 0.573576)
      var_5 = var_5 - 0.34;

    if(var_4)
      var_5 = var_5 - 0.34;

    var_14 = var_1 getstance();

    if(var_3 <= int(350 / var_5)) {
      if(var_14 == "_encstr_922406F1A6FD5E05")
        return 0;

      return 1;
    } else if(var_3 <= int(500 / var_5)) {
      if(var_14 == "_encstr_922406F1A6FD5E05")
        return 0;

      return 1;
    } else if(var_3 <= int(950 / var_5)) {
      if(var_14 == "_encstr_922406F1A6FD5E05" || var_14 == "_encstr_B13D076BED70539F23")
        return 0;

      return 1;
    }
  }

  return 0;
}

alert_all_nearby_enemies(var_0) {
  wait 0.1;
  thread temp_stealthicon_changecolor(2.6, 2, "_encstr_B24717A29B385783886BDCCC11318C6F5830F9FAC005F7FFB0");

  if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && !scripts\engine\utility::flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0")) {
    scripts\engine\utility::flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
    level notify("_encstr_B67219EE2CE753DFBB3A78F87215276917B27D709DBFD8FB23A2F8");
  }

  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_2 = 16386304;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }
    if(!isDefined(var_4.agent_type) || isDefined(var_4.agent_type) && var_4.agent_type != "_encstr_A7E80E1818902B623DBA872BD4C1184C") {
      continue;
    }
    if(distance2dsquared(self.origin, var_4.origin) > var_2) {
      continue;
    }
    if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1)
      var_4 scripts\cp\cp_agent_patrol::enter_combat();
    else
      var_4 enter_combat();

    var_4 notify("_encstr_BA22087EA808525BA5D9");
  }

  thread alert_debug_display(var_0);
}

alert_debug_display(var_0) {
  wait 0.1;

  foreach(var_2 in level.players) {
    var_3 = "_encstr_974C0246";

    if(isDefined(level.debug_last_triggered))
      var_3 = level.debug_last_triggered.name;

    var_2 iprintlnbold("_encstr_BE1A04976480" + var_3 + "_encstr_8C351A2F6640501B5639D1B2C8043A1AB2108EAB2C4E19DC9080A301" + var_0);
    wait 0.05;
  }
}

are_enemies_nearby(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_2 = var_0 * var_0;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }
    if(!isDefined(var_4.agent_type) || isDefined(var_4.agent_type) && var_4.agent_type != "_encstr_A7E80E1818902B623DBA872BD4C1184C") {
      continue;
    }
    var_5 = distance2dsquared(self.origin, var_4.origin);

    if(var_5 > var_2) {
      continue;
    }
    return 1;
  }

  return 0;
}

init_fallback_triggers() {
  var_0 = getEntArray("_encstr_A79611E5424A1739B503398837C4105592AED2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\engine\utility::array_thread(var_0, ::setup_fallback_trigger);
}

setup_fallback_trigger() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    [[level.fallback_trigger_func]](self, var_0);
    break;
  }

  wait 1;
  self delete();
}

fallback_to_closest_spot(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getclosest(self.origin, var_1);
  self.goalradius = 128;
  self setgoalpos(getclosestpointonnavmesh(var_2.origin));
  scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_A3130D9AF069D2310E87C1D9C03A82");
  self.goalradius = 1500;
}

script_spawnsoldiers(var_0) {
  if(scripts\cp\cp_modular_spawning::isambientspawningpaused())
    return undefined;

  if(!isarray(var_0)) {
    var_1 = _spawnsoldier(var_0);

    if(isDefined(var_1))
      var_1 thread respawn_on_death(var_0);

    return var_1;
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;
  var_5 = var_0;

  foreach(var_7 in var_0) {
    if(!isDefined(var_7.script_label)) {
      continue;
    }
    if(var_7.script_label == "_encstr_BD12065B20DB1B26")
      var_3[var_3.size] = var_7;
  }

  switch (level.players.size) {
    case 1:
      var_0 = scripts\engine\utility::array_remove_array(var_0, var_3);
      break;
    case 2:
      var_3 = scripts\engine\utility::array_randomize(var_3);
      var_3 = [var_3[0]];

      if(var_3.size == 2)
        var_3 = [var_3[0], var_3[1]];
      else if(var_3.size > 2)
        var_3 = [var_3[0], var_3[1], var_3[2]];

      var_0 = scripts\engine\utility::array_combine(var_0, var_3);
      break;
    default:
  }

  foreach(var_7 in var_0) {
    var_1 = _spawnsoldier(var_7);

    if(!isDefined(var_1)) {
      continue;
    }
    var_1 thread respawn_on_death(var_7);
    var_2[var_2.size] = var_1;
    var_4++;

    if(var_4 % 4 == 0)
      wait 0.05;
  }

  if(var_2.size)
    return var_2;
  else
    return undefined;
}

_spawnsoldier(var_0, var_1, var_2, var_3) {
  if(getdvarint("_encstr_A96918DCB127EBB0B1AC4E8E59237D8657CDE87D59DC16131B95") == 1) {
    if(!isDefined(level.host_spawn_point))
      return undefined;
  }

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_4 = var_0 scripts\cp\cp_modular_spawning::spawn_ai();

  if(isDefined(var_4)) {
    var_0 notify("_encstr_91940E4B73CF5F1D7177EDC36F986207", var_0);
    level notify("_encstr_A3DD1637382CEEDC56C8EBEC27DEAB83AFCD7B63C84B569C", var_4);
    thread scripts\cp\cp_modular_spawning::run_ai_post_spawn_init(undefined, var_4, var_0, undefined, undefined, 1, undefined);
    return var_4;
  }
}

debug_kill_soldier(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.nocorpse = 1;
  wait 3;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "_encstr_AB590C99ED78875F650F3951034D");
}

debug_kill_soldier_after_anim(var_0) {
  var_0.nocorpse = 1;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "_encstr_AB590C99ED78875F650F3951034D");
}

get_random_spec() {
  var_0 = ["_encstr_958C08CDDBD8325A959C", "_encstr_958C08CDDBD8325A959C", "_encstr_958C08CDDBD8325A959C", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_842408C29CB6DB392B32", "_encstr_842408C29CB6DB392B32", "_encstr_842408C29CB6DB392B32", "_encstr_8C710F56607DE7252963A0BB2BC85F5AB8", "_encstr_8C710F56607DE7252963A0BB2BC85F5AB8"];
  return var_0;
}

register_trigger_func(var_0, var_1) {
  if(!isDefined(level.trigger_spawn_func))
    level.trigger_spawn_func = [];

  level.trigger_spawn_func[var_0] = var_1;
}

run_trigger_func(var_0, var_1, var_2) {
  if(isDefined(level.trigger_spawn_func[var_0]))
    level thread[[level.trigger_spawn_func[var_0]]](var_1, var_2);
}

get_ai_by_groupname(var_0) {
  var_1 = [];
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_4 in var_2) {
    if(!var_4.isactive) {
      continue;
    }
    if(!isDefined(var_4.groupname)) {
      continue;
    }
    if(var_4.groupname != var_0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

hunt_player_delayed() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = randomintrange(25, 60);
  var_1 = randomintrange(10, 15);
  hunt_player(var_0, var_1);
}

hunt_player(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    wait(var_0);

  while(!should_hunt_player())
    wait 1;

  self.hunting_player = 1;
  self.no_fallback = 1;
  self.goalradius = 500;
  thread reduce_goalradius_over_time(var_1);

  for(;;) {
    if(!isDefined(self.enemy)) {
      wait 0.5;
      self.hunting_player = 0;
      continue;
    }

    self.hunting_player = 1;
    self setgoalentity(self.enemy, 3);
    wait 3;
  }
}

should_hunt_player() {
  var_0 = 0;
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.hunting_player))
      var_0++;
  }

  if(var_0 >= level.players.size)
    return 0;

  return 1;
}

reduce_goalradius_over_time(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = 2;

  for(;;) {
    if(self.goalradius < 250)
      self.goalradius = 250;
    else {
      self.goalradius = self.goalradius - 100;

      if(self.goalradius < 50)
        self.goalradius = 50;
    }

    wait(var_0);
  }
}

wait_for_group_cleared(var_0) {
  for(;;) {
    var_1 = get_ai_by_groupname(var_0);

    if(!var_1.size) {
      break;
    }

    wait 1;
  }

  level.ambient_spawning_paused = 0;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

do_door_spawn(var_0, var_1) {
  if(istrue(var_1.inuse)) {
    return;
  }
  var_1.inuse = 1;
  var_2 = ["_encstr_9165210B174B510A5753BF6185D8EDD68123D14FAFB3890B88F781EF8037DE97124F49", "_encstr_AC6521101BFA6E478A2DC0D3C51383736FEB30784F922651B256D8ED58D9D7DBBAC788", "_encstr_B865210A59408FFA701BC71775A5C2FA81234795D0B847435F1FBF3F61D86A3130EE3E"];
  var_1.og_angles = var_1.angles;

  foreach(var_5, var_4 in var_0)
  var_4 thread door_spawn_entrance(var_4, var_2, var_1, var_5);

  var_1.animname = "_encstr_84480E58D2AF37832CBBE6AFC87BDB4E";
  var_1 useanimtree(#animtree);
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "_encstr_A16724E6234EF5C6ED5BAF4B373A56C9F5E48CEDED39D73A858DFACA3CEBC6E2897D8CDBDE4E");
  var_1 playSound("_encstr_A3B50F0330A0BC21FD177F730F120AF3D8");
  var_6 = var_0[var_0.size - 1] scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_2[var_0.size - 1]);
  var_7 = var_0[var_0.size - 1] scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_6);
  wait(getanimlength(var_7) + 3);
  var_1.inuse = 0;
}

door_spawn_entrance(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.ignoreall = 1;
  var_0.scripted_mode = 1;
  scripts\asm\shared\mp\utility::burningpartlogic(var_1[var_3], var_2);
  var_0.ignoreall = 0;
  var_0.scripted_mode = 0;
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
}

kill_flood_spawner() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    foreach(var_3 in var_0)
    var_3.count = 0;

    break;
  }

  wait 1;
  self delete();
}

get_closest_unhunted_player() {
  var_0 = 1073741824;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }
    var_4 = distancesquared(self.origin, var_3.origin);

    if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_1;
}
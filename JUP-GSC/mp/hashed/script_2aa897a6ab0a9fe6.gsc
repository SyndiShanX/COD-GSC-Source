/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2aa897a6ab0a9fe6.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_41387eecc35b88bf;
#using script_5753ba9c28794a65;
#using script_638d701d263ee1ed;
#using script_7956d56c4922bd1;
#using script_fe797d0f2980f96;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#namespace namespace_d33f59adf1371d04;

function function_e3728e23c67c0893() {
  if(istrue(getdvarint(@ "hash_e0a808f0c05b7ec2", 0))) {
    return;
  }

  s_bundle = getscriptbundle("obdifficultymanager:ob_difficulty_manager_base");

  if(!isDefined(s_bundle)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  level.var_d33f59adf1371d04 = spawnStruct();
  level.var_d33f59adf1371d04.updatecooldown = default_to(s_bundle.updatecooldown, 1);
  level.var_d33f59adf1371d04.var_cd8bdc5ab10a653d = default_to(s_bundle.var_cd8bdc5ab10a653d, 8);
  level.var_d33f59adf1371d04.var_1929f713c9bd0d0d = default_to(s_bundle.var_1929f713c9bd0d0d, 2);
  level.var_d33f59adf1371d04.var_16566ef2187888d1 = default_to(s_bundle.var_16566ef2187888d1, 1);
  level.var_d33f59adf1371d04.var_aaf11fc3e5236d0b = default_to(s_bundle.var_aaf11fc3e5236d0b, 2);
  level.var_d33f59adf1371d04.var_28a5175f535cfc30 = default_to(s_bundle.var_28a5175f535cfc30, 3);
  level.var_d33f59adf1371d04.var_9b9103a411642a92 = default_to(s_bundle.var_9b9103a411642a92, 6);
  level.var_d33f59adf1371d04.var_f54aa5460f01506a = default_to(s_bundle.var_f54aa5460f01506a, 7);
  level.var_d33f59adf1371d04.var_f9c01cfd515c353b = default_to(s_bundle.var_f9c01cfd515c353b, 2);
  level.var_d33f59adf1371d04.var_c4aa3481e90a1644 = default_to(s_bundle.var_c4aa3481e90a1644, 4);
  level.var_d33f59adf1371d04.var_ca99f4bd9d2625a2 = default_to(s_bundle.var_ca99f4bd9d2625a2, 4);
  level.var_d33f59adf1371d04.var_f054303c5358efb = default_to(s_bundle.var_f054303c5358efb, 6);
  level.var_d33f59adf1371d04.var_ae51045c32a81d2d = default_to(s_bundle.var_ae51045c32a81d2d, 6);
  level.var_d33f59adf1371d04.var_d4f0adf3100613e8 = default_to(s_bundle.var_d4f0adf3100613e8, 0.8);
  level.var_d33f59adf1371d04.var_c000923809277559 = default_to(s_bundle.var_c000923809277559, 2);
  level.var_d33f59adf1371d04.var_bd5f1ea9f27333f0["zombie_hellhound"] = 1;
  level.var_d33f59adf1371d04.var_bd5f1ea9f27333f0["zombie_base"] = 2;
  level.var_d33f59adf1371d04.var_bd5f1ea9f27333f0["zombie_base_armored_heavy"] = 3;
  level.var_d33f59adf1371d04.var_bd5f1ea9f27333f0["zombie_mangler"] = 10;
  level.var_d33f59adf1371d04.spawnevents = [];
  level.var_d33f59adf1371d04.var_c65b5bce2145c2bc = [];
  spawnevents = s_bundle.var_353a95db366b54c;
  var_38a0599641c0747f = s_bundle.var_9c1c53be3162676d;

  if(isDefined(spawnevents)) {
    foreach(event in spawnevents) {
      eventcolor = default_to(event.var_489e98931a420e8b, "difficulty_easy");
      eventdifficulty = default_to(event.var_abf2f21255b5b7d5, "easy");

      if(!isDefined(level.var_d33f59adf1371d04.spawnevents[event.var_489e98931a420e8b])) {
        level.var_d33f59adf1371d04.spawnevents[eventcolor] = spawnStruct();
        level.var_d33f59adf1371d04.spawnevents[eventcolor].easy = [];
        level.var_d33f59adf1371d04.spawnevents[eventcolor].medium = [];
        level.var_d33f59adf1371d04.spawnevents[eventcolor].hard = [];
      }

      easysize = level.var_d33f59adf1371d04.spawnevents[eventcolor].easy.size;
      mediumsize = level.var_d33f59adf1371d04.spawnevents[eventcolor].medium.size;
      hardsize = level.var_d33f59adf1371d04.spawnevents[eventcolor].hard.size;

      if(eventdifficulty == "easy") {
        level.var_d33f59adf1371d04.spawnevents[eventcolor].easy[easysize] = spawnStruct();
        level.var_d33f59adf1371d04.spawnevents[eventcolor].easy[easysize].var_f625a578efca7f8e = default_to(event.var_f625a578efca7f8e, 0);
        level.var_d33f59adf1371d04.spawnevents[eventcolor].easy[easysize].var_d1e337675a4febbf = default_to(event.var_d1e337675a4febbf, "ai_encounter:ai_encounter_spawn_event_easy_green_1");
        continue;
      }

      if(eventdifficulty == "medium") {
        level.var_d33f59adf1371d04.spawnevents[eventcolor].medium[mediumsize] = spawnStruct();
        level.var_d33f59adf1371d04.spawnevents[eventcolor].medium[mediumsize].var_f625a578efca7f8e = default_to(event.var_f625a578efca7f8e, 0);
        level.var_d33f59adf1371d04.spawnevents[eventcolor].medium[mediumsize].var_d1e337675a4febbf = default_to(event.var_d1e337675a4febbf, "ai_encounter:ai_encounter_spawn_event_easy_green_1");
        continue;
      }

      if(eventdifficulty == "hard") {
        level.var_d33f59adf1371d04.spawnevents[eventcolor].hard[hardsize] = spawnStruct();
        level.var_d33f59adf1371d04.spawnevents[eventcolor].hard[hardsize].var_f625a578efca7f8e = default_to(event.var_f625a578efca7f8e, 0);
        level.var_d33f59adf1371d04.spawnevents[eventcolor].hard[hardsize].var_d1e337675a4febbf = default_to(event.var_d1e337675a4febbf, "ai_encounter:ai_encounter_spawn_event_easy_green_1");
      }
    }
  }

  level thread function_900b224f51e6952f();
}

function function_c17f70713e3b32e6() {
  n_players = self.playerparticipants.size;
  var_d54b8704cb9ea6bc = 0;

  switch (self.difficulty) {
    case #"hash_7bb2cd766703d463":
      var_d54b8704cb9ea6bc = n_players - level.var_d33f59adf1371d04.var_f9c01cfd515c353b;
      break;
    case #"hash_af83e47edfa8900a":
      var_d54b8704cb9ea6bc = n_players - level.var_d33f59adf1371d04.var_c4aa3481e90a1644;
      break;
    case #"hash_5343b465e56ec9a4":
      var_d54b8704cb9ea6bc = n_players - level.var_d33f59adf1371d04.var_ca99f4bd9d2625a2;
      break;
    case #"hash_651f76c0ad6741ec":
      var_d54b8704cb9ea6bc = n_players - level.var_d33f59adf1371d04.var_f054303c5358efb;
      break;
  }

  if(var_d54b8704cb9ea6bc >= level.var_d33f59adf1371d04.var_16566ef2187888d1 && var_d54b8704cb9ea6bc <= level.var_d33f59adf1371d04.var_aaf11fc3e5236d0b) {
    self.var_9104bda523a7745e = "easy";
    self.var_d54b8704cb9ea6bc = var_d54b8704cb9ea6bc;
    return;
  }

  if(var_d54b8704cb9ea6bc >= level.var_d33f59adf1371d04.var_28a5175f535cfc30 && var_d54b8704cb9ea6bc <= level.var_d33f59adf1371d04.var_9b9103a411642a92) {
    self.var_9104bda523a7745e = "medium";
    self.var_d54b8704cb9ea6bc = var_d54b8704cb9ea6bc;
    return;
  }

  if(var_d54b8704cb9ea6bc >= level.var_d33f59adf1371d04.var_f54aa5460f01506a) {
    self.var_9104bda523a7745e = "hard";
    self.var_d54b8704cb9ea6bc = var_d54b8704cb9ea6bc;
    return;
  }

  self.var_9104bda523a7745e = undefined;
  self.var_d54b8704cb9ea6bc = undefined;
}

function function_665935a06b2c3b16(var_b381b0883bcd4847) {
  var_c90b80e2759171b1 = function_30f6db0964bb1633(self);
  obproperties = var_c90b80e2759171b1.var_5de130ac10732635;

  if(istrue(obproperties.var_9854308bd339eec7)) {
    self.var_177c4e4d4ae90d53 = 1;

    if(!isDefined(self.difficulty)) {
      point = namespace_68dc261109a9503f::function_8988a4c89289d7f4(self);
      difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(point);
      self.difficulty = difficulty;
    }

    self.var_b30ea0426ecac94 = obproperties.var_c94ef4e226afbf8b.var_b9b77b74513a61ac;
    self.var_91fa3ff2e3ec781f = obproperties.var_c94ef4e226afbf8b.var_f73902d33a34c5d7;
    self.var_24a4dd28cba60cb1 = obproperties.var_c94ef4e226afbf8b.var_2bce786b1fd552e9;
    self.var_d684f521b593b6ef = obproperties.var_c94ef4e226afbf8b.var_33f32b9720c22e87;
    self.var_e234e23642d571ee = obproperties.var_c94ef4e226afbf8b.var_8ce8254b9215bc7f;
    function_8b5b2a3392fc7e2a("PlayerJoin", &function_e175e8f6a82c094d, self.type);
    function_8b5b2a3392fc7e2a("PlayerLeave", &function_33d0acfef12e9a3c, self.type);
  }
}

function function_e175e8f6a82c094d(var_b381b0883bcd4847) {
  if(istrue(self.var_177c4e4d4ae90d53)) {
    player_list = var_b381b0883bcd4847.playerlist;

    foreach(player in player_list) {
      if(isPlayer(player)) {
        if(!isDefined(self.difficulty)) {
          difficulty = player.difficulty;
          self.difficulty = difficulty;
        }
      }
    }

    function_c17f70713e3b32e6();
  }
}

function function_33d0acfef12e9a3c(var_b381b0883bcd4847) {
  if(istrue(self.var_177c4e4d4ae90d53)) {
    function_c17f70713e3b32e6();
  }
}

function function_900b224f51e6952f() {
  level endon("game_ended");

  while(true) {
    foreach(activity in level.activities.instances) {
      if(!isDefined(activity)) {
        continue;
      }

      activitystate = getactivitystate(activity);

      if(istrue(activity.var_177c4e4d4ae90d53)) {
        var_4aed760c6d068e13 = getdvarint(@ "hash_e7cee129b1a5b6f1", 0);
        var_1695b82fcb75a916 = getDvar(@ "hash_469e8ee29337b850", "<dev string:x47>");

        if(var_4aed760c6d068e13 > 0) {
          activity.var_d54b8704cb9ea6bc = var_4aed760c6d068e13;
          activity.var_9104bda523a7745e = var_1695b82fcb75a916;
        }

        if(isDefined(activity.var_9104bda523a7745e)) {
          activity function_4d566855e4ef8720();
          activity function_ef462f102d407064();
        }
      }
    }

    wait level.var_d33f59adf1371d04.updatecooldown;
  }
}

function function_4d566855e4ef8720() {
  time = gettime();

  if(!isDefined(self.var_93937a7d68e917f0)) {
    self.var_93937a7d68e917f0 = time;
  }

  if((time - self.var_93937a7d68e917f0) / 1000 < level.var_d33f59adf1371d04.var_1929f713c9bd0d0d) {
    return;
  }

  if(!isDefined(self.var_9104bda523a7745e)) {
    return;
  }

  if(self.var_9104bda523a7745e == "easy" && istrue(self.var_b30ea0426ecac94)) {
    return;
  } else if(self.var_9104bda523a7745e == "medium" && istrue(self.var_91fa3ff2e3ec781f)) {
    return;
  } else if(self.var_9104bda523a7745e == "hard" && istrue(self.var_24a4dd28cba60cb1)) {
    return;
  } else if(istrue(self.var_b30ea0426ecac94) && istrue(self.var_91fa3ff2e3ec781f) && istrue(self.var_24a4dd28cba60cb1)) {
    return;
  }

  self.var_93937a7d68e917f0 = time;

  if(!isDefined(self.var_934b4e6dcc8d3350)) {
    self.var_934b4e6dcc8d3350 = [];
  }

  var_ad4baf29665916d5 = 0;

  foreach(zombie in self.var_934b4e6dcc8d3350) {
    if(isalive(zombie)) {
      points = 0;

      if(isDefined(level.var_d33f59adf1371d04.var_bd5f1ea9f27333f0[zombie.subclass])) {
        points = level.var_d33f59adf1371d04.var_bd5f1ea9f27333f0[zombie.subclass];
      }

      var_ad4baf29665916d5 += points;
      continue;
    }

    self.var_934b4e6dcc8d3350 = array_remove(self.var_934b4e6dcc8d3350, zombie);
  }

  var_d54b8704cb9ea6bc = self.var_d54b8704cb9ea6bc;

  var_4aed760c6d068e13 = getdvarint(@ "hash_e7cee129b1a5b6f1", 0);

  if(var_4aed760c6d068e13 > 0) {
    var_d54b8704cb9ea6bc = var_4aed760c6d068e13;
  }

  var_d1ea44cc5cf470dd = var_d54b8704cb9ea6bc * level.var_d33f59adf1371d04.var_cd8bdc5ab10a653d;

  if(isDefined(level.var_d33f59adf1371d04.spawnevents[self.difficulty])) {
    var_bc67b30f4f1ac01 = [];

    if(self.var_9104bda523a7745e == "easy") {
      var_bc67b30f4f1ac01 = level.var_d33f59adf1371d04.spawnevents[self.difficulty].easy;
    } else if(self.var_9104bda523a7745e == "medium") {
      var_bc67b30f4f1ac01 = level.var_d33f59adf1371d04.spawnevents[self.difficulty].medium;
    } else if(self.var_9104bda523a7745e == "hard") {
      var_bc67b30f4f1ac01 = level.var_d33f59adf1371d04.spawnevents[self.difficulty].hard;
    }
  } else {
    return;
  }

  var_99f4421245958d63 = var_d1ea44cc5cf470dd - var_ad4baf29665916d5;
  validevents = [];

  foreach(event in var_bc67b30f4f1ac01) {
    if(event.var_f625a578efca7f8e <= var_99f4421245958d63) {
      validevents[validevents.size] = event;
    }
  }

  if(validevents.size > 0) {
    randomindex = randomintrange(0, validevents.size);
    spawnevent = validevents[randomindex];
    spawnpoints = [];

    if(isDefined(self.a_s_spawnpts)) {
      foreach(point in self.a_s_spawnpts) {
        spawnpoints[spawnpoints.size] = point.origin;
      }
    } else {
      spawnpoints[0] = namespace_68dc261109a9503f::function_8988a4c89289d7f4(self);

      foreach(player in self.playerparticipants) {
        spawnpoints[spawnpoints.size] = player.origin;
      }
    }

    randompointindex = randomintrange(0, spawnpoints.size);
    randompoint = spawnpoints[randompointindex];
    spawn_event("ai_encounter:" + spawnevent.var_d1e337675a4febbf, randompoint, 256);
    return;
  }

  return;
}

function spawn_event(ai_encounter, origin, radius) {
  requestid = function_f8ccadcd850da124(ai_encounter, origin, radius, 1, 0, 1, 1);
  scripts\cp_mp\agents\ai_spawn_director::function_e4a67fe4ddca7ed5(requestid, &function_ce33fb862aeb6f93, self);
}

function function_ce33fb862aeb6f93(requestid, instance, agent, ai_data) {
  if(isDefined(instance.var_934b4e6dcc8d3350)) {
    instance.var_934b4e6dcc8d3350 = array_add(instance.var_934b4e6dcc8d3350, agent);
  }
}

function function_ef462f102d407064() {
  time = gettime();

  if(!isDefined(self.var_e75b42e6c7c244d4)) {
    self.var_e75b42e6c7c244d4 = time;
  }

  var_d54b8704cb9ea6bc = isDefined(self.var_d54b8704cb9ea6bc) ? self.var_d54b8704cb9ea6bc : 1;

  var_4aed760c6d068e13 = getdvarint(@ "hash_e7cee129b1a5b6f1", 0);

  if(var_4aed760c6d068e13 > 0) {
    var_d54b8704cb9ea6bc = var_4aed760c6d068e13;
  }

  var_58abeae972627404 = level.var_d33f59adf1371d04.var_ae51045c32a81d2d * var_d54b8704cb9ea6bc * level.var_d33f59adf1371d04.var_d4f0adf3100613e8;

  if(var_58abeae972627404 < level.var_d33f59adf1371d04.var_c000923809277559) {
    var_58abeae972627404 = level.var_d33f59adf1371d04.var_c000923809277559;
  }

  if(!isDefined(self.var_93937a7d68e917f0)) {
    self.var_93937a7d68e917f0 = time;
  }

  if((time - self.var_e75b42e6c7c244d4) / 1000 < var_58abeae972627404) {
    return;
  }

  if(istrue(self.var_d684f521b593b6ef)) {
    return;
  }

  var_a921858aa59839ad = self.var_e234e23642d571ee;

  iprintlnbold("<dev string:x4f>");
}
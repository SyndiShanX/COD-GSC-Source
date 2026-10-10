/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1d280385f222835d.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_24f248b33b79e48d;
#using script_2ff6eb4f5b8663fb;
#using script_30fbbeb9a6251e9a;
#using script_3ab210ea917601e7;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_4538cf9ec73b7c58;
#using script_46c7c73b1a7e4773;
#using script_482376d10f69832c;
#using script_4e6e58ab5d96c2b0;
#using script_4ef01fe6151dde4d;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_6df6604a74a7a9c7;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7cfaa6fd841fb4dd;
#using scripts\common\callbacks;
#using scripts\common\progress_tracker;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\ob\ob_seismic_refractor;
#namespace namespace_cf5f414fb0f7eb56;

function function_e6e051aa76d5b810() {}

function function_c23224cc410b370f() {
  function_89384091f7a2dbd("REV_OB_DEFEND_MERCS", 0, &function_cc375e239d0dfb19);
  function_89384091f7a2dbd("REV_OB_DEFEND_MERCS", 1, &function_cfee6b0edf5b201);
  function_89384091f7a2dbd("REV_OB_DEFEND_MERCS", 2, &function_2c40f641749f51b1);
  function_89384091f7a2dbd("REV_OB_DEFEND_MERCS", 3, &function_5ffd3278443da8fe);
  function_89384091f7a2dbd("REV_OB_DEFEND_MERCS", 5, &function_f2aff52722b5a4ad);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_b0003a3df00a8817, "REV_OB_DEFEND_MERCS");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_e301c891f62ac307, "REV_OB_DEFEND_MERCS");
  function_8b5b2a3392fc7e2a("PlayerAbandon", &function_540f9b357f3b5419, "REV_OB_DEFEND_MERCS");
  function_8b5b2a3392fc7e2a("RewardsSpawned", &function_5a7e18187183dc57, "REV_OB_DEFEND_MERCS");
}

function function_cc375e239d0dfb19() {
  level endon("game_ended");
  self endon("activity_ended");
  var_45c17c8bd7095cc4 = function_b9c4aa88ad97ee68(self);
  self.variant_definition = var_45c17c8bd7095cc4;
  self.var_69ea82ef856f5ed1 = getStruct(self.varianttag, "targetname");
  assertex(isDefined(self.var_69ea82ef856f5ed1), "<dev string:x1c>" + self.varianttag);
  self.var_30f9c928ab66270d = getStruct(self.varianttag + "_RADIANT", "targetname");
  assertex(isDefined(self.var_30f9c928ab66270d), "<dev string:x5f>" + self.varianttag + "<dev string:xaa>");
  self.awareness_zones = self.var_69ea82ef856f5ed1 function_954eb52ab4cdeb46("awareness_zone", "targetname");
  assertex(isDefined(self.awareness_zones) && self.awareness_zones.size > 0, "<dev string:xb6>" + self.varianttag);
  self.reward_struct = self.var_69ea82ef856f5ed1 function_954eb52ab4cdeb46("reward_struct", "targetname");
  assertex(isDefined(self.reward_struct) && self.reward_struct.size > 0, "<dev string:xf1>" + self.varianttag);
  self.attack_struct = self.var_69ea82ef856f5ed1 function_954eb52ab4cdeb46("attack_point", "targetname")[0];

  if(isDefined(self.var_69ea82ef856f5ed1.target)) {
    self.lanes = self.var_69ea82ef856f5ed1 getStructArray(self.var_69ea82ef856f5ed1.target, "targetname");
  }

  if(!isDefined(self.lanes) || self.lanes.size <= 0) {
    self.lanes = self.var_69ea82ef856f5ed1 function_954eb52ab4cdeb46("defend_lane", "targetname");
  }

  self.var_3bd50128c7825e7c = self.variant_definition.waves;
  self.defend_difficulty = function_8dc20f4fdc5aab0b(self.var_69ea82ef856f5ed1.origin);
  self.difficulty_rules = function_fbee8b93874b9a00(self.defend_difficulty);
  self.activity_ended = 0;
  self.var_3c54f8ab21886d24 = [];
  self.var_ffe90ba1f0aa9b88 = [];
  self.var_3b33a18f9be9c6ac = [];
  self.var_745e3aafa7831a6c = [];
  self.var_77b340bd2d6c8c6f = 0;
  self.var_23f384f68f572e4c = 0;
  self.var_f1170835545f292e = 0;
  self.var_26380688bbdb545c = 0;
  self.var_3b67a03af80ff8d2 = undefined;
  self.var_b23b927c590cdcc5 = undefined;
  self.var_209424e196b67f71 = function_c57bf411aafa17f4();
  function_ac747fbc6661554();
  function_b6fc2c96b463c007(self);
}

function function_cfee6b0edf5b201() {
  self.on_mission = zombie_challenges::function_f578373042c34e16(17070, "quest_s0a3t1_s2fa_mdfcontractstart", self.var_6c29f2fdb0054bbe);

  if(!self.on_mission) {
    function_b651248a140c2a43("MERC_DEFEND_CONTRACT_START");
  }

  foreach(player in self.var_6c29f2fdb0054bbe) {
    player callback::callback("on_merc_defend_started");
  }

  if(self.var_a0401ba7a9bb75be.size > 0) {
    function_63295b54f5603cf5();
  }

  namespace_262d6474998a2356::function_716949a1eeeb1f47();
  waitframe();
  namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_DEFEND_MERCS_START_UPLOAD");
  self.activity_id = function_36a95c9de2ace25a("mercdefend_marker", 0, 1);
  var_421fa4c1a4461651 = anglestoright(self.var_209424e196b67f71.angles) * 5;
  var_e9c2c0242ec1196 = anglesToForward(self.var_209424e196b67f71.angles) * 20;
  var_af41cd8ea2059636 = var_421fa4c1a4461651 - var_e9c2c0242ec1196 + (0, 0, 20);
  scripts\mp\objidpoolmanager::update_objective_position(self.activity_id, self.var_209424e196b67f71.origin + var_af41cd8ea2059636);
  self.var_209424e196b67f71 notify("activate_interact", self.var_6c29f2fdb0054bbe);
  self.var_209424e196b67f71 waittill("begin_transmission");
  function_b651248a140c2a43("MERC_DEFEND_COMPUTER_START");
  thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();
  self.var_77b340bd2d6c8c6f = 1;
  self.var_209424e196b67f71.attackeraccuracy = 1;
  self.var_607c675e70f4dded = [];
  self.var_607c675e70f4dded[0] = self.var_209424e196b67f71.origin;
  wait 7;
  function_901c3fbfd9586100();
  thread function_77af9ecbca50ad22();
  thread function_89d41a2997651c12();
}

function function_2c40f641749f51b1(success) {
  if(isDefined(self.var_209424e196b67f71)) {
    self.var_209424e196b67f71 stoploopsound();
  }

  function_a705c3b1237835dc("effects", "idle");

  foreach(refractor in self.var_bf2ad74c36bb40ac) {
    if(isDefined(refractor.request_id)) {
      function_2169641d6a403864(refractor.request_id);
    }
  }

  foreach(lane in self.lanes) {
    if(isDefined(lane.request_id)) {
      function_18790a3cb3f88db7(lane.request_id);
    }
  }
}

function function_5ffd3278443da8fe() {
  namespace_64135de19550f047::function_486b0f579d5b6dae(self.active_cover);
  function_e23f7699eb3f384e();
  self.var_209424e196b67f71 cleanup_computer();
}

function function_f2aff52722b5a4ad() {
  return self.reward_struct;
}

function function_fbee8b93874b9a00(difficulty) {
  switch (difficulty) {
    case #"hash_af83e47edfa8900a":
      difficulty_settings = self.variant_definition.lvl2difficulty;
      break;
    case #"hash_5343b465e56ec9a4":
      difficulty_settings = self.variant_definition.lvl3difficulty;
      break;
    case #"hash_651f76c0ad6741ec":
      difficulty_settings = self.variant_definition.var_b2e1a15979286d2a;
      break;
    case #"hash_7bb2cd766703d463":
    default:
      difficulty_settings = self.variant_definition.lvl1difficulty;
      break;
  }

  difficulty_rules = spawnStruct();
  difficulty_rules.wavetimeouttime = difficulty_settings.wavetimeout;
  difficulty_rules.var_6807f29efce456e9 = difficulty_settings.var_6807f29efce456e9;
  difficulty_rules.var_6acad01e3c3dce74 = difficulty_settings.var_75042da312d352cc;
  difficulty_rules.var_5f17953229d4c42e = difficulty_settings.var_debedbd55e65912;
  difficulty_rules.grenadechance = difficulty_settings.grenadechance;
  difficulty_rules.var_8d2aef00a333b493 = difficulty_settings.airstrikesettings.var_a4b8cd7d2abfa391;
  difficulty_rules.airstrike_chance = difficulty_settings.airstrikesettings.airstrikechance;
  difficulty_rules.var_cc142ed1d30b4f54 = difficulty_settings.airstrikesettings.var_28f0d2ad91ee22dc;

  if(getdvarint(@ "hash_a6b70eeff43b8a2c", -1) != -1) {
    difficulty_rules.wavetimeouttime = 30;
    difficulty_rules.var_6807f29efce456e9 = 2;
    difficulty_rules.var_6acad01e3c3dce74 = 15;
    difficulty_rules.var_5f17953229d4c42e = 20;
    difficulty_rules.grenadechance = 20;
    difficulty_rules.var_8d2aef00a333b493 = 1;
    difficulty_rules.airstrike_chance = 100;
    difficulty_rules.var_cc142ed1d30b4f54 = 2;
  }

  return difficulty_rules;
}

function function_8dc20f4fdc5aab0b(location) {
  defend_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(location);

  if(defend_difficulty == "difficulty_undefined") {
    defend_difficulty = getDvar(@ "hash_792c5a053f5dca90", "difficulty_easy");
  }

  return defend_difficulty;
}

function function_1611eaf5485896e3() {}

function private function_ac747fbc6661554() {
  self.var_a0401ba7a9bb75be = self.var_69ea82ef856f5ed1 function_954eb52ab4cdeb46("refractor_spawn", "targetname");
  assertex(self.var_a0401ba7a9bb75be.size == 3 || self.var_a0401ba7a9bb75be.size == 0, "<dev string:x12a>" + 3 + "<dev string:x150>" + self.var_a0401ba7a9bb75be.size);
  self.var_bf2ad74c36bb40ac = [];
  self.var_f4e1a46d38b95262 = 0;

  foreach(refractor_spawn in self.var_a0401ba7a9bb75be) {
    refractor = ob_seismic_refractor::spawn_refractor(refractor_spawn);
    refractor ob_seismic_refractor::function_d290ab656c9cd6e2(&function_7192fa51a97ee5e9);
    refractor.activity_instance = self;
    self.var_bf2ad74c36bb40ac = array_add(self.var_bf2ad74c36bb40ac, refractor);

    foreach(player in level.players) {
      refractor disablescriptableplayeruse(player);
    }

    if(isDefined(refractor_spawn.target)) {
      encounter_data = getStruct(refractor_spawn.target, "targetname");
      refractor.encounter_data = encounter_data;
    }
  }
}

function function_7192fa51a97ee5e9(player) {
  if(istrue(self.encounter_spawned)) {
    return;
  }

  if(isDefined(self.encounter_data)) {
    encounter_origin = self.encounter_data.origin;
    encounter_radius = self.encounter_data.radius;
  } else {
    encounter_origin = self.origin;
    encounter_radius = 800;
  }

  self.activity_instance function_765b706dc170e214(self.activity_id);
  self.activity_instance function_61f89c32c1328df9();
  request_id = self.activity_instance function_f8ccadcd850da124("ai_encounter:jup_ob_activity_seismic_enc", encounter_origin, encounter_radius, 1, 0, 1, 2);
  function_d37068aac7785c04(request_id, self.activity_instance.defend_difficulty, 1);
  self.request_id = request_id;
  self.encounter_spawned = 1;
}

function private function_61f89c32c1328df9() {
  self.var_f4e1a46d38b95262++;
  namespace_262d6474998a2356::function_c661dba3e304266b(self.var_f4e1a46d38b95262);

  if(self.var_f4e1a46d38b95262 >= self.var_a0401ba7a9bb75be.size) {
    self notify("refractors_finished");
  }
}

function private function_63295b54f5603cf5() {
  if(getdvarint(@ "hash_33108768a28745b3", 0)) {
    return;
  }

  function_a705c3b1237835dc("model", "usable");

  foreach(refractor in self.var_bf2ad74c36bb40ac) {
    refractor.activity_id = function_36a95c9de2ace25a("mercdefend_marker", 0, 1);
    scripts\mp\objidpoolmanager::update_objective_position(refractor.activity_id, refractor.origin);
  }

  thread function_4e30037ac34a824d();
  namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_DEFEND_MERCS_REFRACTORS");
  namespace_262d6474998a2356::function_c661dba3e304266b(0);
  self waittill("refractors_finished");
  function_8f2669f8d17d21f3();
}

function private function_a705c3b1237835dc(part, state) {
  foreach(refractor in self.var_bf2ad74c36bb40ac) {
    refractor setscriptablepartstate(part, state, 0);
  }
}

function private function_e23f7699eb3f384e() {
  foreach(refractor in self.var_bf2ad74c36bb40ac) {
    refractor ob_seismic_refractor::function_e23f7699eb3f384e();
  }
}

function function_e7941594a8070d56() {}

function function_901c3fbfd9586100() {
  self.vehicle_lanes = [];

  foreach(lane in self.lanes) {
    var_70428fb88bfb1427 = spawnStruct();
    var_70428fb88bfb1427.lane = lane;
    var_70428fb88bfb1427.activity_instance = self;
    lane.should_spawn = 0;
    lane.var_b3ae7899f41036d = 0;
    lane.var_a226ff8d4301f45c = 0;
    lane.var_3c54f8ab21886d24 = [];
    lane.request_id = function_3ee36bc763779ba1(lane.target, 1, 0, 2, 2);
    function_c67c7b9e7cbf3821(lane.request_id, &function_c3043a804637f392, var_70428fb88bfb1427);
    function_c6942df117004b8(lane.request_id, &function_bbebde02927a064f, var_70428fb88bfb1427);
    function_84b829dec3e573eb(lane.request_id, &function_a1248b32171987d1, var_70428fb88bfb1427);
    function_ce9c21523336cdbc(lane.request_id, &function_a26fdba13b6a95a3, var_70428fb88bfb1427);
    function_d37068aac7785c04(lane.request_id, self.defend_difficulty, 1);

    if(function_7b67661ff4de0ac5(lane.request_id)) {
      self.vehicle_lanes = array_add(self.vehicle_lanes, lane);
    }
  }
}

function function_a35fb21c35e05c15(wave_index) {
  self endon("defend_objective_destroyed");
  self endon("activity_ended");
  assertex(wave_index < self.var_3bd50128c7825e7c.size, "<dev string:x15c>");
  var_ccdf55ac1e3b5258 = int(self.var_3bd50128c7825e7c[wave_index].var_c5980c293bd2226e.size);
  assertex(self.lanes.size >= var_ccdf55ac1e3b5258, "<dev string:x196>" + "<dev string:x1d6>" + self.lanes.size + "<dev string:x1ec>" + var_ccdf55ac1e3b5258);

  if(wave_index > 0) {
    foreach(bucket in self.var_3bd50128c7825e7c[wave_index - 1].var_c5980c293bd2226e) {
      function_e08cf487aa3fa70f(bucket.var_3c20b16cbf89b1a9);
    }
  }

  foreach(lane in self.lanes) {
    lane.var_35996696a8599df2 = 0;
  }

  self.var_ffe90ba1f0aa9b88[wave_index] = [];
  self.var_ffe90ba1f0aa9b88[wave_index]["shields"] = [];
  var_72dd6481256b2c25 = undefined;

  for(lane_index = 0; lane_index < var_ccdf55ac1e3b5258; lane_index++) {
    if(lane_index == 0) {
      var_72dd6481256b2c25 = randomintrange(0, self.lanes.size);

      if(isDefined(self.var_b23b927c590cdcc5) && var_72dd6481256b2c25 == self.var_b23b927c590cdcc5) {
        var_72dd6481256b2c25 = (var_72dd6481256b2c25 + 1) % self.lanes.size;
      }
    } else {
      var_72dd6481256b2c25++;
      var_72dd6481256b2c25 %= self.lanes.size;
    }

    spawn_type = self.var_3bd50128c7825e7c[wave_index].var_c5980c293bd2226e[lane_index].spawntype;

    if(spawn_type == "GroundVehicle") {
      if(self.lanes[var_72dd6481256b2c25].var_a226ff8d4301f45c || !function_7b67661ff4de0ac5(self.lanes[var_72dd6481256b2c25].request_id)) {
        for(idx = 0; idx < self.lanes.size; idx++) {
          var_d389d47f0d9d39d8 = (var_72dd6481256b2c25 + idx) % self.lanes.size;
          next_lane = self.lanes[var_d389d47f0d9d39d8];

          if(!next_lane.var_a226ff8d4301f45c && function_7b67661ff4de0ac5(next_lane.request_id)) {
            var_72dd6481256b2c25 = var_d389d47f0d9d39d8;
            break;
          }
        }
      }

      self.lanes[var_72dd6481256b2c25].var_a226ff8d4301f45c = 1;
    }

    if(self.lanes[var_72dd6481256b2c25].var_35996696a8599df2) {
      for(idx = 0; idx < self.lanes.size; idx++) {
        var_d389d47f0d9d39d8 = (var_72dd6481256b2c25 + idx) % self.lanes.size;
        next_lane = self.lanes[var_d389d47f0d9d39d8];

        if(!next_lane.var_35996696a8599df2) {
          var_72dd6481256b2c25 = var_d389d47f0d9d39d8;
          break;
        }
      }
    }

    self.lanes[var_72dd6481256b2c25].var_35996696a8599df2 = 1;
    self.var_3b67a03af80ff8d2 = self.lanes[var_72dd6481256b2c25];
    self.var_b23b927c590cdcc5 = var_72dd6481256b2c25;
    function_d37068aac7785c04(self.var_3b67a03af80ff8d2.request_id, self.var_3bd50128c7825e7c[wave_index].var_c5980c293bd2226e[lane_index].var_3c20b16cbf89b1a9, 1);
    self.lanes[var_72dd6481256b2c25].var_3c20b16cbf89b1a9 = self.var_3bd50128c7825e7c[wave_index].var_c5980c293bd2226e[lane_index].var_3c20b16cbf89b1a9;
    self.lanes[var_72dd6481256b2c25].should_spawn = 1;
    str_direction = self.var_3b67a03af80ff8d2.script_noteworthy;

    iprintlnbold("<dev string:x20b>" + str_direction);

    if(wave_index > 1 && lane_index == 0 && !istrue(self.var_f1170835545f292e)) {
      if(cointoss()) {
        thread function_94ddaf6967a7d603();
      } else {
        thread function_249b26da16511ad8(str_direction);
      }
    }

    if(spawn_type == "OnFoot") {
      wait randomfloatrange(4, 7);
      continue;
    }

    wait randomfloatrange(1.5, 3);
  }
}

function function_e08cf487aa3fa70f(var_1feda409064e0c83) {
  foreach(lane in self.lanes) {
    function_d37068aac7785c04(lane.request_id, var_1feda409064e0c83, 0);
  }
}

function function_c3043a804637f392(request_id, userdata) {
  if(userdata.lane.should_spawn) {
    return true;
  }

  return false;
}

function function_bbebde02927a064f(request_id, userdata) {
  if(userdata.lane.var_b3ae7899f41036d) {
    return true;
  }

  return false;
}

function function_a1248b32171987d1(request_id, userdata) {
  userdata.lane.should_spawn = 0;
  userdata.activity_instance function_55caa7ecdad1659c(request_id);
}

function function_8d58edd5f2c25faf() {}

function function_89d41a2997651c12() {
  level endon("game_ended");
  self endon("activity_ended");
  airstrike_count = 0;
  thread function_acf26f4ea064ff9b();

  while(true) {
    iprintlnbold("<dev string:x228>" + self.var_26380688bbdb545c + 1 + "<dev string:x231>");

    self notify("defend_wave_begin");
    var_a3d777249b5955fb = self.var_26380688bbdb545c;
    self.var_ffe90ba1f0aa9b88[var_a3d777249b5955fb] = [];

    if(var_a3d777249b5955fb >= self.var_3bd50128c7825e7c.size) {
      var_a3d777249b5955fb = int(self.var_3bd50128c7825e7c.size * 0.5);
    }

    if(self.var_26380688bbdb545c != 0 && airstrike_count < self.difficulty_rules.var_cc142ed1d30b4f54 && function_786e0c296b2706af(self.defend_difficulty, self.difficulty_rules.airstrike_chance)) {
      airstrike_count++;
    }

    function_a35fb21c35e05c15(var_a3d777249b5955fb);
    function_afa866a320ed5174(self.var_ffe90ba1f0aa9b88[self.var_26380688bbdb545c], self.difficulty_rules.wavetimeouttime, self.var_26380688bbdb545c);
    wait randomfloatrange(2, 3);
    self.var_26380688bbdb545c++;
  }
}

function function_acf26f4ea064ff9b() {
  self endon("activity_ended");

  while(true) {
    if(getDvar(@ "hash_537c9ca4d24f120a", "0") == "1") {
      setDvar(@ "hash_537c9ca4d24f120a", "0");

      foreach(ai in self.var_3c54f8ab21886d24) {
        ai kill();
      }
    }

    waitframe();
  }
}

function function_a26fdba13b6a95a3(requestid, userdata, agent, data) {
  agent endon("death");
  userdata.lane.should_spawn = 0;
  activityinstance = userdata.activity_instance;
  activityinstance endon("activity_ended");

  foreach(zone in activityinstance.awareness_zones) {
    agent function_65cdab0fc78aba8f(zone.origin, float(zone.script_noteworthy));
  }

  grenadechance = activityinstance.difficulty_rules.grenadechance + activityinstance.var_26380688bbdb545c * 5;

  if(!istrue(scripts\engine\utility::percent_chance(grenadechance))) {
    agent.grenadeammo = 0;
  }

  activityinstance.var_3c54f8ab21886d24 = array_add(activityinstance.var_3c54f8ab21886d24, agent);
  activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c] = array_add(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c], agent);
  activityinstance.var_3b67a03af80ff8d2.var_3c54f8ab21886d24 = array_add(activityinstance.var_3b67a03af80ff8d2.var_3c54f8ab21886d24, agent);
  var_57a2235116532539 = ["jup_ob_enemy_specialist_shielded"];

  foreach(rusher_type in var_57a2235116532539) {
    if(string_starts_with(agent.agent_type, rusher_type)) {
      activityinstance.var_745e3aafa7831a6c[activityinstance.var_745e3aafa7831a6c.size] = agent;
      break;
    }
  }

  function_d7ea0d1150637b75(agent, userdata, activityinstance);
  agent ent_flag_init("activity_merc_defend_spawned");
}

function function_d7ea0d1150637b75(agent, userdata, activityinstance) {
  if(string_starts_with(agent.agent_type, "actor_jup_ob_enemy_specialist_sniper")) {
    return;
  }

  if(string_starts_with(agent.agent_type, "actor_jup_ob_enemy_specialist_rocketeer")) {
    agent function_efd59bf2ff8d9fcf(activityinstance);
    agent function_a3e09da1e1f0547b(activityinstance.awareness_zones[0]);
    return;
  }

  if(getdvarint(@ "hash_2761a482142460ae", 0) && agent.agent_type == "actor_jup_ob_enemy_specialist_shielded") {
    agent function_efd59bf2ff8d9fcf(activityinstance);
    agent function_a3e09da1e1f0547b(activityinstance.attack_struct);
    return;
  }

  if(!getdvarint(@ "hash_2761a482142460ae", 0) && userdata.lane.var_3c20b16cbf89b1a9 == "riot_rusher") {
    if(agent.agent_type != "actor_jup_ob_enemy_specialist_shielded") {
      activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["rusher"] = agent;
      agent thread function_eacc2a5a8308b776(activityinstance);
      agent thread function_7737d88a521fce86(activityinstance);
      agent thread function_eb1138fda5cb7039(activityinstance);
    } else {
      activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"][activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"].size] = agent;
      temp_struct = spawnStruct();
      temp_struct.origin = activityinstance.attack_struct.origin;
      temp_struct.radius = max(20, activityinstance.attack_struct.radius - 20);
      agent function_a3e09da1e1f0547b(temp_struct);
      agent thread function_e3557dcaf265cdb6(activityinstance);
    }

    return;
  }

  agent function_a3e09da1e1f0547b(userdata.lane);
}

function function_eacc2a5a8308b776(activityinstance) {
  self endon("death");
  self endon("rusher_arrived");

  while(!isDefined(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"])) {
    waitframe();
  }

  var_be4761e18f095f3b = random(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"]);

  while(true) {
    if(is_dead_or_dying(var_be4761e18f095f3b)) {
      activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"] = array_removedead_or_dying(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"]);

      if(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"].size == 0) {
        function_a3e09da1e1f0547b(activityinstance.attack_struct);
        return;
      }

      var_be4761e18f095f3b = random(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"]);
    }

    self setgoalpos(var_be4761e18f095f3b.origin, 20);

    if(getdvarint(@ "hash_7f6a9112ac36f3b8", 0)) {
      thread function_9b84792ea544d0a9(self, var_be4761e18f095f3b.origin, 20);
    }

    waitframe();
  }
}

function function_e3557dcaf265cdb6(activityinstance) {
  self endon("death");
  rusher = undefined;

  while(!isDefined(rusher)) {
    rusher = activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["rusher"];
    wait 0.1;
  }

  rusher endon("death");
  result = function_28551e899093b138("rusher_arrived", "rusher_dead");

  if(result["message"] == "rusher_arrived") {
    thread function_a535ad32f9c45eba(result[0]);
  }
}

function function_a535ad32f9c45eba(rusher) {
  self endon("rusher_dead");

  while(true) {
    function_3f4980393aa03e85(rusher.origin, 100);
    wait 1;
  }
}

function function_7737d88a521fce86(activityinstance) {
  self endon("death");

  while(!is_dead_or_dying(self)) {
    if(array_contains(getaiarrayinradius(activityinstance.attack_struct.origin, activityinstance.attack_struct.radius), self)) {
      iprintlnbold("<dev string:x241>");

      activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"] = array_removedead_or_dying(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"]);

      foreach(ai in activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"]) {
        ai notify("rusher_arrived", self);
      }

      self notify("rusher_arrived");
      function_efd59bf2ff8d9fcf(activityinstance);
      function_a3e09da1e1f0547b(activityinstance.attack_struct);
      return;
    }

    wait 0.1;
  }
}

function function_eb1138fda5cb7039(activityinstance) {
  self waittill("death");

  iprintlnbold("<dev string:x253>");

  if(!isDefined(activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"])) {
    return;
  }

  foreach(ai in activityinstance.var_ffe90ba1f0aa9b88[activityinstance.var_26380688bbdb545c]["shields"]) {
    ai notify("rusher_dead");
  }
}

function function_efd59bf2ff8d9fcf(activityinstance) {
  ai_target = activityinstance.var_209424e196b67f71;

  if(isDefined(ai_target) && issentient(ai_target)) {
    self agentsetfavoriteenemy(ai_target);
    self setagentattacker(ai_target);
    self getenemyinfo(ai_target);
    self forcethreatupdate();
  }
}

function function_a3e09da1e1f0547b(goal_struct) {
  v_goal = goal_struct.origin;
  n_goal_radius = goal_struct.radius;
  self setgoalpos(v_goal, n_goal_radius);

  if(getdvarint(@ "hash_7f6a9112ac36f3b8", 0) && isDefined(v_goal) && isDefined(n_goal_radius)) {
    thread function_9b84792ea544d0a9(self, v_goal, n_goal_radius);
  }
}

function function_3f4980393aa03e85(v_goal, n_goal_radius) {
  self setgoalpos(v_goal, n_goal_radius);

  if(getdvarint(@ "hash_7f6a9112ac36f3b8", 0) && isDefined(v_goal) && isDefined(n_goal_radius)) {
    thread function_9b84792ea544d0a9(self, v_goal, n_goal_radius);
  }
}

function function_afa866a320ed5174(var_ffe90ba1f0aa9b88, var_6d5fc99821332eef, var_26380688bbdb545c) {
  level endon("game_ended");
  self endon("activity_ended");
  self endon("defend_wave_end");

  while(true) {
    var_cee1500f2de3dccf = 0;

    foreach(lane in self.lanes) {
      if(lane.should_spawn) {
        var_cee1500f2de3dccf = 1;
      }
    }

    if(!var_cee1500f2de3dccf) {
      break;
    }

    waitframe();
  }

  wait 1;
  var_ffe90ba1f0aa9b88 = array_removedead_or_dying(self.var_3c54f8ab21886d24);

  if(var_ffe90ba1f0aa9b88.size == 0) {
    iprintlnbold("<dev string:x228>" + var_26380688bbdb545c + 1 + "<dev string:x262>");

    self notify("defend_wave_end", var_26380688bbdb545c);
    return;
  }

  thread function_c6683cea57fb5e00(var_ffe90ba1f0aa9b88, var_26380688bbdb545c);
  msg = waittill_any_timeout_1(var_6d5fc99821332eef, "wave_clear");

  if(msg == "wave_clear") {
    iprintlnbold("<dev string:x228>" + var_26380688bbdb545c + 1 + "<dev string:x262>");
  }

  self notify("defend_wave_end", var_26380688bbdb545c);
}

function function_c6683cea57fb5e00(var_ffe90ba1f0aa9b88, var_26380688bbdb545c) {
  level endon("game_ended");
  self endon("activity_ended");
  self endon("defend_wave_end");

  while(var_ffe90ba1f0aa9b88.size > 4) {
    var_ffe90ba1f0aa9b88 = array_removedead_or_dying(var_ffe90ba1f0aa9b88);

    iprintln("<dev string:x228>" + var_26380688bbdb545c + 1 + "<dev string:x271>" + var_ffe90ba1f0aa9b88.size);

    wait 0.25;
  }

  self notify("wave_clear");
}

function function_381e399fb9960731(var_ff58e3596f9049d0, str_direction) {
  level endon("game_ended");
  self endon("activity_ended");
  self endon("defend_objective_destroyed");
  n_wait = randomfloatrange(self.difficulty_rules.var_6acad01e3c3dce74, self.difficulty_rules.var_5f17953229d4c42e) / 1;
  wait n_wait;
  var_3c54f8ab21886d24 = var_ff58e3596f9049d0.var_3c54f8ab21886d24;

  while(true) {
    var_3c54f8ab21886d24 = array_removedead_or_dying(var_3c54f8ab21886d24);

    if(var_3c54f8ab21886d24.size == 0) {
      break;
    }

    if(self.var_3b33a18f9be9c6ac.size >= self.difficulty_rules.var_6807f29efce456e9) {
      wait 1;
      continue;
    }

    self.var_745e3aafa7831a6c = array_removedead_or_dying(self.var_745e3aafa7831a6c);
    self.var_745e3aafa7831a6c = function_16baac7bed7a85d0(self.var_745e3aafa7831a6c);

    if(self.var_745e3aafa7831a6c.size > 0) {
      ai_rusher = random(self.var_745e3aafa7831a6c);
    } else {
      ai_rusher = random(var_3c54f8ab21886d24);
    }

    self.var_745e3aafa7831a6c = array_remove(self.var_745e3aafa7831a6c, ai_rusher);
    self.var_3b33a18f9be9c6ac = array_add(self.var_3b33a18f9be9c6ac, ai_rusher);
    v_goal = self.var_209424e196b67f71.origin;
    n_goal_radius = 300;
    ai_target = self.var_209424e196b67f71;

    if(isDefined(ai_target)) {
      ai_rusher agentsetfavoriteenemy(ai_target);
      ai_rusher setagentattacker(ai_target);
      ai_rusher getenemyinfo(ai_target);
      ai_rusher forcethreatupdate();
      attack_point = self.var_69ea82ef856f5ed1 function_954eb52ab4cdeb46("attack_point", "targetname")[0];
      v_goal = attack_point.origin;
      n_goal_radius = attack_point.radius;
    }

    ai_rusher setgoalpos(v_goal, n_goal_radius);
    self notify("defend_enemy_rush", str_direction);
    ai_rusher thread function_85948a98ad25d79f(self, ai_target, v_goal, n_goal_radius);
    ai_rusher thread function_4d86c58c4b38a974(self, v_goal);

    iprintln("<dev string:x28c>" + str_direction);

    if(getdvarint(@ "hash_7f6a9112ac36f3b8", 0)) {
      ai_rusher thread function_9b84792ea544d0a9(self, v_goal, n_goal_radius);
    }

    n_wait = randomfloatrange(self.difficulty_rules.var_6acad01e3c3dce74, self.difficulty_rules.var_5f17953229d4c42e) / 1;
    msg = ai_rusher waittill_notify_or_timeout_return("death", n_wait);

    if(msg == "death") {
      n_wait = randomfloatrange(self.difficulty_rules.var_6acad01e3c3dce74 * 0.25, self.difficulty_rules.var_5f17953229d4c42e * 0.25) / 1;
      wait n_wait;
    }
  }
}

function function_16baac7bed7a85d0(array) {
  new_array = [];

  foreach(ai in array) {
    if(ai.team == "team_hundred_ninety") {
      new_array[new_array.size] = ai;
    }
  }

  return new_array;
}

function function_9b84792ea544d0a9(activityinstance, v_goal, n_goal_radius) {
  self endon("death");
  self notify("debugsingleton");
  self endon("debugsingleton");
  level endon("game_ended");
  activityinstance endon("activity_ended");

  while(true) {
    thread draw_ent_axis((1, 0, 0), 10, 30);
    thread draw_circle(v_goal, n_goal_radius, (1, 0, 0), 1, 0, 10);
    thread draw_line_for_time(self.origin, v_goal, 1, 0, 0, 0.1);

    wait 0.1;
  }
}

function function_c077b72ad02950fa(activityinstance, ai_target) {
  self endon("death");
  level endon("game_ended");
  activityinstance endon("activity_ended");
  v_search_pos = ai_target.origin + (0, 0, 32) + anglesToForward(ai_target.angles) * 150;
  v_goal = findclosestlospointwithinradius(v_search_pos, 300, ai_target.origin, v_search_pos);

  if(!isDefined(v_goal)) {
    v_goal = v_search_pos;
  }

  var_3663f0e8ae5c51e1 = self getclosestreachablepointonnavmesh(v_goal);
  return var_3663f0e8ae5c51e1;
}

function function_85948a98ad25d79f(activityinstance, ai_target, v_goal, n_goal_radius) {
  self endon("death");
  level endon("game_ended");
  activityinstance endon("activity_ended");
  self.ignoreme = 1;
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 300;
  self.pathenemylookahead = 128;
  self.nododgemove = 1;
  self.doavoidanceblocking = 0;
  self waittill("goal");
  self.ignoreme = 0;
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;

  if(isDefined(self.fixednodewason)) {
    self.fixednode = self.fixednodewason;
  }

  self.fixednodewason = undefined;

  if(isDefined(self.var_a4700673c6ef6c4)) {
    self.var_b29c3655b12e292d = self.var_a4700673c6ef6c4;
  }

  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;
}

function function_4d86c58c4b38a974(activityinstance, v_goal) {
  level endon("game_ended");
  activityinstance endon("activity_ended");
  activityinstance.var_607c675e70f4dded = array_add(activityinstance.var_607c675e70f4dded, v_goal);
  self waittill("death");
  activityinstance.var_607c675e70f4dded = array_remove(activityinstance.var_607c675e70f4dded, v_goal);
  activityinstance.var_3b33a18f9be9c6ac = array_removedead_or_dying(activityinstance.var_3b33a18f9be9c6ac);
}

function function_d62bad6a73ba1f63(activity_instance, success) {
  activity_instance.var_209424e196b67f71 namespace_7ee9a03c8b80c102::function_ebc62d30ce909ad2();
  activity_instance.var_3c54f8ab21886d24 = array_removedead_or_dying(activity_instance.var_3c54f8ab21886d24);

  foreach(ai in activity_instance.var_3c54f8ab21886d24) {
    ai_target = random(activity_instance.var_6c29f2fdb0054bbe);

    if(isalive(ai_target)) {
      ai agentsetfavoriteenemy(ai_target);
      ai setagentattacker(ai_target);
      ai getenemyinfo(ai_target);
      ai forcethreatupdate();
    }
  }
}

function function_58d14c31907921bf(event) {
  return false;
}

function function_e530d11a8cbf4e45() {}

function function_b0003a3df00a8817(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.var_b494ea8c4b70490;

  foreach(player in player_list) {
    if(isPlayer(player)) {
      foreach(refractor in self.var_bf2ad74c36bb40ac) {
        refractor enablescriptableplayeruse(player);
      }

      if(isDefined(self.var_209424e196b67f71.var_165945de1c6a2cad)) {
        self.var_209424e196b67f71.var_165945de1c6a2cad enablescriptableplayeruse(player);
      }

      if(!self.var_77b340bd2d6c8c6f) {
        self.var_77b340bd2d6c8c6f = 1;
      }

      if(var_a83ac3549acc2da2 == "PlayerJoinedProximity") {
        self notify("player_near_defend_location", player);
        continue;
      }

      if(var_a83ac3549acc2da2 == "PlayerJoinedDamage") {
        self notify("player_defending_object", player);
      }
    }
  }
}

function function_e301c891f62ac307(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  foreach(player in player_list) {
    if(isPlayer(player)) {
      foreach(refractor in self.var_bf2ad74c36bb40ac) {
        refractor disablescriptableplayeruse(player);
      }

      if(isDefined(self.var_209424e196b67f71.var_165945de1c6a2cad)) {
        self.var_209424e196b67f71.var_165945de1c6a2cad disablescriptableplayeruse(player);
      }
    }
  }
}

function function_540f9b357f3b5419(var_b381b0883bcd4847) {
  wait 0.2;

  foreach(player in var_b381b0883bcd4847.playerlist) {
    function_4a508fcbbea05afd(player);
  }
}

function function_5a7e18187183dc57(var_b381b0883bcd4847) {
  activityinstance = self;
  var_9ff035d5fc0b423c = var_b381b0883bcd4847.var_9ff035d5fc0b423c;
  var_695aa6b24855b76d = var_b381b0883bcd4847.var_695aa6b24855b76d;
  var_4c4113a8e03e8d91 = var_b381b0883bcd4847.rewardcaches;

  if(var_4c4113a8e03e8d91.size == 0) {
    return;
  }

  if(var_9ff035d5fc0b423c == "ActivitySuccess" || var_9ff035d5fc0b423c == "ActivityEnd") {
    rewardrift = var_4c4113a8e03e8d91[0];
    var_db1036d6c298e796 = spawnStruct();
    level thread namespace_e8853d3344e33cf6::function_f4ca5678b389bda1(var_db1036d6c298e796, activityinstance, rewardrift);
  }
}

function private function_4a508fcbbea05afd(player) {
  if(function_5acc35fc66331385(player, 17070)) {
    player ent_flag_clear("quest_s0a3t1_s2fa_mdfcontractstart");
    player ent_flag_clear("quest_s0a3t1_s2fa_mdfrefractor");
    player ent_flag_clear("quest_s0a3t1_s2fa_mdfdamage25");
  }
}

function function_d5e73a798c5645e4() {}

function function_c57bf411aafa17f4() {
  self.computer_health = 3000;
  debug_health = getdvarint(@ "hash_d24bb9994630a823", -1);

  if(debug_health != -1) {
    self.computer_health = debug_health;
  }

  var_ea29272d9062356 = self.var_69ea82ef856f5ed1 function_954eb52ab4cdeb46("computer_spawn", "targetname");
  location_struct = random(var_ea29272d9062356);
  self.var_e0548951332eeb87 = location_struct function_954eb52ab4cdeb46("airstrike_location", "targetname")[0];
  defend_objective = spawn_computer(location_struct, self.computer_health);
  defend_objective disableplayeruseforallplayers();
  shared_cover = [];
  computer_cover = [];

  if(isDefined(self.var_30f9c928ab66270d.target)) {
    shared_cover = self.var_30f9c928ab66270d getStructArray(self.var_30f9c928ab66270d.target, "targetname");
  }

  if(isDefined(location_struct.script_noteworthy)) {
    computer_cover = getStructArray(location_struct.script_noteworthy, "targetname");
  }

  cover_structs = scripts\engine\utility::array_combine(shared_cover, computer_cover);
  self.active_cover = namespace_64135de19550f047::function_cf24aec050c0e5f8(cover_structs);
  return defend_objective;
}

function function_77af9ecbca50ad22() {
  self endon("activity_ended");
  thread function_e02c0c6dce450ac8();
  thread function_e83ba5edd1a6ad08();
  self.n_total_time = self.variant_definition.defendtimelimit / 1;
  self.var_c75bc1d152e0d74e = int(self.n_total_time * 0.5);
  self.var_20187e8e1269d154 = int(self.n_total_time * 0.2);
  thread function_7cdc25ec5bfb67cc();
  thread function_a73c374961da5518();
}

function function_e02c0c6dce450ac8() {
  self endon("activity_ended");
  var_a4d2f01b12651c52 = 0;
  var_aeffe221b9e7bd = 0;
  var_f593feeeb1fbcd55 = self.computer_health * 0.75;
  var_e73fda26baf627ea = self.computer_health * 0.25;

  while(true) {
    msg = self.var_209424e196b67f71 waittill_any_return_2("damage_modify", "death");

    if(msg == "death" && function_38df7cd1dc2f5bc9(self.var_209424e196b67f71) <= 0) {
      self notify("defend_objective_destroyed");
      break;
    } else {
      var_9905f929d844e555 = function_1b71094fb5bf7c52(self.var_209424e196b67f71) * 100;

      if(!istrue(var_a4d2f01b12651c52) && function_38df7cd1dc2f5bc9(self.var_209424e196b67f71) < var_f593feeeb1fbcd55) {
        if(!self.on_mission) {
          function_a0c6692e6f413bf4();
        }

        foreach(player in self.var_6c29f2fdb0054bbe) {
          player callback::callback("on_merc_defend_damage_25");
        }

        var_a4d2f01b12651c52 = 1;
      } else if(!istrue(var_aeffe221b9e7bd) && function_38df7cd1dc2f5bc9(self.var_209424e196b67f71) < var_e73fda26baf627ea) {
        function_a0d35d2e6f4f3615();
        var_aeffe221b9e7bd = 1;
      }

      percentage_health = int(ceil(var_9905f929d844e555));
      namespace_262d6474998a2356::function_c661dba3e304266b(percentage_health);
      namespace_262d6474998a2356::function_f0361294db9d74a7(percentage_health);
    }

    waitframe();
  }

  iprintlnbold("<dev string:x2ac>");

  function_68c67070dd1f1752();
}

function function_e83ba5edd1a6ad08() {
  self endon("activity_ended");

  while(true) {
    playersinrange = 0;

    foreach(player in self.var_6c29f2fdb0054bbe) {
      if(squared(7874.02) > distance2dsquared(player.origin, self.var_209424e196b67f71.origin)) {
        playersinrange = 1;
        break;
      }
    }

    if(!istrue(playersinrange)) {
      function_68c67070dd1f1752();
      return;
    }

    wait 2;
  }
}

function function_68c67070dd1f1752() {
  function_3e92b57d50fe4529();
  waitframe();
  function_7dc2892a940a9cdd(self, 0);
}

function function_7cdc25ec5bfb67cc() {
  self endon("activity_ended");
  namespace_262d6474998a2356::function_716949a1eeeb1f47();
  waitframe();
  namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_DEFEND_MERCS");
  namespace_262d6474998a2356::function_c661dba3e304266b(100);
  namespace_262d6474998a2356::function_474722293c221d5c(self.n_total_time);
  namespace_262d6474998a2356::function_f0361294db9d74a7(100, 20);
  missiontime = gettime() + self.n_total_time * 1000;

  while(gettime() < missiontime) {
    waitframe();
  }

  if(!self.on_mission) {
    thread function_368d332dcf03c8a4();
  }

  foreach(player in self.var_6c29f2fdb0054bbe) {
    player callback::callback("on_merc_defend_success");
  }

  waitframe();
  self.var_209424e196b67f71 notify("objective_success");
  function_7dc2892a940a9cdd(self, 1);
}

function function_a73c374961da5518() {
  self endon("activity_ended");
  alarmtime = gettime() + (self.n_total_time - 15) * 1000;

  while(gettime() < alarmtime) {
    waitframe();
  }

  if(isDefined(self.var_209424e196b67f71.scriptable)) {
    self.var_209424e196b67f71.scriptable setscriptablepartstate("audio_alarm", "on");
  }
}

function function_5bcf28da56698d9f(progress_tracker) {
  if(progress_tracker iscomplete()) {
    self notify("countdown_finished");
    return;
  }

  n_time_remaining = progress_tracker function_cfeb21bf93c30dae();

  if(n_time_remaining < self.var_c75bc1d152e0d74e && !istrue(self.var_23f384f68f572e4c)) {
    self notify("countdown_halfway");
    self.var_23f384f68f572e4c = 1;
    return;
  }

  if(n_time_remaining < self.var_20187e8e1269d154 && !istrue(self.var_f1170835545f292e)) {
    self notify("countdown_almost");
    self.var_f1170835545f292e = 1;
  }
}

function function_7dc2892a940a9cdd(activity_instance, success) {
  if(isDefined(activity_instance.var_209424e196b67f71.scriptable)) {
    activity_instance.var_209424e196b67f71.scriptable setscriptablepartstate("audio_alarm", "off");
  }

  function_d62bad6a73ba1f63(activity_instance, success);
  self.activity_ended = 1;

  if(!success) {
    foreach(player in activity_instance.var_6c29f2fdb0054bbe) {
      function_4a508fcbbea05afd(player);
    }
  }

  endactivity(activity_instance, success);
}

function function_aae779cfe6d93561() {}

function function_45e725898a9c93c6() {}

function function_786e0c296b2706af(defend_difficulty, airstrike_chance) {
  roll = randomint(100);

  if(roll < airstrike_chance) {
    thread function_4ef6f7130d12c13(defend_difficulty);
    wait 4;
    return true;
  }

  return false;
}

function function_4ef6f7130d12c13(defend_difficulty) {
  num_planes = 1;

  switch (defend_difficulty) {
    case #"hash_5343b465e56ec9a4":
      strike_type = "multi_airstrike";
      num_planes = 2;
      break;
    case #"hash_651f76c0ad6741ec":
      if(cointoss()) {
        strike_type = "multi_airstrike";
        num_planes = 3;
      } else {
        strike_type = "fuel_airstrike";
        num_planes = 1;
      }

      break;
    case #"hash_af83e47edfa8900a":
      strike_type = "multi_airstrike";
      num_planes = 2;
      break;
    default:
      strike_type = "multi_airstrike";
      num_planes = 1;
      break;
  }

  if(isDefined(self.var_e0548951332eeb87)) {
    ob_airstrike(self.var_e0548951332eeb87.origin, strike_type, num_planes, 1, self.var_e0548951332eeb87.angles[1]);
  } else {
    ob_airstrike(self.var_209424e196b67f71.origin, strike_type, num_planes, 1, undefined);
  }

  wait 9;
  self notify("defend_strike_done");
}

function function_c8e3617f0328fd7f() {}

function function_b651248a140c2a43(conv_ref, buffer_time, playerlist) {
  if(!isDefined(buffer_time) || !isDefined(self.var_aff42daa8b6ef4b0) || isDefined(self.var_aff42daa8b6ef4b0) && gettime() - self.var_aff42daa8b6ef4b0 >= buffer_time) {
    self.var_aff42daa8b6ef4b0 = gettime();
    namespace_277c27ef297ef569::function_1281c7fff9456e18(conv_ref, playerlist);
  }
}

function function_4e30037ac34a824d() {
  wait 2;

  while(true) {
    foreach(refractor in self.var_a0401ba7a9bb75be) {
      players = scripts\mp\utility\player::getplayersinradius(refractor.origin, 1000);

      if(isDefined(players) && players.size > 0) {
        if(!self.on_mission) {
          function_b651248a140c2a43("MERC_DEFEND_APPROACH_REFRACTOR");
        }

        foreach(player in self.var_6c29f2fdb0054bbe) {
          player callback::callback("on_merc_defend_approach_refractor");
        }

        return;
      }
    }

    wait 2;
  }
}

function function_8f2669f8d17d21f3() {
  function_b651248a140c2a43("MERC_DEFEND_REFRACTOR_COMPLETE", 12000);
}

function function_776b221a8c9ee141() {
  namespace_277c27ef297ef569::function_1281c7fff9456e18("NAME");
}

function function_94ddaf6967a7d603() {
  if(!isDefined(self.var_e589924c48ad8642) || isDefined(self.var_e589924c48ad8642) && gettime() - self.var_e589924c48ad8642 >= 30000) {
    self.var_e589924c48ad8642 = gettime();
  } else {
    return;
  }

  function_b651248a140c2a43("MERC_DEFEND_WAVE_START");
}

function function_249b26da16511ad8(str_direction) {
  if(!isDefined(self.var_e589924c48ad8642) || isDefined(self.var_e589924c48ad8642) && gettime() - self.var_e589924c48ad8642 >= 30000) {
    self.var_e589924c48ad8642 = gettime();
  } else {
    return;
  }

  str_dialog = "MERC_DEFEND_WAVE_";

  switch (str_direction) {
    case #"hash_b9ff0a9f617355e4":
      str_dialog += "NORTH";
      break;
    case #"hash_493bfd7122639b31":
      str_dialog += "NORTHEAST";
      break;
    case #"hash_22ce3b03c1e51a9c":
      str_dialog += "EAST";
      break;
    case #"hash_8856b747c93e7793":
      str_dialog += "SOUTHEAST";
      break;
    case #"hash_fbd39e4f5634905a":
      str_dialog += "SOUTH";
      break;
    case #"hash_abed5ad834825ff1":
      str_dialog += "SOUTHWEST";
      break;
    case #"hash_a1e9b77432f55b0e":
      str_dialog += "WEST";
      break;
    case #"hash_b66b59dcd06dfad3":
      str_dialog += "NORTHWEST";
      break;
    default:
      str_dialog = "MERC_DEFEND_WAVE_START";
      break;
  }

  function_b651248a140c2a43(str_dialog);
}

function function_a0c6692e6f413bf4() {
  function_b651248a140c2a43("MERC_DEFEND_COMPUTER_DMG_25");
}

function function_a0d35d2e6f4f3615() {
  function_b651248a140c2a43("MERC_DEFEND_COMPUTER_DMG_75");
}

function function_3e92b57d50fe4529() {
  function_b651248a140c2a43("MERC_DEFEND_CONTRACT_FAIL");
}

function function_368d332dcf03c8a4() {
  function_b651248a140c2a43("MERC_DEFEND_CONTRACT_SUCCESS");
}
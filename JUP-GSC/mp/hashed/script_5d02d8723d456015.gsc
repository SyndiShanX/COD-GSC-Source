/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5d02d8723d456015.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_24f248b33b79e48d;
#using script_39d11000e476a42a;
#using scripts\mp\objective_marker_bundle_helper;
#using script_3ab210ea917601e7;
#using script_3e31016b9c11a616;
#using script_3e34d236a84cfd96;
#using script_41387eecc35b88bf;
#using scripts\cp_mp\zombie_challenges;
#using script_4e6e58ab5d96c2b0;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_638d701d263ee1ed;
#using script_7956d56c4922bd1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\radiation;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace namespace_39f971ea9ca4fb9e;

function function_d745018e64b6b902() {
  function_89384091f7a2dbd("REV_OB_BIGBOUNTY", 0, &function_866135ff44f9a1b8);
  function_89384091f7a2dbd("REV_OB_BIGBOUNTY", 1, &function_1ddc9629c6534e38);
  function_89384091f7a2dbd("REV_OB_BIGBOUNTY", 2, &function_7b0fea7ae2112c25);
  function_89384091f7a2dbd("REV_OB_BIGBOUNTY", 3, &function_d17f711a3cf0d287);
  function_89384091f7a2dbd("REV_OB_BIGBOUNTY", 4, &function_6f747a641f77773c);
  function_89384091f7a2dbd("REV_OB_BIGBOUNTY", 5, &function_3d2a5e67e320a325);
  function_89384091f7a2dbd("REV_OB_BIGBOUNTY", 7, &function_93cc9badd07b3211);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_e2827300b9992692, "REV_OB_BIGBOUNTY");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_f0f14142a301b2e2, "REV_OB_BIGBOUNTY");
  function_8b5b2a3392fc7e2a("PlayerAbandon", &function_540f9b357f3b5419, "REV_OB_BIGBOUNTY");
}

function function_866135ff44f9a1b8() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");

  if(istrue(level.var_dbca431b3ea02d2e)) {
    self.var_e726c726c6fb7dec = 1;
  }

  activityvariantdefinition = function_b9c4aa88ad97ee68(self);
  self.variant_definition = activityvariantdefinition;
  self.spawnradius = self.variant_definition.spawnradius;
  self.circleradius = self.variant_definition.circleradius;
  self.spawnmaxdist = self.variant_definition.maxdist;
  self.spawnmindist = self.variant_definition.mindist;
  self.var_4158f9fefbe61805 = self.variant_definition.var_4158f9fefbe61805;
  self.keylist = self.variant_definition.keylist;
  self.var_b226288584700d27 = self.variant_definition.markersettings.markericon;
  self.var_d51c5b5df247c905 = self.variant_definition.markersettings.zoffset;
  self.var_f70e74acfb34f2b4 = self.variant_definition.markersettings.mimiczoffset;
  self.var_d24c97a0ba2de66f = self.variant_definition.markersettings.manglerzoffset;
  self.var_664da60d21c76e48 = self.variant_definition.markersettings.disciplezoffset;
  self.var_c55e3742fdc960b7 = self.variant_definition.markersettings.var_3ed4a0ea874a05d4;
  self.circleoffset = self.variant_definition.markersettings.circleoffset;
  self.var_4a30e8b5f565a933 = [];
  self.var_4a30e8b5f565a933["difficulty_easy"] = [];
  self.var_4a30e8b5f565a933["difficulty_normal"] = [];
  self.var_4a30e8b5f565a933["difficulty_hard"] = [];
  self.var_4a30e8b5f565a933["difficulty_darkaether"] = [];

  foreach(struct in self.variant_definition.var_36580a8603f37d28) {
    self.var_4a30e8b5f565a933["difficulty_easy"] = function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_easy"], struct.var_42dc5ba76891bff9);
  }

  foreach(struct in self.variant_definition.var_d5f514e3f40b591f) {
    self.var_4a30e8b5f565a933["difficulty_normal"] = function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_normal"], struct.var_42dc5ba76891bff9);
  }

  foreach(struct in self.variant_definition.var_202004aa59cd95a5) {
    self.var_4a30e8b5f565a933["difficulty_hard"] = function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_hard"], struct.var_42dc5ba76891bff9);
  }

  foreach(struct in self.variant_definition.var_8db5d77e931fbc88) {
    self.var_4a30e8b5f565a933["difficulty_darkaether"] = function_6d6af8144a5131f1(self.var_4a30e8b5f565a933["difficulty_darkaether"], struct.var_42dc5ba76891bff9);
  }

  var_f923d1b5e7f75c3b = function_4481ee309bf2c75c(activity_instance);

  if(isDefined(var_f923d1b5e7f75c3b) && isstring(var_f923d1b5e7f75c3b.str_ai)) {
    self.var_db0e660397a76bd8 = var_f923d1b5e7f75c3b.str_ai;
    self.var_24a16c52437dde0f = 1;
    callback::callback("big_bounty_quest_contract_starting", {
      #player: var_f923d1b5e7f75c3b.var_b20fac6bac1d6fde, #instance: activity_instance
    });
  }

  self.region_string = function_415547ee4122c2ca();

  if(!isDefined(self.var_db0e660397a76bd8)) {
    switch (self.region_string) {
      case #"hash_7bb2cd766703d463":
        self.var_3d51c5307549c964 = self.variant_definition.var_4d335db04f92489e;
        break;
      case #"hash_af83e47edfa8900a":
        self.var_3d51c5307549c964 = self.variant_definition.var_3db5481149848407;
        break;
      case #"hash_5343b465e56ec9a4":
        self.var_3d51c5307549c964 = self.variant_definition.var_eb166bed99d3ea61;
        break;
      case #"hash_651f76c0ad6741ec":
        self.var_3d51c5307549c964 = self.variant_definition.var_82482014ca52c65e;
        break;
      default:
        self.var_3d51c5307549c964 = self.variant_definition.var_4d335db04f92489e;
        break;
    }

    weights = [];

    foreach(ai in self.var_3d51c5307549c964) {
      weights = array_add(weights, ai.weight);
    }

    random_key = random_weighted(self.var_3d51c5307549c964, weights);
    self.var_db0e660397a76bd8 = random_key.aisubclass;
  }

  switch (self.var_db0e660397a76bd8) {
    case #"hash_c1fa8721b046b258":
      self.ai_type = "mimic";
      self.var_20e5602e719b2988 = self.var_f70e74acfb34f2b4;
      break;
    case #"hash_60cbd0daf82a39c9":
      self.ai_type = "mangler";
      self.var_20e5602e719b2988 = self.var_d24c97a0ba2de66f;
      break;
    case #"hash_c1b612499d7bd4a":
      self.ai_type = "disciple";
      self.var_20e5602e719b2988 = self.var_664da60d21c76e48;
      break;
    case #"hash_a18ec1c48b974dc7":
      self.ai_type = "megabomb";
      self.var_20e5602e719b2988 = self.var_c55e3742fdc960b7;
      break;
  }

  if(getdvarint(@ "hash_a727d89442d7861", 0)) {
    self.ai_type = "mimic";
    self.var_db0e660397a76bd8 = "zombie_mimic_hvt";
    self.var_20e5602e719b2988 = self.var_f70e74acfb34f2b4;
  } else if(getdvarint(@ "hash_33cc263918e8c228", 0)) {
    self.ai_type = "mangler";
    self.var_db0e660397a76bd8 = "zombie_mangler_hvt";
    self.var_20e5602e719b2988 = self.var_d24c97a0ba2de66f;
  } else if(getdvarint(@ "hash_f85b2e43578eeb5b", 0)) {
    self.ai_type = "disciple";
    self.var_db0e660397a76bd8 = "zombie_disciple_hvt";
    self.var_20e5602e719b2988 = self.var_664da60d21c76e48;
  } else if(getdvarint(@ "hash_ce59878585b9d4e6", 0)) {
    self.ai_type = "megabomb";
    self.var_db0e660397a76bd8 = "zombie_abom_mega_hvt";
    self.var_20e5602e719b2988 = self.var_c55e3742fdc960b7;
  } else if(getdvarint(@ "ob_s3_rift_run", 0)) {
    self.ai_type = "megabomb";
    self.var_db0e660397a76bd8 = "zombie_abom_mega_hvt";
    self.var_20e5602e719b2988 = self.var_c55e3742fdc960b7;
  }

  var_93249e2e66af0afc = getStructArray(self.varianttag, "target");
  self.interact_struct = var_93249e2e66af0afc[0];

  foreach(struct in var_93249e2e66af0afc) {
    if(isDefined(struct.targetname)) {
      switch (struct.targetname) {
        case #"hash_dbd5b76bf287c738":
          self.interact_struct = struct;
          break;
      }
    }
  }

  function_b6fc2c96b463c007(self);
}

function function_44c6c04fa367baea(point) {
  difficulty_region = undefined;
  difficulty_region = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(point);

  if(!isDefined(difficulty_region) || is_equal(difficulty_region, "difficulty_undefined")) {
    return "difficulty_easy";
  }

  return difficulty_region;
}

function function_415547ee4122c2ca() {
  difficulty_region = undefined;

  if(isDefined(level.var_fac39a693f085779)) {
    difficulty_region = [[level.var_fac39a693f085779]](namespace_68dc261109a9503f::function_8988a4c89289d7f4(self));
  }

  if(!isDefined(difficulty_region) || is_equal(difficulty_region, "difficulty_undefined")) {
    return "difficulty_easy";
  }

  return difficulty_region;
}

function function_a551ec2d5303061b(struct, maxdist) {
  if(distancesquared(struct.origin, self.interact_struct.origin) >= squared(self.spawnmindist) && distancesquared(struct.origin, self.interact_struct.origin) <= squared(maxdist)) {
    return true;
  }

  return false;
}

function function_1ddc9629c6534e38() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  self.on_mission = zombie_challenges::function_f578373042c34e16(16651, "quest_s0a2t3_bountyhunt_start", self.playerparticipants);

  if(!self.on_mission && !istrue(self.var_24a16c52437dde0f)) {
    thread function_1281c7fff9456e18("contract_bigbounty_start");
  }

  foreach(player in self.playerparticipants) {
    player setclientomnvar("ui_br_objective_param", function_e56334b856964aef());
    params = spawnStruct();
    params.player = player;
    callback::callback("big_bounty_started", params);
  }

  function_e4dae689f876b8ba();
  function_70785f5ff53b07c9();
  self.ai_zombie waittill("death");
  goo_origin = getgroundposition(self.ai_zombie.origin, 1);

  if(!isDefined(goo_origin)) {
    goo_origin = self.ai_zombie.origin;
  }

  self.var_fa72b05f74204fb9 = goo_origin;
  var_ec5900b94ec05c4a = (goo_origin[0], goo_origin[1], goo_origin[2] - 1);
  self.goo = utility::spawn_model("jup_zm_pile_of_goo", var_ec5900b94ec05c4a, self.ai_zombie.angles);
  self.goo setscriptablepartstate("audio", "spawned");
  playerparticipants = self.playerparticipants;
  thread function_6f3caa9ac6c424a9(playerparticipants, goo_origin);
  function_2c8097c0bcd7e70();
}

function function_6f3caa9ac6c424a9(players, goo_origin) {
  activity_instance = self;
  activity_instance endon("instance_destroyed");

  if(istrue(self.var_24a16c52437dde0f)) {
    return;
  }

  var_f8f4f21c37f86c70 = namespace_c47da9d4c2db4f0d::function_709eb291cbeeb02(self, "contract_bigbounty_ee_goo");
  wait 4;

  while(true) {
    foreach(player in players) {
      if(isDefined(player) && isalive(player) && isDefined(goo_origin)) {
        dist = distancesquared(player.origin, goo_origin);

        if(dist < squared(100) && scripts\engine\utility::within_fov(player.origin, player.angles, goo_origin, cos(70))) {
          eyepos = player getEye();

          if(sighttracepassed(eyepos, goo_origin, 1, player, self.goo)) {
            broadcast(var_f8f4f21c37f86c70, [player]);
          }
        }
      }
    }

    wait 0.1;
  }
}

function function_2c8097c0bcd7e70() {
  activity_instance = self;

  if(!istrue(self.var_24a16c52437dde0f)) {
    thread function_1281c7fff9456e18("contract_bigbounty_success");
  }

  endactivity(activity_instance, 1);
}

function function_3bab4fee62f0fbd8() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  self endon("AI_seen");

  while(true) {
    if(distancesquared(self.ai_zombie.origin, self.var_7ca681f995301d27) > squared(self.circleradius)) {
      self notify("bigbounty_ping_marker_moved");
      self.var_7ca681f995301d27 = function_b51e0dd3c4ef0eed(self.aispawnstruct);

      foreach(player in self.playerparticipants) {
        if(isDefined(player)) {
          self.pingindex = player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, self.var_7ca681f995301d27, self.activity_id);
          thread scripts\cp_mp\calloutmarkerping::function_9a7200f5142066ba(player, self.pingindex, undefined, ["bigbounty_ping_marker_moved"]);
          break;
        }
      }

      scripts\mp\objidpoolmanager::update_objective_position(self.activity_id, self.var_7ca681f995301d27);
      function_6e148c8da2e4db13(self.var_7ca681f995301d27);
    }

    wait 5;
  }
}

function function_6b9c1b0c02633e65() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  self endon("AI_seen");

  while(true) {
    foreach(player in self.playerparticipants) {
      if(!isDefined(player) || !isalive(player)) {
        continue;
      }

      dist = distancesquared(player.origin, self.ai_zombie.origin);

      if(dist < squared(2000) && scripts\engine\utility::within_fov(player.origin, player.angles, self.ai_zombie.origin, cos(70))) {
        seen = 0;
        var_73b566ef640efc09 = (self.ai_zombie.origin[0], self.ai_zombie.origin[1], self.ai_zombie.origin[2] + 50);
        eyepos = player getEye();
        waitframe();

        if(sighttracepassed(eyepos, var_73b566ef640efc09, 1, player, self.ai_zombie)) {
          function_d81084befdcda4a5();
          seen = 1;
          self notify("AI_seen");
        }

        if(self.ai_type == "megabomb" && !seen) {
          var_73b566ef640efc09 = (self.ai_zombie.origin[0], self.ai_zombie.origin[1], self.ai_zombie.origin[2] + 200);
          eyepos = player getEye();
          waitframe();

          if(sighttracepassed(eyepos, var_73b566ef640efc09, 1, player, self.ai_zombie)) {
            function_d81084befdcda4a5();
            self notify("AI_seen");
          }
        }
      }
    }

    waitframe();
  }
}

function function_d81084befdcda4a5() {
  function_4eaf685bc40a3b9();
  scripts\mp\objidpoolmanager::update_objective_onentity(self.activity_id, self.ai_zombie);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(self.activity_id, self.var_20e5602e719b2988);
  thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();
}

function function_b51e0dd3c4ef0eed(spawn_struct) {
  x_offset = randomintrange(self.circleoffset * -1, self.circleoffset);
  y_offset = randomintrange(self.circleoffset * -1, self.circleoffset);
  offset_origin = (spawn_struct.origin[0] + x_offset, spawn_struct.origin[1] + y_offset, spawn_struct.origin[2] + self.var_d51c5b5df247c905);
  return offset_origin;
}

function private function_e56334b856964aef() {
  switch (self.var_db0e660397a76bd8) {
    case #"hash_c1fa8721b046b258":
      return 1;
    case #"hash_60cbd0daf82a39c9":
      return 2;
    case #"hash_c1b612499d7bd4a":
      return 3;
    case #"hash_a18ec1c48b974dc7":
      return 4;
  }
}

function function_a8a2b5385efae3a6() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.wave_index = 0;
  function_ec0ae7d1127fa00(self.region_string);
}

function function_ec0ae7d1127fa00(region) {
  self endon("activity_ended");
  self endon("instance_destroyed");

  if(!isDefined(self.var_4a30e8b5f565a933[self.region_string][0])) {
    return;
  }

  var_934083a148144947 = "ai_flood_fill_encounter:" + self.var_4a30e8b5f565a933[self.region_string][self.wave_index];
  self.encounter_origin = function_8988a4c89289d7f4(self);
  request_id = namespace_34bf641998024ddb::function_f8ccadcd850da124(var_934083a148144947, self.encounter_origin, 800, 1, 0, 1, 2);
  function_ce9c21523336cdbc(request_id, &function_d984d0bc8b82a279, self);

  switch (region) {
    case #"hash_7bb2cd766703d463":
      function_d37068aac7785c04(request_id, "base_zombie", 1);
      break;
    case #"hash_5343b465e56ec9a4":
    case #"hash_651f76c0ad6741ec":
    case #"hash_af83e47edfa8900a":
      function_d37068aac7785c04(request_id, "base_zombie", 1);
      function_d37068aac7785c04(request_id, "armored_zombie", 1);
      break;
    default:
      function_d37068aac7785c04(request_id, "base_zombie", 1);
      break;
  }

  encounter_params = spawnStruct();
  encounter_params.request_id = request_id;
  encounter_params.wave_index = self.wave_index;
  self.var_d8a75048641f114e["ambient"][request_id] = encounter_params;
  scripts\cp_mp\agents\ai_spawn_director::function_bc5315dc37ae4cf(request_id, &function_5648fc22043a73cf);
  scripts\cp_mp\agents\ai_spawn_director::function_73147cdf5c28d10c(request_id, &function_b7c01d53cbd78e62, self);
  function_4b7d420e1bad897f(request_id, 8);
  self.request_id = request_id;
  thread function_4e275d54aa5d27ec();
}

function function_4e275d54aa5d27ec() {
  self endon("activity_ended");
  self endon("instance_destroyed");

  while(true) {
    if(distancesquared(self.encounter_origin, function_8988a4c89289d7f4(self)) > 1500) {
      self.encounter_origin = function_8988a4c89289d7f4(self);
      function_df930eed75d4f74f(self.request_id, self.encounter_origin, 800);
    }

    wait 1;
  }
}

function function_5648fc22043a73cf(requestid, userdata) {
  return true;
}

function function_b7c01d53cbd78e62(requestid, userdata) {
  if(!isDefined(userdata)) {
    return true;
  }

  if(!isarray(userdata.var_d8a75048641f114e)) {
    return true;
  }

  if(!isDefined(userdata.var_d8a75048641f114e["ambient"][requestid])) {
    return true;
  }

  if(!is_equal(userdata.var_d8a75048641f114e["ambient"][requestid].wave_index, userdata.wave_index)) {
    return true;
  }

  return false;
}

function function_d984d0bc8b82a279(requestid, userdata, agent, data) {}

function function_70785f5ff53b07c9() {
  activity_instance = self;
  activity_instance endon("instance_destroyed");
  activity_instance endon("AI_spawned");
  ai_spawned = 0;

  while(!ai_spawned) {
    foreach(player in self.playerparticipants) {
      if(distancesquared(player.origin, self.aispawnstruct.origin) <= squared(self.spawnradius)) {
        ai_spawned = 1;
        spawn_point = getclosestpointonnavmesh(self.aispawnstruct.origin);
        aitype = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc(self.var_db0e660397a76bd8);
        self.ai_zombie = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(aitype[0], spawn_point, self.aispawnstruct.angles, "team_two_hundred");
        waitframe();

        if(isDefined(self.ai_zombie)) {
          self.ai_zombie ent_flag_init("big_bounty_target");
          self.ai_zombie ent_flag_set("log_on_despawn");
          self.ai_zombie callback::add("on_zombie_ai_killed", &on_zombie_ai_killed);
        }

        thread function_f069e10a4ee93d9f();
        thread function_6b9c1b0c02633e65();
        thread function_3bab4fee62f0fbd8();
        thread function_a8a2b5385efae3a6();

        if(self.var_db0e660397a76bd8 != "zombie_disciple_hvt") {
          thread function_da005eb9ab9ef712();
        }

        callback::callback("big_bounty_target_spawned", {
          #instance: self
        });
        self notify("AI_spawned");
      }
    }

    wait 0.1;
  }
}

function on_zombie_ai_killed(params) {
  var_129cfed92896a644 = string(self getentitynumber());
  weaponname = isDefined(params.objweapon) ? params.objweapon.basename : "";
  damage = isDefined(params.idamage) ? string(params.idamage) : "";
  entitynum = isDefined(params.eattacker) ? string(params.eattacker getentitynumber()) : "";
  classname = isDefined(params.eattacker) && isDefined(params.eattacker.classname) ? params.eattacker.classname : "";
  inflictor = isDefined(params.einflictor) ? params.einflictor.classname : "";
  var_405e1f9370025d56 = isDefined(params.einflictor) ? string(params.einflictor getentitynumber()) : "";
  error_msg = "Bounty slain [ " + var_129cfed92896a644 + " ]. Weapon: " + weaponname + " - Damage: " + damage + " - Attacker EntNum: " + entitynum + " - Attacker Class: " + classname + " - Inflictor EntNum: " + var_405e1f9370025d56 + " - Inflictor Class: " + inflictor;
  logstring(error_msg);
}

function function_da005eb9ab9ef712() {
  self.ai_zombie endon("death");
  var_3d17afd54b2e8657 = self.ai_zombie.origin;
  var_b88633e593471f5c = 0;

  while(true) {
    if(!ispointonnavmesh(self.ai_zombie.origin)) {
      navmesh_origin = getclosestpointonnavmesh(self.ai_zombie.origin);

      if(!isDefined(navmesh_origin) || distancesquared(self.ai_zombie.origin, navmesh_origin) > squared(256)) {
        var_b88633e593471f5c++;
      }

      if(var_b88633e593471f5c > 3) {
        if(isDefined(navmesh_origin) && distancesquared(self.ai_zombie.origin, navmesh_origin) <= squared(256)) {
          var_b88633e593471f5c = 0;
          self.ai_zombie forceteleport(navmesh_origin);
        } else {
          var_b88633e593471f5c = 0;
          self.ai_zombie forceteleport(var_3d17afd54b2e8657);
        }
      }
    } else {
      var_b88633e593471f5c = 0;
      var_3d17afd54b2e8657 = self.ai_zombie.origin;
    }

    wait 3;
  }
}

function function_f069e10a4ee93d9f() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  var_682d602ddf0d8234 = 0;

  while(!var_682d602ddf0d8234) {
    foreach(player in self.playerparticipants) {
      if(distancesquared(player.origin, self.aispawnstruct.origin) <= squared(self.circleradius)) {
        infov = 0;

        if(scripts\engine\utility::within_fov(player.origin, player.angles, self.ai_zombie.origin, cos(70))) {
          var_73b566ef640efc09 = (self.ai_zombie.origin[0], self.ai_zombie.origin[1], self.ai_zombie.origin[2] + 50);
          eyepos = player getEye();
          waitframe();

          if(sighttracepassed(eyepos, var_73b566ef640efc09, 1, player, self.ai_zombie)) {
            infov = 1;
          }
        }

        if(!infov && !istrue(self.var_24a16c52437dde0f)) {
          thread namespace_277c27ef297ef569::function_1281c7fff9456e18("bigbounty_approached_hvt");
        }

        var_682d602ddf0d8234 = 1;
        return;
      }
    }

    waitframe();
  }
}

function function_e4dae689f876b8ba() {
  activity_instance = self;
  activity_instance endon("instance_destroyed");
  var_ce7d122aeea98ccd = 10;
  potential_spawns = getStructArray("bigbounty_spawn", "targetname");
  self.var_330bae6241dd76bc = [];

  for(index = 0; index < potential_spawns.size; index++) {
    struct = potential_spawns[index];
    struct_region = function_44c6c04fa367baea(struct.origin);

    if(struct_region == self.region_string && function_a551ec2d5303061b(struct, self.spawnmaxdist) && struct.script_noteworthy == self.ai_type) {
      self.var_330bae6241dd76bc[self.var_330bae6241dd76bc.size] = struct;
    }

    if(index % var_ce7d122aeea98ccd == 0) {
      waitframe();
    }
  }

  if(self.var_330bae6241dd76bc.size < 3) {
    count_reached = 0;
    maxdist = self.spawnmaxdist + 500;

    while(!count_reached) {
      counter = 0;

      foreach(struct in potential_spawns) {
        struct_region = function_44c6c04fa367baea(struct.origin);

        if(function_a551ec2d5303061b(struct, maxdist) && struct.script_noteworthy == self.ai_type && struct_region == self.region_string) {
          self.var_330bae6241dd76bc = function_6d6af8144a5131f1(self.var_330bae6241dd76bc, struct);

          if(self.var_330bae6241dd76bc.size >= 3) {
            count_reached = 1;
          }
        }

        counter++;

        if(counter >= 200) {
          waitframe();
          counter = 0;
        }
      }

      maxdist += 500;

      if(maxdist >= 18000) {
        count_reached = 1;
      }

      waitframe();
    }
  }

  if(self.var_330bae6241dd76bc.size < 0) {
    endactivity(activity_instance, 0);
    function_d17f711a3cf0d287();
  }

  spawn_struct = self.var_330bae6241dd76bc[0];
  furthest_distance = 0;
  var_ce7d122aeea98ccd = 10;

  for(index = 0; index < self.var_330bae6241dd76bc.size; index++) {
    if(index % var_ce7d122aeea98ccd == 0) {
      waitframe();
    }

    struct = self.var_330bae6241dd76bc[index];

    if(isDefined(level.aether_storm) && level.aether_storm.radiation scripts\cp_mp\radiation::function_1b4f63fa623de69a(struct.origin) || namespace_af57321bdeb06a78::function_a055325e4e4436fe(struct.origin, 1)) {
      continue;
    }

    mindistance = distancesquared(level.players[0].origin, struct.origin);
    nearestplayer = level.players[0];

    foreach(pl in level.players) {
      if(distancesquared(pl.origin, struct.origin) < mindistance) {
        mindistance = distancesquared(pl.origin, struct.origin);
        nearestplayer = pl;
      }
    }

    if(distancesquared(nearestplayer.origin, struct.origin) > furthest_distance) {
      furthest_distance = distancesquared(nearestplayer.origin, struct.origin);
      spawn_struct = struct;
    }
  }

  self.aispawnstruct = spawn_struct;
  function_3a38fb1773a90e3d();
}

function function_3a38fb1773a90e3d() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");

  if(isDefined(level.var_7f1d1c7c6153a9bf) && [[level.var_7f1d1c7c6153a9bf]]()) {
    self.activity_id = function_36a95c9de2ace25a("jup_ob_objectivemarker_bigbounty_rift_run", 1, 1);
  } else {
    self.activity_id = function_36a95c9de2ace25a("jup_ob_objectivemarker_bigbounty", 1, 1);
  }

  waitframe();
  self.var_7ca681f995301d27 = function_b51e0dd3c4ef0eed(self.aispawnstruct);
  scripts\mp\objidpoolmanager::update_objective_position(self.activity_id, self.var_7ca681f995301d27);
  waitframe();

  foreach(player in self.playerparticipants) {
    if(isDefined(player)) {
      self.pingindex = player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(11, self.var_7ca681f995301d27, self.activity_id);
      break;
    }
  }

  function_6b6b6273f8180522("BigBounty_Ob", self.var_7ca681f995301d27, self.circleradius);

  foreach(member in self.playerparticipants) {
    function_cfd53c8f6878014f(member);
  }
}

function function_7b0fea7ae2112c25(activity_succeeded) {
  activity_instance = self;
  activity_instance endon("instance_destroyed");
  activity_instance function_a26e39e03a0d6739();

  if(function_acaa75ca8754452e()) {
    function_af5604ce591768e1();
  }
}

function function_d17f711a3cf0d287() {
  activity_instance = self;
  activity_instance endon("instance_destroyed");

  if(function_acaa75ca8754452e()) {
    function_af5604ce591768e1();
  }

  if(isDefined(self.ai_zombie)) {
    self.ai_zombie kill();
  }

  if(isDefined(self.goo)) {
    self.goo delete();
  }
}

function function_6f747a641f77773c() {
  if(isDefined(self.interact_struct)) {
    return self.interact_struct.origin;
  }

  return undefined;
}

function function_3d2a5e67e320a325() {
  var_6c1956fd6ce84917 = 1;
  var_cc7aa96a854fd8ee = namespace_71ca15b739deab72::function_3ae7f99339b96499(self.var_fa72b05f74204fb9, var_6c1956fd6ce84917, self.var_4158f9fefbe61805);
  return var_cc7aa96a854fd8ee;
}

function function_93cc9badd07b3211(var_b381b0883bcd4847) {
  activity_instance = self;

  if(isDefined(self.var_cda97c89ff1bb729) && isDefined(self.var_295815e7263cda4d) && array_contains(var_b381b0883bcd4847.reward_group, self.var_295815e7263cda4d)) {
    quest_key = spawnStruct();
    quest_key.lootid = self.var_cda97c89ff1bb729;
    quest_key.quantity = 1;
    return [quest_key];
  }

  return activity_instance namespace_71ca15b739deab72::function_9302d6fba4ac736a(var_b381b0883bcd4847);
}

function function_e2827300b9992692(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

function function_f0f14142a301b2e2(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;

  if(function_acaa75ca8754452e()) {
    foreach(player in player_list) {
      function_d7d113d56ef0ef5b(player);
    }
  }
}

function function_540f9b357f3b5419(var_b381b0883bcd4847) {
  if(!istrue(self.var_24a16c52437dde0f) && isDefined(var_b381b0883bcd4847.playerlist)) {
    thread function_1281c7fff9456e18("contract_bigbounty_abandoned", var_b381b0883bcd4847.playerlist);
  }
}
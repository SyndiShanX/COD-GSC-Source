/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_edb8e725d068ac9.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_208955cb4d2c8fb3;
#using script_20a226c24f1585bf;
#using script_220d0eb95a8fab7d;
#using script_2304453c69e996e2;
#using script_24946c036cb2f7b2;
#using script_24fbedba9a7a1ef4;
#using script_2d400da2610fe542;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_42adcce5878f583;
#using script_46c7c73b1a7e4773;
#using script_4e6e58ab5d96c2b0;
#using script_5200937492b52afd;
#using script_5295a2c10229ffef;
#using script_5753ba9c28794a65;
#using script_59a48734035ff34d;
#using script_5d8202968463a21d;
#using script_638d701d263ee1ed;
#using script_681c3db54537afa6;
#using script_6bffae1b97f70547;
#using script_6df6604a74a7a9c7;
#using script_7956d56c4922bd1;
#using script_7cfaa6fd841fb4dd;
#using script_ec2a55b85051e9b;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment\scripted_trophy;
#using scripts\cp_mp\equipment\thermobaric_grenade;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\tripwire;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\scriptable;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\equipment\claymore;
#using scripts\mp\gametypes\ob;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\player;
#namespace namespace_35b2e84a255ee2f6;

function function_8abadf3d8f19384a() {
  activity_common::function_89384091f7a2dbd("REV_OB_WARLORD", 0, &function_2f2e68800d162bd0);
  activity_common::function_89384091f7a2dbd("REV_OB_WARLORD", 1, &function_117718a13c7de6b0);
  activity_common::function_89384091f7a2dbd("REV_OB_WARLORD", 2, &function_e011dac5a20d257c);
  activity_common::function_89384091f7a2dbd("REV_OB_WARLORD", 3, &function_db6605af979b72df);
  activity_common::function_89384091f7a2dbd("REV_OB_WARLORD", 4, &function_46e783dbae11a33e);
  activity_common::function_89384091f7a2dbd("REV_OB_WARLORD", 5, &function_5d3698def4754183);
  activity_common::function_89384091f7a2dbd("REV_OB_WARLORD", 7, &function_b4364b16b16b0c60);
  activity_common::function_8b5b2a3392fc7e2a("ActivityBegin", &function_ff58fdabe59872b2, "REV_OB_WARLORD");
  activity_common::function_8b5b2a3392fc7e2a("ActivityEnd", &function_57ddbeb9a1cc605e, "REV_OB_WARLORD");
  activity_common::function_8b5b2a3392fc7e2a("PlayerJoin", &function_6d66d93448222103, "REV_OB_WARLORD");
  activity_common::function_8b5b2a3392fc7e2a("PlayerLeave", &function_dc36a8f9522bd566, "REV_OB_WARLORD");
  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_61c4487eafc2bc4c);
  callback::add("on_ai_killed", &function_e5ea18b76842725f);
  namespace_4c2b495b8d79cc2e::function_fca481c0e8fafd2c("SpatialZoneContainerGroup_Warlord_No_Key_Zone", &function_f13be2fe056ab5a, &function_6ce86afa6684b8eb, "handler_comms_nokey");
  namespace_4c2b495b8d79cc2e::function_fca481c0e8fafd2c("SpatialZoneContainerGroup_Warlord_Comms_Zone", &function_f13be2fe056ab5a, &function_e17f7c1d44ee2fe5, "warlord_comms_range");
  namespace_4c2b495b8d79cc2e::function_fca481c0e8fafd2c("SpatialZoneContainerGroup_Warlord_Handler_Comms_Zone", &function_f13be2fe056ab5a, &function_b66d94a678e363e4, "handler_comms_range");
  namespace_4c2b495b8d79cc2e::function_11a6c27cf403881f("SpatialZoneContainerGroup_Warlord_Handler_Comms_Zone", &function_a81c6611776ea959);

  if(getdvarint(@ "hash_8560a0fd509568a8", 0)) {
    callback::add("player_spawned", &on_player_spawned);
  }

  setdvarifuninitialized(@ "hash_31b253892ec07512", 0.9, 0, 1);

  function_c638fba4eade0ac3();
}

function on_player_spawned(params) {
  thread function_a7bac03ceca2c973();
}

function function_2f2e68800d162bd0() {
  self.centerstruct = utility::getStruct(self.varianttag, "targetname");
  self.var_184f5484f9868308 = utility::getStruct(self.varianttag + "_RADIANT", "targetname");
  self.goal_volumes = [];
  self.vehicles = [];
  self.warlord_cover = [];
  self.agents = [];
  self.var_b293aa98b3af028f = [];
  self.suppression_mines = [];
  self.trophy_nodes = [];
  self.trigger_volumes = [];
  self.sentries = [];
  self.tripwires = [];
  self.vfx = [];
  self.var_23b910077b8047db = [];
  self.var_ec082222d3b65a9a = [];
  self.var_b11fbfdeb09954c2 = [];
  self.laser_tripwires = [];
  self.b_airstrike = 1;
  function_71443626b27491ba();
  function_d4a7e3d1bed1606c();
  function_862ec3b2476d1b25();
  function_8f94c63669b258b();
  thread function_6fbbd049f160f136();

  if(isDefined(self.centerstruct)) {
    self.region_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10(self.centerstruct.origin);

    switch (self.region_difficulty) {
      case #"hash_7bb2cd766703d463":
        self.var_b90c26f642e9b96e = "ob_major_activity_complete_green";
        break;
      case #"hash_af83e47edfa8900a":
        self.var_b90c26f642e9b96e = "ob_major_activity_complete_yellow";
        break;
      case #"hash_5343b465e56ec9a4":
        self.var_b90c26f642e9b96e = "ob_major_activity_complete_red";
        break;
      case #"hash_651f76c0ad6741ec":
        self.var_b90c26f642e9b96e = "ob_major_activity_complete_orange";
        break;
      default:
        println("<dev string:x1c>" + self.centerstruct.origin);
        return;
    }
  }

  thread function_6997cf73d6a2c9a4();

  if(getdvarint(@ "hash_7bad6ebd2065ec37", 0)) {
    function_93b355d72bbf87ba();
  }

  if(getdvarint(@ "hash_cd07a64b17183b31", 1) && !istrue(scripts\engine\utility::function_f3bb4f4911a1beb2("warlords", "warlordIsDisabled", "WARLORD_RAINMAKER"))) {
    thread function_7550473fbe4c5f8d();
  }

  if(isDefined(level) && !istrue(level.var_5f9b7aebe78d69a0)) {
    if(!self.var_24ff739b2eb09591 && !self.warlordenabled) {
      function_4c7fb6ad4120d921();
    }
  }

  namespace_4fda5d7358015a06::function_b6fc2c96b463c007(self);

  if(!isDefined(level.ob.var_7dd4780d4e4bff4d)) {
    level.ob.var_7dd4780d4e4bff4d = [];
  }

  level.ob.var_7dd4780d4e4bff4d[level.ob.var_7dd4780d4e4bff4d.size] = self;

  if(self.varianttag == "WARLORD_ALLFORONE") {
    if(isDefined(self.var_1556d7f7e1dc9165)) {
      function_d37068aac7785c04(self.var_1556d7f7e1dc9165, self.region_difficulty, 1);
      self.var_5818a66f80fcc972 = -1;
      scripts\cp_mp\agents\ai_spawn_director::function_7a2920be35f4386(self.var_1556d7f7e1dc9165, &function_e201002625151c19, [self]);
    }
  } else if(self.varianttag == "WARLORD_MAESTRO") {
    namespace_8480efeffcd6e233::function_35da39cae76b832d(self, "warlord_comms_range", 1);
    namespace_8480efeffcd6e233::function_35da39cae76b832d(self, "handler_comms_range", 1);
  }

  namespace_9718b9a169c3ead0::function_cb146e445d78e9ee();
}

function function_e201002625151c19(requestid, userdata, wavenumber) {
  activitydata = userdata[0];

  if(!isDefined(activitydata.var_5818a66f80fcc972)) {
    return false;
  }

  if(activitydata.var_5818a66f80fcc972 >= 0) {
    if(gettime() > activitydata.var_5818a66f80fcc972) {
      activitydata.var_5818a66f80fcc972 = -1;
      return true;
    }

    return false;
  }

  requestinfo = function_9a39e23c3c52c2af(requestid);
  var_1d4422cffe43a39b = 8;
  reinforcementdelaytime = 0;

  switch (wavenumber) {
    case 0:
      var_1d4422cffe43a39b = 22;
      reinforcementdelaytime = 1;
      break;
    case 1:
      var_1d4422cffe43a39b = 25;
      reinforcementdelaytime = 20;
      break;
    case 2:
      var_1d4422cffe43a39b = 18;
      reinforcementdelaytime = 20;
      break;
    case 3:
      var_1d4422cffe43a39b = 8;
      reinforcementdelaytime = 90;
      break;
    case 4:
      var_1d4422cffe43a39b = 13;
      reinforcementdelaytime = 35;
      break;
    case 5:
      var_1d4422cffe43a39b = 12;
      reinforcementdelaytime = 20;
      break;
    case 6:
      var_1d4422cffe43a39b = 8;
      reinforcementdelaytime = 180;
      break;
    case 7:
      var_1d4422cffe43a39b = 13;
      reinforcementdelaytime = 20;
      break;
    case 8:
      var_1d4422cffe43a39b = 12;
      reinforcementdelaytime = 20;
      break;
    case 9:
      var_1d4422cffe43a39b = 8;
      reinforcementdelaytime = 90;
      break;
    case 10:
      var_1d4422cffe43a39b = 13;
      reinforcementdelaytime = 35;
      break;
    case 11:
      var_1d4422cffe43a39b = 12;
      reinforcementdelaytime = 20;
      break;
    case 12:
      var_1d4422cffe43a39b = 8;
      reinforcementdelaytime = 180;
      break;
    case 13:
      var_1d4422cffe43a39b = 13;
      reinforcementdelaytime = 20;
      break;
    case 14:
      var_1d4422cffe43a39b = 12;
      reinforcementdelaytime = 20;
      break;
    case 15:
      var_1d4422cffe43a39b = 8;
      reinforcementdelaytime = 90;
      break;
    case 16:
      var_1d4422cffe43a39b = 13;
      reinforcementdelaytime = 35;
      break;
    case 17:
      var_1d4422cffe43a39b = 12;
      reinforcementdelaytime = 20;
      break;
    default:
      break;
  }

  if(requestinfo.ai.size <= var_1d4422cffe43a39b) {
    if(reinforcementdelaytime == 0) {
      return true;
    }

    activitydata.var_5818a66f80fcc972 = gettime() + reinforcementdelaytime * 1000;
  }

  return false;
}

function function_117718a13c7de6b0() {
  var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(self);
  self.var_d1c7613187e69022 = var_d1c7613187e69022;
  self.var_c6358338b001421e = [];
  self.var_5dee1547ae6ea9b9 = [];
  self.var_54f15fe5e3cf317e = [];
  self.var_60b311ec76290e79 = [];
  self.var_51abd1adba5747ef = [];
  activity_participation::function_3e33031646de23b0(self);

  if(istrue(self.b_airstrike)) {
    kill_zone = namespace_4c2b495b8d79cc2e::function_5bbdc39a533d9d57(self, "Ambient_AI_Exclusion_Zone");
    namespace_64135de19550f047::function_daee52aa53ad6314(kill_zone[0].origin, kill_zone[0].radius);
  }

  if(var_d1c7613187e69022.helicopterenabled) {
    thread function_1e1e28d0a6731c06(self);
  }

  thread function_4e27bde5c4ab78e2();
}

function function_e011dac5a20d257c() {
  foreach(vfx in self.vfx) {
    vfx setscriptablepartstate("state", "hidden");
  }

  if(self.varianttag == "WARLORD_CHEMIST") {
    foreach(player in self.var_6c29f2fdb0054bbe) {
      if(player.var_d9928cc9ad437613) {
        if(!player namespace_d3f3cf99d75d3345::function_6ef47ee9171ed1b9() && (istrue(player.gasmaskequipped) || istrue(player.gasmaskswapinprogress) && !istrue(player.gasmaskequipped))) {
          player namespace_d3f3cf99d75d3345::toggle_gasmask("off");
        }
      }

      player.var_d9928cc9ad437613 = 0;
      player namespace_d3f3cf99d75d3345::function_92bdd3200219d4b7();
    }
  }

  if(namespace_4c2b495b8d79cc2e::function_1888d1b2aeeda25(self, "warlord_comms_range")) {
    namespace_4c2b495b8d79cc2e::function_d829ceb32b15c66a(self, "warlord_comms_range");
  }

  if(namespace_4c2b495b8d79cc2e::function_1888d1b2aeeda25(self, "handler_comms_range")) {
    namespace_4c2b495b8d79cc2e::function_d829ceb32b15c66a(self, "handler_comms_range");
  }
}

function function_db6605af979b72df() {
  self.var_d1c7613187e69022 = undefined;
  self.var_c6358338b001421e = undefined;
  self.var_5dee1547ae6ea9b9 = undefined;
  self.var_54f15fe5e3cf317e = undefined;
  self.var_60b311ec76290e79 = undefined;
  self.var_51abd1adba5747ef = undefined;

  if(self.var_23b910077b8047db.size > 0) {
    foreach(cache in self.var_23b910077b8047db) {
      cache freescriptable();
    }
  }
}

function function_46e783dbae11a33e() {}

function function_5d3698def4754183(var_6f8af5eb76deac21) {
  reward_structs = self.centerstruct function_954eb52ab4cdeb46(tolower("s_" + self.varianttag + "_reward"), "targetname");
  assertex(isDefined(reward_structs[0]), "<dev string:x77>");
  return reward_structs[0];
}

function function_b4364b16b16b0c60(var_6f8af5eb76deac21) {
  instance = var_6f8af5eb76deac21.activity_instance;
  cache = spawnStruct();
  cache.contents = [];

  if(isDefined(instance.var_d1c7613187e69022.var_40a60ab97af0a72d) && instance.var_d1c7613187e69022.var_40a60ab97af0a72d != "") {
    common_cache::function_d71a41afca697376(cache, instance.var_d1c7613187e69022.var_40a60ab97af0a72d, 3);
  } else {
    assertmsg("<dev string:xb8>");
  }

  if(isDefined(instance.var_d1c7613187e69022.var_57bd150ec48f66fd) && instance.var_d1c7613187e69022.var_57bd150ec48f66fd != "") {
    common_cache::function_ff5a53c1d3232e2f(cache, 1, instance.var_d1c7613187e69022.var_57bd150ec48f66fd);
  }

  return cache.contents;
}

function function_6d66d93448222103(var_6f8af5eb76deac21) {
  playerlist = var_6f8af5eb76deac21.playerlist;
  var_b494ea8c4b70490 = var_6f8af5eb76deac21.var_b494ea8c4b70490;

  if(isDefined(self)) {
    foreach(player in playerlist) {
      if(isDefined(player)) {
        function_172019cfb04f5df4(player.team, player.sessionsquadid);
        player.var_15e233396dbbe296 = getdvarint(@ "hash_7abe4b1e03c0f79d", 3);
      }
    }
  }

  if(self.varianttag == "WARLORD_CHEMIST") {
    if(isDefined(level.var_367d292e115ae65c)) {
      [[level.var_367d292e115ae65c]](var_6f8af5eb76deac21);
    }
  }
}

function function_dc36a8f9522bd566(var_6f8af5eb76deac21) {
  playerlist = var_6f8af5eb76deac21.playerlist;

  if(self.varianttag == "WARLORD_CHEMIST") {
    if(isDefined(level.var_81ba5adae4e23b59)) {
      [[level.var_81ba5adae4e23b59]](var_6f8af5eb76deac21);
    }
  }

  if(isDefined(self)) {
    foreach(player in playerlist) {
      player.var_15e233396dbbe296 = undefined;

      if(self.state != "EndedState") {
        player function_4a508fcbbea05afd(self.varianttag);
      }

      if(self.varianttag == "WARLORD_MAESTRO") {
        player scripts\mp\gametypes\ob::function_6109bfd0330e0b8f("warlord_maestro", 0);
      }
    }
  }
}

function function_4a508fcbbea05afd(variant_tag) {
  self endon("death_or_disconnect");
  wait 120;
  player = self;

  if(variant_tag == "WARLORD_ALLFORONE") {
    if(function_5acc35fc66331385(player, 17078)) {
      player ent_flag_clear("quest_s0a3t3_mercstronghold_allforone_intro");
      player ent_flag_clear("quest_s0a3t3_merccamp_allforone_success");
      player ent_flag_clear("quest_s0a3t3_mercstronghold_allforone_success");
    }
  }
}

function function_e17f7c1d44ee2fe5(var_d6bfa53c531546d6) {
  player = var_d6bfa53c531546d6.player;
  var_a917328b0b1b2a19 = var_d6bfa53c531546d6.enteredzone;

  if(isDefined(player) && istrue(var_a917328b0b1b2a19) && isDefined(self) && function_73bd348a2ec322cf(self) == "ActiveState") {
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);

    if(isDefined(squadmembers) && isarray(squadmembers) && squadmembers.size > 0) {
      var_5a6e3a10171c93b = function_9fef405219837367(player.team, player.sessionsquadid);

      if(!var_5a6e3a10171c93b) {
        namespace_277c27ef297ef569::function_1281c7fff9456e18("music_proximity", squadmembers);
        function_f48c2eb99522654c(player.team, player.sessionsquadid);
        wait 3;
      }

      if(!function_37b98a4622b4a7e7(player.team, player.sessionsquadid)) {
        namespace_dc53a27a8db8e6bf::function_d0b51f1ea60e958b(squadmembers, var_5a6e3a10171c93b);
        function_bc48a786f5a1caec(player.team, player.sessionsquadid, 1);
      }
    }
  }
}

function function_b66d94a678e363e4(var_d6bfa53c531546d6) {
  player = var_d6bfa53c531546d6.player;
  var_a917328b0b1b2a19 = var_d6bfa53c531546d6.enteredzone;

  if(isDefined(player) && isDefined(self) && function_73bd348a2ec322cf(self) == "ActiveState") {
    function_b83bd9d74d584449(player, var_a917328b0b1b2a19);
    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);

    if(isDefined(squadmembers) && isarray(squadmembers) && squadmembers.size > 0) {
      othersquadmembers = array_remove(squadmembers, player);

      if(istrue(var_a917328b0b1b2a19)) {
        var_46dd97aee60238fb = !function_32023c054bfb2134(othersquadmembers);

        if(var_46dd97aee60238fb) {
          namespace_277c27ef297ef569::function_1281c7fff9456e18("warlord_intro", squadmembers);
        }

        var_5a6e3a10171c93b = function_5514e10e746ae988(player.team, player.sessionsquadid);

        if(!istrue(var_5a6e3a10171c93b)) {
          function_6fbc52d037ffca97(player.team, player.sessionsquadid);
          namespace_277c27ef297ef569::function_1281c7fff9456e18("music_intro", squadmembers);
          wait 3;
          namespace_dc53a27a8db8e6bf::function_71171b28ba5738df(squadmembers);
        }

        return;
      }

      var_fa61ee2d73806d3b = !function_32023c054bfb2134(othersquadmembers);
      var_f5309bc209c4bce1 = function_37b98a4622b4a7e7(player.team, player.sessionsquadid);

      if(var_fa61ee2d73806d3b && var_f5309bc209c4bce1) {
        namespace_dc53a27a8db8e6bf::function_9c1b6cb8cff3ac15(squadmembers);
        function_bc48a786f5a1caec(player.team, player.sessionsquadid, 0);
      }
    }
  }
}

function private function_bc48a786f5a1caec(team, squad, played) {
  if(!isDefined(team) || !isDefined(squad)) {
    return;
  }

  if(!isDefined(self.var_60b311ec76290e79[team])) {
    self.var_60b311ec76290e79[team] = [];
  }

  self.var_60b311ec76290e79[team][squad] = played;
}

function private function_37b98a4622b4a7e7(team, squad) {
  if(!isDefined(team) || !isDefined(squad)) {
    return false;
  }

  return isDefined(self.var_60b311ec76290e79[team]) && istrue(self.var_60b311ec76290e79[team][squad]);
}

function private function_172019cfb04f5df4(team, squad) {
  if(!isDefined(team) || !isDefined(squad)) {
    return;
  }

  if(!isDefined(self.var_c6358338b001421e[team])) {
    self.var_c6358338b001421e[team] = [];
  }

  if(!isDefined(self.var_c6358338b001421e[team][squad])) {
    self.var_c6358338b001421e[team][squad] = 1;
  }
}

function private function_261dedb8a2ab915d() {
  players = [];

  if(isDefined(self.var_c6358338b001421e) && self.var_c6358338b001421e.size > 0) {
    foreach(team, squads in self.var_c6358338b001421e) {
      if(!isDefined(level.squaddata[team])) {
        continue;
      }

      foreach(squad, dummy in squads) {
        if(!isDefined(level.squaddata[team][squad]) || !isDefined(level.squaddata[team][squad].players)) {
          continue;
        }

        foreach(squadplayer in level.squaddata[team][squad].players) {
          if(isDefined(squadplayer) && isalive(squadplayer)) {
            players[players.size] = squadplayer;
          }
        }
      }
    }
  }

  return players;
}

function private function_f48c2eb99522654c(team, squad) {
  if(!isDefined(team) || !isDefined(squad)) {
    return;
  }

  if(!isDefined(self.var_5dee1547ae6ea9b9[team])) {
    self.var_5dee1547ae6ea9b9[team] = [];
  }

  if(!isDefined(self.var_5dee1547ae6ea9b9[team][squad])) {
    self.var_5dee1547ae6ea9b9[team][squad] = 1;
  }
}

function private function_9fef405219837367(team, squad) {
  if(!isDefined(team) || !isDefined(squad)) {
    return false;
  }

  return isDefined(self.var_5dee1547ae6ea9b9[team]) && istrue(self.var_5dee1547ae6ea9b9[team][squad]);
}

function private function_6fbc52d037ffca97(team, squad) {
  if(!isDefined(team) || !isDefined(squad)) {
    return;
  }

  if(!isDefined(self.var_54f15fe5e3cf317e[team])) {
    self.var_54f15fe5e3cf317e[team] = [];
  }

  if(!isDefined(self.var_54f15fe5e3cf317e[team][squad])) {
    self.var_54f15fe5e3cf317e[team][squad] = 1;
  }
}

function private function_5514e10e746ae988(team, squad) {
  if(!isDefined(team) || !isDefined(squad)) {
    return false;
  }

  return isDefined(self.var_54f15fe5e3cf317e[team]) && istrue(self.var_54f15fe5e3cf317e[team][squad]);
}

function private function_b83bd9d74d584449(player, inzone) {
  if(!isDefined(player) || !isDefined(player.guid)) {
    return;
  }

  self.var_51abd1adba5747ef[player.guid] = inzone;
}

function private function_d5cb0adc7d9ca575(player) {
  if(!isDefined(player) || !isDefined(player.guid)) {
    return false;
  }

  return istrue(self.var_51abd1adba5747ef[player.guid]);
}

function private function_32023c054bfb2134(players) {
  if(!isDefined(players) || !isarray(players)) {
    return false;
  }

  foreach(player in players) {
    if(function_d5cb0adc7d9ca575(player)) {
      return true;
    }
  }

  return false;
}

function private function_71443626b27491ba() {
  var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(self);

  if(var_d1c7613187e69022.var_288c8d9305c3830d != "") {
    self.var_5dcee23735042a7e = ai_spawn_director::function_930897c0d1a7eb24(var_d1c7613187e69022.var_288c8d9305c3830d);
  }

  if(var_d1c7613187e69022.var_6b56b49e3cd8be76 != "") {
    self.var_1556d7f7e1dc9165 = ai_spawn_director::function_930897c0d1a7eb24(var_d1c7613187e69022.var_6b56b49e3cd8be76);
  }

  ffradius = var_d1c7613187e69022.var_b3158fa4b328eced;

  if(ffradius == 0) {
    ffradius = self.centerstruct.radius;
  }

  if(var_d1c7613187e69022.var_ce6817a6a5472a74 != "") {
    self.var_7c3ce577a0a6220e = ai_spawn_director::spawn_request("ai_flood_fill_encounter:" + var_d1c7613187e69022.var_ce6817a6a5472a74, self.centerstruct.origin, ffradius, 0, 1, 0);
  }

  self.warlordenabled = 0;
  self.var_24ff739b2eb09591 = 0;
  self.var_b02230a375a40b26 = 1;
  self.var_237757e83de93466 = 0;
  ent_flag_init("min_bodyguards_spawned");

  if(isDefined(self.var_1556d7f7e1dc9165)) {
    function_fc38783a3da0bc71(self.var_1556d7f7e1dc9165, 1);
    ai_spawn_director::function_e4a67fe4ddca7ed5(self.var_1556d7f7e1dc9165, &function_4feeab7e11747cbf, self);
    ai_spawn_director::function_11f03fd3165d148f(self.var_1556d7f7e1dc9165, &function_90598913578a8611, self);
  }

  if(istrue(var_d1c7613187e69022.var_3f8e801d4fddc931)) {
    function_4c7fb6ad4120d921();
  }
}

function function_4c7fb6ad4120d921() {
  assertex(!self.warlordenabled, "<dev string:x111>");

  if(isDefined(self.var_5dcee23735042a7e)) {
    function_adcc96a7d541aa36(self.var_5dcee23735042a7e, 0);
    function_fc38783a3da0bc71(self.var_5dcee23735042a7e, 1);
    ai_spawn_director::function_e4a67fe4ddca7ed5(self.var_5dcee23735042a7e, &function_2cfc1a4b81b1a37e, self);
    self.warlordenabled = 1;
    thread function_46d11b0177fbbf78();
  }
}

function private function_8f0eda302ff3a00e() {
  if(isDefined(self.var_7c3ce577a0a6220e)) {
    function_adcc96a7d541aa36(self.var_7c3ce577a0a6220e, 0);
    function_fc38783a3da0bc71(self.var_7c3ce577a0a6220e, 1);
    ai_spawn_director::function_e4a67fe4ddca7ed5(self.var_7c3ce577a0a6220e, &function_b78baddc17cc2592, self);
    ai_spawn_director::function_11f03fd3165d148f(self.var_7c3ce577a0a6220e, &function_9414e16098691766, self);
    ai_spawn_director::function_73147cdf5c28d10c(self.var_7c3ce577a0a6220e, &function_36b22edbec3478ce, self);
    self.var_b02230a375a40b26 = 0;
  }
}

function private function_5f8ee230917bcf2f() {
  if(isDefined(self.var_1556d7f7e1dc9165)) {
    if(!istrue(self.var_d1c7613187e69022.var_a85d020fb4e471f8)) {
      function_18790a3cb3f88db7(self.var_1556d7f7e1dc9165);
    }
  }
}

function private function_46d11b0177fbbf78() {
  level endon("game_ended");
  self endon("activity_ended");
  self waittill("fortress_unlocked");

  while(self.var_b02230a375a40b26) {
    ent_flag_wait("min_bodyguards_spawned");

    if(self.var_d1c7613187e69022.var_ee83790983314c1c && self.var_237757e83de93466 <= self.var_d1c7613187e69022.var_dca5ed5becc5bc60) {
      function_8f0eda302ff3a00e();
      break;
    }

    if(!self.var_d1c7613187e69022.var_ee83790983314c1c) {
      function_8f0eda302ff3a00e();
      break;
    }

    waitframe();
  }
}

function function_e5ea18b76842725f(sparams) {
  if(issubstr(self.agent_type, "actor_jup_ob_warlord_")) {
    params = spawnStruct();
    params.warlord_name = self.agent_type;
    params.var_48abf05cf6177c50 = sparams.smeansofdeath;
    params.var_5b949a992945023b = gettime();
    params.var_542053df5d1c8da8 = self.spawned_timestamp;
    var_9c4e6c601cc02f34 = namespace_64135de19550f047::function_3bd4148272ae66ee(sparams);
    var_ef00557b8aebf355 = isDefined(var_9c4e6c601cc02f34) ? var_9c4e6c601cc02f34 : sparams.einflictor;
    var_ef00557b8aebf355 callback::callback("warlord_killed", params);
  }
}

function private function_97a95cbf18a165f3(warlord) {
  level endon("game_ended");
  self endon("activity_ended");
  warlord waittill("death", killer, eattacker, idamage, idflags, smeansofdeath);

  foreach(claymore in self.var_b293aa98b3af028f) {
    claymore thread scripts\mp\equipment\claymore::claymore_trigger();
  }

  foreach(lasertrap in self.laser_tripwires) {
    if(isDefined(lasertrap)) {
      namespace_c7c8e97cfcdfb1e1::function_de1ff0b717ef1a19(lasertrap);
    }
  }

  if(isDefined(warlord)) {
    self.var_8744c7583ee96a5e = warlord.origin;

    if(isPlayer(killer) && namespace_838b439602b3acc7::function_5acc35fc66331385(killer, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      params = spawnStruct();
      params.player = killer;

      if(isDefined(self.var_8744c7583ee96a5e)) {
        params.var_1b68ba89f80f2b5c = self.var_8744c7583ee96a5e;
      } else {
        params.var_1b68ba89f80f2b5c = killer.origin;
      }

      callback::callback("merc_warlord_death", params);
    }
  }

  self.var_b02230a375a40b26 = 1;
  thread function_d925580cdefd8594();

  if(isDefined(self.var_d953047f1b4c7c9) && isDefined(self.var_d953047f1b4c7c9.scriptable)) {
    level notify("forced_kill_callout_" + self.var_d953047f1b4c7c9.scriptable.origin);
  }

  if(isDefined(self.heli)) {
    self.heli.warlordkilled = 1;
  }

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
  }

  foreach(var_6876372a894fe601 in self.var_be1c48bfab7ccb6) {
    namespace_9e69d66f68c38a10::function_b092780f9ec4496e(var_6876372a894fe601);
  }

  self.var_be1c48bfab7ccb6 = [];
  self.var_24ff739b2eb09591 = 0;
}

function function_39003eb2578c3215(agent) {
  level endon("game_ended");
  self endon("activity_ended");
  agent waittill("death", killer);
  self.var_237757e83de93466--;
}

function private function_2cfc1a4b81b1a37e(requestid, activityinstance, agent, data) {
  activityinstance activity_participation::function_f0675d4a690011d6(agent);
  activityinstance.agents = utility::array_add(activityinstance.agents, agent);
  iswarlord = 0;

  if(issubstr(agent.agent_type, "warlord")) {
    activityinstance thread function_97a95cbf18a165f3(agent);
    activityinstance.warlord_agent = agent;
    iswarlord = 1;

    if(!isDefined(agent.ob)) {
      agent.ob = spawnStruct();
    }

    agent.ob.instancedata = activityinstance;
    activityinstance notify("warlord_spawned");
  }

  if(issubstr(agent.agent_type, "bodyguard")) {
    activityinstance.var_237757e83de93466++;
    activityinstance thread function_39003eb2578c3215(agent);
  }

  if(isDefined(activityinstance.var_d1c7613187e69022)) {
    if(activityinstance.var_237757e83de93466 > activityinstance.var_d1c7613187e69022.var_dca5ed5becc5bc60) {
      activityinstance ent_flag_set("min_bodyguards_spawned");
    }
  }

  var_72b14bd03dbabac3 = namespace_4c2b495b8d79cc2e::function_5bbdc39a533d9d57(activityinstance, "Awareness_Zone");
  var_d018f00fe7ac52a2 = namespace_4c2b495b8d79cc2e::function_2403f7fe5d40cecc(var_72b14bd03dbabac3[0]);
  agent function_65cdab0fc78aba8f(namespace_4fda5d7358015a06::function_8988a4c89289d7f4(activityinstance), var_d018f00fe7ac52a2);
  agent utility::ent_flag_wait("stealth_enabled");

  if(!istrue(iswarlord) && activityinstance.varianttag == "WARLORD_CHEMIST") {
    warlordparameters = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46("Chemist");
    function_9a62f2a3e0ef15fa(agent, warlordparameters);
  }

  agent setstealthstate("combat");
}

function private function_4feeab7e11747cbf(requestid, activityinstance, agent, data) {
  level endon("game_ended");
  agent endon("death");

  if(!isDefined(agent.ob)) {
    agent.ob = spawnStruct();
  }

  if(isDefined(data.spawnfilter)) {
    agent.ob.spawnfilter = data.spawnfilter;
  }

  if(isDefined(agent.agent_type) && agent.agent_type == "actor_jup_ob_enemy_specialist_rocketeer") {
    agent.disablereload = 1;
    agent.var_dd87797881fb9b6e = 0;
  }

  var_72b14bd03dbabac3 = namespace_4c2b495b8d79cc2e::function_5bbdc39a533d9d57(activityinstance, "Awareness_Zone");
  var_d018f00fe7ac52a2 = namespace_4c2b495b8d79cc2e::function_2403f7fe5d40cecc(var_72b14bd03dbabac3[0]);

  if(activityinstance.varianttag == "WARLORD_RAINMAKER") {
    agent function_65cdab0fc78aba8f(namespace_4fda5d7358015a06::function_8988a4c89289d7f4(activityinstance), var_d018f00fe7ac52a2);
    agent.callbackdamaged = &function_fdcad249ce837eac;
  } else if(isDefined(activityinstance.var_400ddeb71b9dff4a)) {
    agent function_398d3434e12ab1d1(activityinstance.var_400ddeb71b9dff4a);
  } else {
    agent function_65cdab0fc78aba8f(namespace_4fda5d7358015a06::function_8988a4c89289d7f4(activityinstance), var_d018f00fe7ac52a2);
  }

  agent.ob.var_392cd09a100e53d5 = 1;
  agent.ob.warlordtype = activityinstance.varianttag;
  activityinstance activity_participation::function_f0675d4a690011d6(agent);
  activityinstance.agents = utility::array_add(activityinstance.agents, agent);
  agent waittill_any_4("stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush");

  if(activityinstance.varianttag == "WARLORD_CHEMIST") {
    warlordparameters = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46("Chemist");
    function_9a62f2a3e0ef15fa(agent, warlordparameters);
  }

  function_9604283fa66d5066(activityinstance, agent, data.origin);
}

function private function_9a62f2a3e0ef15fa(agent, warlordparameters) {
  if(!isDefined(agent)) {
    return;
  }

  hasgrenade = isDefined(agent.grenadeweapon) && isDefined(agent.grenadeweapon.basename);

  if(hasgrenade && agent.grenadeweapon.basename == "gas_grenade_exgm_chemist") {
    namespace_d3f3cf99d75d3345::function_c17d42c1c9426b4f(agent, warlordparameters);
  }
}

function private function_90598913578a8611(requestid, activityinstance, agent) {
  function_9604283fa66d5066(activityinstance, agent, agent.origin);
}

function private function_9414e16098691766(requestid, activityinstance, agent) {
  function_9604283fa66d5066(activityinstance, agent, agent.origin);
  warlord = activityinstance.warlord_agent;

  if(issubstr(agent.agent_type, "bodyguard") && isDefined(warlord.ob) && isDefined(warlord) && isDefined(warlord.ob.var_2189bfeed28cbb65) && warlord.isactive) {
    agent namespace_87d75ea764a6d2fd::function_b0f5bec38374c8cc(warlord.ob.var_2189bfeed28cbb65);
  }
}

function private function_9604283fa66d5066(activityinstance, agent, var_80125264ad1e9d85) {
  if(issubstr(agent.agent_type, "sniper")) {
    agent setgoalpos(var_80125264ad1e9d85, 120);
    return;
  }

  if(issubstr(agent.agent_type, "rocketeer")) {
    agent setgoalpos(var_80125264ad1e9d85, 120);
    return;
  }

  if(isDefined(activityinstance.var_400ddeb71b9dff4a)) {
    agent setgoalvolumeauto(activityinstance.var_400ddeb71b9dff4a);
  }
}

function private function_f702262ac6bab5ed(agent, warlord, playersearchradius) {
  level endon("game_ended");
  agent endon("death");

  if(!isDefined(warlord)) {
    return;
  }

  closestplayer = function_3c32f942d9c8c310(warlord, playersearchradius);

  if(!isDefined(closestplayer)) {
    return;
  }

  agent setgoalentity(closestplayer);
  agent.goalradius = 512;
}

function private function_3c32f942d9c8c310(agent, playersearchradius) {
  if(!isDefined(agent)) {
    return;
  }

  nearbyplayers = player::getplayersinradius(agent.origin, playersearchradius);
  closestplayers = utility::get_array_of_closest(agent.origin, nearbyplayers);

  if(closestplayers.size > 0) {
    return closestplayers[0];
  }
}

function private function_b78baddc17cc2592(requestid, activityinstance, agent, data) {
  activityinstance.agents = utility::array_add(activityinstance.agents, agent);
  var_72b14bd03dbabac3 = namespace_4c2b495b8d79cc2e::function_5bbdc39a533d9d57(activityinstance, "Awareness_Zone");
  var_d018f00fe7ac52a2 = namespace_4c2b495b8d79cc2e::function_2403f7fe5d40cecc(var_72b14bd03dbabac3[0]);
  agent function_65cdab0fc78aba8f(namespace_4fda5d7358015a06::function_8988a4c89289d7f4(activityinstance), var_d018f00fe7ac52a2);

  if(activityinstance.varianttag == "WARLORD_RAINMAKER") {
    agent thread function_f6c1105658306786();
  }

  if(activityinstance.varianttag == "WARLORD_ALLFORONE") {
    if(!isDefined(activityinstance.warlord_agent.var_cfe1965e9b3580f6)) {
      activityinstance.warlord_agent.var_cfe1965e9b3580f6 = gettime();
    }

    if(activityinstance.warlord_agent.var_cfe1965e9b3580f6 + 1000 < gettime()) {
      activityinstance.warlord_agent thread namespace_dc53a27a8db8e6bf::function_ad4a51e0b0472ebd();
      activityinstance.warlord_agent.var_cfe1965e9b3580f6 = gettime();
    }

    agent.aggressivemode = 1;
    agent.ignoresuppression = 1;
    agent.usestrictreacquiresightshoot = 1;
    agent.cautiousnavigation = 0;
    agent.balwayscoverexposed = 0;
    function_f702262ac6bab5ed(agent, activityinstance.warlord_agent, 1000);
  }
}

function private function_f6c1105658306786() {
  self endon("death");
  wait 20;
  self setgoalvolumeauto(level.artillerytrigger);
  self.aggressivemode = 1;
  level.var_ce26c3aea06b3627[level.var_ce26c3aea06b3627.size] = self;
}

function private function_36b22edbec3478ce(requestid, activityinstance, agent, data) {
  return activityinstance.var_b02230a375a40b26;
}

function private function_d4a7e3d1bed1606c() {
  function_d1f612ac9ad83918();
  self.radiantobjects = array_combine(getStructArray(self.var_184f5484f9868308.target, "targetname"), getentitylessscriptablearray(self.var_184f5484f9868308.target, "targetname"), function_f159c10d5cf8f0b4(self.var_184f5484f9868308.target, "targetname"));
  zone = namespace_4c2b495b8d79cc2e::function_5bbdc39a533d9d57(self, "Proximity_Join_Zone");
  searchradius = namespace_4c2b495b8d79cc2e::function_2403f7fe5d40cecc(zone[0]);
  self.mapdoors = getentitylessscriptablearray(undefined, undefined, self.var_184f5484f9868308.origin, searchradius, "door");
  self.var_1a922b6626c0afa6 = getDvar(@ "hash_e0f1cbb34127441e", "warlord");

  foreach(radiantobject in self.radiantobjects) {
    if(isDefined(radiantobject.script_noteworthy)) {
      switch (radiantobject.script_noteworthy) {
        case #"hash_d35ffa282189588":
          function_dbfc831a765bed05(radiantobject, 1);
          break;
        case #"hash_106df5d1729e996":
          function_dbfc831a765bed05(radiantobject, 0);
          break;
        case #"hash_291b6952be381b6":
          function_4838fdf98c26f014(radiantobject);
          break;
        case #"hash_4428070f2d520b00":
          self.suppression_mines[self.suppression_mines.size] = radiantobject;
          break;
        case #"hash_2242fe24e997a6d9":
          self.trophy_nodes[self.trophy_nodes.size] = radiantobject;
          break;
        case #"hash_5c206a7eaf25a048":
          if(radiantobject.script_parameters == "fortress") {
            self.var_400ddeb71b9dff4a = radiantobject;
          }

          self.goal_volumes[self.goal_volumes.size] = radiantobject;
          break;
        case #"hash_b0ac7b80eaf29c7d":
          function_a2cadb9697f95c6c(radiantobject);
          break;
        case #"hash_433afd693fd45d50":
          self.var_ec082222d3b65a9a[self.var_ec082222d3b65a9a.size] = radiantobject;
          break;
        case #"hash_6ba84a6b3654842a":
          self.laser_tripwires[self.laser_tripwires.size] = radiantobject;
          break;
      }
    }

    if(isDefined(radiantobject.classname)) {
      if(issubstr(radiantobject.classname, "scriptable_blocker")) {
        function_3e2148b8c3d77d9a(radiantobject);
      }

      if(issubstr(radiantobject.classname, "scriptable_ob_toggleable")) {
        function_3e2148b8c3d77d9a(radiantobject);
      }

      if(issubstr(radiantobject.classname, "tripwire")) {
        self.tripwires[self.tripwires.size] = radiantobject;
      }
    }
  }

  function_3d4be0b871f56777();
  function_ecbf61c3f62144d9();
  function_eb6bcc12e631d5c3();
  function_539df65138ab1658();
  function_c0e7edb7e5689007();

  if(getdvarint(@ "hash_c12188e0dd4944e0", 1)) {
    function_e2dbf4d781dcd9b();
  }

  if(getdvarint(@ "hash_1a0fd324434e98b1", 1)) {
    thread function_264adfbf7055e8b4();
  }

  if(getdvarint(@ "hash_c17259bab05fb81e", 1)) {
    thread function_989a82177d3587e3();
  }

  if(getdvarint(@ "hash_14d46405fc41d63a", 1)) {
    thread function_77cf7452f59f93df();
  }

  self.mapdoors = undefined;
}

function function_3d4be0b871f56777() {
  if(isDefined(self.var_184f5484f9868308.script_noteworthy)) {
    var_7f8c8f8cc7f509da = "e_cover_" + self.var_184f5484f9868308.script_noteworthy;
    self.warlord_cover = namespace_17b45e55cf344cda::function_e9158c9e8c391f25(var_7f8c8f8cc7f509da);
  }
}

function function_ecbf61c3f62144d9() {
  self.trigger_volumes = self.centerstruct namespace_6c6964e55ab1bec8::function_a230870ff680af93("warlord_trigger", "targetname");
}

function private function_3e2148b8c3d77d9a(blocker) {
  blocker setscriptablepartstate("state", "visible");
}

function private function_dbfc831a765bed05(doornode, canopen) {
  zone = namespace_4c2b495b8d79cc2e::function_5bbdc39a533d9d57(self, "Proximity_Join_Zone");
  searchradius = namespace_4c2b495b8d79cc2e::function_2403f7fe5d40cecc(zone[0]);
  self.var_ab1e4c965d683006 = namespace_ef96e7c723871c3d::function_c94f363ec8793bc2(self.var_184f5484f9868308.origin, searchradius);
  var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(self);

  if(!isDefined(self.var_be1c48bfab7ccb6)) {
    self.var_be1c48bfab7ccb6 = [];
  }

  var_98fa2809e21ff34f = [];
  var_98fa2809e21ff34f = namespace_9e69d66f68c38a10::function_ad1b6accbaab404e(doornode, var_98fa2809e21ff34f, var_d1c7613187e69022.var_9a002d7b10d97a7d, istrue(canopen), self.var_1a922b6626c0afa6, self.mapdoors);

  if(getdvarint(@ "hash_7b3451672ea3da42", 1) == 0) {
    return;
  }

  foreach(var_aaa3e5affa4753c9 in var_98fa2809e21ff34f) {
    currentdoor = undefined;
    var_8a27b0bf423dfbbc = isDefined(doornode.script_parameters) && doornode.script_parameters == "InvertedLockedDoor";
    var_7584f633a4f1341 = istrue(var_aaa3e5affa4753c9.var_413588fb9a3b4c94);

    if(!istrue(var_7584f633a4f1341)) {
      var_aaa3e5affa4753c9 setscriptablepartstate("door", "invisible");
    }

    if(isDefined(var_aaa3e5affa4753c9.connecteddoor)) {
      if(istrue(var_7584f633a4f1341)) {
        currentdoor = var_aaa3e5affa4753c9;
      } else {
        currentdoor = spawnscriptable("scriptable_door_armory_metal_01", var_aaa3e5affa4753c9.origin, var_aaa3e5affa4753c9.angles);
      }

      if(isDefined(currentdoor)) {
        var_aaa3e5affa4753c9.connecteddoor.var_d0b5210a732916e4 = currentdoor;
        function_8aa310a1da096b43(currentdoor, var_aaa3e5affa4753c9);
        namespace_9e69d66f68c38a10::function_fbbfe6f05eda5eb1(currentdoor);
      } else {
        println("<dev string:x162>" + var_aaa3e5affa4753c9.origin);
      }
    } else if(istrue(var_aaa3e5affa4753c9.doubledoor)) {
      if(istrue(var_7584f633a4f1341)) {
        currentdoor = var_aaa3e5affa4753c9;
        waitframe();
        currentdoor setscriptablepartstate("door", "closed");
        waitframe();
      } else {
        currentdoor = spawnscriptable("scriptable_door_armory_metal_02", var_aaa3e5affa4753c9.origin, var_aaa3e5affa4753c9.angles);
      }

      if(isDefined(currentdoor)) {
        if(isDefined(var_aaa3e5affa4753c9.var_d0b5210a732916e4)) {
          var_aaa3e5affa4753c9.var_d0b5210a732916e4.connecteddoor = currentdoor;
        } else {
          println("<dev string:x1f9>" + var_aaa3e5affa4753c9.origin);
        }

        function_8aa310a1da096b43(currentdoor, var_aaa3e5affa4753c9);

        if(issubstr(currentdoor.classname, "saloon")) {
          var_f34a60219065c89 = 1;
        }

        if(istrue(var_f34a60219065c89)) {
          currentdoor function_9af4c9b2cc1bf989();
        } else {
          currentdoor scriptabledoorfreeze(1);
        }
      }
    } else {
      var_5a6d681c50a11025 = var_8a27b0bf423dfbbc ? "scriptable_door_security_02" : "scriptable_door_security_01";

      if(!istrue(canopen) && isDefined(doornode.script_parameters)) {
        var_5a6d681c50a11025 = doornode.script_parameters;
      }

      currentdoor = spawnscriptable(var_5a6d681c50a11025, var_aaa3e5affa4753c9.origin, var_aaa3e5affa4753c9.angles);

      if(isDefined(currentdoor)) {
        function_8aa310a1da096b43(currentdoor, var_aaa3e5affa4753c9);
        namespace_9e69d66f68c38a10::function_fbbfe6f05eda5eb1(currentdoor);
      }
    }

    if(istrue(canopen)) {
      currentdoor.var_1166203281bb91a5 = "jup_ob_keycard_swipe_unlock_beep";
      currentdoor.var_def557e8fd5c6763 = &function_66d288b89ec18bd2;
      self.var_be1c48bfab7ccb6[self.var_be1c48bfab7ccb6.size] = currentdoor;
    } else {
      currentdoor scriptabledoorfreeze(1);
    }

    currentdoor.warlordactivity = self;
  }

  if(!self.var_24ff739b2eb09591) {
    self.var_24ff739b2eb09591 = 1;
  }
}

function private function_8aa310a1da096b43(newdoor, originaldoor) {
  if(newdoor == originaldoor) {
    return;
  }

  if(istrue(originaldoor.var_67535222a761bdc5)) {
    newdoor.var_67535222a761bdc5 = originaldoor.var_67535222a761bdc5;
    newdoor.keyname = originaldoor.keyname;
    newdoor.var_9ccea499f9e1b693 = originaldoor.var_9ccea499f9e1b693;
    newdoor.node = originaldoor.node;
    newdoor.interiororigin = originaldoor.interiororigin;
    newdoor.outerorigin = originaldoor.outerorigin;

    if(istrue(originaldoor.doubledoor)) {
      newdoor.doubledoor = 1;
    }
  }
}

function private function_539df65138ab1658() {
  if(self.trigger_volumes.size > 0) {
    foreach(vol in self.trigger_volumes) {
      if(vol.script_noteworthy == "navblocker_warlord") {
        refobj = spawnStruct();
        refobj = vol.struct;
      }
    }
  }

  if(isDefined(refobj)) {
    aabb = [];
    maxvalx = refobj.origin[0] + abs(refobj.var_750c4cbbadf7cc32[0]);
    maxvaly = refobj.origin[1] + abs(refobj.var_750c4cbbadf7cc32[1]);
    maxvalz = refobj.origin[2] + abs(refobj.var_750c4cbbadf7cc32[2]);
    aabb["max"] = (maxvalx, maxvaly, maxvalz);
    minvalx = refobj.origin[0] - abs(refobj.var_74e936bbadd15418[0]);
    minvaly = refobj.origin[1] - abs(refobj.var_74e936bbadd15418[1]);
    minvalz = refobj.origin[2] - abs(refobj.var_74e936bbadd15418[2]);
    aabb["min"] = (minvalx, minvaly, minvalz);
    halfsize = (abs(maxvalx - minvalx) / 2, abs(maxvaly - minvaly) / 2, abs(maxvalz - minvalz) / 2);
    center = (aabb["max"][0] - halfsize[0], aabb["max"][1] - halfsize[1], aabb["max"][2] - halfsize[2]);
    self.navobstacle = createnavobstaclebybounds(center, halfsize, refobj.angles);
  }
}

function private function_c0e7edb7e5689007() {
  if(self.trigger_volumes.size > 0) {
    foreach(vol in self.trigger_volumes) {
      if(vol.script_noteworthy == "NoVOBanner_warlord_allforone") {
        self.var_676f150f4c7fc9fa = vol;
        break;
      }
    }
  }
}

function private function_4838fdf98c26f014(barrel) {
  barrel setscriptablepartstate("state", "healthy");
  barrel.navobstacleid = createnavobstaclebybounds(barrel.origin, (16, 16, 45), barrel.angles);
}

function function_61c4487eafc2bc4c(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(istrue(instance.destroyed)) {
    return;
  }

  if(is_equal(instance.type, "barrel_toggleable_red")) {
    thread red_barrel_explosion_monitor(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
    return;
  }

  if(is_equal(instance.type, "jup_ob_inflatable_dummy")) {
    instance thread namespace_c569d26b8efc6f63::function_234f1442e280f1fd(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
    return;
  }

  if(is_equal(instance.type, "equip_claymore_ob")) {
    instance thread namespace_64135de19550f047::function_cd2b3e5bab3edee3(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
  }
}

function private red_barrel_explosion_monitor(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  level endon("game_ended");
  instance notify("red_barrel_explosion_monitor");
  instance endon("red_barrel_explosion_monitor");
  assertex(instance getscriptablehaspart("<dev string:x2a7>"), "<dev string:x2b0>" + instance.origin);
  damagerange = getdvarint(@ "hash_d5bf7c2cfa2963af", 300);
  outerdamage = getdvarint(@ "hash_7e4c624175a9b761", 50);
  innerdamage = getdvarint(@ "hash_8d319c1d79922952", 200);
  finalwaittime = gettime() + 5000;

  while(gettime() < finalwaittime) {
    if(instance getscriptablepartstate("state") == "explode") {
      radiusdamage(instance.origin, damagerange, innerdamage, outerdamage, eattacker, "MOD_EXPLOSIVE", objweapon);
      break;
    }

    waitframe();
  }
}

function private function_d1f612ac9ad83918() {
  if(!isDefined(level.var_e9a6fc11b0aa7eb2)) {
    tripwire::init();
    level.tripwireweaponname = "jup_frag_grenade_ob";

    if(isDefined(level.var_f1bff73a86c35c52)) {
      [[level.var_f1bff73a86c35c52]]();
    }
  }
}

function private function_eb6bcc12e631d5c3() {
  self.tripwires = array_randomize(self.tripwires);
  var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(self);
  self.tripwire_count = default_to(var_d1c7613187e69022.tripwirecount, 5);
  var_303f68b800b31d41 = getentitylessscriptablearray("scriptable_ob_tripwire_wall_pin", "classname");
  frags = getentitylessscriptablearray("scriptable_ob_tripwire_frag", "classname");

  if(self.tripwires.size < self.tripwire_count) {
    self.tripwire_count = self.tripwires.size;
  }

  for(i = 0; i < self.tripwire_count; i++) {
    var_4512f5142b419e2b = [];

    foreach(wallpin in var_303f68b800b31d41) {
      if(self.tripwires[i].target == wallpin.targetname) {
        var_4512f5142b419e2b[var_4512f5142b419e2b.size] = wallpin;
      }
    }

    var_303f68b800b31d41 = array_remove_array(var_303f68b800b31d41, var_4512f5142b419e2b);
    myfrags = [];

    foreach(frag in frags) {
      if(self.tripwires[i].target == frag.targetname) {
        myfrags[myfrags.size] = frag;
      }
    }

    frags = array_remove_array(frags, myfrags);
    targets = array_combine(var_4512f5142b419e2b, myfrags);
    [[level.var_e9a6fc11b0aa7eb2]](self.tripwires[i], "team_hundred_ninety", targets);
    self.tripwires[i].activityinstance = self;
    self.tripwires[i].var_70587812595fd991 = default_to(var_d1c7613187e69022.tripwiregrenadeweapon, undefined);
  }
}

function private function_a2cadb9697f95c6c(scriptable) {
  self.vfx = array_add(self.vfx, scriptable);
  scriptable setscriptablepartstate("state", "visible");
}

function private function_66d288b89ec18bd2(var_67c2ef0a05674606, player) {
  level endon("game_ended");
  warlordactivity = var_67c2ef0a05674606.warlordactivity;
  var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(warlordactivity);
  warlordactivity function_ecb9170931917bd();
  player notify("disguise_state_change", "end_disguise");
  warlordactivity namespace_dc53a27a8db8e6bf::function_d13aa6af7fce67c9(warlordactivity.var_6c29f2fdb0054bbe);
  keylootid = loot::getlootidfromref(warlordactivity function_1404cfa239b8c45a());

  if(isDefined(keylootid)) {
    backpackindex = player common_inventory::function_4776284a348ebb6a(keylootid);
  }

  if(isDefined(backpackindex) && backpackindex != -1) {
    player common_inventory::function_ca3bbb1070436540(backpackindex, 0, 0);
  }
}

function private function_ecb9170931917bd() {
  assertex(self.var_24ff739b2eb09591, "<dev string:x30a>");

  if(isDefined(self.mortar_instances) && istrue(level.var_9171353caa234820)) {
    foreach(mortarinstance in self.mortar_instances) {
      scripts\engine\utility::function_f3bb4f4911a1beb2("team_mortars", "mortar_stop", mortarinstance);
      operator = mortarinstance.operator;

      if(isDefined(operator) && isagent(operator)) {
        operator scripts\engine\utility::function_f3bb4f4911a1beb2("team_mortars", "clear_operator_data");
      }
    }
  }

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
  }

  namespace_ef96e7c723871c3d::function_e05a3fe61be76eed(self.var_ab1e4c965d683006);

  foreach(var_6876372a894fe601 in self.var_be1c48bfab7ccb6) {
    namespace_9e69d66f68c38a10::function_b092780f9ec4496e(var_6876372a894fe601);
  }

  self.var_be1c48bfab7ccb6 = [];
  self.var_24ff739b2eb09591 = 0;
  thread namespace_b3f32c8cb80b8124::function_e73a92bbeb2ae323();
  function_5f8ee230917bcf2f();

  if(!self.warlordenabled) {
    function_4c7fb6ad4120d921();
  }

  self notify("fortress_unlocked");

  if(self.varianttag != "WARLORD_MAESTRO") {
    thread namespace_dc53a27a8db8e6bf::function_53bd256d9112a4e3();
  }
}

function private function_93b355d72bbf87ba() {
  key_spawners = self.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46("warlord_key_spawner", "targetname");

  if(key_spawners.size > 0) {
    foreach(spawner in key_spawners) {
      itemid = "obloot_key_human_fortress_allforone";

      if(isDefined(spawner.script_noteworthy)) {
        itemid = spawner.script_noteworthy;
      }

      namespace_2b1145f62aa835b8::function_38e113a4c30f6c0d(itemid, spawner.origin, spawner.angles, undefined, 1, 0, 1);
      waitframe();
    }
  }
}

function function_8f94c63669b258b() {
  self.sentrystructs = self.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46("sentry", "targetname");
  self endon("activity_ended");
  self.var_70507c40273c3d2c = throttle::throttle_initialize("sentry_health_bar_update", 2);

  if(!isDefined(level.sentrysettings["ai_sentry_turret"])) {
    ai_sentry_turret::init();
  }

  namespace_64135de19550f047::function_64d1082e50f1eed();

  foreach(struct in self.sentrystructs) {
    sentry = namespace_17b45e55cf344cda::function_586d4d82f07e0d09(struct);
    self.sentries = utility::array_add(self.sentries, sentry);
    sentry laseroff();
    activity_participation::function_f0675d4a690011d6(sentry);
    sentry thread function_62ee91c2023c75d2(self);
    sentry thread function_2c6d204530cc7f9d(self);
    waitframe();
  }
}

function function_2c6d204530cc7f9d(activityinstance) {
  self endon("death");
  activityinstance endon("activity_ended");

  while(true) {
    if(isDefined(self.besttarget) && utility::array_contains(level.players, self.besttarget)) {
      if(!utility::array_contains(activityinstance.var_6c29f2fdb0054bbe, self.besttarget)) {
        activity_participation::function_bbdcd857d0c2a65e(activityinstance, self.besttarget, "PlayerJoinedDamage");
      }

      activityinstance notify("player_attacking", self.besttarget);
    }

    wait 1;
  }
}

function private function_1e1e28d0a6731c06(activityinstance) {
  activityinstance endon("activity_ended");
  activityinstance endon("WARLORD_ACTIVITY_HELI_DEAD_NOTIFY");
  level endon("game_ended");
  heli = undefined;

  while(true) {
    if(!isDefined(heli)) {
      player_in_range = function_643b13acbcc4d157();

      if(isDefined(player_in_range)) {
        heli = function_ad3c2d380193c0d6(player_in_range);
        heli.activityinstance = activityinstance;
        heli namespace_c908de38bcdbd93d::function_4782ceab7eadd844(&function_82ad46939b373287);
        heli.var_1d6756d9fe7a5156 = 1;
        wait 10;
      }
    } else if(function_142fcb9939ab6dff()) {
      heli namespace_c908de38bcdbd93d::function_21c899c9bbaf0adc(1);
      heli = undefined;
      wait 10;
    }

    wait 5;
  }
}

function private function_82ad46939b373287(heli, data) {
  if(isDefined(heli.activityinstance)) {
    heli.activityinstance notify("WARLORD_ACTIVITY_HELI_DEAD_NOTIFY");
  }
}

function private function_643b13acbcc4d157() {
  patrolcenter = getStruct("allforone_heli_combat_range", "targetname");

  if(isDefined(patrolcenter)) {
    playersinrange = player::getplayersinradius(patrolcenter.origin, patrolcenter.radius);

    if(playersinrange.size > 0) {
      return playersinrange[randomintrange(0, playersinrange.size)];
    }
  }
}

function private function_142fcb9939ab6dff() {
  if(istrue(self.heli.warlordkilled)) {
    return true;
  }

  patrolcenter = getStruct("allforone_heli_return_patrol_range", "targetname");

  if(isDefined(patrolcenter)) {
    playersinrange = player::getplayersinradius(patrolcenter.origin, patrolcenter.radius);
    return (playersinrange.size == 0);
  }

  return true;
}

function private function_ad3c2d380193c0d6(initial_target) {
  var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(self);
  helipathstart = utility::getStruct(var_d1c7613187e69022.var_37031919bed79345, "targetname");
  var_8fcade05dee813af = getscriptbundle("helicoptersettings:" + var_d1c7613187e69022.helicoptersettings);
  assertex(isDefined(helipathstart), "<dev string:x344>");
  assertex(isDefined(var_8fcade05dee813af), "<dev string:x398>");
  heli = namespace_c908de38bcdbd93d::heli_spawn(helipathstart, 0, 1, var_8fcade05dee813af, &function_900c6f46dec4a691);
  heli.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_helicopter_healthbar");
  heli.var_534e788bc498be9f = getscriptbundle(%"hash_27cb9204e77bbcea");
  heli.subclass = heli.var_534e788bc498be9f.name;
  combatcenter = getStructArray("allforone_heli_combat_range", "targetname");
  patrolcenter = getStructArray("allforone_heli_return_patrol_range", "targetname");
  self.heli = heli;
  heli namespace_dc53a27a8db8e6bf::function_d9c2d13ae0f4fbcb();

  if(isDefined(combatcenter) && combatcenter.size > 0) {
    heli.combat_center = combatcenter[0];
  }

  if(isDefined(patrolcenter) && patrolcenter.size > 0) {
    heli.patrol_center = patrolcenter[0];
  }

  patrol_start = utility::getStruct(helipathstart.target, "targetname");
  var_7578bbf36df02c60 = getscriptbundle("magicturretsettings:hind_turret_settings_warmup_jup_ob");
  heli namespace_c908de38bcdbd93d::function_89891a51d22c497e(var_7578bbf36df02c60);
  heli function_d6eba8149fb949e9(initial_target.origin + (0, 0, 1000) + vectorNormalize(heli.origin - initial_target.origin) * 5000, 1, 0, 0, undefined, undefined, 70);
  var_4db1bca04bf972a1 = getscriptbundle("magicturretsettings:hind_turret_settings_jup_ob");
  heli namespace_c908de38bcdbd93d::function_89891a51d22c497e(var_4db1bca04bf972a1);
  heli thread namespace_c908de38bcdbd93d::behavior_combat(initial_target, &function_900c6f46dec4a691, 1);
  return heli;
}

function private function_900c6f46dec4a691(heli) {
  var_79be769e862eb002 = utility::ter_op(isDefined(heli.combat_center) && isDefined(heli.combat_center.origin), heli.combat_center.origin, heli.origin);
  playersearchradius = utility::ter_op(isDefined(heli.combat_center) && isDefined(heli.combat_center.radius), heli.combat_center.radius, heli.var_e309f77b84ade0d9);
  players = player::getplayersinradius(var_79be769e862eb002, playersearchradius);
  players = array_randomize(players);

  foreach(player in players) {
    if(isDefined(player) && !isinlaststand(player) && heli namespace_c908de38bcdbd93d::function_618e0f50b9b8b310(player, 1)) {
      if(!istrue(heli.warlordkilled)) {
        heli namespace_dc53a27a8db8e6bf::function_1bfced88fed9a20b();
      }

      return player;
    }

    wait 1;
  }
}

function private function_f6497e3d84e6a305(heli) {
  var_79be769e862eb002 = utility::ter_op(isDefined(heli.patrol_center) && isDefined(heli.patrol_center.origin), heli.patrol_center.origin, heli.origin);
  playersearchradius = utility::ter_op(isDefined(heli.patrol_center) && isDefined(heli.patrol_center.radius), heli.patrol_center.radius, heli.var_e309f77b84ade0d9);
  players = player::getplayersinradius(var_79be769e862eb002, playersearchradius);
  return players.size == 0;
}

function private function_7550473fbe4c5f8d() {
  level endon("game_ended");
  self endon("activity_ended");

  if(isDefined(level.var_96a00a6fce3851c3)) {
    [[level.var_96a00a6fce3851c3]]();
  }

  if(istrue(level.var_9171353caa234820)) {
    if(!isDefined(self.mortar_instances)) {
      self.mortar_instances = [];
    }

    self.mortar_structs = self.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46("warlord_mortar_area", "targetname");

    foreach(mortarstruct in self.mortar_structs) {
      mortarstruct thread scripts\engine\utility::function_f3bb4f4911a1beb2("team_mortars", "area_think", self);
    }
  }
}

function function_6997cf73d6a2c9a4() {
  level endon("game_ended");
  self endon("activity_ended");
  self.minestructs = self.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46("warlord_mine_spawner", "targetname");

  while(self.agents.size == 0) {
    waitframe();
  }

  foreach(minestruct in self.minestructs) {
    badplace_id = "bp_" + self.centerstruct.script_noteworthy + "_mine" + self.var_b293aa98b3af028f.size;
    var_e5194a01f6efb3c4 = function_243a68aff426d3f7(self, minestruct.origin);

    if(isDefined(var_e5194a01f6efb3c4)) {
      var_23063b5f7f0755ee = namespace_17b45e55cf344cda::function_908ec13fb4d6cede(minestruct.origin, badplace_id, var_e5194a01f6efb3c4, undefined, minestruct.angles, 1);
      var_23063b5f7f0755ee.allowfriendlyfire = 1;

      if(getdvarint(@ "hash_fc60b06adb1fca92", 0)) {
        childthread function_8a71f4e1d200ccd0(var_23063b5f7f0755ee);
      }

      self.var_b293aa98b3af028f = utility::array_add(self.var_b293aa98b3af028f, var_23063b5f7f0755ee);
      thread function_410c31fa869b0858(var_e5194a01f6efb3c4, var_23063b5f7f0755ee);
    } else {
      assertmsg("<dev string:x3fc>" + minestruct.origin);
    }

    waitframe();
  }
}

function function_410c31fa869b0858(agent, claymore) {
  level endon("game_ended");
  self endon("activity_ended");
  claymore endon("trigger_grenade");
  claymore endon("mine_triggered");
  claymore endon("death");
  agent waittill("death", killer);

  while(true) {
    var_e5194a01f6efb3c4 = function_243a68aff426d3f7(self, claymore.origin, agent);

    if(isDefined(var_e5194a01f6efb3c4)) {
      claymore.owner = var_e5194a01f6efb3c4;
      thread function_410c31fa869b0858(var_e5194a01f6efb3c4, claymore);
      return;
    }

    wait 0.5;
  }
}

function function_243a68aff426d3f7(activityinstance, var_62434b927ee2f21a, var_fa5c99d7340916d5) {
  if(isDefined(activityinstance) && isDefined(activityinstance.agents) && activityinstance.agents.size > 0) {
    var_c3aa714a81ce8865 = sortbydistance(activityinstance.agents, var_62434b927ee2f21a);

    foreach(var_b42f126d1a0a7bb0 in var_c3aa714a81ce8865) {
      if(isDefined(var_b42f126d1a0a7bb0) && isagent(var_b42f126d1a0a7bb0) && isalive(var_b42f126d1a0a7bb0) && (!isDefined(var_fa5c99d7340916d5) || var_b42f126d1a0a7bb0 != var_fa5c99d7340916d5)) {
        return var_b42f126d1a0a7bb0;
      }
    }
  }

  radiussquared = getdvarint(@ "hash_303a1bdec0ead5a8", 2000);

  if(function_a794fcf9545f2062()) {
    nearbyai = function_b1eef70090b5b7b5(var_62434b927ee2f21a, radiussquared, function_869ccb4e3451b8c6(["etype_ai"]), [], "team_hundred_ninety");
  } else {
    nearbyai = getaiarrayinradius(var_62434b927ee2f21a, radiussquared, "team_hundred_ninety");
  }

  var_b3d2c590b879f78d = sortbydistance(nearbyai, var_62434b927ee2f21a);

  if(!isDefined(var_b3d2c590b879f78d) || var_b3d2c590b879f78d.size == 0) {
    return undefined;
  }

  foreach(agent in var_b3d2c590b879f78d) {
    if(!isDefined(agent) || !isagent(agent) || !isalive(agent) || isDefined(var_fa5c99d7340916d5) && var_b42f126d1a0a7bb0 == var_fa5c99d7340916d5) {
      continue;
    }

    return agent;
  }

  return undefined;
}

function function_62ee91c2023c75d2(activityinstance) {
  activityinstance endon("activity_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_417b2b7d8ec44514 = 0;

  while(true) {
    self waittill("damage", amount, attacker);

    if(utility::array_contains(level.players, attacker)) {
      activityinstance notify("player_attacking", attacker);

      if(var_417b2b7d8ec44514 == 0) {
        params = spawnStruct();
        params.warlord_name = self.varianttag;
        attacker callback::callback("warlord_damaged", params);
        var_417b2b7d8ec44514 = 1;
      }
    }

    wait 1;
  }
}

function function_264adfbf7055e8b4() {
  level endon("game_ended");
  self endon("activity_ended");

  while(self.agents.size == 0) {
    waitframe();
  }

  foreach(minestruct in self.suppression_mines) {
    throwvelocity = anglestoup(minestruct.angles) * -100;
    suppression_mine = magicgrenademanual("sound_veil_mp", minestruct.origin, throwvelocity);
    suppression_mine.team = "team_hundred_ninety";
    suppression_mine.owner = suppression_mine;
    suppression_mine.ignoretimeout = 1;
    suppression_mine.var_fff21a869f9fa687 = 1;
    self.agents[0] thread namespace_ade096b4b575e46c::function_7b988e1bb56ca747(suppression_mine);
  }
}

function function_e2dbf4d781dcd9b() {
  level endon("game_ended");
  self endon("activity_ended");

  if(!isDefined(level.trophy) || !isDefined(level.trophy.tags)) {
    scripts\cp_mp\equipment\scripted_trophy::trophy_init();
  }

  foreach(trophystruct in self.trophy_nodes) {
    scripts\cp_mp\equipment\scripted_trophy::trophy_create(trophystruct, 1, 100, undefined, "team_hundred_ninety");
    waitframe();
  }
}

function private function_989a82177d3587e3() {
  level endon("game_ended");
  self endon("activity_ended");
  self waittill("fortress_unlocked");
  scripts\engine\scriptable::scriptable_addnotifycallback("afo_dummy_destroyed", &function_47670cf75afc9359);

  foreach(decoynode in self.var_ec082222d3b65a9a) {
    function_70a82e2de870327d(decoynode);
  }
}

function private function_77cf7452f59f93df() {
  level endon("game_ended");
  self endon("activity_ended");
  self waittill("player_joined");

  if(self.laser_tripwires.size == 0) {
    var_7adcf39d92d1dae = self.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46("warlord_laser", "targetname");

    foreach(var_f9eaae33f2ebcf7c in var_7adcf39d92d1dae) {
      self.laser_tripwires[self.laser_tripwires.size] = var_f9eaae33f2ebcf7c namespace_c7c8e97cfcdfb1e1::create_laser_trap();
    }
  }

  if(self.laser_tripwires.size > 0) {
    namespace_c7c8e97cfcdfb1e1::init(self.laser_tripwires, self);
  }
}

function private function_47670cf75afc9359(instance, note, param, var_535d9c3fdddab5a9) {
  instance notify("afo_dummy_destroyed");
}

function function_862ec3b2476d1b25() {
  veh_spawners = self.centerstruct namespace_6c6964e55ab1bec8::function_954eb52ab4cdeb46("warlord_vehicle_spawner", "targetname");

  if(veh_spawners.size > 0) {
    foreach(spawner in veh_spawners) {
      spawn_type = "veh_jup_suv_1996";

      if(isDefined(spawner.script_noteworthy)) {
        spawn_type = spawner.script_noteworthy;
      }

      spawn_data = spawnStruct();
      spawn_data.origin = getgroundposition(spawner.origin, 64, 256) + (0, 0, 128);
      spawn_data.angles = spawner.angles;
      spawn_data.var_699ac4a9c9e9f0ec = 1;
      spawn_data.var_24993ee24f7c7c0 = 1;
      vehicle = vehicle::vehicle_spawn(spawn_type, spawn_data);

      if(isDefined(vehicle)) {
        self.vehicles = utility::array_add(self.vehicles, vehicle);
      }

      waitframe();
    }
  }
}

function private function_70a82e2de870327d(scriptstruct) {
  triggers = undefined;

  if(isDefined(scriptstruct.target)) {
    triggers = function_f159c10d5cf8f0b4(scriptstruct.target, "targetname");
  }

  dummyposition = scriptstruct.origin;
  var_8d0f45d41889833f = scriptstruct.angles;
  var_9d3481ce8c723f5d = 150;
  var_1bf3d502bc0ffdc0 = 0;
  var_54a5151b32a865e8 = 0.5;
  var_65373cd353370c96 = 3;
  var_f03196013d5cd011 = spawnStruct();
  var_f03196013d5cd011.angles = scriptstruct.angles;
  var_f03196013d5cd011.position = scriptstruct.origin;
  var_f03196013d5cd011.health = var_9d3481ce8c723f5d;
  var_f03196013d5cd011.team = "team_hundred_ninety";
  var_f03196013d5cd011.activity = self;

  if(isDefined(triggers)) {
    thread namespace_3fa2391f9077d907::function_841c25eb1c7438b(var_f03196013d5cd011, triggers);
    return;
  }

  thread namespace_3fa2391f9077d907::function_6c904abfe5e38110(var_f03196013d5cd011);
}

function function_fdcad249ce837eac(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(eattacker) && istrue(eattacker.var_eb504fc7e1cfeb4c) && self.team == eattacker.team && smeansofdeath == "MOD_EXPLOSIVE") {
    idamage *= clamp(1 - getdvarfloat(@ "hash_ed046e2c9070b1de", 0), 0, 1);
  }

  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_aed7a5e07b895fa(var_2d9552508615d396, tripwire) {
  if(isDefined(tripwire.activityinstance) && isDefined(tripwire.var_70587812595fd991)) {
    if(tripwire.var_70587812595fd991 == "gas_grenade_exgm_chemist_tripwire") {
      var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(tripwire.activityinstance);

      if(isDefined(var_d1c7613187e69022) && isDefined(level.var_381f13069ba0b5d4)) {
        [[level.var_381f13069ba0b5d4]](var_2d9552508615d396.origin, tripwire.activityinstance.warlord_agent, "team_hundred_ninety", var_d1c7613187e69022.var_99bab916c06a776f, var_d1c7613187e69022.var_49b3f2d037b27309, 0, "scr_warlord_chemist_grenade_tripwire", var_d1c7613187e69022.var_d8f7e0d3f8827fca, 4);
      }

      return;
    } else if(tripwire.var_70587812595fd991 == "thermobaric_grenade_jup_mp") {
      var_d1c7613187e69022 = namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(tripwire.activityinstance);

      if(isDefined(var_d1c7613187e69022)) {
        var_e6c6c445ebccdb46 = spawnStruct();
        var_e6c6c445ebccdb46.weapon_name = "thermobaric_grenade_jup_mp";
        scripts\cp_mp\equipment\thermobaric_grenade::function_a4cf6140ad44312c(var_e6c6c445ebccdb46);
        fakegrenade = makeweapon("thermobaric_grenade_jup_mp");
        explosionradius = getgrenadedamageradius(fakegrenade);
        players = player::getplayersinradius(tripwire.origin, explosionradius);

        if(players.size > 0) {
          foreach(player in players) {
            data = spawnStruct();
            data.meansofdeath = "MOD_FIRE";
            data.victim = player;
            data.attacker = tripwire.activityinstance.warlord_agent;
            data.objweapon = fakegrenade;
            data.inflictor = tripwire;
            data.point = tripwire.origin;
            player scripts\cp_mp\equipment\thermobaric_grenade::onplayerdamaged(data);
          }
        }

        tripwire.team = "team_hundred_ninety";
        tableinfo = scripts\common\values::getequipmenttableinfo("equip_thermobaric_grenade");
        bundle = tableinfo.bundle;
        scripts\cp_mp\equipment\thermobaric_grenade::function_90a9e9f5e4922a2a(tripwire.origin, tripwire.angles, "thermobaric_grenade_jup_mp", "team_hundred_ninety", bundle, 0);
      }

      return;
    }
  }

  scripts\cp_mp\tripwire::function_5edfa6cc73a7922d(tripwire);
}

function private function_d925580cdefd8594() {
  level endon("game_ended");
  var_236c7d2f9df60974 = self.var_6c29f2fdb0054bbe;
  var_468b14d2ee56214d = function_261dedb8a2ab915d();
  var_58e219427c5fe7f0 = [];

  foreach(player in var_236c7d2f9df60974) {
    if(!isDefined(player) || array_contains(var_58e219427c5fe7f0, player)) {
      continue;
    }

    if(namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078) || getdvarint(@ "hash_7b8b09c504a0c9a0", 0)) {
      squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

      foreach(squadmember in squadmembers) {
        var_58e219427c5fe7f0[var_58e219427c5fe7f0.size] = squadmember;
      }
    }
  }

  var_5e1310bbe1f90b35 = [];

  foreach(player in var_236c7d2f9df60974) {
    if(!isDefined(player) || array_contains(var_58e219427c5fe7f0, player)) {
      continue;
    }

    var_5e1310bbe1f90b35[var_5e1310bbe1f90b35.size] = player;
  }

  var_745b4e28cd79834e = namespace_dc53a27a8db8e6bf::function_bf1a19db888d229f(var_5e1310bbe1f90b35);

  if(istrue(var_745b4e28cd79834e)) {
    waitseconds = getdvarint(@ "hash_e5ad89ea7f242a75", 1);
    wait waitseconds;
  }

  namespace_277c27ef297ef569::function_1281c7fff9456e18("warlord_success", var_468b14d2ee56214d);
  wait 5;
  namespace_dc53a27a8db8e6bf::function_65175e987bbfc6f8(var_468b14d2ee56214d);
  namespace_4fda5d7358015a06::endactivity(self, 1);
}

function private function_ff58fdabe59872b2(var_6f8af5eb76deac21) {
  instid = function_f0f498aed6f8fa5d(self);
  activitytype = namespace_4fda5d7358015a06::function_de53ed8e35d0ed7a(self);

  if(isDefined(activitytype) && activitytype == "REV_OB_WARLORD") {
    level.activities.warlordinstances[instid] = self;
  }
}

function private function_57ddbeb9a1cc605e(var_6f8af5eb76deac21) {
  uniqueid = function_f0f498aed6f8fa5d(self);
  activitytype = namespace_4fda5d7358015a06::function_de53ed8e35d0ed7a(self);

  if(isDefined(activitytype) && activitytype == "REV_OB_WARLORD") {
    level.activities.warlordinstances[uniqueid] = undefined;
  }
}

function private function_f13be2fe056ab5a() {
  var_f29480668da18e7a = [];

  if(isDefined(level.activities.warlordinstances)) {
    foreach(instance in level.activities.warlordinstances) {
      if(!isDefined(instance)) {
        continue;
      }

      activitystate = namespace_4fda5d7358015a06::function_73bd348a2ec322cf(instance);

      if(!isDefined(activitystate) || !(activitystate == "IdleState" || activitystate == "ActiveState")) {
        continue;
      }

      assert(namespace_4fda5d7358015a06::function_de53ed8e35d0ed7a(instance) == "<dev string:x437>");
      var_f29480668da18e7a[var_f29480668da18e7a.size] = instance;
    }
  }

  return var_f29480668da18e7a;
}

function private function_6ce86afa6684b8eb(var_d6bfa53c531546d6) {
  player = var_d6bfa53c531546d6.player;
  var_a917328b0b1b2a19 = var_d6bfa53c531546d6.enteredzone;

  if(isDefined(player) && istrue(var_a917328b0b1b2a19) && istrue(self.var_24ff739b2eb09591) && isDefined(self.var_d1c7613187e69022) && isDefined(self.var_d1c7613187e69022.var_9a002d7b10d97a7d)) {
    squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers(player.team, 1);

    if(isDefined(squad) && isarray(squad) && squad.size > 0 && !namespace_9718b9a169c3ead0::function_1abf09c903e6c16b(squad, function_1404cfa239b8c45a()) && !namespace_838b439602b3acc7::function_5acc35fc66331385(player, 17078)) {
      namespace_dc53a27a8db8e6bf::function_49a282654ffb7685(squad);
    }
  }
}

function private function_1404cfa239b8c45a() {
  if(isDefined(self.var_d1c7613187e69022) && isDefined(self.var_d1c7613187e69022.var_9a002d7b10d97a7d)) {
    return ("loot_key_" + self.var_d1c7613187e69022.var_9a002d7b10d97a7d);
  }

  return undefined;
}

function private function_a81c6611776ea959(var_e33aa6ec4a9e8de9) {
  var_3d7c908c7166d6a9 = var_e33aa6ec4a9e8de9.withinradius;
  player = var_e33aa6ec4a9e8de9.player;

  if(isDefined(self) && isDefined(self.varianttag) && self.varianttag == "WARLORD_ALLFORONE") {
    if(var_3d7c908c7166d6a9) {
      return (isDefined(player) && !function_f0fc36a4010a833(player.origin));
    } else {
      return 0;
    }

    return;
  }

  return var_3d7c908c7166d6a9;
}

function private function_f0fc36a4010a833(point) {
  return isDefined(point) && isDefined(self.var_676f150f4c7fc9fa) && ispointinvolume(point, self.var_676f150f4c7fc9fa);
}

function private function_c638fba4eade0ac3() {
  devgui::function_6e7290c8ee4f558b("<dev string:x449>");
  devgui::function_b2159fbbd7ac094e("<dev string:x464>", @ "hash_465e351e0dbf9dc");
  devgui::function_fe953f000498048f();
  devgui::function_6e7290c8ee4f558b("<dev string:x477>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x4a4>", "<dev string:x4b3>", &function_7e9147a046f3c383);
  devgui::function_b23a59dfb4ca49a1("<dev string:x4dc>", "<dev string:x4e7>", &function_7e9147a046f3c383);
  devgui::function_b23a59dfb4ca49a1("<dev string:x50c>", "<dev string:x517>", &function_7e9147a046f3c383);
  devgui::function_b23a59dfb4ca49a1("<dev string:x53c>", "<dev string:x549>", &function_7e9147a046f3c383);
  devgui::function_fe953f000498048f();
}

function private function_7e9147a046f3c383(params) {
  activitydefinition = undefined;

  switch (params[0]) {
    case #"hash_e48274df9a633c0b":
      activitydefinition = getscriptbundle(%"hash_18ab94080543a9b");
      break;
    case #"hash_4d25f397e1684a18":
      activitydefinition = getscriptbundle(%"hash_3cec25ea8162f108");
      break;
    case #"hash_4a435a29eef2af26":
      activitydefinition = getscriptbundle(%"hash_7abfa82092752176");
      break;
    case #"hash_41390110c3a2bde9":
      activitydefinition = getscriptbundle(%"hash_7d4d9cf51a069859");
      break;
  }

  if(!isDefined(activitydefinition)) {
    assertmsg("<dev string:x5a2>" + params[0]);
    return;
  }

  var_d13c18af4084bdfd = {
    #activity_instance: {
      #var_d1c7613187e69022: namespace_3485b020a23acaae::function_b9c4aa88ad97ee68(activitydefinition)
    }
  };
  common_cache::function_7029bab8ebd74e1d(function_b4364b16b16b0c60(var_d13c18af4084bdfd));
  common_cache::function_803e6cfa13174264();
}

function private function_4e27bde5c4ab78e2() {
  while(true) {
    if(getdvarint(@ "hash_465e351e0dbf9dc", 0) && istrue(self.var_24ff739b2eb09591)) {
      function_ecb9170931917bd();
    }

    wait 5;
  }
}

function private function_8a71f4e1d200ccd0(var_990f9e7267153a46) {
  var_990f9e7267153a46 endon("<dev string:x5e1>");
  var_990f9e7267153a46 endon("<dev string:x5f4>");
  var_990f9e7267153a46 endon("<dev string:x606>");
  waitframe();

  while(true) {
    if(isDefined(var_990f9e7267153a46)) {
      if(isDefined(var_990f9e7267153a46.owner)) {
        level thread scripts\mp\utility\debug::drawsphere(var_990f9e7267153a46.owner.origin, 64, 0.5, (0, 1, 0));
        level thread scripts\mp\utility\debug::drawline(var_990f9e7267153a46.owner.origin, var_990f9e7267153a46.origin, 0.5, (0, 1, 0));
      } else {
        level thread scripts\mp\utility\debug::drawsphere(var_990f9e7267153a46.owner.origin, 32, 0.5, (1, 0, 0));
      }
    } else {
      level thread scripts\mp\utility\debug::drawsphere(var_990f9e7267153a46.owner.origin, 32, 5, (0, 0, 1));
      println("<dev string:x60f>");
      return;
    }

    wait 0.5;
  }
}

function private function_a7bac03ceca2c973() {
  ammo_mods = ["brainrot", "deadwire", "napalmburst", "cryofreeze", "shatterblast"];
  self.platecarrierlevel = 3;
  self.maxarmorhealth = self.platecarrierlevel * level.var_4b78859bacc88808;
  waitframe();
  scripts\cp_mp\armor::setarmorhealth(self.maxarmorhealth);
  waitframe();
  scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(3);
  waitframe();
  scripts\cp_mp\laststand::function_188085b8b8d431f2(1);
  waitframe();
  a_weapons = self getweaponslist("primary");

  foreach(weapon in a_weapons) {
    self takeweapon(weapon);
  }

  waitframe();
  fakeitem = spawnStruct();
  var_d7732d0238eae9ff = 50;
  item_entry = "ob_jup_item_weapon_ar_acharlie_blue";
  item_bundle = getscriptbundle("itemspawnentry:" + item_entry);
  item_scriptable = item_bundle.scriptable;
  fakeitem.count = scripts\cp_mp\loot\common_item::function_7209c8cd4b2e3afd(var_d7732d0238eae9ff);
  scripts\cp_mp\loot\common_item::function_7f6f62ba8dfd0da0(item_bundle, fakeitem);
  fakeitem = spawnStruct();
  var_d7732d0238eae9ff = 50;
  item_entry = "ob_jup_item_weapon_sm_coscar635_blue";
  item_bundle = getscriptbundle("itemspawnentry:" + item_entry);
  item_scriptable = item_bundle.scriptable;
  fakeitem.count = scripts\cp_mp\loot\common_item::function_7209c8cd4b2e3afd(var_d7732d0238eae9ff);
  scripts\cp_mp\loot\common_item::function_7f6f62ba8dfd0da0(item_bundle, fakeitem);
  wait 0.5;
  a_weapons = self getweaponslist("primary");

  for(i = 0; i < 3; i++) {
    currentweapon = a_weapons[i];

    if(scripts\cp_mp\pack_a_punch::can_pap(currentweapon)) {
      var_5476695cf42091ed = scripts\cp_mp\pack_a_punch::get_pap_level(currentweapon);
      scripts\cp_mp\pack_a_punch::pap_weapon(currentweapon, var_5476695cf42091ed);
    }

    waitframe();
    var_4bc27b790622bd85 = randomint(ammo_mods.size);
    namespace_dc2e59577d3a271f::function_6c40f58b29a952a9(a_weapons[i], ammo_mods[var_4bc27b790622bd85]);
  }

  waitframe();
  scripts\cp_mp\zombie_perks::give_perk("specialty_juggernog", 0);
  scripts\cp_mp\zombie_perks::give_perk("specialty_speedcola", 0);
  scripts\cp_mp\zombie_perks::give_perk("specialty_death_perception", 0);
  scripts\cp_mp\zombie_perks::give_perk("specialty_tombstone", 0);
}

function function_6fbbd049f160f136() {
  self endon("activity_ended");
  self endon("game_ended");

  if(self.varianttag == "WARLORD_CHEMIST") {
    cache_scriptkey = "activity_warlord_chemist";
    variantmin = 3;
    variantmax = 4;
  } else if(self.varianttag == "WARLORD_MAESTRO") {
    cache_scriptkey = "activity_warlord_maestro";
    variantmin = 8;
    variantmax = 8;
  } else {
    cache_scriptkey = "activity_warlord";
    variantmin = 3;
    variantmax = 4;
  }

  cache_structs = self.centerstruct function_954eb52ab4cdeb46("s_warlord_cache", "targetname");
  var_c861c692ff9761d8 = int(min(cache_structs.size, variantmin));
  var_1333f42d9fc03d92 = int(min(cache_structs.size, variantmax));

  if(cache_structs.size > 0) {
    if(cache_structs.size > 1) {
      if(var_1333f42d9fc03d92 > var_c861c692ff9761d8) {
        n_caches = randomintrange(var_c861c692ff9761d8, var_1333f42d9fc03d92);
      } else {
        n_caches = var_c861c692ff9761d8;
      }

      structs_random = array_randomize(cache_structs);
      var_a3ed1b4a55e2a2c8 = array_slice(structs_random, 0, n_caches);
    } else {
      var_a3ed1b4a55e2a2c8 = cache_structs;
    }

    foreach(struct in var_a3ed1b4a55e2a2c8) {
      var_15bcd5035937f3bd = getgroundposition(struct.origin, 32);
      warlord_cache = common_cache::cache_spawncache(cache_scriptkey, var_15bcd5035937f3bd, struct.angles);

      while(!isDefined(warlord_cache)) {
        waitframe();
      }

      warlord_cache setscriptablepartstate("body", "closed_usable");
      self.var_23b910077b8047db = array_add(self.var_23b910077b8047db, warlord_cache);
    }
  }
}
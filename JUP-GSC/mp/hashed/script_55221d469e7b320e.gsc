/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_55221d469e7b320e.gsc
*************************************************/

#using script_41387eecc35b88bf;
#using script_443d99fe707f1d9f;
#using script_485622d93fa7e4cf;
#using script_55221d469e7b320e;
#using script_6f65366f542f6627;
#using script_749ff6f56673a813;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\pmc_missions;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace namespace_e809fb16a76c99a;

function function_751a7af62e6ae0c7() {
  callback::add("quest_exfil_spawned", &function_efb50a1f9ede7de7);
  callback::add("quest_exfil_complete", &function_202616c69c9f30c0);
  callback::add("player_spawned", &on_player_spawned);
  level.var_4dc2d161649b3568 = &function_11bcd4711058b7d3;
  level.var_41e730a6eb28dcca = &"JUP_OB_OBJECTIVES/QUEST_0_EXFIL_ACT1";
  level.var_2b4ea776b3e4b973 = &"JUP_OB_OBJECTIVES/QUEST_0_EXFIL_ACT2";
  level.var_baa6228c15af450c = &"JUP_OB_OBJECTIVES/QUEST_0_EXFIL_ACT3";
  level flag_wait("exfil_initialized");
  level.var_9ec4962076db301b = [];
  level.var_9ec4962076db301b["exfil_destinations"] = [];
  a_destinations = getStructArray("content_destination", "variantname");

  foreach(destination in a_destinations) {
    if(is_equal(destination.script_noteworthy, "quest_destination")) {
      level.var_9ec4962076db301b["exfil_destinations"] = array_add(level.var_9ec4962076db301b["exfil_destinations"], destination);
    }
  }

  function_7b7ef7b297577097();
  level thread function_3588066237370357();
  level flag_set("quest_exfil_initialized");
}

function on_player_spawned(params) {
  level flag_wait("quest_exfil_initialized");

  if(getdvarint(@ "hash_bb56255b931f8adb", 0)) {
    namespace_bbc151ced3ff8d46::function_689512f156cb5a4a(self, "s0_act1");
    namespace_bbc151ced3ff8d46::function_689512f156cb5a4a(self, "s0_act2");
    namespace_bbc151ced3ff8d46::function_689512f156cb5a4a(self, "s0_act3");
  }

  if(namespace_9571f642f38c8169::function_3bb8b73991355a1(2) || getdvarint(@ "hash_7672e037953e3ff2", 0)) {
    if(!getdvarint(@ "hash_8a2c3d4f98cab77e", 0)) {
      namespace_bbc151ced3ff8d46::function_689512f156cb5a4a(self, "s0_act1");
    }
  }

  if(namespace_9571f642f38c8169::function_3bb8b73991355a1(4) || getdvarint(@ "hash_cbbe6eb889d15db1", 0)) {
    if(!getdvarint(@ "hash_2dd1fe433bb4044f", 0)) {
      namespace_bbc151ced3ff8d46::function_689512f156cb5a4a(self, "s0_act2");
    }
  }

  if(namespace_9571f642f38c8169::function_3bb8b73991355a1(6) || getdvarint(@ "hash_9f96ef962ff292e4", 0)) {
    if(!getdvarint(@ "hash_964dfa8da1d550f4", 0)) {
      namespace_bbc151ced3ff8d46::function_689512f156cb5a4a(self, "s0_act3");
    }
  }
}

function function_7b7ef7b297577097() {
  level.var_9ec4962076db301b["general_info"] = spawnStruct();
  level.var_9ec4962076db301b["general_info"].eligible_players = [];
  level.var_9ec4962076db301b["general_info"].var_f6e64573c4a3a4be = [];
  level.var_9ec4962076db301b["s0_act1"] = spawnStruct();
  level.var_9ec4962076db301b["s0_act1"].name = "s0_act1";
  level.var_9ec4962076db301b["s0_act1"].eligible_players = [];
  level.var_9ec4962076db301b["s0_act2"] = spawnStruct();
  level.var_9ec4962076db301b["s0_act2"].name = "s0_act2";
  level.var_9ec4962076db301b["s0_act2"].eligible_players = [];
  level.var_9ec4962076db301b["s0_act3"] = spawnStruct();
  level.var_9ec4962076db301b["s0_act3"].name = "s0_act3";
  level.var_9ec4962076db301b["s0_act3"].eligible_players = [];
}

function function_689512f156cb5a4a(player, mission_name) {
  if(!isDefined(level.var_9ec4962076db301b[mission_name]) || !isDefined(player)) {
    return;
  }

  level.var_9ec4962076db301b[mission_name].eligible_players[level.var_9ec4962076db301b[mission_name].eligible_players.size] = player;
  level.var_9ec4962076db301b["general_info"].eligible_players[level.var_9ec4962076db301b["general_info"].eligible_players.size] = player;
  player.var_9043213f45d750a4 = mission_name;
  function_6a3d3280a1913f27(player);
}

function function_587db41e9361a424(player, mission_name) {
  if(!isPlayer(player)) {
    return;
  }

  if(isDefined(mission_name)) {
    if(isDefined(level.var_9ec4962076db301b[mission_name]) && array_contains(level.var_9ec4962076db301b[mission_name].eligible_players, player)) {
      return 1;
    }
  } else if(array_contains(level.var_9ec4962076db301b["general_info"].eligible_players, player)) {
    return 1;
  }

  return 0;
}

function function_f4506108332ff64b(player) {
  var_fc92e63a56e600d2 = [];
}

function function_3588066237370357() {
  level flag_wait("quest_exfil_initialized");
  var_b9fd6576745cea1 = array_randomize(level.var_9ec4962076db301b["exfil_destinations"]);
  var_601a910f45d75832 = var_b9fd6576745cea1;
  var_b9fd6576745cea1 = [];

  foreach(exfil_destination in var_601a910f45d75832) {
    if(isDefined(level.aether_storm) && isvector(level.aether_storm.starting_origin) && isDefined(level.aether_storm.starting_radius)) {
      distancesquared = distance2dsquared(level.aether_storm.starting_origin, exfil_destination.origin);
      testdistancesquared = squared(max(level.aether_storm.starting_radius, 0));

      if(distancesquared <= testdistancesquared) {
        continue;
      }

      var_b9fd6576745cea1[var_b9fd6576745cea1.size] = exfil_destination;
    }
  }

  var_d08f3ac86be7ae9e = [];

  for(i = 0; i < 3; i++) {
    if(isDefined(var_b9fd6576745cea1[i])) {
      level thread namespace_9f6a961447bab709::function_cb80f3df972cd7d4(var_b9fd6576745cea1[i]);
    }
  }

  foreach(s_exfil in level.var_2562ea48235e90b5) {
    if(namespace_9f6a961447bab709::function_4027f5445bb7c8fb(s_exfil) && !isDefined(s_exfil.var_d182b8d3f3aaa93b)) {
      var_d08f3ac86be7ae9e[var_d08f3ac86be7ae9e.size] = s_exfil;
    }
  }

  for(i = 0; i < var_d08f3ac86be7ae9e.size; i++) {
    mission_name = function_1cbe81bf66185af4(i);

    if(is_equal(mission_name, "s0_act2")) {
      var_d08f3ac86be7ae9e[i].var_35d53d54bebe2864 = 1;
      var_d08f3ac86be7ae9e[i].var_1defa642cf137bd = 1;
      var_d08f3ac86be7ae9e[i].var_4e8463d4b66778dc = 1;
    }

    var_d08f3ac86be7ae9e[i].var_1f97475ff2d69ebf = function_515820c869914cdd(mission_name);
    var_d08f3ac86be7ae9e[i].str_mission = mission_name;
    var_d08f3ac86be7ae9e[i] namespace_9f6a961447bab709::function_2e0dc001c9a5c661();
    level thread start_exfil_spawns_at_destination(var_d08f3ac86be7ae9e[i]);
  }
}

function function_cd828662014a857e() {
  switch (self.model) {
    case #"hash_d212853f8d744c9e":
      return "s0_act1";
    case #"hash_313fbf630ac98b33":
      return "s0_act2";
    case #"hash_313fbe630ac989a0":
      return "s0_act3";
  }
}

function function_1cbe81bf66185af4(n_act) {
  switch (n_act) {
    case 0:
      str_mission = "s0_act1";
      break;
    case 1:
      str_mission = "s0_act2";
      break;
    case 2:
      str_mission = "s0_act3";
      break;
    default:
      str_mission = "s0_act1";
      break;
  }

  return str_mission;
}

function function_515820c869914cdd(mission_name) {
  switch (mission_name) {
    case #"hash_34b3c3f2be08e508":
      return "cp_mp_quest_exfil_site_xmodel";
    case #"hash_34b3c6f2be08e9c1":
      return "cp_mp_quest_exfil_site_xmodel_2";
    case #"hash_34b3c5f2be08e82e":
      return "cp_mp_quest_exfil_site_xmodel_3";
  }
}

function function_6a3d3280a1913f27(player) {
  level.var_9ec4962076db301b["general_info"].var_f6e64573c4a3a4be = array_removedead(level.var_9ec4962076db301b["general_info"].var_f6e64573c4a3a4be);

  foreach(quest_exfil in level.var_9ec4962076db301b["general_info"].var_f6e64573c4a3a4be) {
    if(isDefined(quest_exfil)) {
      quest_exfil enablescriptableplayeruse(player);
      quest_exfil showtoplayer(player);
    }
  }
}

function function_efb50a1f9ede7de7(params) {
  if(!isDefined(params.var_d182b8d3f3aaa93b)) {
    return;
  }

  var_d182b8d3f3aaa93b = params.var_d182b8d3f3aaa93b;
  var_d182b8d3f3aaa93b setscriptablepartstate("cp_mp_exfil_icon", "default_icon");
  str_act = var_d182b8d3f3aaa93b function_cd828662014a857e();

  foreach(player in level.players) {
    var_d182b8d3f3aaa93b disablescriptableplayeruse(player);
    var_d182b8d3f3aaa93b hidefromplayer(player);
  }

  foreach(player in level.var_9ec4962076db301b[str_act].eligible_players) {
    if(isDefined(player)) {
      var_d182b8d3f3aaa93b enablescriptableplayeruse(player);
      var_d182b8d3f3aaa93b showtoplayer(player);
      var_5c6e050b71cc8eb3 = var_d182b8d3f3aaa93b getlinkedscriptableinstance();
    }

    wait 1;

    if(isDefined(player)) {
      if(str_act == "cp_mp_quest_exfil_site_xmodel") {
        missionid = 17551;
      } else if(str_act == "cp_mp_quest_exfil_site_xmodel_2") {
        missionid = 17568;
      } else {
        missionid = 17091;
      }

      if(!function_62b41959b3c5a9ca(player, missionid)) {
        player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(18, var_5c6e050b71cc8eb3.origin, var_5c6e050b71cc8eb3.index);
      }
    }
  }

  level.var_9ec4962076db301b["general_info"].var_f6e64573c4a3a4be = array_add(level.var_9ec4962076db301b["general_info"].var_f6e64573c4a3a4be, var_d182b8d3f3aaa93b);
}

function function_202616c69c9f30c0(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  if(isDefined(params.s_exfil.mission_selected) && array_contains(level.var_9ec4962076db301b[params.s_exfil.mission_selected].eligible_players, params.player)) {
    str_callback = "exfil_to_" + params.s_exfil.mission_selected;
    logstring("quest exfil to act callback");
    level callback::callback(str_callback, params);
  }
}

function function_11bcd4711058b7d3(s_exfil, player) {
  if(!isDefined(player)) {
    return;
  }

  level.var_9ec4962076db301b["s0_act1"].eligible_players = array_removeundefined(level.var_9ec4962076db301b["s0_act1"].eligible_players, 1);
  level.var_9ec4962076db301b["s0_act2"].eligible_players = array_removeundefined(level.var_9ec4962076db301b["s0_act2"].eligible_players, 1);
  level.var_9ec4962076db301b["s0_act3"].eligible_players = array_removeundefined(level.var_9ec4962076db301b["s0_act3"].eligible_players, 1);

  if(array_contains(level.var_9ec4962076db301b["s0_act1"].eligible_players, player) && s_exfil.var_1f97475ff2d69ebf == "cp_mp_quest_exfil_site_xmodel") {
    level thread scripts\cp_mp\overlord::playconversation("quest_s0a1t7_ava_start", level.var_9ec4962076db301b["s0_act1"].eligible_players, 0, 1);
    s_exfil.mission_selected = "s0_act1";
    return;
  }

  if(array_contains(level.var_9ec4962076db301b["s0_act2"].eligible_players, player) && s_exfil.var_1f97475ff2d69ebf == "cp_mp_quest_exfil_site_xmodel_2") {
    level thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_exfil_to_act", level.var_9ec4962076db301b["s0_act2"].eligible_players, 0, 1);
    s_exfil.mission_selected = "s0_act2";
    return;
  }

  if(array_contains(level.var_9ec4962076db301b["s0_act3"].eligible_players, player) && s_exfil.var_1f97475ff2d69ebf == "cp_mp_quest_exfil_site_xmodel_3") {
    level thread scripts\cp_mp\overlord::playconversation("quest_s0a3t5_zakhaev_start", level.var_9ec4962076db301b["s0_act3"].eligible_players, 0, 1);
    s_exfil.mission_selected = "s0_act3";
  }
}

function map_transition(var_684092929dab076f, var_576f57af0204c38c, str_mission) {
  if(!isDefined(var_684092929dab076f)) {
    return;
  }

  if(!isDefined(str_mission)) {
    return;
  }

  a_squads = [];
  var_2de99dcf81d44b88 = function_3e4e6e35ce1eb985(str_mission);
  logstring("quest exfil start squad check");
  var_684092929dab076f = array_removeundefined(var_684092929dab076f);

  while(true) {
    player = var_684092929dab076f[0];

    if(!isDefined(player)) {
      return;
    }

    var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers(undefined, 1);
    var_de42222cf42400aa = [];

    foreach(squad_member in var_c9b69aecc5c631ed) {
      if(var_576f57af0204c38c function_c80b9a252474413b(squad_member)) {
        var_de42222cf42400aa[var_de42222cf42400aa.size] = squad_member;
      }
    }

    a_squads[a_squads.size] = var_de42222cf42400aa;

    foreach(squad_member in var_de42222cf42400aa) {
      if(isDefined(squad_member)) {
        var_684092929dab076f = array_remove(var_684092929dab076f, squad_member);
      }
    }

    if(!var_684092929dab076f.size) {
      break;
    }

    waitframe();
  }

  foreach(squad in a_squads) {
    logstring("quest exfil squad to map to map start");
    level thread ob_exfil::function_e229d89e0c38206d(squad, var_2de99dcf81d44b88);
  }
}

function function_3e4e6e35ce1eb985(str_mission) {
  switch (str_mission) {
    case #"hash_34b3c3f2be08e508":
      n_id = 1001;
      break;
    case #"hash_34b3c6f2be08e9c1":
      n_id = 1002;
      break;
    case #"hash_34b3c5f2be08e82e":
      n_id = 1003;
      break;
  }

  return n_id;
}

function function_c80b9a252474413b(player) {
  if(!isDefined(self) || !isalive(self) || !isDefined(self.origin) || !isDefined(player) || !isDefined(player.origin)) {
    return 0;
  }

  return function_f69d383479425bfa(player);
}

function function_f69d383479425bfa(player) {
  if(isarray(self.ridingplayers) && array_contains_key(self.ridingplayers, player.guid)) {
    return true;
  }

  return false;
}
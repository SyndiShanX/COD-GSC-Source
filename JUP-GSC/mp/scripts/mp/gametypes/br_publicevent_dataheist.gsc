/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_publicevent_dataheist.gsc
****************************************************************/

#using script_21c19cfc7139d773;
#using script_252fa7d2b1b1b50b;
#using script_5238dee479bbf7fb;
#using script_55e418c5cc946593;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace br_publicevent_dataheist;

function __init() {}

function autoexec main() {
  scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82(%"dataheist", &init);
}

function init(event_info) {
  event_info.validatefunc = &event_validate;
  event_info.waitfunc = &event_wait;
  event_info.activatefunc = &event_activate;
  event_info.postinitfunc = &function_de40a46baab733f5;
  event_info.deactivatefunc = &event_deactivate;
  snd_transient_load("wz_pe_dataheist");
}

function function_de40a46baab733f5() {
  init_dvars(self);
  function_6e94141d9de9568d(self);
  level thread init_ai(self);
  init_dialog();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("br_pe_dataheist_uplink_useable", &function_533c18ee02139b7e);
  scripts\mp\rank::registerscoreinfo(#"br_pe_capNode", #"value", 1000);
  self.screen_states = [];
  self.screen_states[0] = "default";
  self.screen_states[1] = "downloading";
  self.screen_states[2] = "interference";
  self.screen_states[3] = "blocked";

  level thread debug_init();
  setdvarifuninitialized(@ "hash_31426ea35497080f", 0);
  setdvarifuninitialized(@ "hash_8326c0fb793ffe45", "<dev string:x1c>");
}

function init_dvars(event_data) {
  team_size = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();

  switch (team_size) {
    case 1:
      event_data.var_a1579dc24e9412dd = 50;
      event_data.var_78fd234febf0416a = 3;
      event_data.var_7df9fdb99d27a28b = 4;
      break;
    case 2:
      event_data.var_a1579dc24e9412dd = 50;
      event_data.var_78fd234febf0416a = 3;
      event_data.var_7df9fdb99d27a28b = 4;
      break;
    case 3:
      event_data.var_a1579dc24e9412dd = 60;
      event_data.var_78fd234febf0416a = 4;
      event_data.var_7df9fdb99d27a28b = 3;
      break;
    case 4:
    default:
      event_data.var_a1579dc24e9412dd = 60;
      event_data.var_78fd234febf0416a = 4;
      event_data.var_7df9fdb99d27a28b = 3;
      break;
  }

  var_cca5fc6c8ed8be7f = getdvarint(@ "hash_193a2e0ce733e6d1", 0);

  if(var_cca5fc6c8ed8be7f > -1) {
    event_data.var_78fd234febf0416a = var_cca5fc6c8ed8be7f;
  }

  event_data.var_a1579dc24e9412dd = getdvarint(@ "hash_dc4cb3509e8702a4", event_data.var_a1579dc24e9412dd);
  event_data.var_7df9fdb99d27a28b = getdvarint(@ "hash_6b8529ae11c8c7f6", event_data.var_7df9fdb99d27a28b);
  event_data.var_9e852ac0876c3bbe = [0.25];
  function_c1150641505df131();
  event_data.var_453503008f1b0d85 = getdvarint(@ "hash_f1bec911a034dce4", 1500);
  event_data.var_adc5129ff19a0342 = squared(event_data.var_453503008f1b0d85);
  event_data.var_cc79ec8ec36334d3 = getdvarint(@ "hash_3fe660588b6f40ce", 5000);
  event_data.var_a355ae253087e6ec = squared(event_data.var_cc79ec8ec36334d3);
  event_data.var_6dc1e20d4411f853 = getdvarint(@ "hash_63a6751a902ecaec", 750);
  event_data.var_ad5deff214441f02 = getdvarint(@ "hash_ebb538de66a9395", 500);
  event_data.var_1de3f81c4507840 = getdvarint(@ "hash_c70440c743bc72f1", 1) == 1;
  event_data.var_76013aa23b2588d8 = getdvarint(@ "hash_36db07fd99bb9b31", 1) == 1;
  event_data.var_f2f4664f784bb1b0 = getdvarint(@ "hash_9ec61cfa337dc3e1", 1000);
  event_data.var_f6769d2b85aaf27e = int(max(1, getdvarint(@ "hash_3b2ad4cc6d705455", 300)));
  event_data.var_f25b6e5894571eb2 = event_data.var_f6769d2b85aaf27e + event_data.var_a1579dc24e9412dd;
  event_data.var_160294b506c51a7c = getdvarint(@ "hash_86aca5c7cdaf36b5", 4000);
  event_data.var_c740830cdb73800e = int(max(1, getdvarint(@ "hash_f33906ab457ed275", 3)));
  event_data.var_5dfa1429cddcbc96 = int(max(1, getdvarint(@ "hash_e87df641ad60dfbd", 3)));
  event_data.var_c5f1eb4d167935 = 1 / event_data.var_5dfa1429cddcbc96;
  event_data.var_80242dc777bb3f8 = getdvarint(@ "hash_c70caafa18fe870f", 240);
  event_data.var_8b248d86225e95c5 = getdvarint(@ "hash_ae3ec08cd03905e0", 50);
  event_data.var_62f375887033841f = getdvarint(@ "hash_f63bb46f84687aac", 500);
  event_data.var_8fae2a4c66da64c0 = getdvarint(@ "hash_8dbf9e06474b2ba7", 1) == 1;
  event_data.var_7e9fd2d078543358 = getdvarint(@ "hash_17b8716c1c9ca6ff", 1);
  event_data.var_d03b16e4339a4546 = getdvarint(@ "hash_9e246216c8ab73cd", 2);
  event_data.var_5b470c719e713baa = getdvarint(@ "hash_d1254cb3a6456cd3", 3);
  event_data.var_3b2fe32897ffd722 = getdvarint(@ "hash_6f20a3b0bc339fcb", 2);
  event_data.agent_accuracy = getdvarfloat(@ "hash_743f2aafce01b00d", 0.4);
  event_data.var_464ff1ef779c439d = getdvarint(@ "hash_8a328fc0a8b887e4", 8);
  event_data.var_4febd27038048ffb = getdvarint(@ "hash_89e40bcff5370f82", 120);
  event_data.var_94b952789d039abb = getdvarint(@ "hash_5b21ed44f9d400", 1) == 1;
}

function function_c1150641505df131() {
  var_f087e13b64fb79ca = getDvar(@ "hash_4675782a74d204dc");

  if(isDefined(var_f087e13b64fb79ca) && var_f087e13b64fb79ca != "") {
    var_4976eafad6c14c36 = [];
    tokens = strtok(var_f087e13b64fb79ca, ",", 0);

    foreach(token in tokens) {
      threshold = float(token);

      if(!isfloat(threshold)) {
        println("<dev string:x20>" + token + "<dev string:x40>");
        continue;
      }

      var_4976eafad6c14c36[var_4976eafad6c14c36.size] = threshold;
    }

    if(var_4976eafad6c14c36.size > 0) {
      self.var_9e852ac0876c3bbe = var_4976eafad6c14c36;
    }
  }
}

function function_6e94141d9de9568d(event_data) {
  uplink_points = [];
  id = 0;
  uplink_structs = getStructArray("dataheist_uplink_location", "script_noteworthy");

  foreach(struct in uplink_structs) {
    uplink_points = array_add(uplink_points, function_c82760fff0dc45df(struct.origin, struct.angles, struct.group, id));
    id++;
  }

  if(uplink_points.size <= 0) {
    switch (level.mapname) {
      case #"hash_71c69de1abae3a2":
      case #"hash_4aa5d6e97851bdbd":
        uplink_points = array_add(uplink_points, function_c82760fff0dc45df((-471, -1886, 25), (0, 180, 0), "none", 0));
        uplink_points = array_add(uplink_points, function_c82760fff0dc45df((-367, -811, 25), (0, 180, 0), "none", 1));
        uplink_points = array_add(uplink_points, function_c82760fff0dc45df((704, -2767, 25), (0, 270, 0), "none", 2));
        uplink_points = array_add(uplink_points, function_c82760fff0dc45df((1970, -4096, 25), (0, 270, 0), "none", 3));
        uplink_points = array_add(uplink_points, function_c82760fff0dc45df((3077, -2300, 25), (0, 180, 0), "none", 4));
        uplink_points = array_add(uplink_points, function_c82760fff0dc45df((2935, 59, 25), (0, 0, 0), "none", 5));
        uplink_points = array_add(uplink_points, function_c82760fff0dc45df((5015, -674, 25), (0, 0, 0), "none", 6));
        break;
    }
  }

  event_data.uplink_points = uplink_points;

  event_data function_24afcbb2ea0ccb49(event_data.var_f6769d2b85aaf27e);
}

function function_c82760fff0dc45df(origin, angles, group, id) {
  point = spawnStruct();
  point.origin = origin;
  point.angles = angles;
  point.group = group;
  point.id = id;

  if(!isDefined(group)) {
    point.group = "none";
  }

  if(!isDefined(id)) {
    id = -1;
  }

  point.used = 0;
  point.is_valid = 0;
  point.valid_neighbors = [];
  return point;
}

function init_ai(event_data) {
  level endon("game_ended");

  if(event_data.var_78fd234febf0416a < 1) {
    return;
  }

  scripts\mp\ai_mp_controller::function_2fc80954fa70d153();
  scripts\mp\ai_mp_controller::function_ba4022744dce59f6("dataheist", event_data.var_8b248d86225e95c5);
  namespace_8d9453d94dd4f401::function_b146e2b40516b668("dataheist");
}

function init_dialog() {
  game["dialog"]["dataheist_event_start"] = "dths_grav_dhes";
  game["dialog"]["dataheist_comp_success"] = "dths_grav_dhcs";
  game["dialog"]["dataheist_comp_failure"] = "dths_grav_dhcf";
  game["dialog"]["dataheist_team_act_uplink"] = "dths_grav_dtap";
  game["dialog"]["dataheist_enemy_act_uplink"] = "dths_grav_dhnp";
  game["dialog"]["dataheist_enemy_cap_uplink"] = "dths_grav_dhnc";
  game["dialog"]["dataheist_team_cap_uplink"] = "dths_grav_dhtc";
  game["dialog"]["dataheist_ai_spawn"] = "dths_grav_dhas";
  game["dialog"]["dataheist_enemy_block_down"] = "dths_grav_debd";
  game["dialog"]["dataheist_out_range"] = "dths_grav_dhtr";
  game["dialog"]["dataheist_team_comp_uplink"] = "dths_grav_dhtp";
  game["dialog"]["dataheist_enemy_comp_uplink"] = "dths_grav_nmsn";
  game["dialog"]["dataheist_enemy_comp_lost_uplink"] = "dths_grav_dhnl";
  game["dialog"]["dataheist_time_warn"] = "dths_grav_dhtw";
}

function __event() {}

function event_validate() {
  if(!scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() != "resurgence") {
    return false;
  }

  return true;
}

function event_wait() {}

function event_activate() {
  assertex(self.var_a1579dc24e9412dd > 0, "<dev string:x87>");
  self endon("event_deactivated");

  function_7b885b4b79b662b9();

  self.uplinks = [];
  self.team_scores = [];
  thread function_cdb11d6d4ce247ea();
  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_dataheist_start", "splash_list_br_pe_dataheist");
  setomnvar("ui_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 6);
  var_f6769d2b85aaf27e = self.var_f6769d2b85aaf27e;

  if(!level.br_circle_disabled) {
    var_f6769d2b85aaf27e = min(self.var_f6769d2b85aaf27e, scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7() - 5);
  }

  self.end_time = gettime() + var_f6769d2b85aaf27e * 1000;
  self.warning_time = self.end_time - 30000;
  setomnvar("ui_publicevent_timer", self.end_time);
  function_24afcbb2ea0ccb49(var_f6769d2b85aaf27e);
  var_2f1f2bd8531e8866 = getDvar(@ "hash_8326c0fb793ffe45", "");
  force_points = function_671cc803581d0e65(var_2f1f2bd8531e8866);
  points = [];

  if(force_points.size > 0) {
    foreach(point_index in force_points) {
      points[points.size] = self.uplink_points[point_index];
    }
  } else {
    var_ff9e6fbb61b45590 = function_45a890c985d26276();

    if(var_ff9e6fbb61b45590.size <= 0) {
      iprintlnbold("<dev string:xbf>");

      level thread scripts\mp\gametypes\br_publicevents::function_2907d01a7d692108(%"dataheist");
      return;
    }

    points[0] = random(var_ff9e6fbb61b45590);
    nearby_points = array_randomize(points[0].valid_neighbors);

    for(i = 0; i < self.var_c740830cdb73800e - 1; i++) {
      points[i + 1] = nearby_points[i];
    }
  }

  foreach(point in points) {
    thread uplink_start(point);
  }

  self.midpoint = (0, 0, 0);

  foreach(point in points) {
    self.midpoint += point.origin;
  }

  self.midpoint /= points.size;
  var_c27aa5edd70a0762 = 0;

  foreach(point in points) {
    dist_sq = distance2dsquared(self.midpoint, point.origin);

    if(dist_sq > var_c27aa5edd70a0762) {
      var_c27aa5edd70a0762 = dist_sq;
    }
  }

  self.var_59ea6b2ef4905653 = sqrt(var_c27aa5edd70a0762) + self.var_f2f4664f784bb1b0;

  if(self.var_1de3f81c4507840) {
    circle_radius = max(sqrt(var_c27aa5edd70a0762) + 250, self.var_160294b506c51a7c);
    self.map_circle = function_dc11c1caffe56e16("Dataheist_Br", self.midpoint[0], self.midpoint[1], circle_radius, undefined);
    self.map_circle show();

    if(self.var_f2f4664f784bb1b0 > self.var_6dc1e20d4411f853) {
      thread function_54539d559adc405c();
    }

    if(self.var_76013aa23b2588d8) {
      thread function_e6b8718faa7f2edf();
    }
  }

  if(getdvarint(@ "hash_31426ea35497080f", 0) == 1) {
    function_29327b1833cde79e();
  }

  scripts\mp\ai_mp_controller::function_93add0b65db9f722(&function_60fdeceea0c7a20e);
  thread function_2b9e294b137a88d1();
  thread function_518af9f5c4bcde52(var_f6769d2b85aaf27e - 30);

  if(self.var_94b952789d039abb) {
    thread function_e86f6c7b0f5447e2();
  }

  function_e8ce5f018d2b942c("dataheist_event_start", 1);
  waittill_any_timeout_1(var_f6769d2b85aaf27e, "all_uplinks_complete");
  winners = [];
  losers = [];

  foreach(player in level.players) {
    if(function_8d72849f49068945(player.team) > 0) {
      winners[winners.size] = player;
      continue;
    }

    losers[losers.size] = player;
  }

  function_63bdbc18191be5f9("dataheist_comp_success", winners, 0.5);
  function_63bdbc18191be5f9("dataheist_comp_failure", losers, 0.5);
  level thread scripts\mp\gametypes\br_publicevents::function_2907d01a7d692108(%"dataheist");
}

function event_deactivate() {
  function_1497224a9c74808b();

  scripts\mp\gametypes\br_publicevents::showsplashtoall("br_pe_dataheist_end", "splash_list_br_pe_dataheist");
  scripts\mp\ai_mp_controller::function_66a6064fad612bf3(&function_60fdeceea0c7a20e);

  if(isDefined(self.map_circle)) {
    self.map_circle delete();
  }

  foreach(uplink in self.uplinks) {
    uplink uplink_cleanup();
  }

  self.uplinks = undefined;
  self.team_scores = undefined;
  setomnvar("ui_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  self notify("event_deactivated");
}

function function_2b9e294b137a88d1() {
  level endon("game_ended");
  self endon("event_deactivated");

  for(i = 0; i < self.uplinks.size; i++) {
    self waittill("uplink_complete");
  }

  self notify("all_uplinks_complete");
}

function function_518af9f5c4bcde52(time) {
  level endon("game_ended");
  self endon("event_deactivated");
  wait time;
  nearby_players = scripts\mp\utility\player::getplayersinradius(self.midpoint, self.var_59ea6b2ef4905653);
  function_63bdbc18191be5f9("dataheist_time_warn", nearby_players);
}

function function_54539d559adc405c() {
  level endon("game_ended");
  self endon("event_deactivated");

  while(true) {
    for(i = 0; i < self.uplinks.size; i++) {
      uplink = self.uplinks[i];
      uplink.nearby_players = scripts\mp\utility\player::getplayersinradius(uplink.origin, self.var_f2f4664f784bb1b0);

      foreach(player in uplink.nearby_players) {
        if(isDefined(player.team) && !array_contains_key(uplink.seen_teams, player.team)) {
          uplink.seen_teams[player.team] = 1;

          if(isDefined(uplink.obj_id)) {
            objective_addteamtomask(uplink.obj_id, player.team);
          }
        }
      }

      wait 1;
    }
  }
}

function function_e6b8718faa7f2edf() {
  level endon("game_ended");
  self endon("event_deactivated");
  revealed_count = 0;

  while(revealed_count < self.uplinks.size) {
    self waittill("uplink_reveal", uplink);
    revealed_count++;

    foreach(team, data in level.teamdata) {
      if(isDefined(team) && !array_contains_key(uplink.seen_teams, team)) {
        uplink.seen_teams[team] = 1;

        if(isDefined(uplink.obj_id)) {
          objective_addteamtomask(uplink.obj_id, team);
        }
      }
    }
  }

  self.var_9d8c59410245296 = 1;
}

function function_2f06f510aff6c900(team) {
  if(istrue(self.var_9d8c59410245296)) {
    return;
  }

  foreach(uplink in self.uplinks) {
    if(!array_contains_key(uplink.seen_teams, team)) {
      uplink.seen_teams[team] = 1;

      if(isDefined(uplink.obj_id)) {
        objective_addteamtomask(uplink.obj_id, team);
      }
    }
  }
}

function function_cdb11d6d4ce247ea() {
  level endon("game_ended");
  self endon("event_deactivated");
  level waittill("cancel_public_event");
  event_deactivate();
}

function event_add_score(team) {
  if(isDefined(self.team_scores[team])) {
    self.team_scores[team]++;
  } else {
    self.team_scores[team] = 1;
  }

  var_c96877a325b94330 = "";

  switch (self.team_scores[team]) {
    case 1:
      var_c96877a325b94330 = #"hash_cfddc35e5f58e75";
      break;
    case 2:
      var_c96877a325b94330 = #"hash_cfdd935e5f5895c";
      break;
    case 3:
    default:
      var_c96877a325b94330 = #"hash_cfdda35e5f58b0f";
      break;
  }

  team_players = scripts\mp\utility\teams::getteamdata(team, "players");
  var_88846aeef1f75a50 = 0;

  foreach(player in team_players) {
    if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      if(!var_88846aeef1f75a50) {
        player thread scripts\mp\utility\points::doscoreevent(#"br_pe_capNode");
        var_88846aeef1f75a50 = 1;
      }

      player thread scripts\mp\utility\points::doscoreevent(var_c96877a325b94330);
    }
  }
}

function function_8d72849f49068945(team) {
  if(isDefined(self.team_scores[team])) {
    return self.team_scores[team];
  }

  return 0;
}

function function_60fdeceea0c7a20e(agent, attacker) {
  self endon("event_deactivated");
  category = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(agent, "category");

  if(!is_equal("dataheist", category)) {
    return;
  }

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }

  if(isDefined(self.uplinks)) {
    foreach(uplink in self.uplinks) {
      if(uplink.is_complete) {
        continue;
      }

      if(attacker.team == uplink.controlling_team && array_contains(uplink.agents, agent)) {
        uplink function_5e4d7ff52575526(self.var_7df9fdb99d27a28b);
      }
    }
  }
}

function function_e86f6c7b0f5447e2() {
  level endon("game_ended");
  wait 5;

  foreach(player in level.players) {
    if(isalive(player) && !player scripts\mp\gametypes\br_public::isplayeringulag()) {
      player namespace_88bfae359020fdd3::ftue_triggertip("br_ftue_dataheist");
    }
  }
}

function __uplink() {}

function uplink_start(uplink_point) {
  assertex(isDefined(uplink_point), "<dev string:xfb>");
  level endon("game_ended");
  self endon("event_deactivated");
  uplink_point.used = 1;
  uplink = spawnStruct();
  uplink.event = self;
  self.uplinks[self.uplinks.size] = uplink;
  uplink.is_complete = 0;
  uplink.is_active = 0;
  uplink.num_blockers = 0;
  uplink.var_a5d01c9b7f5297af = 0;
  uplink.time = 0;
  uplink.progress = 0;
  uplink.controlling_team = "None";
  uplink.origin = uplink_point.origin;
  uplink.angles = uplink_point.angles;
  uplink.agents = [];
  uplink.seen_teams = [];
  uplink.capture_state = 0;
  uplink.var_a5d01c9b7f5297af = 0;
  uplink.num_blockers = 0;
  uplink.loc_name = "Uplink #" + uplink_point.id + " @ " + uplink_point.group;
  uplink.var_aa83c2ddc32095ed = self.var_a1579dc24e9412dd;
  uplink.previous_owners = [];
  uplink.obj_id = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  uplink.trigger = spawn("trigger_radius", uplink.origin - (0, 0, self.var_ad5deff214441f02 * 0.5), 0, self.var_6dc1e20d4411f853, self.var_ad5deff214441f02);
  uplink.trigger.uplink = uplink;
  uplink.trigger_ents = [];
  uplink thread function_2bb37c482de07fd3();
  uplink.var_4c42ac43dde49b92 = 0;
  scripts\cp_mp\emp_debuff::add_emp_ent(uplink.trigger);
  uplink.trigger scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_88a9ce111608764a);
  uplink.trigger scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_635613a90782ee9b);
  uplink.scriptable = spawnscriptable("br_pe_dataheist_uplink", uplink.origin, uplink.angles);
  uplink.scriptable.uplink = uplink;

  if(self.var_78fd234febf0416a > 0) {
    requests = function_e27b61f74dfba712(self.var_78fd234febf0416a);
    uplink thread function_3723563cad2eb687(requests, ["heli", "para", "safe"], function_27ba596aafa69f39(1));
  }

  assertex(uplink.obj_id != -1, "<dev string:x13d>");
  scripts\mp\objidpoolmanager::objective_add_objective(uplink.obj_id, "current", uplink.origin + (0, 0, 15), "ui_map_icon_obj_dataheist_uplink");

  if(self.var_1de3f81c4507840) {
    objective_removeallfrommask(uplink.obj_id);
    objective_showtoplayersinmask(uplink.obj_id);
  }

  objective_setdescription(uplink.obj_id, &"MP_BR_PE_DATAHEIST/NAME");
  objective_setbackground(uplink.obj_id, 6);
  uplink waittill("activated", team);
  self notify("uplink_reveal", uplink);
  uplink.scriptable setscriptablepartstate("br_pe_dataheist_uplink_useable", "active");
  uplink.is_active = 1;
  objective_setshowprogress(uplink.obj_id, 1);

  foreach(player in level.players) {
    objective_showprogressforclient(uplink.obj_id, player);
  }

  foreach(ent in uplink.trigger_ents) {
    if(isPlayer(ent)) {
      objective_hideprogressforclient(uplink.obj_id, ent);
    }
  }

  uplink function_6fc077e1f039cf7(team);
  nearby_players = function_2a43e356ecd267c7(uplink.controlling_team);
  function_63bdbc18191be5f9("dataheist_team_act_uplink", nearby_players, 2);
  nearby_players = function_f8cd8b690a39bec2(uplink.controlling_team);
  function_63bdbc18191be5f9("dataheist_enemy_act_uplink", nearby_players, 2);
  nearby_players = undefined;
  uplink childthread function_f5b8c7d6bb6609c4();
  uplink childthread function_db1ce4cd12dd95d5();

  if(self.var_78fd234febf0416a > 0) {
    uplink childthread function_6314bc0655f4a7c9(self.var_9e852ac0876c3bbe);
  }

  last_state = uplink.capture_state;
  uplink.scriptable setscriptablepartstate("br_pe_dataheist_uplink_screen", self.screen_states[uplink.capture_state]);
  var_d13206c3844d8288 = 0.25;
  var_6c602b41960a6297 = gettime() + 5000;
  var_234548a5923400d2 = -1;
  var_836160b8b34bc69a = gettime() + 5000;
  var_b1da730a8bf61935 = -1;

  while(uplink.time < uplink.var_aa83c2ddc32095ed) {
    time = gettime();

    if(!uplink.var_a5d01c9b7f5297af) {
      uplink.capture_state = 0;
    } else if(uplink.var_4c42ac43dde49b92 || uplink.num_blockers >= self.var_5dfa1429cddcbc96) {
      uplink.capture_state = 3;
    } else if(uplink.num_blockers > 0) {
      uplink.capture_state = 2;
    } else {
      uplink.capture_state = 1;
    }

    if(uplink.capture_state != last_state) {
      foreach(ent in uplink.trigger_ents) {
        if(isPlayer(ent)) {
          ent setclientomnvar("ui_publicevent_dataheist_state", uplink.capture_state);
        }
      }

      if(uplink.capture_state == 0) {
        var_234548a5923400d2 = gettime() + 10000;
      } else {
        var_234548a5923400d2 = -1;
      }

      if(uplink.capture_state > 1) {
        var_b1da730a8bf61935 = gettime() + 6000;
      } else {
        var_b1da730a8bf61935 = -1;
      }

      last_state = uplink.capture_state;
      uplink.scriptable setscriptablepartstate("br_pe_dataheist_uplink_screen", self.screen_states[uplink.capture_state]);
    }

    if(var_234548a5923400d2 > 0) {
      if(time > var_234548a5923400d2 && time > var_6c602b41960a6297) {
        var_6c602b41960a6297 = time + 30000;
        nearby_team = uplink function_aeb8753295c3577(uplink.controlling_team);
        function_63bdbc18191be5f9("dataheist_out_range", nearby_team);
        var_234548a5923400d2 = -1;
      }
    } else if(var_b1da730a8bf61935 > 0) {
      if(time > var_b1da730a8bf61935 && time > var_836160b8b34bc69a) {
        var_836160b8b34bc69a = time + 30000;
        nearby_team = uplink function_aeb8753295c3577(uplink.controlling_team);
        function_63bdbc18191be5f9("dataheist_enemy_block_down", nearby_team);
      }
    }

    if(uplink.var_a5d01c9b7f5297af && !uplink.var_4c42ac43dde49b92) {
      scale = (time - self.warning_time) / (self.end_time - self.warning_time);
      scale = clamp(scale, 0, 1);
      time_scalar = 3 * scale + 1;
      increment = var_d13206c3844d8288 * time_scalar;
      uplink function_5e4d7ff52575526((1 - min(1, self.var_c5f1eb4d167935 * uplink.num_blockers)) * increment);
    }

    wait var_d13206c3844d8288;
  }

  uplink.scriptable setscriptablepartstate("br_pe_dataheist_uplink_screen", "complete");
  uplink.scriptable setscriptablepartstate("br_pe_dataheist_uplink_useable", "complete");
  event_add_score(uplink.controlling_team);
  uplink.scriptable function_358de5caa85aabf7();

  foreach(player in uplink.controlling_players) {
    player thread function_ddfc2513ffdc4ddc();
  }

  if(uplink.obj_id != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(uplink.obj_id);
    uplink.obj_id = undefined;
  }

  nearby_players = function_f3167a32a9d8b1e8();
  winners = [];
  losers = [];
  neutrals = [];

  foreach(player in nearby_players) {
    if(player.team == uplink.controlling_team) {
      winners[winners.size] = player;
      continue;
    }

    if(isDefined(uplink.previous_owners[player.team])) {
      losers[losers.size] = player;
      continue;
    }

    neutrals[neutrals.size] = player;
  }

  uplink.scriptable thread function_a52def3d6b40207a(winners);
  uplink.is_complete = 1;
  uplink notify("complete");
  self notify("uplink_complete");
  function_2f06f510aff6c900(uplink.controlling_team);
  wait 1;
  function_63bdbc18191be5f9("dataheist_team_comp_uplink", winners, 2);

  foreach(player in winners) {
    player scripts\mp\hud_message::showsplash("br_pe_dataheist_success", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist");
  }

  function_63bdbc18191be5f9("dataheist_enemy_comp_lost_uplink", losers, 2);
  function_63bdbc18191be5f9("dataheist_enemy_comp_uplink", neutrals, 2);
  uplink uplink_cleanup();
}

function function_5e4d7ff52575526(increment) {
  self.time += increment;
  self.progress = min(1, self.time / self.var_aa83c2ddc32095ed);

  if(isDefined(self.obj_id)) {
    objective_setprogress(self.obj_id, self.progress);
  }

  foreach(ent in self.trigger_ents) {
    if(isPlayer(ent)) {
      ent setclientomnvar("ui_publicevent_dataheist_progress", self.progress);
    }
  }
}

function function_f5b8c7d6bb6609c4() {
  self endon("complete");

  while(true) {
    self waittill("activated", team);

    if(team == self.controlling_team) {
      continue;
    }

    nearby_players = self.event function_2a43e356ecd267c7(self.controlling_team);
    function_63bdbc18191be5f9("dataheist_enemy_cap_uplink", nearby_players, 2);

    foreach(player in nearby_players) {
      player scripts\mp\hud_message::showsplash("br_pe_dataheist_stolen", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist");
    }

    function_6fc077e1f039cf7(team);
    nearby_players = self.event function_2a43e356ecd267c7(self.controlling_team);
    function_63bdbc18191be5f9("dataheist_team_cap_uplink", nearby_players, 2);
  }
}

function function_88a9ce111608764a(data) {
  if(data.attacker.team == self.uplink.controlling_team) {
    return;
  }

  self.uplink.var_4c42ac43dde49b92 = 1;
}

function function_635613a90782ee9b(from_death) {
  self.uplink.var_4c42ac43dde49b92 = 0;
}

function function_db1ce4cd12dd95d5() {
  self endon("complete");

  while(true) {
    self.var_a5d01c9b7f5297af = 0;
    self.num_blockers = 0;

    foreach(ent in self.trigger_ents) {
      if(ent scripts\common\vehicle::isvehicle()) {
        continue;
      }

      if(isDefined(ent.team) && ent.team == self.controlling_team) {
        self.var_a5d01c9b7f5297af = 1;
        continue;
      }

      self.num_blockers++;
    }

    waitframe();
  }
}

function function_6314bc0655f4a7c9(var_aea828ab13b354b) {
  event = self.event;

  foreach(progress in var_aea828ab13b354b) {
    while(self.progress < progress) {
      wait 1;
    }

    requests = undefined;
    var_1ffc02522d731e6e = function_74428d38b94d6664();

    if(istrue(event.var_8fae2a4c66da64c0) && var_1ffc02522d731e6e < event.var_5b470c719e713baa) {
      var_148e19647354d724 = int(min(event.var_5b470c719e713baa - var_1ffc02522d731e6e, event.var_d03b16e4339a4546)) + 1;
      requests = function_16460a9daba16a6(event.var_78fd234febf0416a, randomintrange(event.var_7e9fd2d078543358, var_148e19647354d724), event.var_3b2fe32897ffd722);
    } else {
      requests = function_e27b61f74dfba712(event.var_78fd234febf0416a);
    }

    thread function_3723563cad2eb687(requests, ["safe", "para"], function_27ba596aafa69f39(0));
    function_63bdbc18191be5f9("dataheist_ai_spawn", self.nearby_players, 5);
  }
}

function function_6fc077e1f039cf7(team) {
  self.scriptable function_ae84023e1dbb45f3(team);
  self.controlling_team = team;
  self.controlling_players = scripts\mp\utility\teams::getteamdata(team, "players");

  if(!isDefined(self.previous_owners[team])) {
    self.previous_owners[team] = 1;
  }

  foreach(player in self.controlling_players) {
    player scripts\mp\hud_message::showsplash("br_pe_dataheist_defend", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist");
  }

  foreach(ent in self.trigger_ents) {
    if(isPlayer(ent)) {
      if(ent.team == self.controlling_team) {
        function_b2588b08ad6f485b(ent);
        continue;
      }

      function_e232769e6ea189ca(ent);
    }
  }

  if(isDefined(self.obj_id)) {
    objective_setprogressteam(self.obj_id, self.controlling_team);
  }
}

function uplink_cleanup() {
  foreach(ent in self.trigger_ents) {
    if(isPlayer(ent)) {
      ent setclientomnvar("ui_publicevent_dataheist_state", 0);
      ent setclientomnvar("ui_publicevent_dataheist_progress", 0);
    }
  }

  if(isDefined(self.map_circle)) {
    self.map_circle delete();
  }

  if(!self.is_complete && isDefined(self.scriptable)) {
    self.scriptable freescriptable();
  }

  if(isDefined(self.obj_id) && self.obj_id != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.obj_id);
  }

  if(isDefined(self.trigger)) {
    self.trigger notify("destroy");
    self.trigger delete();
  }

  self notify("cleanup");
}

function function_2bb37c482de07fd3() {
  level endon("game_ended");
  self endon("cleanup");

  while(isDefined(self.trigger)) {
    self.trigger waittill("trigger", ent);
    ent_id = ent getentitynumber();

    if(isDefined(self.trigger_ents[ent_id])) {
      continue;
    }

    if(!isPlayer(ent) && !isagent(ent) && !ent scripts\common\vehicle::isvehicle()) {
      continue;
    }

    if(ent scripts\common\vehicle::isvehicle()) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

      foreach(occupant in occupants) {
        if(isPlayer(occupant) || isagent(occupant)) {
          occupant_id = occupant getentitynumber();

          if(isDefined(self.trigger_ents[occupant_id])) {
            continue;
          }

          self.trigger_ents[occupant_id] = occupant;
          occupant thread function_191978f898963a8(self);
        }
      }

      continue;
    }

    self.trigger_ents[ent_id] = ent;
    ent thread function_191978f898963a8(self);
  }
}

function function_191978f898963a8(uplink) {
  level endon("game_ended");
  uplink endon("cleanup");

  if(isPlayer(self)) {
    uplink function_190c4bfff3fdc6b8(self);
  }

  while(scripts\mp\utility\player::isreallyalive(self)) {
    if(isDefined(self.vehicle)) {
      if(!self.vehicle istouching(uplink.trigger)) {
        break;
      }
    } else if(!self istouching(uplink.trigger)) {
      break;
    }

    waitframe();
  }

  ent_id = self getentitynumber();
  uplink.trigger_ents[ent_id] = undefined;

  if(isPlayer(self)) {
    uplink function_eb7d54264004374b(self);
  }
}

function function_190c4bfff3fdc6b8(player) {
  if(isDefined(player.team) && !array_contains_key(self.seen_teams, player.team)) {
    self.seen_teams[player.team] = 1;

    if(isDefined(self.obj_id)) {
      objective_addteamtomask(self.obj_id, player.team);
    }
  }

  if(istrue(self.is_active) && player.team == self.controlling_team) {
    function_b2588b08ad6f485b(player);
  }
}

function function_eb7d54264004374b(player) {
  function_e232769e6ea189ca(player);
}

function function_b2588b08ad6f485b(player) {
  if(isDefined(self.obj_id)) {
    objective_hideprogressforclient(self.obj_id, player);
  }

  player setclientomnvar("ui_publicevent_dataheist_state", self.capture_state);
  player setclientomnvar("ui_publicevent_dataheist_progress", self.progress);
}

function function_e232769e6ea189ca(player) {
  if(isDefined(self.obj_id)) {
    objective_showprogressforclient(self.obj_id, player);
  }

  player setclientomnvar("ui_publicevent_dataheist_state", 0);
}

function function_533c18ee02139b7e(instance, part, state, player, bautouse, usestring) {
  if(istrue(instance.var_180f4d931981e33e)) {
    if(getdvarint(@ "hash_ed4efe8df2b29df0", 1)) {
      namespace_981ad73f8047222f::function_647a8c40104e4866(player.team);
    }

    instance thread function_7a3f6a13e7005ed();
    return;
  }

  if(isDefined(instance.uplink)) {
    instance.uplink notify("activated", player.team);
  }
}

function function_ae84023e1dbb45f3(team) {
  foreach(player in level.players) {
    if(player.team == team) {
      self disablescriptableplayeruse(player);
      continue;
    }

    self enablescriptableplayeruse(player);
  }
}

function function_2b41b2856496cbb9() {}

function function_358de5caa85aabf7() {
  self.var_180f4d931981e33e = 1;
  uplink = self.uplink;
  event = uplink.event;
  score = event function_8d72849f49068945(uplink.controlling_team);
  team_size = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
  self.loot = [];
  self.loot = function_921cab584a3d07c0(event, score, team_size);

  foreach(player in level.players) {
    if(player.team != uplink.controlling_team) {
      self disablescriptableplayeruse(player);
      continue;
    }

    self enablescriptableplayeruse(player);
  }
}

function function_921cab584a3d07c0(event, score, team_size) {
  a_loot = [];

  switch (score) {
    case 3:
      a_loot[a_loot.size] = ["brloot_killstreak_auav", 1];

      if(cointoss() && getdvarint(@ "hash_9264f8f1143934c6", 0) && namespace_708f627020de59d3::function_2980f22fb01f43e6()) {
        perkpacks = ["brloot_perkpack_beret_br", "brloot_perkpack_insurgent_br", "brloot_perkpack_demolitionist_br", "brloot_perkpack_reserves_br", "brloot_perkpack_swat_br"];
        a_loot[a_loot.size] = [array_random(perkpacks), 1];
      } else if(getdvarint(@ "hash_368ea569c1a6a4e4", 1)) {
        var_5a6d897e9cfe5f52 = ["brloot_plate_carrier_tempered"];
        a_loot[a_loot.size] = [array_random(var_5a6d897e9cfe5f52), 1];
      }
    case 2:
      lootid = pickscriptablelootitem("weapon", 4, 4, "mp/loot/br/default/lootset_cache_lege.csv");
      lootcount = 1;

      if(isDefined(level.br_lootiteminfo[lootid])) {
        weapon = scripts\mp\gametypes\br_pickups::getfullweaponobjfromscriptablename(lootid);
        lootcount = weaponclipsize(weapon);
      }

      a_loot[a_loot.size] = [lootid, lootcount];
    case 1:
      if(score == 1 || score == 2) {
        a_loot[a_loot.size] = ["brloot_killstreak_uav", 1];
      }

      var_63de1dee54326fdd = scripts\mp\gametypes\br_plunder::getplundernamebyamount(event.var_80242dc777bb3f8);

      for(i = 0; i < team_size; i++) {
        a_loot[a_loot.size] = [var_63de1dee54326fdd, event.var_80242dc777bb3f8];
      }

      a_loot[a_loot.size] = ["brloot_super_armorbox"];
      a_loot[a_loot.size] = ["brloot_super_munitionsbox"];
      break;
  }

  return a_loot;
}

function function_7a3f6a13e7005ed() {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

  foreach(item in self.loot) {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, undefined, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride);
    scriptable = scripts\mp\gametypes\br_pickups::spawnpickup(item[0], dropinfo, item[1], 1);
  }

  if(isDefined(self.uplink.var_47b9acc51b653de0) && self.uplink.var_47b9acc51b653de0 != -1) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.uplink.var_47b9acc51b653de0);
  }

  self setscriptablepartstate("br_pe_dataheist_uplink_useable", "pickup");
  self setscriptablepartstate("br_pe_dataheist_uplink_screen", "hidden");
  self notify("uplink_looted");
  wait 1;
  self freescriptable();
}

function function_a52def3d6b40207a(winners) {
  level endon("game_ended");
  self endon("uplink_looted");
  self.uplink.var_47b9acc51b653de0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.uplink.var_47b9acc51b653de0 > -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.uplink.var_47b9acc51b653de0, "current", self.uplink.origin, "ui_map_icon_obj_sealion_sidequest_reward");
    objective_removeallfrommask(self.uplink.var_47b9acc51b653de0);
    objective_showtoplayersinmask(self.uplink.var_47b9acc51b653de0);
    objective_setbackground(self.uplink.var_47b9acc51b653de0, 1);
    objective_setplayintro(self.uplink.var_47b9acc51b653de0, 0);
    objective_position(self.uplink.var_47b9acc51b653de0, self.uplink.origin + (0, 0, 20));
    objective_setdescription(self.uplink.var_47b9acc51b653de0, &"MP_BR_INGAME/REWARD_ICON_NAME_DATAHEIST");
  }

  foreach(player in winners) {
    objective_addclienttomask(self.uplink.var_47b9acc51b653de0, player);
  }

  thread function_606beeae377568ad();
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.uplink.var_47b9acc51b653de0, 1);
  wait self.uplink.event.var_464ff1ef779c439d;
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.uplink.var_47b9acc51b653de0, 0);
}

function function_606beeae377568ad() {
  level endon("game_ended");
  self endon("uplink_looted");
  uplink_timeline = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab(self.origin);
  reward_id = self.uplink.var_47b9acc51b653de0;
  time_to_wait = self.uplink.event.var_4febd27038048ffb;
  self.uplink.event waittill("event_deactivated");
  var_607904254b97e282 = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852(uplink_timeline);

  if(var_607904254b97e282 < time_to_wait) {
    wait var_607904254b97e282;
  } else {
    wait time_to_wait;
  }

  scripts\mp\objidpoolmanager::update_objective_state(reward_id, "active");
}

function function_62e43e141326b7c5() {}

function function_e27b61f74dfba712(var_1eaffe65673cf616) {
  requests = [];

  for(i = 0; i < var_1eaffe65673cf616; i++) {
    ai_type = scripts\mp\ai_mp_controller::function_ed108ff3eb578327("guard");
    requests[i] = scripts\mp\ai_mp_controller::function_de59d7cb310c1aff(ai_type);
  }

  return requests;
}

function function_16460a9daba16a6(var_1eaffe65673cf616, var_9ff8d6ff64b1e412, rusher_tier) {
  requests = [];
  tier = 1;

  for(i = 0; i < var_1eaffe65673cf616; i++) {
    if(i >= var_9ff8d6ff64b1e412) {
      ai_type = scripts\mp\ai_mp_controller::function_ed108ff3eb578327("guard");
      tier = 1;
    } else {
      ai_type = "rusher";
      tier = rusher_tier;
    }

    requests[i] = scripts\mp\ai_mp_controller::function_de59d7cb310c1aff(ai_type, tier);
  }

  return requests;
}

function function_3723563cad2eb687(requests, reinforcement_types, params) {
  if(requests.size < 1) {
    return;
  }

  agents = namespace_8d9453d94dd4f401::spawn_reinforcements(self.origin, requests, reinforcement_types, params);
  assertex(agents.size > 0, "<dev string:x16c>");
  waitframe();

  foreach(agent in agents) {
    assertex(isDefined(agent), "<dev string:x1a0>");
    assertex(!isint(agent), "<dev string:x1e3>");

    if(issubstr(agent.agent_type, "rusher") || agent.animsetname == "rusher") {
      agent.pathenemyfightdist = 0;

      if(isDefined(agent.var_4c2e21367dbf09d0)) {
        [[agent.var_4c2e21367dbf09d0]](self.origin, 1000);
      }
    }

    scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "dropWeapon", 0);
    scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "dropGrenade", 0);
  }

  self.agents = array_combine(self.agents, agents);
}

function function_27ba596aafa69f39(force_closest) {
  params = spawnStruct();
  params.ai_category = "dataheist";
  params.ai_priority = "high";
  params.var_a78daf96b4bdf866 = 1500;
  params.var_1b20f5fb6aee28f7 = 500;
  params.var_cf0b51ba5e529a7 = 5;
  params.force_closest = ter_op(isDefined(force_closest), force_closest, 0);
  return params;
}

function function_74428d38b94d6664() {
  rushercount = 0;
  agents = self.agents;

  if(!isDefined(agents) || agents.size <= 0) {
    println("<dev string:x21c>" + self.loc_name);
  } else {
    foreach(agent in agents) {
      if(!is_dead_or_dying(agent) && (issubstr(agent.agent_type, "rusher") || agent.animsetname == "rusher")) {
        rushercount++;
      }
    }
  }

  return rushercount;
}

function __dialog() {}

function function_e8ce5f018d2b942c(dialog, delay) {
  function_63bdbc18191be5f9(dialog, level.players, delay);
}

function function_63bdbc18191be5f9(dialog, players, delay) {
  sound_name = game["dialog"][dialog];
  assertex(isDefined(sound_name), "<dev string:x24f>" + dialog);

  foreach(player in players) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogplayer(dialog, player, undefined, undefined, delay, undefined);
  }
}

function __util() {}

function function_2a43e356ecd267c7(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  nearby_players = [];
  dist_sq = squared(self.var_59ea6b2ef4905653);

  foreach(player in players) {
    if(distance2dsquared(player.origin, self.midpoint) <= dist_sq) {
      nearby_players[nearby_players.size] = player;
    }
  }

  return nearby_players;
}

function function_f8cd8b690a39bec2(team) {
  team_players = scripts\mp\utility\teams::getteamdata(team, "players");
  return scripts\mp\utility\player::getplayersinradius(self.midpoint, self.var_59ea6b2ef4905653, undefined, team_players);
}

function function_f3167a32a9d8b1e8() {
  return scripts\mp\utility\player::getplayersinradius(self.midpoint, self.var_59ea6b2ef4905653);
}

function function_aeb8753295c3577(team) {
  members = [];

  foreach(player in self.nearby_players) {
    if(player.team == team) {
      members[members.size] = player;
    }
  }

  return members;
}

function function_63245662e2e8a786(point) {
  return point.is_valid && point.valid_neighbors.size >= self.var_c740830cdb73800e - 1;
}

function function_45a890c985d26276() {
  valid_points = [];

  foreach(point in self.uplink_points) {
    if(function_63245662e2e8a786(point)) {
      valid_points[valid_points.size] = point;
    }
  }

  return valid_points;
}

function function_24afcbb2ea0ccb49(event_duration) {
  foreach(point in self.uplink_points) {
    point.valid_neighbors = [];
    point.is_valid = 1;

    if(point.used) {
      point.is_valid = 0;

      point.status = "<dev string:x28a>";

      continue;
    }

    if(!istrue(level.br_circle_disabled) && isDefined(level.br_circle)) {
      circle_timeline = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab(point.origin);
      hit_time = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852(circle_timeline);

      if(hit_time < event_duration) {
        point.is_valid = 0;

        point.status = "<dev string:x2b4>" + hit_time + "<dev string:x2d8>";

        continue;
      }
    }

    point.status = "<dev string:x2e4>";
  }

  for(i = 0; i < self.uplink_points.size; i++) {
    point_i = self.uplink_points[i];

    if(!point_i.is_valid) {
      continue;
    }

    for(j = i + 1; j < self.uplink_points.size; j++) {
      point_j = self.uplink_points[j];

      if(!point_j.is_valid) {
        continue;
      }

      dist = distance2dsquared(point_i.origin, point_j.origin);

      if(dist > self.var_adc5129ff19a0342 && dist < self.var_a355ae253087e6ec) {
        point_i.valid_neighbors[point_i.valid_neighbors.size] = point_j;
        point_j.valid_neighbors[point_j.valid_neighbors.size] = point_i;
      }
    }
  }

  dump = dump_new("<dev string:x2ee>");
  dump function_d10a8a5bcebaedf2("<dev string:x310>" + event_duration + "<dev string:x2d8>");
  dump function_d10a8a5bcebaedf2("<dev string:x324>");
  good_starts = [];

  foreach(index, point in self.uplink_points) {
    if(!isDefined(good_starts[point.group])) {
      good_starts[point.group] = 0;
    }

    if(function_63245662e2e8a786(point)) {
      good_starts[point.group] += 1;
    }

    dump function_d10a8a5bcebaedf2("<dev string:x33d>" + index + "<dev string:x342>" + point.group + "<dev string:x349>" + point.status);

    if(point.is_valid) {
      dump dump_add("<dev string:x358>" + point.valid_neighbors.size);
    }
  }

  keys = getarraykeys(good_starts);

  foreach(key in keys) {
    dump function_d10a8a5bcebaedf2(key + "<dev string:x370>" + good_starts[key]);
  }

  dump dump_print();
}

function function_c034dc08d0d12cd8(state) {
  switch (state) {
    case 1:
      return &"MP_BR_PE_DATAHEIST/CAPTURE_STATE_DOWNLOADING";
    case 2:
      return &"MP_BR_PE_DATAHEIST/CAPTURE_STATE_INTERFERENCE";
    case 3:
      return &"MP_BR_PE_DATAHEIST/CAPTURE_STATE_BLOCKED";
    default:
      return "!! INVALID STATE !!";
  }
}

function function_671cc803581d0e65(points_string) {
  points = [];

  if(!isDefined(points_string)) {
    return points;
  }

  var_64598ecf49ab5725 = strtok(points_string, ",");

  foreach(point_string in var_64598ecf49ab5725) {
    point_int = int(point_string);

    if(isint(point_int) && point_int >= 0 && point_int < self.uplink_points.size) {
      points[points.size] = point_int;
      continue;
    }

    iprintlnbold("<dev string:x377>" + point_string + "<dev string:x39e>" + self.uplink_points.size - 1);
  }

  return points;
}

function function_ddfc2513ffdc4ddc() {
  scripts\cp_mp\challenges::function_8359cadd253f9604(self, "dataheist_uplink_complete", 1);
}

function __debug() {}

function debug_init() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x3cf>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x3f1>", "<dev string:x400>", &function_db70bae7732f5204);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x419>", "<dev string:x427>", &function_79f09180ee96a5de);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x43f>", "<dev string:x452>", &function_ca12a92628328432);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x475>", "<dev string:x48b>", &function_c3d7b176abc6b629);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x4ab>", "<dev string:x4c4>", &function_2a20415ca9baa8f9);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x4ed>", "<dev string:x504>", &function_9f75279b43f251c6);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x52b>", "<dev string:x548>", &function_6eeb59951c1edac6);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x56b>", "<dev string:x585>", &function_fd6377203b2db297);
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x5b5>", "<dev string:x5cf>", &function_fd6377203b2db297);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x5ff>", "<dev string:x61c>", &function_83873605c0cc0f3a);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x643>", "<dev string:x65f>", &function_41d60ffda1134555);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x686>", "<dev string:x69d>", &function_7e5217f288b95f5e);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_c3d7b176abc6b629() {
  event_data = level.br_pe_data[%"dataheist"];

  if(!isDefined(event_data)) {
    return;
  }

  init_dvars(event_data);
}

function function_fd6377203b2db297(params) {
  if(!isDefined(params[0]) || !isDefined(params[1])) {
    return;
  }

  value = int(params[1]);

  if(!isint(value)) {
    return;
  }

  setDvar(hashcat(@ "hash_7805fcacedd1cf62", params[0]), value);
}

function function_db70bae7732f5204() {
  level thread scripts\mp\gametypes\br_publicevents::function_e37ee072d95a7c98(%"dataheist");
}

function function_79f09180ee96a5de() {
  level thread scripts\mp\gametypes\br_publicevents::function_2907d01a7d692108(%"dataheist");
}

function function_ca12a92628328432() {
  spawnscriptable("<dev string:x6c4>", level.player.origin, level.player.angles);
}

function function_29327b1833cde79e() {
  level notify("<dev string:x6de>");
  level thread function_9c68002c913d40e5();
}

function function_1497224a9c74808b() {
  level notify("<dev string:x6de>");
}

function function_9c68002c913d40e5() {
  level endon("<dev string:x703>");
  level endon("<dev string:x6de>");
  event_data = level.br_pe_data[%"dataheist"];

  if(!isDefined(event_data)) {
    return;
  }

  position_offset = (0, 0, 40);
  var_f037fc926270b3a2 = (0, 0, 4);
  scale = 0.25;
  color_active = (0, 1, 0);
  color_blocked = (1, 0.65, 0);
  color_range = (0.25, 0.25, 0.25);
  color = undefined;
  print_duration = 1;
  var_e486b5f3a3268190 = int(print_duration / level.framedurationseconds);
  prog = undefined;

  while(true) {
    if(!istrue(event_data.active)) {
      function_1497224a9c74808b();
    }

    foreach(uplink in event_data.uplinks) {
      if(!uplink.var_a5d01c9b7f5297af) {
        color = color_range;
      } else if(uplink.num_blockers > 0) {
        color = color_blocked;
      } else {
        color = color_active;
      }

      print3d(uplink.origin + position_offset - var_f037fc926270b3a2 * 0, "<dev string:x711>" + uplink.origin, color, 1, scale, var_e486b5f3a3268190, 1);
      print3d(uplink.origin + position_offset - var_f037fc926270b3a2 * 1, "<dev string:x71d>" + uplink.angles, color, 1, scale, var_e486b5f3a3268190, 1);
      print3d(uplink.origin + position_offset - var_f037fc926270b3a2 * 2, "<dev string:x729>" + uplink.controlling_team, color, 1, scale, var_e486b5f3a3268190, 1);
      print3d(uplink.origin + position_offset - var_f037fc926270b3a2 * 3, "<dev string:x733>" + uplink.progress * 100 + "<dev string:x741>", color, 1, scale, var_e486b5f3a3268190, 1);

      if(uplink.num_blockers > 0) {
        print3d(uplink.origin + position_offset - var_f037fc926270b3a2 * 4, "<dev string:x746>" + uplink.num_blockers + "<dev string:x755>", color, 1, scale, var_e486b5f3a3268190, 1);
      }
    }

    wait print_duration;
  }
}

function function_7e5217f288b95f5e() {
  event_data = level.br_pe_data[%"dataheist"];

  if(!isDefined(event_data)) {
    return;
  }

  var_f6769d2b85aaf27e = event_data.var_f6769d2b85aaf27e;

  if(!level.br_circle_disabled) {
    var_f6769d2b85aaf27e = min(event_data.var_f6769d2b85aaf27e, scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7() - 5);
  }

  event_data function_24afcbb2ea0ccb49(var_f6769d2b85aaf27e);
  points = [];
  var_ff9e6fbb61b45590 = event_data function_45a890c985d26276();
  points[0] = random(var_ff9e6fbb61b45590);
  nearby_points = array_randomize(points[0].valid_neighbors);

  for(i = 0; i < event_data.var_c740830cdb73800e - 1; i++) {
    points[i + 1] = nearby_points[i];
  }

  print_duration = 5;
  var_e486b5f3a3268190 = int(print_duration / level.framedurationseconds);
  last_point = undefined;

  foreach(point in points) {
    sphere(point.origin, 100, (0, 1, 0), 0, var_e486b5f3a3268190);

    if(isDefined(last_point)) {
      line(point.origin, last_point.origin, (0, 1, 0), 1, 0, var_e486b5f3a3268190);
    }

    last_point = point;
  }
}

function function_83873605c0cc0f3a() {
  level notify("<dev string:x761>");
  level thread function_2634cd6355be1303();
}

function function_41d60ffda1134555() {
  level notify("<dev string:x761>");
}

function function_2634cd6355be1303() {
  level endon("<dev string:x703>");
  level endon("<dev string:x761>");
  event_data = level.br_pe_data[%"dataheist"];

  if(!isDefined(event_data)) {
    return;
  }

  position_offset = (0, 0, 40);
  var_e8285ce19e9412ce = (0, 0, 4);
  scale = 0.25;
  valid_color = (0, 1, 0);
  invalid_color = (1, 0, 0);
  color = undefined;
  print_duration = 5;
  var_e486b5f3a3268190 = int(print_duration / level.framedurationseconds);
  halfheight = event_data.var_ad5deff214441f02 * 0.5;

  while(true) {
    foreach(point in event_data.uplink_points) {
      color = ter_op(point.is_valid, valid_color, invalid_color);
      print3d(point.origin + position_offset + var_e8285ce19e9412ce * 3, "<dev string:x788>" + point.id, color, 1, scale, var_e486b5f3a3268190, 1);
      print3d(point.origin + position_offset + var_e8285ce19e9412ce * 2, "<dev string:x79d>" + point.group, color, 1, scale, var_e486b5f3a3268190, 1);
      print3d(point.origin + position_offset + var_e8285ce19e9412ce * 1, "<dev string:x7a8>" + point.status, color, 1, scale, var_e486b5f3a3268190, 1);
      cylinder(point.origin - (0, 0, halfheight), point.origin + (0, 0, halfheight), event_data.var_6dc1e20d4411f853, color, 0, var_e486b5f3a3268190);
      draw_circle(point.origin, event_data.var_f2f4664f784bb1b0, color, 1, 0, var_e486b5f3a3268190);
    }

    wait print_duration;
  }
}

function function_2a20415ca9baa8f9() {
  event_data = level.br_pe_data[%"dataheist"];

  if(!isDefined(event_data)) {
    return;
  }

  foreach(uplink in event_data.uplinks) {
    uplink notify("<dev string:x7bc>", "<dev string:x7c9>");
  }
}

function function_9f75279b43f251c6() {
  event_data = level.br_pe_data[%"dataheist"];

  if(!isDefined(event_data)) {
    return;
  }

  team = level.player.team;

  foreach(uplink in event_data.uplinks) {
    uplink notify("<dev string:x7bc>", team);
  }
}

function function_6eeb59951c1edac6() {
  event_data = level.br_pe_data[%"dataheist"];

  if(!isDefined(event_data)) {
    return;
  }

  event_data function_7b885b4b79b662b9();
  event_data.var_6d21295d793761b = [];

  foreach(point in event_data.uplink_points) {
    event_data.var_6d21295d793761b = array_add(event_data.var_6d21295d793761b, spawnscriptable("<dev string:x6c4>", point.origin, point.angles));
  }
}

function function_7b885b4b79b662b9() {
  if(isDefined(self.var_6d21295d793761b)) {
    foreach(scriptable in self.var_6d21295d793761b) {
      scriptable freescriptable();
    }
  }
}

function __dump() {}

function dump_new(title) {
  dump = spawnStruct();
  dump.title = title;
  dump.msg = "<dev string:x1c>";
  return dump;
}

function dump_print() {
  println("<dev string:x7e5>" + self.title + "<dev string:x7f9>");
  println(self.msg);
  println("<dev string:x80c>");
}

function dump_add(text) {
  self.msg += text;
}

function function_d10a8a5bcebaedf2(text) {
  dump_add("<dev string:x832>" + text);
}

# /
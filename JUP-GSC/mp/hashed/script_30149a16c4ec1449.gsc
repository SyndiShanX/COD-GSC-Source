/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_30149a16c4ec1449.gsc
*************************************************/

#using script_32d93a194074fa6a;
#using script_35ee5e2cef30eea2;
#using script_47a7dd805c87b33f;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\supply_sweep;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace namespace_52e7ef6f147270cd;

function autoexec main() {
  if(getdvarint(@ "scr_br_jump_master_enable", 0) == 0) {
    return;
  }

  initleveldata();
  initdialog();
  thread function_2b009da164c0e825();

  if(getdvarint(@ "hash_b61b2a0e17b732a5", 0) == 1) {
    function_1e6758ee2481b603();
  }
}

function initleveldata() {
  level.var_52e7ef6f147270cd = spawnStruct();
  level.var_52e7ef6f147270cd.var_933df417910f0e90 = getdvarint(@ "hash_251f06799fe57bc0", 750);
  level.var_52e7ef6f147270cd.var_ad28616282c423e2 = getdvarint(@ "hash_c0830c59f22ac373", 20);
  level.var_52e7ef6f147270cd.var_fb5115870937efca = getdvarint(@ "hash_183dc090a84dc1e3", 20);
  level.var_52e7ef6f147270cd.var_6f071ed9eb553129 = getdvarint(@ "hash_8f614c4746fc140a", 3);
  level.var_52e7ef6f147270cd.var_b4ac4197b8b8c538 = getdvarint(@ "hash_44640a9617ac33ca", 1);
  level.var_52e7ef6f147270cd.var_5fa95b718bb83f53 = getdvarint(@ "hash_b2857df27655a96e", 0);
  level.var_52e7ef6f147270cd.var_ad34ddd1891256ea = [];

  foreach(cashreward in strtok(getDvar(@ "hash_c1696d53d2af75d", "25 50 100"), " ")) {
    level.var_52e7ef6f147270cd.var_ad34ddd1891256ea[level.var_52e7ef6f147270cd.var_ad34ddd1891256ea.size] = int(cashreward);
  }

  level.var_52e7ef6f147270cd.scoreevents = [#"hash_56db108798fc15cf", #"hash_9f7b46e27e962f59", #"hash_7f123e521ff8ec9b"];
  level.var_52e7ef6f147270cd.teaminfos = [];

  level.var_52e7ef6f147270cd.var_fe64bf53eea0ba6 = getdvarint(@ "hash_3204e82e175717e2", 0);

  registersharedfunc(#"JumpMaster", #"hash_2e70af38af7a98db", &function_d0ff3887d23c6207);
}

function initdialog() {
  game["dialog"]["jumpMaster_awardSupplySweep"] = "sqla_grav_lsua";
}

function function_2b009da164c0e825() {
  level endon("game_ended");
  level waittill("prematch_done");

  foreach(team in level.teamnamelist) {
    teamplayers = scripts\mp\utility\teams::getteamdata(team, "players");

    if(teamplayers.size < 2) {
      continue;
    }

    foreach(player in teamplayers) {
      player thread function_31a2c63ee70617dd();
    }
  }

  level waittill("infils_ready");

  foreach(team in level.teamnamelist) {
    teamplayers = scripts\mp\utility\teams::getteamdata(team, "players");

    if(teamplayers.size < 2) {
      continue;
    }

    registerteam(team, teamplayers.size);

    foreach(player in teamplayers) {
      player thread watchplayerdeath();
      player thread watchplayerdisconnect();
      player thread function_6ee66a55f8c211e8();
    }
  }

  thread function_bf009181e339063c();
}

function registerteam(team, teamsize) {
  level.var_52e7ef6f147270cd.teaminfos[team] = spawnStruct();
  level.var_52e7ef6f147270cd.teaminfos[team].var_89c97e93672687c2 = teamsize;
  level.var_52e7ef6f147270cd.teaminfos[team].validteamsize = teamsize;
  level.var_52e7ef6f147270cd.teaminfos[team].var_648ac7a297d4614d = [];
  level.var_52e7ef6f147270cd.teaminfos[team].playerbeams = [];
}

function watchplayerdeath() {
  player = self;
  level endon("game_ended");
  player endon("first_ground_landing");
  player endon("disconnect");
  player waittill("death");

  if(isDefined(player.team) && isDefined(level.var_52e7ef6f147270cd.teaminfos[player.team])) {
    player function_479ff6dfb0157065(player.team);
  }
}

function watchplayerdisconnect() {
  player = self;
  team = player.team;
  level endon("game_ended");
  player endon("first_ground_landing");
  player endon("death");
  player waittill("disconnect");

  if(isDefined(team) && isDefined(level.var_52e7ef6f147270cd.teaminfos[team])) {
    player function_479ff6dfb0157065(team);
    level.var_52e7ef6f147270cd.teaminfos[team].validteamsize--;
  }
}

function function_6ee66a55f8c211e8() {
  player = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player waittill("parachute_landed");

  while(!player isonground() && !player isswimming()) {
    waitframe();
  }

  player notify("first_ground_landing");
  player function_6bbbf5315d65ed51();
}

function function_6bbbf5315d65ed51() {
  player = self;

  if(!isDefined(player.team) || !isDefined(level.var_52e7ef6f147270cd.teaminfos[player.team])) {
    return;
  }

  if(scripts\mp\gametypes\br_c130::ispointinbounds(player.origin)) {
    player function_556a64f81081d8f5();
    player function_aab5f704ec3c1fea();

    if(level.var_52e7ef6f147270cd.var_fe64bf53eea0ba6) {
      player thread function_6ed3639433522f28();
    }
  }

  player function_479ff6dfb0157065(player.team);
}

function function_556a64f81081d8f5() {
  player = self;
  var_b3c9f5af96296480 = spawnStruct();
  var_b3c9f5af96296480.player = player;
  var_b3c9f5af96296480.origin = player.origin;
  level.var_52e7ef6f147270cd.teaminfos[player.team].var_648ac7a297d4614d[level.var_52e7ef6f147270cd.teaminfos[player.team].var_648ac7a297d4614d.size] = var_b3c9f5af96296480;
}

function function_479ff6dfb0157065(team) {
  player = self;
  level.var_52e7ef6f147270cd.teaminfos[team].var_89c97e93672687c2--;

  if(level.var_52e7ef6f147270cd.teaminfos[team].var_89c97e93672687c2 <= 0) {
    function_7eee31a24d3fbb0b(team);
  }

  if(isDefined(player)) {
    player.var_825e4ba9b7006678 = 1;
  }
}

function function_7eee31a24d3fbb0b(team) {
  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    player notify("team_fully_landed");
  }

  thread function_72cd872dc1aa9416(team);
  teamsize = level.var_52e7ef6f147270cd.teaminfos[team].validteamsize;
  var_20d4f6638c24feff = function_21a83e0a61acac46(team);

  if(var_20d4f6638c24feff.size == 0) {
    return;
  }

  foreach(cluster in var_20d4f6638c24feff) {
    clusterplayers = function_a42fdbbb591efcef(cluster);

    if(cluster.size == teamsize) {
      function_df208d9949ca2db(clusterplayers, 2);
      thread function_ea3b7b129831241d(team, clusterplayers, 1);
      continue;
    }

    if(cluster.size > teamsize / 2) {
      function_df208d9949ca2db(clusterplayers, 1);
      thread function_ea3b7b129831241d(team, clusterplayers);
      continue;
    }

    if(cluster.size == teamsize / 2) {
      function_df208d9949ca2db(clusterplayers, 0);
    }
  }
}

function function_21a83e0a61acac46(team) {
  availableplayers = level.var_52e7ef6f147270cd.teaminfos[team].var_648ac7a297d4614d;
  var_14b27c1a0b68dde2 = [];

  while(availableplayers.size > 1) {
    currentplayer = availableplayers[0];
    availableplayers = array_remove_index(availableplayers, 0);
    [newcluster, availableplayers] = currentplayer function_dada6e3cb835602(availableplayers);

    if(newcluster.size > 1) {
      var_14b27c1a0b68dde2[var_14b27c1a0b68dde2.size] = newcluster;
    }
  }

  return var_14b27c1a0b68dde2;
}

function function_dada6e3cb835602(availableplayers) {
  var_db754ef8776026b9 = [self];

  for(i = 0; i < var_db754ef8776026b9.size; i++) {
    var_525f83b11670fdb9 = function_f7a98d43838654af(var_db754ef8776026b9[i].origin, availableplayers, level.var_52e7ef6f147270cd.var_933df417910f0e90);

    if(var_525f83b11670fdb9.size > 0) {
      var_db754ef8776026b9 = array_combine(var_db754ef8776026b9, var_525f83b11670fdb9);
      availableplayers = array_remove_array(availableplayers, var_525f83b11670fdb9);

      if(availableplayers.size == 0) {
        break;
      }
    }
  }

  return [var_db754ef8776026b9, availableplayers];
}

function function_a42fdbbb591efcef(var_847a75f6564a75c9) {
  validplayers = [];

  foreach(playerinfo in var_847a75f6564a75c9) {
    player = playerinfo.player;

    if(isDefined(player)) {
      validplayers[validplayers.size] = player;
    }
  }

  return validplayers;
}

function function_aab5f704ec3c1fea() {
  player = self;
  playerbeam = spawnStruct();
  groundposition = player function_72661518bf142546();
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", groundposition, "hud_icon_objective_squad_landing");
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(objid, &"MP_BR_INGAME/SQUAD_LANDING");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
    scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(objid, 1);
    player function_db159b649ea79356(objid);
    playerbeam.objid = objid;
  }

  level.var_52e7ef6f147270cd.teaminfos[player.team].playerbeams[level.var_52e7ef6f147270cd.teaminfos[player.team].playerbeams.size] = playerbeam;
}

function function_db159b649ea79356(var_31c5b182175253f5) {
  player = self;
  teamplayers = scripts\mp\utility\teams::getteamdata(player.team, "players");
  objective_removeallfrommask(var_31c5b182175253f5);

  foreach(otherplayer in teamplayers) {
    if(isbot(otherplayer) || otherplayer == player) {
      continue;
    }

    objective_addclienttomask(var_31c5b182175253f5, otherplayer);
  }

  objective_showtoplayersinmask(var_31c5b182175253f5);
}

function function_72661518bf142546() {
  player = self;
  groundposition = getgroundposition(player.origin, 1);
  waterheight = getwaterheightatlocation(groundposition);

  if(isDefined(waterheight) && groundposition[2] < waterheight) {
    groundposition = (groundposition[0], groundposition[1], waterheight);
  }

  return groundposition;
}

function function_72cd872dc1aa9416(team) {
  wait level.var_52e7ef6f147270cd.var_b4ac4197b8b8c538;

  foreach(playerbeam in level.var_52e7ef6f147270cd.teaminfos[team].playerbeams) {
    if(isDefined(playerbeam.objid)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(playerbeam.objid);
    }
  }
}

function function_df208d9949ca2db(players, var_6093665a701fddb2) {
  var_2bf64bfa9adef507 = int(min(var_6093665a701fddb2, level.var_52e7ef6f147270cd.var_ad34ddd1891256ea.size - 1));
  cashreward = level.var_52e7ef6f147270cd.var_ad34ddd1891256ea[var_2bf64bfa9adef507];
  scoreevent = level.var_52e7ef6f147270cd.scoreevents[var_6093665a701fddb2];

  foreach(player in players) {
    player notify("jump_master_succeed");
    player scripts\mp\gametypes\br_plunder::playerplunderevent(cashreward, 1, undefined, undefined, 1, 1);
    player scripts\mp\utility\points::doscoreevent(scoreevent);
    scripts\cp_mp\challenges::function_8359cadd253f9604(player, "squad_landing", 1);

    if(level.var_52e7ef6f147270cd.var_5fa95b718bb83f53 && (var_6093665a701fddb2 == 1 || var_6093665a701fddb2 == 2)) {
      player br_pickups::function_e8fc4167d33ed55d("specialty_running_sneakers");
    }
  }
}

function private function_8d3fcffd3594690e() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(!istrue(self.var_825e4ba9b7006678) || !istrue(self.var_3e7e3a6a70bcfeb8)) {
    self waittill("luinotifyserver", message);

    switch (message) {
      case #"hash_8a66337b71ccec4c":
        self.var_3e7e3a6a70bcfeb8 = 1;
        break;
      case #"hash_899f65d5013659d0":
        self.var_3e7e3a6a70bcfeb8 = 0;
        self notify("br_jump_master_tacmap_closed");
        break;
    }
  }
}

function function_2d977d0c59fddf55(pingindex) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  level scripts\mp\flags::gameflagwait("infil_animatic_complete");

  if(istrue(player.var_825e4ba9b7006678)) {
    return;
  }

  if(istrue(player.var_3e7e3a6a70bcfeb8)) {
    self waittill("br_jump_master_tacmap_closed");
  }

  if(istrue(player.var_ec2b4913eadf6267)) {
    return;
  }

  player.var_ec2b4913eadf6267 = 1;
  player scripts\mp\utility\points::doscoreevent(#"hash_6a39e883c87ef76f");
}

function function_31a2c63ee70617dd() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("team_fully_landed");
  thread function_8d3fcffd3594690e();

  while(true) {
    player waittill("calloutmarkerping_notifyhandled", notification, pingindex, optionalarg);

    if(!isDefined(notification)) {
      continue;
    }

    switch (notification) {
      case #"hash_11ea00e1a93830a7":
      case #"hash_bf30d88fa3f51a24":
        player thread function_2d977d0c59fddf55(pingindex);
        break;
      case #"hash_58db4293949d3d7e":
        if(!isDefined(optionalarg)) {
          break;
        }

        var_ed14a5f83c5e7295 = getentbynum(optionalarg);

        if(isDefined(var_ed14a5f83c5e7295)) {
          var_ed14a5f83c5e7295 thread function_2d977d0c59fddf55(pingindex);
        }

        break;
      default:
        break;
    }
  }
}

function function_ea3b7b129831241d(team, eligibleplayers, var_28fc1cad1c84a2b8) {
  level endon("game_ended");
  level endon("jump_master_supply_sweep_stop" + team);
  sweepduration = istrue(var_28fc1cad1c84a2b8) ? level.var_52e7ef6f147270cd.var_ad28616282c423e2 : level.var_52e7ef6f147270cd.var_fb5115870937efca;
  level.var_52e7ef6f147270cd.teaminfos[team].var_28fc1cad1c84a2b8 = var_28fc1cad1c84a2b8;
  level.var_52e7ef6f147270cd.teaminfos[team].var_d4f159884b299bb5 = 1;
  scripts\mp\gametypes\br_public::brleaderdialog("jumpMaster_awardSupplySweep", 1, eligibleplayers, 0, 0, undefined, "dx_br_brdm_");

  foreach(player in eligibleplayers) {
    player thread scripts\mp\hud_message::showsplash("br_jump_master_supply_sweep_coming");
  }

  wait level.var_52e7ef6f147270cd.var_6f071ed9eb553129;

  if(!function_f067369ec1cab391(team, eligibleplayers)) {
    return;
  }

  function_981149f0bfc968e2(eligibleplayers, 1);
  wait sweepduration;
  function_981149f0bfc968e2(eligibleplayers, 0);
}

function function_981149f0bfc968e2(eligibleplayers, enable) {
  foreach(player in eligibleplayers) {
    if(!isDefined(player)) {
      continue;
    }

    player function_c682f38a22ea89d6(enable);
    player function_6d446993dd36bb41(enable);

    if(enable) {
      player playsoundtoplayer("activate_supply_sweep", player);
    }
  }
}

function function_f067369ec1cab391(team, eligibleplayers) {
  activesupplysweeps = level.teamdata[team]["activeSupplySweeps"];

  if(isDefined(activesupplysweeps) && activesupplysweeps.size > 0) {
    return false;
  }

  foreach(player in eligibleplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!player scripts\mp\killstreaks\supply_sweep::function_5a93fbbb0fd1f33e()) {
      return false;
    }
  }

  return true;
}

function function_d0ff3887d23c6207() {
  data = spawnStruct();
  data.key = "JumpMaster";
  data.var_2297e189e2eb2818 = [0, 1, 2, 3];
  data.priority = 30;
  data.condfunc = &function_3f94fd264fd2dce3;
  data.execfunc = &function_9db35e8d23bb631e;
  return data;
}

function function_9db35d8d23bb60eb() {
  namespace_b1d233abf1e31488::function_6fba31415caeee6e(1);
  self notify("currentContextualTipCompleted");
}

function function_9db35e8d23bb631e() {
  self endon("disconnect");
  self endon("jump_master_succeed");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  self endon("currentContextualTipAbortEnded");

  if(istrue(level.var_52e7ef6f147270cd.var_5fa95b718bb83f53)) {
    namespace_b1d233abf1e31488::function_9e0151baa208fe9e(#"jump_master");
  } else {
    namespace_b1d233abf1e31488::function_9e0151baa208fe9e(#"hash_a5eadaee7c3bdfab");
  }

  childthread namespace_c7fbb8d68025450d::function_7fdf3cf66304f3c5(self, 60);
  function_b4b8cb1efda1450(&function_9db35d8d23bb60eb);
  self waittill("team_fully_landed");
  waitframe();
  self notify("currentContextualTipAborted");
}

function function_3f94fd264fd2dce3(params) {
  if(!isDefined(level.var_52e7ef6f147270cd)) {
    return 0;
  }

  if(!isDefined(level.var_52e7ef6f147270cd.teaminfos[self.team])) {
    return 0;
  }

  return namespace_196a3629befb677e::function_6fc17f2a58009875();
}

function function_b4b8cb1efda1450(var_8cdf4ff04b7775ec, initcallback) {
  thread function_80c4e37f268b87cf(var_8cdf4ff04b7775ec, initcallback);
}

function function_80c4e37f268b87cf(var_8cdf4ff04b7775ec, initcallback) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  assert(isDefined(self));
  assert(isDefined(var_8cdf4ff04b7775ec));

  if(isDefined(initcallback)) {
    self[[initcallback]]();
  }

  self waittill("jump_master_succeed");
  self[[var_8cdf4ff04b7775ec]]();
}

function function_bf009181e339063c() {
  level waittill("game_ended");
  var_2a3cb7a6998badb6 = 0;
  var_88d835e248fac8d = 0;
  var_df7782467367638c = 0;

  foreach(teaminfos in level.var_52e7ef6f147270cd.teaminfos) {
    if(teaminfos.validteamsize > 1) {
      var_df7782467367638c++;

      if(istrue(teaminfos.var_d4f159884b299bb5)) {
        var_2a3cb7a6998badb6++;

        if(istrue(teaminfos.var_28fc1cad1c84a2b8)) {
          var_88d835e248fac8d++;
        }
      }
    }
  }

  dlog_recordevent("dlog_event_jump_master_supply_sweep_match_event", ["supply_sweep_team_count", var_2a3cb7a6998badb6, "supply_sweep_full_team_count", var_88d835e248fac8d, "valid_teams_count", var_df7782467367638c]);
}

function private function_33edbbdf9f925cc7(locations) {
  registerteam("<dev string:x1c>", locations.size);

  foreach(location in locations) {
    dummy = spawnStruct();
    dummy.origin = location;
    dummy.team = "<dev string:x1c>";
    dummy function_556a64f81081d8f5();
  }
}

function private function_1e6758ee2481b603() {
  fardistance = 751;
  neardistance = 749;
  function_33edbbdf9f925cc7([]);
  var_b4d2a98e3fdeca31 = function_21a83e0a61acac46("<dev string:x1c>");
  assert(var_b4d2a98e3fdeca31.size == 0, "<dev string:x25>");
  function_33edbbdf9f925cc7([(0, 0, 0), (fardistance, 0, 0), (fardistance * 2, 0, 0), (fardistance * 3, 0, 0), (fardistance * 4, 0, 0)]);
  var_b4d2a98e3fdeca31 = function_21a83e0a61acac46("<dev string:x1c>");
  assert(var_b4d2a98e3fdeca31.size == 0, "<dev string:x54>");
  function_33edbbdf9f925cc7([(0, 0, 0), (0, 0, fardistance), (0, 0, fardistance * 2)]);
  var_b4d2a98e3fdeca31 = function_21a83e0a61acac46("<dev string:x1c>");
  assert(var_b4d2a98e3fdeca31.size == 1, "<dev string:x99>");
  function_33edbbdf9f925cc7([(neardistance * 3, 0, 0), (0, neardistance, 0), (neardistance, 0, 0), (neardistance * 2, 0, 0), (neardistance * 4, 0, 0)]);
  var_b4d2a98e3fdeca31 = function_21a83e0a61acac46("<dev string:x1c>");
  assert(var_b4d2a98e3fdeca31.size == 1, "<dev string:x103>");
  var_8ef67f87a1f70228 = [(0, 0, 0), (neardistance, 0, 0), (0, neardistance, 0), (fardistance, fardistance, 0), (fardistance + neardistance, fardistance, 0), (fardistance + neardistance * 2, fardistance, 0), (fardistance * -1, fardistance * -1, 0), (fardistance * -1 - neardistance, fardistance * -1, 0), (fardistance * -1, fardistance * -1 - neardistance, fardistance * 10), (fardistance * 10, fardistance * 10, 0)];
  function_a068835f4a40f493(var_8ef67f87a1f70228);
  var_8ef67f87a1f70228 array_reverse(var_8ef67f87a1f70228);
  function_a068835f4a40f493(var_8ef67f87a1f70228);

  for(i = 0; i < 50; i++) {
    var_8ef67f87a1f70228 = array_randomize(var_8ef67f87a1f70228);
    function_a068835f4a40f493(var_8ef67f87a1f70228);
  }

  var_8ef67f87a1f70228 = array_combine(var_8ef67f87a1f70228, [(fardistance / 2, fardistance / 2, 0), (fardistance * -1 / 2, fardistance * -1 / 2, 0)]);
  function_33edbbdf9f925cc7(var_8ef67f87a1f70228);
  var_b4d2a98e3fdeca31 = function_21a83e0a61acac46("<dev string:x1c>");
  assert(var_b4d2a98e3fdeca31.size == 1, "<dev string:x18c>");
}

function private function_a068835f4a40f493(teamlocations) {
  function_33edbbdf9f925cc7(teamlocations);
  var_b4d2a98e3fdeca31 = function_21a83e0a61acac46("<dev string:x1c>");
  assert(var_b4d2a98e3fdeca31.size == 3, "<dev string:x1db>");

  foreach(cluster in var_b4d2a98e3fdeca31) {
    assert(cluster.size == 3, "<dev string:x210>" + cluster.size);
  }
}

function private function_6ed3639433522f28() {
  level endon("<dev string:x243>");
  center = self.origin;
  radius = level.var_52e7ef6f147270cd.var_933df417910f0e90;

  while(true) {
    waitframe();
    cylinder(center, center + (0, 0, 2000), radius, (1, 1, 0), 1, 1);
  }
}

# /
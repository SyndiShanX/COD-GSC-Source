/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_c00335a7aeb2728.gsc
************************************************/

#using script_1174abedbefe9ada;
#using script_15ca41a3fbb0e379;
#using script_1c9fa9bfb0a2fd44;
#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using script_b7a9ce0a2282b79;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_safes;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_af15d3221a0949b3;

function function_2eddefe4d621123b() {
  if(!isDefined(level.searchprops)) {
    level.var_24a15c328e009c6d = 1;
    level.searchprops = spawnStruct();
    level.searchprops.domradius = getdvarint(@ "hash_71edffc21985cf3c", 128);
    level.searchprops.capturetime = getdvarfloat(@ "hash_44a66b39ccca38b1", 20);
    level.searchprops.var_34ef5bf2eebf19eb = getdvarfloat(@ "hash_a10f5fb90206dbc", 6);
    level.searchprops.circleradius = getdvarint(@ "hash_a3f5f94b78758c13", 1000);
    level.searchprops.var_e3aa1de9d96e0086 = getdvarint(@ "hash_d411b19dd9e74816", 250);
    level.searchprops.domflagmaxdist = getdvarint(@ "hash_2aa1ea2e4cb8c3d2", 15000);
    level.searchprops.rewardsintel = getdvarint(@ "hash_9291026d90b23401", 0);
    level.searchprops.var_b820cb1ac6257b4b = getdvarint(@ "hash_6e810109e7c6b4f2", 128);
    level.searchprops.reinforcetower = getdvarint(@ "hash_6e6ad32f4df0a3cd", 0);
  }
}

function function_80d68c9701e1aea5(data) {
  function_2eddefe4d621123b();
  function_7828c1afe3365dd2();
  var_fee1c80afe3e660 = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "dmz_intel_laptop");
  level.var_d8db1602c8bf473e["dmz_intel_laptop"] = &function_e76e3c2aae1d1be6;
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_upload_station", &function_4e64a11d42d9b58a);
  var_7626533fb4b71334 = getStructArray("dmz_dom_tower", "script_noteworthy");

  if(getdvarint(@ "hash_698d4fdc619d5572", 1)) {
    level.domnodes = var_7626533fb4b71334;
  } else {
    level.domnodes = [];

    foreach(node in var_7626533fb4b71334) {
      nodepoi = node.poi;

      if(!isDefined(nodepoi)) {
        nodepoi = scripts\mp\poi::poi_findpoioriginisin(node.origin);
      }

      if(!scripts\mp\poi::poi_issystemactive() || isDefined(nodepoi) && scripts\mp\poi::poi_ispoiactive(nodepoi) && !namespace_7789f919216d38a2::function_cdcab1374db7f007(node.origin) && !namespace_9823ee6035594d67::function_f59f68adc71d49b3(node.origin)) {
        level.domnodes[level.domnodes.size] = node;
      }
    }
  }

  if(getdvarint(@ "hash_9d58313058bb5cfd", 1)) {
    foreach(domnode in level.domnodes) {
      spawnStruct() thread function_443a192943945265(domnode, level.searchprops.var_34ef5bf2eebf19eb);
    }
  }

  level.var_2c8f684c8de8ea1 = [];

  foreach(node in var_fee1c80afe3e660) {
    node setscriptablepartstate("dmz_intel_laptop", "actually_hidden");
    var_f649b1da590a1250 = get_array_of_closest(node.origin, level.domnodes, undefined, undefined, level.searchprops.domflagmaxdist);

    if(!isDefined(var_f649b1da590a1250) || !isDefined(var_f649b1da590a1250[0])) {
      continue;
    }

    node.domnode = var_f649b1da590a1250[0];
    level.var_2c8f684c8de8ea1[level.var_2c8f684c8de8ea1.size] = node;
  }

  level thread function_e3c59f87c74a628();

  function_b713f2d39b34540f(data, &function_c2d2a192e013115a, level.var_2c8f684c8de8ea1);
}

function function_a07f7c4c0c4ef8e3() {
  return getStructArray("<dev string:x1c>", "<dev string:x2d>");
}

#using_animtree("script_model");

function function_7828c1afe3365dd2() {
  level.scr_animtree["upload_station_player"] = #animtree;
  level.scr_anim["upload_station_player"]["upload_station_enter"] = % iw9_dmz_uploadstation_enter_sdr;
  level.scr_eventanim["upload_station_player"]["upload_station_enter"] = % "upload_station_enter";
  level.scr_viewmodelanim["upload_station_player"]["upload_station_enter"] = "iw9_dmz_uploadstation_enter_sdr";
  level.scr_anim["upload_station_player"]["upload_station_type"] = % iw9_dmz_uploadstation_type_sdr;
  level.scr_eventanim["upload_station_player"]["upload_station_type"] = % "upload_station_type";
  level.scr_viewmodelanim["upload_station_player"]["upload_station_type"] = "iw9_dmz_uploadstation_type_sdr";
  level.scr_anim["upload_station_player"]["upload_station_exit"] = % iw9_dmz_uploadstation_exit_sdr;
  level.scr_eventanim["upload_station_player"]["upload_station_exit"] = % "upload_station_exit";
  level.scr_viewmodelanim["upload_station_player"]["upload_station_exit"] = "iw9_dmz_uploadstation_exit_sdr";
  level.scr_anim["upload_station_player"]["upload_station_exit_cancel"] = % iw9_dmz_uploadstation_exit_cancel_sdr;
  level.scr_eventanim["upload_station_player"]["upload_station_exit_cancel"] = % "upload_station_exit_cancel";
  level.scr_viewmodelanim["upload_station_player"]["upload_station_exit_cancel"] = "iw9_dmz_uploadstation_exit_cancel_sdr";
  level.scr_anim["upload_station_harddrive"]["upload_station_enter"] = % iw9_dmz_uploadstation_enter_hdd;
  level.scr_eventanim["upload_station_harddrive"]["upload_station_enter"] = % "upload_station_enter";
  level.scr_viewmodelanim["upload_station_harddrive"]["upload_station_enter"] = "iw9_dmz_uploadstation_enter_hdd";
  level.scr_anim["upload_station_harddrive"]["upload_station_type"] = % iw9_dmz_uploadstation_type_hdd;
  level.scr_eventanim["upload_station_harddrive"]["upload_station_type"] = % "upload_station_type";
  level.scr_viewmodelanim["upload_station_harddrive"]["upload_station_type"] = "iw9_dmz_uploadstation_type_hdd";
  level.scr_anim["upload_station_harddrive"]["upload_station_exit"] = % iw9_dmz_uploadstation_exit_hdd;
  level.scr_eventanim["upload_station_harddrive"]["upload_station_exit"] = % "upload_station_exit";
  level.scr_viewmodelanim["upload_station_harddrive"]["upload_station_exit"] = "iw9_dmz_uploadstation_exit_hdd";
  level.scr_anim["upload_station_harddrive"]["upload_station_exit_cancel"] = % iw9_dmz_uploadstation_exit_cancel_hdd;
  level.scr_eventanim["upload_station_harddrive"]["upload_station_exit_cancel"] = % "upload_station_exit_cancel";
  level.scr_viewmodelanim["upload_station_harddrive"]["upload_station_exit_cancel"] = "iw9_dmz_uploadstation_exit_cancel_hdd";
}

function function_c2d2a192e013115a(activity, node) {
  task = task_create(activity);
  task.funcs["onInit"] = &function_a090fd5db1d41d09;
  task.funcs["onTeamAssigned"] = &function_5e492a2ae2c58516;
  task.funcs["onPlayerJoined"] = &function_406fed676340e8b;
  task.funcs["onPlayerRemoved"] = &function_4790ab669e14dbca;
  task.funcs["onTeamStart"] = &function_fe978bb57c108c1e;
  task.funcs["onCancel"] = &function_8e8de0da459365e9;
  task.ref = "dmz_domination_explore";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.node = node;

  if(!isDefined(level.var_5ef55b8e3822f67e)) {
    level.var_5ef55b8e3822f67e = 0;
  }

  task.assignmentname = "domMission" + level.var_5ef55b8e3822f67e;
  level.var_5ef55b8e3822f67e++;
  return task;
}

function function_a090fd5db1d41d09() {
  self.item = self.node;
  self.item.task = self;
  self.item setscriptablepartstate("dmz_intel_laptop", "unusable");
  self.item.harddrive = spawnscriptable("dmz_intel_harddrive", self.item.origin, self.item.angles);
  self.numagents = 0;
  self.domnode = self.node.domnode;
  self.questcircles = [];

  if(!isDefined(self.domnode) || namespace_9823ee6035594d67::function_f59f68adc71d49b3(self.item.origin)) {
    task_ended();
    return;
  }

  self.activity.origin = self.item.origin;

  if(istrue(self.domnode.setup)) {
    self.domflag = self.domnode.flag;
    self.domflag.tasks[self.domflag.tasks.size] = self;
  } else {
    thread function_443a192943945265(self.domnode, level.searchprops.var_34ef5bf2eebf19eb);
  }

  self.unlocked = 0;
  circlelocation = function_ab50f62a3a730400(self.item.origin, level.searchprops.circleradius);
  self.circlecenter = circlelocation;
  self.circleradius = level.searchprops.circleradius;
  function_325390edb051cd5d("Explore_Dmz", [circlelocation], level.searchprops.circleradius + level.searchprops.var_e3aa1de9d96e0086);
  self.curorigin = circlelocation;
  self.offset3d = (0, 0, 50);
  function_c847bfd52c064289(circlelocation + (0, 0, 750), "intel");

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x42>", self.activity.name, undefined, "<dev string:x57>", undefined, undefined, self.activity.poi, self.node.origin);
}

function function_443a192943945265(node, var_34ef5bf2eebf19eb) {
  if(!isDefined(self.domflag)) {
    self.domflag = spawnscriptable("dmz_upload_station", node.origin, node.angles);
  }

  self.domflag.poi = scripts\mp\poi::poi_findpoioriginisin(node.origin, 1);

  if(isDefined(self.activity)) {
    namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x70>", self.activity.name, undefined, "<dev string:x84>", undefined, undefined, self.activity.poi, node.origin);
  }

  domradius = function_9258edce111428c2();
  self.domflag.trigger = spawn("trigger_radius", node.origin, 0, int(domradius), int(domradius));

  if(isDefined(self.activity)) {
    namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x9a>", self.activity.name, undefined, "<dev string:xaa>", undefined, undefined, self.activity.poi, node.origin);
  }

  self.domflag.trigger trigger_on();
  self.domflag.playersintrigger = [];
  self.domflag thread function_a93281d34421174f();
  self.domflag.var_34ef5bf2eebf19eb = var_34ef5bf2eebf19eb;
  self.domflag.teamsusing = [];
  self.domflag.tasks = [self];
  node.setup = 1;
  node.flag = self.domflag;
  node.trigger = self.domflag.trigger;
}

function function_fe978bb57c108c1e(teamname) {}

function function_406fed676340e8b(player) {
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);

  if(!istrue(self.unlocked)) {
    function_1851e9cfb7687f68(player);
    self.item enablescriptableplayeruse(player);
  }
}

function function_4790ab669e14dbca(player) {
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.icon, player);

  if(!istrue(self.unlocked)) {
    function_556fb3a465f0e978(player);
    self.item disablescriptableplayeruse(player);
  }
}

function function_5e492a2ae2c58516(teamname) {
  function_e54df8560bf7dc64(teamname);
  thread function_c373f127dafc389a(teamname);

  if(scripts\mp\gametypes\br_gametype_dmz::function_a7f9424636f37fb1()) {
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("secure_intel_assigned_generic", teamname);
  } else {
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("secure_intel_assigned", teamname);
  }

  function_1759acfd39bb5edf("dmz_dom_assigned", teamname);
  function_c1fd3441ccfba6f8(teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  self.item setscriptablepartstate("dmz_intel_laptop", "usable");
  players = getteamdata(teamname, "players");

  foreach(player in level.players) {
    self.item disablescriptableplayeruse(player);
  }

  foreach(player in players) {
    self.item enablescriptableplayeruse(player);
  }

  if(!isDefined(self.canreinforce)) {
    self.canreinforce = 1;
  }
}

function function_8e8de0da459365e9(teamname) {
  players = getteamdata(teamname, "players");

  foreach(player in players) {
    if(isDefined(self.item)) {
      self.item disablescriptableplayeruse(player);
    }
  }

  function_1ca101629b43a466(players);
  task_ended();
}

function function_1ca101629b43a466(playersonteam) {
  if(isDefined(playersonteam)) {
    foreach(player in playersonteam) {
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.icon, player);
    }
  }

  function_2476daefa3384c5e();
  function_629ed367d1393020();
  self.domflag setscriptablepartstate("upload_screen", "screen_off");

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    namespace_a12ab42942591824::intel_resetusability(self.domflag, self.teams[0]);
  }

  self.domflag.tasks = array_remove(self.domflag.tasks, self);
}

function private function_804eb3448706c9bc(teamname) {
  playersonteam = getteamdata(teamname, "players");
  function_1ca101629b43a466(playersonteam);
  thread function_8c550607fb966b6f(teamname, self.domflag.origin);
  function_cd4f277cf0d6a560(teamname);
  function_a1738a95d7aa8094("dmz_upload_complete", "dom", self.activity.cashreward, teamname);
  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("secure_intel_win", teamname, 1);
  function_c1fd3441ccfba6f8(teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
  waitframe();
  task_ended(teamname, 1);
}

function private function_e76e3c2aae1d1be6(struct, player) {
  instance = struct.instance;

  if(function_7bf020dc824bddb7(instance, player)) {
    task = instance.task;
    team = task.teams[0];
    task function_5314298e777e5688("dmz_domination");
    task function_1759acfd39bb5edf("dmz_located_intel", team);
    function_c1fd3441ccfba6f8(team, "dmz_activity_action", 1.5, "dmz_activity_action_classic");
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("secure_intel_found", team);

    if(istrue(level.searchprops.reinforcetower)) {
      task thread function_ba861064e674a7cb();
    }

    return 1;
  }

  return 2;
}

function function_7bf020dc824bddb7(instance, player) {
  task = instance.task;

  if(isDefined(task) && isDefined(task.teams) && isDefined(task.teams[0]) && task.teams[0] == player.team) {
    instance setscriptablepartstate("dmz_intel_laptop", "hidden");
    instance.harddrive setscriptablepartstate("dmz_intel_harddrive", "closing");
    players = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(player in players) {
      player setclientomnvar("ui_hard_drive_taken", 1);
    }

    instance.harddrive thread function_63863c633bfa3c96();
    level thread function_2c2a32e879a2bcfd(players);
    team = task.teams[0];
    task notify("item_found");
    task.unlocked = 1;
    task function_2476daefa3384c5e();
    objective_position(task.icon, task.domflag.origin + (0, 0, 50));
    task function_cef2ed613a8338be(task.domflag.origin + (0, 0, 75));

    foreach(player in getteamdata(team, "players")) {
      task.domflag enablescriptableplayeruse(player);
    }

    task thread function_c63511286db73ab1();
    return true;
  }

  return false;
}

function function_63863c633bfa3c96() {
  level endon("game_ended");
  wait 1;
  self freescriptable();
}

function function_2c2a32e879a2bcfd(players) {
  level endon("game_ended");
  wait 1.25;

  foreach(player in players) {
    if(isDefined(player)) {
      player setclientomnvar("ui_hard_drive_taken", 0);
    }
  }
}

function function_ba861064e674a7cb() {
  level endon("game_ended");
  self endon("task_ended");
  var_d280b3d2ad13e4db = 10;
  var_88cbf247ff1e11b1 = utility::function_98a826b6b6d0d118(self.domflag.origin + (0, 0, -1000), 2500, undefined, 3000, 0).size;
  var_5c362dcaaa44cdf0 = [];

  while(var_88cbf247ff1e11b1 < var_d280b3d2ad13e4db) {
    var_5c362dcaaa44cdf0 = scripts\mp\ai_mp_controller::function_353fecd1549f5f42(self.domflag.origin, 4000, undefined, var_d280b3d2ad13e4db - var_88cbf247ff1e11b1);
    var_88cbf247ff1e11b1 += var_5c362dcaaa44cdf0.size;

    if(var_88cbf247ff1e11b1 >= var_d280b3d2ad13e4db) {
      return;
    }

    scripts\mp\ai_mp_controller::function_77acc10c4823dd8a(5, self.domflag.origin, "high", "mission", "domReinforcements", undefined, undefined, 1, self.node.poi);
    var_88cbf247ff1e11b1 += 5;
    wait randomfloatrange(22, 28);
  }
}

function function_c373f127dafc389a(team, ignoreheight) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("item_found");
  var_b820cb1ac6257b4b = function_7f460fe8d509a260();
  var_ef6c8282fde1f7bb = var_b820cb1ac6257b4b * var_b820cb1ac6257b4b;
  intel = function_133d4b6d206849d8();
  wait 5;

  if(isDefined(self.icon)) {
    objective_setplayintro(self.icon, 0);
  }

  var_19725aa1e0e97456 = 0;

  while(true) {
    wait 1;
    players = getteamdata(team, "players");
    objective_showtoplayersinmask(self.icon);
    var_19725aa1e0e97456 = 0;
    var_500527a31ce67ea7 = 0;

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(istrue(ignoreheight)) {
        var_500527a31ce67ea7 = distance2dsquared(player.origin, intel.origin);
      } else {
        var_500527a31ce67ea7 = distancesquared(player.origin, intel.origin);
      }

      if(var_500527a31ce67ea7 < var_ef6c8282fde1f7bb) {
        var_19725aa1e0e97456 = 1;
        break;
      }
    }

    if(var_19725aa1e0e97456) {
      objective_setplayintro(self.icon, 1);
      objective_position(self.icon, intel.origin + (0, 0, 10));

      foreach(player in players) {
        if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        objective_addclienttomask(self.icon, player);
      }

      continue;
    }

    objective_setplayintro(self.icon, 0);
    objective_position(self.icon, self.circlecenter + (0, 0, 750));

    foreach(player in players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      var_8c64faa69e531014 = distance2dsquared(player.origin, self.circlecenter);

      if(var_8c64faa69e531014 <= self.circleradius * self.circleradius) {
        objective_removeclientfrommask(self.icon, player);
        continue;
      }

      objective_addclienttomask(self.icon, player);
    }
  }
}

function function_c63511286db73ab1() {
  level endon("game_ended");
  self endon("task_ended");
  approachdistsq = 1000000;

  if(isDefined(level.var_d6ae5cc7b162c730) && isDefined(level.var_d6ae5cc7b162c730.var_30326e6a2f443451)) {
    approachdistsq = level.var_d6ae5cc7b162c730.var_30326e6a2f443451;
  }

  while(true) {
    players = getteamdata(self.teams[0], "players");

    foreach(player in players) {
      distsq = distance2dsquared(player.origin, self.domflag.origin);

      if(distsq < approachdistsq) {
        scripts\cp_mp\overlord::playevent("secure_intel_near_uav", players);
        function_c1fd3441ccfba6f8(self.teams[0], "dmz_activity_tension", 0, "dmz_activity_tension_classic");
        return;
      }
    }

    wait 1;
  }
}

function function_4e64a11d42d9b58a(instance, part, state, useplayer, bautouse, usestring) {
  if(isDefined(instance.animatingplayer) || !isDefined(useplayer.team) || isDefined(instance.teamsusing[useplayer.team])) {
    useplayer scripts\mp\hud_message::showerrormessage("MP/CANNOT_USE_GENERIC");
    return;
  }

  if(useplayer isthrowinggrenade() || useplayer isswitchingweapon() || isDefined(useplayer getheldoffhand()) && !isnullweapon(useplayer getheldoffhand())) {
    if(isDefined(level.showerrormessagefunc) && isDefined(level.br_pickups.var_859f4bd204f1259)) {
      useplayer[[level.showerrormessagefunc]](level.br_pickups.var_859f4bd204f1259);
    }

    return;
  }

  playertask = function_37416c14e9703fb6(useplayer);

  if(isDefined(playertask) && istrue(playertask.unlocked) && isDefined(instance.tasks) && array_contains(instance.tasks, playertask)) {
    thread function_a22ac2645c342456(instance, part, state, useplayer, bautouse, usestring);
    return;
  }

  pmcsuccess = istrue(instance scripts\engine\utility::callsharedfunc("pmc_missions", "onUseUploadStation", useplayer));

  if(!pmcsuccess) {
    useplayer scripts\mp\hud_message::showerrormessage("DMZ/UPLOAD_STATION_USE_ERR");
  }
}

function function_a22ac2645c342456(instance, part, state, useplayer, bautouse, usestring) {
  function_94f937f05d8740c8(instance, useplayer);

  if(istrue(instance.successfuluse)) {
    playertask = undefined;

    foreach(task in instance.tasks) {
      if(function_8158903a6e2f32fd(task, useplayer)) {
        playertask = task;
        break;
      }
    }

    if(isDefined(playertask)) {
      if(scripts\mp\utility\game::getsubgametype() != "dmz") {
        level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer("mission_intel_upload", useplayer.team, useplayer, 1, undefined, 2);
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("mission_intel_upload_first_person", useplayer, 1, undefined, 2);

        if(getdvarint(@ "hash_91fb20e61355309f", 1) == 1) {
          level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(instance.origin, "dom");
        }

        playertask thread namespace_a12ab42942591824::function_9e9a76453cf89412(useplayer.team, playertask.domflag, playertask.objidnum);
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(playertask.icon, useplayer.team);
      }

      playertask thread domflag_update(playertask.teams[0], playertask.domflag, playertask.icon);
    } else {
      useplayer scripts\mp\hud_message::showerrormessage("DMZ/UPLOAD_STATION_USE_ERR");
    }

    return;
  }

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    namespace_a12ab42942591824::intel_resetusability(instance);
  }
}

function function_94f937f05d8740c8(instance, useplayer) {
  instance setscriptablepartstate("dmz_upload_station", "unusable");
  instance.successfuluse = 0;
  instance.animatedplayer = useplayer;
  instance function_fb78f1cd45a31b9c(useplayer);

  if(isDefined(instance.animstruct) && isDefined(instance.animstruct.harddrive)) {
    instance.animstruct.harddrive delete();
  }

  instance.animatedplayer = undefined;
  instance setscriptablepartstate("dmz_upload_station", "usable");

  if(scripts\mp\utility\game::getsubgametype() != "dmz") {
    namespace_a12ab42942591824::intel_resetusability(instance, useplayer.team);
  }
}

function function_fb78f1cd45a31b9c(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  thread function_783f84b2aaf11d69(player);
  function_21bf34fdb6a27d05(player);
  thread function_a7adf312e5d321b6(player);
  function_40cf8163c7e23d93(player);

  if(istrue(self.successfuluse)) {
    function_5d370c10d291b6a2(player);
  } else {
    function_e31e154d777cd614(player);
  }

  if(isDefined(player) && isreallyalive(player)) {
    player notify("interact_finished");
  }

  if(isDefined(self.animstruct) && isDefined(self.animstruct.harddrive)) {
    self.animstruct.harddrive delete();
  }

  waitframe();

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(player)) {
    player notify("remove_rig");

    if(isreallyalive(player)) {
      player scripts\mp\gametypes\dmz_safes::function_680b501eb7141c84(1);
    }
  }
}

function function_21bf34fdb6a27d05(player) {
  player scripts\mp\gametypes\dmz_safes::function_680b501eb7141c84(0);
  playerviewangles = player getplayerangles();
  player.linktoent = player spawn_tag_origin(player.origin, player.playerviewangles);
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1);
  anglesrotated = self.angles + (0, 180, 0);
  goalpos = self.origin + rotatevector((-37, 0.9, 3.5), anglesrotated);
  forward = anglesToForward(anglesrotated);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  goalangles = axistoangles(forward, right, up);
  movetotime = 0.5;
  player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
  player.linktoent rotateTo(goalangles, movetotime, 0.1, 0.1);
  player setstance("stand");
  var_cd9982adb17761a8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = movetotime - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000;
  waittime = max(0, var_218f64cb035d54be);
  wait waittime;
  function_c1fd3441ccfba6f8(player.team, undefined, 0.5);
  player setOrigin(goalpos);
  player setplayerangles(goalangles);
  player thread scripts\mp\utility\infilexfil::infil_player_rig_updated("upload_station_player", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);
  animstruct = spawnStruct();
  animstruct.origin = goalpos;
  animstruct.angles = anglesrotated;
  animstruct.harddrive = spawn("script_model", self.origin);
  animstruct.harddrive setModel("misc_hard_drive_v0_rig");
  animstruct.harddrive show();
  animstruct.harddrive useanimtree(#animtree);
  animstruct.harddrive.animname = "upload_station_harddrive";
  self.animstruct = animstruct;
  self.animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "upload_station_enter");
  self.animstruct scripts\common\anim::anim_single_solo(self.animstruct.harddrive, "upload_station_enter");
}

function function_a7adf312e5d321b6(player) {
  player endon("disconnect");
  player endon("interact_interrupt");
  waitframe();

  if(!isbot(player)) {
    player notifyonplayercommand("interact_cancelled", "+weapnext");
  }

  self.cancel = 0;
  msg = player waittill_any_timeout_1(self.var_34ef5bf2eebf19eb, "interact_cancelled");
  self.cancel = 1;

  if(!isbot(player)) {
    player notifyonplayercommandremove("interact_cancelled", "+weapnext");
  }

  if(msg == "interact_cancelled") {
    self.successfuluse = 0;
  } else {
    self.successfuluse = 1;
    player notify("interact_begin_exit");
  }

  self notify("stop_loop");
}

function function_783f84b2aaf11d69(player) {
  player endon("interact_finished");
  linktoent = player.linktoent;
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");

  if(!isDefined(player)) {
    if(isDefined(linktoent)) {
      linktoent delete();
    }

    return;
  }

  player notify("interact_interrupt");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player scripts\mp\gametypes\dmz_safes::function_680b501eb7141c84(1);
}

function function_40cf8163c7e23d93(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_begin_exit");
  player endon("interact_cancelled");

  if(isreallyalive(player)) {
    self.animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "upload_station_type");
    self.animstruct scripts\common\anim::anim_single_solo(self.animstruct.harddrive, "upload_station_type");
  }
}

function function_5d370c10d291b6a2(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  player endon("interact_cancelled");

  if(isreallyalive(player)) {
    self.animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "upload_station_exit");
    self.animstruct scripts\common\anim::anim_single_solo(self.animstruct.harddrive, "upload_station_exit");
  }
}

function function_e31e154d777cd614(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");

  if(isreallyalive(player)) {
    self.animstruct thread scripts\mp\anim::anim_player_solo(player, player.player_rig, "upload_station_exit_cancel");
    self.animstruct scripts\common\anim::anim_single_solo(self.animstruct.harddrive, "upload_station_exit_cancel");
  }
}

function domflag_update(team, domflag, objidnum, durationoverride) {
  domflag.teamsusing[team] = objidnum;
  function_bd844a68a625e6ca(team, domflag, objidnum, durationoverride);
  domflag.teamsusing[team] = undefined;
}

function private function_bd844a68a625e6ca(team, domflag, objidnum, durationoverride) {
  level endon("game_ended");
  self endon("task_ended");
  self.uploading = 1;
  objective_setpinned(objidnum, 1);
  domflag setscriptablepartstate("upload_screen", "screen_on");
  playersonteam = getteamdata(team, "players");
  scripts\cp_mp\overlord::playevent("secure_intel_uploading", playersonteam);
  function_c1fd3441ccfba6f8(team, undefined, 0);
  timer = 0;
  duration = function_d9a6bc7f39149ca7() * 1000;

  if(isDefined(durationoverride)) {
    duration = durationoverride;
  }

  while(true) {
    count = 0;

    foreach(player in domflag.playersintrigger) {
      if(is_equal(team, player.team)) {
        scripts\mp\objidpoolmanager::function_ce702e5925e31fc9(objidnum, player, 2, 2, &"DMZ/UPLOAD_STATION_PROGRESS");

        if(isDefined(self.category) && self.category == "intel") {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objidnum, player);
        }

        count++;
      }
    }

    if(count > 0) {
      if(isDefined(self.category) && self.category == "intel" && !istrue(self.var_c30f326891049f08)) {
        self.var_c30f326891049f08 = 1;
        function_e2aa45e2c6b5dec1(1);
      }

      var_be9b7e1f96f8a7fb = getdvarfloat(@ "hash_93243ddce42d0f81", 1);
      var_9d10545ed5149c2f = 0;

      if(level.maxteamsize > 1) {
        var_9d10545ed5149c2f = var_be9b7e1f96f8a7fb / (level.maxteamsize - 1);
      }

      capturerate = 1 + (count - 1) * var_9d10545ed5149c2f;
      timer += level.frameduration * capturerate;
      progress = timer / duration;
      progress = clamp(progress, 0, 1);

      if(timer < duration) {
        objective_setprogress(objidnum, progress);
        domflag play_spotrep_capture_sfx(progress, team);
      } else {
        self.capturingplayer = domflag.playersintrigger[0];

        if(isDefined(self.var_c30f326891049f08) && isDefined(self.category) && self.category == "intel") {
          self.var_c30f326891049f08 = 0;
          function_e2aa45e2c6b5dec1(0);
        }

        if(isDefined(self.var_bf7f7683ea10da26)) {
          [[self.var_bf7f7683ea10da26]](team);
        } else {
          function_804eb3448706c9bc(team);
        }
      }
    } else if(isDefined(self.category) && self.category == "intel" && istrue(self.var_c30f326891049f08)) {
      self.var_c30f326891049f08 = 0;
      function_e2aa45e2c6b5dec1(0);
    }

    waitframe();
  }
}

function function_a93281d34421174f() {
  level endon("game_ended");

  while(true) {
    self.trigger waittill("trigger", player);

    if(!isPlayer(player) || array_contains(self.playersintrigger, player)) {
      continue;
    }

    if(!array_contains(self.playersintrigger, player)) {
      self.playersintrigger[self.playersintrigger.size] = player;
      thread function_caf75fde8e8c0a45(player);
    }
  }
}

function function_caf75fde8e8c0a45(player) {
  level endon("game_ended");
  domradius = function_9258edce111428c2();
  domradiussq = domradius * domradius;

  while(isDefined(player) && isalive(player) && isDefined(self.trigger) && distancesquared(self.trigger.origin, player.origin) < domradiussq) {
    waitframe();
  }

  if(isDefined(player)) {
    foreach(team, objicon in self.teamsusing) {
      if(isDefined(objicon) && is_equal(team, player.team)) {
        if(isDefined(self.tasks) && self.tasks.size > 0) {
          foreach(task in self.tasks) {
            if(isDefined(task.category) && task.category == "intel") {
              if(isDefined(task.teams) && task.teams.size > 0) {
                foreach(questteam in task.teams) {
                  if(questteam == player.team) {
                    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(objicon, player);
                    scripts\mp\objidpoolmanager::function_482e36e6af02143c(player);
                    break;
                  }
                }
              }
            }
          }

          continue;
        }

        scripts\mp\objidpoolmanager::function_26259bd38697b5ad(objicon, player);
        break;
      }
    }

    self.playersintrigger = array_remove(self.playersintrigger, player);
    return;
  }

  self.playersintrigger = array_removeundefined(self.playersintrigger);
}

function play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_c3ddfb0eaa8f761c = "";
    progress = int(floor(progress * 10));
    var_c3ddfb0eaa8f761c = "mp_dom_capturing_tick_0" + progress;
    players = getteamdata(team, "players");

    foreach(player in players) {
      player playlocalsound(var_c3ddfb0eaa8f761c, undefined, undefined, 1);
    }
  }
}

function domflag_setdomscriptablepartstate(part, state, statemod) {
  switch (state) {
    case #"hash_1c39674e5b0de0f3":
    case #"hash_3699ac6c262c25ea":
    case #"hash_86bf1a776a7c4cbe":
      return 0;
    default:
      state = "using";

      if(isDefined(statemod)) {
        state += statemod;
      }

      self.scriptable setscriptablepartstate(part, state);

      if(part == "pulse") {
        self.scriptable setscriptablepartstate("flag", state);
      }

      return 1;
  }
}

function function_8c550607fb966b6f(team, origin) {
  wait 4;
  players = getteamdata(team, "players");

  if(isDefined(players) && players.size > 0 && issharedfuncdefined("dmz_bosses", "revealBossLocation")) {
    closestplayer = getclosest(origin, players);
    var_93c69ead55eb3f07 = namespace_a38a2e1fe7519183::function_e860c1be7ff11f5b(team, 20);

    for(i = 0; i < 1 + var_93c69ead55eb3f07; i++) {
      level thread[[getsharedfunc("dmz_bosses", "revealBossLocation")]](closestplayer, 1, origin);
      wait 5;
    }
  }
}

function function_9258edce111428c2() {
  if(isDefined(level.var_d6ae5cc7b162c730)) {
    return level.var_d6ae5cc7b162c730.var_5f4a68d8fb9f45dd;
  }

  return level.searchprops.domradius;
}

function function_d9a6bc7f39149ca7() {
  if(isDefined(level.var_d6ae5cc7b162c730)) {
    return level.var_d6ae5cc7b162c730.domcapturetime;
  }

  return level.searchprops.capturetime;
}

function function_7f460fe8d509a260() {
  if(isDefined(level.var_d6ae5cc7b162c730)) {
    return level.var_d6ae5cc7b162c730.var_b820cb1ac6257b4b;
  }

  return level.searchprops.var_b820cb1ac6257b4b;
}

function function_133d4b6d206849d8() {
  if(isDefined(self.var_5e5710ca5b795c6b)) {
    return self.var_5e5710ca5b795c6b;
  }

  return self.item;
}

function function_e3c59f87c74a628() {
  while(true) {
    if(getdvarint(@ "hash_16723be93d108e5e", 0)) {
      setDvar(@ "hash_16723be93d108e5e", 0);
      thread function_8c550607fb966b6f(level.players[0].team, level.players[0].origin);
    }

    waitframe();
  }
}

function function_d2973feefae661b8() {
  while(true) {
    sphere(self.origin, 50, (1, 0, 0), 0, 1);
    waitframe();
  }
}

# /
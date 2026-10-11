/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_241ff3c86d02a28d.gsc
*************************************************/

#using script_15ca41a3fbb0e379;
#using script_24fbedba9a7a1ef4;
#using script_4948cdf739393d2d;
#using script_5307834cd39b435c;
#using script_5c65d346ac65390c;
#using script_64acb6ce534155b7;
#using scripts\anim\dialogue;
#using scripts\common\anim;
#using scripts\common\cap;
#using scripts\common\elevator;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\rescue;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_ae2d053cbf559cee;

function function_80d68c9701e1aea5(data) {
  level.var_af7d80856e5ae6c0 = spawnStruct();
  level.var_af7d80856e5ae6c0.circleradius = getdvarint(@ "hash_d2585ec2c64a9f34", 300);
  level.var_af7d80856e5ae6c0.var_e3aa1de9d96e0086 = getdvarint(@ "hash_1d6b7e1f5eab0397", 700);
  level.var_af7d80856e5ae6c0.bombtimer = getdvarfloat(@ "hash_5670ae3dc42b22ff", 50);
  level.var_af7d80856e5ae6c0.disarmtime = getdvarfloat(@ "hash_11c996694ec6bc7d", 3);
  level.var_af7d80856e5ae6c0.blockplayerdamage = getdvarint(@ "hash_152094cca50e086", 1);
  level.var_af7d80856e5ae6c0.var_82a01ce31b77ac5c = getdvarfloat(@ "hash_4f66fa15a2fb52a5", 750);
  initanims();
  level._effect["hostage_bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_hostage", &function_b7a8186b8098b13f);
  function_b713f2d39b34540f(data, &function_d871ffa09fd34efe, function_f0c7539dc72c3dfd());
}

function function_a07f7c4c0c4ef8e3() {
  return getStructArray("<dev string:x1c>", "<dev string:x2d>");
}

function function_d871ffa09fd34efe(mission, node) {
  task = task_create(mission);
  task.funcs["onInit"] = &function_c17a05d80baf63a8;
  task.funcs["onPlayerJoined"] = &function_15bd4f5a3da26fba;
  task.funcs["onPlayerRemoved"] = &function_64b4cc14af5fcbf9;
  task.funcs["onTeamAssigned"] = &function_48ef78129771c52b;
  task.funcs["onTeamStart"] = &function_497633646487b841;
  task.funcs["onCancel"] = &function_55cff0a19d87f7b0;
  task.ref = "dmz_hostage";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.node = node;
  fort = namespace_9823ee6035594d67::function_bbe42d7091bedfc5(node.origin, "hostage_forts");
  namespace_9823ee6035594d67::function_4e6dd86684152b17(fort, "hostage_door");
  namespace_9823ee6035594d67::function_5d8264355db47371(fort, 0, 1, 0, 0, undefined, undefined, undefined, undefined, 1, 0);
  task.fort = fort;
  task.helinode = node.helinode;
  node.helinode.info = namespace_25b25d188ef778c4::function_a4181028915c44fa(node.helinode, 0);
  return task;
}

function function_c17a05d80baf63a8() {
  self.activity.origin = self.node.origin;
  self.node.inuse = 1;
  circlelocation = function_ab50f62a3a730400(self.fort.origin, level.var_af7d80856e5ae6c0.circleradius);
  function_325390edb051cd5d("Hostage_Dmz", [circlelocation], level.var_af7d80856e5ae6c0.circleradius + level.var_af7d80856e5ae6c0.var_e3aa1de9d96e0086);
  self.curorigin = circlelocation;
  self.offset3d = (0, 0, 750);
  function_c847bfd52c064289(self.curorigin + self.offset3d, "rescue");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.icon, 1);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.icon, 0);
  self.door_opened = 0;
  self.activitykey = "hostage" + gettime();
  function_bd0bde6807000dae();
  function_b6b601986dcad85a();

  if(!isDefined(self.hostage)) {
    function_8250fd658e3aae32();
    task_ended();
    return;
  }

  function_14f7745b0a1250db();

  thread debughostage();
}

function function_15bd4f5a3da26fba(player) {
  player.activitykey = self.activitykey;
  players = getteamdata(player.team, "players");

  if(!isDefined(self.bombexploded)) {
    self.instance enablescriptableplayeruse(player);
    return;
  }

  if(isDefined(self.carryingplayer)) {
    self.instance disablescriptableplayeruse(player);
    return;
  }

  self.instance enablescriptableplayeruse(player);
}

function function_64b4cc14af5fcbf9(player) {
  player.activitykey = undefined;

  if(isDefined(self.carryingplayer) && self.carryingplayer == player) {
    drophostage(1);
  }

  self.instance disablescriptableplayeruse(player);
}

function function_48ef78129771c52b(teamname) {
  function_1759acfd39bb5edf("dmz_hostage_assigned", teamname);
  function_e54df8560bf7dc64(teamname);
  function_dffcbce998c9ee50(teamname);
  players = getteamdata(teamname, "players");
  self.instance setscriptablepartstate("dmz_hostage", "usable", 0);

  foreach(player in level.players) {
    self.instance disablescriptableplayeruse(player);
  }

  foreach(player in players) {
    self.instance enablescriptableplayeruse(player);
  }

  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_assigned", teamname);
  function_c1fd3441ccfba6f8(teamname, "dmz_hostage_start", 1.5, "dmz_hostage_start_classic");
  thread function_d2a6b6d52ac64120(teamname);

  if(getdvarint(@ "hash_74041777d8dfea42", 0) == 1) {
    function_5511b411b075d27b();
  }
}

function function_497633646487b841(teamname) {
  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_approach", teamname, 2);
  function_c1fd3441ccfba6f8(teamname, "dmz_hostage_approach", 0);
}

function function_55cff0a19d87f7b0(teamname) {
  self.failure = 1;
  function_8250fd658e3aae32();

  if(isDefined(self.carryingplayer)) {
    thread drophostage(1);
  }

  function_c1fd3441ccfba6f8(teamname, "dmz_hostage_rescue_failed", 1, "dmz_hostage_rescue_failed_classic");
  task_ended();
}

function function_8250fd658e3aae32() {
  if(istrue(self.completed)) {
    return;
  }

  self.completed = 1;

  if(!istrue(self.skipcontract)) {
    if(isDefined(self.shownplayers)) {
      foreach(player in self.shownplayers) {
        scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.icon, player);
      }
    }

    function_2476daefa3384c5e();
    function_629ed367d1393020();
  }

  if(isDefined(self.instance)) {
    self.instance freescriptable();
  }

  if(isDefined(self.heli) && isDefined(self.heli.var_902a7ffcff8aa65)) {
    foreach(player in self.heli.var_902a7ffcff8aa65) {
      player namespace_25b25d188ef778c4::function_a9f268abd153b713();
    }
  }

  if(!istrue(self.skipcontract)) {
    function_45bd3184ff146b46(self.teams[0]);
  }
}

function function_cb2f74520e05756f(teamname) {
  function_8250fd658e3aae32();

  if(!istrue(self.skipcontract)) {
    if(isDefined(teamname)) {
      thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_hostage_exfil", teamname, 2);
      function_a1738a95d7aa8094("dmz_hostage_exfilled", "hostage", self.activity.cashreward, teamname);
      function_cd4f277cf0d6a560(teamname);
      function_c1fd3441ccfba6f8(teamname, "", 0);
      scripts\mp\pmc_missions::function_496b109dc14fa57d(self);
    } else if(isDefined(self.teams[0])) {
      function_c1fd3441ccfba6f8(self.teams[0], "dmz_hostage_rescue_failed", 0, "dmz_hostage_rescue_failed_classic");
    }

    task_ended(teamname);
  }
}

function function_bd0bde6807000dae() {
  foreach(door in self.fort.lockeddoors) {
    door.task = self;
    door scriptabledoorclose();
    door.activitykey = self.activitykey;
    door.var_8e6ba9b12787eb1d = 1;

    namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x3b>", self.activity.name, undefined, undefined, undefined, undefined, self.activity.poi, door.origin);
  }

  namespace_9823ee6035594d67::function_68a6379d51e7dbc2(self.fort, undefined, &function_bf35c0838580cf50);
}

function function_bf35c0838580cf50(door, player) {
  if(isDefined(door.task)) {
    if(isDefined(door.node.script_noteworthy) && door.node.script_noteworthy == "lockMe") {
      door thread function_aa49ad82e62a035f();
    }
  }
}

function function_aa49ad82e62a035f() {
  while(self scriptabledoorisclosed()) {
    waitframe();
  }

  self.task.door_opened = 1;
}

function function_d2a6b6d52ac64120(teamname) {
  self endon("task_ended");
  self endon("abort_rescue_timer");

  while(!istrue(self.door_opened)) {
    waitframe();
  }

  self.hostage.invulnerable = undefined;
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_loud", teamname);
  self.state = "player_entered_building";
  thread function_795b60c4ae5793a2(teamname);
}

function private function_795b60c4ae5793a2(teamname) {
  if(istrue(self.aborttimer) || isDefined(self.bombexploded) && !self.bombexploded) {
    return;
  }

  self endon("task_ended");
  self endon("abort_rescue_timer");

  if(istrue(self.var_ad3ac58c52d589d7)) {
    return;
  }

  self.var_ad3ac58c52d589d7 = 1;
  timer = level.var_af7d80856e5ae6c0.bombtimer;
  function_c1fd3441ccfba6f8(teamname, "dmz_hostage_breach", 1, "dmz_hostage_breach_classic");
  thread function_68c8358014264e66(timer);
  scripts\mp\objidpoolmanager::objective_set_show_progress(self.icon, 1);
  bombexploded = explode_bomb(timer);

  if(isDefined(bombexploded)) {
    self.bombexploded = bombexploded;
  }

  foreach(player in self.shownplayers) {
    scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.icon, player);
    scripts\mp\objidpoolmanager::objective_unpin_player(self.icon, player);
  }

  if(isDefined(self.bombexploded) && self.bombexploded == 0) {
    scripts\mp\objidpoolmanager::objective_set_show_progress(self.icon, 0);
  }

  if(istrue(self.bombexploded)) {
    self notify("bomb_exploded");

    if(isDefined(self.hostage) && self.hostage.health > 0) {
      self.hostage dodamage(1000, self.hostage.origin);
    }

    effect = "hostage_bomb_explosion";
    explosionpos = self.c4.origin + (0, 0, 50);
    explosioneffect = spawnfx(level._effect[effect], explosionpos);
    explosioneffect thread delete_after_delay(10);
    triggerfx(explosioneffect);
    physicsexplosionsphere(explosionpos, 200, 100, 3);
    playrumbleonposition("grenade_rumble", self.c4.origin);
    earthquake(0.25, 0.5, self.c4.origin, 500);
    playsoundatpos(explosionpos, "exp_bombsite_lr");
    radiusdamage(self.c4.origin + (0, 0, 50), 200, 500, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_exploded", self.teams[0], 2);
  }

  if(isDefined(self.c4)) {
    self.c4 delete();
  }
}

function function_68c8358014264e66(timer) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("bomb_defused");
  wait timer;
  self.instance setscriptablepartstate("dmz_hostage", "unusable", 0);
}

function explode_bomb(timer) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("bomb_defused");
  self endon("abort_rescue_timer");
  self.shownplayers = [];
  currenttime = gettime();
  offset = 1000 * level.var_af7d80856e5ae6c0.disarmtime;
  bombendtime = int(currenttime + 1000 * timer + offset);
  var_c301d652d9a73075 = bombendtime - currenttime;
  thread function_c98c343e42951ea2(bombendtime, offset);

  while(var_c301d652d9a73075 > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = bombendtime - currenttime;

    if(var_c301d652d9a73075 < 0) {
      break;
    }

    self.nearbyplayers = [];
    playersonteam = getteamdata(self.teams[0], "players");

    foreach(player in playersonteam) {
      if(distance2dsquared(player.origin, self.fort.origin) < 1048576) {
        self.nearbyplayers[self.nearbyplayers.size] = player;
      }
    }

    progress = (var_c301d652d9a73075 - offset) / timer * 1000;

    if(progress > 0) {
      self.shownplayers = function_f69e0b0e05fd9b85(self.nearbyplayers, self.shownplayers);
      scripts\mp\objidpoolmanager::objective_set_progress(self.icon, progress);
    } else {
      scripts\mp\objidpoolmanager::function_17db39bd195cc5b1(self.icon);
      self.objectivehidden = 1;
    }

    waitframe();
  }

  return true;
}

function function_c98c343e42951ea2(bombendtime, offset) {
  level endon("game_ended");
  self endon("task_ended");
  self endon("abort_rescue_timer");
  self endon("bomb_exploded");
  self endon("bomb_defused");
  currenttime = gettime();
  var_c301d652d9a73075 = bombendtime - currenttime;

  while(var_c301d652d9a73075 > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = bombendtime - currenttime;

    if(var_c301d652d9a73075 <= 0 + offset) {
      if(var_c301d652d9a73075 <= 250) {
        if(soundexists("hostage_warning_beep_05")) {
          self.c4 playSound("hostage_warning_beep_05");
        }
      } else if(var_c301d652d9a73075 <= 750) {
        if(soundexists("hostage_warning_beep_04")) {
          self.c4 playSound("hostage_warning_beep_04");
        }
      } else if(var_c301d652d9a73075 <= 1500) {
        if(soundexists("hostage_warning_beep_03")) {
          self.c4 playSound("hostage_warning_beep_03");
        }
      } else if(soundexists("hostage_warning_beep_02")) {
        self.c4 playSound("hostage_warning_beep_02");
      }

      wait 0.25;
      continue;
    }

    if(var_c301d652d9a73075 <= 10000 + offset) {
      if(soundexists("hostage_warning_beep_02")) {
        self.c4 playSound("hostage_warning_beep_02");
      }

      wait 0.5;
      continue;
    }

    if(soundexists("hostage_warning_beep_01")) {
      self.c4 playSound("hostage_warning_beep_01");
    }

    wait 1;
  }
}

function function_f69e0b0e05fd9b85(nearbyplayers, shownplayers) {
  allplayers = array_combine(nearbyplayers, shownplayers);
  var_f6fd7b0e73c3270c = shownplayers;

  foreach(player in allplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!array_contains(shownplayers, player) && array_contains(nearbyplayers, player)) {
      if(scripts\mp\objidpoolmanager::function_ce702e5925e31fc9(self.icon, player, 2, 2, &"MP_DMZ_MISSIONS/HOSTAGE_BAR_TITLE")) {
        scripts\mp\objidpoolmanager::objective_pin_player(self.icon, player);
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.icon, player);
        var_f6fd7b0e73c3270c = array_add(var_f6fd7b0e73c3270c, player);
      }

      continue;
    }

    if(array_contains(shownplayers, player) && !array_contains(nearbyplayers, player)) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.icon, player);
      scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.icon, player);
      var_f6fd7b0e73c3270c = array_remove(var_f6fd7b0e73c3270c, player);
    }
  }

  return var_f6fd7b0e73c3270c;
}

function private function_c0ccb94fcfe50916() {
  self endon("task_ended");
  self.hostage thread function_8dc13537721b3c2d();

  while(isDefined(self.hostage) && self.hostage.health > 0 && !istrue(self.bombexploded)) {
    waitframe();
  }

  if(istrue(self.failure)) {
    return;
  }

  self.failure = 1;

  if(isDefined(self.var_90758efde9b783b7)) {
    self.var_90758efde9b783b7 delete();
  }

  if(!istrue(self.skipcontract)) {
    function_a1738a95d7aa8094("dmz_hostage_failure", "hostage", 0, self.teams[0]);

    if(isDefined(self.teams[0]) && !istrue(self.bombexploded)) {
      thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_shot", self.teams[0], 1.5);
    }

    if(isDefined(self.shownplayers)) {
      foreach(player in self.shownplayers) {
        scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.icon, player);
        scripts\mp\objidpoolmanager::objective_unpin_player(self.icon, player);
      }
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.icon);
    scripts\mp\objidpoolmanager::objective_set_show_progress(self.icon, 0);
    self.questcircles[0] function_4eaf685bc40a3b9();
  }

  thread function_cb2f74520e05756f();
}

function private function_b7a8186b8098b13f(instance, part, state, player, bautouse, usestring) {
  if(part != "dmz_hostage") {
    return;
  }

  if(!isDefined(instance.task)) {
    return;
  }

  if(!istrue(instance.task.skipcontract) && (!isDefined(instance.task.teams[0]) || player.team != instance.task.teams[0])) {
    assertmsg("<dev string:x48>");
    return;
  }

  if(state == "usable" && isDefined(instance.hostage)) {
    if(isDefined(instance.task.task_ended)) {
      return;
    }

    instance setscriptablepartstate("dmz_hostage", "unusable");
    task = instance.task;
    task.c4 hide();
    bomb = task function_cadc5181c3b67e3f(player);
    thread function_d86771edadba8b4a(instance, task, player);
    buttontime = 0;

    while(buttontime < level.var_af7d80856e5ae6c0.disarmtime) {
      if(!isDefined(instance) || instance.cancel || istrue(task.failure) || !scripts\mp\utility\player::isaliveandnotinlaststand(player)) {
        if(isDefined(player)) {
          player notifyonplayercommandremove("cancel", "+weapnext");
        }

        task function_db896f4486ca187(player, bomb);
        task.c4 show();

        if(!istrue(task.failure) && isDefined(instance)) {
          instance setscriptablepartstate("dmz_hostage", "usable");

          foreach(otherplayer in level.players) {
            instance disablescriptableplayeruse(otherplayer);
          }

          teammates = getteamdata(instance.task.teams[0], "players");

          foreach(teammate in teammates) {
            instance enablescriptableplayeruse(teammate);
          }
        }

        return 0;
      }

      buttontime += level.framedurationseconds;
      waitframe();
    }

    if(isDefined(player)) {
      player notifyonplayercommandremove("cancel", "+weapnext");
    }

    if(istrue(instance.task.failure)) {
      instance.task function_db896f4486ca187(player, bomb);

      if(isDefined(task.c4)) {
        task.c4 delete();
      }

      return;
    }

    instance.task.state = "rescued";
    instance.hostage notify("play_dialog");
    instance.task.bombexploded = 0;
    instance.task notify("bomb_defused");

    if(isDefined(instance.task.shownplayers)) {
      foreach(shownplayer in instance.task.shownplayers) {
        scripts\mp\objidpoolmanager::function_26259bd38697b5ad(instance.task.icon, shownplayer);
        scripts\mp\objidpoolmanager::objective_unpin_player(instance.task.icon, player);
      }
    }

    scripts\mp\objidpoolmanager::function_6ae37618bb04ea60(instance.task.icon);
    instance.task function_db896f4486ca187(player, bomb);

    if(isDefined(task.c4)) {
      task.c4 delete();
    }

    if(istrue(task.failure)) {
      return;
    }

    player playSound("mp_dmz_hostage_unzip");
    instance.task.dropposition = instance.position;
    instance setscriptablepartstate("dmz_hostage", "remaining");

    foreach(guy in level.players) {
      instance disablescriptableplayeruse(guy);
    }

    teammates = getteamdata(instance.task.teams[0], "players");

    foreach(teammate in teammates) {
      instance enablescriptableplayeruse(teammate);
    }

    scripts\mp\objidpoolmanager::update_objective_position(instance.task.icon, instance.task.hostage.origin + (0, 0, 30));
    instance.task.questcircles[0] function_4eaf685bc40a3b9();
    instance.task.questcircles[0] function_6e148c8da2e4db13(instance.task.helinode.origin);
    instance.task function_1759acfd39bb5edf("dmz_hostage_success", instance.task.teams[0]);
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_win", instance.task.teams[0], 2);
    instance.task thread function_df48d309a8bc55a();
    function_c1fd3441ccfba6f8(instance.task.teams[0], "dmz_hostage_rescue", 1, "dmz_hostage_rescue_classic");
    return;
  }

  if(state == "remaining" && isDefined(instance.hostage)) {
    instance setscriptablepartstate("dmz_hostage", "unusable");
    instance.task pickuphostage(player, instance.hostage);
    return;
  }

  if(state == "following" && isDefined(instance.hostage)) {
    instance.task drophostage();
  }
}

#using_animtree("script_model");

function initanims() {
  level.scr_animtree["player_pickup_hostage"] = #animtree;
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch"] = % iw9_mp_hostage_pickup_crouch_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch"] = % "pickup_front_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand"] = % iw9_mp_hostage_pickup_stand_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand"] = % "pickup_front_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch"] = % iw9_mp_hostage_pickup_crouch_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch"] = % "pickup_back_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand"] = % iw9_mp_hostage_pickup_stand_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand"] = % "pickup_back_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch"] = % iw9_mp_hostage_pickup_crouch_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch"] = % "pickup_right_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand"] = % iw9_mp_hostage_pickup_stand_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand"] = % "pickup_right_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch"] = % iw9_mp_hostage_pickup_crouch_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch"] = % "pickup_left_crouch";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand"] = % iw9_mp_hostage_pickup_stand_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand"] = % "pickup_left_stand";
  level.scr_anim["player_pickup_hostage"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_crouch_vm"] = % "pickup_front_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_8;
  level.scr_eventanim["player_pickup_hostage"]["pickup_front_stand_vm"] = % "pickup_front_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_crouch_vm"] = % "pickup_back_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_2;
  level.scr_eventanim["player_pickup_hostage"]["pickup_back_stand_vm"] = % "pickup_back_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_crouch_vm"] = % "pickup_right_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_6;
  level.scr_eventanim["player_pickup_hostage"]["pickup_right_stand_vm"] = % "pickup_right_stand_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickup_crouch_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_crouch_vm"] = % "pickup_left_crouch_vm";
  level.scr_anim["player_pickup_hostage"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickup_stand_4;
  level.scr_eventanim["player_pickup_hostage"]["pickup_left_stand_vm"] = % "pickup_left_stand_vm";
  level.scr_animtree["hostage_pickup"] = #animtree;
  level.scr_anim["hostage_pickup"]["pickup_front_crouch"] = % iw9_mp_hostage_pickedup_crouch_8;
  level.scr_eventanim["hostage_pickup"]["pickup_front_crouch"] = % "hash_67f23cafd452eaf";
  level.scr_anim["hostage_pickup"]["pickup_front_stand"] = % iw9_mp_hostage_pickedup_stand_8;
  level.scr_eventanim["hostage_pickup"]["pickup_front_stand"] = % "hash_76c3c19b5cdc4957";
  level.scr_anim["hostage_pickup"]["pickup_back_crouch"] = % iw9_mp_hostage_pickedup_crouch_2;
  level.scr_eventanim["hostage_pickup"]["pickup_back_crouch"] = % "hash_5b9b71e89b7aff69";
  level.scr_anim["hostage_pickup"]["pickup_back_stand"] = % iw9_mp_hostage_pickedup_stand_2;
  level.scr_eventanim["hostage_pickup"]["pickup_back_stand"] = % "hash_6a3ae844da15c55d";
  level.scr_anim["hostage_pickup"]["pickup_right_crouch"] = % iw9_mp_hostage_pickedup_crouch_6;
  level.scr_eventanim["hostage_pickup"]["pickup_right_crouch"] = % "hash_17c61661c4ba6d68";
  level.scr_anim["hostage_pickup"]["pickup_right_stand"] = % iw9_mp_hostage_pickedup_stand_6;
  level.scr_eventanim["hostage_pickup"]["pickup_right_stand"] = % "hash_2c87d17e444be8d6";
  level.scr_anim["hostage_pickup"]["pickup_left_crouch"] = % iw9_mp_hostage_pickedup_crouch_4;
  level.scr_eventanim["hostage_pickup"]["pickup_left_crouch"] = % "hash_763bf8b46b8f6ff";
  level.scr_anim["hostage_pickup"]["pickup_left_stand"] = % iw9_mp_hostage_pickedup_stand_4;
  level.scr_eventanim["hostage_pickup"]["pickup_left_stand"] = % "hash_3c9d606392a88b87";
  level.scr_animtree["hostage_pickup_sm"] = #animtree;
  level.scr_anim["hostage_pickup_sm"]["pickup_front_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_8;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_front_crouch_vm"] = % "hash_2dfeef0aebdfeecd";
  level.scr_anim["hostage_pickup_sm"]["pickup_front_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_8;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_front_stand_vm"] = % "hash_7e016dd39eca5fe5";
  level.scr_anim["hostage_pickup_sm"]["pickup_back_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_2;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_back_crouch_vm"] = % "hash_1a414b9d05f157c3";
  level.scr_anim["hostage_pickup_sm"]["pickup_back_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_2;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_back_stand_vm"] = % "hash_242c761811d89107";
  level.scr_anim["hostage_pickup_sm"]["pickup_right_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_6;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_right_crouch_vm"] = % "hash_716be6cc83bf81c";
  level.scr_anim["hostage_pickup_sm"]["pickup_right_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_6;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_right_stand_vm"] = % "hash_4590693be6e310be";
  level.scr_anim["hostage_pickup_sm"]["pickup_left_crouch_vm"] = % iw9_mp_hostage_vm_pickedup_crouch_4;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_left_crouch_vm"] = % "hash_1897e7f4cbc945fd";
  level.scr_anim["hostage_pickup_sm"]["pickup_left_stand_vm"] = % iw9_mp_hostage_vm_pickedup_stand_4;
  level.scr_eventanim["hostage_pickup_sm"]["pickup_left_stand_vm"] = % "hash_39404f4bc2930c35";
}

function pickuphostage(player, hostage) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("last_stand_start");
  level endon("game_ended");
  self.hostage endon("death");
  self endon("task_ended");

  if(!istrue(self.completed)) {
    self.carryingplayer = player;
    thread function_82ef6d194918247f(player);
    player.var_859654e0445a36d9 = 1;
    hostage unlink();
    self.instance scriptableclearparententity();
    hostage function_3b8913dc82881267(player);
    player notify("hostage_pickup_finished");
  }

  if(!istrue(self.completed)) {
    hostage hide();
    hostage.origin += (0, 0, 100000);
    hostage.invulnerable = 1;
    self.carryingplayer setcarryobject(function_58ca3a35159054b1(hostage.model));
    function_f0c2012ae22ca0d6(self.carryingplayer);

    if(!istrue(self.skipcontract)) {
      players = getteamdata(self.teams[0], "players");

      foreach(teammate in players) {
        self.questcircles[0] function_cfd53c8f6878014f(teammate);
      }

      scripts\mp\objidpoolmanager::update_objective_position(self.icon, self.helinode.origin);
    }

    self.instance setscriptablepartstate("dmz_hostage", "following");

    foreach(otherplayer in level.players) {
      self.instance disablescriptableplayeruse(otherplayer);
    }

    self.instance enablescriptableplayeruse(self.carryingplayer);
    thread function_eede562ce57290d3();
  }
}

function function_58ca3a35159054b1(model) {
  if(!isDefined(model)) {
    return "hostage_rescue";
  }

  switch (model) {
    case #"hash_e1b1040264d1aa90":
      return "hostage_civ_male_3_1";
    case #"hash_7c27bd492fe216bd":
      return "hostage_civ_male_3_2";
    case #"hash_2dc1b9fc9dd2ecc6":
      return "hostage_civ_male_3_3";
    default:
      return "hostage_rescue";
  }
}

function function_8f65ac94aafe5d3e(animname, spawnpos, spawnang, bodymodel, headmodel) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  var_fc77a3ee1c3e72b5 = spawn("script_model", spawnpos);
  var_fc77a3ee1c3e72b5.angles = spawnang;
  var_fc77a3ee1c3e72b5 setModel(bodymodel);
  var_fc77a3ee1c3e72b5 notsolid();
  self.var_fc77a3ee1c3e72b5 = var_fc77a3ee1c3e72b5;
  self.var_fc77a3ee1c3e72b5.animname = animname;
  self.var_fc77a3ee1c3e72b5 useanimtree(#animtree);
  self.var_fc77a3ee1c3e72b5.updatedversion = 1;
  head = spawn("script_model", spawnpos);
  head setModel(headmodel);
  head notsolid();
  self.var_fc77a3ee1c3e72b5.head = head;
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(head)) {
    head unlink();
    head delete();
  }

  if(isDefined(var_fc77a3ee1c3e72b5)) {
    var_fc77a3ee1c3e72b5 delete();
  }
}

function function_8277f49f79bff530(animname, spawnpos, spawnang) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  if(isPlayer(self)) {
    self function_b88c89bb7cd1ab8e(spawnpos);
  }

  var_e3bda5be1db297f = spawn("script_arms", spawnpos, 0, 0, self);
  var_e3bda5be1db297f.angles = spawnang;
  var_e3bda5be1db297f.player = self;
  self.var_e3bda5be1db297f = var_e3bda5be1db297f;
  self.var_e3bda5be1db297f.animname = animname;
  self.var_e3bda5be1db297f useanimtree(#animtree);
  self.var_e3bda5be1db297f.updatedversion = 1;
  self playerlinktoabsolute(self.var_e3bda5be1db297f, "tag_player", 1, 0, 0, 0, 0, 1);
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    thread scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
  }

  if(isDefined(var_e3bda5be1db297f)) {
    var_e3bda5be1db297f delete();
  }
}

function function_a3a4a2cdca554483(animname, spawnpos, spawnang) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  if(isPlayer(self)) {
    self function_b88c89bb7cd1ab8e(spawnpos);
  }

  var_54d7b76a2a71e284 = spawn("script_arms", spawnpos, 0, 0, self);
  var_54d7b76a2a71e284.angles = spawnang;
  var_54d7b76a2a71e284.player = self;
  self.var_54d7b76a2a71e284 = var_54d7b76a2a71e284;
  self.var_54d7b76a2a71e284.animname = animname;
  self.var_54d7b76a2a71e284 useanimtree(#animtree);
  self.var_54d7b76a2a71e284.updatedversion = 1;
  self playerlinktoabsolute(self.var_54d7b76a2a71e284, "tag_player", 1, 0, 0, 0, 0, 1);
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    thread scripts\cp_mp\utility\inventory_utility::takegunlessweapon();
  }

  if(isDefined(var_54d7b76a2a71e284)) {
    var_54d7b76a2a71e284 delete();
  }
}

function function_3b8913dc82881267(player) {
  self.var_44206360497f15c2 = 1;
  player val::set("carry", "vehicle_use", 0);
  player val::set("carry", "melee", 0);
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "sprint", 0);
  player val::set("carry", "fire", 0);
  player val::set("carry", "reload", 0);
  player val::set("carry", "weapon_pickup", 0);
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "allow_jump", 0);
  player val::set("carry", "gesture", 0);
  player function_35501b42058d4de9();
  player val::set("move_disable", "allow_movement", 0);

  if(istrue(player.insertingarmorplate)) {
    player notify("try_armor_cancel");

    while(isDefined(player.currentweapon) && isDefined(player.currentweapon.basename) && player.currentweapon.basename == "iw9_armor_plate_deploy_mp") {
      waitframe();
    }

    waitframe();
  }

  animlength = 0;
  stance = player getstance();

  if(stance == "prone") {
    player setstance("crouch", 1, 1);
    stance = "crouch";
  }

  player.switchweapon = player getcurrentweapon();
  fists = makeweapon("iw9_gunless_mp");
  player giveweapon(fists);
  player.var_73f4b954751a8643 = fists;
  result = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(fists, 1, 1);

  if(!istrue(result)) {
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(fists, 1, 1);
  }

  player scripts\common\values::reset_all("move_disable");
  tmporigin = (self.origin[0], self.origin[1], player.origin[2]);
  directionvector = vectorNormalize(player.origin - tmporigin);
  var_82b4f01ce94ed444 = vectordot(directionvector, anglesToForward(self.angles));
  var_8288e81ce91e5c46 = vectordot(directionvector, anglestoright(self.angles));
  self.origin = player.origin + anglesToForward(player.angles) * 34.672;
  self.animstance = stance;
  self.animdir = undefined;
  anime = "pickup_back_stand";
  var_cf13edffb05efcd8 = "pickup_back_stand_vm";
  var_318eea579595b65e = undefined;

  if(var_82b4f01ce94ed444 >= 0.707) {
    self.animdir = "front";
    anime = "pickup_front_" + stance;
    var_cf13edffb05efcd8 = "pickup_front_" + stance + "_vm";
    directiontoplayer = vectorNormalize(player.origin - self.origin);
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(directiontoplayer, anglestoup(self.angles));
    self.angles = var_318eea579595b65e;
  } else if(var_82b4f01ce94ed444 <= -0.707) {
    self.animdir = "back";
    anime = "pickup_back_" + stance;
    var_cf13edffb05efcd8 = "pickup_back_" + stance + "_vm";
    var_81554c014ce7839c = vectorNormalize(self.origin - player.origin);
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(var_81554c014ce7839c, anglestoup(self.angles));
    self.angles = var_318eea579595b65e;
  } else if(var_8288e81ce91e5c46 >= 0.707) {
    self.animdir = "right";
    anime = "pickup_right_" + stance;
    var_cf13edffb05efcd8 = "pickup_right_" + stance + "_vm";
    var_81554c014ce7839c = vectorcross(vectorNormalize(self.origin - player.origin), anglestoup(self.angles));
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(var_81554c014ce7839c, anglestoup(self.angles));
    self.angles = var_318eea579595b65e;
  } else if(var_8288e81ce91e5c46 <= -0.707) {
    self.animdir = "left";
    anime = "pickup_left_" + stance;
    var_cf13edffb05efcd8 = "pickup_left_" + stance + "_vm";
    directiontoplayer = vectorcross(vectorNormalize(player.origin - self.origin), anglestoup(self.angles));
    var_318eea579595b65e = scripts\mp\utility\script::vectortoanglessafe(directiontoplayer, anglestoup(self.angles));
    self.angles = var_318eea579595b65e;
  }

  if(isDefined(var_318eea579595b65e)) {
    self orientmode("face angle 3d", var_318eea579595b65e);
  }

  player thread function_8277f49f79bff530("player_pickup_hostage", player.origin, player.angles);
  player.var_e3bda5be1db297f hide();
  player thread function_a3a4a2cdca554483("player_pickup_hostage", player.origin, player.angles);

  if(player getcamerathirdperson()) {
    player.var_54d7b76a2a71e284 hide();
  } else {
    player.var_54d7b76a2a71e284 showonlytoplayer(player);
  }

  var_d5b5ffad0eca8c36 = spawnStruct();
  var_d5b5ffad0eca8c36 thread function_8f65ac94aafe5d3e("hostage_pickup_sm", self.origin, self.angles, self.model, self.headmodel);
  var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5 hide();
  var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5 showonlytoplayer(player);

  if(isDefined(var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5.head)) {
    var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5.head hide();
    var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5.head showonlytoplayer(player);
    var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5.head linkTo(var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5, "j_neck", (-9, 1, 0), (0, 0, 0));
  }

  self.var_d5b5ffad0eca8c36 = var_d5b5ffad0eca8c36;
  player.var_43e2c0fcf655ebac = var_d5b5ffad0eca8c36;
  self hidefromplayer(player);
  self.animname = "hostage_pickup";
  self useanimtree(level.scr_animtree["hostage_pickup"]);
  self._blackboard.bseqphase = "getting_picked_up";
  animstruct = spawnStruct();
  animstruct.origin = player.origin;
  animstruct.angles = player.angles;
  var_f514603feaf5c1e2 = player getmovingplatformparent();

  if(isDefined(var_f514603feaf5c1e2) && scripts\cp_mp\utility\killstreak_utility::function_63bdc8c411a85475(var_f514603feaf5c1e2)) {
    var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5 linkTo(var_f514603feaf5c1e2);
    player.var_54d7b76a2a71e284 linkTo(var_f514603feaf5c1e2);
    player playerlinkedoffsetenable();
  }

  animstruct thread scripts\mp\anim::anim_player_solo(player, player.var_e3bda5be1db297f, anime);
  animstruct thread scripts\common\anim::anim_single_solo(player.var_54d7b76a2a71e284, var_cf13edffb05efcd8);
  var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5 thread scripts\common\anim::anim_single_solo(var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5, var_cf13edffb05efcd8);
  wait getanimlength(level.scr_anim["player_pickup_hostage"][var_cf13edffb05efcd8]);
  var_f514603feaf5c1e2 = player getmovingplatformparent();

  if(isDefined(var_f514603feaf5c1e2) && scripts\cp_mp\utility\killstreak_utility::function_63bdc8c411a85475(var_f514603feaf5c1e2)) {
    var_d5b5ffad0eca8c36.var_fc77a3ee1c3e72b5 unlink();
    player.var_54d7b76a2a71e284 unlink();
    player playerlinkedoffsetdisable();
  }

  player notify("remove_rig");
  var_d5b5ffad0eca8c36 notify("remove_rig");
  player.var_73f4b954751a8643 = undefined;
  player.var_43e2c0fcf655ebac = undefined;
  player takeweapon(fists);
  scripts\mp\gametypes\rescue::function_83dfc273b8e7efed(player);
  self.var_44206360497f15c2 = undefined;
}

function function_524f22fe698eeb0f(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  function_b7771cc818b41864(player);
  gunless = makeweapon("iw9_gunless_mp");
  player giveweapon(gunless);
  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless);

  if(isDefined(player.givenweapon)) {
    player takeweapon(player.givenweapon);
    player.givenweapon = undefined;
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.switchweapon);
  } else {
    player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(player.switchweapon);
  }

  if(isDefined(player.switchweapon)) {
    player.switchweapon = undefined;
  }

  player takeweapon(gunless);
  player resetcarryobject();
}

function drophostage(forcedrop) {
  droporigin = undefined;
  dropangles = undefined;
  dropstance = undefined;

  if(!isDefined(self.carryingplayer) || !isDefined(self.carryingplayer.origin) || !isDefined(self.carryingplayer.angles)) {
    droporigin = self.carryorigin;
    dropangles = self.var_bff867759e490124;
    dropstance = self.carrystance;
  } else {
    droporigin = self.carryingplayer.origin;
    dropangles = self.carryingplayer.angles;
    dropstance = self.carryingplayer getstance();
  }

  var_7fe2df4a925adffe = undefined;
  var_9fbc564d9bb976ed = undefined;
  watercontents = physics_createcontents(["physicscontents_water"]);
  castresult = physics_getclosestpointtosphere(droporigin, 16, 0, watercontents, [], "physicsquery_any");

  if(istrue(castresult)) {
    var_7fe2df4a925adffe = 1;
  }

  contents = physics_createcontents(["physicscontents_playerclip", "physicscontents_glass"]);
  caststart = droporigin;
  castdir = (0, 0, -1);
  castdist = 60;
  castend = caststart + castdir * castdist;
  ignorelist = [self.hostage, self.carryingplayer];
  castresult = physics_capsulecast(caststart + (0, 0, 24), castend, 4, 40, (0, 0, 90), contents, ignorelist, "physicsquery_closest");

  if(!isDefined(castresult) || castresult.size <= 0) {
    function_e07d74d7e0452e2b(forcedrop);
    return;
  }

  hitent = castresult[0]["entity"];

  if(isDefined(hitent) && istrue(hitent.var_e6e657a1fa139548)) {
    var_9fbc564d9bb976ed = 1;
  }

  if(isDefined(hitent) && !function_cf6e0046827d08c(hitent, droporigin) || istrue(var_7fe2df4a925adffe) && !istrue(var_9fbc564d9bb976ed)) {
    function_e07d74d7e0452e2b(forcedrop);
    return;
  }

  var_c72145d539d8d1a1 = castresult[0]["shape_position"];
  hitpos = castresult[0]["position"];
  spawnpos = var_c72145d539d8d1a1 - (0, 0, 20);
  var_7a2d144a06a00b97 = function_a2a73e5d91d2aae4(hitent);

  if(!isDefined(var_7a2d144a06a00b97) && scripts\common\elevator::function_d9d18dab18ebded(self.carryingplayer getmovingplatformparent())) {
    var_7a2d144a06a00b97 = self.carryingplayer getmovingplatformparent();
  }

  if(isDefined(var_7a2d144a06a00b97)) {
    self.hostage.origin = droporigin;
    self.hostage.angles = dropangles;
    self.hostage.animstance = dropstance;
    localoffset = coordtransformtranspose(droporigin, var_7a2d144a06a00b97.origin, var_7a2d144a06a00b97.angles);
    localangles = combineanglesinverted(dropangles, var_7a2d144a06a00b97.angles);

    if(!isDefined(self.var_90758efde9b783b7)) {
      self.var_90758efde9b783b7 = spawn("script_origin", droporigin);
    }

    self.var_90758efde9b783b7.origin = droporigin;
    ismovingplatform = scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e(var_7a2d144a06a00b97);

    if(istrue(ismovingplatform)) {
      self.var_90758efde9b783b7 linkTo(var_7a2d144a06a00b97);
    } else {
      self.var_90758efde9b783b7 linkTo(var_7a2d144a06a00b97, "tag_origin", localoffset, localangles);
    }

    self.hostage linkTo(self.var_90758efde9b783b7);
    thread watchformovingentdeath(var_7a2d144a06a00b97);
  } else {
    self.hostage.origin = droporigin;
    self.hostage.angles = dropangles;
    self.hostage.animstance = dropstance;
  }

  self.hostage show();
  self.hostage.invulnerable = 0;
  function_6b3ac788a12c0dda(self.carryingplayer);
  animlength = undefined;

  if(isDefined(self.hostage) && istrue(self.hostage.var_44206360497f15c2) || !isDefined(self.carryingplayer)) {
    self.var_44206360497f15c2 = undefined;

    if(isDefined(self.carryingplayer) && isDefined(self.carryingplayer.var_73f4b954751a8643)) {
      self.carryingplayer takeweapon(self.carryingplayer.var_73f4b954751a8643);
    }

    waitframe();
  }

  self.hostage._blackboard.bseqphase = "getting_dropped";
  animlength = getanimlength(%iw9_mp_hostage_dropped_stand);

  if(!istrue(self.failure)) {
    self.instance setscriptablepartstate("dmz_hostage", "unusable");
  }

  if(isDefined(animlength)) {
    wait animlength;
  }

  if(!istrue(self.failure)) {
    self.instance setscriptablepartstate("dmz_hostage", "remaining");

    if(istrue(self.skipcontract)) {
      foreach(player in level.players) {
        self.instance enablescriptableplayeruse(player);
      }
    } else {
      foreach(player in level.players) {
        self.instance disablescriptableplayeruse(player);
      }

      teammates = getteamdata(self.teams[0], "players");

      foreach(teammate in teammates) {
        self.instance enablescriptableplayeruse(teammate);
      }
    }

    self.hostage._blackboard.bseqphase = "dropped";
    self.instance.origin = self.hostage.origin;
    self.instance scriptablesetparententity(self.hostage, (0, 0, 15), (0, 0, 0));

    if(!istrue(self.skipcontract)) {
      scripts\mp\objidpoolmanager::update_objective_setzoffset(self.icon, 30);
      scripts\mp\objidpoolmanager::update_objective_onentity(self.icon, self.hostage);
      self.questcircles[0] function_4eaf685bc40a3b9();
    }

    self.carryingplayer = undefined;

    if(isDefined(var_7a2d144a06a00b97) && isent(var_7a2d144a06a00b97) && var_7a2d144a06a00b97 scripts\cp_mp\vehicles\vehicle::isvehicle() && var_7a2d144a06a00b97.vehiclename == "veh9_palfa") {
      function_7cfc061c84dd495a(var_7a2d144a06a00b97);
    }
  }
}

function function_333f22ba123f0470() {
  self.carryingplayer endon("hostage_pickup_finished");
  thread function_a29878fb7affbc16();

  while(true) {
    self.instance.origin = self.hostage.origin;

    if(!istrue(self.skipcontract)) {
      scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self.hostage.origin + (0, 0, 30));
    }

    wait 0.05;
  }
}

function function_a29878fb7affbc16() {
  level endon("disconnect");
  self.carryingplayer waittill("hostage_pickup_finished");
  self.var_90758efde9b783b7 unlink();
  self.hostage unlink();
}

function function_e07d74d7e0452e2b(forcedrop) {
  if(istrue(forcedrop)) {
    self.hostage show();
    self.hostage.invulnerable = 0;
    function_6b3ac788a12c0dda(self.carryingplayer);
    self.hostage kill();
    return;
  }

  self.carryingplayer scripts\mp\hud_message::showerrormessage("MP_DMZ_MISSIONS/HOSTAGE_PLACE_ERR");
}

function function_6b3ac788a12c0dda(player) {
  if(isreallyalive(player) && !scripts\mp\utility\player::isinlaststand(player)) {
    player.playerstreakspeedscale = 0;
    player setmovespeedscale(1);
    thread scripts\mp\gametypes\rescue::function_524f22fe698eeb0f(player);
    player skydive_setdeploymentstatus(1);
    player skydive_setbasejumpingstatus(1);
  } else {
    function_b7771cc818b41864(player);

    if(isDefined(player.givenweapon)) {
      player takeweapon(player.givenweapon);
      player.givenweapon = undefined;
    }

    if(isDefined(player.switchweapon)) {
      if(scripts\mp\utility\player::isinlaststand(player)) {
        player.laststandoldweaponobj = player.switchweapon;
      }

      player.switchweapon = undefined;
    }

    player resetcarryobject();
  }

  player.var_859654e0445a36d9 = 0;
  player stopanimscriptsceneevent();
  player notify("remove_rig");

  if(isDefined(self.hostage) && isDefined(self.hostage.var_d5b5ffad0eca8c36)) {
    self.hostage.var_d5b5ffad0eca8c36 notify("remove_rig");
  }

  if(isDefined(player)) {
    player notify("drop_hostage");
  }
}

function function_cf6e0046827d08c(ent, origin) {
  if(isPlayer(ent)) {
    return false;
  }

  if(ent getnonstick()) {
    return false;
  }

  if(istrue(ent.mountmantlemodel)) {
    return false;
  }

  if(isDefined(ent.cover) && isDefined(ent.cover.equipmentref) && ent.cover.equipmentref == "equip_tac_cover") {
    return false;
  }

  if(ent.classname == "misc_turret") {
    return false;
  }

  if(ent.classname == "script_vehicle") {
    if(isDefined(ent.vehiclename) && ent.vehiclename == "veh9_civ_lnd_dirt_bike") {
      return false;
    }

    if(ent scripts\cp_mp\vehicles\vehicle_occupancy::function_a24042975031e692()) {
      foreach(point in [origin, origin + (0, 0, -10), origin + (0, 0, -20)]) {
        if(ent scripts\cp_mp\vehicles\vehicle_occupancy::function_4e4cf75e0f7e4184(point)) {
          return true;
        }
      }

      return false;
    }

    return true;
  }

  return true;
}

function function_a2a73e5d91d2aae4(hitent) {
  if(isDefined(hitent)) {
    if(scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e(hitent) || hitent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      return hitent;
    }

    return 0;
  }

  return undefined;
}

function function_eede562ce57290d3() {
  self.carryingplayer endon("drop_hostage");

  while(true) {
    if(!isDefined(self.instance)) {
      return;
    }

    if(!isDefined(self.carryingplayer)) {
      return;
    }

    start = self.carryingplayer getEye();
    ignore = [self.carryingplayer];

    if(isDefined(self.heli)) {
      ignore[ignore.size] = self.heli;
    }

    passed = scripts\engine\trace::sphere_trace_passed(start, start + (0, 0, -25), 25, ignore);

    if(self.carryingplayer isonground() && passed) {
      state = self.instance getscriptablepartstate("dmz_hostage");

      if(isDefined(state) && state != "following") {
        self.instance setscriptablepartstate("dmz_hostage", "following");

        foreach(player in level.players) {
          self.instance disablescriptableplayeruse(player);
        }

        self.instance enablescriptableplayeruse(self.carryingplayer);
      }

      forward = 5 * anglesToForward(self.carryingplayer getplayerangles());
      self.instance.origin = start + forward * 0.1;
    } else {
      self.instance setscriptablepartstate("dmz_hostage", "unusable");
    }

    waitframe();
  }
}

function function_cf6e805ce234f5e(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("drop_hostage");
  self endon("task_ended");

  while(true) {
    self.carryorigin = player.origin;
    self.var_bff867759e490124 = player.angles;
    self.carrystance = player getstance();
    waitframe();
  }
}

function watchformovingentdeath(ent) {
  self endon("hostage_pickup_finished");
  self.hostage endon("death");
  self notify("watchForMovingEntDeath");
  self endon("watchForMovingEntDeath");
  ent waittill("death");
  self.hostage kill(self.hostage.origin);
}

function watchforplayerdeath(player) {
  player endon("drop_hostage");
  player waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player stopanimscriptsceneevent();
  player notify("remove_rig");
  thread drophostage(1);
}

function function_5ac14a79b2a4db6(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("drop_hostage");
  self.hostage waittill("death");
  player stopanimscriptsceneevent();
  player notify("remove_rig");

  if(isDefined(player.var_43e2c0fcf655ebac)) {
    player.var_43e2c0fcf655ebac notify("remove_rig");
    player.var_43e2c0fcf655ebac = undefined;
  }

  function_6b3ac788a12c0dda(self.carryingplayer);
}

function function_82ef6d194918247f(player) {
  player endon("drop_hostage");
  player endon("hostage_pickup_finished");
  thread function_cf6e805ce234f5e(player);
  thread function_5ac14a79b2a4db6(player);
  thread watchforplayerdeath(player);
}

function function_f0c2012ae22ca0d6(player) {
  player val::reset_all("carry");
  player val::set("carry", "prone", 0);
  player val::set("carry", "slide", 0);
  player val::set("carry", "supersprint", 0);
  player val::set("carry", "mount_side", 0);
  player val::set("carry", "mount_top", 0);
  player val::set("carry", "mantle", 0);
  player val::set("carry", "equipment_secondary", 0);
  player val::set("carry", "equipment_primary", 0);
  player val::set("carry", "supers", 0);
  player val::set("carry", "melee", 0);
  player val::set("carry", "weapon_switch", 0);
  player val::set("carry", "swimming_underwater", 0);
  player val::set("carry", "dtp", 0);
  player val::set("carry", "ladder", 0);
  player val::set("carry", "weapon_pickup", 0);
  player val::set("carry", "weapon_switch_clip", 0);
  player val::set("carry", "killstreaks", 0);
  player val::set("carry", "execution_attack", 0);
  player val::set("carry", "vehicle_use", 0);
  player val::set("carry", "ascender_use", 0);
  player val::set("carry", "ads", 1);
  player skydive_setdeploymentstatus(0);
  player skydive_setbasejumpingstatus(0);
  player.playerstreakspeedscale = -0.25;
  player setmovespeedscale(0.75);
}

function function_b7771cc818b41864(player) {
  player val::reset_all("carry");
  player skydive_setdeploymentstatus(1);
  player skydive_setbasejumpingstatus(1);
  player.playerstreakspeedscale = 0;
  player setmovespeedscale(1);
}

function private function_cadc5181c3b67e3f(player) {
  self.defusingplayer = player;
  bomb = makeweapon("briefcase_bomb_mp");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(bomb, undefined, undefined, 0);
  player setweaponammostock(bomb, 0);
  player setweaponammoclip(bomb, 0);
  player thread scripts\mp\gameobjects::switchtouseweapon(bomb, 1, 1);
  player function_bf9ec93bee75f88c(0);
  return bomb;
}

function private function_db896f4486ca187(player, bomb) {
  lastweaponobj = player scripts\mp\utility\inventory::getlastweapon();

  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
  } else if(!player hasweapon(lastweaponobj)) {
    lastweaponobj = player scripts\mp\utility\inventory::getfirstprimaryweapon();
  }

  player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(lastweaponobj, 0, 1);
  player takeweapon(bomb);
  player function_bf9ec93bee75f88c(1);
  self.defusingplayer = undefined;
}

function private function_bf9ec93bee75f88c(isallowed) {
  val::set("hostage_holding_bomb", "allow_movement", isallowed);
  val::set("hostage_holding_bomb", "script_weapon_switch", !isallowed);
  val::set("hostage_holding_bomb", "sprint", isallowed);
  val::set("hostage_holding_bomb", "fire", isallowed);
  val::set("hostage_holding_bomb", "reload", isallowed);
  val::set("hostage_holding_bomb", "weapon_pickup", isallowed);
  val::set("hostage_holding_bomb", "weapon_switch", isallowed);
  val::set("hostage_holding_bomb", "allow_jump", isallowed);
  val::set("hostage_holding_bomb", "gesture", isallowed);
  self function_35501b42058d4de9();

  if(isallowed) {
    waittill_any_timeout_1(0.8, "bomb_allow_offhands");
  }

  val::set("hostage_holding_bomb", "melee", isallowed);
  val::set("hostage_holding_bomb", "mantle", isallowed);
  val::set("hostage_holding_bomb", "offhand_weapons", isallowed);

  if(isallowed) {
    val::reset_all("hostage_holding_bomb");
    self function_bb04491d50d9e43e();
  }
}

function function_b6b601986dcad85a() {
  spawnlocs = getStructArray(self.node.target, "targetname");
  spawnlocs = array_randomize(spawnlocs);
  self.hostage = undefined;

  foreach(spawnloc in spawnlocs) {
    if(!isDefined(spawnloc.script_noteworthy) || spawnloc.script_noteworthy != "hostage") {
      continue;
    }

    poiname = scripts\mp\poi::poi_findpoioriginisin(spawnloc.origin);
    ai = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent("civilian_mp_dmz_hostage", getclosestpointonnavmesh(spawnloc.origin), spawnloc.angles, "absolute", "mission", undefined, "civs", "civilian", undefined, poiname, 1, undefined, 0);

    if(!isDefined(ai)) {
      return;
    }

    ai.var_b582b10663b5b2a9 = 0;
    ai.ignoreme = 1;
    ai.health = 250;
    ai.maxhealth = 250;
    ai setcanusecover(0);
    ai function_b661b022700ba72f("script", 1);
    ai.callbackdamaged = &function_164927827f9f0870;
    ai scripts\common\cap::cap_start("cap_hostage", "civilian_dmz_hostage");
    ai.ishostage = 1;
    ai.task = self;
    self.hostage = ai;
    level.agent_funcs[ai.agent_type]["on_damaged"] = &scripts\mp\ai_mp_controller::function_779b9979fd853e26;
    ai.invulnerable = 1;
    break;
  }

  if(!isDefined(self.hostage)) {
    return;
  }

  self.instance = spawnscriptable("dmz_hostage", self.hostage.origin, (0, 0, 0));
  self.instance.hostage = self.hostage;
  self.hostage.instance = self.instance;
  self.instance.task = self;
  self.instance setscriptablepartstate("dmz_hostage", "unusable", 0);

  if(!istrue(self.skipcontract)) {
    bombspawnloc = self.hostage.origin + anglestoright(self.hostage.angles) * -20;
    self.c4 = spawn("script_model", bombspawnloc);
    self.c4 setModel("offhand_2h_wm_briefcase_bomb_v0");
    self.c4.issuper = 0;
  }

  thread function_c0ccb94fcfe50916();
}

function function_164927827f9f0870(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  isplayerdamage = isDefined(eattacker) && (isPlayer(eattacker) || isDefined(eattacker.owner) && isPlayer(eattacker.owner));

  if(istrue(isplayerdamage) && istrue(level.var_af7d80856e5ae6c0.blockplayerdamage)) {
    return;
  }

  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function private function_5511b411b075d27b() {
  self.hostage.origin = level.players[0].origin;
  self.hostage.instance.origin = level.players[0].origin;
}

function private function_14f7745b0a1250db() {
  spawnlocs = getStructArray(self.fort.target, "targetname");
  self.guards = [];

  if(isDefined(self.hostage) && isDefined(self.hostage.origin)) {
    spawnlocs = sortbydistance(spawnlocs, self.hostage.origin);
  }

  for(i = 0; i < spawnlocs.size; i++) {
    if(self.guards.size >= 8) {
      break;
    }

    spawnloc = spawnlocs[i];

    if(!isDefined(spawnloc.script_noteworthy) || !issubstr(spawnloc.script_noteworthy, "guard")) {
      continue;
    }

    basetype = "ar";

    if(i == 1) {
      basetype = "shotgun";
    }

    aitype = scripts\mp\ai_mp_controller::function_d5bc07eabf352abb(undefined, undefined, undefined, "ar", 3);
    enemy = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, spawnloc.origin, spawnloc.angles, "high", "mission", "hostageGuard", undefined, undefined, undefined, self.node.poi, 0, undefined, 0);

    if(isDefined(enemy)) {
      function_67f905dfb8137021(enemy, 1);
      enemy scripts\mp\ai_behavior::function_304da84d9a815c01(enemy.origin, 16);
      enemy.var_b582b10663b5b2a9 = 0;
      self.guards[self.guards.size] = enemy;

      if(issubstr(aitype, "shotgun")) {
        if(!isDefined(self.shotgun_guard)) {
          self.shotgun_guard = enemy;
        }
      }

      thread scripts\mp\ai_behavior::function_b11c1964f528574b(enemy);
    }
  }
}

function function_67f905dfb8137021(agent, noweaponchange) {
  grenade_type = random(["concussion_grenade_mp", "smoke_grenade_mp", "flash_grenade_mp"]);
  grenadeammo = getdvarint(@ "hash_537fa443ce212a8a", 4);
  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, undefined, grenade_type, grenadeammo, undefined, undefined);
}

function function_8dc13537721b3c2d() {
  self.task endon("task_ended");
  self endon("death");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    state = self.task.state;

    if(!isDefined(state)) {
      state = "";
    }

    dialogprefix = ter_op(isDefined(level.var_b58c6275920edf51), level.var_b58c6275920edf51, "dmzc");
    alias = function_422546a862beb2c7(state, dialogprefix);
    thread scripts\anim\dialogue::function_e7c1c9dee13137aa(alias);

    if(state == "rescued") {
      return;
    }

    length = lookupsoundlength(alias);
    waittill_notify_or_timeout("play_dialog", length / 1000 + 4);
  }
}

function function_422546a862beb2c7(state, prefix) {
  nationality = ter_op(isDefined(level.var_ce11405f66c0872e), level.var_ce11405f66c0872e, "cvm3");
  var_b4648963b1ef138c = undefined;

  switch (state) {
    case #"hash_56049e7ee0845631":
      var_b4648963b1ef138c = "_creb";
      break;
    case #"hash_5548a62ed50ac006":
      var_b4648963b1ef138c = "_crec";
      break;
    case #"hash_a152dd6f2d4b9918":
      var_b4648963b1ef138c = "_cref";
      break;
    default:
      var_b4648963b1ef138c = "_cire";
      break;
  }

  alias = "dx_br_" + prefix + "_hore_" + nationality + var_b4648963b1ef138c;
  return alias;
}

function function_df48d309a8bc55a() {
  function_5314298e777e5688("dmz_hostage_transport");
  thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_rescue_heli_incoming", self.teams[0], 5);
  wait 5;

  if(!istrue(self.failure)) {
    path = namespace_e8fceb5cf6e8cdf8::function_ed11ae9fe1abdeb(self.helinode, self.helinode.origin);

    if(!isDefined(path)) {
      if(!istrue(self.failure)) {
        thread function_cb2f74520e05756f(self.teams[0]);
      }

      return;
    }

    ownerplayer = undefined;
    players = getteamdata(self.teams[0], "players");

    if(!isDefined(players)) {
      function_cb2f74520e05756f();
      return;
    }

    for(i = 0; i < players.size && !isDefined(ownerplayer); i++) {
      ownerplayer = players[i];
    }

    if(!isDefined(ownerplayer)) {
      function_cb2f74520e05756f();
      return;
    }

    team = ownerplayer.team;
    self.heli = namespace_e8fceb5cf6e8cdf8::function_d05f47d864f18196(ownerplayer, path.origin, self.helinode.angles);
    thread namespace_e8fceb5cf6e8cdf8::function_a5fc6e8f9df1ccea(self.heli, self.helinode.origin);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self.heli, team);
    self.heli.onstartriding = &function_8ebf38fbb99af797;
    self.heli.onendriding = &function_f6685fad77b7f64d;
    self.heli.task = self;
    self.heli.helinode = self.helinode;
    self.heli.minwaittimer = 1;
    self.heli.exfilhelicopter = 1;
    self.heli thread function_364ab6a28426c5ce(path);
  } else {
    return;
  }

  if(!istrue(self.failure)) {
    function_21d5138d3f032dd4();
  }

  if(!isDefined(self.hostageheli)) {
    return;
  }

  if(!istrue(self.completed)) {
    scripts\mp\objidpoolmanager::update_objective_onentity(self.icon, self.hostageheli);
  }

  if(!istrue(self.failure)) {
    self.hostage.invulnerable = 1;
  }

  while(!istrue(self.hostageheli.exfilpathstarted)) {
    self.hostageheli waittill("exfil_path_started");
  }

  thread function_2d144609316a301e(self.hostageheli);

  if(!istrue(self.failure)) {
    thread function_cb2f74520e05756f(self.teams[0]);
  }
}

function function_7cfc061c84dd495a(heli) {
  if(istrue(heli.exfilhelicopter)) {
    self.instance setscriptablepartstate("dmz_hostage", "unusable");

    if(!isDefined(self.var_90758efde9b783b7)) {
      self.var_90758efde9b783b7 = spawn("script_origin", self.hostage.origin);
    }

    self.var_90758efde9b783b7.origin = self.hostage.origin;
    self.var_90758efde9b783b7 linkTo(heli);
    self.hostage linkTo(self.var_90758efde9b783b7);
    self.hostage.invulnerable = 1;
    self.var_49ad1a873f5f008b = 1;
    self.hostageheli = heli;
    heli notify("dmz_exfil_hostage_inside");
    self notify("dmz_hostage_inside_heli");
  }
}

function function_364ab6a28426c5ce(path) {
  self endon("death");
  scripts\common\vehicle_paths::vehicle_paths_helicopter(path);

  if(!istrue(self.helinode.info.land)) {
    self sethoverparams(0, 0, 0);
  }

  if(!istrue(self.task.completed)) {
    self.task waittill_any_2("dmz_hostage_inside_heli", "task_ended");
  }

  if(istrue(self.task.failure)) {
    function_8c05501355cc8322();
  }

  self.exfilpathstarted = 1;
  self notify("exfil_path_started");
  namespace_e8fceb5cf6e8cdf8::function_18d68b06fa34264b(self);
  path = namespace_e8fceb5cf6e8cdf8::function_1093b8f392744e3b(self.helinode, self.helinode.origin, level.chopperexfil.heliheight);
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
  wait 8;

  if(!istrue(self.failure)) {
    info = namespace_e8fceb5cf6e8cdf8::function_730c660d9fc6808e(self.playersinside, 0, 1, 0, 0);
    namespace_25b25d188ef778c4::exfilplayers(self.playersinside, info);
  }

  wait 15;
  thread namespace_e8fceb5cf6e8cdf8::function_ed686fcbc5363b3();
}

function function_8ebf38fbb99af797(player) {
  if(!array_contains_key(self.playersinside, player.guid)) {
    self.playersinside[player.guid] = player;
    scripts\mp\outofbounds::enableoobimmunity(player);

    if(!istrue(self.task.var_be20b95d97b75707)) {
      self.task.var_be20b95d97b75707 = 1;
      scripts\cp_mp\overlord::function_9793a81bc3bc19e9("hostage_lower_heli", self.task.teams[0]);
    }
  }

  if(istrue(self.task.var_49ad1a873f5f008b) && isDefined(self.var_75adb7f3cbe5d522)) {
    if(!isDefined(player.var_a09b2cb47a28054a)) {
      self.var_902a7ffcff8aa65[self.var_902a7ffcff8aa65.size] = player;
      player thread namespace_25b25d188ef778c4::playerexfiltimer(self.origin, self.var_75adb7f3cbe5d522, 2000);
    }
  }
}

function function_f6685fad77b7f64d(player) {
  self.playersinside[player.guid] = undefined;

  if(scripts\mp\outofbounds::isoobimmune(player)) {
    scripts\mp\outofbounds::disableoobimmunity(player);
  }
}

function function_662ca8c888b5eb6(startnode, heliheight, reverse) {
  if(!isDefined(reverse)) {
    reverse = 0;
  }

  var_3fb4a86293ed25a6 = 10;
  contents = create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  startpos = startnode.origin + (0, 0, heliheight + 600);
  var_3674d96c61e2dd0d = ter_op(reverse, startnode.angles[1] + 180, startnode.angles[1]);
  yaw = 0;

  while(yaw < 360) {
    var_3674d96c61e2dd0d += yaw;
    testangles = (0, var_3674d96c61e2dd0d, 0);
    approachstartpos = startpos;
    approachendpos = startpos + anglesToForward(testangles) * 18000;
    approachtrace = sphere_trace(approachstartpos, approachendpos, 100, undefined, contents, 1);

    if(approachtrace["fraction"] == 1) {
      line(approachstartpos, approachendpos, (0, 1, 0), 1, 0, 2000);

      return approachendpos;
    }

    line(approachstartpos, approachendpos, (1, 0, 0), 1, 0, 2000);

    if(yaw % 3 == 0) {
      waitframe();
    }

    yaw += var_3fb4a86293ed25a6;
  }

  return undefined;
}

function function_21d5138d3f032dd4() {
  self endon("task_ended");

  while(!isDefined(self.hostageheli)) {
    self waittill("dmz_hostage_inside_heli");
  }
}

function function_9597b6c3f099d3d7() {
  self.task endon("task_ended");

  if(!istrue(self.var_49ad1a873f5f008b)) {
    self waittill("dmz_exfil_hostage_inside");
  }

  self.var_75adb7f3cbe5d522 = 5;

  foreach(player in self.playersinside) {
    if(!isDefined(player.var_a09b2cb47a28054a)) {
      self.var_902a7ffcff8aa65[self.var_902a7ffcff8aa65.size] = player;
      player thread namespace_25b25d188ef778c4::playerexfiltimer(self.origin, self.var_75adb7f3cbe5d522, 2000);
    }
  }

  while(self.var_75adb7f3cbe5d522 > 0) {
    self.var_75adb7f3cbe5d522 -= 1;
    wait 1;
  }
}

function function_8c05501355cc8322() {
  self endon("death");
  level endon("game_ended");
  var_c82efe11c4073af4 = [];

  while(true) {
    wait 1;
    var_7408ed52662703d3 = utility::playersincylinder(self.origin, 665, undefined, 500);

    foreach(player in var_7408ed52662703d3) {
      if(!isDefined(var_c82efe11c4073af4[player.guid])) {
        var_c82efe11c4073af4[player.guid] = gettime();
      }

      if(gettime() - var_c82efe11c4073af4[player.guid] > 5000) {
        player scripts\mp\hud_message::showerrormessage("MP_DMZ_MISSIONS/HOSTAGE_HELI_MSG");
        var_c82efe11c4073af4[player.guid] = gettime();
      }
    }

    if(var_7408ed52662703d3.size == 0) {
      break;
    }
  }
}

function function_2d144609316a301e(heli) {
  heli waittill("death");

  if(isDefined(self.hostage) && isalive(self.hostage) && istrue(self.var_49ad1a873f5f008b)) {
    self.hostage scripts\mp\ai_mp_controller::function_28b90eb2b591003f();
  }

  if(isDefined(self.var_90758efde9b783b7)) {
    self.var_90758efde9b783b7 delete();
  }
}

function function_f0c7539dc72c3dfd() {
  alllocations = array_randomize(getStructArray("hostage_setup", "targetname"));
  validlocations = [];
  helinodes = array_randomize(getStructArray("dmz_hostage_exfil", "script_noteworthy"));

  foreach(loc in alllocations) {
    isvalid = 1;

    if(!isDefined(loc.target)) {
      continue;
    }

    spawnlocs = getStructArray(loc.target, "targetname");

    foreach(spawnloc in spawnlocs) {
      if(isDefined(spawnloc.script_noteworthy) && spawnloc.script_noteworthy == "hostage") {
        pos = getclosestpointonnavmesh(spawnloc.origin);

        if(distance(pos, spawnloc.origin) > 100) {
          isvalid = 0;
          break;
        }
      }
    }

    if(!isvalid) {
      continue;
    }

    fortress = namespace_9823ee6035594d67::function_bbe42d7091bedfc5(loc.origin, "hostage_forts");

    if(!isDefined(fortress)) {
      continue;
    }

    if(distance2dsquared(fortress.origin, loc.origin) > level.var_af7d80856e5ae6c0.var_82a01ce31b77ac5c * level.var_af7d80856e5ae6c0.var_82a01ce31b77ac5c || array_contains(level.var_f1073fbd45b59a06.var_df987907a483df89, fortress)) {
      continue;
    }

    mindist = 12000;

    foreach(heli in helinodes) {
      dist = distance(loc.origin, heli.origin);

      if(!istrue(heli.chosen) && dist < mindist) {
        mindist = dist;
        loc.helinode = heli;
      }
    }

    if(isDefined(loc.helinode)) {
      loc.helinode.chosen = 1;
    } else {
      isvalid = 0;
    }

    if(isvalid) {
      validlocations[validlocations.size] = loc;
    }
  }

  return validlocations;
}

function debughostage() {
  while(true) {
    if(getdvarint(@ "hash_c387ab1458383808", 0)) {
      setDvar(@ "hash_c387ab1458383808", 0);

      if(isDefined(self.carryingplayer)) {
        drophostage(1);
      }
    }

    waitframe();
  }
}

# /
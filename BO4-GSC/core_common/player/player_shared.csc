/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_shared.csc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace player;

autoexec __init__system__() {
  system::register(#"player", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "gameplay_started", 1, 1, "int", &gameplay_started_callback, 0, 1);
  clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "player_dof_settings", 1, 2, "int", &function_f9e445ee, 0, 0);
  callback::on_localplayer_spawned(&local_player_spawn);
  callback::on_spawned(&on_player_spawned);
}

gameplay_started_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setdvar(#"cg_isgameplayactive", newval);

  if(newval) {
    level callback::callback(#"on_gameplay_started", localclientnum);
  }
}

local_player_spawn(localclientnum) {
  if(!self function_21c0fa55()) {
    return;
  }

  setdepthoffield(localclientnum, 0, 0, 0, 0, 6, 1.8);
}

on_player_spawned(localclientnum) {
  if(sessionmodeiswarzonegame()) {
    return;
  }

  var_87e3f0d8 = function_27673a7(localclientnum);

  if(level.var_7315d934 === 1) {
    if(var_87e3f0d8 == self) {
      var_87e3f0d8 thread function_c98e67ae(localclientnum);
    }

    return;
  }

  players = getplayers(localclientnum);

  foreach(player in players) {
    player function_8656d7d1(localclientnum);
  }
}

function_f22aa227(localclientnum) {
  if(level.var_7315d934 === 1) {
    self function_9f517895(localclientnum);
    return;
  }

  self function_8656d7d1(localclientnum);
}

private function_8656d7d1(localclientnum) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(player)) {
    return;
  }

  var_87e3f0d8 = function_27673a7(localclientnum);

  if(player.team !== var_87e3f0d8.team) {
    player function_e2d964e8();
    return;
  }

  player function_f71119e0(0);
}

function_c98e67ae(localclientnum) {
  self notify("3ae575e255539f29");
  self endon("3ae575e255539f29");
  wait 10;

  while(true) {
    wait 0.2;
    players = getplayers(localclientnum);
    var_f3108b8 = function_5c10bd79(localclientnum);

    foreach(player in players) {
      if(player == var_f3108b8) {
        continue;
      }

      player function_9f517895(localclientnum);
    }
  }
}

private function_9f517895(localclientnum) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(player)) {
    return;
  }

  var_87e3f0d8 = function_27673a7(localclientnum);
  var_f3108b8 = function_5c10bd79(localclientnum);

  if(player.team !== var_87e3f0d8.team && !player isplayerswimmingunderwater() && !var_f3108b8 isplayerswimmingunderwater()) {
    player function_e2d964e8();
    return;
  }

  player function_f71119e0(0);
}

private function_e2d964e8() {
  if(self.visionpulsereveal === 1) {
    return;
  }

  if(isDefined(level.var_20369084)) {
    self function_9535c165(level.var_20369084, "cold_blooded");
    return;
  }

  self function_bd70f43d();
}

function_9535c165(var_2af183d0, clientfield) {
  if(self clientfield::get(clientfield) > 0) {
    self function_994b4121();
    self enable_rob(var_2af183d0);
    return;
  }

  self disable_rob(var_2af183d0);
  self function_bd70f43d();
}

function_f2ba057() {
  function_f71119e0(1);
}

private function_f71119e0(var_c8db7193) {
  if(self.visionpulsereveal === 1) {
    return;
  }

  if(isDefined(level.var_20369084)) {
    self disable_rob(level.var_20369084);
  }

  self function_994b4121();
}

enable_rob(var_6560376a) {
  if(!self function_d2503806(var_6560376a)) {
    self playrenderoverridebundle(var_6560376a);
  }
}

disable_rob(var_6560376a) {
  if(self function_d2503806(var_6560376a)) {
    self stoprenderoverridebundle(var_6560376a);
  }
}

private function_bd70f43d() {
  if(!self function_d2503806(#"rob_sonar_set_enemy")) {
    self playrenderoverridebundle(#"rob_sonar_set_enemy");
  }
}

private function_994b4121() {
  if(self function_d2503806(#"rob_sonar_set_enemy")) {
    self stoprenderoverridebundle(#"rob_sonar_set_enemy");
  }
}

function_f9e445ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0:
      setdepthoffield(localclientnum, 0, 0, 512, 512, 4, 0);
      break;
    case 1:
      setdepthoffield(localclientnum, 0, 0, 512, 4000, 4, 0);
      break;
    case 2:
      setdepthoffield(localclientnum, 0, 128, 512, 4000, 6, 1.8);
      break;
    default:
      break;
  }
}
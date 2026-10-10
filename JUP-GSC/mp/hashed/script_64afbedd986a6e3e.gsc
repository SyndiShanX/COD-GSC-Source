/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_64afbedd986a6e3e.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\music_and_dialog;
#namespace zombie_music;

function function_4b77a1615a8dd64a() {
  level thread scripts\mp\music_and_dialog::disablemusic();
  game["zombiemusic_bank"] = undefined;
  game["zombiemusic_bank_default"] = undefined;
  level callback::add("player_connect", &on_playerconnect);
}

function on_playerconnect(sparams) {
  function_5fd4ac422c2433ab();
}

function function_5fd4ac422c2433ab() {
  if(!isDefined(self.var_3fb2c165c0c044b8)) {
    self.var_3fb2c165c0c044b8 = spawnStruct();
    self.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47 = 1;
    self.var_3fb2c165c0c044b8.active_bank = undefined;
    self.var_3fb2c165c0c044b8.state_current = undefined;
    self.var_3fb2c165c0c044b8.state_prev = undefined;
    self.var_3fb2c165c0c044b8.priority_current = 1;
    self.var_3fb2c165c0c044b8.priority_prev = 1;
  }
}

function function_8888f70dbecaeda1(var_d7c75c93c4ca506) {
  foreach(player in level.players) {
    player thread function_8ae818ed183a1753(var_d7c75c93c4ca506);
  }
}

function function_8ae818ed183a1753(var_d7c75c93c4ca506) {
  function_8b1835eeb80e8efc(self);

  if(function_17f2893c6d199180(self, var_d7c75c93c4ca506)) {
    return;
  }

  self notify("zombieMusicStateUpdate");
  var_8af73af26533d0ac = game["zombiemusic_bank"][self.var_3fb2c165c0c044b8.active_bank][var_d7c75c93c4ca506];

  if(isDefined(self.var_3fb2c165c0c044b8.state_current)) {
    self.var_3fb2c165c0c044b8.state_prev = self.var_3fb2c165c0c044b8.state_current;
  }

  self.var_3fb2c165c0c044b8.state_current = var_d7c75c93c4ca506;
  self.var_3fb2c165c0c044b8.priority_current = var_8af73af26533d0ac.n_priority;
  var_e13d86eabf5ff75d = var_8af73af26533d0ac.array_musicstates[randomintrange(0, var_8af73af26533d0ac.array_musicstates.size)];
  self setplayermusicstate(var_e13d86eabf5ff75d);

  if(!var_8af73af26533d0ac.var_aaa744342068977a) {
    thread function_b88aec4b0b3b3614(var_e13d86eabf5ff75d);
  }
}

function function_17f2893c6d199180(player, var_d7c75c93c4ca506) {
  if(!function_cda1c2ac4fa2e2da(player)) {
    return true;
  }

  if(!isDefined(game["zombiemusic_bank"]) || !isDefined(player.var_3fb2c165c0c044b8.active_bank)) {
    return true;
  }

  if(!isDefined(game["zombiemusic_bank"][player.var_3fb2c165c0c044b8.active_bank])) {
    return true;
  }

  if(!isDefined(game["zombiemusic_bank"][player.var_3fb2c165c0c044b8.active_bank][var_d7c75c93c4ca506])) {
    return true;
  }

  var_8af73af26533d0ac = game["zombiemusic_bank"][player.var_3fb2c165c0c044b8.active_bank][var_d7c75c93c4ca506];

  if(var_8af73af26533d0ac.array_musicstates.size <= 0) {
    return true;
  }

  if(!isDefined(player.var_3fb2c165c0c044b8)) {
    return true;
  }

  var_225923bb7dfc33dd = player.var_3fb2c165c0c044b8;

  if(isDefined(player.var_3fb2c165c0c044b8.state_current)) {
    if(player.var_3fb2c165c0c044b8.priority_current > var_8af73af26533d0ac.n_priority && var_8af73af26533d0ac.n_priority != 0) {
      return true;
    }

    if(player.var_3fb2c165c0c044b8.state_current == var_d7c75c93c4ca506) {
      return true;
    }
  }

  return false;
}

function function_b88aec4b0b3b3614(var_e13d86eabf5ff75d) {
  self endon("zombieMusicStateUpdate");
  self endon("zombieMusicStateClear");
  self endon("death_or_disconnect");
  level endon("game_ended");
  n_wait_time = function_30429ea66e99f476(var_e13d86eabf5ff75d);
  wait n_wait_time;

  if(isDefined(self)) {
    function_9450c133a155c196();
  }
}

function function_9e6da63353ea9512(var_d7c75c93c4ca506) {
  foreach(player in level.players) {
    player thread function_9450c133a155c196(var_d7c75c93c4ca506);
  }
}

function function_9450c133a155c196(var_d7c75c93c4ca506) {
  if(!function_cda1c2ac4fa2e2da(self)) {
    return;
  }

  if(isDefined(var_d7c75c93c4ca506)) {
    if(isDefined(self.var_3fb2c165c0c044b8.state_current)) {
      if(self.var_3fb2c165c0c044b8.state_current == var_d7c75c93c4ca506) {
        self notify("zombieMusicStateClear");
        self setplayermusicstate("");
        self.var_3fb2c165c0c044b8.state_prev = self.var_3fb2c165c0c044b8.state_current;
        self.var_3fb2c165c0c044b8.priority_prev = self.var_3fb2c165c0c044b8.priority_current;
        self.var_3fb2c165c0c044b8.state_current = undefined;
        self.var_3fb2c165c0c044b8.priority_current = 1;
      } else {
        return;
      }
    } else {
      return;
    }

    return;
  }

  self notify("zombieMusicStateClear");
  self setplayermusicstate("");
  self.var_3fb2c165c0c044b8.state_prev = self.var_3fb2c165c0c044b8.state_current;
  self.var_3fb2c165c0c044b8.priority_prev = self.var_3fb2c165c0c044b8.priority_current;
  self.var_3fb2c165c0c044b8.state_current = undefined;
  self.var_3fb2c165c0c044b8.priority_current = 1;
}

function function_30429ea66e99f476(str_statename) {
  str_alias = "mus_" + str_statename + "_intro";
  duration_ms = lookupsoundlength(str_alias);

  if(!isDefined(duration_ms) || duration_ms <= 0) {
    duration_ms = 1000;
  }

  return duration_ms / 1000;
}

function function_43956cb0410eec0f() {
  foreach(player in level.players) {
    level thread function_f95cf184582d2009(player);
  }
}

function function_f95cf184582d2009(player) {
  if(!isDefined(player)) {
    return;
  }

  if(!isDefined(player.var_3fb2c165c0c044b8)) {
    return;
  }

  player.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47 = 1;
}

function function_94636ebe77d7581a() {
  function_9e6da63353ea9512();

  foreach(player in level.players) {
    level thread function_665863ce16735aae(player);
  }
}

function function_665863ce16735aae(player) {
  if(!isDefined(player)) {
    return;
  }

  if(!isDefined(player.var_3fb2c165c0c044b8)) {
    return;
  }

  player.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47 = 0;
}

function function_cda1c2ac4fa2e2da(player) {
  if(!isDefined(player)) {
    return 0;
  }

  if(!isDefined(player.var_3fb2c165c0c044b8)) {
    return 0;
  }

  return player.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47;
}

function function_d7f0cecf71088d68(var_60e81aa6c9b5d1cf) {
  assertex(!isDefined(level.var_4beddfdc7466d52a), "<dev string:x1c>");
  level.var_4beddfdc7466d52a = var_60e81aa6c9b5d1cf;
}

function function_fba03eb610498694() {
  assert(isDefined(level.var_4beddfdc7466d52a));
  level.var_4beddfdc7466d52a = undefined;
}

function function_956cfd575691a5d9(var_6e450c4f40b511ee, var_7a511a9369ed49e5, n_priority, var_aaa744342068977a) {
  if(!isDefined(game["zombiemusic_bank"])) {
    game["zombiemusic_bank"] = [];
  }

  var_9e2dc14ec772ce23 = undefined;
  tokens = strtok(var_6e450c4f40b511ee, "#");

  if(tokens.size > 1) {
    var_9e2dc14ec772ce23 = tokens[0];
    var_6e450c4f40b511ee = tokens[1];
  } else if(isDefined(level.var_4beddfdc7466d52a)) {
    var_9e2dc14ec772ce23 = level.var_4beddfdc7466d52a;
  }

  if(!isDefined(var_9e2dc14ec772ce23)) {
    return;
  }

  if(!isDefined(game["zombiemusic_bank"][var_9e2dc14ec772ce23])) {
    game["zombiemusic_bank"][var_9e2dc14ec772ce23] = [];
  }

  game["zombiemusic_bank"][var_9e2dc14ec772ce23][var_6e450c4f40b511ee] = spawnStruct();
  game["zombiemusic_bank"][var_9e2dc14ec772ce23][var_6e450c4f40b511ee].n_priority = n_priority;
  game["zombiemusic_bank"][var_9e2dc14ec772ce23][var_6e450c4f40b511ee].array_musicstates = var_7a511a9369ed49e5;
  game["zombiemusic_bank"][var_9e2dc14ec772ce23][var_6e450c4f40b511ee].var_aaa744342068977a = 0;

  if(isDefined(var_aaa744342068977a)) {
    game["zombiemusic_bank"][var_9e2dc14ec772ce23][var_6e450c4f40b511ee].var_aaa744342068977a = var_aaa744342068977a;
  }
}

function function_9326597e1696db30(var_60e81aa6c9b5d1cf) {
  foreach(player in level.players) {
    player function_bf7177d54915e7d4(var_60e81aa6c9b5d1cf);
  }
}

function function_bf7177d54915e7d4(var_60e81aa6c9b5d1cf) {
  self.var_3fb2c165c0c044b8.active_bank = var_60e81aa6c9b5d1cf;
}

function function_8b1835eeb80e8efc(player) {
  if(!isDefined(player.var_3fb2c165c0c044b8)) {
    return;
  }

  if(!isDefined(player.var_3fb2c165c0c044b8.active_bank)) {
    if(isDefined(game["zombiemusic_bank_default"])) {
      player function_bf7177d54915e7d4(game["zombiemusic_bank_default"]);
    }
  }
}
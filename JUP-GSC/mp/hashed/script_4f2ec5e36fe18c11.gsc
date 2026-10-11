/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4f2ec5e36fe18c11.gsc
*************************************************/

#using script_27af1dac0930f28e;
#using script_35ee5e2cef30eea2;
#using script_40e63dd222434655;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_util;
#using scripts\mp\outline;
#using scripts\mp\teams;
#namespace namespace_cf6ea30b1312e834;

function function_9813640fb9b49e46(bots) {
  if(!isDefined(bots)) {
    return;
  }

  var_105033a3f589a207 = [];
  var_7bb9679b97ffc9df = [];
  var_e80ef5b65c009b23 = [];

  foreach(bot in bots) {
    switch (bot.spawnpriority) {
      case #"hash_7e89154a96f625d":
        var_105033a3f589a207 = array_add(var_105033a3f589a207, bot);
        break;
      case #"hash_2881ce6c1efb40c5":
        var_7bb9679b97ffc9df = array_add(var_7bb9679b97ffc9df, bot);
        break;
      case #"hash_2f27546c22430661":
        var_e80ef5b65c009b23 = array_add(var_e80ef5b65c009b23, bot);
        break;
      default:
        var_7bb9679b97ffc9df = array_add(var_7bb9679b97ffc9df, bot);
        break;
    }
  }

  function_686deda65062ab0a(var_105033a3f589a207, "high_priority_bots_spawned");
  thread function_686deda65062ab0a(var_7bb9679b97ffc9df, "mid_priority_bots_spawned");
  thread function_1484a2c2c40efa4e(var_e80ef5b65c009b23, "low_priority_bots_spawned");
}

function private function_686deda65062ab0a(bots, notifyflag) {
  if(!isDefined(bots[0])) {
    return;
  }

  foreach(bot in bots) {
    function_b7f44575cc09ded1(bot);
  }

  if(isDefined(notifyflag)) {
    level notify(notifyflag);
  }
}

function private function_1484a2c2c40efa4e(bots, notifyflag) {
  if(!isDefined(bots[0])) {
    return;
  }

  level waittill("mid_priority_bots_spawned");

  foreach(bot in bots) {
    while(level.players.size >= level.maxclients) {
      wait 5;
    }

    function_b7f44575cc09ded1(bot);
  }

  if(isDefined(notifyflag)) {
    level notify(notifyflag);
  }
}

function function_b7f44575cc09ded1(bot) {
  bot.botentity = function_5f09f43b4ad28837(bot);

  while(!isDefined(bot.botentity) || !isDefined(bot.botentity.sessionstate) || bot.botentity.sessionstate == "spectator" || bot.botentity.sessionstate == "intermission") {
    waitframe();
  }

  bot thread function_f6354bdcd37ead9f();
  level.ftuedata.botsinfo.spawnedbots++;
  return bot;
}

function private function_5f09f43b4ad28837(spawndata) {
  assert(isDefined(spawndata.name));
  assert(isDefined(spawndata.team));
  assert(isDefined(spawndata.operatorref));
  assert(isDefined(spawndata.personality));
  bot = addbot(spawndata.name);
  connecting = spawnStruct();
  connecting.ready = 0;
  connecting.abort = 0;
  connecting.difficulty = spawndata.personality;

  if(spawndata.team == "ally") {
    spawndata.team = level.player.team;
  }

  bot bot_set_loadout_class();
  bot spawn_bot_latent(spawndata.team, undefined, connecting);
  waitframe();
  bot scripts\mp\teams::createoperatorcustomization(spawndata.operatorref[0], spawndata.operatorref[1]);
  bot.sessionsquadid += level.ftuedata.botsinfo.spawnedbots + 1;
  return bot;
}

function private function_f6354bdcd37ead9f() {
  while(distance(self.botentity.origin, level.ftuedata.botsinfo.inactiveposition) > 200) {
    self.botentity setOrigin(level.ftuedata.botsinfo.inactiveposition);
    waitframe();
  }

  self.botentity function_390c90207bac8552();

  while(!self.botentity isonground()) {
    waitframe();
  }

  self.botentity function_67d00e6b876c5ee2(self.spawnposition, self.spawnrotation);

  if(!isDefined(self.entranceonspawn) || !self.entranceonspawn) {
    self.botentity function_a593971d75d82113();
    self.botentity function_379bb555405c16bb("ftue_bots::ftue_bots_placeBotOnSpawnPoint()");
    self.botentity botsetflag("suspended", 1);
  }

  self.botentity.armorhealth = 0;
  self.botentity takeallweapons();
  startingweapon = scripts\cp_mp\weapon::buildweapon(self.weapon, undefined, undefined, undefined, -1, undefined, undefined, undefined, 0);
  self.botentity giveweapon(startingweapon);
  self.botentity switchtoweapon(startingweapon);
  self.botentity allowreload(0);
  self.botentity function_f83c33a014ee22fe();
}

function function_390c90207bac8552() {
  assert(isbot(self));
  self botsetflag("disable_movement", 1);
  self botsetflag("disable_attack", 1);
  self allowslide(0);
  self.var_4165728871d6465c = 0;
  self.var_bc97abf5a86e403f = 0;
  self.var_77198b6da7d57a45 = 0;
  self.var_95ee53cadeb45990 = 0;
  self botsetflag("ignore_nodes", 1);

  foreach(decision in self.mind.var_f0a8822dcc782c9d.decisions) {
    decision.enabled = 0;
    decision.var_10f0b5c52ece08ce = 0;
  }
}

function function_931679c28a759f96(botstruct, style) {
  if(!isDefined(botstruct.botentity) || !isbot(botstruct.botentity)) {
    return;
  }

  botstruct.botentity botsetflag("suspended", 0);
  botstruct.botentity playershow();
  botstruct.botentity scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("ftue_bots::ftue_bots_botMakeEntrance()");

  if(getdvarint(@ "hash_957c4bdd53678c6f", 0) == 1) {
    botstruct.botentity function_67d00e6b876c5ee2(botstruct.destpositions["DEFAULT"][0]);
    botstruct.botentity function_9cd34cbd05a34bf2(botstruct.destpositions["DEFAULT"][1]);
    botstruct function_5827a66f9760a49d();
  } else if(isDefined(style)) {
    switch (style) {
      case #"hash_20cd76d83c2f7487":
        if(isDefined(botstruct.destpositions["DEFAULT"])) {
          botstruct function_f5ce7d12b7b279d3("DEFAULT", undefined, &function_5827a66f9760a49d, botstruct);
        }

        break;
      case #"hash_718f4c8bdaf008f8":
        if(isDefined(botstruct.destpositions["DEFAULT"])) {
          botstruct function_f5ce7d12b7b279d3("DEFAULT", undefined, &function_5827a66f9760a49d, botstruct);
          wait 0.5;
          botstruct.botentity function_3500675d209f72a2(botstruct.shoottarget);
        }

        break;
      case #"hash_4580af3edd21d3af":
        if(isDefined(botstruct.var_d676e6af83f5eb14) && isDefined(botstruct.destpositions["DEFAULT"])) {
          botstruct.botentity function_5a0202bcb9ee9af6(botstruct.var_d676e6af83f5eb14, botstruct.destpositions["DEFAULT"][0], botstruct.destpositions["DEFAULT"][1], &function_5827a66f9760a49d, botstruct);
        }

        break;
      default:
        botstruct.botentity function_67d00e6b876c5ee2(botstruct.destpositions["DEFAULT"][0]);
        botstruct.botentity function_9cd34cbd05a34bf2(botstruct.destpositions["DEFAULT"][1]);
        botstruct function_5827a66f9760a49d();
        break;
    }
  } else {
    botstruct.botentity function_67d00e6b876c5ee2(botstruct.destpositions["DEFAULT"][0]);
    botstruct.botentity function_9cd34cbd05a34bf2(botstruct.destpositions["DEFAULT"][1]);
    botstruct function_5827a66f9760a49d();
  }

  if(isDefined(botstruct.disableoutline) && botstruct.disableoutline) {
    return;
  }

  if(isDefined(level.ftuedata.botsinfo.outlinedelay)) {
    wait level.ftuedata.botsinfo.outlinedelay;
  }

  botstruct.botentity scripts\mp\outline::hudoutline_add_channel_internal("ftue_enemies", 10, "outlinefill_nodepth_orange");
  botstruct.botentity scripts\mp\outline::hudoutline_enable_internal(level.player, "ftue_enemies");
}

function private function_5827a66f9760a49d() {
  self.botentity setCanDamage(1);

  if(isDefined(self.shootenabled) && self.shootenabled) {
    self.botentity function_3500675d209f72a2(self.shoottarget);
  }

  if(isDefined(self.var_4165728871d6465c) && self.var_4165728871d6465c) {
    self.botentity function_d5f96927e4cf615f();
  }
}

function function_7ae554a22b6a36ae(position, targetlookat, var_abf8bccf988c7d40, callback, var_273cfbde456ab2af) {
  assert(isbot(self));

  if(isDefined(self.var_4165728871d6465c)) {
    self.var_4165728871d6465c = 0;
  }

  thread function_d25ba7eda1bf7272(position, targetlookat, var_abf8bccf988c7d40, callback, var_273cfbde456ab2af);
}

function private function_d25ba7eda1bf7272(position, targetlookat, var_abf8bccf988c7d40, callback, var_273cfbde456ab2af) {
  self notify("new_move_to_position");
  self endon("death_or_disconnect");
  self endon("new_move_to_position");
  targetposition = getclosestpointonnavmesh(position);
  function_47ba56fe3a40bd49(0);

  if(isDefined(targetlookat)) {
    function_9cd34cbd05a34bf2(targetlookat);
  } else if(!isDefined(self.var_4165728871d6465c) || !self.var_4165728871d6465c) {
    self.var_bc97abf5a86e403f = 0;
  }

  self botclearscriptgoal();
  self botsetpathingstyle("scripted");
  self botsetscriptgoal(targetposition, 20, "objective");
  result = bot_waittill_goal_or_fail();

  if(result != "script_goal_changed") {
    function_47ba56fe3a40bd49(1);
  }

  if(isDefined(var_abf8bccf988c7d40)) {
    function_9cd34cbd05a34bf2(var_abf8bccf988c7d40);
  }

  if(isDefined(callback)) {
    if(isDefined(var_273cfbde456ab2af)) {
      var_273cfbde456ab2af thread[[callback]]();
    } else {
      self thread[[callback]]();
    }
  }

  return true;
}

function function_cf3bf67de9b58336(position, speed, var_abf8bccf988c7d40, callback, var_273cfbde456ab2af) {
  assert(isbot(self));

  if(isDefined(self.var_4165728871d6465c)) {
    self.var_4165728871d6465c = 0;
  }

  thread function_a74132c4896883a(position, speed, var_abf8bccf988c7d40, callback, var_273cfbde456ab2af);
}

function private function_a74132c4896883a(position, speed, var_abf8bccf988c7d40, callback, var_273cfbde456ab2af) {
  self notify("new_move_to_position");
  self endon("death_or_disconnect");
  self endon("new_move_to_position");
  targetposition = getclosestpointonnavmesh(position);
  function_47ba56fe3a40bd49(0);
  path = [];
  path = self findpath(self.origin, targetposition);
  self botclearscriptgoal();

  for(i = 0; i < path.size; i++) {
    while(distance2d(self.origin, path[i]) > 20) {
      direction = vectortoyaw(path[i] - self.origin);
      self botsetscriptmove(direction, 0.1, speed);
      wait 0.1;
    }
  }

  self botclearscriptgoal();
  function_47ba56fe3a40bd49(1);

  if(isDefined(var_abf8bccf988c7d40)) {
    function_9cd34cbd05a34bf2(var_abf8bccf988c7d40);
  }

  if(isDefined(callback)) {
    if(isDefined(var_273cfbde456ab2af)) {
      var_273cfbde456ab2af thread[[callback]]();
    } else {
      self thread[[callback]]();
    }
  }

  return true;
}

function function_f5ce7d12b7b279d3(destinationid, speed, callback, var_273cfbde456ab2af) {
  assert(isbot(self.botentity) && isDefined(destinationid));
  thread function_a62362913caeb1cd(destinationid, speed, callback, var_273cfbde456ab2af);
}

function private function_a62362913caeb1cd(destinationid, speed, callback, var_273cfbde456ab2af) {
  movement = undefined;

  if(isDefined(speed)) {
    movement = self.botentity function_a74132c4896883a(self.destpositions[destinationid][0], speed, self.destpositions[destinationid][1]);
  } else {
    movement = self.botentity function_d25ba7eda1bf7272(self.destpositions[destinationid][0], undefined, self.destpositions[destinationid][1]);
  }

  if(!isDefined(movement) || !movement) {
    return;
  }

  self.botentity function_e333732833f72059(self.destpositions[destinationid][2]);

  if(isDefined(callback)) {
    if(isDefined(var_273cfbde456ab2af)) {
      var_273cfbde456ab2af thread[[callback]]();
      return;
    }

    self.botentity thread[[callback]]();
  }
}

function function_5a0202bcb9ee9af6(var_fe4c0c27a524b5ee, targetdestination, targetlookat, callback, var_273cfbde456ab2af) {
  assert(isbot(self) || isDefined(var_fe4c0c27a524b5ee) || isDefined(targetdestination) || isDefined(targetlookat));
  self setOrigin(var_fe4c0c27a524b5ee);
  function_47ba56fe3a40bd49(0);
  waitframe();
  self.desiredlandingspot = targetdestination;
  thread namespace_bc2665cbe6cf4e1f::parachute(0);

  while(self isonground() == 0) {
    waitframe();
  }

  wait 1;
  function_f5ce7d12b7b279d3(0, callback, var_273cfbde456ab2af);
}

function function_d5f96927e4cf615f() {
  assert(isbot(self));
  thread function_a0fb5734f6cef381();
}

function private function_a0fb5734f6cef381() {
  self notify("new_reposition_routine");
  self endon("death_or_disconnect");
  self endon("new_reposition_routine");
  self.var_4165728871d6465c = 1;

  while(self.var_4165728871d6465c) {
    wait 5 + randomfloat(5);
    middlepos = self.origin + (level.player.origin - self.origin) / 2;
    newpos = getrandomnavpoint(middlepos, 800);
    function_d25ba7eda1bf7272(newpos);
  }
}

function function_e333732833f72059(stance) {
  if(isbot(self)) {
    self botsetstance(stance);
  }
}

function function_47ba56fe3a40bd49(value) {
  if(isbot(self)) {
    self botsetflag("disable_movement", value);
  }
}

function function_9cd34cbd05a34bf2(target, time) {
  assert(isbot(self));
  thread function_32b581a67dc2fb4e(target, time);
}

function private function_32b581a67dc2fb4e(target, time) {
  self notify("new_look_at_target");
  self endon("death_or_disconnect");
  self endon("new_look_at_target");

  if(!isDefined(time)) {
    time = 0.2;
  }

  self.var_bc97abf5a86e403f = 1;

  while(self.var_bc97abf5a86e403f) {
    if(!isDefined(target)) {
      break;
    }

    if(isstring(target)) {
      switch (target) {
        case #"hash_1119adae802dcc40":
          if(!isalive(level.player)) {
            return;
          }

          var_ee802a36a349579d = level.player getEye() + (randomfloat(0), randomfloat(0), randomfloat(0));
          self botlookatpoint(var_ee802a36a349579d, time, "script_forced");
          break;
        case #"hash_46f2e5a2ee89ad68":
          if(!isalive(level.ftuedata.allybots[#"AllyBot_1"].botentity)) {
            return;
          }

          var_ee802a36a349579d = level.ftuedata.allybots[#"AllyBot_1"].botentity getEye() + (randomfloat(0), randomfloat(0), randomfloat(0));
          self botlookatpoint(var_ee802a36a349579d, time, "script_forced");
          break;
      }
    } else if(isvector(target)) {
      self botlookatpoint(target, time, "script_forced");
    } else if(isent(target)) {
      if(!isalive(target)) {
        return;
      }

      self botlookatpoint(target.origin, time, "script_forced");
    }

    wait time;
  }
}

function function_3500675d209f72a2(target) {
  assert(isbot(self));
  thread function_a3921eb2329446be(target);
}

function private function_a3921eb2329446be(target) {
  self notify("new_shoot_routine");
  self endon("death_or_disconnect");
  self endon("new_shoot_routine");
  thread function_32b581a67dc2fb4e(target);
  wait 1;
  self.var_77198b6da7d57a45 = 1;

  while(self.var_77198b6da7d57a45) {
    if(isstring(target)) {
      switch (target) {
        case #"hash_1119adae802dcc40":
          if(!isalive(level.player)) {
            function_3a31862196d98146("attack");
            return 1;
          }

          if(level.player sightconetrace(self getEye(), self) < 0) {
            wait 1;
            continue;
          }

          break;
        case #"hash_46f2e5a2ee89ad68":
          if(!isalive(level.ftuedata.allybots[#"AllyBot_1"].botentity)) {
            function_3a31862196d98146("attack");
            return 1;
          }

          if(level.ftuedata.allybots[#"AllyBot_1"].botentity sightconetrace(self getEye(), self) < 0) {
            wait 1;
            continue;
          }

          break;
      }
    } else if(isent(target)) {
      if(!isalive(target)) {
        function_3a31862196d98146("attack");
        return 1;
      }

      if(target sightconetrace(self getEye(), self) < 0) {
        wait 1;
        continue;
      }
    } else {
      return;
    }

    shoottime = 0.5 + randomfloat(2);
    thread function_f37f04aa427d8f84("attack", shoottime);
    wait shoottime + 1 + randomfloat(2);
  }
}

function function_a7fc1ce7540e5915(enemies) {
  assert(isbot(self) && isDefined(enemies));
  thread function_e6311310bbaaa193(enemies);
}

function private function_e6311310bbaaa193(enemies) {
  self notify("new_combat_routine");
  self endon("death_or_disconnect");
  self endon("new_combat_routine");
  self.var_95ee53cadeb45990 = 1;

  while(self.var_95ee53cadeb45990) {
    targetenemy = undefined;

    foreach(enemy in enemies) {
      enemybot = level.ftuedata.enemybots[getxhash(enemy)].botentity;

      if(!isDefined(enemybot) || !isalive(enemybot)) {
        continue;
      }

      targetenemy = enemybot;
    }

    if(!isDefined(targetenemy)) {
      return 1;
    }

    function_3500675d209f72a2(targetenemy);
    wait 3 + randomfloat(3);
  }
}

function function_d780d856d7d110a4(targetoperator, approachspeed, executionid, callback) {
  assert(isbot(self) || !isDefined(targetoperator));
  thread function_dc9666b56df67864(targetoperator, approachspeed, executionid, callback);
}

function private function_dc9666b56df67864(targetoperator, approachspeed, executionid, callback) {
  self endon("death_or_disconnect");

  if(isDefined(executionid)) {
    scripts\cp_mp\execution::_giveexecution(executionid);
  }

  self.var_bc97abf5a86e403f = 0;
  var_b8bc5657b0d4dcf9 = vectorNormalize(anglesToForward(targetoperator getplayerangles()));
  var_e9b6877d9370d55c = targetoperator.origin - var_b8bc5657b0d4dcf9 * 30;

  if(distance2d(self.origin, var_e9b6877d9370d55c) > 20) {
    if(!isDefined(approachspeed)) {
      approachspeed = 1;
    }

    function_a74132c4896883a(var_e9b6877d9370d55c, approachspeed);
  }

  self botlookatpoint(targetoperator getEye(), 1);
  self enableexecutionattack();

  while(!self isinexecutionattack()) {
    function_f37f04aa427d8f84("melee", 3);
    wait 3;
  }

  while(self isinexecutionattack()) {
    waitframe();
  }

  if(isDefined(callback)) {
    self thread[[callback]]();
  }
}

function function_deafdba8d60e4c3b(var_71cb2f1fe7ef9720, attackposition, callback) {
  assert(isbot(self) || !isDefined(var_71cb2f1fe7ef9720) || !isDefined(attackposition));
  thread function_c0c83d8b47029a95(var_71cb2f1fe7ef9720, attackposition, callback);
}

function private function_c0c83d8b47029a95(var_71cb2f1fe7ef9720, attackposition, callback) {
  self endon("death_or_disconnect");
  previousequipment = self getcurrentweapon();
  self takeallweapons();
  missilelauncher = scripts\cp_mp\weapon::buildweapon("iw9_la_rpapa7", undefined, undefined, undefined, -1, undefined, undefined, undefined, 0);
  self giveweapon(missilelauncher);
  self givemaxammo(missilelauncher);
  self switchtoweapon(missilelauncher);

  if(distance2d(self.origin, attackposition) > 20) {
    function_d25ba7eda1bf7272(attackposition);
  }

  function_9cd34cbd05a34bf2(var_71cb2f1fe7ef9720, 4);
  wait 0.5;
  function_f37f04aa427d8f84("ads", 4);
  wait 0.5;
  var_71cb2f1fe7ef9720 namespace_9e27347da4069f42::function_4d84a1c381ece6c0(callback);
  function_f37f04aa427d8f84("attack", 2);
  wait 1.5;

  if(isalive(var_71cb2f1fe7ef9720) > 0) {
    var_71cb2f1fe7ef9720 namespace_9e27347da4069f42::function_b9a4d29f4bc73806(callback);
  }

  self takeallweapons();
  self giveweapon(previousequipment);
  self givemaxammo(previousequipment);
  self switchtoweapon(previousequipment);
}

function function_f37f04aa427d8f84(var_baa0b8d939a551b, time) {
  assert(isbot(self));
  self botpressbutton(var_baa0b8d939a551b, time);
}

function function_3a31862196d98146(var_baa0b8d939a551b) {
  assert(isbot(self));
  self botclearbutton(var_baa0b8d939a551b);
}
/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3115.gsc
***********************************************/

func_98E5(var_0) {
  if(isDefined(self.spawner) && self.spawner func_10863()) {
    self.entered_playspace = 1;
  }

  if(isDefined(level.in_room_check_func)) {
    if(self[[level.in_room_check_func]]()) {
      self.entered_playspace = 1;
    }
  }

  return anim.success;
}

func_10863() {
  if(isDefined(self.script_parameters) && (self.script_parameters == "no_boards" || self.script_parameters == "ground_spawn_no_boards")) {
    return 1;
  }

  return 0;
}

func_102D4(var_0) {
  var_1 = gettime();

  if(isDefined(self.var_102D5)) {
    if(var_1 >= self.var_102D5) {
      self.var_102D5 = undefined;
      return anim.failure;
    }

    return anim.running;
  }

  if(!isDefined(self.curmeleetarget)) {
    self.var_102D5 = var_1 + 800;
    return anim.running;
  }

  var_2 = distance2d(self.origin, self.curmeleetarget.origin);

  if(var_2 < 250) {
    return anim.failure;
  }

  if(var_2 > 800) {
    self.var_102D5 = var_1 + 500;
    return anim.running;
  }

  var_2 = var_2 - 250;
  var_3 = var_2 / 550;
  self.var_102D5 = var_1 + 200 + int(var_3 * 300);
  return anim.running;
}

func_10004(var_0) {
  if(isDefined(level.fnzombieshouldenterplayspace)) {
    if(!self[[level.fnzombieshouldenterplayspace]]()) {
      return anim.failure;
    } else if(self.hastraversed) {
      return anim.failure;
    }
  }

  return anim.success;
}

func_5827() {
  self endon("AbortEnterPlayspace");
  self.var_2A90 = 1;
  self[[level.fnzombieenterplayspace]]();
  self.var_2A90 = 0;
}

func_6628(var_0) {
  self.bneedtoenterplayspace = 1;
}

func_6629(var_0) {
  self notify("AbortEnterPlayspace");
}

func_6627(var_0) {
  if(scripts\engine\utility::is_true(self.entered_playspace)) {
    return anim.success;
  }

  return anim.running;
}

func_3E48(var_0) {
  if(!scripts\engine\utility::is_true(self.scripted_mode)) {
    return anim.failure;
  }

  return anim.running;
}

func_3E29(var_0) {
  if(self.ignoreall) {
    scripts\asm\asm_bb::bb_clearmeleerequest();
    return anim.failure;
  }

  scripts\asm\asm_bb::bb_clearmeleerequest();

  if(!isDefined(self.curmeleetarget)) {
    return anim.failure;
  }

  if(isDefined(self.curmeleetarget.ignoreme) && self.curmeleetarget.ignoreme == 1) {
    return anim.failure;
  }

  if(isDefined(self.curmeleetarget.killing_time)) {
    return anim.failure;
  }

  if(self.aistate == "melee" || scripts\anim\notetracks_mp::isstatelocked()) {
    return anim.failure;
  }

  if(!scripts\mp\agents\zombie\zombie_util::func_8B76()) {
    return anim.failure;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_138E7()) {
    return anim.failure;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_54BF()) {
    return anim.failure;
  }

  var_1 = scripts\engine\utility::is_true(self.var_B104) && isDefined(self.var_B100) && gettime() - self.var_B100 <= self.var_B0FE;

  if(!ispointonnavmesh(self.curmeleetarget.origin, self) && !scripts\asm\asm_bb::bb_moverequested()) {
    if(!scripts\mp\agents\zombie\zombie_util::func_DD7C("offmesh")) {
      return anim.failure;
    }
  } else if(scripts\mp\agents\zombie\zombie_util::func_54BE() || var_1) {
    if(!scripts\mp\agents\zombie\zombie_util::func_DD7C("base")) {
      return anim.failure;
    }
  } else if(!scripts\mp\agents\zombie\zombie_util::func_DD7C("normal"))
    return anim.failure;

  if(isDefined(self.var_B603)) {
    var_2 = gettime() - self.var_A9B8;

    if(var_2 < self.var_B603 * 1000) {
      return anim.failure;
    }
  }

  if(!isDefined(self.var_A9B9) || distancesquared(self.var_A9B9, self.origin) > 256) {
    if(!isDefined(self.asm.cur_move_mode)) {
      var_3 = self.movemode;
    } else {
      var_3 = self.asm.cur_move_mode;
    }

    self.var_B629 = var_3;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  return anim.failure;
}

func_3E4F(var_0) {
  if(!scripts\engine\utility::is_true(self.is_suicide_bomber)) {
    return anim.failure;
  }

  scripts\asm\asm_bb::bb_clearmeleerequest();

  if(self.ignoreall) {
    return anim.failure;
  }

  if(!isDefined(self.curmeleetarget)) {
    return anim.failure;
  }

  if(isDefined(self.curmeleetarget.ignoreme) && self.curmeleetarget.ignoreme == 1) {
    return anim.failure;
  }

  if(self.aistate == "melee" || scripts\anim\notetracks_mp::isstatelocked()) {
    return anim.failure;
  }

  if(!scripts\mp\agents\zombie\zombie_util::func_8B76()) {
    return anim.failure;
  }

  if(!func_13D9D(self.curmeleetarget)) {
    return anim.failure;
  }

  bb_requeststance(self.curmeleetarget);
  return anim.failure;
}

bb_requeststance(var_0) {
  self._blackboard.var_3134 = 1;
}

func_13D9D(var_0) {
  return distancesquared(self.origin, var_0.origin) <= 5625;
}

chaseenemy(var_0) {
  scripts\asm\asm_bb::bb_setisincombat(1);

  if(self.ignoreall) {
    self.curmeleetarget = undefined;
    return anim.failure;
  }

  if(isDefined(self.hastraversed) && self.hastraversed) {
    self.noturnanims = 0;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(isDefined(self.enemy.is_fast_traveling) || isDefined(self.enemy.is_off_grid)) {
    self.curmeleetarget = undefined;
    return anim.failure;
  }

  if(isDefined(self.enemy.killing_time)) {
    self.curmeleetarget = undefined;
    return anim.failure;
  }

  var_1 = undefined;

  if(isDefined(self.var_571B) && scripts\mp\agents\zombie\zombie_util::func_100AB()) {
    var_1 = self.var_571B;
  } else if(isDefined(self.attackent)) {
    var_1 = self.attackent;
  } else if(isDefined(self.enemy) && !scripts\mp\agents\zombie\zombie_util::shouldignoreent(self.enemy)) {
    var_1 = self.enemy;
  }

  if(!isDefined(var_1)) {
    if(isDefined(self.curmeleetarget)) {
      self.var_2AB8 = 1;
    }

    self.curmeleetarget = undefined;
    return anim.failure;
  }

  var_3 = self.var_252B + self.radius * 2;
  var_4 = var_3 * var_3;
  var_5 = self.var_252B;
  var_6 = var_5 * var_5;
  self.curmeleetarget = var_1;
  var_7 = scripts\mp\agents\zombie\zombie_util::func_7FAA(var_1);
  var_8 = var_7.var_656D;
  var_9 = distancesquared(var_7.origin, self.origin);
  var_10 = distancesquared(var_8, self.origin);
  var_11 = self.var_2AB8;

  if(var_10 < squared(self.radius) && distancesquared(var_8, var_7.origin) > squared(self.radius)) {
    var_11 = 1;
    self notify("attack_anim", "end");
  }

  if(!var_11 && var_10 > var_4 && var_9 > var_6) {
    var_11 = 1;
  }

  if(var_7.var_1312B) {
    if(!var_11 && var_10 <= var_4 && var_9 > squared(self.defaultgoalradius)) {
      var_11 = 1;
    }

    self scragentsetgoalradius(self.defaultgoalradius);
  } else if(!scripts\mp\agents\zombie\zombie_util::func_8C39(var_1, self.var_B640)) {
    self scragentsetgoalradius(self.defaultgoalradius);
    var_11 = 1;
  } else {
    self scragentsetgoalradius(var_3);

    if(var_10 <= var_4) {
      var_7.origin = self.origin;
      var_11 = 1;
    }
  }

  if(var_11) {
    var_2 = getclosestpointonnavmesh(var_7.origin);

    if(distancesquared(var_2, var_7.origin) > 10000) {
      return anim.failure;
    }

    self scragentsetgoalpos(var_2);
  }

  return anim.success;
}

seekenemy(var_0) {
  if(isDefined(self.dontseekenemies)) {
    return anim.failure;
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.ignoreme || isDefined(var_3.owner) && var_3.owner.ignoreme) {
      continue;
    }
    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_5 = undefined;

  if(var_1.size > 0) {
    var_5 = sortbydistance(var_1, self.origin);
  }

  if(isDefined(var_5) && var_5.size > 0) {
    var_6 = 300;
    var_7 = distancesquared(var_5[0].origin, self.origin);

    if(var_7 < var_6 * var_6) {
      var_6 = 16;
    }

    var_8 = var_6 * var_6;

    if(self.var_2AB8 || distancesquared(self ghosthide(), var_5[0].origin) > var_8) {
      var_9 = var_5[0].origin;
      var_10 = getclosestpointonnavmesh(var_9, self);

      if(distancesquared(var_10, var_5[0].origin) > var_8) {
        return anim.failure;
      }

      self scragentsetgoalpos(var_10);
      self.var_2AB8 = 0;
    }

    scripts\asm\asm_bb::bb_setisincombat(1);
    return anim.success;
  }

  return anim.failure;
}

notargetfound(var_0) {
  scripts\asm\asm_bb::bb_setisincombat(0);

  if(isDefined(level.var_71A7)) {
    var_1 = 200;

    if(!isDefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, self.origin) < var_1 * var_1) {
      var_2 = self[[level.var_71A7]]();

      if(isDefined(var_2)) {
        self scragentsetgoalpos(var_2);
      } else {
        self clearpath();
      }
    }
  } else
    self clearpath();

  return anim.success;
}
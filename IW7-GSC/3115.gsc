/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3115.gsc
************************/

func_98E5(param_00) {
  if(isDefined(self.spawner) && self.spawner func_10863()) {
    self.entered_playspace = 1;
  }

  if(isDefined(level.in_room_check_func)) {
    if(self[[level.in_room_check_func]]()) {
      self.entered_playspace = 1;
    }
  }

  return level.success;
}

func_10863() {
  if(isDefined(self.script_parameters) && self.script_parameters == "no_boards" || self.script_parameters == "ground_spawn_no_boards") {
    return 1;
  }

  return 0;
}

func_102D4(param_00) {
  var_01 = gettime();
  if(isDefined(self.var_102D5)) {
    if(var_01 >= self.var_102D5) {
      self.var_102D5 = undefined;
      return level.failure;
    }

    return level.running;
  }

  if(!isDefined(self.curmeleetarget)) {
    self.var_102D5 = var_01 + 800;
    return level.running;
  }

  var_02 = distance2d(self.origin, self.curmeleetarget.origin);
  if(var_02 < 250) {
    return level.failure;
  }

  if(var_02 > 800) {
    self.var_102D5 = var_01 + 500;
    return level.running;
  }

  var_02 = var_02 - 250;
  var_03 = var_02 / 550;
  self.var_102D5 = var_01 + 200 + int(var_03 * 300);
  return level.running;
}

func_10004(param_00) {
  if(isDefined(level.fnzombieshouldenterplayspace)) {
    if(!self[[level.fnzombieshouldenterplayspace]]()) {
      return level.failure;
    } else if(self.hastraversed) {
      return level.failure;
    }
  }

  return level.success;
}

func_5827() {
  self endon("AbortEnterPlayspace");
  self.var_2A90 = 1;
  self[[level.fnzombieenterplayspace]]();
  self.var_2A90 = 0;
}

func_6628(param_00) {
  self.bneedtoenterplayspace = 1;
}

func_6629(param_00) {
  self notify("AbortEnterPlayspace");
}

func_6627(param_00) {
  if(scripts\engine\utility::istrue(self.entered_playspace)) {
    return level.success;
  }

  return level.running;
}

func_3E48(param_00) {
  if(!scripts\engine\utility::istrue(self.scripted_mode)) {
    return level.failure;
  }

  return level.running;
}

func_3E29(param_00) {
  if(self.precacheleaderboards) {
    scripts\asm\asm_bb::bb_clearmeleerequest();
    return level.failure;
  }

  scripts\asm\asm_bb::bb_clearmeleerequest();
  if(!isDefined(self.curmeleetarget)) {
    return level.failure;
  }

  if(isDefined(self.curmeleetarget.ignoreme) && self.curmeleetarget.ignoreme == 1) {
    return level.failure;
  }

  if(isDefined(self.curmeleetarget.killing_time)) {
    return level.failure;
  }

  if(self.aistate == "melee" || scripts\mp\agents\_scriptedagents::isstatelocked()) {
    return level.failure;
  }

  if(!scripts\mp\agents\zombie\zombie_util::func_8B76()) {
    return level.failure;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_138E7()) {
    return level.failure;
  }

  if(scripts\mp\agents\zombie\zombie_util::func_54BF()) {
    return level.failure;
  }

  var_01 = scripts\engine\utility::istrue(self.var_B104) && isDefined(self.var_B100) && gettime() - self.var_B100 <= self.var_B0FE;
  if(!ispointonnavmesh(self.curmeleetarget.origin, self) && !scripts\asm\asm_bb::bb_moverequested()) {
    if(!scripts\mp\agents\zombie\zombie_util::func_DD7C("offmesh")) {
      return level.failure;
    }
  } else if(scripts\mp\agents\zombie\zombie_util::func_54BE() || var_01) {
    if(!scripts\mp\agents\zombie\zombie_util::func_DD7C("base")) {
      return level.failure;
    }
  } else if(!scripts\mp\agents\zombie\zombie_util::func_DD7C("normal")) {
    return level.failure;
  }

  if(isDefined(self.var_B603)) {
    var_02 = gettime() - self.var_A9B8;
    if(var_02 < self.var_B603 * 1000) {
      return level.failure;
    }
  }

  if(!isDefined(self.var_A9B9) || distancesquared(self.var_A9B9, self.origin) > 256) {
    if(!isDefined(self.asm.cur_move_mode)) {
      var_03 = self.synctransients;
    } else {
      var_03 = self.asm.cur_move_mode;
    }

    self.var_B629 = var_03;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.curmeleetarget);
  return level.failure;
}

func_3E4F(param_00) {
  if(!scripts\engine\utility::istrue(self.is_suicide_bomber)) {
    return level.failure;
  }

  scripts\asm\asm_bb::bb_clearmeleerequest();
  if(self.precacheleaderboards) {
    return level.failure;
  }

  if(!isDefined(self.curmeleetarget)) {
    return level.failure;
  }

  if(isDefined(self.curmeleetarget.ignoreme) && self.curmeleetarget.ignoreme == 1) {
    return level.failure;
  }

  if(self.aistate == "melee" || scripts\mp\agents\_scriptedagents::isstatelocked()) {
    return level.failure;
  }

  if(!scripts\mp\agents\zombie\zombie_util::func_8B76()) {
    return level.failure;
  }

  if(!func_13D9D(self.curmeleetarget)) {
    return level.failure;
  }

  bb_requeststance(self.curmeleetarget);
  return level.failure;
}

bb_requeststance(param_00) {
  self.var_1198.var_3134 = 1;
}

func_13D9D(param_00) {
  return distancesquared(self.origin, param_00.origin) <= 5625;
}

chaseenemy(param_00) {
  scripts\asm\asm_bb::bb_setisincombat(1);
  if(self.precacheleaderboards) {
    self.curmeleetarget = undefined;
    return level.failure;
  }

  if(isDefined(self.hastraversed) && self.hastraversed) {
    self.noturnanims = 0;
  }

  if(!isDefined(self.isnodeoccupied)) {
    return level.failure;
  }

  if(isDefined(self.isnodeoccupied.is_fast_traveling) || isDefined(self.isnodeoccupied.is_off_grid)) {
    self.curmeleetarget = undefined;
    return level.failure;
  }

  if(isDefined(self.isnodeoccupied.killing_time)) {
    self.curmeleetarget = undefined;
    return level.failure;
  }

  var_01 = undefined;
  if(isDefined(self.var_571B) && scripts\mp\agents\zombie\zombie_util::func_100AB()) {
    var_01 = self.var_571B;
  } else if(isDefined(self.attackent)) {
    var_01 = self.attackent;
  } else if(isDefined(self.isnodeoccupied) && !scripts\mp\agents\zombie\zombie_util::shouldignoreent(self.isnodeoccupied)) {
    var_01 = self.isnodeoccupied;
  }

  if(!isDefined(var_01)) {
    if(isDefined(self.curmeleetarget)) {
      self.var_2AB8 = 1;
    }

    self.curmeleetarget = undefined;
    return level.failure;
  }

  var_03 = self.var_252B + self.fgetarg * 2;
  var_04 = var_03 * var_03;
  var_05 = self.var_252B;
  var_06 = var_05 * var_05;
  self.curmeleetarget = var_01;
  var_07 = scripts\mp\agents\zombie\zombie_util::func_7FAA(var_01);
  var_08 = var_07.var_656D;
  var_09 = distancesquared(var_07.origin, self.origin);
  var_0A = distancesquared(var_08, self.origin);
  var_0B = self.var_2AB8;
  if(var_0A < squared(self.fgetarg) && distancesquared(var_08, var_07.origin) > squared(self.fgetarg)) {
    var_0B = 1;
    self notify("attack_anim", "end");
  }

  if(!var_0B && var_0A > var_04 && var_09 > var_06) {
    var_0B = 1;
  }

  if(var_07.var_1312B) {
    if(!var_0B && var_0A <= var_04 && var_09 > squared(self.defaultgoalradius)) {
      var_0B = 1;
    }

    self ghostskulls_total_waves(self.defaultgoalradius);
  } else if(!scripts\mp\agents\zombie\zombie_util::func_8C39(var_01, self.var_B640)) {
    self ghostskulls_total_waves(self.defaultgoalradius);
    var_0B = 1;
  } else {
    self ghostskulls_total_waves(var_03);
    if(var_0A <= var_04) {
      var_07.origin = self.origin;
      var_0B = 1;
    }
  }

  if(var_0B) {
    var_02 = getclosestpointonnavmesh(var_07.origin);
    if(distancesquared(var_02, var_07.origin) > 10000) {
      return level.failure;
    }

    self ghostskulls_complete_status(var_02);
  }

  return level.success;
}

seekenemy(param_00) {
  if(isDefined(self.dontseekenemies)) {
    return level.failure;
  }

  var_01 = [];
  foreach(var_03 in level.players) {
    if(var_03.ignoreme || isDefined(var_03.triggerportableradarping) && var_03.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_03)) {
      continue;
    }

    if(!isalive(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  var_05 = undefined;
  if(var_01.size > 0) {
    var_05 = sortbydistance(var_01, self.origin);
  }

  if(isDefined(var_05) && var_05.size > 0) {
    var_06 = 300;
    var_07 = distancesquared(var_05[0].origin, self.origin);
    if(var_07 < var_06 * var_06) {
      var_06 = 16;
    }

    var_08 = var_06 * var_06;
    if(self.var_2AB8 || distancesquared(self ghosthide(), var_05[0].origin) > var_08) {
      var_09 = var_05[0].origin;
      var_0A = getclosestpointonnavmesh(var_09, self);
      if(distancesquared(var_0A, var_05[0].origin) > var_08) {
        return level.failure;
      }

      self ghostskulls_complete_status(var_0A);
      self.var_2AB8 = 0;
    }

    scripts\asm\asm_bb::bb_setisincombat(1);
    return level.success;
  }

  return level.failure;
}

notargetfound(param_00) {
  scripts\asm\asm_bb::bb_setisincombat(0);
  if(isDefined(level.var_71A7)) {
    var_01 = 200;
    if(!isDefined(self.vehicle_getspawnerarray) || distancesquared(self.vehicle_getspawnerarray, self.origin) < var_01 * var_01) {
      var_02 = self[[level.var_71A7]]();
      if(isDefined(var_02)) {
        self ghostskulls_complete_status(var_02);
      } else {
        self clearpath();
      }
    }
  } else {
    self clearpath();
  }

  return level.success;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\dog\combat.gsc
***********************************************/

dog_init(var_0) {
  self.fixednode = 0;
  self.combatmode = "no_cover";
  self.subclass = "dog";
  self._blackboard.movetype = "walk";
  self.meleechargedist = 384;
  self.meleechargedistvsplayer = 384;
  self.meleechargedistreloadmultiplier = 1;
  self.meleerangesq = 4096;
  self.unarmedmeleedamageoverride = 400;
  self.meleemaxzdiff = 72;
  self.meleetryhard = 1;
  self.fnismeleevalid = ::ismeleevalid;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  self.fnsetstealthstate = ::setstealthstate;
  self.fnisinstealthidle = scripts\aitypes\stealth::isidle;
  self.fnisinstealthinvestigate = scripts\aitypes\stealth::isinvestigating;
  self.fnisinstealthhunt = scripts\aitypes\stealth::ishunting;
  self.fnisinstealthcombat = scripts\aitypes\stealth::iscombating;
  self.fnisinstealthidlescriptedanim = scripts\aitypes\stealth::isidlescriptedanim;
  self.fnstealthupdatevisionforlighting = scripts\aitypes\stealth::updatevisionforlighting;
  self.fnstealthgotonode = scripts\sp\spawner::go_to_node;
  self.smellradiussq = 589824;
  self.smellouterradiussq = 685584;
  self.barkradiussq = 409600;
  self.barkouterradiussq = 490000;
  self.combatradiussq = 262144;
  return anim.success;
}

canmovefrompointtopoint(var_0, var_1) {
  return self maymovefrompointtopoint(var_0, var_1, 0, 1);
}

updateeveryframe(var_0) {
  if(!isalive(self))
    return anim.failure;

  var_1 = scripts\engine\utility::is_equal(self.demeanoroverride, "sprint") || isDefined(self.enemy);

  if(var_1)
    self._blackboard.movetype = "run";
  else
    self._blackboard.movetype = "walk";

  return anim.success;
}

updateeveryframe_stealth(var_0) {
  var_1 = level.player;

  switch (self.stealth.bsmstate) {
    case 0:
      var_2 = distancesquared(var_1.origin, self.origin);

      if(var_2 < self.smellradiussq)
        setstealthstate("investigate");

      break;
    case 1:
      var_2 = distancesquared(var_1.origin, self.origin);

      if(var_2 > self.smellouterradiussq) {
        if(!isDefined(self.stealth.threat_sight_lost) || self.stealth.threat_sight_lost)
          setstealthstate("idle");
      } else if(var_2 < self.combatradiussq && self cansee(var_1))
        setstealthstate("combat");

      break;
  }

  return anim.success;
}

enableeventlisteners(var_0) {
  var_1 = ["bulletwhizby", "explode", "gunshot", "projectile_impact", "silenced_shot"];

  if(var_0) {
    foreach(var_3 in var_1)
    self addaieventlistener(var_3);
  } else {
    foreach(var_3 in var_1)
    self removeaieventlistener(var_3);
  }
}

dog_idle_init() {
  enableeventlisteners(1);
  self clearenemy();
  scripts\stealth\enemy::set_sight_state("hidden");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1.stealth)) {
      continue;
    }
    if(!isDefined(var_1.stealth.spotted_list)) {
      continue;
    }
    var_1.stealth.spotted_list[self.unique_id] = undefined;
  }

  scripts\stealth\event::event_escalation_clear();
  thread scripts\stealth\enemy::set_alert_level("reset");

  if(isDefined(self.stealth.funcs["hidden"]))
    scripts\stealth\callbacks::stealth_call_thread("hidden");

  if(isDefined(self.target)) {
    self.goalradius = 32;

    if(isDefined(self.fnstealthgotonode))
      self thread[[self.fnstealthgotonode]](undefined, undefined, undefined);
  }
}

dog_idle_init_task(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.stealth.bidlecurious = 0;
}

dog_idle(var_0) {
  var_1 = self.bt.instancedata[var_0];
  var_2 = level.player;
  var_3 = self getthreatsight(var_2);
  var_4 = 0.25;

  if(self.stealth.bidlecurious) {
    var_5 = 2000;

    if(gettime() > var_1.curiousstarttime + var_5) {
      if(var_3 < var_4 * 0.9) {
        self.stealth.bidlecurious = 0;
        self.stealth.idlecurioustarget = undefined;

        if(!isDefined(self.pathgoalpos) && isDefined(var_1.idlenode))
          self._blackboard.idlenode = var_1.idlenode;
      }
    }
  } else if(var_3 >= var_4) {
    self.stealth.bidlecurious = 1;
    self.stealth.idlecurioustarget = var_2;
    var_1.curiousstarttime = gettime();
    var_1.idlenode = self._blackboard.idlenode;
    self._blackboard.idlenode = undefined;
  }

  self._blackboard.movetype = "walk";
  return anim.running;
}

dog_idle_terminate_task(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.stealth.bidlecurious = undefined;
  self.stealth.idlecurioustarget = undefined;
}

dog_investigate_init_task(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.stealth.bbark = 0;
  self.stealth.bgrowl = 0;
}

dog_investigate(var_0) {
  var_1 = level.player;
  var_2 = distancesquared(self.origin, var_1.origin);

  if(var_2 < self.barkradiussq) {
    self.stealth.bbark = 1;
    self.stealth.bgrowl = 0;
  } else if(var_2 > self.barkouterradiussq) {
    self.stealth.bbark = 0;
    self.stealth.bgrowl = 1;
  }

  if(self.stealth.bbark || self.stealth.bgrowl)
    self._blackboard.target = var_1;
  else
    self._blackboard.target = undefined;

  self._blackboard.movetype = "run";
  return anim.running;
}

dog_investigate_terminate_task(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.stealth.bbark = undefined;
  self.stealth.bgrowl = undefined;
  self._blackboard.target = undefined;
}

ismeleevalid(var_0, var_1) {
  if(!scripts\aitypes\melee::ismeleevalid_common(var_0, var_1))
    return anim.failure;

  return anim.success;
}

dog_followenemy_init(var_0) {
  var_1 = spawnStruct();
  var_1.nextupdatetime = 0;
  self.bt.instancedata[var_0] = var_1;
}

dog_followenemy(var_0) {
  var_1 = self.enemy;
  var_2 = self.bt.instancedata[var_0];
  var_3 = gettime();

  if(var_3 >= var_2.nextupdatetime) {
    var_2.nextupdatetime = var_3 + 500;
    var_4 = 192;
    var_5 = var_1.origin - self.origin;
    var_6 = length(var_5);

    if(var_6 > var_4 && !istrue(self.dontmelee)) {
      var_7 = var_1.origin - var_5 * var_4 / var_6;
      var_8 = getclosestpointonnavmesh(var_7, self);
      self setbtgoalpos(1, var_8);
      self.btgoalradius = 64;
    }
  }

  if(isDefined(self.stealth)) {
    if(!isDefined(self.pathgoalpos))
      self.stealth.bbark = 1;
    else
      self.stealth.bbark = undefined;
  }

  return anim.running;
}

dog_followenemy_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;

  if(!isDefined(self.enemy))
    self clearbtgoal(1);
}

dog_combat_init() {
  enableeventlisteners(0);
  scripts\stealth\event::event_escalation_clear();
  scripts\stealth\enemy::set_sight_state("spotted");
}

enterstealthstate(var_0) {
  exitstealthstate(self.stealth.bsmstate);
  self.stealth.bsmstate = var_0;

  switch (var_0) {
    case 0:
      dog_idle_init();
      break;
    case 1:
      break;
    case 3:
      dog_combat_init();
      break;
  }
}

exitstealthstate(var_0) {
  switch (var_0) {
    case 0:
      break;
    case 1:
      break;
  }
}

setstealthstate(var_0, var_1) {
  switch (var_0) {
    case "idle":
      enterstealthstate(0);
      self notify("stealth_idle");
      break;
    case "investigate":
      enterstealthstate(1);
      self notify("stealth_investigate");
      break;
    case "combat":
      enterstealthstate(3);
      self notify("stealth_combat");
      break;
  }
}
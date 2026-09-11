/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gondola.gsc
***********************************************/

function ref_1396d() {
  level endon("game_ended");
  wait 1;
  level.can_combat_action_be_interrupted = getEntArray("gondola_start", "script_noteworthy");

  foreach(var_1 in level.can_combat_action_be_interrupted) {
    ref_1396e(var_1);
    thread select_patrol_three_spawners();
    thread ref_140fe();
  }
}

function unuseweapon() {
  level endon("game_ended");
  wait 1;
  level.can_combat_action_be_interrupted = getEntArray("gondola_start_v2", "script_noteworthy");

  foreach(var_1 in level.can_combat_action_be_interrupted) {
    var_1 clearwristwatchtime(1);
    friendly_convoy_intro_decho_idle_animation(var_1);
    thread select_patrol_six_spawners();
    thread ref_140fe();
  }
}

function ref_1396e() {
  var_0 = self;
  var_1 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);

    if(isDefined(var_3.classname) && var_3.classname == "script_brushmodel" && !isDefined(var_3.targetname)) {
      var_0.collision = var_3;
      var_3.targetname = "gondola_clipbrush";
      var_3.unresolved_collision_func = &select_players_not_in_killzone_only;
    }

    if(isDefined(var_3.targetname) && var_3.targetname == "wheeler") {
      var_0.ref_145aa = var_3;
    }
  }

  var_5 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_6 = getEnt(var_5.target, "targetname");
  var_7 = getEnt(var_6.target, "targetname");
  var_8 = scripts\engine\utility::getStruct(var_7.target, "targetname");
  var_9 = getEnt(var_8.target, "targetname");
  var_0.ref_1376e = var_0.origin;
  var_0.movelatejoinerstospectators = var_5.origin;
  var_0.ref_13770 = var_7.origin;
  var_0.moveleadmarkers = var_8.origin;
  var_0.ref_1376f = var_0.angles[1];
  var_0.ref_12384 = var_6;
  var_0.ref_12385 = var_9;

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "up") {
    var_0.juggheli_spawner_jammer5_1 = vectortopitch(var_0.origin - var_0.movelatejoinerstospectators);
  } else if(isDefined(var_0.script_parameters) && var_0.script_parameters == "down") {
    var_0.juggheli_spawner_jammer5_1 = vectortopitch(var_0.movelatejoinerstospectators - var_0.origin);
  }

  if(!isDefined(var_0.script_speed)) {
    var_0.script_speed = 15;
    return;
  }
}

function friendly_convoy_intro_decho_idle_animation() {
  var_0 = self;
  var_1 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);

    if(isDefined(var_3.classname) && var_3.classname == "script_brushmodel" && !isDefined(var_3.targetname)) {
      var_0.collision = var_3;
      var_3.targetname = "gondola_clipbrush";
      var_3.unresolved_collision_func = &select_players_not_in_killzone_only;
    }

    if(isDefined(var_3.targetname) && var_3.targetname == "wheeler") {
      var_0.ref_145aa = var_3;
    }
  }

  var_5 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0.ref_1376f = var_0.angles[1];

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "up") {
    var_0.juggheli_spawner_jammer5_1 = 25;
  } else if(isDefined(var_0.script_parameters) && var_0.script_parameters == "down") {
    var_0.juggheli_spawner_jammer5_1 = 25;
  }

  if(!isDefined(var_0.script_speed)) {
    var_0.script_speed = 1;
  }

  var_6 = getdvarfloat("scr_gondola_speed_multiplier", 1.25);
  var_0.script_speed = 1 * var_6;
}

function select_patrol_six_spawners() {
  level endon("game_ended");
  self endon("death");
  waitframe();

  for(;;) {
    if(self.angles[1] != self.ref_1376f) {
      self.angles = (self.angles[0], self.ref_1376f, self.angles[2]);
    }

    var_0 = self;
    var_1 = undefined;
    self.ref_1385b = scripts\engine\utility::getStruct(self.target, "targetname");

    for(;;) {
      var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

      if(!isDefined(var_2)) {
        break;
      }

      if(isstruct(var_2)) {
        var_1 = var_2;
        ref_145ab(var_1, var_0);
        self moveTo(var_1.origin, self.script_speed, 0, 0);
        wait self.script_speed;
        waitframe();
        var_0 = var_2;
        ref_13437(var_0);
      }
    }

    var_3 = getEnt(var_0.target, "targetname");

    if(isDefined(var_3) && var_3.script_noteworthy == "pivot_point") {
      self linkTo(var_3);
      var_3 rotateYaw(180, 4);
      wait 4;
      waitframe();
      self unlink();
      waitframe();
      var_0 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    }

    select_patrol_two_spawners();

    for(;;) {
      var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

      if(!isDefined(var_2)) {
        break;
      }

      if(isstruct(var_2)) {
        var_1 = var_2;
        ref_145ab(var_1, var_0);
        self moveTo(var_1.origin, self.script_speed, 0, 0);
        wait self.script_speed;
        waitframe();
        var_0 = var_2;
        ref_13437(var_0);
      }
    }

    var_3 = getEnt(var_0.target, "targetname");

    if(isDefined(var_3) && var_3.script_noteworthy == "pivot_point") {
      self linkTo(var_3);
      var_3 rotateYaw(180, 4);
      wait 4;
      waitframe();
      self unlink();
      waitframe();
      var_0 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    }

    select_patrol_two_spawners();

    while(scripts\engine\utility::getStruct(var_0.target, "targetname") != self.ref_1385b) {
      var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

      if(!isDefined(var_2)) {
        break;
      }

      if(isstruct(var_2)) {
        var_1 = var_2;
        ref_145ab(var_1, var_0);
        self moveTo(var_1.origin, self.script_speed, 0, 0);
        wait self.script_speed;
        waitframe();
        var_0 = var_2;
        ref_13437(var_0);
      }
    }
  }
}

function select_patrol_three_spawners() {
  level endon("game_ended");
  self endon("death");
  waitframe();

  for(;;) {
    if(self.angles[1] != self.ref_1376f) {
      self.angles = (self.angles[0], self.ref_1376f, self.angles[2]);
    }

    if(isDefined(self.script_parameters)) {
      self.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_" + self.script_parameters);
      self setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_" + self.script_parameters);
    }

    select_players_in_killzone_first();
    self moveTo(self.movelatejoinerstospectators, self.script_speed, 0.5, 0.5);
    wait self.script_speed;
    waitframe();
    self.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_TURN");
    self setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_TURN");
    self linkTo(self.ref_12384);
    self.ref_12384 rotateYaw(180, 4);
    wait 4;
    waitframe();
    self unlink();
    waitframe();
    select_patrol_two_spawners();

    if(isDefined(self.script_parameters)) {
      self.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_" + self.script_parameters);
      self setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_" + self.script_parameters);
    }

    select_players_in_killzone_first();
    self moveTo(self.moveleadmarkers, self.script_speed, 0.5, 0.5);
    wait self.script_speed;
    waitframe();
    self.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_TURN");
    self setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_TURN");
    self linkTo(self.ref_12385);
    self.ref_12385 rotateYaw(180, 4);
    wait 4;
    waitframe();
    self unlink();
    waitframe();
    select_patrol_two_spawners();
  }
}

function select_patrol_two_spawners() {
  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "up") {
      self.script_parameters = "down";
      return;
    }

    if(self.script_parameters == "down") {
      self.script_parameters = "up";
      return;
    }

    return;
  }
}

function select_players_in_killzone_first() {
  var_0 = self;

  if(!isDefined(var_0.juggheli_spawner_jammer5_1)) {
    return;
  }

  if(!isDefined(var_0.ref_145aa)) {
    return;
  }

  var_0.ref_145aa.angles = (0, var_0.ref_145aa.angles[1], var_0.ref_145aa.angles[2]);
  var_0.ref_145aa unlink();

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "up") {
    var_0.ref_145aa addpitch(var_0.juggheli_spawner_jammer5_1);
  } else if(isDefined(var_0.script_parameters) && var_0.script_parameters == "down") {
    var_0.ref_145aa addpitch(-1 * var_0.juggheli_spawner_jammer5_1);
  }

  var_0.ref_145aa linkTo(var_0);
}

function select_players_not_in_killzone_only(var_0, var_1) {
  var_2 = self;
  var_2.manageprematchfade = 1;
  var_2.stage1accradius = level.can_combat_action_be_interrupted;

  if(isDefined(level.ref_11c87) && [[level.ref_11c87]](var_0, var_2)) {
    return;
  }

  var_3 = undefined;
  var_4 = var_2 getlinkedparent();
  var_5 = var_4.origin;
  var_6 = var_5 + (0, 0, 5);
  var_7 = playerphysicstrace(var_5, var_6);

  if(var_7 == var_6 && canspawn(var_5)) {
    var_3 = var_5;
  }

  if(isDefined(var_3)) {
    var_0 setOrigin(var_3);
    return;
  }

  var_8 = 1000;

  if(isDefined(var_2.unresolved_collision_damage)) {
    var_8 = var_2.unresolved_collision_damage;
  }

  var_0 dodamage(var_8, var_2.origin, var_2.owner, var_2, "MOD_CRUSH");
}

function triggereliminatedoverlay(var_0) {
  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "gondola_clipbrush") {
    return true;
  }

  return false;
}

function ref_140fe() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("touch", var_0);

    if(isDefined(var_0) && nuke_vault_suicidebomber_internal(var_0)) {
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "MOD_CRUSH");
    }
  }
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function ref_13437(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || !isDefined(var_0) || !isDefined(var_1.ref_145aa)) {
    return;
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "snd_turn") {
    var_1.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_TURN");
    var_1 setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_TURN");
    return;
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "snd_up") {
    var_1.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_up");
    var_1 setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_up");
    return;
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "snd_down") {
    var_1.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_down");
    var_1 setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_down");
    return;
  }
}

function ref_145ab(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2) || !isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2.ref_145aa)) {
    return;
  }

  var_2.ref_145aa unlink();
  var_2.ref_145aa.angles = (0, var_2.ref_145aa.angles[1], var_2.ref_145aa.angles[2]);
  var_3 = vectortopitch(var_1.origin - var_0.origin);
  var_2.ref_145aa addpitch(var_3);
  var_2.ref_145aa linkTo(var_2);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gondola.gsc
***********************************************/

function ref_1396d() {
  level endon("game_ended");
  wait 1;
  level.can_combat_action_be_interrupted = getEntArray("gondola_start", "script_noteworthy");

  foreach(var1 in level.can_combat_action_be_interrupted) {
    ref_1396e(var1);
    thread select_patrol_three_spawners();
    thread ref_140fe();
  }
}

function unuseweapon() {
  level endon("game_ended");
  wait 1;
  level.can_combat_action_be_interrupted = getEntArray("gondola_start_v2", "script_noteworthy");

  foreach(var1 in level.can_combat_action_be_interrupted) {
    var1 clearwristwatchtime(1);
    friendly_convoy_intro_decho_idle_animation(var1);
    thread select_patrol_six_spawners();
    thread ref_140fe();
  }
}

function ref_1396e() {
  var0 = self;
  var1 = var0 scripts\engine\utility::get_linked_ents();

  foreach(var3 in var1) {
    var3 linkTo(var0);

    if(isDefined(var3.classname) && var3.classname == "script_brushmodel" && !isDefined(var3.targetname)) {
      var0.collision = var3;
      var3.targetname = "gondola_clipbrush";
      var3.unresolved_collision_func = &select_players_not_in_killzone_only;
    }

    if(isDefined(var3.targetname) && var3.targetname == "wheeler") {
      var0.ref_145aa = var3;
    }
  }

  var5 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var6 = getEnt(var5.target, "targetname");
  var7 = getEnt(var6.target, "targetname");
  var8 = scripts\engine\utility::getStruct(var7.target, "targetname");
  var9 = getEnt(var8.target, "targetname");
  var0.ref_1376e = var0.origin;
  var0.movelatejoinerstospectators = var5.origin;
  var0.ref_13770 = var7.origin;
  var0.moveleadmarkers = var8.origin;
  var0.ref_1376f = var0.angles[1];
  var0.ref_12384 = var6;
  var0.ref_12385 = var9;

  if(isDefined(var0.script_parameters) && var0.script_parameters == "up") {
    var0.juggheli_spawner_jammer5_1 = vectortopitch(var0.origin - var0.movelatejoinerstospectators);
  } else if(isDefined(var0.script_parameters) && var0.script_parameters == "down") {
    var0.juggheli_spawner_jammer5_1 = vectortopitch(var0.movelatejoinerstospectators - var0.origin);
  }

  if(!isDefined(var0.script_speed)) {
    var0.script_speed = 15;
    return;
  }
}

function friendly_convoy_intro_decho_idle_animation() {
  var0 = self;
  var1 = var0 scripts\engine\utility::get_linked_ents();

  foreach(var3 in var1) {
    var3 linkTo(var0);

    if(isDefined(var3.classname) && var3.classname == "script_brushmodel" && !isDefined(var3.targetname)) {
      var0.collision = var3;
      var3.targetname = "gondola_clipbrush";
      var3.unresolved_collision_func = &select_players_not_in_killzone_only;
    }

    if(isDefined(var3.targetname) && var3.targetname == "wheeler") {
      var0.ref_145aa = var3;
    }
  }

  var5 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var0.ref_1376f = var0.angles[1];

  if(isDefined(var0.script_parameters) && var0.script_parameters == "up") {
    var0.juggheli_spawner_jammer5_1 = 25;
  } else if(isDefined(var0.script_parameters) && var0.script_parameters == "down") {
    var0.juggheli_spawner_jammer5_1 = 25;
  }

  if(!isDefined(var0.script_speed)) {
    var0.script_speed = 1;
  }

  var6 = getdvarfloat("scr_gondola_speed_multiplier", 1.25);
  var0.script_speed = 1 * var6;
}

function select_patrol_six_spawners() {
  level endon("game_ended");
  self endon("death");
  waitframe();

  for(;;) {
    if(self.angles[1] != self.ref_1376f) {
      self.angles = (self.angles[0], self.ref_1376f, self.angles[2]);
    }

    var0 = self;
    var1 = undefined;
    self.ref_1385b = scripts\engine\utility::getStruct(self.target, "targetname");

    for(;;) {
      var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

      if(!isDefined(var2)) {
        break;
      }

      if(isstruct(var2)) {
        var1 = var2;
        ref_145ab(var1, var0);
        self moveTo(var1.origin, self.script_speed, 0, 0);
        wait self.script_speed;
        waitframe();
        var0 = var2;
        ref_13437(var0);
      }
    }

    var3 = getEnt(var0.target, "targetname");

    if(isDefined(var3) && var3.script_noteworthy == "pivot_point") {
      self linkTo(var3);
      var3 rotateYaw(180, 4);
      wait 4;
      waitframe();
      self unlink();
      waitframe();
      var0 = scripts\engine\utility::getStruct(var3.target, "targetname");
    }

    select_patrol_two_spawners();

    for(;;) {
      var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

      if(!isDefined(var2)) {
        break;
      }

      if(isstruct(var2)) {
        var1 = var2;
        ref_145ab(var1, var0);
        self moveTo(var1.origin, self.script_speed, 0, 0);
        wait self.script_speed;
        waitframe();
        var0 = var2;
        ref_13437(var0);
      }
    }

    var3 = getEnt(var0.target, "targetname");

    if(isDefined(var3) && var3.script_noteworthy == "pivot_point") {
      self linkTo(var3);
      var3 rotateYaw(180, 4);
      wait 4;
      waitframe();
      self unlink();
      waitframe();
      var0 = scripts\engine\utility::getStruct(var3.target, "targetname");
    }

    select_patrol_two_spawners();

    while(scripts\engine\utility::getStruct(var0.target, "targetname") != self.ref_1385b) {
      var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

      if(!isDefined(var2)) {
        break;
      }

      if(isstruct(var2)) {
        var1 = var2;
        ref_145ab(var1, var0);
        self moveTo(var1.origin, self.script_speed, 0, 0);
        wait self.script_speed;
        waitframe();
        var0 = var2;
        ref_13437(var0);
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
  var0 = self;

  if(!isDefined(var0.juggheli_spawner_jammer5_1)) {
    return;
  }

  if(!isDefined(var0.ref_145aa)) {
    return;
  }

  var0.ref_145aa.angles = (0, var0.ref_145aa.angles[1], var0.ref_145aa.angles[2]);
  var0.ref_145aa unlink();

  if(isDefined(var0.script_parameters) && var0.script_parameters == "up") {
    var0.ref_145aa addpitch(var0.juggheli_spawner_jammer5_1);
  } else if(isDefined(var0.script_parameters) && var0.script_parameters == "down") {
    var0.ref_145aa addpitch(-1 * var0.juggheli_spawner_jammer5_1);
  }

  var0.ref_145aa linkTo(var0);
}

function select_players_not_in_killzone_only(var0, var1) {
  var2 = self;
  var2.manageprematchfade = 1;
  var2.stage1accradius = level.can_combat_action_be_interrupted;

  if(isDefined(level.ref_11c87) && [[level.ref_11c87]](var0, var2)) {
    return;
  }

  var3 = undefined;
  var4 = var2 getlinkedparent();
  var5 = var4.origin;
  var6 = var5 + (0, 0, 5);
  var7 = playerphysicstrace(var5, var6);

  if(var7 == var6 && canspawn(var5)) {
    var3 = var5;
  }

  if(isDefined(var3)) {
    var0 setOrigin(var3);
    return;
  }

  var8 = 1000;

  if(isDefined(var2.unresolved_collision_damage)) {
    var8 = var2.unresolved_collision_damage;
  }

  var0 dodamage(var8, var2.origin, var2.owner, var2, "MOD_CRUSH");
}

function triggereliminatedoverlay(var0) {
  if(isDefined(var0) && isDefined(var0.targetname) && var0.targetname == "gondola_clipbrush") {
    return true;
  }

  return false;
}

function ref_140fe() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("touch", var0);

    if(isDefined(var0) && nuke_vault_suicidebomber_internal(var0)) {
      var0 dodamage(var0.health, self.origin, var0, var0, "MOD_CRUSH");
    }
  }
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function ref_13437(var0) {
  var1 = self;

  if(!isDefined(var1) || !isDefined(var0) || !isDefined(var1.ref_145aa)) {
    return;
  }

  if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "snd_turn") {
    var1.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_TURN");
    var1 setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_TURN");
    return;
  }

  if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "snd_up") {
    var1.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_up");
    var1 setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_up");
    return;
  }

  if(isDefined(var0.script_noteworthy) && var0.script_noteworthy == "snd_down") {
    var1.ref_145aa setscriptablepartstate("sfx", "sfx_don4_gondola_down");
    var1 setscriptablepartstate("sfx", "sfx_don4_gondola_arrived_down");
    return;
  }
}

function ref_145ab(var0, var1) {
  var2 = self;

  if(!isDefined(var2) || !isDefined(var0) || !isDefined(var1) || !isDefined(var2.ref_145aa)) {
    return;
  }

  var2.ref_145aa unlink();
  var2.ref_145aa.angles = (0, var2.ref_145aa.angles[1], var2.ref_145aa.angles[2]);
  var3 = vectortopitch(var1.origin - var0.origin);
  var2.ref_145aa addpitch(var3);
  var2.ref_145aa linkTo(var2);
}
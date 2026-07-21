/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gondola.gsc
***********************************************/

_id_1396D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  level.can_combat_action_be_interrupted = getEntArray("_encstr_B1D90E97D730426F98D9393A53D8BAFB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_1 in level.can_combat_action_be_interrupted) {
    var_1 _id_1396E();
    var_1 thread select_patrol_three_spawners();
    var_1 thread _id_140FE();
  }
}

unuseweapon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  level.can_combat_action_be_interrupted = getEntArray("_encstr_A9CA11D7778D30B8BB12169BAB67EE6869C6C5", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_1 in level.can_combat_action_be_interrupted) {
    var_1 clearwristwatchtime(1);
    var_1 friendly_convoy_intro_decho_idle_animation();
    var_1 thread select_patrol_six_spawners();
    var_1 thread _id_140FE();
  }
}

_id_1396E() {
  var_0 = self;
  var_1 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);

    if(isDefined(var_3.classname) && var_3.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C" && !isDefined(var_3.targetname)) {
      var_0.collision = var_3;
      var_3.targetname = "_encstr_A6C2120F9FBB0FAF81B75026726BE8C276B54F0B";
      var_3.unresolved_collision_func = ::select_players_not_in_killzone_only;
    }

    if(isDefined(var_3.targetname) && var_3.targetname == "_encstr_A71A08D0EA37BBF8EFF2")
      var_0._id_145AA = var_3;
  }

  var_5 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = getEnt(var_5.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = getEnt(var_6.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = scripts\engine\utility::getStruct(var_7.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = getEnt(var_8.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0._id_1376E = var_0.origin;
  var_0.movelatejoinerstospectators = var_5.origin;
  var_0._id_13770 = var_7.origin;
  var_0.moveleadmarkers = var_8.origin;
  var_0._id_1376F = var_0.angles[1];
  var_0._id_12384 = var_6;
  var_0._id_12385 = var_9;

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_87070365F7")
    var_0.juggheli_spawner_jammer5_1 = vectortopitch(var_0.origin - var_0.movelatejoinerstospectators);
  else if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_9767056D0FBFA8")
    var_0.juggheli_spawner_jammer5_1 = vectortopitch(var_0.movelatejoinerstospectators - var_0.origin);

  if(!isDefined(var_0.script_speed))
    var_0.script_speed = 15;
}

friendly_convoy_intro_decho_idle_animation() {
  var_0 = self;
  var_1 = var_0 scripts\engine\utility::get_linked_ents();

  foreach(var_3 in var_1) {
    var_3 linkTo(var_0);

    if(isDefined(var_3.classname) && var_3.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C" && !isDefined(var_3.targetname)) {
      var_0.collision = var_3;
      var_3.targetname = "_encstr_A6C2120F9FBB0FAF81B75026726BE8C276B54F0B";
      var_3.unresolved_collision_func = ::select_players_not_in_killzone_only;
    }

    if(isDefined(var_3.targetname) && var_3.targetname == "_encstr_A71A08D0EA37BBF8EFF2")
      var_0._id_145AA = var_3;
  }

  var_5 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0._id_1376F = var_0.angles[1];

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_87070365F7")
    var_0.juggheli_spawner_jammer5_1 = 25;
  else if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_9767056D0FBFA8")
    var_0.juggheli_spawner_jammer5_1 = 25;

  if(!isDefined(var_0.script_speed))
    var_0.script_speed = 1;

  var_6 = getdvarfloat("_encstr_A6D31D9BB19C7DEC7BB98C7BB158F5370E95B223EBDA571B1DD283C6D259C9", 1.25);
  var_0.script_speed = 1 * var_6;
}

select_patrol_six_spawners() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  waitframe();

  for(;;) {
    if(self.angles[1] != self._id_1376F)
      self.angles = (self.angles[0], self._id_1376F, self.angles[2]);

    var_0 = self;
    var_1 = undefined;
    self._id_1385B = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    for(;;) {
      var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(!isDefined(var_2)) {
        break;
      }

      if(isstruct(var_2)) {
        var_1 = var_2;
        _id_145AB(var_1, var_0);
        self moveTo(var_1.origin, self.script_speed, 0, 0);
        wait(self.script_speed);
        waitframe();
        var_0 = var_2;
        _id_13437(var_0);
        continue;
      }
    }

    var_3 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3) && var_3.script_noteworthy == "_encstr_B2F80CD263F34A4B26C1F7FAD8B9") {
      self linkTo(var_3);
      var_3 rotateYaw(180, 4);
      wait 4;
      waitframe();
      self unlink();
      waitframe();
      var_0 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }

    select_patrol_two_spawners();

    for(;;) {
      var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(!isDefined(var_2)) {
        break;
      }

      if(isstruct(var_2)) {
        var_1 = var_2;
        _id_145AB(var_1, var_0);
        self moveTo(var_1.origin, self.script_speed, 0, 0);
        wait(self.script_speed);
        waitframe();
        var_0 = var_2;
        _id_13437(var_0);
        continue;
      }
    }

    var_3 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3) && var_3.script_noteworthy == "_encstr_B2F80CD263F34A4B26C1F7FAD8B9") {
      self linkTo(var_3);
      var_3 rotateYaw(180, 4);
      wait 4;
      waitframe();
      self unlink();
      waitframe();
      var_0 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }

    select_patrol_two_spawners();

    while(scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF") != self._id_1385B) {
      var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(!isDefined(var_2)) {
        break;
      }

      if(isstruct(var_2)) {
        var_1 = var_2;
        _id_145AB(var_1, var_0);
        self moveTo(var_1.origin, self.script_speed, 0, 0);
        wait(self.script_speed);
        waitframe();
        var_0 = var_2;
        _id_13437(var_0);
        continue;
      }
    }
  }
}

select_patrol_three_spawners() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  waitframe();

  for(;;) {
    if(self.angles[1] != self._id_1376F)
      self.angles = (self.angles[0], self._id_1376F, self.angles[2]);

    if(isDefined(self.script_parameters)) {
      self._id_145AA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_820E122B6C286F6A4F4502E7993850523FD252B7" + self.script_parameters);
      self setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_8FB21A9BCCF0EBC8DB9B68BEB3B73719B7C685BE16274E4BB32B32EB" + self.script_parameters);
    }

    select_players_in_killzone_first();
    self moveTo(self.movelatejoinerstospectators, self.script_speed, 0.5, 0.5);
    wait(self.script_speed);
    waitframe();
    self._id_145AA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_83B31603F70889458A3BE12F07529898A7CDC91E134DB918");
    self setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_B8291E939051490B78B8BCDFC480DB4F97583AE90B1D7A777315F42775EF639D");
    self linkTo(self._id_12384);
    self._id_12384 rotateYaw(180, 4);
    wait 4;
    waitframe();
    self unlink();
    waitframe();
    select_patrol_two_spawners();

    if(isDefined(self.script_parameters)) {
      self._id_145AA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_820E122B6C286F6A4F4502E7993850523FD252B7" + self.script_parameters);
      self setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_8FB21A9BCCF0EBC8DB9B68BEB3B73719B7C685BE16274E4BB32B32EB" + self.script_parameters);
    }

    select_players_in_killzone_first();
    self moveTo(self.moveleadmarkers, self.script_speed, 0.5, 0.5);
    wait(self.script_speed);
    waitframe();
    self._id_145AA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_83B31603F70889458A3BE12F07529898A7CDC91E134DB918");
    self setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_B8291E939051490B78B8BCDFC480DB4F97583AE90B1D7A777315F42775EF639D");
    self linkTo(self._id_12385);
    self._id_12385 rotateYaw(180, 4);
    wait 4;
    waitframe();
    self unlink();
    waitframe();
    select_patrol_two_spawners();
  }
}

select_patrol_two_spawners() {
  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "_encstr_87070365F7")
      self.script_parameters = "_encstr_9767056D0FBFA8";
    else if(self.script_parameters == "_encstr_9767056D0FBFA8")
      self.script_parameters = "_encstr_87070365F7";
  }
}

select_players_in_killzone_first() {
  var_0 = self;

  if(!isDefined(var_0.juggheli_spawner_jammer5_1)) {
    return;
  }
  if(!isDefined(var_0._id_145AA)) {
    return;
  }
  var_0._id_145AA.angles = (0, var_0._id_145AA.angles[1], var_0._id_145AA.angles[2]);
  var_0._id_145AA unlink();

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_87070365F7")
    var_0._id_145AA addpitch(var_0.juggheli_spawner_jammer5_1);
  else if(isDefined(var_0.script_parameters) && var_0.script_parameters == "_encstr_9767056D0FBFA8")
    var_0._id_145AA addpitch(-1 * var_0.juggheli_spawner_jammer5_1);

  var_0._id_145AA linkTo(var_0);
}

select_players_not_in_killzone_only(var_0, var_1) {
  var_2 = self;
  var_2.manageprematchfade = 1;
  var_2.stage1accradius = level.can_combat_action_be_interrupted;

  if(isDefined(level._id_11C87) && [[level._id_11C87]](var_0, var_2)) {
    return;
  }
  var_3 = undefined;
  var_4 = var_2 getlinkedparent();
  var_5 = var_4.origin;
  var_6 = var_5 + (0, 0, 5);
  var_7 = playerphysicstrace(var_5, var_6);

  if(var_7 == var_6 && canspawn(var_5))
    var_3 = var_5;

  if(isDefined(var_3))
    var_0 setOrigin(var_3);
  else {
    var_8 = 1000;

    if(isDefined(var_2.unresolved_collision_damage))
      var_8 = var_2.unresolved_collision_damage;

    var_0 dodamage(var_8, var_2.origin, var_2.owner, var_2, "_encstr_8D4E0A501FCB898912CB3FA3");
  }
}

triggereliminatedoverlay(var_0) {
  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "_encstr_A6C2120F9FBB0FAF81B75026726BE8C276B54F0B")
    return 1;

  return 0;
}

_id_140FE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8D7D06302FE5E159", var_0);

    if(isDefined(var_0) && var_0 nuke_vault_suicidebomber_internal())
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "_encstr_8D4E0A501FCB898912CB3FA3");
  }
}

nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

_id_13437(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || !isDefined(var_0) || !isDefined(var_1._id_145AA)) {
    return;
  }
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_872509E7F515D154B05B95") {
    var_1._id_145AA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_83B31603F70889458A3BE12F07529898A7CDC91E134DB918");
    var_1 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_B8291E939051490B78B8BCDFC480DB4F97583AE90B1D7A777315F42775EF639D");
  } else if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AB9B077088EB2EAD18") {
    var_1._id_145AA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_8ABD14EBC9913F45B8481A9FCFBA02D3879B9B69BB3B");
    var_1 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A16A1CE6330FF5C8ED9B1AFAB3B7E691F6D82CEB2C399CB4D99523BEBA0E");
  } else if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_9BA1095745A561F4F06BE5") {
    var_1._id_145AA setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_923716D7D52BE17470C8F3210198B68A086927EF49D82B26");
    var_1 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_84AD1ED728127F62F7183BE9F48FBA0C98E017DFB88BAA7AEDA537916DA7E3DE");
  }
}

_id_145AB(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2) || !isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2._id_145AA)) {
    return;
  }
  var_2._id_145AA unlink();
  var_2._id_145AA.angles = (0, var_2._id_145AA.angles[1], var_2._id_145AA.angles[2]);
  var_3 = vectortopitch(var_1.origin - var_0.origin);
  var_2._id_145AA addpitch(var_3);
  var_2._id_145AA linkTo(var_2);
}
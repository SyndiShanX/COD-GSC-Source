/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_lv_trash_can_vegas.gsc
***********************************************************/

main() {
  if(common_scripts\utility::issp()) {
    common_scripts\_destructible::destructible_create("toy_lv_trash_can_vegas", "tag_origin", 0);
    common_scripts\_destructible::destructible_function(::lv_trash_can_vegas);
    main_sp();
  } else {
    common_scripts\_destructible::destructible_create("toy_lv_trash_can_vegas", "tag_origin", 0);
    common_scripts\_destructible::destructible_state("tag_origin", undefined, 100);
    common_scripts\_destructible::destructible_part("tag_lid", "lv_trash_can_vegas_lid", 50);
    common_scripts\_destructible::destructible_physics("tag_lid", (20, 0, 0));
    common_scripts\_destructible::destructible_state(undefined);
  }
}

attachlid() {
  self attach("lv_trash_can_vegas_lid", "tag_lid");
}

main_sp() {
  var_0 = spawnStruct();
  var_0.parts = [];
  var_0.parts[0] = spawnStruct();
  var_0.parts[0].states = [];
  var_0.parts[0].states[0] = spawnStruct();
  var_0.parts[0].states[0].model = undefined;
  var_0.parts[0].states[0].health = undefined;
  var_0.parts[0].states[0].damagecallback[0] = ::serverphysicsobj;
  var_0.parts[0].states[0].damagecallback[1] = ::lv_trash_can_vegas_hitfloor;
  var_0.parts[0].states[1] = spawnStruct();
  var_0.parts[0].states[1].model = undefined;
  var_0.parts[0].states[1].health = undefined;
  var_0.parts[0].states[1].fx = [];
  var_0.parts[0].states[1].fxtags = [];
  var_0.parts[0].states[1].fx[0] = loadfx("fx/props/trash_bottles");
  var_0.parts[0].states[1].fxtags[0] = "tag_fx";
  var_0.parts[0].states[1].fx[1] = loadfx("fx/misc/trash_spiral_runner");
  var_0.parts[0].states[1].fxtags[1] = "tag_fx";
  var_0.parts[0].states[1].sound = "exp_trashcan_sweet";
  var_0.parts[0].states[1].soundtag = "tag_fx";
  var_0.parts[1] = spawnStruct();
  var_0.parts[1].tag = "tag_lid";
  var_0.parts[1].parent = 0;
  var_0.parts[1].alsodamageparent = 1;
  var_0.parts[1].states = [];
  var_0.parts[1].states[0] = spawnStruct();
  var_0.parts[1].states[0].model = undefined;
  var_0.parts[1].states[0].showtag = 1;
  var_0.parts[1].states[0].health = 50;
  var_0.parts[1].states[1] = spawnStruct();
  var_0.parts[1].states[1].physicsmodel = "lv_trash_can_vegas_lid";
  var_0.parts[1].states[1].physicspush = (0, 0, 2000);
  var_0.parts[1].states[1].physicsmultiply = 40;
  var_0.parts[1].states[1].physicsdefaultdamagepush = (0, 0, 0);
  var_0.parts[1].states[1].health = undefined;
  var_0.impacttag = "tag_lid";
  var_0.impactradius = 15;
  var_0.parts[0].hitfloorstate = 1;
  var_0.parts[1].hitfloorstate = 1;
  var_0.clipmovementtolerance = 8;

  if(!isDefined(level._interactive))
    level._interactive = [];

  level._interactive["lv_trash_can_vegas"] = var_0;
}

lv_trash_can_vegas() {
  var_0 = spawnStruct();
  var_0.obj = self;
  var_0.type = "lv_trash_can_vegas";
  interactive_fall_and_break(var_0);
}

interactive_fall_and_break(var_0) {
  var_1 = level._interactive[var_0.type];
  var_0.partstates = [];
  var_0.parthealths = [];

  for(var_2 = 0; var_2 < var_1.parts.size; var_2++) {
    var_0.partstates[var_2] = 0;
    var_0.parthealths[var_2] = var_1.parts[var_2].states[0].health;
  }

  foreach(var_4 in var_1.parts) {
    foreach(var_6 in var_4.states) {
      if(isDefined(var_6.model))
        precachemodel(var_6.model);

      if(isDefined(var_6.physicsmodel))
        precachemodel(var_6.physicsmodel);
    }
  }

  foreach(var_4 in var_1.parts) {
    if(isDefined(var_4.alsodamageparent)) {}
  }

  var_0 fandb_handles_collision_brushes();

  for(;;) {
    var_0.obj waittill("damage", var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);
    var_15 = destructible_modifydamagetype(var_15);
    var_11 = destructible_modifydamageamount(var_11, var_15, var_12);

    if(isDefined(var_18))
      var_19 = fandb_findpartindex(var_0.type, var_18);
    else
      var_19 = 0;

    fandb_dodamage(var_0, var_19, var_11, var_12, var_13, var_14, var_15);
  }
}

destructible_modifydamagetype(var_0) {
  var_1 = common_scripts\_destructible::getdamagetype(var_0);
  return var_1;
}

destructible_modifydamageamount(var_0, var_1, var_2) {
  if(common_scripts\utility::issp())
    var_0 = var_0 * 0.5;
  else
    var_0 = var_0 * 1.0;

  if(common_scripts\_destructible::is_shotgun_damage(var_2, var_1)) {
    if(common_scripts\utility::issp())
      var_0 = var_0 * 8.0;
    else
      var_0 = var_0 * 4.0;
  }

  if(var_1 == "splash") {
    if(common_scripts\utility::issp())
      var_0 = var_0 * 9.0;
    else
      var_0 = var_0 * 13.0;
  }

  return var_0;
}

fandb_dodamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_6 == "splash") {
    var_8 = [];

    for(var_9 = 0; var_9 < level._interactive[var_0.type].parts.size; var_9++)
      var_8[var_9] = var_9;
  } else {
    var_8 = [];
    var_8[0] = var_1;
  }

  foreach(var_11 in var_8) {
    var_12 = level._interactive[var_0.type].parts[var_11];
    var_13 = var_2;

    while(var_13 > 0 && isDefined(var_12.states[var_0.partstates[var_11]])) {
      if(isDefined(var_12.states[var_0.partstates[var_11]].damagecallback)) {
        foreach(var_15 in var_12.states[var_0.partstates[var_11]].damagecallback)
        var_0[[var_15]](var_2, var_3, var_4, var_5, var_6);
      }

      if(isDefined(var_0.parthealths[var_11])) {
        var_0.parthealths[var_11] = var_0.parthealths[var_11] - var_13;

        if(var_0.parthealths[var_11] < 0) {
          var_13 = -1 * var_0.parthealths[var_11];
          var_0 fandb_gotostate(var_11, var_0.partstates[var_11] + 1, var_2, var_3, var_5, var_4, var_6);
        } else
          var_13 = 0;

        continue;
      }

      var_13 = 0;
    }

    if(var_6 != "splash" && (isDefined(var_12.alsodamageparent) && var_12.alsodamageparent > 0) && (!isDefined(var_7) || var_12.parent != var_7))
      fandb_dodamage(var_0, var_12.parent, var_2 * var_12.alsodamageparent, var_3, var_4, var_5, var_6, var_11);
  }
}

fandb_gotostate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level._interactive[self.type].parts[var_0];
  var_8 = self.partstates[var_0];
  self.partstates[var_0] = var_1;
  var_9 = var_8 != var_1;

  if(isDefined(var_7.states[self.partstates[var_0]])) {
    if(var_9) {
      self.parthealths[var_0] = var_7.states[self.partstates[var_0]].health;
      var_10 = var_7.states[self.partstates[var_0]];

      if(isDefined(var_2))
        var_2 = var_2 * var_10.physicsmultiply;

      self.obj fandb_throwphysicsmodel(var_10.physicsmodel, var_7.tag, var_10.physicspush, var_10.physicsdefaultdamagepush, var_2, var_4, var_5);
      self.obj fandb_fx(var_10.fx, var_10.fxtags);
      self.obj fandb_playSound(var_10.sound, var_10.soundtag);
    }

    self.obj fandb_hideshowtag(var_7.states[self.partstates[var_0]].showtag, var_7.tag);
  }
}

fandb_hideshowtag(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(isDefined(var_0) && var_0) {
      if(isDefined(var_2))
        self showpart(var_1, var_2);
      else
        self showpart(var_1);
    } else if(isDefined(var_2))
      self hidepart(var_1, var_2);
    else
      self hidepart(var_1);
  }
}

fandb_throwphysicsmodel(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_0)) {
    var_7 = spawn("script_model", self gettagorigin(var_1));
    var_7.angles = self gettagangles(var_1);
    var_7 setModel(var_0);

    if(isDefined(var_5))
      var_8 = var_5;
    else
      var_8 = var_7.origin;

    if((!isDefined(var_6) || !isDefined(var_4)) && isDefined(var_3))
      var_9 = var_3;
    else
      var_9 = (0, 0, 0);

    if(isDefined(var_2)) {
      var_9 = var_9 + var_2;
      var_8 = (var_8 + var_7.origin) / 2;
    }

    var_10 = var_9[0] * anglesToForward(var_7.angles);
    var_11 = var_9[1] * anglestoright(var_7.angles);
    var_12 = var_9[2] * anglestoup(var_7.angles);
    var_9 = var_10 + var_11 + var_12;

    if(isDefined(var_6) && isDefined(var_4))
      var_9 = var_9 + var_6 * var_4;

    var_7 physicslaunchclient(var_8, var_9);
  }
}

fandb_fx(var_0, var_1) {
  if(isDefined(var_0)) {
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_3 = self gettagorigin(var_1[var_2]);
      var_4 = self gettagangles(var_1[var_2]);
      var_5 = anglesToForward(var_4);
      var_6 = anglestoup(var_4);
      playFX(var_0[var_2], var_3, var_5, var_6);
    }
  }
}

fandb_playSound(var_0, var_1) {
  if(isDefined(var_0))
    thread common_scripts\_destructible::play_sound(var_0, var_1);
}

fandb_findpartindex(var_0, var_1) {
  var_2 = level._interactive[var_0];

  for(var_3 = 0; var_3 < var_2.parts.size; var_3++) {
    if(isDefined(var_2.parts[var_3].tag) && var_2.parts[var_3].tag == var_1)
      return var_3;
  }

  return 0;
}

serverphysicsobj(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", self.obj.origin);
  var_5.angles = self.obj.angles;
  var_5 setModel(self.obj.model);
  var_2 = vectornormalize(var_2);

  if(var_4 != "splash")
    var_0 = var_0 * 10;
  else
    var_0 = var_0 * 2;

  var_5 physicslaunchserver(var_3, var_0 * var_2);
  self.obj delete();
  self.obj = var_5;
  self.obj setCanDamage(1);

  for(var_6 = 0; var_6 < level._interactive[self.type].parts.size; var_6++)
    fandb_gotostate(var_6, self.partstates[var_6]);
}

fandb_handles_collision_brushes() {
  if(!isDefined(self.obj.target)) {
    return;
  }
  var_0 = getEntArray(self.obj.target, "targetname");
  var_1 = [];
  var_1["pre"] = common_scripts\_destructible::collision_brush_pre_explosion;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.script_destruct_collision)) {
      continue;
    }
    self thread[[var_1[var_3.script_destruct_collision]]](var_3);
  }
}

lv_trash_can_vegas_hitfloor(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.startedfallmonitor)) {
    self.startedfallmonitor = 1;
    thread lv_trash_can_vegas_hitfloor_internal();
  }
}

lv_trash_can_vegas_hitfloor_internal() {
  var_0 = level._interactive["lv_trash_can_vegas"];

  if(!isDefined(self.impacttagstartpos)) {
    self.impacttagstartpos = self.obj gettagorigin(var_0.impacttag);
    self.groundheight = self.obj.origin[2];
  }

  var_1 = self.impacttagstartpos;
  var_2 = var_1;
  var_3 = 0;
  var_4 = 1;
  var_5 = "intact";
  var_6 = level.time;

  while(var_4 || var_5 != "deleted") {
    wait 0.05;
    var_1 = self.obj gettagorigin(var_0.impacttag);

    if(distancesquared(var_1, var_2) < 0.0625) {
      var_3++;

      if(var_3 > 20) {
        self.startedfallmonitor = undefined;
        break;
      }
    } else
      var_3 = 0;

    var_2 = var_1;

    if(var_4 && var_1[2] - self.groundheight < var_0.impactradius) {
      var_4 = 0;
      lv_trash_can_vegas_throwlid();
      var_5 = "deleted";
      self notify("exploded");
    }

    if(var_5 != "deleted") {
      if(distancesquared(var_1, self.impacttagstartpos) > var_0.clipmovementtolerance * var_0.clipmovementtolerance) {
        if(var_5 == "intact") {
          var_5 = "pending";
          var_6 = gettime();
        } else {
          if(var_6 > gettime())
            var_6 = gettime() - 1000;

          if(gettime() - var_6 >= 1000) {
            var_5 = "deleted";
            self notify("exploded");
          }
        }

        continue;
      }

      var_5 = "intact";
    }
  }
}

lv_trash_can_vegas_throwlid() {
  var_0 = level._interactive["lv_trash_can_vegas"];
  var_1 = spawn("script_model", self.obj.origin);
  var_1.angles = self.obj.angles;
  var_1 setModel(self.obj.model);
  var_1 physicslaunchclient();
  self.obj delete();
  self.obj = var_1;
  self.obj setCanDamage(1);

  for(var_2 = 0; var_2 < var_0.parts.size; var_2++)
    fandb_gotostate(var_2, var_0.parts[var_2].hitfloorstate);
}
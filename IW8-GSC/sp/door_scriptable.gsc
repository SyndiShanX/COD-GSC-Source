/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\door_scriptable.gsc
***********************************************/

init_destructible() {
  if(!isDefined(self.script_destructible)) {
    return;
  }
  self.destructible = 1;
  var_0 = scripts\engine\utility::get_linked_ents();
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.code_classname == "script_brushmodel" && !var_3 scripts\sp\door_internal::is_clip_nosight()) {
      var_1 = var_3;
      break;
    } else if(isDefined(var_3.script_index) && var_3.script_index == 0) {
      var_1 = var_3;
      break;
    }
  }

  var_5 = get_door_dependencies();
  var_1.parent = self;
  var_1 linkTo(self);
  var_1.script_index = 0;
  var_6 = var_1 scripts\engine\utility::get_linked_ents();
  var_6[var_6.size] = var_1;
  var_1.allpieces = var_6;
  self.pieces = scripts\engine\sp\utility::array_index_by_script_index(var_6);

  foreach(var_3 in self.pieces) {
    var_3.health = 200;
    var_3 setCanDamage(1);
    var_3 linkTo(self);
    var_3.destroyed = 0;
    var_3.mainpiece = var_1;

    if(isDefined(var_3.script_type)) {
      if(var_3.script_type == "handle") {
        var_3.hashandle = 1;

        if(isDefined(self.no_handle_ajar))
          var_3.ignore_bullets = self.no_handle_ajar;
      }
    }

    if(var_3.script_index == 0) {
      var_3.start_health = 2200;
      var_3.health = var_3.start_health;
    } else if(var_3.script_index > 0) {
      var_3.depends = [];

      foreach(var_9 in var_5[var_3.script_index]) {
        foreach(var_11 in self.pieces) {
          if(var_11.script_index == var_9) {
            var_3.depends[var_3.depends.size] = var_11;

            if(!isDefined(var_11.updatedepends))
              var_11.updatedepends = [];

            var_11.updatedepends[var_11.updatedepends.size] = var_3;
          }
        }
      }
    }

    var_3 thread destructible_piece_thread();
  }
}

get_door_dependencies() {
  if(isDefined(self.script_type))
    var_0 = get_model_dependencies();
  else
    var_0 = get_brushmodel_dependencies();

  return var_0;
}

get_model_dependencies() {
  var_0 = [];
  var_0[1] = [0, 2, 3, 6];
  var_0[2] = [1, 3, 6, 7, 8];
  var_0[3] = [2, 4, 8];
  var_0[4] = [3, 8, 9];
  var_0[5] = [0, 1, 6, 10];
  var_0[6] = [1, 2, 5, 7, 11, 12];
  var_0[7] = [2, 6, 8, 12];
  var_0[8] = [2, 3, 4, 7, 9, 12, 13, 14];
  var_0[9] = [4, 8, 14, 21];
  var_0[10] = [0, 5, 11, 15];
  var_0[11] = [6, 10, 12, 16, 17];
  var_0[12] = [6, 7, 8, 11, 13, 18, 19];
  var_0[13] = [8, 12, 14, 19, 20];
  var_0[14] = [8, 9, 13, 20, 21];
  var_0[15] = [0, 10, 22, 17];
  var_0[16] = [11, 15, 16, 22, 23];
  var_0[17] = [11, 12, 16, 18, 23];
  var_0[18] = [12, 13, 17, 19, 23, 24];
  var_0[19] = [13, 18, 20, 24];
  var_0[20] = [13, 14, 19, 21, 24, 25];
  var_0[21] = [14, 20, 25];
  var_0[22] = [0, 15, 16, 23];
  var_0[23] = [18, 19, 20, 22, 25];
  var_0[24] = [18, 20, 23, 25];
  var_0[25] = [20, 21, 24];
  return var_0;
}

get_brushmodel_dependencies() {
  var_0 = [];
  var_0[1] = [0, 2, 3, 6];
  var_0[2] = [1, 3, 6, 7, 8];
  var_0[3] = [2, 4, 8];
  var_0[4] = [3, 8, 9];
  var_0[5] = [0, 1, 6, 10];
  var_0[6] = [1, 2, 5, 7, 11, 12];
  var_0[7] = [2, 6, 8, 12];
  var_0[8] = [2, 3, 4, 7, 9, 12, 13, 14];
  var_0[9] = [4, 8, 14, 22];
  var_0[10] = [0, 5, 11, 15];
  var_0[11] = [6, 10, 12, 16, 17];
  var_0[12] = [6, 7, 8, 11, 13, 18, 19];
  var_0[13] = [8, 12, 14, 20, 21];
  var_0[14] = [8, 9, 13, 21, 22];
  var_0[15] = [0, 10, 23, 17];
  var_0[16] = [11, 15, 16, 23];
  var_0[17] = [11, 16, 18, 24];
  var_0[18] = [12, 17, 19, 24];
  var_0[19] = [12, 18, 20, 24];
  var_0[20] = [13, 19, 21, 25];
  var_0[21] = [13, 14, 20, 22, 25];
  var_0[22] = [14, 9, 21, 26];
  var_0[23] = [0, 15, 16, 24];
  var_0[24] = [16, 17, 18, 19, 23, 25];
  var_0[25] = [19, 20, 21, 24, 26];
  var_0[26] = [21, 22, 25];
  return var_0;
}

is_heirarchy_good() {
  self.heirarchytest = 1;

  foreach(var_1 in self.depends) {
    if(var_1.script_index == 0) {
      self notify("stop_heirarchy_line");
      return 1;
    }

    if(!isDefined(var_1.heirarchytest) && !var_1.destroyed) {
      if(var_1 is_heirarchy_good()) {
        self notify("stop_heirarchy_line");
        return 1;
      }
    }
  }

  self notify("stop_heirarchy_line");
  return 0;
}

doline(var_0, var_1) {
  self endon("stop_heirarchy_line");

  for(;;)
    waitframe();
}

update_depends(var_0) {
  if(isDefined(self.depends))
    self.depends = scripts\engine\utility::array_removeundefined(self.depends);

  self.updatedepends = scripts\engine\utility::array_removeundefined(self.updatedepends);

  foreach(var_2 in self.updatedepends) {
    if(var_2.destroyed) {
      continue;
    }
    var_2.depends = scripts\engine\utility::array_remove(var_2.depends, self);

    if(!var_2 is_heirarchy_good()) {
      self.updatedepends = scripts\engine\utility::array_remove(self.updatedepends, var_2);

      if(isDefined(self.doordamagemod))
        var_2 notify("damage", 90, undefined, var_0, self.doordamagepoint, self.doordamagemod);
      else
        var_2 notify("damage", 90, undefined, var_0, undefined, "scripted");
    }

    foreach(var_2 in self.mainpiece.allpieces)
    var_2.heirarchytest = undefined;
  }
}

destructible_ignore_attacker(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(self.mainpiece.parent.damgeignoreents)) {
    foreach(var_2 in self.mainpiece.parent.damgeignoreents) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_0 == var_2)
        return 1;
    }
  }

  return 0;
}

destructible_piece_thread() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  while(self.health > 0) {
    self waittill("damage", var_4, var_3, var_1, var_0, var_2, var_5, var_6, var_7, var_8, var_9);

    if(destructible_ignore_attacker(var_3) || should_ignore_mod(var_2)) {
      self.maxhealth = 0;
      self.health = self.health + var_4;
      continue;
    }

    var_4 = door_damage_scale(var_4, var_9, var_2);

    if(isDefined(var_2)) {
      if(var_2 == "MOD_GRENADE" || var_2 == "MOD_GRENADE_SPLASH") {
        self.doordamagemod = var_2;
        self.doordamagepoint = var_0;

        if(self.script_index == 0 && var_4 > 100) {
          break;
        }

        var_1 = vectorNormalize(self.origin - var_0);

        if(self.health < var_4 * 3) {
          break;
        }
      } else if(var_2 == "MOD_MELEE") {
        self.maxhealth = 0;
        self.health = self.health + var_4;
      } else if(var_2 == "scripted") {
        break;
      }
    }

    if(self.script_index > 0) {
      var_10 = self.origin + var_1 * -1 * 100;

      if(!isDefined(var_2)) {
        if(!isDefined(var_3))
          self.mainpiece scripts\sp\utility::do_damage(var_4, var_10);
        else
          self.mainpiece scripts\sp\utility::do_damage(var_4, var_10, var_3, var_3);
      } else if(var_2 != "scripted")
        self.mainpiece scripts\sp\utility::do_damage(var_4, var_10, var_3, var_3, var_2);
    }

    self.doordamagepoint = undefined;
    self.doordamagemod = undefined;
  }

  if(isDefined(self.mainpiece))
    var_11 = self.mainpiece;
  else
    var_11 = self;

  if(isDefined(var_11.parent.clip_nosight))
    var_11.parent.clip_nosight delete();

  var_11.parent notify("piece_destroyed", self);
  self.destroyed = 1;
  update_depends(var_1);

  if(!isDefined(var_0))
    var_0 = self.origin;

  var_12 = vectortoangles(self.mainpiece.parent.forward);
  var_13 = anglestoright(var_12);
  var_14 = vectorNormalize(var_0 - self.origin);
  var_15 = vectordot(var_13, var_14);
  var_1 = var_13;

  if(var_15 > 0)
    var_1 = var_1 * -1;

  self unlink();

  if(isDefined(var_3) && isPlayer(var_3))
    var_1 = var_1 * -1;

  if(istrue(self.hashandle) && !istrue(self.ignore_bullets)) {
    var_16 = spawnStruct();
    var_16.origin = self.origin + var_1 * 32;
    self.mainpiece.parent.ajar_opener = var_16;
    self.mainpiece.parent.nohint = 1;
    self.mainpiece.parent notify("first_interact");
    self.mainpiece.parent.open_struct scripts\sp\door::remove_open_interact_hint();
  }

  if(self.code_classname == "script_brushmodel") {
    var_17 = randomintrange(300, 600);
    self.origin = self.origin + var_1 * 3;
  } else
    var_17 = randomintrange(50, 150);

  waitframe();

  if(isDefined(var_2) && var_2 == "explosive")
    self physicslaunchclient(var_0, var_1 * var_17 * 0.5);
  else
    self physicslaunchclient(var_0, var_1 * var_17);

  if(self.script_index == 0) {
    self.parent notify("unusable");
    self.parent scripts\sp\door::clear_navobstacle();
    level.interactive_doors.ents = scripts\engine\utility::array_remove(level.interactive_doors.ents, self.parent);

    if(isDefined(self.parent.pivot_ent))
      self.parent.pivot_ent delete();

    if(isDefined(self.parent.clip_nosight))
      self.parent.clip_nosight delete();

    self.parent delete();
  }

  wait 5;
  self delete();
}

door_damage_scale(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(var_2 != "MOD_MELEE") {
      if(var_1.classname == "spread")
        var_0 = var_0 * 1.36;
    }
  }

  return int(var_0);
}

should_ignore_mod(var_0) {
  if(istrue(self.ignore_bullets)) {
    switch (var_0) {
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        return 1;
      default:
        return 0;
    }
  } else if(istrue(self.mainpiece.parent.ignore_grenades)) {
    switch (var_0) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_EXPLOSIVE":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

scriptable_init() {
  self.destructible = 1;

  if(self.classname == "scriptable_door_wooden_hollow_rl_01")
    self.parthealth = 90;

  scriptable_inherit_parameters();
  scriptable_parts_init();
  self enablelinkTo();
  self.health = 200000;
  self.start_health = 200000;
  self setCanDamage(1);
  thread scriptable_damage_thread();
  scripts\sp\door_internal::init_door_internal();
  level scripts\sp\door_internal::global_door_threads();
}

scriptable_inherit_parameters() {
  var_0 = scripts\engine\utility::get_linked_structs();
  var_1 = var_0[0];
  self.script_parameters = var_1.script_parameters;
  self.script_max_left_angle = var_1.script_max_left_angle;
  self.script_max_right_angle = var_1.script_max_right_angle;
}

scriptable_parts_init() {
  self.parts = [];
  self.part_main = scriptable_part_struct(0);
  self.part_main.health = 2200;
  self.parts_map = get_scriptable_map();

  for(var_0 = 1; var_0 < 31; var_0++) {
    var_1 = scriptable_part_struct(var_0);

    if(var_0 == 1)
      var_1.ishandle = 1;

    self.parts[var_1.full_partname] = var_1;
  }
}

scriptable_part_struct(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(self.parthealth))
    var_2.health = self.parthealth;
  else
    var_2.health = 150;

  var_2.partindex = var_0;

  if(var_0 > 0)
    var_2.full_partname = scriptable_get_full_partname(var_0);

  var_2.destroyed = 0;
  return var_2;
}

scriptable_damage_thread() {
  self.ispristine = 1;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    scriptable_damage_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

scriptable_damage_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!self.ispristine) {
    if(is_explosive_damage(var_4, var_9))
      scriptable_explosive_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    else
      thread scriptable_gun_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else {
    self.ispristine = 0;
    self setscriptablepartstate("main", "initial_dmg");

    if(isDefined(self.fndamage))
      [[self.fndamage]](0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(is_explosive_damage(var_4, var_9))
      thread scriptable_explosive_damage_framedelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

is_explosive_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(var_1.basename == "flash" || var_1.basename == "molotov")
      return 0;
  }

  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_EXPLOSIVE":
      return 1;
  }

  return 0;
}

scriptable_explosive_damage_framedelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  waitframe();
  scriptable_explosive_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

scriptable_explosive_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scriptable_ignore_attacker(var_1) || scriptable_ignore_mod(var_4)) {
    self.maxhealth = 0;
    self.health = self.health + var_0;
    return;
  }

  var_10 = [];

  foreach(var_12 in self.parts)
  var_10[var_10.size] = var_12;

  var_10 = scripts\engine\utility::array_randomize(var_10);
  var_14 = var_0 / 400;
  var_15 = int(var_10.size * var_14);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12.full_partname)) {
      continue;
    }
    if(var_12.destroyed) {
      continue;
    }
    thread scriptable_gun_damage(90, undefined, var_2, var_3, "scripted", undefined, undefined, var_12.full_partname);
    var_15--;

    if(var_15 == 0) {
      break;
    }
  }
}

scriptable_gun_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scriptable_ignore_attacker(var_1) || scriptable_ignore_mod(var_4)) {
    self.maxhealth = 0;
    self.health = self.health + var_0;
  } else {
    var_0 = door_damage_scale(var_0, var_9, var_4);

    if(isDefined(self.fndamage))
      [[self.fndamage]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.parts[var_7])) {
      var_10 = self.parts[var_7];
      var_10.health = var_10.health - var_0;

      if(var_10.health <= 0 || var_4 == "scripted") {
        scriptable_destroy_part(var_10.partindex, var_10, var_4, var_2, var_3, var_1);
        return;
      }
    }
  }
}

scriptable_ignore_attacker(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(self.damgeignoreents)) {
    foreach(var_2 in self.damgeignoreents) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_0 == var_2)
        return 1;
    }
  }

  return 0;
}

scriptable_ignore_mod(var_0) {
  if(istrue(self.ignore_bullets)) {
    switch (var_0) {
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        return 1;
      default:
        return 0;
    }
  } else if(istrue(self.ignore_grenades)) {
    switch (var_0) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_EXPLOSIVE":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

get_fx_direction(var_0) {
  if(!isDefined(var_0))
    return 1;

  var_1 = vectortoangles(self.forward);
  var_2 = anglestoright(var_1);
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_2, var_3);
  self.prevplayeronright = self.playeronright;

  if(var_4 > 0)
    return 1;
  else
    return 0;
}

scriptable_destroy_part(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 = "" + var_0;
  var_1.destroyed = 1;
  scriptable_update_map(var_1.partindex, var_0, var_4);

  if(isDefined(self.clip_nosight))
    self.clip_nosight delete();

  var_7 = get_fx_direction(var_4);

  if(isPlayer(var_5))
    var_7 = !var_7;

  if(var_7)
    self setscriptablepartstate(var_0, "hide");
  else
    self setscriptablepartstate(var_0, "hide_minus");

  if(isDefined(var_1.ishandle)) {
    var_8 = spawnStruct();
    var_8.origin = self.origin + var_3 * -32;
    self.ajar_opener = var_8;
    self.nohint = 1;
    self notify("first_interact");
    self.open_struct scripts\sp\door::remove_open_interact_hint();
  }
}

scriptable_update_map(var_0, var_1, var_2) {
  if(!isDefined(self.parts_map[var_0])) {
    return;
  }
  var_3 = self.parts_map[var_0];

  foreach(var_5 in var_3) {
    if(var_5 == 0) {
      continue;
    }
    var_6 = scriptable_get_part_by_index(var_5);

    if(var_6.destroyed) {
      continue;
    }
    if(!is_scriptable_heirarchy_good(var_6)) {
      if(isDefined(self.doordamagemod))
        thread scriptable_gun_damage(90, undefined, var_1, self.doordamagepoint, self.doordamagemod, undefined, undefined, var_6.full_partname);
      else
        thread scriptable_gun_damage(90, undefined, var_1, var_2, "scripted", undefined, undefined, var_6.full_partname);
    }

    foreach(var_8 in self.parts)
    var_8.heirarchytest = undefined;
  }
}

scriptable_get_full_partname(var_0) {
  if(var_0 < 10)
    var_1 = "0" + var_0;
  else
    var_1 = var_0;

  return "tag_geo_frag_a_0" + var_1;
}

scriptable_get_part_by_index(var_0) {
  return self.parts[scriptable_get_full_partname(var_0)];
}

is_scriptable_heirarchy_good(var_0) {
  var_0.heirarchytest = 1;

  if(!isDefined(self.parts_map[var_0.partindex]))
    return 1;

  var_1 = self.parts_map[var_0.partindex];

  foreach(var_3 in var_1) {
    if(var_3 == 0)
      return 1;

    var_4 = scriptable_get_part_by_index(var_3);

    if(!isDefined(var_4.heirarchytest) && !var_4.destroyed) {
      if(is_scriptable_heirarchy_good(var_4))
        return 1;
    }
  }

  return 0;
}

get_scriptable_map() {
  var_0 = [];

  if(self.classname == "scriptable_door_wooden_hollow_rl_01")
    return get_prototype_scriptable_map();

  var_0[1] = [0, 11];
  var_0[2] = [0, 6];
  var_0[3] = [0, 6];
  var_0[4] = [0, 6];
  var_0[5] = [0, 6, 9];
  var_0[6] = [2, 3, 5, 7, 9];
  var_0[7] = [0, 6, 10];
  var_0[8] = [0, 9, 12];
  var_0[9] = [5, 6, 7, 12, 10];
  var_0[10] = [7, 9, 11, 12, 13];
  var_0[11] = [0, 1, 10, 13];
  var_0[12] = [8, 9, 10, 13, 15, 16];
  var_0[13] = [10, 11, 12, 14, 17, 18];
  var_0[14] = [0, 13];
  var_0[15] = [0, 12, 16, 19];
  var_0[16] = [12, 15, 17, 19, 20];
  var_0[17] = [13, 16, 20, 18];
  var_0[18] = [0, 13, 17, 20];
  var_0[19] = [15, 16, 20, 21, 22];
  var_0[20] = [16, 17, 18, 19, 23, 24];
  var_0[21] = [0, 19, 12, 22];
  var_0[22] = [19, 21, 23, 25, 26];
  var_0[23] = [20, 22, 24, 26, 27, 30];
  var_0[24] = [0, 20, 23];
  var_0[25] = [0, 22, 26];
  var_0[26] = [22, 23, 25, 28, 29, 30];
  var_0[27] = [0, 23];
  var_0[28] = [0, 26];
  var_0[29] = [0, 26];
  var_0[30] = [0, 23, 26];
  return var_0;
}

get_prototype_scriptable_map() {
  var_0 = [];
  var_0[1] = [0, 13, 18];
  var_0[2] = [0, 6];
  var_0[3] = [0, 6];
  var_0[4] = [0, 6];
  var_0[5] = [0, 6, 9];
  var_0[6] = [2, 3, 5, 7, 9];
  var_0[7] = [0, 6, 10];
  var_0[8] = [0, 9, 12];
  var_0[9] = [5, 6, 7, 8, 12, 10];
  var_0[10] = [7, 9, 11, 12, 13, 14];
  var_0[11] = [0, 10];
  var_0[12] = [8, 9, 10, 13, 15, 16];
  var_0[13] = [10, 11, 12, 14, 17, 18];
  var_0[14] = [0, 10, 13];
  var_0[15] = [0, 12, 16, 19];
  var_0[16] = [12, 15, 17, 19, 20];
  var_0[17] = [13, 16, 20, 18];
  var_0[18] = [0, 13, 17, 20];
  var_0[19] = [15, 16, 20, 21, 22];
  var_0[20] = [16, 17, 18, 19, 23, 24];
  var_0[21] = [0, 19, 12, 22];
  var_0[22] = [19, 21, 23, 25, 26];
  var_0[23] = [20, 22, 24, 26, 27, 30];
  var_0[24] = [0, 20, 23];
  var_0[25] = [0, 22, 26];
  var_0[26] = [22, 23, 25, 28, 29, 30];
  var_0[27] = [0, 23];
  var_0[28] = [0, 26];
  var_0[29] = [0, 26];
  var_0[30] = [0, 23, 26];
  return var_0;
}

scriptable_get_part_origin(var_0) {
  if(var_0.partindex == 0)
    var_1 = "tag_origin";
  else
    var_1 = var_0.full_partname;

  return self gettagorigin(var_1);
}
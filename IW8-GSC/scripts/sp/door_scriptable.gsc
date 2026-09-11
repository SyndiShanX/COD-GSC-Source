/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\door_scriptable.gsc
***********************************************/

function init_destructible() {
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
    }

    if(isDefined(var_3.script_index) && var_3.script_index == 0) {
      var_1 = var_3;
      break;
    }
  }

  var_5 = get_door_dependencies();
  var_1.parent = self;
  var_1 linkTo(self);
  var_1.script_index = 0;
  var_6 = var_1 scripts\engine\utility::get_linked_ents();
  GscBinSkip0(0x2e, var_6.size, var_1);
}

function get_door_dependencies() {
  if(isDefined(self.script_type)) {
    var_0 = get_model_dependencies();
  } else {
    var_0 = get_brushmodel_dependencies();
  }

  return var_0;
}

function get_model_dependencies() {
  var_0 = [];
  GscBinSkip0(0x2e, 1, [0, 2, 3, 6]);
}

function get_brushmodel_dependencies() {
  var_0 = [];
  GscBinSkip0(0x2e, 1, [0, 2, 3, 6]);
}

function is_heirarchy_good() {
  self.heirarchytest = 1;

  foreach(var_1 in self.depends) {
    if(var_1.script_index == 0) {
      self notify("stop_heirarchy_line");
      return true;
    }

    if(!isDefined(var_1.heirarchytest) && !var_1.destroyed) {
      if(is_heirarchy_good(var_1)) {
        self notify("stop_heirarchy_line");
        return true;
      }
    }
  }

  self notify("stop_heirarchy_line");
  return false;
}

function doline(var_0, var_1) {
  self endon("stop_heirarchy_line");

  for(;;) {
    waitframe();
  }
}

function update_depends(var_0) {
  if(isDefined(self.depends)) {
    self.depends = scripts\engine\utility::array_removeundefined(self.depends);
  }

  self.updatedepends = scripts\engine\utility::array_removeundefined(self.updatedepends);

  foreach(var_2 in self.updatedepends) {
    if(var_2.destroyed) {
      continue;
    }

    var_2.depends = scripts\engine\utility::array_remove(var_2.depends, self);

    if(!is_heirarchy_good(var_2)) {
      self.updatedepends = scripts\engine\utility::array_remove(self.updatedepends, var_2);

      if(isDefined(self.doordamagemod)) {
        var_2 notify("damage", 90, undefined, var_0, self.doordamagepoint, self.doordamagemod);
      } else {
        var_2 notify("damage", 90, undefined, var_0, undefined, "scripted");
      }
    }

    foreach(var_2 in self.mainpiece.allpieces) {
      var_2.heirarchytest = undefined;
    }
  }
}

function destructible_ignore_attacker(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(self.mainpiece.parent.damgeignoreents)) {
    foreach(var_2 in self.mainpiece.parent.damgeignoreents) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(var_0 == var_2) {
        return true;
      }
    }
  }

  return false;
}

function destructible_piece_thread() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  while(self.health > 0) {
    self waittill("damage", var_4, var_3, var_1, var_0, var_2, var_5, var_6, var_7, var_8, var_9);

    if(destructible_ignore_attacker(var_3) || should_ignore_mod(var_2)) {
      self.maxhealth = 0;
      self.health += var_4;
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
        self.health += var_4;
      } else if(var_2 == "scripted") {
        break;
      }
    }

    if(self.script_index > 0) {
      var_10 = self.origin + var_1 * -1 * 100;

      if(!isDefined(var_2)) {
        if(!isDefined(var_3)) {
          self.mainpiece scripts\sp\utility::do_damage(var_4, var_10);
        } else {
          self.mainpiece scripts\sp\utility::do_damage(var_4, var_10, var_3, var_3);
        }
      } else if(var_2 != "scripted") {
        self.mainpiece scripts\sp\utility::do_damage(var_4, var_10, var_3, var_3, var_2);
      }
    }

    self.doordamagepoint = undefined;
    self.doordamagemod = undefined;
  }

  if(isDefined(self.mainpiece)) {
    var_11 = self.mainpiece;
  } else {
    var_11 = self;
  }

  if(isDefined(var_11.parent.clip_nosight)) {
    var_11.parent.clip_nosight delete();
  }

  var_11.parent notify("piece_destroyed", self);
  self.destroyed = 1;
  update_depends(var_2);

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_12 = vectortoangles(self.mainpiece.parent.forward);
  var_13 = anglestoright(var_12);
  var_14 = vectorNormalize(var_1 - self.origin);
  var_15 = vectordot(var_13, var_14);
  var_2 = var_13;

  if(var_15 > 0) {
    var_2 *= -1;
  }

  self unlink();

  if(isDefined(var_4) && isPlayer(var_4)) {
    var_2 *= -1;
  }

  if(istrue(self.hashandle) && !istrue(self.ignore_bullets)) {
    var_16 = spawnStruct();
    var_16.origin = self.origin + var_2 * 32;
    self.mainpiece.parent.ajar_opener = var_16;
    self.mainpiece.parent.nohint = 1;
    self.mainpiece.parent notify("first_interact");
    self.mainpiece.parent.open_struct scripts\sp\door::remove_open_interact_hint();
  }

  if(self.code_classname == "script_brushmodel") {
    var_17 = randomintrange(300, 600);
    self.origin += var_2 * 3;
  } else {
    var_17 = randomintrange(50, 150);
  }

  waitframe();

  if(isDefined(var_4) && var_4 == "explosive") {
    self physicslaunchclient(var_2, var_3 * var_17 * 0.5);
  } else {
    self physicslaunchclient(var_2, var_3 * var_17);
  }

  if(self.script_index == 0) {
    self.parent notify("unusable");
    self.parent scripts\sp\door::clear_navobstacle();
    level.interactive_doors.ents = scripts\engine\utility::array_remove(level.interactive_doors.ents, self.parent);

    if(isDefined(self.parent.pivot_ent)) {
      self.parent.pivot_ent delete();
    }

    if(isDefined(self.parent.clip_nosight)) {
      self.parent.clip_nosight delete();
    }

    self.parent delete();
  }

  wait 5;
  self delete();
}

function door_damage_scale(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(var_2 != "MOD_MELEE") {
      if(var_1.classname == "spread") {
        var_0 *= 1.36;
      }
    }
  }

  return int(var_0);
}

function should_ignore_mod(var_0) {
  if(istrue(self.ignore_bullets)) {
    switch (var_0) {
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        return true;
      default:
        return false;
    }
  } else if(istrue(self.mainpiece.parent.ignore_grenades)) {
    switch (var_0) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_EXPLOSIVE":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function scriptable_init() {
  self.destructible = 1;

  if(self.classname == "scriptable_door_wooden_hollow_rl_01") {
    self.parthealth = 90;
  }

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

function scriptable_inherit_parameters() {
  var_0 = scripts\engine\utility::get_linked_structs();
  var_1 = var_0[0];
  self.script_parameters = var_1.script_parameters;
  self.script_max_left_angle = var_1.script_max_left_angle;
  self.script_max_right_angle = var_1.script_max_right_angle;
}

function scriptable_parts_init() {
  self.parts = [];
  self.part_main = scriptable_part_struct(0);
  self.part_main.health = 2200;
  self.parts_map = get_scriptable_map();

  for(var_0 = 1; var_0 < 31; var_0++) {
    var_1 = scriptable_part_struct(var_0);

    if(var_0 == 1) {
      var_1.ishandle = 1;
    }

    self.parts[var_1.full_partname] = var_1;
  }
}

function scriptable_part_struct(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(self.parthealth)) {
    var_2.health = self.parthealth;
  } else {
    var_2.health = 150;
  }

  var_2.partindex = var_0;

  if(var_0 > 0) {
    var_2.full_partname = scriptable_get_full_partname(var_0);
  }

  var_2.destroyed = 0;
  return var_2;
}

function scriptable_damage_thread() {
  self.ispristine = 1;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    scriptable_damage_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

function scriptable_damage_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!self.ispristine) {
    if(is_explosive_damage(var_4, var_9)) {
      scriptable_explosive_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
      return;
    }

    thread scriptable_gun_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    return;
  }

  self.ispristine = 0;
  self setscriptablepartstate("main", "initial_dmg");

  if(isDefined(self.fndamage)) {
    [[self.fndamage]](0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(is_explosive_damage(var_4, var_9)) {
    thread scriptable_explosive_damage_framedelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    return;
  }
}

function is_explosive_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(var_1.basename == "flash" || var_1.basename == "molotov") {
      return false;
    }
  }

  if(!isDefined(var_0)) {
    return false;
  }

  switch (var_0) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_EXPLOSIVE":
      return true;
  }

  return false;
}

function scriptable_explosive_damage_framedelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  waitframe();
  scriptable_explosive_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function scriptable_explosive_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scriptable_ignore_attacker(var_1) || scriptable_ignore_mod(var_4)) {
    self.maxhealth = 0;
    self.health += var_0;
    return;
  }

  var_10 = [];

  foreach(var_12 in self.parts) {
    var_10 = var_12;
  }

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

function scriptable_gun_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scriptable_ignore_attacker(var_1) || scriptable_ignore_mod(var_4)) {
    self.maxhealth = 0;
    self.health += var_0;
    return;
  }

  var_0 = door_damage_scale(var_0, var_9, var_4);

  if(isDefined(self.fndamage)) {
    [[self.fndamage]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(self.parts[var_7])) {
    var_10 = self.parts[var_7];
    var_10.health -= var_0;

    if(var_10.health <= 0 || var_4 == "scripted") {
      scriptable_destroy_part(var_10.partindex, var_10, var_4, var_2, var_3, var_1);
      return;
    }

    return;
  }
}

function scriptable_ignore_attacker(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(self.damgeignoreents)) {
    foreach(var_2 in self.damgeignoreents) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(var_0 == var_2) {
        return true;
      }
    }
  }

  return false;
}

function scriptable_ignore_mod(var_0) {
  if(istrue(self.ignore_bullets)) {
    switch (var_0) {
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        return true;
      default:
        return false;
    }
  } else if(istrue(self.ignore_grenades)) {
    switch (var_0) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_EXPLOSIVE":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function get_fx_direction(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  var_1 = vectortoangles(self.forward);
  var_2 = anglestoright(var_1);
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_2, var_3);
  self.prevplayeronright = self.playeronright;

  if(var_4 > 0) {
    return 1;
  }

  return 0;
}

function scriptable_destroy_part(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 = "" + var_0;
  var_1.destroyed = 1;
  scriptable_update_map(var_1.partindex, var_0, var_4);

  if(isDefined(self.clip_nosight)) {
    self.clip_nosight delete();
  }

  var_7 = get_fx_direction(var_4);

  if(isPlayer(var_5)) {
    var_7 = !var_7;
  }

  if(var_7) {
    self setscriptablepartstate(var_0, "hide");
  } else {
    self setscriptablepartstate(var_0, "hide_minus");
  }

  if(isDefined(var_1.ishandle)) {
    var_8 = spawnStruct();
    var_8.origin = self.origin + var_3 * -32;
    self.ajar_opener = var_8;
    self.nohint = 1;
    self notify("first_interact");
    self.open_struct scripts\sp\door::remove_open_interact_hint();
    return;
  }
}

function scriptable_update_map(var_0, var_1, var_2) {
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
      if(isDefined(self.doordamagemod)) {
        thread scriptable_gun_damage(90, undefined, var_1, self.doordamagepoint, self.doordamagemod, undefined, undefined, var_6.full_partname);
      } else {
        thread scriptable_gun_damage(90, undefined, var_1, var_2, "scripted", undefined, undefined, var_6.full_partname);
      }
    }

    foreach(var_8 in self.parts) {
      var_8.heirarchytest = undefined;
    }
  }
}

function scriptable_get_full_partname(var_0) {
  if(var_0 < 10) {
    var_1 = "0" + var_0;
  } else {
    var_1 = var_1;
  }

  return "tag_geo_frag_a_0" + var_1;
}

function scriptable_get_part_by_index(var_0) {
  return self.parts[scriptable_get_full_partname(var_0)];
}

function is_scriptable_heirarchy_good(var_0) {
  var_0.heirarchytest = 1;

  if(!isDefined(self.parts_map[var_0.partindex])) {
    return true;
  }

  var_1 = self.parts_map[var_0.partindex];

  foreach(var_3 in var_1) {
    if(var_3 == 0) {
      return true;
    }

    var_4 = scriptable_get_part_by_index(var_3);

    if(!isDefined(var_4.heirarchytest) && !var_4.destroyed) {
      if(is_scriptable_heirarchy_good(var_4)) {
        return true;
      }
    }
  }

  return false;
}

function get_scriptable_map() {
  var_0 = [];

  if(self.classname == "scriptable_door_wooden_hollow_rl_01") {
    return get_prototype_scriptable_map();
  }

  GscBinSkip0(0x2e, 1, [0, 11]);
}

function get_prototype_scriptable_map() {
  var_0 = [];
  GscBinSkip0(0x2e, 1, [0, 13, 18]);
}

function scriptable_get_part_origin(var_0) {
  if(var_0.partindex == 0) {
    var_1 = "tag_origin";
  } else {
    var_1 = var_1.full_partname;
  }

  return self gettagorigin(var_1);
}
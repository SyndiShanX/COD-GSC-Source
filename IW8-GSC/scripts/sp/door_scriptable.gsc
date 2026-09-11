/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\door_scriptable.gsc
***********************************************/

function init_destructible() {
  if(!isDefined(self.script_destructible)) {
    return;
  }

  self.destructible = 1;
  var0 = scripts\engine\utility::get_linked_ents();
  var1 = undefined;

  foreach(var3 in var0) {
    if(var3.code_classname == "script_brushmodel" && !var3 scripts\sp\door_internal::is_clip_nosight()) {
      var1 = var3;
      break;
    }

    if(isDefined(var3.script_index) && var3.script_index == 0) {
      var1 = var3;
      break;
    }
  }

  var5 = get_door_dependencies();
  var1.parent = self;
  var1 linkTo(self);
  var1.script_index = 0;
  var6 = var1 scripts\engine\utility::get_linked_ents();
  GscBinSkip0(0x2e, var6.size, var1);
}

function get_door_dependencies() {
  if(isDefined(self.script_type)) {
    var0 = get_model_dependencies();
  } else {
    var0 = get_brushmodel_dependencies();
  }

  return var0;
}

function get_model_dependencies() {
  var0 = [];
  GscBinSkip0(0x2e, 1, [0, 2, 3, 6]);
}

function get_brushmodel_dependencies() {
  var0 = [];
  GscBinSkip0(0x2e, 1, [0, 2, 3, 6]);
}

function is_heirarchy_good() {
  self.heirarchytest = 1;

  foreach(var1 in self.depends) {
    if(var1.script_index == 0) {
      self notify("stop_heirarchy_line");
      return true;
    }

    if(!isDefined(var1.heirarchytest) && !var1.destroyed) {
      if(is_heirarchy_good(var1)) {
        self notify("stop_heirarchy_line");
        return true;
      }
    }
  }

  self notify("stop_heirarchy_line");
  return false;
}

function doline(var0, var1) {
  self endon("stop_heirarchy_line");

  for(;;) {
    waitframe();
  }
}

function update_depends(var0) {
  if(isDefined(self.depends)) {
    self.depends = scripts\engine\utility::array_removeundefined(self.depends);
  }

  self.updatedepends = scripts\engine\utility::array_removeundefined(self.updatedepends);

  foreach(var2 in self.updatedepends) {
    if(var2.destroyed) {
      continue;
    }

    var2.depends = scripts\engine\utility::array_remove(var2.depends, self);

    if(!is_heirarchy_good(var2)) {
      self.updatedepends = scripts\engine\utility::array_remove(self.updatedepends, var2);

      if(isDefined(self.doordamagemod)) {
        var2 notify("damage", 90, undefined, var0, self.doordamagepoint, self.doordamagemod);
      } else {
        var2 notify("damage", 90, undefined, var0, undefined, "scripted");
      }
    }

    foreach(var2 in self.mainpiece.allpieces) {
      var2.heirarchytest = undefined;
    }
  }
}

function destructible_ignore_attacker(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(self.mainpiece.parent.damgeignoreents)) {
    foreach(var2 in self.mainpiece.parent.damgeignoreents) {
      if(!isDefined(var2)) {
        continue;
      }

      if(var0 == var2) {
        return true;
      }
    }
  }

  return false;
}

function destructible_piece_thread() {
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  while(self.health > 0) {
    self waittill("damage", var4, var3, var1, var0, var2, var5, var6, var7, var8, var9);

    if(destructible_ignore_attacker(var3) || should_ignore_mod(var2)) {
      self.maxhealth = 0;
      self.health += var4;
      continue;
    }

    var4 = door_damage_scale(var4, var9, var2);

    if(isDefined(var2)) {
      if(var2 == "MOD_GRENADE" || var2 == "MOD_GRENADE_SPLASH") {
        self.doordamagemod = var2;
        self.doordamagepoint = var0;

        if(self.script_index == 0 && var4 > 100) {
          break;
        }

        var1 = vectorNormalize(self.origin - var0);

        if(self.health < var4 * 3) {
          break;
        }
      } else if(var2 == "MOD_MELEE") {
        self.maxhealth = 0;
        self.health += var4;
      } else if(var2 == "scripted") {
        break;
      }
    }

    if(self.script_index > 0) {
      var10 = self.origin + var1 * -1 * 100;

      if(!isDefined(var2)) {
        if(!isDefined(var3)) {
          self.mainpiece scripts\sp\utility::do_damage(var4, var10);
        } else {
          self.mainpiece scripts\sp\utility::do_damage(var4, var10, var3, var3);
        }
      } else if(var2 != "scripted") {
        self.mainpiece scripts\sp\utility::do_damage(var4, var10, var3, var3, var2);
      }
    }

    self.doordamagepoint = undefined;
    self.doordamagemod = undefined;
  }

  if(isDefined(self.mainpiece)) {
    var11 = self.mainpiece;
  } else {
    var11 = self;
  }

  if(isDefined(var11.parent.clip_nosight)) {
    var11.parent.clip_nosight delete();
  }

  var11.parent notify("piece_destroyed", self);
  self.destroyed = 1;
  update_depends(var2);

  if(!isDefined(var1)) {
    var1 = self.origin;
  }

  var12 = vectortoangles(self.mainpiece.parent.forward);
  var13 = anglestoright(var12);
  var14 = vectorNormalize(var1 - self.origin);
  var15 = vectordot(var13, var14);
  var2 = var13;

  if(var15 > 0) {
    var2 *= -1;
  }

  self unlink();

  if(isDefined(var4) && isPlayer(var4)) {
    var2 *= -1;
  }

  if(istrue(self.hashandle) && !istrue(self.ignore_bullets)) {
    var16 = spawnStruct();
    var16.origin = self.origin + var2 * 32;
    self.mainpiece.parent.ajar_opener = var16;
    self.mainpiece.parent.nohint = 1;
    self.mainpiece.parent notify("first_interact");
    self.mainpiece.parent.open_struct scripts\sp\door::remove_open_interact_hint();
  }

  if(self.code_classname == "script_brushmodel") {
    var17 = randomintrange(300, 600);
    self.origin += var2 * 3;
  } else {
    var17 = randomintrange(50, 150);
  }

  waitframe();

  if(isDefined(var4) && var4 == "explosive") {
    self physicslaunchclient(var2, var3 * var17 * 0.5);
  } else {
    self physicslaunchclient(var2, var3 * var17);
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

function door_damage_scale(var0, var1, var2) {
  if(isDefined(var1)) {
    if(var2 != "MOD_MELEE") {
      if(var1.classname == "spread") {
        var0 *= 1.36;
      }
    }
  }

  return int(var0);
}

function should_ignore_mod(var0) {
  if(istrue(self.ignore_bullets)) {
    switch (var0) {
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        return true;
      default:
        return false;
    }
  } else if(istrue(self.mainpiece.parent.ignore_grenades)) {
    switch (var0) {
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
  var0 = scripts\engine\utility::get_linked_structs();
  var1 = var0[0];
  self.script_parameters = var1.script_parameters;
  self.script_max_left_angle = var1.script_max_left_angle;
  self.script_max_right_angle = var1.script_max_right_angle;
}

function scriptable_parts_init() {
  self.parts = [];
  self.part_main = scriptable_part_struct(0);
  self.part_main.health = 2200;
  self.parts_map = get_scriptable_map();

  for(var0 = 1; var0 < 31; var0++) {
    var1 = scriptable_part_struct(var0);

    if(var0 == 1) {
      var1.ishandle = 1;
    }

    self.parts[var1.full_partname] = var1;
  }
}

function scriptable_part_struct(var0, var1) {
  var2 = spawnStruct();

  if(isDefined(self.parthealth)) {
    var2.health = self.parthealth;
  } else {
    var2.health = 150;
  }

  var2.partindex = var0;

  if(var0 > 0) {
    var2.full_partname = scriptable_get_full_partname(var0);
  }

  var2.destroyed = 0;
  return var2;
}

function scriptable_damage_thread() {
  self.ispristine = 1;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    scriptable_damage_proc(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
  }
}

function scriptable_damage_proc(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!self.ispristine) {
    if(is_explosive_damage(var4, var9)) {
      scriptable_explosive_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
      return;
    }

    thread scriptable_gun_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    return;
  }

  self.ispristine = 0;
  self setscriptablepartstate("main", "initial_dmg");

  if(isDefined(self.fndamage)) {
    [[self.fndamage]](0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
  }

  if(is_explosive_damage(var4, var9)) {
    thread scriptable_explosive_damage_framedelay(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    return;
  }
}

function is_explosive_damage(var0, var1) {
  if(isDefined(var1)) {
    if(var1.basename == "flash" || var1.basename == "molotov") {
      return false;
    }
  }

  if(!isDefined(var0)) {
    return false;
  }

  switch (var0) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_EXPLOSIVE":
      return true;
  }

  return false;
}

function scriptable_explosive_damage_framedelay(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  waitframe();
  scriptable_explosive_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function scriptable_explosive_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scriptable_ignore_attacker(var1) || scriptable_ignore_mod(var4)) {
    self.maxhealth = 0;
    self.health += var0;
    return;
  }

  var10 = [];

  foreach(var12 in self.parts) {
    var10 = var12;
  }

  var10 = scripts\engine\utility::array_randomize(var10);
  var14 = var0 / 400;
  var15 = int(var10.size * var14);

  foreach(var12 in var10) {
    if(!isDefined(var12.full_partname)) {
      continue;
    }

    if(var12.destroyed) {
      continue;
    }

    thread scriptable_gun_damage(90, undefined, var2, var3, "scripted", undefined, undefined, var12.full_partname);
    var15--;

    if(var15 == 0) {
      break;
    }
  }
}

function scriptable_gun_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scriptable_ignore_attacker(var1) || scriptable_ignore_mod(var4)) {
    self.maxhealth = 0;
    self.health += var0;
    return;
  }

  var0 = door_damage_scale(var0, var9, var4);

  if(isDefined(self.fndamage)) {
    [[self.fndamage]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
  }

  if(isDefined(self.parts[var7])) {
    var10 = self.parts[var7];
    var10.health -= var0;

    if(var10.health <= 0 || var4 == "scripted") {
      scriptable_destroy_part(var10.partindex, var10, var4, var2, var3, var1);
      return;
    }

    return;
  }
}

function scriptable_ignore_attacker(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(self.damgeignoreents)) {
    foreach(var2 in self.damgeignoreents) {
      if(!isDefined(var2)) {
        continue;
      }

      if(var0 == var2) {
        return true;
      }
    }
  }

  return false;
}

function scriptable_ignore_mod(var0) {
  if(istrue(self.ignore_bullets)) {
    switch (var0) {
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        return true;
      default:
        return false;
    }
  } else if(istrue(self.ignore_grenades)) {
    switch (var0) {
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

function get_fx_direction(var0) {
  if(!isDefined(var0)) {
    return 1;
  }

  var1 = vectortoangles(self.forward);
  var2 = anglestoright(var1);
  var3 = vectorNormalize(var0 - self.origin);
  var4 = vectordot(var2, var3);
  self.prevplayeronright = self.playeronright;

  if(var4 > 0) {
    return 1;
  }

  return 0;
}

function scriptable_destroy_part(var0, var1, var2, var3, var4, var5) {
  var0 = "" + var0;
  var1.destroyed = 1;
  scriptable_update_map(var1.partindex, var0, var4);

  if(isDefined(self.clip_nosight)) {
    self.clip_nosight delete();
  }

  var7 = get_fx_direction(var4);

  if(isPlayer(var5)) {
    var7 = !var7;
  }

  if(var7) {
    self setscriptablepartstate(var0, "hide");
  } else {
    self setscriptablepartstate(var0, "hide_minus");
  }

  if(isDefined(var1.ishandle)) {
    var8 = spawnStruct();
    var8.origin = self.origin + var3 * -32;
    self.ajar_opener = var8;
    self.nohint = 1;
    self notify("first_interact");
    self.open_struct scripts\sp\door::remove_open_interact_hint();
    return;
  }
}

function scriptable_update_map(var0, var1, var2) {
  if(!isDefined(self.parts_map[var0])) {
    return;
  }

  var3 = self.parts_map[var0];

  foreach(var5 in var3) {
    if(var5 == 0) {
      continue;
    }

    var6 = scriptable_get_part_by_index(var5);

    if(var6.destroyed) {
      continue;
    }

    if(!is_scriptable_heirarchy_good(var6)) {
      if(isDefined(self.doordamagemod)) {
        thread scriptable_gun_damage(90, undefined, var1, self.doordamagepoint, self.doordamagemod, undefined, undefined, var6.full_partname);
      } else {
        thread scriptable_gun_damage(90, undefined, var1, var2, "scripted", undefined, undefined, var6.full_partname);
      }
    }

    foreach(var8 in self.parts) {
      var8.heirarchytest = undefined;
    }
  }
}

function scriptable_get_full_partname(var0) {
  if(var0 < 10) {
    var1 = "0" + var0;
  } else {
    var1 = var1;
  }

  return "tag_geo_frag_a_0" + var1;
}

function scriptable_get_part_by_index(var0) {
  return self.parts[scriptable_get_full_partname(var0)];
}

function is_scriptable_heirarchy_good(var0) {
  var0.heirarchytest = 1;

  if(!isDefined(self.parts_map[var0.partindex])) {
    return true;
  }

  var1 = self.parts_map[var0.partindex];

  foreach(var3 in var1) {
    if(var3 == 0) {
      return true;
    }

    var4 = scriptable_get_part_by_index(var3);

    if(!isDefined(var4.heirarchytest) && !var4.destroyed) {
      if(is_scriptable_heirarchy_good(var4)) {
        return true;
      }
    }
  }

  return false;
}

function get_scriptable_map() {
  var0 = [];

  if(self.classname == "scriptable_door_wooden_hollow_rl_01") {
    return get_prototype_scriptable_map();
  }

  GscBinSkip0(0x2e, 1, [0, 11]);
}

function get_prototype_scriptable_map() {
  var0 = [];
  GscBinSkip0(0x2e, 1, [0, 13, 18]);
}

function scriptable_get_part_origin(var0) {
  if(var0.partindex == 0) {
    var1 = "tag_origin";
  } else {
    var1 = var1.full_partname;
  }

  return self gettagorigin(var1);
}
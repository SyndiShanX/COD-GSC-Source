/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\door_scriptable.gsc
******************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\utility;
#namespace door_scriptable;

function init_destructible() {
  if(!isDefined(self.script_destructible)) {
    return;
  }

  self.destructible = 1;
  links = utility::get_linked_ents();
  mainpiece = undefined;

  foreach(ent in links) {
    if(ent.code_classname == "\x98R*{\x04\xf0G?a\x8d\x94a)T\v\xa8\xac" && !ent door_internal::is_clip_nosight()) {
      mainpiece = ent;
      break;
    }

    if(isDefined(ent.script_index) && ent.script_index == 0) {
      mainpiece = ent;
      break;
    }
  }

  var_a80a20f45ea99c52 = get_door_dependencies();
  mainpiece.parent = self;
  mainpiece linkTo(self);
  mainpiece.script_index = 0;
  ents = mainpiece utility::get_linked_ents();
  ents[ents.size] = mainpiece;
  mainpiece.allpieces = ents;
  self.pieces = utility_sp::array_index_by_script_index(ents);

  foreach(ent in self.pieces) {
    ent.health = 200;
    ent setCanDamage(1);
    ent linkTo(self);
    ent.destroyed = 0;
    ent.mainpiece = mainpiece;

    if(isDefined(ent.script_type)) {
      if(ent.script_type == "4\x85\x9b\x91l\xca") {
        ent.hashandle = 1;

        if(isDefined(self.no_handle_ajar)) {
          ent.ignore_bullets = self.no_handle_ajar;
        }
      }
    }

    if(ent.script_index == 0) {
      ent.start_health = 2200;
      ent.health = ent.start_health;
    } else if(ent.script_index > 0) {
      ent.depends = [];

      foreach(var_8ab403a22ad158f8 in var_a80a20f45ea99c52[ent.script_index]) {
        foreach(temp in self.pieces) {
          if(temp.script_index == var_8ab403a22ad158f8) {
            ent.depends[ent.depends.size] = temp;

            if(!isDefined(temp.updatedepends)) {
              temp.updatedepends = [];
            }

            temp.updatedepends[temp.updatedepends.size] = ent;
          }
        }
      }
    }

    ent thread destructible_piece_thread();
  }
}

function get_door_dependencies() {
  if(isDefined(self.script_type)) {
    var_a80a20f45ea99c52 = get_model_dependencies();
  } else {
    var_a80a20f45ea99c52 = get_brushmodel_dependencies();
  }

  return var_a80a20f45ea99c52;
}

function get_model_dependencies() {
  var_a80a20f45ea99c52 = [];
  var_a80a20f45ea99c52[1] = [0, 2, 3, 6];
  var_a80a20f45ea99c52[2] = [1, 3, 6, 7, 8];
  var_a80a20f45ea99c52[3] = [2, 4, 8];
  var_a80a20f45ea99c52[4] = [3, 8, 9];
  var_a80a20f45ea99c52[5] = [0, 1, 6, 10];
  var_a80a20f45ea99c52[6] = [1, 2, 5, 7, 11, 12];
  var_a80a20f45ea99c52[7] = [2, 6, 8, 12];
  var_a80a20f45ea99c52[8] = [2, 3, 4, 7, 9, 12, 13, 14];
  var_a80a20f45ea99c52[9] = [4, 8, 14, 21];
  var_a80a20f45ea99c52[10] = [0, 5, 11, 15];
  var_a80a20f45ea99c52[11] = [6, 10, 12, 16, 17];
  var_a80a20f45ea99c52[12] = [6, 7, 8, 11, 13, 18, 19];
  var_a80a20f45ea99c52[13] = [8, 12, 14, 19, 20];
  var_a80a20f45ea99c52[14] = [8, 9, 13, 20, 21];
  var_a80a20f45ea99c52[15] = [0, 10, 22, 17];
  var_a80a20f45ea99c52[16] = [11, 15, 16, 22, 23];
  var_a80a20f45ea99c52[17] = [11, 12, 16, 18, 23];
  var_a80a20f45ea99c52[18] = [12, 13, 17, 19, 23, 24];
  var_a80a20f45ea99c52[19] = [13, 18, 20, 24];
  var_a80a20f45ea99c52[20] = [13, 14, 19, 21, 24, 25];
  var_a80a20f45ea99c52[21] = [14, 20, 25];
  var_a80a20f45ea99c52[22] = [0, 15, 16, 23];
  var_a80a20f45ea99c52[23] = [18, 19, 20, 22, 25];
  var_a80a20f45ea99c52[24] = [18, 20, 23, 25];
  var_a80a20f45ea99c52[25] = [20, 21, 24];
  return var_a80a20f45ea99c52;
}

function get_brushmodel_dependencies() {
  var_a80a20f45ea99c52 = [];
  var_a80a20f45ea99c52[1] = [0, 2, 3, 6];
  var_a80a20f45ea99c52[2] = [1, 3, 6, 7, 8];
  var_a80a20f45ea99c52[3] = [2, 4, 8];
  var_a80a20f45ea99c52[4] = [3, 8, 9];
  var_a80a20f45ea99c52[5] = [0, 1, 6, 10];
  var_a80a20f45ea99c52[6] = [1, 2, 5, 7, 11, 12];
  var_a80a20f45ea99c52[7] = [2, 6, 8, 12];
  var_a80a20f45ea99c52[8] = [2, 3, 4, 7, 9, 12, 13, 14];
  var_a80a20f45ea99c52[9] = [4, 8, 14, 22];
  var_a80a20f45ea99c52[10] = [0, 5, 11, 15];
  var_a80a20f45ea99c52[11] = [6, 10, 12, 16, 17];
  var_a80a20f45ea99c52[12] = [6, 7, 8, 11, 13, 18, 19];
  var_a80a20f45ea99c52[13] = [8, 12, 14, 20, 21];
  var_a80a20f45ea99c52[14] = [8, 9, 13, 21, 22];
  var_a80a20f45ea99c52[15] = [0, 10, 23, 17];
  var_a80a20f45ea99c52[16] = [11, 15, 16, 23];
  var_a80a20f45ea99c52[17] = [11, 16, 18, 24];
  var_a80a20f45ea99c52[18] = [12, 17, 19, 24];
  var_a80a20f45ea99c52[19] = [12, 18, 20, 24];
  var_a80a20f45ea99c52[20] = [13, 19, 21, 25];
  var_a80a20f45ea99c52[21] = [13, 14, 20, 22, 25];
  var_a80a20f45ea99c52[22] = [14, 9, 21, 26];
  var_a80a20f45ea99c52[23] = [0, 15, 16, 24];
  var_a80a20f45ea99c52[24] = [16, 17, 18, 19, 23, 25];
  var_a80a20f45ea99c52[25] = [19, 20, 21, 24, 26];
  var_a80a20f45ea99c52[26] = [21, 22, 25];
  return var_a80a20f45ea99c52;
}

function is_heirarchy_good() {
  self.heirarchytest = 1;

  foreach(ent in self.depends) {
    if(ent.script_index == 0) {
      self notify("^\x164\xfd\xc1[\xa8r\xf4(\xd3\xce\xfaJ\xdc\xa5\xdc\x80M");
      return true;
    }

    if(!isDefined(ent.heirarchytest) && !ent.destroyed) {
      if(ent is_heirarchy_good()) {
        self notify("^\x164\xfd\xc1[\xa8r\xf4(\xd3\xce\xfaJ\xdc\xa5\xdc\x80M");
        return true;
      }
    }
  }

  self notify("^\x164\xfd\xc1[\xa8r\xf4(\xd3\xce\xfaJ\xdc\xa5\xdc\x80M");
  return false;
}

function doline(pos, pos2) {
  self endon("<dev string:x24>");

  while(true) {
    line(pos, pos2);
    waitframe();
  }
}

function update_depends(dir) {
  if(isDefined(self.depends)) {
    self.depends = utility::array_removeundefined(self.depends);
  }

  self.updatedepends = utility::array_removeundefined(self.updatedepends);

  foreach(ent in self.updatedepends) {
    if(ent.destroyed) {
      continue;
    }

    ent.depends = arrayremove(ent.depends, self);
    println("<dev string:x3b>" + ent getentitynumber());

    if(!ent is_heirarchy_good()) {
      self.updatedepends = arrayremove(self.updatedepends, ent);

      if(isDefined(self.doordamagemod)) {
        ent notify("\fU`\xc0y\x95", 90, undefined, dir, self.doordamagepoint, self.doordamagemod);
      } else {
        ent notify("\fU`\xc0y\x95", 90, undefined, dir, undefined, "\xb86gH\x1e;\xcfE");
      }
    }

    foreach(ent in self.mainpiece.allpieces) {
      ent.heirarchytest = undefined;
    }
  }
}

function function_5c3f0e32ff966a83() {
  if(getdvarint(@ "hash_6985e82f27803483") == 0) {
    return;
  }

  self endon("<dev string:x54>");

  while(true) {
    waitframe();
    print3d(self.origin, self.script_index + "<dev string:x65>" + self.health, (1, 1, 1), 1, 0.05);
  }
}

function destructible_ignore_attacker(attacker) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(isDefined(self.mainpiece.parent.damgeignoreents)) {
    foreach(ent in self.mainpiece.parent.damgeignoreents) {
      if(!isDefined(ent)) {
        continue;
      }

      if(attacker == ent) {
        return true;
      }
    }
  }

  return false;
}

function destructible_piece_thread() {
  thread function_5c3f0e32ff966a83();

  point = undefined;
  dir = undefined;
  mod = undefined;
  attacker = undefined;

  while(self.health > 0) {
    self waittill("\fU`\xc0y\x95", dmg, attacker, dir, point, mod, modelname, tagname, partname, idflags, weapobj);

    if(destructible_ignore_attacker(attacker) || should_ignore_mod(mod)) {
      self.maxhealth = 0;
      self.health += dmg;
      continue;
    }

    dmg = door_damage_scale(dmg, weapobj, mod);

    if(isDefined(mod)) {
      if(mod == "\x9az\x88\xfat)*\xe4\x14\x11\x15" || mod == "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a") {
        self.doordamagemod = mod;
        self.doordamagepoint = point;

        if(self.script_index == 0 && dmg > 100) {
          break;
        }

        dir = vectorNormalize(self.origin - point);

        if(self.health < dmg * 3) {
          break;
        }
      } else if(mod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
        self.maxhealth = 0;
        self.health += dmg;
      } else if(mod == "\xb86gH\x1e;\xcfE") {
        break;
      }
    }

    if(self.script_index > 0) {
      origin = self.origin + dir * -1 * 100;

      if(!isDefined(mod)) {
        if(!isDefined(attacker)) {
          self.mainpiece utility_sp::do_damage(dmg, origin);
        } else {
          self.mainpiece utility_sp::do_damage(dmg, origin, attacker, attacker);
        }
      } else if(mod != "\xb86gH\x1e;\xcfE") {
        self.mainpiece utility_sp::do_damage(dmg, origin, attacker, attacker, mod);
      }
    }

    self.doordamagepoint = undefined;
    self.doordamagemod = undefined;
  }

  if(isDefined(self.mainpiece)) {
    mainpiece = self.mainpiece;
  } else {
    mainpiece = self;
  }

  if(isDefined(mainpiece.parent.clip_nosight)) {
    mainpiece.parent.clip_nosight delete();
  }

  mainpiece.parent notify("\xf2M\x97tK\xd9\xc4\xcb:;\xc7A\x96\by", self);
  self.destroyed = 1;
  update_depends(dir);

  if(!isDefined(point)) {
    point = self.origin;
  }

  angles = vectortoangles(self.mainpiece.parent.forward);
  right = anglestoright(angles);
  normal = vectorNormalize(point - self.origin);
  dot = vectordot(right, normal);
  dir = right;

  if(dot > 0) {
    dir *= -1;
  }

  self unlink();

  if(isDefined(attacker) && isPlayer(attacker)) {
    dir *= -1;
  }

  if(istrue(self.hashandle) && !istrue(self.ignore_bullets)) {
    struct = spawnStruct();
    struct.origin = self.origin + dir * 32;
    self.mainpiece.parent.ajar_opener = struct;
    door_sp::unlock_door();
    self.mainpiece.parent.nohint = 1;
    self.mainpiece.parent notify("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
    self.mainpiece.parent.open_struct door_sp::remove_open_interact_hint();
  }

  if(self.code_classname == "\x98R*{\x04\xf0G?a\x8d\x94a)T\v\xa8\xac") {
    power = randomintrange(300, 600);
    self.origin += dir * 3;
  } else {
    power = randomintrange(50, 150);
  }

  waitframe();

  if(isDefined(mod) && mod == "g%\x0f\x95\xc3\xea\b\xae\xfd") {
    self physicslaunchclient(point, dir * power * 0.5);
  } else {
    self physicslaunchclient(point, dir * power);
  }

  if(getdvarint(@ "hash_6985e82f27803483") > 0) {
    line(self.origin, point, (1, 1, 1), 1, 0, 20);
  }

  if(self.script_index == 0) {
    self.parent notify("\x83\xa2\x0f\x16\b%>\xb0");
    self.parent door_sp::clear_navobstacle();
    level.interactive_doors.ents = arrayremove(level.interactive_doors.ents, self.parent);

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

function door_damage_scale(dmg, weapobj, mod) {
  if(isDefined(weapobj)) {
    if(mod != "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
      if(weapobj.classname == "\n\x1f+\x8dob") {
        dmg *= 1.36;
      }
    }
  }

  return int(dmg);
}

function should_ignore_mod(mod) {
  if(istrue(self.ignore_bullets)) {
    switch (mod) {
      case #"hash_5f1054c48d66fd1c":
      case #"hash_966768b3f0c94767":
        return true;
      default:
        return false;
    }
  } else if(istrue(self.mainpiece.parent.ignore_grenades)) {
    switch (mod) {
      case #"hash_66cb246f3e55fbe2":
      case #"hash_a911a1880d996edb":
      case #"hash_c22b13f81bed11f0":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function scriptable_init() {
  self.destructible = 1;
  scriptable_inherit_parameters();
  scriptable_parts_init();

  if(self.classname == "\xd6!3q\x89\xfb\x12r[`\xa1$\xce\x81%\xd0\v#e\xa2\xfa\xc9F\xbaNR\xc1RrI&A`\xda\xa0" && !isDefined(self.script_health)) {
    self.script_health = 90;
  }

  thread function_5c44eb08ce597f5a();

  self enablelinkTo();
  self.health = 200000;
  self.start_health = 200000;
  self setCanDamage(1);
  thread scriptable_damage_thread();
  door_internal::init_door_internal();
  level door_internal::global_door_threads();
}

function scriptable_inherit_parameters() {
  [struct] = utility::get_linked_structs();
  self.script_parameters = struct.script_parameters;
  self.script_max_left_angle = struct.script_max_left_angle;
  self.script_max_right_angle = struct.script_max_right_angle;
  self.script_side = struct.script_side;
  self.script_health = struct.script_health;
  self.script_spawn_open_yaw = struct.script_spawn_open_yaw;
}

function scriptable_parts_init() {
  self.parts = [];
  self.part_main = scriptable_part_struct(0);
  self.part_main.health = 2200;
  self.parts_map = get_scriptable_map();

  for(i = 1; i < 31; i++) {
    struct = scriptable_part_struct(i);

    if(i == 1) {
      struct.ishandle = 1;
    }

    self.parts[struct.full_partname] = struct;
  }
}

function scriptable_part_struct(partindex, partname) {
  part = spawnStruct();
  part.health = self.script_health ?? 150;
  part.partindex = partindex;

  if(partindex > 0) {
    part.full_partname = scriptable_get_full_partname(partindex);
  }

  part.destroyed = 0;
  return part;
}

function scriptable_damage_thread() {
  self.ispristine = 1;

  while(true) {
    self waittill("\fU`\xc0y\x95", dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
    scriptable_damage_proc(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
  }
}

function scriptable_damage_proc(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj) {
  if(!self.ispristine) {
    if(is_explosive_damage(mod, weapobj)) {
      scriptable_explosive_damage(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
    } else if(isDefined(mod) && mod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
      thread function_ddefec1711b938c2(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
    } else {
      thread scriptable_gun_damage(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
    }

    return;
  }

  self.ispristine = 0;
  self setscriptablepartstate("\xc1\xf0\x81\x9b", "{ \xf1\xb5\xd4\xf1|1\xe1\xf9\xe4");

  if(isDefined(self.fndamage)) {
    [[self.fndamage]](0, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
  }

  if(is_explosive_damage(mod, weapobj)) {
    thread scriptable_explosive_damage_framedelay(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
  }
}

function is_explosive_damage(mod, weaponobj) {
  if(isDefined(weaponobj)) {
    if(weaponobj.basename == "\xef\xd8\x94\x8d\xba" || weaponobj.basename == "\xb6\xbdc\xf6Gov") {
      return false;
    }
  }

  if(!isDefined(mod)) {
    return false;
  }

  switch (mod) {
    case #"hash_66cb246f3e55fbe2":
    case #"hash_a911a1880d996edb":
    case #"hash_c22b13f81bed11f0":
      return true;
  }

  return false;
}

function scriptable_explosive_damage_framedelay(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj) {
  waitframe();
  scriptable_explosive_damage(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
}

function scriptable_explosive_damage(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj) {
  if(scriptable_ignore_attacker(attacker) || scriptable_ignore_mod(mod)) {
    self.maxhealth = 0;
    self.health += dmg;
    return;
  }

  temparray = [];

  foreach(part in self.parts) {
    temparray[temparray.size] = part;
  }

  temparray = utility::array_randomize(temparray);
  scale = dmg / 400;
  count = int(temparray.size * scale);

  foreach(part in temparray) {
    if(!isDefined(part.full_partname)) {
      continue;
    }

    if(part.destroyed) {
      continue;
    }

    thread scriptable_gun_damage(90, undefined, dir, point, "\xb86gH\x1e;\xcfE", undefined, undefined, part.full_partname);
    count--;

    if(count == 0) {
      break;
    }
  }
}

function scriptable_gun_damage(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj) {
  if(scriptable_ignore_attacker(attacker) || scriptable_ignore_mod(mod)) {
    self.maxhealth = 0;
    self.health += dmg;
    return;
  }

  dmg = door_damage_scale(dmg, weapobj, mod);

  if(isDefined(self.fndamage)) {
    [[self.fndamage]](dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);
  }

  if(isDefined(self.parts[full_partname])) {
    part = self.parts[full_partname];
    part.health -= dmg;

    if(part.health <= 0 || mod == "\xb86gH\x1e;\xcfE") {
      scriptable_destroy_part(part.partindex, part, mod, dir, point, attacker);
    }

    return;
  }

  println("<dev string:x6b>");
}

function function_ddefec1711b938c2(dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj) {
  if(scriptable_ignore_attacker(attacker) || scriptable_ignore_mod(mod)) {
    self.maxhealth = 0;
    self.health += dmg;
    return;
  }

  if(!self.locked) {
    return;
  }

  if(!isPlayer(attacker)) {
    return;
  }

  traceend = attacker getEye() + anglesToForward(attacker getplayerangles()) * 50;
  trace = trace::ray_trace(attacker getEye(), traceend, attacker);
  point = trace["\xc1\xbd\xdci\xe8i{7"];
  array = [];
  mindist = squared(15);

  foreach(part in self.parts) {
    if(part.health <= 0) {
      continue;
    }

    part.tempdist = distancesquared(point, self gettagorigin(part.full_partname));

    if(part.tempdist > mindist) {
      continue;
    }

    if(array.size == 0) {
      array[0] = part;
      continue;
    }

    inserted = 0;

    for(j = 0; j < array.size; j++) {
      if(array[j].tempdist > part.tempdist) {
        array = utility::array_insert(array, part, j);
        inserted = 1;
        break;
      }
    }

    if(!inserted) {
      array[array.size] = part;
    }
  }

  if(array.size == 0) {
    return;
  }

  foreach(part in array) {
    part.tempdist = undefined;
  }

  closestpart = array[0];
  closestpart.health -= dmg;

  if(closestpart.health <= 0) {
    scriptable_destroy_part(closestpart.partindex, closestpart, mod, dir, point, attacker);
  }
}

function scriptable_ignore_attacker(attacker) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(isDefined(self.damgeignoreents)) {
    foreach(ent in self.damgeignoreents) {
      if(!isDefined(ent)) {
        continue;
      }

      if(attacker == ent) {
        return true;
      }
    }
  }

  return false;
}

function scriptable_ignore_mod(mod) {
  if(istrue(self.ignore_bullets)) {
    switch (mod) {
      case #"hash_5f1054c48d66fd1c":
      case #"hash_966768b3f0c94767":
        return true;
      default:
        return false;
    }
  } else if(istrue(self.ignore_grenades)) {
    switch (mod) {
      case #"hash_66cb246f3e55fbe2":
      case #"hash_a911a1880d996edb":
      case #"hash_c22b13f81bed11f0":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function get_fx_direction(point) {
  if(!isDefined(point)) {
    return 1;
  }

  angles = vectortoangles(self.forward);
  right = anglestoright(angles);
  normal = vectorNormalize(point - self.origin);
  dot = vectordot(right, normal);
  self.var_d85f7d65c5e146e5 = self.var_b73b304164eadad6;

  if(dot > 0) {
    return 1;
  }

  return 0;
}

function scriptable_destroy_part(partname, part, mod, dir, point, attacker) {
  partname = "" + partname;
  part.destroyed = 1;

  if(!self getscriptablehaspart(partname)) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      iprintlnbold("<dev string:x99>" + partname);
    }

    return;
  }

  if(getdvarint(@ "hash_6985e82f27803483") > 0 && isDefined(point)) {
    origin = scriptable_get_part_origin(part);
    line(origin, point, (1, 1, 1), 1, 0, 20);
  }

  scriptable_update_map(part.partindex, partname, point);

  if(isDefined(self.clip_nosight)) {
    self.clip_nosight delete();
  }

  var_8fe8b7e647b9af7c = get_fx_direction(point);

  if(isPlayer(attacker)) {
    var_8fe8b7e647b9af7c = !var_8fe8b7e647b9af7c;
  }

  if(var_8fe8b7e647b9af7c) {
    println("<dev string:xb6>" + self.doorid + "<dev string:xd6>" + partname + "<dev string:xe5>");
    self setscriptablepartstate(partname, "\x19b\xc2y");
  } else {
    println("<dev string:xb6>" + self.doorid + "<dev string:xd6>" + partname + "<dev string:xee>");
    self setscriptablepartstate(partname, "B\xc5\xa3\xa5c\xc8\xb2\x8f\xd6p");
  }

  if(isDefined(part.ishandle)) {
    struct = spawnStruct();
    struct.origin = self.origin + dir * -32;
    self.ajar_opener = struct;
    self.nohint = 1;
    self notify("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
    self.open_struct door_sp::remove_open_interact_hint();
  }

  if(self.locked) {
    destroyedcount = 0;

    foreach(part in self.parts) {
      if(part.health <= 0) {
        destroyedcount++;
      }
    }

    if(destroyedcount / self.parts.size > 0.6) {
      door_sp::unlock_door();
    }
  }
}

function scriptable_update_map(partindex, dir, point) {
  if(!isDefined(self.parts_map[partindex])) {
    return;
  }

  part_map = self.parts_map[partindex];

  foreach(index in part_map) {
    if(index == 0) {
      continue;
    }

    part = scriptable_get_part_by_index(index);

    if(part.destroyed) {
      continue;
    }

    if(!is_scriptable_heirarchy_good(part)) {
      if(isDefined(self.doordamagemod)) {
        thread scriptable_gun_damage(90, undefined, dir, self.doordamagepoint, self.doordamagemod, undefined, undefined, part.full_partname);
      } else {
        thread scriptable_gun_damage(90, undefined, dir, point, "\xb86gH\x1e;\xcfE", undefined, undefined, part.full_partname);
      }
    }

    foreach(p in self.parts) {
      p.heirarchytest = undefined;
    }
  }
}

function scriptable_get_full_partname(num) {
  if(num < 10) {
    tagnum = "\xfe" + num;
  } else {
    tagnum = num;
  }

  return "\xa8\xe2N\xa7\xe7U\xb0Hr\xe5\xf9\xf2\xf7\b\xae\xf0" + tagnum;
}

function scriptable_get_part_by_index(index) {
  return self.parts[scriptable_get_full_partname(index)];
}

function is_scriptable_heirarchy_good(part) {
  part.heirarchytest = 1;

  if(!isDefined(self.parts_map[part.partindex])) {
    return true;
  }

  part_map = self.parts_map[part.partindex];

  foreach(index in part_map) {
    if(index == 0) {
      return true;
    }

    test_part = scriptable_get_part_by_index(index);

    if(!isDefined(test_part.heirarchytest) && !test_part.destroyed) {
      if(is_scriptable_heirarchy_good(test_part)) {
        return true;
      }
    }
  }

  return false;
}

function get_scriptable_map() {
  map = [];

  if(self.classname == "\xd6!3q\x89\xfb\x12r[`\xa1$\xce\x81%\xd0\v#e\xa2\xfa\xc9F\xbaNR\xc1RrI&A`\xda\xa0") {
    return get_prototype_scriptable_map();
  }

  map[1] = [0, 11];
  map[2] = [0, 6];
  map[3] = [0, 6];
  map[4] = [0, 6];
  map[5] = [0, 6, 9];
  map[6] = [2, 3, 5, 7, 9];
  map[7] = [0, 6, 10];
  map[8] = [0, 9, 12];
  map[9] = [5, 6, 7, 12, 10];
  map[10] = [7, 9, 11, 12, 13];
  map[11] = [0, 1, 10, 13];
  map[12] = [8, 9, 10, 13, 15, 16];
  map[13] = [10, 11, 12, 14, 17, 18];
  map[14] = [0, 13];
  map[15] = [0, 12, 16, 19];
  map[16] = [12, 15, 17, 19, 20];
  map[17] = [13, 16, 20, 18];
  map[18] = [0, 13, 17, 20];
  map[19] = [15, 16, 20, 21, 22];
  map[20] = [16, 17, 18, 19, 23, 24];
  map[21] = [0, 19, 12, 22];
  map[22] = [19, 21, 23, 25, 26];
  map[23] = [20, 22, 24, 26, 27, 30];
  map[24] = [0, 20, 23];
  map[25] = [0, 22, 26];
  map[26] = [22, 23, 25, 28, 29, 30];
  map[27] = [0, 23];
  map[28] = [0, 26];
  map[29] = [0, 26];
  map[30] = [0, 23, 26];
  return map;
}

function get_prototype_scriptable_map() {
  map = [];
  map[1] = [0, 13, 18];
  map[2] = [0, 6];
  map[3] = [0, 6];
  map[4] = [0, 6];
  map[5] = [0, 6, 9];
  map[6] = [2, 3, 5, 7, 9];
  map[7] = [0, 6, 10];
  map[8] = [0, 9, 12];
  map[9] = [5, 6, 7, 8, 12, 10];
  map[10] = [7, 9, 11, 12, 13, 14];
  map[11] = [0, 10];
  map[12] = [8, 9, 10, 13, 15, 16];
  map[13] = [10, 11, 12, 14, 17, 18];
  map[14] = [0, 10, 13];
  map[15] = [0, 12, 16, 19];
  map[16] = [12, 15, 17, 19, 20];
  map[17] = [13, 16, 20, 18];
  map[18] = [0, 13, 17, 20];
  map[19] = [15, 16, 20, 21, 22];
  map[20] = [16, 17, 18, 19, 23, 24];
  map[21] = [0, 19, 12, 22];
  map[22] = [19, 21, 23, 25, 26];
  map[23] = [20, 22, 24, 26, 27, 30];
  map[24] = [0, 20, 23];
  map[25] = [0, 22, 26];
  map[26] = [22, 23, 25, 28, 29, 30];
  map[27] = [0, 23];
  map[28] = [0, 26];
  map[29] = [0, 26];
  map[30] = [0, 23, 26];
  return map;
}

function function_5c44eb08ce597f5a() {
  if(getdvarint(@ "hash_6985e82f27803483") == 0) {
    return;
  }

  prefix = "<dev string:xfd>";
  self endon("<dev string:x54>");

  while(true) {
    waitframe();
    print3d(self.origin + (0, 0, 50), "<dev string:x109>" + self getentitynumber(), (1, 1, 1), 1, 0.4);

    foreach(part in self.parts) {
      if(self.ispristine && part.partindex > 0) {
        continue;
      }

      if(getdvarint(@ "hash_6985e82f27803483") > 1) {
        start = level.player getEye();
        forward = anglesToForward(level.player getplayerangles());
        start += forward * 16;
        end = start + forward * 1000;
        trace = trace::ray_trace_detail(start, end);

        if(distancesquared(trace["<dev string:x116>"], scriptable_get_part_origin(part)) < 9) {
          function_4f2db9e871f5aa7a(part);
        }
      }

      origin = scriptable_get_part_origin(part);
      print3d(origin, part.partindex + "<dev string:x65>" + part.health, (1, 1, 1), 1, 0.05);
    }
  }
}

function function_4f2db9e871f5aa7a(part) {
  origin = scriptable_get_part_origin(part);
  print3d(origin, "<dev string:x122>", (0, 1, 1), 1, 0.05);
  part_map = self.parts_map[part.partindex];

  foreach(index in part_map) {
    if(index == 0) {
      line(origin, self.origin, (0, 1, 1), 0.75);
      continue;
    }

    temppart = scriptable_get_part_by_index(index);
    temporigin = scriptable_get_part_origin(temppart);
    line(origin, temporigin, (0, 1, 1));
  }
}

function scriptable_get_part_origin(part) {
  if(part.partindex == 0) {
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";
  } else {
    tag = part.full_partname;
  }

  return self gettagorigin(tag);
}
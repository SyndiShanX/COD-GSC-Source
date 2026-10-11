/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3455e18e022b7abc.gsc
*************************************************/

#using script_67055b3ff4918256;
#using script_6df6604a74a7a9c7;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_9499d190be9a2ad3;

function init(door, index) {
  index = default_to(index, 0);
  self.door = door;
  self.door namespace_b1453e6e8267c3ce::function_2cade2c182251141(self);

  if(isDefined(self.target)) {
    next_digit = getStruct(self.target, "targetname");
    next_digit init(self.door, index + 1);
  }
}

function digit_activate(should_activate, index) {
  if(should_activate) {
    thread digit_spawn(index);
    return;
  }

  thread digit_cleanup();
}

function digit_spawn(index) {
  angle_adjust = function_6ab8997a6d33d00d(index);
  self.plate = spawn_model(function_c3e078f287496cf7(index), self.origin, self.angles + angle_adjust);
  self.plate.index = index;
  forward = anglestoup(self.angles) * -1;
  self.scriptable = spawnscriptable("ob_combo_lock_entry", self.origin + forward * 1, self.plate.angles * -1);
  self.scriptable.digit_struct = self;
  self.scriptable.door = self.door;
  self.plate.scriptable = self.scriptable;
  self.spawned = 1;
}

function digit_link(should_link) {
  if(!isDefined(self.scriptable)) {
    return;
  }

  if(!istrue(should_link)) {
    current_state = self.scriptable getscriptablepartstate("vfx", 0);

    if(current_state != "unlinked") {
      self.scriptable setscriptablepartstate("model", current_state);
    }

    self.scriptable setscriptablepartstate("vfx", "unlinked");
    self.scriptable setscriptablepartstate("health", "damageable");
  }
}

function digit_lock(should_lock) {
  if(should_lock) {
    self.scriptable setscriptablepartstate("health", "inactive");
    return;
  }

  self.scriptable setscriptablepartstate("health", "damageable");
}

function digit_cleanup() {
  if(!isDefined(self.scriptable)) {
    return;
  }

  self.scriptable setscriptablepartstate("model", "inactive");
  self.scriptable setscriptablepartstate("vfx", "unlinked");
  self.scriptable setscriptablepartstate("health", "inactive");
  self.scriptable freescriptable();
  self.plate setscriptablepartstate("model", "inactive");
  self.spawned = 0;
}

function function_cdbec4722f88f614(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vhitloc, modelindex, partname) {
  if(!isDefined(instance) || instance.type != "ob_combo_lock_entry") {
    return;
  }

  if(einflictor.classname == "rocket" || einflictor.classname == "grenade") {
    if(distance(vhitloc, einflictor.origin) > 2) {
      instance setscriptablepartstate("health", "damageable");
      return;
    }
  }

  instance thread function_d94f8bea6e21780d(instance);
}

function function_d94f8bea6e21780d(instance) {
  state = instance getscriptablepartstate("model", 0);
  instance.door namespace_b1453e6e8267c3ce::function_3edb9b978dca8642(instance, state);
}

function function_25da66b947454d11(instance, note, param, instigator) {
  if(!isDefined(instance) || instance.type != "ob_combo_lock_flagstone" || !isDefined(instance.entity) || !isDefined(instance.entity.index)) {
    return;
  }

  instance.entity.scriptable setscriptablepartstate("model", string(instance.entity.index));
  instance.entity.scriptable setscriptablepartstate("vfx", "unlinked");
  instance.entity.scriptable setscriptablepartstate("health", "damageable");
}

function function_d44e5d38e3b8fb2c(instance, note, param, instigator) {
  if(!isDefined(instance) || instance.type != "ob_combo_lock_flagstone" || !isDefined(instance.entity)) {
    return;
  }

  thread function_8e0504fb64822985(instance.entity);
}

function function_8e0504fb64822985(ent) {
  waitframe();
  ent delete();
}

function function_c3e078f287496cf7(index) {
  switch (index) {
    case 1:
    case 2:
    case 6:
    case 7:
      return "ee_rune_flagstone_02_scr";
    default:
      return "ee_rune_flagstone_scr";
  }
}

function function_6ab8997a6d33d00d(index) {
  return (0, 0, 0);
}
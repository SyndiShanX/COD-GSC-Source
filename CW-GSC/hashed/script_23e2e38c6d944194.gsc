/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_23e2e38c6d944194.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\system_shared;
#namespace namespace_90310f6a;

function private autoexec __init__system__() {
  system::register(#"hash_727cd08e2b1432e6", &init, undefined, undefined, undefined);
}

function init() {
  thread function_32e330d();
}

function function_32e330d() {
  var_78856083 = getEntArray("male_mannequin_trigger", "targetname");

  foreach(trigger in var_78856083) {
    trigger thread function_c46b4b94();
  }

  var_2eec21b8 = getEntArray("female_mannequin_trigger", "targetname");

  foreach(trigger in var_2eec21b8) {
    trigger thread function_69e2587b();
  }

  var_83d5c6a0 = getEntArray("child_mannequin_trigger", "targetname");

  foreach(trigger in var_83d5c6a0) {
    trigger thread function_42a285bf();
  }
}

function function_c46b4b94() {
  self endon(#"entitydeleted", #"hash_27629c40b49f163c");
  self setCanDamage(1);
  self disconnectpaths();
  origin = self.origin;
  s_notify = self waittill(#"damage");
  level thread function_93b6095f(s_notify, origin);
  self connectpaths();
  self deletedelay();
}

function function_93b6095f(s_notify, origin) {
  n_outer_radius = 5;
  n_inner_radius = 1;
  var_67b43134 = 1;
  var_b6680570 = 5;
  var_a62ea1f = 10;
  var_947d01ee = s_notify.weapon.weapclass;
  var_18acfe18 = s_notify.amount;

  switch (var_947d01ee) {
    case # "pistol":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "rifle":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "mg":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "spread":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "smg":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "grenade":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "rocketlauncher":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "turret":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    default:
      n_magnitude = 0.01;
      break;
  }

  playFX("maps/cp_rus_amerika/fx9_impact_mannequin_sm", origin);
  snd::play("exp_facade_debris_mannequin", origin);
  radiusdamage(origin + (0, 0, -10), 5, 10, 3);
  radiusdamage(origin + (0, 0, -5), 5, 10, 3);
  radiusdamage(origin + (0, 0, 20), 5, 10, 3);
  radiusdamage(origin + (0, 0, 30), 5, 10, 3);
  physicsexplosionsphere(origin + (0, 0, -10), n_outer_radius, n_inner_radius, n_magnitude);
  physicsexplosionsphere(origin + (0, 0, 20), n_outer_radius, n_inner_radius, n_magnitude);
}

function function_69e2587b() {
  self endon(#"entitydeleted", #"hash_27629c40b49f163c");
  self setCanDamage(1);
  self disconnectpaths();
  origin = self.origin;
  s_notify = self waittill(#"damage");
  level thread function_83da8e07(s_notify, origin);
  self connectpaths();
  self deletedelay();
}

function function_83da8e07(s_notify, origin) {
  n_outer_radius = 4;
  n_inner_radius = 1;
  var_67b43134 = 1;
  var_b6680570 = 5;
  var_a62ea1f = 10;
  var_947d01ee = s_notify.weapon.weapclass;
  var_18acfe18 = s_notify.amount;

  switch (var_947d01ee) {
    case # "pistol":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "rifle":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "mg":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "spread":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "smg":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "grenade":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "rocketlauncher":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "turret":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    default:
      n_magnitude = 0.01;
      break;
  }

  playFX("maps/cp_rus_amerika/fx9_impact_mannequin_sm", origin);
  snd::play("exp_facade_debris_mannequin", origin);
  radiusdamage(origin + (0, 0, -10), 5, 10, 3);
  radiusdamage(origin + (0, 0, -5), 5, 10, 3);
  radiusdamage(origin + (0, 0, 10), 5, 10, 3);
  radiusdamage(origin + (0, 0, 20), 5, 10, 3);
  radiusdamage(origin + (0, 0, 30), 5, 10, 3);
  physicsexplosionsphere(origin + (0, 0, -10), n_outer_radius, n_inner_radius, n_magnitude);
  physicsexplosionsphere(origin + (0, 0, -5), n_outer_radius, n_inner_radius, n_magnitude);
  physicsexplosionsphere(origin + (0, 0, 20), n_outer_radius, n_inner_radius, n_magnitude);
}

function function_42a285bf() {
  self endon(#"entitydeleted", #"hash_27629c40b49f163c");
  self setCanDamage(1);
  self disconnectpaths();
  origin = self.origin;
  s_notify = self waittill(#"damage");
  level thread function_c59775f7(s_notify, origin);
  self connectpaths();
  self deletedelay();
}

function function_c59775f7(s_notify, origin) {
  n_outer_radius = 5;
  n_inner_radius = 1;
  var_67b43134 = 1;
  var_b6680570 = 5;
  var_a62ea1f = 10;
  var_947d01ee = s_notify.weapon.weapclass;
  var_18acfe18 = s_notify.amount;

  switch (var_947d01ee) {
    case # "pistol":
      n_magnitude = var_18acfe18 * 0.02;
      break;
    case # "rifle":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "mg":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "spread":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "smg":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "grenade":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "rocketlauncher":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    case # "turret":
      n_magnitude = var_18acfe18 * 0.025;
      break;
    default:
      n_magnitude = 0.01;
      break;
  }

  playFX("maps/cp_rus_amerika/fx9_impact_mannequin_sm", origin);
  snd::play("exp_facade_debris_mannequin", origin);
  radiusdamage(origin + (0, 0, -10), 5, 10, 3);
  radiusdamage(origin + (0, 0, -5), 5, 10, 3);
  radiusdamage(origin + (0, 0, 0), 5, 10, 3);
  radiusdamage(origin + (0, 0, 5), 5, 10, 3);
  radiusdamage(origin + (0, 0, 10), 5, 10, 3);
  physicsexplosionsphere(origin + (0, 0, -10), n_outer_radius, n_inner_radius, n_magnitude);
  physicsexplosionsphere(origin + (0, 0, 0), n_outer_radius, n_inner_radius, n_magnitude);
  physicsexplosionsphere(origin + (0, 0, 10), n_outer_radius, n_inner_radius, n_magnitude);
}
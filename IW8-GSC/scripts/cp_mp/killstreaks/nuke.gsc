/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\nuke.gsc
***********************************************/

function terminal_pusher_approach_array(var_0) {
  var_0.unlockableindex = 1;
  thread ref_138da(var_0);
}

function ref_138da(var_0) {
  self endon("disconnect");
  scripts\engine\utility::ref_143a5("end_dragBreath", "death");

  if(isDefined(var_0)) {
    var_0.unlockableindex = undefined;
    return;
  }
}

function ref_13638() {
  var_0 = spawnStruct();
  var_0.ref_11e62 = [];
  var_0.spawn_little_bird_mg_at_location = [];
  var_0.flares = "";
  return var_0;
}

function ref_13146(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(usedpropsindex(var_4)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_4);
    }
  }

  if(var_0.size == 0) {
    return;
  }

  thread flareready(var_0, var_1, var_2);
}

function ref_13147() {
  var_0 = self getcorpseentity();

  if(isDefined(var_0)) {
    var_0 setscriptablepartstate("burning", "flareUp", 0);
    return;
  }
}

function ref_138db() {
  self notify("stop_dragonsbreathDamage");
  self.mine_caves_ambusher = undefined;
}

function flareready(var_0, var_1, var_2) {
  self notify("newBurningParts");
  self endon("disconnect");
  self endon("newBurningParts");
  self endon("stop_dragonsbreathDamage");
  var_0 = scripts\engine\utility::array_remove_duplicates(var_0);

  foreach(var_4 in var_0) {
    if(isDefined(self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4])) {
      self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4] += 0.5;
      self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4] = min(self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4], 4);
      continue;
    }

    self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var_4] = 0.5;
  }

  GscBinSkip4(0x35, var_1, var_2);
}

function ref_13130(var_0, var_1) {
  var_2 = getcompleteweaponname("dragonsbreath_mp");
  var_2.ref_121d9 = var_1;
  var_3 = 1;
  jumpiffalse(level.gametype == "br" && var_1.classname == "spread") LOC_00000042;
  var_3 = 0.75;

  for(;;) {
    wait 0.25;
    var_4 = scripts\engine\math::normalize_value(5, 1, self.mine_caves_ambusher.spawn_little_bird_mg_at_location.size);
    var_5 = scripts\engine\math::factor_value(40, 54, var_4);
    var_6 = int(var_5 * 0.25) * var_3;
    var_6 = floor(var_6);

    if(var_1 hasattachment("ammo_incendiary", 1) && weaponclass(var_1) != "spread") {
      var_6 = int(level.ref_12e38 * level.ref_12e39);

      if(weaponisboltaction(var_1) && issubstr(var_1.basename, "s4_mr_")) {
        var_6 -= 1;
      }
    }

    if(isDefined(var_0)) {
      self dodamage(var_6, self.origin, var_0, var_0, "MOD_FIRE", var_2);
    }
  }
}

function ref_13131() {
  var_0 = "";
  var_1 = [];
  GscBinSkip0(0x2e, "torso", 0);
}

function ref_11ae5(var_0) {
  switch (var_0) {
    case "helmet":
      return "torso";
    case "head":
      return "torso";
    case "neck":
      return "torso";
    case "torso_upper":
      return "torso";
    case "torso_lower":
      return "torso";
    case "right_arm_upper":
      return "torso";
    case "left_arm_upper":
      return "torso";
    case "right_arm_lower":
      return "torso";
    case "left_arm_lower":
      return "torso";
    case "right_hand":
      return "torso";
    case "left_hand":
      return "torso";
    case "right_leg_upper":
      return "legs";
    case "left_leg_upper":
      return "legs";
    case "right_leg_lower":
      return "legs";
    case "left_leg_lower":
      return "legs";
    case "right_foot":
      return "legs";
    case "left_foot":
      return "legs";
  }
}

function unlockables(var_0) {
  var_1 = getweaponammopoolname(var_0);
  var_2 = var_0 hasattachment("ammo_incendiary", 1);
  return var_1 == "WEAPON/AMMO_DB" || var_2;
}

function usedpropsindex(var_0) {
  if(var_0 == "shield") {
    return 1;
  }

  return 0;
}
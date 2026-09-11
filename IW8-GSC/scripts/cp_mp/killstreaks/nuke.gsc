/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\nuke.gsc
***********************************************/

function terminal_pusher_approach_array(var0) {
  var0.unlockableindex = 1;
  thread ref_138da(var0);
}

function ref_138da(var0) {
  self endon("disconnect");
  scripts\engine\utility::ref_143a5("end_dragBreath", "death");

  if(isDefined(var0)) {
    var0.unlockableindex = undefined;
    return;
  }
}

function ref_13638() {
  var0 = spawnStruct();
  var0.ref_11e62 = [];
  var0.spawn_little_bird_mg_at_location = [];
  var0.flares = "";
  return var0;
}

function ref_13146(var0, var1, var2) {
  foreach(var4 in var0) {
    if(usedpropsindex(var4)) {
      var0 = scripts\engine\utility::array_remove(var0, var4);
    }
  }

  if(var0.size == 0) {
    return;
  }

  thread flareready(var0, var1, var2);
}

function ref_13147() {
  var0 = self getcorpseentity();

  if(isDefined(var0)) {
    var0 setscriptablepartstate("burning", "flareUp", 0);
    return;
  }
}

function ref_138db() {
  self notify("stop_dragonsbreathDamage");
  self.mine_caves_ambusher = undefined;
}

function flareready(var0, var1, var2) {
  self notify("newBurningParts");
  self endon("disconnect");
  self endon("newBurningParts");
  self endon("stop_dragonsbreathDamage");
  var0 = scripts\engine\utility::array_remove_duplicates(var0);

  foreach(var4 in var0) {
    if(isDefined(self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var4])) {
      self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var4] += 0.5;
      self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var4] = min(self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var4], 4);
      continue;
    }

    self.mine_caves_ambusher.spawn_little_bird_mg_at_location[var4] = 0.5;
  }

  GscBinSkip4(0x35, var1, var2);
}

function ref_13130(var0, var1) {
  var2 = getcompleteweaponname("dragonsbreath_mp");
  var2.ref_121d9 = var1;
  var3 = 1;
  jumpiffalse(level.gametype == "br" && var1.classname == "spread") LOC_00000042;
  var3 = 0.75;

  for(;;) {
    wait 0.25;
    var4 = scripts\engine\math::normalize_value(5, 1, self.mine_caves_ambusher.spawn_little_bird_mg_at_location.size);
    var5 = scripts\engine\math::factor_value(40, 54, var4);
    var6 = int(var5 * 0.25) * var3;
    var6 = floor(var6);

    if(var1 hasattachment("ammo_incendiary", 1) && weaponclass(var1) != "spread") {
      var6 = int(level.ref_12e38 * level.ref_12e39);

      if(weaponisboltaction(var1) && issubstr(var1.basename, "s4_mr_")) {
        var6 -= 1;
      }
    }

    if(isDefined(var0)) {
      self dodamage(var6, self.origin, var0, var0, "MOD_FIRE", var2);
    }
  }
}

function ref_13131() {
  var0 = "";
  var1 = [];
  GscBinSkip0(0x2e, "torso", 0);
}

function ref_11ae5(var0) {
  switch (var0) {
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

function unlockables(var0) {
  var1 = getweaponammopoolname(var0);
  var2 = var0 hasattachment("ammo_incendiary", 1);
  return var1 == "WEAPON/AMMO_DB" || var2;
}

function usedpropsindex(var0) {
  if(var0 == "shield") {
    return 1;
  }

  return 0;
}
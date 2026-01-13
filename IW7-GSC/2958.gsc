/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2958.gsc
************************/

func_977D() {
  if(!scripts\engine\utility::add_init_script("player_thermal", ::func_977D)) {
    return;
  }

  lib_0B5F::func_965A();
  scripts\engine\utility::array_thread(level.players, ::watchweaponchange);
}

watchweaponchange() {
  if(!isDefined(level.var_73F8)) {
    level.var_73F8 = loadfx("vfx\core\equipment\thermal_tapereflect_inverted.vfx");
  }

  self endon("death");
  var_0 = self getcurrentweapon();
  if(func_13BF6(var_0)) {
    thread func_11776();
  }

  for(;;) {
    self waittill("weapon_change", var_1);
    if(func_13BF6(var_1)) {
      thread func_11776();
      continue;
    }

    self notify("acogThermalTracker");
  }
}

func_11776() {
  self endon("death");
  self notify("acogThermalTracker");
  self endon("acogThermalTracker");
  var_0 = 0;
  for(;;) {
    var_1 = var_0;
    var_0 = self getweaponrankinfominxp();
    if(func_12998(var_0, var_1)) {
      func_11775();
    } else if(func_12997(var_0, var_1)) {
      func_11774();
    }

    wait(0.05);
  }
}

func_12998(var_0, var_1) {
  if(var_0 <= var_1) {
    return 0;
  }

  if(var_0 <= 0.65) {
    return 0;
  }

  return !isDefined(self.var_9C1F);
}

func_12997(var_0, var_1) {
  if(var_0 >= var_1) {
    return 0;
  }

  if(var_0 >= 0.8) {
    return 0;
  }

  return isDefined(self.var_9C1F);
}

func_11775() {
  self.var_9C1F = 1;
  var_0 = getaiarray("allies");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.var_8BB5)) {
      continue;
    }

    var_2.var_8BB5 = 1;
    var_2 thread func_B03E(self.unique_id);
  }
}

func_11774() {
  self.var_9C1F = undefined;
  level notify("thermal_fx_off" + self.unique_id);
  var_0 = getaiarray("allies");
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].var_8BB5 = undefined;
  }
}

func_13BF6(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  if(weaponhasthermalscope(var_0)) {
    return 1;
  }

  return 0;
}

func_B03E(var_0, var_1) {
  if(isDefined(self.var_8B95)) {
    return;
  }

  level endon("thermal_fx_off" + var_0);
  self endon("death");
  for(;;) {
    if(isDefined(var_1)) {
      playfxontagforclients(level.var_73F8, self, "J_Spine4", var_1);
    } else {
      playFXOnTag(level.var_73F8, self, "J_Spine4");
    }

    wait(0.2);
  }
}
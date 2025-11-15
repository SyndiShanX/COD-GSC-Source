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
  var_00 = self getcurrentweapon();
  if(func_13BF6(var_00)) {
    thread func_11776();
  }

  for(;;) {
    self waittill("weapon_change", var_01);
    if(func_13BF6(var_01)) {
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
  var_00 = 0;
  for(;;) {
    var_01 = var_00;
    var_00 = self getweaponrankinfominxp();
    if(func_12998(var_00, var_01)) {
      func_11775();
    } else if(func_12997(var_00, var_01)) {
      func_11774();
    }

    wait(0.05);
  }
}

func_12998(param_00, param_01) {
  if(param_00 <= param_01) {
    return 0;
  }

  if(param_00 <= 0.65) {
    return 0;
  }

  return !isDefined(self.var_9C1F);
}

func_12997(param_00, param_01) {
  if(param_00 >= param_01) {
    return 0;
  }

  if(param_00 >= 0.8) {
    return 0;
  }

  return isDefined(self.var_9C1F);
}

func_11775() {
  self.var_9C1F = 1;
  var_00 = getaiarray("allies");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_8BB5)) {
      continue;
    }

    var_02.var_8BB5 = 1;
    var_02 thread func_B03E(self.unique_id);
  }
}

func_11774() {
  self.var_9C1F = undefined;
  level notify("thermal_fx_off" + self.unique_id);
  var_00 = getaiarray("allies");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01].var_8BB5 = undefined;
  }
}

func_13BF6(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "none") {
    return 0;
  }

  if(weaponhasthermalscope(param_00)) {
    return 1;
  }

  return 0;
}

func_B03E(param_00, param_01) {
  if(isDefined(self.var_8B95)) {
    return;
  }

  level endon("thermal_fx_off" + param_00);
  self endon("death");
  for(;;) {
    if(isDefined(param_01)) {
      playfxontagforclients(level.var_73F8, self, "J_Spine4", param_01);
    } else {
      playFXOnTag(level.var_73F8, self, "J_Spine4");
    }

    wait(0.2);
  }
}
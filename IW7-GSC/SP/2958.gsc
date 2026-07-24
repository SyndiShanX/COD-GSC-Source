/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2958.gsc
**************************************/

_id_977D() {
  if(!scripts\engine\utility::add_init_script("player_thermal", ::_id_977D)) {
    return;
  }
  _id_0B5F::_id_965A();
  scripts\engine\utility::array_thread(level.players, ::watchweaponchange);
}

watchweaponchange() {
  if(!isDefined(level._id_73F8))
    level._id_73F8 = loadfx("vfx/core/equipment/thermal_tapereflect_inverted.vfx");

  self endon("death");
  var_0 = self getcurrentweapon();

  if(_id_13BF6(var_0))
    thread _id_11776();

  for(;;) {
    self waittill("weapon_change", var_1);

    if(_id_13BF6(var_1)) {
      thread _id_11776();
      continue;
    }

    self notify("acogThermalTracker");
  }
}

_id_11776() {
  self endon("death");
  self notify("acogThermalTracker");
  self endon("acogThermalTracker");
  var_0 = 0;

  for(;;) {
    var_1 = var_0;
    var_0 = self playerads();

    if(_id_12998(var_0, var_1))
      _id_11775();
    else if(_id_12997(var_0, var_1))
      _id_11774();

    wait 0.05;
  }
}

_id_12998(var_0, var_1) {
  if(var_0 <= var_1)
    return 0;

  if(var_0 <= 0.65)
    return 0;

  return !isDefined(self._id_9C1F);
}

_id_12997(var_0, var_1) {
  if(var_0 >= var_1)
    return 0;

  if(var_0 >= 0.8)
    return 0;

  return isDefined(self._id_9C1F);
}

_id_11775() {
  self._id_9C1F = 1;
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_8BB5)) {
      continue;
    }
    var_2._id_8BB5 = 1;
    var_2 thread _id_B03E(self.unique_id);
  }
}

_id_11774() {
  self._id_9C1F = undefined;
  level notify("thermal_fx_off" + self.unique_id);
  var_0 = getaiarray("allies");

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1]._id_8BB5 = undefined;
}

_id_13BF6(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 == "none")
    return 0;

  if(weaponhasthermalscope(var_0))
    return 1;

  return 0;
}

_id_B03E(var_0, var_1) {
  if(isDefined(self._id_8B95)) {
    return;
  }
  level endon("thermal_fx_off" + var_0);
  self endon("death");

  for(;;) {
    if(isDefined(var_1))
      playfxontagforclients(level._id_73F8, self, "J_Spine4", var_1);
    else
      playFXOnTag(level._id_73F8, self, "J_Spine4");

    wait 0.2;
  }
}
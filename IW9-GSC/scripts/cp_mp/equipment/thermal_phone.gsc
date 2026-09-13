/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\thermal_phone.gsc
*****************************************************/

_id_7C59B9D44AFF939B() {}

_id_D7B50D4592CD5421(equipmentref, _id_CBB2B3D05E48BD27, variantid) {
  thread _id_D985CED7C32C7258();
}

_id_D985CED7C32C7258() {
  self endon("death_or_disconnect");
  self endon("thermal_phone_taken");

  for(;;) {
    self waittill("grenade_pullback", objweapon);

    if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "thermal_phone_mp") {
      if(isDefined(level._id_668566D171E33358))
        [[level._id_668566D171E33358]](self);
    }
  }
}

_id_E49FA2736F79E04B(equipmentref, _id_CBB2B3D05E48BD27) {
  self notify("thermal_phone_taken");
}

_id_230403B8CF5EA1E8(grenade) {
  if(isDefined(grenade))
    grenade delete();

  if(isDefined(level._id_5A712C9D76830012))
    [[level._id_5A712C9D76830012]](self);

  self notify("thermal_phone_finished");
}
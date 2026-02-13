/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2372.gsc
*************************************************/

_id_AFBA() {
  if(isDefined(self._id_AFAA["melee_scalar"])) {
    return self._id_AFAA["melee_scalar"];
  } else {
    return self._id_AFAA["health"]._id_9D50;
  }
}

_id_AFB9() {
  if(isDefined(self._id_AFAA["max_health"])) {
    return self._id_AFAA["max_health"];
  } else {
    return self._id_AFAA["health"]._id_9C21;
  }
}

_id_AFB2() {
  if(isDefined(self._id_AFAA["bullet_damage_scalar"])) {
    return self._id_AFAA["bullet_damage_scalar"];
  } else {
    return self._id_AFAA["impact"]._id_2D25;
  }
}

_id_AFC1() {
  if(isDefined(self._id_AFAA["revive_time_scalar"])) {
    return self._id_AFAA["revive_time_scalar"];
  } else {
    return self._id_AFAA["medic"]._id_C7D3;
  }
}

_id_AFBB() {
  if(isDefined(self._id_AFAA["move_speed_scalar"])) {
    return self._id_AFAA["move_speed_scalar"];
  } else {
    return self._id_AFAA["medic"]._id_A200;
  }
}

_id_AFC0() {
  if(isDefined(self._id_AFAA["revive_damage_scalar"])) {
    return self._id_AFAA["revive_damage_scalar"];
  } else {
    return self._id_AFAA["medic"]._id_C7BD;
  }
}

_id_AFB6() {
  if(isDefined(self._id_AFAA["explosive_damage_scalar"])) {
    return self._id_AFAA["explosive_damage_scalar"];
  } else {
    return self._id_AFAA["demolition"]._id_57E2;
  }
}

_id_AFBC() {
  if(isDefined(self._id_AFAA["offhand_count"])) {
    return self._id_AFAA["offhand_count"];
  } else {
    return self._id_AFAA["demolition"]._id_A943;
  }
}
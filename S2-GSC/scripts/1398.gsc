/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1398.gsc
**************************************/

_id_52A4() {
  _id_0561::_id_52A5("consumable_zm_self_revive", "Self Revive", ::_id_A234, ::_id_1F88, ::_id_467C);
}

_id_1F88(var_0) {
  if(isDefined(self._id_5378) && self._id_5378)
    return 1;

  return 0;
}

_id_A234(var_0) {
  _id_0555::_id_83DD("self_revive", self);
  self notify("revive_trigger");
}

_id_467C(var_0) {
  var_1 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", 2, "quantity");

  if(var_1 > 1)
    return 2;
  else
    return var_1;
}

_id_4B92() {
  if(isDefined(self._id_259F) && isDefined(self._id_259F["sReviveSlot"]) && self._id_259F["sReviveSlot"]._id_20F0 > 0)
    return 1;

  return 0;
}

_id_83C6() {
  self endon("revive_trigger");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!_id_0561::_id_4B5F("sReviveSlot")) {
    return;
  }
  var_0 = 2;

  if(isDefined(self._id_83BF) && self._id_83BF == var_0) {
    return;
  }
  wait 1.5;
  var_1 = getdvarint("5107");

  if(!isDefined(var_1) || var_1 <= 0)
    var_1 = 250;

  var_2 = 0;
  var_3 = gettime();

  for(;;) {
    if(!var_2) {
      if(self _meth_8341()) {
        var_3 = gettime() + var_1;
        var_2 = 1;
      }
    } else if(!self _meth_8341())
      var_2 = 0;
    else if(gettime() >= var_3) {
      self notify("useConsumable_sReviveSlot");
      _id_0378::_id_8D74("play_revive_sound");
      break;
    }

    waitframe();
  }
}
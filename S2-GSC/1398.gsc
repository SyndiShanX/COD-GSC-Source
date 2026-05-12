/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1398.gsc
*********************************************/

lib_0576::func_52A4() {
  lib_0561::func_52A5("consumable_zm_self_revive", "Self Revive", ::lib_0576::func_A234, ::lib_0576::func_1F88, ::lib_0576::func_467C);
}

lib_0576::func_1F88(param_00) {
  if(isDefined(self.var_5378) && self.var_5378) {
    return 1;
  }

  return 0;
}

lib_0576::func_A234(param_00) {
  lib_0555::func_83DD("self_revive", self);
  self notify("revive_trigger");
}

lib_0576::func_467C(param_00) {
  var_01 = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", 2, "quantity");
  if(var_01 > 1) {
    return 2;
  }

  return var_01;
}

lib_0576::func_4B92() {
  if(isDefined(self.var_259F) && isDefined(self.var_259F["sReviveSlot"]) && self.var_259F["sReviveSlot"].var_20F0 > 0) {
    return 1;
  }

  return 0;
}

lib_0576::func_83C6() {
  self endon("revive_trigger");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(!lib_0561::func_4B5F("sReviveSlot")) {
    return;
  }

  var_00 = 2;
  if(isDefined(self.var_83BF) && self.var_83BF == var_00) {
    return;
  }

  wait(1.5);
  var_01 = getdvarint("5107");
  if(!isDefined(var_01) || var_01 <= 0) {
    var_01 = 250;
  }

  var_02 = 0;
  var_03 = gettime();
  for(;;) {
    if(!var_02) {
      if(self useButtonPressed()) {
        var_03 = gettime() + var_01;
        var_02 = 1;
      }
    } else if(!self useButtonPressed()) {
      var_02 = 0;
    } else if(gettime() >= var_03) {
      self notify("useConsumable_sReviveSlot");
      lib_0378::func_8D74("play_revive_sound");
      break;
    }

    wait 0.05;
  }
}
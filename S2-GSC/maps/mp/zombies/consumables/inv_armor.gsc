/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\consumables\inv_armor.gsc
*****************************************************/

func_52A4() {
  lib_0561::initconsumablesfromtable("armor", ::usearmor, ::canusearmor, ::getarmorcharges);
}

canusearmor(param_00) {
  var_01 = self;
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  if(var_01 lib_056A::func_4B53()) {
    return 0;
  }

  return 1;
}

usearmor(param_00) {
  foreach(var_02 in level.var_744A) {
    var_02 lib_056A::func_4775();
    var_02 thread maps\mp\gametypes\_hud_message::func_9102("zm_shattered_maxarmor_splash");
  }
}

getarmorcharges(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  switch (param_00) {
    case "epic":
      return 4;

    case "legendary":
      return 3;

    case "rare":
      return 2;

    case "common":
      return 1;

    default:
      return 0;
  }
}
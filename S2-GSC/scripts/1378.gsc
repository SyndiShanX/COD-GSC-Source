/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1378.gsc
**************************************/

init() {
  common_scripts\utility::_id_092C("moneyCloud", "vfx/gameplay/mp/zombie/gj_pickup_zombies_01_money");

  foreach(var_1 in ["classic_ee_trigger_01", "classic_ee_trigger_02", "classic_ee_trigger_03", "classic_ee_trigger_04"]) {
    var_2 = _getent(var_1, "script_noteworthy");
    level._id_231F[var_1] = var_2;
    thread _id_3599(var_2);
  }

  thread _id_7E3D();
}

_id_3599(var_0) {
  while(!isDefined(level._id_8AD2))
    waitframe();

  for(;;) {
    level waittill("spawned_money_share");

    foreach(var_2 in level._id_8AD2) {
      if(!var_0 _meth_858B(var_2.origin)) {
        continue;
      }
      var_3 = var_2._id_0117;

      if(!isPlayer(var_3)) {
        continue;
      }
      var_4 = var_3 getentitynumber();
      var_2 _id_0544::_id_8ADD(var_4, 0);
      thread _id_62D8(var_0.origin);
      var_2._id_6FD4 = 0;
      var_2._id_6FCB = 0;
      var_0._id_2320 = 1;
      level notify("theclassic_step_done");
      return;
    }
  }
}

_id_62D8(var_0) {
  var_1 = _spawnfx(common_scripts\utility::_id_44F5("moneyCloud"), var_0);
  _triggerfx(var_1);
  wait 3;
  var_1 delete();
}

_id_0F4E() {
  foreach(var_1 in level._id_231F) {
    if(!common_scripts\utility::_id_562E(var_1._id_2320))
      return 0;
  }

  return 1;
}

_id_7E3D() {
  while(!_id_0F4E())
    level waittill("theclassic_step_done");

  _id_0548::_id_09C8("ppsh41_classic_zm", "extended_mag", "none", "none");
}
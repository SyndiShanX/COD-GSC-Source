/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\fx_zones\.csc.gsc
*************************************************/

fx_zone_watcher(var_0, var_1, var_2, var_3) {
  _id_0510::_id_5C11(var_1);
  _id_0510::_id_5C11("fx_zone_" + var_0 + "_active");

  if(isDefined(var_2)) {
    _id_0510::_id_5C11(var_2);
  }

  if(isDefined(var_3)) {
    if(!_id_0510::_id_5C0C(var_3)) {
      _id_0510::_id_5C11(var_3);
    }
  }

  waitframe();
  var_4 = _func_008C();
  var_4._id_0336 = 0;

  if(isDefined(var_3)) {
    var_4 thread fx_zone_watcher_either_off_killthread(var_0, var_3, var_1, var_2);
  }

  var_4 thread fx_zone_watcher_launcher(var_0, var_1, var_2);
}

fx_zone_watcher_launcher(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = var_1;
  }

  for(;;) {
    thread fx_zone_watcher_either(var_0, var_1, var_2);
    level waittill("fx_zone_" + var_0 + "_deactivating");
    level waittill("fx_zone_" + var_0 + "_activating");
  }
}

fx_zone_watcher_either(var_0, var_1, var_2) {
  level endon("fx_zone_" + var_0 + "_deactivating");
  var_0 = var_0 + "";

  for(;;) {
    _id_0510::_id_5C2B(var_1, var_2);
    play_exploder(var_0);
    flag_waitopen_both(var_1, var_2);
    _id_E893(var_0);
  }
}

fx_zone_watcher_either_off_killthread(var_0, var_1, var_2, var_3) {
  var_0 = var_0 + "";

  for(;;) {
    if(!isDefined(var_3)) {
      var_3 = var_2;
    }

    var_4 = 0;
    _id_0510::_id_5C24(var_1);
    send_deactivate_zone_msg(var_0);
    _id_E893(var_0);
    _id_0510::_id_5C30(var_1);
    send_activate_zone_msg(var_0);

    if(_id_0510::_id_5C00(var_2) || _id_0510::_id_5C00(var_3)) {
      play_exploder(var_0);
    }
  }
}

send_activate_zone_msg(var_0) {
  level notify("fx_zone_" + var_0 + "_activating");
  _id_0510::_id_5C1B("fx_zone_" + var_0 + "_active");
}

send_deactivate_zone_msg(var_0) {
  level notify("fx_zone_" + var_0 + "_deactivating");
  _id_0510::_id_5C04("fx_zone_" + var_0 + "_active");
}

flag_waitopen_both(var_0, var_1) {
  while(_id_0510::_id_5C00(var_0) || _id_0510::_id_5C00(var_1)) {
    level _id_0510::_id_108C5(var_0, var_1);
  }
}

play_exploder(var_0) {
  if(self._id_0336) {
    return;
  }
  self._id_0336 = 1;
  var_1 = 0;
  _func_00C5(var_1, var_0);
}

_id_E893(var_0) {
  if(!self._id_0336) {
    return;
  }
  self._id_0336 = 0;
  var_1 = 0;
  _func_00C7(var_1, var_0);
}
/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\trigger\.csc.gsc
*************************************************/

_id_656B() {
  var_0["trigger_multiple_fx_fxzone"] = ::_id_F5B1;
  var_0["trigger_multiple_set_dvar"] = ::trigger_set_dvar;
  return var_0;
}

_id_80A3() {
  thread init_script_triggers_delayed();
}

init_script_triggers_delayed() {
  wait 1;
  var_0 = _id_656B();
  var_1 = 0;
  var_2 = var_0;

  for(var_5 = _func_0022(var_2); isDefined(var_5); var_5 = _func_0024(var_2, var_5)) {
    var_3 = var_2[var_5];
    var_4 = _func_001E(0, var_5, "classname");
    _id_0510::_id_1BB7(var_4, var_3);
  }

  __asm_var_clear(3)
}

_id_F5B1(var_0) {
  var_0 endon("death");
  var_1 = var_0 _id_67E7();

  if(!_id_0510::_id_5C0C(var_1)) {
    _id_0510::_id_5C11(var_1);
  }

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_0 _id_0510::_id_0393();

    if(isDefined(var_0) && var_0 _meth_802B()) {
      _id_0510::_id_5C1B(var_1, var_2);
    }

    while(isDefined(var_0) && var_0 _meth_802B()) {
      wait 0.25;
    }

    _id_0510::_id_5C04(var_1);
  }
}

trigger_set_dvar(var_0) {
  var_1 = var_0._id_039B;
  var_2 = var_0.target;

  if(var_2 == "r_volumetricDepth") {
    var_2 = "#x36953c7226815560c";
  }

  for(;;) {
    var_0 waittill("trigger", var_3);
    var_0 _id_0510::_id_0393();
    _func_00DF(var_2, var_1);
  }
}

_id_67E7() {
  if(isDefined(self._id_039B)) {
    return self._id_039B;
  }
}

lgt_dvar_watcher(var_0, var_1, var_2) {
  _func_00DF(var_1, var_2);
}
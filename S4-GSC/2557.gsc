/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2557.gsc
*************************************************/

_id_11D7(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::_id_A695("death", "explode_end");
  var_1 thread _id_11D8(var_0);
  var_0 waittill("explode", var_2);
  var_1 notify("advanced_supply_drop_finished");
  thread _id_11D6(var_2);

  if(scripts\mp\outofbounds::_id_89B8(var_2)) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_1._id_EB09)) {
      var_1 scripts\mp\supers::_id_EB50(1);
    }

    return;
  }

  var_1 thread scripts\mp\gametypes\br_rewards::_id_E29B(var_2);

  if(isDefined(var_1._id_EB09)) {
    var_1 scripts\mp\supers::_id_EB50(undefined, undefined, undefined, 1);
  }
}

_id_11D8(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("advanced_supply_drop_finished");
  var_0 waittill("death");
  waitframe();

  if(isDefined(var_1._id_EB09)) {
    var_1 scripts\mp\supers::_id_EB50(1);
  }
}

_id_11D6(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  var_1 playSound("smoke_canister_tail_dissipate");
  var_1 stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  var_1 delete();
}
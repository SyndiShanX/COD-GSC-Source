/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: behaviortree\zombie_juggernaut.gsc
*************************************************/

zombie_juggernautfn0(var_0) {
  return _id_06AF::_id_4EAA(var_0, 200);
}

_id_2509() {
  if(isDefined(level._id_0B73["zombie_juggernaut"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_0E8A = [];
  var_0._id_0E8A[0] = ::scripts\aitypes\zombie_common\ai_util::_id_3558;
  var_0._id_0E8A[1] = _id_08EA::_id_DB4F;
  var_0._id_0E8A[2] = _id_08EA::_id_54DB;
  var_0._id_0E8A[3] = _id_08EA::_id_54DC;
  var_0._id_0E8A[4] = _id_08EA::_id_54DD;
  var_0._id_0E8A[5] = ::zombie_juggernautfn0;
  var_0._id_0E8A[6] = _id_06AF::_id_D8C1;
  var_0._id_0E8A[7] = ::scripts\aitypes\zombie_common\ai_util::_id_8AAE;
  var_0._id_0E8A[8] = ::scripts\aitypes\zombie_common\freeze::_id_8873;
  var_0._id_0E8A[9] = ::scripts\aitypes\zombie_common\freeze::_id_7CA9;
  var_0._id_0E8A[10] = ::scripts\aitypes\zombie_common\freeze::idleinit;
  var_0._id_0E8A[11] = ::scripts\aitypes\zombie_common\freeze::idleterminate;
  var_0._id_0E8A[12] = ::scripts\aitypes\zombie_common\stun::_id_8A6C;
  var_0._id_0E8A[13] = ::scripts\aitypes\zombie_common\stun::_id_7CA9;
  var_0._id_0E8A[14] = ::scripts\aitypes\zombie_common\stun::idleinit;
  var_0._id_0E8A[15] = ::scripts\aitypes\zombie_common\stun::idleterminate;
  var_0._id_0E8A[16] = ::scripts\aitypes\zombie_common\distract::_id_4BA7;
  var_0._id_0E8A[17] = ::scripts\aitypes\zombie_common\awareness::isaware;
  var_0._id_0E8A[18] = ::scripts\aitypes\zombie_common\awareness::_id_7CA9;
  var_0._id_0E8A[19] = ::scripts\aitypes\zombie_common\awareness::idleinit;
  var_0._id_0E8A[20] = ::scripts\aitypes\zombie_common\awareness::idleterminate;
  var_0._id_0E8A[21] = ::scripts\aitypes\zombie_common\awareness::wander;
  var_0._id_0E8A[22] = ::scripts\aitypes\zombie_common\awareness::wanderinit;
  var_0._id_0E8A[23] = ::scripts\aitypes\zombie_common\awareness::wanderterminate;
  var_0._id_0E8A[24] = ::scripts\aitypes\zombie_common\move::shouldmoveaway;
  var_0._id_0E8A[25] = ::scripts\aitypes\zombie_common\move::moveaway;
  var_0._id_0E8A[26] = ::scripts\aitypes\zombie_common\move::moveawayinit;
  var_0._id_0E8A[27] = ::scripts\aitypes\zombie_common\move::moveawayterminate;
  var_0._id_0E8A[28] = ::scripts\aitypes\zombie_juggernaut\combat::shouldshootdoor;
  var_0._id_0E8A[29] = ::scripts\aitypes\zombie_juggernaut\combat::shootdoorupdate;
  var_0._id_0E8A[30] = ::scripts\aitypes\zombie_juggernaut\combat::shootdoorinit;
  var_0._id_0E8A[31] = ::scripts\aitypes\zombie_juggernaut\combat::shootdoorterminate;
  var_0._id_0E8A[32] = ::scripts\aitypes\zombie_juggernaut\combat::_id_DB84;
  var_0._id_0E8A[33] = ::scripts\aitypes\zombie_juggernaut\combat::zombiejuggernaut_melee;
  var_0._id_0E8A[34] = ::scripts\aitypes\zombie_juggernaut\combat::zombiejuggernaut_shouldshoot;
  var_0._id_0E8A[35] = ::scripts\aitypes\zombie_juggernaut\combat::shouldchaseenemy;
  var_0._id_0E8A[36] = ::scripts\aitypes\zombie_juggernaut\combat::_id_341C;
  var_0._id_0E8A[37] = ::scripts\aitypes\zombie_juggernaut\combat::shootwindup;
  var_0._id_0E8A[38] = ::scripts\aitypes\zombie_juggernaut\combat::shootupdate;
  var_0._id_0E8A[39] = ::scripts\aitypes\zombie_juggernaut\combat::shootinit;
  var_0._id_0E8A[40] = ::scripts\aitypes\zombie_juggernaut\combat::shootterminate;
  var_0._id_0E8A[41] = ::scripts\aitypes\zombie_juggernaut\combat::shoulddefendlocation;
  var_0._id_0E8A[42] = ::scripts\aitypes\zombie_juggernaut\combat::_id_461F;
  var_0._id_0E8A[43] = ::scripts\aitypes\zombie_juggernaut\combat::shouldtaunt;
  var_0._id_0E8A[44] = ::scripts\aitypes\zombie_juggernaut\combat::taunt;
  var_0._id_0E8A[45] = ::scripts\aitypes\zombie_juggernaut\combat::tauntinit;
  var_0._id_0E8A[46] = ::scripts\aitypes\zombie_juggernaut\combat::tauntterminate;
  var_0._id_0E8A[47] = ::scripts\aitypes\zombie_juggernaut\combat::shouldrelocate;
  var_0._id_0E8A[48] = ::scripts\aitypes\zombie_juggernaut\combat::relocate;
  var_0._id_0E8A[49] = ::scripts\aitypes\zombie_juggernaut\combat::relocateinit;
  var_0._id_0E8A[50] = ::scripts\aitypes\zombie_juggernaut\combat::relocateterminate;
  var_0._id_0E8A[51] = ::scripts\aitypes\zombie_juggernaut\combat::_id_7CA9;
  var_0._id_0E8A[52] = ::scripts\aitypes\zombie_juggernaut\combat::zombiejuggernaut_init;
  level._id_0B73["zombie_juggernaut"] = var_0;
}

_id_C241() {
  _id_2509();
  _func_030B("zombie_juggernaut");
}
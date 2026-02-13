/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1329.gsc
*************************************************/

_id_11022(var_0) {
  return _id_06AF::_id_4EAA(var_0, 200);
}

_id_2509() {
  if(isDefined(level._id_0B73["zombie_cp"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_0E8A = [];
  var_0._id_0E8A[0] = ::scripts\aitypes\zombie_common\ai_util::_id_3558;
  var_0._id_0E8A[1] = _id_08EA::_id_DB4F;
  var_0._id_0E8A[2] = _id_08EA::_id_54DB;
  var_0._id_0E8A[3] = _id_08EA::_id_54DC;
  var_0._id_0E8A[4] = _id_08EA::_id_54DD;
  var_0._id_0E8A[5] = ::_id_11022;
  var_0._id_0E8A[6] = _id_06AF::_id_D8C1;
  var_0._id_0E8A[7] = ::scripts\aitypes\zombie_common\ai_util::_id_8AAE;
  var_0._id_0E8A[8] = ::scripts\aitypes\zombie_common\ai_util::haslegs;
  var_0._id_0E8A[9] = ::scripts\aitypes\zombie_common\push::shouldknockdown;
  var_0._id_0E8A[10] = ::scripts\aitypes\zombie_common\push::knockdownprocess;
  var_0._id_0E8A[11] = ::scripts\aitypes\zombie_common\push::knockdowninit;
  var_0._id_0E8A[12] = ::scripts\aitypes\zombie_common\push::knockdownterminate;
  var_0._id_0E8A[13] = ::scripts\aitypes\zombie_common\stun::_id_8A6C;
  var_0._id_0E8A[14] = ::scripts\aitypes\zombie_common\stun::_id_7CA9;
  var_0._id_0E8A[15] = ::scripts\aitypes\zombie_common\stun::idleinit;
  var_0._id_0E8A[16] = ::scripts\aitypes\zombie_common\stun::idleterminate;
  var_0._id_0E8A[17] = ::scripts\aitypes\zombie_common\distract::_id_4BA7;
  var_0._id_0E8A[18] = ::scripts\aitypes\zombie_common\awareness::isaware;
  var_0._id_0E8A[19] = ::scripts\aitypes\zombie_common\awareness::_id_7CA9;
  var_0._id_0E8A[20] = ::scripts\aitypes\zombie_common\awareness::idleinit;
  var_0._id_0E8A[21] = ::scripts\aitypes\zombie_common\awareness::idleterminate;
  var_0._id_0E8A[22] = ::scripts\aitypes\zombie_common\awareness::wander;
  var_0._id_0E8A[23] = ::scripts\aitypes\zombie_common\awareness::wanderinit;
  var_0._id_0E8A[24] = ::scripts\aitypes\zombie_common\awareness::wanderterminate;
  var_0._id_0E8A[25] = ::scripts\aitypes\zombie_common\move::shouldmoveaway;
  var_0._id_0E8A[26] = ::scripts\aitypes\zombie_common\move::moveaway;
  var_0._id_0E8A[27] = ::scripts\aitypes\zombie_common\move::moveawayinit;
  var_0._id_0E8A[28] = ::scripts\aitypes\zombie_common\move::moveawayterminate;
  var_0._id_0E8A[29] = _id_08EA::_id_352C;
  var_0._id_0E8A[30] = ::scripts\aitypes\zombie_common\move::checkfordoortoopen;
  var_0._id_0E8A[31] = _id_08EA::_id_341C;
  var_0._id_0E8A[32] = _id_08EA::_id_9CCB;
  var_0._id_0E8A[33] = _id_08EA::_id_DA06;
  var_0._id_0E8A[34] = _id_08EA::_id_DA19;
  var_0._id_0E8A[35] = _id_08EA::_id_D00D;
  var_0._id_0E8A[36] = _id_08EA::_id_A5E5;
  var_0._id_0E8A[37] = _id_08EA::_id_82BE;
  level._id_0B73["zombie_cp"] = var_0;
}

_id_C241() {
  _id_2509();
  _func_030B("zombie_cp");
}
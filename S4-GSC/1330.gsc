/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1330.gsc
*************************************************/

_id_2509() {
  if(isDefined(level._id_0B73["zombie_screamer"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_0E8A = [];
  var_0._id_0E8A[0] = ::scripts\aitypes\zombie_common\ai_util::_id_3558;
  var_0._id_0E8A[1] = ::scripts\aitypes\zombie_common\ai_util::_id_8AAE;
  var_0._id_0E8A[2] = ::scripts\aitypes\zombie_common\ai_util::haslegs;
  var_0._id_0E8A[3] = ::scripts\aitypes\zombie_common\push::shouldknockdown;
  var_0._id_0E8A[4] = ::scripts\aitypes\zombie_common\push::knockdownprocess;
  var_0._id_0E8A[5] = ::scripts\aitypes\zombie_common\push::knockdowninit;
  var_0._id_0E8A[6] = ::scripts\aitypes\zombie_common\push::knockdownterminate;
  var_0._id_0E8A[7] = ::scripts\aitypes\zombie_common\stun::_id_8A6C;
  var_0._id_0E8A[8] = ::scripts\aitypes\zombie_common\stun::_id_7CA9;
  var_0._id_0E8A[9] = ::scripts\aitypes\zombie_common\stun::idleinit;
  var_0._id_0E8A[10] = ::scripts\aitypes\zombie_common\stun::idleterminate;
  var_0._id_0E8A[11] = ::scripts\aitypes\zombie_common\distract::_id_4BA7;
  var_0._id_0E8A[12] = ::scripts\aitypes\zombie_common\awareness::isaware;
  var_0._id_0E8A[13] = ::scripts\aitypes\zombie_common\awareness::_id_7CA9;
  var_0._id_0E8A[14] = ::scripts\aitypes\zombie_common\awareness::idleinit;
  var_0._id_0E8A[15] = ::scripts\aitypes\zombie_common\awareness::idleterminate;
  var_0._id_0E8A[16] = ::scripts\aitypes\zombie_common\awareness::wander;
  var_0._id_0E8A[17] = ::scripts\aitypes\zombie_common\awareness::wanderinit;
  var_0._id_0E8A[18] = ::scripts\aitypes\zombie_common\awareness::wanderterminate;
  var_0._id_0E8A[19] = ::scripts\aitypes\zombie_common\move::shouldmoveaway;
  var_0._id_0E8A[20] = ::scripts\aitypes\zombie_common\move::moveaway;
  var_0._id_0E8A[21] = ::scripts\aitypes\zombie_common\move::moveawayinit;
  var_0._id_0E8A[22] = ::scripts\aitypes\zombie_common\move::moveawayterminate;
  var_0._id_0E8A[23] = _id_08EB::zombiescreamer_shouldexplodedoor;
  var_0._id_0E8A[24] = _id_08EB::zombiescreamer_explode;
  var_0._id_0E8A[25] = _id_08EB::zombiescreamer_shouldexplode;
  var_0._id_0E8A[26] = _id_08EB::_id_11090;
  var_0._id_0E8A[27] = _id_08EB::_id_1108D;
  var_0._id_0E8A[28] = _id_08EA::_id_D00D;
  var_0._id_0E8A[29] = ::scripts\aitypes\zombie_common\move::_id_7CA9;
  var_0._id_0E8A[30] = _id_08EB::_id_1108B;
  level._id_0B73["zombie_screamer"] = var_0;
}

_id_C241() {
  _id_2509();
  _func_030B("zombie_screamer");
}
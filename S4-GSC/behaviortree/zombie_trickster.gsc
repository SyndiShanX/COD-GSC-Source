/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: behaviortree\zombie_trickster.gsc
*************************************************/

_id_2509() {
  if(isDefined(level._id_0B73["zombie_trickster"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_0E8A = [];
  var_0._id_0E8A[0] = ::scripts\aitypes\zombie_common\ai_util::_id_3558;
  var_0._id_0E8A[1] = ::scripts\aitypes\zombie_common\ai_util::_id_8AAE;
  var_0._id_0E8A[2] = ::scripts\aitypes\zombie_common\move::checkfordoortoopen;
  var_0._id_0E8A[3] = ::scripts\aitypes\zombie_trickster\trickster::shouldbreakmask;
  var_0._id_0E8A[4] = ::scripts\aitypes\zombie_trickster\trickster::breakmask;
  var_0._id_0E8A[5] = ::scripts\aitypes\zombie_trickster\trickster::breakmask_init;
  var_0._id_0E8A[6] = ::scripts\aitypes\zombie_trickster\trickster::breakmask_terminate;
  var_0._id_0E8A[7] = ::scripts\aitypes\zombie_common\awareness::isaware;
  var_0._id_0E8A[8] = ::scripts\aitypes\zombie_common\awareness::_id_7CA9;
  var_0._id_0E8A[9] = ::scripts\aitypes\zombie_common\awareness::idleinit;
  var_0._id_0E8A[10] = ::scripts\aitypes\zombie_common\awareness::idleterminate;
  var_0._id_0E8A[11] = ::scripts\aitypes\zombie_common\awareness::wander;
  var_0._id_0E8A[12] = ::scripts\aitypes\zombie_common\awareness::wanderinit;
  var_0._id_0E8A[13] = ::scripts\aitypes\zombie_common\awareness::wanderterminate;
  var_0._id_0E8A[14] = ::scripts\aitypes\zombie_common\move::shouldmoveaway;
  var_0._id_0E8A[15] = ::scripts\aitypes\zombie_common\move::moveaway;
  var_0._id_0E8A[16] = ::scripts\aitypes\zombie_common\move::moveawayinit;
  var_0._id_0E8A[17] = ::scripts\aitypes\zombie_common\move::moveawayterminate;
  var_0._id_0E8A[18] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_shouldattack;
  var_0._id_0E8A[19] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_shouldfastattack;
  var_0._id_0E8A[20] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_fastattackupdate;
  var_0._id_0E8A[21] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_fastattackinit;
  var_0._id_0E8A[22] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_fastattackterminate;
  var_0._id_0E8A[23] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_attackupdate;
  var_0._id_0E8A[24] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_attackinit;
  var_0._id_0E8A[25] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_attackterminate;
  var_0._id_0E8A[26] = ::scripts\aitypes\zombie_trickster\trickster::shouldmoveawayfromenemy;
  var_0._id_0E8A[27] = ::scripts\aitypes\zombie_trickster\trickster::moveawayfromenemy;
  var_0._id_0E8A[28] = ::scripts\aitypes\zombie_trickster\trickster::moveawayfromenemy_init;
  var_0._id_0E8A[29] = ::scripts\aitypes\zombie_trickster\trickster::shouldchaseenemy;
  var_0._id_0E8A[30] = ::scripts\aitypes\zombie_trickster\trickster::_id_341C;
  var_0._id_0E8A[31] = ::scripts\aitypes\zombie_trickster\trickster::chaseenemy_init;
  var_0._id_0E8A[32] = ::scripts\aitypes\zombie_trickster\trickster::shouldrelocate;
  var_0._id_0E8A[33] = ::scripts\aitypes\zombie_trickster\trickster::relocate;
  var_0._id_0E8A[34] = ::scripts\aitypes\zombie_trickster\trickster::relocate_init;
  var_0._id_0E8A[35] = ::scripts\aitypes\zombie_trickster\trickster::relocate_terminate;
  var_0._id_0E8A[36] = ::scripts\aitypes\zombie_common\move::_id_7CA9;
  var_0._id_0E8A[37] = ::scripts\aitypes\zombie_trickster\trickster::zombietrickster_init;
  level._id_0B73["zombie_trickster"] = var_0;
}

_id_C241() {
  _id_2509();
  _func_030B("zombie_trickster");
}
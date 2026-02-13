/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_stun_grenade.gsc
****************************************************/

stun_grenade_used(var_0) {
  var_0 thread _id_0960::_id_A695("death", "end_explode");
  var_0 endon("end_explode");
  var_0 waittill("explode", var_1);
  var_2 = _func_0071(var_1, var_0._id_10D0B._id_014B);

  foreach(var_4 in var_2) {
    var_4 scripts\aitypes\zombie_common\stun::stun(3.0);
    _id_072A::addplayereffects("stun_grenade", var_4, var_0.owner, 3.0);
    var_0.owner _id_0752::_id_7003("stun_grenade_stunned_enemy", undefined, undefined, undefined, var_4);
  }

  if(isDefined(var_0.owner) && !isDefined(var_0.owner.triggeredkeepgrenade)) {
    var_6 = var_0.owner;

    if(isDefined(var_0._id_5562)) {
      var_7 = scripts\cp\utility::getequipmenttypeequipref(var_0._id_5562);

      if(isDefined(var_7)) {
        scripts\cp\cp_playerstats::incrementcategorystat(var_6, "tacticalStats", var_0._id_5562, "uses", 1);
      }
    }
  }
}
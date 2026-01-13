/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: behaviortree\zombie_sasquatch.gsc
*********************************************/

func_2AD0() {
  if(isDefined(level.var_119E["zombie_sasquatch"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.var_1581 = [];
  var_0.var_1581[0] = ::scripts\aitypes\zombie_sasquatch\behaviors::sasquatch_init;
  var_0.var_1581[1] = ::scripts\aitypes\zombie_sasquatch\behaviors::updateeveryframe;
  var_0.var_1581[2] = ::scripts\aitypes\zombie_sasquatch\behaviors::isintrees;
  var_0.var_1581[3] = ::scripts\aitypes\zombie_sasquatch\behaviors::shouldtaunt;
  var_0.var_1581[4] = ::scripts\aitypes\zombie_sasquatch\behaviors::dotaunt;
  var_0.var_1581[5] = ::scripts\aitypes\zombie_sasquatch\behaviors::taunt_init;
  var_0.var_1581[6] = ::scripts\aitypes\zombie_sasquatch\behaviors::taunt_cleanup;
  var_0.var_1581[7] = ::scripts\aitypes\zombie_sasquatch\behaviors::shouldmelee;
  var_0.var_1581[8] = ::scripts\aitypes\zombie_sasquatch\behaviors::melee_setup;
  var_0.var_1581[9] = ::scripts\aitypes\zombie_sasquatch\behaviors::melee_charge;
  var_0.var_1581[10] = ::scripts\aitypes\zombie_sasquatch\behaviors::melee_charge_init;
  var_0.var_1581[11] = ::scripts\aitypes\zombie_sasquatch\behaviors::melee_charge_cleanup;
  var_0.var_1581[12] = ::scripts\aitypes\zombie_sasquatch\behaviors::melee_attack;
  var_0.var_1581[13] = ::scripts\aitypes\zombie_sasquatch\behaviors::melee_attack_init;
  var_0.var_1581[14] = ::scripts\aitypes\zombie_sasquatch\behaviors::melee_attack_cleanup;
  var_0.var_1581[15] = ::scripts\aitypes\zombie_sasquatch\behaviors::shouldrush;
  var_0.var_1581[16] = ::scripts\aitypes\zombie_sasquatch\behaviors::rush_charge;
  var_0.var_1581[17] = ::scripts\aitypes\zombie_sasquatch\behaviors::rush_charge_init;
  var_0.var_1581[18] = ::scripts\aitypes\zombie_sasquatch\behaviors::rush_charge_cleanup;
  var_0.var_1581[19] = ::scripts\aitypes\zombie_sasquatch\behaviors::rush_attack;
  var_0.var_1581[20] = ::scripts\aitypes\zombie_sasquatch\behaviors::rush_attack_init;
  var_0.var_1581[21] = ::scripts\aitypes\zombie_sasquatch\behaviors::rush_attack_cleanup;
  var_0.var_1581[22] = ::scripts\aitypes\zombie_sasquatch\behaviors::shouldthrowrock;
  var_0.var_1581[23] = ::scripts\aitypes\zombie_sasquatch\behaviors::throwattack;
  var_0.var_1581[24] = ::scripts\aitypes\zombie_sasquatch\behaviors::throwattack_init;
  var_0.var_1581[25] = ::scripts\aitypes\zombie_sasquatch\behaviors::throwattack_cleanup;
  var_0.var_1581[26] = ::scripts\aitypes\zombie_sasquatch\behaviors::wander;
  var_0.var_1581[27] = ::scripts\aitypes\zombie_sasquatch\behaviors::wander_init;
  var_0.var_1581[28] = ::scripts\aitypes\zombie_sasquatch\behaviors::wander_cleanup;
  level.var_119E["zombie_sasquatch"] = var_0;
}

func_DEE8() {
  func_2AD0();
  btregistertree("zombie_sasquatch");
}
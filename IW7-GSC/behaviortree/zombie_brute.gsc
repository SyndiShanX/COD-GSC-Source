/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: behaviortree\zombie_brute.gsc
*****************************************/

func_2AD0() {
  if(isDefined(level.var_119E["zombie_brute"])) {
    return;
  }

  var_00 = spawnStruct();
  var_00.var_1581 = [];
  var_00.var_1581[0] = ::scripts\aitypes\zombie_brute\behaviors::initzombiebrute;
  var_00.var_1581[1] = ::scripts\aitypes\zombie_brute\behaviors::destroyfrozenzombies;
  var_00.var_1581[2] = ::lib_0C2B::func_3E48;
  var_00.var_1581[3] = ::lib_0C2B::func_3E29;
  var_00.var_1581[4] = ::scripts\aitypes\zombie_brute\behaviors::updatehelmet;
  var_00.var_1581[5] = ::scripts\aitypes\zombie_brute\behaviors::updatezombietarget;
  var_00.var_1581[6] = ::scripts\aitypes\zombie_brute\behaviors::cangrabzombie;
  var_00.var_1581[7] = ::scripts\aitypes\zombie_brute\behaviors::process_grabzombie;
  var_00.var_1581[8] = ::scripts\aitypes\zombie_brute\behaviors::init_grabzombie;
  var_00.var_1581[9] = ::scripts\aitypes\zombie_brute\behaviors::terminate_grabzombie;
  var_00.var_1581[10] = ::scripts\aitypes\zombie_brute\behaviors::candorangeattack;
  var_00.var_1581[11] = ::scripts\aitypes\zombie_brute\behaviors::process_rangeattack;
  var_00.var_1581[12] = ::scripts\aitypes\zombie_brute\behaviors::init_rangeattack;
  var_00.var_1581[13] = ::scripts\aitypes\zombie_brute\behaviors::terminate_rangeattack;
  var_00.var_1581[14] = ::scripts\aitypes\zombie_brute\behaviors::canseethroughfoliage;
  var_00.var_1581[15] = ::scripts\aitypes\zombie_brute\behaviors::process_laserattack;
  var_00.var_1581[16] = ::scripts\aitypes\zombie_brute\behaviors::init_laserattack;
  var_00.var_1581[17] = ::scripts\aitypes\zombie_brute\behaviors::terminate_laserattack;
  var_00.var_1581[18] = ::scripts\aitypes\zombie_brute\behaviors::shoulddoempattack;
  var_00.var_1581[19] = ::scripts\aitypes\zombie_brute\behaviors::process_empattack;
  var_00.var_1581[20] = ::scripts\aitypes\zombie_brute\behaviors::init_empattack;
  var_00.var_1581[21] = ::scripts\aitypes\zombie_brute\behaviors::terminate_empattack;
  var_00.var_1581[22] = ::lib_0C2B::chaseenemy;
  var_00.var_1581[23] = ::lib_0C2B::seekenemy;
  var_00.var_1581[24] = ::lib_0C2B::notargetfound;
  level.var_119E["zombie_brute"] = var_00;
}

func_DEE8() {
  func_2AD0();
  btregistertree("zombie_brute");
}
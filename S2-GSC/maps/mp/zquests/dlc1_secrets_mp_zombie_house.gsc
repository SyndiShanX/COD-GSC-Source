/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\dlc1_secrets_mp_zombie_house.gsc
************************************************************/

init_dlc1_secrets_mp_zombie_house() {
  lib_0565::zombiegearchallengeregister("mountain_man_blood_set", [::mountain_blood_0, ::mountain_blood_1, ::mountain_blood_2]);
}

mountain_blood_0() {
  var_00 = self;
  var_00 endon("enter_last_stand");
  level waittill(maps\mp\gametypes\zombies::get_round_complete_notify(30));
  return 1;
}

mountain_blood_1() {
  var_00 = self;
  var_00 endon("damage");
  level waittill(maps\mp\gametypes\zombies::get_round_complete_notify(20));
  return 1;
}

mountain_blood_2() {
  level waittill("fireman_killed");
  return 1;
}
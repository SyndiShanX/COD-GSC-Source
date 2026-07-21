/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_events.gsc
***********************************************/

disable_spawnpoints_in_hangar() {
  var_0 = getdvarint("_encstr_AD030EE61B937D4C4ED7593BCAB947CD", 0);

  if(!var_0 || var_0 > 4) {
    return;
  }
  thread _id_12E04(var_0);
}

disable_spawner(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(istrue(var_0.delay_enter_combat_after_investigating_grenade) || !isalive(var_0) || istrue(var_0.gulag))
    return 0;

  return 1;
}

_id_12E04(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::turret_headicon()) {
    return;
  }
  var_1 = "_encstr_8E920D26EBE63981A361DB5D376A4B" + var_0;
  var_2 = getdvarfloat(var_1 + "_encstr_B1D90877CF33126EE059", 0.04);

  if(var_2 <= randomfloat(1.0)) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_3 = getdvarfloat(var_1 + "_encstr_B8D61099C76D675BBBCF7BCBADBDE1858748", 180);
  var_4 = getdvarfloat(var_1 + "_encstr_87D610FAE64716271DD78E4BB5B2BEADC2F0", 300);
  var_5 = randomfloat(var_4 - var_3) + var_3;
  wait(var_5);

  foreach(var_7 in level.players) {
    if(!disable_spawner(var_7)) {
      continue;
    }
    self setclientomnvar("_encstr_A6B50D67F85EDA9B7F75538FE801C3", var_0);
  }
}
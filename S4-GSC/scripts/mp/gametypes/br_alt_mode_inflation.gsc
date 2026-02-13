/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_inflation.gsc
**********************************************************/

init() {
  if(!getdvarint("#x38883117c8c32178", 0)) {
    return;
  }
  level._id_29F8 = spawnStruct();
  level._id_29F8._id_4A88 = 0;
  level._id_29F8._id_3D91 = getdvarint("#x36841c20bd0106998", 45);
  level._id_29F8._id_4FF8 = getdvarfloat("#x3d217101860d83df6", 1.0);
  level._id_1F51 = getdvarfloat("#x37da5c815a3a02b2f", 10.0);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerDropPlunderOnDeath", ::_id_B69D);
  scripts\mp\gametypes\br_gametypes::_id_C243("circleTimer", ::_id_3734);

  if(!getdvarint("#x3fa388cb435d95f87", 0)) {
    scripts\mp\gametypes\br_gametypes::_id_4AB8("gulag");
  }

  level._id_7DE9 = 0.0;
  level._id_C6C4 = 0;
}

_id_B69D(var_0, var_1) {
  var_2 = self._id_B956;

  if(istrue(level._id_2AA8) && !level._id_29F8._id_4A88 && var_2 >= level._id_29F8._id_3D91) {
    var_2 = var_2 - level._id_29F8._id_3D91;
    self._id_7E92 = 1;
  }

  var_2 = int(var_2 * level._id_29F8._id_4FF8);
  scripts\mp\gametypes\br_plunder::_id_B7A3(0);
  scripts\mp\gametypes\br_plunder::_id_5026(var_2, var_0);
  return 1;
}

_id_3734(var_0) {
  if(!var_0) {
    scripts\mp\gametypes\br_gulag::_id_D87A();
  }

  var_1 = scripts\mp\gametypes\br_gulag::_id_6A83();

  if(!level._id_29F8._id_4A88 && var_0 >= var_1) {
    level._id_29F8._id_4A88 = 1;

    foreach(var_3 in level.players) {
      if(!isDefined(var_3) || !isalive(var_3)) {
        continue;
      }
      scripts\mp\gametypes\br_killstreaks::_id_4343(var_3, "gulag_closed", undefined, 2);
    }
  }

  return 0;
}
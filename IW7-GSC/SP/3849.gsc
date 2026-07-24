/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3849.gsc
**************************************/

_id_1139A() {}

_id_6A23() {
  scripts\engine\utility::flag_init("flag_mount_fighter");
  _id_0F35::main();
  level.player thread _id_88FA();
}

_id_88FA(var_0) {
  self endon("death");
  level endon("gravity_special_case");

  if(!scripts\engine\utility::flag_exist("holdGravityShift")) {
    scripts\engine\utility::flag_init("holdGravityShift");
  }

  if(!scripts\engine\utility::is_true(var_0)) {
    _id_0F35::_id_FB24(1, level.player);
    _id_0F35::_id_FB25(1, 1);
    _id_0F31::_id_17A0();
    _id_0F31::_id_17A5();
    _id_0F31::_id_17A4();
  }

  if(!scripts\sp\utility::_id_65DF("player_gravity_off")) {
    scripts\sp\utility::_id_65E0("player_gravity_off");
  }

  scripts\sp\utility::_id_65E1("player_gravity_off");

  if(scripts\engine\utility::flag_exist("player_in_gravity")) {
    scripts\engine\utility::waitframe();

    for(;;) {
      scripts\engine\utility::flag_wait("player_in_gravity");
      scripts\engine\utility::flag_waitopen("holdGravityShift");

      if(scripts\sp\utility::_id_65DB("player_gravity_off")) {
        scripts\sp\utility::_id_65DD("player_gravity_off");
      }

      _id_0F35::_id_FB24(0, level.player);
      _id_0F35::_id_FB25(0, 0);
      _id_0F31::_id_E0C8();
      _id_0F31::_id_E0CE();
      _id_0F31::_id_E0CD();
      scripts\engine\utility::flag_waitopen("player_in_gravity");
      scripts\engine\utility::flag_waitopen("holdGravityShift");

      if(scripts\engine\utility::flag("player_in_gravity")) {
        continue;
      }
      if(!scripts\sp\utility::_id_65DB("player_gravity_off")) {
        scripts\sp\utility::_id_65E1("player_gravity_off");
      }

      _id_0F35::_id_FB24(1, level.player);
      _id_0F35::_id_FB25(1, 1);
      _id_0F31::_id_17A0();
      _id_0F31::_id_17A5();
      _id_0F31::_id_17A4();
    }
  }
}

_id_625C() {
  level.player allowswim(0);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player _meth_84F0(1);
  level.player setactionslot(1, "autolevel");
  level.player setactionslot(3, "rollleft");
  level.player setactionslot(4, "rollright");
}

_id_55A9() {
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player _meth_84F0(0);
  level.player setactionslot(3, "");
  level.player setactionslot(4, "");
}
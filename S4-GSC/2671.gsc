/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2671.gsc
*************************************************/

_id_906A() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lastStandHeal_unset");
  waittillframeend;
  thread _id_906E();
  self._id_9068 = 1;

  for(;;) {
    if(self._id_9068 && (!istrue(self.inlaststand) || istrue(self._id_EA91) || istrue(scripts\mp\playerlogic::_id_690A()))) {
      var_0 = scripts\mp\supers::getcurrentsuper()._id_E76B._id_04F6;
      self _meth_84EA();

      if(isDefined(var_0)) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
      }

      self._id_9068 = 0;
    } else if(!self._id_9068 && istrue(self.inlaststand) && !istrue(self._id_EA91) && !istrue(scripts\mp\playerlogic::_id_690A())) {
      var_0 = scripts\mp\supers::getcurrentsuper()._id_E76B._id_04F6;
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
      var_1 = scripts\engine\utility::ter_op(scripts\mp\supers::_id_8A7B(), 1, 0);
      self setweaponammoclip(var_0, var_1);
      self _meth_84E9(var_0);
      self._id_9068 = 1;
    }

    wait 0.05;
  }
}

_id_906D() {
  self notify("lastStandHeal_unset");
}

_id_906E() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lastStandHeal_unset");

  for(;;) {
    self waittill("spawned_player");
    waittillframeend;
    _id_9069();
  }
}

_id_9069() {
  var_0 = scripts\mp\supers::getcurrentsuper()._id_E76B._id_04F6;
  self _meth_84EA();

  if(isDefined(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
  }

  self._id_9068 = 0;
}

_id_9065() {
  thread _id_906C();
  thread _id_906B();
  return 1;
}

_id_906C() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("last_stand_finished");
  scripts\engine\utility::delaythread(0.05, ::_id_9066);
  self._id_9070 = 1;
  self notify("last_stand_heal_active");
  self notify("handle_revive_message");
  scripts\common\utility::_id_1559(0);
  wait 0.45;
  self playlocalsound("laststand_heal_start");
  self notify("force_regeneration");

  while(self.health < self.maxhealth) {
    waitframe();
  }

  scripts\common\utility::_id_1559(1);
  scripts\mp\supers::_id_EB50(undefined, undefined, undefined, 1);
  self playlocalsound("laststand_heal_done");
  self notify("last_stand_heal_success");
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "use_self_revive");
}

_id_9066() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("last_stand_heal_success");

  for(;;) {
    scripts\mp\supers::_id_C17E(5, 0, 1);
    var_0 = scripts\mp\supers::getcurrentsuper();

    if(var_0._id_FEA3 <= 0) {
      return;
    }
  }
}

_id_906B() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::_id_1089F("death", "last_stand_finished");
  self._id_9070 = 0;
}

_id_9067() {
  return 2;
}
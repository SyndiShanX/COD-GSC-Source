/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2590.gsc
*************************************************/

_id_10D79() {
  level._effect["weapon_drop_impact"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
}

_id_10D73() {
  thread _id_10D78();
  return 1;
}

_id_10D78() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waitframe();
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("weapondrop", self);
  var_0._id_47EE = makeweapon("deploy_weapondrop_mp");
  scripts\common\utility::_id_154F(0);
  var_1 = _id_09B9::_id_EA03(var_0, var_0._id_47EE, "grenade_fire");
  scripts\common\utility::_id_154F(1);

  if(istrue(var_1)) {
    var_0 notify("killstreak_finished_with_deploy_weapon");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
    }
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
}

_id_10D7C(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 waittill("explode", var_1);
  var_0 _id_10D76(self, var_1);
  return 1;
}

_id_10D76(var_0, var_1) {
  var_2 = var_0 _id_09B5::_id_47A2(var_1, ::_id_10D77);

  if(isDefined(var_2)) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("military_crate_field_upgrade_01");
    var_3 setotherent(var_0);
    var_3.owner = var_0;
    var_3.team = var_0.team;
    var_3 linkto(var_2, "tag_origin", (0, 0, -15), (0, 0, 0));
    var_3 _meth_86FE("killstreak");
    var_3 _meth_8706(var_0.team);
    var_2._id_47A1 = var_3;
    var_2 thread _id_10D75(var_3);
  }
}

_id_10D77() {
  self._id_47A1 _id_10D74();
}

_id_10D75(var_0) {
  level endon("game_ended");
  level endon("prematch_cleanup");
  var_0 endon("deliveryBox_dropped");
  var_0 endon("death");
  self waittill("death");
  var_0 thread _id_10D74();
}

_id_10D74() {
  if(istrue(self._id_7558)) {
    return;
  }
  self._id_7558 = 1;
  self notify("deliveryBox_dropped");
  self unlink();
  _id_3E99();
  var_0 = self.origin - (0, 0, 1000);
  scripts\cp_mp\utility\killstreak_utility::_id_8DAE(var_0, 100, 1000, 30.0, self.owner, self.team);
  thread _id_10ABA();
  thread _id_10ABC();
}

_id_4760() {
  _id_3E98();
  self delete();
}

_id_3E99() {
  if(istrue(self._id_B051)) {
    return;
  }
  self._id_B051 = 1;
  self._id_F9A8 = 1;
  self physicslaunchserver((0, 0, 0), (0, 0, 0), 1200);
  var_0 = self _meth_846E(0);
  _func_02D8(var_0, (0, 0, -1));
  self physics_registerforcollisioncallback();
}

_id_3E98() {
  if(!istrue(self._id_B051)) {
    return;
  }
  self notify("crate_physics_off");
  self._id_B051 = undefined;
  self._id_F9A8 = undefined;
  self _meth_8545();
  self _meth_84FD();
  self stoploopsound("mp_care_package_drop_lp");
  scripts\cp_mp\utility\killstreak_utility::_id_8DB2();
}

_id_10ABC() {
  self endon("crate_physics_off");
  _id_10ABD();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
      thread _id_4760();
      return;
    }
  }

  self.owner thread _id_09FE::_id_1704(self);
  thread _id_3E98();
}

_id_10ABD() {
  wait 1;
  var_0 = gettime() + 10000;

  while(gettime() < var_0) {
    var_1 = self _meth_846E(0);
    var_2 = _func_02A1(var_1);

    if(_func_0135(var_2) <= 0.5) {
      break;
    }

    waitframe();
  }
}

_id_10ABA(var_0) {
  self endon("crate_physics_off");
  self playLoopSound("mp_care_package_drop_lp");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  var_1 = 0;

  for(;;) {
    self waittill("collision", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9 _id_09B5::_id_889D()) {
      var_9 thread _id_09B5::_id_786B();
    }

    if(gettime() - var_1 >= 200) {
      var_1 = gettime();
      var_10 = _func_02CA(var_5);
      var_11 = _func_00D6(var_10["name"], 9);

      if(var_11 == "user_terrain1") {
        var_11 = "user_terrain_1";
      }

      _id_B37C(var_6, var_7, var_8, var_11);
    }
  }
}

_id_B37C(var_0, var_1, var_2, var_3) {
  playFX(scripts\engine\utility::getfx("weapon_drop_impact"), var_0, var_1);

  if(var_2 < 150) {
    self _meth_8281("mp_care_package_low_impact", var_3);
  } else if(var_2 < 300) {
    self _meth_8281("mp_care_package_med_impact", var_3);
  } else {
    self _meth_8281("mp_care_package_high_impact", var_3);
  }

  self stoploopsound("mp_care_package_drop_lp");
}
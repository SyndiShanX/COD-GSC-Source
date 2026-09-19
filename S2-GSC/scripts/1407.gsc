/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1407.gsc
**************************************/

init() {
  thread _id_7BAD();
  _id_522E();
  var_0 = undefined;
  thread maps\mp\_utility::_id_6F74(::_id_A8DF, var_0);
  level._id_A9C8["raven_sword_zm"] = ::_id_7A7C;
  level._id_62B3["raven_sword_zm"] = ::_id_7A7E;
  level.activeswordname = "raven_sword_zm+" + maps\mp\gametypes\_class::_id_A9EE("zom_raven");
  _id_0547::_id_7BA9(::_id_7A7F);
}

_id_522E() {
  if(!isDefined(level._id_6DF9))
    level._id_6DF9 = [];

  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (42.816, 5.533, 0);
  var_2 = length(var_1);
  level._id_6DF9["default"]["raven_sword_zm"]["hit_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  level._id_6DF9["default"]["raven_sword_zm"]["hit_zombie_action"] = "pain_paired_melee_raven_sword";
  level._id_6DF9["default"]["raven_sword_zm"]["fatal_worldmodel_anim"] = "va_melee_raven_sword_hit_world";
  level._id_6DF9["default"]["raven_sword_zm"]["fatal_zombie_action"] = "death_melee_raven_sword_zm";
  level._id_6DF9["default"]["raven_sword_zm"]["dismemberment_override"] = var_0;
  level._id_6DF9["default"]["raven_sword_zm"]["fatal_zombie_pos"] = var_1;
  level._id_6DF9["default"]["raven_sword_zm"]["fatal_zombie_dist"] = var_2;
  level._id_6DF9["heavy"]["raven_sword_zm"]["fatal_worldmodel_anim"] = "va_npc_melee_raven_sword_hit_crit_long";
  level._id_6DF9["heavy"]["raven_sword_zm"]["fatal_zombie_action"] = "death_melee_heavy_raven_sword_zm";
  level._id_6DF9["heavy"]["raven_sword_zm"]["dismemberment_override"] = var_0;
  level._id_6DF9["heavy"]["raven_sword_zm"]["fatal_zombie_pos"] = var_1;
  level._id_6DF9["heavy"]["raven_sword_zm"]["fatal_zombie_dist"] = var_2;
  level._id_6DF9["heavy"]["raven_sword_zm"]["no_flinch_time"] = 4;
}

_id_7BAD() {
  level._effect["zmb_raven_sword_burst"] = loadfx("vfx/zombie/zmb_sword_burst");
  level._effect["zmb_raven_sword_touch_of_death_aoe"] = loadfx("vfx/explosion/zmb_sword_tod_aoe");
  level._effect["zmb_sword_activate"] = loadfx("vfx/zombie/zmb_sword_activate");
  level._effect["zmb_sword_impale_head"] = loadfx("vfx/blood/zmb_sword_impale_head");
  level._effect["zmb_sword_slice"] = loadfx("vfx/blood/zmb_sword_slice");
}

_id_4B3A() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "raven_sword_zm");
}

_id_A8DF(var_0) {
  _id_5242();
  var_1 = 0;

  for(;;) {
    var_2 = _id_4B3A();

    if(var_1 != var_2) {
      if(var_2)
        thread _id_7A7B();
      else
        thread _id_7A7D();

      var_1 = var_2;
    }

    common_scripts\utility::_id_A70A("weapon_taken", "weapon_given");
  }
}

_id_7A7E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 _meth_8661()) {
    if(var_1 _id_0547::_id_1F54(var_0, var_4))
      return var_2;
    else
      return 0;
  }

  var_8 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);

  if(var_1._id_7A8D._id_08BE) {
    var_1 _id_90F2(1);
    var_8 = var_8 * 2;
  } else
    var_8 = int(_func_0D5(var_8 / 2.0));

  return int(max(var_2, var_8));
}

_id_7A7B() {
  thread _id_7A84();
}

_id_7A7D() {
  self notify("raven_sword_lost");
}

_id_7A84() {
  self endon("raven_sword_lost");
  thread _id_5FC5();
  thread _id_5FC4();
}

_id_5242() {
  if(!isDefined(self._id_7A8D)) {
    self._id_7A8D = spawnStruct();
    self._id_7A8D._id_08BE = 0;
    self._id_7A8D._id_20F0 = 0;
    self._id_7A8D._id_5A50 = 0;
    self._id_7A8D._id_9AC4 = 0;
  }
}

_id_7A80() {
  self._id_7A8D._id_08BE = 1;

  while(self _meth_8661() || self _meth_8128())
    waitframe();

  var_0 = self getcurrentweapon();
  _id_0586::_id_0790("raven_sword_zm");
  _id_0586::_id_078C(level.activeswordname);

  if(issubstr(var_0, "raven_sword"))
    self _meth_831B(level.activeswordname);

  wait 0.1;
  thread _id_7119();
}

_id_7119() {
  var_0 = self getcurrentweapon();

  if(var_0 == level.activeswordname && self._id_7A8D._id_08BE == 1) {
    var_1 = common_scripts\utility::_id_44F5("zmb_sword_activate");
    self._id_7A8D._id_35A6 = _func_2A8(var_1, self, "TAG_WW_MELEE_FX", 1);
    _func_14C(self._id_7A8D._id_35A6);
    _id_0378::_id_8D74("aud_raven_sword_power_up");
  }

  while(common_scripts\utility::_id_562E(self._id_7A8D._id_08BE)) {
    common_scripts\utility::_id_A70A("weapon_given", "weapon_taken", "zombie_player_spawn_finished", "melee_weapon_change", "weapon_switch_started");
    waitframe();

    while(self _meth_833B())
      waitframe();

    var_0 = self getcurrentweapon();

    if(var_0 == level.activeswordname && self._id_7A8D._id_08BE == 1) {
      var_1 = common_scripts\utility::_id_44F5("zmb_sword_activate");
      self._id_7A8D._id_35A6 = _func_2A8(var_1, self, "TAG_WW_MELEE_FX", 1);
      _func_14C(self._id_7A8D._id_35A6);
      _id_0378::_id_8D74("aud_raven_sword_power_up");
      continue;
    }

    if(isDefined(self._id_7A8D._id_35A6)) {
      _id_0378::_id_8D74("aud_raven_sword_power_dwn");
      self._id_7A8D._id_35A6 delete();
      self._id_7A8D._id_35A6 = undefined;
    }
  }
}

_id_7A81() {
  self._id_7A8D._id_08BE = 0;
  var_0 = self getcurrentweapon();
  _id_0586::_id_0790(level.activeswordname);
  _id_0586::_id_078C("raven_sword_zm");

  if(issubstr(var_0, "raven_sword"))
    self _meth_831B("raven_sword_zm");

  _id_0378::_id_8D74("aud_raven_sword_power_dwn");

  if(isDefined(self._id_7A8D) && isDefined(self._id_7A8D._id_35A6)) {
    self._id_7A8D._id_35A6 delete();
    self._id_7A8D._id_35A6 = undefined;
  }
}

_id_9E06(var_0) {
  if(!self._id_7A8D._id_08BE) {
    if(common_scripts\utility::_id_562E(var_0))
      self._id_7A8D._id_5A50 = self._id_7A8D._id_5A50 + 10;
    else
      self._id_7A8D._id_5A50++;

    if(self._id_7A8D._id_5A50 >= 20) {
      self._id_7A8D._id_20F0 = 12;
      self._id_7A8D._id_5A50 = 0;
      wait 0.45;
      _id_7A80();
    }
  }
}

_id_90F2(var_0) {
  self._id_7A8D._id_20F0 = self._id_7A8D._id_20F0 - var_0;

  if(self._id_7A8D._id_20F0 <= 0)
    _id_7A81();
}

_id_5FC5() {
  self endon("raven_sword_lost");

  for(;;) {
    self waittill("paired_heavy_melee_kill");

    if(self._id_7A8D._id_08BE) {
      _id_90F2(4);
      thread _id_9AB9();

      while(self _meth_8661())
        waitframe();

      continue;
    }

    while(self _meth_8661())
      waitframe();
  }
}

_id_9AB9() {
  self endon("death");
  self endon("disconnect");
  self endon("touch_of_death_aoe_cleanup");
  var_0 = common_scripts\utility::_id_44F5("zmb_raven_sword_touch_of_death_aoe");
  playFX(var_0, self.origin);
  self._id_7A8D._id_9AC4 = 1;
  var_1 = gettime();
  _id_0547::_id_09E9(self, "touch_of_death_aoe");
  thread _id_9ABA();

  while(gettime() < var_1 + 6000) {
    var_2 = _id_0547::_id_408F();

    foreach(var_4 in _func_1AC(var_2, self.origin, 100)) {
      var_5 = var_4.health;

      if(var_4 _id_0547::_id_53DC())
        var_5 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980) * 0.1;

      var_4 _meth_8059(var_5, self.origin, self, self, "MOD_MELEE", "raven_sword_tod_aoe_zm", "none");
      waitframe();
    }

    wait 0.5;
  }

  self notify("touch_of_death_aoe_complete");
}

_id_9ABA() {
  common_scripts\utility::_id_A70A("death", "disconnect", "touch_of_death_aoe_complete");
  _id_0547::_id_7CF8(self, "touch_of_death_aoe");
  self._id_7A8D._id_9AC4 = 0;
  self notify("touch_of_death_aoe_cleanup");
}

_id_5FC4() {
  self endon("raven_sword_lost");

  for(;;) {
    self waittill("melee_fired", var_0);

    if(issubstr(var_0, "raven_sword_zm") && self _meth_8661()) {
      wait 0.45;
      self._id_99FE = gettime();

      if(isDefined(self._id_9A00) && self._id_99FE > self._id_9A00 + 400)
        _id_2416();

      self._id_9A00 = gettime();
      wait 0.3;

      while(self _meth_8661())
        waitframe();
    }
  }
}

_id_2416() {
  var_0 = 72;
  var_1 = 120;
  var_2 = 800;
  var_3 = 0.5;

  if(self._id_7A8D._id_08BE && !self._id_7A8D._id_9AC4) {
    _id_90F2(2);
    var_0 = 109;
    var_1 = 120;
    var_2 = 1;
    var_3 = 5;
    var_4 = common_scripts\utility::_id_44F5("zmb_raven_sword_burst");
    playFX(var_4, self.origin + (0, 0, 40));
    _id_0378::_id_8D74("aud_raven_sword_aoe");
  }

  var_5 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);
  var_6 = int(var_2) + int(var_3 * var_5);
  var_7 = _id_0586::zombies_hit_by_melee_cone(var_0, var_1);

  foreach(var_9 in var_7) {
    var_9 _meth_8059(var_6, self getEye(), self, self, "MOD_MELEE", "raven_sword_cleave_zm", "none");

    if(isDefined(var_9._id_0A4B)) {
      var_10 = _id_0547::_id_0A51(var_9._id_0A4B);

      if(isDefined(var_10) && common_scripts\utility::_id_562E(var_10.knockbyravensword)) {
        if(var_10._id_0A4B != "zombie_heavy" && self._id_7A8D._id_08BE)
          _id_0547::_id_7D1B(self, var_9, "close");
        else
          _id_0547::_id_7D1B(self, var_9, "far");
      }
    }

    waitframe();
  }
}

_id_7A7C(var_0) {
  if(!self _meth_8343())
    return 0;

  return 1;
}

_id_7A7F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1 _id_4B3A()) {
    var_9 = _func_05F(var_4);
    var_10 = 0;

    switch (var_9) {
      case "raven_sword_zm":
        if(common_scripts\utility::_id_562E(self._id_0103))
          var_10 = 1;
      case "raven_sword_cleave_zm":
        var_1 _id_9E06(var_10);
        break;
    }
  }
}
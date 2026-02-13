/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2333.gsc
*************************************************/

_id_A159() {
  level._id_1E2D = [];
  level._id_0F23 = [];
  level._id_42A4 = ::monkey_in_bounds;
  level._effect["monkey_bomb_armed"] = loadfx("vfx/s4/zombie_weapon/vfx_monkey_bomb_light");
  level._effect["monkey_bomb_oob"] = loadfx("vfx/s4/zombie_weapon/vfx_monkey_bomb_despawn");
  level.aether_grenade_tag_overrides["s4_monkey_bomb_zm"] = "j_weapon";
  thread _id_7F16();
  thread _id_10A73();
}

_id_7F16() {
  level waittill("equipment_initialized");
  _id_0728::_id_10AB("equip_monkey_bomb", "onGive", ::_id_A15A);
  _id_0728::_id_10AB("equip_monkey_bomb", "onTake", ::_id_A15B);
}

_id_A15A(var_0, var_1) {}

_id_A15B(var_0, var_1) {}

_id_A15C(var_0) {
  var_0 endon("death");
  var_0 hide();
  var_0.angles = self.angles;
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("wpn_s4_zm_monkey_bomb_main_world");
  var_1._id_0203 = var_0;

  if(istrue(var_0.isaethergrenade)) {
    var_1 thread scripts\cp\cp_weapon::apply_aether_grenade_effects(var_0.weapon_name);
  }

  var_0._id_A15E = var_1;
  var_0._id_A15E linkto(var_0);
  var_0._id_A15E.originating_player = self;
  var_0 playSound("zmb_monkey_throw_vox");
  level._id_1E2D = scripts\engine\utility::array_add(level._id_1E2D, var_0._id_A15E);
  var_0 thread kill_on_throw_timeout(var_1);
  var_0 waittill("missile_stuck", var_2);
  var_0 playSound("zmb_monkey_land_vox");

  if(!isDefined(var_0) && isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_0) && isDefined(var_0._id_A15E)) {
    var_3 = scripts\cp\utility::_id_459B(self, undefined);
    var_0._id_A15E._id_39E4 = _func_02AB(var_0._id_A15E.origin, var_3);
    level._id_0F23 = scripts\engine\utility::array_add(level._id_0F23, var_0._id_A15E);
  }
}

kill_on_throw_timeout(var_0) {
  self endon("missile_stuck");
  wait 45.0;

  if(_func_0458(self)) {
    if(!_func_0458(var_0)) {
      var_0 delete();
    }
  } else
    _id_7151(self, undefined);
}

_id_10A73() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level._id_0F23) {
      if(!isDefined(var_1) || istrue(var_1._id_F615)) {
        continue;
      }
      if(!isDefined(var_1._id_0203)) {
        scripts\aitypes\zombie_common\distract::remove_distraction(var_1);
        var_1 delete();
        continue;
      }

      var_1 thread _id_AF96();
      waitframe();
    }

    level._id_1E2D = scripts\engine\utility::_id_1BD1(level._id_1E2D, 0);
    level._id_0F23 = scripts\engine\utility::_id_1BD1(level._id_0F23, 0);
    waitframe();
  }
}

monkey_in_bounds(var_0) {
  if(!isDefined(self._id_39E4)) {
    return 0;
  }

  var_1 = distancesquared(var_0, self._id_39E4);
  return var_1 <= 10000.0;
}

_id_AF96() {
  self endon("death");
  self unlink();
  waitframe();
  self._id_F615 = 1;

  if(isDefined(level._id_42A4) && ![[level._id_42A4]](self.origin)) {
    scripts\engine\utility::array_remove(level._id_1E2D, self);
    level thread _id_7151(self._id_0203, self);
    return;
  } else if(isDefined(self._id_39E4) && isDefined(self._id_0203)) {
    var_0 = [];
    var_0 = scripts\engine\utility::array_add(var_0, "normal");
    scripts\aitypes\zombie_common\distract::add_distraction(self, var_0);
  }

  thread play_armed_effects();

  if(isDefined(level._id_42A3)) {
    [[level._id_42A3]](self);
  } else if(_func_0205("zmb_monkey_song")) {
    self playLoopSound("zmb_monkey_song");
  }

  self _meth_82CB("s4_zm_monkey_bomb_dance");
  thread _id_4BF1();
  var_1 = gettime() + scripts\cp\utility::_id_CFF0(7.0);

  while(gettime() < var_1) {
    if(!isDefined(self._id_0203)) {
      break;
    }

    waitframe();
  }

  _id_A15D();
}

play_armed_effects() {
  self endon("death");
  wait 0.15;

  if(_func_03CD(self.model, "j_weapon")) {
    playFXOnTag(scripts\engine\utility::getfx("monkey_bomb_armed"), self, "j_weapon");
  }
}

_id_4BF1() {
  self endon("death");
  wait 6.5;

  if(_func_0205("")) {
    self playSound("");
  }

  self.originating_player _id_0720::_id_BEC0("kill_monkey");
}

_id_A15D() {
  if(isDefined(self._id_0203)) {
    if(_func_0205("zmb_monkey_explo")) {
      self playSound("zmb_monkey_explo");
    }

    self.originating_player _id_0720::_id_BEC0("kill_monkey");
    self._id_0203 detonate();
  }

  self delete();
}

_id_7151(var_0, var_1) {
  if(!isDefined(var_0._id_A15E)) {
    return;
  }
  var_2 = var_0._id_A15E.origin;
  var_2 = (var_2[1], var_2[0], 0);

  if(var_2[1] < 0 || var_2[0] > 0 && var_2[1] > 0) {
    var_2 = (var_2[0], var_2[1] * -1, 0);
  } else if(var_2[0] < 0) {
    var_2 = (var_2[0] * -1, var_2[1], 0);
  }

  if(_func_0205("")) {
    var_3 = scripts\cp\utility::_id_6C5C();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(isalive(var_3[var_4])) {
        var_3[var_4] playlocalsound("");
      }
    }
  }

  var_0._id_A15E unlink();
  waitframe();

  if(_func_03CD(var_0._id_A15E.model, "j_weapon")) {
    playFXOnTag(scripts\engine\utility::getfx("monkey_bomb_oob"), var_0._id_A15E, "j_weapon");
  }

  var_0._id_A15E movez(60, 1.0, 0.25, 0.25);
  var_0._id_A15E _meth_844B(var_2, 1.5, 2.5, 1.0);
  var_0._id_A15E waittill("movedone");
  var_0._id_A15E delete();

  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_42E1)) {
      var_0._id_42E1 delete();
    }

    var_0 delete();
  }
}

destroy_monkey_bomb() {
  var_0 = self._id_0203;

  if(_func_03CD(self.model, "j_weapon")) {
    playFXOnTag(scripts\engine\utility::getfx("monkey_bomb_oob"), self, "j_weapon");
  }

  wait 0.1;

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_42E1)) {
      var_0._id_42E1 delete();
    }

    var_0 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}
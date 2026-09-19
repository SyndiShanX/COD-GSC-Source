/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1379.gsc
**************************************/

init() {
  level._id_0A41["zombie_exploder"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_exploder"]["think"] = ::_id_ABA0;
  level._id_0A41["zombie_exploder"]["spawn"] = ::_id_AB9F;
  level._id_0A41["zombie_exploder"]["on_damaged_finished"] = ::_id_AB99;
  level._id_0A41["zombie_exploder"]["is_hit_weak_point"] = ::_id_AB95;
  level._id_0A41["zombie_exploder"]["on_killed"] = ::_id_AB9A;
  level._id_0A41["zombie_exploder"]["get_action_params"] = ::_id_AB91;
  level._id_0A41["zombie_exploder"]["move_mode"] = ::_id_AB97;
  level._id_0A41["zombie_exploder"]["on_damaged"] = ::_id_AB9B;
  level._id_62B3["drag_explosive_zm"] = ::_id_62A2;
  level._id_ABA1 = spawn("script_origin", (0, 0, 0));
  level._id_ABA1.team = "allies";
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_exploder";
  var_0._id_0EAE = "zombie_animclass";
  var_0._id_0E88 = "zombie_generic";
  var_0._id_0879 = "zombie_generic";
  var_0._id_5ED2["bomber"]["whole_body"] = "zom_bomber_base";
  var_0._id_5ED2["bomber"]["drag_weapons"] = ["zom_bomb"];
  var_0._id_4C12 = 2.0;
  var_0._id_60E2 = 20;
  var_0._id_8302 = 65;
  var_0._id_8303 = 15;
  var_0.parenttype = "zombie_generic";
  var_0.suppressive_fire_speed_multiplier = 0.3;
  var_0.tacklebymelee = 1;
  var_0.tacklebycharge = 1;
  var_0.knockbyravensword = 1;
  var_0.shockbyteslablood = 1;
  var_0.energyhold = 1;
  var_0.energyslowsecondary = 1;
  var_0.throwable = 1;

  if(isDefined(level._id_62AB))
    var_0 = [[level._id_62AB]](var_0);

  _id_0547::_id_0A52(var_0, "zombie_exploder");
  level._id_393E = [];
}

_id_AB94(var_0) {
  if(!isDefined(self._id_4BF4)) {
    return;
  }
  foreach(var_2 in self._id_4BF4) {
    if(var_2._id_95A6 == var_0)
      return var_2;
  }
}

_id_AB9F(var_0, var_1, var_2) {
  _id_054D::_id_6BD7(var_0, var_1, var_2);
  self._id_4BF4 = [];
  self _meth_85A1("zombie_exploder");

  foreach(var_4 in ["j_headb"]) {
    var_5 = spawnStruct();
    var_5._id_95A6 = var_4;
    var_5.maxhealth = 0.3 * self.maxhealth;
    var_5.health = var_5.maxhealth;
    self._id_4BF4 = common_scripts\utility::_id_0F6F(self._id_4BF4, var_5);
  }

  self._id_4B34 = 0;
  self._id_A99D = "TAG_WEAPON_CHEST";
  thread _id_51C4();
}

_id_ABA0() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  _id_0566::_id_ABB5();
  var_0 = 1;

  for(;;) {
    if(var_0) {
      var_1 = _func_0A3(0.2);
      var_0 = 0;
    } else
      var_1 = 0.2;

    wait(var_1);

    if(_id_053C::_id_4F8C()) {
      continue;
    }
    if(_id_053C::_id_4F84()) {
      continue;
    }
    if(_id_053C::_id_4F9B()) {
      continue;
    }
    if(_id_053C::_id_4F9A()) {
      continue;
    }
    _id_053C::_id_0647();
  }
}

_id_51C4() {
  self endon("death");
  waittillframeend;
  var_0 = _id_0547::_id_0A51("zombie_exploder");
  self._id_3391 = common_scripts\utility::random(var_0._id_5ED2[self._id_18B0]["drag_weapons"]);
  var_1 = spawnStruct();
  self attach(self._id_3391, self._id_A99D);
  self._id_3937 = var_1;
  var_2 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_exploder"), self._id_901F);
  var_1._id_6280 = self;
  var_1._id_3935 = int(0.2 * var_2);
  var_1._id_3F22 = 0;
  var_1._id_0117 = self;
  var_1._id_72A1 = 0;
  var_1._id_5B3C = 0;
  self._id_392C = 1;
  self._id_1723 = 1;
  thread _id_AB96();
}

_id_AB9A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self._id_392C)) {
    if(common_scripts\utility::_id_562E(self._id_6734))
      self._id_3937 _id_3940();
    else
      thread _id_AB90();

    if(isPlayer(var_1) && issubstr(var_4, "shovel") && maps\mp\_utility::_id_4571() == "mp_zombie_nest_01")
      var_1 maps\mp\gametypes\zombies::_id_47C8("ZM_SHOVEL");
  }

  level notify("zombie_exploder_killed");
  self setModel("zom_bomber_base");
  _id_054D::_id_6BD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_AB99(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!common_scripts\utility::_id_562E(self.exploder_godmode) && _id_0547::_id_5565(var_10, _func_117("TAG_WEAPON"))) {
    if(common_scripts\utility::_id_562E(self._id_392C)) {
      if(isDefined(var_5) && isDefined(var_8) && isDefined(var_1) && isPlayer(var_1)) {
        var_11 = var_1 _meth_850B(var_5, var_8);

        if(var_11 != 0)
          var_2 = int(var_2 / var_11);
      }

      self._id_3937 _id_3943(var_2, var_1, var_5, var_4);
    }

    return;
  }

  if(common_scripts\utility::_id_562E(self.sgvip) && _id_AB95(self, var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_10))
    var_2 = int(var_2 * 1.1);

  if(!common_scripts\utility::_id_562E(self.exploder_godmode) && !self._id_4B34) {
    var_12 = _id_AB94(var_10);

    if(isDefined(var_12) && var_12.health > 0) {
      var_12.health = var_12.health - var_2;

      if(var_12.health <= 0) {
        var_12.health = 0;
        self._id_4B34 = 1;
        self notify(_id_40E3(var_12._id_95A6));
        var_13 = var_12._id_95A6 + " taken out";

        switch (var_12._id_95A6) {
          case "j_head":
            var_13 = "\nExploder can't melee";
            self._id_1723 = 1;
            break;
          case "j_headb":
            self._id_1723 = undefined;

            if(common_scripts\utility::_id_562E(self._id_392C) && !common_scripts\utility::_id_562E(self.escort_zombie)) {
              var_13 = "\nExploder dropped bomb";
              _id_AB90();

              if(isPlayer(var_1) && !_id_0547::_id_577E(var_1))
                var_1 thread _id_054E::_id_18EC();

              self._id_6CC4 = "scripted_pain_drop_bomb";
            }

            break;
        }
      }
    }
  }

  _id_054D::_id_6BD3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  self._id_6CC4 = undefined;
}

_id_AB95(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0 = self;

  if(common_scripts\utility::_id_562E(self._id_392C) && _id_0547::_id_5565(var_9, _func_117("TAG_WEAPON")))
    return 1;

  if(common_scripts\utility::_id_562E(self.sgvip) && zombie_vib_exploder_is_weak_point(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9))
    return 1;

  return _id_054D::_id_5714(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

zombie_vib_exploder_is_weak_point(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = "";

  switch (var_8) {
    case "j_headb":
    case "neck":
    case "helmet":
    case "j_head":
    case "head":
      var_10 = 1;
      break;
  }

  return var_10;
}

_id_AB9D() {
  self detach(self._id_3391, self._id_A99D);
  self._id_3937._id_0117 = undefined;
  self._id_3937 = undefined;
  self._id_392C = 0;
  var_0 = _id_AB94("j_headb");

  if(var_0.health > 0) {
    var_0.health = 0;
    self._id_4B34 = 1;
    self setModel("zom_bomber_base_dead_phys");
  }

  self._id_1723 = 0;
}

_id_5F07() {
  self._id_6280 delete();
}

_id_AB90() {
  self notify("dropped_explosive");
  self._id_349C = spawn("script_model", (0, 0, 0));
  self._id_349C setModel(self._id_3391);
  self._id_349C._id_A99D = "TAG_WEAPON";
  _id_0BBF(self._id_349C, self._id_349C._id_A99D, self, self._id_A99D);
  self._id_349C _id_0547::init_damageable_script_model();
  self._id_349C _meth_82C4(1);
  self._id_349C.health = self._id_3937._id_3935;
  self._id_349C._id_3937 = self._id_3937;
  self._id_3937._id_6280 = self._id_349C;
  _id_AB9D();
  self._id_349C _meth_8272();
  self._id_349C thread _id_A88A();
  self._id_349C thread _id_6282();
  self setModel("zom_bomber_base_dead_phys");
}

_id_3940() {
  self notify("exploder_shutdown");

  if(isDefined(self._id_0117) && common_scripts\utility::_id_562E(self._id_0117._id_392C))
    self._id_0117 _id_AB9D();
  else
    _id_5F07();
}

_id_3943(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 == "drag_explosive_zm") {
    return;
  }
  if(isDefined(var_3) && var_3 == "MOD_MELEE") {
    return;
  }
  if(isPlayer(var_1) && var_3 != "MOD_EXPLOSIVE" && self._id_5B3C != gettime()) {
    self._id_72A1++;
    self._id_5B3C = gettime();
  }

  self._id_3935 = self._id_3935 - var_0;

  if(self._id_3935 <= 0 || self._id_72A1 >= 4)
    thread _id_0893(var_1, var_2);
}

zombie_exploder_attempt_detonate(var_0, var_1) {
  var_2 = self;

  if(common_scripts\utility::_id_562E(self._id_392C))
    self._id_3937 thread _id_0893(var_0, var_1);
}

_id_A88A() {
  self endon("entitydeleted");
  self._id_3937 endon("detonate");
  self._id_3937 endon("exploder_shutdown");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self._id_3937 _id_3943(var_0, var_1, var_9, var_4);
  }
}

_id_4183() {
  var_0 = self;
  var_1 = var_0._id_6280 gettagorigin(var_0._id_6280._id_A99D);
  return var_1;
}

_id_0893(var_0, var_1) {
  self notify("detonate");
  var_2 = _id_4183();
  _id_AB98(var_2);
  var_3 = spawn("script_origin", var_2);

  if(isDefined(var_0)) {
    var_3._id_9DBF = var_1;
    var_3 _meth_8561("drag_explosive_zm", var_0);
  } else
    var_3 _meth_8561("drag_explosive_zm");

  var_4 = level._id_ABA1;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_4._id_0117 = var_0;
    var_4._id_9DBF = var_1;
  } else
    var_4 = undefined;

  if(isDefined(self._id_0117) && common_scripts\utility::_id_562E(self._id_0117._id_392C))
    self._id_0117 thread zombie_exploder_ensure_die_from_attached_explosion(var_4);

  _id_3940();
  _id_AB9C(var_2, var_4);
  _id_AB9E(var_2);
  wait 5;
  var_3 delete();
}

zombie_exploder_ensure_die_from_attached_explosion(var_0) {
  var_1 = self;
  var_1 endon("death");
  waitframe();

  if(isDefined(var_0) && !isPlayer(var_0._id_0117))
    var_0 = undefined;

  if(isalive(var_1))
    var_1 _meth_8059(var_1.maxhealth + 666, var_1.origin, var_0, undefined, "MOD_EXPLOSIVE", "drag_explosive_zombie_zm");
}

_id_AB9C(var_0, var_1) {
  var_2 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_exploder"), level._id_A980);
  var_3 = int(1.1 * var_2);
  var_4 = int(0.5 * var_2);
  radiusdamage(var_0, 92, var_3, var_4, var_1, "MOD_EXPLOSIVE", "drag_explosive_zombie_zm");
}

_id_AB9E(var_0) {
  if(!isDefined(level.players)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(distance(var_0, var_2.origin) <= 92)
      var_2 _meth_8182("ear_ring_mp", 1.25, 0, 0);
  }
}

_id_AB97() {
  var_0 = "walk";
  var_1 = 1;
  var_2 = _id_AB94("j_headb");

  if(isDefined(var_2) && var_2.health <= 0) {
    var_1 = 1;
    var_0 = [[level._id_0A41["zombie"]["move_mode"]]]();

    if(var_0 == "walk")
      var_0 = "run";
  }

  self._id_64C2 = var_1 * _id_054D::_id_4440();
  self._id_2FA4 = var_0 != "walk";
  return var_0;
}

_id_AB91() {
  var_0 = _id_054D::_id_AC22();

  if(common_scripts\utility::_id_562E(self._id_392C)) {
    if(self._id_3937._id_3F22 == 1)
      var_0["script_var"] = "tick_bomb";
    else
      var_0["script_var"] = "held_bomb";
  } else
    var_0["script_var"] = "drop_bomb";

  return var_0;
}

_id_40E3(var_0) {
  return var_0 + "_braindead";
}

_id_AB96() {
  self endon("death");
  self endon("dropped_explosive");
  self endon(_id_40E3("j_headb"));
  self._id_3937 endon("short_fuse");
  self._id_3937 endon("detonate");
  waitframe();
  thread _id_6309(self, self._id_3937);

  for(;;) {
    wait 1;

    if(_id_0547::is_zombie_stunned()) {
      continue;
    }
    if(self._id_3937._id_3F22 == 1) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self.escort_zombie)) {
      continue;
    }
    var_0 = _id_053C::_id_4F88()[0];

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = distancesquared(self.origin, var_0.origin);

    if(var_1 > _func_0DA(_id_AB92())) {
      continue;
    }
    if(!_id_0547::_id_4B2C()) {
      continue;
    }
    if(isPlayer(var_0) && !self _meth_8393(var_0)) {
      continue;
    }
    self._id_3937 thread _id_3942();
  }
}

_id_3932() {
  var_0 = self;

  if(!common_scripts\utility::_id_562E(var_0._id_5759)) {
    return;
  }
  var_0 notify("killanimscript");
  var_0 thread maps\mp\agents\humanoid\_humanoid_move::_id_2603();
}

_id_3942() {
  self notify("short_fuse");
  self endon("detonate");
  self endon("exploder_shutdown");
  self endon("exploder_interrupt");
  var_0 = self._id_0117;
  var_0 endon("death");
  var_0 endon("dropped_explosive");
  self._id_3F22 = 1;
  self._id_3F23 = gettime();
  var_0 _id_3932();
  var_1 = var_0 _id_053C::_id_4F88()[0];

  if(isDefined(var_1)) {
    var_2 = 1 - distance(var_1.origin, var_0.origin) / _id_AB92();

    if(var_2 > 0.2) {
      var_3 = 2.3 * var_2;
      wait(var_3);
    }
  }

  wait 1.25;

  for(;;) {
    var_4 = level.players;

    if(common_scripts\utility::_id_562E(var_0.ismooncontrolled))
      var_4 = var_0 _id_053C::_id_4F88();

    if(var_0 should_explode(self, var_4)) {
      break;
    }

    wait 0.1;
  }

  thread _id_0893();
}

should_explode(var_0, var_1) {
  if(_id_0547::_id_5565(self._id_0BA4, "traverse"))
    return 0;

  if(_id_0547::_id_5565(self._id_0BA4, "scripted"))
    return 0;

  if(isDefined(common_scripts\utility::_id_4461(var_0 _id_4183(), var_1, 92)))
    return 1;

  return 0;
}

_id_630A(var_0) {
  var_0 endon("exploder_interrupt");
  var_1 = self;

  for(;;) {
    wait 1;
    var_2 = _id_053C::_id_4F88();

    if(var_2.size == 0) {
      break;
    }

    var_3 = var_2[0];
    var_4 = distance(var_1.origin, var_3.origin);

    if(var_4 > _id_AB93()) {
      break;
    }
  }

  var_1 notify("player_dist_reset");
}

_id_6309(var_0, var_1) {
  var_1 endon("exploder_shutdown");
  var_1 endon("death");
  var_1 endon("detonate");
  var_0 endon("death");
  var_0 endon("dropped_explosive");
  var_1 waittill("short_fuse");
  var_0 childthread _id_630A(var_1);
  var_2 = var_0 common_scripts\utility::_id_A715("stun_burst", "player_dist_reset", "dropped_explosive", "zombie_stunned");
  var_1 notify("exploder_interrupt");
  var_1._id_3F22 = 0;
  var_0 _id_3932();
  var_0 thread _id_AB96();
}

_id_0BBF(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin(var_1);
  var_5 = var_0 _meth_8181(var_1);
  var_6 = var_2 gettagorigin(var_3);
  var_7 = var_2 _meth_8181(var_3);
  var_8 = _func_111(var_6, var_7, var_4, var_5, var_0.origin, var_0.angles);
  var_0.origin = var_8["origin"];
  var_0.angles = var_8["angles"];
}

_id_2AD8(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_4);
  var_5 = [];
  var_5["forward"] = (1, 0, 0);
  var_5["up"] = (0, 0, 1);
  var_5["right"] = (0, 1, 0);
  var_6 = _func_22E(var_1);

  foreach(var_9, var_8 in var_6)
  var_6[var_9] = var_8 * var_2 * 0.5;

  for(;;) {
    foreach(var_9, var_8 in var_6) {
      thread maps\mp\_utility::_id_33D8(var_0, var_0 + var_8, 1.0, var_3);
      thread maps\mp\_utility::_id_33D8(var_0 + var_8, var_0 + var_8 * 2, 1.0, var_5[var_9]);
    }

    wait 1.0;
  }
}

_id_62A2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return 0;
}

_id_6282() {
  level._id_393E = common_scripts\utility::_id_0F6F(level._id_393E, self);
  thread _id_6281();
  waittillframeend;

  if(level._id_393E.size > 12) {
    var_0 = level._id_393E.size - 12;
    var_1 = [];

    for(var_2 = 0; var_2 < var_0; var_2++)
      var_1[var_2] = level._id_393E[var_2];

    foreach(var_4 in var_1)
    var_4._id_3937 _id_3940();
  }
}

_id_6281() {
  self waittill("entitydeleted");
  level._id_393E = common_scripts\utility::_id_0F93(level._id_393E, self);
}

_id_AB92() {
  if(common_scripts\utility::_id_562E(level.zmb_exploder_always_chases))
    return 99999;

  return 350;
}

_id_AB93() {
  if(common_scripts\utility::_id_562E(level.zmb_exploder_always_chases))
    return 999990;

  return 450;
}

_id_AB98(var_0) {
  level notify("objective_zombie_exploder_detonation", var_0, 92);
}

_id_AB9B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!common_scripts\utility::_id_562E(self._id_55AB) && var_5 == "panzerschreck_zm" || var_5 == "bazooka_zm") {
    if(common_scripts\utility::_id_562E(self.sgvip))
      var_2 = int(self.maxhealth / 5);
    else
      var_2 = self.maxhealth;
  }

  if(common_scripts\utility::_id_562E(self.sgvip) && isDefined(level.zmb_boss_damage_reduction_func))
    var_2 = [[level.zmb_boss_damage_reduction_func]](var_5, var_2);

  if(isDefined(self.on_took_damage_func))
    self thread[[self.on_took_damage_func]](anglesToForward(self.angles), var_8, var_5, var_4, var_2, var_0, var_1);

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}
/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombies_soul_collection.gsc
**********************************************************/

_id_170B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self._id_695B = var_3;
  self._id_696B = var_1;
  self._id_6943 = var_2;
  self.checklos = var_14;
  self._id_2E37 = var_5;
  self._id_2DA5 = var_6;
  self._id_2DA6 = var_7;
  self._id_AC2D = var_0;
  self._id_AC2C = 0;

  if(isDefined(var_8))
    self._id_7D24 = var_8;

  if(isDefined(var_9))
    self._id_8C47 = var_9;

  if(isDefined(var_10))
    self._id_8C48 = var_10;

  if(isDefined(var_12))
    self.sightignore = var_12;

  if(isDefined(var_13))
    self.optionaldisablearclightning = var_13;

  if(!isDefined(level._id_08E3))
    level._id_08E3 = [];

  level._id_08E3 = common_scripts\utility::_id_0F6F(level._id_08E3, self);

  while(!isDefined(level._id_376B))
    waitframe();

  if(!isDefined(var_4) && !common_scripts\utility::_id_0F79(level._id_376B, ::_id_4030))
    _id_0547::_id_7BA9(::_id_4030);

  if(isDefined(var_4)) {
    self.hasnongenerickillfunc = 1;

    if(!common_scripts\utility::_id_0F79(level._id_376B, var_4))
      _id_0547::_id_7BA9(var_4);
  }

  if(isDefined(var_11))
    thread _id_4DED(var_11);

  while(self._id_AC2D == -1 || self._id_AC2C < self._id_AC2D) {
    level waittill(self._id_695B);

    if(self._id_AC2D != -1 && self._id_AC2C >= self._id_AC2D) {
      break;
    }
  }

  if(isDefined(var_11))
    thread _id_9408();

  if(!common_scripts\utility::_id_562E(self.disable_end_sound))
    _id_0378::_id_8D74("zombie_soul_suck_threshold", self.origin);

  if(isDefined(var_4) && !common_scripts\utility::_id_562E(self.disable_auto_deregister))
    _id_0547::_id_2D8C(var_4);

  level._id_08E3 = common_scripts\utility::_id_0F93(level._id_08E3, self);
}

beginazombiesoulcollectionobjectiveonstruct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = self;
  var_16 = var_15 common_scripts\utility::_id_8FFC();
  var_16 show();
  var_15.collector = var_16;

  if(isDefined(self.onzombiesacrificedfunc))
    var_15.collector.onzombiesacrificedfunc = self.onzombiesacrificedfunc;

  if(isDefined(self.optionaldisablearclightning))
    var_15.collector.optionaldisablearclightning = self.optionaldisablearclightning;

  if(common_scripts\utility::_id_562E(var_15.ignoresighttrace))
    var_16.ignoresighttrace = 1;

  var_16 _id_170B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  var_16 delete();
}

_id_4030(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self.soulcollectinvalid)) {
    return;
  }
  if(level._id_08E3.size == 0) {
    return;
  }
  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    return;
  }
  if(!isDefined(level.zmb_max_soul_collection_beams))
    level.zmb_max_soul_collection_beams = 3;

  if(!isDefined(level._id_6666))
    level._id_6666 = 0;

  var_9 = common_scripts\utility::_id_4461(self.origin, level._id_08E3);

  if(!isDefined(var_9)) {
    return;
  }
  var_10 = 0;

  if(common_scripts\utility::_id_562E(var_9.hasnongenerickillfunc)) {
    return;
  }
  if(isDefined(var_9._id_7D24)) {
    if(_isarray(var_9._id_7D24)) {
      var_11 = 0;

      foreach(var_13 in var_9._id_7D24) {
        if(var_4 == var_13)
          var_11 = 1;
      }

      if(!var_11)
        var_10 = 1;
    } else if(var_4 != var_9._id_7D24)
      var_10 = 1;
  }

  if(isDefined(var_9.desired_zombie_type)) {
    if(self._id_0A4B != var_9.desired_zombie_type)
      return;
  }

  if(level._id_08E3.size == 0 || common_scripts\utility::_id_562E(self._id_8F2B) || var_10) {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_AC10) || common_scripts\utility::_id_562E(self.not_valid_sacrifice)) {
    return;
  }
  if(isDefined(var_9._id_2E37) && var_9 gettagindex(var_9._id_2E37) != -1) {
    var_15 = var_9 gettagorigin(var_9._id_2E37);

    if(isDefined(var_9._id_8C48))
      var_15 = var_15 + var_9._id_8C48;
  } else
    var_15 = var_9.origin;

  if(isDefined(var_9.ignoresighttrace) && var_9.ignoresighttrace)
    var_16 = 1;
  else if(isDefined(var_9._id_8C47))
    var_16 = _bullettracepassed(self getEye(), var_15, 0, var_9, var_9._id_8C47);
  else
    var_16 = _bullettracepassed(self getEye(), var_15, 0, var_9);

  var_17 = _id_21CF(var_9, var_9._id_696B, var_9._id_6943, var_9.checklos);

  if(var_17 && var_16) {
    self._id_8F2B = 1;

    if(!common_scripts\utility::_id_562E(var_9.optionaldisablearclightning)) {
      if(level._id_6666 < level.zmb_max_soul_collection_beams)
        thread _id_2024(var_9, var_9._id_2E37, var_9._id_2DA5, var_9._id_2DA6);

      try_play_scripted_soul_suck_anim("scripted_soul_eat");
    }

    if(isDefined(var_9.onzombiesacrificedfunc))
      self thread[[var_9.onzombiesacrificedfunc]](var_9);

    var_9._id_AC2C++;

    if(isDefined(self) && isDefined(self._id_0A4B))
      level notify(var_9._id_695B, var_9, self._id_0A4B);
    else
      level notify(var_9._id_695B, var_9);
  }
}

try_play_scripted_soul_suck_anim(var_0) {
  if(!common_scripts\utility::_id_562E(self._id_2FDA) && !_id_0547::_id_5565(self._id_0A4B, "zombie_fireman"))
    _id_865C(var_0, 0);
}

_id_2024(var_0, var_1, var_2, var_3) {
  _id_0378::_id_8D74("aud_zombie_soul_absorb");

  if(!isDefined(level._id_6666))
    level._id_6666 = 0;

  self waittill("body_spawned", var_4);

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  level._id_6666++;
  var_5 = _func_382("zmb_geistkraft_reg_beam_med", var_4, "j_neck", var_0, var_1);

  if(!isDefined(var_2))
    var_6 = "zmb_cart_charge_pnt";
  else
    var_6 = var_2;

  if(!isDefined(var_3))
    var_7 = var_1;
  else
    var_7 = var_3;

  _playfxontag(level._effect[var_6], var_0, var_7);

  if(isDefined(level._id_3571)) {
    _playfxontag(level._effect["zmb_gk_claw_battery_charge_1"], level._id_3571, "flap1_shroud");
    _playfxontag(level._effect["zmb_gk_claw_battery_charge_2"], level._id_3571, "flap2_shroud");
    _playfxontag(level._effect["zmb_gk_claw_battery_charge_3"], level._id_3571, "flap3_shroud");
  }

  _id_0378::_id_8D74("zombie_soul_suck", var_4.origin, var_0.origin);
  wait 0.45;

  if(isDefined(var_5))
    var_5 delete();

  level._id_6666--;
}

_id_21CF(var_0, var_1, var_2, var_3) {
  return _id_56B0(var_0, var_1, var_2, var_3);
}

_id_56B0(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;

  if(isDefined(var_0._id_2E37))
    var_4 = var_0 gettagorigin(var_0._id_2E37);

  if(!isDefined(var_3))
    var_3 = 0;

  if(common_scripts\utility::_id_562E(var_3)) {
    var_5 = _sighttracepassed(self.origin, var_4, 0, self, var_0, 0);

    if(!var_5)
      return 0;
  }

  if(isDefined(var_2))
    return _distance2d(var_4, self.origin) < var_1 && _abs(var_4[2] - self.origin[2]) < var_2;
  else
    return _distance2d(var_4, self.origin) < var_1 && self.origin[2] < var_4[2];
}

_id_865C(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1))
    self._id_2A9D = var_0;
  else if(self._id_0BA4 != "traverse")
    self._id_2A9D = var_0;
}

_id_4DED(var_0) {
  self endon("stop_sould_bucket_leak");

  for(;;) {
    var_1 = 0;

    while(!var_1) {
      var_2 = self._id_AC2C;
      wait(var_0);

      if(self._id_AC2C <= var_2)
        var_1 = 1;
    }

    _id_35FC();
  }
}

_id_35FC() {
  self endon("stop_sould_bucket_leak");
  level endon(self._id_695B);

  while(self._id_AC2C > 0) {
    self._id_AC2C--;
    wait 0.25;
  }

  self._id_AC2C = 0;
}

_id_9408() {
  self notify("stop_sould_bucket_leak");
}
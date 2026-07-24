/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3143.gsc
**************************************/

_id_351B() {
  self endon("death");
  thread _id_D310();
  self notify("begin_rodeo");

  if(self._blackboard.rodeorequested == "left")
    var_0 = "right";
  else
    var_0 = "left";

  if(var_0 == "right") {
    self clearanim(_id_0A1E::_id_2356("aimset_right", "arm_pitch"), 0.2);
    self clearanim(_id_0A1E::_id_2356("aimset_right", "arm_rail"), 0.2);
  } else {
    self clearanim(_id_0A1E::_id_2356("aimset_left", "arm_pitch"), 0.2);
    self clearanim(_id_0A1E::_id_2356("aimset_left", "arm_rail"), 0.2);
    self clearanim(_id_0A1E::_id_2356("aimset_minigun", "aim_knob"), 0.2);
  }

  var_1 = 0.4;
  var_2 = _id_361C(self);
  var_2 scripts\engine\utility::delaycall(var_1, ::show);
  var_2 linkTo(self, "j_spineupper");
  var_2._id_3919 = 0;
  var_2._id_13CCC = var_0;
  self._id_D267 = var_2;
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player _meth_84AF(1);
  level.player scripts\engine\utility::allow_weapon(0);

  if(var_0 == "right") {
    var_3 = level.player getcurrentweapon();
    var_4 = level.player scripts\sp\utility::_id_7D74(1);
    var_4 = scripts\engine\utility::array_sort_with_func(var_4, ::_id_445F);

    if(_id_7D6D(var_3) <= _id_7D6D(var_4[0]))
      self._id_D34D = var_3;
    else {
      self._id_D34D = var_4[0];
      level.player switchtoweapon(self._id_D34D);
    }
  }

  var_5 = "tag_player";
  thread _id_0F3D::_id_5103(0.4, 0, 0, 0, 128, 512, 2, 0.1);
  thread _id_D3F4(var_2, var_0, self._id_E5F8);
  level.player _meth_823C(var_2, var_5, var_1);
  level.player.ignoreme = 1;
  self.ignoreme = 1;
  self._id_D461 = level.player _meth_8525();
  level.player _meth_80D1();
  self setCanDamage(0);
  self._blackboard._id_E5FD = 1;
  _id_0C08::_id_351D(var_0, 0);
  _id_361A(var_0);
  var_6 = "rodeo_left";

  if(var_0 == "left")
    var_6 = "rodeo_right";

  self _meth_82E7("RodeoJump", _id_0A1E::_id_2356(var_6, "jump_" + self._id_E5F8), 1, 0.2, 1);
  _id_0A1E::_id_231F("rodeo", "RodeoJump", ::_id_35EE);
  thread _id_D3FA(var_2, var_0);
  thread _id_D433(self._id_D267, var_0);
  var_7 = _id_35F1(_id_0A1E::_id_2356(var_6, "mount"), var_0);
  var_8 = 3;

  if(var_7 < 2) {
    while(var_8) {
      var_7 = _id_35F1(_id_0A1E::_id_2356(var_6, "miss"), var_0, 1);
      var_8--;

      if(var_7 == 2) {
        break;
      }

      wait(randomfloatrange(0.2, 0.5));
    }
  }

  self._id_D267._id_3919 = 0;

  if(var_7 == 2) {
    thread _id_D3F0(self._id_D267, var_0);

    if(var_0 == "right")
      _id_10907();

    var_9 = _id_0A1E::_id_2356(var_6, "hit");
    self _meth_82E7("RodeoHit", var_9, 1, 0.2, 1);
    _id_0A1E::_id_231F("rodeo", "RodeoHit", ::_id_35EE);
    self clearanim(var_9, 0.2);

    if(var_0 == "left") {
      thread _id_35F2(var_2);
      thread _id_D404(var_2);
      var_10 = _id_0A1E::_id_2356(var_6, "struggle");
      self _meth_82EA("RodeoStruggle", var_10, 1, 0.2, 1);
      self waittill("struggle_succeeded");
      self clearanim(var_10, 0.2);
      thread _id_0F3D::_id_50E8(0.2);
    }

    var_10 = _id_0A1E::_id_2356(var_6, "success");
    thread _id_D3ED(self._id_D267, var_0);
    self _meth_82E7("RodeoDismount", var_10, 1, 0.2, 1);

    if(var_0 == "left")
      self _meth_82A2(_id_0A1E::_id_2356("rodeo_right", "fire"), 1, 0.2, 1);

    _id_0A1E::_id_231F("rodeo", "RodeoDismount", ::_id_35EE);
    self._id_30EA = 1;
  } else {
    var_10 = _id_0A1E::_id_2356(var_6, "fail");
    var_11 = scripts\engine\utility::get_notetrack_time(var_10, "knockoff");
    thread _id_D3F6(self._id_D267, var_0, var_11);
    self _meth_82E7("RodeoKnockOff", var_10, 1, 0.2, 1);
    _id_0A1E::_id_231F("rodeo", "RodeoKnockOff", ::_id_35EE);
    self.asm._id_11B08._id_30E6 = 0;
  }

  thread _id_E245();
  self._blackboard._id_E5FD = 0;
  self._id_7212 = gettime() + 10000;
  _id_0C08::_id_351D(var_0, 1);
  self notify("end_rodeo");
}

_id_E245() {
  self endon("death");
  self._blackboard._id_E5F9 = 1;
  wait 0.75;
  self._blackboard._id_E5F9 = undefined;
}

_id_361A(var_0) {
  var_1 = "aimset_" + var_0;
  var_2 = 0.2;
  var_3 = _id_0A1E::_id_2356(var_1, "arm_rail");
  self clearanim(var_3, var_2);
  var_3 = _id_0A1E::_id_2356(var_1, "arm_pitch");
  self clearanim(var_3, var_2);
}

_id_35F1(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 0;
  var_4 = [scripts\engine\utility::get_notetrack_time(var_0, "hit_start"), scripts\engine\utility::get_notetrack_time(var_0, "hit_end")];
  var_5 = gettime();
  self _meth_82E7("RodeoHitPlayer", var_0, 1, 0.2, 1);
  thread _id_0A1E::_id_231F("rodeo", "RodeoHitPlayer", ::_id_35EE);
  wait(var_4[0] - 0.05);
  var_6 = _id_4A09(var_1);

  if(isDefined(var_2) && var_2) {
    level.player viewkick(30, var_6.origin, 0);
    level.player playRumbleOnEntity("light_1s");
  }

  var_7 = _id_D3B0();
  wait 0.05;
  self._id_D267._id_3919 = 0;
  var_6 makeusable();
  var_8 = (var_4[1] - var_4[0]) * 3000;
  var_9 = var_5 + var_4[0] * 1000 + var_8;
  _id_E5FE("Can HIT NOW " + (var_9 - gettime()));

  while(gettime() < var_9) {
    if(_id_D3B0() && !var_7) {
      var_3 = 2;
      break;
    } else if(var_7)
      var_7 = _id_D3B0();

    wait 0.05;
  }

  _id_E5FE("Cannot HIT");
  var_6 makeunusable();
  var_6 delete();

  while(self islegacyagent(var_0) < 0.99)
    wait 0.05;

  self._id_D267._id_3919 = 1;
  return var_3;
}

_id_35F2(var_0) {
  self endon("death");
  var_1 = _id_0A1E::_id_2356("rodeo_right", "struggle");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 _meth_81E2(level.player, "tag_origin", (50, 0, -15), (0, 0, 0), 1);
  var_2 setCursorHint("HINT_BUTTON");
  var_2 _meth_84B8(1);
  var_2 setuserange(500);
  var_2 _meth_84A4(500);
  var_2 makeusable();
  var_2 show();
  self._id_A8E4 = 0;
  thread _id_35F4();
  var_3 = 1;
  var_4 = var_3;
  var_5 = 0;
  var_6 = 0.01;
  var_7 = 0.3;
  self._id_B3C3 = 0;
  var_8 = 5;
  var_9 = 1000 / var_8;
  self._id_6D3E = 1;
  thread _id_35F3();
  var_0 _meth_8244("steady_rumble");
  var_10 = getdvarint("cg_fov");
  var_11 = 50;
  var_12 = var_10 - var_11;

  while(var_5 < 0.9) {
    scripts\engine\utility::waitframe();
    var_4 = var_3;
    var_3 = self._id_B3C3 >= var_8;
    var_13 = gettime() - self._id_A8E4;
    var_5 = self islegacyagent(var_1);

    if(var_3 && !var_4) {
      self _meth_82B1(var_1, var_7);
      var_0 _meth_82B1(var_0._id_11169, var_7);
    }

    if(!var_3) {
      if(var_4) {
        self _meth_82B1(var_1, 0);
        var_0 _meth_82B1(var_0._id_11169, 0);
      } else if(var_5 > var_6) {
        var_5 = var_5 - var_6;
        self _meth_82B0(var_1, var_5);
        var_0 _meth_82B0(var_0._id_11169, var_5);
      }
    }

    level.player _meth_81DE(var_10 - var_12 * var_5, 0.05);
  }

  self notify("mash_end");
  level.player notify("stop_temperature_sfx");
  self._id_6D3E = 0;
  var_2 makeunusable();
  var_2 delete();
  self _meth_82B1(var_1, var_7);
  var_0 _meth_82B1(var_0._id_11169, var_7);
  level.player _meth_81DE(var_11, getanimlength(var_1) * (1 - var_5) / var_7);

  while(self islegacyagent(var_1) < 1)
    scripts\engine\utility::waitframe();

  self _meth_82B1(var_1, 0);
  var_0 _meth_82B1(var_0._id_11169, 0);
  playFXOnTag(level._id_7649["vfx_c12_joint_selfdestruct_head_buildup"], self, "j_neck");
  wait 0.4;
  self setscriptablepartstate("head", "rodeofinal");
  thread scripts\sp\utility::play_sound_on_tag("c12_rodeo_head_explo", "j_neck");
  scripts\asm\asm_bb::bb_setselfdestruct(1);
  level.player viewkick(40, self gettagorigin("j_neck"), 0);
  earthquake(0.4, 0.5, self gettagorigin("j_neck"), 256);
  var_0 stoprumble("steady_rumble");
  wait 0.05;
  setslowmotion(1, 0.2, 0.2);
  level.player playRumbleOnEntity("heavy_1s");
  level.player _meth_81DE(var_10, 1);
  wait 0.3;
  setslowmotion(0.2, 1, 2);
  self.brodeostrugglesucceeded = 1;
  self notify("struggle_succeeded");
}

_id_35F4() {
  self endon("mash_end");
  level.player endon("death");
  var_0 = 0;

  for(;;) {
    scripts\engine\utility::waitframe();

    if(level.player useButtonPressed()) {
      if(!var_0) {
        self._id_A8E4 = gettime();
        thread _id_12DE6();
      }

      var_0 = 1;
      continue;
    }

    var_0 = 0;
  }
}

_id_35F3() {
  self endon("death");
  var_0 = isDefined(level._id_470F);
  level._id_470F = 1;
  thread _id_116C9();
  var_1 = level.player.health;
  level.player.health = level.player.maxhealth;
  var_2 = level.player.health;
  var_3 = anim._id_35C6;
  var_4 = "j_weaponshoulder_le";
  thread _id_A661(var_4);

  while(self._id_6D3E && isalive(level.player)) {
    var_2 = var_2 - var_3;
    var_5 = level.player.health - var_2;
    level.player _meth_80A1();
    level.player dodamage(var_5, level.player.origin, self);
    level.player _meth_80D1();
    wait 2;
  }

  if(!isalive(level.player)) {
    return;
  }
  if(scripts\sp\utility::_id_93A6())
    level.player.health = var_1;

  if(!var_0)
    level._id_470F = undefined;
}

_id_A661(var_0) {
  self waittill("death");
  killfxontag(level._id_7649["vfx_c12_knife_sparks"], self, var_0);
}

_id_116C9() {
  var_0 = undefined;
  var_1 = 10;
  var_2 = 400;
  var_3 = getomnvar("ui_helmet_meter_temperature");
  var_4 = var_3;
  var_0 = undefined;

  while(self._id_6D3E && isalive(self)) {
    if(!isDefined(var_0)) {
      level.player setclientomnvar("ui_show_temperature_gauge", 1);
      var_0 = 1;
      level.player playSound("scn_c12_rodeo_plr_on_fire");
      thread _id_35EF();
    }

    wait 0.05;
    var_4 = var_4 + var_1;
    var_4 = min(var_4, var_2);
    level.player setclientomnvar("ui_helmet_meter_temperature", var_4);
  }

  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  wait 2;

  while(var_4 > var_3) {
    wait 0.05;
    var_4 = var_4 - var_1 * 2;
    var_4 = max(var_4, var_3);
    level.player setclientomnvar("ui_helmet_meter_temperature", var_4);
  }
}

_id_35EF() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  wait 0.05;
  var_0 playSound("ui_c12_rodeo_temperature_warning_lp_start");
  wait 0.5;
  var_0 thread c12_rodeo_temperature_sfx_lp();
  level.player scripts\engine\utility::waittill_any("stop_temperature_sfx", "death");
  var_0 stoploopsound("ui_c12_rodeo_temperature_warning_lp");
  var_0 delete();
  level.player playSound("ui_c12_rodeo_temperature_warning_lp_end");
}

c12_rodeo_temperature_sfx_lp() {
  level.player endon("stop_temperature_sfx");
  level.player endon("death");
  wait 1.7;
  self playLoopSound("ui_c12_rodeo_temperature_warning_lp");
}

_id_6D73() {
  self endon("death");
  self playSound("weap_c12_minigun_spinup");
  self playLoopSound("weap_c12_minigun_fire");
  var_0 = self.secondaryweapon;
  var_1 = "tag_weapon_rotate_le";
  self _meth_82A2(_id_0A1E::_id_2356("rodeo_right", "fire"), 1, 0.2, 1);
  var_2 = _id_0A1E::_id_2356("rodeo_right", "struggle");
  var_3 = getnotetracktimes(var_2, "impfx");
  var_4 = [level._id_7649["vfx_imp_cstm_rodeo_a"], level._id_7649["vfx_imp_cstm_rodeo_b"], level._id_7649["vfx_imp_cstm_rodeo_c"], level._id_7649["vfx_imp_cstm_rodeo_d"], level._id_7649["vfx_imp_cstm_rodeo_e"], level._id_7649["vfx_imp_cstm_rodeo_final"]];
  var_5 = 0;
  var_6 = getnotetracktimes(var_2, "headseq");
  var_7 = 0;
  var_8 = "titan_c12_rodeo_bullet_hits_lp";
  var_9 = 0;

  for(;;) {
    var_10 = self gettagorigin(var_1);
    var_11 = self gettagangles(var_1);
    var_12 = var_10 + anglesToForward(var_11);
    var_13 = bulletspread(var_10, var_12, 4);
    self _meth_8494(var_0, var_10, var_11, 1, var_13, 0, 0, var_1);
    var_14 = 0.35;

    if(!isDefined(self.brodeostrugglesucceeded) || !self.brodeostrugglesucceeded) {
      var_15 = self islegacyagent(var_2);

      if(var_5 < var_3.size && var_15 >= var_3[var_5]) {
        self._id_E5EF = var_4[var_5];
        var_5++;
      }

      if(var_7 < var_6.size && var_15 >= var_6[var_7]) {
        self setscriptablepartstate("head", "rodeo" + var_7);
        var_7++;
      }

      if(isDefined(self._id_E5EF)) {
        var_16 = scripts\common\trace::ray_trace_detail(var_12, var_13);

        if(isDefined(var_16["entity"]) && var_16["entity"] == self) {
          var_14 = 0.6;
          playFXOnTag(self._id_E5EF, self, "j_helmet");
          level.player playRumbleOnEntity("light_1s");

          if(!var_9) {
            thread scripts\sp\utility::play_loop_sound_on_tag(var_8, "j_head");
            var_9 = 1;
          }
        } else if(var_9) {
          thread scripts\engine\utility::stop_loop_sound_on_entity(var_8);
          var_9 = 0;
        }
      }
    }

    earthquake(var_14, 0.1, self gettagorigin("tag_brass_le"), 32);
    wait 0.1;
  }
}

_id_12DE6() {
  var_0 = 1;

  if(self._id_B3C3 == 0)
    var_0 = 3;

  self._id_B3C3 = self._id_B3C3 + var_0;
  wait 1;
  self._id_B3C3 = self._id_B3C3 - var_0;
}

_id_D91A(var_0) {}

_id_D3B0() {
  return isalive(level.player) && level.player meleeButtonPressed();
}

_id_D433(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = 0;

  for(;;) {
    wait 0.05;

    if(!var_0._id_3919) {
      continue;
    }
    if(!var_2) {
      var_2 = 1;
      thread _id_D3F3(var_0, var_1);
    }

    if(!_id_D3B0()) {
      continue;
    }
    var_2 = 0;
    _id_D3F2(var_0, var_1);
  }
}

_id_4A09(var_0) {
  var_1 = "j_missile_backcover_ri";
  var_2 = (0, 0, 0);

  if(var_0 == "left") {
    var_1 = "tag_brass_le";
    var_2 = (-3, -12, 0);
  }

  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3 linkTo(self, var_1, var_2, (0, 0, 0));
  var_3 _meth_84A3("+melee");
  var_3 setCursorHint("HINT_BUTTON");
  var_3 setuserange(50);
  var_3 _meth_84A4(100);
  var_3 setHintString(&"SCRIPT_C12_RODEO_MELEE");
  return var_3;
}

#using_animtree("player");

_id_361C(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 _meth_83D0(#animtree);
  var_2 = level.player _meth_84C6("currentViewModel");

  if(isDefined(var_2))
    var_1 setModel(var_2);

  var_1 hide();
  var_1._id_3508 = var_0;
  var_1._id_11169 = % titan_c12_rodeo_gun_player_struggle;
  return var_1;
}

_id_D3F4(var_0, var_1, var_2) {
  _id_E5FE(" --- PlayerRig_Jump");
  var_3 = "rodeoJump";
  var_4 = undefined;

  if(var_1 == "right") {
    switch (var_2) {
      case "front":
        var_4 = % titan_c12_rodeo_player_jump_front;
        break;
      case "left":
        var_4 = % titan_c12_rodeo_player_jump_left;
        break;
      case "rear":
        var_4 = % titan_c12_rodeo_player_jump_rear;
        break;
      case "right":
        var_4 = % titan_c12_rodeo_player_jump_right;
        break;
    }
  } else {
    switch (var_2) {
      case "front":
        var_4 = % titan_c12_rodeo_gun_player_jump_front;
        break;
      case "left":
        var_4 = % titan_c12_rodeo_gun_player_jump_left;
        break;
      case "rear":
        var_4 = % titan_c12_rodeo_gun_player_jump_rear;
        break;
      case "right":
        var_4 = % titan_c12_rodeo_gun_player_jump_right;
        break;
    }
  }

  level.player playSound("double_jump_boost_plr");
  level.player playRumbleOnEntity("doublejumpboost_start");
  var_0 animScripted(var_3, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_4);
  var_0 scripts\anim\shared::donotetracks(var_3, ::_id_D403);
}

_id_D3FA(var_0, var_1) {
  _id_E5FE(" --- PlayerRig_Mount");
  var_2 = "rodeoMount";
  var_3 = % titan_c12_rodeo_player_mount;

  if(var_1 == "left")
    var_3 = % titan_c12_rodeo_gun_player_mount;

  var_0 animScripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_3);
  var_0 scripts\anim\shared::donotetracks(var_2, ::_id_D403);
}

_id_D3F0(var_0, var_1) {
  _id_E5FE(" --- PlayerRig_Hit");
  var_2 = "rodeoHit";
  var_3 = % titan_c12_rodeo_player_hit;

  if(var_1 == "left")
    var_3 = % titan_c12_rodeo_gun_player_hit;

  var_0 animScripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_3);
  var_0 scripts\anim\shared::donotetracks(var_2, ::_id_D403);
}

_id_D3F2(var_0, var_1) {
  _id_E5FE(" --- PlayerRig_HitQuickMiss");
  var_2 = "rodeoQuickMiss";

  if(var_1 == "right")
    var_0 animScripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), %titan_c12_rodeo_player_miss_quick);
  else
    var_0 _meth_82E7(var_2, %titan_c12_rodeo_gun_player_miss_quick);

  var_0 scripts\anim\shared::donotetracks(var_2, ::_id_D403);
}

_id_D3F3(var_0, var_1) {
  _id_E5FE(" --- PlayerRig_Idle");
  var_2 = "rodeoIdle";

  if(var_1 == "right")
    var_0 animScripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), %titan_c12_rodeo_player_idle);
  else
    var_0 _meth_82E7(var_2, %titan_c12_rodeo_gun_player_idle);

  var_0 scripts\anim\shared::donotetracks(var_2, ::_id_D403);
}

_id_D404(var_0) {
  _id_E5FE(" --- PlayerRig_Struggle");
  var_1 = "rodeoStruggle";
  var_0 animScripted(var_1, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_0._id_11169);
  var_0 scripts\anim\shared::donotetracks(var_1, ::_id_D403);
}

_id_D3ED(var_0, var_1) {
  _id_E5FE(" --- PlayerRig_Dismount");
  var_2 = "rodeoDismount";
  var_3 = % titan_c12_rodeo_player_dismount;

  if(var_1 == "left")
    var_3 = % titan_c12_rodeo_gun_player_dismount;

  thread _id_D3EF(var_0, var_1, var_3);
  var_0 animScripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_3);
  var_0 scripts\anim\shared::donotetracks(var_2, ::_id_D403);
}

_id_D3F6(var_0, var_1, var_2) {
  _id_E5FE(" --- PlayerRig_KnockOff");
  var_3 = "rodeoKnockOff";
  var_4 = % titan_c12_rodeo_player_miss_knockoff;

  if(var_1 == "left")
    var_4 = % titan_c12_rodeo_gun_player_miss_knockoff;

  thread _id_D3F7(var_0, var_1, var_2);
  var_0 animScripted(var_3, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_4);
  var_0 scripts\anim\shared::donotetracks(var_3, ::_id_D403);
}

_id_35EE(var_0) {
  if(scripts\sp\anim_notetrack::_id_C0DB(var_0))
    return;
}

_id_D403(var_0, var_1) {
  if(scripts\sp\anim_notetrack::_id_C0DB(var_0)) {
    return;
  }
  if(self._id_13CCC == "right")
    var_2 = "tag_knife_attach2";
  else
    var_2 = "tag_accessory_left";

  var_3 = self._id_3508;

  switch (var_0) {
    case "attach_rocket":
      if(isDefined(self._id_3508._id_E601))
        var_3._id_E601 delete();

      self attach(level._id_EC8C["asm_c12_rodeo_rocket"], var_2, 1);
      break;
    case "detach_rocket":
      var_3 thread _id_CC50(self);
      self detach(level._id_EC8C["asm_c12_rodeo_rocket"], var_2);
      break;
    case "attach_knife":
      self attach(level._id_EC8C["asm_c12_viewmodel_knife"], var_2, 1);
      break;
    case "knife_hit":
      if(self._id_13CCC == "left") {
        playFXOnTag(level._id_7649["vfx_c12_knife_sparks"], var_3, "j_weaponshoulder_le");
        var_3 thread scripts\sp\utility::play_loop_sound_on_tag("titan_c12_rodeo_fire_loop", "tag_brass_le");
      } else {
        var_4 = self gettagangles("tag_knife_fx");
        var_5 = self gettagorigin("tag_knife_fx") + rotatevector((0, 0, -6), var_4);
        playFX(level._id_7649["vfx_c12_knife_oneshot"], var_5, anglesToForward(var_4), anglestoup(var_4));
      }

      break;
    case "detach_knife":
      self detach(level._id_EC8C["asm_c12_viewmodel_knife"], var_2);
      break;
    case "fire_minigun":
      var_3 thread _id_6D73();
      break;
    case "rocket_pop":
      var_3._id_E601 linkTo(self, "tag_knife_attach2", (0, 0, 0), (0, 0, 0));
      break;
    case "jump_off":
      self notify("jump_off");
      break;
    case "weapons_free":
      level.player playerlinkTo(self, "tag_player");
      var_3 thread _id_D3EE(self._id_13CCC);
      self._id_13CC9 = 1;
      self unlink();
      self hide();
      break;
    case "rumble":
      self playRumbleOnEntity("light_1s");
      break;
  }
}

_id_D3EF(var_0, var_1, var_2) {
  self.ignoreall = 1;
  self._id_595F = 1;
  self.playerwillunlink = 1;
  var_3 = gettime() + 1000 * getanimlength(var_2);
  var_0 waittill("jump_off");

  while(gettime() < var_3) {
    var_4 = level.player.origin;
    wait 0.05;
    var_5 = level.player.origin;

    if(!level.player scripts\common\trace::player_trace_passed(var_5, var_5 + (var_5 - var_4), level.player.angles, [var_0, level.player, self])) {
      level.player setOrigin(var_4);
      break;
    }
  }

  level.player unlink();
  var_0 delete();

  if(!isDefined(var_0._id_13CC9))
    thread _id_D3EE(var_1);

  self.ignoreall = 0;
  self._id_595F = undefined;
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  wait 0.3;
  level.player.ignoreme = 0;

  if(!self._id_D461)
    level.player _meth_80A1();

  if(var_1 == "left")
    _id_0A05::_id_3634("c12AchievementRodeoLeft");
}

_id_D3EE(var_0) {
  level.player scripts\engine\utility::allow_weapon(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);

  if(var_0 == "right") {
    self notify("can_damage_rocket");
    thread _id_0F3D::_id_50E8(0);
    self _meth_84AE();
    level.player _id_0E42::giveperk("specialty_quickdraw");
    var_1 = getdvarfloat("perk_quickDrawSpeedScaleSP", 1);
    var_2 = getdvarfloat("perk_quickDrawSpeedScaleSniperSP", 1);
    var_3 = getdvarfloat("bg_quickWeaponSwitchSpeedScaleSP", 1);
    var_4 = _id_7D71(self._id_D34D);
    setsaveddvar("perk_quickDrawSpeedScaleSP", var_1 * var_4);
    setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_2 * var_4);
    setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_3 / var_4);
    var_5 = int(weaponclipsize(self._id_D34D) * 0.5);

    if(level.player getweaponammoclip(self._id_D34D) < var_5)
      level.player setweaponammoclip(self._id_D34D, var_5);

    setslowmotion(1, 0.2, 0.2);

    while(isDefined(level.player getlinkedparent()) && isalive(self))
      wait 0.05;

    setsaveddvar("perk_quickDrawSpeedScaleSP", var_1);
    setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_2);
    setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_3);
    level.player _id_0E42::removeperk("specialty_quickdraw");
    self _meth_84AD();
    self setCanDamage(1);

    if(!isalive(self)) {
      wait 0.2;
      setslowmotion(0.2, 1, 0.2);
    } else
      setslowmotion(0.2, 1, 0);
  }

  level.player _meth_84AF(0);
}

_id_445F(var_0, var_1) {
  return _id_7D6D(var_0) < _id_7D6D(var_1);
}

_id_7D6D(var_0) {
  var_1 = weaponclass(var_0);

  switch (var_1) {
    case "pistol":
    case "smg":
    case "rifle":
      return 0;
    case "spread":
      return 1;
    case "mg":
      return 2;
    case "rocketlauncher":
      return 3;
    case "sniper":
      return 4;
    default:
      return 5;
  }
}

_id_7D71(var_0) {
  var_1 = weaponclass(var_0);

  switch (var_1) {
    case "pistol":
    case "smg":
    case "rifle":
      return 1;
    case "spread":
      return 1;
    case "mg":
      return 1.35;
    case "sniper":
      return 1.5;
    case "rocketlauncher":
      return 1.5;
    default:
      return 1;
  }
}

_id_CC50(var_0) {
  self endon("death");
  var_1 = var_0 gettagorigin("tag_knife_attach2");
  var_2 = var_0 gettagangles("tag_knife_attach2");
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setModel(level._id_EC8C["asm_c12_rodeo_rocket"]);
  var_3 linkTo(self, "j_neck");
  self._id_E601 = var_3;
  self waittill("can_damage_rocket");
  var_3 scripts\sp\utility::_id_9196(3, 1, 1);
  var_3 setCanDamage(1);
  var_3.health = 9999;
  var_4 = 30;

  while(isDefined(var_3) && var_4 > 0) {
    var_3 waittill("damage", var_5, var_6);

    if(var_6 == level.player) {
      var_4 = var_4 - var_5;
      continue;
    }

    var_3.health = var_3.health + var_5;
  }

  if(!isDefined(var_3)) {
    return;
  }
  var_3 _meth_81D0();
  var_1 = self gettagorigin("j_spineupper");
  self playSound("scn_C12_rodeo_exp");
  playFX(level._id_7649["c12_implode_pre_explosion"], var_1);
  var_7 = int(90 * (distance(var_1, level.player.origin) / 1000));
  level.player viewkick(var_7, var_1, 0);
  self _meth_824A("vox_c12_death", "vox_c12_death", 1);
  _id_0C46::_id_3539("implode", ["right_leg", "left_leg"]);
  self _meth_8189("j_spinelowerbottom");
  self.asm._id_4E73 = 1;
  playrumbleonposition("heavy_1s", var_1);
  earthquake(0.25, 0.5, var_1, 1200);
  _id_0A05::_id_3634("c12AchievementRodeoRight");
  var_1 = var_3.origin;
  var_3 delete();
  thread scripts\engine\utility::play_sound_in_space("c12_self_destruct", self.origin);
  self _meth_81D0(var_1, level.player);
}

_id_10907() {
  if(isDefined(self._id_E601)) {
    return;
  }
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(level._id_EC8C["asm_c12_rodeo_rocket_nocoll"]);
  var_1 = (7.15, 2, -2.15);
  var_2 = (0, -90, 0);
  var_3 = "j_weaponshoulder_ri";
  var_4 = self gettagangles(var_3);
  var_0 linkTo(self, var_3, var_1, var_2);
  self._id_E601 = var_0;
}

_id_D3F7(var_0, var_1, var_2) {
  self.playerwillunlink = 1;
  wait(var_2);
  level.player playRumbleOnEntity("heavy_1s");
  thread _id_0F3D::_id_50E8(0);
  level.player _meth_84AF(0);

  if(var_1 == "right")
    var_3 = "tag_brass_ri";
  else
    var_3 = "tag_missile_bottom_back_le";

  var_4 = self gettagorigin(var_3);
  var_5 = vectorNormalize(level.player.origin - var_4);
  var_6 = var_5 * 500;
  level.player setvelocity(var_6);
  level.player viewkick(75, var_4);

  if(!self._id_D461)
    level.player _meth_80A1();

  level.player dodamage(level.player.health * 0.6, var_4, self);
  wait 0.2;
  level.player unlink();
  level.player scripts\engine\utility::allow_weapon(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  var_0 delete();
  level.player.ignoreme = 0;
  self.ignoreme = 0;
  self setCanDamage(1);
}

_id_E5FE(var_0) {}

_id_D310() {
  self endon("end_rodeo");
  self waittill("death");

  if(isDefined(self.playerwillunlink)) {
    return;
  }
  level.player unlink();
  self._id_D267 delete();
  thread _id_0F3D::_id_50E8(0);
  level.player _meth_81DE(65, 0.2);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player _meth_84AF(0);
  level.player scripts\engine\utility::allow_weapon(1);
  level.player.ignoreme = 0;

  if(!self._id_D461)
    level.player _meth_80A1();
}
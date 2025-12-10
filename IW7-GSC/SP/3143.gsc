/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3143.gsc
************************/

func_351B() {
  self endon("death");
  thread func_D310();
  self notify("begin_rodeo");
  if(self.var_1198.rodeorequested == "left") {
    var_00 = "right";
  } else {
    var_00 = "left";
  }

  if(var_00 == "right") {
    self clearanim(lib_0A1E::func_2356("aimset_right", "arm_pitch"), 0.2);
    self clearanim(lib_0A1E::func_2356("aimset_right", "arm_rail"), 0.2);
  } else {
    self clearanim(lib_0A1E::func_2356("aimset_left", "arm_pitch"), 0.2);
    self clearanim(lib_0A1E::func_2356("aimset_left", "arm_rail"), 0.2);
    self clearanim(lib_0A1E::func_2356("aimset_minigun", "aim_knob"), 0.2);
  }

  var_01 = 0.4;
  var_02 = func_361C(self);
  var_02 scripts\engine\utility::delaycall(var_01, ::show);
  var_02 linkto(self, "j_spineupper");
  var_02.var_3919 = 0;
  var_02.var_13CCC = var_00;
  self.var_D267 = var_02;
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player _meth_84AF(1);
  level.player scripts\engine\utility::allow_weapon(0);
  level.player.inrodeo = 1;
  if(var_00 == "right") {
    var_03 = level.player getcurrentweapon();
    var_04 = level.player scripts\sp\utility::func_7D74(1);
    var_04 = scripts\engine\utility::array_sort_with_func(var_04, ::func_445F);
    if(func_7D6D(var_03) <= func_7D6D(var_04[0])) {
      self.var_D34D = var_03;
    } else {
      self.var_D34D = var_04[0];
      level.player switchtoweapon(self.var_D34D);
    }
  }

  var_05 = "tag_player";
  thread lib_0F3D::func_5103(0.4, 0, 0, 0, 128, 512, 2, 0.1);
  thread func_D3F4(var_02, var_00, self.var_E5F8);
  level.player playerlinktoblend(var_02, var_05, var_01);
  level.player.ignoreme = 1;
  self.ignoreme = 1;
  self.var_D461 = level.player _meth_8525();
  level.player getrankinfoxpamt();
  self setCanDamage(0);
  self.var_1198.var_E5FD = 1;
  lib_0C08::func_351D(var_00, 0);
  func_361A(var_00);
  var_06 = "rodeo_left";
  if(var_00 == "left") {
    var_06 = "rodeo_right";
  }

  self _meth_82E7("RodeoJump", lib_0A1E::func_2356(var_06, "jump_" + self.var_E5F8), 1, 0.2, 1);
  lib_0A1E::func_231F("rodeo", "RodeoJump", ::func_35EE);
  thread func_D3FA(var_02, var_00);
  thread func_D433(self.var_D267, var_00);
  var_07 = func_35F1(lib_0A1E::func_2356(var_06, "mount"), var_00);
  var_08 = 3;
  if(var_07 < 2) {
    while(var_08) {
      var_07 = func_35F1(lib_0A1E::func_2356(var_06, "miss"), var_00, 1);
      var_08--;
      if(var_07 == 2) {
        break;
      }

      wait(randomfloatrange(0.2, 0.5));
    }
  }

  self.var_D267.var_3919 = 0;
  if(var_07 == 2) {
    thread func_D3F0(self.var_D267, var_00);
    if(var_00 == "right") {
      func_10907();
    }

    var_09 = lib_0A1E::func_2356(var_06, "hit");
    self _meth_82E7("RodeoHit", var_09, 1, 0.2, 1);
    lib_0A1E::func_231F("rodeo", "RodeoHit", ::func_35EE);
    self clearanim(var_09, 0.2);
    if(var_00 == "left") {
      thread func_35F2(var_02);
      thread func_D404(var_02);
      var_0A = lib_0A1E::func_2356(var_06, "struggle");
      self _meth_82EA("RodeoStruggle", var_0A, 1, 0.2, 1);
      self waittill("struggle_succeeded");
      self clearanim(var_0A, 0.2);
      thread lib_0F3D::func_50E8(0.2);
    }

    var_0A = lib_0A1E::func_2356(var_06, "success");
    thread func_D3ED(self.var_D267, var_00);
    self _meth_82E7("RodeoDismount", var_0A, 1, 0.2, 1);
    if(var_00 == "left") {
      self give_attacker_kill_rewards(lib_0A1E::func_2356("rodeo_right", "fire"), 1, 0.2, 1);
    }

    lib_0A1E::func_231F("rodeo", "RodeoDismount", ::func_35EE);
    self.var_30EA = 1;
  } else {
    var_0A = lib_0A1E::func_2356(var_07, "fail");
    var_0B = scripts\engine\utility::get_notetrack_time(var_0A, "knockoff");
    thread func_D3F6(self.var_D267, var_00, var_0B);
    self _meth_82E7("RodeoKnockOff", var_0A, 1, 0.2, 1);
    lib_0A1E::func_231F("rodeo", "RodeoKnockOff", ::func_35EE);
    self.asm.var_11B08.var_30E6 = 0;
  }

  thread func_E245();
  self.var_1198.var_E5FD = 0;
  self.var_7212 = gettime() + 10000;
  lib_0C08::func_351D(var_00, 1);
  level.player.inrodeo = undefined;
  self notify("end_rodeo");
}

func_E245() {
  self endon("death");
  self.var_1198.var_E5F9 = 1;
  wait(0.75);
  self.var_1198.var_E5F9 = undefined;
}

func_361A(param_00) {
  var_01 = "aimset_" + param_00;
  var_02 = 0.2;
  var_03 = lib_0A1E::func_2356(var_01, "arm_rail");
  self clearanim(var_03, var_02);
  var_03 = lib_0A1E::func_2356(var_01, "arm_pitch");
  self clearanim(var_03, var_02);
}

func_35F1(param_00, param_01, param_02) {
  self endon("death");
  var_03 = 0;
  var_04 = [scripts\engine\utility::get_notetrack_time(param_00, "hit_start"), scripts\engine\utility::get_notetrack_time(param_00, "hit_end")];
  var_05 = gettime();
  self _meth_82E7("RodeoHitPlayer", param_00, 1, 0.2, 1);
  thread lib_0A1E::func_231F("rodeo", "RodeoHitPlayer", ::func_35EE);
  wait(var_04[0] - 0.05);
  var_06 = func_4A09(param_01);
  if(isDefined(param_02) && param_02) {
    level.player viewkick(30, var_06.origin, 0);
    level.player playrumbleonentity("light_1s");
  }

  var_07 = func_D3B0();
  wait(0.05);
  self.var_D267.var_3919 = 0;
  var_06 makeusable();
  var_08 = var_04[1] - var_04[0] * 3000;
  var_09 = var_05 + var_04[0] * 1000 + var_08;
  func_E5FE("Can HIT NOW " + var_09 - gettime());
  while(gettime() < var_09) {
    if(func_D3B0() && !var_07) {
      var_03 = 2;
      break;
    } else if(var_07) {
      var_07 = func_D3B0();
    }

    wait(0.05);
  }

  func_E5FE("Cannot HIT");
  var_06 makeunusable();
  var_06 delete();
  while(self getscoreinfocategory(param_00) < 0.99) {
    wait(0.05);
  }

  self.var_D267.var_3919 = 1;
  return var_03;
}

func_35F2(param_00) {
  self endon("death");
  var_01 = lib_0A1E::func_2356("rodeo_right", "struggle");
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_02 _meth_81E2(level.player, "tag_origin", (50, 0, -15), (0, 0, 0), 1);
  var_02 setcursorhint("HINT_BUTTON");
  var_02 _meth_84B8(1);
  var_02 setuserange(500);
  var_02 _meth_84A4(500);
  var_02 makeusable();
  var_02 show();
  self.var_A8E4 = 0;
  thread func_35F4();
  var_03 = 1;
  var_04 = var_03;
  var_05 = 0;
  var_06 = 0.01;
  var_07 = 0.3;
  self.var_B3C3 = 0;
  var_08 = 5;
  var_09 = 1000 / var_08;
  self.var_6D3E = 1;
  thread func_35F3();
  param_00 _meth_8244("steady_rumble");
  var_0A = getdvarint("cg_fov");
  var_0B = 50;
  var_0C = var_0A - var_0B;
  while(var_05 < 0.9) {
    scripts\engine\utility::waitframe();
    var_04 = var_03;
    var_03 = self.var_B3C3 >= var_08;
    var_0D = gettime() - self.var_A8E4;
    var_05 = self getscoreinfocategory(var_01);
    if(var_03 && !var_04) {
      self _meth_82B1(var_01, var_07);
      param_00 _meth_82B1(param_00.var_11169, var_07);
    }

    if(!var_03) {
      if(var_04) {
        self _meth_82B1(var_01, 0);
        param_00 _meth_82B1(param_00.var_11169, 0);
        continue;
      }

      if(var_05 > var_06) {
        var_05 = var_05 - var_06;
        self _meth_82B0(var_01, var_05);
        param_00 _meth_82B0(param_00.var_11169, var_05);
      }
    }

    level.player _meth_81DE(var_0A - var_0C * var_05, 0.05);
  }

  self notify("mash_end");
  level.player notify("stop_temperature_sfx");
  self.var_6D3E = 0;
  var_02 makeunusable();
  var_02 delete();
  self _meth_82B1(var_01, var_07);
  param_00 _meth_82B1(param_00.var_11169, var_07);
  level.player _meth_81DE(var_0B, getanimlength(var_01) * 1 - var_05 / var_07);
  while(self getscoreinfocategory(var_01) < 1) {
    scripts\engine\utility::waitframe();
  }

  self _meth_82B1(var_01, 0);
  param_00 _meth_82B1(param_00.var_11169, 0);
  playFXOnTag(level.var_7649["vfx_c12_joint_selfdestruct_head_buildup"], self, "j_neck");
  wait(0.4);
  self setscriptablepartstate("head", "rodeofinal");
  thread scripts\sp\utility::play_sound_on_tag("c12_rodeo_head_explo", "j_neck");
  scripts\asm\asm_bb::bb_setselfdestruct(1);
  level.player viewkick(40, self gettagorigin("j_neck"), 0);
  earthquake(0.4, 0.5, self gettagorigin("j_neck"), 256);
  param_00 stoprumble("steady_rumble");
  wait(0.05);
  setslowmotion(1, 0.2, 0.2);
  level.player playrumbleonentity("heavy_1s");
  level.player _meth_81DE(var_0A, 1);
  wait(0.3);
  setslowmotion(0.2, 1, 2);
  self.brodeostrugglesucceeded = 1;
  self notify("struggle_succeeded");
}

func_35F4() {
  self endon("mash_end");
  level.player endon("death");
  var_00 = 0;
  for(;;) {
    scripts\engine\utility::waitframe();
    if(level.player usebuttonpressed()) {
      if(!var_00) {
        self.var_A8E4 = gettime();
        thread func_12DE6();
      }

      var_00 = 1;
      continue;
    }

    var_00 = 0;
  }
}

func_35F3() {
  self endon("death");
  var_00 = isDefined(level.var_470F);
  level.var_470F = 1;
  thread func_116C9();
  var_01 = level.player.health;
  var_02 = level.player.maxhealth;
  level.player.health = level.player.maxhealth;
  var_03 = level.player.health;
  var_04 = level.var_35C6;
  var_05 = "j_weaponshoulder_le";
  thread func_A661(var_05);
  while(self.var_6D3E && isalive(level.player)) {
    var_03 = var_03 - var_04;
    var_06 = level.player.health - var_03;
    level.player _meth_80A1();
    level.player dodamage(var_06, level.player.origin, self);
    level.player getrankinfoxpamt();
    wait(2);
  }

  if(!isalive(level.player)) {
    return;
  }

  if(scripts\sp\utility::func_93A6()) {
    level.player.health = var_01;
    level.player.maxhealth = var_02;
  }

  if(!var_00) {
    level.var_470F = undefined;
  }
}

func_A661(param_00) {
  self waittill("death");
  killfxontag(level.var_7649["vfx_c12_knife_sparks"], self, param_00);
}

func_116C9() {
  var_00 = undefined;
  var_01 = 10;
  var_02 = 400;
  var_03 = getomnvar("ui_helmet_meter_temperature");
  var_04 = var_03;
  var_00 = undefined;
  while(self.var_6D3E && isalive(self)) {
    if(!isDefined(var_00)) {
      level.player setclientomnvar("ui_show_temperature_gauge", 1);
      var_00 = 1;
      level.player playSound("scn_c12_rodeo_plr_on_fire");
      thread func_35EF();
    }

    wait(0.05);
    var_04 = var_04 + var_01;
    var_04 = min(var_04, var_02);
    level.player setclientomnvar("ui_helmet_meter_temperature", var_04);
  }

  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  wait(2);
  while(var_04 > var_03) {
    wait(0.05);
    var_04 = var_04 - var_01 * 2;
    var_04 = max(var_04, var_03);
    level.player setclientomnvar("ui_helmet_meter_temperature", var_04);
  }
}

func_35EF() {
  var_00 = spawn("script_origin", level.player.origin);
  var_00 linkto(level.player);
  wait(0.05);
  var_00 playSound("ui_c12_rodeo_temperature_warning_lp_start");
  wait(0.5);
  var_00 thread c12_rodeo_temperature_sfx_lp();
  level.player scripts\engine\utility::waittill_any_3("stop_temperature_sfx", "death");
  var_00 stoploopsound("ui_c12_rodeo_temperature_warning_lp");
  var_00 delete();
  level.player playSound("ui_c12_rodeo_temperature_warning_lp_end");
}

c12_rodeo_temperature_sfx_lp() {
  level.player endon("stop_temperature_sfx");
  level.player endon("death");
  wait(1.7);
  self playLoopSound("ui_c12_rodeo_temperature_warning_lp");
}

func_6D73() {
  self endon("death");
  self playSound("weap_c12_minigun_spinup");
  self playLoopSound("weap_c12_minigun_fire");
  var_00 = self.secondaryweapon;
  var_01 = "tag_weapon_rotate_le";
  self give_attacker_kill_rewards(lib_0A1E::func_2356("rodeo_right", "fire"), 1, 0.2, 1);
  var_02 = lib_0A1E::func_2356("rodeo_right", "struggle");
  var_03 = getnotetracktimes(var_02, "impfx");
  var_04 = [level.var_7649["vfx_imp_cstm_rodeo_a"], level.var_7649["vfx_imp_cstm_rodeo_b"], level.var_7649["vfx_imp_cstm_rodeo_c"], level.var_7649["vfx_imp_cstm_rodeo_d"], level.var_7649["vfx_imp_cstm_rodeo_e"], level.var_7649["vfx_imp_cstm_rodeo_final"]];
  var_05 = 0;
  var_06 = getnotetracktimes(var_02, "headseq");
  var_07 = 0;
  var_08 = "titan_c12_rodeo_bullet_hits_lp";
  var_09 = 0;
  for(;;) {
    var_0A = self gettagorigin(var_01);
    var_0B = self gettagangles(var_01);
    var_0C = var_0A + anglesToForward(var_0B);
    var_0D = bulletspread(var_0A, var_0C, 4);
    self _meth_8494(var_00, var_0A, var_0B, 1, var_0D, 0, 0, var_01);
    var_0E = 0.35;
    if(!isDefined(self.brodeostrugglesucceeded) || !self.brodeostrugglesucceeded) {
      var_0F = self getscoreinfocategory(var_02);
      if(var_05 < var_03.size && var_0F >= var_03[var_05]) {
        self.var_E5EF = var_04[var_05];
        var_05++;
      }

      if(var_07 < var_06.size && var_0F >= var_06[var_07]) {
        self setscriptablepartstate("head", "rodeo" + var_07);
        var_07++;
      }

      if(isDefined(self.var_E5EF)) {
        var_10 = scripts\common\trace::ray_trace_detail(var_0C, var_0D);
        if(isDefined(var_10["entity"]) && var_10["entity"] == self) {
          var_0E = 0.6;
          playFXOnTag(self.var_E5EF, self, "j_helmet");
          level.player playrumbleonentity("light_1s");
          if(!var_09) {
            thread scripts\sp\utility::play_loop_sound_on_tag(var_08, "j_head");
            var_09 = 1;
          }
        } else if(var_09) {
          thread scripts\engine\utility::stop_loop_sound_on_entity(var_08);
          var_09 = 0;
        }
      }
    }

    earthquake(var_0E, 0.1, self gettagorigin("tag_brass_le"), 32);
    wait(0.1);
  }
}

func_12DE6() {
  var_00 = 1;
  if(self.var_B3C3 == 0) {
    var_00 = 3;
  }

  self.var_B3C3 = self.var_B3C3 + var_00;
  wait(1);
  self.var_B3C3 = self.var_B3C3 - var_00;
}

func_D91A(param_00) {}

func_D3B0() {
  return isalive(level.player) && level.player meleebuttonpressed();
}

func_D433(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  var_02 = 0;
  for(;;) {
    wait(0.05);
    if(!param_00.var_3919) {
      continue;
    }

    if(!var_02) {
      var_02 = 1;
      thread func_D3F3(param_00, param_01);
    }

    if(!func_D3B0()) {
      continue;
    }

    var_02 = 0;
    func_D3F2(param_00, param_01);
  }
}

func_4A09(param_00) {
  var_01 = "j_missile_backcover_ri";
  var_02 = (0, 0, 0);
  if(param_00 == "left") {
    var_01 = "tag_brass_le";
    var_02 = (-3, -12, 0);
  }

  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_03 linkto(self, var_01, var_02, (0, 0, 0));
  var_03 _meth_84A3("+melee");
  var_03 setcursorhint("HINT_BUTTON");
  var_03 setuserange(50);
  var_03 _meth_84A4(100);
  var_03 sethintstring(&"SCRIPT_C12_RODEO_MELEE");
  return var_03;
}

func_361C(param_00) {
  var_01 = spawn("script_model", param_00.origin);
  var_01.angles = param_00.angles;
  var_01 glinton(#animtree);
  var_02 = level.player _meth_84C6("currentViewModel");
  if(isDefined(var_02)) {
    var_01 setModel(var_02);
  }

  var_01 hide();
  var_01.var_3508 = param_00;
  var_01.var_11169 = % titan_c12_rodeo_gun_player_struggle;
  return var_01;
}

func_D3F4(param_00, param_01, param_02) {
  func_E5FE(" --- PlayerRig_Jump");
  var_03 = "rodeoJump";
  var_04 = undefined;
  if(param_01 == "right") {
    switch (param_02) {
      case "front":
        var_04 = % titan_c12_rodeo_player_jump_front;
        break;

      case "left":
        var_04 = % titan_c12_rodeo_player_jump_left;
        break;

      case "rear":
        var_04 = % titan_c12_rodeo_player_jump_rear;
        break;

      case "right":
        var_04 = % titan_c12_rodeo_player_jump_right;
        break;
    }
  } else {
    switch (param_02) {
      case "front":
        var_04 = % titan_c12_rodeo_gun_player_jump_front;
        break;

      case "left":
        var_04 = % titan_c12_rodeo_gun_player_jump_left;
        break;

      case "rear":
        var_04 = % titan_c12_rodeo_gun_player_jump_rear;
        break;

      case "right":
        var_04 = % titan_c12_rodeo_gun_player_jump_right;
        break;
    }
  }

  level.player playSound("double_jump_boost_plr");
  level.player playrumbleonentity("doublejumpboost_start");
  param_00 animscripted(var_03, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_04);
  param_00 scripts\anim\shared::donotetracks(var_03, ::func_D403);
}

func_D3FA(param_00, param_01) {
  func_E5FE(" --- PlayerRig_Mount");
  var_02 = "rodeoMount";
  var_03 = % titan_c12_rodeo_player_mount;
  if(param_01 == "left") {
    var_03 = % titan_c12_rodeo_gun_player_mount;
  }

  param_00 animscripted(var_02, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_03);
  param_00 scripts\anim\shared::donotetracks(var_02, ::func_D403);
}

func_D3F0(param_00, param_01) {
  func_E5FE(" --- PlayerRig_Hit");
  var_02 = "rodeoHit";
  var_03 = % titan_c12_rodeo_player_hit;
  if(param_01 == "left") {
    var_03 = % titan_c12_rodeo_gun_player_hit;
  }

  param_00 animscripted(var_02, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_03);
  param_00 scripts\anim\shared::donotetracks(var_02, ::func_D403);
}

func_D3F2(param_00, param_01) {
  func_E5FE(" --- PlayerRig_HitQuickMiss");
  var_02 = "rodeoQuickMiss";
  if(param_01 == "right") {
    param_00 animscripted(var_02, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), % titan_c12_rodeo_player_miss_quick);
  } else {
    param_00 _meth_82E7(var_02, % titan_c12_rodeo_gun_player_miss_quick);
  }

  param_00 scripts\anim\shared::donotetracks(var_02, ::func_D403);
}

func_D3F3(param_00, param_01) {
  func_E5FE(" --- PlayerRig_Idle");
  var_02 = "rodeoIdle";
  if(param_01 == "right") {
    param_00 animscripted(var_02, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), % titan_c12_rodeo_player_idle);
  } else {
    param_00 _meth_82E7(var_02, % titan_c12_rodeo_gun_player_idle);
  }

  param_00 scripts\anim\shared::donotetracks(var_02, ::func_D403);
}

func_D404(param_00) {
  func_E5FE(" --- PlayerRig_Struggle");
  var_01 = "rodeoStruggle";
  param_00 animscripted(var_01, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), param_00.var_11169);
  param_00 scripts\anim\shared::donotetracks(var_01, ::func_D403);
}

func_D3ED(param_00, param_01) {
  func_E5FE(" --- PlayerRig_Dismount");
  var_02 = "rodeoDismount";
  var_03 = % titan_c12_rodeo_player_dismount;
  if(param_01 == "left") {
    var_03 = % titan_c12_rodeo_gun_player_dismount;
  }

  thread func_D3EF(param_00, param_01, var_03);
  param_00 animscripted(var_02, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_03);
  param_00 scripts\anim\shared::donotetracks(var_02, ::func_D403);
}

func_D3F6(param_00, param_01, param_02) {
  func_E5FE(" --- PlayerRig_KnockOff");
  var_03 = "rodeoKnockOff";
  var_04 = % titan_c12_rodeo_player_miss_knockoff;
  if(param_01 == "left") {
    var_04 = % titan_c12_rodeo_gun_player_miss_knockoff;
  }

  thread func_D3F7(param_00, param_01, param_02);
  param_00 animscripted(var_03, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_04);
  param_00 scripts\anim\shared::donotetracks(var_03, ::func_D403);
}

func_35EE(param_00) {
  if(scripts\sp\anim::func_C0DB(param_00)) {}
}

func_D403(param_00, param_01) {
  if(scripts\sp\anim::func_C0DB(param_00)) {
    return;
  }

  if(self.var_13CCC == "right") {
    var_02 = "tag_knife_attach2";
  } else {
    var_02 = "tag_accessory_left";
  }

  var_03 = self.var_3508;
  switch (param_00) {
    case "attach_rocket":
      if(isDefined(self.var_3508.var_E601)) {
        var_03.var_E601 delete();
      }

      self attach(level.var_EC8C["asm_c12_rodeo_rocket"], var_02, 1);
      break;

    case "detach_rocket":
      var_03 thread func_CC50(self);
      self detach(level.var_EC8C["asm_c12_rodeo_rocket"], var_02);
      break;

    case "attach_knife":
      self attach(level.var_EC8C["asm_c12_viewmodel_knife"], var_02, 1);
      break;

    case "knife_hit":
      if(self.var_13CCC == "left") {
        playFXOnTag(level.var_7649["vfx_c12_knife_sparks"], var_03, "j_weaponshoulder_le");
        var_03 thread scripts\sp\utility::play_loop_sound_on_tag("titan_c12_rodeo_fire_loop", "tag_brass_le");
      } else {
        var_04 = self gettagangles("tag_knife_fx");
        var_05 = self gettagorigin("tag_knife_fx") + rotatevector((0, 0, -6), var_04);
        playFX(level.var_7649["vfx_c12_knife_oneshot"], var_05, anglesToForward(var_04), anglestoup(var_04));
      }
      break;

    case "detach_knife":
      self detach(level.var_EC8C["asm_c12_viewmodel_knife"], var_02);
      break;

    case "fire_minigun":
      var_03 thread func_6D73();
      break;

    case "rocket_pop":
      var_03.var_E601 linkto(self, "tag_knife_attach2", (0, 0, 0), (0, 0, 0));
      break;

    case "jump_off":
      self notify("jump_off");
      break;

    case "weapons_free":
      level.player playerlinkto(self, "tag_player");
      var_03 thread func_D3EE(self.var_13CCC);
      self.var_13CC9 = 1;
      self unlink();
      self hide();
      break;

    case "rumble":
      self playrumbleonentity("light_1s");
      break;
  }
}

func_D3EF(param_00, param_01, param_02) {
  self.precacheleaderboards = 1;
  self.var_595F = 1;
  self.playerwillunlink = 1;
  var_03 = gettime() + 1000 * getanimlength(param_02);
  param_00 waittill("jump_off");
  while(gettime() < var_03) {
    var_04 = level.player.origin;
    wait(0.05);
    var_05 = level.player.origin;
    if(!level.player scripts\common\trace::player_trace_passed(var_05, var_05 + var_05 - var_04, level.player.angles, [param_00, level.player, self])) {
      level.player setorigin(var_04);
      break;
    }
  }

  level.player unlink();
  param_00 delete();
  if(!isDefined(param_00.var_13CC9)) {
    thread func_D3EE(param_01);
  }

  self.precacheleaderboards = 0;
  self.var_595F = undefined;
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  wait(0.3);
  level.player.ignoreme = 0;
  if(!self.var_D461) {
    level.player _meth_80A1();
  }

  if(param_01 == "left") {
    lib_0A05::func_3634("c12AchievementRodeoLeft");
  }
}

func_D3EE(param_00) {
  level.player scripts\engine\utility::allow_weapon(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  if(param_00 == "right") {
    self notify("can_damage_rocket");
    thread lib_0F3D::func_50E8(0);
    self _meth_84AE();
    level.player lib_0E42::giveperk("specialty_quickdraw");
    var_01 = getdvarfloat("perk_quickDrawSpeedScaleSP", 1);
    var_02 = getdvarfloat("perk_quickDrawSpeedScaleSniperSP", 1);
    var_03 = getdvarfloat("bg_quickWeaponSwitchSpeedScaleSP", 1);
    var_04 = func_7D71(self.var_D34D);
    setsaveddvar("perk_quickDrawSpeedScaleSP", var_01 * var_04);
    setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_02 * var_04);
    setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_03 / var_04);
    var_05 = int(weaponclipsize(self.var_D34D) * 0.5);
    if(level.player getweaponammoclip(self.var_D34D) < var_05) {
      level.player setweaponammoclip(self.var_D34D, var_05);
    }

    setslowmotion(1, 0.2, 0.2);
    while(isDefined(level.player getlinkedparent()) && isalive(self)) {
      wait(0.05);
    }

    setsaveddvar("perk_quickDrawSpeedScaleSP", var_01);
    setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_02);
    setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_03);
    level.player lib_0E42::removeperk("specialty_quickdraw");
    self _meth_84AD();
    self setCanDamage(1);
    if(!isalive(self)) {
      wait(0.2);
      setslowmotion(0.2, 1, 0.2);
    } else {
      setslowmotion(0.2, 1, 0);
    }
  }

  level.player _meth_84AF(0);
}

func_445F(param_00, param_01) {
  return func_7D6D(param_00) < func_7D6D(param_01);
}

func_7D6D(param_00) {
  var_01 = weaponclass(param_00);
  switch (var_01) {
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

func_7D71(param_00) {
  var_01 = weaponclass(param_00);
  switch (var_01) {
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

func_CC50(param_00) {
  self endon("death");
  var_01 = param_00 gettagorigin("tag_knife_attach2");
  var_02 = param_00 gettagangles("tag_knife_attach2");
  var_03 = spawn("script_model", var_01);
  var_03.angles = var_02;
  var_03 setModel(level.var_EC8C["asm_c12_rodeo_rocket"]);
  var_03 linkto(self, "j_neck");
  self.var_E601 = var_03;
  self waittill("can_damage_rocket");
  var_03 scripts\sp\utility::func_9196(3, 1, 1);
  var_03 setCanDamage(1);
  var_03.health = 9999;
  var_04 = 30;
  while(isDefined(var_03) && var_04 > 0) {
    var_03 waittill("damage", var_05, var_06);
    if(var_06 == level.player) {
      var_04 = var_04 - var_05;
      continue;
    }

    var_03.health = var_03.health + var_05;
  }

  if(!isDefined(var_03)) {
    return;
  }

  var_03 _meth_81D0();
  var_01 = self gettagorigin("j_spineupper");
  self playSound("scn_C12_rodeo_exp");
  playFX(level.var_7649["c12_implode_pre_explosion"], var_01);
  var_07 = int(90 * distance(var_01, level.player.origin) / 1000);
  level.player viewkick(var_07, var_01, 0);
  self getyawtoenemy("vox_c12_death", "vox_c12_death", 1);
  lib_0C46::func_3539("implode", ["right_leg", "left_leg"]);
  self _meth_8189("j_spinelowerbottom");
  self.asm.var_4E73 = 1;
  playrumbleonposition("heavy_1s", var_01);
  earthquake(0.25, 0.5, var_01, 1200);
  lib_0A05::func_3634("c12AchievementRodeoRight");
  var_01 = var_03.origin;
  var_03 delete();
  thread scripts\engine\utility::play_sound_in_space("c12_self_destruct", self.origin);
  self _meth_81D0(var_01, level.player);
}

func_10907() {
  if(isDefined(self.var_E601)) {
    return;
  }

  var_00 = spawn("script_model", self.origin);
  var_00 setModel(level.var_EC8C["asm_c12_rodeo_rocket_nocoll"]);
  var_01 = (7.15, 2, -2.15);
  var_02 = (0, -90, 0);
  var_03 = "j_weaponshoulder_ri";
  var_04 = self gettagangles(var_03);
  var_00 linkto(self, var_03, var_01, var_02);
  self.var_E601 = var_00;
}

func_D3F7(param_00, param_01, param_02) {
  self.playerwillunlink = 1;
  wait(param_02);
  level.player playrumbleonentity("heavy_1s");
  thread lib_0F3D::func_50E8(0);
  level.player _meth_84AF(0);
  if(param_01 == "right") {
    var_03 = "tag_brass_ri";
  } else {
    var_03 = "tag_missile_bottom_back_le";
  }

  var_04 = self gettagorigin(var_03);
  var_05 = vectornormalize(level.player.origin - var_04);
  var_06 = var_05 * 500;
  level.player setvelocity(var_06);
  level.player viewkick(75, var_04);
  if(!self.var_D461) {
    level.player _meth_80A1();
  }

  level.player dodamage(level.player.health * 0.6, var_04, self);
  wait(0.2);
  level.player unlink();
  level.player scripts\engine\utility::allow_weapon(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  param_00 delete();
  level.player.ignoreme = 0;
  self.ignoreme = 0;
  self setCanDamage(1);
}

func_E5FE(param_00) {}

func_D310() {
  self endon("end_rodeo");
  self waittill("death");
  if(isDefined(self.playerwillunlink)) {
    return;
  }

  level.player unlink();
  self.var_D267 delete();
  thread lib_0F3D::func_50E8(0);
  level.player _meth_81DE(65, 0.2);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player _meth_84AF(0);
  level.player scripts\engine\utility::allow_weapon(1);
  level.player.ignoreme = 0;
  level.player.inrodeo = undefined;
  if(!self.var_D461) {
    level.player _meth_80A1();
  }
}
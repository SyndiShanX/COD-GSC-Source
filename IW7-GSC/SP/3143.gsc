/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3143.gsc
************************/

func_351B() {
  self endon("death");
  thread func_D310();
  self notify("begin_rodeo");
  if(self._blackboard.rodeorequested == "left") {
    var_0 = "right";
  } else {
    var_0 = "left";
  }

  if(var_0 == "right") {
    self clearanim(lib_0A1E::func_2356("aimset_right", "arm_pitch"), 0.2);
    self clearanim(lib_0A1E::func_2356("aimset_right", "arm_rail"), 0.2);
  } else {
    self clearanim(lib_0A1E::func_2356("aimset_left", "arm_pitch"), 0.2);
    self clearanim(lib_0A1E::func_2356("aimset_left", "arm_rail"), 0.2);
    self clearanim(lib_0A1E::func_2356("aimset_minigun", "aim_knob"), 0.2);
  }

  var_1 = 0.4;
  var_2 = func_361C(self);
  var_2 scripts\engine\utility::delaycall(var_1, ::show);
  var_2 linkto(self, "j_spineupper");
  var_2.var_3919 = 0;
  var_2.var_13CCC = var_0;
  self.var_D267 = var_2;
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player _meth_84AF(1);
  level.player scripts\engine\utility::allow_weapon(0);
  level.player.inrodeo = 1;
  if(var_0 == "right") {
    var_3 = level.player getcurrentweapon();
    var_4 = level.player scripts\sp\utility::func_7D74(1);
    var_4 = scripts\engine\utility::array_sort_with_func(var_4, ::func_445F);
    if(func_7D6D(var_3) <= func_7D6D(var_4[0])) {
      self.var_D34D = var_3;
    } else {
      self.var_D34D = var_4[0];
      level.player switchtoweapon(self.var_D34D);
    }
  }

  var_5 = "tag_player";
  thread lib_0F3D::func_5103(0.4, 0, 0, 0, 128, 512, 2, 0.1);
  thread func_D3F4(var_2, var_0, self.var_E5F8);
  level.player playerlinktoblend(var_2, var_5, var_1);
  level.player.ignoreme = 1;
  self.ignoreme = 1;
  self.var_D461 = level.player _meth_8525();
  level.player getrankinfoxpamt();
  self setCanDamage(0);
  self._blackboard.var_E5FD = 1;
  lib_0C08::func_351D(var_0, 0);
  func_361A(var_0);
  var_6 = "rodeo_left";
  if(var_0 == "left") {
    var_6 = "rodeo_right";
  }

  self _meth_82E7("RodeoJump", lib_0A1E::func_2356(var_6, "jump_" + self.var_E5F8), 1, 0.2, 1);
  lib_0A1E::func_231F("rodeo", "RodeoJump", ::func_35EE);
  thread func_D3FA(var_2, var_0);
  thread func_D433(self.var_D267, var_0);
  var_7 = func_35F1(lib_0A1E::func_2356(var_6, "mount"), var_0);
  var_8 = 3;
  if(var_7 < 2) {
    while(var_8) {
      var_7 = func_35F1(lib_0A1E::func_2356(var_6, "miss"), var_0, 1);
      var_8--;
      if(var_7 == 2) {
        break;
      }

      wait(randomfloatrange(0.2, 0.5));
    }
  }

  self.var_D267.var_3919 = 0;
  if(var_7 == 2) {
    thread func_D3F0(self.var_D267, var_0);
    if(var_0 == "right") {
      func_10907();
    }

    var_9 = lib_0A1E::func_2356(var_6, "hit");
    self _meth_82E7("RodeoHit", var_9, 1, 0.2, 1);
    lib_0A1E::func_231F("rodeo", "RodeoHit", ::func_35EE);
    self clearanim(var_9, 0.2);
    if(var_0 == "left") {
      thread func_35F2(var_2);
      thread func_D404(var_2);
      var_0A = lib_0A1E::func_2356(var_6, "struggle");
      self _meth_82EA("RodeoStruggle", var_0A, 1, 0.2, 1);
      self waittill("struggle_succeeded");
      self clearanim(var_0A, 0.2);
      thread lib_0F3D::func_50E8(0.2);
    }

    var_0A = lib_0A1E::func_2356(var_6, "success");
    thread func_D3ED(self.var_D267, var_0);
    self _meth_82E7("RodeoDismount", var_0A, 1, 0.2, 1);
    if(var_0 == "left") {
      self give_attacker_kill_rewards(lib_0A1E::func_2356("rodeo_right", "fire"), 1, 0.2, 1);
    }

    lib_0A1E::func_231F("rodeo", "RodeoDismount", ::func_35EE);
    self.var_30EA = 1;
  } else {
    var_0A = lib_0A1E::func_2356(var_7, "fail");
    var_0B = scripts\engine\utility::get_notetrack_time(var_0A, "knockoff");
    thread func_D3F6(self.var_D267, var_0, var_0B);
    self _meth_82E7("RodeoKnockOff", var_0A, 1, 0.2, 1);
    lib_0A1E::func_231F("rodeo", "RodeoKnockOff", ::func_35EE);
    self.asm.var_11B08.var_30E6 = 0;
  }

  thread func_E245();
  self._blackboard.var_E5FD = 0;
  self.var_7212 = gettime() + 10000;
  lib_0C08::func_351D(var_0, 1);
  level.player.inrodeo = undefined;
  self notify("end_rodeo");
}

func_E245() {
  self endon("death");
  self._blackboard.var_E5F9 = 1;
  wait(0.75);
  self._blackboard.var_E5F9 = undefined;
}

func_361A(var_0) {
  var_1 = "aimset_" + var_0;
  var_2 = 0.2;
  var_3 = lib_0A1E::func_2356(var_1, "arm_rail");
  self clearanim(var_3, var_2);
  var_3 = lib_0A1E::func_2356(var_1, "arm_pitch");
  self clearanim(var_3, var_2);
}

func_35F1(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 0;
  var_4 = [scripts\engine\utility::get_notetrack_time(var_0, "hit_start"), scripts\engine\utility::get_notetrack_time(var_0, "hit_end")];
  var_5 = gettime();
  self _meth_82E7("RodeoHitPlayer", var_0, 1, 0.2, 1);
  thread lib_0A1E::func_231F("rodeo", "RodeoHitPlayer", ::func_35EE);
  wait(var_4[0] - 0.05);
  var_6 = func_4A09(var_1);
  if(isDefined(var_2) && var_2) {
    level.player viewkick(30, var_6.origin, 0);
    level.player playrumbleonentity("light_1s");
  }

  var_7 = func_D3B0();
  wait(0.05);
  self.var_D267.var_3919 = 0;
  var_6 makeusable();
  var_8 = var_4[1] - var_4[0] * 3000;
  var_9 = var_5 + var_4[0] * 1000 + var_8;
  func_E5FE("Can HIT NOW " + var_9 - gettime());
  while(gettime() < var_9) {
    if(func_D3B0() && !var_7) {
      var_3 = 2;
      break;
    } else if(var_7) {
      var_7 = func_D3B0();
    }

    wait(0.05);
  }

  func_E5FE("Cannot HIT");
  var_6 makeunusable();
  var_6 delete();
  while(self getscoreinfocategory(var_0) < 0.99) {
    wait(0.05);
  }

  self.var_D267.var_3919 = 1;
  return var_3;
}

func_35F2(var_0) {
  self endon("death");
  var_1 = lib_0A1E::func_2356("rodeo_right", "struggle");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 _meth_81E2(level.player, "tag_origin", (50, 0, -15), (0, 0, 0), 1);
  var_2 setcursorhint("HINT_BUTTON");
  var_2 _meth_84B8(1);
  var_2 setuserange(500);
  var_2 _meth_84A4(500);
  var_2 makeusable();
  var_2 show();
  self.var_A8E4 = 0;
  thread func_35F4();
  var_3 = 1;
  var_4 = var_3;
  var_5 = 0;
  var_6 = 0.01;
  var_7 = 0.3;
  self.var_B3C3 = 0;
  var_8 = 5;
  var_9 = 1000 / var_8;
  self.var_6D3E = 1;
  thread func_35F3();
  var_0 _meth_8244("steady_rumble");
  var_0A = getdvarint("cg_fov");
  var_0B = 50;
  var_0C = var_0A - var_0B;
  while(var_5 < 0.9) {
    scripts\engine\utility::waitframe();
    var_4 = var_3;
    var_3 = self.var_B3C3 >= var_8;
    var_0D = gettime() - self.var_A8E4;
    var_5 = self getscoreinfocategory(var_1);
    if(var_3 && !var_4) {
      self _meth_82B1(var_1, var_7);
      var_0 _meth_82B1(var_0.var_11169, var_7);
    }

    if(!var_3) {
      if(var_4) {
        self _meth_82B1(var_1, 0);
        var_0 _meth_82B1(var_0.var_11169, 0);
        continue;
      }

      if(var_5 > var_6) {
        var_5 = var_5 - var_6;
        self _meth_82B0(var_1, var_5);
        var_0 _meth_82B0(var_0.var_11169, var_5);
      }
    }

    level.player _meth_81DE(var_0A - var_0C * var_5, 0.05);
  }

  self notify("mash_end");
  level.player notify("stop_temperature_sfx");
  self.var_6D3E = 0;
  var_2 makeunusable();
  var_2 delete();
  self _meth_82B1(var_1, var_7);
  var_0 _meth_82B1(var_0.var_11169, var_7);
  level.player _meth_81DE(var_0B, getanimlength(var_1) * 1 - var_5 / var_7);
  while(self getscoreinfocategory(var_1) < 1) {
    scripts\engine\utility::waitframe();
  }

  self _meth_82B1(var_1, 0);
  var_0 _meth_82B1(var_0.var_11169, 0);
  playFXOnTag(level.var_7649["vfx_c12_joint_selfdestruct_head_buildup"], self, "j_neck");
  wait(0.4);
  self setscriptablepartstate("head", "rodeofinal");
  thread scripts\sp\utility::play_sound_on_tag("c12_rodeo_head_explo", "j_neck");
  scripts\asm\asm_bb::bb_setselfdestruct(1);
  level.player viewkick(40, self gettagorigin("j_neck"), 0);
  earthquake(0.4, 0.5, self gettagorigin("j_neck"), 256);
  var_0 stoprumble("steady_rumble");
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
  var_0 = 0;
  for(;;) {
    scripts\engine\utility::waitframe();
    if(level.player usebuttonpressed()) {
      if(!var_0) {
        self.var_A8E4 = gettime();
        thread func_12DE6();
      }

      var_0 = 1;
      continue;
    }

    var_0 = 0;
  }
}

func_35F3() {
  self endon("death");
  var_0 = isDefined(level.var_470F);
  level.var_470F = 1;
  thread func_116C9();
  var_1 = level.player.health;
  var_2 = level.player.maxhealth;
  level.player.health = level.player.maxhealth;
  var_3 = level.player.health;
  var_4 = level.var_35C6;
  var_5 = "j_weaponshoulder_le";
  thread func_A661(var_5);
  while(self.var_6D3E && isalive(level.player)) {
    var_3 = var_3 - var_4;
    var_6 = level.player.health - var_3;
    level.player _meth_80A1();
    level.player dodamage(var_6, level.player.origin, self);
    level.player getrankinfoxpamt();
    wait(2);
  }

  if(!isalive(level.player)) {
    return;
  }

  if(scripts\sp\utility::func_93A6()) {
    level.player.health = var_1;
    level.player.maxhealth = var_2;
  }

  if(!var_0) {
    level.var_470F = undefined;
  }
}

func_A661(var_0) {
  self waittill("death");
  killfxontag(level.var_7649["vfx_c12_knife_sparks"], self, var_0);
}

func_116C9() {
  var_0 = undefined;
  var_1 = 10;
  var_2 = 400;
  var_3 = getomnvar("ui_helmet_meter_temperature");
  var_4 = var_3;
  var_0 = undefined;
  while(self.var_6D3E && isalive(self)) {
    if(!isDefined(var_0)) {
      level.player setclientomnvar("ui_show_temperature_gauge", 1);
      var_0 = 1;
      level.player playSound("scn_c12_rodeo_plr_on_fire");
      thread func_35EF();
    }

    wait(0.05);
    var_4 = var_4 + var_1;
    var_4 = min(var_4, var_2);
    level.player setclientomnvar("ui_helmet_meter_temperature", var_4);
  }

  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  wait(2);
  while(var_4 > var_3) {
    wait(0.05);
    var_4 = var_4 - var_1 * 2;
    var_4 = max(var_4, var_3);
    level.player setclientomnvar("ui_helmet_meter_temperature", var_4);
  }
}

func_35EF() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkto(level.player);
  wait(0.05);
  var_0 playSound("ui_c12_rodeo_temperature_warning_lp_start");
  wait(0.5);
  var_0 thread c12_rodeo_temperature_sfx_lp();
  level.player scripts\engine\utility::waittill_any_3("stop_temperature_sfx", "death");
  var_0 stoploopsound("ui_c12_rodeo_temperature_warning_lp");
  var_0 delete();
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
  var_0 = self.secondaryweapon;
  var_1 = "tag_weapon_rotate_le";
  self give_attacker_kill_rewards(lib_0A1E::func_2356("rodeo_right", "fire"), 1, 0.2, 1);
  var_2 = lib_0A1E::func_2356("rodeo_right", "struggle");
  var_3 = getnotetracktimes(var_2, "impfx");
  var_4 = [level.var_7649["vfx_imp_cstm_rodeo_a"], level.var_7649["vfx_imp_cstm_rodeo_b"], level.var_7649["vfx_imp_cstm_rodeo_c"], level.var_7649["vfx_imp_cstm_rodeo_d"], level.var_7649["vfx_imp_cstm_rodeo_e"], level.var_7649["vfx_imp_cstm_rodeo_final"]];
  var_5 = 0;
  var_6 = getnotetracktimes(var_2, "headseq");
  var_7 = 0;
  var_8 = "titan_c12_rodeo_bullet_hits_lp";
  var_9 = 0;
  for(;;) {
    var_0A = self gettagorigin(var_1);
    var_0B = self gettagangles(var_1);
    var_0C = var_0A + anglesToForward(var_0B);
    var_0D = bulletspread(var_0A, var_0C, 4);
    self _meth_8494(var_0, var_0A, var_0B, 1, var_0D, 0, 0, var_1);
    var_0E = 0.35;
    if(!isDefined(self.brodeostrugglesucceeded) || !self.brodeostrugglesucceeded) {
      var_0F = self getscoreinfocategory(var_2);
      if(var_5 < var_3.size && var_0F >= var_3[var_5]) {
        self.var_E5EF = var_4[var_5];
        var_5++;
      }

      if(var_7 < var_6.size && var_0F >= var_6[var_7]) {
        self setscriptablepartstate("head", "rodeo" + var_7);
        var_7++;
      }

      if(isDefined(self.var_E5EF)) {
        var_10 = scripts\common\trace::ray_trace_detail(var_0C, var_0D);
        if(isDefined(var_10["entity"]) && var_10["entity"] == self) {
          var_0E = 0.6;
          playFXOnTag(self.var_E5EF, self, "j_helmet");
          level.player playrumbleonentity("light_1s");
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

    earthquake(var_0E, 0.1, self gettagorigin("tag_brass_le"), 32);
    wait(0.1);
  }
}

func_12DE6() {
  var_0 = 1;
  if(self.var_B3C3 == 0) {
    var_0 = 3;
  }

  self.var_B3C3 = self.var_B3C3 + var_0;
  wait(1);
  self.var_B3C3 = self.var_B3C3 - var_0;
}

func_D91A(var_0) {}

func_D3B0() {
  return isalive(level.player) && level.player meleebuttonpressed();
}

func_D433(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = 0;
  for(;;) {
    wait(0.05);
    if(!var_0.var_3919) {
      continue;
    }

    if(!var_2) {
      var_2 = 1;
      thread func_D3F3(var_0, var_1);
    }

    if(!func_D3B0()) {
      continue;
    }

    var_2 = 0;
    func_D3F2(var_0, var_1);
  }
}

func_4A09(var_0) {
  var_1 = "j_missile_backcover_ri";
  var_2 = (0, 0, 0);
  if(var_0 == "left") {
    var_1 = "tag_brass_le";
    var_2 = (-3, -12, 0);
  }

  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3 linkto(self, var_1, var_2, (0, 0, 0));
  var_3 _meth_84A3("+melee");
  var_3 setcursorhint("HINT_BUTTON");
  var_3 setuserange(50);
  var_3 _meth_84A4(100);
  var_3 sethintstring(&"SCRIPT_C12_RODEO_MELEE");
  return var_3;
}

func_361C(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 glinton(#animtree);
  var_2 = level.player _meth_84C6("currentViewModel");
  if(isDefined(var_2)) {
    var_1 setModel(var_2);
  }

  var_1 hide();
  var_1.var_3508 = var_0;
  var_1.var_11169 = % titan_c12_rodeo_gun_player_struggle;
  return var_1;
}

func_D3F4(var_0, var_1, var_2) {
  func_E5FE(" --- PlayerRig_Jump");
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
  level.player playrumbleonentity("doublejumpboost_start");
  var_0 animscripted(var_3, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_4);
  var_0 scripts\anim\shared::donotetracks(var_3, ::func_D403);
}

func_D3FA(var_0, var_1) {
  func_E5FE(" --- PlayerRig_Mount");
  var_2 = "rodeoMount";
  var_3 = % titan_c12_rodeo_player_mount;
  if(var_1 == "left") {
    var_3 = % titan_c12_rodeo_gun_player_mount;
  }

  var_0 animscripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_3);
  var_0 scripts\anim\shared::donotetracks(var_2, ::func_D403);
}

func_D3F0(var_0, var_1) {
  func_E5FE(" --- PlayerRig_Hit");
  var_2 = "rodeoHit";
  var_3 = % titan_c12_rodeo_player_hit;
  if(var_1 == "left") {
    var_3 = % titan_c12_rodeo_gun_player_hit;
  }

  var_0 animscripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_3);
  var_0 scripts\anim\shared::donotetracks(var_2, ::func_D403);
}

func_D3F2(var_0, var_1) {
  func_E5FE(" --- PlayerRig_HitQuickMiss");
  var_2 = "rodeoQuickMiss";
  if(var_1 == "right") {
    var_0 animscripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), % titan_c12_rodeo_player_miss_quick);
  } else {
    var_0 _meth_82E7(var_2, % titan_c12_rodeo_gun_player_miss_quick);
  }

  var_0 scripts\anim\shared::donotetracks(var_2, ::func_D403);
}

func_D3F3(var_0, var_1) {
  func_E5FE(" --- PlayerRig_Idle");
  var_2 = "rodeoIdle";
  if(var_1 == "right") {
    var_0 animscripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), % titan_c12_rodeo_player_idle);
  } else {
    var_0 _meth_82E7(var_2, % titan_c12_rodeo_gun_player_idle);
  }

  var_0 scripts\anim\shared::donotetracks(var_2, ::func_D403);
}

func_D404(var_0) {
  func_E5FE(" --- PlayerRig_Struggle");
  var_1 = "rodeoStruggle";
  var_0 animscripted(var_1, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_0.var_11169);
  var_0 scripts\anim\shared::donotetracks(var_1, ::func_D403);
}

func_D3ED(var_0, var_1) {
  func_E5FE(" --- PlayerRig_Dismount");
  var_2 = "rodeoDismount";
  var_3 = % titan_c12_rodeo_player_dismount;
  if(var_1 == "left") {
    var_3 = % titan_c12_rodeo_gun_player_dismount;
  }

  thread func_D3EF(var_0, var_1, var_3);
  var_0 animscripted(var_2, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_3);
  var_0 scripts\anim\shared::donotetracks(var_2, ::func_D403);
}

func_D3F6(var_0, var_1, var_2) {
  func_E5FE(" --- PlayerRig_KnockOff");
  var_3 = "rodeoKnockOff";
  var_4 = % titan_c12_rodeo_player_miss_knockoff;
  if(var_1 == "left") {
    var_4 = % titan_c12_rodeo_gun_player_miss_knockoff;
  }

  thread func_D3F7(var_0, var_1, var_2);
  var_0 animscripted(var_3, self gettagorigin("j_spineupper"), self gettagangles("j_spineupper"), var_4);
  var_0 scripts\anim\shared::donotetracks(var_3, ::func_D403);
}

func_35EE(var_0) {
  if(scripts\sp\anim::func_C0DB(var_0)) {}
}

func_D403(var_0, var_1) {
  if(scripts\sp\anim::func_C0DB(var_0)) {
    return;
  }

  if(self.var_13CCC == "right") {
    var_2 = "tag_knife_attach2";
  } else {
    var_2 = "tag_accessory_left";
  }

  var_3 = self.var_3508;
  switch (var_0) {
    case "attach_rocket":
      if(isDefined(self.var_3508.var_E601)) {
        var_3.var_E601 delete();
      }

      self attach(level.var_EC8C["asm_c12_rodeo_rocket"], var_2, 1);
      break;

    case "detach_rocket":
      var_3 thread func_CC50(self);
      self detach(level.var_EC8C["asm_c12_rodeo_rocket"], var_2);
      break;

    case "attach_knife":
      self attach(level.var_EC8C["asm_c12_viewmodel_knife"], var_2, 1);
      break;

    case "knife_hit":
      if(self.var_13CCC == "left") {
        playFXOnTag(level.var_7649["vfx_c12_knife_sparks"], var_3, "j_weaponshoulder_le");
        var_3 thread scripts\sp\utility::play_loop_sound_on_tag("titan_c12_rodeo_fire_loop", "tag_brass_le");
      } else {
        var_4 = self gettagangles("tag_knife_fx");
        var_5 = self gettagorigin("tag_knife_fx") + rotatevector((0, 0, -6), var_4);
        playFX(level.var_7649["vfx_c12_knife_oneshot"], var_5, anglesToForward(var_4), anglestoup(var_4));
      }
      break;

    case "detach_knife":
      self detach(level.var_EC8C["asm_c12_viewmodel_knife"], var_2);
      break;

    case "fire_minigun":
      var_3 thread func_6D73();
      break;

    case "rocket_pop":
      var_3.var_E601 linkto(self, "tag_knife_attach2", (0, 0, 0), (0, 0, 0));
      break;

    case "jump_off":
      self notify("jump_off");
      break;

    case "weapons_free":
      level.player playerlinkto(self, "tag_player");
      var_3 thread func_D3EE(self.var_13CCC);
      self.var_13CC9 = 1;
      self unlink();
      self hide();
      break;

    case "rumble":
      self playrumbleonentity("light_1s");
      break;
  }
}

func_D3EF(var_0, var_1, var_2) {
  self.precacheleaderboards = 1;
  self.var_595F = 1;
  self.playerwillunlink = 1;
  var_3 = gettime() + 1000 * getanimlength(var_2);
  var_0 waittill("jump_off");
  while(gettime() < var_3) {
    var_4 = level.player.origin;
    wait(0.05);
    var_5 = level.player.origin;
    if(!level.player scripts\common\trace::player_trace_passed(var_5, var_5 + var_5 - var_4, level.player.angles, [var_0, level.player, self])) {
      level.player setorigin(var_4);
      break;
    }
  }

  level.player unlink();
  var_0 delete();
  if(!isDefined(var_0.var_13CC9)) {
    thread func_D3EE(var_1);
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

  if(var_1 == "left") {
    lib_0A05::func_3634("c12AchievementRodeoLeft");
  }
}

func_D3EE(var_0) {
  level.player scripts\engine\utility::allow_weapon(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  if(var_0 == "right") {
    self notify("can_damage_rocket");
    thread lib_0F3D::func_50E8(0);
    self _meth_84AE();
    level.player lib_0E42::giveperk("specialty_quickdraw");
    var_1 = getdvarfloat("perk_quickDrawSpeedScaleSP", 1);
    var_2 = getdvarfloat("perk_quickDrawSpeedScaleSniperSP", 1);
    var_3 = getdvarfloat("bg_quickWeaponSwitchSpeedScaleSP", 1);
    var_4 = func_7D71(self.var_D34D);
    setsaveddvar("perk_quickDrawSpeedScaleSP", var_1 * var_4);
    setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_2 * var_4);
    setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_3 / var_4);
    var_5 = int(weaponclipsize(self.var_D34D) * 0.5);
    if(level.player getweaponammoclip(self.var_D34D) < var_5) {
      level.player setweaponammoclip(self.var_D34D, var_5);
    }

    setslowmotion(1, 0.2, 0.2);
    while(isDefined(level.player getlinkedparent()) && isalive(self)) {
      wait(0.05);
    }

    setsaveddvar("perk_quickDrawSpeedScaleSP", var_1);
    setsaveddvar("perk_quickDrawSpeedScaleSniperSP", var_2);
    setsaveddvar("bg_quickWeaponSwitchSpeedScaleSP", var_3);
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

func_445F(var_0, var_1) {
  return func_7D6D(var_0) < func_7D6D(var_1);
}

func_7D6D(var_0) {
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

func_7D71(var_0) {
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

func_CC50(var_0) {
  self endon("death");
  var_1 = var_0 gettagorigin("tag_knife_attach2");
  var_2 = var_0 gettagangles("tag_knife_attach2");
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setModel(level.var_EC8C["asm_c12_rodeo_rocket"]);
  var_3 linkto(self, "j_neck");
  self.var_E601 = var_3;
  self waittill("can_damage_rocket");
  var_3 scripts\sp\utility::func_9196(3, 1, 1);
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
  playFX(level.var_7649["c12_implode_pre_explosion"], var_1);
  var_7 = int(90 * distance(var_1, level.player.origin) / 1000);
  level.player viewkick(var_7, var_1, 0);
  self getyawtoenemy("vox_c12_death", "vox_c12_death", 1);
  lib_0C46::func_3539("implode", ["right_leg", "left_leg"]);
  self _meth_8189("j_spinelowerbottom");
  self.asm.var_4E73 = 1;
  playrumbleonposition("heavy_1s", var_1);
  earthquake(0.25, 0.5, var_1, 1200);
  lib_0A05::func_3634("c12AchievementRodeoRight");
  var_1 = var_3.origin;
  var_3 delete();
  thread scripts\engine\utility::play_sound_in_space("c12_self_destruct", self.origin);
  self _meth_81D0(var_1, level.player);
}

func_10907() {
  if(isDefined(self.var_E601)) {
    return;
  }

  var_0 = spawn("script_model", self.origin);
  var_0 setModel(level.var_EC8C["asm_c12_rodeo_rocket_nocoll"]);
  var_1 = (7.15, 2, -2.15);
  var_2 = (0, -90, 0);
  var_3 = "j_weaponshoulder_ri";
  var_4 = self gettagangles(var_3);
  var_0 linkto(self, var_3, var_1, var_2);
  self.var_E601 = var_0;
}

func_D3F7(var_0, var_1, var_2) {
  self.playerwillunlink = 1;
  wait(var_2);
  level.player playrumbleonentity("heavy_1s");
  thread lib_0F3D::func_50E8(0);
  level.player _meth_84AF(0);
  if(var_1 == "right") {
    var_3 = "tag_brass_ri";
  } else {
    var_3 = "tag_missile_bottom_back_le";
  }

  var_4 = self gettagorigin(var_3);
  var_5 = vectornormalize(level.player.origin - var_4);
  var_6 = var_5 * 500;
  level.player setvelocity(var_6);
  level.player viewkick(75, var_4);
  if(!self.var_D461) {
    level.player _meth_80A1();
  }

  level.player dodamage(level.player.health * 0.6, var_4, self);
  wait(0.2);
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

func_E5FE(var_0) {}

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
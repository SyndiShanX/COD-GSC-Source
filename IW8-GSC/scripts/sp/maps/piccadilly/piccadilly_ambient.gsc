/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly_ambient.gsc
*************************************************************/

function precache() {
  precachemodel("greece_cash_register");
  precachemodel("veh8_piccadilly_crash_gr1_secho_soft");
  precachemodel("veh8_piccadilly_crash_gr1_skilo_soft");
  precachemodel("veh8_piccadilly_crash_gr1_victor_soft");
  precachemodel("veh8_piccadilly_crash_gr1_walfa_soft");
  precachemodel("veh8_piccadilly_crash_gr1_secho_soft_dmg");
  precachemodel("veh8_piccadilly_crash_gr1_skilo_soft_dmg");
  precachemodel("veh8_piccadilly_crash_gr1_victor_soft_dmg");
  precachemodel("veh8_piccadilly_crash_gr1_walfa_soft_dmg");
  precachemodel("veh8_piccadilly_accident_gr2_victor_soft_dmg");
  scripts\engine\utility::flag_init("sting_building_bump_p1");
  scripts\engine\utility::flag_init("sting_building_bump_p2");
  scripts\engine\utility::flag_init("sting_building_bump_p3");
  scripts\engine\utility::flag_init("lilly_white_execution_time_out");
  scripts\engine\utility::flag_init("lilly_white_execution_save");
  scripts\engine\utility::flag_init("lilly_white_interupt");
  scripts\engine\utility::flag_init("lillywhites_terry_dead");
  scripts\engine\utility::flag_init("left_side_under_engaged");
  scripts\engine\utility::flag_init("post_explosion");
  scripts\engine\utility::flag_init("player_went_upstairs");
  scripts\engine\utility::flag_init("scripted_sniper");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("left_underground_hero_cop", &left_underground_hero_cop);
}

function main() {
  thread injured_vignettes();
  var0 = scripts\engine\utility::getStructArray("bullet_background", "targetname");
  scripts\engine\utility::array_thread(var0, &ambient_fighting);
  scripts\engine\utility::flag_wait("combat_approach");
  left_side();
  right_side();
  scripts\engine\sp\utility::flagwaitthread("ripleys_explosion", &ambient_explosion, "ripleys_explosion");
  scripts\engine\sp\utility::flagwaitthread("bank_explosion", &ambient_explosion, "bank_explosion");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("car_vignette", &car_vignette_guy);
  thread scriptable_car_getouts();
  thread sirens_on();
}

function sirens_on() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("sirens_on", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("siren", "siren_on");
  }
}

function ambient_fighting() {
  self endon("stop_audio");

  while(distance2dsquared(self.origin, level.player.origin) > 7290000) {
    wait 0.5;
  }

  GscBinSkip4(0x35);
}

function ambient_fighting_monitor_player() {
  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) <= squared(self.radius)) {
      self notify("stop_audio");
    }

    if(level.player.origin[1] >= self.origin[1]) {
      self notify("stop_audio");
    }

    if(scripts\engine\utility::flag("gap_approach")) {
      self notify("stop_audio");
    }

    wait 1;
  }
}

function injured_vignettes() {
  level.injured_actors = [];
  var0 = scripts\engine\utility::getStructArray("injured_vignette", "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2.script_noteworthy)) {
      switch (var2.script_noteworthy) {
        case "drag03":
        case "drag02":
        case "drag01":
          thread drag_scene();
          break;
        case "civ08":
        case "civ07":
        case "civ06":
        case "civ05":
        case "civ04":
        case "civ03":
        case "civ01":
          thread injured_loop_single_death();
          break;
      }
    } else {
      thread injured_loop_vignette();
    }

    waitframe();
  }
}

function car_vignette_guy() {
  waitframe();

  if(!getaiarrayinradius(self.origin, 900, "axis").size) {
    self delete();
    return;
  }

  self hide();
  thread scripts\engine\sp\utility::notify_delay("stop_going_to_node", 0.1);
  thread scripts\common\ai::magic_bullet_shield();
  self.ignoreme = 1;
  self.animnode = scripts\engine\utility::getStruct(self.target, "targetname");
  self.animname = "generic";
  scripts\engine\utility::delaycall(0.05, &show);
  self.animnode thread scripts\common\anim::anim_loop_solo(self, "lon_int_010_subway_idle");
  wait 0.2;
  var0 = self getEye();
  level.player scripts\sp\maps\piccadilly\piccadilly_util::waittill_within_fov_from_dist(400, var0, 2);
  self.animnode notify("stop_loop");
  self.animnode scripts\common\anim::anim_single_solo(self, "lon_int_010_subway_death");
}

function injured_loop_vignette() {
  if(scripts\sp\starts::is_after_start("lillywhites")) {
    return;
  }

  while(distance2dsquared(self.origin, level.player.origin) > 2250000) {
    wait 1;
  }

  var0 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1, 1);
  var0.animname = "generic";

  if(isDefined(self.script_noteworthy)) {
    var0.script_noteworthy = self.script_noteowrthy;
  }

  var0.script_index = 1;
  thread vignette_drone_give_soul();
  var0 thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();
  var0.script_animation = self.script_animation;
  self.script_animation = undefined;
  thread vo_injured_loop();
  thread scripts\common\anim::anim_loop_solo(var0, var0.script_animation);
  level.injured_actors[level.injured_actors.size] = var0;
}

function vo_injured_loop() {
  self endon("death");
  var0 = [];

  if(scripts\engine\utility::is_equal(self.voice, "unitednationsfemale")) {
    GscBinSkip0(0x2e, var0.size, "dx_vom_ucf1_sting_rear_wounded_60");
  }

  GscBinSkip0(0x2e, var0.size, "dx_vom_ucm1_sting_rear_wounded_20");
}

function injured_loop_single_death() {
  var0 = spawn_looping_fakeactor_wait_for_player();
  var1 = self.radius;

  if(!isDefined(var0)) {
    level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
    return;
  }

  while(isDefined(var0) && !should_do_death_vignette(var0, var1)) {
    wait 0.1;
  }

  if(!isDefined(var0)) {
    return;
  }

  spawn_death_vignette_ai(var0);
}

function should_do_death_vignette(var0) {
  if(getaiarray().size > 28) {
    return false;
  }

  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = 1200;
  }

  var2 = getaiarrayinradius(self.origin, var1, "axis");

  if(!var2.size) {
    return false;
  }

  if(distancesquared(level.player.origin, self.origin + (0, 0, 70)) <= 422500 && level.player scripts\engine\trace::can_see_origin(self.origin + (0, 0, 70), 0)) {
    return true;
  }

  return false;
}

function spawn_death_vignette_ai(var0) {
  var1 = undefined;
  var1 = spawn_my_twin(var0);

  if(isDefined(var0.magic_bullet_shield)) {
    var0 scripts\common\ai::stop_magic_bullet_shield();
  }

  var0 scripts\engine\utility::delaycall(0.05, &delete);
  thread injured_dmg_death_logic();
  var1 thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();
  var1 endon("death");
  var1 endon("scripted_death");
  var1 thread scripts\sp\maps\piccadilly\piccadilly::vo_ally_warn_me();

  if(isDefined(level.scr_anim[var1.animname]["run"])) {
    scripts\sp\anim::anim_custom_animmode([var1], "gravity", "run");
    var1 scripts\sp\anim::anim_custom_animmode([var1], "gravity", "injured_death");
  } else {
    scripts\sp\anim::anim_custom_animmode([var1], "gravity", "injured_death");
  }

  var1.a.nodeath = 1;
  var1.allowdeath = 1;
  var1 scripts\common\ai::stop_magic_bullet_shield();
  var1 scripts\engine\sp\utility::die();
}

function spawn_looping_fakeactor_wait_for_player() {
  level endon("spawn_gap_bomber");

  while(distance2dsquared(self.origin, level.player.origin) > 2250000) {
    wait 1;
  }

  var0 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1, 1);
  var0.animname = self.script_noteworthy;
  var0 setCanDamage(1);
  thread injured_dmg_death_logic();
  level.injured_actors[level.injured_actors.size] = var0;
  var0 endon("death");
  thread scripts\common\anim::anim_loop_solo(var0, "idle");
  waitframe();
  var0 thread scripts\anim\death::play_blood_pool();
  level.player scripts\sp\maps\piccadilly\piccadilly_util::waittill_within_fov_from_dist(650, var0.origin + (0, 0, 70), 10);
  return var0;
}

function injured_dmg_death_logic() {
  self endon("entitydeleted");
  GscBinSkip4(0x35);
}

function injured_actor_death(var0) {
  self waittill("scripted_death", var1, var2, var3, var3, var4, var3, var3, var3, var3, var5, var3, var3, var3, var6);
  scripts\common\ai::stop_magic_bullet_shield();
  var7 = 0;

  if(isDefined(self.lastattacker) && scripts\engine\utility::is_equal(self.lastattacker.asmname, "suicidebomber")) {
    var7 = 1;
  }

  if(!var7 && isDefined(self.damageweapon) && scripts\engine\utility::is_equal(self.damageweapon.basename, "suicide_vest")) {
    var7 = 1;
  }

  if(var7) {
    scripts\asm\soldier\death::dogib();
    self hide();

    if(isai(self)) {
      scripts\asm\soldier\death::deathcleanup();
    }

    self delete();
  } else {
    thread scripts\sp\maps\piccadilly\piccadilly_util::death_vo();

    if(!isai(self)) {
      if(isDefined(self)) {
        self freeentitysentient();
      }

      if(isDefined(self)) {
        self startragdoll();
      }

      if(isDefined(self)) {
        self notsolid();
      }

      self dodamage(self.health + 100, self.origin, var2, var6, var4, var5);
      self scriptmoverdistancefade();
    } else {
      scripts\engine\sp\utility::anim_stopanimScripted();
      self.forceragdollimmediate = 1;
      scripts\engine\sp\utility::set_allowdeath(1);
      scripts\engine\sp\utility::die();
    }
  }

  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
  waitframe();
}

function spawn_my_twin(var0) {
  var1 = undefined;

  if(isDefined(self.script_forcecolor)) {
    while(!isDefined(var1)) {
      var1 = scripts\engine\utility::random(getspawnerarray("obj_frontline")) stalingradspawn();

      if(!isDefined(var1)) {
        wait 0.5;
        continue;
      }

      var1.animname = self.animname;
      var1.voice = self.voice;

      if(!isDefined(var0)) {
        var1 forceteleport(self.origin, self.angles, 99999);
      }

      return var1;
    }
  }

  while(!isDefined(var1)) {
    var1 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random");

    if(!isDefined(var1)) {
      wait 0.5;
    }
  }

  var1 setModel(self.model);

  if(var1.headmodel != self.headmodel) {
    var1 detach(var1.headmodel);
    var1 attach(self.headmodel);
  }

  var1 setthreatbiasgroup("civilians");
  var1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var1.script_friendname = "";
  var1.name = self.script_friendname;
  var1.animname = self.animname;
  var1.voice = self.voice;
  return var1;
}

function drag_scene() {
  while(distance2dsquared(self.origin, level.player.origin) > 2250000) {
    wait 1;
  }

  var0 = self.script_noteworthy;
  self.intro = var0 + "_intro_idle";
  self.single = var0;
  self.outro = var0 + "_outro_idle";
  self.guy1 = spawn_drone_cop();
  self.guy1.animname = "guy1";
  self.guy1.animnode = self;
  level.injured_actors[level.injured_actors.size] = self.guy1;
  thread vignette_drone_give_soul();
  thread group_vignette_dmg_func(self.guy1, self);
  thread group_vignette_death_func(self.guy1, self);
  self.guy2 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("female", 1, 1);
  self.guy2.animname = "guy2";
  thread vignette_drone_give_soul();
  thread group_vignette_dmg_func(self.guy2, self);
  thread group_vignette_death_func(self.guy2, self);
  level.injured_actors[level.injured_actors.size] = self.guy2;
  thread drag_scene_internal();
  self waittill("update", var1, var2, var3, var4, var4, var5, var4, var4, var4, var4, var6, var4, var4, var4, var7);

  switch (var1) {
    case "all_dead":
    case "guy1_shot":
      if(isDefined(self.stuntguy1)) {
        self.stuntguy1 scripts\engine\sp\utility::anim_stopanimScripted();
        self.stuntguy1 dodamage(self.stuntguy1.health + 100, self.stuntguy1.origin, var3, var7, var5, var6);

        if(isDefined(self.guy1)) {
          self.guy1 delete();
        }
      } else if(isDefined(self.guy1)) {
        self.guy1 notify("death");
        drone_death_cleanup(self.guy1, self);
      }

      if(isDefined(self.stuntguy2)) {
        self.stuntguy2 scripts\engine\sp\utility::anim_stopanimScripted();
        self.stuntguy2 dodamage(self.stuntguy2.health + 100, self.stuntguy2.origin, var3, var7, var5, var6);
        self.guy2 delete();
      } else if(isDefined(self.guy2)) {
        self.guy2 dodamage(self.guy2.health + 100, self.guy2.origin, var3, var7, var5, var6);
        drone_death_cleanup(self.guy2, self);
      }

      break;
    case "guy2_shot":
      if(isDefined(self.stuntguy2)) {
        self.stuntguy2 scripts\engine\sp\utility::anim_stopanimScripted();
        self.stuntguy2 dodamage(self.stuntguy2.health + 100, self.stuntguy2.origin, var3, var7, var5, var6);
        self.guy2 delete();
      } else {
        self.guy2 dodamage(self.guy2.health + 100, self.guy2.origin, var3, var7, var5, var6);
        drone_death_cleanup(self.guy2, self);
      }

      if(isDefined(self.stuntguy1)) {
        if(!self.stuntguy1 scripts\sp\maps\piccadilly\piccadilly_util::is_upright()) {
          self.stuntguy1.a.coverpose_request = "exposed_crouch";
        }

        self.stuntguy1 scripts\engine\sp\utility::anim_stopanimScripted();
        self.guy1 scripts\engine\utility::delaycall(0.2, &delete);
        thread set_cop_free();
      } else if(isDefined(self.guy1)) {
        var8 = spawn_animating_ai_cop();

        if(isalive(var8)) {
          self.guy1 hide();
        } else {
          self.guy1 dodamage(self.guy2.health + 100, self.guy2.origin, var3, var7, var5, var6);
          drone_death_cleanup(self.guy1, self);
        }

        waitframe();

        if(isalive(var8)) {
          self notify("stop_loop_" + var8 getentitynumber());
          var8 stopanimScripted();
          thread set_cop_free();
          self.guy1 delete();
        }
      }

      break;
  }

  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
}

function drone_death_cleanup(var0) {
  self setanimrate(level.scr_anim[self.animname][var0.lastanim][0], 0);
  scripts\asm\shared\utility::setfacialindexfornonai("death");
}

function spawn_animating_ai_cop() {
  var0 = spawn_my_twin(self.guy1, 1);
  var0 endon("death");
  var0 invisiblenotsolid();
  var0.a.coverpose_request = "exposed_crouch";
  var1 = level.scr_anim[self.guy1.animname][self.lastanim][0];
  var2 = self.guy1 getanimtime(var1);
  thread scripts\common\anim::anim_loop_solo(var0, self.lastanim, "stop_loop_" + var0 getentitynumber());
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  waitframe();

  if(isalive(var0)) {
    var0 setanimtime(var1, var2);
    var0 visiblesolid();
    return var0;
  }

  return undefined;
}

function set_cop_free() {
  self endon("death");

  if(isDefined(self.script_force_color)) {
    scripts\engine\sp\utility::disable_ai_color();
  }

  self.ignoreme = 0;
  self.ignoreall = 0;
  self setgoalpos(self.origin);
  thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 400);

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  while(!isDefined(self.enemy)) {
    waitframe();
  }

  self getenemyinfo(self.enemy);
  self.newenemyreactiontime = gettime();
  self.newenemyreaction = 1;
  var0 = undefined;
  self.goalradius = 2048;

  while(!isDefined(var0)) {
    var0 = self findbestcovernode(undefined, 1);
    waitframe();
  }

  self.goalradius = 32;
  scripts\sp\spawner::go_to_node(var0);
}

function spawn_drone_cop() {
  var0 = scripts\engine\utility::random(getspawnerarray("obj_frontline"));
  var1 = var0 spawndrone();
  var1 scripts\sp\utility::enable_procedural_bones();
  var1.spawner = var0;
  var1.origin = self.origin;
  var1.angles = self.angles;
  thread vignette_drone_give_soul();
  var1 thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();

  if(!isai(var1) && !istrue(var1.script_fakeactor) && !isDefined(var1.anim_getrootfunc)) {
    var1.anim_getrootfunc = &scripts\sp\maps\piccadilly\piccadilly::get_anim_model_root;
  }

  thread scripts\sp\friendlyfire::friendly_fire_think(var1);
  return var1;
}

function drag_scene_internal() {
  self endon("update");
  thread vo_drag_scene_idle(1);
  thread scripts\common\anim::anim_loop([self.guy1, self.guy2], self.intro);
  self.lastanim = self.intro;
  level.player scripts\sp\maps\piccadilly\piccadilly_util::waittill_within_fov_from_dist(950, self.origin + (0, 0, 50));

  while(getaiarray().size > 28) {
    waitframe();
  }

  var0 = self.guy1 scripts\engine\utility::getanim(self.intro);

  while(self.guy1 getanimtime(var0[0]) > 0.05) {
    waitframe();
  }

  var1 = spawn_my_twin(self.guy1);
  var1 invisiblenotsolid();
  thread group_vignette_dmg_func(var1, self);
  thread group_vignette_death_func(var1, self);
  var2 = spawn_my_twin(self.guy2);
  var2 invisiblenotsolid();
  thread group_vignette_dmg_func(var2, self);
  thread group_vignette_death_func(var2, self);
  var2 thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();
  var2 thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();
  self.stuntguy1 = var1;
  self.stuntguy2 = var2;
  scripts\engine\utility::array_call([self.guy1, self.guy2], &hide);
  scripts\engine\utility::array_call([self.guy1, self.guy2], &notsolid);
  self notify("stop_loop");
  scripts\engine\sp\utility::delaychildthread(0.5, &position_outro);
  var1 visiblesolid();
  var2 visiblesolid();
  thread vo_drag_scene_carry();
  self.lastanim = self.single;
  scripts\sp\anim::anim_custom_animmode([var1, var2], "gravity", self.single);
  thread scripts\engine\utility::array_delete([var1, var2]);
  thread scripts\engine\utility::array_call(scripts\engine\utility::array_removeundefined([self.guy1, self.guy2]), &show);
  childthread scripts\common\anim::anim_loop(scripts\engine\utility::array_removeundefined([self.guy1, self.guy2]), self.outro);
  self.lastanim = self.outro;
  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
  scripts\engine\utility::array_call([self.guy1, self.guy2], &solid);
}

function vo_drag_scene_idle(var0) {
  self endon("stop_loop");
  self endon("update");
  var1 = 562500;
  var2 = [];

  if(istrue(var0)) {
    GscBinSkip0(0x2e, var2.size, "dx_vom_uk52_sting_rear_wounded_70");
  }

  GscBinSkip0(0x2e, var2.size, "dx_vom_ucf1_sting_rear_wounded_210");
}

function vo_drag_scene_carry() {
  self endon("update");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_uk52_sting_rear_wounded_140");
}

function position_outro() {
  scripts\common\anim::anim_first_frame([self.guy1, self.guy2], self.outro);
  waitframe();
  var0 = getgroundposition(self.guy2.origin, 30);
  var1 = self.guy2.origin[2] - var0[2];
  self.origin -= (0, 0, var1);
  scripts\common\anim::anim_first_frame([self.guy1, self.guy2], self.outro);
}

function group_vignette_dmg_func(var0, var1) {
  waitframe();
  waitframe();
  self.health = 9999;
  var0 endon("update");

  for(;;) {
    self waittill("damage", var2, var3, var4, var4, var5, var4, var4, var4, var4, var6, var4, var4, var4, var7);

    if(!isai(self) && isDefined(var6)) {
      self.damageweapon = var6;
    }

    if(isDefined(var3) && var3 == level.player) {
      level.gotachievement = 0;
      waitframe();
    }

    if(isDefined(var5)) {
      if(isexplosivedamagemod(var5)) {
        var0 notify("update", "all_dead", var2, var3, var4, var4, var5, var4, var4, var4, var4, var6, var4, var4, var4, var7);
        continue;
      }

      if(scripts\engine\utility::isbulletdamage(var5)) {
        var0 notify("update", var1, var2, var3, var4, var4, var5, var4, var4, var4, var4, var6, var4, var4, var4, var7);
      }
    }
  }
}

function group_vignette_death_func(var0, var1) {
  var0 endon("update");
  self waittill("death", var2, var3, var4, var5);

  if(!isai(self) && isDefined(var4)) {
    self.damageweapon = var4;
  }

  if(isDefined(var2) && var2 == level.player) {
    level.gotachievement = 0;
    waitframe();
  }

  if(isDefined(var3)) {
    if(isexplosivedamagemod(var3)) {
      var0 notify("update", "all_dead", undefined, var2, undefined, undefined, var3, undefined, undefined, undefined, undefined, var4, undefined, undefined, undefined, undefined);
      return;
    }

    if(scripts\engine\utility::isbulletdamage(var3)) {
      var0 notify("update", var1, undefined, var2, undefined, undefined, var3, undefined, undefined, undefined, undefined, var4, undefined, undefined, undefined, undefined);
      return;
    }

    return;
  }
}

function vignette_drone_give_soul(var0) {
  self setCanDamage(1);
  thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();

  if(!isDefined(var0)) {
    self makeentitysentient(self.team);
    self setthreatbiasgroup("civilians");
    self.ignoreme = 1;
    self.health = 10;
    self.team = "allies";

    if(isai(self)) {
      scripts\engine\utility::delaythread(0.05, &scripts\engine\sp\utility::set_allowdeath, 1);
    }

    self waittill("death");
    level.injured_actors = scripts\engine\utility::array_remove(level.injured_actors, self);

    if(isDefined(self) && isDefined(self.script_animation)) {
      self setanimrate(level.scr_anim["generic"][self.script_animation][0], 0);
      scripts\asm\shared\utility::setfacialindexfornonai("death");
    }

    if(isDefined(self)) {
      self freeentitysentient();
    }

    if(isDefined(self)) {
      self startragdoll();
    }

    if(isDefined(self)) {
      self notsolid();
      return;
    }

    return;
  }
}

function left_side() {
  thread init_donnas();
  thread left_underground_rescue();
  thread sting_building_rescue();
  thread leftside_carcrash();
  thread northeast_carcrash();
  scripts\engine\sp\utility::array_spawn_function_targetname("left_crash_kill_squad", &scripts\sp\maps\piccadilly\piccadilly_combat::left_crash_kill_squad_terry);
}

function right_side() {
  thread init_wileys();
  thread hostage_sequence_lillywhites();
  thread underground_rescue_right();
}

function ambient_explosion(var0) {
  if(scripts\engine\utility::flag("spec_price_intro_start")) {
    return;
  }

  while(level.suicide_bombers_alive) {
    wait 5;
  }

  var1 = scripts\engine\sp\utility::get_rumble_ent("steady_rumble");
  var1 thread scripts\engine\sp\utility::rumble_ramp_to(5, 2);
  var1 scripts\engine\utility::delaycall(3, &delete);
  var2 = undefined;

  if(var0 == "ripleys_explosion") {
    var3 = (598, -442.5, 118.5);
    var2 = 490000;
  } else {
    var3 = (-469.5, 810.5, 148.5);
    var3 = 1690000;
  }

  thread scripts\engine\utility::exploder(var1);
  thread destroy_building(var1);
  thread building_expl_sfx(var1, var3);

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var3, cos(65))) {
    scripts\engine\utility::delaythread(0.25, &scripts\sp\player::radial_distortion, 0.05, 0.2, 0.15, var3);
  }

  wait 0.1;
  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);

  foreach(var5 in level.injured_actors) {
    if(var5.animname == "guy1" || var5.animname == "guy2") {
      continue;
    }

    if(isDefined(var5) && distance2dsquared(var3, var5.origin) < 160000) {
      var5 delete();
    }
  }

  radiusdamage(scripts\common\utility::groundpos(var3) + (0, 0, 10), 500, 150, 10, undefined, "MOD_EXPLOSIVE");
  wait 0.25;

  if(distance2dsquared(var3, level.player.origin) <= var3 && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var3, cos(65))) {
    level.player shellshock("default_nosound", 2);
    level.player scripts\engine\utility::delaycall(2.5, &fadeoutshellshock);
    level.player setpriorityclienttriggeraudiozonepartial("deathsdoor", "deathsdoor", "reverb");
    level.player scripts\engine\utility::delaycall(2.5, &clearpriorityclienttriggeraudiozone, "deathsdoor");
  }

  level.player playSound("plr_breath_pain_init");
  level.player scripts\engine\utility::delaycall(4, &playsound, "breathing_better");
  level.player viewkick(120, var3, 0);
  earthquake(0.5, 0.8, level.player.origin, 800);

  if(var1 == "ripleys_explosion") {
    var7 = getaiarray();

    foreach(var9 in var7) {
      if(isalive(var9) && var9 istouching(level.goalvolumes["gap_street_front"])) {
        var9 dodamage(40, var9 getEye());
      }
    }

    level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
    wait 1;
    level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk52_bombers_wileys_10", 1, 1);
    level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk51_bombers_wileys_20");
    return;
  }

  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
  wait 1;
  level thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk51_bombers_donna_10", 1, 1);
}

function init_donnas() {
  var0 = ["donna_destroyed"];

  foreach(var2 in var0) {
    var3 = getEnt(var2, "targetname");
    var3.origin -= (0, 0, 1000);
  }
}

function init_wileys() {
  var0 = ["left_brushmodel_destroyed", "right_brushmodel_destroyed", "middle_brushmodel_destroyed"];

  foreach(var2 in var0) {
    var3 = getEnt(var2, "targetname");
    var3.origin -= (0, 0, 1000);
  }
}

function destroy_building(var0) {
  var1 = [];
  var2 = [];

  if(var0 == "ripleys_explosion") {
    var1 = ["middle_brushmodel_pristine", "left_brushmodel_pristine", "right_brushmodel_pristine"];
    var2 = ["left_brushmodel_destroyed", "right_brushmodel_destroyed", "middle_brushmodel_destroyed"];
  } else {
    var1 = ["donna_pristine"];
    var2 = ["donna_destroyed"];
    cinematicingameloop("mp_pic_screens", 1);
  }

  if(var1.size) {
    foreach(var4 in var1) {
      var5 = getEnt(var4, "targetname");
      var5.origin -= (0, 0, 1000);

      if(var5.spawnflags & 1) {
        waitframe();
        self disconnectPaths();
      }
    }
  }

  if(var2.size) {
    foreach(var4 in var2) {
      var5 = getEnt(var4, "targetname");
      var5.origin += (0, 0, 1000);
    }

    return;
  }
}

function building_expl_sfx(var0, var1) {
  var2 = spawn("script_origin", var1);

  if(var0 == "ripleys_explosion") {
    var2 playexplosionsound("bldng_ripleys_expl", "exp");
    var3 = spawn("script_origin", (612, -425, 168));
    var3 playLoopSound("emt_bldng_fire_lp_01");
  } else if(var0 == "bank_explosion") {
    var2 playexplosionsound("bldng_bank_expl", "exp");
    var4 = spawn("script_origin", (-508, 848, 196));
    var5 = spawn("script_origin", (-584, 955, 200));
    var4 playLoopSound("emt_bldng_fire_lp_03");
    var5 playLoopSound("emt_bldng_fire_lp_01");
  }

  wait 10;
  var2 delete();
}

function ambient_combat_popo() {
  level endon("inside_gap_flag");
  var0 = scripts\common\utility::getvehiclespawner("ambient_popo", "targetname");
  var0 scripts\engine\sp\utility::add_spawn_function(&ambient_popo_spawn_func);

  for(;;) {
    var1 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("ambient_popo");
    wait 1;
    var1 vehicle_setspeedimmediate(var1 vehicle_getspeed() + randomint(15), 10);
    var1 waittill("reached_end_node");
    wait randomfloatrange(4, 6);
  }
}

function ambient_popo_spawn_func() {
  self playLoopSound("siren_police");
  self vehicle_setspeedimmediate(45, 40, 5);
  self waittill("reached_end_node");
  self delete();
}

function left_underground_rescue() {
  level endon("spec_price_intro_start");
  var0 = scripts\engine\utility::getStruct("underground_left_animnode", "targetname");
  GscBinSkip4(0x6e, var0);
}

#using_animtree("generic_human");

function left_underground_civ_dmg_func() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var2, var3, var2, var2, var2, var2, var4, var2, var2, var2, var5);

    if(istrue(self.shot)) {
      return;
    }

    if(scripts\engine\utility::is_equal(var1, level.player)) {
      level.gotachievement = 0;

      if(!scripts\sp\maps\piccadilly\piccadilly_util::mydeathaccidental()) {
        thread scripts\sp\maps\piccadilly\piccadilly_util::civdeathinstafail();
        return;
      }

      if(isDefined(self.magic_bullet_shield)) {
        scripts\common\ai::stop_magic_bullet_shield();
      }

      scripts\engine\sp\utility::anim_stopanimScripted();
      self.deathanim = % sdr_com_exposed_crouch_death01_midbody_md_4;
      self.allowdeath = 1;
      scripts\engine\sp\utility::die();
    }
  }
}

function vo_enemy_underground_left() {
  var0 = scripts\engine\utility::spawn_script_origin(self.origin + (55, 55, 60));
  vo_enemy_underground_left_internal(var0);
  var0 stopsounds();
  waitframe();
  var0 delete();
}

function vo_enemy_underground_left_internal() {
  level endon("right_side_cleanup");
  scripts\engine\utility::flag_wait("tflag_left_underground");
  thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_aq1_combat_tube_60");
  scripts\engine\utility::flag_wait("left_side_under_engaged");
}

function vo_hostage_sequence_underground_left(var0, var1) {
  wait 0.3;
  var1[0] thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_ucm1_combat_tube_80", 1);
  wait 1.4;
  var1[1] thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_ucm2_combat_tube_90", 1);
  wait 0.2;
  scripts\engine\sp\utility::waittill_dead_or_dying(var0, var0.size);
  wait 1.5;
  var2 = 0;
  var3 = scripts\engine\sp\utility::create_deck(["dx_vom_ucm1_combat_tube_110", "dx_vom_ucm2_combat_tube_120"]);
  var4 = scripts\engine\sp\utility::create_deck(["dx_vom_ucf1_combat_tube_130"]);

  foreach(var6 in var1) {
    if(isalive(var6)) {
      var7 = var6 scripts\sp\maps\piccadilly\piccadilly_util::get_gender();

      if(var7 == "male") {
        if(var3 scripts\engine\sp\utility::deck_is_empty()) {
          continue;
        }

        var6 thread scripts\sp\maps\piccadilly\piccadilly_util::say(var3 scripts\engine\sp\utility::deck_draw(), 1);
      } else {
        if(var4 scripts\engine\sp\utility::deck_is_empty()) {
          continue;
        }

        var6 thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter(var4 scripts\engine\sp\utility::deck_draw(), 1);
      }

      if(!var2) {
        level.player thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_140", 1, 2);
      }

      var2 = 1;
      wait randomfloatrange(0.1, 0.35);
    }
  }

  var9 = (-1947.35, -1346.81, -59);

  if(!var2 && level.player scripts\engine\trace::can_see_origin(var9, 0)) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_150");
  }

  var10 = scripts\engine\sp\utility::get_living_ai("left_underground_hero_cop", "script_noteworthy");

  if(!isDefined(var10)) {
    return;
  }

  wait 2;
  var10.animname = "left_underground_police_rescue";

  if(var2) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_170", 1);

    if(!isDefined(var10)) {
      return;
    }

    var10 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk55_combat_tube_190", 1);
    return;
  }

  level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_180", 1);

  if(!isDefined(var10)) {
    return;
  }

  var10 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk55_combat_tube_200", 1);
}

function print3donme(var0) {
  self endon("death");
  self notify("stop_print3d");
  self endon("stop_print3d");

  for(;;) {
    waitframe();
  }
}

function left_underground_bad_guy_death_reacts(var0, var1, var2) {
  var0 endon("stop breakout");
  thread proximity_check(var0);
  scripts\engine\utility::waittill_any_ents(self, "death", var0, "update");
  scripts\engine\utility::flag_set("left_side_under_engaged");
  var3 = "left_underground_execution_react_r";
  var4 = level.player.origin[1] > -1270;

  if(var4) {
    var3 = "left_underground_execution_react_l";
  }

  var5 = undefined;

  if(self == var1[0] && isalive(var1[1])) {
    var5 = var1[1];
  }

  if(self == var1[1] && isalive(var1[0])) {
    var5 = var1[0];
  }

  if(isDefined(var5)) {
    var5 scripts\engine\sp\utility::anim_stopanimScripted();
    var0 thread scripts\common\anim::anim_single_solo(var5, var3);
  }

  var2 = scripts\engine\utility::array_removedead(var2);
  var0 notify("stop breakout");
}

function left_underground_hero_cop() {
  scripts\engine\utility::array_delete(getEntArray("left_underground_hero_trig", "script_noteworthy"));
  self endon("death");
  self.dontevershoot = 1;
  level.player scripts\engine\utility::waittill_notify_or_timeout("weapon_fired", 2.5);
  self.dontevershoot = 0;
  thread delete_after_time(7);
}

function delete_after_time(var0) {
  self endon("death");
  wait var0;
  level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 600);
}

function reset_after_anim(var0, var1) {
  self endon("death");
  var0 waittill(var1);
  self.health = self.og_health;
  self.deathanim = self.og_deathanim;
}

function remove_civ_left_subway(var0, var1) {
  self endon("death");
  var0 waittill(var1);

  if(istrue(self.shot)) {
    return;
  }

  scripts\common\ai::stop_magic_bullet_shield();
  scripts\engine\sp\utility::anim_stopanimScripted();
  var0 scripts\common\anim::anim_single_solo(self, "left_underground_execution_getup");
  var0 thread scripts\common\anim::anim_loop_solo(self, "left_underground_execution_getup_idle", "stop_loop_" + self getentitynumber());
  var2 = cos(65);

  for(;;) {
    wait 2;

    if(distancesquared(self.origin, level.player.origin) <= 122500 && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self getEye(), var2) && level.player adsButtonPressed()) {
      var0 notify("stop_loop_" + self getentitynumber());
      var0 scripts\common\anim::anim_single_solo(self, "left_underground_execution_react_ads");
      var0 thread scripts\common\anim::anim_loop_solo(self, "left_underground_execution_getup_idle", "stop_loop_" + self getentitynumber());
    }
  }
}

function create_hostage_interact() {
  scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 48), "Untie", undefined, undefined, 110);
}

#using_animtree("");

function hostage_sequence_lillywhites() {
  var0 = scripts\engine\utility::getStruct("lillywhites_upper_escalator_animnode", "targetname");
  var0.struggle_started = 0;
  var0.struggle_decided = 0;
  var0.no_player = 0;
  var1 = getspawnerarray("lillywhites_execution_c");
  var2 = [];
  var3 = [];
  var4 = [];
  level.lillywhites_civs = [];

  for(var5 = 0; var5 < var1.size; var5++) {
    var6 = scripts\engine\utility::ter_op(var1[var5].script_animname == "lw_civ3", "female", "male");
    var7 = var1[var5] scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ(var6, 1);
    var7.animname = var1[var5].script_animname;
    var7.team = "allies";
    var7 scripts\engine\utility::ent_flag_init("free");
    var2 = scripts\engine\utility::array_add(var2, var7);
    var3 = scripts\engine\utility::array_add(var3, var7);

    if(var7.animname == "lw_civ1") {
      var7.allowdeath = 1;
      var4 = scripts\engine\utility::array_add(var4, var7);
    }

    level.lillywhites_civs[var7.animname] = var7;
    thread lilly_actor_dmg_func(var7, var0, "civ_dmg");
  }

  var8 = scripts\engine\sp\utility::spawn_targetname("lillywhites_execution_t", 1);
  var8.animname = "lw_t1";
  var8.og_health = var8.health;
  var8.allowdeath = 1;
  var8.ignoreme = 1;
  var8.ignoreall = 1;
  var8.disablelongdeath = 1;
  thread lilly_actor_dmg_func(var8, var0);
  var8 scripts\sp\utility::context_melee_allow(0);
  level.lilly_terry = var8;
  var2 = scripts\engine\utility::array_add(var2, var8);
  var4 = scripts\engine\utility::array_add(var4, var8);
  var0.guys = var2;
  var0.good_guys = var3;
  var0.end_guys = var4;
  var0.terry = var8;
  var0 thread scripts\common\anim::anim_loop(var2, "lilly_whites_execution_idle");
  thread lillywhites_internal(level);
  var0 waittill("update", var9, var10);
  var0.outcome = 1;

  switch (var9) {
    case "civ_dmg":
      if(scripts\engine\utility::is_equal(var10.lastattacker, level.player)) {
        var10 scripts\engine\sp\utility::anim_stopanimScripted();
        var10 setanim(%sdr_com_exposed_crouch_death01_midbody_md_4, 1);
      }

      break;
    case "terry_dmg":
      scripts\engine\sp\utility::array_notify(var2, "stop_polling_damage");
      var11 = var8.lastattacker;
      var12 = var8.damagemod;
      var13 = level.player getcurrentweapon();

      while(istrue(var8.noreact)) {
        waitframe();
      }

      var8 thread scripts\anim\shared::dropallaiweapons();

      if(istrue(var0.struggle_started)) {
        var14 = var8.origin + anglestoright(var8.angles) * 100;
        var15 = vectorNormalize(var14 - var8.origin);
        var8 startragdollfromimpact("torso_upper", var15 * 2000);
        wait 0.5;
        var8 scripts\sp\utility::do_damage(var8.health + 100, var8.origin, var11, var11, var12, var13);
      } else {
        var8 scripts\sp\utility::do_damage(var8.health + 100, var8.origin, var11, var11, var12, var13);
      }

      free_lilly_civs(var0);
      break;
    case "terry_proximity":
      scripts\engine\sp\utility::array_notify(var2, "stop_polling_damage");
      var8 scripts\engine\sp\utility::anim_stopanimScripted();
      var8.health = var8.og_health;
      var8.ignoreme = 0;
      var8.ignoreall = 0;
      wait 1;
      thread free_lilly_civs(var0);
      break;
    case "all_dead":
      var2 = scripts\engine\utility::array_removedead(var2);
      var16 = 0;

      foreach(var7 in var2) {
        if(var7.team != "axis" && scripts\engine\utility::is_equal(var7.lastattacker, level.player)) {
          var16 = 1;
        }

        var7 scripts\engine\sp\utility::anim_stopanimScripted();
        var7 setanim(%sdr_com_exposed_crouch_death01_midbody_md_4, 1);
        var7 scripts\engine\sp\utility::die();
      }

      if(var16) {
        thread scripts\sp\friendlyfire::missionfail(1);
      }

      break;
    case "delete":
      scripts\engine\utility::array_delete(var2);
      return;
    default:
      var8.ignoreme = 0;
      var8.ignoreall = 0;
      break;
  }

  scripts\engine\sp\utility::autosave_by_name("blah");
  level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(scripts\engine\utility::array_removedead(level.lillywhites_civs), 600);
  level scripts\engine\utility::delaythread(2, &spawn_lillywhite_rescue_police, var0);
}

function free_lilly_civs(var0) {
  level.lillywhites_civs = scripts\engine\utility::array_removeundefined(level.lillywhites_civs);
  var0 notify("stop_loop");

  foreach(var2 in level.lillywhites_civs) {
    if(isDefined(var2.executed)) {
      continue;
    }

    thread lilly_civ_reaction(var2);
  }
}

function lilly_civ_reaction(var0) {
  self endon("death");
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(istrue(var0.struggle_started) && self.animname == "lw_civ1") {
    var1 = "lilly_whites_execution_enemy_death";
    var2 = "lilly_whites_execution_enemy_death_idle";
    var3 = "lilly_whites_execution_enemy_death_cower";
  } else {
    var1 = "lilly_whites_free";
    var2 = "lilly_whites_free_idle";
    var3 = "lilly_whites_free_cower";
  }

  thread vo_lilly_civ_react();
  var3 scripts\common\anim::anim_single_solo(self, var1);
  var3 thread scripts\common\anim::anim_loop_solo(self, var2, "stop_loop_" + self getentitynumber());

  if(self.animname == "lw_civ1" || self.animname == "lw_civ2") {
    thread civ_dmg_trig();
  }

  var4 = cos(65);

  for(;;) {
    wait 1;

    if(distancesquared(self.origin, level.player.origin) <= 122500 && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self getEye(), var4) && level.player adsButtonPressed()) {
      var3 notify("stop_loop_" + self getentitynumber());
      var3 scripts\common\anim::anim_single_solo(self, var3);
      var3 thread scripts\common\anim::anim_loop_solo(self, var2, "stop_loop_" + self getentitynumber());
    }
  }
}

function vo_lilly_civ_react() {
  self endon("death");

  if(self.animname == "lw_civ1") {
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm2_combat_tube_133");
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm2_combat_tube_136");
  } else if(self.animname == "lw_civ2") {
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm1_combat_tube_131");
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm1_combat_tube_134");
  } else {
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvf1_combat_tube_132");
    scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvf1_combat_tube_135");
  }

  thread vo_injured_loop();
}

function civ_dmg_trig() {
  self notsolid();

  if(self.animname == "lw_civ1") {
    var0 = "civ03_rescue_dmg";
  } else {
    var0 = "civ01_rescue_dmg";
  }

  var1 = getEnt(var0, "targetname");

  for(;;) {
    var1 waittill("damage", var2, var3, var4, var4, var5, var4, var4, var4, var4, var6, var4, var4, var4, var7);

    if(scripts\engine\utility::is_equal(var3, level.player)) {
      thread scripts\sp\friendlyfire::missionfail(1);
      return;
    }
  }
}

function lilly_actor_dmg_func(var0, var1, var2) {
  self endon("death");

  if(!isai(self)) {
    self setCanDamage(1);
    self makeentitysentient("allies");
  }

  if(istrue(var2)) {
    self.ignoreall = 1;
    self.ignoreme = 1;
  }

  self.health = 9999;

  for(;;) {
    self waittill("damage", var3, var4, var5, var5, var6, var5, var5, var5, var5, var7, var5, var5, var5, var8);

    if(!isai(self) && isDefined(var4)) {
      self.lastattacker = var4;
    }

    if(scripts\engine\utility::is_equal(var4, var0.terry)) {
      continue;
    }

    if(isDefined(var6)) {
      if(isexplosivedamagemod(var6)) {
        var0 notify("update", "all_dead", self);
        return;
      }

      if(scripts\engine\utility::isbulletdamage(var6)) {
        if(!istrue(var0.outcome) && scripts\engine\utility::is_equal(var4, level.player) && self.team == "axis") {
          var0 notify("update", var1, self);
        }

        if(scripts\engine\utility::is_equal(var4, level.player) && self.team != "axis") {
          if(!scripts\sp\maps\piccadilly\piccadilly_util::mydeathaccidental()) {
            thread scripts\sp\maps\piccadilly\piccadilly_util::civdeathinstafail();
            return;
          }

          level.gotachievement = 0;
          scripts\sp\maps\piccadilly\piccadilly_util::print_no_achievement();
        }
      }
    }
  }
}

function lillywhites_internal(var0) {
  var1 = do_lilly_execition(var0);

  if(istrue(var1)) {
    do_lilly_struggle(var0);
    return;
  }
}

function do_lilly_execition(var0) {
  var0 endon("update");
  var1 = scripts\engine\utility::flag_wait_any_return("lillywhites_rescue_start_escalator", "spec_price_intro_start");

  if(var1 != "lillywhites_rescue_start_escalator") {
    var0 notify("update", "delete");
    return;
  }

  thread vo_lilly_execution(var0);
  GscBinSkip4(0x6e, var0.terry, var0);
}

function vo_lilly_execution(var0) {
  thread vo_lillywhites_cleared(var0);
  var0 endon("update");
  var0.terry scripts\engine\utility::call_on_notify("damage", &stopsounds);
  var1 = level.lillywhites_civs["lw_civ1"];
  var2 = level.lillywhites_civs["lw_civ2"];
  var3 = level.lillywhites_civs["lw_civ3"];
  wait 0.3;
  var3 thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvf1_shops_execution_20");
  wait 0.5;
  var0.terry thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_aq3_shops_execution_10");
  var3 waittill("shot");
  var3 stopsounds();
  wait 0.2;
  var2 thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm1_shops_execution_30");
  wait 1.7;
  var0.terry thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_aq3_shops_execution_60");
  wait 7;
  var0.terry stopsounds();
}

function vo_lillywhites_cleared(var0) {
  var0.terry waittill("death", var1);

  if(!isDefined(var1)) {
    return;
  }

  wait 1.35;

  if(var0.no_player) {
    scripts\engine\utility::flag_wait("lillywhites_rescue_start_escalator");
  }

  var2 = 0;

  foreach(var4 in level.lillywhites_civs) {
    if(isalive(var4)) {
      var2++;
    }
  }

  if(var2 > 0) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_kyle_shops_execution_100");
    wait 0.25;
  }

  switch (var2) {
    case 3:
      level.player thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_shops_execution_110");
      break;
    case 2:
      level.player thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_shops_execution_120");
      break;
    case 1:
    case 0:
      level.player thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_shops_execution_10");
      break;
    default:
      break;
  }

  level scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_gfc_shops_execution_20");
}

function terry_noreact_window(var0) {
  self endon("death");
  wait 3.36;
  self.noreact = 1;
  var0.terry.skipdeathanim = 1;
  wait 1.7;
  var0.struggle_started = 1;
  self.noreact = undefined;
}

function vo_final_struggle() {
  self endon("end_struggle");
  wait 1.5;
  level.lillywhites_civs[0] thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm2_shops_execution_80", 1);
  wait 2.5;
  level.lillywhites_civs[0] stopsounds();
}

function do_lilly_struggle(var0) {
  var0 endon("update");
  level notify("lillywhite struggle");

  if(var0.no_player) {
    thread spawn_lillywhite_rescue_police(var0);
  }

  var0 thread scripts\common\anim::anim_loop(var0.end_guys, "lilly_whites_execution_struggle", "end_struggle");
  thread lilly_white_time_out();
  thread lilly_white_kill(var0);
  thread vo_final_struggle();
  var1 = scripts\engine\utility::flag_wait_any_return("lilly_white_execution_time_out", "lilly_white_execution_save");
  var0.struggle_decided = 1;
  var0 notify("end_struggle");

  if(var1 == "lilly_white_execution_save") {
    level.lillywhites_civs[0] thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm2_shops_execution_90");
    var0.end_guys = scripts\engine\utility::array_remove(var0.end_guys, var0.terry);
    var0.terry thread scripts\sp\maps\piccadilly\piccadilly_gap::die_after_anim();
    var0 thread scripts\common\anim::anim_single(var0.end_guys, "lilly_whites_execution_enemy_death");
    return;
  }

  if(var1 == "lilly_white_execution_time_out") {
    var0.terry thread scripts\anim\notetracks::notetrackfire();
    thread scripts\sp\maps\piccadilly\piccadilly_anim::squib_chest(var0.end_guys[0]);
    var0.end_guys[0] scripts\engine\utility::delaycall(0.1, &startragdoll);
    var0 scripts\common\anim::anim_single(var0.end_guys, "lilly_whites_execution_civ_death");
    var2 = scripts\engine\utility::array_remove(var0.end_guys, var0.terry);

    if(isalive(var0.end_guys[0])) {
      if(isDefined(var0.end_guys[0].magic_bullet_shield)) {
        var0.end_guys[0] scripts\common\ai::stop_magic_bullet_shield();
      }

      var0.end_guys[0].script_pushable = 0;
      var0.end_guys[0] setCanDamage(0);
      var0.end_guys[0] freeentitysentient();
      var0.end_guys[0] notsolid();
      level.lillywhites_civs = scripts\engine\utility::array_remove(level.lillywhites_civs, var0.end_guys[0]);
    }

    var0.terry.health = var0.terry.og_health;
    var0.terry.skipdeathanim = undefined;
    var0.terry getenemyinfo(level.player);
    var0.terry.goalradius = 2048;
    var0 notify("update", "scene_complete");
    return;
  }
}

function proximity_check(var0) {
  self endon("death");
  var1 = squared(120);

  for(;;) {
    if(istrue(self.noreact)) {
      return;
    }

    if(distancesquared(self.origin, level.player.origin) <= var1) {
      var0 notify("update", "terry_proximity");
    }

    waitframe();
  }
}

function spawn_lillywhite_rescue_police(var0) {
  var1 = scripts\engine\sp\utility::spawn_targetname("lilly_rescue_police", 1);

  if(!scripts\common\ai::spawn_failed(var1)) {
    var1 scripts\engine\utility::set_movement_speed(190);
    var1.attackeraccuracy = 0;
    var1 scripts\engine\utility::delaythread(5, &scripts\engine\sp\utility::set_attackeraccuracy, 1);
    return;
  }
}

function lilly_white_time_out() {
  if(level.gameskill < 2) {
    wait 4;
  } else {
    wait 2;
  }

  scripts\engine\utility::flag_set("lilly_white_execution_time_out");
}

function lilly_white_kill(var0) {
  var0 waittill("damage");
  scripts\engine\utility::flag_set("lilly_white_execution_save");
}

function get_scriptable_door_anim(var0, var1) {
  var2 = undefined;

  switch (var1) {
    case "victor40":
      if(var0.animname == "male_lf") {
        var2 = % vehicle_victor40_car_getout_lf_side;
      } else {
        var2 = $vehicle_victor40_car_getout_rf_side;
      }

      break;
    case "skilo":
      if(var0.animname == "male_lf") {
        var2 = % vehicle_skilo_car_getout_lf_side;
      } else {
        var2 = % vehicle_skilo_car_getout_rf_side;
      }

      break;
    case "calfa":
      if(var0.animname == "male_lf") {
        var2 = % vehicle_calfa_car_getout_lf_side;
      } else {
        var2 = % vehicle_calfa_car_getout_rf_side;
      }

      break;
    case "ralfa":
      if(var0.animname == "male_lf") {
        var2 = % vehicle_ralfa_car_getout_lf_side;
      } else {
        var2 = % vehicle_ralfa_car_getout_rf_side;
      }

      break;
    default:
      var2 = undefined;
      break;
  }

  return var2;
}

function scriptable_anim(var0) {
  self useanimtree(#animtree);
  self setflaggedanimknoball("single anim", var0, %root, 1, 0);
}

function sting_building_rescue() {
  var0 = scripts\engine\utility::getStruct("sting_building_animnode", "targetname");
  scripts\engine\utility::flag_wait("stop_storefront_drones");
  var1 = getspawnerarray("sting_civs");
  var2 = getspawner("sting_po", "targetname");
  var3 = [];

  for(var4 = 0; var4 < var1.size; var4++) {
    if(var4 == 3 || var4 == 5 || var4 == 7) {
      continue;
    }

    if(var4 == 2) {
      var5 = var1[var4] scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("male", 1);
    } else {
      var5 = var1[var4] scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1);
    }

    var5.animname = "sting_rescue_civ" + var4 + 1;
    var3 = scripts\engine\utility::array_add(var3, var5);
    var5.ignoreme = 1;
  }

  var5 = var2 stalingradspawn();
  var5.animname = "sting_rescue_p";
  var5.ignoreme = 1;
  var3 = scripts\engine\utility::array_add(var3, var5);
  scripts\engine\utility::array_thread(var3, &sting_actor_logic, var0);
  var6 = getEnt("reading_rescue_door", "targetname");
  var7 = scripts\engine\utility::flag_wait_any_return("sting_building_rescue_start", "reading_place_front", "player_in_center", "gap_approach");

  if(var7 != "sting_building_rescue_start") {
    scripts\engine\utility::array_delete(var3);
    return;
  }

  thread vo_bookstore_walla();
  var6 scripts\engine\utility::delaycall(3.2, &rotateyaw, 90, 0.25, 0.15, 0.05);
  var6 scripts\engine\utility::delaythread(3.2, &audio_door_open);
  var6 scripts\engine\utility::delaycall(10.2, &rotateyaw, -90, 0.6, 0.55, 0.05);
  var6 scripts\engine\utility::delaythread(10.6, &audio_door_close);
  scripts\engine\sp\utility::autosave_by_name("sting_rescue");
  var5 waittillmatch("single anim", "end");
  wait 1;
  scripts\engine\utility::array_delete(var3);
}

function vo_bookstore_walla() {
  var0 = spawn("script_origin", (-2378, -390, 172));
  var0 playSound("scn_piccadilly_bookstore_walla");
  var0 moveTo((-2393, -583, 172), 2.5);
  wait 2.5;
  var0 moveTo((-2625, -614, 172), 2.5);
  wait 12;
  var0 delete();
}

function audio_door_open() {
  var0 = self.origin + (0, 0, 40);
  thread scripts\engine\utility::play_sound_in_space("scrpt_door_wood_clean_bash", var0);
}

function audio_door_close() {
  var0 = self.origin + (0, 0, 40);
  thread scripts\engine\utility::play_sound_in_space("door_hit_wall", var0);
}

function sting_actor_logic(var0) {
  self endon("death");

  if(!isai(self)) {
    thread vignette_drone_give_soul();
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, "sting_rescue_idle", "stop_sting_idle");
  scripts\engine\utility::flag_wait("sting_building_rescue_start");
  var0 notify("stop_sting_idle");
  level.scr_goaltime[self.animname]["sting_rescue"] = 1.5;
  var0 scripts\common\anim::anim_single_solo(self, "sting_rescue");
  var0 thread scripts\common\anim::anim_loop_solo(self, "sting_rescue_end", "stop_sting_idle");
}

function scriptable_car_getouts() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("civ_getout", "targetname");
  scripts\engine\utility::array_thread(var0, &car_getout);
}

function car_getout() {
  self.script_noteworthy = "ignore";
  var0 = strtok(self.classname, "_")[4];
  var1 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("male", 1, 1);
  var1.animname = "male_lf";
  thread scripts\common\anim::anim_loop_solo(var1, var0 + "_scared_idle");
  var1 linkTo(self, "tag_origin");
  waittill_player_close_or_death();
  var2 = self getscriptablepartstate("body", 1);
  var3 = scripts\engine\utility::is_equal(var2, "dead");

  if(!var3) {
    if(scripts\engine\math::is_point_in_front(level.player.origin)) {
      var4 = var0 + "_exit_fwd";
    } else {
      var4 = var1 + "_exit_back";
    }

    while(getaiarray().size > 25) {
      waitframe();
    }

    var5 = get_scriptable_door_anim(var2, var1);
    var6 = spawn_my_twin(var2);
    self notify("stop_loop");
    var2 delete();
    thread scriptable_anim(var5);
    var6 scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::play_sound_on_entity, "generic_death_falling_scream");
    var6.deathfunction = &car_runner_deathfunc;
    scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::set_allowdeath, 1);
    scripts\common\anim::anim_single_solo(var6, var4);
    self clearanim(var5, 0);
    self.script_noteworthy = "";

    if(isalive(var6)) {
      if(can_fake_snipe()) {
        thread snipe_me(var6);
      }
    }

    if(isalive(var6)) {
      var6 thread scripts\sp\maps\piccadilly\piccadilly_civs::civ_think_run();
      return;
    }

    return;
  }

  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var2, "victor40_death");
}

function car_runner_deathfunc() {
  if(self isinscriptedstate()) {
    scripts\engine\sp\utility::anim_stopanimScripted();
  }

  return false;
}

function can_fake_snipe() {
  if(scripts\engine\utility::flag("snipers_engaged")) {
    return false;
  }

  if(scripts\engine\utility::flag("scripted_sniper")) {
    return false;
  }

  if(scripts\engine\utility::flag("snipers_dead")) {
    return false;
  }

  if(scripts\engine\utility::flag("gap_approach")) {
    return false;
  }

  return randomint(100) < 66;
}

function snipe_me(var0) {
  self endon("death");
  scripts\engine\utility::flag_set("scripted_sniper");
  var1 = scripts\engine\utility::getStructArray("window_snipe", "targetname");
  var1 = sortbydistance(var1, self.origin);
  var2 = undefined;

  foreach(var4 in var1) {
    if(scripts\engine\trace::ray_trace_passed(var4.origin, self getEye(), self)) {
      var2 = var4;
      break;
    }
  }

  if(!isDefined(var2)) {
    scripts\engine\utility::flag_clear("scripted_sniper");
    return false;
  }

  if(istrue(var0)) {
    snipe_laser(var2, self);
  }

  var6 = getcompleteweaponname("iw8_sn_delta");
  self.health = 10;
  magicbullet(var6, var2.origin, self getEye());
  scripts\engine\utility::flag_clear("scripted_sniper");
  return true;
}

function snipe_laser(var0) {
  var0 endon("death");

  while(level.player.origin[2] - self.origin[2] > abs(100)) {
    waitframe();
  }

  var1 = gettime() + 700 + randomintrange(300, 550);
  var2 = spawn("script_model", self.origin);
  var2 setModel("tag_laser");
  var2.angles = self.angles;
  var2 setmoverlaserweapon(scripts\sp\maps\piccadilly\piccadilly_combat::make_picc_sniper_weapon());
  var2 laserforceon();
  var0 thread scripts\engine\utility::delete_on_death(var2);

  while(gettime() < var1) {
    var3 = var2.origin;
    var4 = var0 getEye();
    var5 = vectorNormalize(var4 - var3);
    var6 = var2.angles;
    var5 = vectorNormalize((var5[0], var5[1], 0));
    var6 = vectorNormalize((var6[0], var6[1], 0));
    var2.angles = vectortoangles(var4 - self.origin);
    waitframe();
  }
}

function waittill_player_close_or_death() {
  self endon("rocked");
  level.player scripts\sp\maps\piccadilly\piccadilly_util::waittill_within_fov_from_dist(580, self.origin + (0, 0, 70));
  return "player_sees";
}

function leftside_carcrash() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getEnt("left_crash_ralfa_doors_open", "targetname");
  var0 notsolid();
  var1 = getnodearray("leftside_crash_nodes", "targetname");

  foreach(var3 in var1) {
    var3 disconnectnode();
  }

  var5 = scripts\engine\utility::getStruct("sting_crashnode", "targetname");
  var5.angles = (0, 0, 0);
  var6 = getscriptablearray("left_crash_car3", "targetname")[0];
  var6.animname = "left_crash_car3";
  var6 scripts\engine\sp\utility::assign_animtree();
  var6.scriptcoll = get_script_car_collision("left_crash_car3");
  var6.scriptcoll linkTo(var6, "tag_origin", (0, 0, 0), (0, 0, 0));
  var6.scriptcoll.trigger scripts\engine\utility::trigger_off();
  var7 = getstartorigin(var5.origin, var5.angles, var6 scripts\engine\utility::getanim("left_car_crash"));
  var8 = getstartangles(var5.origin, var5.angles, var6 scripts\engine\utility::getanim("left_car_crash"));
  var6.origin = var7;
  var6.angles = var8;
  waitframe();
  var6.scriptcoll.collision disconnectPaths();
  scripts\engine\utility::flag_wait("left_car_crash_go");
  thread delete_lotus_decho();
  scripts\engine\sp\utility::flagwaitthread("left_crash_kill_squad_looking", &left_crash_kill_squad);
  getEnt("left_crash_kill_squad_trig", "targetname") scripts\engine\sp\utility::add_trigger_function(&left_crash_kill_squad_civs);
  var9 = [];
  GscBinSkip0(0x2e, var9.size, var6);
}

function ralfa_delete_door_collision(var0) {
  self waittill("rocked");
  var0 delete();
}

function delete_lotus_decho() {
  var0 = scripts\common\utility::getvehiclespawner("middle_lotus_enemies", "targetname");

  foreach(var2 in getspawnerarray(var0.target)) {
    if(isspawner(var2)) {
      var2 delete();
    }
  }

  var0 delete();
}

function left_side_cop_driver() {
  if(isai(self)) {
    scripts\common\ai::gun_remove();
  }

  var0 = anglestoright(self.driver.angles) * -1;
  var1 = self.driver.origin + var0 * 200;
  var2 = vectorNormalize(var1 - self.driver.origin);
  self.driver notify("stop_driving");
  self.driver unlink();
  self.driver scripts\engine\sp\utility::anim_stopanimScripted();
  self.driver startragdollfromimpact("torso_upper", var2 * 4500);
}

function left_crash_kill_squad() {
  var0 = getEnt("left_crash_kill_squad_trig", "targetname");

  if(isDefined(var0) && !istrue(var0.trigger_off)) {
    var0 scripts\engine\sp\utility::activate_trigger();
    return;
  }
}

function left_crash_kill_squad_civs(var0) {
  if(scripts\engine\utility::flag("left_crash_far_civs")) {
    thread scripts\sp\maps\piccadilly\piccadilly_civs::start_civ_struct_spawner("left_car_accident_civs_far", 8);
    return;
  }

  thread scripts\sp\maps\piccadilly\piccadilly_civs::start_civ_struct_spawner("left_car_accident_civs", 8);
}

function vo_left_crash_react() {
  wait 3.5;

  if(level.player scripts\engine\trace::can_see_origin(self.origin + (0, 0, 60), 0)) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_kyle_sting_rear_exit_60");
    return;
  }
}

function left_side_crash_terries(var0, var1) {
  var2 = scripts\engine\sp\utility::array_spawn_targetname("left_car_accident_terry");

  foreach(var4 in var2) {
    if(var5 == 0) {
      var4.animname = "ralfa_left";
    } else {
      var4.animname = "ralfa_right";
    }

    var4.ignoreme = 1;
    var4 thread scripts\common\ai::magic_bullet_shield(1);
    var0 scripts\common\anim::anim_first_frame_solo(var4, "left_crash_exit");
    var4 linkTo(var0, "tag_origin");
    var4 scripts\engine\utility::delaythread(var1 - 0.6, &left_side_terry_dmg);
  }

  var0 scripts\engine\utility::delaythread(var1 - 0.6, &scripts\common\anim::anim_single, var2, "left_crash_exit");
  scripts\engine\utility::array_thread(var2, &left_side_crash_terry_logic);
}

function left_side_crash_terry_logic() {
  self waittillmatch("single anim", "end");
  self notify("stop_dmg_polling");
  self unlink();
  self.ignoreme = 0;
  scripts\common\ai::stop_magic_bullet_shield();

  if(isDefined(self.animname)) {
    var0 = getnode(self.animname, "script_noteworthy");

    if(var0 scripts\engine\math::is_point_in_front(level.player.origin)) {
      self.goalradius = 32;
      thread scripts\sp\spawner::go_to_node(var0);
    }
  } else {
    self.goalradius = 2048;
  }

  thread scripts\sp\maps\piccadilly\piccadilly_combat::close_in_on_far_player();
}

function left_side_terry_dmg() {
  self endon("stop_dmg_polling");
  self waittill("damage", var0, var1, var2, var2, var3, var2, var2, var2, var2, var4, var2, var2, var2, var5);
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.forceragdollimmediate = 1;
  scripts\engine\sp\utility::set_allowdeath(1);
  self dodamage(self.health + 1000, self.origin, var1, var5, var3, var4);
}

function northeast_carcrash() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getnodearray("right_car_crash1", "targetname");
  var1 = getEnt("right_crash_placed_clip", "targetname");
  var1 connectpaths();
  var1 notsolid();

  foreach(var3 in var0) {
    var3 disconnectnode();
  }

  var5 = scripts\engine\utility::getStruct("northeast_street_animnode", "targetname");
  var6 = getscriptablearray("right_car4", "targetname")[0];
  var6.animname = "right_car4";
  var6 scripts\engine\sp\utility::assign_animtree();
  var6.scriptcoll = get_script_car_collision("right_car4");
  var6.scriptcoll linkTo(var6, "tag_origin", (0, 0, 0), (0, 0, 0));
  var6.scriptcoll.trigger triggerdisable();
  var6.shell = scripts\engine\sp\utility::spawn_anim_model("right_car4_shell", var6.origin, var6.angles);
  var6.shell linkTo(var6, "tag_body_animate", (0, 0, 0), (0, 0, 0));
  thread delete_shell();
  thread swap_shell();
  var7 = getstartorigin(var5.origin, var5.angles, var6 scripts\engine\utility::getanim("right_car_crash1"));
  var8 = getstartangles(var5.origin, var5.angles, var6 scripts\engine\utility::getanim("right_car_crash1"));
  var6.origin = var7;
  var6.angles = var8;
  waitframe();
  var6.scriptcoll.collision disconnectPaths();
  scripts\engine\utility::flag_wait("right_car_crash");
  scripts\engine\sp\utility::autosave_by_name("right_crash");
  var9 = (350.5, -1051, 132.5);
  var10 = createnavbadplacebybounds(var9, (90, 600, 32), (0, 56, 0));
  scripts\engine\utility::noself_delaycall(4.5, &destroynavobstacle, var10);
  var1 scripts\engine\utility::delaycall(3.8, &solid);
  var1 scripts\engine\utility::delaycall(4, &connectpaths);
  var11 = [];

  for(var12 = 0; var12 < 3; var12++) {
    var13 = "right_car" + var12 + 1;
    var14 = getscriptablearray(var13, "targetname")[0];
    var14.animname = var13;
    var14 scripts\engine\sp\utility::assign_animtree();
    var14.shell = scripts\engine\sp\utility::spawn_anim_model(var13 + "_shell", var14.origin, var14.angles);
    var14.shell linkTo(var14, "tag_body_animate", (0, 0, 0), (0, 0, 0));
    thread delete_shell();
    thread swap_shell();
    var11 = scripts\engine\utility::array_add(var11, var14);
    var14.scriptcoll = get_script_car_collision(var13);
    var14.scriptcoll linkTo(var14, "tag_origin", (0, 0, 0), (0, 0, 0));
    var7 = getstartorigin(var5.origin, var5.angles, var14 scripts\engine\utility::getanim("right_car_crash1"));
    var8 = getstartangles(var5.origin, var5.angles, var14 scripts\engine\utility::getanim("right_car_crash1"));
    var14.origin = var7;
    var14.angles = var8;
    var14.script_noteworthy = "";
  }

  waitframe();
  var11 = scripts\engine\utility::array_add(var11, var6);

  foreach(var14 in var11) {
    var16 = getanimlength(var14 scripts\engine\utility::getanim("right_car_crash1"));

    if(var14.animname != "right_car4") {
      thread spawn_my_crash_driver(var14, var16);
    }

    var17 = scripts\engine\utility::ter_op(var14.animname == "right_car1", var16 - 1, var16);
    var14.scriptcoll.trigger scripts\engine\utility::delaycall(var17, &delete);
    var14.scriptcoll.collision scripts\engine\utility::delaycall(var16, &disconnectpaths);
    thread scripts\common\notetrack::start_notetrack_wait(var14, "single anim", "right_car_crash1", var14.animname, var14 scripts\engine\utility::getanim("right_car_crash1"));
    thread scripts\sp\anim::animscriptdonotetracksthread(var14, "single anim", "right_car_crash1");
    var14 setflaggedanimknoball("single anim", var14 scripts\engine\utility::getanim("right_car_crash1"), %root, 1, 0);

    if(isDefined(var14.shell)) {
      thread scripts\common\notetrack::start_notetrack_wait(var14.shell, "right_car_crash1_notes", "right_car_crash1", var14.shell.animname, var14.shell scripts\engine\utility::getanim("right_car_crash1"));
      thread scripts\sp\anim::animscriptdonotetracksthread(var14.shell, "right_car_crash1_notes", "right_car_crash1");
      var14.shell setflaggedanim("right_car_crash1_notes", var14.shell scripts\engine\utility::getanim("right_car_crash1"), 1);
    }
  }

  wait 5;

  foreach(var3 in var0) {
    var3 connectnode();
  }
}

function spawn_my_crash_driver(var0, var1) {
  if(self.animname == "left_crash_car2") {
    var2 = scripts\engine\utility::random(getspawnerarray("obj_frontline"));
    var3 = var2 spawndrone();
    var3 scripts\sp\utility::enable_procedural_bones();
    var3.spawner = var2;
    var2.count++;
  } else {
    var3 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("female", 1, 1);
  }

  self.driver = var3;
  self.driver endon("stop_driving");
  self.drivernode = scripts\engine\utility::spawn_tag_origin();

  if(self.animname == "right_car2") {
    self.drivernode linkTo(self, "tag_origin", (-19, 0, 0), (0, 0, 0));
  } else if(self.animname == "right_car3") {
    self.drivernode linkTo(self, "tag_origin", (-19, 0, 7), (0, 0, 0));
  } else {
    self.drivernode linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  if(istrue(var3)) {
    var3.animname = "male_rf";
  } else {
    var3.animname = "male_lf";
  }

  var3 linkTo(self.drivernode, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(isai(var3)) {
    var3 visiblenotsolid();
  } else {
    var3 notsolid();
  }

  self.drivernode thread scripts\common\anim::anim_loop_solo(var3, "victor40_idle", "stop_driving_" + var3 getentitynumber());
  wait var1 - 1;
  self.drivernode notify("stop_driving_" + var3 getentitynumber());
  self.drivernode scripts\common\anim::anim_single_solo(var3, "victor40_death");
  self.drivernode delete();
}

function nt_test() {
  for(;;) {
    self waittill("single anim", var0);
    iprintlnbold(self.animname + " " + var0[0]);
  }
}

function swap_shell() {
  self waittillmatch("single anim", "end");

  if(isDefined(self.shell)) {
    self.shell setModel(self.model + "_soft_dmg");
    return;
  }
}

function delete_shell() {
  for(;;) {
    self waittillmatch("scriptableNotification", "modelswap");
    self.shell delete();
  }
}

function animated_passanger_logic() {
  self waittillmatch("single anim", "end");
  self notify("stop_loop");
  self.passenger thread scripts\sp\maps\piccadilly\piccadilly_util::ragdoll_death_after_anim();
  scripts\common\anim::anim_single_solo(self.passenger, "death");
}

function spawn_car_passenger() {
  var0 = ["_rf"];

  foreach(var2 in var0) {
    var3 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1);

    if(isDefined(var3)) {
      var4 = var3.script_namenumber == "male";

      if(var4) {
        var5 = "male";
      } else {
        var5 = "female";
        self.origin += anglesToForward(self.angles) * 7;
        self.origin += (0, 0, 6);
      }

      var6 = var5 + var3;
      var7.animname = var6;
      var7 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
      thread scripts\common\anim::anim_loop_solo(var7, "idle");
      self.passenger = var7;
      thread animated_passanger_logic();
    }
  }

  var2 = undefined;
  var4 = undefined;
}

function underground_rescue_right() {
  var0 = getEnt("underground_rescue2_gate", "targetname");
  var0 moveTo(var0.origin + (0, 0, 64), 0.05);
  var1 = scripts\engine\utility::flag_wait_any_return("underground_rescue_start_first_frame", "spec_price_intro_start");

  if(var1 != "underground_rescue_start_first_frame") {
    return;
  }

  var2 = scripts\engine\utility::getStruct("underground_rescue2_animnode", "targetname");
  var3 = getspawner("police_rescue_spawner", "targetname");
  var3.count = 1;
  var4 = scripts\engine\sp\utility::spawn_targetname("police_rescue_spawner", 1);
  var4.animname = "subway_right_rescue_p";
  var4.allowdeath = 0;
  var4.ignoreme = 1;
  var4.ignoreall = 1;
  var4 thread scripts\common\ai::magic_bullet_shield();
  var4 hide();
  var5 = [];
  GscBinSkip0(0x2e, var5.size, var4);
}

function vo_underground_rescue_right(var0) {
  thread vo_underground_right_walla();
  var0[0] scripts\engine\utility::delaythread(0.6, &scripts\sp\maps\piccadilly\piccadilly_util::say, "dx_vom_ucm3_right_underground_rescue_30");
  var0[1] scripts\engine\utility::delaythread(0.2, &scripts\sp\maps\piccadilly\piccadilly_util::say, "dx_vom_ucm4_right_underground_rescue_40");
  wait 2;
  var1 = self;
  var1 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk56_right_underground_rescue_10", 1);
  var1 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk56_right_underground_rescue_20", 0);
  scripts\engine\utility::flag_wait("tflag_left_underground_exit");
  var1 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk56_right_underground_rescue_50", 1);
}

function vo_underground_right_walla() {
  wait 0.1;
  var0 = spawn("script_origin", (751, -1485, -40));
  var0 playSound("scn_piccadilly_subway_walla");
  var0 moveTo((1413, -1815, -50), 5);
  wait 9.5;
  var0 delete();
}

function subway_right_escape_magic_bullets(var0) {
  var1 = getspawnerarray("subway_right_wave2");
  wait 2;

  foreach(var3 in var0) {
    if(!isalive(var3)) {
      continue;
    }

    thread scripts\sp\maps\piccadilly\piccadilly_combat::magicbullet_burst(scripts\engine\utility::random(var1).origin + (0, 0, 70), var3 getEye());
    wait 0.55;

    if(!isalive(var3)) {
      continue;
    }

    var3 thread scripts\engine\sp\utility::play_sound_on_entity("generic_death_falling");
  }
}

function stop_anim_on_dmg() {
  self waittill("damage");
  scripts\engine\sp\utility::anim_stopanimScripted();
}

function init_script_car_collision() {
  level.script_car_collision = [];
  var0 = getEntArray("script_car_coll", "script_noteworthy");

  foreach(var2 in var0) {
    level.script_car_collision = scripts\engine\utility::array_add(level.script_car_collision, var2);
    var3 = var2 scripts\engine\utility::get_linked_ents();

    foreach(var5 in var3) {
      switch (var5.classname) {
        case "trigger_multiple":
          if(scripts\engine\utility::is_equal(var2.script_parameters, "no_damage")) {
            var5 delete();
            break;
          }

          var5 enablelinkTo();
          var2.trigger = var5;
          thread car_coll_trig_logic(var5);
          var5 linkTo(var2);
          break;
        case "script_brushmodel":
          var2.collision = var5;
          var5 linkTo(var2);
          break;
        default:
          break;
      }
    }
  }
}

function get_script_car_collision(var0) {
  foreach(var2 in level.script_car_collision) {
    if(scripts\engine\utility::is_equal(var2.targetname, var0)) {
      return var2;
    }
  }

  return undefined;
}

function script_collision_delete() {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.collision)) {
    self.collision delete();
  }

  level.script_car_collision = scripts\engine\utility::array_remove(level.script_car_collision, self);
  self delete();
}

function car_coll_trig_logic(var0) {
  self endon("death");
  self.victims = [];

  for(;;) {
    self waittill("trigger", var1);

    if(isDefined(var1) && !scripts\engine\utility::array_contains(self.victims, var1)) {
      if(isPlayer(var1)) {
        self.victims[self.victims.size] = var1;
        var2 = vectorNormalize((0, var0.angles[1], 45));
        var1 pushplayervector(var2 * 12, 1);
        var1 scripts\sp\utility::do_damage(var1.health * 0.5, var1.origin);
        var1 scripts\engine\utility::delaycall(0.25, &kill, var1.origin);
        continue;
      }

      if(isai(var1)) {
        if(isDefined(var1.magic_bullet_shield)) {
          continue;
        }

        self.victims[self.victims.size] = var1;
        thread scripts\engine\utility::play_sound_in_space("generic_death_falling", self.origin);
        var1 scripts\engine\sp\utility::ai_ragdoll_immediate();
      }
    }
  }
}

function car_trig_debug() {
  for(;;) {
    waitframe();
  }
}
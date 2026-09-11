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
  var_0 = scripts\engine\utility::getStructArray("bullet_background", "targetname");
  scripts\engine\utility::array_thread(var_0, &ambient_fighting);
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
  var_0 = getscriptablearray("sirens_on", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("siren", "siren_on");
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
  var_0 = scripts\engine\utility::getStructArray("injured_vignette", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      switch (var_2.script_noteworthy) {
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
  var_0 = self getEye();
  level.player scripts\sp\maps\piccadilly\piccadilly_util::waittill_within_fov_from_dist(400, var_0, 2);
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

  var_0 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1, 1);
  var_0.animname = "generic";

  if(isDefined(self.script_noteworthy)) {
    var_0.script_noteworthy = self.script_noteowrthy;
  }

  var_0.script_index = 1;
  thread vignette_drone_give_soul();
  var_0 thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();
  var_0.script_animation = self.script_animation;
  self.script_animation = undefined;
  thread vo_injured_loop();
  thread scripts\common\anim::anim_loop_solo(var_0, var_0.script_animation);
  level.injured_actors[level.injured_actors.size] = var_0;
}

function vo_injured_loop() {
  self endon("death");
  var_0 = [];

  if(scripts\engine\utility::is_equal(self.voice, "unitednationsfemale")) {
    GscBinSkip0(0x2e, var_0.size, "dx_vom_ucf1_sting_rear_wounded_60");
  }

  GscBinSkip0(0x2e, var_0.size, "dx_vom_ucm1_sting_rear_wounded_20");
}

function injured_loop_single_death() {
  var_0 = spawn_looping_fakeactor_wait_for_player();
  var_1 = self.radius;

  if(!isDefined(var_0)) {
    level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
    return;
  }

  while(isDefined(var_0) && !should_do_death_vignette(var_0, var_1)) {
    wait 0.1;
  }

  if(!isDefined(var_0)) {
    return;
  }

  spawn_death_vignette_ai(var_0);
}

function should_do_death_vignette(var_0) {
  if(getaiarray().size > 28) {
    return false;
  }

  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = 1200;
  }

  var_2 = getaiarrayinradius(self.origin, var_1, "axis");

  if(!var_2.size) {
    return false;
  }

  if(distancesquared(level.player.origin, self.origin + (0, 0, 70)) <= 422500 && level.player scripts\engine\trace::can_see_origin(self.origin + (0, 0, 70), 0)) {
    return true;
  }

  return false;
}

function spawn_death_vignette_ai(var_0) {
  var_1 = undefined;
  var_1 = spawn_my_twin(var_0);

  if(isDefined(var_0.magic_bullet_shield)) {
    var_0 scripts\common\ai::stop_magic_bullet_shield();
  }

  var_0 scripts\engine\utility::delaycall(0.05, &delete);
  thread injured_dmg_death_logic();
  var_1 thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();
  var_1 endon("death");
  var_1 endon("scripted_death");
  var_1 thread scripts\sp\maps\piccadilly\piccadilly::vo_ally_warn_me();

  if(isDefined(level.scr_anim[var_1.animname]["run"])) {
    scripts\sp\anim::anim_custom_animmode([var_1], "gravity", "run");
    var_1 scripts\sp\anim::anim_custom_animmode([var_1], "gravity", "injured_death");
  } else {
    scripts\sp\anim::anim_custom_animmode([var_1], "gravity", "injured_death");
  }

  var_1.a.nodeath = 1;
  var_1.allowdeath = 1;
  var_1 scripts\common\ai::stop_magic_bullet_shield();
  var_1 scripts\engine\sp\utility::die();
}

function spawn_looping_fakeactor_wait_for_player() {
  level endon("spawn_gap_bomber");

  while(distance2dsquared(self.origin, level.player.origin) > 2250000) {
    wait 1;
  }

  var_0 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1, 1);
  var_0.animname = self.script_noteworthy;
  var_0 setCanDamage(1);
  thread injured_dmg_death_logic();
  level.injured_actors[level.injured_actors.size] = var_0;
  var_0 endon("death");
  thread scripts\common\anim::anim_loop_solo(var_0, "idle");
  waitframe();
  var_0 thread scripts\anim\death::play_blood_pool();
  level.player scripts\sp\maps\piccadilly\piccadilly_util::waittill_within_fov_from_dist(650, var_0.origin + (0, 0, 70), 10);
  return var_0;
}

function injured_dmg_death_logic() {
  self endon("entitydeleted");
  GscBinSkip4(0x35);
}

function injured_actor_death(var_0) {
  self waittill("scripted_death", var_1, var_2, var_3, var_3, var_4, var_3, var_3, var_3, var_3, var_5, var_3, var_3, var_3, var_6);
  scripts\common\ai::stop_magic_bullet_shield();
  var_7 = 0;

  if(isDefined(self.lastattacker) && scripts\engine\utility::is_equal(self.lastattacker.asmname, "suicidebomber")) {
    var_7 = 1;
  }

  if(!var_7 && isDefined(self.damageweapon) && scripts\engine\utility::is_equal(self.damageweapon.basename, "suicide_vest")) {
    var_7 = 1;
  }

  if(var_7) {
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

      self dodamage(self.health + 100, self.origin, var_2, var_6, var_4, var_5);
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

function spawn_my_twin(var_0) {
  var_1 = undefined;

  if(isDefined(self.script_forcecolor)) {
    while(!isDefined(var_1)) {
      var_1 = scripts\engine\utility::random(getspawnerarray("obj_frontline")) stalingradspawn();

      if(!isDefined(var_1)) {
        wait 0.5;
        continue;
      }

      var_1.animname = self.animname;
      var_1.voice = self.voice;

      if(!isDefined(var_0)) {
        var_1 forceteleport(self.origin, self.angles, 99999);
      }

      return var_1;
    }
  }

  while(!isDefined(var_1)) {
    var_1 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random");

    if(!isDefined(var_1)) {
      wait 0.5;
    }
  }

  var_1 setModel(self.model);

  if(var_1.headmodel != self.headmodel) {
    var_1 detach(var_1.headmodel);
    var_1 attach(self.headmodel);
  }

  var_1 setthreatbiasgroup("civilians");
  var_1 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  var_1.script_friendname = "";
  var_1.name = self.script_friendname;
  var_1.animname = self.animname;
  var_1.voice = self.voice;
  return var_1;
}

function drag_scene() {
  while(distance2dsquared(self.origin, level.player.origin) > 2250000) {
    wait 1;
  }

  var_0 = self.script_noteworthy;
  self.intro = var_0 + "_intro_idle";
  self.single = var_0;
  self.outro = var_0 + "_outro_idle";
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
  self waittill("update", var_1, var_2, var_3, var_4, var_4, var_5, var_4, var_4, var_4, var_4, var_6, var_4, var_4, var_4, var_7);

  switch (var_1) {
    case "all_dead":
    case "guy1_shot":
      if(isDefined(self.stuntguy1)) {
        self.stuntguy1 scripts\engine\sp\utility::anim_stopanimScripted();
        self.stuntguy1 dodamage(self.stuntguy1.health + 100, self.stuntguy1.origin, var_3, var_7, var_5, var_6);

        if(isDefined(self.guy1)) {
          self.guy1 delete();
        }
      } else if(isDefined(self.guy1)) {
        self.guy1 notify("death");
        drone_death_cleanup(self.guy1, self);
      }

      if(isDefined(self.stuntguy2)) {
        self.stuntguy2 scripts\engine\sp\utility::anim_stopanimScripted();
        self.stuntguy2 dodamage(self.stuntguy2.health + 100, self.stuntguy2.origin, var_3, var_7, var_5, var_6);
        self.guy2 delete();
      } else if(isDefined(self.guy2)) {
        self.guy2 dodamage(self.guy2.health + 100, self.guy2.origin, var_3, var_7, var_5, var_6);
        drone_death_cleanup(self.guy2, self);
      }

      break;
    case "guy2_shot":
      if(isDefined(self.stuntguy2)) {
        self.stuntguy2 scripts\engine\sp\utility::anim_stopanimScripted();
        self.stuntguy2 dodamage(self.stuntguy2.health + 100, self.stuntguy2.origin, var_3, var_7, var_5, var_6);
        self.guy2 delete();
      } else {
        self.guy2 dodamage(self.guy2.health + 100, self.guy2.origin, var_3, var_7, var_5, var_6);
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
        var_8 = spawn_animating_ai_cop();

        if(isalive(var_8)) {
          self.guy1 hide();
        } else {
          self.guy1 dodamage(self.guy2.health + 100, self.guy2.origin, var_3, var_7, var_5, var_6);
          drone_death_cleanup(self.guy1, self);
        }

        waitframe();

        if(isalive(var_8)) {
          self notify("stop_loop_" + var_8 getentitynumber());
          var_8 stopanimScripted();
          thread set_cop_free();
          self.guy1 delete();
        }
      }

      break;
  }

  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
}

function drone_death_cleanup(var_0) {
  self setanimrate(level.scr_anim[self.animname][var_0.lastanim][0], 0);
  scripts\asm\shared\utility::setfacialindexfornonai("death");
}

function spawn_animating_ai_cop() {
  var_0 = spawn_my_twin(self.guy1, 1);
  var_0 endon("death");
  var_0 invisiblenotsolid();
  var_0.a.coverpose_request = "exposed_crouch";
  var_1 = level.scr_anim[self.guy1.animname][self.lastanim][0];
  var_2 = self.guy1 getanimtime(var_1);
  thread scripts\common\anim::anim_loop_solo(var_0, self.lastanim, "stop_loop_" + var_0 getentitynumber());
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  waitframe();

  if(isalive(var_0)) {
    var_0 setanimtime(var_1, var_2);
    var_0 visiblesolid();
    return var_0;
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
  var_0 = undefined;
  self.goalradius = 2048;

  while(!isDefined(var_0)) {
    var_0 = self findbestcovernode(undefined, 1);
    waitframe();
  }

  self.goalradius = 32;
  scripts\sp\spawner::go_to_node(var_0);
}

function spawn_drone_cop() {
  var_0 = scripts\engine\utility::random(getspawnerarray("obj_frontline"));
  var_1 = var_0 spawndrone();
  var_1 scripts\sp\utility::enable_procedural_bones();
  var_1.spawner = var_0;
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  thread vignette_drone_give_soul();
  var_1 thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();

  if(!isai(var_1) && !istrue(var_1.script_fakeactor) && !isDefined(var_1.anim_getrootfunc)) {
    var_1.anim_getrootfunc = &scripts\sp\maps\piccadilly\piccadilly::get_anim_model_root;
  }

  thread scripts\sp\friendlyfire::friendly_fire_think(var_1);
  return var_1;
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

  var_0 = self.guy1 scripts\engine\utility::getanim(self.intro);

  while(self.guy1 getanimtime(var_0[0]) > 0.05) {
    waitframe();
  }

  var_1 = spawn_my_twin(self.guy1);
  var_1 invisiblenotsolid();
  thread group_vignette_dmg_func(var_1, self);
  thread group_vignette_death_func(var_1, self);
  var_2 = spawn_my_twin(self.guy2);
  var_2 invisiblenotsolid();
  thread group_vignette_dmg_func(var_2, self);
  thread group_vignette_death_func(var_2, self);
  var_2 thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();
  var_2 thread scripts\sp\maps\piccadilly\piccadilly_util::check_player_psycho();
  self.stuntguy1 = var_1;
  self.stuntguy2 = var_2;
  scripts\engine\utility::array_call([self.guy1, self.guy2], &hide);
  scripts\engine\utility::array_call([self.guy1, self.guy2], &notsolid);
  self notify("stop_loop");
  scripts\engine\sp\utility::delaychildthread(0.5, &position_outro);
  var_1 visiblesolid();
  var_2 visiblesolid();
  thread vo_drag_scene_carry();
  self.lastanim = self.single;
  scripts\sp\anim::anim_custom_animmode([var_1, var_2], "gravity", self.single);
  thread scripts\engine\utility::array_delete([var_1, var_2]);
  thread scripts\engine\utility::array_call(scripts\engine\utility::array_removeundefined([self.guy1, self.guy2]), &show);
  childthread scripts\common\anim::anim_loop(scripts\engine\utility::array_removeundefined([self.guy1, self.guy2]), self.outro);
  self.lastanim = self.outro;
  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);
  scripts\engine\utility::array_call([self.guy1, self.guy2], &solid);
}

function vo_drag_scene_idle(var_0) {
  self endon("stop_loop");
  self endon("update");
  var_1 = 562500;
  var_2 = [];

  if(istrue(var_0)) {
    GscBinSkip0(0x2e, var_2.size, "dx_vom_uk52_sting_rear_wounded_70");
  }

  GscBinSkip0(0x2e, var_2.size, "dx_vom_ucf1_sting_rear_wounded_210");
}

function vo_drag_scene_carry() {
  self endon("update");
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_uk52_sting_rear_wounded_140");
}

function position_outro() {
  scripts\common\anim::anim_first_frame([self.guy1, self.guy2], self.outro);
  waitframe();
  var_0 = getgroundposition(self.guy2.origin, 30);
  var_1 = self.guy2.origin[2] - var_0[2];
  self.origin -= (0, 0, var_1);
  scripts\common\anim::anim_first_frame([self.guy1, self.guy2], self.outro);
}

function group_vignette_dmg_func(var_0, var_1) {
  waitframe();
  waitframe();
  self.health = 9999;
  var_0 endon("update");

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_4, var_5, var_4, var_4, var_4, var_4, var_6, var_4, var_4, var_4, var_7);

    if(!isai(self) && isDefined(var_6)) {
      self.damageweapon = var_6;
    }

    if(isDefined(var_3) && var_3 == level.player) {
      level.gotachievement = 0;
      waitframe();
    }

    if(isDefined(var_5)) {
      if(isexplosivedamagemod(var_5)) {
        var_0 notify("update", "all_dead", var_2, var_3, var_4, var_4, var_5, var_4, var_4, var_4, var_4, var_6, var_4, var_4, var_4, var_7);
        continue;
      }

      if(scripts\engine\utility::isbulletdamage(var_5)) {
        var_0 notify("update", var_1, var_2, var_3, var_4, var_4, var_5, var_4, var_4, var_4, var_4, var_6, var_4, var_4, var_4, var_7);
      }
    }
  }
}

function group_vignette_death_func(var_0, var_1) {
  var_0 endon("update");
  self waittill("death", var_2, var_3, var_4, var_5);

  if(!isai(self) && isDefined(var_4)) {
    self.damageweapon = var_4;
  }

  if(isDefined(var_2) && var_2 == level.player) {
    level.gotachievement = 0;
    waitframe();
  }

  if(isDefined(var_3)) {
    if(isexplosivedamagemod(var_3)) {
      var_0 notify("update", "all_dead", undefined, var_2, undefined, undefined, var_3, undefined, undefined, undefined, undefined, var_4, undefined, undefined, undefined, undefined);
      return;
    }

    if(scripts\engine\utility::isbulletdamage(var_3)) {
      var_0 notify("update", var_1, undefined, var_2, undefined, undefined, var_3, undefined, undefined, undefined, undefined, var_4, undefined, undefined, undefined, undefined);
      return;
    }

    return;
  }
}

function vignette_drone_give_soul(var_0) {
  self setCanDamage(1);
  thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();

  if(!isDefined(var_0)) {
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

function ambient_explosion(var_0) {
  if(scripts\engine\utility::flag("spec_price_intro_start")) {
    return;
  }

  while(level.suicide_bombers_alive) {
    wait 5;
  }

  var_1 = scripts\engine\sp\utility::get_rumble_ent("steady_rumble");
  var_1 thread scripts\engine\sp\utility::rumble_ramp_to(5, 2);
  var_1 scripts\engine\utility::delaycall(3, &delete);
  var_2 = undefined;

  if(var_0 == "ripleys_explosion") {
    var_3 = (598, -442.5, 118.5);
    var_2 = 490000;
  } else {
    var_3 = (-469.5, 810.5, 148.5);
    var_3 = 1690000;
  }

  thread scripts\engine\utility::exploder(var_1);
  thread destroy_building(var_1);
  thread building_expl_sfx(var_1, var_3);

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_3, cos(65))) {
    scripts\engine\utility::delaythread(0.25, &scripts\sp\player::radial_distortion, 0.05, 0.2, 0.15, var_3);
  }

  wait 0.1;
  level.injured_actors = scripts\engine\utility::array_removeundefined(level.injured_actors);

  foreach(var_5 in level.injured_actors) {
    if(var_5.animname == "guy1" || var_5.animname == "guy2") {
      continue;
    }

    if(isDefined(var_5) && distance2dsquared(var_3, var_5.origin) < 160000) {
      var_5 delete();
    }
  }

  radiusdamage(scripts\common\utility::groundpos(var_3) + (0, 0, 10), 500, 150, 10, undefined, "MOD_EXPLOSIVE");
  wait 0.25;

  if(distance2dsquared(var_3, level.player.origin) <= var_3 && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_3, cos(65))) {
    level.player shellshock("default_nosound", 2);
    level.player scripts\engine\utility::delaycall(2.5, &fadeoutshellshock);
    level.player setpriorityclienttriggeraudiozonepartial("deathsdoor", "deathsdoor", "reverb");
    level.player scripts\engine\utility::delaycall(2.5, &clearpriorityclienttriggeraudiozone, "deathsdoor");
  }

  level.player playSound("plr_breath_pain_init");
  level.player scripts\engine\utility::delaycall(4, &playsound, "breathing_better");
  level.player viewkick(120, var_3, 0);
  earthquake(0.5, 0.8, level.player.origin, 800);

  if(var_1 == "ripleys_explosion") {
    var_7 = getaiarray();

    foreach(var_9 in var_7) {
      if(isalive(var_9) && var_9 istouching(level.goalvolumes["gap_street_front"])) {
        var_9 dodamage(40, var_9 getEye());
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
  var_0 = ["donna_destroyed"];

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "targetname");
    var_3.origin -= (0, 0, 1000);
  }
}

function init_wileys() {
  var_0 = ["left_brushmodel_destroyed", "right_brushmodel_destroyed", "middle_brushmodel_destroyed"];

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "targetname");
    var_3.origin -= (0, 0, 1000);
  }
}

function destroy_building(var_0) {
  var_1 = [];
  var_2 = [];

  if(var_0 == "ripleys_explosion") {
    var_1 = ["middle_brushmodel_pristine", "left_brushmodel_pristine", "right_brushmodel_pristine"];
    var_2 = ["left_brushmodel_destroyed", "right_brushmodel_destroyed", "middle_brushmodel_destroyed"];
  } else {
    var_1 = ["donna_pristine"];
    var_2 = ["donna_destroyed"];
    cinematicingameloop("mp_pic_screens", 1);
  }

  if(var_1.size) {
    foreach(var_4 in var_1) {
      var_5 = getEnt(var_4, "targetname");
      var_5.origin -= (0, 0, 1000);

      if(var_5.spawnflags & 1) {
        waitframe();
        self disconnectPaths();
      }
    }
  }

  if(var_2.size) {
    foreach(var_4 in var_2) {
      var_5 = getEnt(var_4, "targetname");
      var_5.origin += (0, 0, 1000);
    }

    return;
  }
}

function building_expl_sfx(var_0, var_1) {
  var_2 = spawn("script_origin", var_1);

  if(var_0 == "ripleys_explosion") {
    var_2 playexplosionsound("bldng_ripleys_expl", "exp");
    var_3 = spawn("script_origin", (612, -425, 168));
    var_3 playLoopSound("emt_bldng_fire_lp_01");
  } else if(var_0 == "bank_explosion") {
    var_2 playexplosionsound("bldng_bank_expl", "exp");
    var_4 = spawn("script_origin", (-508, 848, 196));
    var_5 = spawn("script_origin", (-584, 955, 200));
    var_4 playLoopSound("emt_bldng_fire_lp_03");
    var_5 playLoopSound("emt_bldng_fire_lp_01");
  }

  wait 10;
  var_2 delete();
}

function ambient_combat_popo() {
  level endon("inside_gap_flag");
  var_0 = scripts\common\utility::getvehiclespawner("ambient_popo", "targetname");
  var_0 scripts\engine\sp\utility::add_spawn_function(&ambient_popo_spawn_func);

  for(;;) {
    var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("ambient_popo");
    wait 1;
    var_1 vehicle_setspeedimmediate(var_1 vehicle_getspeed() + randomint(15), 10);
    var_1 waittill("reached_end_node");
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
  var_0 = scripts\engine\utility::getStruct("underground_left_animnode", "targetname");
  GscBinSkip4(0x6e, var_0);
}

#using_animtree("generic_human");

function left_underground_civ_dmg_func() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_2, var_3, var_2, var_2, var_2, var_2, var_4, var_2, var_2, var_2, var_5);

    if(istrue(self.shot)) {
      return;
    }

    if(scripts\engine\utility::is_equal(var_1, level.player)) {
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
  var_0 = scripts\engine\utility::spawn_script_origin(self.origin + (55, 55, 60));
  vo_enemy_underground_left_internal(var_0);
  var_0 stopsounds();
  waitframe();
  var_0 delete();
}

function vo_enemy_underground_left_internal() {
  level endon("right_side_cleanup");
  scripts\engine\utility::flag_wait("tflag_left_underground");
  thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_aq1_combat_tube_60");
  scripts\engine\utility::flag_wait("left_side_under_engaged");
}

function vo_hostage_sequence_underground_left(var_0, var_1) {
  wait 0.3;
  var_1[0] thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_ucm1_combat_tube_80", 1);
  wait 1.4;
  var_1[1] thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_ucm2_combat_tube_90", 1);
  wait 0.2;
  scripts\engine\sp\utility::waittill_dead_or_dying(var_0, var_0.size);
  wait 1.5;
  var_2 = 0;
  var_3 = scripts\engine\sp\utility::create_deck(["dx_vom_ucm1_combat_tube_110", "dx_vom_ucm2_combat_tube_120"]);
  var_4 = scripts\engine\sp\utility::create_deck(["dx_vom_ucf1_combat_tube_130"]);

  foreach(var_6 in var_1) {
    if(isalive(var_6)) {
      var_7 = var_6 scripts\sp\maps\piccadilly\piccadilly_util::get_gender();

      if(var_7 == "male") {
        if(var_3 scripts\engine\sp\utility::deck_is_empty()) {
          continue;
        }

        var_6 thread scripts\sp\maps\piccadilly\piccadilly_util::say(var_3 scripts\engine\sp\utility::deck_draw(), 1);
      } else {
        if(var_4 scripts\engine\sp\utility::deck_is_empty()) {
          continue;
        }

        var_6 thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter(var_4 scripts\engine\sp\utility::deck_draw(), 1);
      }

      if(!var_2) {
        level.player thread scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_140", 1, 2);
      }

      var_2 = 1;
      wait randomfloatrange(0.1, 0.35);
    }
  }

  var_9 = (-1947.35, -1346.81, -59);

  if(!var_2 && level.player scripts\engine\trace::can_see_origin(var_9, 0)) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_150");
  }

  var_10 = scripts\engine\sp\utility::get_living_ai("left_underground_hero_cop", "script_noteworthy");

  if(!isDefined(var_10)) {
    return;
  }

  wait 2;
  var_10.animname = "left_underground_police_rescue";

  if(var_2) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_170", 1);

    if(!isDefined(var_10)) {
      return;
    }

    var_10 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk55_combat_tube_190", 1);
    return;
  }

  level.player scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_kyle_combat_tube_180", 1);

  if(!isDefined(var_10)) {
    return;
  }

  var_10 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk55_combat_tube_200", 1);
}

function print3donme(var_0) {
  self endon("death");
  self notify("stop_print3d");
  self endon("stop_print3d");

  for(;;) {
    waitframe();
  }
}

function left_underground_bad_guy_death_reacts(var_0, var_1, var_2) {
  var_0 endon("stop breakout");
  thread proximity_check(var_0);
  scripts\engine\utility::waittill_any_ents(self, "death", var_0, "update");
  scripts\engine\utility::flag_set("left_side_under_engaged");
  var_3 = "left_underground_execution_react_r";
  var_4 = level.player.origin[1] > -1270;

  if(var_4) {
    var_3 = "left_underground_execution_react_l";
  }

  var_5 = undefined;

  if(self == var_1[0] && isalive(var_1[1])) {
    var_5 = var_1[1];
  }

  if(self == var_1[1] && isalive(var_1[0])) {
    var_5 = var_1[0];
  }

  if(isDefined(var_5)) {
    var_5 scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 thread scripts\common\anim::anim_single_solo(var_5, var_3);
  }

  var_2 = scripts\engine\utility::array_removedead(var_2);
  var_0 notify("stop breakout");
}

function left_underground_hero_cop() {
  scripts\engine\utility::array_delete(getEntArray("left_underground_hero_trig", "script_noteworthy"));
  self endon("death");
  self.dontevershoot = 1;
  level.player scripts\engine\utility::waittill_notify_or_timeout("weapon_fired", 2.5);
  self.dontevershoot = 0;
  thread delete_after_time(7);
}

function delete_after_time(var_0) {
  self endon("death");
  wait var_0;
  level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 600);
}

function reset_after_anim(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);
  self.health = self.og_health;
  self.deathanim = self.og_deathanim;
}

function remove_civ_left_subway(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);

  if(istrue(self.shot)) {
    return;
  }

  scripts\common\ai::stop_magic_bullet_shield();
  scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\common\anim::anim_single_solo(self, "left_underground_execution_getup");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "left_underground_execution_getup_idle", "stop_loop_" + self getentitynumber());
  var_2 = cos(65);

  for(;;) {
    wait 2;

    if(distancesquared(self.origin, level.player.origin) <= 122500 && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self getEye(), var_2) && level.player adsButtonPressed()) {
      var_0 notify("stop_loop_" + self getentitynumber());
      var_0 scripts\common\anim::anim_single_solo(self, "left_underground_execution_react_ads");
      var_0 thread scripts\common\anim::anim_loop_solo(self, "left_underground_execution_getup_idle", "stop_loop_" + self getentitynumber());
    }
  }
}

function create_hostage_interact() {
  scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 48), "Untie", undefined, undefined, 110);
}

#using_animtree("");

function hostage_sequence_lillywhites() {
  var_0 = scripts\engine\utility::getStruct("lillywhites_upper_escalator_animnode", "targetname");
  var_0.struggle_started = 0;
  var_0.struggle_decided = 0;
  var_0.no_player = 0;
  var_1 = getspawnerarray("lillywhites_execution_c");
  var_2 = [];
  var_3 = [];
  var_4 = [];
  level.lillywhites_civs = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = scripts\engine\utility::ter_op(var_1[var_5].script_animname == "lw_civ3", "female", "male");
    var_7 = var_1[var_5] scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ(var_6, 1);
    var_7.animname = var_1[var_5].script_animname;
    var_7.team = "allies";
    var_7 scripts\engine\utility::ent_flag_init("free");
    var_2 = scripts\engine\utility::array_add(var_2, var_7);
    var_3 = scripts\engine\utility::array_add(var_3, var_7);

    if(var_7.animname == "lw_civ1") {
      var_7.allowdeath = 1;
      var_4 = scripts\engine\utility::array_add(var_4, var_7);
    }

    level.lillywhites_civs[var_7.animname] = var_7;
    thread lilly_actor_dmg_func(var_7, var_0, "civ_dmg");
  }

  var_8 = scripts\engine\sp\utility::spawn_targetname("lillywhites_execution_t", 1);
  var_8.animname = "lw_t1";
  var_8.og_health = var_8.health;
  var_8.allowdeath = 1;
  var_8.ignoreme = 1;
  var_8.ignoreall = 1;
  var_8.disablelongdeath = 1;
  thread lilly_actor_dmg_func(var_8, var_0);
  var_8 scripts\sp\utility::context_melee_allow(0);
  level.lilly_terry = var_8;
  var_2 = scripts\engine\utility::array_add(var_2, var_8);
  var_4 = scripts\engine\utility::array_add(var_4, var_8);
  var_0.guys = var_2;
  var_0.good_guys = var_3;
  var_0.end_guys = var_4;
  var_0.terry = var_8;
  var_0 thread scripts\common\anim::anim_loop(var_2, "lilly_whites_execution_idle");
  thread lillywhites_internal(level);
  var_0 waittill("update", var_9, var_10);
  var_0.outcome = 1;

  switch (var_9) {
    case "civ_dmg":
      if(scripts\engine\utility::is_equal(var_10.lastattacker, level.player)) {
        var_10 scripts\engine\sp\utility::anim_stopanimScripted();
        var_10 setanim(%sdr_com_exposed_crouch_death01_midbody_md_4, 1);
      }

      break;
    case "terry_dmg":
      scripts\engine\sp\utility::array_notify(var_2, "stop_polling_damage");
      var_11 = var_8.lastattacker;
      var_12 = var_8.damagemod;
      var_13 = level.player getcurrentweapon();

      while(istrue(var_8.noreact)) {
        waitframe();
      }

      var_8 thread scripts\anim\shared::dropallaiweapons();

      if(istrue(var_0.struggle_started)) {
        var_14 = var_8.origin + anglestoright(var_8.angles) * 100;
        var_15 = vectorNormalize(var_14 - var_8.origin);
        var_8 startragdollfromimpact("torso_upper", var_15 * 2000);
        wait 0.5;
        var_8 scripts\sp\utility::do_damage(var_8.health + 100, var_8.origin, var_11, var_11, var_12, var_13);
      } else {
        var_8 scripts\sp\utility::do_damage(var_8.health + 100, var_8.origin, var_11, var_11, var_12, var_13);
      }

      free_lilly_civs(var_0);
      break;
    case "terry_proximity":
      scripts\engine\sp\utility::array_notify(var_2, "stop_polling_damage");
      var_8 scripts\engine\sp\utility::anim_stopanimScripted();
      var_8.health = var_8.og_health;
      var_8.ignoreme = 0;
      var_8.ignoreall = 0;
      wait 1;
      thread free_lilly_civs(var_0);
      break;
    case "all_dead":
      var_2 = scripts\engine\utility::array_removedead(var_2);
      var_16 = 0;

      foreach(var_7 in var_2) {
        if(var_7.team != "axis" && scripts\engine\utility::is_equal(var_7.lastattacker, level.player)) {
          var_16 = 1;
        }

        var_7 scripts\engine\sp\utility::anim_stopanimScripted();
        var_7 setanim(%sdr_com_exposed_crouch_death01_midbody_md_4, 1);
        var_7 scripts\engine\sp\utility::die();
      }

      if(var_16) {
        thread scripts\sp\friendlyfire::missionfail(1);
      }

      break;
    case "delete":
      scripts\engine\utility::array_delete(var_2);
      return;
    default:
      var_8.ignoreme = 0;
      var_8.ignoreall = 0;
      break;
  }

  scripts\engine\sp\utility::autosave_by_name("blah");
  level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(scripts\engine\utility::array_removedead(level.lillywhites_civs), 600);
  level scripts\engine\utility::delaythread(2, &spawn_lillywhite_rescue_police, var_0);
}

function free_lilly_civs(var_0) {
  level.lillywhites_civs = scripts\engine\utility::array_removeundefined(level.lillywhites_civs);
  var_0 notify("stop_loop");

  foreach(var_2 in level.lillywhites_civs) {
    if(isDefined(var_2.executed)) {
      continue;
    }

    thread lilly_civ_reaction(var_2);
  }
}

function lilly_civ_reaction(var_0) {
  self endon("death");
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(istrue(var_0.struggle_started) && self.animname == "lw_civ1") {
    var_1 = "lilly_whites_execution_enemy_death";
    var_2 = "lilly_whites_execution_enemy_death_idle";
    var_3 = "lilly_whites_execution_enemy_death_cower";
  } else {
    var_1 = "lilly_whites_free";
    var_2 = "lilly_whites_free_idle";
    var_3 = "lilly_whites_free_cower";
  }

  thread vo_lilly_civ_react();
  var_3 scripts\common\anim::anim_single_solo(self, var_1);
  var_3 thread scripts\common\anim::anim_loop_solo(self, var_2, "stop_loop_" + self getentitynumber());

  if(self.animname == "lw_civ1" || self.animname == "lw_civ2") {
    thread civ_dmg_trig();
  }

  var_4 = cos(65);

  for(;;) {
    wait 1;

    if(distancesquared(self.origin, level.player.origin) <= 122500 && scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self getEye(), var_4) && level.player adsButtonPressed()) {
      var_3 notify("stop_loop_" + self getentitynumber());
      var_3 scripts\common\anim::anim_single_solo(self, var_3);
      var_3 thread scripts\common\anim::anim_loop_solo(self, var_2, "stop_loop_" + self getentitynumber());
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
    var_0 = "civ03_rescue_dmg";
  } else {
    var_0 = "civ01_rescue_dmg";
  }

  var_1 = getEnt(var_0, "targetname");

  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_4, var_5, var_4, var_4, var_4, var_4, var_6, var_4, var_4, var_4, var_7);

    if(scripts\engine\utility::is_equal(var_3, level.player)) {
      thread scripts\sp\friendlyfire::missionfail(1);
      return;
    }
  }
}

function lilly_actor_dmg_func(var_0, var_1, var_2) {
  self endon("death");

  if(!isai(self)) {
    self setCanDamage(1);
    self makeentitysentient("allies");
  }

  if(istrue(var_2)) {
    self.ignoreall = 1;
    self.ignoreme = 1;
  }

  self.health = 9999;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_5, var_6, var_5, var_5, var_5, var_5, var_7, var_5, var_5, var_5, var_8);

    if(!isai(self) && isDefined(var_4)) {
      self.lastattacker = var_4;
    }

    if(scripts\engine\utility::is_equal(var_4, var_0.terry)) {
      continue;
    }

    if(isDefined(var_6)) {
      if(isexplosivedamagemod(var_6)) {
        var_0 notify("update", "all_dead", self);
        return;
      }

      if(scripts\engine\utility::isbulletdamage(var_6)) {
        if(!istrue(var_0.outcome) && scripts\engine\utility::is_equal(var_4, level.player) && self.team == "axis") {
          var_0 notify("update", var_1, self);
        }

        if(scripts\engine\utility::is_equal(var_4, level.player) && self.team != "axis") {
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

function lillywhites_internal(var_0) {
  var_1 = do_lilly_execition(var_0);

  if(istrue(var_1)) {
    do_lilly_struggle(var_0);
    return;
  }
}

function do_lilly_execition(var_0) {
  var_0 endon("update");
  var_1 = scripts\engine\utility::flag_wait_any_return("lillywhites_rescue_start_escalator", "spec_price_intro_start");

  if(var_1 != "lillywhites_rescue_start_escalator") {
    var_0 notify("update", "delete");
    return;
  }

  thread vo_lilly_execution(var_0);
  GscBinSkip4(0x6e, var_0.terry, var_0);
}

function vo_lilly_execution(var_0) {
  thread vo_lillywhites_cleared(var_0);
  var_0 endon("update");
  var_0.terry scripts\engine\utility::call_on_notify("damage", &stopsounds);
  var_1 = level.lillywhites_civs["lw_civ1"];
  var_2 = level.lillywhites_civs["lw_civ2"];
  var_3 = level.lillywhites_civs["lw_civ3"];
  wait 0.3;
  var_3 thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvf1_shops_execution_20");
  wait 0.5;
  var_0.terry thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_aq3_shops_execution_10");
  var_3 waittill("shot");
  var_3 stopsounds();
  wait 0.2;
  var_2 thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm1_shops_execution_30");
  wait 1.7;
  var_0.terry thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_aq3_shops_execution_60");
  wait 7;
  var_0.terry stopsounds();
}

function vo_lillywhites_cleared(var_0) {
  var_0.terry waittill("death", var_1);

  if(!isDefined(var_1)) {
    return;
  }

  wait 1.35;

  if(var_0.no_player) {
    scripts\engine\utility::flag_wait("lillywhites_rescue_start_escalator");
  }

  var_2 = 0;

  foreach(var_4 in level.lillywhites_civs) {
    if(isalive(var_4)) {
      var_2++;
    }
  }

  if(var_2 > 0) {
    level.player scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_kyle_shops_execution_100");
    wait 0.25;
  }

  switch (var_2) {
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

function terry_noreact_window(var_0) {
  self endon("death");
  wait 3.36;
  self.noreact = 1;
  var_0.terry.skipdeathanim = 1;
  wait 1.7;
  var_0.struggle_started = 1;
  self.noreact = undefined;
}

function vo_final_struggle() {
  self endon("end_struggle");
  wait 1.5;
  level.lillywhites_civs[0] thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm2_shops_execution_80", 1);
  wait 2.5;
  level.lillywhites_civs[0] stopsounds();
}

function do_lilly_struggle(var_0) {
  var_0 endon("update");
  level notify("lillywhite struggle");

  if(var_0.no_player) {
    thread spawn_lillywhite_rescue_police(var_0);
  }

  var_0 thread scripts\common\anim::anim_loop(var_0.end_guys, "lilly_whites_execution_struggle", "end_struggle");
  thread lilly_white_time_out();
  thread lilly_white_kill(var_0);
  thread vo_final_struggle();
  var_1 = scripts\engine\utility::flag_wait_any_return("lilly_white_execution_time_out", "lilly_white_execution_save");
  var_0.struggle_decided = 1;
  var_0 notify("end_struggle");

  if(var_1 == "lilly_white_execution_save") {
    level.lillywhites_civs[0] thread scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_cvm2_shops_execution_90");
    var_0.end_guys = scripts\engine\utility::array_remove(var_0.end_guys, var_0.terry);
    var_0.terry thread scripts\sp\maps\piccadilly\piccadilly_gap::die_after_anim();
    var_0 thread scripts\common\anim::anim_single(var_0.end_guys, "lilly_whites_execution_enemy_death");
    return;
  }

  if(var_1 == "lilly_white_execution_time_out") {
    var_0.terry thread scripts\anim\notetracks::notetrackfire();
    thread scripts\sp\maps\piccadilly\piccadilly_anim::squib_chest(var_0.end_guys[0]);
    var_0.end_guys[0] scripts\engine\utility::delaycall(0.1, &startragdoll);
    var_0 scripts\common\anim::anim_single(var_0.end_guys, "lilly_whites_execution_civ_death");
    var_2 = scripts\engine\utility::array_remove(var_0.end_guys, var_0.terry);

    if(isalive(var_0.end_guys[0])) {
      if(isDefined(var_0.end_guys[0].magic_bullet_shield)) {
        var_0.end_guys[0] scripts\common\ai::stop_magic_bullet_shield();
      }

      var_0.end_guys[0].script_pushable = 0;
      var_0.end_guys[0] setCanDamage(0);
      var_0.end_guys[0] freeentitysentient();
      var_0.end_guys[0] notsolid();
      level.lillywhites_civs = scripts\engine\utility::array_remove(level.lillywhites_civs, var_0.end_guys[0]);
    }

    var_0.terry.health = var_0.terry.og_health;
    var_0.terry.skipdeathanim = undefined;
    var_0.terry getenemyinfo(level.player);
    var_0.terry.goalradius = 2048;
    var_0 notify("update", "scene_complete");
    return;
  }
}

function proximity_check(var_0) {
  self endon("death");
  var_1 = squared(120);

  for(;;) {
    if(istrue(self.noreact)) {
      return;
    }

    if(distancesquared(self.origin, level.player.origin) <= var_1) {
      var_0 notify("update", "terry_proximity");
    }

    waitframe();
  }
}

function spawn_lillywhite_rescue_police(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_targetname("lilly_rescue_police", 1);

  if(!scripts\common\ai::spawn_failed(var_1)) {
    var_1 scripts\engine\utility::set_movement_speed(190);
    var_1.attackeraccuracy = 0;
    var_1 scripts\engine\utility::delaythread(5, &scripts\engine\sp\utility::set_attackeraccuracy, 1);
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

function lilly_white_kill(var_0) {
  var_0 waittill("damage");
  scripts\engine\utility::flag_set("lilly_white_execution_save");
}

function get_scriptable_door_anim(var_0, var_1) {
  var_2 = undefined;

  switch (var_1) {
    case "victor40":
      if(var_0.animname == "male_lf") {
        var_2 = % vehicle_victor40_car_getout_lf_side;
      } else {
        var_2 = $vehicle_victor40_car_getout_rf_side;
      }

      break;
    case "skilo":
      if(var_0.animname == "male_lf") {
        var_2 = % vehicle_skilo_car_getout_lf_side;
      } else {
        var_2 = % vehicle_skilo_car_getout_rf_side;
      }

      break;
    case "calfa":
      if(var_0.animname == "male_lf") {
        var_2 = % vehicle_calfa_car_getout_lf_side;
      } else {
        var_2 = % vehicle_calfa_car_getout_rf_side;
      }

      break;
    case "ralfa":
      if(var_0.animname == "male_lf") {
        var_2 = % vehicle_ralfa_car_getout_lf_side;
      } else {
        var_2 = % vehicle_ralfa_car_getout_rf_side;
      }

      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

function scriptable_anim(var_0) {
  self useanimtree(#animtree);
  self setflaggedanimknoball("single anim", var_0, %root, 1, 0);
}

function sting_building_rescue() {
  var_0 = scripts\engine\utility::getStruct("sting_building_animnode", "targetname");
  scripts\engine\utility::flag_wait("stop_storefront_drones");
  var_1 = getspawnerarray("sting_civs");
  var_2 = getspawner("sting_po", "targetname");
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_4 == 3 || var_4 == 5 || var_4 == 7) {
      continue;
    }

    if(var_4 == 2) {
      var_5 = var_1[var_4] scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("male", 1);
    } else {
      var_5 = var_1[var_4] scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1);
    }

    var_5.animname = "sting_rescue_civ" + var_4 + 1;
    var_3 = scripts\engine\utility::array_add(var_3, var_5);
    var_5.ignoreme = 1;
  }

  var_5 = var_2 stalingradspawn();
  var_5.animname = "sting_rescue_p";
  var_5.ignoreme = 1;
  var_3 = scripts\engine\utility::array_add(var_3, var_5);
  scripts\engine\utility::array_thread(var_3, &sting_actor_logic, var_0);
  var_6 = getEnt("reading_rescue_door", "targetname");
  var_7 = scripts\engine\utility::flag_wait_any_return("sting_building_rescue_start", "reading_place_front", "player_in_center", "gap_approach");

  if(var_7 != "sting_building_rescue_start") {
    scripts\engine\utility::array_delete(var_3);
    return;
  }

  thread vo_bookstore_walla();
  var_6 scripts\engine\utility::delaycall(3.2, &rotateyaw, 90, 0.25, 0.15, 0.05);
  var_6 scripts\engine\utility::delaythread(3.2, &audio_door_open);
  var_6 scripts\engine\utility::delaycall(10.2, &rotateyaw, -90, 0.6, 0.55, 0.05);
  var_6 scripts\engine\utility::delaythread(10.6, &audio_door_close);
  scripts\engine\sp\utility::autosave_by_name("sting_rescue");
  var_5 waittillmatch("single anim", "end");
  wait 1;
  scripts\engine\utility::array_delete(var_3);
}

function vo_bookstore_walla() {
  var_0 = spawn("script_origin", (-2378, -390, 172));
  var_0 playSound("scn_piccadilly_bookstore_walla");
  var_0 moveTo((-2393, -583, 172), 2.5);
  wait 2.5;
  var_0 moveTo((-2625, -614, 172), 2.5);
  wait 12;
  var_0 delete();
}

function audio_door_open() {
  var_0 = self.origin + (0, 0, 40);
  thread scripts\engine\utility::play_sound_in_space("scrpt_door_wood_clean_bash", var_0);
}

function audio_door_close() {
  var_0 = self.origin + (0, 0, 40);
  thread scripts\engine\utility::play_sound_in_space("door_hit_wall", var_0);
}

function sting_actor_logic(var_0) {
  self endon("death");

  if(!isai(self)) {
    thread vignette_drone_give_soul();
  }

  var_0 thread scripts\common\anim::anim_loop_solo(self, "sting_rescue_idle", "stop_sting_idle");
  scripts\engine\utility::flag_wait("sting_building_rescue_start");
  var_0 notify("stop_sting_idle");
  level.scr_goaltime[self.animname]["sting_rescue"] = 1.5;
  var_0 scripts\common\anim::anim_single_solo(self, "sting_rescue");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "sting_rescue_end", "stop_sting_idle");
}

function scriptable_car_getouts() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("civ_getout", "targetname");
  scripts\engine\utility::array_thread(var_0, &car_getout);
}

function car_getout() {
  self.script_noteworthy = "ignore";
  var_0 = strtok(self.classname, "_")[4];
  var_1 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("male", 1, 1);
  var_1.animname = "male_lf";
  thread scripts\common\anim::anim_loop_solo(var_1, var_0 + "_scared_idle");
  var_1 linkTo(self, "tag_origin");
  waittill_player_close_or_death();
  var_2 = self getscriptablepartstate("body", 1);
  var_3 = scripts\engine\utility::is_equal(var_2, "dead");

  if(!var_3) {
    if(scripts\engine\math::is_point_in_front(level.player.origin)) {
      var_4 = var_0 + "_exit_fwd";
    } else {
      var_4 = var_1 + "_exit_back";
    }

    while(getaiarray().size > 25) {
      waitframe();
    }

    var_5 = get_scriptable_door_anim(var_2, var_1);
    var_6 = spawn_my_twin(var_2);
    self notify("stop_loop");
    var_2 delete();
    thread scriptable_anim(var_5);
    var_6 scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::play_sound_on_entity, "generic_death_falling_scream");
    var_6.deathfunction = &car_runner_deathfunc;
    scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::set_allowdeath, 1);
    scripts\common\anim::anim_single_solo(var_6, var_4);
    self clearanim(var_5, 0);
    self.script_noteworthy = "";

    if(isalive(var_6)) {
      if(can_fake_snipe()) {
        thread snipe_me(var_6);
      }
    }

    if(isalive(var_6)) {
      var_6 thread scripts\sp\maps\piccadilly\piccadilly_civs::civ_think_run();
      return;
    }

    return;
  }

  self notify("stop_loop");
  scripts\common\anim::anim_single_solo(var_2, "victor40_death");
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

function snipe_me(var_0) {
  self endon("death");
  scripts\engine\utility::flag_set("scripted_sniper");
  var_1 = scripts\engine\utility::getStructArray("window_snipe", "targetname");
  var_1 = sortbydistance(var_1, self.origin);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(scripts\engine\trace::ray_trace_passed(var_4.origin, self getEye(), self)) {
      var_2 = var_4;
      break;
    }
  }

  if(!isDefined(var_2)) {
    scripts\engine\utility::flag_clear("scripted_sniper");
    return false;
  }

  if(istrue(var_0)) {
    snipe_laser(var_2, self);
  }

  var_6 = getcompleteweaponname("iw8_sn_delta");
  self.health = 10;
  magicbullet(var_6, var_2.origin, self getEye());
  scripts\engine\utility::flag_clear("scripted_sniper");
  return true;
}

function snipe_laser(var_0) {
  var_0 endon("death");

  while(level.player.origin[2] - self.origin[2] > abs(100)) {
    waitframe();
  }

  var_1 = gettime() + 700 + randomintrange(300, 550);
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_laser");
  var_2.angles = self.angles;
  var_2 setmoverlaserweapon(scripts\sp\maps\piccadilly\piccadilly_combat::make_picc_sniper_weapon());
  var_2 laserforceon();
  var_0 thread scripts\engine\utility::delete_on_death(var_2);

  while(gettime() < var_1) {
    var_3 = var_2.origin;
    var_4 = var_0 getEye();
    var_5 = vectorNormalize(var_4 - var_3);
    var_6 = var_2.angles;
    var_5 = vectorNormalize((var_5[0], var_5[1], 0));
    var_6 = vectorNormalize((var_6[0], var_6[1], 0));
    var_2.angles = vectortoangles(var_4 - self.origin);
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
  var_0 = getEnt("left_crash_ralfa_doors_open", "targetname");
  var_0 notsolid();
  var_1 = getnodearray("leftside_crash_nodes", "targetname");

  foreach(var_3 in var_1) {
    var_3 disconnectnode();
  }

  var_5 = scripts\engine\utility::getStruct("sting_crashnode", "targetname");
  var_5.angles = (0, 0, 0);
  var_6 = getscriptablearray("left_crash_car3", "targetname")[0];
  var_6.animname = "left_crash_car3";
  var_6 scripts\engine\sp\utility::assign_animtree();
  var_6.scriptcoll = get_script_car_collision("left_crash_car3");
  var_6.scriptcoll linkTo(var_6, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_6.scriptcoll.trigger scripts\engine\utility::trigger_off();
  var_7 = getstartorigin(var_5.origin, var_5.angles, var_6 scripts\engine\utility::getanim("left_car_crash"));
  var_8 = getstartangles(var_5.origin, var_5.angles, var_6 scripts\engine\utility::getanim("left_car_crash"));
  var_6.origin = var_7;
  var_6.angles = var_8;
  waitframe();
  var_6.scriptcoll.collision disconnectPaths();
  scripts\engine\utility::flag_wait("left_car_crash_go");
  thread delete_lotus_decho();
  scripts\engine\sp\utility::flagwaitthread("left_crash_kill_squad_looking", &left_crash_kill_squad);
  getEnt("left_crash_kill_squad_trig", "targetname") scripts\engine\sp\utility::add_trigger_function(&left_crash_kill_squad_civs);
  var_9 = [];
  GscBinSkip0(0x2e, var_9.size, var_6);
}

function ralfa_delete_door_collision(var_0) {
  self waittill("rocked");
  var_0 delete();
}

function delete_lotus_decho() {
  var_0 = scripts\common\utility::getvehiclespawner("middle_lotus_enemies", "targetname");

  foreach(var_2 in getspawnerarray(var_0.target)) {
    if(isspawner(var_2)) {
      var_2 delete();
    }
  }

  var_0 delete();
}

function left_side_cop_driver() {
  if(isai(self)) {
    scripts\common\ai::gun_remove();
  }

  var_0 = anglestoright(self.driver.angles) * -1;
  var_1 = self.driver.origin + var_0 * 200;
  var_2 = vectorNormalize(var_1 - self.driver.origin);
  self.driver notify("stop_driving");
  self.driver unlink();
  self.driver scripts\engine\sp\utility::anim_stopanimScripted();
  self.driver startragdollfromimpact("torso_upper", var_2 * 4500);
}

function left_crash_kill_squad() {
  var_0 = getEnt("left_crash_kill_squad_trig", "targetname");

  if(isDefined(var_0) && !istrue(var_0.trigger_off)) {
    var_0 scripts\engine\sp\utility::activate_trigger();
    return;
  }
}

function left_crash_kill_squad_civs(var_0) {
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

function left_side_crash_terries(var_0, var_1) {
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("left_car_accident_terry");

  foreach(var_4 in var_2) {
    if(var_5 == 0) {
      var_4.animname = "ralfa_left";
    } else {
      var_4.animname = "ralfa_right";
    }

    var_4.ignoreme = 1;
    var_4 thread scripts\common\ai::magic_bullet_shield(1);
    var_0 scripts\common\anim::anim_first_frame_solo(var_4, "left_crash_exit");
    var_4 linkTo(var_0, "tag_origin");
    var_4 scripts\engine\utility::delaythread(var_1 - 0.6, &left_side_terry_dmg);
  }

  var_0 scripts\engine\utility::delaythread(var_1 - 0.6, &scripts\common\anim::anim_single, var_2, "left_crash_exit");
  scripts\engine\utility::array_thread(var_2, &left_side_crash_terry_logic);
}

function left_side_crash_terry_logic() {
  self waittillmatch("single anim", "end");
  self notify("stop_dmg_polling");
  self unlink();
  self.ignoreme = 0;
  scripts\common\ai::stop_magic_bullet_shield();

  if(isDefined(self.animname)) {
    var_0 = getnode(self.animname, "script_noteworthy");

    if(var_0 scripts\engine\math::is_point_in_front(level.player.origin)) {
      self.goalradius = 32;
      thread scripts\sp\spawner::go_to_node(var_0);
    }
  } else {
    self.goalradius = 2048;
  }

  thread scripts\sp\maps\piccadilly\piccadilly_combat::close_in_on_far_player();
}

function left_side_terry_dmg() {
  self endon("stop_dmg_polling");
  self waittill("damage", var_0, var_1, var_2, var_2, var_3, var_2, var_2, var_2, var_2, var_4, var_2, var_2, var_2, var_5);
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.forceragdollimmediate = 1;
  scripts\engine\sp\utility::set_allowdeath(1);
  self dodamage(self.health + 1000, self.origin, var_1, var_5, var_3, var_4);
}

function northeast_carcrash() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getnodearray("right_car_crash1", "targetname");
  var_1 = getEnt("right_crash_placed_clip", "targetname");
  var_1 connectpaths();
  var_1 notsolid();

  foreach(var_3 in var_0) {
    var_3 disconnectnode();
  }

  var_5 = scripts\engine\utility::getStruct("northeast_street_animnode", "targetname");
  var_6 = getscriptablearray("right_car4", "targetname")[0];
  var_6.animname = "right_car4";
  var_6 scripts\engine\sp\utility::assign_animtree();
  var_6.scriptcoll = get_script_car_collision("right_car4");
  var_6.scriptcoll linkTo(var_6, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_6.scriptcoll.trigger triggerdisable();
  var_6.shell = scripts\engine\sp\utility::spawn_anim_model("right_car4_shell", var_6.origin, var_6.angles);
  var_6.shell linkTo(var_6, "tag_body_animate", (0, 0, 0), (0, 0, 0));
  thread delete_shell();
  thread swap_shell();
  var_7 = getstartorigin(var_5.origin, var_5.angles, var_6 scripts\engine\utility::getanim("right_car_crash1"));
  var_8 = getstartangles(var_5.origin, var_5.angles, var_6 scripts\engine\utility::getanim("right_car_crash1"));
  var_6.origin = var_7;
  var_6.angles = var_8;
  waitframe();
  var_6.scriptcoll.collision disconnectPaths();
  scripts\engine\utility::flag_wait("right_car_crash");
  scripts\engine\sp\utility::autosave_by_name("right_crash");
  var_9 = (350.5, -1051, 132.5);
  var_10 = createnavbadplacebybounds(var_9, (90, 600, 32), (0, 56, 0));
  scripts\engine\utility::noself_delaycall(4.5, &destroynavobstacle, var_10);
  var_1 scripts\engine\utility::delaycall(3.8, &solid);
  var_1 scripts\engine\utility::delaycall(4, &connectpaths);
  var_11 = [];

  for(var_12 = 0; var_12 < 3; var_12++) {
    var_13 = "right_car" + var_12 + 1;
    var_14 = getscriptablearray(var_13, "targetname")[0];
    var_14.animname = var_13;
    var_14 scripts\engine\sp\utility::assign_animtree();
    var_14.shell = scripts\engine\sp\utility::spawn_anim_model(var_13 + "_shell", var_14.origin, var_14.angles);
    var_14.shell linkTo(var_14, "tag_body_animate", (0, 0, 0), (0, 0, 0));
    thread delete_shell();
    thread swap_shell();
    var_11 = scripts\engine\utility::array_add(var_11, var_14);
    var_14.scriptcoll = get_script_car_collision(var_13);
    var_14.scriptcoll linkTo(var_14, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_7 = getstartorigin(var_5.origin, var_5.angles, var_14 scripts\engine\utility::getanim("right_car_crash1"));
    var_8 = getstartangles(var_5.origin, var_5.angles, var_14 scripts\engine\utility::getanim("right_car_crash1"));
    var_14.origin = var_7;
    var_14.angles = var_8;
    var_14.script_noteworthy = "";
  }

  waitframe();
  var_11 = scripts\engine\utility::array_add(var_11, var_6);

  foreach(var_14 in var_11) {
    var_16 = getanimlength(var_14 scripts\engine\utility::getanim("right_car_crash1"));

    if(var_14.animname != "right_car4") {
      thread spawn_my_crash_driver(var_14, var_16);
    }

    var_17 = scripts\engine\utility::ter_op(var_14.animname == "right_car1", var_16 - 1, var_16);
    var_14.scriptcoll.trigger scripts\engine\utility::delaycall(var_17, &delete);
    var_14.scriptcoll.collision scripts\engine\utility::delaycall(var_16, &disconnectpaths);
    thread scripts\common\notetrack::start_notetrack_wait(var_14, "single anim", "right_car_crash1", var_14.animname, var_14 scripts\engine\utility::getanim("right_car_crash1"));
    thread scripts\sp\anim::animscriptdonotetracksthread(var_14, "single anim", "right_car_crash1");
    var_14 setflaggedanimknoball("single anim", var_14 scripts\engine\utility::getanim("right_car_crash1"), %root, 1, 0);

    if(isDefined(var_14.shell)) {
      thread scripts\common\notetrack::start_notetrack_wait(var_14.shell, "right_car_crash1_notes", "right_car_crash1", var_14.shell.animname, var_14.shell scripts\engine\utility::getanim("right_car_crash1"));
      thread scripts\sp\anim::animscriptdonotetracksthread(var_14.shell, "right_car_crash1_notes", "right_car_crash1");
      var_14.shell setflaggedanim("right_car_crash1_notes", var_14.shell scripts\engine\utility::getanim("right_car_crash1"), 1);
    }
  }

  wait 5;

  foreach(var_3 in var_0) {
    var_3 connectnode();
  }
}

function spawn_my_crash_driver(var_0, var_1) {
  if(self.animname == "left_crash_car2") {
    var_2 = scripts\engine\utility::random(getspawnerarray("obj_frontline"));
    var_3 = var_2 spawndrone();
    var_3 scripts\sp\utility::enable_procedural_bones();
    var_3.spawner = var_2;
    var_2.count++;
  } else {
    var_3 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("female", 1, 1);
  }

  self.driver = var_3;
  self.driver endon("stop_driving");
  self.drivernode = scripts\engine\utility::spawn_tag_origin();

  if(self.animname == "right_car2") {
    self.drivernode linkTo(self, "tag_origin", (-19, 0, 0), (0, 0, 0));
  } else if(self.animname == "right_car3") {
    self.drivernode linkTo(self, "tag_origin", (-19, 0, 7), (0, 0, 0));
  } else {
    self.drivernode linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  if(istrue(var_3)) {
    var_3.animname = "male_rf";
  } else {
    var_3.animname = "male_lf";
  }

  var_3 linkTo(self.drivernode, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(isai(var_3)) {
    var_3 visiblenotsolid();
  } else {
    var_3 notsolid();
  }

  self.drivernode thread scripts\common\anim::anim_loop_solo(var_3, "victor40_idle", "stop_driving_" + var_3 getentitynumber());
  wait var_1 - 1;
  self.drivernode notify("stop_driving_" + var_3 getentitynumber());
  self.drivernode scripts\common\anim::anim_single_solo(var_3, "victor40_death");
  self.drivernode delete();
}

function nt_test() {
  for(;;) {
    self waittill("single anim", var_0);
    iprintlnbold(self.animname + " " + var_0[0]);
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
  var_0 = ["_rf"];

  foreach(var_2 in var_0) {
    var_3 = scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1);

    if(isDefined(var_3)) {
      var_4 = var_3.script_namenumber == "male";

      if(var_4) {
        var_5 = "male";
      } else {
        var_5 = "female";
        self.origin += anglesToForward(self.angles) * 7;
        self.origin += (0, 0, 6);
      }

      var_6 = var_5 + var_3;
      var_7.animname = var_6;
      var_7 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
      thread scripts\common\anim::anim_loop_solo(var_7, "idle");
      self.passenger = var_7;
      thread animated_passanger_logic();
    }
  }

  var_2 = undefined;
  var_4 = undefined;
}

function underground_rescue_right() {
  var_0 = getEnt("underground_rescue2_gate", "targetname");
  var_0 moveTo(var_0.origin + (0, 0, 64), 0.05);
  var_1 = scripts\engine\utility::flag_wait_any_return("underground_rescue_start_first_frame", "spec_price_intro_start");

  if(var_1 != "underground_rescue_start_first_frame") {
    return;
  }

  var_2 = scripts\engine\utility::getStruct("underground_rescue2_animnode", "targetname");
  var_3 = getspawner("police_rescue_spawner", "targetname");
  var_3.count = 1;
  var_4 = scripts\engine\sp\utility::spawn_targetname("police_rescue_spawner", 1);
  var_4.animname = "subway_right_rescue_p";
  var_4.allowdeath = 0;
  var_4.ignoreme = 1;
  var_4.ignoreall = 1;
  var_4 thread scripts\common\ai::magic_bullet_shield();
  var_4 hide();
  var_5 = [];
  GscBinSkip0(0x2e, var_5.size, var_4);
}

function vo_underground_rescue_right(var_0) {
  thread vo_underground_right_walla();
  var_0[0] scripts\engine\utility::delaythread(0.6, &scripts\sp\maps\piccadilly\piccadilly_util::say, "dx_vom_ucm3_right_underground_rescue_30");
  var_0[1] scripts\engine\utility::delaythread(0.2, &scripts\sp\maps\piccadilly\piccadilly_util::say, "dx_vom_ucm4_right_underground_rescue_40");
  wait 2;
  var_1 = self;
  var_1 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk56_right_underground_rescue_10", 1);
  var_1 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk56_right_underground_rescue_20", 0);
  scripts\engine\utility::flag_wait("tflag_left_underground_exit");
  var_1 scripts\sp\maps\piccadilly\piccadilly_util::say_as_chatter("dx_vom_uk56_right_underground_rescue_50", 1);
}

function vo_underground_right_walla() {
  wait 0.1;
  var_0 = spawn("script_origin", (751, -1485, -40));
  var_0 playSound("scn_piccadilly_subway_walla");
  var_0 moveTo((1413, -1815, -50), 5);
  wait 9.5;
  var_0 delete();
}

function subway_right_escape_magic_bullets(var_0) {
  var_1 = getspawnerarray("subway_right_wave2");
  wait 2;

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }

    thread scripts\sp\maps\piccadilly\piccadilly_combat::magicbullet_burst(scripts\engine\utility::random(var_1).origin + (0, 0, 70), var_3 getEye());
    wait 0.55;

    if(!isalive(var_3)) {
      continue;
    }

    var_3 thread scripts\engine\sp\utility::play_sound_on_entity("generic_death_falling");
  }
}

function stop_anim_on_dmg() {
  self waittill("damage");
  scripts\engine\sp\utility::anim_stopanimScripted();
}

function init_script_car_collision() {
  level.script_car_collision = [];
  var_0 = getEntArray("script_car_coll", "script_noteworthy");

  foreach(var_2 in var_0) {
    level.script_car_collision = scripts\engine\utility::array_add(level.script_car_collision, var_2);
    var_3 = var_2 scripts\engine\utility::get_linked_ents();

    foreach(var_5 in var_3) {
      switch (var_5.classname) {
        case "trigger_multiple":
          if(scripts\engine\utility::is_equal(var_2.script_parameters, "no_damage")) {
            var_5 delete();
            break;
          }

          var_5 enablelinkTo();
          var_2.trigger = var_5;
          thread car_coll_trig_logic(var_5);
          var_5 linkTo(var_2);
          break;
        case "script_brushmodel":
          var_2.collision = var_5;
          var_5 linkTo(var_2);
          break;
        default:
          break;
      }
    }
  }
}

function get_script_car_collision(var_0) {
  foreach(var_2 in level.script_car_collision) {
    if(scripts\engine\utility::is_equal(var_2.targetname, var_0)) {
      return var_2;
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

function car_coll_trig_logic(var_0) {
  self endon("death");
  self.victims = [];

  for(;;) {
    self waittill("trigger", var_1);

    if(isDefined(var_1) && !scripts\engine\utility::array_contains(self.victims, var_1)) {
      if(isPlayer(var_1)) {
        self.victims[self.victims.size] = var_1;
        var_2 = vectorNormalize((0, var_0.angles[1], 45));
        var_1 pushplayervector(var_2 * 12, 1);
        var_1 scripts\sp\utility::do_damage(var_1.health * 0.5, var_1.origin);
        var_1 scripts\engine\utility::delaycall(0.25, &kill, var_1.origin);
        continue;
      }

      if(isai(var_1)) {
        if(isDefined(var_1.magic_bullet_shield)) {
          continue;
        }

        self.victims[self.victims.size] = var_1;
        thread scripts\engine\utility::play_sound_in_space("generic_death_falling", self.origin);
        var_1 scripts\engine\sp\utility::ai_ragdoll_immediate();
      }
    }
  }
}

function car_trig_debug() {
  for(;;) {
    waitframe();
  }
}
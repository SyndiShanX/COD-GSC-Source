/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: engine\sp\utility.gsc
***********************************************/

get_tag_list(var_0) {
  var_1 = [];
  var_2 = getnumparts(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++)
    var_1[var_1.size] = getpartname(var_0, var_3);

  return var_1;
}

get_all_closest_living(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_1.size < 1)
    return var_4;

  if(!isDefined(var_3))
    var_3 = 0;

  var_2 = squared(var_2);

  foreach(var_6 in var_1) {
    if(!isalive(var_6) || !isDefined(var_6) || !var_3 && isDefined(var_6.a.doinglongdeath)) {
      continue;
    }
    if(distancesquared(var_6.origin, var_0) <= var_2)
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

mph_travel_time(var_0, var_1) {
  var_0 = var_0 * 17.6;
  var_2 = var_1 / var_0;
  return var_2;
}

set_hudoutline(var_0, var_1, var_2) {
  var_3 = undefined;
  var_0 = tolower(var_0);
  var_4["friendly"] = "outline_nodepth_cyan";
  var_4["enemy"] = "outline_nodepth_red";
  var_4["objective"] = "outline_nodepth_orange";
  var_4["neutral"] = "outline_nodepth_white";
  var_3 = var_4[var_0];
  hudoutline_enable_new(var_4[var_0]);
}

convert_to_time_string(var_0, var_1) {
  var_2 = "";

  if(var_0 < 0)
    var_2 = var_2 + "-";

  var_0 = scripts\engine\math::round_float(var_0, 1, 0);
  var_3 = var_0 * 100;
  var_3 = int(var_3);
  var_3 = abs(var_3);
  var_4 = var_3 / 6000;
  var_4 = int(var_4);
  var_2 = var_2 + var_4;
  var_5 = var_3 / 100;
  var_5 = int(var_5);
  var_5 = var_5 - var_4 * 60;

  if(var_5 < 10)
    var_2 = var_2 + (":0" + var_5);
  else
    var_2 = var_2 + (":" + var_5);

  if(isDefined(var_1) && var_1) {
    var_6 = var_3;
    var_6 = var_6 - var_4 * 6000;
    var_6 = var_6 - var_5 * 100;
    var_6 = int(var_6 / 10);
    var_2 = var_2 + ("." + var_6);
  }

  return var_2;
}

sun_light_fade(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for(var_4 = 0; var_4 < 4; var_4++)
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;

  var_5 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    wait 0.05;

    for(var_6 = 0; var_6 < 4; var_6++)
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;

    setsuncolorandintensity(var_5[0], var_5[1], var_5[2], var_5[3]);
  }

  setsuncolorandintensity(var_1[0], var_1[1], var_1[2], var_1[3]);
}

get_closest_to_player_view(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = level.player;

  if(!isDefined(var_3))
    var_3 = -1;

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_4 = var_1 getEye();

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = -1;

  foreach(var_10 in var_0) {
    var_11 = vectortoangles(var_10.origin - var_4);
    var_12 = anglesToForward(var_11);
    var_13 = vectordot(var_7, var_12);

    if(var_13 < var_8) {
      continue;
    }
    if(var_13 < var_3) {
      continue;
    }
    var_8 = var_13;
    var_5 = var_10;
  }

  return var_5;
}

get_closest_index_to_player_view(var_0, var_1, var_2) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = level.player;

  var_3 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_3 = var_1 getEye();

  var_4 = undefined;
  var_5 = var_1 getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = -1;

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_9 = vectortoangles(var_0[var_8].origin - var_3);
    var_10 = anglesToForward(var_9);
    var_11 = vectordot(var_6, var_10);

    if(var_11 < var_7) {
      continue;
    }
    var_7 = var_11;
    var_4 = var_8;
  }

  return var_4;
}

flag_trigger_init(var_0, var_1, var_2) {
  scripts\engine\utility::flag_init(var_0);

  if(!isDefined(var_2))
    var_2 = 0;

  var_1 thread scripts\engine\sp\utility_code::_flag_wait_trigger(var_0, var_2);
  return var_1;
}

flag_triggers_init(var_0, var_1, var_2) {
  scripts\engine\utility::flag_init(var_0);

  if(!isDefined(var_2))
    var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_1[var_3] thread scripts\engine\sp\utility_code::_flag_wait_trigger(var_0, 0);

  return var_1;
}

flag_clear_delayed(var_0, var_1) {
  wait(var_1);
  scripts\engine\utility::flag_clear(var_0);
}

flag_clear_delayed_endonset(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
  scripts\engine\utility::flag_clear(var_0);
}

level_end_save() {
  if(level.missionfailed) {
    return;
  }
  if(scripts\sp\utility::is_trials_level())
    return 0;

  if(scripts\engine\utility::flag("game_saving")) {
    return;
  }
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!isalive(var_1))
      return;
  }

  scripts\engine\utility::flag_set("game_saving");
  var_2 = "levelshots / autosave / autosave_" + level.script + "end";
  savegame("levelend", &"AUTOSAVE_AUTOSAVE", var_2, 1);
  scripts\engine\utility::flag_clear("game_saving");
}

add_extra_autosave_check(var_0, var_1, var_2) {
  level.autosave.extra_autosave_checks[var_0] = [];
  level.autosave.extra_autosave_checks[var_0]["func"] = var_1;
  level.autosave.extra_autosave_checks[var_0]["msg"] = var_2;
}

remove_extra_autosave_check(var_0) {
  level.autosave.extra_autosave_checks[var_0] = undefined;
}

autosave_stealth() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1);
}

autosave_stealth_silent() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1, 1);
}

autosave_tactical() {
  scripts\engine\sp\utility_code::autosave_tactical_setup();
  thread scripts\engine\sp\utility_code::autosave_tactical_proc();
}

autosave_by_name(var_0) {
  thread autosave_by_name_thread(var_0);
}

autosave_by_name_silent(var_0) {
  thread autosave_by_name_thread(var_0, undefined, undefined, 1);
}

autosave_by_name_thread(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.curautosave))
    level.curautosave = 1;

  var_5 = "levelshots/autosave/autosave_" + level.script + level.curautosave;
  var_6 = level scripts\sp\autosave::tryautosave(level.curautosave, "autosave", var_5, var_1, var_2, var_3, var_4);

  if(isDefined(var_6) && var_6)
    level.curautosave++;
}

autosave_or_timeout(var_0, var_1) {
  thread autosave_by_name_thread(var_0, var_1);
}

autosave_try_once(var_0, var_1) {
  thread autosave_by_name_thread(var_0, undefined, undefined, var_1, 1);
}

autosave_or_timeout_silent(var_0, var_1) {
  thread autosave_by_name_thread(var_0, var_1, undefined, 1);
}

debug_message(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 5;

  if(isDefined(var_3)) {
    var_3 endon("death");
    var_1 = var_3.origin;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    if(!isDefined(var_3)) {} else {}

    wait 0.05;
  }
}

debug_message_clear(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level notify(var_0 + var_3);
    level endon(var_0 + var_3);
  } else {
    level notify(var_0);
    level endon(var_0);
  }

  if(!isDefined(var_2))
    var_2 = 5;

  for(var_4 = 0; var_4 < var_2 * 20; var_4++)
    wait 0.05;
}

closerfunc(var_0, var_1) {
  return var_0 >= var_1;
}

getclosestfx(var_0, var_1, var_2) {
  return scripts\engine\sp\utility_code::comparesizesfx(var_0, var_1, var_2, ::closerfunc);
}

get_farthest_ent(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = distance(var_1[0] getorigin(), var_0);
  var_3 = var_1[0];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 < var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

get_within_range(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

get_outside_range(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) > var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

get_closest_living(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 9999999;

  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!isalive(var_1[var_4])) {
      continue;
    }
    var_5 = distance(var_1[var_4].origin, var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

get_highest_dot(var_0, var_1, var_2) {
  if(!var_2.size) {
    return;
  }
  var_3 = undefined;
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = anglesToForward(var_4);
  var_6 = -1;

  foreach(var_8 in var_2) {
    var_4 = vectortoangles(var_8.origin - var_0);
    var_9 = anglesToForward(var_4);
    var_10 = vectordot(var_5, var_9);

    if(var_10 < var_6) {
      continue;
    }
    var_6 = var_10;
    var_3 = var_8;
  }

  return var_3;
}

get_closest_index(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 9999999;

  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  foreach(var_7, var_5 in var_1) {
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_7;
  }

  return var_3;
}

get_closest_exclude(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return undefined;

  var_3 = 0;

  if(isDefined(var_2) && var_2.size) {
    var_4 = [];

    for(var_5 = 0; var_5 < var_1.size; var_5++)
      var_4[var_5] = 0;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_1[var_5] == var_2[var_6])
          var_4[var_5] = 1;
      }
    }

    var_7 = 0;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(!var_4[var_5] && isDefined(var_1[var_5])) {
        var_7 = 1;
        var_3 = distance(var_0, var_1[var_5].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }

    if(!var_7)
      return undefined;
  } else {
    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(isDefined(var_1[var_5])) {
        var_3 = distance(var_0, var_1[0].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }
  }

  var_8 = undefined;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(isDefined(var_1[var_5])) {
      var_4 = 0;

      if(isDefined(var_2)) {
        for(var_6 = 0; var_6 < var_2.size; var_6++) {
          if(var_1[var_5] == var_2[var_6])
            var_4 = 1;
        }
      }

      if(!var_4) {
        var_9 = distance(var_0, var_1[var_5].origin);

        if(var_9 <= var_3) {
          var_3 = var_9;
          var_8 = var_5;
        }
      }
    }
  }

  if(isDefined(var_8))
    return var_1[var_8];
  else
    return undefined;
}

get_closest_ai(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = getaiarray(var_1);
  else
    var_3 = getaiarray();

  if(var_3.size == 0)
    return undefined;

  if(isDefined(var_2))
    var_3 = scripts\engine\utility::array_remove_array(var_3, var_2);

  return scripts\engine\utility::getclosest(var_0, var_3);
}

get_closest_ai_exclude(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = getaiarray(var_1);
  else
    var_3 = getaiarray();

  if(var_3.size == 0)
    return undefined;

  return get_closest_exclude(var_0, var_3, var_2);
}

get_progress(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = distance(var_0, var_1);

  var_3 = max(0.01, var_3);
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = var_2 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_3;
  var_6 = clamp(var_6, 0, 1);
  return var_6;
}

disable_long_death() {
  self.a.disablelongdeath = 1;
}

enable_long_death() {
  self.a.disablelongdeath = 0;
}

enable_blood_pool() {
  self.skipbloodpool = undefined;
  self setragdollnobloodpoolfx(0);
}

disable_blood_pool() {
  self.skipbloodpool = 1;
  self setragdollnobloodpoolfx(1);
}

deletable_magic_bullet_shield() {
  scripts\common\ai::magic_bullet_shield(1);
}

get_ignoreme() {
  return self.ignoreme;
}

set_ignoreme(var_0) {
  self.ignoreme = var_0;
}

set_ignoreall(var_0) {
  self.ignoreall = var_0;
}

set_favoriteenemy(var_0) {
  self.favoriteenemy = var_0;
}

get_pacifist() {
  return self.pacifist;
}

set_pacifist(var_0) {
  self.pacifist = var_0;
}

set_maxsightdistsquared(var_0) {
  self.maxsightdistsqrd = var_0;
}

set_maxvisibledist(var_0) {
  self.maxvisibledist = var_0;
}

set_maxfaceenemydist(var_0) {
  self.maxfaceenemydist = var_0;
}

set_sprint(var_0) {
  self.sprint = var_0;
}

flood_spawn(var_0) {
  scripts\sp\spawner::flood_spawner_scripted(var_0);
}

force_crawling_death(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 4;

  thread force_crawling_death_proc(var_0, var_1, var_2, var_3);
}

override_crawl_death_anims() {
  if(isDefined(self.a.custom_crawling_death_array)) {
    self.a.array["crawl"] = self.a.custom_crawling_death_array["crawl"];
    self.a.array["death"] = self.a.custom_crawling_death_array["death"];
    self.a.crawl_fx_rate = self.a.custom_crawling_death_array["blood_fx_rate"];

    if(isDefined(self.a.custom_crawling_death_array["blood_fx"]))
      self.a.crawl_fx = self.a.custom_crawling_death_array["blood_fx"];
  }

  self.a.array["stand_2_crawl"] = [];

  if(isDefined(self.nofallanim))
    self.currentpose = "prone";

  self orientmode("face angle", self.a.force_crawl_angle);
  self.a.force_crawl_angle = undefined;
}

force_crawling_death_proc(var_0, var_1, var_2, var_3) {
  self.forcelongdeath = 1;
  self.a.force_num_crawls = var_1;
  self.noragdoll = 1;
  self.nofallanim = var_3;
  self.a.custom_crawling_death_array = var_2;
  self.crawlingpainanimoverridefunc = ::override_crawl_death_anims;
  self.maxhealth = 100000;
  self.health = 100000;
  enable_long_death();

  if(!isDefined(var_3) || var_3 == 0)
    self.a.force_crawl_angle = var_0 + 181.02;
  else {
    self.a.force_crawl_angle = var_0;
    thread scripts\anim\notetracks_sp.gsc::notetrackposecrawl();
  }
}

ai_ragdoll_immediate() {
  self.skipdeathanim = 1;
  die();
}

playerwatch_unresolved_collision(var_0) {
  self endon("death");
  self endon("stop_unresolved_collision_script");

  if(!isDefined(var_0))
    var_0 = 20;

  self.unresolved_collision_count = 0;

  for(;;) {
    self waittill("unresolved_collision", var_1);
    self.last_unresolved_collision_time = gettime();

    if(isDefined(var_1) && (istrue(var_1.doorclip) || istrue(var_1.allowunresolvedcollision))) {
      continue;
    }
    childthread resetunresolvedcollision();
    self.unresolved_collision_count++;

    if(self.unresolved_collision_count >= var_0) {
      if(isDefined(var_1) && isDefined(var_1.unresolved_collision_func))
        var_1[[var_1.unresolved_collision_func]](self);

      if(isDefined(self.handle_unresolved_collision)) {
        self[[self.handle_unresolved_collision]]();
        continue;
      }

      default_unresolved_collision_handler();
    }
  }
}

resetunresolvedcollision() {
  self notify("newUnresolvedCollision");
  self endon("newUnresolvedCollision");
  wait 0.05;
  waittillframeend;
  self.unresolved_collision_count = 0;
}

default_unresolved_collision_handler() {
  level.custom_death_quote = 438;
  scripts\sp\utility::missionfailedwrapper();
}

stop_playerwatch_unresolved_collision() {
  self notify("stop_unresolved_collision_script");
}

play_sound_on_tag_endon_death(var_0, var_1) {
  play_sound_on_tag(var_0, var_1, 1);
}

play_loop_sound_on_entity_with_pitch(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", (0, 0, 0));
  var_4 endon("death");
  thread scripts\engine\utility::delete_on_death(var_4);

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(isDefined(var_1))
    var_4.origin = self.origin + var_1;
  else
    var_4.origin = self.origin;

  var_4.angles = self.angles;
  var_4 linkTo(self);
  var_4 playLoopSound(var_0);
  var_4 scalepitch(var_2, var_3);
  self waittill("stop sound" + var_0);
  var_4 stoploopsound(var_0);
  var_4 delete();
}

play_sound_on_entity(var_0, var_1) {
  play_sound_on_tag(var_0, undefined, undefined, var_1);
}

play_loop_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    thread scripts\engine\utility::delete_on_death(var_5);

  if(!isDefined(var_3))
    var_3 = 0;

  if(var_3)
    thread delete_on_removed(var_5);

  if(isDefined(var_1))
    var_5 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 linkTo(self);
  }

  var_5 playLoopSound(var_0);
  self waittill("stop sound" + var_0);

  if(isDefined(var_4)) {
    var_5 playSound(var_4, "sounddone");
    var_5 scripts\engine\utility::delaycall(0.15, ::stoploopsound, var_0);
    var_5 waittill("sounddone");
    var_5 delete();
  } else {
    var_5 stoploopsound(var_0);
    var_5 delete();
  }
}

delete_on_removed(var_0) {
  var_0 endon("death");

  while(isDefined(self))
    wait 0.05;

  if(isDefined(var_0))
    var_0 delete();
}

assign_animtree(var_0) {
  if(isDefined(var_0))
    self.animname = var_0;

  self useanimtree(level.scr_animtree[self.animname]);
}

assign_model() {
  if(isarray(level.scr_model[self.animname])) {
    var_0 = randomint(level.scr_model[self.animname].size);
    self setModel(level.scr_model[self.animname][var_0]);
  } else
    self setModel(level.scr_model[self.animname]);
}

spawn_anim_model(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = spawn("script_model", var_1);
  var_3.animname = var_0;
  var_3 assign_animtree();
  var_3 assign_model();

  if(isDefined(var_2))
    var_3.angles = var_2;

  return var_3;
}

spawn_anim_weapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = spawn("script_model", var_1);
  var_4.animname = var_0;
  var_4 assign_animtree();
  var_5 = [];

  if(isDefined(level.scr_weapon[var_0][1]))
    var_5 = level.scr_weapon[var_0][1];

  var_4 scripts\common\utility::make_weapon_model(level.scr_weapon[var_0][0], var_5, var_3);

  if(isDefined(var_2))
    var_4.angles = var_2;

  return var_4;
}

trigger_wait(var_0, var_1) {
  var_2 = getEnt(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 waittill("trigger", var_3);
  level notify(var_0, var_3);
  return var_3;
}

trigger_wait_targetname(var_0) {
  return trigger_wait(var_0, "targetname");
}

set_flag_on_dead(var_0, var_1) {
  thread set_flag_on_func_wait_proc(var_0, var_1, ::waittill_dead, "set_flag_on_dead");
}

set_flag_on_dead_or_dying(var_0, var_1) {
  thread set_flag_on_func_wait_proc(var_0, var_1, ::waittill_dead_or_dying, "set_flag_on_dead_or_dying");
}

empty_func(var_0) {
  return;
}

set_flag_on_spawned_ai_proc(var_0, var_1) {
  self waittill("spawned", var_2);

  if(scripts\common\ai::spawn_failed(var_2)) {
    return;
  }
  var_0.ai[var_0.ai.size] = var_2;
  scripts\engine\utility::ent_flag_set(var_1);
}

set_flag_on_func_wait_proc(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.ai = [];

  foreach(var_7, var_6 in var_0)
  var_6 scripts\engine\utility::ent_flag_init(var_3);

  scripts\engine\utility::array_thread(var_0, ::set_flag_on_spawned_ai_proc, var_4, var_3);

  foreach(var_7, var_6 in var_0)
  var_6 scripts\engine\utility::ent_flag_wait(var_3);

  [[var_2]](var_4.ai);
  scripts\engine\utility::flag_set(var_1);
}

set_flag_on_trigger(var_0, var_1) {
  if(!scripts\engine\utility::flag(var_1)) {
    var_0 waittill("trigger", var_2);
    scripts\engine\utility::flag_set(var_1);
    return var_2;
  }
}

set_flag_on_targetname_trigger(var_0) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }
  var_1 = getEnt(var_0, "targetname");
  var_1 waittill("trigger");
  scripts\engine\utility::flag_set(var_0);
}

waittill_dead(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread scripts\engine\sp\utility_code::waittill_dead_timeout(var_2);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count)
    var_10.count = var_1;

  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility_code::waittill_dead_thread, var_10);

  while(var_10.count > 0)
    var_10 waittill("waittill_dead guy died");
}

waittill_dead_or_dying(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5.ignoreforfixednodesafecheck)
      var_3[var_3.size] = var_5;
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread scripts\engine\sp\utility_code::waittill_dead_timeout(var_2);
  }

  var_7.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_7.count)
    var_7.count = var_1;

  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility_code::waittill_dead_or_dying_thread, var_7);

  while(var_7.count > 0)
    var_7 waittill("waittill_dead_guy_dead_or_dying");
}

waittill_notetrack_or_damage(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

get_living_ai(var_0, var_1) {
  var_2 = get_living_ai_array(var_0, var_1);

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

get_living_ai_array(var_0, var_1) {
  var_2 = getaispeciesarray("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "targetname":
        if(isDefined(var_5.targetname) && var_5.targetname == var_0)
          var_3[var_3.size] = var_5;

        break;
      case "script_noteworthy":
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0)
          var_3[var_3.size] = var_5;

        break;
      case "animname":
        if(isDefined(var_5.animname) && var_5.animname == var_0)
          var_3[var_3.size] = var_5;

        break;
    }
  }

  return var_3;
}

get_vehicle(var_0, var_1) {
  var_2 = get_vehicle_array(var_0, var_1);

  if(!var_2.size)
    return undefined;

  return var_2[0];
}

get_vehicle_array(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6.code_classname != "script_vehicle") {
      continue;
    }
    var_4[0] = var_6;

    if(isspawner(var_6)) {
      if(isDefined(var_6.last_spawned_vehicle)) {
        var_4[0] = var_6.last_spawned_vehicle;
        var_3 = array_merge(var_3, var_4);
      }

      continue;
    }

    var_3 = array_merge(var_3, var_4);
  }

  return var_3;
}

get_living_aispecies(var_0, var_1, var_2) {
  var_3 = get_living_aispecies_array(var_0, var_1, var_2);

  if(var_3.size > 1)
    return undefined;

  return var_3[0];
}

get_living_aispecies_array(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = "all";

  var_3 = getaispeciesarray("allies", var_2);
  var_3 = scripts\engine\utility::array_combine(var_3, getaispeciesarray("axis", var_2));
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_1) {
      case "targetname":
        if(isDefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
      case "script_noteworthy":
        if(isDefined(var_3[var_5].script_noteworthy) && var_3[var_5].script_noteworthy == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
    }
  }

  return var_4;
}

gather_delay_proc(var_0, var_1) {
  if(isDefined(level.gather_delay[var_0])) {
    if(level.gather_delay[var_0]) {
      wait 0.05;

      if(isalive(self))
        self notify("gather_delay_finished" + var_0 + var_1);

      return;
    }

    level waittill(var_0);

    if(isalive(self))
      self notify("gather_delay_finished" + var_0 + var_1);

    return;
  }

  level.gather_delay[var_0] = 0;
  wait(var_1);
  level.gather_delay[var_0] = 1;
  level notify(var_0);

  if(isalive(self))
    self notify("gather_delay_finished" + var_0 + var_1);
}

gather_delay(var_0, var_1) {
  thread gather_delay_proc(var_0, var_1);
  self waittill("gather_delay_finished" + var_0 + var_1);
}

getlinks_array(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_4.script_linkname;

    if(!isDefined(var_5)) {
      continue;
    }
    if(!isDefined(var_1[var_5])) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_merge(var_0, var_1) {
  if(var_0.size == 0)
    return var_1;

  if(var_1.size == 0)
    return var_0;

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5)
      continue;
    else
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_exclude(var_0, var_1) {
  var_2 = var_0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(scripts\engine\utility::array_contains(var_0, var_1[var_3]))
      var_2 = scripts\engine\utility::array_remove(var_2, var_1[var_3]);
  }

  return var_2;
}

array_compare(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(var_4 != var_3)
      return 0;
  }

  return 1;
}

create_deck(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = [];
  else if(!isarray(var_0))
    var_0 = [var_0];

  var_3 = spawnStruct();
  var_3.items = [];
  var_3.index = 0;
  var_3.autoshuffle = !isDefined(var_1) || var_1;
  var_3.prevent_redraw = !isDefined(var_2) || var_2;

  foreach(var_5 in var_0)
  var_3.items[var_3.items.size] = var_5;

  if(var_3.autoshuffle)
    var_3 deck_shuffle();

  return var_3;
}

deck_draw() {
  var_0 = self;

  if(var_0.items.size == 0)
    return undefined;

  var_0 refill_if_empty();
  var_0.last_drawn = var_0.items[var_0.index];
  var_0.index++;
  return var_0.last_drawn;
}

deck_draw_specific(var_0, var_1) {
  var_2 = self;

  if(var_2.items.size == 0)
    return undefined;

  var_2 refill_if_empty();

  foreach(var_5, var_4 in var_2.items) {
    if(var_4 != var_0 || !istrue(var_1) && var_5 < var_2.index) {
      continue;
    }
    var_2.last_drawn = var_2.items[var_5];

    if(var_2.autoshuffle) {
      var_2.items[var_5] = var_2.items[var_2.index];
      var_2.items[var_2.index] = var_2.last_drawn;
      var_2.index++;
    } else
      var_2.index = var_5 + 1;

    return var_2.last_drawn;
  }
}

deck_shuffle() {
  var_0 = self;
  var_0.index = 0;
  var_0.items = scripts\engine\utility::array_randomize(var_0.items);

  if(!var_0.prevent_redraw || !isDefined(var_0.last_drawn) || var_0.items.size <= 1) {
    return;
  }
  if(var_0.items[0] == var_0.last_drawn) {
    var_1 = randomintrange(1, var_0.items.size);
    var_2 = var_0.items[0];
    var_0.items[0] = var_0.items[var_1];
    var_0.items[var_1] = var_2;
  }
}

refill_if_empty() {
  var_0 = self;

  if(var_0 deck_is_empty()) {
    if(var_0.autoshuffle)
      var_0 deck_shuffle();
    else
      var_0.index = 0;
  }
}

deck_is_empty() {
  return self.index >= self.items.size;
}

is_deck(var_0) {
  return isDefined(var_0) && isstruct(var_0) && isDefined(var_0.items) && isDefined(var_0.index);
}

getlinkedvehiclenodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");
      var_0 = scripts\engine\utility::array_combine(var_0, var_4);
    }
  }

  return var_0;
}

draw_line(var_0, var_1, var_2, var_3, var_4) {
  for(;;)
    wait 0.05;
}

draw_line_to_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_1.origin))
      return;
  }
}

draw_line_from_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  draw_line_to_ent_for_time(var_1, var_0, var_2, var_3, var_4, var_5);
}

draw_line_from_ent_to_ent_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5)
    wait 0.05;
}

draw_line_from_ent_to_ent_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for(;;)
    wait 0.05;
}

draw_line_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);

  for(;;)
    scripts\engine\utility::draw_line_for_time(var_0, var_1, var_2, var_3, var_4, 0.05);
}

draw_line_from_ent_to_vec_for_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while(gettime() < var_6) {
    wait 0.05;

    if(!isDefined(var_0) || !isDefined(var_0.origin))
      return;
  }
}

draw_circle_until_notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 16;
  var_8 = 360 / var_7;
  var_9 = [];

  for(var_10 = 0; var_10 < var_7; var_10++) {
    var_11 = var_8 * var_10;
    var_12 = cos(var_11) * var_1;
    var_13 = sin(var_11) * var_1;
    var_14 = var_0[0] + var_12;
    var_15 = var_0[1] + var_13;
    var_16 = var_0[2];
    var_9[var_9.size] = (var_14, var_15, var_16);
  }

  thread draw_circle_lines_until_notify(var_9, var_2, var_3, var_4, var_5, var_6);
}

draw_circle_lines_until_notify(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_6 + 1 >= var_0.size)
      var_8 = var_0[0];
    else
      var_8 = var_0[var_6 + 1];

    thread draw_line_until_notify(var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

battlechatter_off(var_0) {
  level notify("battlechatter_off_thread");
  scripts\anim\battlechatter.gsc::bcs_setup_chatter_toggle_array();

  if(isDefined(var_0)) {
    set_battlechatter_variable(var_0, 0);
    var_1 = getaiarray(var_0);
  } else {
    foreach(var_0 in anim.teams)
    set_battlechatter_variable(var_0, 0);

    var_1 = getaiarray();
  }

  if(!isDefined(anim.chatinitialized) || !anim.chatinitialized) {
    return;
  }
  for(var_4 = 0; var_4 < var_1.size; var_4++)
    var_1[var_4].battlechatterallowed = 0;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];

    if(!isalive(var_5)) {
      continue;
    }
    if(!var_5.chatinitialized) {
      continue;
    }
    if(!var_5.battlechatter.isspeaking) {
      continue;
    }
    var_5 scripts\engine\sp\utility_code::wait_until_done_speaking();
    anim.bcs_enabled = 0;
  }

  var_6 = gettime() - anim.lastteamspeaktime["allies"];

  if(var_6 < 1500)
    wait(var_6 / 1000);

  if(isDefined(var_0))
    level notify(var_0 + " done speaking");
  else
    level notify("done speaking");
}

battlechatter_on(var_0) {
  thread scripts\engine\sp\utility_code::battlechatter_on_thread(var_0);
}

battlechatter_commander_off(var_0) {
  if(var_0 == "all") {
    setDvar("bcs_commander_off", "all");
    return;
  }

  switch (getDvar("bcs_commander_off")) {
    case "":
      setDvar("bcs_commander_off", var_0);
      break;
    case "axis":
      if(var_0 == "allies")
        setDvar("bcs_commander_off", "all");

      break;
    case "allies":
      if(var_0 == "axis")
        setDvar("bcs_commander_off", "all");

      break;
  }
}

battlechatter_commander_on(var_0) {
  if(var_0 == "all") {
    setDvar("bcs_commander_off", "");
    return;
  }

  switch (getDvar("bcs_commander_off")) {
    case "axis":
      if(var_0 == "axis")
        setDvar("bcs_commander_off", "");

      break;
    case "allies":
      if(var_0 == "allies")
        setDvar("bcs_commander_off", "");

      break;
    case "all":
      if(var_0 == "axis")
        setDvar("bcs_commander_off", "allies");
      else if(var_0 == "allies")
        setDvar("bcs_commander_off", "allies");

      break;
  }
}

battlechatter_radioecho_off(var_0) {
  if(var_0 == "all") {
    setDvar("bcs_radioecho_off", "all");
    return;
  }

  switch (getDvar("bcs_radioecho_off")) {
    case "":
      setDvar("bcs_radioecho_off", var_0);
      break;
    case "axis":
      if(var_0 == "allies")
        setDvar("bcs_radioecho_off", "all");

      break;
    case "allies":
      if(var_0 == "axis")
        setDvar("bcs_radioecho_off", "all");

      break;
  }
}

battlechatter_radioecho_on(var_0) {
  if(var_0 == "all") {
    setDvar("bcs_radioecho_off", "");
    return;
  }

  switch (getDvar("bcs_radioecho_off")) {
    case "axis":
      if(var_0 == "axis")
        setDvar("bcs_radioecho_off", "");

      break;
    case "allies":
      if(var_0 == "allies")
        setDvar("bcs_radioecho_off", "");

      break;
    case "all":
      if(var_0 == "axis")
        setDvar("bcs_radioecho_off", "allies");
      else if(var_0 == "allies")
        setDvar("bcs_radioecho_off", "axis");

      break;
  }
}

battlechatter_otn_on(var_0, var_1) {
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_2 = undefined;

  switch (var_0) {
    case "stealth":
      var_2 = "bcs_otnStealth";
      break;
    case "combat":
      var_2 = "bcs_otnCombat";
      break;
    default:
  }

  setDvar(var_2, var_1);
}

battlechatter_otn_off(var_0) {
  var_0 = tolower(var_0);
  var_1 = undefined;

  switch (var_0) {
    case "stealth":
      var_1 = "bcs_otnStealth";
      break;
    case "combat":
      var_1 = "bcs_otnCombat";
      break;
    default:
  }

  setDvar(var_1, "off");
}

battlechatter_probability(var_0) {
  self.battlechatter_saytimescaled = var_0;
}

battlechatter_filter_on(var_0) {
  if(!isarray(var_0))
    var_0 = [var_0];

  foreach(var_2 in var_0)
  battlechatter_filter_internal(var_2, 1);
}

battlechatter_filter_off(var_0) {
  if(!isarray(var_0))
    var_0 = [var_0];

  foreach(var_2 in var_0)
  battlechatter_filter_internal(var_2, undefined);
}

battlechatter_filter_internal(var_0, var_1) {
  switch (var_0) {
    case "threat":
      self.battlechatter.filterthreat = var_1;
      break;
    case "inform":
      self.battlechatter.filterinform = var_1;
      break;
    case "vehicle":
      self.battlechatter.filtervehicle = var_1;
      break;
    case "order":
      self.battlechatter.filterorder = var_1;
      break;
    case "reaction":
      self.battlechatter.filterreaction = var_1;
      break;
    case "response":
      self.battlechatter.filterresponse = var_1;
      break;
    case "stealth":
      self.battlechatter.filterstealth = var_1;
      break;
  }
}

battlechatter_friendlyfire_force(var_0) {
  if(istrue(var_0))
    self.battlechatter.friendlyfire_force = 1;
  else
    self.battlechatter.friendlyfire_force = undefined;
}

battlechatter_addvehicle(var_0) {
  if(!isDefined(self.battlechatter))
    self.battlechatter = spawnStruct();

  self.battlechatter.enemyclass = var_0;
  thread scripts\anim\battlechatter_ai.gsc::aivehiclekillwaiter();
}

set_battlechatter(var_0) {
  if(!anim.chatinitialized) {
    return;
  }
  if(istrue(self.battlechatter_removed)) {
    return;
  }
  if(var_0) {
    if(isDefined(self.script_bcdialog) && !self.script_bcdialog)
      self.battlechatterallowed = 0;
    else
      self.battlechatterallowed = 1;
  } else {
    self.battlechatterallowed = 0;

    if(isDefined(self.battlechatter) && istrue(self.battlechatter.isspeaking))
      self waittill("done speaking");
  }
}

set_team_bcvoice(var_0, var_1) {
  if(!anim.chatinitialized) {
    return;
  }
  var_2 = getarraykeys(anim.countryids);
  var_3 = scripts\engine\utility::array_contains(var_2, var_1);

  if(!var_3) {
    return;
  }
  var_4 = getaiarray(var_0);

  foreach(var_6 in var_4) {
    var_6 set_ai_bcvoice(var_1);
    waitframe();
  }
}

set_ai_bcvoice(var_0) {
  if(!anim.chatinitialized) {
    return;
  }
  var_1 = getarraykeys(anim.countryids);
  var_2 = scripts\engine\utility::array_contains(var_1, var_0);

  if(!var_2) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(isDefined(self.battlechatter) && istrue(self.battlechatter.isspeaking)) {
    self waittill("done speaking");
    wait 0.1;
  }

  scripts\anim\battlechatter_ai.gsc::removefromsystem();
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self.voice = var_0;
  scripts\anim\battlechatter_ai.gsc::addtosystem();
}

flavorbursts_on(var_0) {
  thread set_flavorbursts_team_state(1, var_0);
}

flavorbursts_off(var_0) {
  thread set_flavorbursts_team_state(0, var_0);
}

set_flavorbursts_team_state(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "allies";

  while(!isDefined(anim.chatinitialized))
    wait 0.05;

  if(!anim.chatinitialized) {
    return;
  }
  wait 1.5;
  level.flavorbursts[var_1] = var_0;
  var_2 = [];
  var_2 = getaiarray(var_1);
  scripts\engine\utility::array_thread(var_2, ::set_flavorbursts, var_0);
}

set_flavorbursts(var_0) {
  self.flavorbursts = var_0;
}

friendlyfire_warnings_off() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 set_friendlyfire_warnings(0);
  }

  level.friendlyfire_warnings = 0;
}

friendlyfire_warnings_on() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 set_friendlyfire_warnings(1);
  }

  level.friendlyfire_warnings = 1;
}

set_friendlyfire_warnings(var_0) {
  if(var_0)
    self.friendlyfire_warnings_disable = undefined;
  else
    self.friendlyfire_warnings_disable = 1;
}

player_battlechatter_on() {
  thread scripts\sp\player\playerchatter::player_battlechatter_on_thread();
}

player_battlechatter_off() {
  thread scripts\sp\player\playerchatter::player_battlechatter_off_thread();
}

debugorigin() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");

  for(;;) {
    var_0 = anglesToForward(self.angles);
    var_1 = var_0 * 30;
    var_2 = var_0 * 20;
    var_3 = anglestoright(self.angles);
    var_4 = var_3 * -10;
    var_3 = var_3 * 10;
    wait 0.05;
  }
}

get_linked_struct() {
  var_0 = scripts\engine\utility::get_linked_structs();

  if(!var_0.size)
    return undefined;

  return var_0[0];
}

get_last_ent_in_chain(var_0) {
  var_1 = self;

  while(isDefined(var_1.target)) {
    wait 0.05;

    if(isDefined(var_1.target)) {
      var_1 = get_next_point_in_chain(var_0, var_1.target);
      continue;
    }

    break;
  }

  var_2 = var_1;
  return var_2;
}

get_next_point_in_chain(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "vehiclenode":
        var_2 = getvehiclenode(var_1, "targetname");
        break;
      case "pathnode":
        var_2 = getnode(var_1, "targetname");
        break;
      case "ent":
        var_2 = getEnt(var_1, "targetname");
        break;
      case "struct":
        var_2 = scripts\engine\utility::getStruct(var_1, "targetname");
        break;
      default:
    }

    return var_2;
  } else {
    var_2 = scripts\engine\utility::getStruct(var_1, "targetname");

    if(isDefined(var_2))
      return var_2;

    var_2 = getnode(var_1, "targetname");

    if(isDefined(var_2))
      return var_2;

    var_2 = getEnt(var_1, "targetname");

    if(isDefined(var_2))
      return var_2;

    var_2 = getvehiclenode(var_1, "targetname");

    if(isDefined(var_2))
      return var_2;
  }

  return undefined;
}

timeout(var_0) {
  self endon("death");
  wait(var_0);
  self notify("timeout");
}

array_removedead_keepkeys(var_0) {
  var_1 = [];
  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_0[var_4])) {
      continue;
    }
    var_1[var_4] = var_0[var_4];
  }

  return var_1;
}

array_remove_nokeys(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1)
      var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

array_remove_key_array(var_0, var_1) {
  if(var_1.size == 0)
    return var_0;

  var_2 = [];

  foreach(var_9, var_4 in var_0) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(var_7 == var_9) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    }
    var_2[var_9] = var_4;
  }

  return var_2;
}

array_notify(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0)
  var_4 notify(var_1, var_2);
}

struct_arrayspawn() {
  var_0 = spawnStruct();
  var_0.array = [];
  var_0.lastindex = 0;
  return var_0;
}

structarray_add(var_0, var_1) {
  var_0.array[var_0.lastindex] = var_1;
  var_1.struct_array_index = var_0.lastindex;
  var_0.lastindex++;
}

structarray_remove(var_0, var_1) {
  structarray_swaptolast(var_0, var_1);
  var_0.array[var_0.lastindex - 1] = undefined;
  var_0.lastindex--;
}

structarray_remove_index(var_0, var_1) {
  if(isDefined(var_0.array[var_0.lastindex - 1])) {
    var_0.array[var_1] = var_0.array[var_0.lastindex - 1];
    var_0.array[var_1].struct_array_index = var_1;
    var_0.array[var_0.lastindex - 1] = undefined;
    var_0.lastindex = var_0.array.size;
  } else {
    var_0.array[var_1] = undefined;
    structarray_remove_undefined(var_0);
  }
}

structarray_remove_undefined(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.array) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_0.array = var_1;

  foreach(var_6, var_3 in var_0.array)
  var_3.struct_array_index = var_6;

  var_0.lastindex = var_0.array.size;
}

structarray_swaptolast(var_0, var_1) {
  var_0 scripts\engine\sp\utility_code::structarray_swap(var_0.array[var_0.lastindex - 1], var_1);
}

structarray_shuffle(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0 scripts\engine\sp\utility_code::structarray_swap(var_0.array[var_2], var_0.array[randomint(var_0.lastindex)]);
}

custom_battlechatter(var_0) {
  return scripts\anim\battlechatter_ai.gsc::custom_battlechatter_internal(var_0);
}

get_stop_watch(var_0, var_1) {
  var_2 = newhudelem();

  if(isplatformpc()) {
    var_2.x = 68;
    var_2.y = 35;
  } else {
    var_2.x = 58;
    var_2.y = 95;
  }

  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "left";
  var_2.vertalign = "middle";

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = level.explosiveplanttime;

  var_2 setclock(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
}

set_mission_failed_override(var_0) {
  level.mission_fail_func = var_0;
}

get_force_color_guys(var_0, var_1) {
  var_2 = getaiarray(var_0);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5.script_forcecolor)) {
      continue;
    }
    if(var_5.script_forcecolor != var_1) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

get_all_force_color_friendlies() {
  var_0 = getaiarray("allies");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.script_forcecolor)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

enable_ai_color() {
  if(isDefined(self.script_forcecolor)) {
    return;
  }
  if(!isDefined(self.old_forcecolor)) {
    return;
  }
  set_force_color(self.old_forcecolor);
  self.old_forcecolor = undefined;
}

enable_ai_color_dontmove() {
  self.dontcolormove = 1;
  enable_ai_color();
}

disable_ai_color() {
  if(isDefined(self.new_force_color_being_set)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  self clearfixednodesafevolume();

  if(!isDefined(self.script_forcecolor)) {
    return;
  }
  self.old_forcecolor = self.script_forcecolor;
  level.arrays_of_colorforced_ai[scripts\sp\colors::get_team()][self.script_forcecolor] = scripts\engine\utility::array_remove(level.arrays_of_colorforced_ai[scripts\sp\colors::get_team()][self.script_forcecolor], self);
  scripts\sp\colors::left_color_node();
  self.script_forcecolor = undefined;
  self.currentcolorcode = undefined;
}

clear_force_color() {
  disable_ai_color();
}

get_force_color() {
  var_0 = self.script_forcecolor;
  return var_0;
}

shortencolor(var_0) {
  return level.colorchecklist[tolower(var_0)];
}

set_force_color(var_0) {
  var_1 = shortencolor(var_0);

  if(!isai(self)) {
    set_force_color_spawner(var_1);
    return;
  }

  if(self.team == "allies") {
    self.fixednode = 1;
    self.fixednodesaferadius = 64;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 0;
  }

  self.script_color_axis = undefined;
  self.script_color_allies = undefined;
  self.old_forcecolor = undefined;
  var_2 = scripts\sp\colors::get_team();

  if(isDefined(self.script_forcecolor))
    level.arrays_of_colorforced_ai[var_2][self.script_forcecolor] = scripts\engine\utility::array_remove(level.arrays_of_colorforced_ai[var_2][self.script_forcecolor], self);

  self.script_forcecolor = var_1;
  level.arrays_of_colorforced_ai[var_2][var_1] = scripts\engine\utility::array_removedead(level.arrays_of_colorforced_ai[var_2][var_1]);
  level.arrays_of_colorforced_ai[var_2][self.script_forcecolor] = scripts\engine\utility::array_add(level.arrays_of_colorforced_ai[var_2][self.script_forcecolor], self);
  thread scripts\engine\sp\utility_code::new_color_being_set(var_1);
}

set_force_color_spawner(var_0) {
  self.script_forcecolor = var_0;
  self.old_forcecolor = undefined;
}

restarteffect() {
  scripts\common\createfx::restart_fx_looper();
}

pauseexploder(var_0) {
  var_0 = var_0 + "";
  var_1 = level.createfxexploders[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1)
    var_3 scripts\engine\utility::pauseeffect();
  }
}

restartexploder(var_0) {
  var_0 = var_0 + "";
  var_1 = level.createfxexploders[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1)
    var_3 restarteffect();
  }
}

ignoreallenemies(var_0) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if(var_0) {
    self.old_threat_bias_group = self getthreatbiasgroup();
    var_1 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_2 = [];
    var_2["axis"] = "allies";
    var_2["allies"] = "axis";
    var_3 = getaiarray(var_2[self.team]);
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.size; var_5++)
      var_4[var_3[var_5] getthreatbiasgroup()] = 1;

    var_6 = getarraykeys(var_4);

    for(var_5 = 0; var_5 < var_6.size; var_5++)
      setthreatbias(var_6[var_5], "ignore_everybody", 0);
  } else {
    var_1 = undefined;

    if(self.old_threat_bias_group != "")
      self setthreatbiasgroup(self.old_threat_bias_group);

    self.old_threat_bias_group = undefined;
  }
}

add_start(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\sp\starts::add_start_assert();
  var_0 = tolower(var_0);
  var_6 = scripts\sp\starts::add_start_construct(var_0, var_1, var_2, var_3, var_4, var_5);
  level.start_functions[level.start_functions.size] = var_6;
  level.start_arrays[var_0] = var_6;
}

set_default_start(var_0) {
  level.default_start_override = var_0;
}

set_default_start_alt(var_0) {
  level.default_start_override_alt = var_0;
}

within_fov_of_players(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3] getEye();
    var_2 = scripts\engine\utility::within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

    if(!var_2)
      return 0;
  }

  return 1;
}

wait_for_buffer_time_to_pass(var_0, var_1) {
  var_2 = var_1 * 1000 - (gettime() - var_0);
  var_2 = var_2 * 0.001;

  if(var_2 > 0)
    wait(var_2);
}

bcs_scripted_dialogue_start() {
  anim.scripteddialoguestarttime = gettime();
}

dialogue_queue(var_0) {
  bcs_scripted_dialogue_start();
  scripts\sp\anim::anim_single_queue(self, var_0);
}

generic_dialogue_queue(var_0, var_1) {
  bcs_scripted_dialogue_start();
  scripts\sp\anim::anim_generic_queue(self, var_0, undefined, undefined, var_1);
}

radio_dialogue(var_0, var_1) {
  if(!isDefined(level.player_radio_emitter)) {
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var_2;
  }

  bcs_scripted_dialogue_start();
  var_3 = 0;

  if(!isDefined(var_1))
    var_3 = level.player_radio_emitter function_stack(scripts\engine\utility::playsoundontag, level.scr_radio[var_0], undefined, 1);
  else
    var_3 = level.player_radio_emitter function_stack_timeout(var_1, scripts\engine\utility::playsoundontag, level.scr_radio[var_0], undefined, 1);

  return var_3;
}

radio_dialogue_overlap(var_0) {
  level.player_radio_emitter play_sound_on_tag(level.scr_radio[var_0], undefined, 1);
}

radio_dialogue_stop() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter delete();
}

radio_dialogue_clear_stack() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }
  level.player_radio_emitter function_stack_clear();
}

radio_dialogue_interupt(var_0) {
  if(!isDefined(level.player_radio_emitter)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var_1;
  }

  level.player_radio_emitter play_sound_on_tag(level.scr_radio[var_0], undefined, 1);
}

radio_dialogue_safe(var_0) {
  return radio_dialogue(var_0, 0.05);
}

smart_radio_dialogue(var_0, var_1) {
  scripts\engine\sp\utility_code::add_to_radio(var_0);
  radio_dialogue(var_0, var_1);
}

smart_radio_dialogue_interrupt(var_0) {
  scripts\engine\sp\utility_code::add_to_radio(var_0);
  radio_dialogue_stop();
  radio_dialogue_interupt(var_0);
}

smart_radio_dialogue_overlap(var_0) {
  scripts\engine\sp\utility_code::add_to_radio(var_0);
  radio_dialogue_overlap(var_0);
}

player_dialogue(var_0, var_1) {
  return player_dialogue_gesture(var_0, 0, undefined, undefined, undefined, var_1);
}

_play_player_dialogue(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\engine\utility::is_dead_sentient()) {
    return;
  }
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");
  var_5.origin = self.origin;
  var_5.angles = self.angles;
  var_5 linkTo(self);

  if(var_1 > 0)
    var_5 scripts\engine\utility::delaycall(var_1, ::playsound, var_0, "sounddone");
  else
    var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(isDefined(var_4) && isDefined(var_4[var_6])) {
          level.player scripts\engine\utility::delaythread(var_3[var_6], ::player_gesture_force, var_2[var_6], var_4[var_6]);
          continue;
        }

        level.player scripts\engine\utility::delaythread(var_3[var_6], ::player_gesture_force, var_2[var_6]);
      }
    } else if(isDefined(var_4))
      level.player scripts\engine\utility::delaythread(var_3, ::player_gesture_force, var_2, var_4);
    else
      level.player scripts\engine\utility::delaythread(var_3, ::player_gesture_force, var_2);
  }

  if(var_1 > 0)
    wait(var_1);

  if(!isDefined(wait_for_sounddone_or_death(var_5, level.player)))
    var_5 stopsounds();

  wait 0.05;
  var_5 delete();
}

player_dialogue_gesture(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.player_dialogue_emitter)) {
    var_6 = spawn("script_origin", (0, 0, 0));
    var_6 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_dialogue_emitter = var_6;
  }

  bcs_scripted_dialogue_start();
  var_7 = 0;

  if(!isDefined(var_5))
    var_7 = level.player_dialogue_emitter function_stack(::_play_player_dialogue, level.scr_plrdialogue[var_0], var_1, var_2, var_3, var_4);
  else
    var_7 = level.player_dialogue_emitter function_stack_timeout(var_5, ::_play_player_dialogue, level.scr_plrdialogue[var_0], var_1, var_2, var_3, var_4);

  return var_7;
}

player_dialogue_stop() {
  if(!isDefined(level.player_dialogue_emitter)) {
    return;
  }
  level.player_dialogue_emitter delete();
}

player_dialogue_clear_stack() {
  if(!isDefined(level.player_dialogue_emitter)) {
    return;
  }
  level.player_dialogue_emitter function_stack_clear();
}

player_dialogue_interrupt(var_0) {
  player_dialogue_stop();

  if(!isDefined(level.player_dialogue_emitter)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_dialogue_emitter = var_1;
  }

  level.player_dialogue_emitter _play_player_dialogue(level.scr_plrdialogue[var_0], 0);
}

smart_player_dialogue(var_0, var_1) {
  scripts\engine\sp\utility_code::add_to_player_dialogue(var_0);
  player_dialogue(var_0, var_1);
}

smart_player_dialogue_interrupt(var_0) {
  scripts\engine\sp\utility_code::add_to_player_dialogue(var_0);
  player_dialogue_interrupt(var_0);
}

smart_player_dialogue_gesture(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\sp\utility_code::add_to_player_dialogue(var_0);
  player_dialogue_gesture(var_0, var_1, var_2, var_3, var_4, var_5);
}

smart_dialogue(var_0) {
  scripts\engine\sp\utility_code::add_to_dialogue(var_0);
  dialogue_queue(var_0);
}

smart_dialogue_generic(var_0) {
  scripts\engine\sp\utility_code::add_to_dialogue_generic(var_0);
  generic_dialogue_queue(var_0);
}

radio_dialogue_queue(var_0) {
  radio_dialogue(var_0);
}

ignoreeachother(var_0, var_1) {
  setignoremegroup(var_0, var_1);
  setignoremegroup(var_1, var_0);
}

add_global_spawn_function(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["function"] = var_1;
  var_5["param1"] = var_2;
  var_5["param2"] = var_3;
  var_5["param3"] = var_4;
  level.spawn_funcs[var_0][level.spawn_funcs[var_0].size] = var_5;
}

remove_global_spawn_function(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.spawn_funcs[var_0].size; var_3++) {
    if(level.spawn_funcs[var_0][var_3]["function"] != var_1)
      var_2[var_2.size] = level.spawn_funcs[var_0][var_3];
  }

  level.spawn_funcs[var_0] = var_2;
}

exists_global_spawn_function(var_0, var_1) {
  if(!isDefined(level.spawn_funcs))
    return 0;

  for(var_2 = 0; var_2 < level.spawn_funcs[var_0].size; var_2++) {
    if(level.spawn_funcs[var_0][var_2]["function"] == var_1)
      return 1;
  }

  return 0;
}

remove_spawn_function(var_0) {
  var_1 = [];

  foreach(var_3 in self.spawn_functions) {
    if(var_3["function"] == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self.spawn_functions = var_1;
}

add_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self.spawn_functions) {
    if(var_7["function"] == var_0)
      return;
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self.spawn_functions[self.spawn_functions.size] = var_9;
}

array_kill(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] kill();
}

ignore_triggers(var_0) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isDefined(var_0))
    wait(var_0);
  else
    wait 0.5;

  self.ignoretriggers = 0;
}

activate_trigger_with_targetname(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 activate_trigger();
}

activate_trigger_with_noteworthy(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 activate_trigger();
}

disable_trigger_with_targetname(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 scripts\engine\utility::trigger_off();
}

disable_trigger_with_noteworthy(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 scripts\engine\utility::trigger_off();
}

enable_trigger_with_targetname(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 scripts\engine\utility::trigger_on();
}

enable_trigger_with_noteworthy(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 scripts\engine\utility::trigger_on();
}

set_team_pacifist(var_0, var_1) {
  var_2 = getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_2[var_3].pacifist = var_1;
}

replace_on_death() {
  scripts\sp\colors::colornode_replace_on_death();
}

spawn_reinforcement(var_0, var_1) {
  scripts\sp\colors::colornode_spawn_reinforcement(var_0, var_1);
}

set_promotion_order(var_0, var_1) {
  if(!isDefined(level.current_color_order))
    level.current_color_order = [];

  var_0 = shortencolor(var_0);
  var_1 = shortencolor(var_1);
  level.current_color_order[var_0] = var_1;

  if(!isDefined(level.current_color_order[var_1]))
    set_empty_promotion_order(var_1);
}

set_empty_promotion_order(var_0) {
  if(!isDefined(level.current_color_order))
    level.current_color_order = [];

  level.current_color_order[var_0] = "none";
}

remove_color_from_array(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.script_forcecolor)) {
      continue;
    }
    if(var_4.script_forcecolor == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

remove_noteworthy_from_array(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_closest_colored_friendly(var_0, var_1) {
  var_2 = get_force_color_guys("allies", var_0);

  if(!isDefined(var_1))
    var_3 = level.player.origin;
  else
    var_3 = var_1;

  return scripts\engine\utility::getclosest(var_3, var_2);
}

remove_without_classname(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].classname, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

remove_without_model(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].model, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

get_closest_colored_friendly_with_classname(var_0, var_1, var_2) {
  var_3 = get_force_color_guys("allies", var_0);

  if(!isDefined(var_2))
    var_4 = level.player.origin;
  else
    var_4 = var_2;

  var_3 = remove_without_classname(var_3, var_1);
  return scripts\engine\utility::getclosest(var_4, var_3);
}

promote_nearest_friendly(var_0, var_1) {
  for(;;) {
    var_2 = get_closest_colored_friendly(var_0);

    if(!isalive(var_2)) {
      wait 1;
      continue;
    }

    var_2 set_force_color(var_1);
    return;
  }
}

instantly_promote_nearest_friendly(var_0, var_1) {
  for(;;) {
    var_2 = get_closest_colored_friendly(var_0);

    if(!isalive(var_2)) {
      return;
    }
    var_2 set_force_color(var_1);
    return;
  }
}

instantly_promote_nearest_friendly_with_classname(var_0, var_1, var_2) {
  for(;;) {
    var_3 = get_closest_colored_friendly_with_classname(var_0, var_2);

    if(!isalive(var_3)) {
      return;
    }
    var_3 set_force_color(var_1);
    return;
  }
}

promote_nearest_friendly_with_classname(var_0, var_1, var_2) {
  for(;;) {
    var_3 = get_closest_colored_friendly_with_classname(var_0, var_2);

    if(!isalive(var_3)) {
      wait 1;
      continue;
    }

    var_3 set_force_color(var_1);
    return;
  }
}

instantly_set_color_from_array_with_classname(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_3 || !issubstr(var_6.classname, var_2)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    var_3 = 1;
    var_6 set_force_color(var_1);
  }

  return var_4;
}

instantly_set_color_from_array(var_0, var_1) {
  var_2 = 0;
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_2) {
      var_3[var_3.size] = var_5;
      continue;
    }

    var_2 = 1;
    var_5 set_force_color(var_1);
  }

  return var_3;
}

wait_for_script_noteworthy_trigger(var_0) {
  scripts\engine\sp\utility_code::wait_for_trigger(var_0, "script_noteworthy");
}

wait_for_targetname_trigger(var_0) {
  scripts\engine\sp\utility_code::wait_for_trigger(var_0, "targetname");
}

wait_for_flag_or_timeout(var_0, var_1) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  wait(var_1);
}

wait_for_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

wait_for_trigger_or_timeout(var_0) {
  self endon("trigger");
  wait(var_0);
}

wait_for_either_trigger(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = [];
  var_3 = scripts\engine\utility::array_combine(var_3, getEntArray(var_0, "targetname"));
  var_3 = scripts\engine\utility::array_combine(var_3, getEntArray(var_1, "targetname"));

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_2 thread scripts\engine\sp\utility_code::ent_waits_for_trigger(var_3[var_4]);

  var_2 waittill("done");
}

dronespawn_bodyonly(var_0) {
  var_1 = scripts\sp\spawner::spawner_dronespawn(var_0);
  return var_1;
}

fakeactorspawn(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_1 = scripts\sp\spawner::spawner_dronespawn(var_0);
  var_1[[level.fakeactor_spawn_func]]();
  var_1.spawn_funcs = var_0.spawn_functions;
  var_1.spawn_functions = undefined;
  var_1 thread scripts\sp\spawner::run_spawn_functions();
  var_1.spawner = var_0;
  var_1.script_fakeactor = 1;

  if(isDefined(var_0.script_nodrop))
    var_1.nodrop = var_0.script_nodrop;

  if(isDefined(var_0.script_noragdoll))
    var_1.noragdoll = var_0.script_noragdoll;

  return var_1;
}

bodyonlyspawn(var_0) {
  var_1 = scripts\sp\spawner::spawner_dronespawn(var_0);
  var_1.spawn_funcs = var_0.spawn_functions;
  var_1.spawn_functions = undefined;
  var_1 thread scripts\sp\spawner::run_spawn_functions();
  return var_1;
}

dronespawn(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_1 = scripts\sp\spawner::spawner_dronespawn(var_0);
  var_1[[level.drone_spawn_func]]();
  var_1.spawn_funcs = var_0.spawn_functions;
  var_1.spawn_functions = undefined;
  var_1 thread scripts\sp\spawner::run_spawn_functions();
  return var_1;
}

create_corpses() {
  var_0 = getEntArray("corpse", "script_noteworthy");

  if(var_0.size)
    array_spawn_function(var_0, ::init_corpse);

  var_0 = getEntArray("corpse_noragdoll", "script_noteworthy");

  if(var_0.size)
    array_spawn_function(var_0, ::init_corpse);

  var_0 = get_spawner_array("corpse", "script_noteworthy");

  if(var_0.size)
    array_spawn_function(var_0, ::init_corpse);
}

init_corpse() {
  if(!isDefined(self.script_animation))
    self delete();
  else {
    self.animname = "corpse";
    self startusingheroonlylighting();

    if(isai(self))
      self.ignoreall = 1;
    else
      self notsolid();

    if(isDefined(self.target)) {
      var_0 = scripts\engine\utility::get_target_ent(self.target);
      self dontinterpolate();

      if(isai(self))
        self forceteleport(var_0.origin, var_0.angles);
      else {
        self.origin = var_0.origin;
        self.angles = var_0.angles;
      }
    }

    var_1 = getweaponmodel(self.weapon);

    if(isDefined(var_1) && var_1 != "") {
      if(isai(self))
        scripts\common\ai::gun_remove();

      if(!isDefined(self.script_nodrop)) {
        var_2 = spawn("weapon_" + createheadicon(self.weapon), self gettagorigin("tag_weapon_right"));
        var_2.angles = self gettagangles("tag_weapon_right");
      }
    }

    if(isai(self)) {
      if(self.script_noteworthy == "corpse_noragdoll")
        self.noragdoll = 1;

      set_deathanim(self.script_animation);
      self kill();
      return;
    }

    self animScripted("corpse_anim", self.origin, self.angles, scripts\engine\utility::getanim(self.script_animation), "deathplant", undefined, 0);

    if(self.script_noteworthy != "corpse_noragdoll") {
      var_3 = getanimlength(scripts\engine\utility::getanim(self.script_animation));

      if(var_3 > 0)
        wait(var_3 * 0.35);

      if(isDefined(self.fnpreragdoll))
        self[[self.fnpreragdoll]]();

      self startragdoll();
    }
  }
}

get_trigger_flag() {
  if(isDefined(self.script_flag))
    return self.script_flag;

  if(isDefined(self.script_noteworthy))
    return self.script_noteworthy;
}

set_default_pathenemy_settings() {
  self.pathenemylookahead = 50;
  self.pathenemyfightdist = 192;
}

walk_and_talk(var_0, var_1, var_2) {
  if(var_0 == "on") {
    self._blackboard.walk_and_talk_requested = 1;

    if(isDefined(var_2)) {
      if(var_2 == "right")
        self.walk_and_talk_hemisphere = "right";
      else
        self.walk_and_talk_hemisphere = "left";
    }

    if(!isDefined(var_1))
      self.walk_and_talk_target = level.player;
    else {
      self.walk_and_talk_target = var_1;

      if(!isDefined(var_1.origin))
        return;
    }
  } else
    self._blackboard.walk_and_talk_requested = 0;
}

enable_eight_point_strafe(var_0) {
  if(self.type == "dog") {
    return;
  }
  if(var_0)
    self._blackboard.eight_point_strafe_requested = 1;
  else
    self._blackboard.eight_point_strafe_requested = 0;
}

enable_readystand() {
  self.busereadyidle = 1;
}

disable_readystand() {
  self.busereadyidle = undefined;
}

cqb_aim(var_0) {
  if(!isDefined(var_0))
    self.cqb_target = undefined;
  else {
    self.cqb_target = var_0;

    if(!isDefined(var_0.origin))
      return;
  }
}

set_force_cover(var_0) {
  if(isDefined(var_0) && var_0)
    self.forcesuppression = 1;
  else
    self.forcesuppression = undefined;
}

first_touch(var_0) {
  if(!isDefined(self.touched))
    self.touched = [];

  if(isDefined(self.touched[var_0.unique_id]))
    return 0;

  self.touched[var_0.unique_id] = 1;
  return 1;
}

add_hint_string(var_0, var_1, var_2) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.trigger_hint_string[var_0] = var_1;
  precachestring(var_1);

  if(isDefined(var_2))
    level.trigger_hint_func[var_0] = var_2;
}

clearthreatbias(var_0, var_1) {
  setthreatbias(var_0, var_1, 0);
  setthreatbias(var_1, var_0, 0);
}

set_ignoresuppression(var_0) {
  self.ignoresuppression = var_0;
}

set_goalRadius(var_0) {
  self.goalradius = var_0;
}

set_allowdeath(var_0) {
  self.allowdeath = var_0;
}

set_run_anim(var_0, var_1) {
  if(getdvarint("LPNQTQRRP", 0) == 1) {
    var_2 = "combat";
    set_move_anim(var_2, var_0);
    self.run_overrideanim = level.scr_anim[self.animname][var_0];
    return;
  }

  if(isDefined(var_1))
    self.alwaysrunforward = var_1;
  else
    self.alwaysrunforward = 1;

  scripts\common\ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim[self.animname][var_0];
  self.walk_overrideanim = self.run_overrideanim;
}

set_move_anim(var_0, var_1) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var_0, "move", level.scr_anim[self.animname][var_1]);
}

clear_move_anim(var_0) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var_0, "move");
}

set_idle_anim(var_0, var_1) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var_0, "idle", level.scr_anim[self.animname][var_1]);
}

clear_idle_anim(var_0) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var_0, "idle");
}

set_dog_walk_anim() {
  self.a.movement = "walk";
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.script_nobark = 1;
}

set_arrival_speed(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(isDefined(self.arrivalspeed))
    self.arrivalspeed = var_0;
  else
    return;
}

clear_arrival_speed() {
  if(isDefined(self.arrivalspeed))
    self.arrivalspeed = 1;
}

override_move_with_purpose(var_0) {
  var_1 = scripts\asm\asm::asm_lookupanimfromalias("move_walk_loop", "casual_purpose");
  scripts\asm\asm::asm_setdemeanoranimoverride(var_0, "move", var_1);

  if(var_0 == "casual")
    thread set_arrival_speed(1.15);
}

clear_move_with_purpose() {
  thread clear_move_anim(scripts\asm\asm::asm_getdemeanor());
  thread clear_arrival_speed();
}

set_generic_idle_anim(var_0) {
  var_1 = level.scr_anim["generic"][var_0];

  if(isarray(var_1))
    self.specialidleanim = var_1;
  else
    self.specialidleanim[0] = var_1;
}

clear_generic_idle_anim() {
  self.specialidleanim = undefined;
  self notify("stop_specialidle");
}

set_generic_run_anim(var_0, var_1) {
  set_generic_run_anim_array(var_0, undefined, var_1);
}

clear_generic_run_anim() {
  self notify("movemode");
  scripts\common\ai::enable_turnanims();
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
}

set_generic_run_anim_array(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2)
    self.alwaysrunforward = 1;
  else
    self.alwaysrunforward = undefined;

  scripts\common\ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim["generic"][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var_1)) {
    self.run_override_weights = level.scr_anim["generic"][var_1];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

set_run_anim_array(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2)
    self.alwaysrunforward = 1;
  else
    self.alwaysrunforward = undefined;

  scripts\common\ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim[self.animname][var_0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var_1)) {
    self.run_override_weights = level.scr_anim[self.animname][var_1];
    self.walk_override_weights = self.run_override_weights;
  } else {
    self.run_override_weights = undefined;
    self.walk_override_weights = undefined;
  }
}

clear_run_anim() {
  self notify("clear_run_anim");
  self notify("movemode");

  if(self.type == "dog") {
    self.a.movement = "run";
    self.disablearrivals = 0;
    self.disableexits = 0;
    self.script_nobark = undefined;
    return;
  }

  if(getdvarint("LPNQTQRRP", 0) == 1) {
    var_0 = "combat";
    self.allowstrafe = 1;
    clear_move_anim(var_0);
    self.run_overrideanim = undefined;
    return;
  }

  if(!isDefined(self.casual_killer))
    scripts\common\ai::enable_turnanims();

  self.alwaysrunforward = undefined;
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

physicsjolt_proximity(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_physicsjolt");

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    var_0 = 400;
    var_1 = 256;
    var_2 = (0, 0, 0.075);
  }

  var_3 = var_0 * var_0;
  var_4 = 3;
  var_5 = var_2;

  for(;;) {
    wait 0.1;
    var_2 = var_5;

    if(self.code_classname == "script_vehicle") {
      var_6 = self vehicle_getspeed();

      if(var_6 < var_4) {
        var_7 = var_6 / var_4;
        var_2 = var_5 * var_7;
      }
    }

    var_8 = distancesquared(self.origin, level.player.origin);
    var_7 = var_3 / var_8;

    if(var_7 > 1)
      var_7 = 1;

    var_2 = var_2 * var_7;
    var_9 = var_2[0] + var_2[1] + var_2[2];

    if(var_9 > 0.025)
      physicsjitter(self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0);
  }
}

set_goal_entity(var_0) {
  self setgoalentity(var_0);
}

activate_trigger(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    activate_trigger_process(var_2);
  else {
    var_3 = getEntArray(var_0, var_1);
    scripts\engine\utility::array_thread(var_3, ::activate_trigger_process, var_2);
  }
}

activate_trigger_process(var_0) {
  if(isDefined(self.script_color_allies)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::activate_color_trigger("allies");
  }

  if(isDefined(self.script_color_axis)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::activate_color_trigger("axis");
  }

  self notify("trigger", var_0);
}

self_delete() {
  self delete();
}

has_color() {
  if(scripts\sp\colors::get_team() == "axis")
    return isDefined(self.script_color_axis) || isDefined(self.script_forcecolor);

  return isDefined(self.script_color_allies) || isDefined(self.script_forcecolor);
}

clear_colors() {
  clear_team_colors("axis");
  clear_team_colors("allies");
}

clear_team_colors(var_0) {
  level.currentcolorforced[var_0]["r"] = undefined;
  level.currentcolorforced[var_0]["b"] = undefined;
  level.currentcolorforced[var_0]["c"] = undefined;
  level.currentcolorforced[var_0]["y"] = undefined;
  level.currentcolorforced[var_0]["p"] = undefined;
  level.currentcolorforced[var_0]["o"] = undefined;
  level.currentcolorforced[var_0]["g"] = undefined;
}

notify_delay(var_0, var_1) {
  self endon("death");

  if(var_1 > 0)
    wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}

name_hide() {
  if(!isDefined(self.name)) {
    return;
  }
  self.og_name = self.name;
  self.name = undefined;

  if(isDefined(self.callsign)) {
    self.og_callsign = self.callsign;
    self.callsign = "";
  }
}

name_show() {
  self.name = self.og_name;

  if(isDefined(self.og_callsign))
    self.callsign = self.og_callsign;
}

place_weapon_on(var_0, var_1) {
  if(!scripts\anim\utility.gsc::aihasweapon(var_0))
    scripts\common\utility::initweapon(var_0);

  scripts\anim\shared.gsc::placeweaponon(var_0, var_1);
}

player_moves(var_0) {
  var_1 = level.player.origin;

  for(;;) {
    if(distance(var_1, level.player.origin) > var_0) {
      break;
    }

    wait 0.05;
  }
}

waittill_either_function(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread scripts\engine\sp\utility_code::waittill_either_function_internal(var_4, var_0, var_1);
  thread scripts\engine\sp\utility_code::waittill_either_function_internal(var_4, var_2, var_3);
  var_4 waittill("done");
}

waittill_msg(var_0) {
  self waittill(var_0);
}

in_realism_mode() {
  return level.gameskill == 4;
}

display_hint(var_0, var_1, var_2, var_3, var_4) {
  if(in_realism_mode()) {
    return;
  }
  thread display_hint_proc(var_0, var_1, var_2, var_3, var_4);
}

display_hint_forced(var_0, var_1, var_2, var_3, var_4) {
  thread display_hint_proc(var_0, var_1, var_2, var_3, var_4);
}

display_hint_proc(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && isDefined(var_4)) {
    if(!isarray(var_3))
      var_3 = [var_3];

    if(!isarray(var_4))
      var_4 = [var_4];

    foreach(var_6 in var_3) {
      foreach(var_8 in var_4)
      var_6 endon(var_8);
    }
  }

  var_11 = get_player_from_self();
  var_11 endon("new_hint");

  if(isDefined(level.trigger_hint_func[var_0])) {
    var_11 endon("hint_function_cancel");
    var_11 childthread display_hint_function_cancel_logic(level.trigger_hint_func[var_0]);
  }

  if(istrue(var_2))
    wait(var_2);

  if(isDefined(level.trigger_hint_func[var_0])) {
    if(var_11[[level.trigger_hint_func[var_0]]]()) {
      return;
    }
    var_11 thread scripts\engine\sp\utility_code::hintprint(level.trigger_hint_string[var_0], level.trigger_hint_func[var_0], var_1, undefined, var_3, var_4);
  } else
    var_11 thread scripts\engine\sp\utility_code::hintprint(level.trigger_hint_string[var_0], undefined, var_1, undefined, var_3, var_4);
}

display_hint_function_cancel_logic(var_0) {
  for(;;) {
    if([[var_0]]())
      self notify("hint_function_cancel");

    waitframe();
  }
}

getgenericanim(var_0) {
  return level.scr_anim["generic"][var_0];
}

enable_careful() {
  self.script_careful = 1;
}

disable_careful() {
  self.script_careful = 0;
  self notify("stop_being_careful");
}

enable_sprint() {
  self.sprint = 1;
  scripts\common\utility::demeanor_override("sprint");
}

disable_sprint() {
  self.sprint = undefined;
  scripts\common\utility::clear_demeanor_override();
}

disable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = 1;
}

enable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = undefined;
}

set_fixednode_true() {
  self.fixednode = 1;
}

set_fixednode_false() {
  self.fixednode = 0;
}

spawn_ai(var_0, var_1) {
  if(isDefined(self.script_delay_spawn)) {
    self endon("death");
    wait(self.script_delay_spawn);
  }

  var_2 = undefined;
  var_3 = isDefined(self.script_stealthgroup) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
  var_4 = 0;

  if(isDefined(self.script_suspend)) {
    var_4 = scripts\sp\spawner::prespawn_suspended_ai();

    if(self.count == 0 && !var_4)
      return undefined;
  }

  var_5 = 0;
  var_6 = 0;

  if(isDefined(self.script_drone))
    var_7 = dronespawn(self);
  else if(isDefined(self.script_fakeactor))
    var_7 = fakeactorspawn(self);
  else if(isDefined(self.script_bodyonly))
    var_7 = bodyonlyspawn(self);
  else {
    var_5 = 1;

    if(isDefined(self.script_forcespawn) || istrue(var_0)) {
      var_7 = self stalingradspawn(var_3);
      var_6 = 1;
    } else if(isDefined(self.script_forcespawndist) && distancesquared(self.origin, level.player.origin) > squared(self.script_forcespawndist)) {
      var_7 = self stalingradspawn(var_3);
      var_6 = 1;
    } else
      var_7 = self dospawn(var_3);
  }

  if(var_5) {
    if(isDefined(var_1) && var_1 && isalive(var_7))
      var_7 scripts\common\ai::magic_bullet_shield();

    if(scripts\common\ai::spawn_failed(var_7)) {
      if(!var_4 && isDefined(self.script_aigroup))
        scripts\sp\spawner::aigroup_decrement(level._ai_group[self.script_aigroup]);

      if(var_4) {
        self.count--;

        if(!isDefined(self.try_og_origin)) {
          self.try_og_origin = 1;
          var_7 = spawn_ai();
          return var_7;
        } else
          self.try_og_origin = undefined;
      }
    } else if(var_6) {}
  }

  if(isDefined(self.script_spawn_once))
    self delete();

  return var_7;
}

function_stack(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6 thread scripts\engine\sp\utility_code::function_stack_proc(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return scripts\engine\sp\utility_code::function_stack_wait_finish(var_6);
}

function_stack_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread scripts\engine\sp\utility_code::function_stack_proc(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7.function_stack_func_begun) || var_7 scripts\engine\utility::waittill_any_timeout(var_0, "function_stack_func_begun") != "timeout")
    return scripts\engine\sp\utility_code::function_stack_wait_finish(var_7);
  else {
    var_7 notify("death");
    return 0;
  }
}

function_stack_clear() {
  var_0 = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun))
    var_0[0] = self.function_stack[0];

  self.function_stack = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0].function_stack_func_begun) {
    return;
  }
  self.function_stack = var_0;
}

set_blur(var_0, var_1) {
  setblur(var_0, var_1);
}

set_goal_radius(var_0) {
  self.goalradius = var_0;
}

set_goal_node(var_0) {
  self.last_set_goalnode = var_0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var_0);
}

set_goal_node_targetname(var_0) {
  var_1 = getnode(var_0, "targetname");
  set_goal_node(var_1);
}

set_goal_pos(var_0) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var_0;
  self.last_set_goalent = undefined;
  self setgoalpos(var_0);
}

set_goal_ent(var_0) {
  set_goal_pos(var_0.origin);
  self.last_set_goalent = var_0;

  if(isstruct(var_0) && !isDefined(var_0.type))
    var_0.type = "struct";
}

get_spawner_array(var_0, var_1) {
  var_2 = getspawnerarray();
  var_3 = [];

  if(var_1 == "code_classname") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.code_classname) && var_5.code_classname == var_0)
        var_3[var_3.size] = var_5;
    }
  } else if(var_1 == "classname") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.classname) && var_5.classname == var_0)
        var_3[var_3.size] = var_5;
    }
  } else if(var_1 == "target") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.target) && var_5.target == var_0)
        var_3[var_3.size] = var_5;
    }
  } else if(var_1 == "script_linkname") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.script_linkname) && var_5.script_linkname == var_0)
        var_3[var_3.size] = var_5;
    }
  } else if(var_1 == "script_noteworthy") {
    foreach(var_5 in var_2) {
      if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0)
        var_3[var_3.size] = var_5;
    }
  } else if(var_1 == "targetname") {} else {}

  return var_3;
}

array_spawn(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];

  foreach(var_5 in var_0) {
    var_5.count = 1;

    if(getsubstr(var_5.classname, 7, 10) == "veh") {
      var_6 = var_5 scripts\common\utility::spawn_vehicle();

      if(isDefined(var_6.target) && !isDefined(var_6.script_moveoverride))
        var_6 thread scripts\common\vehicle_paths::gopath();

      var_3[var_3.size] = var_6;
      continue;
    }

    var_6 = var_5 spawn_ai(var_1);

    if(!var_2) {}

    var_3[var_3.size] = var_6;
  }

  if(!var_2) {}

  return var_3;
}

array_spawn_targetname(var_0, var_1, var_2, var_3) {
  var_4 = getspawnerarray(var_0);
  var_4 = array_merge(var_4, getEntArray(var_0, "targetname"));
  return array_spawn(var_4, var_1, var_2);
}

array_spawn_noteworthy(var_0, var_1, var_2, var_3) {
  var_4 = get_spawner_array(var_0, "script_noteworthy");
  var_4 = array_merge(var_4, getEntArray(var_0, "script_noteworthy"));
  return array_spawn(var_4, var_1, var_2);
}

spawn_script_noteworthy(var_0, var_1) {
  var_2 = getspawner(var_0, "script_noteworthy");
  var_3 = var_2 spawn_ai(var_1);
  return var_3;
}

spawn_targetname(var_0, var_1) {
  var_2 = getspawner(var_0, "targetname");
  var_3 = var_2 spawn_ai(var_1);
  return var_3;
}

set_grenadeammo(var_0) {
  self.grenadeammo = var_0;
}

set_grenadeweapon(var_0) {
  var_1 = strtok(var_0, " ");
  self.grenadeweapon = getcompleteweaponname(var_1[randomint(var_1.size)]);
}

get_player_feet_from_view() {
  var_0 = self.origin;
  var_1 = anglestoup(self getplayerangles());
  var_2 = self getplayerviewheight();
  var_3 = var_0 + (0, 0, var_2);
  var_4 = var_0 + var_1 * var_2;
  var_5 = var_3 - var_4;
  var_6 = var_0 + var_5;
  return var_6;
}

set_baseaccuracy(var_0) {
  self.baseaccuracy = var_0;
}

set_attackeraccuracy(var_0) {
  if(scripts\common\utility::issp() && isPlayer(self))
    scripts\sp\utility::set_player_attacker_accuracy(var_0);
  else
    self.attackeraccuracy = var_0;
}

autosave_now(var_0) {
  return scripts\sp\autosave::_autosave_game_now(var_0);
}

autosave_now_silent() {
  return scripts\sp\autosave::_autosave_game_now(1);
}

set_generic_deathanim(var_0) {
  self.deathanim = getgenericanim(var_0);
}

set_deathanim(var_0) {
  self.deathanim = scripts\engine\utility::getanim(var_0);
}

clear_deathanim() {
  self.deathanim = undefined;
}

set_dontmelee(var_0) {
  self.dontmelee = var_0;
}

putgunaway() {
  scripts\anim\shared.gsc::placeweaponon(self.weapon, "none");
  self.weapon = isundefinedweapon();
}

anim_stopanimScripted() {
  self stopanimScripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self notify("stop_animmode");
}

antigrav_float_ai_override(var_0) {
  self.allowantigrav = var_0;
}

antigrav_clear_float_ai_override() {
  self.allowantigrav = undefined;
}

antigrav_disable_nav_obstacle_for_team(var_0, var_1) {
  if(var_1) {
    if(!isDefined(level.antigrav.disablenavobstacleteams) || level.antigrav.disablenavobstacleteams.size == 0 || var_0 == "all") {
      level.antigrav.disablenavobstacleteams = [];
      level.antigrav.disablenavobstacleteams[0] = var_0;
    } else if(level.antigrav.disablenavobstacleteams[0] != "all")
      level.antigrav.disablenavobstacleteams = scripts\engine\utility::array_combine_unique(level.antigrav.disablenavobstacleteams, [var_0]);
  } else {
    if(!isDefined(level.antigrav.disablenavobstacleteams) || level.antigrav.disablenavobstacleteams.size == 0) {
      return;
    }
    if(var_0 == "all")
      level.antigrav.disablenavobstacleteams = undefined;
    else if(level.antigrav.disablenavobstacleteams[0] == "all") {
      level.antigrav.disablenavobstacleteams = [];

      if(var_0 == "allies")
        level.antigrav.disablenavobstacleteams[0] = "axis";
      else
        level.antigrav.disablenavobstacleteams[0] = "allies";
    } else {
      level.antigrav.disablenavobstacleteams = scripts\engine\utility::array_remove_array(level.antigrav.disablenavobstacleteams, [var_0]);
      return;
    }
  }
}

kill_wrapper() {
  self enabledeathshield(0);
  self kill();
  return 1;
}

array_wait_match(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  foreach(var_5 in var_0)
  thread array_wait_match_proc(var_3, var_5, var_1, var_2);

  for(var_7 = 0; var_7 < var_0.size; var_7++)
    var_3 waittill("array_wait_match_proc");
}

array_wait_match_proc(var_0, var_1, var_2, var_3) {
  var_0 endon("array_wait_success");
  var_1 waittillmatch(var_2, var_3);
  var_0 notify("array_wait_match_proc");
}

array_any_wait_match(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  foreach(var_5 in var_0)
  thread array_any_wait_match_proc(var_3, var_5, var_1, var_2);

  var_3 waittill("array_wait_proc");
}

array_any_wait_match_proc(var_0, var_1, var_2, var_3) {
  var_1 waittillmatch(var_2, var_3);
  var_0 notify("array_wait_proc");
}

die() {
  self kill((0, 0, 0));
}

getmodel(var_0) {
  return level.scr_model[var_0];
}

isads() {
  return self playerads() > 0.5;
}

disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

waittill_player_lookat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = level.player;

  var_6 = spawnStruct();

  if(isDefined(var_3))
    var_6 thread notify_delay("timeout", var_3);

  var_6 endon("timeout");

  if(!isDefined(var_0))
    var_0 = 0.92;

  if(!isDefined(var_1))
    var_1 = 0;

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = isai(self);
  var_10 = undefined;

  for(;;) {
    if(var_9)
      var_10 = self getEye();
    else
      var_10 = self.origin;

    if(var_5 player_looking_at(var_10, var_0, var_2, var_4)) {
      var_8--;

      if(var_8 <= 0)
        return 1;
    } else
      var_8 = var_7;

    wait 0.05;
  }
}

waittill_player_lookat_for_time(var_0, var_1, var_2, var_3) {
  waittill_player_lookat(var_1, var_0, var_2, undefined, var_3);
}

player_looking_at(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_4 = get_player_from_self();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1)
    return 0;

  if(isDefined(var_2))
    return 1;

  return scripts\engine\trace::ray_trace_detail_passed(var_0, var_5, var_3, scripts\engine\trace::create_default_contents(1));
}

either_player_looking_at(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4] player_looking_at(var_0, var_1, var_2, var_3))
      return 1;
  }

  return 0;
}

point_orientation_relative_to_player(var_0) {
  var_1 = get_player_from_self();
  var_2 = vectortoangles(var_0 - var_1 getEye());
  var_3 = anglesToForward(var_2);
  var_4 = var_1 getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = vectorcross(var_3, var_5);

  if(var_6[2] < 0)
    return "left";
  else
    return "right";
}

players_within_distance(var_0, var_1) {
  var_2 = var_0 * var_0;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(var_1, level.players[var_3].origin) < var_2)
      return 1;
  }

  return 0;
}

ai_delete_when_out_of_sight(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  while(var_0.size > 0) {
    wait 1;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isalive(var_0[var_3])) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_3]);
        continue;
      }

      if(players_within_distance(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(either_player_looking_at(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isDefined(var_0[var_3].magic_bullet_shield))
        var_0[var_3] scripts\common\ai::stop_magic_bullet_shield();

      var_0[var_3] delete();
      var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_3]);
    }
  }
}

add_wait(var_0, var_1, var_2, var_3, var_4) {
  init_waits();
  var_5 = spawnStruct();
  var_5.caller = self;
  var_5.func = var_0;
  var_5.parms = [];

  if(isDefined(var_1))
    var_5.parms[var_5.parms.size] = var_1;

  if(isDefined(var_2))
    var_5.parms[var_5.parms.size] = var_2;

  if(isDefined(var_3))
    var_5.parms[var_5.parms.size] = var_3;

  if(isDefined(var_4))
    var_5.parms[var_5.parms.size] = var_4;

  if(!isDefined(level.waits.wait_any_func_array))
    level.waits.wait_any_func_array = [var_5];
  else
    level.waits.wait_any_func_array[level.waits.wait_any_func_array.size] = var_5;
}

add_abort(var_0, var_1, var_2, var_3) {
  init_waits();
  var_4 = spawnStruct();
  var_4.caller = self;
  var_4.func = var_0;
  var_4.parms = [];

  if(isDefined(var_1))
    var_4.parms[var_4.parms.size] = var_1;

  if(isDefined(var_2))
    var_4.parms[var_4.parms.size] = var_2;

  if(isDefined(var_3))
    var_4.parms[var_4.parms.size] = var_3;

  level.waits.abort_wait_any_func_array[level.waits.abort_wait_any_func_array.size] = var_4;
}

add_func(var_0, var_1, var_2, var_3, var_4, var_5) {
  init_waits();
  var_6 = spawnStruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isDefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isDefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isDefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isDefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.waits.run_func_after_wait_array[level.waits.run_func_after_wait_array.size] = var_6;
}

add_call(var_0, var_1, var_2, var_3, var_4, var_5) {
  init_waits();
  var_6 = spawnStruct();
  var_6.caller = self;
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isDefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isDefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isDefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isDefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.waits.run_call_after_wait_array[level.waits.run_call_after_wait_array.size] = var_6;
}

add_noself_call(var_0, var_1, var_2, var_3, var_4, var_5) {
  init_waits();
  var_6 = spawnStruct();
  var_6.func = var_0;
  var_6.parms = [];

  if(isDefined(var_1))
    var_6.parms[var_6.parms.size] = var_1;

  if(isDefined(var_2))
    var_6.parms[var_6.parms.size] = var_2;

  if(isDefined(var_3))
    var_6.parms[var_6.parms.size] = var_3;

  if(isDefined(var_4))
    var_6.parms[var_6.parms.size] = var_4;

  if(isDefined(var_5))
    var_6.parms[var_6.parms.size] = var_5;

  level.waits.run_noself_call_after_wait_array[level.waits.run_noself_call_after_wait_array.size] = var_6;
}

add_endon(var_0) {
  init_waits();
  var_1 = spawnStruct();
  var_1.caller = self;
  var_1.ender = var_0;
  level.waits.do_wait_endons_array[level.waits.do_wait_endons_array.size] = var_1;
}

do_wait_any() {
  init_waits();
  do_wait(level.waits.wait_any_func_array.size - 1);
}

do_wait(var_0) {
  init_waits();

  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = spawnStruct();
  var_2 = level.waits.wait_any_func_array;
  var_3 = level.waits.do_wait_endons_array;
  var_4 = level.waits.run_func_after_wait_array;
  var_5 = level.waits.run_call_after_wait_array;
  var_6 = level.waits.run_noself_call_after_wait_array;
  var_7 = level.waits.abort_wait_any_func_array;
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  var_1.count = var_2.size;
  var_1 scripts\engine\utility::array_levelthread(var_2, scripts\engine\sp\utility_code::waittill_func_ends, var_3);
  var_1 thread scripts\engine\sp\utility_code::do_abort(var_7);
  var_1 endon("any_funcs_aborted");

  for(;;) {
    if(var_1.count <= var_0) {
      break;
    }

    var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(var_4, scripts\engine\sp\utility_code::exec_func, []);
  scripts\engine\utility::array_levelthread(var_5, scripts\engine\sp\utility_code::exec_call);
  scripts\engine\utility::array_levelthread(var_6, scripts\engine\sp\utility_code::exec_call_noself);
}

do_funcs() {
  var_0 = spawnStruct();
  var_1 = level.waits.run_func_after_wait_array;
  level.waits.run_func_after_wait_array = [];

  foreach(var_3 in var_1)
  level scripts\engine\sp\utility_code::exec_func(var_3, []);

  var_0 notify("all_funcs_ended");
}

is_default_start() {
  if(isDefined(level.forced_start_catchup) && level.forced_start_catchup == 1)
    return 0;

  if(isDefined(level.default_start_override_alt) && level.default_start_override_alt == level.start_point)
    return 1;

  if(isDefined(level.default_start_override)) {
    if(level.default_start_override == level.start_point)
      return 1;
  } else if(scripts\sp\starts::level_has_start_points())
    return level.start_point == level.start_functions[0]["name"];

  return level.start_point == "default";
}

manual_linkTo(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  for(;;) {
    self.origin = var_0.origin + var_1;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

nextmission(var_0) {
  scripts\sp\endmission::nextmission_internal(var_0);
}

nextmission_preload(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("nextmission_preload_complete"))
    scripts\engine\utility::flag_init("nextmission_preload_complete");

  scripts\engine\utility::flag_clear("nextmission_preload_complete");
  scripts\sp\endmission::nextmission_preload_internal(var_0, var_1);
  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

nextmission_primeloadbink() {
  scripts\sp\endmission::nextmission_primeloadbink_internal();
}

make_array(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if(isDefined(var_1))
    var_5[var_5.size] = var_1;

  if(isDefined(var_2))
    var_5[var_5.size] = var_2;

  if(isDefined(var_3))
    var_5[var_5.size] = var_3;

  if(isDefined(var_4))
    var_5[var_5.size] = var_4;

  return var_5;
}

fail_on_friendly_fire() {
  level.failonfriendlyfire = 1;
}

normal_friendly_fire_penalty() {
  level.failonfriendlyfire = 0;
}

getplayerclaymores() {
  var_0 = 0;
  var_1 = self.equippedweapons;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_3.basename == "claymore")
      var_0 = var_0 + self getweaponammoclip(var_3);
  }

  return var_0;
}

lerp_saveddvar(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if(var_6 > 0) {
    for(var_7 = var_4 / var_6; var_6; var_6--) {
      var_3 = var_3 + var_7;
      setsaveddvar(var_0, var_3);
      wait(var_5);
    }
  }

  setsaveddvar(var_0, var_1);
}

lerp_omnvar(var_0, var_1, var_2, var_3) {
  var_4 = getomnvar(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_5 = var_1 - var_4;
  var_6 = 0.05;
  var_7 = int(var_2 / var_6);

  for(var_8 = var_5 / var_7; var_7; var_7--) {
    var_4 = var_4 + var_8;

    if(isDefined(var_3)) {
      var_9 = scripts\engine\math::round_float(var_4, var_3);
      setomnvar(var_0, var_9);
    } else
      setomnvar(var_0, var_4);

    wait(var_6);
  }

  if(isDefined(var_3)) {
    var_9 = scripts\engine\math::round_float(var_1, var_3);
    setomnvar(var_0, var_9);
  } else
    setomnvar(var_0, var_1);
}

lerp_omnvarint(var_0, var_1, var_2) {
  var_3 = getomnvar(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for(var_7 = var_4 / var_6; var_6; var_6--) {
    var_3 = var_3 + var_7;
    setomnvar(var_0, int(var_3));
    wait(var_5);
  }

  setomnvar(var_0, int(var_1));
}

slowmo_setspeed_slow(var_0) {
  level.slowmo.speed_slow = var_0;
}

slowmo_setspeed_norm(var_0) {
  level.slowmo.speed_norm = var_0;
}

slowmo_setlerptime_in(var_0) {
  level.slowmo.lerp_time_in = var_0;
}

slowmo_setlerptime_out(var_0) {
  level.slowmo.lerp_time_out = var_0;
}

slowmo_lerp_in() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }
  scripts\sp\audio::set_slowmo_dialogue_start();
  setslowmotion(level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in);
}

slowmo_lerp_out() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }
  setslowmotion(level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out);
  scripts\sp\audio::set_slowmo_dialogue_end();
}

add_earthquake(var_0, var_1, var_2, var_3) {
  level.earthquake[var_0]["magnitude"] = var_1;
  level.earthquake[var_0]["duration"] = var_2;
  level.earthquake[var_0]["radius"] = var_3;
}

get_average_origin(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3.origin;

  return var_1 * (1.0 / var_0.size);
}

generic_damage_think() {
  self.damage_functions = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    foreach(var_11 in self.damage_functions)
    thread[[var_11]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

add_damage_function(var_0) {
  self.damage_functions[self.damage_functions.size] = var_0;
}

remove_damage_function(var_0) {
  var_1 = [];

  foreach(var_3 in self.damage_functions) {
    if(var_3 == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self.damage_functions = var_1;
}

playlocalsoundwrapper(var_0) {
  self playlocalsound(var_0);
}

teleport_player(var_0) {
  level.player setOrigin(var_0.origin);

  if(isDefined(var_0.angles))
    level.player setplayerangles(var_0.angles);
}

translate_local() {
  var_0 = [];

  if(isDefined(self.entities))
    var_0 = self.entities;

  if(isDefined(self.entity))
    var_0[var_0.size] = self.entity;

  scripts\engine\utility::array_levelthread(var_0, scripts\engine\sp\utility_code::translate_local_on_ent);
}

open_up_fov(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player playerlinktodelta(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

get_ai_touching_volume(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = "all";

  if(!isDefined(var_1))
    var_1 = "all";

  var_3 = getaispeciesarray(var_0, var_1);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6 istouching(self))
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

get_drones_touching_volume(var_0) {
  if(!isDefined(var_0))
    var_0 = "all";

  var_1 = [];

  if(var_0 == "all") {
    var_1 = array_merge(level.drones["allies"].array, level.drones["axis"].array);
    var_1 = array_merge(var_1, level.drones["neutral"].array);
  } else
    var_1 = level.drones[var_0].array;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 istouching(self))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_drones_with_targetname(var_0) {
  var_1 = array_merge(level.drones["allies"].array, level.drones["axis"].array);
  var_1 = array_merge(var_1, level.drones["neutral"].array);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.targetname) && var_4.targetname == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

set_count(var_0) {
  self.count = var_0;
}

follow_path(var_0, var_1, var_2) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_3 = self.script_forcegoal;
  self.script_forcegoal = 1;
  scripts\sp\spawner::go_to_node(var_0, var_1, var_2);
  self.script_forcegoal = var_3;

  if(!isDefined(self.script_forcegoal) || !self.script_forcegoal)
    self.goalradius = level.default_goalradius;
}

enable_dynamic_run_speed(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  setdvarifuninitialized("scr_debug_dynamic_run_speed", 0);
  disable_dynamic_run_speed(0);

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 205;

  if(!isDefined(var_3))
    var_3 = 250;

  if(!isDefined(var_4))
    var_4 = 100;

  if(!isDefined(var_5))
    var_5 = -100;

  if(!isDefined(var_6))
    var_6 = -200;

  thread scripts\engine\sp\utility_code::dynamic_run_speed_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

disable_dynamic_run_speed(var_0) {
  if(!isDefined(var_0))
    var_0 = 165;

  self notify("stop_dynamic_run_speed");

  if(istrue(var_0))
    scripts\engine\utility::set_movement_speed(var_0);
}

waittill_entity_in_range_or_timeout(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_2))
    var_2 = 5;

  var_3 = gettime() + var_2 * 1000;

  while(isDefined(var_0)) {
    if(distancesquared(var_0.origin, self.origin) <= var_1 * var_1) {
      break;
    }

    if(gettime() > var_3) {
      break;
    }

    wait 0.1;
  }
}

waittill_entity_in_range(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distancesquared(var_0.origin, self.origin) <= var_1 * var_1) {
      break;
    }

    wait 0.1;
  }
}

waittill_entity_out_of_range(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distancesquared(var_0.origin, self.origin) > var_1 * var_1) {
      break;
    }

    wait 0.1;
  }
}

player_speed_percent(var_0, var_1) {
  var_2 = int(getDvar("NSRPQNLSNK"));

  if(!isDefined(level.player.g_speed))
    level.player.g_speed = var_2;

  var_3 = int(level.player.g_speed * var_0 * 0.01);
  level.player player_speed_set(var_3, var_1);
}

blend_movespeedscale_percent(var_0, var_1, var_2) {
  var_3 = self;

  if(!isPlayer(var_3))
    var_3 = level.player;

  if(!isDefined(var_3.movespeedscale))
    var_3.movespeedscale = 1.0;

  var_4 = var_0 * 0.01;
  var_3 blend_movespeedscale(var_4, var_1, var_2);
}

player_speed_set(var_0, var_1) {
  var_2 = int(getDvar("NSRPQNLSNK"));

  if(!isDefined(level.player.g_speed))
    level.player.g_speed = var_2;

  var_3 = scripts\engine\sp\utility_code::g_speed_get_func;
  var_4 = scripts\engine\sp\utility_code::g_speed_set_func;
  level.player thread player_speed_proc(var_0, var_1, var_3, var_4, "player_speed_set");
}

player_bob_scale_set(var_0, var_1) {
  var_2 = scripts\engine\sp\utility_code::g_bob_scale_get_func;
  var_3 = scripts\engine\sp\utility_code::g_bob_scale_set_func;
  level.player thread player_speed_proc(var_0, var_1, var_2, var_3, "player_bob_scale_set");
}

blend_movespeedscale(var_0, var_1, var_2) {
  var_3 = self;

  if(!isPlayer(var_3))
    var_3 = level.player;

  if(!isDefined(var_3.movespeedscale))
    var_3.movespeedscale = 1.0;

  var_4 = scripts\engine\sp\utility_code::movespeed_get_func;
  var_5 = scripts\engine\sp\utility_code::movespeed_set_func;
  var_3 thread player_speed_proc(var_0, var_1, var_4, var_5, "blend_movespeedscale", var_2);
}

player_speed_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify(var_4);
  self endon(var_4);
  var_6 = [[var_2]](var_5);
  var_7 = var_0;

  if(isDefined(var_1) && var_1 > 0) {
    var_8 = var_7 - var_6;
    var_9 = 0.05;
    var_10 = var_1 / var_9;
    var_11 = var_8 / var_10;

    while(abs(var_7 - var_6) > abs(var_11 * 1.1)) {
      var_6 = var_6 + var_11;
      [[var_3]](var_6, var_5);
      wait(var_9);
    }
  }

  [[var_3]](var_7, var_5);
}

player_speed_default(var_0) {
  if(!isDefined(level.player.g_speed)) {
    return;
  }
  level.player player_speed_set(level.player.g_speed, var_0);
  waittillframeend;
  level.player.g_speed = undefined;
}

blend_movespeedscale_default(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2))
    var_2 = level.player;

  if(!isDefined(var_2.movespeedscale)) {
    return;
  }
  var_2 blend_movespeedscale(1.0, var_0, var_1);
  var_2.movespeedscale = undefined;
}

teleport_ent(var_0) {
  if(isPlayer(self)) {
    self setOrigin(var_0.origin);
    self setplayerangles(var_0.angles);
  } else if(isai(self))
    self forceteleport(var_0.origin, var_0.angles);
  else {
    self.origin = var_0.origin;
    self.angles = var_0.angles;
  }
}

teleport_to_ent_tag(var_0, var_1) {
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  self dontinterpolate();

  if(isPlayer(self)) {
    self setOrigin(var_2);
    self setplayerangles(var_3);
  } else if(isai(self))
    self forceteleport(var_2, var_3);
  else {
    self.origin = var_2;
    self.angles = var_3;
  }
}

teleport_ai(var_0) {
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(self.origin);
  self setgoalnode(var_0);
}

move_all_fx(var_0) {
  foreach(var_2 in level.createfxent)
  var_2.v["origin"] = var_2.v["origin"] + var_0;
}

issliding() {
  return self issprintsliding();
}

beginsliding(var_0, var_1, var_2) {
  self endon("stop_sliding");
  self endon("death");
  var_3 = self;

  if(var_3 scripts\engine\utility::ent_flag_exist("is_sliding"))
    var_3 scripts\engine\utility::ent_flag_clear("is_sliding");
  else
    var_3 scripts\engine\utility::ent_flag_init("is_sliding");

  var_4 = isDefined(level.custom_linkto_slide);
  var_5 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.slidemodel = var_5;
  var_6 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.fx_tag = var_6;
  var_7 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0);
  var_8 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_3, var_7);
  var_9 = 0;
  var_10 = (0, 0, 0);
  var_11 = var_8["normal"];

  for(;;) {
    if(!var_3 isjumping()) {
      var_8 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var_3, var_7);
      var_11 = var_8["normal"];

      if(isDefined(var_11)) {
        var_12 = vectordot(var_11, (0, 0, 1));

        if(var_12 <= 0.95) {
          var_9 = acos(var_12);
          var_10 = var_8["position"];
          break;
        }
      }
    }

    wait 0.05;
  }

  var_11 = vectorNormalize(scripts\engine\utility::flatten_vector(var_11, (0, 0, 1)));
  var_13 = vectorNormalize(vectorcross(var_11, (0, 1, 0)));
  var_14 = vectorNormalize(vectorcross(var_11, var_13));
  var_5.angles = var_3.angles;
  var_5.origin = var_3.origin;
  var_15 = vectortoangles(var_11) + var_11 * var_9;
  var_5.gesture_target = spawn("script_model", var_5.origin + anglesToForward(var_15) * 2000);
  var_5.gesture_target.angles = var_15;
  var_3.fx_tag.angles = var_15;

  if(!isDefined(var_0))
    var_0 = var_3 getvelocity() + (0, 0, -10);

  if(!isDefined(var_1))
    var_1 = 10;

  if(!isDefined(var_2))
    var_2 = 0.035;

  var_5 moveslide((0, 0, 15), 15, var_0);
  var_3 thread play_sound_on_entity("foot_slide_plr_start");
  var_3 hidelegsandshadow();
  var_3 forceplaygestureviewmodel("ges_slide", var_5.gesture_target, 0.2);

  if(isDefined(level._effect["vfx_slide_dirt"])) {
    var_16 = scripts\engine\utility::getfx("vfx_slide_dirt");
    playFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_3.fx_tag, "tag_origin");
    var_3.fx_tag show();
  }

  var_3 scripts\engine\utility::ent_flag_set("is_sliding");

  if(var_4) {
    var_3 playerlinktoblend(var_5, undefined, 1);
    wait 1.0;
    var_3 playerlinktodelta(var_5, "tag_origin", 1, 180, 180, 180, 180, 1);
  } else
    var_3 playerlinktodelta(var_5, "tag_origin", 0, 180, 180, 180, 180);

  setsaveddvar("NMLOKNMRSK", 1);
  var_3 scripts\common\utility::allow_fire(0);
  var_3 scripts\common\utility::allow_prone(0);
  var_3 scripts\common\utility::allow_stand(0);
  var_3 scripts\common\utility::allow_reload(0);
  var_3 thread scripts\engine\sp\utility_code::doslide(var_5, var_1, var_2);
  var_3 thread play_loop_sound_on_tag("foot_slide_plr_loop");
}

endsliding() {
  var_0 = self;

  if(level.player isgestureplaying()) {
    var_0 stopgestureviewmodel("ges_slide");
    var_0 notify("stop soundfoot_slide_plr_loop");
    var_0 thread play_sound_on_entity("foot_slide_plr_end");
  }

  var_0 scripts\engine\utility::delaycall(0.2, ::showlegsandshadow);

  if(level.player islinked()) {
    var_0 unlink();
    var_0 setvelocity(var_0.slidemodel.slidevelocity);
  }

  if(isDefined(var_0.fx_tag)) {
    if(isDefined(level._effect["vfx_slide_dirt"])) {
      var_1 = scripts\engine\utility::getfx("vfx_slide_dirt");

      if(isDefined(var_1))
        stopFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var_0.fx_tag, "tag_origin");
    }

    var_0.fx_tag delete();
  }

  if(var_0 scripts\engine\utility::ent_flag_exist("is_sliding") && var_0 scripts\engine\utility::ent_flag("is_sliding")) {
    var_0 scripts\engine\utility::ent_flag_clear("is_sliding");
    var_0 scripts\common\utility::allow_fire(1);
    var_0 scripts\common\utility::allow_prone(1);
    var_0 scripts\common\utility::allow_stand(1);
    var_0 scripts\common\utility::allow_reload(1);
  }

  var_0.slidemodel delete();
  setsaveddvar("NMLOKNMRSK", 0);
  var_0 notify("stop_sliding");
}

beginslidinglegacy(var_0, var_1, var_2) {
  var_3 = self;

  if(var_3 scripts\engine\utility::ent_flag_exist("is_sliding"))
    var_3 scripts\engine\utility::ent_flag_clear("is_sliding");
  else
    var_3 scripts\engine\utility::ent_flag_init("is_sliding");

  var_3 thread play_sound_on_entity("foot_slide_plr_start");
  var_3 thread play_loop_sound_on_tag("foot_slide_plr_loop");
  var_4 = isDefined(level.custom_linkto_slide);

  if(!isDefined(var_0))
    var_0 = var_3 getvelocity() + (0, 0, -10);

  if(!isDefined(var_1))
    var_1 = 10;

  if(!isDefined(var_2))
    var_2 = 0.035;

  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3.slidemodel = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);
  var_3 scripts\engine\utility::ent_flag_set("is_sliding");

  if(var_4)
    var_3 playerlinktoblend(var_5, undefined, 1);
  else
    var_3 playerlinkTo(var_5);

  var_3 scripts\common\utility::allow_weapon(0);
  var_3 scripts\common\utility::allow_prone(0);
  var_3 scripts\common\utility::allow_crouch(1);
  var_3 scripts\common\utility::allow_stand(0);
  var_3 thread scripts\engine\sp\utility_code::doslide(var_5, var_1, var_2);
}

endslidinglegacy() {
  var_0 = self;
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread play_sound_on_entity("foot_slide_plr_end");
  var_0 unlink();
  var_0 setvelocity(var_0.slidemodel.slidevelocity);
  var_0.slidemodel delete();
  var_0 scripts\common\utility::allow_weapon(1);
  var_0 scripts\common\utility::allow_prone(1);
  var_0 scripts\common\utility::allow_crouch(1);
  var_0 scripts\common\utility::allow_stand(1);
  var_0 notify("stop_sliding");

  if(var_0 scripts\engine\utility::ent_flag_exist("is_sliding") && var_0 scripts\engine\utility::ent_flag("is_sliding"))
    var_0 scripts\engine\utility::ent_flag_clear("is_sliding");
}

getentwithflag(var_0) {
  var_1 = scripts\sp\trigger::get_load_trigger_classes();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_7 = scripts\sp\trigger::get_load_trigger_funcs();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_10 = undefined;

  foreach(var_12 in var_2) {
    if(var_12.script_flag == var_0)
      return var_12;
  }
}

getentarraywithflag(var_0) {
  var_1 = scripts\sp\trigger::get_load_trigger_classes();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_7 = scripts\sp\trigger::get_load_trigger_funcs();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  var_10 = [];

  foreach(var_12 in var_2) {
    if(var_12.script_flag == var_0)
      var_10[var_10.size] = var_12;
  }

  return var_10;
}

set_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_1);
}

set_y(var_0, var_1) {
  return (var_0[0], var_1, var_0[2]);
}

set_x(var_0, var_1) {
  return (var_1, var_0[1], var_0[2]);
}

get_rumble_ent(var_0) {
  var_1 = get_player_from_self();

  if(!isDefined(var_0))
    var_0 = "steady_rumble";

  var_2 = spawn("script_origin", var_1 getEye());
  var_2.intensity = 1;
  var_2 thread scripts\engine\sp\utility_code::update_rumble_intensity(var_1, var_0);
  return var_2;
}

set_rumble_intensity(var_0) {
  self.intensity = var_0;
}

rumble_ramp_on(var_0) {
  thread rumble_ramp_to(1, var_0);
}

rumble_ramp_off(var_0) {
  thread rumble_ramp_to(0, var_0);
}

rumble_ramp_to(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self.intensity;
  var_4 = var_3 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity = self.intensity + var_4;
    wait 0.05;
  }

  self.intensity = var_0;
}

get_player_from_self() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self))
      return level.player;
    else
      return self;
  } else
    return level.player;
}

get_player_gameskill() {
  return int(self getplayersetting("gameskill"));
}

array_delete_evenly(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach(var_5 in var_0) {
    var_3[var_3.size] = var_5;

    if(var_3.size == var_2) {
      var_3 = scripts\engine\utility::array_randomize(var_3);

      for(var_6 = var_1; var_6 < var_3.size; var_6++)
        var_3[var_6] delete();

      var_3 = [];
    }
  }

  var_8 = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_8[var_8.size] = var_5;
  }

  return var_8;
}

waittill_in_range(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.5;

  self endon("death");

  while(isDefined(self)) {
    if(distancesquared(var_0, self.origin) <= var_1 * var_1) {
      break;
    }

    wait(var_2);
  }
}

waittill_out_of_range(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.5;

  self endon("death");

  while(isDefined(self)) {
    if(distancesquared(var_0, self.origin) > var_1 * var_1) {
      break;
    }

    wait(var_2);
  }
}

disable_surprise() {
  self.newenemyreactiondistsq = 0;
}

enable_surprise() {
  self.newenemyreactiondistsq = squared(512);
}

getvehiclearray() {
  return vehicle_getarray();
}

getteamvehiclearray(var_0) {
  if(!isarray(var_0))
    var_0[0] = var_0;

  var_1 = vehicle_getarray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.team) && scripts\engine\utility::array_contains(var_0, var_3.team))
      continue;
    else
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  return var_1;
}

getvehiclearray_in_radius(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, vehicle_getarray(), undefined, undefined, var_1);

  if(isDefined(var_2)) {
    var_4 = [];

    foreach(var_6 in var_3) {
      if(scripts\engine\utility::is_equal(var_6.script_team, var_2))
        var_4[var_4.size] = var_6;
    }

    var_3 = var_4;
  }

  return var_3;
}

hint(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level.hintelement))
    level.hintelement scripts\sp\hud_util::destroyelem();

  level.hintelement = scripts\sp\hud_util::createfontstring("default", 1.5);
  level.hintelement scripts\sp\hud_util::setpoint("MIDDLE", undefined, 0, 30 + var_2);
  level.hintelement.color = (1, 1, 1);
  level.hintelement settext(var_0);
  level.hintelement.alpha = 0;
  level.hintelement fadeovertime(0.5);
  level.hintelement.alpha = 1;
  wait 0.5;
  level.hintelement endon("death");

  if(isDefined(var_1))
    wait(var_1);
  else
    return;

  level.hintelement fadeovertime(var_3);
  level.hintelement.alpha = 0;
  wait(var_3);
  level.hintelement scripts\sp\hud_util::destroyelem();
}

hint_fade() {
  var_0 = 1;

  if(isDefined(level.hintelement)) {
    level notify("clearing_hints");
    level.hintelement fadeovertime(var_0);
    level.hintelement.alpha = 0;
    wait(var_0);
  }
}

kill_deathflag(var_0, var_1) {
  if(!isDefined(level.flag[var_0])) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in level.deathflags[var_0]) {
    foreach(var_5 in var_3) {
      if(isalive(var_5)) {
        var_5 thread scripts\engine\sp\utility_code::kill_deathflag_proc(var_1);
        continue;
      }

      var_5 delete();
    }
  }
}

get_player_view_controller(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = "player_view_controller";

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setModel("tag_turret");
  var_5 linkTo(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 setmode("manual");
  return var_5;
}

create_blend(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 childthread scripts\engine\sp\utility_code::process_blend(var_0, self, var_1, var_2, var_3);
  return var_4;
}

store_players_weapons(var_0) {
  if(!isDefined(self.stored_weapons))
    self.stored_weapons = [];

  var_1 = [];
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    var_5 = createheadicon(var_4);
    var_1[var_5] = [];
    var_1[var_5]["clip_left"] = self getweaponammoclip(var_4, "left");
    var_1[var_5]["clip_right"] = self getweaponammoclip(var_4, "right");
    var_1[var_5]["stock"] = self getweaponammostock(var_4);
  }

  if(!isDefined(var_0))
    var_0 = "default";

  self.stored_weapons[var_0] = [];
  self.stored_weapons[var_0]["current_weapon"] = self getcurrentweapon();
  self.stored_weapons[var_0]["inventory"] = var_1;
}

restore_players_weapons(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "default";

  if(!isDefined(self.stored_weapons) || !isDefined(self.stored_weapons[var_0])) {
    return;
  }
  self takeallweapons();

  foreach(var_4, var_3 in self.stored_weapons[var_0]["inventory"]) {
    if(weaponinventorytype(var_4) != "altmode")
      self giveweapon(var_4);

    self setweaponammoclip(var_4, var_3["clip_left"], "left");
    self setweaponammoclip(var_4, var_3["clip_right"], "right");
    self setweaponammostock(var_4, var_3["stock"]);
  }

  var_5 = self.stored_weapons[var_0]["current_weapon"];

  if(!nullweapon(var_5)) {
    if(istrue(var_1))
      self switchtoweaponimmediate(var_5);
    else
      self switchtoweapon(var_5);
  }
}

hide_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;
    case "script_brushmodel":
      self hide();
      self notsolid();

      if(self.spawnflags & 1)
        self connectpaths();

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      scripts\engine\utility::trigger_off();
      break;
    default:
  }
}

show_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;
    case "script_brushmodel":
      self show();
      self solid();

      if(self.spawnflags & 1)
        self disconnectPaths();

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      scripts\engine\utility::trigger_on();
      break;
    default:
  }
}

set_moveplaybackrate(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  self endon("death");

  if(isDefined(var_1)) {
    var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
    var_3 = var_0 - var_2;
    var_4 = 0.05;
    var_5 = var_1 / var_4;

    for(var_6 = var_3 / var_5; abs(var_0 - var_2) > abs(var_6 * 1.1); var_2 = scripts\asm\asm::asm_getmoveplaybackrate()) {
      scripts\asm\asm::asm_setmoveplaybackrate(var_2 + var_6);
      wait(var_4);
    }
  }

  scripts\asm\asm::asm_setmoveplaybackrate(var_0);
}

array_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0)
  var_7 thread add_spawn_function(var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_targetname(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getspawnerarray(var_0);
  var_6 = array_merge(var_6, getEntArray(var_0, "targetname"));
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_noteworthy(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_spawner_array(var_0, "script_noteworthy");
  var_6 = array_merge(var_6, getEntArray(var_0, "script_noteworthy"));
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

array_spawn_function_aigroup(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_ai_group_spawners(var_0);
  array_spawn_function(var_6, var_1, var_2, var_3, var_4, var_5);
}

enable_dontevershoot() {
  self.dontevershoot = 1;
}

disable_dontevershoot() {
  self.dontevershoot = 0;
}

create_sunflare_setting(var_0) {
  if(!isDefined(level.sunflare_settings))
    level.sunflare_settings = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  level.sunflare_settings[var_0] = var_1;
  return var_1;
}

mask_exploders_in_volume(var_0) {
  if(getDvar("LSTTOTKPNP") != "") {
    return;
  }
  var_1 = getEntArray("script_brushmodel", "classname");
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_1[var_1.size] = var_2[var_3];

  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.script_prefab_exploder))
        var_7.script_exploder = var_7.script_prefab_exploder;

      if(!isDefined(var_7.script_exploder)) {
        continue;
      }
      if(!isDefined(var_7.model)) {
        continue;
      }
      if(var_7.code_classname != "script_model") {
        continue;
      }
      if(!var_7 istouching(var_5)) {
        continue;
      }
      var_7.masked_exploder = 1;
    }
  }
}

activate_exploders_in_volume() {
  var_0 = spawn("script_origin", (0, 0, 0));

  foreach(var_2 in level.createfxent) {
    if(!isDefined(var_2.v["masked_exploder"])) {
      continue;
    }
    var_0.origin = var_2.v["origin"];
    var_0.angles = var_2.v["angles"];

    if(!var_0 istouching(self)) {
      continue;
    }
    var_3 = var_2.v["masked_exploder"];
    var_4 = var_2.v["masked_exploder_spawnflags"];
    var_5 = var_2.v["masked_exploder_script_disconnectpaths"];
    var_6 = spawn("script_model", (0, 0, 0), var_4);
    var_6 setModel(var_3);
    var_6.origin = var_2.v["origin"];
    var_6.angles = var_2.v["angles"];
    var_2.v["masked_exploder"] = undefined;
    var_2.v["masked_exploder_spawnflags"] = undefined;
    var_2.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_6.disconnect_paths = var_5;
    var_6.script_exploder = var_2.v["exploder"];
    scripts\common\exploder::setup_individual_exploder(var_6);
    var_2.model = var_6;
  }

  var_0 delete();
}

delete_destructibles_in_volumes(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3.destructibles = [];

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_8 in var_5) {
    var_9 = getEntArray(var_8, "targetname");

    foreach(var_11 in var_9) {
      foreach(var_3 in var_0) {
        if(var_1) {
          var_6++;
          var_6 = var_6 % 5;

          if(var_6 == 1)
            wait 0.05;
        }

        if(!var_3 istouching(var_11)) {
          continue;
        }
        var_11 delete();
        break;
      }
    }
  }
}

delete_exploders_in_volumes(var_0, var_1) {
  var_2 = getEntArray("script_brushmodel", "classname");
  var_3 = getEntArray("script_model", "classname");

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_2[var_2.size] = var_3[var_4];

  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_9 in var_0) {
    foreach(var_11 in var_2) {
      if(!isDefined(var_11.script_exploder)) {
        continue;
      }
      var_6.origin = var_11 getorigin();

      if(!var_9 istouching(var_6)) {
        continue;
      }
      var_5[var_5.size] = var_11;
    }
  }

  scripts\engine\utility::array_delete(var_5);
  var_6 delete();
}

waittill_volume_dead() {
  for(;;) {
    var_0 = getaispeciesarray("axis", "all");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3 istouching(self)) {
        var_1 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_1) {
      var_5 = get_ai_touching_volume("axis");

      if(!var_5.size) {
        break;
      }
    }

    wait 0.05;
  }
}

waittill_volume_dead_or_dying() {
  var_0 = 0;

  for(;;) {
    var_1 = getaispeciesarray("axis", "all");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isalive(var_4)) {
        continue;
      }
      if(var_4 istouching(self)) {
        if(var_4 scripts\engine\utility::doinglongdeath()) {
          continue;
        }
        var_2 = 1;
        var_0 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_2) {
      var_6 = get_ai_touching_volume("axis");

      if(!var_6.size) {
        break;
      } else
        var_0 = 1;
    }

    wait 0.05;
  }

  return var_0;
}

waittill_volume_dead_then_set_flag(var_0) {
  waittill_volume_dead();
  scripts\engine\utility::flag_set(var_0);
}

waittill_targetname_volume_dead_then_set_flag(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 waittill_volume_dead_then_set_flag(var_1);
}

array_index_by_parameters(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3.script_parameters] = var_3;

  return var_1;
}

array_index_by_classname(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3.classname] = var_3;

  return var_1;
}

array_index_by_script_index(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_index))
      var_1[var_3.script_index] = var_3;
  }

  return var_1;
}

get_color_volume_from_trigger() {
  var_0 = scripts\engine\sp\utility_code::get_color_info_from_trigger();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level.arrays_of_colorcoded_volumes[var_1][var_3];

    if(isDefined(var_4))
      return var_4;
  }

  return undefined;
}

get_color_nodes_from_trigger() {
  var_0 = scripts\engine\sp\utility_code::get_color_info_from_trigger();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level.arrays_of_colorcoded_nodes[var_1][var_3];

    if(isDefined(var_4))
      return var_4;
  }

  return undefined;
}

get_splineid(var_0) {
  return getcsplineid(var_0);
}

get_splineidarray(var_0) {
  return getcsplineidarray(var_0);
}

earthquake_and_rumble(var_0) {
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.5, var_0, 400);
}

pathrandompercent_set(var_0) {
  if(!isDefined(self.old_pathrandompercent))
    self.old_pathrandompercent = self.pathrandompercent;

  self.pathrandompercent = var_0;
}

pathrandompercent_zero() {
  if(isDefined(self.old_pathrandompercent)) {
    return;
  }
  self.old_pathrandompercent = self.pathrandompercent;
  self.pathrandompercent = 0;
}

pathrandompercent_reset() {
  self.pathrandompercent = self.old_pathrandompercent;
  self.old_pathrandompercent = undefined;
}

walkdist_zero() {
  if(isDefined(self.old_walkdistfacingmotion)) {
    return;
  }
  self.old_walkdist = self.walkdist;
  self.old_walkdistfacingmotion = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
}

walkdist_reset() {
  self.walkdist = self.old_walkdist;
  self.walkdistfacingmotion = self.old_walkdistfacingmotion;
  self.old_walkdist = undefined;
  self.old_walkdistfacingmotion = undefined;
}

enable_ignorerandombulletdamage_drone() {
  thread ignorerandombulletdamage_drone_proc();
}

ignorerandombulletdamage_drone_proc() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.ignorerandombulletdamage = 1;
  self.fakehealth = self.health;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isPlayer(var_1) && issentient(var_1)) {
      if(isDefined(var_1.enemy) && var_1.enemy != self)
        continue;
    }

    self.fakehealth = self.fakehealth - var_0;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  self kill();
}

hide_notsolid() {
  if(!isai(self))
    self notsolid();

  self hide();
}

show_solid() {
  if(!isai(self))
    self solid();

  self show();
}

set_brakes(var_0) {
  self.veh_brake = var_0;
}

disable_ignorerandombulletdamage_drone() {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self.ignorerandombulletdamage)) {
    return;
  }
  self notify("disable_ignorerandombulletdamage_drone");
  self.ignorerandombulletdamage = undefined;
  self.health = self.fakehealth;
}

timeoutent(var_0) {
  var_1 = spawnStruct();
  var_1 scripts\engine\utility::delaythread(var_0, scripts\engine\utility::send_notify, "timeout");
  return var_1;
}

delaychildthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  childthread scripts\engine\sp\utility_code::delaychildthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

flagwaitthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isarray(var_0))
    var_0 = [var_0, 0];

  thread scripts\engine\sp\utility_code::flagwaitthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

waittillthread(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isarray(var_0))
    var_0 = [var_0, 0];

  thread scripts\engine\sp\utility_code::waittillthread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

enable_danger_react(var_0) {
  var_0 = var_0 * 1000;
  self.dodangerreact = 1;
  self.dangerreactduration = var_0;
  self.neversprintforvariation = undefined;
}

disable_danger_react() {
  self.dodangerreact = 0;
  self.neversprintforvariation = 1;
}

set_group_advance_to_enemy_parameters(var_0, var_1) {
  level.advancetoenemyinterval = var_0;
  level.advancetoenemygroupmax = var_1;
}

reset_group_advance_to_enemy_timer(var_0) {
  level.lastadvancetoenemytime[var_0] = gettime();
}

string_is_single_digit_integer(var_0) {
  if(var_0.size > 1)
    return 0;

  var_1 = [];
  var_1["0"] = 1;
  var_1["1"] = 1;
  var_1["2"] = 1;
  var_1["3"] = 1;
  var_1["4"] = 1;
  var_1["5"] = 1;
  var_1["6"] = 1;
  var_1["7"] = 1;
  var_1["8"] = 1;
  var_1["9"] = 1;

  if(isDefined(var_1[var_0]))
    return 1;

  return 0;
}

set_battlechatter_variable(var_0, var_1) {
  level.battlechatter[var_0] = var_1;
  scripts\engine\sp\utility_code::update_battlechatter_hud();
}

get_minutes_and_seconds(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for(var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60)
    var_1["minutes"]++;

  if(var_1["seconds"] < 10)
    var_1["seconds"] = "0" + var_1["seconds"];

  return var_1;
}

player_has_weapon(var_0) {
  var_1 = var_0;

  if(isstring(var_0))
    var_1 = asmdevgetallstates(var_0);

  var_2 = level.player.primaryinventory;

  foreach(var_4 in var_2) {
    if(isnullweapon(var_4, var_1, 1))
      return 1;
  }

  return 0;
}

player_has_base_weapon(var_0) {
  var_1 = var_0;

  if(isstring(var_0))
    var_1 = asmdevgetallstates(var_0);

  var_2 = level.player.primaryinventory;

  foreach(var_4 in var_2) {
    if(var_4.basename == var_1.basename)
      return 1;
  }

  return 0;
}

player_has_equipment(var_0, var_1) {
  var_2 = var_0;

  if(isstring(var_0))
    var_2 = asmdevgetallstates(var_0);

  var_3 = level.player.offhandinventory;

  foreach(var_5 in var_3) {
    if(isnullweapon(var_5, var_2, 1))
      return 1;
  }

  return 0;
}

graph_position(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = var_3 - var_1;
  var_7 = var_5 / var_6;
  var_0 = var_0 - var_3;
  var_0 = var_7 * var_0;
  var_0 = var_0 + var_4;
  return var_0;
}

musiclength(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 * 0.001;
  return var_1;
}

is_command_bound(var_0) {
  var_1 = getkeybinding(var_0);
  return var_1["count"];
}

template_level(var_0) {
  iprintlnbold("remove 'template_level( " + var_0 + " );' from " + var_0 + ".gsc - this will error as of 5/19");
}

fx_volume_pause_noteworthy(var_0, var_1) {
  thread fx_volume_pause_noteworthy_thread(var_0, var_1);
}

fx_volume_pause_noteworthy_thread(var_0, var_1) {
  var_2 = getEnt(var_0, "script_noteworthy");
  var_2 notify("new_volume_command");
  var_2 endon("new_volume_command");
  wait 0.05;
  scripts\engine\sp\utility_code::fx_volume_pause(var_2, var_1);
}

fx_volume_restart_noteworthy(var_0) {
  thread fx_volume_restart_noteworthy_thread(var_0);
}

fx_volume_restart_noteworthy_thread(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 notify("new_volume_command");
  var_1 endon("new_volume_command");
  wait 0.05;

  if(!isDefined(var_1.fx_paused)) {
    return;
  }
  var_1.fx_paused = undefined;
  fx_volume_restart(var_1);
}

fx_volume_restart(var_0) {
  scripts\engine\utility::array_thread(var_0.fx, ::restarteffect);
}

add_cleanup_ent(var_0, var_1) {
  if(!isDefined(level.cleanup_ents))
    level.cleanup_ents = [];

  if(!isDefined(level.cleanup_ents[var_1]))
    level.cleanup_ents[var_1] = [];

  level.cleanup_ents[var_1][level.cleanup_ents[var_1].size] = var_0;
}

cleanup_ents(var_0) {
  var_1 = level.cleanup_ents[var_0];
  var_1 = scripts\engine\utility::array_removeundefined(var_1);
  scripts\engine\utility::array_delete(var_1);
  level.cleanup_ents[var_0] = undefined;
}

cleanup_ents_removing_bullet_shield(var_0) {
  if(!isDefined(level.cleanup_ents)) {
    return;
  }
  if(!isDefined(level.cleanup_ents[var_0])) {
    return;
  }
  var_1 = level.cleanup_ents[var_0];
  var_1 = scripts\engine\utility::array_removeundefined(var_1);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3.magic_bullet_shield)) {
      continue;
    }
    if(!var_3.magic_bullet_shield) {
      continue;
    }
    var_3 scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\engine\utility::array_delete(var_1);
  level.cleanup_ents[var_0] = undefined;
}

add_trigger_function(var_0) {
  if(!isDefined(self.trigger_functions))
    thread scripts\engine\sp\utility_code::add_trigger_func_thread();

  self.trigger_functions[self.trigger_functions.size] = var_0;
}

getallweapons() {
  var_0 = [];
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.classname)) {
      continue;
    }
    if(scripts\engine\utility::string_starts_with(var_3.classname, "weapon_"))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

move_with_rate(var_0, var_1, var_2) {
  self notify("newmove");
  self endon("newmove");

  if(!isDefined(var_2))
    var_2 = 200;

  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectorNormalize(var_0 - self.origin);
  self moveTo(var_0, var_4, 0, 0);
  self rotateTo(var_1, var_4, 0, 0);
  wait(var_4);

  if(!isDefined(self)) {
    return;
  }
  self.velocity = var_5 * (var_3 / var_4);
}

flag_on_death(var_0) {
  level endon(var_0);
  self waittill("death");
  scripts\engine\utility::flag_set(var_0);
}

enable_damagefeedback() {
  level.damagefeedback = 1;
}

disable_damagefeedback() {
  level.damagefeedback = 0;
}

is_damagefeedback_enabled() {
  return isDefined(level.damagefeedback) && level.damagefeedback;
}

worldtolocalcoords(var_0) {
  var_1 = var_0 - self.origin;
  return (vectordot(var_1, anglesToForward(self.angles)), -1.0 * vectordot(var_1, anglestoright(self.angles)), vectordot(var_1, anglestoup(self.angles)));
}

sound_fade_and_delete(var_0, var_1) {
  self scalevolume(0, var_0);

  if(istrue(var_1))
    scripts\engine\utility::delaycall(var_0 + 0.05, ::stoploopsound);
  else
    scripts\engine\utility::delaycall(var_0 + 0.05, ::stopsounds);

  scripts\engine\utility::delaycall(var_0 + 0.1, ::delete);
}

sound_fade_in(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_1 = clamp(var_1, 0, 1);
  var_2 = max(0.05, var_2);
  self scalevolume(0.0);
  wait 0.05;

  if(isDefined(var_3))
    self playLoopSound(var_0);
  else
    self playSound(var_0);

  wait 0.05;
  scripts\engine\utility::delaycall(0.05, ::scalevolume, var_1, var_2);
}

intro_screen_create(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.introscreen))
    level.introscreen = spawnStruct();

  level.introscreen.completed_delay = 3;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = undefined;
  level.introscreen.lines = [var_0, var_1, var_2, var_3, var_4];
  scripts\engine\utility::noself_array_call(level.introscreen.lines, ::precachestring);
}

intro_screen_custom_func(var_0) {
  if(!isDefined(level.introscreen))
    level.introscreen = spawnStruct();

  level.introscreen.customfunc = var_0;
}

register_archetype(var_0, var_1, var_2) {
  scripts\anim\animset.gsc::registerarchetype(var_0, var_1, var_2);
}

archetype_exists(var_0) {
  return scripts\anim\animset.gsc::archetypeexists(var_0);
}

set_archetype(var_0) {
  self.animarchetype = var_0;
  self notify("move_loop_restart");

  if(var_0 == "creepwalk")
    self.sharpturnlookaheaddist = 72;
}

clear_archetype() {
  if(isDefined(self.animarchetype) && self.animarchetype == "creepwalk")
    self.sharpturnlookaheaddist = 30;

  self.animarchetype = undefined;
  self notify("move_loop_restart");
}

transient_load(var_0) {
  if(istransientloaded(var_0)) {
    return;
  }
  if(!scripts\engine\utility::flag_exist(var_0 + "_loaded"))
    scripts\engine\utility::flag_init(var_0 + "_loaded");

  loadtransient(var_0);

  while(!istransientloaded(var_0))
    waitframe();

  scripts\engine\utility::flag_set(var_0 + "_loaded");
  level notify("new_transient_loaded");
}

transient_unload(var_0) {
  if(!istransientloaded(var_0)) {
    return;
  }
  unloadtransient(var_0);

  while(istransientloaded(var_0))
    waitframe();

  scripts\engine\utility::flag_clear(var_0 + "_loaded");
}

transient_load_array(var_0) {
  foreach(var_2 in var_0)
  thread transient_load(var_2);

  for(;;) {
    var_4 = 1;

    foreach(var_2 in var_0) {
      if(!istransientloaded(var_2)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      break;
    }

    waitframe();
  }

  level notify("new_transient_loaded");
}

transient_unload_array(var_0) {
  foreach(var_2 in var_0)
  thread transient_unload(var_2);

  for(;;) {
    var_4 = 1;

    foreach(var_2 in var_0) {
      if(istransientloaded(var_2)) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      break;
    }

    waitframe();
  }
}

transient_init(var_0) {
  scripts\engine\utility::flag_init(var_0 + "_loaded");
}

transient_switch(var_0, var_1) {
  if(scripts\engine\utility::flag(var_0 + "_loaded"))
    transient_unload(var_0);

  if(!scripts\engine\utility::flag(var_1 + "_loaded"))
    transient_load(var_1);
}

transient_unloadall_and_load(var_0) {
  unloadalltransients();
  transient_load(var_0);
}

follow_path_and_animate(var_0, var_1) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;

  if(!isDefined(var_1))
    var_1 = 300;

  self.current_follow_path = var_2;
  var_2 scripts\engine\utility::script_delay();

  while(isDefined(var_2)) {
    self.current_follow_path = var_2;

    if(isDefined(var_2.lookahead)) {
      break;
    }

    if(isDefined(level.struct_class_names["targetname"][var_2.targetname]))
      var_4 = ::follow_path_animate_set_struct;
    else if(isDefined(var_2.classname))
      var_4 = ::follow_path_animate_set_ent;
    else
      var_4 = ::follow_path_animate_set_node;

    if(isDefined(var_2.radius) && var_2.radius != 0)
      self.goalradius = var_2.radius;

    if(self.goalradius < 16)
      self.goalradius = 16;

    if(isDefined(var_2.height) && var_2.height != 0)
      self.goalheight = var_2.height;

    var_5 = self.goalradius;
    self childthread[[var_4]](var_2);

    if(isDefined(var_2.animation))
      var_2 waittill(var_2.animation);
    else {
      for(;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_2 notify("trigger", self);

    if(isDefined(var_2.script_flag_set))
      scripts\engine\utility::flag_set(var_2.script_flag_set);

    if(isDefined(var_2.script_parameters)) {
      var_6 = strtok(var_2.script_parameters, " ");

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        if(isDefined(level.custom_followpath_parameter_func))
          self[[level.custom_followpath_parameter_func]](var_6[var_7], var_2);

        if(self.type == "dog") {
          continue;
        }
        switch (var_6[var_7]) {
          case "enable_cqb":
            scripts\common\utility::enable_cqbwalk();
            break;
          case "disable_cqb":
            scripts\common\utility::disable_cqbwalk();
            break;
          case "deleteme":
            self delete();
            return;
        }
      }
    }

    if(!isDefined(var_2.script_requires_player) && var_1 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(follow_path_wait_for_player(var_2, var_1)) {
          break;
        }

        if(isDefined(var_2.animation)) {
          self.goalradius = var_5;
          self setgoalpos(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isDefined(var_2.target)) {
      break;
    }

    if(isDefined(var_2.script_flag_wait))
      scripts\engine\utility::flag_wait(var_2.script_flag_wait);

    var_2 scripts\engine\utility::script_delay();
    var_2 = var_2 scripts\engine\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

follow_path_wait_for_player(var_0, var_1) {
  if(distance(level.player.origin, var_0.origin) < distance(self.origin, var_0.origin))
    return 1;

  var_2 = undefined;
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(level.player.origin - self.origin);

  if(isDefined(var_0.target)) {
    var_4 = scripts\engine\utility::get_target_ent(var_0.target);
    var_2 = vectorNormalize(var_4.origin - var_0.origin);
  } else if(isDefined(var_0.angles))
    var_2 = anglesToForward(var_0.angles);
  else
    var_2 = anglesToForward(self.angles);

  if(vectordot(var_2, var_3) > 0)
    return 1;

  if(distance(level.player.origin, self.origin) < var_1)
    return 1;

  return 0;
}

follow_path_animate_set_node(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 scripts\sp\anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 scripts\sp\anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 scripts\common\anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    set_goal_node(var_0);
}

follow_path_animate_set_ent(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 scripts\sp\anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 scripts\sp\anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 scripts\common\anim::anim_generic_run(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    set_goal_ent(var_0);
}

follow_path_animate_set_struct(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 scripts\sp\anim::anim_generic_reach(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    scripts\common\ai::disable_exits();

    if(isDefined(var_0.script_parameters) && issubstr(var_0.script_parameters, "gravity"))
      var_0 scripts\sp\anim::anim_generic_gravity(self, var_0.animation);
    else
      var_0 scripts\common\anim::anim_generic_run(self, var_0.animation);

    scripts\engine\utility::delaythread(0.05, scripts\common\ai::enable_exits);
    self setgoalpos(self.origin);
  } else
    set_goal_pos(var_0.origin);
}

post_load_precache(var_0) {
  if(!isDefined(level.post_load_funcs))
    level.post_load_funcs = [];

  level.post_load_funcs = scripts\engine\utility::array_add(level.post_load_funcs, var_0);
}

ui_action_slot_force_active_on(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "on");
}

ui_action_slot_force_active_off(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "turn_off");
}

ui_action_slot_force_active_one_time(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "onetime");
}

init_waits() {
  if(!scripts\engine\utility::add_init_script("waits", ::init_waits)) {
    return;
  }
  level.waits = spawnStruct();
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
}

set_start_location(var_0, var_1) {
  var_2 = [];

  if(isstring(var_0))
    var_2 = scripts\engine\utility::get_target_array(var_0);
  else if(isarray(var_0))
    var_2 = var_0;

  if(var_2.size == 0) {
    return;
  }
  foreach(var_4 in var_1) {
    var_5 = undefined;

    foreach(var_7 in var_2) {
      if(!isDefined(var_7.script_noteworthy)) {
        continue;
      }
      if(isPlayer(var_4)) {
        if(var_7.script_noteworthy == "player") {
          var_5 = var_7;
          break;
        }
      } else if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_7.script_noteworthy) {
        var_5 = var_7;
        break;
      }
    }

    if(isDefined(var_5)) {
      var_5.taken = 1;
      var_4.start_node = var_5;

      if(isai(var_4))
        var_4 setgoalpos(var_5.origin);

      var_4 teleport_ent(var_5);
    }
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4.start_node)) {
      continue;
    }
    foreach(var_7 in var_2) {
      if(!isDefined(var_7.taken)) {
        var_7.taken = 1;
        var_4.start_node = var_7;

        if(isai(var_4))
          var_4 setgoalpos(var_7.origin);

        var_4 teleport_ent(var_7);
        break;
      }
    }
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4.start_node))
      var_4.start_node = undefined;
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_7.taken))
      var_7.taken = undefined;
  }
}

kleenex_popup(var_0) {}

allow_nvg(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = scripts\common\input_allow::allow_input_internal("NVG", var_0, var_1);

  if(isDefined(var_3) && !var_3)
    thread scripts\sp\nvg\nvg_player::disable_nvg_proc(1, var_2);
  else if(isDefined(var_3) && var_3)
    thread scripts\sp\nvg\nvg_player::disable_nvg_proc(0);
}

set_nvg_vision(var_0) {
  level.player scripts\sp\nvg\nvg_player::set_nvg_vision_proc(var_0);
}

set_nvg_light(var_0) {
  level.player scripts\sp\nvg\nvg_player::set_nvg_light_proc(var_0);
}

set_nvg_flir(var_0) {
  level.player scripts\sp\nvg\nvg_player::set_nvg_flir_proc(var_0);
}

is_flir_vision_on() {
  if(isDefined(self.nvg) && self.nvg.flir)
    return 1;
  else
    return 0;
}

player_gesture_combat(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;

  if(level.player get_player_demeanor() == "safe") {
    var_3 = 1.0;
    var_4 = 1;
  }

  var_5 = 0;

  if(isDefined(var_1))
    var_2 = self playgestureviewmodel(var_0, var_1, var_5, var_3, undefined);
  else
    var_2 = self playgestureviewmodel(var_0, undefined, var_5, var_3, undefined);

  return var_2;
}

player_gesture_noncombat(var_0, var_1) {
  self endon("death");

  if(self isfiring())
    return 0;

  if(self isreloading())
    return 0;

  return player_gesture_force(var_0, var_1);
}

player_gesture_force(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;

  if(level.player get_player_demeanor() == "safe") {
    var_3 = 0.2;
    var_4 = 1;
  }

  if(isDefined(var_1) && isent(var_1))
    var_2 = self forceplaygestureviewmodel(var_0, var_1, var_3, undefined, undefined);
  else
    var_2 = self forceplaygestureviewmodel(var_0, undefined, var_3, undefined, undefined);

  if(var_2)
    thread scripts\sp\player\gestures::player_gestures_input_disable(var_0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, undefined, "gesture");

  return var_2;
}

get_ai_group_count(var_0) {
  return level._ai_group[var_0].spawnercount + level._ai_group[var_0].aicount;
}

get_ai_group_sentient_count(var_0) {
  level._ai_group[var_0].ai = scripts\engine\utility::array_removedead_or_dying(level._ai_group[var_0].ai);
  level._ai_group[var_0].ai = scripts\engine\utility::array_removeundefined(level._ai_group[var_0].ai);
  return level._ai_group[var_0].aicount;
}

get_ai_group_spawner_count(var_0) {
  return level._ai_group[var_0].spawnercount;
}

get_ai_group_death_count(var_0) {
  return level._ai_group[var_0].aideaths;
}

get_ai_group_spawners(var_0) {
  return level._ai_group[var_0].spawners;
}

get_ai_group_ai(var_0) {
  level._ai_group[var_0].ai = scripts\engine\utility::array_removedead_or_dying(level._ai_group[var_0].ai);
  level._ai_group[var_0].ai = scripts\engine\utility::array_removeundefined(level._ai_group[var_0].ai);
  return level._ai_group[var_0].ai;
}

waittill_ai_group_dead(var_0) {
  while(level._ai_group[var_0].aicount || level._ai_group[var_0].spawnercount)
    wait 0.05;
}

fx_playontag_safe(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.fx_ticket_queue))
    fx_regulate_init();

  thread fx_playontag_safe_internal(var_0, var_1, var_2, var_3, var_4);
}

fx_playontag_safe_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_2))
    wait(var_2);

  fx_regulate();

  if(!isDefined(var_4) || !var_4)
    test_tag(var_1, var_0);

  playFXOnTag(scripts\engine\utility::getfx(var_0), self, var_1);
}

fx_stopontag_safe(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.fx_ticket_queue))
    fx_regulate_init();

  thread fx_stopontag_safe_internal(var_0, var_1, var_2, var_3, var_4);
}

test_tag(var_0, var_1) {
  if(self.model == "") {}

  if(isai(self)) {
    var_2 = 0;
    var_3 = [];

    if(isDefined(self.headmodel) && self.headmodel != "")
      var_3[var_3.size] = self.headmodel;

    if(isDefined(self.hatmodel) && self.hatmodel != "")
      var_3[var_3.size] = self.hatmodel;

    if(!nullweapon(self.weapon))
      var_3[var_3.size] = getweaponmodel(self.weapon);

    var_3[var_3.size] = self.model;

    foreach(var_5 in var_3) {
      if(scripts\engine\utility::hastag(var_5, var_0)) {
        var_2 = 1;
        break;
      }
    }

    if(!var_2)
      return;
  } else if(!scripts\engine\utility::hastag(self.model, var_0))
    return;
}

fx_stopontag_safe_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_2))
    wait(var_2);

  fx_regulate();

  if(!isDefined(var_4) || !var_4)
    test_tag(var_1, var_0);

  stopFXOnTag(scripts\engine\utility::getfx(var_0), self, var_1);
}

fx_killontag_safe(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.fx_ticket_queue))
    fx_regulate_init();

  thread fx_killontag_safe_internal(var_0, var_1, var_2, var_3, var_4);
}

fx_killontag_safe_internal(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_3))
    self endon(var_3);

  if(isDefined(var_2))
    wait(var_2);

  fx_regulate();

  if(!isDefined(var_4) || !var_4)
    test_tag(var_1, var_0);

  if(var_1 == "tag_flash" && nullweapon(self.weapon)) {
    return;
  }
  killfxontag(scripts\engine\utility::getfx(var_0), self, var_1);
}

get_fx_ticket() {
  self.fx_ticket++;
  return scripts\engine\utility::string(self.fx_ticket);
}

fx_regulate_init() {
  if(isDefined(self.fx_ticket_queue)) {
    return;
  }
  self.fx_ticket_queue = [];
  self.fx_ticket = 0;
  thread fx_regulator();
}

fx_regulator() {
  self endon("entitydeleted");
  var_0 = 0;

  for(;;) {
    self waittill("new_fx_call");

    while(self.fx_ticket_queue.size > 0) {
      var_1 = self.fx_ticket_queue[0];
      self.fx_ticket_queue = scripts\engine\utility::array_remove(self.fx_ticket_queue, var_1);
      self notify(var_1);
      var_0++;

      if(var_0 == 3) {
        wait 0.05;
        var_0 = 0;
      }
    }
  }
}

fx_regulate() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = get_fx_ticket();
  self.fx_ticket_queue = scripts\engine\utility::array_add(self.fx_ticket_queue, var_0);
  self notify("new_fx_call");
  self waittill(var_0);
}

stop_player_gesture(var_0) {
  if(isDefined(var_0))
    self stopgestureviewmodel(var_0);
  else
    self stopgestureviewmodel();

  self notify("gesture_stop");
}

set_player_demeanor(var_0) {
  self notify("entering_new_demeanor");

  if(!isDefined(self.gestures))
    self.gestures = spawnStruct();

  waittillframeend;

  switch (var_0) {
    case "green_beam":
      scripts\sp\player\gestures::enter_demeanor_green_beam();
      break;
    case "normal":
      scripts\sp\player\gestures::enter_demeanor_normal();
      break;
    case "relaxed":
      scripts\sp\player\gestures::enter_demeanor_relaxed();
      break;
    case "safe":
      scripts\sp\player\gestures::enter_demeanor_safe();
      break;
    default:
      break;
  }
}

get_player_demeanor() {
  return level.player getdemeanorviewmodel();
}

init_gravity() {
  if(!isDefined(level.gravity_gameplay)) {
    level.gravity_gameplay = getdvarint("NPOQPMP");
    level.gravity_physics = getomnvar("physics_gravity_z");
  }
}

scale_gravity(var_0, var_1) {
  init_gravity();

  if(isDefined(var_0))
    setsaveddvar("NPOQPMP", level.gravity_gameplay * var_0);

  if(isDefined(var_1))
    physics_setgravity((0, 0, level.gravity_physics * var_1));
}

atmosphere_enable(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0 && !level.atmosphere)
    level.atmosphere = var_0;
  else if(!var_0 && level.atmosphere)
    level.atmosphere = var_0;
}

set_gravity(var_0, var_1) {
  init_gravity();

  if(isDefined(var_0))
    setsaveddvar("NPOQPMP", var_0);

  if(isDefined(var_1))
    physics_setgravity((0, 0, var_1));
}

reset_gravity() {
  setsaveddvar("NPOQPMP", level.gravity_gameplay);
  physics_setgravity((0, 0, level.gravity_physics));
}

gesture_stop(var_0) {
  if(isDefined(self.unittype) && self.unittype == "c6")
    thread scripts\asm\gesture\script_funcs::ai_gesture_stop_c6(var_0);
  else {
    thread scripts\asm\gesture\script_funcs::ai_gesture_eyes_stop(var_0 * 0.1);
    thread scripts\asm\gesture\script_funcs::ai_gesture_stop(var_0);
  }

  self notify("stop_lookat");
  self notify("gesture_natural_stop");
  self.playing_gesture = undefined;
}

gesture_torso_stop(var_0) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_torso_stop(var_0);
}

gesture_eyes_stop(var_0) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_eyes_stop(var_0);
}

gesture_head_stop(var_0) {
  if(self.unittype == "c6")
    thread scripts\asm\gesture\script_funcs::ai_gesture_stop_c6(var_0);
  else
    scripts\asm\gesture\script_funcs::ai_gesture_stop(var_0);

  self notify("stop_lookat");
}

gesture_follow_lookat(var_0, var_1, var_2) {
  self endon("death");
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat(var_0, var_1, var_2);
}

gesture_follow_lookat_natural(var_0, var_1, var_2, var_3) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_natural(var_0, var_1, var_2, var_3);
}

gesture_follow_eyes(var_0, var_1, var_2) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_eyes_lookat(var_0, var_1, var_2);
}

gesture_follow_torso(var_0, var_1) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_torso(var_0, var_1);
}

gesture_follow_lookat_update(var_0, var_1) {
  scripts\asm\gesture\script_funcs::ai_gesture_update_lookat(var_0, var_1);
}

gesture_follow_eye_update(var_0, var_1) {
  scripts\asm\gesture\script_funcs::ai_gesture_update_eyes_lookat(var_0, var_1);
}

gesture_point(var_0) {
  scripts\asm\gesture\script_funcs::ai_gesture_point(var_0);
}

gesture_simple(var_0) {
  scripts\asm\gesture\script_funcs::ai_gesture_simple(var_0);
}

gesture_directional_custom(var_0, var_1, var_2) {
  scripts\asm\gesture\script_funcs::ai_gesture_directional_custom(var_0, var_1, var_2);
}

gesture_custom(var_0, var_1) {
  scripts\asm\gesture\script_funcs::ai_custom_gesture(var_0, var_1);
}

gesture_eye_dart_loop(var_0, var_1) {
  self endon("death");
  self endon("stop_lookat");
  self endon("eye_gesture_stop");

  if(!isDefined(self.is_eye_tracking))
    thread gesture_follow_eyes(var_0, 4.0, 0.1);

  if(isDefined(var_1) && var_1)
    thread gesture_follow_lookat(var_0, 0.15, 0.7);

  wait 0.7;

  for(;;) {
    thread gesture_follow_eye_update(var_0, 2.0);
    wait(randomfloatrange(3.0, 5.0));
    var_2 = var_0 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
    thread gesture_follow_eye_update(var_2, 2.0);
    wait(randomfloatrange(0.25, 0.5));

    if(scripts\engine\utility::cointoss()) {
      var_2 = var_0 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
      thread gesture_follow_eye_update(var_2, 2.0);
      wait(randomfloatrange(0.25, 0.5));
    }
  }
}

gesture_simple_when_close(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("gesture_stop");
  var_4 = squared(var_1);
  scripts\sp\interaction_manager::add_actor_to_manager();
  var_5 = distance2dsquared(self.origin, var_2.origin);

  for(;;) {
    if(var_5 < var_4 && scripts\sp\interaction_manager::can_play_nearby_gesture(var_1 * 3.0)) {
      break;
    }

    var_5 = distance2dsquared(self.origin, var_2.origin);
    waitframe();
  }

  self.playing_gesture = 1;

  if(isDefined(var_3)) {
    thread gesture_simple(var_0);
    self[[var_3]]();
  } else
    gesture_simple(var_0);

  wait 2.0;
  scripts\sp\interaction_manager::remove_actor_from_manager();
  self.playing_gesture = 0;
}

get_direction_value(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = var_0[1] - var_3[1];
  var_4 = var_4 + 360;
  var_4 = int(var_4) % 360;

  if(var_4 > 350 || var_4 < 10)
    var_5 = "8";
  else if(var_4 < 60)
    var_5 = "9";
  else if(var_4 < 120)
    var_5 = "6";
  else if(var_4 < 150)
    var_5 = "3";
  else if(var_4 < 210)
    var_5 = "2";
  else if(var_4 < 240)
    var_5 = "1";
  else if(var_4 < 300)
    var_5 = "4";
  else
    var_5 = "7";

  return var_5;
}

give_melee_weapon(var_0) {
  take_melee_weapon();
  self giveweapon(var_0);
  self assignweaponmeleeslot(var_0);
}

take_melee_weapon() {
  var_0 = self.meleeweapons;

  foreach(var_2 in var_0)
  self takeweapon(var_2);
}

offhandprecache(var_0) {
  scripts\sp\equipment\offhands::init();
  var_1 = scripts\sp\equipment\offhands::offhandprecachefuncs();

  foreach(var_3 in var_0) {
    if(scripts\sp\equipment\offhands::offhandisprecached(var_3)) {
      continue;
    }
    precacheitem(var_3);

    if(scripts\engine\utility::array_contains_key(var_1, var_3))
      [[var_1[var_3]]](var_3);
    else {}

    level.offhands.precached = scripts\engine\utility::array_add(level.offhands.precached, var_3);
  }
}

give_offhand(var_0, var_1) {
  if(isPlayer(self))
    scripts\sp\player::offhandswap(var_0, var_1);
  else {}
}

take_offhand(var_0) {
  if(isPlayer(self))
    scripts\sp\player::offhandremove(var_0);
  else {}
}

get_melee_weapon() {
  var_0 = self.meleeweapons;

  foreach(var_2 in var_0) {
    if(!nullweapon(var_2))
      return var_2;
  }

  return undefined;
}

give_action_slot_weapon(var_0) {
  self.actionslotweapon = var_0;
  self giveweapon(var_0);

  if(is_action_slot_weapon_allowed())
    self setactionslot(1, "weapon", var_0);
}

take_action_slot_weapon() {
  self setactionslot(1, "");
  self takeweapon(self.actionslotweapon);
  self.actionslotweapon = undefined;
}

get_action_slot_weapon() {
  if(isDefined(self.actionslotweapon))
    return self.actionslotweapon;
  else
    return "";
}

allow_action_slot_weapon(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("actionSlotWeapons", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2) {
      if(isDefined(self.actionslotweapon))
        self setactionslot(1, "weapon", self.actionslotweapon);
    } else
      self setactionslot(1, "");
  }
}

is_action_slot_weapon_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("actionSlotWeapons");
}

get_weapons_list_primaries(var_0, var_1) {
  var_2 = level.player.primaryweapons;

  if(isDefined(var_0) && var_0 == 1)
    var_2 = scripts\engine\utility::array_combine(var_2, level.player.alternateweapons);

  var_3 = [];
  var_4 = level.player get_melee_weapon();

  if(isDefined(var_4) && (!isDefined(var_1) || var_1 == 0)) {
    foreach(var_6 in var_2) {
      if(var_6 != var_4)
        var_3[var_3.size] = var_6;
    }
  } else
    var_3 = var_2;

  return var_3;
}

is_primary_equipment_button_down() {
  return scripts\engine\utility::flag("primary_equipment_input_down");
}

wait_primary_equipment_button_up() {
  scripts\engine\utility::flag_waitopen("primary_equipment_input_down");
}

wait_primary_equipment_button_down() {
  scripts\engine\utility::flag_wait("primary_equipment_input_down");
}

wait_primary_equipment_button_pressed() {
  self waittill("primary_equipment_pressed");
  scripts\engine\utility::flag_wait("primary_equipment_input_down");
}

is_primary_equipment_in_use() {
  return scripts\engine\utility::flag("primary_equipment_in_use");
}

is_secondary_equipment_button_down() {
  return scripts\engine\utility::flag("secondary_equipment_input_down");
}

wait_secondary_equipment_button_up() {
  scripts\engine\utility::flag_waitopen("secondary_equipment_input_down");
}

wait_secondary_equipment_button_down() {
  scripts\engine\utility::flag_wait("secondary_equipment_input_down");
}

wait_secondary_equipment_button_pressed() {
  self waittill("secondary_equipment_pressed");
  scripts\engine\utility::flag_wait("secondary_equipment_input_down");
}

is_secondary_equipment_in_use() {
  return scripts\engine\utility::flag("secondary_equipment_in_use");
}

get_primary_equipment() {
  return undefined;
}

get_primary_equipment_ammo() {
  return 0;
}

get_secondary_equipment() {
  return undefined;
}

get_secondary_equipment_ammo() {
  return 0;
}

get_stored_primary_equipment() {
  return undefined;
}

get_stored_primary_equipment_ammo() {
  return 1;
}

get_stored_secondary_equipment() {
  return undefined;
}

get_stored_secondary_equipment_ammo() {
  return 1;
}

get_equipment_ammo(var_0) {
  var_1 = [::get_primary_equipment, ::get_stored_primary_equipment, ::get_secondary_equipment, ::get_stored_secondary_equipment];
  var_2 = [::get_primary_equipment_ammo, ::get_stored_primary_equipment_ammo, ::get_secondary_equipment_ammo, ::get_stored_secondary_equipment_ammo];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = [[var_1[var_3]]]();
    var_5 = [[var_2[var_3]]]();

    if(isDefined(var_4) && var_4 == var_0)
      return var_5;
  }
}

get_corpse_origin() {
  if(getdvarint("MQSNSOSMPN"))
    return self getcorpsephysicsorigin();

  return self.origin;
}

hudoutline_add_channel(var_0, var_1, var_2) {
  scripts\sp\outline::hudoutline_add_channel_internal(var_0, var_1, var_2);
}

hudoutline_add_child_channel(var_0, var_1, var_2) {
  scripts\sp\outline::hudoutline_add_child_channel_internal(var_0, var_1, var_2);
}

hudoutline_force_channel(var_0, var_1) {
  scripts\sp\outline::hudoutline_force_channel_internal(var_0, var_1);
}

hudoutline_enable_new(var_0, var_1) {
  scripts\sp\outline::hudoutline_enable_internal(var_1, var_0);
}

hudoutline_enable(var_0, var_1, var_2, var_3) {
  scripts\sp\outline::hudoutline_enable_internal(var_3, "outline_depth_red");
}

hudoutline_disable(var_0) {
  scripts\sp\outline::hudoutline_disable_internal(var_0);
}

hudoutline_channel_animation(var_0, var_1) {
  scripts\sp\outline::play_animation_on_channel(var_0, var_1);
  level notify("hudoutline_anim_complete");
  level notify("hudoutline_anim_complete" + var_0);
}

hudoutline_channel_animation_loop(var_0, var_1) {
  thread scripts\sp\outline::play_animation_on_channel_loop(var_0, var_1);
}

hudoutline_vis_enemy_settings(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  setsaveddvar("NMROQRRONQ", 1);
  var_1 = "0.5 0.5 0.5";
  var_2 = "1 1 1";

  if(var_0) {
    var_1 = "0.5 0.5 0.5 1";
    var_2 = "0.5 0.5 0.5 0.2";
    var_3 = "0.5 0.5 0.5 1";
    var_4 = "0.7 0.7 0.7 1";
    var_5 = "0.5 0.5 0.5 1";
  } else {
    var_1 = "0.5 0.5 0.5 0";
    var_2 = "0.5 0.5 0.5 0";
    var_3 = "0.5 0.5 0.5 1";
    var_4 = "0.5 0.5 0.5 0.5";
    var_5 = "0.5 0.5 0.5 0.5";
  }

  setsaveddvar("LRMPROLMKN", var_1);
  setsaveddvar("NTOSKSTKQQ", var_2);
  setsaveddvar("NSNOLMTLLL", var_3);
  setsaveddvar("LSRTPRNOLS", var_4);
  setsaveddvar("LNNOSQKRTP", var_5);
  setsaveddvar("RKSQOKQNK", 1);
}

hudoutline_vis_enemy(var_0, var_1) {
  var_2["allies"] = "friendly";
  var_2["axis"] = "enemy";
  var_2["team3"] = "neutral";
  var_2["dead"] = "neutral";

  if(isDefined(var_1))
    var_3 = var_1;
  else if(isDefined(self.team))
    var_3 = self.team;
  else
    var_3 = "dead";

  if(var_0 && isDefined(var_2[var_3]))
    set_hudoutline(var_2[var_3], 0);
  else
    self hudoutlinedisable();
}

hud_bink(var_0) {
  setomnvar("ui_show_bink", 1);
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame(var_0);

  while(!iscinematicplaying())
    waitframe();

  while(iscinematicplaying())
    waitframe();

  stopcinematicingame();
  setomnvar("ui_show_bink", 0);
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
}

hud_fluff_text_message(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "fluff_messages_default";

  if(!isDefined(var_1))
    var_1 = 1;

  setomnvar("ui_sp_fluff_messaging", var_0);
  setomnvar("ui_sp_fluff_messaging_context", var_1);
}

_intel_waypoint_button_listener() {
  level notify("stopstop_intel_waypoint_int");
  level endon("stop_intel_waypoint");
  self.intel_waypoint_request = undefined;
  self notifyonplayercommand("set_waypoint", "+weapnext");
  self waittill("set_waypoint");
  self.intel_waypoint_request = 1;
}

_intel_dismiss_button_listener() {
  self endon("dismiss_skipped");
  self notifyonplayercommand("intel_dismiss", "+gostand");
  self notifyonplayercommand("intel_dismiss", "+activate");
  self notifyonplayercommand("intel_dismiss", "+usereload");
  self waittill("intel_dismiss");
  self.intel_dismiss_request = 1;
}

init_manipulate_ent() {
  var_0 = getEntArray("manipulate_ent", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::manipulate_ent_setup);
}

manipulate_ent_setup() {
  if(isDefined(self.script_flag_wait))
    scripts\engine\utility::flag_init(self.script_flag_wait);

  if(isDefined(self.script_deathflag))
    scripts\engine\utility::flag_init(self.script_deathflag);

  if(isDefined(self.script_rotation_speed)) {
    self.start_angles = self.angles;

    if(!isDefined(self.script_rotation_max))
      self.script_rotation_max = (0, 0, 0);

    self.rotation_spring_index = [];

    for(var_0 = 0; var_0 < 3; var_0++) {
      if(self.script_rotation_max[var_0] != 0) {
        if(self.script_rotation_speed[var_0] > 0) {
          self.rotation_spring_index[var_0] = scripts\engine\math::spring_make_under_damped(self.script_rotation_speed[var_0] * 10, 0, self.start_angles[var_0] + self.script_rotation_max[var_0], 0);
          continue;
        }
      }
    }

    thread rotate_ent_think();
  }

  if(isDefined(self.script_translate_speed)) {
    self.start_origin = self.origin;

    if(!isDefined(self.script_translate_max))
      self.script_translate_max = (0, 0, 0);

    self.translate_spring_index = [];

    for(var_0 = 0; var_0 < 3; var_0++) {
      if(self.script_translate_max[var_0] != 0) {
        if(self.script_translate_speed[var_0] > 0) {
          self.translate_spring_index[var_0] = scripts\engine\math::spring_make_under_damped(self.script_translate_speed[var_0] * 10, 0, self.start_origin[var_0] + self.script_translate_max[var_0], 0);
          continue;
        }
      }
    }

    thread translate_ent_think();
  }

  thread manipulate_ent_death_think();
  thread manipulate_ent_cleanup();
}

translate_ent_think() {
  self endon("death");
  self endon("stop_manipulate_ent");

  if(isDefined(self.script_flag_wait))
    scripts\engine\utility::flag_wait(self.script_flag_wait);

  for(;;) {
    var_0 = [];

    for(var_1 = 0; var_1 < 3; var_1++) {
      if(self.script_translate_speed[var_1] == 0) {
        var_0[var_1] = self.start_origin[var_1];
        continue;
      }

      if(self.script_translate_speed[var_1] != 0 && self.script_translate_max[var_1] == 0) {
        var_0[var_1] = self.origin[var_1] + self.script_translate_speed[var_1] / 20;
        continue;
      }

      if(self.script_translate_speed[var_1] > 0 && self.script_translate_max[var_1] != 0)
        var_0[var_1] = scripts\engine\math::spring_update(self.translate_spring_index[var_1], self.start_origin[var_1]);
    }

    self.origin = (var_0[0], var_0[1], var_0[2]);
    waitframe();
  }
}

rotate_ent_think() {
  self endon("death");
  self endon("stop_manipulate_ent");

  if(isDefined(self.script_flag_wait))
    scripts\engine\utility::flag_wait(self.script_flag_wait);

  for(;;) {
    var_0 = [];

    for(var_1 = 0; var_1 < 3; var_1++) {
      if(self.script_rotation_speed[var_1] == 0) {
        var_0[var_1] = self.start_angles[var_1];
        continue;
      }

      if(self.script_rotation_speed[var_1] != 0 && self.script_rotation_max[var_1] == 0) {
        var_0[var_1] = self.angles[var_1] + self.script_rotation_speed[var_1] / 20;
        continue;
      }

      if(self.script_rotation_speed[var_1] > 0 && self.script_rotation_max[var_1] != 0)
        var_0[var_1] = scripts\engine\math::spring_update(self.rotation_spring_index[var_1], self.start_angles[var_1]);
    }

    var_0 = (angleclamp(var_0[0]), angleclamp(var_0[1]), angleclamp(var_0[2]));
    self.angles = var_0;
    waitframe();
  }
}

manipulate_ent_death_think() {
  self endon("death");

  if(isDefined(self.script_deathflag)) {
    scripts\engine\utility::flag_wait(self.script_deathflag);

    if(isDefined(self.script_delete) && self.script_delete)
      self delete();
    else
      self notify("stop_manipulate_ent");
  }
}

manipulate_ent_cleanup() {
  scripts\engine\utility::waittill_either("death", "stop_manipulate_ent");

  if(isDefined(self.rotation_spring_index)) {
    foreach(var_1 in self.rotation_spring_index)
    scripts\engine\math::spring_delete(var_1);
  }

  if(isDefined(self.translate_spring_index)) {
    foreach(var_1 in self.translate_spring_index)
    scripts\engine\math::spring_delete(var_1);
  }
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size)
    return var_0;

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1)
    return getsubstr(var_0, 0, var_0.size - var_1.size);

  return var_0;
}

set_exception(var_0, var_1) {
  self.exception[var_0] = var_1;
}

set_all_exceptions(var_0) {
  var_1 = getarraykeys(self.exception);

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    self.exception[var_1[var_2]] = var_0;
}

waittill_multiple_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_8 = spawnStruct();
  var_8.threads = 0;

  if(isDefined(var_0)) {
    var_0 childthread scripts\engine\utility::waittill_string(var_1, var_8);
    var_8.threads++;
  }

  if(isDefined(var_2)) {
    var_2 childthread scripts\engine\utility::waittill_string(var_3, var_8);
    var_8.threads++;
  }

  if(isDefined(var_4)) {
    var_4 childthread scripts\engine\utility::waittill_string(var_5, var_8);
    var_8.threads++;
  }

  if(isDefined(var_6)) {
    var_6 childthread scripts\engine\utility::waittill_string(var_7, var_8);
    var_8.threads++;
  }

  while(var_8.threads) {
    var_8 waittill("returned");
    var_8.threads--;
  }

  var_8 notify("die");
}

get_linked_scriptables() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getscriptablearray(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = scripts\engine\utility::array_combine(var_0, var_4);
    }
  }

  if(!var_0.size && gettime() <= 300) {}

  return var_0;
}

get_linked_vehicles() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = vehicle_getarray();
      var_5 = [];

      foreach(var_7 in var_4) {
        if(scripts\engine\utility::is_equal(var_7.script_linkname, var_3))
          var_5 = scripts\engine\utility::array_add(var_5, var_7);
      }

      if(var_5.size > 0)
        var_0 = scripts\engine\utility::array_combine(var_0, var_5);
    }
  }

  return var_0;
}

get_linked_vehicle_spawners() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = scripts\common\utility::getvehiclespawnerarray(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = scripts\engine\utility::array_combine(var_0, var_4);
    }
  }

  return var_0;
}

get_linked_spawners() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getspawnerarray();
      var_5 = [];

      foreach(var_7 in var_4) {
        if(scripts\engine\utility::is_equal(var_7.script_linkname, var_3))
          var_5 = scripts\engine\utility::array_add(var_5, var_7);
      }

      if(var_5.size > 0)
        var_0 = scripts\engine\utility::array_combine(var_0, var_5);
    }
  }

  return var_0;
}

get_linked_vehicle_nodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = scripts\engine\utility::array_combine(var_0, var_4);
    }
  }

  return var_0;
}

run_thread_on_targetname(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);

  if(isDefined(level.getspawnerarrayfunction)) {
    var_6 = call[[level.getspawnerarrayfunction]](var_0);

    foreach(var_8 in var_6) {
      if(isnonentspawner(var_8))
        scripts\engine\utility::array_thread([var_8], var_1, var_2, var_3, var_4);
    }
  }

  var_5 = scripts\engine\utility::getStructArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
}

run_thread_on_noteworthy(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);

  if(isDefined(level.getspawnerarrayfunction)) {
    var_6 = call[[level.getspawnerarrayfunction]]();

    foreach(var_8 in var_6) {
      if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == var_0 && isnonentspawner(var_8))
        scripts\engine\utility::array_thread([var_8], var_1, var_2, var_3, var_4);
    }
  }

  var_5 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, var_1, var_2, var_3, var_4);
}

get_noteworthy_ent(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");

  if(isDefined(var_1))
    return var_1;

  if(scripts\common\utility::issp()) {
    var_1 = call[[level.getnodefunction]](var_0, "script_noteworthy");

    if(isDefined(var_1))
      return var_1;
  }

  var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

  if(isDefined(var_1))
    return var_1;

  var_1 = getvehiclenode(var_0, "script_noteworthy");

  if(isDefined(var_1))
    return var_1;
}

is_locked(var_0) {
  var_1 = level.lock[var_0];
  return var_1.count > var_1.max_count;
}

getfarthest(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 500000;

  var_3 = 0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distance(var_6.origin, var_0);

    if(var_7 <= var_3 || var_7 >= var_2) {
      continue;
    }
    var_3 = var_7;
    var_4 = var_6;
  }

  return var_4;
}

array_sort_by_handler(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    for(var_3 = var_2 + 1; var_3 < var_0.size; var_3++) {
      if(var_0[var_3][[var_1]]() < var_0[var_2][[var_1]]()) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_2];
        var_0[var_2] = var_4;
      }
    }
  }

  return var_0;
}

monitor_interact_delay(var_0, var_1) {
  var_0 waittill("trigger", var_2);
  level.player enableslowaim(0.1, 0.1);
  level.player scripts\common\utility::allow_ads(0);

  while(!level.player isonground())
    wait 0.05;

  var_3 = level.player getstance();

  if(var_3 != var_1) {
    level.player setstance(var_1);

    if(var_3 == "prone")
      wait 0.2;
  }

  level.player disableslowaim();
  level.player scripts\common\utility::allow_ads(1);
  return var_2;
}

ai_weapon_override(var_0, var_1, var_2, var_3, var_4) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var_3) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648))
      wait 0.05;
  }

  var_5 = undefined;

  if(isDefined(var_0)) {
    if(issameweapon(var_0))
      var_5 = var_0;
    else
      var_5 = asmdevgetallstates(var_0);
  }

  var_6 = undefined;

  if(isDefined(var_1)) {
    if(issameweapon(var_1))
      var_6 = var_1;
    else
      var_6 = asmdevgetallstates(var_1);
  }

  self.forcedweaponoriginal = self.weapon;

  if(isDefined(var_4)) {
    var_7 = undefined;

    if(issameweapon(var_4))
      var_7 = var_4;
    else
      var_7 = asmdevgetallstates(var_4);

    if(self.weapon != var_7)
      ai_create_weapon_stow(self.weapon);

    self.forcedweapon = self.overrideweapon;
    scripts\anim\shared.gsc::forceuseweapon(var_7, "primary");
    self.weaponoverride = 1;
    return;
  }

  scripts\anim\shared.gsc::forceuseweapon(var_6, "primary");
  ai_create_weapon_stow(var_5);
  self.forcedweaponclose = var_5;
  self.forcedweaponfar = var_6;
  self.closeweaponmaxdist = var_2;
  self.forcedweapon = self.forcedweaponfar;
}

clear_ai_weapon_override(var_0, var_1, var_2) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var_1) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648))
      wait 0.05;
  }

  if(isDefined(var_2)) {
    var_3 = undefined;

    if(issameweapon(var_2))
      var_3 = var_2;
    else
      var_3 = asmdevgetallstates(var_2);

    if(isDefined(self.weapon_stow) && self.weapon_stow.model == getweaponmodel(var_3))
      self.weapon_stow delete();

    place_weapon_on(var_3, "right");
  } else
    place_weapon_on(self.forcedweaponoriginal, "right");

  if(isDefined(self.weapon_stow) && var_0)
    self.weapon_stow delete();

  self.forcedweapon = undefined;
  self.weaponoverride = 0;
}

ai_create_weapon_stow(var_0) {
  self.weapon_stow = spawn("script_model", self gettagorigin("tag_stowed_back"));
  self.weapon_stow setModel(getweaponmodel(var_0));
  self.weapon_stow notsolid();
  self.weapon_stow.angles = self gettagangles("tag_stowed_back");
  self.weapon_stow linkTo(self, "tag_stowed_back");
}

countdown_start(var_0, var_1) {
  level notify("countdown_start");
  level endon("countdown_start");
  level endon("countdown_end");
  setomnvar("ui_countdown_mission_text", var_1);
  setomnvar("ui_countdown_timer", gettime() + var_0 * 1000);
  wait(var_0);
  level notify(var_1);
  wait 5;
  setomnvar("ui_countdown_timer", 0);
}

countdown_end() {
  level notify("countdown_end");
  setomnvar("ui_countdown_timer", 0);
}

setfirstsavetime(var_0) {
  var_0 = max(var_0, 2);
  level.beginningoflevelsavedelay = var_0;
}

dof_enable_autofocus(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(self) && self != level)
    dyndof(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  else
    dyndof(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

dof_disable_autofocus() {
  dyndof_disable();
}

dof_enable(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) && isstruct(self) && self == level) {} else if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1.0;

  if(!isDefined(var_3))
    var_3 = 2.0;

  level notify("stop_dyndof");
  level notify("stop_dyndof_debug");
  setsaveddvar("MRSTKSMMP", 1);
  level.player enablephysicaldepthoffieldscripting();

  if(self != level) {
    if(isDefined(var_5)) {
      var_4 = self gettagorigin(var_5);

      if(getdvarint("debug_dof_functions", 0)) {}
    } else {
      var_4 = self.origin;

      if(getdvarint("debug_dof_functions", 0)) {}
    }
  }

  if(isDefined(var_4))
    level.player setphysicaldepthoffield(var_0, var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    level.player setphysicaldepthoffield(var_0, var_1, var_2, var_3);
  else if(isDefined(var_2))
    level.player setphysicaldepthoffield(var_0, var_1, var_2);
  else
    level.player setphysicaldepthoffield(var_0, var_1);
}

dof_disable() {
  level notify("stop_dyndof");
  level notify("stop_dyndof_debug");
  level.player disablephysicaldepthoffieldscripting();
}

motion_blur_disable(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  thread lerp_saveddvar("NMORQOTSK", 0, var_0);
  thread lerp_saveddvar("RMLOTKMMM", 0, var_0);
}

motion_blur_enable(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = scripts\engine\utility::ter_op(isDefined(level.motionblur), level.motionblur["velocityScaleDefault"], getdvarfloat("NMORQOTSK"));

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::ter_op(isDefined(level.motionblur), level.motionblur["velocityScaleViewModelDefault"], getdvarfloat("RMLOTKMMM"));

  if(!isDefined(var_2))
    var_2 = 0;

  thread lerp_saveddvar("NMORQOTSK", var_0, var_2);
  thread lerp_saveddvar("RMLOTKMMM", var_1, var_2);
}

create_motion_blur_defaults(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = getdvarfloat("NMORQOTSK");

  if(!isDefined(var_1))
    var_1 = getdvarfloat("RMLOTKMMM");

  level.motionblur = [];
  level.motionblur["velocityScaleDefault"] = var_0;
  level.motionblur["velocityScaleViewModelDefault"] = var_1;
}

dyndof(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1))
    var_1 = 1.0;

  if(!isDefined(var_2))
    var_2 = 2.0;

  level notify("stop_dyndof");
  setsaveddvar("MRSTKSMMP", 1);
  level.player enablephysicaldepthoffieldscripting();

  if(isDefined(level.dyndof))
    level.dyndof = undefined;

  level.dyndof = scripts\engine\sp\utility_code::create_dyndof();
  level.dyndof.fstop = var_0;
  level.dyndof.focusspeed = var_1;
  level.dyndof.aperturespeed = var_2;
  level.dyndof.desiredbone = var_4;
  level.dyndof.ignorecollision = var_6;

  if(isDefined(var_5))
    level.dyndof.ignorelist = var_5;
  else
    level.dyndof.ignorelist = [level.player];

  if(isDefined(var_3))
    level.dyndof.traceangle = var_3;

  if(isDefined(self))
    thread scripts\engine\sp\utility_code::dyndof_thread();
  else
    level thread scripts\engine\sp\utility_code::dyndof_thread();
}

dyndof_disable() {
  level notify("stop_dyndof");
  level notify("stop_dyndof_debug");
  level.player disablephysicaldepthoffieldscripting();
  scripts\engine\sp\utility_code::destroy_dyndof();
}

actionslotoverride(var_0, var_1, var_2, var_3, var_4) {
  self setweaponhudiconoverride("actionslot" + var_0, var_1);

  if(isDefined(var_2))
    setactionslotoverrideammo(var_0, var_2);

  if(isDefined(var_3))
    thread actionslotoverridecallback(var_0, var_3, var_4);
}

actionslotoverridecallback(var_0, var_1, var_2) {
  self endon("death");
  self endon("removeActionslot" + var_0);
  self notifyonplayercommand("actionslot" + var_0, "+actionslot " + var_0);

  for(;;) {
    self waittill("actionslot" + var_0);

    if(!isDefined(var_2) || !var_2 || var_2 && level.player usinggamepad())
      self thread[[var_1]]();
  }
}

actionslotoverrideremove(var_0) {
  self notify("removeActionslot" + var_0);
  self setweaponhudiconoverrideammo("actionslot" + var_0, -1);
  self setweaponhudiconoverride("actionslot" + var_0, "none");
}

setactionslotoverrideammo(var_0, var_1) {
  self setweaponhudiconoverrideammo("actionslot" + var_0, var_1);
}

takeallweaponsexcludemelee() {
  var_0 = self.meleeweapons;
  self takeallweapons();

  foreach(var_2 in var_0)
  give_melee_weapon(var_2);
}

giveweaponmaxammo(var_0) {
  self givemaxammo(var_0);
}

can_trace_to_player(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = [];

  if(!isarray(var_1))
    var_1 = [var_1];

  var_1[var_1.size] = level.player;

  if(isent(self) || isai(self))
    var_1[var_1.size] = self;

  if(scripts\engine\trace::ray_trace_passed(var_0, level.player.origin, var_1, var_2))
    return 1;

  if(scripts\engine\trace::ray_trace_passed(var_0, level.player.origin + (0, 0, 30), var_1, var_2))
    return 1;

  if(scripts\engine\trace::ray_trace_passed(var_0, level.player getEye(), var_1, var_2))
    return 1;

  return 0;
}

play_footstep_sound(var_0, var_1) {
  if(scripts\engine\utility::is_dead_sentient() || !soundexists(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = "dirt";

  var_2 = spawn("script_origin", self.origin);
  var_2 endon("death");
  var_3 = var_0 + "_ceiling";

  if(soundexists(var_3)) {
    var_2 playsurfacesound(var_0, var_1);
    var_2 scripts\engine\utility::waittill_notify_or_timeout("death", 0.05);
    var_2.origin = var_2.origin - (0, 0, 12);
    var_4 = getdvarfloat("OLPQMMPMMM", 150.0);
    var_5 = getdvarfloat("LQSRRTOKNN", 360.0);
    var_6 = (0, 0, -1);
    var_7 = (1, 0, 0);
    var_8 = atan(var_4 / var_5);

    if(isalive(self) && scripts\engine\math::pointvscone(level.player.origin, var_2.origin, var_6, var_7, var_5, 0.0, var_8)) {
      var_2 playsurfacesound(var_3, var_1, "sounddone");
      wait_for_sounddone_or_death(var_2);
    }
  } else {
    var_2 playsurfacesound(var_0, var_1, "sounddone");
    wait_for_sounddone_or_death(var_2);
  }

  var_2 delete();
}

wait_for_sounddone_or_death(var_0, var_1) {
  if(isDefined(var_1))
    var_1 endon("death");

  self endon("death");
  var_0 waittill("sounddone");
  return 1;
}

delete_on_death_wait_sound(var_0, var_1) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    if(var_0 iswaitingonsound())
      var_0 waittill(var_1);

    var_0 delete();
  }
}

is_touching_any(var_0) {
  foreach(var_2 in var_0) {
    if(self istouching(var_2))
      return 1;
  }

  return 0;
}

scripter_note(var_0) {
  thread scripts\engine\sp\utility_code::scripter_note_proc(var_0);
}

play_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\engine\utility::is_dead_sentient()) {
    return;
  }
  var_5 = spawn("script_origin", self.origin);
  var_5 endon("death");
  thread delete_on_death_wait_sound(var_5, "sounddone");

  if(isDefined(var_1))
    var_5 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 linkTo(self);
  }

  var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    if(!isDefined(wait_for_sounddone_or_death(var_5)))
      var_5 stopsounds();

    wait 0.05;
  } else
    var_5 waittill("sounddone");

  if(isDefined(var_3))
    self notify(var_3);

  var_5 delete();
}

setupglobalcallbackfunctions_sp() {
  if(!scripts\engine\utility::add_init_script("globalCallbacks_SP", ::setupglobalcallbackfunctions_sp)) {
    return;
  }
  level.fnplaysoundonentity = ::play_sound_on_entity;
  level.fnplaysoundontag = ::play_sound_on_tag;
}

get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw))
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  else
    return undefined;
}
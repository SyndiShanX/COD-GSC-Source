/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\sp\utility.gsc
***********************************************/

function get_tag_list(var0) {
  var1 = [];
  var2 = getnumparts(var0);

  for(var3 = 0; var3 < var2; var3++) {
    var1 = getpartname(var0, var3);
  }

  return var1;
}

function get_all_closest_living(var0, var1, var2, var3) {
  var4 = [];

  if(var1.size < 1) {
    return var4;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var2 = squared(var2);

  foreach(var6 in var1) {
    if(!isalive(var6) || !isDefined(var6) || !var3 && isDefined(var6.a.doinglongdeath)) {
      continue;
    }

    if(distancesquared(var6.origin, var0) <= var2) {
      var4 = var6;
    }
  }

  return var4;
}

function mph_travel_time(var0, var1) {
  var0 *= 17.6;
  var2 = var1 / var0;
  return var2;
}

function set_hudoutline(var0, var1, var2) {
  var3 = undefined;
  var0 = tolower(var0);
  GscBinSkip1(0x45, "friendly", "outline_nodepth_cyan");
}

function convert_to_time_string(var0, var1) {
  var2 = "";

  if(var0 < 0) {
    var2 += "-";
  }

  var0 = scripts\engine\math::round_float(var0, 1, 0);
  var3 = var0 * 100;
  var3 = int(var3);
  var3 = abs(var3);
  var4 = var3 / 6000;
  var4 = int(var4);
  var2 += var4;
  var5 = var3 / 100;
  var5 = int(var5);
  var5 -= var4 * 60;

  if(var5 < 10) {
    var2 += ":0" + var5;
  } else {
    var2 += ":" + var5;
  }

  if(isDefined(var1) && var1) {
    var6 = var3;
    var6 -= var4 * 6000;
    var6 -= var5 * 100;
    var6 = int(var6 / 10);
    var2 += "." + var6;
  }

  return var2;
}

function sun_light_fade(var0, var1, var2) {
  var2 = int(var2 * 20);
  var3 = [];

  for(var4 = 0; var4 < 4; var4++) {
    var3 = (var0[var4] - var1[var4]) / var2;
  }

  var5 = [];

  for(var4 = 0; var4 < var2; var4++) {
    wait 0.05;

    for(var6 = 0; var6 < 4; var6++) {
      var5 = var0[var6] - var3[var6] * var4;
    }

    setsuncolorandintensity(var5[0], var5[1], var5[2], var5[3]);
  }

  setsuncolorandintensity(var1[0], var1[1], var1[2], var1[3]);
}

function get_closest_to_player_view(var0, var1, var2, var3) {
  if(!var0.size) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = level.player;
  }

  if(!isDefined(var3)) {
    var3 = -1;
  }

  var4 = var1.origin;

  if(isDefined(var2) && var2) {
    var4 = var1 getEye();
  }

  var5 = undefined;
  var6 = var1 getplayerangles();
  var7 = anglesToForward(var6);
  var8 = -1;

  foreach(var10 in var0) {
    var11 = vectortoangles(var10.origin - var4);
    var12 = anglesToForward(var11);
    var13 = vectordot(var7, var12);

    if(var13 < var8) {
      continue;
    }

    if(var13 < var3) {
      continue;
    }

    var8 = var13;
    var5 = var10;
  }

  return var5;
}

function get_closest_index_to_player_view(var0, var1, var2) {
  if(!var0.size) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = level.player;
  }

  var3 = var1.origin;

  if(isDefined(var2) && var2) {
    var3 = var1 getEye();
  }

  var4 = undefined;
  var5 = var1 getplayerangles();
  var6 = anglesToForward(var5);
  var7 = -1;

  for(var8 = 0; var8 < var0.size; var8++) {
    var9 = vectortoangles(var0[var8].origin - var3);
    var10 = anglesToForward(var9);
    var11 = vectordot(var6, var10);

    if(var11 < var7) {
      continue;
    }

    var7 = var11;
    var4 = var8;
  }

  return var4;
}

function flag_trigger_init(var0, var1, var2) {
  scripts\engine\utility::flag_init(var0);

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var1 thread scripts\engine\sp\utility_code::_flag_wait_trigger(var0, var2);
  return var1;
}

function flag_triggers_init(var0, var1, var2) {
  scripts\engine\utility::flag_init(var0);

  if(!isDefined(var2)) {
    var2 = 0;
  }

  for(var3 = 0; var3 < var1.size; var3++) {
    var1[var3] thread scripts\engine\sp\utility_code::_flag_wait_trigger(var0, 0);
  }

  return var1;
}

function flag_clear_delayed(var0, var1) {
  wait var1;
  scripts\engine\utility::flag_clear(var0);
}

function flag_clear_delayed_endonset(var0, var1) {
  level endon(var0);
  wait var1;
  scripts\engine\utility::flag_clear(var0);
}

function level_end_save() {
  if(level.missionfailed) {
    return;
  }

  if(scripts\sp\utility::is_trials_level()) {
    return 0;
  }

  if(scripts\engine\utility::flag("game_saving")) {
    return;
  }

  for(var0 = 0; var0 < level.players.size; var0++) {
    var1 = level.players[var0];

    if(!isalive(var1)) {
      return;
    }
  }

  scripts\engine\utility::flag_set("game_saving");
  var2 = "levelshots / autosave / autosave_" + level.script + "end";
  savegame("levelend", &"AUTOSAVE_AUTOSAVE", var2, 1);
  scripts\engine\utility::flag_clear("game_saving");
}

function add_extra_autosave_check(var0, var1, var2) {
  level.autosave.extra_autosave_checks[var0] = [];
  level.autosave.extra_autosave_checks[var0]["func"] = var1;
  level.autosave.extra_autosave_checks[var0]["msg"] = var2;
}

function remove_extra_autosave_check(var0) {
  level.autosave.extra_autosave_checks[var0] = undefined;
}

function autosave_stealth() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1);
}

function autosave_stealth_silent() {
  thread autosave_by_name_thread("autosave_stealth", 8, 1, 1);
}

function autosave_tactical() {
  scripts\engine\sp\utility_code::autosave_tactical_setup();
  thread scripts\engine\sp\utility_code::autosave_tactical_proc();
}

function autosave_by_name(var0) {
  thread autosave_by_name_thread(var0);
}

function autosave_by_name_silent(var0) {
  thread autosave_by_name_thread(var0, undefined, undefined, 1);
}

function autosave_by_name_thread(var0, var1, var2, var3, var4) {
  if(!isDefined(level.curautosave)) {
    level.curautosave = 1;
  }

  var5 = "levelshots/autosave/autosave_" + level.script + level.curautosave;
  var6 = level scripts\sp\autosave::tryautosave(level.curautosave, "autosave", var5, var1, var2, var3, var4);

  if(isDefined(var6) && var6) {
    level.curautosave++;
    return;
  }
}

function autosave_or_timeout(var0, var1) {
  thread autosave_by_name_thread(var0, var1);
}

function autosave_try_once(var0, var1) {
  thread autosave_by_name_thread(var0, undefined, undefined, var1, 1);
}

function autosave_or_timeout_silent(var0, var1) {
  thread autosave_by_name_thread(var0, var1, undefined, 1);
}

function debug_message(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 5;
  }

  if(isDefined(var3)) {
    var3 endon("death");
    var1 = var3.origin;
  }

  for(var4 = 0; var4 < var2 * 20; var4++) {
    if(!isDefined(var3)) {}

    wait 0.05;
  }
}

function debug_message_clear(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    level notify(var0 + var3);
    level endon(var0 + var3);
  } else {
    level notify(var0);
    level endon(var0);
  }

  if(!isDefined(var2)) {
    var2 = 5;
  }

  for(var4 = 0; var4 < var2 * 20; var4++) {
    wait 0.05;
  }
}

function closerfunc(var0, var1) {
  return var0 >= var1;
}

function getclosestfx(var0, var1, var2) {
  return scripts\engine\sp\utility_code::comparesizesfx(var0, var1, var2, &closerfunc);
}

function get_farthest_ent(var0, var1) {
  if(var1.size < 1) {
    return;
  }

  var2 = distance(var1[0] getorigin(), var0);
  var3 = var1[0];

  for(var4 = 0; var4 < var1.size; var4++) {
    var5 = distance(var1[var4] getorigin(), var0);

    if(var5 < var2) {
      continue;
    }

    var2 = var5;
    var3 = var1[var4];
  }

  return var3;
}

function get_within_range(var0, var1, var2) {
  var3 = [];

  for(var4 = 0; var4 < var1.size; var4++) {
    if(distance(var1[var4].origin, var0) <= var2) {
      var3 = var1[var4];
    }
  }

  return var3;
}

function get_outside_range(var0, var1, var2) {
  var3 = [];

  for(var4 = 0; var4 < var1.size; var4++) {
    if(distance(var1[var4].origin, var0) > var2) {
      var3 = var1[var4];
    }
  }

  return var3;
}

function get_closest_living(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 9999999;
  }

  if(var1.size < 1) {
    return;
  }

  var3 = undefined;

  for(var4 = 0; var4 < var1.size; var4++) {
    if(!isalive(var1[var4])) {
      continue;
    }

    var5 = distance(var1[var4].origin, var0);

    if(var5 >= var2) {
      continue;
    }

    var2 = var5;
    var3 = var1[var4];
  }

  return var3;
}

function get_highest_dot(var0, var1, var2) {
  if(!var2.size) {
    return;
  }

  var3 = undefined;
  var4 = vectortoangles(var1 - var0);
  var5 = anglesToForward(var4);
  var6 = -1;

  foreach(var8 in var2) {
    var4 = vectortoangles(var8.origin - var0);
    var9 = anglesToForward(var4);
    var10 = vectordot(var5, var9);

    if(var10 < var6) {
      continue;
    }

    var6 = var10;
    var3 = var8;
  }

  return var3;
}

function get_closest_index(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 9999999;
  }

  if(var1.size < 1) {
    return;
  }

  var3 = undefined;

  foreach(var5 in var1) {
    var6 = distance(var5.origin, var0);

    if(var6 >= var2) {
      continue;
    }

    var2 = var6;
    var3 = var7;
  }

  return var3;
}

function get_closest_exclude(var0, var1, var2) {
  if(!isDefined(var1)) {
    return undefined;
  }

  var3 = 0;

  if(isDefined(var2) && var2.size) {
    var4 = [];
    var5 = 0;

    if(var5 < var1.size) {
      GscBinSkip0(0x2e, var5, 0);
    }

    for(var5 = 0; var5 < var1.size; var5++) {
      for(var6 = 0; var6 < var2.size; var6++) {
        if(var1[var5] == var2[var6]) {
          var4 = 1;
        }
      }
    }

    var7 = 0;

    for(var5 = 0; var5 < var1.size; var5++) {
      if(!var4[var5] && isDefined(var1[var5])) {
        var7 = 1;
        var3 = distance(var0, var1[var5].origin);
        var8 = var5;
        var5 = var1.size + 1;
      }
    }

    if(!var7) {
      return undefined;
    }
  } else {
    for(var5 = 0; var5 < var2.size; var5++) {
      if(isDefined(var2[var5])) {
        var5 = distance(var1, var2[0].origin);
        var8 = var5;
        var5 = var2.size + 1;
      }
    }
  }

  var8 = undefined;

  for(var5 = 0; var5 < var2.size; var5++) {
    if(isDefined(var2[var5])) {
      var4 = 0;

      if(isDefined(var3)) {
        for(var6 = 0; var6 < var3.size; var6++) {
          if(var2[var5] == var3[var6]) {
            var4 = 1;
          }
        }
      }

      if(!var4) {
        var9 = distance(var1, var2[var5].origin);

        if(var9 <= var5) {
          var5 = var9;
          var8 = var5;
        }
      }
    }
  }

  if(isDefined(var8)) {
    return var2[var8];
  }

  return undefined;
}

function get_closest_ai(var0, var1, var2) {
  if(isDefined(var1)) {
    var3 = getaiarray(var1);
  } else {
    var3 = getaiarray();
  }

  if(var3.size == 0) {
    return undefined;
  }

  if(isDefined(var3)) {
    var3 = scripts\engine\utility::array_remove_array(var3, var3);
  }

  return scripts\engine\utility::getclosest(var1, var3);
}

function get_closest_ai_exclude(var0, var1, var2) {
  if(isDefined(var1)) {
    var3 = getaiarray(var1);
  } else {
    var3 = getaiarray();
  }

  if(var3.size == 0) {
    return undefined;
  }

  return get_closest_exclude(var1, var3, var3);
}

function get_progress(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = distance(var0, var1);
  }

  var3 = max(0.01, var3);
  var4 = vectorNormalize(var1 - var0);
  var5 = var2 - var0;
  var6 = vectordot(var5, var4);
  var6 /= var3;
  var6 = clamp(var6, 0, 1);
  return var6;
}

function disable_long_death() {
  self.a.disablelongdeath = 1;
}

function enable_long_death() {
  self.a.disablelongdeath = 0;
}

function enable_blood_pool() {
  self.skipbloodpool = undefined;
  self setragdollnobloodpoolfx(0);
}

function disable_blood_pool() {
  self.skipbloodpool = 1;
  self setragdollnobloodpoolfx(1);
}

function deletable_magic_bullet_shield() {
  scripts\common\ai::magic_bullet_shield(1);
}

function get_ignoreme() {
  return self.ignoreme;
}

function set_ignoreme(var0) {
  self.ignoreme = var0;
}

function set_ignoreall(var0) {
  self.ignoreall = var0;
}

function set_favoriteenemy(var0) {
  self.favoriteenemy = var0;
}

function get_pacifist() {
  return self.pacifist;
}

function set_pacifist(var0) {
  self.pacifist = var0;
}

function set_maxsightdistsquared(var0) {
  self.maxsightdistsqrd = var0;
}

function set_maxvisibledist(var0) {
  self.maxvisibledist = var0;
}

function set_maxfaceenemydist(var0) {
  self.maxfaceenemydist = var0;
}

function set_sprint(var0) {
  self.sprint = var0;
}

function flood_spawn(var0) {
  scripts\sp\spawner::flood_spawner_scripted(var0);
}

function force_crawling_death(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = 4;
  }

  thread force_crawling_death_proc(var0, var1, var2, var3);
}

function override_crawl_death_anims() {
  if(isDefined(self.a.custom_crawling_death_array)) {
    self.a.array["crawl"] = self.a.custom_crawling_death_array["crawl"];
    self.a.array["death"] = self.a.custom_crawling_death_array["death"];
    self.a.crawl_fx_rate = self.a.custom_crawling_death_array["blood_fx_rate"];

    if(isDefined(self.a.custom_crawling_death_array["blood_fx"])) {
      self.a.crawl_fx = self.a.custom_crawling_death_array["blood_fx"];
    }
  }

  self.a.array["stand_2_crawl"] = [];

  if(isDefined(self.nofallanim)) {
    self.currentpose = "prone";
  }

  self orientmode("face angle", self.a.force_crawl_angle);
  self.a.force_crawl_angle = undefined;
}

function force_crawling_death_proc(var0, var1, var2, var3) {
  self.forcelongdeath = 1;
  self.a.force_num_crawls = var1;
  self.noragdoll = 1;
  self.nofallanim = var3;
  self.a.custom_crawling_death_array = var2;
  self.crawlingpainanimoverridefunc = &override_crawl_death_anims;
  self.maxhealth = 100000;
  self.health = 100000;
  enable_long_death();

  if(!isDefined(var3) || var3 == 0) {
    self.a.force_crawl_angle = var0 + 181.02;
    return;
  }

  self.a.force_crawl_angle = var0;
  thread scripts\anim\notetracks_sp::notetrackposecrawl();
}

function ai_ragdoll_immediate() {
  self.skipdeathanim = 1;
  die();
}

function playerwatch_unresolved_collision(var0) {
  self endon("death");
  self endon("stop_unresolved_collision_script");

  if(!isDefined(var0)) {
    var0 = 20;
  }

  self.unresolved_collision_count = 0;

  for(;;) {
    self waittill("unresolved_collision", var1);
    self.last_unresolved_collision_time = gettime();

    if(isDefined(var1) && (istrue(var1.doorclip) || istrue(var1.allowunresolvedcollision))) {
      continue;
    }

    GscBinSkip4(0x35);
  }
}

function resetunresolvedcollision() {
  self notify("newUnresolvedCollision");
  self endon("newUnresolvedCollision");
  wait 0.05;
  waittillframeend();
  self.unresolved_collision_count = 0;
}

function default_unresolved_collision_handler() {
  level.custom_death_quote = 438;
  scripts\sp\utility::missionfailedwrapper();
}

function stop_playerwatch_unresolved_collision() {
  self notify("stop_unresolved_collision_script");
}

function play_sound_on_tag_endon_death(var0, var1) {
  play_sound_on_tag(var0, var1, 1);
}

function play_loop_sound_on_entity_with_pitch(var0, var1, var2, var3) {
  var4 = spawn("script_origin", (0, 0, 0));
  var4 endon("death");
  thread scripts\engine\utility::delete_on_death(var4);

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(isDefined(var1)) {
    var4.origin = self.origin + var1;
  } else {
    var4.origin = self.origin;
  }

  var4.angles = self.angles;
  var4 linkTo(self);
  var4 playLoopSound(var0);
  var4 scalepitch(var2, var3);
  self waittill("stop sound" + var0);
  var4 stoploopsound(var0);
  var4 delete();
}

function play_sound_on_entity(var0, var1) {
  play_sound_on_tag(var0, undefined, undefined, var1);
}

function play_loop_sound_on_tag(var0, var1, var2, var3, var4) {
  var5 = spawn("script_origin", (0, 0, 0));
  var5 endon("death");

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
    thread scripts\engine\utility::delete_on_death(var5);
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(var3) {
    thread delete_on_removed(var5);
  }

  if(isDefined(var1)) {
    var5 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  } else {
    var5.origin = self.origin;
    var5.angles = self.angles;
    var5 linkTo(self);
  }

  var5 playLoopSound(var0);
  self waittill("stop sound" + var0);

  if(isDefined(var4)) {
    var5 playSound(var4, "sounddone");
    var5 scripts\engine\utility::delaycall(0.15, &stoploopsound, var0);
    var5 waittill("sounddone");
    var5 delete();
    return;
  }

  var5 stoploopsound(var0);
  var5 delete();
}

function delete_on_removed(var0) {
  var0 endon("death");

  while(isDefined(self)) {
    wait 0.05;
  }

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function assign_animtree(var0) {
  if(isDefined(var0)) {
    self.animname = var0;
  }

  self useanimtree(level.scr_animtree[self.animname]);
}

function assign_model() {
  if(isarray(level.scr_model[self.animname])) {
    var0 = randomint(level.scr_model[self.animname].size);
    self setModel(level.scr_model[self.animname][var0]);
    return;
  }

  self setModel(level.scr_model[self.animname]);
}

function spawn_anim_model(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  var3 = spawn("script_model", var1);
  var3.animname = var0;
  assign_animtree(var3);
  assign_model(var3);

  if(isDefined(var2)) {
    var3.angles = var2;
  }

  return var3;
}

function spawn_anim_weapon(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = spawn("script_model", var1);
  var4.animname = var0;
  assign_animtree(var4);
  var5 = [];

  if(isDefined(level.scr_weapon[var0][1])) {
    var5 = level.scr_weapon[var0][1];
  }

  var4 scripts\common\utility::make_weapon_model(level.scr_weapon[var0][0], var5, var3);

  if(isDefined(var2)) {
    var4.angles = var2;
  }

  return var4;
}

function trigger_wait(var0, var1) {
  var2 = getEnt(var0, var1);
  jumpiftrue(isDefined(var2)) LOC_00000011;
  return;
}

function trigger_wait_targetname(var0) {
  return trigger_wait(var0, "targetname");
}

function set_flag_on_dead(var0, var1) {
  thread set_flag_on_func_wait_proc(var0, var1, &waittill_dead, "set_flag_on_dead");
}

function set_flag_on_dead_or_dying(var0, var1) {
  thread set_flag_on_func_wait_proc(var0, var1, &waittill_dead_or_dying, "set_flag_on_dead_or_dying");
}

function empty_func(var0) {}

function set_flag_on_spawned_ai_proc(var0, var1) {
  self waittill("spawned", var2);

  if(scripts\common\ai::spawn_failed(var2)) {
    return;
  }

  var0.ai[var0.ai.size] = var2;
  scripts\engine\utility::ent_flag_set(var1);
}

function set_flag_on_func_wait_proc(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.ai = [];

  foreach(var7, var6 in var0) {
    var6 scripts\engine\utility::ent_flag_init(var3);
  }

  scripts\engine\utility::array_thread(var0, &set_flag_on_spawned_ai_proc, var4, var3);

  foreach(var6 in var0) {
    var6 scripts\engine\utility::ent_flag_wait(var3);
  }

  [[var2]](var4.ai);
  scripts\engine\utility::flag_set(var1);
}

function set_flag_on_trigger(var0, var1) {
  if(!scripts\engine\utility::flag(var1)) {
    var0 waittill("trigger", var2);
    scripts\engine\utility::flag_set(var1);
    return var2;
  }
}

function set_flag_on_targetname_trigger(var0) {
  if(scripts\engine\utility::flag(var0)) {
    return;
  }

  var1 = getEnt(var0, "targetname");
  var1 waittill("trigger");
  scripts\engine\utility::flag_set(var0);
}

function waittill_dead(var0, var1, var2) {
  var10 = spawnStruct();

  if(isDefined(var2)) {
    var10 endon("thread_timed_out");
    var10 thread scripts\engine\sp\utility_code::waittill_dead_timeout(var2);
  }

  var10.count = var0.size;

  if(isDefined(var1) && var1 < var10.count) {
    var10.count = var1;
  }

  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility_code::waittill_dead_thread, var10);

  while(var10.count > 0) {
    var10 waittill("waittill_dead guy died");
  }
}

function waittill_dead_or_dying(var0, var1, var2) {
  var3 = [];

  foreach(var5 in var0) {
    if(isalive(var5) && !var5.ignoreforfixednodesafecheck) {
      var3 = var5;
    }
  }

  var0 = var3;
  var7 = spawnStruct();

  if(isDefined(var2)) {
    var7 endon("thread_timed_out");
    var7 thread scripts\engine\sp\utility_code::waittill_dead_timeout(var2);
  }

  var7.count = var0.size;

  if(isDefined(var1) && var1 < var7.count) {
    var7.count = var1;
  }

  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility_code::waittill_dead_or_dying_thread, var7);

  while(var7.count > 0) {
    var7 waittill("waittill_dead_guy_dead_or_dying");
  }
}

function waittill_notetrack_or_damage(var0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var0);
}

function get_living_ai(var0, var1) {
  var2 = get_living_ai_array(var0, var1);

  if(var2.size > 1) {
    return undefined;
  }

  return var2[0];
}

function get_living_ai_array(var0, var1) {
  var2 = getaispeciesarray("all", "all");
  var3 = [];

  foreach(var5 in var2) {
    if(!isalive(var5)) {
      continue;
    }

    switch (var1) {
      case "targetname":
        if(isDefined(var5.targetname) && var5.targetname == var0) {
          var3 = var5;
        }

        break;
      case "script_noteworthy":
        if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == var0) {
          var3 = var5;
        }

        break;
      case "animname":
        if(isDefined(var5.animname) && var5.animname == var0) {
          var3 = var5;
        }

        break;
    }
  }

  return var3;
}

function get_vehicle(var0, var1) {
  var2 = get_vehicle_array(var0, var1);

  if(!var2.size) {
    return undefined;
  }

  return var2[0];
}

function get_vehicle_array(var0, var1) {
  var2 = getEntArray(var0, var1);
  var3 = [];
  var4 = [];

  foreach(var6 in var2) {
    if(var6.code_classname != "script_vehicle") {
      continue;
    }

    var4 = var6;

    if(isspawner(var6)) {
      if(isDefined(var6.last_spawned_vehicle)) {
        var4 = var6.last_spawned_vehicle;
        var3 = array_merge(var3, var4);
      }

      continue;
    }

    var3 = array_merge(var3, var4);
  }

  return var3;
}

function get_living_aispecies(var0, var1, var2) {
  var3 = get_living_aispecies_array(var0, var1, var2);

  if(var3.size > 1) {
    return undefined;
  }

  return var3[0];
}

function get_living_aispecies_array(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "all";
  }

  var3 = getaispeciesarray("allies", var2);
  var3 = scripts\engine\utility::array_combine(var3, getaispeciesarray("axis", var2));
  var4 = [];

  for(var5 = 0; var5 < var3.size; var5++) {
    switch (var1) {
      case "targetname":
        if(isDefined(var3[var5].targetname) && var3[var5].targetname == var0) {
          var4 = var3[var5];
        }

        break;
      case "script_noteworthy":
        if(isDefined(var3[var5].script_noteworthy) && var3[var5].script_noteworthy == var0) {
          var4 = var3[var5];
        }

        break;
    }
  }

  return var4;
}

function gather_delay_proc(var0, var1) {
  if(isDefined(level.gather_delay[var0])) {
    if(level.gather_delay[var0]) {
      wait 0.05;

      if(isalive(self)) {
        self notify("gather_delay_finished" + var0 + var1);
      }

      return;
    }

    level waittill(var0);

    if(isalive(self)) {
      self notify("gather_delay_finished" + var0 + var1);
    }

    return;
  }

  level.gather_delay[var0] = 0;
  wait var1;
  level.gather_delay[var0] = 1;
  level notify(var0);

  if(isalive(self)) {
    self notify("gather_delay_finished" + var0 + var1);
    return;
  }
}

function gather_delay(var0, var1) {
  thread gather_delay_proc(var0, var1);
  self waittill("gather_delay_finished" + var0 + var1);
}

function getlinks_array(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];
    var5 = var4.script_linkname;

    if(!isDefined(var5)) {
      continue;
    }

    if(!isDefined(var1[var5])) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function array_merge(var0, var1) {
  if(var0.size == 0) {
    return var1;
  }

  if(var1.size == 0) {
    return var0;
  }

  var2 = var0;

  foreach(var4 in var1) {
    var5 = 0;

    foreach(var7 in var0) {
      if(var7 == var4) {
        var5 = 1;
        break;
      }
    }

    if(var5) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function array_exclude(var0, var1) {
  var2 = var0;

  for(var3 = 0; var3 < var1.size; var3++) {
    if(scripts\engine\utility::array_contains(var0, var1[var3])) {
      var2 = scripts\engine\utility::array_remove(var2, var1[var3]);
    }
  }

  return var2;
}

function array_compare(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(var4 != var3) {
      return false;
    }
  }

  return true;
}

function create_deck(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = [];
  } else if(!isarray(var0)) {
    var0 = [var0];
  }

  var3 = spawnStruct();
  var3.items = [];
  var3.index = 0;
  var3.autoshuffle = !isDefined(var1) || var1;
  var3.prevent_redraw = !isDefined(var2) || var2;

  foreach(var5 in var0) {
    var3.items[var3.items.size] = var5;
  }

  if(var3.autoshuffle) {
    deck_shuffle(var3);
  }

  return var3;
}

function deck_draw() {
  var0 = self;

  if(var0.items.size == 0) {
    return undefined;
  }

  refill_if_empty(var0);
  var0.last_drawn = var0.items[var0.index];
  var0.index++;
  return var0.last_drawn;
}

function deck_draw_specific(var0, var1) {
  var2 = self;

  if(var2.items.size == 0) {
    return undefined;
  }

  refill_if_empty(var2);

  foreach(var5, var4 in var2.items) {
    if(var4 != var0 || !istrue(var1) && var5 < var2.index) {
      continue;
    }

    var2.last_drawn = var2.items[var5];

    if(var2.autoshuffle) {
      var2.items[var5] = var2.items[var2.index];
      var2.items[var2.index] = var2.last_drawn;
      var2.index++;
    } else {
      var2.index = var5 + 1;
    }

    return var2.last_drawn;
  }
}

function deck_shuffle() {
  var0 = self;
  var0.index = 0;
  var0.items = scripts\engine\utility::array_randomize(var0.items);

  if(!var0.prevent_redraw || !isDefined(var0.last_drawn) || var0.items.size <= 1) {
    return;
  }

  if(var0.items[0] == var0.last_drawn) {
    var1 = randomintrange(1, var0.items.size);
    var2 = var0.items[0];
    var0.items[0] = var0.items[var1];
    var0.items[var1] = var2;
    return;
  }
}

function refill_if_empty() {
  var0 = self;

  if(deck_is_empty(var0)) {
    if(var0.autoshuffle) {
      deck_shuffle(var0);
      return;
    }

    var0.index = 0;
    return;
  }
}

function deck_is_empty() {
  return self.index >= self.items.size;
}

function is_deck(var0) {
  return isDefined(var0) && isstruct(var0) && isDefined(var0.items) && isDefined(var0.index);
}

function getlinkedvehiclenodes() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_links();

    foreach(var3 in var1) {
      var4 = getvehiclenodearray(var3, "script_linkname");
      var0 = scripts\engine\utility::array_combine(var0, var4);
    }
  }

  return var0;
}

function draw_line(var0, var1, var2, var3, var4) {
  for(;;) {
    wait 0.05;
  }
}

function draw_line_to_ent_for_time(var0, var1, var2, var3, var4, var5) {
  var5 = gettime() + var5 * 1000;

  while(gettime() < var5) {
    wait 0.05;

    if(!isDefined(var1) || !isDefined(var1.origin)) {
      return;
    }
  }
}

function draw_line_from_ent_for_time(var0, var1, var2, var3, var4, var5) {
  draw_line_to_ent_for_time(var1, var0, var2, var3, var4, var5);
}

function draw_line_from_ent_to_ent_for_time(var0, var1, var2, var3, var4, var5) {
  var0 endon("death");
  var1 endon("death");
  var5 = gettime() + var5 * 1000;

  while(gettime() < var5) {
    wait 0.05;
  }
}

function draw_line_from_ent_to_ent_until_notify(var0, var1, var2, var3, var4, var5, var6) {
  var0 endon("death");
  var1 endon("death");
  var5 endon(var6);

  for(;;) {
    wait 0.05;
  }
}

function draw_line_until_notify(var0, var1, var2, var3, var4, var5, var6) {
  var5 endon(var6);

  for(;;) {
    scripts\engine\utility::draw_line_for_time(var0, var1, var2, var3, var4, 0.05);
  }
}

function draw_line_from_ent_to_vec_for_time(var0, var1, var2, var3, var4, var5, var6) {
  var6 = gettime() + var6 * 1000;
  var1 *= var2;

  while(gettime() < var6) {
    wait 0.05;

    if(!isDefined(var0) || !isDefined(var0.origin)) {
      return;
    }
  }
}

function draw_circle_until_notify(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 16;
  var8 = 360 / var7;
  var9 = [];

  for(var10 = 0; var10 < var7; var10++) {
    var11 = var8 * var10;
    var12 = cos(var11) * var1;
    var13 = sin(var11) * var1;
    var14 = var0[0] + var12;
    var15 = var0[1] + var13;
    var16 = var0[2];
    var9 = (var14, var15, var16);
  }

  thread draw_circle_lines_until_notify(var9, var2, var3, var4, var5, var6);
}

function draw_circle_lines_until_notify(var0, var1, var2, var3, var4, var5) {
  for(var6 = 0; var6 < var0.size; var6++) {
    var7 = var0[var6];

    if(var6 + 1 >= var0.size) {
      var8 = var0[0];
    } else {
      var8 = var0[var6 + 1];
    }

    thread draw_line_until_notify(var7, var8, var1, var2, var3, var4, var5);
  }
}

function battlechatter_off(var0) {
  level notify("battlechatter_off_thread");
  scripts\anim\battlechatter::bcs_setup_chatter_toggle_array();
  jumpiffalse(isDefined(var0)) LOC_00000028;
  set_battlechatter_variable(var0, 0);
  var1 = getaiarray(var0);
  goto LOC_0000005c;
}

function battlechatter_on(var0) {
  thread scripts\engine\sp\utility_code::battlechatter_on_thread(var0);
}

function battlechatter_commander_off(var0) {
  if(var0 == "all") {
    setDvar("bcs_commander_off", "all");
    return;
  }

  switch (getDvar("bcs_commander_off")) {
    case "":
      setDvar("bcs_commander_off", var0);
      break;
    case "axis":
      if(var0 == "allies") {
        setDvar("bcs_commander_off", "all");
      }

      break;
    case "allies":
      if(var0 == "axis") {
        setDvar("bcs_commander_off", "all");
      }

      break;
  }
}

function battlechatter_commander_on(var0) {
  if(var0 == "all") {
    setDvar("bcs_commander_off", "");
    return;
  }

  switch (getDvar("bcs_commander_off")) {
    case "axis":
      if(var0 == "axis") {
        setDvar("bcs_commander_off", "");
      }

      break;
    case "allies":
      if(var0 == "allies") {
        setDvar("bcs_commander_off", "");
      }

      break;
    case "all":
      if(var0 == "axis") {
        setDvar("bcs_commander_off", "allies");
      } else if(var0 == "allies") {
        setDvar("bcs_commander_off", "allies");
      }

      break;
  }
}

function battlechatter_radioecho_off(var0) {
  if(var0 == "all") {
    setDvar("bcs_radioecho_off", "all");
    return;
  }

  switch (getDvar("bcs_radioecho_off")) {
    case "":
      setDvar("bcs_radioecho_off", var0);
      break;
    case "axis":
      if(var0 == "allies") {
        setDvar("bcs_radioecho_off", "all");
      }

      break;
    case "allies":
      if(var0 == "axis") {
        setDvar("bcs_radioecho_off", "all");
      }

      break;
  }
}

function battlechatter_radioecho_on(var0) {
  if(var0 == "all") {
    setDvar("bcs_radioecho_off", "");
    return;
  }

  switch (getDvar("bcs_radioecho_off")) {
    case "axis":
      if(var0 == "axis") {
        setDvar("bcs_radioecho_off", "");
      }

      break;
    case "allies":
      if(var0 == "allies") {
        setDvar("bcs_radioecho_off", "");
      }

      break;
    case "all":
      if(var0 == "axis") {
        setDvar("bcs_radioecho_off", "allies");
      } else if(var0 == "allies") {
        setDvar("bcs_radioecho_off", "axis");
      }

      break;
  }
}

function battlechatter_otn_on(var0, var1) {
  var0 = tolower(var0);
  var1 = tolower(var1);
  var2 = undefined;

  switch (var0) {
    case "stealth":
      var2 = "bcs_otnStealth";
      break;
    case "combat":
      var2 = "bcs_otnCombat";
      break;
    default:
      break;
  }

  setDvar(var2, var1);
}

function battlechatter_otn_off(var0) {
  var0 = tolower(var0);
  var1 = undefined;

  switch (var0) {
    case "stealth":
      var1 = "bcs_otnStealth";
      break;
    case "combat":
      var1 = "bcs_otnCombat";
      break;
    default:
      break;
  }

  setDvar(var1, "off");
}

function battlechatter_probability(var0) {
  self.battlechatter_saytimescaled = var0;
}

function battlechatter_filter_on(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var2 in var0) {
    battlechatter_filter_internal(var2, 1);
  }
}

function battlechatter_filter_off(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var2 in var0) {
    battlechatter_filter_internal(var2, undefined);
  }
}

function battlechatter_filter_internal(var0, var1) {
  switch (var0) {
    case "threat":
      self.battlechatter.filterthreat = var1;
      break;
    case "inform":
      self.battlechatter.filterinform = var1;
      break;
    case "vehicle":
      self.battlechatter.filtervehicle = var1;
      break;
    case "order":
      self.battlechatter.filterorder = var1;
      break;
    case "reaction":
      self.battlechatter.filterreaction = var1;
      break;
    case "response":
      self.battlechatter.filterresponse = var1;
      break;
    case "stealth":
      self.battlechatter.filterstealth = var1;
      break;
  }
}

function battlechatter_friendlyfire_force(var0) {
  if(istrue(var0)) {
    self.battlechatter.friendlyfire_force = 1;
    return;
  }

  self.battlechatter.friendlyfire_force = undefined;
}

function battlechatter_addvehicle(var0) {
  if(!isDefined(self.battlechatter)) {
    self.battlechatter = spawnStruct();
  }

  self.battlechatter.enemyclass = var0;
  thread scripts\anim\battlechatter_ai::aivehiclekillwaiter();
}

function set_battlechatter(var0) {
  if(!anim.chatinitialized) {
    return;
  }

  if(istrue(self.battlechatter_removed)) {
    return;
  }

  if(var0) {
    if(isDefined(self.script_bcdialog) && !self.script_bcdialog) {
      self.battlechatterallowed = 0;
      return;
    }

    self.battlechatterallowed = 1;
    return;
  }

  self.battlechatterallowed = 0;

  if(isDefined(self.battlechatter) && istrue(self.battlechatter.isspeaking)) {
    self waittill("done speaking");
    return;
  }
}

function set_team_bcvoice(var0, var1) {
  if(!anim.chatinitialized) {
    return;
  }

  var2 = getarraykeys(anim.countryids);
  var3 = scripts\engine\utility::array_contains(var2, var1);

  if(!var3) {
    return;
  }

  var4 = getaiarray(var0);

  foreach(var6 in var4) {
    set_ai_bcvoice(var6, var1);
    waitframe();
  }
}

function set_ai_bcvoice(var0) {
  if(!anim.chatinitialized) {
    return;
  }

  var1 = getarraykeys(anim.countryids);
  var2 = scripts\engine\utility::array_contains(var1, var0);

  if(!var2) {
    return;
  }

  if(self.type == "dog") {
    return;
  }

  if(isDefined(self.battlechatter) && istrue(self.battlechatter.isspeaking)) {
    self waittill("done speaking");
    wait 0.1;
  }

  scripts\anim\battlechatter_ai::removefromsystem();
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  self.voice = var0;
  scripts\anim\battlechatter_ai::addtosystem();
}

function flavorbursts_on(var0) {
  thread set_flavorbursts_team_state(1, var0);
}

function flavorbursts_off(var0) {
  thread set_flavorbursts_team_state(0, var0);
}

function set_flavorbursts_team_state(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "allies";
  }

  while(!isDefined(anim.chatinitialized)) {
    wait 0.05;
  }

  if(!anim.chatinitialized) {
    return;
  }

  wait 1.5;
  level.flavorbursts[var1] = var0;
  var2 = [];
  var2 = getaiarray(var1);
  scripts\engine\utility::array_thread(var2, &set_flavorbursts, var0);
}

function set_flavorbursts(var0) {
  self.flavorbursts = var0;
}

function friendlyfire_warnings_off() {
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    if(isalive(var2)) {
      set_friendlyfire_warnings(var2, 0);
    }
  }

  level.friendlyfire_warnings = 0;
}

function friendlyfire_warnings_on() {
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    if(isalive(var2)) {
      set_friendlyfire_warnings(var2, 1);
    }
  }

  level.friendlyfire_warnings = 1;
}

function set_friendlyfire_warnings(var0) {
  if(var0) {
    self.friendlyfire_warnings_disable = undefined;
    return;
  }

  self.friendlyfire_warnings_disable = 1;
}

function player_battlechatter_on() {
  thread scripts\sp\player\playerchatter::player_battlechatter_on_thread();
}

function player_battlechatter_off() {
  thread scripts\sp\player\playerchatter::player_battlechatter_off_thread();
}

function debugorigin() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");

  for(;;) {
    var0 = anglesToForward(self.angles);
    var1 = var0 * 30;
    var2 = var0 * 20;
    var3 = anglestoright(self.angles);
    var4 = var3 * -10;
    var3 *= 10;
    wait 0.05;
  }
}

function get_linked_struct() {
  var0 = scripts\engine\utility::get_linked_structs();

  if(!var0.size) {
    return undefined;
  }

  return var0[0];
}

function get_last_ent_in_chain(var0) {
  var1 = self;

  while(isDefined(var1.target)) {
    wait 0.05;

    if(isDefined(var1.target)) {
      var1 = get_next_point_in_chain(var0, var1.target);
      continue;
    }

    break;
  }

  var2 = var1;
  return var2;
}

function get_next_point_in_chain(var0, var1) {
  var2 = undefined;

  if(isDefined(var0)) {
    switch (var0) {
      case "vehiclenode":
        var2 = getvehiclenode(var1, "targetname");
        break;
      case "pathnode":
        var2 = getnode(var1, "targetname");
        break;
      case "ent":
        var2 = getEnt(var1, "targetname");
        break;
      case "struct":
        var2 = scripts\engine\utility::getStruct(var1, "targetname");
        break;
      default:
        break;
    }

    return var2;
  } else {
    var2 = scripts\engine\utility::getStruct(var1, "targetname");

    if(isDefined(var2)) {
      return var2;
    }

    var2 = getnode(var1, "targetname");

    if(isDefined(var2)) {
      return var2;
    }

    var2 = getEnt(var1, "targetname");

    if(isDefined(var2)) {
      return var2;
    }

    var2 = getvehiclenode(var1, "targetname");

    if(isDefined(var2)) {
      return var2;
    }
  }

  return undefined;
}

function timeout(var0) {
  self endon("death");
  wait var0;
  self notify("timeout");
}

function array_removedead_keepkeys(var0) {
  var1 = [];
  var2 = getarraykeys(var0);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];

    if(!isalive(var0[var4])) {
      continue;
    }

    var1 = var0[var4];
  }

  return var1;
}

function array_remove_nokeys(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    if(var0[var3] != var1) {
      var2 = var0[var3];
    }
  }

  return var2;
}

function array_remove_key_array(var0, var1) {
  if(var1.size == 0) {
    return var0;
  }

  var2 = [];

  foreach(var4 in var0) {
    var5 = 0;

    foreach(var7 in var1) {
      if(var7 == var9) {
        var5 = 1;
        break;
      }
    }

    if(var5) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function array_notify(var0, var1, var2) {
  foreach(var4 in var0) {
    var4 notify(var1, var2);
  }
}

function struct_arrayspawn() {
  var0 = spawnStruct();
  var0.array = [];
  var0.lastindex = 0;
  return var0;
}

function structarray_add(var0, var1) {
  var0.array[var0.lastindex] = var1;
  var1.struct_array_index = var0.lastindex;
  var0.lastindex++;
}

function structarray_remove(var0, var1) {
  structarray_swaptolast(var0, var1);
  var0.array[var0.lastindex - 1] = undefined;
  var0.lastindex--;
}

function structarray_remove_index(var0, var1) {
  if(isDefined(var0.array[var0.lastindex - 1])) {
    var0.array[var1] = var0.array[var0.lastindex - 1];
    var0.array[var1].struct_array_index = var1;
    var0.array[var0.lastindex - 1] = undefined;
    var0.lastindex = var0.array.size;
    return;
  }

  var0.array[var1] = undefined;
  structarray_remove_undefined(var0);
}

function structarray_remove_undefined(var0) {
  var1 = [];

  foreach(var3 in var0.array) {
    if(!isDefined(var3)) {
      continue;
    }

    var1 = var3;
  }

  var0.array = var1;

  foreach(var3 in var0.array) {
    var3.struct_array_index = var6;
  }

  var0.lastindex = var0.array.size;
}

function structarray_swaptolast(var0, var1) {
  var0 scripts\engine\sp\utility_code::structarray_swap(var0.array[var0.lastindex - 1], var1);
}

function structarray_shuffle(var0, var1) {
  for(var2 = 0; var2 < var1; var2++) {
    var0 scripts\engine\sp\utility_code::structarray_swap(var0.array[var2], var0.array[randomint(var0.lastindex)]);
  }
}

function custom_battlechatter(var0) {
  return scripts\anim\battlechatter_ai::custom_battlechatter_internal(var0);
}

function get_stop_watch(var0, var1) {
  var2 = newhudelem();

  if(isplatformpc()) {
    var2.x = 68;
    var2.y = 35;
  } else {
    var2.x = 58;
    var2.y = 95;
  }

  var2.alignx = "center";
  var2.aligny = "middle";
  var2.horzalign = "left";
  var2.vertalign = "middle";

  if(isDefined(var1)) {
    var3 = var1;
  } else {
    var3 = level.explosiveplanttime;
  }

  var3 setclock(var3, var1, "hudStopwatch", 64, 64);
  return var3;
}

function set_mission_failed_override(var0) {
  level.mission_fail_func = var0;
}

function get_force_color_guys(var0, var1) {
  var2 = getaiarray(var0);
  var3 = [];

  for(var4 = 0; var4 < var2.size; var4++) {
    var5 = var2[var4];

    if(!isDefined(var5.script_forcecolor)) {
      continue;
    }

    if(var5.script_forcecolor != var1) {
      continue;
    }

    var3 = var5;
  }

  return var3;
}

function get_all_force_color_friendlies() {
  var0 = getaiarray("allies");
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = var0[var2];

    if(!isDefined(var3.script_forcecolor)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function enable_ai_color() {
  if(isDefined(self.script_forcecolor)) {
    return;
  }

  if(!isDefined(self.old_forcecolor)) {
    return;
  }

  set_force_color(self.old_forcecolor);
  self.old_forcecolor = undefined;
}

function enable_ai_color_dontmove() {
  self.dontcolormove = 1;
  enable_ai_color();
}

function disable_ai_color() {
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

function clear_force_color() {
  disable_ai_color();
}

function get_force_color() {
  var0 = self.script_forcecolor;
  return var0;
}

function shortencolor(var0) {
  return level.colorchecklist[tolower(var0)];
}

function set_force_color(var0) {
  var1 = shortencolor(var0);

  if(!isai(self)) {
    set_force_color_spawner(var1);
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
  var2 = scripts\sp\colors::get_team();

  if(isDefined(self.script_forcecolor)) {
    level.arrays_of_colorforced_ai[var2][self.script_forcecolor] = scripts\engine\utility::array_remove(level.arrays_of_colorforced_ai[var2][self.script_forcecolor], self);
  }

  self.script_forcecolor = var1;
  level.arrays_of_colorforced_ai[var2][var1] = scripts\engine\utility::array_removedead(level.arrays_of_colorforced_ai[var2][var1]);
  level.arrays_of_colorforced_ai[var2][self.script_forcecolor] = scripts\engine\utility::array_add(level.arrays_of_colorforced_ai[var2][self.script_forcecolor], self);
  thread scripts\engine\sp\utility_code::new_color_being_set(var1);
}

function set_force_color_spawner(var0) {
  self.script_forcecolor = var0;
  self.old_forcecolor = undefined;
}

function restarteffect() {
  scripts\common\createfx::restart_fx_looper();
}

function pauseexploder(var0) {
  var0 += "";
  var1 = level.createfxexploders[var0];

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      var3 scripts\engine\utility::pauseeffect();
    }

    return;
  }
}

function restartexploder(var0) {
  var0 += "";
  var1 = level.createfxexploders[var0];

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      restarteffect(var3);
    }

    return;
  }
}

function ignoreallenemies(var0) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if(var0) {
    self.old_threat_bias_group = self getthreatbiasgroup();
    var1 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var2 = [];
    GscBinSkip0(0x2e, "axis", "allies");
  }

  var1 = undefined;

  if(self.old_threat_bias_group != "") {
    self setthreatbiasgroup(self.old_threat_bias_group);
  }

  self.old_threat_bias_group = undefined;
}

function add_start(var0, var1, var2, var3, var4, var5) {
  scripts\sp\starts::add_start_assert();
  var0 = tolower(var0);
  var6 = scripts\sp\starts::add_start_construct(var0, var1, var2, var3, var4, var5);
  level.start_functions[level.start_functions.size] = var6;
  level.start_arrays[var0] = var6;
}

function set_default_start(var0) {
  level.default_start_override = var0;
}

function set_default_start_alt(var0) {
  level.default_start_override_alt = var0;
}

function within_fov_of_players(var0, var1) {
  var2 = undefined;

  for(var3 = 0; var3 < level.players.size; var3++) {
    var4 = level.players[var3] getEye();
    var2 = scripts\engine\utility::within_fov(var4, level.players[var3] getplayerangles(), var0, var1);

    if(!var2) {
      return false;
    }
  }

  return true;
}

function wait_for_buffer_time_to_pass(var0, var1) {
  var2 = var1 * 1000 - gettime() - var0;
  var2 *= 0.001;

  if(var2 > 0) {
    wait var2;
    return;
  }
}

function bcs_scripted_dialogue_start() {
  anim.scripteddialoguestarttime = gettime();
}

function dialogue_queue(var0) {
  bcs_scripted_dialogue_start();
  scripts\sp\anim::anim_single_queue(self, var0);
}

function generic_dialogue_queue(var0, var1) {
  bcs_scripted_dialogue_start();
  scripts\sp\anim::anim_generic_queue(self, var0, undefined, undefined, var1);
}

function radio_dialogue(var0, var1) {
  if(!isDefined(level.player_radio_emitter)) {
    var2 = spawn("script_origin", (0, 0, 0));
    var2 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var2;
  }

  bcs_scripted_dialogue_start();
  var3 = 0;

  if(!isDefined(var1)) {
    var3 = function_stack(level.player_radio_emitter, &scripts\engine\utility::playsoundontag, level.scr_radio[var0], undefined, 1);
  } else {
    var3 = function_stack_timeout(level.player_radio_emitter, var1, &scripts\engine\utility::playsoundontag, level.scr_radio[var0], undefined, 1);
  }

  return var3;
}

function radio_dialogue_overlap(var0) {
  play_sound_on_tag(level.player_radio_emitter, level.scr_radio[var0], undefined, 1);
}

function radio_dialogue_stop() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }

  level.player_radio_emitter delete();
}

function radio_dialogue_clear_stack() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }

  function_stack_clear(level.player_radio_emitter);
}

function radio_dialogue_interupt(var0) {
  if(!isDefined(level.player_radio_emitter)) {
    var1 = spawn("script_origin", (0, 0, 0));
    var1 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = var1;
  }

  play_sound_on_tag(level.player_radio_emitter, level.scr_radio[var0], undefined, 1);
}

function radio_dialogue_safe(var0) {
  return radio_dialogue(var0, 0.05);
}

function smart_radio_dialogue(var0, var1) {
  scripts\engine\sp\utility_code::add_to_radio(var0);
  radio_dialogue(var0, var1);
}

function smart_radio_dialogue_interrupt(var0) {
  scripts\engine\sp\utility_code::add_to_radio(var0);
  radio_dialogue_stop();
  radio_dialogue_interupt(var0);
}

function smart_radio_dialogue_overlap(var0) {
  scripts\engine\sp\utility_code::add_to_radio(var0);
  radio_dialogue_overlap(var0);
}

function player_dialogue(var0, var1) {
  return player_dialogue_gesture(var0, 0, undefined, undefined, undefined, var1);
}

function _play_player_dialogue(var0, var1, var2, var3, var4) {
  if(scripts\engine\utility::is_dead_sentient()) {
    return;
  }

  var5 = spawn("script_origin", (0, 0, 0));
  var5 endon("death");
  var5.origin = self.origin;
  var5.angles = self.angles;
  var5 linkTo(self);

  if(var1 > 0) {
    var5 scripts\engine\utility::delaycall(var1, &playsound, var0, "sounddone");
  } else {
    var5 playSound(var0, "sounddone");
  }

  if(isDefined(var2)) {
    if(isarray(var2)) {
      for(var6 = 0; var6 < var2.size; var6++) {
        if(isDefined(var4) && isDefined(var4[var6])) {
          level.player scripts\engine\utility::delaythread(var3[var6], &player_gesture_force, var2[var6], var4[var6]);
          continue;
        }

        level.player scripts\engine\utility::delaythread(var3[var6], &player_gesture_force, var2[var6]);
      }
    } else if(isDefined(var4)) {
      level.player scripts\engine\utility::delaythread(var3, &player_gesture_force, var2, var4);
    } else {
      level.player scripts\engine\utility::delaythread(var3, &player_gesture_force, var2);
    }
  }

  if(var1 > 0) {
    wait var1;
  }

  if(!isDefined(wait_for_sounddone_or_death(var5, level.player))) {
    var5 stopsounds();
  }

  wait 0.05;
  var5 delete();
}

function player_dialogue_gesture(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.player_dialogue_emitter)) {
    var6 = spawn("script_origin", (0, 0, 0));
    var6 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_dialogue_emitter = var6;
  }

  bcs_scripted_dialogue_start();
  var7 = 0;

  if(!isDefined(var5)) {
    var7 = function_stack(level.player_dialogue_emitter, &_play_player_dialogue, level.scr_plrdialogue[var0], var1, var2, var3, var4);
  } else {
    var7 = function_stack_timeout(level.player_dialogue_emitter, var5, &_play_player_dialogue, level.scr_plrdialogue[var0], var1, var2, var3, var4);
  }

  return var7;
}

function player_dialogue_stop() {
  if(!isDefined(level.player_dialogue_emitter)) {
    return;
  }

  level.player_dialogue_emitter delete();
}

function player_dialogue_clear_stack() {
  if(!isDefined(level.player_dialogue_emitter)) {
    return;
  }

  function_stack_clear(level.player_dialogue_emitter);
}

function player_dialogue_interrupt(var0) {
  player_dialogue_stop();

  if(!isDefined(level.player_dialogue_emitter)) {
    var1 = spawn("script_origin", (0, 0, 0));
    var1 linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_dialogue_emitter = var1;
  }

  _play_player_dialogue(level.player_dialogue_emitter, level.scr_plrdialogue[var0], 0);
}

function smart_player_dialogue(var0, var1) {
  scripts\engine\sp\utility_code::add_to_player_dialogue(var0);
  player_dialogue(var0, var1);
}

function smart_player_dialogue_interrupt(var0) {
  scripts\engine\sp\utility_code::add_to_player_dialogue(var0);
  player_dialogue_interrupt(var0);
}

function smart_player_dialogue_gesture(var0, var1, var2, var3, var4, var5) {
  scripts\engine\sp\utility_code::add_to_player_dialogue(var0);
  player_dialogue_gesture(var0, var1, var2, var3, var4, var5);
}

function smart_dialogue(var0) {
  scripts\engine\sp\utility_code::add_to_dialogue(var0);
  dialogue_queue(var0);
}

function smart_dialogue_generic(var0) {
  scripts\engine\sp\utility_code::add_to_dialogue_generic(var0);
  generic_dialogue_queue(var0);
}

function radio_dialogue_queue(var0) {
  radio_dialogue(var0);
}

function ignoreeachother(var0, var1) {
  setignoremegroup(var0, var1);
  setignoremegroup(var1, var0);
}

function add_global_spawn_function(var0, var1, var2, var3, var4) {
  var5 = [];
  GscBinSkip0(0x2e, "function", var1);
}

function remove_global_spawn_function(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < level.spawn_funcs[var0].size; var3++) {
    if(level.spawn_funcs[var0][var3]["function"] != var1) {
      var2 = level.spawn_funcs[var0][var3];
    }
  }

  level.spawn_funcs[var0] = var2;
}

function exists_global_spawn_function(var0, var1) {
  if(!isDefined(level.spawn_funcs)) {
    return false;
  }

  for(var2 = 0; var2 < level.spawn_funcs[var0].size; var2++) {
    if(level.spawn_funcs[var0][var2]["function"] == var1) {
      return true;
    }
  }

  return false;
}

function remove_spawn_function(var0) {
  var1 = [];

  foreach(var3 in self.spawn_functions) {
    if(var3["function"] == var0) {
      continue;
    }

    var1 = var3;
  }

  self.spawn_functions = var1;
}

function add_spawn_function(var0, var1, var2, var3, var4, var5) {
  foreach(var7 in self.spawn_functions) {
    if(var7["function"] == var0) {
      return;
    }
  }

  var9 = [];
  GscBinSkip0(0x2e, "function", var0);
}

function array_kill(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1] kill();
  }
}

function ignore_triggers(var0) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isDefined(var0)) {
    wait var0;
  } else {
    wait 0.5;
  }

  self.ignoretriggers = 0;
}

function activate_trigger_with_targetname(var0) {
  var1 = getEnt(var0, "targetname");
  activate_trigger(var1);
}

function activate_trigger_with_noteworthy(var0) {
  var1 = getEnt(var0, "script_noteworthy");
  activate_trigger(var1);
}

function disable_trigger_with_targetname(var0) {
  var1 = getEnt(var0, "targetname");
  var1 scripts\engine\utility::trigger_off();
}

function disable_trigger_with_noteworthy(var0) {
  var1 = getEnt(var0, "script_noteworthy");
  var1 scripts\engine\utility::trigger_off();
}

function enable_trigger_with_targetname(var0) {
  var1 = getEnt(var0, "targetname");
  var1 scripts\engine\utility::trigger_on();
}

function enable_trigger_with_noteworthy(var0) {
  var1 = getEnt(var0, "script_noteworthy");
  var1 scripts\engine\utility::trigger_on();
}

function set_team_pacifist(var0, var1) {
  var2 = getaiarray(var0);

  for(var3 = 0; var3 < var2.size; var3++) {
    var2[var3].pacifist = var1;
  }
}

function replace_on_death() {
  scripts\sp\colors::colornode_replace_on_death();
}

function spawn_reinforcement(var0, var1) {
  scripts\sp\colors::colornode_spawn_reinforcement(var0, var1);
}

function set_promotion_order(var0, var1) {
  if(!isDefined(level.current_color_order)) {
    level.current_color_order = [];
  }

  var0 = shortencolor(var0);
  var1 = shortencolor(var1);
  level.current_color_order[var0] = var1;

  if(!isDefined(level.current_color_order[var1])) {
    set_empty_promotion_order(var1);
    return;
  }
}

function set_empty_promotion_order(var0) {
  if(!isDefined(level.current_color_order)) {
    level.current_color_order = [];
  }

  level.current_color_order[var0] = "none";
}

function remove_color_from_array(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];

    if(!isDefined(var4.script_forcecolor)) {
      continue;
    }

    if(var4.script_forcecolor == var1) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function remove_noteworthy_from_array(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];

    if(!isDefined(var4.script_noteworthy)) {
      continue;
    }

    if(var4.script_noteworthy == var1) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function get_closest_colored_friendly(var0, var1) {
  var2 = get_force_color_guys("allies", var0);

  if(!isDefined(var1)) {
    var3 = level.player.origin;
  } else {
    var3 = var2;
  }

  return scripts\engine\utility::getclosest(var3, var3);
}

function remove_without_classname(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    if(!issubstr(var0[var3].classname, var1)) {
      continue;
    }

    var2 = var0[var3];
  }

  return var2;
}

function remove_without_model(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    if(!issubstr(var0[var3].model, var1)) {
      continue;
    }

    var2 = var0[var3];
  }

  return var2;
}

function get_closest_colored_friendly_with_classname(var0, var1, var2) {
  var3 = get_force_color_guys("allies", var0);

  if(!isDefined(var2)) {
    var4 = level.player.origin;
  } else {
    var4 = var3;
  }

  var4 = remove_without_classname(var4, var2);
  return scripts\engine\utility::getclosest(var4, var4);
}

function promote_nearest_friendly(var0, var1) {
  for(;;) {
    var2 = get_closest_colored_friendly(var0);

    if(!isalive(var2)) {
      wait 1;
      continue;
    }

    set_force_color(var2, var1);
    return;
  }
}

function instantly_promote_nearest_friendly(var0, var1) {
  var2 = get_closest_colored_friendly(var0);

  if(!isalive(var2)) {
    return;
  }

  set_force_color(var2, var1);
}

function instantly_promote_nearest_friendly_with_classname(var0, var1, var2) {
  var3 = get_closest_colored_friendly_with_classname(var0, var2);

  if(!isalive(var3)) {
    return;
  }

  set_force_color(var3, var1);
}

function promote_nearest_friendly_with_classname(var0, var1, var2) {
  for(;;) {
    var3 = get_closest_colored_friendly_with_classname(var0, var2);

    if(!isalive(var3)) {
      wait 1;
      continue;
    }

    set_force_color(var3, var1);
    return;
  }
}

function instantly_set_color_from_array_with_classname(var0, var1, var2) {
  var3 = 0;
  var4 = [];

  for(var5 = 0; var5 < var0.size; var5++) {
    var6 = var0[var5];

    if(var3 || !issubstr(var6.classname, var2)) {
      var4 = var6;
      continue;
    }

    var3 = 1;
    set_force_color(var6, var1);
  }

  return var4;
}

function instantly_set_color_from_array(var0, var1) {
  var2 = 0;
  var3 = [];

  for(var4 = 0; var4 < var0.size; var4++) {
    var5 = var0[var4];

    if(var2) {
      var3 = var5;
      continue;
    }

    var2 = 1;
    set_force_color(var5, var1);
  }

  return var3;
}

function wait_for_script_noteworthy_trigger(var0) {
  scripts\engine\sp\utility_code::wait_for_trigger(var0, "script_noteworthy");
}

function wait_for_targetname_trigger(var0) {
  scripts\engine\sp\utility_code::wait_for_trigger(var0, "targetname");
}

function wait_for_flag_or_timeout(var0, var1) {
  if(scripts\engine\utility::flag(var0)) {
    return;
  }

  level endon(var0);
  wait var1;
}

function wait_for_notify_or_timeout(var0, var1) {
  self endon(var0);
  wait var1;
}

function wait_for_trigger_or_timeout(var0) {
  self endon("trigger");
  wait var0;
}

function wait_for_either_trigger(var0, var1) {
  var2 = spawnStruct();
  var3 = [];
  var3 = scripts\engine\utility::array_combine(var3, getEntArray(var0, "targetname"));
  var3 = scripts\engine\utility::array_combine(var3, getEntArray(var1, "targetname"));

  for(var4 = 0; var4 < var3.size; var4++) {
    var2 thread scripts\engine\sp\utility_code::ent_waits_for_trigger(var3[var4]);
  }

  var2 waittill("done");
}

function dronespawn_bodyonly(var0) {
  var1 = scripts\sp\spawner::spawner_dronespawn(var0);
  return var1;
}

function fakeactorspawn(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  var1 = scripts\sp\spawner::spawner_dronespawn(var0);
  var1[[level.fakeactor_spawn_func]]();
  var1.spawn_funcs = var0.spawn_functions;
  var1.spawn_functions = undefined;
  var1 thread scripts\sp\spawner::run_spawn_functions();
  var1.spawner = var0;
  var1.script_fakeactor = 1;

  if(isDefined(var0.script_nodrop)) {
    var1.nodrop = var0.script_nodrop;
  }

  if(isDefined(var0.script_noragdoll)) {
    var1.noragdoll = var0.script_noragdoll;
  }

  return var1;
}

function bodyonlyspawn(var0) {
  var1 = scripts\sp\spawner::spawner_dronespawn(var0);
  var1.spawn_funcs = var0.spawn_functions;
  var1.spawn_functions = undefined;
  var1 thread scripts\sp\spawner::run_spawn_functions();
  return var1;
}

function dronespawn(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  var1 = scripts\sp\spawner::spawner_dronespawn(var0);
  var1[[level.drone_spawn_func]]();
  var1.spawn_funcs = var0.spawn_functions;
  var1.spawn_functions = undefined;
  var1 thread scripts\sp\spawner::run_spawn_functions();
  return var1;
}

function create_corpses() {
  var0 = getEntArray("corpse", "script_noteworthy");

  if(var0.size) {
    array_spawn_function(var0, &init_corpse);
  }

  var0 = getEntArray("corpse_noragdoll", "script_noteworthy");

  if(var0.size) {
    array_spawn_function(var0, &init_corpse);
  }

  var0 = get_spawner_array("corpse", "script_noteworthy");

  if(var0.size) {
    array_spawn_function(var0, &init_corpse);
    return;
  }
}

function init_corpse() {
  if(!isDefined(self.script_animation)) {
    self delete();
    return;
  }

  self.animname = "corpse";
  self startusingheroonlylighting();

  if(isai(self)) {
    self.ignoreall = 1;
  } else {
    self notsolid();
  }

  if(isDefined(self.target)) {
    var0 = scripts\engine\utility::get_target_ent(self.target);
    self dontinterpolate();

    if(isai(self)) {
      self forceteleport(var0.origin, var0.angles);
    } else {
      self.origin = var0.origin;
      self.angles = var0.angles;
    }
  }

  var1 = getweaponmodel(self.weapon);

  if(isDefined(var1) && var1 != "") {
    if(isai(self)) {
      scripts\common\ai::gun_remove();
    }

    if(!isDefined(self.script_nodrop)) {
      var2 = spawn("weapon_" + createheadicon(self.weapon), self gettagorigin("tag_weapon_right"));
      var2.angles = self gettagangles("tag_weapon_right");
    }
  }

  if(isai(self)) {
    if(self.script_noteworthy == "corpse_noragdoll") {
      self.noragdoll = 1;
    }

    set_deathanim(self.script_animation);
    self kill();
    return;
  }

  self animScripted("corpse_anim", self.origin, self.angles, scripts\engine\utility::getanim(self.script_animation), "deathplant", undefined, 0);

  if(self.script_noteworthy != "corpse_noragdoll") {
    var3 = getanimlength(scripts\engine\utility::getanim(self.script_animation));

    if(var3 > 0) {
      wait var3 * 0.35;
    }

    if(isDefined(self.fnpreragdoll)) {
      self[[self.fnpreragdoll]]();
    }

    self startragdoll();
    return;
  }
}

function get_trigger_flag() {
  if(isDefined(self.script_flag)) {
    return self.script_flag;
  }

  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
}

function set_default_pathenemy_settings() {
  self.pathenemylookahead = 50;
  self.pathenemyfightdist = 192;
}

function walk_and_talk(var0, var1, var2) {
  if(var0 == "on") {
    self._blackboard.walk_and_talk_requested = 1;

    if(isDefined(var2)) {
      if(var2 == "right") {
        self.walk_and_talk_hemisphere = "right";
      } else {
        self.walk_and_talk_hemisphere = "left";
      }
    }

    if(!isDefined(var1)) {
      self.walk_and_talk_target = level.player;
      return;
    }

    self.walk_and_talk_target = var1;

    if(!isDefined(var1.origin)) {
      return;
    }

    return;
  }

  self._blackboard.walk_and_talk_requested = 0;
}

function enable_eight_point_strafe(var0) {
  if(self.type == "dog") {
    return;
  }

  if(var0) {
    self._blackboard.eight_point_strafe_requested = 1;
    return;
  }

  self._blackboard.eight_point_strafe_requested = 0;
}

function enable_readystand() {
  self.busereadyidle = 1;
}

function disable_readystand() {
  self.busereadyidle = undefined;
}

function cqb_aim(var0) {
  if(!isDefined(var0)) {
    self.cqb_target = undefined;
    return;
  }

  self.cqb_target = var0;

  if(!isDefined(var0.origin)) {
    return;
  }
}

function set_force_cover(var0) {
  if(isDefined(var0) && var0) {
    self.forcesuppression = 1;
    return;
  }

  self.forcesuppression = undefined;
}

function first_touch(var0) {
  if(!isDefined(self.touched)) {
    self.touched = [];
  }

  if(isDefined(self.touched[var0.unique_id])) {
    return false;
  }

  self.touched[var0.unique_id] = 1;
  return true;
}

function add_hint_string(var0, var1, var2) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
  }

  level.trigger_hint_string[var0] = var1;
  precachestring(var1);

  if(isDefined(var2)) {
    level.trigger_hint_func[var0] = var2;
    return;
  }
}

function clearthreatbias(var0, var1) {
  setthreatbias(var0, var1, 0);
  setthreatbias(var1, var0, 0);
}

function set_ignoresuppression(var0) {
  self.ignoresuppression = var0;
}

function set_goalRadius(var0) {
  self.goalradius = var0;
}

function set_allowdeath(var0) {
  self.allowdeath = var0;
}

function set_run_anim(var0, var1) {
  if(getdvarint("LPNQTQRRP", 0) == 1) {
    var2 = "combat";
    set_move_anim(var2, var0);
    self.run_overrideanim = level.scr_anim[self.animname][var0];
    return;
  }

  if(isDefined(var2)) {
    self.alwaysrunforward = var2;
  } else {
    self.alwaysrunforward = 1;
  }

  scripts\common\ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim[self.animname][var1];
  self.walk_overrideanim = self.run_overrideanim;
}

function set_move_anim(var0, var1) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var0, "move", level.scr_anim[self.animname][var1]);
}

function clear_move_anim(var0) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var0, "move");
}

function set_idle_anim(var0, var1) {
  scripts\asm\asm::asm_setdemeanoranimoverride(var0, "idle", level.scr_anim[self.animname][var1]);
}

function clear_idle_anim(var0) {
  scripts\asm\asm::asm_cleardemeanoranimoverride(var0, "idle");
}

function set_dog_walk_anim() {
  self.a.movement = "walk";
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.script_nobark = 1;
}

function set_arrival_speed(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(isDefined(self.arrivalspeed)) {
    self.arrivalspeed = var0;
    return;
  }
}

function clear_arrival_speed() {
  if(isDefined(self.arrivalspeed)) {
    self.arrivalspeed = 1;
    return;
  }
}

function override_move_with_purpose(var0) {
  var1 = scripts\asm\asm::asm_lookupanimfromalias("move_walk_loop", "casual_purpose");
  scripts\asm\asm::asm_setdemeanoranimoverride(var0, "move", var1);

  if(var0 == "casual") {
    thread set_arrival_speed(1.15);
    return;
  }
}

function clear_move_with_purpose() {
  thread clear_move_anim(scripts\asm\asm::asm_getdemeanor());
  thread clear_arrival_speed();
}

function set_generic_idle_anim(var0) {
  var1 = level.scr_anim["generic"][var0];

  if(isarray(var1)) {
    self.specialidleanim = var1;
    return;
  }

  self.specialidleanim[0] = var1;
}

function clear_generic_idle_anim() {
  self.specialidleanim = undefined;
  self notify("stop_specialidle");
}

function set_generic_run_anim(var0, var1) {
  set_generic_run_anim_array(var0, undefined, var1);
}

function clear_generic_run_anim() {
  self notify("movemode");
  scripts\common\ai::enable_turnanims();
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
}

function set_generic_run_anim_array(var0, var1, var2) {
  self notify("movemode");

  if(!isDefined(var2) || var2) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  scripts\common\ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim["generic"][var0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var1)) {
    self.run_override_weights = level.scr_anim["generic"][var1];
    self.walk_override_weights = self.run_override_weights;
    return;
  }

  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

function set_run_anim_array(var0, var1, var2) {
  self notify("movemode");

  if(!isDefined(var2) || var2) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  scripts\common\ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim[self.animname][var0];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(var1)) {
    self.run_override_weights = level.scr_anim[self.animname][var1];
    self.walk_override_weights = self.run_override_weights;
    return;
  }

  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

function clear_run_anim() {
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
    var0 = "combat";
    self.allowstrafe = 1;
    clear_move_anim(var0);
    self.run_overrideanim = undefined;
    return;
  }

  if(!isDefined(self.casual_killer)) {
    scripts\common\ai::enable_turnanims();
  }

  self.alwaysrunforward = undefined;
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

function physicsjolt_proximity(var0, var1, var2) {
  self endon("death");
  self endon("stop_physicsjolt");

  if(!isDefined(var0) || !isDefined(var1) || !isDefined(var2)) {
    var0 = 400;
    var1 = 256;
    var2 = (0, 0, 0.075);
  }

  var3 = var0 * var0;
  var4 = 3;
  var5 = var2;

  for(;;) {
    wait 0.1;
    var2 = var5;

    if(self.code_classname == "script_vehicle") {
      var6 = self vehicle_getspeed();

      if(var6 < var4) {
        var7 = var6 / var4;
        var2 = var5 * var7;
      }
    }

    var8 = distancesquared(self.origin, level.player.origin);
    var7 = var3 / var8;

    if(var7 > 1) {
      var7 = 1;
    }

    var2 *= var7;
    var9 = var2[0] + var2[1] + var2[2];

    if(var9 > 0.025) {
      physicsjitter(self.origin, var0, var1, var2[2], var2[2] * 2);
    }
  }
}

function set_goal_entity(var0) {
  self setgoalentity(var0);
}

function activate_trigger(var0, var1, var2) {
  if(!isDefined(var0)) {
    activate_trigger_process(var2);
    return;
  }

  var3 = getEntArray(var0, var1);
  scripts\engine\utility::array_thread(var3, &activate_trigger_process, var2);
}

function activate_trigger_process(var0) {
  if(isDefined(self.script_color_allies)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::activate_color_trigger("allies");
  }

  if(isDefined(self.script_color_axis)) {
    self.activated_color_trigger = 1;
    scripts\sp\colors::activate_color_trigger("axis");
  }

  self notify("trigger", var0);
}

function self_delete() {
  self delete();
}

function has_color() {
  if(scripts\sp\colors::get_team() == "axis") {
    return (isDefined(self.script_color_axis) || isDefined(self.script_forcecolor));
  }

  return isDefined(self.script_color_allies) || isDefined(self.script_forcecolor);
}

function clear_colors() {
  clear_team_colors("axis");
  clear_team_colors("allies");
}

function clear_team_colors(var0) {
  level.currentcolorforced[var0]["r"] = undefined;
  level.currentcolorforced[var0]["b"] = undefined;
  level.currentcolorforced[var0]["c"] = undefined;
  level.currentcolorforced[var0]["y"] = undefined;
  level.currentcolorforced[var0]["p"] = undefined;
  level.currentcolorforced[var0]["o"] = undefined;
  level.currentcolorforced[var0]["g"] = undefined;
}

function notify_delay(var0, var1) {
  self endon("death");

  if(var1 > 0) {
    wait var1;
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(var0);
}

function name_hide() {
  if(!isDefined(self.name)) {
    return;
  }

  self.og_name = self.name;
  self.name = undefined;

  if(isDefined(self.callsign)) {
    self.og_callsign = self.callsign;
    self.callsign = "";
    return;
  }
}

function name_show() {
  self.name = self.og_name;

  if(isDefined(self.og_callsign)) {
    self.callsign = self.og_callsign;
    return;
  }
}

function place_weapon_on(var0, var1) {
  if(!scripts\anim\utility::aihasweapon(var0)) {
    scripts\common\utility::initweapon(var0);
  }

  scripts\anim\shared::placeweaponon(var0, var1);
}

function player_moves(var0) {
  var1 = level.player.origin;

  for(;;) {
    if(distance(var1, level.player.origin) > var0) {
      break;
    }

    wait 0.05;
  }
}

function waittill_either_function(var0, var1, var2, var3) {
  var4 = spawnStruct();
  thread scripts\engine\sp\utility_code::waittill_either_function_internal(var4, var0, var1);
  thread scripts\engine\sp\utility_code::waittill_either_function_internal(var4, var2, var3);
  var4 waittill("done");
}

function waittill_msg(var0) {
  self waittill(var0);
}

function in_realism_mode() {
  return level.gameskill == 4;
}

function display_hint(var0, var1, var2, var3, var4) {
  if(in_realism_mode()) {
    return;
  }

  thread display_hint_proc(var0, var1, var2, var3, var4);
}

function display_hint_forced(var0, var1, var2, var3, var4) {
  thread display_hint_proc(var0, var1, var2, var3, var4);
}

function display_hint_proc(var0, var1, var2, var3, var4) {
  if(isDefined(var3) && isDefined(var4)) {
    if(!isarray(var3)) {
      var3 = [var3];
    }

    if(!isarray(var4)) {
      var4 = [var4];
    }

    foreach(var6 in var3) {
      foreach(var8 in var4) {
        var6 endon(var8);
      }
    }
  }

  var11 = get_player_from_self();
  var11 endon("new_hint");

  if(isDefined(level.trigger_hint_func[var0])) {
    var11 endon("hint_function_cancel");
    GscBinSkip4(0x6e, var11, level.trigger_hint_func[var0]);
  }

  if(istrue(var2)) {
    wait var2;
  }

  if(isDefined(level.trigger_hint_func[var0])) {
    if(var11[[level.trigger_hint_func[var0]]]()) {
      return;
    }

    var11 thread scripts\engine\sp\utility_code::hintprint(level.trigger_hint_string[var0], level.trigger_hint_func[var0], var1, undefined, var3, var4);
    return;
  }

  var11 thread scripts\engine\sp\utility_code::hintprint(level.trigger_hint_string[var0], undefined, var1, undefined, var3, var4);
}

function display_hint_function_cancel_logic(var0) {
  for(;;) {
    if([[var0]]()) {
      self notify("hint_function_cancel");
    }

    waitframe();
  }
}

function getgenericanim(var0) {
  return level.scr_anim["generic"][var0];
}

function enable_careful() {
  self.script_careful = 1;
}

function disable_careful() {
  self.script_careful = 0;
  self notify("stop_being_careful");
}

function enable_sprint() {
  self.sprint = 1;
  scripts\common\utility::demeanor_override("sprint");
}

function disable_sprint() {
  self.sprint = undefined;
  scripts\common\utility::clear_demeanor_override();
}

function disable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = 1;
}

function enable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = undefined;
}

function set_fixednode_true() {
  self.fixednode = 1;
}

function set_fixednode_false() {
  self.fixednode = 0;
}

function spawn_ai(var0, var1) {
  if(isDefined(self.script_delay_spawn)) {
    self endon("death");
    wait self.script_delay_spawn;
  }

  var2 = undefined;
  var3 = isDefined(self.script_stealthgroup) && scripts\engine\utility::flag("stealth_enabled") && !scripts\engine\utility::flag("stealth_spotted");
  var4 = 0;

  if(isDefined(self.script_suspend)) {
    var4 = scripts\sp\spawner::prespawn_suspended_ai();

    if(self.count == 0 && !var4) {
      return undefined;
    }
  }

  var5 = 0;
  var6 = 0;

  if(isDefined(self.script_drone)) {
    var7 = dronespawn(self);
  } else if(isDefined(self.script_fakeactor)) {
    var7 = fakeactorspawn(self);
  } else if(isDefined(self.script_bodyonly)) {
    var7 = bodyonlyspawn(self);
  } else {
    var7 = 1;

    if(isDefined(self.script_forcespawn) || istrue(var3)) {
      var7 = self stalingradspawn(var6);
      var7 = 1;
    } else if(isDefined(self.script_forcespawndist) && distancesquared(self.origin, level.player.origin) > squared(self.script_forcespawndist)) {
      var7 = self stalingradspawn(var7);
      var7 = 1;
    } else {
      var7 = self dospawn(var7);
    }
  }

  if(var7) {
    if(isDefined(var6) && var6 && isalive(var7)) {
      var7 scripts\common\ai::magic_bullet_shield();
    }

    if(scripts\common\ai::spawn_failed(var7)) {
      if(!var7 && isDefined(self.script_aigroup)) {
        scripts\sp\spawner::aigroup_decrement(level._ai_group[self.script_aigroup]);
      }

      if(var7) {
        self.count--;

        if(!isDefined(self.try_og_origin)) {
          self.try_og_origin = 1;
          var7 = spawn_ai();
          return var7;
        } else {
          self.try_og_origin = undefined;
        }
      }
    } else if(var7) {}
  }

  if(isDefined(self.script_spawn_once)) {
    self delete();
  }

  return var7;
}

function function_stack(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();
  var6 thread scripts\engine\sp\utility_code::function_stack_proc(self, var0, var1, var2, var3, var4, var5);
  return scripts\engine\sp\utility_code::function_stack_wait_finish(var6);
}

function function_stack_timeout(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnStruct();
  var7 thread scripts\engine\sp\utility_code::function_stack_proc(self, var1, var2, var3, var4, var5, var6);

  if(isDefined(var7.function_stack_func_begun) || var7 scripts\engine\utility::waittill_any_timeout(var0, "function_stack_func_begun") != "timeout") {
    return scripts\engine\sp\utility_code::function_stack_wait_finish(var7);
  }

  var7 notify("death");
  return 0;
}

function function_stack_clear() {
  var0 = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun)) {
    GscBinSkip0(0x2e, 0, self.function_stack[0]);
  }

  self.function_stack = undefined;
  self notify("clear_function_stack");
  waittillframeend();

  if(!var0.size) {
    return;
  }

  if(!var0[0].function_stack_func_begun) {
    return;
  }

  self.function_stack = var0;
}

function set_blur(var0, var1) {
  setblur(var0, var1);
}

function set_goal_radius(var0) {
  self.goalradius = var0;
}

function set_goal_node(var0) {
  self.last_set_goalnode = var0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var0);
}

function set_goal_node_targetname(var0) {
  var1 = getnode(var0, "targetname");
  set_goal_node(var1);
}

function set_goal_pos(var0) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var0;
  self.last_set_goalent = undefined;
  self setgoalpos(var0);
}

function set_goal_ent(var0) {
  set_goal_pos(var0.origin);
  self.last_set_goalent = var0;

  if(isstruct(var0) && !isDefined(var0.type)) {
    var0.type = "struct";
    return;
  }
}

function get_spawner_array(var0, var1) {
  var2 = getspawnerarray();
  var3 = [];

  if(var1 == "code_classname") {
    foreach(var5 in var2) {
      if(isDefined(var5.code_classname) && var5.code_classname == var0) {
        var3 = var5;
      }
    }
  } else if(var1 == "classname") {
    foreach(var5 in var2) {
      if(isDefined(var5.classname) && var5.classname == var0) {
        var3 = var5;
      }
    }
  } else if(var1 == "target") {
    foreach(var5 in var2) {
      if(isDefined(var5.target) && var5.target == var0) {
        var3 = var5;
      }
    }
  } else if(var1 == "script_linkname") {
    foreach(var5 in var2) {
      if(isDefined(var5.script_linkname) && var5.script_linkname == var0) {
        var3 = var5;
      }
    }
  } else if(var1 == "script_noteworthy") {
    foreach(var5 in var2) {
      if(isDefined(var5.script_noteworthy) && var5.script_noteworthy == var0) {
        var3 = var5;
      }
    }
  } else if(var1 == "targetname") {}

  return var3;
}

function array_spawn(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = [];

  foreach(var5 in var0) {
    var5.count = 1;

    if(getsubstr(var5.classname, 7, 10) == "veh") {
      var6 = var5 scripts\common\utility::spawn_vehicle();

      if(isDefined(var6.target) && !isDefined(var6.script_moveoverride)) {
        var6 thread scripts\common\vehicle_paths::gopath();
      }

      var3 = var6;
      continue;
    }

    var6 = spawn_ai(var5, var1);

    if(var2) {}

    var3 = var6;
  }

  if(var2) {}

  return var3;
}

function array_spawn_targetname(var0, var1, var2, var3) {
  var4 = getspawnerarray(var0);
  var4 = array_merge(var4, getEntArray(var0, "targetname"));
  return array_spawn(var4, var1, var2);
}

function array_spawn_noteworthy(var0, var1, var2, var3) {
  var4 = get_spawner_array(var0, "script_noteworthy");
  var4 = array_merge(var4, getEntArray(var0, "script_noteworthy"));
  return array_spawn(var4, var1, var2);
}

function spawn_script_noteworthy(var0, var1) {
  var2 = getspawner(var0, "script_noteworthy");
  var3 = spawn_ai(var2, var1);
  return var3;
}

function spawn_targetname(var0, var1) {
  var2 = getspawner(var0, "targetname");
  var3 = spawn_ai(var2, var1);
  return var3;
}

function set_grenadeammo(var0) {
  self.grenadeammo = var0;
}

function set_grenadeweapon(var0) {
  var1 = strtok(var0, " ");
  self.grenadeweapon = getcompleteweaponname(var1[randomint(var1.size)]);
}

function get_player_feet_from_view() {
  var0 = self.origin;
  var1 = anglestoup(self getplayerangles());
  var2 = self getplayerviewheight();
  var3 = var0 + (0, 0, var2);
  var4 = var0 + var1 * var2;
  var5 = var3 - var4;
  var6 = var0 + var5;
  return var6;
}

function set_baseaccuracy(var0) {
  self.baseaccuracy = var0;
}

function set_attackeraccuracy(var0) {
  if(scripts\common\utility::issp() && isPlayer(self)) {
    scripts\sp\utility::set_player_attacker_accuracy(var0);
    return;
  }

  self.attackeraccuracy = var0;
}

function autosave_now(var0) {
  return scripts\sp\autosave::_autosave_game_now(var0);
}

function autosave_now_silent() {
  return scripts\sp\autosave::_autosave_game_now(1);
}

function set_generic_deathanim(var0) {
  self.deathanim = getgenericanim(var0);
}

function set_deathanim(var0) {
  self.deathanim = scripts\engine\utility::getanim(var0);
}

function clear_deathanim() {
  self.deathanim = undefined;
}

function set_dontmelee(var0) {
  self.dontmelee = var0;
}

function putgunaway() {
  scripts\anim\shared::placeweaponon(self.weapon, "none");
  self.weapon = isundefinedweapon();
}

function anim_stopanimScripted() {
  self stopanimScripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self notify("stop_animmode");
}

function antigrav_float_ai_override(var0) {
  self.allowantigrav = var0;
}

function antigrav_clear_float_ai_override() {
  self.allowantigrav = undefined;
}

function antigrav_disable_nav_obstacle_for_team(var0, var1) {
  if(var1) {
    if(!isDefined(level.antigrav.disablenavobstacleteams) || level.antigrav.disablenavobstacleteams.size == 0 || var0 == "all") {
      level.antigrav.disablenavobstacleteams = [];
      level.antigrav.disablenavobstacleteams[0] = var0;
      return;
    }

    if(level.antigrav.disablenavobstacleteams[0] != "all") {
      level.antigrav.disablenavobstacleteams = scripts\engine\utility::array_combine_unique(level.antigrav.disablenavobstacleteams, [var0]);
      return;
    }

    return;
  }

  if(!isDefined(level.antigrav.disablenavobstacleteams) || level.antigrav.disablenavobstacleteams.size == 0) {
    return;
  }

  if(var0 == "all") {
    level.antigrav.disablenavobstacleteams = undefined;
    return;
  }

  if(level.antigrav.disablenavobstacleteams[0] == "all") {
    level.antigrav.disablenavobstacleteams = [];

    if(var0 == "allies") {
      level.antigrav.disablenavobstacleteams[0] = "axis";
      return;
    }

    level.antigrav.disablenavobstacleteams[0] = "allies";
    return;
  }

  level.antigrav.disablenavobstacleteams = scripts\engine\utility::array_remove_array(level.antigrav.disablenavobstacleteams, [var0]);
}

function kill_wrapper() {
  self enabledeathshield(0);
  self kill();
  return true;
}

function array_wait_match(var0, var1, var2) {
  var3 = spawnStruct();

  foreach(var5 in var0) {
    thread array_wait_match_proc(var3, var5, var1, var2);
  }

  for(var7 = 0; var7 < var0.size; var7++) {
    var3 waittill("array_wait_match_proc");
  }
}

function array_wait_match_proc(var0, var1, var2, var3) {
  var0 endon("array_wait_success");
  var1 waittillmatch(var2, var3);
  var0 notify("array_wait_match_proc");
}

function array_any_wait_match(var0, var1, var2) {
  var3 = spawnStruct();

  foreach(var5 in var0) {
    thread array_any_wait_match_proc(var3, var5, var1, var2);
  }

  var3 waittill("array_wait_proc");
}

function array_any_wait_match_proc(var0, var1, var2, var3) {
  var1 waittillmatch(var2, var3);
  var0 notify("array_wait_proc");
}

function die() {
  self kill((0, 0, 0));
}

function getmodel(var0) {
  return level.scr_model[var0];
}

function isads() {
  return self playerads() > 0.5;
}

function disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("_disable_reinforcement");
}

function waittill_player_lookat(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var5)) {
    var5 = level.player;
  }

  var6 = spawnStruct();

  if(isDefined(var3)) {
    thread notify_delay(var6, "timeout");
  }

  var6 endon("timeout");

  if(!isDefined(var0)) {
    var0 = 0.92;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var7 = int(var1 * 20);
  var8 = var7;
  self endon("death");
  var9 = isai(self);
  var10 = undefined;

  for(;;) {
    if(var9) {
      var10 = self getEye();
    } else {
      var10 = self.origin;
    }

    if(player_looking_at(var5, var10, var0, var2, var4)) {
      var8--;

      if(var8 <= 0) {
        return 1;
      }
    } else {
      var8 = var7;
    }

    wait 0.05;
  }
}

function waittill_player_lookat_for_time(var0, var1, var2, var3) {
  waittill_player_lookat(var1, var0, var2, undefined, var3);
}

function player_looking_at(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = 0.8;
  }

  var4 = get_player_from_self();
  var5 = var4 getEye();
  var6 = vectortoangles(var0 - var5);
  var7 = anglesToForward(var6);
  var8 = var4 getplayerangles();
  var9 = anglesToForward(var8);
  var10 = vectordot(var7, var9);

  if(var10 < var1) {
    return 0;
  }

  if(isDefined(var2)) {
    return 1;
  }

  return scripts\engine\trace::ray_trace_detail_passed(var0, var5, var3, scripts\engine\trace::create_default_contents(1));
}

function either_player_looking_at(var0, var1, var2, var3) {
  for(var4 = 0; var4 < level.players.size; var4++) {
    if(player_looking_at(level.players[var4], var0, var1, var2, var3)) {
      return true;
    }
  }

  return false;
}

function point_orientation_relative_to_player(var0) {
  var1 = get_player_from_self();
  var2 = vectortoangles(var0 - var1 getEye());
  var3 = anglesToForward(var2);
  var4 = var1 getplayerangles();
  var5 = anglesToForward(var4);
  var6 = vectorcross(var3, var5);

  if(var6[2] < 0) {
    return "left";
  }

  return "right";
}

function players_within_distance(var0, var1) {
  var2 = var0 * var0;

  for(var3 = 0; var3 < level.players.size; var3++) {
    if(distancesquared(var1, level.players[var3].origin) < var2) {
      return true;
    }
  }

  return false;
}

function ai_delete_when_out_of_sight(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  var2 = 0.75;

  while(var0.size > 0) {
    wait 1;

    for(var3 = 0; var3 < var0.size; var3++) {
      if(!isalive(var0[var3])) {
        var0 = scripts\engine\utility::array_remove(var0, var0[var3]);
        continue;
      }

      if(players_within_distance(var1, var0[var3].origin)) {
        continue;
      }

      if(either_player_looking_at(var0[var3].origin + (0, 0, 48), var2, 1)) {
        continue;
      }

      if(isDefined(var0[var3].magic_bullet_shield)) {
        var0[var3] scripts\common\ai::stop_magic_bullet_shield();
      }

      var0[var3] delete();
      var0 = scripts\engine\utility::array_remove(var0, var0[var3]);
    }
  }
}

function add_wait(var0, var1, var2, var3, var4) {
  init_waits();
  var5 = spawnStruct();
  var5.caller = self;
  var5.func = var0;
  var5.parms = [];

  if(isDefined(var1)) {
    var5.parms[var5.parms.size] = var1;
  }

  if(isDefined(var2)) {
    var5.parms[var5.parms.size] = var2;
  }

  if(isDefined(var3)) {
    var5.parms[var5.parms.size] = var3;
  }

  if(isDefined(var4)) {
    var5.parms[var5.parms.size] = var4;
  }

  if(!isDefined(level.waits.wait_any_func_array)) {
    level.waits.wait_any_func_array = [var5];
    return;
  }

  level.waits.wait_any_func_array[level.waits.wait_any_func_array.size] = var5;
}

function add_abort(var0, var1, var2, var3) {
  init_waits();
  var4 = spawnStruct();
  var4.caller = self;
  var4.func = var0;
  var4.parms = [];

  if(isDefined(var1)) {
    var4.parms[var4.parms.size] = var1;
  }

  if(isDefined(var2)) {
    var4.parms[var4.parms.size] = var2;
  }

  if(isDefined(var3)) {
    var4.parms[var4.parms.size] = var3;
  }

  level.waits.abort_wait_any_func_array[level.waits.abort_wait_any_func_array.size] = var4;
}

function add_func(var0, var1, var2, var3, var4, var5) {
  init_waits();
  var6 = spawnStruct();
  var6.caller = self;
  var6.func = var0;
  var6.parms = [];

  if(isDefined(var1)) {
    var6.parms[var6.parms.size] = var1;
  }

  if(isDefined(var2)) {
    var6.parms[var6.parms.size] = var2;
  }

  if(isDefined(var3)) {
    var6.parms[var6.parms.size] = var3;
  }

  if(isDefined(var4)) {
    var6.parms[var6.parms.size] = var4;
  }

  if(isDefined(var5)) {
    var6.parms[var6.parms.size] = var5;
  }

  level.waits.run_func_after_wait_array[level.waits.run_func_after_wait_array.size] = var6;
}

function add_call(var0, var1, var2, var3, var4, var5) {
  init_waits();
  var6 = spawnStruct();
  var6.caller = self;
  var6.func = var0;
  var6.parms = [];

  if(isDefined(var1)) {
    var6.parms[var6.parms.size] = var1;
  }

  if(isDefined(var2)) {
    var6.parms[var6.parms.size] = var2;
  }

  if(isDefined(var3)) {
    var6.parms[var6.parms.size] = var3;
  }

  if(isDefined(var4)) {
    var6.parms[var6.parms.size] = var4;
  }

  if(isDefined(var5)) {
    var6.parms[var6.parms.size] = var5;
  }

  level.waits.run_call_after_wait_array[level.waits.run_call_after_wait_array.size] = var6;
}

function add_noself_call(var0, var1, var2, var3, var4, var5) {
  init_waits();
  var6 = spawnStruct();
  var6.func = var0;
  var6.parms = [];

  if(isDefined(var1)) {
    var6.parms[var6.parms.size] = var1;
  }

  if(isDefined(var2)) {
    var6.parms[var6.parms.size] = var2;
  }

  if(isDefined(var3)) {
    var6.parms[var6.parms.size] = var3;
  }

  if(isDefined(var4)) {
    var6.parms[var6.parms.size] = var4;
  }

  if(isDefined(var5)) {
    var6.parms[var6.parms.size] = var5;
  }

  level.waits.run_noself_call_after_wait_array[level.waits.run_noself_call_after_wait_array.size] = var6;
}

function add_endon(var0) {
  init_waits();
  var1 = spawnStruct();
  var1.caller = self;
  var1.ender = var0;
  level.waits.do_wait_endons_array[level.waits.do_wait_endons_array.size] = var1;
}

function do_wait_any() {
  init_waits();
  do_wait(level.waits.wait_any_func_array.size - 1);
}

function do_wait(var0) {
  init_waits();

  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = spawnStruct();
  var2 = level.waits.wait_any_func_array;
  var3 = level.waits.do_wait_endons_array;
  var4 = level.waits.run_func_after_wait_array;
  var5 = level.waits.run_call_after_wait_array;
  var6 = level.waits.run_noself_call_after_wait_array;
  var7 = level.waits.abort_wait_any_func_array;
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  var1.count = var2.size;
  var1 scripts\engine\utility::array_levelthread(var2, &scripts\engine\sp\utility_code::waittill_func_ends, var3);
  var1 thread scripts\engine\sp\utility_code::do_abort(var7);
  var1 endon("any_funcs_aborted");

  for(;;) {
    if(var1.count <= var0) {
      break;
    }

    var1 waittill("func_ended");
  }

  var1 notify("all_funcs_ended");
  scripts\engine\utility::array_levelthread(var4, &scripts\engine\sp\utility_code::exec_func, []);
  scripts\engine\utility::array_levelthread(var5, &scripts\engine\sp\utility_code::exec_call);
  scripts\engine\utility::array_levelthread(var6, &scripts\engine\sp\utility_code::exec_call_noself);
}

function do_funcs() {
  var0 = spawnStruct();
  var1 = level.waits.run_func_after_wait_array;
  level.waits.run_func_after_wait_array = [];

  foreach(var3 in var1) {
    level scripts\engine\sp\utility_code::exec_func(var3, []);
  }

  var0 notify("all_funcs_ended");
}

function is_default_start() {
  if(isDefined(level.forced_start_catchup) && level.forced_start_catchup == 1) {
    return false;
  }

  if(isDefined(level.default_start_override_alt) && level.default_start_override_alt == level.start_point) {
    return true;
  }

  if(isDefined(level.default_start_override)) {
    if(level.default_start_override == level.start_point) {
      return true;
    }
  } else if(scripts\sp\starts::level_has_start_points()) {
    return (level.start_point == level.start_functions[0]["name"]);
  }

  return level.start_point == "default";
}

function manual_linkTo(var0, var1) {
  var0 endon("death");
  self endon("death");

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  for(;;) {
    self.origin = var0.origin + var1;
    self.angles = var0.angles;
    wait 0.05;
  }
}

function nextmission(var0) {
  scripts\sp\endmission::nextmission_internal(var0);
}

function nextmission_preload(var0, var1) {
  if(!scripts\engine\utility::flag_exist("nextmission_preload_complete")) {
    scripts\engine\utility::flag_init("nextmission_preload_complete");
  }

  scripts\engine\utility::flag_clear("nextmission_preload_complete");
  scripts\sp\endmission::nextmission_preload_internal(var0, var1);
  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

function nextmission_primeloadbink() {
  scripts\sp\endmission::nextmission_primeloadbink_internal();
}

function make_array(var0, var1, var2, var3, var4) {
  var5 = [];
  GscBinSkip0(0x2e, var5.size, var0);
}

function fail_on_friendly_fire() {
  level.failonfriendlyfire = 1;
}

function normal_friendly_fire_penalty() {
  level.failonfriendlyfire = 0;
}

function getplayerclaymores() {
  var0 = 0;
  var1 = self.equippedweapons;

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(var3.basename == "claymore") {
      var0 += self getweaponammoclip(var3);
    }
  }

  return var0;
}

function lerp_saveddvar(var0, var1, var2) {
  var3 = getdvarfloat(var0);
  level notify(var0 + "_lerp_savedDvar");
  level endon(var0 + "_lerp_savedDvar");
  var4 = var1 - var3;
  var5 = 0.05;
  var6 = int(var2 / var5);

  if(var6 > 0) {
    var7 = var4 / var6;

    while(var6) {
      var3 += var7;
      setsaveddvar(var0, var3);
      wait var5;
      var6--;
    }
  }

  setsaveddvar(var0, var1);
}

function lerp_omnvar(var0, var1, var2, var3) {
  var4 = getomnvar(var0);
  level notify(var0 + "_lerp_savedDvar");
  level endon(var0 + "_lerp_savedDvar");
  var5 = var1 - var4;
  var6 = 0.05;
  var7 = int(var2 / var6);
  var8 = var5 / var7;

  while(var7) {
    var4 += var8;

    if(isDefined(var3)) {
      var9 = scripts\engine\math::round_float(var4, var3);
      setomnvar(var0, var9);
    } else {
      setomnvar(var0, var4);
    }

    wait var6;
    var7--;
  }

  if(isDefined(var3)) {
    var9 = scripts\engine\math::round_float(var1, var3);
    setomnvar(var0, var9);
    return;
  }

  setomnvar(var0, var1);
}

function lerp_omnvarint(var0, var1, var2) {
  var3 = getomnvar(var0);
  level notify(var0 + "_lerp_savedDvar");
  level endon(var0 + "_lerp_savedDvar");
  var4 = var1 - var3;
  var5 = 0.05;
  var6 = int(var2 / var5);
  var7 = var4 / var6;

  while(var6) {
    var3 += var7;
    setomnvar(var0, int(var3));
    wait var5;
    var6--;
  }

  setomnvar(var0, int(var1));
}

function slowmo_setspeed_slow(var0) {
  level.slowmo.speed_slow = var0;
}

function slowmo_setspeed_norm(var0) {
  level.slowmo.speed_norm = var0;
}

function slowmo_setlerptime_in(var0) {
  level.slowmo.lerp_time_in = var0;
}

function slowmo_setlerptime_out(var0) {
  level.slowmo.lerp_time_out = var0;
}

function slowmo_lerp_in() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }

  scripts\sp\audio::set_slowmo_dialogue_start();
  setslowmotion(level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in);
}

function slowmo_lerp_out() {
  if(isDefined(level.no_slowmo) && level.no_slowmo) {
    return;
  }

  setslowmotion(level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out);
  scripts\sp\audio::set_slowmo_dialogue_end();
}

function add_earthquake(var0, var1, var2, var3) {
  level.earthquake[var0]["magnitude"] = var1;
  level.earthquake[var0]["duration"] = var2;
  level.earthquake[var0]["radius"] = var3;
}

function get_average_origin(var0) {
  var1 = (0, 0, 0);

  foreach(var3 in var0) {
    var1 += var3.origin;
  }

  return var1 * 1 / var0.size;
}

function generic_damage_think() {
  self.damage_functions = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    var10 = self.damage_functions;
    var12 = getfirstarraykey(var10);

    if(isDefined(var12)) {
      var11 = var10[var12];
      GscBinSkip1(0x74, var11, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    }

    var10 = undefined;
    var12 = undefined;
  }
}

function add_damage_function(var0) {
  self.damage_functions[self.damage_functions.size] = var0;
}

function remove_damage_function(var0) {
  var1 = [];

  foreach(var3 in self.damage_functions) {
    if(var3 == var0) {
      continue;
    }

    var1 = var3;
  }

  self.damage_functions = var1;
}

function playlocalsoundwrapper(var0) {
  self playlocalsound(var0);
}

function teleport_player(var0) {
  level.player setOrigin(var0.origin);

  if(isDefined(var0.angles)) {
    level.player setplayerangles(var0.angles);
    return;
  }
}

function translate_local() {
  var0 = [];

  if(isDefined(self.entities)) {
    var0 = self.entities;
  }

  if(isDefined(self.entity)) {
    GscBinSkip0(0x2e, var0.size, self.entity);
  }

  scripts\engine\utility::array_levelthread(var0, &scripts\engine\sp\utility_code::translate_local_on_ent);
}

function open_up_fov(var0, var1, var2, var3, var4, var5, var6) {
  level.player endon("stop_opening_fov");
  wait var0;
  level.player playerlinktodelta(var1, var2, 1, var3, var4, var5, var6, 1);
}

function get_ai_touching_volume(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = "all";
  }

  if(!isDefined(var1)) {
    var1 = "all";
  }

  var3 = getaispeciesarray(var0, var1);
  var4 = [];

  foreach(var6 in var3) {
    if(var6 istouching(self)) {
      var4 = var6;
    }
  }

  return var4;
}

function get_drones_touching_volume(var0) {
  if(!isDefined(var0)) {
    var0 = "all";
  }

  var1 = [];

  if(var0 == "all") {
    var1 = array_merge(level.drones["allies"].array, level.drones["axis"].array);
    var1 = array_merge(var1, level.drones["neutral"].array);
  } else {
    var1 = level.drones[var0].array;
  }

  var2 = [];

  foreach(var4 in var1) {
    if(!isDefined(var4)) {
      continue;
    }

    if(var4 istouching(self)) {
      var2 = var4;
    }
  }

  return var2;
}

function get_drones_with_targetname(var0) {
  var1 = array_merge(level.drones["allies"].array, level.drones["axis"].array);
  var1 = array_merge(var1, level.drones["neutral"].array);
  var2 = [];

  foreach(var4 in var1) {
    if(!isDefined(var4)) {
      continue;
    }

    if(isDefined(var4.targetname) && var4.targetname == var0) {
      var2 = var4;
    }
  }

  return var2;
}

function set_count(var0) {
  self.count = var0;
}

function follow_path(var0, var1, var2) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var3 = self.script_forcegoal;
  self.script_forcegoal = 1;
  scripts\sp\spawner::go_to_node(var0, var1, var2);
  self.script_forcegoal = var3;

  if(!isDefined(self.script_forcegoal) || !self.script_forcegoal) {
    self.goalradius = level.default_goalradius;
    return;
  }
}

function enable_dynamic_run_speed(var0, var1, var2, var3, var4, var5, var6) {
  setdvarifuninitialized("scr_debug_dynamic_run_speed", 0);
  disable_dynamic_run_speed(0);

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 205;
  }

  if(!isDefined(var3)) {
    var3 = 250;
  }

  if(!isDefined(var4)) {
    var4 = 100;
  }

  if(!isDefined(var5)) {
    var5 = -100;
  }

  if(!isDefined(var6)) {
    var6 = -200;
  }

  thread scripts\engine\sp\utility_code::dynamic_run_speed_thread(var0, var1, var2, var3, var4, var5, var6);
}

function disable_dynamic_run_speed(var0) {
  if(!isDefined(var0)) {
    var0 = 165;
  }

  self notify("stop_dynamic_run_speed");

  if(istrue(var0)) {
    scripts\engine\utility::set_movement_speed(var0);
    return;
  }
}

function waittill_entity_in_range_or_timeout(var0, var1, var2) {
  self endon("death");
  var0 endon("death");

  if(!isDefined(var2)) {
    var2 = 5;
  }

  var3 = gettime() + var2 * 1000;

  while(isDefined(var0)) {
    if(distancesquared(var0.origin, self.origin) <= var1 * var1) {
      break;
    }

    if(gettime() > var3) {
      break;
    }

    wait 0.1;
  }
}

function waittill_entity_in_range(var0, var1) {
  self endon("death");
  var0 endon("death");

  while(isDefined(var0)) {
    if(distancesquared(var0.origin, self.origin) <= var1 * var1) {
      break;
    }

    wait 0.1;
  }
}

function waittill_entity_out_of_range(var0, var1) {
  self endon("death");
  var0 endon("death");

  while(isDefined(var0)) {
    if(distancesquared(var0.origin, self.origin) > var1 * var1) {
      break;
    }

    wait 0.1;
  }
}

function player_speed_percent(var0, var1) {
  var2 = int(getDvar("NSRPQNLSNK"));

  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = var2;
  }

  var3 = int(level.player.g_speed * var0 * 0.01);
  player_speed_set(level.player, var3, var1);
}

function blend_movespeedscale_percent(var0, var1, var2) {
  var3 = self;

  if(!isPlayer(var3)) {
    var3 = level.player;
  }

  if(!isDefined(var3.movespeedscale)) {
    var3.movespeedscale = 1;
  }

  var4 = var0 * 0.01;
  blend_movespeedscale(var3, var4, var1, var2);
}

function player_speed_set(var0, var1) {
  var2 = int(getDvar("NSRPQNLSNK"));

  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = var2;
  }

  var3 = &scripts\engine\sp\utility_code::g_speed_get_func;
  var4 = &scripts\engine\sp\utility_code::g_speed_set_func;
  thread player_speed_proc(level.player, var0, var1, var3, var4);
}

function player_bob_scale_set(var0, var1) {
  var2 = &scripts\engine\sp\utility_code::g_bob_scale_get_func;
  var3 = &scripts\engine\sp\utility_code::g_bob_scale_set_func;
  thread player_speed_proc(level.player, var0, var1, var2, var3);
}

function blend_movespeedscale(var0, var1, var2) {
  var3 = self;

  if(!isPlayer(var3)) {
    var3 = level.player;
  }

  if(!isDefined(var3.movespeedscale)) {
    var3.movespeedscale = 1;
  }

  var4 = &scripts\engine\sp\utility_code::movespeed_get_func;
  var5 = &scripts\engine\sp\utility_code::movespeed_set_func;
  thread player_speed_proc(var3, var0, var1, var4, var5, "blend_movespeedscale");
}

function player_speed_proc(var0, var1, var2, var3, var4, var5) {
  self notify(var4);
  self endon(var4);
  var6 = [[var2]](var5);
  var7 = var0;

  if(isDefined(var1) && var1 > 0) {
    var8 = var7 - var6;
    var9 = 0.05;
    var10 = var1 / var9;
    var11 = var8 / var10;

    while(abs(var7 - var6) > abs(var11 * 1.1)) {
      var6 += var11;
      [[var3]](var6, var5);
      wait var9;
    }
  }

  [[var3]](var7, var5);
}

function player_speed_default(var0) {
  if(!isDefined(level.player.g_speed)) {
    return;
  }

  player_speed_set(level.player, level.player.g_speed, var0);
  waittillframeend();
  level.player.g_speed = undefined;
}

function blend_movespeedscale_default(var0, var1) {
  var2 = self;

  if(!isPlayer(var2)) {
    var2 = level.player;
  }

  if(!isDefined(var2.movespeedscale)) {
    return;
  }

  blend_movespeedscale(var2, 1, var0, var1);
  var2.movespeedscale = undefined;
}

function teleport_ent(var0) {
  if(isPlayer(self)) {
    self setOrigin(var0.origin);
    self setplayerangles(var0.angles);
    return;
  }

  if(isai(self)) {
    self forceteleport(var0.origin, var0.angles);
    return;
  }

  self.origin = var0.origin;
  self.angles = var0.angles;
}

function teleport_to_ent_tag(var0, var1) {
  var2 = var0 gettagorigin(var1);
  var3 = var0 gettagangles(var1);
  self dontinterpolate();

  if(isPlayer(self)) {
    self setOrigin(var2);
    self setplayerangles(var3);
    return;
  }

  if(isai(self)) {
    self forceteleport(var2, var3);
    return;
  }

  self.origin = var2;
  self.angles = var3;
}

function teleport_ai(var0) {
  self forceteleport(var0.origin, var0.angles);
  self setgoalpos(self.origin);
  self setgoalnode(var0);
}

function move_all_fx(var0) {
  foreach(var2 in level.createfxent) {
    var2.v["origin"] = var2.v["origin"] + var0;
  }
}

function issliding() {
  return self issprintsliding();
}

function beginsliding(var0, var1, var2) {
  self endon("stop_sliding");
  self endon("death");
  var3 = self;

  if(var3 scripts\engine\utility::ent_flag_exist("is_sliding")) {
    var3 scripts\engine\utility::ent_flag_clear("is_sliding");
  } else {
    var3 scripts\engine\utility::ent_flag_init("is_sliding");
  }

  var4 = isDefined(level.custom_linkto_slide);
  var5 = level.player scripts\engine\utility::spawn_tag_origin();
  var3.slidemodel = var5;
  var6 = level.player scripts\engine\utility::spawn_tag_origin();
  var3.fx_tag = var6;
  var7 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0);
  var8 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var3, var7);
  var9 = 0;
  var10 = (0, 0, 0);
  var11 = var8["normal"];

  for(;;) {
    if(!var3 isjumping()) {
      var8 = scripts\engine\trace::ray_trace(level.player getEye(), level.player getEye() - (0, 0, 100), var3, var7);
      var11 = var8["normal"];

      if(isDefined(var11)) {
        var12 = vectordot(var11, (0, 0, 1));

        if(var12 <= 0.95) {
          var9 = acos(var12);
          var10 = var8["position"];
          break;
        }
      }
    }

    wait 0.05;
  }

  var11 = vectorNormalize(scripts\engine\utility::flatten_vector(var11, (0, 0, 1)));
  var13 = vectorNormalize(vectorcross(var11, (0, 1, 0)));
  var14 = vectorNormalize(vectorcross(var11, var13));
  var5.angles = var3.angles;
  var5.origin = var3.origin;
  var15 = vectortoangles(var11) + var11 * var9;
  var5.gesture_target = spawn("script_model", var5.origin + anglesToForward(var15) * 2000);
  var5.gesture_target.angles = var15;
  var3.fx_tag.angles = var15;

  if(!isDefined(var0)) {
    var0 = var3 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(var1)) {
    var1 = 10;
  }

  if(!isDefined(var2)) {
    var2 = 0.035;
  }

  var5 moveslide((0, 0, 15), 15, var0);
  thread play_sound_on_entity(var3);
  var3 hidelegsandshadow();
  var3 forceplaygestureviewmodel("ges_slide", var5.gesture_target, 0.2);

  if(isDefined(level._effect["vfx_slide_dirt"])) {
    var16 = scripts\engine\utility::getfx("vfx_slide_dirt");
    playFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var3.fx_tag, "tag_origin");
    var3.fx_tag show();
  }

  var3 scripts\engine\utility::ent_flag_set("is_sliding");

  if(var4) {
    var3 playerlinktoblend(var5, undefined, 1);
    wait 1;
    var3 playerlinktodelta(var5, "tag_origin", 1, 180, 180, 180, 180, 1);
  } else {
    var3 playerlinktodelta(var5, "tag_origin", 0, 180, 180, 180, 180);
  }

  setsaveddvar("NMLOKNMRSK", 1);
  var3 scripts\common\utility::allow_fire(0);
  var3 scripts\common\utility::allow_prone(0);
  var3 scripts\common\utility::allow_stand(0);
  var3 scripts\common\utility::allow_reload(0);
  var3 thread scripts\engine\sp\utility_code::doslide(var5, var1, var2);
  thread play_loop_sound_on_tag(var3);
}

function endsliding() {
  var0 = self;

  if(level.player isgestureplaying()) {
    var0 stopgestureviewmodel("ges_slide");
    var0 notify("stop soundfoot_slide_plr_loop");
    thread play_sound_on_entity(var0);
  }

  var0 scripts\engine\utility::delaycall(0.2, &showlegsandshadow);

  if(level.player islinked()) {
    var0 unlink();
    var0 setvelocity(var0.slidemodel.slidevelocity);
  }

  if(isDefined(var0.fx_tag)) {
    if(isDefined(level._effect["vfx_slide_dirt"])) {
      var1 = scripts\engine\utility::getfx("vfx_slide_dirt");

      if(isDefined(var1)) {
        stopFXOnTag(scripts\engine\utility::getfx("vfx_slide_dirt"), var0.fx_tag, "tag_origin");
      }
    }

    var0.fx_tag delete();
  }

  if(var0 scripts\engine\utility::ent_flag_exist("is_sliding") && var0 scripts\engine\utility::ent_flag("is_sliding")) {
    var0 scripts\engine\utility::ent_flag_clear("is_sliding");
    var0 scripts\common\utility::allow_fire(1);
    var0 scripts\common\utility::allow_prone(1);
    var0 scripts\common\utility::allow_stand(1);
    var0 scripts\common\utility::allow_reload(1);
  }

  var0.slidemodel delete();
  setsaveddvar("NMLOKNMRSK", 0);
  var0 notify("stop_sliding");
}

function beginslidinglegacy(var0, var1, var2) {
  var3 = self;

  if(var3 scripts\engine\utility::ent_flag_exist("is_sliding")) {
    var3 scripts\engine\utility::ent_flag_clear("is_sliding");
  } else {
    var3 scripts\engine\utility::ent_flag_init("is_sliding");
  }

  thread play_sound_on_entity(var3);
  thread play_loop_sound_on_tag(var3);
  var4 = isDefined(level.custom_linkto_slide);

  if(!isDefined(var0)) {
    var0 = var3 getvelocity() + (0, 0, -10);
  }

  if(!isDefined(var1)) {
    var1 = 10;
  }

  if(!isDefined(var2)) {
    var2 = 0.035;
  }

  var5 = spawn("script_origin", var3.origin);
  var5.angles = var3.angles;
  var3.slidemodel = var5;
  var5 moveslide((0, 0, 15), 15, var0);
  var3 scripts\engine\utility::ent_flag_set("is_sliding");

  if(var4) {
    var3 playerlinktoblend(var5, undefined, 1);
  } else {
    var3 playerlinkTo(var5);
  }

  var3 scripts\common\utility::allow_weapon(0);
  var3 scripts\common\utility::allow_prone(0);
  var3 scripts\common\utility::allow_crouch(1);
  var3 scripts\common\utility::allow_stand(0);
  var3 thread scripts\engine\sp\utility_code::doslide(var5, var1, var2);
}

function endslidinglegacy() {
  var0 = self;
  var0 notify("stop soundfoot_slide_plr_loop");
  thread play_sound_on_entity(var0);
  var0 unlink();
  var0 setvelocity(var0.slidemodel.slidevelocity);
  var0.slidemodel delete();
  var0 scripts\common\utility::allow_weapon(1);
  var0 scripts\common\utility::allow_prone(1);
  var0 scripts\common\utility::allow_crouch(1);
  var0 scripts\common\utility::allow_stand(1);
  var0 notify("stop_sliding");

  if(var0 scripts\engine\utility::ent_flag_exist("is_sliding") && var0 scripts\engine\utility::ent_flag("is_sliding")) {
    var0 scripts\engine\utility::ent_flag_clear("is_sliding");
    return;
  }
}

function getentwithflag(var0) {
  var1 = scripts\sp\trigger::get_load_trigger_classes();
  var2 = [];

  foreach(var4 in var1) {
    if(!issubstr(var6, "flag")) {
      continue;
    }

    var5 = getEntArray(var6, "classname");
    var2 = scripts\engine\utility::array_combine(var2, var5);
  }

  var7 = scripts\sp\trigger::get_load_trigger_funcs();

  foreach(var4 in var7) {
    if(!issubstr(var9, "flag")) {
      continue;
    }

    var5 = getEntArray(var9, "targetname");
    var2 = scripts\engine\utility::array_combine(var2, var5);
  }

  var10 = undefined;

  foreach(var12 in var2) {
    if(var12.script_flag == var0) {
      return var12;
    }
  }
}

function getentarraywithflag(var0) {
  var1 = scripts\sp\trigger::get_load_trigger_classes();
  var2 = [];

  foreach(var4 in var1) {
    if(!issubstr(var6, "flag")) {
      continue;
    }

    var5 = getEntArray(var6, "classname");
    var2 = scripts\engine\utility::array_combine(var2, var5);
  }

  var7 = scripts\sp\trigger::get_load_trigger_funcs();

  foreach(var4 in var7) {
    if(!issubstr(var9, "flag")) {
      continue;
    }

    var5 = getEntArray(var9, "targetname");
    var2 = scripts\engine\utility::array_combine(var2, var5);
  }

  var10 = [];

  foreach(var12 in var2) {
    if(var12.script_flag == var0) {
      var10 = var12;
    }
  }

  return var10;
}

function set_z(var0, var1) {
  return (var0[0], var0[1], var1);
}

function set_y(var0, var1) {
  return (var0[0], var1, var0[2]);
}

function set_x(var0, var1) {
  return (var1, var0[1], var0[2]);
}

function get_rumble_ent(var0) {
  var1 = get_player_from_self();

  if(!isDefined(var0)) {
    var0 = "steady_rumble";
  }

  var2 = spawn("script_origin", var1 getEye());
  var2.intensity = 1;
  var2 thread scripts\engine\sp\utility_code::update_rumble_intensity(var1, var0);
  return var2;
}

function set_rumble_intensity(var0) {
  self.intensity = var0;
}

function rumble_ramp_on(var0) {
  thread rumble_ramp_to(1, var0);
}

function rumble_ramp_off(var0) {
  thread rumble_ramp_to(0, var0);
}

function rumble_ramp_to(var0, var1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var2 = var1 * 20;
  var3 = var0 - self.intensity;
  var4 = var3 / var2;

  for(var5 = 0; var5 < var2; var5++) {
    self.intensity += var4;
    wait 0.05;
  }

  self.intensity = var0;
}

function get_player_from_self() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self)) {
      return level.player;
    }

    return self;
  }

  return level.player;
}

function get_player_gameskill() {
  return int(self getplayersetting("gameskill"));
}

function array_delete_evenly(var0, var1, var2) {
  var3 = [];
  var1 = var2 - var1;

  foreach(var5 in var0) {
    var3 = var5;

    if(var3.size == var2) {
      var3 = scripts\engine\utility::array_randomize(var3);

      for(var6 = var1; var6 < var3.size; var6++) {
        var3[var6] delete();
      }

      var3 = [];
    }
  }

  var8 = [];

  foreach(var5 in var0) {
    if(!isDefined(var5)) {
      continue;
    }

    var8 = var5;
  }

  return var8;
}

function waittill_in_range(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0.5;
  }

  self endon("death");

  while(isDefined(self)) {
    if(distancesquared(var0, self.origin) <= var1 * var1) {
      break;
    }

    wait var2;
  }
}

function waittill_out_of_range(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0.5;
  }

  self endon("death");

  while(isDefined(self)) {
    if(distancesquared(var0, self.origin) > var1 * var1) {
      break;
    }

    wait var2;
  }
}

function disable_surprise() {
  self.newenemyreactiondistsq = 0;
}

function enable_surprise() {
  self.newenemyreactiondistsq = squared(512);
}

function getvehiclearray() {
  return vehicle_getarray();
}

function getteamvehiclearray(var0) {
  if(!isarray(var0)) {
    GscBinSkip0(0x2e, 0, var0);
  }

  var1 = vehicle_getarray();

  foreach(var3 in var1) {
    if(isDefined(var3.team) && scripts\engine\utility::array_contains(var0, var3.team)) {
      continue;
    }

    var1 = scripts\engine\utility::array_remove(var1, var3);
  }

  return var1;
}

function getvehiclearray_in_radius(var0, var1, var2) {
  var3 = scripts\engine\utility::get_array_of_closest(var0, vehicle_getarray(), undefined, undefined, var1);

  if(isDefined(var2)) {
    var4 = [];

    foreach(var6 in var3) {
      if(scripts\engine\utility::is_equal(var6.script_team, var2)) {
        var4 = var6;
      }
    }

    var3 = var4;
  }

  return var3;
}

function hint(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level.hintelement)) {
    level.hintelement scripts\sp\hud_util::destroyelem();
  }

  level.hintelement = scripts\sp\hud_util::createfontstring("default", 1.5);
  level.hintelement scripts\sp\hud_util::setpoint("MIDDLE", undefined, 0, 30 + var2);
  level.hintelement.color = (1, 1, 1);
  level.hintelement settext(var0);
  level.hintelement.alpha = 0;
  level.hintelement fadeovertime(0.5);
  level.hintelement.alpha = 1;
  wait 0.5;
  level.hintelement endon("death");

  if(isDefined(var1)) {
    wait var1;
  } else {
    return;
  }

  level.hintelement fadeovertime(var3);
  level.hintelement.alpha = 0;
  wait var3;
  level.hintelement scripts\sp\hud_util::destroyelem();
}

function hint_fade() {
  var0 = 1;

  if(isDefined(level.hintelement)) {
    level notify("clearing_hints");
    level.hintelement fadeovertime(var0);
    level.hintelement.alpha = 0;
    wait var0;
    return;
  }
}

function kill_deathflag(var0, var1) {
  if(!isDefined(level.flag[var0])) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  foreach(var3 in level.deathflags[var0]) {
    foreach(var5 in var3) {
      if(isalive(var5)) {
        var5 thread scripts\engine\sp\utility_code::kill_deathflag_proc(var1);
        continue;
      }

      var5 delete();
    }
  }
}

function get_player_view_controller(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = "player_view_controller";
  }

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  var4 = var0 gettagorigin(var1);
  var5 = spawnturret("misc_turret", var4, var3);
  var5.angles = var0 gettagangles(var1);
  var5 setModel("tag_turret");
  var5 linkTo(var0, var1, var2, (0, 0, 0));
  var5 makeunusable();
  var5 hide();
  var5 setmode("manual");
  return var5;
}

function create_blend(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4 childthread scripts\engine\sp\utility_code::process_blend(var0, self, var1, var2, var3);
  return var4;
}

function store_players_weapons(var0) {
  if(!isDefined(self.stored_weapons)) {
    self.stored_weapons = [];
  }

  var1 = [];
  var2 = self getweaponslistall();

  foreach(var4 in var2) {
    var5 = createheadicon(var4);
    var1 = [];
    var1["clip_left"] = self getweaponammoclip(var4, "left");
    var1["clip_right"] = self getweaponammoclip(var4, "right");
    var1["stock"] = self getweaponammostock(var4);
  }

  if(!isDefined(var0)) {
    var0 = "default";
  }

  self.stored_weapons[var0] = [];
  self.stored_weapons[var0]["current_weapon"] = self getcurrentweapon();
  self.stored_weapons[var0]["inventory"] = var1;
}

function restore_players_weapons(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(!isDefined(self.stored_weapons) || !isDefined(self.stored_weapons[var0])) {
    return;
  }

  self takeallweapons();

  foreach(var4, var3 in self.stored_weapons[var0]["inventory"]) {
    if(weaponinventorytype(var4) != "altmode") {
      self giveweapon(var4);
    }

    self setweaponammoclip(var4, var3["clip_left"], "left");
    self setweaponammoclip(var4, var3["clip_right"], "right");
    self setweaponammostock(var4, var3["stock"]);
  }

  var5 = self.stored_weapons[var0]["current_weapon"];

  if(!nullweapon(var5)) {
    if(istrue(var1)) {
      self switchtoweaponimmediate(var5);
      return;
    }

    self switchtoweapon(var5);
    return;
  }
}

function hide_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;
    case "script_brushmodel":
      self hide();
      self notsolid();

      if(self.spawnflags & 1) {
        self connectpaths();
      }

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
      break;
  }
}

function show_entity() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;
    case "script_brushmodel":
      self show();
      self solid();

      if(self.spawnflags & 1) {
        self disconnectPaths();
      }

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
      break;
  }
}

function set_moveplaybackrate(var0, var1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  self endon("death");

  if(isDefined(var1)) {
    var2 = scripts\asm\asm::asm_getmoveplaybackrate();
    var3 = var0 - var2;
    var4 = 0.05;
    var5 = var1 / var4;
    var6 = var3 / var5;

    while(abs(var0 - var2) > abs(var6 * 1.1)) {
      scripts\asm\asm::asm_setmoveplaybackrate(var2 + var6);
      wait var4;
      var2 = scripts\asm\asm::asm_getmoveplaybackrate();
    }
  }

  scripts\asm\asm::asm_setmoveplaybackrate(var0);
}

function array_spawn_function(var0, var1, var2, var3, var4, var5) {
  foreach(var7 in var0) {
    thread add_spawn_function(var7, var1, var2, var3, var4);
  }
}

function array_spawn_function_targetname(var0, var1, var2, var3, var4, var5) {
  var6 = getspawnerarray(var0);
  var6 = array_merge(var6, getEntArray(var0, "targetname"));
  array_spawn_function(var6, var1, var2, var3, var4, var5);
}

function array_spawn_function_noteworthy(var0, var1, var2, var3, var4, var5) {
  var6 = get_spawner_array(var0, "script_noteworthy");
  var6 = array_merge(var6, getEntArray(var0, "script_noteworthy"));
  array_spawn_function(var6, var1, var2, var3, var4, var5);
}

function array_spawn_function_aigroup(var0, var1, var2, var3, var4, var5) {
  var6 = get_ai_group_spawners(var0);
  array_spawn_function(var6, var1, var2, var3, var4, var5);
}

function enable_dontevershoot() {
  self.dontevershoot = 1;
}

function disable_dontevershoot() {
  self.dontevershoot = 0;
}

function create_sunflare_setting(var0) {
  if(!isDefined(level.sunflare_settings)) {
    level.sunflare_settings = [];
  }

  var1 = spawnStruct();
  var1.name = var0;
  level.sunflare_settings[var0] = var1;
  return var1;
}

function mask_exploders_in_volume(var0) {
  if(getDvar("LSTTOTKPNP") != "") {
    return;
  }

  var1 = getEntArray("script_brushmodel", "classname");
  var2 = getEntArray("script_model", "classname");

  for(var3 = 0; var3 < var2.size; var3++) {
    var1 = var2[var3];
  }

  foreach(var5 in var0) {
    foreach(var7 in var1) {
      if(isDefined(var7.script_prefab_exploder)) {
        var7.script_exploder = var7.script_prefab_exploder;
      }

      if(!isDefined(var7.script_exploder)) {
        continue;
      }

      if(!isDefined(var7.model)) {
        continue;
      }

      if(var7.code_classname != "script_model") {
        continue;
      }

      if(!var7 istouching(var5)) {
        continue;
      }

      var7.masked_exploder = 1;
    }
  }
}

function activate_exploders_in_volume() {
  var0 = spawn("script_origin", (0, 0, 0));

  foreach(var2 in level.createfxent) {
    if(!isDefined(var2.v["masked_exploder"])) {
      continue;
    }

    var0.origin = var2.v["origin"];
    var0.angles = var2.v["angles"];

    if(!var0 istouching(self)) {
      continue;
    }

    var3 = var2.v["masked_exploder"];
    var4 = var2.v["masked_exploder_spawnflags"];
    var5 = var2.v["masked_exploder_script_disconnectpaths"];
    var6 = spawn("script_model", (0, 0, 0), var4);
    var6 setModel(var3);
    var6.origin = var2.v["origin"];
    var6.angles = var2.v["angles"];
    var2.v["masked_exploder"] = undefined;
    var2.v["masked_exploder_spawnflags"] = undefined;
    var2.v["masked_exploder_script_disconnectpaths"] = undefined;
    var6.disconnect_paths = var5;
    var6.script_exploder = var2.v["exploder"];
    scripts\common\exploder::setup_individual_exploder(var6);
    var2.model = var6;
  }

  var0 delete();
}

function delete_destructibles_in_volumes(var0, var1) {
  foreach(var3 in var0) {
    var3.destructibles = [];
  }

  var5 = ["destructible_toy", "destructible_vehicle"];
  var6 = 0;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  foreach(var8 in var5) {
    var9 = getEntArray(var8, "targetname");

    foreach(var11 in var9) {
      foreach(var3 in var0) {
        if(var1) {
          var6++;
          var6 %= 5;

          if(var6 == 1) {
            wait 0.05;
          }
        }

        if(!var3 istouching(var11)) {
          continue;
        }

        var11 delete();
        break;
      }
    }
  }
}

function delete_exploders_in_volumes(var0, var1) {
  var2 = getEntArray("script_brushmodel", "classname");
  var3 = getEntArray("script_model", "classname");

  for(var4 = 0; var4 < var3.size; var4++) {
    var2 = var3[var4];
  }

  var5 = [];
  var6 = spawn("script_origin", (0, 0, 0));
  var7 = 0;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  foreach(var9 in var0) {
    foreach(var11 in var2) {
      if(!isDefined(var11.script_exploder)) {
        continue;
      }

      var6.origin = var11 getorigin();

      if(!var9 istouching(var6)) {
        continue;
      }

      var5 = var11;
    }
  }

  scripts\engine\utility::array_delete(var5);
  var6 delete();
}

function waittill_volume_dead() {
  for(;;) {
    var0 = getaispeciesarray("axis", "all");
    var1 = 0;

    foreach(var3 in var0) {
      if(!isalive(var3)) {
        continue;
      }

      if(var3 istouching(self)) {
        var1 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var1) {
      var5 = get_ai_touching_volume("axis");

      if(!var5.size) {
        break;
      }
    }

    wait 0.05;
  }
}

function waittill_volume_dead_or_dying() {
  var0 = 0;

  for(;;) {
    var1 = getaispeciesarray("axis", "all");
    var2 = 0;

    foreach(var4 in var1) {
      if(!isalive(var4)) {
        continue;
      }

      if(var4 istouching(self)) {
        if(var4 scripts\engine\utility::doinglongdeath()) {
          continue;
        }

        var2 = 1;
        var0 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var2) {
      var6 = get_ai_touching_volume("axis");

      if(!var6.size) {
        break;
      } else {
        var0 = 1;
      }
    }

    wait 0.05;
  }

  return var0;
}

function waittill_volume_dead_then_set_flag(var0) {
  waittill_volume_dead();
  scripts\engine\utility::flag_set(var0);
}

function waittill_targetname_volume_dead_then_set_flag(var0, var1) {
  var2 = getEnt(var0, "targetname");
  waittill_volume_dead_then_set_flag(var2, var1);
}

function array_index_by_parameters(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var1 = var3;
  }

  return var1;
}

function array_index_by_classname(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var1 = var3;
  }

  return var1;
}

function array_index_by_script_index(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(isDefined(var3.script_index)) {
      var1 = var3;
    }
  }

  return var1;
}

function get_color_volume_from_trigger() {
  var0 = scripts\engine\sp\utility_code::get_color_info_from_trigger();
  var1 = var0["team"];

  foreach(var3 in var0["codes"]) {
    var4 = level.arrays_of_colorcoded_volumes[var1][var3];

    if(isDefined(var4)) {
      return var4;
    }
  }

  return undefined;
}

function get_color_nodes_from_trigger() {
  var0 = scripts\engine\sp\utility_code::get_color_info_from_trigger();
  var1 = var0["team"];

  foreach(var3 in var0["codes"]) {
    var4 = level.arrays_of_colorcoded_nodes[var1][var3];

    if(isDefined(var4)) {
      return var4;
    }
  }

  return undefined;
}

function get_splineid(var0) {
  return getcsplineid(var0);
}

function get_splineidarray(var0) {
  return getcsplineidarray(var0);
}

function earthquake_and_rumble(var0) {
  playrumbleonposition("grenade_rumble", var0);
  earthquake(0.4, 0.5, var0, 400);
}

function pathrandompercent_set(var0) {
  if(!isDefined(self.old_pathrandompercent)) {
    self.old_pathrandompercent = self.pathrandompercent;
  }

  self.pathrandompercent = var0;
}

function pathrandompercent_zero() {
  if(isDefined(self.old_pathrandompercent)) {
    return;
  }

  self.old_pathrandompercent = self.pathrandompercent;
  self.pathrandompercent = 0;
}

function pathrandompercent_reset() {
  self.pathrandompercent = self.old_pathrandompercent;
  self.old_pathrandompercent = undefined;
}

function walkdist_zero() {
  if(isDefined(self.old_walkdistfacingmotion)) {
    return;
  }

  self.old_walkdist = self.walkdist;
  self.old_walkdistfacingmotion = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
}

function walkdist_reset() {
  self.walkdist = self.old_walkdist;
  self.walkdistfacingmotion = self.old_walkdistfacingmotion;
  self.old_walkdist = undefined;
  self.old_walkdistfacingmotion = undefined;
}

function enable_ignorerandombulletdamage_drone() {
  thread ignorerandombulletdamage_drone_proc();
}

function ignorerandombulletdamage_drone_proc() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.ignorerandombulletdamage = 1;
  self.fakehealth = self.health;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var0, var1);

    if(!isPlayer(var1) && issentient(var1)) {
      if(isDefined(var1.enemy) && var1.enemy != self) {
        continue;
      }
    }

    self.fakehealth -= var0;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  self kill();
}

function hide_notsolid() {
  if(!isai(self)) {
    self notsolid();
  }

  self hide();
}

function show_solid() {
  if(!isai(self)) {
    self solid();
  }

  self show();
}

function set_brakes(var0) {
  self.veh_brake = var0;
}

function disable_ignorerandombulletdamage_drone() {
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

function timeoutent(var0) {
  var1 = spawnStruct();
  var1 scripts\engine\utility::delaythread(var0, &scripts\engine\utility::send_notify, "timeout");
  return var1;
}

function delaychildthread(var0, var1, var2, var3, var4, var5, var6, var7) {
  childthread scripts\engine\sp\utility_code::delaychildthread_proc(var1, var0, var2, var3, var4, var5, var6, var7);
}

function flagwaitthread(var0, var1, var2, var3, var4, var5, var6) {
  if(!isarray(var0)) {
    var0 = [var0, 0];
  }

  thread scripts\engine\sp\utility_code::flagwaitthread_proc(var1, var0, var2, var3, var4, var5, var6);
}

function waittillthread(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  if(!isarray(var0)) {
    var0 = [var0, 0];
  }

  thread scripts\engine\sp\utility_code::waittillthread_proc(var1, var0, var2, var3, var4, var5, var6);
}

function enable_danger_react(var0) {
  var0 *= 1000;
  self.dodangerreact = 1;
  self.dangerreactduration = var0;
  self.neversprintforvariation = undefined;
}

function disable_danger_react() {
  self.dodangerreact = 0;
  self.neversprintforvariation = 1;
}

function set_group_advance_to_enemy_parameters(var0, var1) {
  level.advancetoenemyinterval = var0;
  level.advancetoenemygroupmax = var1;
}

function reset_group_advance_to_enemy_timer(var0) {
  level.lastadvancetoenemytime[var0] = gettime();
}

function string_is_single_digit_integer(var0) {
  if(var0.size > 1) {
    return false;
  }

  var1 = [];
  GscBinSkip0(0x2e, "0", 1);
}

function set_battlechatter_variable(var0, var1) {
  level.battlechatter[var0] = var1;
  scripts\engine\sp\utility_code::update_battlechatter_hud();
}

function get_minutes_and_seconds(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "minutes", 0);
}

function player_has_weapon(var0) {
  var1 = var0;

  if(isstring(var0)) {
    var1 = asmdevgetallstates(var0);
  }

  var2 = level.player.primaryinventory;

  foreach(var4 in var2) {
    if(isnullweapon(var4, var1, 1)) {
      return true;
    }
  }

  return false;
}

function player_has_base_weapon(var0) {
  var1 = var0;

  if(isstring(var0)) {
    var1 = asmdevgetallstates(var0);
  }

  var2 = level.player.primaryinventory;

  foreach(var4 in var2) {
    if(var4.basename == var1.basename) {
      return true;
    }
  }

  return false;
}

function player_has_equipment(var0, var1) {
  var2 = var0;

  if(isstring(var0)) {
    var2 = asmdevgetallstates(var0);
  }

  var3 = level.player.offhandinventory;

  foreach(var5 in var3) {
    if(isnullweapon(var5, var2, 1)) {
      return true;
    }
  }

  return false;
}

function graph_position(var0, var1, var2, var3, var4) {
  var5 = var4 - var2;
  var6 = var3 - var1;
  var7 = var5 / var6;
  var0 -= var3;
  var0 = var7 * var0;
  var0 += var4;
  return var0;
}

function musiclength(var0) {
  var1 = lookupsoundlength(var0);
  var1 *= 0.001;
  return var1;
}

function is_command_bound(var0) {
  var1 = getkeybinding(var0);
  return var1["count"];
}

function template_level(var0) {
  iprintlnbold("remove 'template_level( " + var0 + " );' from " + var0 + ".gsc - this will error as of 5/19");
}

function fx_volume_pause_noteworthy(var0, var1) {
  thread fx_volume_pause_noteworthy_thread(var0, var1);
}

function fx_volume_pause_noteworthy_thread(var0, var1) {
  var2 = getEnt(var0, "script_noteworthy");
  var2 notify("new_volume_command");
  var2 endon("new_volume_command");
  wait 0.05;
  scripts\engine\sp\utility_code::fx_volume_pause(var2, var1);
}

function fx_volume_restart_noteworthy(var0) {
  thread fx_volume_restart_noteworthy_thread(var0);
}

function fx_volume_restart_noteworthy_thread(var0) {
  var1 = getEnt(var0, "script_noteworthy");
  var1 notify("new_volume_command");
  var1 endon("new_volume_command");
  wait 0.05;

  if(!isDefined(var1.fx_paused)) {
    return;
  }

  var1.fx_paused = undefined;
  fx_volume_restart(var1);
}

function fx_volume_restart(var0) {
  scripts\engine\utility::array_thread(var0.fx, &restarteffect);
}

function add_cleanup_ent(var0, var1) {
  if(!isDefined(level.cleanup_ents)) {
    level.cleanup_ents = [];
  }

  if(!isDefined(level.cleanup_ents[var1])) {
    level.cleanup_ents[var1] = [];
  }

  level.cleanup_ents[var1][level.cleanup_ents[var1].size] = var0;
}

function cleanup_ents(var0) {
  var1 = level.cleanup_ents[var0];
  var1 = scripts\engine\utility::array_removeundefined(var1);
  scripts\engine\utility::array_delete(var1);
  level.cleanup_ents[var0] = undefined;
}

function cleanup_ents_removing_bullet_shield(var0) {
  if(!isDefined(level.cleanup_ents)) {
    return;
  }

  if(!isDefined(level.cleanup_ents[var0])) {
    return;
  }

  var1 = level.cleanup_ents[var0];
  var1 = scripts\engine\utility::array_removeundefined(var1);

  foreach(var3 in var1) {
    if(!isai(var3)) {
      continue;
    }

    if(!isalive(var3)) {
      continue;
    }

    if(!isDefined(var3.magic_bullet_shield)) {
      continue;
    }

    if(!var3.magic_bullet_shield) {
      continue;
    }

    var3 scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\engine\utility::array_delete(var1);
  level.cleanup_ents[var0] = undefined;
}

function add_trigger_function(var0) {
  if(!isDefined(self.trigger_functions)) {
    thread scripts\engine\sp\utility_code::add_trigger_func_thread();
  }

  self.trigger_functions[self.trigger_functions.size] = var0;
}

function getallweapons() {
  var0 = [];
  var1 = getEntArray();

  foreach(var3 in var1) {
    if(!isDefined(var3.classname)) {
      continue;
    }

    if(scripts\engine\utility::string_starts_with(var3.classname, "weapon_")) {
      var0 = var3;
    }
  }

  return var0;
}

function move_with_rate(var0, var1, var2) {
  self notify("newmove");
  self endon("newmove");

  if(!isDefined(var2)) {
    var2 = 200;
  }

  var3 = distance(self.origin, var0);
  var4 = var3 / var2;
  var5 = vectorNormalize(var0 - self.origin);
  self moveTo(var0, var4, 0, 0);
  self rotateTo(var1, var4, 0, 0);
  wait var4;

  if(!isDefined(self)) {
    return;
  }

  self.velocity = var5 * var3 / var4;
}

function flag_on_death(var0) {
  level endon(var0);
  self waittill("death");
  scripts\engine\utility::flag_set(var0);
}

function enable_damagefeedback() {
  level.damagefeedback = 1;
}

function disable_damagefeedback() {
  level.damagefeedback = 0;
}

function is_damagefeedback_enabled() {
  return isDefined(level.damagefeedback) && level.damagefeedback;
}

function worldtolocalcoords(var0) {
  var1 = var0 - self.origin;
  return (vectordot(var1, anglesToForward(self.angles)), -1 * vectordot(var1, anglestoright(self.angles)), vectordot(var1, anglestoup(self.angles)));
}

function sound_fade_and_delete(var0, var1) {
  self scalevolume(0, var0);

  if(istrue(var1)) {
    scripts\engine\utility::delaycall(var0 + 0.05, &stoploopsound);
  } else {
    scripts\engine\utility::delaycall(var0 + 0.05, &stopsounds);
  }

  scripts\engine\utility::delaycall(var0 + 0.1, &delete);
}

function sound_fade_in(var0, var1, var2, var3) {
  self endon("death");
  var1 = clamp(var1, 0, 1);
  var2 = max(0.05, var2);
  self scalevolume(0);
  wait 0.05;

  if(isDefined(var3)) {
    self playLoopSound(var0);
  } else {
    self playSound(var0);
  }

  wait 0.05;
  scripts\engine\utility::delaycall(0.05, &scalevolume, var1, var2);
}

function intro_screen_create(var0, var1, var2, var3, var4) {
  if(!isDefined(level.introscreen)) {
    level.introscreen = spawnStruct();
  }

  level.introscreen.completed_delay = 3;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = undefined;
  level.introscreen.lines = [var0, var1, var2, var3, var4];
  scripts\engine\utility::noself_array_call(level.introscreen.lines, &precachestring);
}

function intro_screen_custom_func(var0) {
  if(!isDefined(level.introscreen)) {
    level.introscreen = spawnStruct();
  }

  level.introscreen.customfunc = var0;
}

function register_archetype(var0, var1, var2) {
  scripts\anim\animset::registerarchetype(var0, var1, var2);
}

function archetype_exists(var0) {
  return scripts\anim\animset::archetypeexists(var0);
}

function set_archetype(var0) {
  self.animarchetype = var0;
  self notify("move_loop_restart");

  if(var0 == "creepwalk") {
    self.sharpturnlookaheaddist = 72;
    return;
  }
}

function clear_archetype() {
  if(isDefined(self.animarchetype) && self.animarchetype == "creepwalk") {
    self.sharpturnlookaheaddist = 30;
  }

  self.animarchetype = undefined;
  self notify("move_loop_restart");
}

function transient_load(var0) {
  if(istransientloaded(var0)) {
    return;
  }

  if(!scripts\engine\utility::flag_exist(var0 + "_loaded")) {
    scripts\engine\utility::flag_init(var0 + "_loaded");
  }

  loadtransient(var0);

  while(!istransientloaded(var0)) {
    waitframe();
  }

  scripts\engine\utility::flag_set(var0 + "_loaded");
  level notify("new_transient_loaded");
}

function transient_unload(var0) {
  if(!istransientloaded(var0)) {
    return;
  }

  unloadtransient(var0);

  while(istransientloaded(var0)) {
    waitframe();
  }

  scripts\engine\utility::flag_clear(var0 + "_loaded");
}

function transient_load_array(var0) {
  foreach(var2 in var0) {
    thread transient_load(var2);
  }

  for(;;) {
    var4 = 1;

    foreach(var2 in var0) {
      if(!istransientloaded(var2)) {
        var4 = 0;
        break;
      }
    }

    if(var4) {
      break;
    }

    waitframe();
  }

  level notify("new_transient_loaded");
}

function transient_unload_array(var0) {
  foreach(var2 in var0) {
    thread transient_unload(var2);
  }

  for(;;) {
    var4 = 1;

    foreach(var2 in var0) {
      if(istransientloaded(var2)) {
        var4 = 0;
        break;
      }
    }

    if(var4) {
      break;
    }

    waitframe();
  }
}

function transient_init(var0) {
  scripts\engine\utility::flag_init(var0 + "_loaded");
}

function transient_switch(var0, var1) {
  if(scripts\engine\utility::flag(var0 + "_loaded")) {
    transient_unload(var0);
  }

  if(!scripts\engine\utility::flag(var1 + "_loaded")) {
    transient_load(var1);
    return;
  }
}

function transient_unloadall_and_load(var0) {
  unloadalltransients();
  transient_load(var0);
}

function follow_path_and_animate(var0, var1) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var2 = var0;
  var3 = undefined;
  var4 = undefined;

  if(!isDefined(var1)) {
    var1 = 300;
  }

  self.current_follow_path = var2;
  var2 scripts\engine\utility::script_delay();

  while(isDefined(var2)) {
    self.current_follow_path = var2;

    if(isDefined(var2.lookahead)) {
      break;
    }

    if(isDefined(level.struct_class_names["targetname"][var2.targetname])) {
      var4 = &follow_path_animate_set_struct;
    } else if(isDefined(var2.classname)) {
      var4 = &follow_path_animate_set_ent;
    } else {
      var4 = &follow_path_animate_set_node;
    }

    if(isDefined(var2.radius) && var2.radius != 0) {
      self.goalradius = var2.radius;
    }

    if(self.goalradius < 16) {
      self.goalradius = 16;
    }

    if(isDefined(var2.height) && var2.height != 0) {
      self.goalheight = var2.height;
    }

    var5 = self.goalradius;
    self childthread[[var4]](var2);

    if(isDefined(var2.animation)) {
      var2 waittill(var2.animation);
    } else {
      for(;;) {
        self waittill("goal");

        if(distance(var2.origin, self.origin) < var5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var2 notify("trigger", self);

    if(isDefined(var2.script_flag_set)) {
      scripts\engine\utility::flag_set(var2.script_flag_set);
    }

    if(isDefined(var2.script_parameters)) {
      var6 = strtok(var2.script_parameters, " ");

      for(var7 = 0; var7 < var6.size; var7++) {
        if(isDefined(level.custom_followpath_parameter_func)) {
          self[[level.custom_followpath_parameter_func]](var6[var7], var2);
        }

        if(self.type == "dog") {
          continue;
        }

        switch (var6[var7]) {
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

    if(!isDefined(var2.script_requires_player) && var1 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(follow_path_wait_for_player(var2, var1)) {
          break;
        }

        if(isDefined(var2.animation)) {
          self.goalradius = var5;
          self setgoalpos(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isDefined(var2.target)) {
      break;
    }

    if(isDefined(var2.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var2.script_flag_wait);
    }

    var2 scripts\engine\utility::script_delay();
    var2 = var2 scripts\engine\utility::get_target_ent();
  }

  self notify("path_end_reached");
}

function follow_path_wait_for_player(var0, var1) {
  if(distance(level.player.origin, var0.origin) < distance(self.origin, var0.origin)) {
    return true;
  }

  var2 = undefined;
  var2 = anglesToForward(self.angles);
  var3 = vectorNormalize(level.player.origin - self.origin);

  if(isDefined(var0.target)) {
    var4 = scripts\engine\utility::get_target_ent(var0.target);
    var2 = vectorNormalize(var4.origin - var0.origin);
  } else if(isDefined(var0.angles)) {
    var2 = anglesToForward(var0.angles);
  } else {
    var2 = anglesToForward(self.angles);
  }

  if(vectordot(var2, var3) > 0) {
    return true;
  }

  if(distance(level.player.origin, self.origin) < var1) {
    return true;
  }

  return false;
}

function follow_path_animate_set_node(var0) {
  self notify("follow_path_new_goal");

  if(isDefined(var0.animation)) {
    var0 scripts\sp\anim::anim_generic_reach(self, var0.animation);
    self notify("starting_anim", var0.animation);

    if(isDefined(var0.script_parameters) && issubstr(var0.script_parameters, "gravity")) {
      var0 scripts\sp\anim::anim_generic_gravity(self, var0.animation);
    } else {
      var0 scripts\common\anim::anim_generic_run(self, var0.animation);
    }

    self setgoalpos(self.origin);
    return;
  }

  set_goal_node(var0);
}

function follow_path_animate_set_ent(var0) {
  self notify("follow_path_new_goal");

  if(isDefined(var0.animation)) {
    var0 scripts\sp\anim::anim_generic_reach(self, var0.animation);
    self notify("starting_anim", var0.animation);

    if(isDefined(var0.script_parameters) && issubstr(var0.script_parameters, "gravity")) {
      var0 scripts\sp\anim::anim_generic_gravity(self, var0.animation);
    } else {
      var0 scripts\common\anim::anim_generic_run(self, var0.animation);
    }

    self setgoalpos(self.origin);
    return;
  }

  set_goal_ent(var0);
}

function follow_path_animate_set_struct(var0) {
  self notify("follow_path_new_goal");

  if(isDefined(var0.animation)) {
    var0 scripts\sp\anim::anim_generic_reach(self, var0.animation);
    self notify("starting_anim", var0.animation);
    scripts\common\ai::disable_exits();

    if(isDefined(var0.script_parameters) && issubstr(var0.script_parameters, "gravity")) {
      var0 scripts\sp\anim::anim_generic_gravity(self, var0.animation);
    } else {
      var0 scripts\common\anim::anim_generic_run(self, var0.animation);
    }

    scripts\engine\utility::delaythread(0.05, &scripts\common\ai::enable_exits);
    self setgoalpos(self.origin);
    return;
  }

  set_goal_pos(var0.origin);
}

function post_load_precache(var0) {
  if(!isDefined(level.post_load_funcs)) {
    level.post_load_funcs = [];
  }

  level.post_load_funcs = scripts\engine\utility::array_add(level.post_load_funcs, var0);
}

function ui_action_slot_force_active_on(var0) {
  var1 = "ui_actionslot_" + var0 + "_forceActive";
  setDvar(var1, "on");
}

function ui_action_slot_force_active_off(var0) {
  var1 = "ui_actionslot_" + var0 + "_forceActive";
  setDvar(var1, "turn_off");
}

function ui_action_slot_force_active_one_time(var0) {
  var1 = "ui_actionslot_" + var0 + "_forceActive";
  setDvar(var1, "onetime");
}

function init_waits() {
  if(!scripts\engine\utility::add_init_script("waits", &init_waits)) {
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

function set_start_location(var0, var1) {
  var2 = [];

  if(isstring(var0)) {
    var2 = scripts\engine\utility::get_target_array(var0);
  } else if(isarray(var0)) {
    var2 = var0;
  }

  if(var2.size == 0) {
    return;
  }

  foreach(var4 in var1) {
    var5 = undefined;

    foreach(var7 in var2) {
      if(!isDefined(var7.script_noteworthy)) {
        continue;
      }

      if(isPlayer(var4)) {
        if(var7.script_noteworthy == "player") {
          var5 = var7;
          break;
        }

        continue;
      }

      if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == var7.script_noteworthy) {
        var5 = var7;
        break;
      }
    }

    if(isDefined(var5)) {
      var5.taken = 1;
      var4.start_node = var5;

      if(isai(var4)) {
        var4 setgoalpos(var5.origin);
      }

      teleport_ent(var4, var5);
    }
  }

  foreach(var4 in var1) {
    if(isDefined(var4.start_node)) {
      continue;
    }

    foreach(var7 in var2) {
      if(!isDefined(var7.taken)) {
        var7.taken = 1;
        var4.start_node = var7;

        if(isai(var4)) {
          var4 setgoalpos(var7.origin);
        }

        teleport_ent(var4, var7);
        break;
      }
    }
  }

  foreach(var4 in var1) {
    if(isDefined(var4.start_node)) {
      var4.start_node = undefined;
    }
  }

  foreach(var7 in var2) {
    if(isDefined(var7.taken)) {
      var7.taken = undefined;
    }
  }
}

function kleenex_popup(var0) {}

function allow_nvg(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = scripts\common\input_allow::allow_input_internal("NVG", var0, var1);

  if(isDefined(var3) && !var3) {
    thread scripts\sp\nvg\nvg_player::disable_nvg_proc(1, var2);
    return;
  }

  if(isDefined(var3) && var3) {
    thread scripts\sp\nvg\nvg_player::disable_nvg_proc(0);
    return;
  }
}

function set_nvg_vision(var0) {
  level.player scripts\sp\nvg\nvg_player::set_nvg_vision_proc(var0);
}

function set_nvg_light(var0) {
  level.player scripts\sp\nvg\nvg_player::set_nvg_light_proc(var0);
}

function set_nvg_flir(var0) {
  level.player scripts\sp\nvg\nvg_player::set_nvg_flir_proc(var0);
}

function is_flir_vision_on() {
  if(isDefined(self.nvg) && self.nvg.flir) {
    return 1;
  }

  return 0;
}

function player_gesture_combat(var0, var1) {
  self endon("death");
  var2 = 0;
  var3 = undefined;
  var4 = 0;

  if(get_player_demeanor(level.player) == "safe") {
    var3 = 1;
    var4 = 1;
  }

  var5 = 0;

  if(isDefined(var1)) {
    var2 = self playgestureviewmodel(var0, var1, var5, var3, undefined);
  } else {
    var2 = self playgestureviewmodel(var0, undefined, var5, var3, undefined);
  }

  return var2;
}

function player_gesture_noncombat(var0, var1) {
  self endon("death");

  if(self isfiring()) {
    return 0;
  }

  if(self isreloading()) {
    return 0;
  }

  return player_gesture_force(var0, var1);
}

function player_gesture_force(var0, var1) {
  self endon("death");
  var2 = 0;
  var3 = undefined;
  var4 = 0;

  if(get_player_demeanor(level.player) == "safe") {
    var3 = 0.2;
    var4 = 1;
  }

  if(isDefined(var1) && isent(var1)) {
    var2 = self forceplaygestureviewmodel(var0, var1, var3, undefined, undefined);
  } else {
    var2 = self forceplaygestureviewmodel(var0, undefined, var3, undefined, undefined);
  }

  if(var2) {
    thread scripts\sp\player\gestures::player_gestures_input_disable(var0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, undefined, "gesture");
  }

  return var2;
}

function get_ai_group_count(var0) {
  return level._ai_group[var0].spawnercount + level._ai_group[var0].aicount;
}

function get_ai_group_sentient_count(var0) {
  level._ai_group[var0].ai = scripts\engine\utility::array_removedead_or_dying(level._ai_group[var0].ai);
  level._ai_group[var0].ai = scripts\engine\utility::array_removeundefined(level._ai_group[var0].ai);
  return level._ai_group[var0].aicount;
}

function get_ai_group_spawner_count(var0) {
  return level._ai_group[var0].spawnercount;
}

function get_ai_group_death_count(var0) {
  return level._ai_group[var0].aideaths;
}

function get_ai_group_spawners(var0) {
  return level._ai_group[var0].spawners;
}

function get_ai_group_ai(var0) {
  level._ai_group[var0].ai = scripts\engine\utility::array_removedead_or_dying(level._ai_group[var0].ai);
  level._ai_group[var0].ai = scripts\engine\utility::array_removeundefined(level._ai_group[var0].ai);
  return level._ai_group[var0].ai;
}

function waittill_ai_group_dead(var0) {
  while(level._ai_group[var0].aicount || level._ai_group[var0].spawnercount) {
    wait 0.05;
  }
}

function fx_playontag_safe(var0, var1, var2, var3, var4) {
  if(!isDefined(self.fx_ticket_queue)) {
    fx_regulate_init();
  }

  thread fx_playontag_safe_internal(var0, var1, var2, var3, var4);
}

function fx_playontag_safe_internal(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var2)) {
    wait var2;
  }

  fx_regulate();

  if(!isDefined(var4) || !var4) {
    test_tag(var1, var0);
  }

  playFXOnTag(scripts\engine\utility::getfx(var0), self, var1);
}

function fx_stopontag_safe(var0, var1, var2, var3, var4) {
  if(!isDefined(self.fx_ticket_queue)) {
    fx_regulate_init();
  }

  thread fx_stopontag_safe_internal(var0, var1, var2, var3, var4);
}

function test_tag(var0, var1) {
  if(self.model == "") {}

  if(isai(self)) {
    var2 = 0;
    var3 = [];

    if(isDefined(self.headmodel) && self.headmodel != "") {
      GscBinSkip0(0x2e, var3.size, self.headmodel);
    }

    if(isDefined(self.hatmodel) && self.hatmodel != "") {
      GscBinSkip0(0x2e, var3.size, self.hatmodel);
    }

    if(!nullweapon(self.weapon)) {
      GscBinSkip0(0x2e, var3.size, getweaponmodel(self.weapon));
    }

    GscBinSkip0(0x2e, var3.size, self.model);
  }

  if(!scripts\engine\utility::hastag(self.model, var2)) {
    return;
  }
}

function fx_stopontag_safe_internal(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var2)) {
    wait var2;
  }

  fx_regulate();

  if(!isDefined(var4) || !var4) {
    test_tag(var1, var0);
  }

  stopFXOnTag(scripts\engine\utility::getfx(var0), self, var1);
}

function fx_killontag_safe(var0, var1, var2, var3, var4) {
  if(!isDefined(self.fx_ticket_queue)) {
    fx_regulate_init();
  }

  thread fx_killontag_safe_internal(var0, var1, var2, var3, var4);
}

function fx_killontag_safe_internal(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var3)) {
    self endon(var3);
  }

  if(isDefined(var2)) {
    wait var2;
  }

  fx_regulate();

  if(!isDefined(var4) || !var4) {
    test_tag(var1, var0);
  }

  if(var1 == "tag_flash" && nullweapon(self.weapon)) {
    return;
  }

  killfxontag(scripts\engine\utility::getfx(var0), self, var1);
}

function get_fx_ticket() {
  self.fx_ticket++;
  return scripts\engine\utility::string(self.fx_ticket);
}

function fx_regulate_init() {
  if(isDefined(self.fx_ticket_queue)) {
    return;
  }

  self.fx_ticket_queue = [];
  self.fx_ticket = 0;
  thread fx_regulator();
}

function fx_regulator() {
  self endon("entitydeleted");
  var0 = 0;

  for(;;) {
    self waittill("new_fx_call");

    while(self.fx_ticket_queue.size > 0) {
      var1 = self.fx_ticket_queue[0];
      self.fx_ticket_queue = scripts\engine\utility::array_remove(self.fx_ticket_queue, var1);
      self notify(var1);
      var0++;

      if(var0 == 3) {
        wait 0.05;
        var0 = 0;
      }
    }
  }
}

function fx_regulate() {
  self endon("death");
  self endon("entitydeleted");
  var0 = get_fx_ticket();
  self.fx_ticket_queue = scripts\engine\utility::array_add(self.fx_ticket_queue, var0);
  self notify("new_fx_call");
  self waittill(var0);
}

function stop_player_gesture(var0) {
  if(isDefined(var0)) {
    self stopgestureviewmodel(var0);
  } else {
    self stopgestureviewmodel();
  }

  self notify("gesture_stop");
}

function set_player_demeanor(var0) {
  self notify("entering_new_demeanor");

  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  waittillframeend();

  switch (var0) {
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

function get_player_demeanor() {
  return level.player getdemeanorviewmodel();
}

function init_gravity() {
  if(!isDefined(level.gravity_gameplay)) {
    level.gravity_gameplay = getdvarint("NPOQPMP");
    level.gravity_physics = getomnvar("physics_gravity_z");
    return;
  }
}

function scale_gravity(var0, var1) {
  init_gravity();

  if(isDefined(var0)) {
    setsaveddvar("NPOQPMP", level.gravity_gameplay * var0);
  }

  if(isDefined(var1)) {
    physics_setgravity((0, 0, level.gravity_physics * var1));
    return;
  }
}

function atmosphere_enable(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(var0 && !level.atmosphere) {
    level.atmosphere = var0;
    return;
  }

  if(!var0 && level.atmosphere) {
    level.atmosphere = var0;
    return;
  }
}

function set_gravity(var0, var1) {
  init_gravity();

  if(isDefined(var0)) {
    setsaveddvar("NPOQPMP", var0);
  }

  if(isDefined(var1)) {
    physics_setgravity((0, 0, var1));
    return;
  }
}

function reset_gravity() {
  setsaveddvar("NPOQPMP", level.gravity_gameplay);
  physics_setgravity((0, 0, level.gravity_physics));
}

function gesture_stop(var0) {
  if(isDefined(self.unittype) && self.unittype == "c6") {
    thread scripts\asm\gesture\script_funcs::ai_gesture_stop_c6(var0);
  } else {
    thread scripts\asm\gesture\script_funcs::ai_gesture_eyes_stop(var0 * 0.1);
    thread scripts\asm\gesture\script_funcs::ai_gesture_stop(var0);
  }

  self notify("stop_lookat");
  self notify("gesture_natural_stop");
  self.playing_gesture = undefined;
}

function gesture_torso_stop(var0) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_torso_stop(var0);
}

function gesture_eyes_stop(var0) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_eyes_stop(var0);
}

function gesture_head_stop(var0) {
  if(self.unittype == "c6") {
    thread scripts\asm\gesture\script_funcs::ai_gesture_stop_c6(var0);
  } else {
    scripts\asm\gesture\script_funcs::ai_gesture_stop(var0);
  }

  self notify("stop_lookat");
}

function gesture_follow_lookat(var0, var1, var2) {
  self endon("death");
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat(var0, var1, var2);
}

function gesture_follow_lookat_natural(var0, var1, var2, var3) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_natural(var0, var1, var2, var3);
}

function gesture_follow_eyes(var0, var1, var2) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_eyes_lookat(var0, var1, var2);
}

function gesture_follow_torso(var0, var1) {
  thread scripts\asm\gesture\script_funcs::ai_gesture_lookat_torso(var0, var1);
}

function gesture_follow_lookat_update(var0, var1) {
  scripts\asm\gesture\script_funcs::ai_gesture_update_lookat(var0, var1);
}

function gesture_follow_eye_update(var0, var1) {
  scripts\asm\gesture\script_funcs::ai_gesture_update_eyes_lookat(var0, var1);
}

function gesture_point(var0) {
  scripts\asm\gesture\script_funcs::ai_gesture_point(var0);
}

function gesture_simple(var0) {
  scripts\asm\gesture\script_funcs::ai_gesture_simple(var0);
}

function gesture_directional_custom(var0, var1, var2) {
  scripts\asm\gesture\script_funcs::ai_gesture_directional_custom(var0, var1, var2);
}

function gesture_custom(var0, var1) {
  scripts\asm\gesture\script_funcs::ai_custom_gesture(var0, var1);
}

function gesture_eye_dart_loop(var0, var1) {
  self endon("death");
  self endon("stop_lookat");
  self endon("eye_gesture_stop");

  if(!isDefined(self.is_eye_tracking)) {
    thread gesture_follow_eyes(var0, 4, 0.1);
  }

  if(isDefined(var1) && var1) {
    thread gesture_follow_lookat(var0, 0.15, 0.7);
  }

  wait 0.7;

  for(;;) {
    thread gesture_follow_eye_update(var0, 2);
    wait randomfloatrange(3, 5);
    var2 = var0 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
    thread gesture_follow_eye_update(var2, 2);
    wait randomfloatrange(0.25, 0.5);

    if(scripts\engine\utility::cointoss()) {
      var2 = var0 getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
      thread gesture_follow_eye_update(var2, 2);
      wait randomfloatrange(0.25, 0.5);
    }
  }
}

function gesture_simple_when_close(var0, var1, var2, var3) {
  self endon("death");
  self endon("gesture_stop");
  var4 = squared(var1);
  scripts\sp\interaction_manager::add_actor_to_manager();
  var5 = distance2dsquared(self.origin, var2.origin);

  for(;;) {
    if(var5 < var4 && scripts\sp\interaction_manager::can_play_nearby_gesture(var1 * 3)) {
      break;
    }

    var5 = distance2dsquared(self.origin, var2.origin);
    waitframe();
  }

  self.playing_gesture = 1;

  if(isDefined(var3)) {
    thread gesture_simple(var0);
    self[[var3]]();
  } else {
    gesture_simple(var0);
  }

  wait 2;
  scripts\sp\interaction_manager::remove_actor_from_manager();
  self.playing_gesture = 0;
}

function get_direction_value(var0, var1, var2) {
  var3 = vectortoangles(var2 - var1);
  var4 = var0[1] - var3[1];
  var4 += 360;
  var4 = int(var4) % 360;

  if(var4 > 350 || var4 < 10) {
    var5 = "8";
  } else if(var5 < 60) {
    var5 = "9";
  } else if(var5 < 120) {
    var5 = "6";
  } else if(var5 < 150) {
    var5 = "3";
  } else if(var5 < 210) {
    var5 = "2";
  } else if(var5 < 240) {
    var5 = "1";
  } else if(var5 < 300) {
    var5 = "4";
  } else {
    var5 = "7";
  }

  return var5;
}

function give_melee_weapon(var0) {
  take_melee_weapon();
  self giveweapon(var0);
  self assignweaponmeleeslot(var0);
}

function take_melee_weapon() {
  var0 = self.meleeweapons;

  foreach(var2 in var0) {
    self takeweapon(var2);
  }
}

function offhandprecache(var0) {
  scripts\sp\equipment\offhands::init();
  var1 = scripts\sp\equipment\offhands::offhandprecachefuncs();

  foreach(var3 in var0) {
    if(scripts\sp\equipment\offhands::offhandisprecached(var3)) {
      continue;
    }

    precacheitem(var3);

    if(scripts\engine\utility::array_contains_key(var1, var3)) {
      [[var1[var3]]](var3);
    }

    level.offhands.precached = scripts\engine\utility::array_add(level.offhands.precached, var3);
  }
}

function give_offhand(var0, var1) {
  if(isPlayer(self)) {
    scripts\sp\player::offhandswap(var0, var1);
    return;
  }
}

function take_offhand(var0) {
  if(isPlayer(self)) {
    scripts\sp\player::offhandremove(var0);
    return;
  }
}

function get_melee_weapon() {
  var0 = self.meleeweapons;

  foreach(var2 in var0) {
    if(!nullweapon(var2)) {
      return var2;
    }
  }

  return undefined;
}

function give_action_slot_weapon(var0) {
  self.actionslotweapon = var0;
  self giveweapon(var0);

  if(is_action_slot_weapon_allowed()) {
    self setactionslot(1, "weapon", var0);
    return;
  }
}

function take_action_slot_weapon() {
  self setactionslot(1, "");
  self takeweapon(self.actionslotweapon);
  self.actionslotweapon = undefined;
}

function get_action_slot_weapon() {
  if(isDefined(self.actionslotweapon)) {
    return self.actionslotweapon;
  }

  return "";
}

function allow_action_slot_weapon(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("actionSlotWeapons", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
      if(isDefined(self.actionslotweapon)) {
        self setactionslot(1, "weapon", self.actionslotweapon);
        return;
      }

      return;
    }

    self setactionslot(1, "");
    return;
  }
}

function is_action_slot_weapon_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("actionSlotWeapons");
}

function get_weapons_list_primaries(var0, var1) {
  var2 = level.player.primaryweapons;

  if(isDefined(var0) && var0 == 1) {
    var2 = scripts\engine\utility::array_combine(var2, level.player.alternateweapons);
  }

  var3 = [];
  var4 = get_melee_weapon(level.player);

  if(isDefined(var4) && (!isDefined(var1) || var1 == 0)) {
    foreach(var6 in var2) {
      if(var6 != var4) {
        var3 = var6;
      }
    }
  } else {
    var3 = var2;
  }

  return var3;
}

function is_primary_equipment_button_down() {
  return scripts\engine\utility::flag("primary_equipment_input_down");
}

function wait_primary_equipment_button_up() {
  scripts\engine\utility::flag_waitopen("primary_equipment_input_down");
}

function wait_primary_equipment_button_down() {
  scripts\engine\utility::flag_wait("primary_equipment_input_down");
}

function wait_primary_equipment_button_pressed() {
  self waittill("primary_equipment_pressed");
  scripts\engine\utility::flag_wait("primary_equipment_input_down");
}

function is_primary_equipment_in_use() {
  return scripts\engine\utility::flag("primary_equipment_in_use");
}

function is_secondary_equipment_button_down() {
  return scripts\engine\utility::flag("secondary_equipment_input_down");
}

function wait_secondary_equipment_button_up() {
  scripts\engine\utility::flag_waitopen("secondary_equipment_input_down");
}

function wait_secondary_equipment_button_down() {
  scripts\engine\utility::flag_wait("secondary_equipment_input_down");
}

function wait_secondary_equipment_button_pressed() {
  self waittill("secondary_equipment_pressed");
  scripts\engine\utility::flag_wait("secondary_equipment_input_down");
}

function is_secondary_equipment_in_use() {
  return scripts\engine\utility::flag("secondary_equipment_in_use");
}

function get_primary_equipment() {
  return undefined;
}

function get_primary_equipment_ammo() {
  return false;
}

function get_secondary_equipment() {
  return undefined;
}

function get_secondary_equipment_ammo() {
  return false;
}

function get_stored_primary_equipment() {
  return undefined;
}

function get_stored_primary_equipment_ammo() {
  return true;
}

function get_stored_secondary_equipment() {
  return undefined;
}

function get_stored_secondary_equipment_ammo() {
  return true;
}

function get_equipment_ammo(var0) {
  var1 = [ &get_primary_equipment, &get_stored_primary_equipment, &get_secondary_equipment, &get_stored_secondary_equipment];
  var2 = [ &get_primary_equipment_ammo, &get_stored_primary_equipment_ammo, &get_secondary_equipment_ammo, &get_stored_secondary_equipment_ammo];

  for(var3 = 0; var3 < var1.size; var3++) {
    var4 = [[var1[var3]]]();
    var5 = [[var2[var3]]]();

    if(isDefined(var4) && var4 == var0) {
      return var5;
    }
  }
}

function get_corpse_origin() {
  if(getdvarint("MQSNSOSMPN")) {
    return self getcorpsephysicsorigin();
  }

  return self.origin;
}

function hudoutline_add_channel(var0, var1, var2) {
  scripts\sp\outline::hudoutline_add_channel_internal(var0, var1, var2);
}

function hudoutline_add_child_channel(var0, var1, var2) {
  scripts\sp\outline::hudoutline_add_child_channel_internal(var0, var1, var2);
}

function hudoutline_force_channel(var0, var1) {
  scripts\sp\outline::hudoutline_force_channel_internal(var0, var1);
}

function hudoutline_enable_new(var0, var1) {
  scripts\sp\outline::hudoutline_enable_internal(var1, var0);
}

function hudoutline_enable(var0, var1, var2, var3) {
  scripts\sp\outline::hudoutline_enable_internal(var3, "outline_depth_red");
}

function hudoutline_disable(var0) {
  scripts\sp\outline::hudoutline_disable_internal(var0);
}

function hudoutline_channel_animation(var0, var1) {
  scripts\sp\outline::play_animation_on_channel(var0, var1);
  level notify("hudoutline_anim_complete");
  level notify("hudoutline_anim_complete" + var0);
}

function hudoutline_channel_animation_loop(var0, var1) {
  thread scripts\sp\outline::play_animation_on_channel_loop(var0, var1);
}

function hudoutline_vis_enemy_settings(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  setsaveddvar("NMROQRRONQ", 1);
  var1 = "0.5 0.5 0.5";
  var2 = "1 1 1";

  if(var0) {
    var1 = "0.5 0.5 0.5 1";
    var2 = "0.5 0.5 0.5 0.2";
    var3 = "0.5 0.5 0.5 1";
    var4 = "0.7 0.7 0.7 1";
    var5 = "0.5 0.5 0.5 1";
  } else {
    var4 = "0.5 0.5 0.5 0";
    var5 = "0.5 0.5 0.5 0";
    var3 = "0.5 0.5 0.5 1";
    var4 = "0.5 0.5 0.5 0.5";
    var5 = "0.5 0.5 0.5 0.5";
  }

  setsaveddvar("LRMPROLMKN", var4);
  setsaveddvar("NTOSKSTKQQ", var5);
  setsaveddvar("NSNOLMTLLL", var3);
  setsaveddvar("LSRTPRNOLS", var4);
  setsaveddvar("LNNOSQKRTP", var5);
  setsaveddvar("RKSQOKQNK", 1);
}

function hudoutline_vis_enemy(var0, var1) {
  GscBinSkip1(0x45, "allies", "friendly");
}

function hud_bink(var0) {
  setomnvar("ui_show_bink", 1);
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame(var0);

  while(!iscinematicplaying()) {
    waitframe();
  }

  while(iscinematicplaying()) {
    waitframe();
  }

  stopcinematicingame();
  setomnvar("ui_show_bink", 0);
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
}

function hud_fluff_text_message(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "fluff_messages_default";
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  setomnvar("ui_sp_fluff_messaging", var0);
  setomnvar("ui_sp_fluff_messaging_context", var1);
}

function _intel_waypoint_button_listener() {
  level notify("stopstop_intel_waypoint_int");
  level endon("stop_intel_waypoint");
  self.intel_waypoint_request = undefined;
  self notifyonplayercommand("set_waypoint", "+weapnext");
  self waittill("set_waypoint");
  self.intel_waypoint_request = 1;
}

function _intel_dismiss_button_listener() {
  self endon("dismiss_skipped");
  self notifyonplayercommand("intel_dismiss", "+gostand");
  self notifyonplayercommand("intel_dismiss", "+activate");
  self notifyonplayercommand("intel_dismiss", "+usereload");
  self waittill("intel_dismiss");
  self.intel_dismiss_request = 1;
}

function init_manipulate_ent() {
  var0 = getEntArray("manipulate_ent", "script_noteworthy");
  scripts\engine\utility::array_thread(var0, &manipulate_ent_setup);
}

function manipulate_ent_setup() {
  if(isDefined(self.script_flag_wait)) {
    scripts\engine\utility::flag_init(self.script_flag_wait);
  }

  if(isDefined(self.script_deathflag)) {
    scripts\engine\utility::flag_init(self.script_deathflag);
  }

  if(isDefined(self.script_rotation_speed)) {
    self.start_angles = self.angles;

    if(!isDefined(self.script_rotation_max)) {
      self.script_rotation_max = (0, 0, 0);
    }

    self.rotation_spring_index = [];

    for(var0 = 0; var0 < 3; var0++) {
      if(self.script_rotation_max[var0] != 0) {
        if(self.script_rotation_speed[var0] > 0) {
          self.rotation_spring_index[var0] = scripts\engine\math::spring_make_under_damped(self.script_rotation_speed[var0] * 10, 0, self.start_angles[var0] + self.script_rotation_max[var0], 0);
        }
      }
    }

    thread rotate_ent_think();
  }

  if(isDefined(self.script_translate_speed)) {
    self.start_origin = self.origin;

    if(!isDefined(self.script_translate_max)) {
      self.script_translate_max = (0, 0, 0);
    }

    self.translate_spring_index = [];

    for(var0 = 0; var0 < 3; var0++) {
      if(self.script_translate_max[var0] != 0) {
        if(self.script_translate_speed[var0] > 0) {
          self.translate_spring_index[var0] = scripts\engine\math::spring_make_under_damped(self.script_translate_speed[var0] * 10, 0, self.start_origin[var0] + self.script_translate_max[var0], 0);
        }
      }
    }

    thread translate_ent_think();
  }

  thread manipulate_ent_death_think();
  thread manipulate_ent_cleanup();
}

function translate_ent_think() {
  self endon("death");
  self endon("stop_manipulate_ent");
  jumpiffalse(isDefined(self.script_flag_wait)) LOC_00000023;
  scripts\engine\utility::flag_wait(self.script_flag_wait);

  for(;;) {
    var0 = [];

    for(var1 = 0; var1 < 3; var1++) {
      if(self.script_translate_speed[var1] == 0) {
        var0 = self.start_origin[var1];
        continue;
      }

      if(self.script_translate_speed[var1] != 0 && self.script_translate_max[var1] == 0) {
        var0 = self.origin[var1] + self.script_translate_speed[var1] / 20;
        continue;
      }

      if(self.script_translate_speed[var1] > 0 && self.script_translate_max[var1] != 0) {
        var0 = scripts\engine\math::spring_update(self.translate_spring_index[var1], self.start_origin[var1]);
      }
    }

    self.origin = (var0[0], var0[1], var0[2]);
    waitframe();
  }
}

function rotate_ent_think() {
  self endon("death");
  self endon("stop_manipulate_ent");
  jumpiffalse(isDefined(self.script_flag_wait)) LOC_00000023;
  scripts\engine\utility::flag_wait(self.script_flag_wait);

  for(;;) {
    var0 = [];

    for(var1 = 0; var1 < 3; var1++) {
      if(self.script_rotation_speed[var1] == 0) {
        var0 = self.start_angles[var1];
        continue;
      }

      if(self.script_rotation_speed[var1] != 0 && self.script_rotation_max[var1] == 0) {
        var0 = self.angles[var1] + self.script_rotation_speed[var1] / 20;
        continue;
      }

      if(self.script_rotation_speed[var1] > 0 && self.script_rotation_max[var1] != 0) {
        var0 = scripts\engine\math::spring_update(self.rotation_spring_index[var1], self.start_angles[var1]);
      }
    }

    var0 = (angleclamp(var0[0]), angleclamp(var0[1]), angleclamp(var0[2]));
    self.angles = var0;
    waitframe();
  }
}

function manipulate_ent_death_think() {
  self endon("death");

  if(isDefined(self.script_deathflag)) {
    scripts\engine\utility::flag_wait(self.script_deathflag);

    if(isDefined(self.script_delete) && self.script_delete) {
      self delete();
      return;
    }

    self notify("stop_manipulate_ent");
    return;
  }
}

function manipulate_ent_cleanup() {
  scripts\engine\utility::waittill_either("death", "stop_manipulate_ent");

  if(isDefined(self.rotation_spring_index)) {
    foreach(var1 in self.rotation_spring_index) {
      scripts\engine\math::spring_delete(var1);
    }
  }

  if(isDefined(self.translate_spring_index)) {
    foreach(var1 in self.translate_spring_index) {
      scripts\engine\math::spring_delete(var1);
    }

    return;
  }
}

function strip_suffix(var0, var1) {
  if(var0.size <= var1.size) {
    return var0;
  }

  if(getsubstr(var0, var0.size - var1.size, var0.size) == var1) {
    return getsubstr(var0, 0, var0.size - var1.size);
  }

  return var0;
}

function set_exception(var0, var1) {
  self.exception[var0] = var1;
}

function set_all_exceptions(var0) {
  var1 = getarraykeys(self.exception);

  for(var2 = 0; var2 < var1.size; var2++) {
    self.exception[var1[var2]] = var0;
  }
}

function waittill_multiple_ents(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("death");
  var8 = spawnStruct();
  var8.threads = 0;

  if(isDefined(var0)) {
    var0 childthread scripts\engine\utility::waittill_string(var1, var8);
    var8.threads++;
  }

  if(isDefined(var2)) {
    var2 childthread scripts\engine\utility::waittill_string(var3, var8);
    var8.threads++;
  }

  if(isDefined(var4)) {
    var4 childthread scripts\engine\utility::waittill_string(var5, var8);
    var8.threads++;
  }

  if(isDefined(var6)) {
    var6 childthread scripts\engine\utility::waittill_string(var7, var8);
    var8.threads++;
  }

  while(var8.threads) {
    var8 waittill("returned");
    var8.threads--;
  }

  var8 notify("die");
}

function get_linked_scriptables() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_links();

    foreach(var3 in var1) {
      var4 = getscriptablearray(var3, "script_linkname");

      if(var4.size > 0) {
        var0 = scripts\engine\utility::array_combine(var0, var4);
      }
    }
  }

  if(!var0.size && gettime() <= 300) {}

  return var0;
}

function get_linked_vehicles() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_links();

    foreach(var3 in var1) {
      var4 = vehicle_getarray();
      var5 = [];

      foreach(var7 in var4) {
        if(scripts\engine\utility::is_equal(var7.script_linkname, var3)) {
          var5 = scripts\engine\utility::array_add(var5, var7);
        }
      }

      if(var5.size > 0) {
        var0 = scripts\engine\utility::array_combine(var0, var5);
      }
    }
  }

  return var0;
}

function get_linked_vehicle_spawners() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_links();

    foreach(var3 in var1) {
      var4 = scripts\common\utility::getvehiclespawnerarray(var3, "script_linkname");

      if(var4.size > 0) {
        var0 = scripts\engine\utility::array_combine(var0, var4);
      }
    }
  }

  return var0;
}

function get_linked_spawners() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_links();

    foreach(var3 in var1) {
      var4 = getspawnerarray();
      var5 = [];

      foreach(var7 in var4) {
        if(scripts\engine\utility::is_equal(var7.script_linkname, var3)) {
          var5 = scripts\engine\utility::array_add(var5, var7);
        }
      }

      if(var5.size > 0) {
        var0 = scripts\engine\utility::array_combine(var0, var5);
      }
    }
  }

  return var0;
}

function get_linked_vehicle_nodes() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_links();

    foreach(var3 in var1) {
      var4 = getvehiclenodearray(var3, "script_linkname");

      if(var4.size > 0) {
        var0 = scripts\engine\utility::array_combine(var0, var4);
      }
    }
  }

  return var0;
}

function run_thread_on_targetname(var0, var1, var2, var3, var4) {
  var5 = getEntArray(var0, "targetname");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);

  if(isDefined(level.getspawnerarrayfunction)) {
    var6 = builtin[[level.getspawnerarrayfunction]](var0);

    foreach(var8 in var6) {
      if(isnonentspawner(var8)) {
        scripts\engine\utility::array_thread([var8], var1, var2, var3, var4);
      }
    }
  }

  var5 = scripts\engine\utility::getStructArray(var0, "targetname");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);
  var5 = builtin[[level.getnodearrayfunction]](var0, "targetname");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);
  var5 = getvehiclenodearray(var0, "targetname");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);
}

function run_thread_on_noteworthy(var0, var1, var2, var3, var4) {
  var5 = getEntArray(var0, "script_noteworthy");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);

  if(isDefined(level.getspawnerarrayfunction)) {
    var6 = builtin[[level.getspawnerarrayfunction]]();

    foreach(var8 in var6) {
      if(isDefined(var8.script_noteworthy) && var8.script_noteworthy == var0 && isnonentspawner(var8)) {
        scripts\engine\utility::array_thread([var8], var1, var2, var3, var4);
      }
    }
  }

  var5 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);
  var5 = builtin[[level.getnodearrayfunction]](var0, "script_noteworthy");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);
  var5 = getvehiclenodearray(var0, "script_noteworthy");
  scripts\engine\utility::array_thread(var5, var1, var2, var3, var4);
}

function get_noteworthy_ent(var0) {
  var1 = getEnt(var0, "script_noteworthy");

  if(isDefined(var1)) {
    return var1;
  }

  if(scripts\common\utility::issp()) {
    var1 = builtin[[level.getnodefunction]](var0, "script_noteworthy");

    if(isDefined(var1)) {
      return var1;
    }
  }

  var1 = scripts\engine\utility::getStruct(var0, "script_noteworthy");

  if(isDefined(var1)) {
    return var1;
  }

  var1 = getvehiclenode(var0, "script_noteworthy");

  if(isDefined(var1)) {
    return var1;
  }
}

function is_locked(var0) {
  var1 = level.lock[var0];
  return var1.count > var1.max_count;
}

function getfarthest(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 500000;
  }

  var3 = 0;
  var4 = undefined;

  foreach(var6 in var1) {
    var7 = distance(var6.origin, var0);

    if(var7 <= var3 || var7 >= var2) {
      continue;
    }

    var3 = var7;
    var4 = var6;
  }

  return var4;
}

function array_sort_by_handler(var0, var1) {
  for(var2 = 0; var2 < var0.size - 1; var2++) {
    for(var3 = var2 + 1; var3 < var0.size; var3++) {
      if(var0[var3][[var1]]() < var0[var2][[var1]]()) {
        var4 = var0[var3];
        var0 = var0[var2];
        var0 = var4;
      }
    }
  }

  return var0;
}

function monitor_interact_delay(var0, var1) {
  var0 waittill("trigger", var2);
  level.player enableslowaim(0.1, 0.1);
  level.player scripts\common\utility::allow_ads(0);

  while(!level.player isonground()) {
    wait 0.05;
  }

  var3 = level.player getstance();

  if(var3 != var1) {
    level.player setstance(var1);

    if(var3 == "prone") {
      wait 0.2;
    }
  }

  level.player disableslowaim();
  level.player scripts\common\utility::allow_ads(1);
  return var2;
}

function ai_weapon_override(var0, var1, var2, var3, var4) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var3) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait 0.05;
    }
  }

  var5 = undefined;

  if(isDefined(var0)) {
    if(issameweapon(var0)) {
      var5 = var0;
    } else {
      var5 = asmdevgetallstates(var0);
    }
  }

  var6 = undefined;

  if(isDefined(var1)) {
    if(issameweapon(var1)) {
      var6 = var1;
    } else {
      var6 = asmdevgetallstates(var1);
    }
  }

  self.forcedweaponoriginal = self.weapon;

  if(isDefined(var4)) {
    var7 = undefined;

    if(issameweapon(var4)) {
      var7 = var4;
    } else {
      var7 = asmdevgetallstates(var4);
    }

    if(self.weapon != var7) {
      ai_create_weapon_stow(self.weapon);
    }

    self.forcedweapon = self.overrideweapon;
    scripts\anim\shared::forceuseweapon(var7, "primary");
    self.weaponoverride = 1;
    return;
  }

  scripts\anim\shared::forceuseweapon(var7, "primary");
  ai_create_weapon_stow(var6);
  self.forcedweaponclose = var6;
  self.forcedweaponfar = var7;
  self.closeweaponmaxdist = var3;
  self.forcedweapon = self.forcedweaponfar;
}

function clear_ai_weapon_override(var0, var1, var2) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if(!var1) {
    while(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
      wait 0.05;
    }
  }

  if(isDefined(var2)) {
    var3 = undefined;

    if(issameweapon(var2)) {
      var3 = var2;
    } else {
      var3 = asmdevgetallstates(var2);
    }

    if(isDefined(self.weapon_stow) && self.weapon_stow.model == getweaponmodel(var3)) {
      self.weapon_stow delete();
    }

    place_weapon_on(var3, "right");
  } else {
    place_weapon_on(self.forcedweaponoriginal, "right");
  }

  if(isDefined(self.weapon_stow) && var0) {
    self.weapon_stow delete();
  }

  self.forcedweapon = undefined;
  self.weaponoverride = 0;
}

function ai_create_weapon_stow(var0) {
  self.weapon_stow = spawn("script_model", self gettagorigin("tag_stowed_back"));
  self.weapon_stow setModel(getweaponmodel(var0));
  self.weapon_stow notsolid();
  self.weapon_stow.angles = self gettagangles("tag_stowed_back");
  self.weapon_stow linkTo(self, "tag_stowed_back");
}

function countdown_start(var0, var1) {
  level notify("countdown_start");
  level endon("countdown_start");
  level endon("countdown_end");
  setomnvar("ui_countdown_mission_text", var1);
  setomnvar("ui_countdown_timer", gettime() + var0 * 1000);
  wait var0;
  level notify(var1);
  wait 5;
  setomnvar("ui_countdown_timer", 0);
}

function countdown_end() {
  level notify("countdown_end");
  setomnvar("ui_countdown_timer", 0);
}

function setfirstsavetime(var0) {
  var0 = max(var0, 2);
  level.beginningoflevelsavedelay = var0;
}

function dof_enable_autofocus(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(self) && self != level) {
    dyndof(var0, var1, var2, var3, var4, var5, var6);
    return;
  }

  dyndof(var0, var1, var2, var3, var4, var5, var6);
}

function dof_disable_autofocus() {
  dyndof_disable();
}

function dof_enable(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1) && isstruct(self) && self == level) {} else if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 2;
  }

  level notify("stop_dyndof");
  level notify("stop_dyndof_debug");
  setsaveddvar("MRSTKSMMP", 1);
  level.player enablephysicaldepthoffieldscripting();

  if(self != level) {
    if(isDefined(var5)) {
      var4 = self gettagorigin(var5);

      if(getdvarint("debug_dof_functions", 0)) {}
    } else {
      var4 = self.origin;

      if(getdvarint("debug_dof_functions", 0)) {}
    }
  }

  if(isDefined(var4)) {
    level.player setphysicaldepthoffield(var0, var1, var2, var3, var4);
    return;
  }

  if(isDefined(var3)) {
    level.player setphysicaldepthoffield(var0, var1, var2, var3);
    return;
  }

  if(isDefined(var2)) {
    level.player setphysicaldepthoffield(var0, var1, var2);
    return;
  }

  level.player setphysicaldepthoffield(var0, var1);
}

function dof_disable() {
  level notify("stop_dyndof");
  level notify("stop_dyndof_debug");
  level.player disablephysicaldepthoffieldscripting();
}

function motion_blur_disable(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  thread lerp_saveddvar("NMORQOTSK", 0, var0);
  thread lerp_saveddvar("RMLOTKMMM", 0, var0);
}

function motion_blur_enable(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = scripts\engine\utility::ter_op(isDefined(level.motionblur), level.motionblur["velocityScaleDefault"], getdvarfloat("NMORQOTSK"));
  }

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::ter_op(isDefined(level.motionblur), level.motionblur["velocityScaleViewModelDefault"], getdvarfloat("RMLOTKMMM"));
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  thread lerp_saveddvar("NMORQOTSK", var0, var2);
  thread lerp_saveddvar("RMLOTKMMM", var1, var2);
}

function create_motion_blur_defaults(var0, var1) {
  if(!isDefined(var0)) {
    var0 = getdvarfloat("NMORQOTSK");
  }

  if(!isDefined(var1)) {
    var1 = getdvarfloat("RMLOTKMMM");
  }

  level.motionblur = [];
  level.motionblur["velocityScaleDefault"] = var0;
  level.motionblur["velocityScaleViewModelDefault"] = var1;
}

function dyndof(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 2;
  }

  level notify("stop_dyndof");
  setsaveddvar("MRSTKSMMP", 1);
  level.player enablephysicaldepthoffieldscripting();

  if(isDefined(level.dyndof)) {
    level.dyndof = undefined;
  }

  level.dyndof = scripts\engine\sp\utility_code::create_dyndof();
  level.dyndof.fstop = var0;
  level.dyndof.focusspeed = var1;
  level.dyndof.aperturespeed = var2;
  level.dyndof.desiredbone = var4;
  level.dyndof.ignorecollision = var6;

  if(isDefined(var5)) {
    level.dyndof.ignorelist = var5;
  } else {
    level.dyndof.ignorelist = [level.player];
  }

  if(isDefined(var3)) {
    level.dyndof.traceangle = var3;
  }

  if(isDefined(self)) {
    thread scripts\engine\sp\utility_code::dyndof_thread();
    return;
  }

  level thread scripts\engine\sp\utility_code::dyndof_thread();
}

function dyndof_disable() {
  level notify("stop_dyndof");
  level notify("stop_dyndof_debug");
  level.player disablephysicaldepthoffieldscripting();
  scripts\engine\sp\utility_code::destroy_dyndof();
}

function actionslotoverride(var0, var1, var2, var3, var4) {
  self setweaponhudiconoverride("actionslot" + var0, var1);

  if(isDefined(var2)) {
    setactionslotoverrideammo(var0, var2);
  }

  if(isDefined(var3)) {
    thread actionslotoverridecallback(var0, var3, var4);
    return;
  }
}

function actionslotoverridecallback(var0, var1, var2) {
  self endon("death");
  self endon("removeActionslot" + var0);
  self notifyonplayercommand("actionslot" + var0, "+actionslot " + var0);

  for(;;) {
    self waittill("actionslot" + var0);

    if(!isDefined(var2) || !var2 || var2 && level.player usinggamepad()) {
      self thread[[var1]]();
    }
  }
}

function actionslotoverrideremove(var0) {
  self notify("removeActionslot" + var0);
  self setweaponhudiconoverrideammo("actionslot" + var0, -1);
  self setweaponhudiconoverride("actionslot" + var0, "none");
}

function setactionslotoverrideammo(var0, var1) {
  self setweaponhudiconoverrideammo("actionslot" + var0, var1);
}

function takeallweaponsexcludemelee() {
  var0 = self.meleeweapons;
  self takeallweapons();

  foreach(var2 in var0) {
    give_melee_weapon(var2);
  }
}

function giveweaponmaxammo(var0) {
  self givemaxammo(var0);
}

function can_trace_to_player(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = [];
  }

  if(!isarray(var1)) {
    var1 = [var1];
  }

  var1 = level.player;

  if(isent(self) || isai(self)) {
    var1 = self;
  }

  if(scripts\engine\trace::ray_trace_passed(var0, level.player.origin, var1, var2)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var0, level.player.origin + (0, 0, 30), var1, var2)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var0, level.player getEye(), var1, var2)) {
    return true;
  }

  return false;
}

function play_footstep_sound(var0, var1) {
  if(scripts\engine\utility::is_dead_sentient() || !soundexists(var0)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = "dirt";
  }

  var2 = spawn("script_origin", self.origin);
  var2 endon("death");
  var3 = var0 + "_ceiling";

  if(soundexists(var3)) {
    var2 playsurfacesound(var0, var1);
    var2 scripts\engine\utility::waittill_notify_or_timeout("death", 0.05);
    var2.origin -= (0, 0, 12);
    var4 = getdvarfloat("OLPQMMPMMM", 150);
    var5 = getdvarfloat("LQSRRTOKNN", 360);
    var6 = (0, 0, -1);
    var7 = (1, 0, 0);
    var8 = atan(var4 / var5);

    if(isalive(self) && scripts\engine\math::pointvscone(level.player.origin, var2.origin, var6, var7, var5, 0, var8)) {
      var2 playsurfacesound(var3, var1, "sounddone");
      wait_for_sounddone_or_death(var2);
    }
  } else {
    var2 playsurfacesound(var0, var1, "sounddone");
    wait_for_sounddone_or_death(var2);
  }

  var2 delete();
}

function wait_for_sounddone_or_death(var0, var1) {
  if(isDefined(var1)) {
    var1 endon("death");
  }

  self endon("death");
  var0 waittill("sounddone");
  return true;
}

function delete_on_death_wait_sound(var0, var1) {
  var0 endon("death");
  self waittill("death");

  if(isDefined(var0)) {
    if(var0 iswaitingonsound()) {
      var0 waittill(var1);
    }

    var0 delete();
    return;
  }
}

function is_touching_any(var0) {
  foreach(var2 in var0) {
    if(self istouching(var2)) {
      return true;
    }
  }

  return false;
}

function scripter_note(var0) {
  thread scripts\engine\sp\utility_code::scripter_note_proc(var0);
}

function play_sound_on_tag(var0, var1, var2, var3, var4) {
  if(scripts\engine\utility::is_dead_sentient()) {
    return;
  }

  var5 = spawn("script_origin", self.origin);
  var5 endon("death");
  thread delete_on_death_wait_sound(var5, "sounddone");

  if(isDefined(var1)) {
    var5 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  } else {
    var5.origin = self.origin;
    var5.angles = self.angles;
    var5 linkTo(self);
  }

  var5 playSound(var0, "sounddone");

  if(isDefined(var2)) {
    if(!isDefined(wait_for_sounddone_or_death(var5))) {
      var5 stopsounds();
    }

    wait 0.05;
  } else {
    var5 waittill("sounddone");
  }

  if(isDefined(var3)) {
    self notify(var3);
  }

  var5 delete();
}

function setupglobalcallbackfunctions_sp() {
  if(!scripts\engine\utility::add_init_script("globalCallbacks_SP", &setupglobalcallbackfunctions_sp)) {
    return;
  }

  level.fnplaysoundonentity = &play_sound_on_entity;
  level.fnplaysoundontag = &play_sound_on_tag;
}

function get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw)) {
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  }

  return undefined;
}
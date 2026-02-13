/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_gauntlet.gsc
****************************************************************/

init() {
  register_gauntlet("damage_during_movement", ::gauntlet_damage_during_movement_on_begin, ::gauntlet_damage_during_movement_on_end);
  register_gauntlet("kill_enemies_for_health", ::gauntlet_kill_for_health_on_begin, ::gauntlet_kill_for_health_on_end);
  register_gauntlet("disable_health_regen", ::gauntlet_disable_health_regen_on_begin, ::gauntlet_disable_health_regen_on_end);
  register_gauntlet("enemies_do_double_damage", ::gauntlet_take_double_damage_on_begin, ::gauntlet_take_double_damage_on_end);
  register_gauntlet("only_regen_when_prone", ::gauntlet_regen_when_prone_on_begin, ::gauntlet_regen_when_prone_on_end);
  register_gauntlet("take_no_damage", ::gauntlet_take_no_damage_on_begin, ::gauntlet_take_no_damage_on_end);
  register_gauntlet("headshot_only", ::gauntlet_headshot_on_begin, ::gauntlet_headshot_on_end);
  register_gauntlet("use_given_pistol_only", ::gauntlet_use_given_pistol_only_on_begin, ::gauntlet_use_given_pistol_only_on_end);
  level.trial_gauntlet_fail_hint = int(_func_0222("cp/cp_hints.csv", 1, "gauntlet_failed", 0));
}

register_gauntlet(var_0, var_1, var_2) {
  if(!isDefined(level.a_gauntlets)) {
    level.a_gauntlets = [];
  }

  if(!_func_03AC(var_1) || !_func_03AC(var_2) || !_func_0121(var_0)) {
    return;
  }
  level.a_gauntlets[var_0] = spawnStruct();
  level.a_gauntlets[var_0].on_begin = var_1;
  level.a_gauntlets[var_0].on_end = var_2;
}

begin_gauntlet(var_0, var_1, var_2) {
  if(!isDefined(level.a_gauntlets) || !isDefined(level.a_gauntlets[var_1]) || !_func_03AC(level.a_gauntlets[var_1].on_begin)) {
    return 0;
  }

  if(!isDefined(var_0) || !_func_0107(var_0)) {
    return 0;
  }

  foreach(var_4 in var_0) {
    if(isDefined(var_4.activate_gauntlet)) {
      return 0;
    }
  }

  if(scripts\engine\utility::is_equal(var_1, "take_no_damage")) {
    level thread clear_certain_type_zombies(["actor_enemy_zombie_juggernaut_cp", "actor_enemy_zombie_screamer_cp"]);
  }

  foreach(var_4 in var_0) {
    if(!isDefined(var_4) || !isPlayer(var_4)) {
      continue;
    }
    level thread[[level.a_gauntlets[var_1].on_begin]](var_4, var_2);
    var_4 thread player_killed_in_gauntlet_monitor();
    var_4 playLoopSound("zmb_trial_gauntlet_lp");
  }

  level thread end_gauntlet_when_exfil_starts_monitor();
  return 1;
}

clear_certain_type_zombies(var_0) {
  level endon("game_ended");
  var_1 = _id_06FE::_id_6322();
  var_2 = [];

  if(!isDefined(var_0) || !_func_0107(var_0)) {
    return;
  }
  foreach(var_4 in var_1) {
    if(scripts\engine\utility::array_contains(var_0, var_4._id_1210) && !istrue(var_4.b_is_hvt)) {
      var_4._id_5FF5 = 1;
      var_5 = scripts\engine\utility::ter_op(var_4 tagexists("j_spinelower"), "j_spinelower", "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("powerup_nuke_zombie_fire"), var_4, var_5);
      var_2[var_2.size] = var_4;
      var_4 _id_0B05::_id_D602("walk");
    }
  }

  _id_0746::_id_B8F1("zmb_trial_clear_zombies");

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    wait(randomfloatrange(0.1, 0.3));

    if(!isalive(var_2[var_7])) {
      continue;
    }
    var_2[var_7] _meth_81FA();
  }
}

player_killed_in_gauntlet_monitor() {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  self endon("death");
  self waittill("last_stand_start");
  end_gauntlet([self]);
}

end_gauntlet_when_exfil_starts_monitor() {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  level scripts\engine\utility::_id_5C24("start_rbz_exfil");
  end_gauntlet(level.players);
}

end_gauntlet(var_0) {
  if(!isDefined(level.a_gauntlets)) {
    return;
  }
  if(!isDefined(var_0) || !_func_0107(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2) || !isPlayer(var_2)) {
      continue;
    }
    if(isDefined(level.trial_gauntlet_out_of_area_hint) && var_2 _meth_876E("zm_hint_index") == level.trial_gauntlet_out_of_area_hint) {
      var_2 setclientomnvar("zm_hint_index", 0);
    }

    if(isDefined(var_2.activate_gauntlet) && isDefined(level.a_gauntlets[var_2.activate_gauntlet]) && _func_03AC(level.a_gauntlets[var_2.activate_gauntlet].on_end)) {
      level thread[[level.a_gauntlets[var_2.activate_gauntlet].on_end]](var_2);
      var_2.activate_gauntlet = undefined;
      var_2 thread clear_gauntlet_timer_and_fx();
      var_2 stoploopsound("zmb_trial_gauntlet_lp");
      scripts\cp\utility::_id_B8F4("zmb_trial_gauntlet_stop", var_2);
    }
  }

  return;
}

set_gauntlet_timer_and_fx(var_0, var_1) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  self visionsetkillstreakforplayer("zm_kortifex_vision", 0.5);
  _func_019D(scripts\engine\utility::getfx("mq_gauntlet_screen"), self, "j_head", self);
  show_gauntlet_text(var_0);
  create_timer(30, -50, var_1);
}

create_timer(var_0, var_1, var_2) {
  self._id_F245 = scripts\cp\utility::_id_4065("default", 2);
  self._id_F245 scripts\cp\utility::setpoint("LEFT", undefined, var_0, var_1);
  self._id_F245.color = (1, 1, 1);
  self._id_F245.archived = 0;
  self._id_F245._id_01D6 = 1;
  self._id_F245 _id_F487(1);
  self._id_F245 _meth_8391(var_2);
  var_3 = [0, 0, 0, 9, 15];
  thread arrange_timer_ticking_sound(var_2, var_3);
}

arrange_timer_ticking_sound(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(self._id_F245) || !is_valid_ticking_sound_intensity_sequence(var_1)) {
    return;
  }
  self._id_F245 endon("death");
  var_2 = var_1[var_1.size - 1];
  var_3 = ["zmb_ui_timer_a", "zmb_ui_timer_b", "zmb_ui_timer_c", "zmb_ui_timer_d", "zmb_ui_timer_e"];

  if(var_0 > var_2) {
    wait(var_0 - var_2);
  }

  var_4 = 0;
  var_5 = 0;

  for(var_6 = 2; var_4 < var_1.size; var_5 = var_5 + var_6) {
    while(var_4 < var_1.size && var_1[var_4] <= var_5) {
      var_4++;
    }

    if(var_4 >= var_1.size) {
      return;
    }
    scripts\cp\utility::_id_B8F4(var_3[var_4], self);
    wait(var_6);
  }
}

is_valid_ticking_sound_intensity_sequence(var_0) {
  var_1 = 5;

  if(!_func_0107(var_0) || var_0[0] < 0 || var_0.size > var_1) {
    return 0;
  }

  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_0[var_2] < 0 || var_0[var_2] > var_0[var_2 + 1]) {
      return 0;
    }
  }

  return 1;
}

clear_timer() {
  if(isDefined(self._id_F245)) {
    self._id_F245 destroy();
  }
}

_id_F487(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self._id_9C52)) {
    self.alpha = self._id_9C52;
  } else {
    self.alpha = 1;
  }
}

clear_gauntlet_timer_and_fx() {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  self visionsetkillstreakforplayer("", 0.5);
  _func_02D1(scripts\engine\utility::getfx("mq_gauntlet_screen"), self, "j_head", self);
  clear_timer();

  if(isDefined(self.gauntlet_hint)) {
    self.gauntlet_hint fadeovertime(0.15);
    self.gauntlet_hint.alpha = 0;
    self.gauntlet_hint scripts\cp\utility::destroyelem();
  }
}

show_gauntlet_text(var_0) {
  self.gauntlet_hint = scripts\cp\utility::createfontstring("default", 1);
  self.gauntlet_hint scripts\cp\utility::setpoint("LEFT", undefined, 12, -90);
  self.gauntlet_hint.color = (1, 1, 1);
  self.gauntlet_hint settext(var_0);
  self.gauntlet_hint _id_F487(1);
}

set_gauntlet_progress(var_0) {
  self.gauntlet_countdown_bar = scripts\cp\utility::_id_3F99((1, 1, 1), 100, 10);
  self.gauntlet_countdown_bar scripts\cp\utility::setpoint("LEFT", undefined, 12, -80);
  self.gauntlet_countdown_bar scripts\cp\utility::_id_FC11(var_0);
}

update_gauntlet_progress(var_0) {
  self.gauntlet_countdown_bar scripts\cp\utility::_id_FC11(var_0);
}

gauntlet_damage_during_movement_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "damage_during_movement";
  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/DAMAGE_DURING_MOVING", var_1);
  var_0 thread damage_player_while_movement(10);
}

damage_player_while_movement(var_0) {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  self endon("death");
  self endon("disconnect");

  while(scripts\engine\utility::is_equal(self.activate_gauntlet, "damage_during_movement")) {
    if(isalive(self) && !istrue(self.inlaststand)) {
      if(length(self getvelocity()) != 0) {
        self dodamage(var_0, self.origin, undefined, undefined, "MOD_SUICIDE");
        wait 1;
      }
    }

    waitframe();
  }
}

gauntlet_damage_during_movement_on_end(var_0) {}

gauntlet_kill_for_health_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "kill_enemies_for_health";
  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/KILL_ENEMIES_FOR_HEALTH", var_1);
  var_0 thread damage_player_over_time(8, 1.1, 3);
  _id_06CB::_id_AA4A(::regen_health_on_ai_killed);
}

damage_player_over_time(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  self endon("death");
  wait(var_2);

  while(scripts\engine\utility::is_equal(self.activate_gauntlet, "kill_enemies_for_health")) {
    if(self.health > 0 && !istrue(self.inlaststand)) {
      self dodamage(var_0, self.origin, undefined, undefined, "MOD_SUICIDE");
    }

    wait(var_1);
  }
}

regen_health_on_ai_killed(var_0) {
  var_1 = var_0._id_50FF;

  if(isPlayer(var_1) && scripts\engine\utility::is_equal(var_1.activate_gauntlet, "kill_enemies_for_health")) {
    var_2 = var_1.health + 25;
    var_1.health = int(clamp(var_2, 0, var_1.maxhealth));
  }
}

gauntlet_kill_for_health_on_end(var_0) {
  _id_06CB::_id_C417(::regen_health_on_ai_killed);
}

gauntlet_disable_health_regen_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "disable_health_regen";
  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/DISABLE_HEALTH_REGEN", var_1);
  var_0._id_4A07 = 1;
}

gauntlet_disable_health_regen_on_end(var_0, var_1) {
  var_0._id_4A07 = undefined;
  var_0 thread trigger_health_regen();
}

gauntlet_take_double_damage_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "enemies_do_double_damage";
  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/ENEMY_DOUBLE_DAMAGE", var_1);
  var_0 scripts\cp\utility::_id_10A2("trial_of_mindfulness_double_damage", 2, 0);
}

gauntlet_take_double_damage_on_end(var_0, var_1) {
  var_0 scripts\cp\utility::_id_C48A("trial_of_mindfulness_double_damage", 0);
}

gauntlet_regen_when_prone_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "only_regen_when_prone";
  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/REGEN_WHEN_PRONE", var_1);
  var_0 thread enable_regen_monitor();
}

enable_regen_monitor(var_0) {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  self endon("death");
  self endon("disconnect");

  while(scripts\engine\utility::is_equal(self.activate_gauntlet, "only_regen_when_prone")) {
    if(self getstance() == "prone" && istrue(self._id_4A07)) {
      self._id_4A07 = undefined;
      thread trigger_health_regen();
    } else if(self getstance() != "prone" && !istrue(self._id_4A07))
      self._id_4A07 = 1;

    waitframe();
  }
}

trigger_health_regen() {
  var_0 = _id_073B::_id_6A8F();
  var_1 = self.health / var_0;

  if(var_1 >= 1) {
    self.health = var_0;
    return;
  }

  thread scripts\cp\utility::_id_7643(gettime(), var_1);
}

gauntlet_regen_when_prone_on_end(var_0) {
  var_0._id_4A07 = undefined;
  var_0 thread trigger_health_regen();
}

gauntlet_take_no_damage_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "take_no_damage";
  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/SURVIVE_WITHOUT_TAKE_DAMAGE", var_1);
  var_0 thread take_damage_monitor();
}

take_damage_monitor() {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  self endon("death");
  self endon("disconnect");
  wait 1.5;

  while(scripts\engine\utility::is_equal(self.activate_gauntlet, "take_no_damage")) {
    self waittill("player_damaged");

    if(scripts\engine\utility::is_equal(self.activate_gauntlet, "take_no_damage")) {
      thread play_gaunt_fail_prompt(1);
      end_gauntlet([self]);
    }
  }
}

gauntlet_take_no_damage_on_end(var_0) {}

gauntlet_headshot_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "headshot_only";
  level.gauntlet_headshot_counter = 0;

  switch (level.players.size) {
    case 1:
      level.gauntlet_headshot_requirement = 5;
      break;
    case 2:
      level.gauntlet_headshot_requirement = 10;
      break;
    case 3:
      level.gauntlet_headshot_requirement = 15;
      break;
    case 4:
      level.gauntlet_headshot_requirement = 20;
      break;
    default:
      level.gauntlet_headshot_requirement = 5;
  }

  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/KILL_WITH_HEADSHOTS", var_1);
  var_0 thread set_gauntlet_progress(level.gauntlet_headshot_counter / level.gauntlet_headshot_requirement);
  _id_06CB::_id_AA4A(::on_ai_killed_gauntlet_headshot);
}

on_ai_killed_gauntlet_headshot(var_0) {
  if(isPlayer(var_0._id_50FF) && scripts\engine\utility::is_equal(var_0._id_50FF.activate_gauntlet, "headshot_only")) {
    if(isDefined(var_0._id_04F6) && isDefined(var_0._id_D9E0) && isDefined(var_0._id_DE2B) && scripts\cp\utility::_id_8891(var_0._id_04F6, var_0._id_D9E0, var_0._id_DE2B, var_0._id_50FF)) {
      level.gauntlet_headshot_counter++;

      if(isDefined(level.players)) {
        foreach(var_2 in level.players) {
          if(isPlayer(var_2) && scripts\engine\utility::is_equal(var_2.activate_gauntlet, "headshot_only")) {
            var_2 thread update_gauntlet_progress(level.gauntlet_headshot_counter / level.gauntlet_headshot_requirement);
          }
        }
      }

      if(scripts\engine\utility::is_equal(level.gauntlet_headshot_counter, level.gauntlet_headshot_requirement)) {
        gauntlet_headshot_success_sequence();
      }
    }
  }
}

gauntlet_headshot_success_sequence() {
  level notify("gauntlet_finish");
}

gauntlet_headshot_on_end(var_0) {
  if(!isDefined(level.gauntlet_headshot_counter) || !isDefined(level.gauntlet_headshot_requirement) || level.gauntlet_headshot_counter < level.gauntlet_headshot_requirement) {
    level notify("gauntlet_fail");
    var_0 thread play_gaunt_fail_prompt(1);
  }

  _id_06CB::_id_C417(::on_ai_killed_gauntlet_headshot);
  var_0 thread remove_gauntlet_progress();
}

remove_gauntlet_progress() {
  if(isDefined(self.gauntlet_countdown_bar)) {
    self.gauntlet_countdown_bar fadeovertime(0.15);
    self.gauntlet_countdown_bar.alpha = 0;
    self.gauntlet_countdown_bar scripts\cp\utility::destroyelem();
  }
}

gauntlet_use_given_pistol_only_on_begin(var_0, var_1) {
  var_0.activate_gauntlet = "use_given_pistol_only";
  var_0 thread set_gauntlet_timer_and_fx(&"CP_ZM_OASIS/USE_GIVEN_PISTOL_ONLY", var_1);
  var_2 = ["s4_pi_luniform08_mp", "s4_pi_wecho_mp", "s4_pi_ttango33_mp"];
  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 = "";

  foreach(var_5 in var_2) {
    var_3 = var_5;

    if(!var_0 has_weapon_name(var_5)) {
      break;
    }
  }

  var_7 = scripts\cp\cp_weapon::buildweapon(var_3);
  var_0 giveweapon(var_7);
  var_0.gauntlet_given_pistol = var_7;
  var_0 switchtoweaponimmediate(var_0.gauntlet_given_pistol);
  var_0 thread gauntlet_use_given_pistol_only_check_current_weapon_monitor();
  var_0 disableoffhandweapons();
  var_0 scripts\common\utility::_id_154F(0);
  var_0 scripts\common\utility::_id_1593(0);
}

has_weapon_name(var_0) {
  var_1 = 0;
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.basename, var_0)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

gauntlet_use_given_pistol_only_check_current_weapon_monitor() {
  level endon("game_ended");
  level endon("gauntlet_finish");
  level endon("gauntlet_fail");
  self endon("death");
  wait 1;

  while(scripts\engine\utility::is_equal(self.activate_gauntlet, "use_given_pistol_only")) {
    waitframe();

    if(scripts\engine\utility::is_equal(self.activate_gauntlet, "use_given_pistol_only") && !scripts\engine\utility::is_equal(self.gauntlet_given_pistol, self getcurrentweapon())) {
      thread play_gaunt_fail_prompt(1);
      end_gauntlet([self]);
    }
  }
}

gauntlet_use_given_pistol_only_on_end(var_0) {
  if(isDefined(var_0.gauntlet_given_pistol) && var_0 hasweapon(var_0.gauntlet_given_pistol)) {
    var_0 takeweapon(var_0.gauntlet_given_pistol);
    var_1 = var_0 getweaponslistprimaries();

    if(var_1.size > 0 && !istrue(var_0.inlaststand)) {
      var_0 _id_0777::_id_EC3C();
    }
  }

  var_0 enableoffhandweapons();
  var_0 scripts\common\utility::_id_154F(1);
  var_0.gauntlet_given_pistol = undefined;
  var_0 scripts\common\utility::_id_1593(1);
}

play_gaunt_fail_prompt(var_0) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(level.trial_gauntlet_fail_hint) && self _meth_876E("zm_hint_index") == 0) {
    self setclientomnvar("zm_hint_index", level.trial_gauntlet_fail_hint);
    wait(var_0);

    if(isDefined(self) && self _meth_876E("zm_hint_index") == level.trial_gauntlet_fail_hint) {
      self setclientomnvar("zm_hint_index", 0);
    }
  }
}
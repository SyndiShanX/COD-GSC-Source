/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_roof_stealth.gsc
***************************************/

section_main() {
  maps\_utility::add_hint_string("attack_hint", &"FLOOD_STEALTH_ATTACK", ::no_attack_hint);
  maps\_utility::add_hint_string("crouch_hint", &"FLOOD_CROUCH_HINT", ::no_crouch_hint);
}

section_precache() {
  precacheitem("flood_knife");
  precachestring(&"FLOOD_STEALTH_FAIL0");
  precachestring(&"FLOOD_STEALTH_FAIL1");
  precachestring(&"FLOOD_STEALTH_FAIL2");
  precachestring(&"FLOOD_STEALTH_FAIL3");
  precachemodel("com_hatchet");
  precachemodel("com_flashlight_off");
}

section_flag_inits() {
  common_scripts\utility::flag_init("stealth_attack_player");
  common_scripts\utility::flag_init("stealth_kill_01_done");
  common_scripts\utility::flag_init("player_start_stealth_kill_02");
  common_scripts\utility::flag_init("stealth_kill_02_done");
  common_scripts\utility::flag_init("stealth_player_touching");
  common_scripts\utility::flag_init("hatchet_linked");
  common_scripts\utility::flag_init("stealth_enemy_3_dead");
}

roof_stealth_start() {
  maps\flood_util::player_move_to_checkpoint_start("roof_stealth_start");
  maps\flood_util::spawn_allies();
  level.allies[0] maps\_utility::gun_remove();
  level.allies[0] thread ally0_main();
  var_0 = level.player getweaponslistprimaries();

  foreach(var_2 in var_0)
  level.player takeweapon(var_2);

  level.player disableoffhandweapons();
  maps\flood_util::setup_default_weapons(1);
  setsaveddvar("ammoCounterHide", 1);
  thread maps\flood_swept::swept_water_toggle("swim", "show");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "hide");
  visionsetnaked("flood_stealth", 0);
  maps\_utility::fog_set_changes("flood_stealth", 0);
  level.cw_vision_above = "flood_stealth";
  level.cw_fog_above = "flood_stealth";
}

roof_stealth() {
  level thread maps\_utility::autosave_now();
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  thread maps\flood_coverwater::register_coverwater_area("coverwater_stealth", "skybridge_done");
  level.cw_player_in_rising_water = 0;
  level.cw_player_allowed_underwater_time = 30;
  maps\_utility::stop_exploder("swept_under_fx");
  thread float_stuff();
  thread check_for_weapon_pickup();
  thread firstframe_stealth_debris();
  thread maps\flood_fx::fx_stealth_ambient();
  thread maps\flood_fx::exit_stealth_misc_fx();
  level.player thread maps\_gameskill::healthoverlay();
  level.cover_warnings_disabled = undefined;
  var_0 = level.player getfractionmaxammo("fraggrenade");

  if(var_0 == 1) {
    var_1 = level.player getweaponammoclip("fraggrenade");
    level.player setweaponammoclip("fraggrenade", var_1 - 1);
  }

  level.player disableinvulnerability();
  level.player enableweaponpickup();
  level.player giveweapon("flood_knife");
  level.player switchtoweaponimmediate("flood_knife");
  common_scripts\utility::flag_wait("stealth_kill_02_done");
  level notify("onto_skybridge");
}

ally0_main() {
  level endon("stealth_attack_player");
  maps\_utility::clear_force_color();
  self.ignoreall = 1;
  self pushplayer(1);
  maps\_utility::set_ignoreme(1);
  thread ally0_instruction_vo_table();
  thread stealth_kill_01();
  common_scripts\utility::flag_wait_any("stealth_kill_01_done", "player_start_stealth_kill_02");

  if(!common_scripts\utility::flag("player_start_stealth_kill_02")) {
    var_0 = getent("stealth_kill_01", "targetname");
    var_0 thread maps\_anim::anim_loop_solo(self, "stealth_kill_idle", "stop_idle");
    level waittill("player_start_stealth_kill_02");
    var_0 notify("stop_idle");
  }

  level thread maps\flood_anim::skybridge_doorbreach_setup();
  stealth_kill_02_ally();
  self pushplayer(0);
  maps\_utility::set_force_color("r");
}

ally0_instruction_vo(var_0) {
  var_0 endon("death");
  level endon("stealth_attack_player");
  level endon("player_start_stealth_kill_02");
  level endon("player_passed_table");

  if(!common_scripts\utility::flag("player_passed_table")) {
    if(common_scripts\utility::flag("cw_player_underwater"))
      maps\_utility::radio_dialogue("flood_vrg_onlytwomoreup");
    else
      var_0 maps\_utility::dialogue_queue("flood_diz_yougoleft");

    wait 3;
    var_1 = [];
    var_1[0] = "flood_diz_getbelow";
    var_1[1] = "flood_diz_gounderwater";
    var_2 = [];
    var_2[0] = "flood_vrg_gounderwaterandwell";
    var_0 thread play_nag_stealth(var_1, var_2, "player_passed_table", 8, 1, 1.5);
  }
}

play_nag_stealth(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("stop nags");
  var_6 = var_3;
  var_7 = 30;
  var_8 = 0;

  while(!common_scripts\utility::flag(var_2)) {
    if(common_scripts\utility::flag("cw_player_underwater")) {
      var_9 = var_1[randomint(var_1.size)];
      maps\_utility::radio_dialogue(var_9);
    } else {
      var_9 = var_0[randomint(var_0.size)];
      maps\_utility::dialogue_queue(var_9);
    }

    wait(randomfloatrange(var_6 * 0.8, var_6 * 1.2));

    if(var_7 > var_6) {
      var_8 = var_8 + 1;

      if(var_8 == var_4) {
        var_8 = 0;
        var_6 = var_6 * var_5;

        if(var_7 < var_6)
          var_6 = var_7;
      }
    }
  }
}

ally0_instruction_vo_table() {
  self endon("death");
  level endon("stealth_attack_player");
  level endon("player_start_stealth_kill_02");
  common_scripts\utility::flag_wait("player_passed_table");
  maps\_utility::radio_dialogue("flood_vrg_welltakethemout");
}

ally0_instruction_vo_holdup(var_0) {
  if(!common_scripts\utility::flag("player_passed_table")) {
    if(common_scripts\utility::flag("cw_player_underwater"))
      maps\_utility::radio_dialogue("flood_vrg_holdup_2");
    else
      var_0 thread maps\_utility::dialogue_queue("flood_vrg_holdup");
  }
}

roof_stealth_create_enemies() {
  var_0 = getent("stealth_enemy_1", "targetname");
  var_0 maps\_utility::add_spawn_function(::roof_stealth_enemy_spawn_func, "stealth_kill_02_done");
  var_1 = var_0 maps\_utility::spawn_ai();
  level.stealth_enemy_1 = var_1;
  var_1.animname = "stealth_enemy_flash";
  var_2 = getent("stealth_enemy_2", "targetname");
  var_2 maps\_utility::add_spawn_function(::roof_stealth_enemy_spawn_func, "stealth_kill_02_done");
  var_3 = var_2 maps\_utility::spawn_ai();
  level.stealth_enemy_2 = var_3;
  var_3.animname = "stealth_enemy_debris";
  var_4 = getent("stealth_enemy_3", "targetname");
  var_4 maps\_utility::add_spawn_function(::roof_stealth_enemy_spawn_func, "stealth_enemy_3_dead");
  var_5 = var_4 maps\_utility::spawn_ai();
  level.stealth_enemy_3 = var_5;
  var_5.animname = "stealth_enemy_3";
}

roof_stealth_enemy_spawn_func(var_0) {
  thread maps\_utility::enable_cqbwalk();
  maps\_utility::magic_bullet_shield(1);
  self.favoriteenemy = level.player;
  self.aggressivemode = 1;
  maps\_utility::disable_surprise();
  maps\_utility::disable_pain();
  self setengagementmindist(0, 0);
  self setengagementmaxdist(64, 64);
  self.fixednode = 0;
  var_1 = randomfloatrange(0.7, 0.75);
  self.moveplaybackrate = var_1;
  self.movetransitionrate = var_1;
  self.animplaybackrate = var_1;
}

roof_stealth_enemy_flashlight() {
  self endon("death");
  level endon("stealth_attack_player");
  self.allowdeath = 1;
  self.health = 150;
  var_0 = getent("stealth_kill_02", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "stealth_kill_02_idle");
  thread enemy_debris_vo();
  var_0 thread check_break_stealth(210, "debris");
  var_0 thread maps\_anim::anim_loop_solo(self, "stealth_kill_02_idle", "stop_first_loop");
  stopFXOnTag(level._effect["flood_swept_flashlight"], self, "tag_flash");
  playFXOnTag(level._effect["flood_swept_flashlight"], self.flashlight, "tag_light");
  thread check_for_melee_stab();
  thread detect_player_touching();
  common_scripts\utility::flag_wait("player_passed_table");
  var_0 notify("stop_first_loop");
  var_0 maps\_anim::anim_single_solo(self, "stealth_kill_02_into_idle2");
  var_0 thread maps\_anim::anim_loop_solo(self, "stealth_kill_02_idle2", "stop_second_loop");
}

roof_stealth_enemy_debris() {
  self endon("death");
  level endon("stealth_attack_player");
  take_flashlight();
  var_0 = getent("stealth_kill_02", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "stealth_kill_02_idle");
  thread drop_grenade_bag();
  maps\_utility::gun_remove();
  var_0 thread maps\_anim::anim_loop_solo(self, "stealth_kill_02_idle");
}

check_for_weapon_pickup() {
  for(;;) {
    var_0 = level.player getcurrentweapon();

    if(var_0 != "none" && var_0 != "flood_knife") {
      maps\flood_util::jkuprint("unhiding ammo counter because of weapon pickup.taking knife");
      level.player takeweapon("flood_knife");
      level.player enableoffhandweapons();
      setsaveddvar("ammoCounterHide", 0);
      break;
    }

    common_scripts\utility::waitframe();
  }
}

stealth_door_traverse_think() {
  level.player endon("mantle_used");
  var_0 = getent("stealth_mantle_lookat", "targetname");
  notifyoncommand("mantle", "+gostand");

  for(;;) {
    if(common_scripts\utility::flag("mantle_copier") && maps\_utility::player_looking_at(var_0.origin, 0.8, 1) && level.player getstance() == "stand" && !level.player isthrowinggrenade() && !level.player ismeleeing()) {
      setsaveddvar("hud_forceMantleHint", 1);
      level.player allowjump(0);
      level.player disableweapons();
      level.player thread player_mantle_wait();

      while(common_scripts\utility::flag("mantle_copier") && maps\_utility::player_looking_at(var_0.origin, 0.8, 1) && level.player getstance() == "stand" && !level.player isthrowinggrenade() && !level.player ismeleeing()) {
        if(level.player getstance() != "stand") {
          break;
        }

        common_scripts\utility::waitframe();
      }
    } else {
      level.player notify("not_active");
      setsaveddvar("hud_forceMantleHint", 0);
      level.player allowjump(1);
      level.player enableweapons();
    }

    common_scripts\utility::waitframe();
  }
}

player_mantle_wait() {
  self endon("not_active");
  self waittill("mantle");
  setsaveddvar("hud_forceMantleHint", 0);
  self notify("mantle_used");
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  var_0 = maps\_utility::spawn_anim_model("player_rig");
  var_1 = [];
  var_1["player_rig"] = var_0;
  var_2 = getent("stealth_kill_02", "targetname");
  var_2 maps\_anim::anim_first_frame(var_1, "stealth_traverse");
  level.player playerlinktoblend(var_0, "tag_player", 0.25, 0.1, 0.1, 1);
  thread maps\flood_audio::sfx_plr_vault();
  level thread maps\flood_rooftops::skybridge_teleport_cheats();
  var_2 maps\_anim::anim_single(var_1, "stealth_traverse");
  var_0 delete();
  level.player unlink();
  level.player freezecontrols(0);
  level.player allowjump(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  stealth_debris_collision("on");
  thread maps\flood_swept::swept_water_toggle("swim", "show");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "hide");
  level notify("player_done_stealth_mantle");
}

reset_allies_to_defaults() {
  var_0 = randomfloatrange(0.9, 1.1);
  level.allies[0] thread maps\_utility::disable_cqbwalk();
  level.allies[0].goalradius = 2048;
  level.allies[0].ignoreall = 0;
  level.allies[0] maps\_utility::set_ignoreme(0);
  level.allies[0].moveplaybackrate = 1.0;
  level.allies[0].movetransitionrate = var_0;
  level.allies[0].animplaybackrate = var_0;
}

drop_grenade_bag() {
  var_0 = self.team;
  maps\_spawner::waittilldeathorpaindeath();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.nodrop)) {
    return;
  }
  self.ignoreforfixednodesafecheck = 1;
  var_1 = 25;
  var_2 = 12;
  var_3 = self.origin + (randomint(var_1) - var_2, randomint(var_1) - var_2, 2) + (0, 0, 42);
  var_4 = (0, randomint(360), 90);
  thread maps\_spawner::spawn_grenade_bag(var_3, var_4, self.team);
  level.player enableoffhandweapons();
}

float_stuff() {
  var_0 = getEntArray("stealth_bob", "targetname");

  foreach(var_2 in var_0)
  var_2 maps\_utility::delaythread(randomfloatrange(0, 1.5), ::floater_logic, "stealth_bob");
}

floater_logic(var_0) {
  level endon("window_smash");
  self endon("popped");
  self endon("death");

  switch (var_0) {
    case "stealth_bob":
      for(;;) {
        var_1 = 2;
        var_2 = 1;
        var_3 = 1.25;
        self moveto(self.origin - (0, 0, var_1), var_3, 0.2, 0.2);
        self rotateto(self.angles - (var_2, 0, var_2), var_3, 0.4, 0.4);
        wait(var_3);
        self moveto(self.origin + (0, 0, var_1), var_3, 0.2, 0.2);
        self rotateto(self.angles + (var_2, 0, var_2), var_3, 0.4, 0.4);
        wait(var_3);
      }
  }
}

enemy_start_vo(var_0) {
  level.stealth_enemy_1 endon("death");
  level.stealth_enemy_2 endon("death");
  level.stealth_enemy_3 endon("death");
  level endon("stealth_attack_player");
  level endon("player_start_stealth_kill_02");
  level.allies[0] maps\_utility::dialogue_queue("flood_vrg_itlookslikeits");

  if(common_scripts\utility::flag("cw_player_underwater")) {
    level thread maps\_utility::radio_dialogue("flood_vrg_folowmyleashit");
    thread maps\flood_audio::sfx_rorke_submerge(level.allies[0]);
  } else {
    level.allies[0] thread maps\_utility::dialogue_queue("flood_vrg_theyrecomingthisway");
    thread maps\flood_audio::sfx_rorke_submerge(level.allies[0]);
  }

  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_duartecheckinthere");
  level.stealth_enemy_3 maps\_utility::dialogue_queue("flood_vs7_yessir");
  wait 1;
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_castilloyourewithme");
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_whatsthatupahead");
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_ithinkthatsanother");
  wait 1;
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_castillotryandclear");
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_couldigetsome");
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_sure");
}

enemy_debris_vo() {
  level.stealth_enemy_1 endon("death");
  level.stealth_enemy_2 endon("death");
  level endon("stealth_attack_player");
  level endon("player_start_stealth_kill_02");
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_getthrough");
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_dontgiveup");
  wait 2;
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_makingprogress");
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_goodgrip");
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_lightsteady");
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_keepthelight");
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_finejustkeep");
  wait 3;
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_thinksomething");
  level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_thelight");
  level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_ohright");

  for(;;) {
    if(randomint(2)) {
      level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_getthrough");
      level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_dontgiveup");
    } else {
      level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_thinksomething");
      level.stealth_enemy_2 maps\_utility::dialogue_queue("flood_vs9_thelight");
      level.stealth_enemy_1 maps\_utility::dialogue_queue("flood_vs8_ohright");
    }

    wait(randomintrange(6, 9));
  }
}

ai_alert_player_break_stealth() {
  common_scripts\utility::flag_set("stealth_attack_player");
  level notify("stealth_attack_player");
  level.allies[0] thread maps\_utility::dialogue_queue("flood_diz_theyseeyou");
  level.allies[0] thread take_hatchet();
  level.allies[0] stopanimscripted();

  if(!isDefined(level.allies[0].magic_bullet_shield))
    level.allies[0] maps\_utility::stop_magic_bullet_shield();

  level.allies[0].health = 1;
  var_0 = getnode("ally_stealth_break_01_node", "targetname");
  level.allies[0] allowedstances("crouch");
  var_1 = getent("stealth_kill_01", "targetname");
  var_1 notify("stop_idle");
  waittillframeend;
  level.allies[0] thread maps\_anim::anim_loop_solo(level.allies[0], "stealth_busted_idle", "stop_loop");
  level maps\_utility::delaythread(5, maps\_utility::missionfailedwrapper);

  if(isalive(level.stealth_enemy_1)) {
    level.stealth_enemy_1 stopanimscripted();
    level.stealth_enemy_1 drop_flashlight();
    level.stealth_enemy_1.ignoreall = 0;
    level.stealth_enemy_1.goalradius = 8;
    level.stealth_enemy_1 setgoalpos(level.player.origin);
  }

  level.stealth_enemy_2 stopanimscripted();
  level.stealth_enemy_2 drop_flashlight();
  level.stealth_enemy_2.ignoreall = 0;
  level.stealth_enemy_2.goalradius = 64;
  level.stealth_enemy_2 setgoalpos(level.player.origin);
  level.stealth_enemy_2 maps\_utility::gun_recall();

  if(!common_scripts\utility::flag("hatchet_linked")) {
    level.stealth_enemy_3 stopanimscripted();
    level.stealth_enemy_3 drop_flashlight();
    level.stealth_enemy_3.ignoreall = 0;
    level.stealth_enemy_3 setgoalpos(level.player.origin);
  }
}

check_break_stealth(var_0, var_1) {
  self endon("death");
  level endon("start_evade_success");
  level endon("player_start_stealth_kill_02");
  level endon("onto_skybridge");
  maps\flood_util::jkuprint("looking");

  for(;;) {
    if(!common_scripts\utility::flag("cw_player_underwater") && distance2d(level.player.origin, self.origin) < var_0 || common_scripts\utility::flag("stealth_player_touching") || !isalive(level.stealth_enemy_1) || !isalive(level.stealth_enemy_2)) {
      thread clean_up_attack(1);
      thread maps\flood_coverwater::player_abovewater_defaults();
      thread ai_alert_player_break_stealth();
      break;
    }

    common_scripts\utility::waitframe();
  }

  maps\flood_util::jkuprint("spotted!");
  maps\_utility::delaythread(2, ::break_stealth_mg, var_1);
}

break_stealth_mg(var_0) {
  while(isalive(level.player)) {
    var_1 = level.player getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = level.player.origin + 15 * var_2 + (randomfloatrange(-10, 10), randomfloatrange(-10, 10), 55);
    magicbullet("pp19", var_3, level.player.origin);
    level.player dodamage(50, level.player.origin);
    wait(randomfloatrange(0.05, 0.15));
  }

  if(var_0 == "start")
    setDvar("ui_deadquote", &"FLOOD_STEALTH_FAIL0");
  else if(randomint(2))
    setDvar("ui_deadquote", &"FLOOD_STEALTH_FAIL1");
  else
    setDvar("ui_deadquote", &"FLOOD_STEALTH_FAIL2");
}

no_attack_hint() {
  if(!isalive(level.player))
    return 1;

  if(!isDefined(level.player.ready_to_attack) || !level.player.ready_to_attack)
    return 1;

  if(isDefined(level.player.in_attack) && level.player.in_attack)
    return 1;

  if(common_scripts\utility::flag("stealth_attack_player"))
    return 1;

  return 0;
}

ready_to_attack() {
  level.player allowmelee(0);
  level.player.ready_to_attack = 1;
}

clean_up_attack(var_0) {
  if(isDefined(level.player.ready_to_attack) && level.player.ready_to_attack)
    level.player.ready_to_attack = undefined;

  if(var_0)
    level.player allowmelee(1);
}

check_for_melee_stab() {
  level.player endon("death");
  level endon("stealth_attack_player");
  var_0 = 8100;

  for(;;) {
    var_1 = distancesquared(level.player.origin, self.origin);

    if(var_1 < var_0 && maps\_utility::player_looking_at(self.origin + (0, 0, 30), 0.7)) {
      ready_to_attack();

      if(level.player meleeButtonPressed() && !level.player ismeleeing() && !level.player isthrowinggrenade()) {
        common_scripts\utility::flag_set("player_start_stealth_kill_02");
        level notify("player_start_stealth_kill_02");
        level.player.in_attack = 1;
        stealth_kill_02_player();
        level.stealth_enemy_1.a.nodeath = 1;
        level.stealth_enemy_1.allowdeath = 1;
        level.stealth_enemy_1.diequietly = 1;
        level.stealth_enemy_1 kill();
        level.stealth_enemy_2 dropweapon("pp19", "right", 0);
        level.stealth_enemy_2 maps\_utility::stop_magic_bullet_shield();
        level.stealth_enemy_2.a.nodeath = 1;
        level.stealth_enemy_2.allowdeath = 1;
        level.stealth_enemy_2.diequietly = 1;
        level.stealth_enemy_2 kill();
        clean_up_attack(1);
        return;
      }
    } else if(var_1 < var_0 && common_scripts\utility::flag("cw_player_underwater"))
      clean_up_attack(0);
    else
      clean_up_attack(1);

    common_scripts\utility::waitframe();
  }
}

firstframe_stealth_debris() {
  var_0 = getent("stealth_kill_02", "targetname");
  var_1 = getent("firstframe_test", "targetname");
  level.stealth_filecab1 = maps\_utility::spawn_anim_model("flood_stealthkill_02_filecabinet_01");
  level.stealth_filecab1.origin = var_1.origin;
  var_2 = getent("stealth_door_filecab1", "targetname");
  var_2 linkto(level.stealth_filecab1);
  level.stealth_filecab2 = maps\_utility::spawn_anim_model("flood_stealthkill_02_filecabinet_02");
  level.stealth_filecab2.origin = var_1.origin;
  var_2 = getent("stealth_door_filecab2", "targetname");
  var_2 linkto(level.stealth_filecab2);
  level.stealth_photocopier = maps\_utility::spawn_anim_model("stealthkill_photocopier");
  level.stealth_photocopier.origin = var_1.origin;
  var_2 = getent("stealth_door_copier", "targetname");
  var_2 linkto(level.stealth_photocopier);
  var_3 = [];
  var_3["flood_stealthkill_02_filecabinet_01"] = level.stealth_filecab1;
  var_3["flood_stealthkill_02_filecabinet_02"] = level.stealth_filecab2;
  var_3["stealthkill_photocopier"] = level.stealth_photocopier;
  var_0 maps\_anim::anim_first_frame(var_3, "stealth_kill_02");
  var_2 disconnectpaths();
}

stealth_debris_collision(var_0) {
  switch (var_0) {
    case "on":
      var_1 = getent("stealth_door_filecab1", "targetname");
      var_1 solid();
      break;
    case "off":
      var_1 = getent("stealth_door_filecab1", "targetname");
      var_1 notsolid();
      break;
  }
}

crouch_hint() {
  level.player maps\_utility::display_hint_timeout("crouch_hint", 3);
}

no_crouch_hint() {
  if(!isalive(level.player))
    return 1;

  return 0;
}

remove_kill1_collision() {
  var_0 = getent("stealth kill1 collision", "targetname");
  var_0 notsolid();
}

detect_player_touching() {
  self endon("death");
  level endon("player_start_stealth_kill_02");
  level endon("stealth_attack_player");

  for(;;) {
    var_0 = gettime();
    var_1 = undefined;

    while(distance2d(level.player.origin, self.origin) < 36 || level.player istouching(self)) {
      var_2 = gettime();

      if(var_2 - var_0 > 3000 || level.player istouching(self)) {
        common_scripts\utility::flag_set("stealth_player_touching");
        break;
      } else if(var_2 - var_0 > 500) {
        if(!isDefined(var_1)) {
          var_1 = 1;
          level.player maps\_utility::display_hint("attack_hint");
        }
      }

      common_scripts\utility::waitframe();
    }

    common_scripts\utility::waitframe();
  }
}

stealth_kill_01() {
  roof_stealth_create_enemies();
  var_0 = getent("stealth_kill_01", "targetname");
  level.stealth_enemy_1 thread stealth_kill_01_enemy1(var_0);
  level.stealth_enemy_2 thread stealth_kill_01_enemy2(var_0);
  var_1 = maps\_utility::spawn_anim_model("stealth_axebox");
  var_2 = getent("axbox_collision", "targetname");
  var_2.origin = var_1 gettagorigin("j_bone_door_1") + (13.5, 0, 2.5);
  var_2.angles = var_1 gettagangles("j_bone_door_1");
  var_2 linkto(var_1, "j_bone_door_1");
  level.allies[0] thread create_hatchet();
  var_3 = [];
  var_3["ally_0"] = level.allies[0];
  var_3["stealth_axebox"] = var_1;
  var_3["stealth_enemy_3"] = level.stealth_enemy_3;
  level.stealth_enemy_2 maps\_utility::delaythread(11, ::check_break_stealth, 666, "start");
  maps\_utility::delaythread(16, ::check_break_stealth_end);
  maps\_utility::delaythread(1, ::remove_kill1_collision);
  maps\_utility::delaythread(21, maps\_utility::autosave_now);
  level.stealth_enemy_3 give_flashlight();
  var_0 maps\_anim::anim_single(var_3, "stealth_kill_01");
  level.stealth_enemy_3 maps\_vignette_util::vignette_actor_kill();
  common_scripts\utility::flag_set("stealth_kill_01_done");
}

stealth_kill_01_enemy1(var_0) {
  maps\_utility::stop_magic_bullet_shield();
  maps\_utility::enable_pain();
  give_flashlight();
  var_0 maps\_anim::anim_single_solo(self, "stealth_kill_01");
  stopFXOnTag(level._effect["flashlight"], self.flashlight, "tag_light");
  playFXOnTag(level._effect["flashlight"], self, "tag_flash");
  roof_stealth_enemy_flashlight();
}

stealth_kill_01_enemy2(var_0) {
  give_flashlight();
  var_0 maps\_anim::anim_single_solo(self, "stealth_kill_01");
  roof_stealth_enemy_debris();
}

enemy_dead(var_0) {
  maps\flood_util::jkuprint("killing enemy via notetrack to stop coverwater");
  var_0 notify("ai_stop_coverwater");
}

give_flashlight() {
  self.flashlight = maps\_utility::spawn_anim_model("stealth_flashlight");
  self.flashlight.origin = self gettagorigin("tag_inhand");
  self.flashlight.angles = self gettagangles("tag_inhand");
  self.flashlight linkto(self, "tag_inhand");
  playFXOnTag(level._effect["flood_swept_flashlight"], self.flashlight, "tag_light");
}

take_flashlight() {
  stopFXOnTag(level._effect["flood_swept_flashlight"], self.flashlight, "tag_light");
  self.flashlight unlink();
  self.flashlight delete();
  self.flashlight = undefined;
}

off_flashlight(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = self;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1) {
    stopFXOnTag(level._effect["flood_swept_flashlight"], var_0.flashlight, "tag_light");
    var_0.flashlight setModel("com_flashlight_off");
  } else {
    stopFXOnTag(level._effect["flood_swept_flashlight"], var_0.flashlight, "tag_light");
    var_0.flashlight setModel("com_flashlight_off");
    wait 0.15;
    playFXOnTag(level._effect["flood_swept_flashlight"], var_0.flashlight, "tag_light");
    var_0.flashlight setModel("com_flashlight_on");
    wait 0.2;
    stopFXOnTag(level._effect["flood_swept_flashlight"], var_0.flashlight, "tag_light");
    var_0.flashlight setModel("com_flashlight_off");
    wait 0.1;
    playFXOnTag(level._effect["flood_swept_flashlight"], var_0.flashlight, "tag_light");
    var_0.flashlight setModel("com_flashlight_on");
    wait 0.25;
    stopFXOnTag(level._effect["flood_swept_flashlight"], var_0.flashlight, "tag_light");
    var_0.flashlight setModel("com_flashlight_off");
  }
}

drop_flashlight() {
  if(isDefined(self.flashlight)) {
    self.flashlight unlink();
    var_0 = physicstrace(self.flashlight.origin, self.flashlight.origin + (0, 0, -300));
    var_1 = 0.6;
    thread off_flashlight(undefined, 1);
    var_2 = [];
    var_2[0] = 90;
    var_2[1] = -90;
    self.flashlight moveto(var_0 + (0, 0, 1), var_1);
    self.flashlight rotateto((common_scripts\utility::random(var_2), self.flashlight.angles[0], common_scripts\utility::random(var_2)), var_1);
  }
}

check_break_stealth_end() {
  level notify("start_evade_success");
  maps\flood_util::jkuprint("not looking");
}

create_hatchet() {
  if(!isDefined(self.hatchet))
    self.hatchet = maps\_utility::spawn_anim_model("stealth_hatchet", (4191.98, -2684.73, 66.7125));

  self.hatchet.angles = (90, 0, 0);
}

#using_animtree("generic_human");

give_hatchet(var_0) {
  var_0 clearanim(%flood_stealthkill_01_ally1_face1, 0.2);
  common_scripts\utility::flag_set("hatchet_linked");

  if(!common_scripts\utility::flag("player_passed_table"))
    var_0 thread maps\_utility::dialogue_queue("flood_vrg_thiswillbeuseful");

  var_0.hatchet.origin = var_0 gettagorigin("tag_inhand");
  var_0.hatchet.angles = var_0 gettagangles("tag_inhand");
  var_0.hatchet delete();
  var_0 attach("com_hatchet", "tag_inhand", 1);
}

take_hatchet() {
  if(common_scripts\utility::flag("hatchet_linked"))
    self detach("com_hatchet", "tag_inhand");
}

detach_hatchet(var_0) {
  var_1 = maps\_utility::spawn_anim_model("stealth_hatchet");
  var_1.origin = var_0 gettagorigin("tag_inhand");
  var_1.angles = var_0 gettagangles("tag_inhand");
  var_0 detach("com_hatchet", "tag_inhand");
}

hatchet_linked(var_0) {
  common_scripts\utility::flag_set("hatchet_linked");
}

stealth_kill_02_player() {
  var_0 = getent("stealth_kill_02", "targetname");
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.cw_no_waterwipe = 1;
  thread maps\flood_audio::sfx_stealth_kill_death_vo(level.stealth_enemy_1);
  level.stealth_enemy_1 thread off_flashlight(undefined, 1);
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_1 gettagorigin("tag_player") + (0, 0, 20);
  var_2.angles = var_1 gettagangles("tag_player");
  var_2 linkto(var_1, "tag_player");
  var_3 = [];
  var_3["vignette_stealth_kill2_opfor1"] = level.stealth_enemy_1;
  var_3["player_rig"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_3, "stealth_kill_02");
  var_1 hide();
  level.allies[0] hide();
  level.player playerlinktoblend(var_2, "tag_origin", 0.1);
  wait 0.1;
  level.player hideviewmodel();
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1 attach("viewmodel_knife_iw6", "tag_knife_attach", 1);
  level.player playSound("scn_flood_plr_stealth_kill");
  var_1 show();
  level.allies[0] common_scripts\utility::delaycall(0.3, ::show);
  level thread stealth_kill_02_vision_hack();
  var_0 maps\_anim::anim_single(var_3, "stealth_kill_02");
  var_1 detach("viewmodel_knife_iw6", "tag_knife_attach", 1);
  level.player unlink();
  var_1 delete();
  level.player showviewmodel();
  level.player freezecontrols(0);
  level.player allowcrouch(1);
  level.player enableweapons();
  level.cw_no_waterwipe = 0;
  var_4 = getent("stealth_hall_clip", "targetname");
  var_4 hide();
  var_4 notsolid();
}

stealth_kill_02_ally() {
  var_0 = getent("stealth_kill_02", "targetname");
  var_1 = [];
  var_1["flood_stealthkill_02_filecabinet_01"] = level.stealth_filecab1;
  var_1["flood_stealthkill_02_filecabinet_02"] = level.stealth_filecab2;
  var_1["stealthkill_photocopier"] = level.stealth_photocopier;
  var_1["vignette_stealth_kill2_opfor2"] = level.stealth_enemy_2;
  var_1["vignette_stealth_kill2_ally1"] = level.allies[0];
  thread maps\flood_audio::sfx_diaz_stealth_kills2(var_1["vignette_stealth_kill2_ally1"]);
  level.allies[0] maps\_utility::delaythread(11, maps\_utility::smart_dialogue, "flood_diz_stabelground");
  stealth_debris_collision("off");
  maps\_utility::delaythread(13.5, ::stealth_door_traverse_think);
  level.allies[0] maps\_utility::delaythread(13, maps\_utility::gun_recall);
  level.allies[0] maps\_utility::delaythread(13, maps\_utility::forceuseweapon, "fads", "primary");
  var_0 maps\_anim::anim_single(var_1, "stealth_kill_02");
  common_scripts\utility::flag_set("stealth_kill_02_done");
}

roof_stealth_cleanup() {
  var_0 = getEntArray("stealth_bob", "targetname");
  maps\_utility::array_delete(var_0);
  var_0 = getEntArray("stealth_cleanup", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

stealth_kill_02_vision_hack() {
  level.player visionsetnakedforplayer("flood_underwater_stealth", 0);
  level.player setwatersurfacetransitionfx(common_scripts\utility::getfx("small_water_splash"), common_scripts\utility::getfx("small_water_splash"), common_scripts\utility::getfx("small_water_splash"), common_scripts\utility::getfx("small_water_splash"));
  wait 1.75;
  maps\flood_util::jkuprint("turning water transition hack off");
  level.player visionsetnakedforplayer(level.cw_vision_above, 0);
  maps\flood::flood_default_water_transion_fx();
}

stealth_kill_01_facial(var_0) {
  var_0 setanim(%flood_stealthkill_01_ally1_face1, 1, 0.2);
}

stealth_kill_01_facial_start(var_0) {
  var_0 setanim(%flood_stealthkill_01_ally1_facestart, 1, 0.2);
}

stealth_kill_01_opfor_facial(var_0) {
  var_0 setanim(%flood_stealthkill_01_opfor3_face, 1, 0.2);
}
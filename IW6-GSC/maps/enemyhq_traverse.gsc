/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\enemyhq_traverse.gsc
*****************************************************/

enemyhq_traverse_pre_load() {
  common_scripts\utility::flag_init("rpg_ambush_shield");
  common_scripts\utility::flag_init("start_sniper_rpg_ambush");
  common_scripts\utility::flag_init("ambush_moved_up");
  common_scripts\utility::flag_init("ambush1_dead");
  common_scripts\utility::flag_init("ambush2_dead");
  common_scripts\utility::flag_init("traverse_done");
}

setup_traverse() {
  level.start_point = "traverse";
  maps\enemyhq::setup_common();
  thread maps\enemyhq_audio::aud_check("traverse");
  level.dog maps\enemyhq_code::lock_player_control();
}

begin_traverse() {
  level.sniper_vision_override = "enemyhq_sniper_view_b";
  var_0 = getent("debris_slide", "targetname");
  var_0 common_scripts\utility::trigger_off();
  common_scripts\utility::flag_clear("done_sniping_early");
  maps\_utility::autosave_by_name("traverse");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("traversal_allies1");
  thread handle_rpg_ambush();
  thread turn_off_sniping();
  common_scripts\utility::flag_wait("start_rpg_ambush");
  level.remote_sniper_return_struct = common_scripts\utility::getstruct("ambush_return_spot", "targetname");
  thread handle_ambush_return_spot();
  level.dog maps\_utility::disable_ai_color();
  level.dog setgoalpos(level.dog.origin);
  wait 0.2;
  level.dog maps\_utility_dogs::disable_dog_sniff();
  wait 0.2;
  level.dog maps\_utility::enable_ai_color();
  common_scripts\utility::flag_wait("to_basement");
  level.createrpgrepulsors = 0;

  if(common_scripts\utility::flag("start_sniper_rpg_ambush"))
    thread dog_sniff_traverse();

  var_1 = getnode("doggie_basement_path", "targetname");
  level.dog thread maps\_utility::follow_path(var_1);
  level.dog maps\_utility::disable_ai_color();
  level.dog thread dog_color_on();
  maps\enemyhq_code::safe_activate_trigger_with_targetname("traversal_allies2");
  common_scripts\utility::flag_wait("final_rpg_ambush");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("wait_in_basement");
  common_scripts\utility::flag_wait("traverse_done");
  level.createrpgrepulsors = 1;
  level notify("cancel_rpg");
  wait 1;
  common_scripts\utility::flag_set("done_sniping_early");
}

dog_color_on() {
  self waittill("reached_path_end");
  maps\_utility::enable_ai_color();
}

handle_ambush_return_spot() {
  common_scripts\utility::flag_wait("ambush_moved_up");
  level.remote_sniper_return_struct = undefined;
}

dog_sniff_traverse() {
  wait 1;
  level.dog playSound("anml_dog_bark");
  wait 0.5;
  level.dog playSound("anml_dog_bark");
  wait 1;
  level.allies[2] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_hsh_stickwithrileyhell");
}

player_rpg_shield() {
  common_scripts\utility::flag_set("rpg_ambush_shield");
  maps\_utility::delaythread(6, common_scripts\utility::flag_clear, "rpg_ambush_shield");
  var_0 = [];
  var_0[var_0.size] = missile_createrepulsorent(level.player, 5000, 800);
  wait 0.25;
  var_0[var_0.size] = missile_createrepulsorent(level.player, 5000, 800);
  wait 0.25;

  while(common_scripts\utility::flag("rpg_ambush_shield")) {
    var_0[var_0.size] = missile_createrepulsorent(level.player, 5000, 800);
    missile_deleteattractor(var_0[0]);
    var_0 = maps\_utility::array_remove_index(var_0, 0);
    wait 0.25;
  }

  foreach(var_2 in var_0)
  missile_deleteattractor(var_2);
}

player_rpg_attractor() {
  var_0 = [];
  var_0[var_0.size] = missile_createattractorent(level.player, 5000, 800);
  wait 0.25;
  var_0[var_0.size] = missile_createattractorent(level.player, 5000, 800);
  wait 0.25;

  while(!common_scripts\utility::flag("traverse_done")) {
    var_1 = level.player.origin + anglesToForward(level.player.angles) * 100;
    var_0[var_0.size] = missile_createattractororigin(var_1, 5000, 800);
    missile_deleteattractor(var_0[0]);
    var_0 = maps\_utility::array_remove_index(var_0, 0);
    wait 0.25;
  }

  foreach(var_3 in var_0)
  missile_deleteattractor(var_3);
}

rpg_crash() {
  var_0 = common_scripts\utility::getstruct("rpg_originA", "targetname");
  var_1 = common_scripts\utility::getstruct("rpg_targA", "targetname");
  var_2 = missile_createattractororigin(var_1.origin, 10000, 500);
  var_3 = magicbullet("rpg", var_0.origin, var_1.origin);
  var_4 = getent("debris_slide", "targetname");
  var_4 common_scripts\utility::trigger_on();
  var_3 waittill("explode");
  thread maps\enemyhq_audio::aud_player_slide();
  screenshake(level.player.origin, 50, 50, 50, 0.5);
  var_1 = common_scripts\utility::getstruct("rpg_explosion", "targetname");
  var_5 = common_scripts\utility::getfx("remote_sniper_hit");
  playFX(var_5, var_1.origin, var_1.angles);
  var_1 = common_scripts\utility::getstruct("rpg_explosion2", "targetname");
  var_5 = common_scripts\utility::getfx("remote_sniper_hit");
  playFX(var_5, var_1.origin, var_1.angles);
  missile_deleteattractor(var_2);
  wait 5;
  level.player enabledeathshield(0);
}

handle_rpg_ambush() {
  level endon("cancel_rpg");
  common_scripts\utility::flag_wait("start_pre_rpg_ambush");
  level.player enabledeathshield(1);
  var_0 = common_scripts\utility::getstructarray("rpg_originB", "targetname");
  var_1 = common_scripts\utility::getstructarray("rpg_targB", "targetname");
  var_2 = missile_createattractororigin(var_1[0].origin, 1000, 300);
  thread fire_fake_rpgs(var_0, var_1);
  level.allies[1] maps\_utility::delaythread(0.5, maps\enemyhq_code::char_dialog_add_and_go, "enemyhq_kgn_ambush");
  common_scripts\utility::flag_wait("start_rpg_ambush");
  thread maps\_utility::battlechatter_on("allies");
  thread maps\_utility::battlechatter_on("axis");
  thread rpg_crash();
  wait 1;
  var_0 = common_scripts\utility::getstructarray("rpg_origin", "targetname");
  var_1 = common_scripts\utility::getstructarray("rpg_targ", "targetname");
  thread fire_fake_rpgs(var_0, var_1);
  thread fudge_ally_accuracy();
  maps\_utility::delaythread(2, ::player_rpg_shield);
  var_3 = maps\enemyhq_code::array_spawn_targetname_allow_fail("rpg_ambush_guys", 1);
  level.rpg_ambush_guys = var_3;
  common_scripts\utility::array_thread(var_3, ::rpg_ambushers);
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_3, var_3.size, "ambush1_dead");
  wait 1;
  missile_deleteattractor(var_2);
  thread handle_rpg_sniper();
  thread handle_skip_rpg_sniping();
  wait 1;
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_adamusetheremote");
  common_scripts\utility::flag_set("start_rpg_kibble");
  thread maps\enemyhq_code::sniper_hint("start_sniper_rpg_ambush", 4);
  common_scripts\utility::flag_wait("ambush1_dead");

  if(common_scripts\utility::flag("start_sniper_rpg_ambush"))
    common_scripts\utility::flag_wait("ambush2_dead");

  common_scripts\utility::flag_set("done_sniping_early");
  wait 1;
  common_scripts\utility::flag_set("to_basement");
  level.allies[0] thread maps\enemyhq_code::char_dialog_add_and_go("enemyhq_mrk_allclearmove");
  wait 10;
  thread maps\enemyhq_code::nag_player_until_flag(level.allies[0], "final_rpg_ambush", "enemyhq_mrk_letsgoreinforcementsllbe", "enemyhq_mrk_getdownhere", "enemyhq_mrk_logancatchup", "enemyhq_mrk_moveajaxwontlast");
}

rpg_ambushers() {
  self endon("death");
  self clearenemy();
  maps\_utility::set_ignoresuppression(1);
  wait 2;
  self getenemyinfo(level.player);
  var_0 = 1;

  for(;;) {
    if(isDefined(self.a.rockets))
      self.a.rockets = var_0;

    wait 0.05;
  }
}

fudge_ally_accuracy() {
  foreach(var_1 in level.allies) {
    var_1.oldaccuracy = var_1.baseaccuracy;
    var_1 maps\_utility::set_baseaccuracy(0.01);
  }

  common_scripts\utility::flag_wait("to_basement");

  foreach(var_1 in level.allies)
  var_1 maps\_utility::set_baseaccuracy(var_1.oldaccuracy);
}

handle_skip_rpg_sniping() {
  common_scripts\utility::flag_wait("to_basement");
  common_scripts\utility::flag_clear("rpg_ambush_shield");

  if(!common_scripts\utility::flag("start_sniper_rpg_ambush") && !common_scripts\utility::flag("ambush1_dead")) {
    thread player_rpg_attractor();
    var_0 = common_scripts\utility::getstructarray("rpg_origin", "targetname");
    var_1 = common_scripts\utility::getstructarray("rpg_targ2", "targetname");
    thread fire_fake_rpgs(var_0, var_1);
    common_scripts\utility::flag_wait("final_rpg_ambush");

    if(!common_scripts\utility::flag("start_sniper_rpg_ambush") && !common_scripts\utility::flag("ambush1_dead")) {
      var_1 = common_scripts\utility::getstructarray("rpg_targ3", "targetname");
      thread fire_fake_rpgs(var_0, var_1);
    }
  }
}

turn_off_sniping() {
  common_scripts\utility::flag_wait_any("ambush1_dead", "traverse_done", "done_sniping_early");

  if(!common_scripts\utility::flag("start_sniper_rpg_ambush")) {
    level.player notify("stop_watching_remote_sniper");
    level notify("cancel_rpg_sniper");
    level.player setweaponhudiconoverride("actionslot1", "");
    wait 0.2;
    common_scripts\utility::flag_set("start_sniper_rpg_ambush");

    if(!common_scripts\utility::flag("done_sniping_early")) {
      var_0 = getEntArray("rpg_ambusher", "script_noteworthy");
      common_scripts\utility::array_thread(var_0, maps\enemyhq_code::die_quietly);
    }
  }
}

handle_rpg_sniper() {
  level endon("cancel_rpg_sniper");
  thread maps\enemyhq_audio::aud_pre_sniper_rpg_listener();
  level.player waittill("player_switching_to_tablet");
  common_scripts\utility::flag_set("start_sniper_rpg_ambush");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("rpg_ambush_color");
  thread maps\enemyhq_audio::aud_start_sniper("enhq_stadium_open");
  maps\enemyhq_code::safe_activate_trigger_with_targetname("ally_ambush_positions");
  var_0 = maps\enemyhq_code::array_spawn_targetname_allow_fail("rpg_ambush_guys2", 1);
  common_scripts\utility::array_thread(var_0, ::rpg_ambushers);
  thread maps\enemyhq_code::ai_array_killcount_flag_set(var_0, var_0.size, "ambush2_dead");
  level.rpg_ambush_guys = common_scripts\utility::array_combine(level.rpg_ambush_guys, var_0);
  wait 30;
  level.rpg_ambush_guys = maps\_utility::array_removedead_or_dying(level.rpg_ambush_guys);

  if(level.rpg_ambush_guys.size > 1)
    common_scripts\utility::array_thread(level.rpg_ambush_guys, ::kill_allies_on_next_shot);
  else
    common_scripts\utility::array_thread(level.rpg_ambush_guys, ::fake_ally_kill_me);
}

kill_allies_on_next_shot() {
  self endon("death");
  self waittill("shooting");
  level.rpg_ambush_guys = maps\_utility::array_removedead_or_dying(level.rpg_ambush_guys);

  if(level.rpg_ambush_guys.size > 1) {
    wait 2;
    level.rpg_ambush_guys = maps\_utility::array_removedead_or_dying(level.rpg_ambush_guys);

    if(level.rpg_ambush_guys.size > 1) {
      if(self.enemy != level.player && self.enemy.magic_bullet_shield) {
        self.enemy maps\_utility::stop_magic_bullet_shield();
        self.enemy maps\_utility::die();
      }

      setdvar("ui_deadquote", & "ENEMY_HQ_YOUR_ALLY_WAS_KILLED");
      maps\_utility::missionfailedwrapper();
    } else
      common_scripts\utility::array_thread(level.rpg_ambush_guys, ::fake_ally_kill_me);
  } else
    common_scripts\utility::array_thread(level.rpg_ambush_guys, ::fake_ally_kill_me);
}

fake_ally_kill_me() {
  self endon("death");
  var_0 = common_scripts\utility::getstruct("ally_kill_loc", "targetname");
  var_1 = level.allies[0].weapon;
  magicbullet(var_1, var_0.origin, self.origin + (0, 20, 0));
  wait 0.2;
  magicbullet(var_1, var_0.origin, self.origin);
  wait 0.1;
  magicbullet(var_1, var_0.origin, self.origin + (0, 30, 0));
  wait 0.1;
  magicbullet(var_1, var_0.origin, self.origin + (0, 20, 0));
  wait 0.4;
  maps\_utility::die();
}

fire_fake_rpgs(var_0, var_1) {
  var_2 = min(var_0.size, var_1.size);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    magicbullet("rpg", var_0[var_3].origin, var_1[var_3].origin);
    wait(randomfloatrange(0.5, 1));
  }
}
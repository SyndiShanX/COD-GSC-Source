/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_strength_test.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_strength_test;
#include maps\_art;

set_strengthtest_difficulty(max_button_presses, fail_time) {
  self.strengthtest_max_button_presses = max_button_presses;
  self.strengthtest_fail_time = fail_time;
}

set_strength_test_audio(enemy_attack, fight_looping) {
  self.strengthtest_enemy_attack_audio = enemy_attack;
  self.strengthtest_fight_looping_audio = fight_looping;
}

strength_test_start(align_node_targetname, enemy_spawner_targetname, button_prompt_text) {
  self endon("death");

  if(!self flag_exists("start_strength_test")) {
    self ent_flag_init("start_strength_test");
    self ent_flag_init("strength_test_half_way");
    self ent_flag_init("strength_test_complete");
  }

  self ent_flag_clear("start_strength_test");
  self ent_flag_clear("strength_test_half_way");
  self ent_flag_clear("strength_test_complete");

  if(!isDefined(self.strengthtest_max_button_presses))
    self set_strengthtest_difficulty(15, 8);

  level thread maps\_strength_test::strength_test_update(self, button_prompt_text);
  align_node = getent(align_node_targetname, "targetname");
  self disableweapons();
  self hideviewmodel();
  self.body = spawn_anim_model("player_body");
  self playerlinktoabsolute(self.body, "tag_player");
  e_enemy = simple_spawn_single(enemy_spawner_targetname);
  e_enemy.diequietly = 1;
  e_enemy.animname = "e_strength_enemy";
  e_enemy.ignoreall = 1;
  e_enemy.ignoreme = 1;
  e_enemy magic_bullet_shield();

  if(isDefined(self.strengthtest_enemy_attack_audio))
    e_enemy playsound(self.strengthtest_enemy_attack_audio);

  self attacking_enemy_dof();
  actors = array(self.body, e_enemy);
  align_node anim_single_aligned(actors, "strength_test_start");
  self ent_flag_set("start_strength_test");
  align_node thread anim_loop_aligned(actors, "strength_test_loop");
  sound_org = spawn("script_origin", (0, 0, 0));

  if(isDefined(self.strengthtest_fight_looping_audio))
    sound_org playloopsound(self.strengthtest_fight_looping_audio);

  self ent_flag_wait("strength_test_complete");
  level clientnotify("vcd");
  self setblur(0, 0.5);
  sound_org stoploopsound(0.5);
  e_enemy stop_magic_bullet_shield();
  self thread punch_out_rumble();
  align_node anim_single_aligned(actors, "strength_test_success");
  self maps\_art::setdefaultdepthoffield();
  self unlink();
  self.body delete();
  self showviewmodel();
  self enableweapons();
  self setstance("stand");
}

strength_test_update(player, button_prompt_text) {
  player ent_flag_wait("start_strength_test");
  player endon("death");
  level endon("end");
  player thread strength_test_button_prompt(button_prompt_text);
  player.strengthtest_button_presses = 0;
  decay_rate = 0.2;
  button_state = 1;
  player thread strength_test_fighting_rumble();
  player thread strength_test_fail_timer();

  while(player.strengthtest_button_presses <= player.strengthtest_max_button_presses * 0.05) {
    if(!player ent_flag("strength_test_half_way") && player.strengthtest_button_presses >= player.strengthtest_max_button_presses * 0.05 * 0.5)
      player ent_flag_set("strength_test_half_way");

    if(player usebuttonpressed()) {
      if(button_state == 1 || button_state == 3)
        button_state = 2;
      else if(button_state == 2)
        button_state = 0;
    } else if(button_state == 0 || button_state == 2)
      button_state = 3;
    else if(button_state == 3)
      button_state = 1;

    if(button_state == 1)
      player.strengthtest_button_presses = player.strengthtest_button_presses - decay_rate * 0.05;

    if(button_state == 2)
      player.strengthtest_button_presses = player.strengthtest_button_presses + 1 / player.strengthtest_max_button_presses;

    if(player.strengthtest_button_presses <= 0)
      player.strengthtest_button_presses = 0;

    wait 0.05;
  }

  player ent_flag_set("strength_test_complete");
}

strength_test_fail_timer() {
  self endon("death");
  self endon("strength_test_complete");
  fail_time = self.strengthtest_fail_time;
  x = fail_time * 1.01;
  blur = 1;

  if(isDefined(self.strengthtest_blur) && self.strengthtest_blur == 0)
    blur = 0;

  while(true) {
    if(isgodmode(self))
      fail_time = 10;
    else {
      if(blur)
        self setblur(x - fail_time, 0.05);

      if(fail_time <= 0) {
        level notify("end");
        fail_time = 0;

        if(!isDefined(self.strengthtest_custom_fail)) {
          for(i = 0; i < 6; i++) {
            self playrumbleonentity("damage_heavy");
            wait 0.5;
          }

          level thread strength_test_screen_out("white", 0.25);
          wait 0.25;
          missionfailedwrapper();
        }

        break;
      }
    }

    wait 1;
    fail_time--;

    println("loiter_time " + fail_time);

  }
}

strength_test_fighting_rumble() {
  self endon("death");
  self endon("strength_test_complete");
  level endon("end");
  rumble_range = 0.5;
  self ent_flag_wait("start_strength_test");

  while(true) {
    if(self.strengthtest_button_presses >= 0 && self.strengthtest_button_presses <= 1) {
      if(self.strengthtest_button_presses >= 0 && self.strengthtest_button_presses < rumble_range) {
        self playrumbleonentity("damage_light");
        wait 0.22;
      }

      if(self.strengthtest_button_presses >= rumble_range && self.strengthtest_button_presses <= 1) {
        self playrumbleonentity("damage_heavy");
        wait 0.02;
      }
    }

    wait 0.05;
  }
}

punch_out_rumble() {
  self playrumbleonentity("damage_heavy");
  wait 1.3;
  self playrumbleonentity("damage_light");
  wait 2.5;
  self playrumbleonentity("grenade_rumble");
}

attacking_enemy_dof() {
  near_start = 0;
  near_end = 25;
  far_start = 558;
  far_end = 2575;
  near_blur = 4;
  far_blur = 0.5;
  self setdepthoffield(near_start, near_end, far_start, far_end, near_blur, far_blur);
}

strength_test_button_prompt(button_message) {
  level endon("end");
  screen_message_create(button_message);
  self ent_flag_wait("strength_test_complete");
  screen_message_delete();
}

strength_test_screen_out(shader, time) {
  if(!isDefined(shader))
    shader = "black";

  if(!isDefined(time))
    time = 2.0;

  if(isDefined(level.st_fade_screen))
    level.st_fade_screen destroy();

  level.st_fade_screen = newhudelem();
  level.st_fade_screen.x = 0;
  level.st_fade_screen.y = 0;
  level.st_fade_screen.horzalign = "fullscreen";
  level.st_fade_screen.vertalign = "fullscreen";
  level.st_fade_screen.foreground = 1;
  level.st_fade_screen setshader(shader, 640, 480);

  if(time == 0)
    level.st_fade_screen.alpha = 1;
  else {
    level.st_fade_screen.alpha = 0;
    level.st_fade_screen fadeovertime(time);
    level.st_fade_screen.alpha = 1;
    wait(time);
  }

  level notify("screen_fade_out_complete");
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\yemen.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_glasses;
#include clientscripts\_filter;
#include clientscripts\yemen_fx;
#include clientscripts\_load;
#include clientscripts\yemen_amb;
#include clientscripts\_audio;
#include clientscripts\_fire_direction;

main() {
  clientscripts\yemen_fx::main();
  clientscripts\_load::main();
  clientscripts\yemen_amb::snd_create_randoms();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\yemen_amb::main();
  thread clientscripts\_fire_direction::init();
  waitforclient(0);

  println("*** Client : yemen running...");

  thread speech_crowd_think();
  level.speech_crowd_delete = 0;
}

yemen_sonar_control() {
  level.localplayers[0] setsonarenabled(1);
  level.localplayers[0].sam_hud_damage_intensity = 0;
  init_filter_f35_damage(level.localplayers[0]);
  enable_filter_f35_damage(level.localplayers[0], 0);
  level waittill("yemen_disable_sonar");

  println("*** Client : Sonar off...");

  level.localplayers[0] setsonarenabled(0);
  disable_filter_f35_damage(level.localplayers[0], 0);
}

#using_animtree("fakeshooters");

speech_crowd_think() {
  level.crowd_models = array("c_mul_cordis_drone1_1_fb", "c_mul_cordis_drone1_2_fb", "c_mul_cordis_drone1_3_fb", "c_mul_cordis_drone1_4_fb", "c_mul_cordis_drone1_5_fb", "c_mul_cordis_drone2_1_fb", "c_mul_cordis_drone2_2_fb", "c_mul_cordis_drone2_3_fb", "c_mul_cordis_drone2_4_fb", "c_mul_cordis_drone2_5_fb", "c_mul_cordis_drone3_1_fb", "c_mul_cordis_drone3_2_fb", "c_mul_cordis_drone3_3_fb", "c_mul_cordis_drone3_4_fb", "c_mul_cordis_drone3_5_fb");
  level.crowd_models_close = array("c_mul_cordis_body3_1", "c_mul_cordis_body1_2", "c_mul_cordis_body1_3", "c_mul_cordis_body1_4", "c_mul_cordis_body2_1", "c_mul_cordis_body2_2", "c_mul_cordis_body2_3", "c_mul_cordis_body2_4");
  level.crowd_models_close_head = array("c_mul_cordis_head1_1", "c_mul_cordis_head1_2", "c_mul_cordis_head1_3", "c_mul_cordis_head1_4", "c_mul_cordis_head1_5", "c_mul_cordis_head2_1", "c_mul_cordis_head3_1", "c_mul_cordis_head4_1", "c_mul_cordis_head4_2", "c_mul_cordis_head4_3", "c_mul_cordis_head4_4", "c_mul_cordis_head4_5");
  level.crowd_anim["speech_crowd_door"][0] = % ch_yemen_01_04_menendez_intro_crowd_cheer_guy01;
  level.crowd_anim["speech_crowd_door"][1] = % ch_yemen_01_04_menendez_intro_crowd_cheer_guy02;
  level.crowd_anim["speech_crowd_idle"][0] = % ch_yemen_01_04_menendez_intro_crowd_idle_guy01;
  level.crowd_anim["speech_crowd_idle"][1] = % ch_yemen_01_04_menendez_intro_crowd_idle_guy02;
  level.crowd_anim["speech_crowd_cheer"][0] = % ch_yemen_01_04_menendez_intro_crowd_fistpump_guy01;
  level.crowd_anim["speech_crowd_cheer"][1] = % ch_yemen_01_04_menendez_intro_crowd_fistpump_guy02;
  level.crowd_anim["speech_crowd_runaway"][0] = % ch_yemen_01_04_menendez_intro_crowd_runaway_guy01;
  level.crowd_anim["speech_crowd_runaway"][1] = % ch_yemen_01_04_menendez_intro_crowd_runaway_guy02;
  level waittill("speech_spawn_crowd");
  level thread speech_crowd_spawn();
}

speech_crowd_spawn() {
  foreach(struct in getstructarray("speech_crowd_center", "targetname")) {
    m_drone = spawn(0, struct.origin, "script_model");
    m_drone.angles = struct.angles;
    m_drone setmodel(random(level.crowd_models));
    m_drone thread speech_crowd_animate_guy();
  }

  foreach(struct in getstructarray("speech_crowd_close", "targetname")) {
    m_drone = spawn(0, struct.origin, "script_model");
    m_drone.angles = struct.angles;
    m_drone setmodel(random(level.crowd_models_close));

    if(m_drone.model != "c_mul_cordis_body3_1")
      m_drone attach(random(level.crowd_models_close_head), "");

    m_drone thread speech_crowd_animate_guy();
  }

  wait 13;
  level notify("crowd_cheer_hush");
  wait 2;
  level notify("crowd_cheer_start");
}

speech_crowd_animate_guy() {
  self endon("entityshutdown");
  wait(randomfloat(2));
  self useanimtree(#animtree);
  self thread animate_drone("door");
  level waittill("crowd_cheer_hush");
  self thread animate_drone("idle");
  level waittill("crowd_cheer_start");
  s_crowd_center = getstruct("speech_crowd_cheer_center", "targetname");
  n_dist = distance2d(s_crowd_center.origin, self.origin);
  n_time = n_dist * 0.003;
  wait(n_time);
  self thread animate_drone("cheer", 0);

  while(level.speech_crowd_delete == 0)
    wait 0.05;

  wait 1;
  self delete();
}

speech_crowd_delete() {
  level.speech_crowd_delete = 1;
}

animate_drone(str_type, b_wait_for_loop) {
  self endon("entityshutdown");
  self endon("drone_death");
  self notify("animate_drone");
  self endon("animate_drone");
  n_blend = 0.9;

  if(isDefined(b_wait_for_loop) && b_wait_for_loop) {
    self waittillmatch("current_anim", "end");
    n_blend = 0;
  }

  anim_last = undefined;

  while(isDefined(self)) {
    anim_current = random(level.crowd_anim["speech_crowd_" + str_type]);

    if(!(!isDefined(anim_current) && !isDefined(anim_last) || isDefined(anim_current) && isDefined(anim_last) && anim_current == anim_last)) {
      anim_last = anim_current;
      n_length = getanimlength(anim_current);
      self clearanim( % root, n_blend);
      self setflaggedanim("current_anim", anim_current, 1, n_blend, 1);
      n_blend = 0;
    }

    self waittillmatch("current_anim", "end");
  }
}
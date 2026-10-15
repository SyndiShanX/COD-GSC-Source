/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_279f3c5ed514db22.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace namespace_1b106d35;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&_targetname);
  snd::trigger_init(&_trigger);
  snd::skipto_init(&_objective);
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  thread function_70bfbb49();
  level.player = snd::getplayerssafe()[0];
  thread function_b3665e44();
  thread function_96ace06();
  thread function_89309aa5();
  thread function_bd046ff2();
  thread function_7422beda();
}

function private _targetname(ent, name) {
  switch (name) {
    case #"audio_vehicle_drive_in_post_emp":
      level.var_77be18d2 = ent;
      thread function_d9013492(ent);
      ent waittill(#"death");
      level.var_77be18d2 = undefined;
      break;
    case #"audio_courtyard_fav_idle":
      level.var_77be18d2 = ent;
      level flag::set("flg_audio_fav_started");
      thread function_d9013492(ent);
      ent waittill(#"death");
      level.var_77be18d2 = undefined;
      break;
    case #"juggernaut_door_close":
      level.var_47acec0 = ent;
      thread juggernaut_door_close(ent);
      ent waittill(#"death");
      level.var_47acec0 = undefined;
      break;
    case #"juggernaut_door_open":
      level.var_47acec0 = ent;
      thread juggernaut_door_open(ent);
      ent waittill(#"death");
      level.var_47acec0 = undefined;
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69(name, "<dev string:x5d>"));

      break;
  }
}

function private _trigger(player, trigger, var_ec80d14b) {
  trigger_name = snd::function_ea2f17d1(var_ec80d14b.script_ambientroom, "$default");

  switch (trigger_name) {
    case #"hash_4f192f4756c79209":
    case #"$default":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>");

      break;
  }
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case #"audio_level_begin_duck_start":
      thread function_563a791();
      break;
    case #"audio_level_begin_duck_stop":
      thread function_1cfbed4a();
      break;
    case #"audio_intro_triton_disable":
      function_b6407dd4(0);
      break;
    case #"evt_emp_blast_screenshake":
      thread evt_emp_blast_screenshake();
      break;
    case #"evt_emp_blast_shockwave":
      thread evt_emp_blast_shockwave();
      break;
    case #"flg_audio_wall_crash":
      level notify(#"hash_201c2ab5508a84de");
      break;
    case #"audio_triton_enable_approach_end":
      function_b6407dd4(1);
      break;
    case #"audio_church_doors_kick_open":
      thread function_c2a390ee();
      break;
    case #"audio_catacombs_bomb_rumble":
      thread function_3e4f581();
      break;
    case #"audio_power_on":
      thread power_on();
      break;
    case #"audio_graveyard_fire_start":
      thread function_e45db9b2();
      break;
    case #"audio_table_flip":
      thread function_c40d0905();
      break;
    case #"ending_fade_out":
      addsubmix("cp_mute_amb", 3);
      addsubmix("cp_mute_player", 3);
      break;
    case #"end_montage":
      addsubmix("cp_mute_amb", 0);
      addsubmix("cp_mute_fly", 0);
      addsubmix("cp_mute_player", 0);
      break;
    case #"end_montage_end":
      break;
    case #"loose_ends_start":

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x86>");

      function_b6407dd4(0);
      addsubmix("cp_mute_amb", 0);
      addsubmix("cp_mute_fly", 0);
      addsubmix("cp_mute_player", 0);
      waitframe(3);
      clearsubmix("cp_mute_amb", 6);
      clearsubmix("cp_mute_fly", 6);
      clearsubmix("cp_mute_player", 6);
      wait 50;
      addsubmix("cp_rus_siege_loose_end", 3, 0.69);
      wait 3;
      blendsubmix("cp_rus_siege_loose_end", 2, 0.99);
      wait 2;
      blendsubmix("cp_rus_siege_loose_end", 0.8, 1);
      wait 0.8;
      break;
    case #"loose_ends_slow":

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x9c>");

      break;
    case #"loose_ends_cando":

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xaf>");

      break;
    case #"loose_ends_fire":
      snd::play("wpn_loose_ends_pistol_fire");
      snd::play("evt_xfx_drone_hit_heartbeat");

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xc3>");

      wait 0.1;
      blendsubmix("cp_rus_siege_loose_end", 0, 1);
      addsubmix("cp_mute_amb", 0.1);
      break;
    case #"musictrack_cp_siege_1":
    case #"musictrack_cp_siege_2":
      function_2cca7b47(0, msg);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xd7>" + snd::function_783b69(msg, "<dev string:x5d>"));

      break;
  }
}

function private _objective(objective) {
  switch (objective) {
    case #"infil":
      break;
    case #"emp_flash":
      break;
    case #"Courtyard":
      break;
    case #"catacombs":
      break;
    case #"graveyard":
      break;
    case #"outtro":
      break;
    case #"looseends":
      break;
    case #"no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xf5>" + objective + "<dev string:x5d>");

      break;
  }
}

function function_befba10a() {
  plr = undefined;
  var_58602358 = [["tmp_animal_bird", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_animal_dog_angry_bark", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_animal_donkey", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_animal_horse", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_animal_rat", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_animal_seagulls", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_animal_wolf_howls", plr, [3, 12], [1200, 1800], [-90, 90]]];
  snd::element_init("$default", var_58602358);
  interior = [["tmp_env_cave_int_single_drips", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_dust", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_glass", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_glass_metal_lrg", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_glass_metal_sml", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_metal_lrg", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_metal_med", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_metal_sml", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_rocks_lrg", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_rocks_med", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_rocks_sml", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_wood_med", plr, [3, 12], [1200, 1800], [-90, 90]], ["tmp_debris_wood_sml", plr, [3, 12], [1200, 1800], [-90, 90]]];
  snd::element_init("interior", interior);
  snd::element_init("interior_cave", "interior");
}

function function_b3665e44() {
  level waittill(#"hash_5c0e295bf1c8ee37");
  thread function_5271e091();
  thread function_34a0b2c1();
}

function function_96ace06() {
  level waittill(#"hash_73c8edce39fa397a");
  thread function_5271e091();
  thread function_34a0b2c1();
}

function function_563a791() {
  addsubmix("cp_rus_siege_level_begin");
}

function function_1cfbed4a() {
  clearsubmix("cp_rus_siege_level_begin");
}

function function_34a0b2c1() {
  addsubmix("cp_rus_siege_intro_ride_scene");
  level waittill(#"hash_7544c8e6cd7cd946");
  clearsubmix("cp_rus_siege_intro_ride_scene");
}

function function_5271e091() {
  if(level flag::get("flg_audio_fav_started") == 1) {
    return;
  }

  level flag::set("flg_audio_fav_started");
  level.var_456dc77d = snd::play([0, "veh_intro_scripted_drive_lp_lr", 1]);
  level.var_9b00aa65 = snd::play([0, "veh_intro_scripted_drive_lp_lsrs", 1]);
  level waittill(#"audio_stop_player_fav");
  wait 1;
  snd::stop(level.var_456dc77d, 0.5);
  snd::stop(level.var_9b00aa65, 0.5);
  var_d5a0eda4 = snd::play(["veh_intro_scripted_drive_end_lr", 0.35]);
}

function function_3e460f0a() {
  level waittill(#"hash_5c0e295bf1c8ee37");
  snd::play("amb_aa_gun_distant_fire_lr");
}

function function_d9013492(ent) {
  level waittill(#"hash_7544c8e6cd7cd946");

  if(level flag::get("flg_audio_fav_idle") == 1) {
    return;
  }

  level flag::set("flg_audio_fav_idle");
  var_ab2f53c3 = snd::play([0.5, "veh_intro_scripted_idle_lp_lr", 2.5], ent);
  thread function_f82d04fd();
}

function function_f82d04fd() {
  var_ccffb456 = [(7385, -3554, 176), (7588, -3548, 176), (7794, -3683, 183), (8013, -3514, 200), (7964, -3029, 182), (7779, -2814, 188)];
  var_ccffb456 = snd::play("veh_intro_scripted_npc_idle_lp", var_ccffb456);
}

function evt_emp_blast_screenshake() {
  snd::play("evt_emp_blast_screenshake_lr");
}

function evt_emp_blast_shockwave() {
  snd::play("evt_emp_blast_shockwave_lr");
  wait 0.75;
  addsubmix("cp_rus_siege_emp_pre_blast");
  wait 3;
  clearsubmix("cp_rus_siege_emp_pre_blast");
}

function function_70bfbb49() {}

function function_c2a390ee() {
  snd::play("evt_church_door_kick_open", (10655, -4868, 262));
}

function function_3e4f581() {
  snd::play("evt_catacombs_distant_bomb_explo");
}

function juggernaut_door_close(ent) {
  snd::play("evt_juggernaut_door_close", ent);
}

function juggernaut_door_open(ent) {
  snd::play("evt_juggernaut_door_open", ent);
}

function power_on() {
  snd::play("evt_power_on");
}

function function_e45db9b2() {
  if(level flag::get("flg_audio_graveyard_fire") == 1) {
    return;
  }

  level flag::set("flg_audio_graveyard_fire");
  snd::play("emt_fire_lrg_lp_no_occ", (10197, -5638, 269));
}

function function_c40d0905() {
  snd::play("evt_graveyard_table_flip", (10197, -5638, 269));
}

function function_89309aa5() {
  level waittill(#"hash_675d0ece373dc0bb");
  addsubmix("cp_rus_siege_outro_aa_gun_mute", 0.5);
}

function function_7422beda() {
  level waittill(#"hash_411156e5e0cb50a2");
  addsubmix("cp_rus_siege_sparks_outro", 0.5);
  level waittill(#"hash_98e94d5912d24a2");
  clearsubmix("cp_rus_siege_sparks_outro", 0.5);
}

function function_bd046ff2() {
  level waittill(#"hash_79f8bc047471afe3");
  addsubmix("cp_rus_siege_outro_metal", 0.5);
  snd::play("emt_fire_med_lp_outro", (12673, -34914, 585));
  snd::play("emt_fire_lrg_lp_no_occ_outro", (1237, -34850, 574));
  snd::play("emt_fire_med_lp_outro", (12693, -34714, 588));
  level waittill(#"hash_6a754a8a4f26d111");
  clearsubmix("cp_rus_siege_outro_metal", 0.5);
}
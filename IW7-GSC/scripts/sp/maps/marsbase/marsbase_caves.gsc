/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_caves.gsc
*******************************************************/

_id_10C68() {
  var_0 = ["salter", "gator", "griff", "ethan", "brooks"];
  var_1 = scripts\sp\maps\marsbase\marsbase_code::_id_77E6("group_ally_dropship3_marines");
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(scripts\sp\maps\marsbase\marsbase_util::_id_2281([var_0, var_1]), "ally_start_gh_infil");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_gh_infil", "targetname"));
  thread _id_856B();
  var_2 = scripts\sp\maps\marsbase\marsbase_util::_id_B3AA("dropship3_destroyed");
  var_3 = scripts\engine\utility::getStruct("s_dropship3_crash_pos", "targetname");
  var_2.origin = var_3.origin;
  var_2.angles = var_3.angles;
  playFX(level._effect["vfx_bombardment_strike_explosion"], var_2.origin);
  playFX(level._effect["vfx_pcr_lingering_smoke_rise"], var_2.origin);
  thread scripts\sp\maps\marsbase\marsbase_greenhouse::_id_8AEA("burning_man_done");
  scripts\sp\utility::_id_15F5("orbit_a2");
  level notify("loot_crate_aa1_cleanup");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa1_complete");
  thread scripts\sp\maps\marsbase\marsbase_intro::_id_4058();
}

_id_B1ED() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  level._id_EA2C scripts\sp\utility::_id_72EC("iw7_m4", "primary");
  level._id_EA2C scripts\sp\utility::_id_F415(1);
  var_0 = getEnt("mdl_gatordoor_closed_clip", "targetname");
  var_0 connectpaths();
  scripts\sp\maps\marsbase\marsbase_greenhouse::_id_855F();
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_53FA();
  level thread _id_6972();
  level thread _id_6974();
  level thread _id_6971();
  scripts\engine\utility::array_thread([level._id_6754, level._id_EA2C], scripts\sp\utility::_id_F3B5, "r");
  scripts\engine\utility::array_thread([level._id_76FB, level._id_8604], scripts\sp\utility::_id_F3B5, "y");
  scripts\engine\utility::array_thread(scripts\sp\utility::_id_77DA("group_ally_dropship3_marines"), scripts\sp\utility::_id_F3B5, "p");
  var_1 = getEnt("trig_exitdoor", "targetname");
  var_1 scripts\sp\utility::_id_13635(10);
  scripts\sp\utility::_id_2669("Greenhouse Exit");
  level thread _id_683C();
  scripts\sp\utility::_id_15F5("trig_greenhouse_infil_allies_1");
  scripts\sp\utility::_id_15F5("trig_gha_dropship3");
  scripts\engine\utility::flag_set("flag_greenhouse_approach_end");
  thread _id_6845();
  thread _id_696E();
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AA("fxanim_sp_mars_crane");
  level._id_8569 _id_0B1F::_id_168A([level._id_76FB, level._id_EA2C]);
  thread greenhouse_door_anim_done_think();
  level notify("exitdoor_opened");
  level._id_EA2C allowedstances("stand", "crouch", "prone");
  scripts\sp\utility::_id_15F5("trig_ghexit_allies_2");
  thread _id_6968();
  scripts\engine\utility::flag_set("exitdoor_boss_dropship_started");
  level notify("boss_dropship_gunner_go");
  level thread _id_14AE();
  level waittill("exitdoor_boss_dropship_exited");
  scripts\engine\utility::flag_wait("gator_death_end");

  if(!level.console) {
    waitfortransient("marsbase_combat_meatgrinder_tr");
  }

  scripts\engine\utility::array_thread(level._id_1684, scripts\sp\utility::_id_F3B5, "r");
  var_2 = scripts\engine\utility::getStruct("s_exitdoor_ref", "targetname");
  var_2 notify("stop_loop");
  wait 0.5;
  scripts\sp\utility::_id_15F5("trig_aa2_allies_1");
  scripts\engine\utility::flag_set("flag_greenhouse_exit_end");
  level notify("greenhouse_enter_done");
  scripts\sp\utility::_id_10FEC("vfx_exp_greenhouse_front");
  scripts\sp\utility::_id_10FEC("vfx_exp_greenhouse_middle");
  scripts\sp\utility::_id_10FEC("vfx_exp_greenhouse_back");
  level._id_EA2C scripts\sp\utility::_id_F415(0);
  wait 2.0;
  scripts\engine\utility::flag_clear("gator_death_start");
}

_id_8567() {
  scripts\engine\utility::flag_set("player_and_heroes_in_aa2");
  scripts\engine\utility::flag_set("flag_greenhouse_exit_end");
}

greenhouse_door_anim_done_think() {
  level waittill("buddydoor_actors_outro_done");
  scripts\engine\utility::flag_set("gator_death_end");
}

_id_696E() {
  var_0 = 2;
  var_1 = 3;
  var_2 = ["vfx_mars_electric_explosion_sparks", "vfx_mars_sparks_burst_runner", "vfx_mars_sparks_burst_child", "vfx_mars_electric_explosion_sparks"];
  var_3 = scripts\engine\utility::getStructArray("s_exitdoor_glitch_fx", "targetname");
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_4[var_5] = ::scripts\engine\utility::spawn_tag_origin(var_3[var_5].origin, var_3[var_5].angles);
  }

  var_6 = undefined;
  var_7 = undefined;

  while(!scripts\engine\utility::flag("exitdoor_boss_dropship_started")) {
    var_8 = randomintrange(1, 3);

    for(var_5 = 1; var_5 <= var_8; var_5++) {
      scripts\engine\utility::random(var_4) thread _id_696F(scripts\engine\utility::random(var_2));
      wait(randomfloatrange(0.1, 0.3));
    }

    wait(randomfloatrange(2.0, 3.0));
  }

  scripts\sp\utility::_id_228A(var_4);
}

_id_696F(var_0) {
  self endon("death");

  if(isDefined(self._id_9B4F)) {
    return;
  }
  self._id_9B4F = 1;
  playFXOnTag(scripts\engine\utility::getfx(var_0), self, "tag_origin");
  wait(randomfloatrange(1.0, 2.0));
  stopFXOnTag(scripts\engine\utility::getfx(var_0), self, "tag_origin");
  self._id_9B4F = undefined;
}

_id_683C() {
  var_0 = 15;
  var_1 = 0;
  var_2 = undefined;
  var_3 = getEntArray("generic_door", "script_noteworthy");

  foreach(var_5 in var_3) {
    if(isDefined(var_5.model) && var_5.model == "door_bulkhead_double_01") {
      var_2 = var_5;
      break;
    }
  }

  wait 3.0;
  level.cansave = 0;

  while(!scripts\engine\utility::flag("flag_greenhouse_exit_end")) {
    level notify("nag_player_open_exitdoor_" + var_1);
    _id_5782(var_1, var_2);

    if(scripts\engine\utility::flag("exitdoor_boss_dropship_started")) {
      var_0 = 5;
    }

    wait(var_0);

    if(!scripts\engine\utility::is_true(level.player._id_2704)) {
      if(var_1 < 3) {
        var_1++;
      }
    }
  }

  var_7 = scripts\sp\utility::_id_8200("veh_enemy_jackal_exitdoor_00", "targetname");
  var_7 delete();
  var_8 = scripts\sp\utility::_id_8200("veh_enemy_jackal_exitdoor_01", "targetname");
  var_8 delete();
  level.cansave = 1;
}

_id_5782(var_0, var_1) {
  var_2 = ["spl_enemy_jackal_exitdoor_strafe_a_0", "spl_enemy_jackal_exitdoor_strafe_b_0", "spl_enemy_jackal_exitdoor_strafe_c_0", "spl_enemy_jackal_exitdoor_strafe_d_0"];
  var_3 = ["trig_exitdoor_jackal_explosions_a", "trig_exitdoor_jackal_explosions_b", "trig_exitdoor_jackal_explosions_c", "trig_exitdoor_jackal_explosions_d"];
  var_4 = ["s_exitdoor_explosion_a", "s_exitdoor_explosion_b", "s_exitdoor_explosion_c", "s_exitdoor_explosion_d"];
  var_5 = var_2[var_0];
  var_6 = "veh_enemy_jackal_exitdoor_0";
  var_7 = var_3[var_0];
  var_8 = var_4[var_0];
  var_9 = 2;

  for(var_10 = 0; var_10 < var_9; var_10++) {
    var_11 = var_5 + var_10;
    var_12 = var_6 + var_10;
    level thread scripts\sp\maps\marsbase\marsbase_util::_id_A1CA(var_12, var_11, 129, 10);
    var_13 = var_0 == 3 && !scripts\engine\utility::flag("exitdoor_boss_dropship_started");
    var_1 thread _id_6970(var_12, var_7, var_8, var_13);
    wait(randomfloatrange(0.05, 0.15));
  }
}

_id_6970(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["s_exitdoor_explosion_a"] = "vfx_exp_greenhouse_front";
  var_4["s_exitdoor_explosion_b"] = "vfx_exp_greenhouse_middle";
  var_4["s_exitdoor_explosion_c"] = "vfx_exp_greenhouse_back";
  var_4["s_exitdoor_explosion_d"] = "vfx_exp_greenhouse_back";
  var_5 = getEnt(var_1, "targetname");
  var_6 = scripts\sp\utility::_id_7D40(var_0, "targetname");

  if(isDefined(var_5) && isDefined(var_6)) {
    while(!var_6 istouching(var_5)) {
      scripts\engine\utility::waitframe();
    }

    var_7 = scripts\engine\utility::getStructArray(var_2, "targetname");
    var_7 = scripts\engine\utility::array_randomize(var_7);

    foreach(var_9 in var_7) {
      if(scripts\engine\utility::is_true(var_3) && scripts\engine\utility::cointoss()) {
        var_6 thread _id_0B76::_id_1992("tag_origin", level.player, 1);
      } else {
        var_6 thread _id_0B76::_id_1992("tag_origin", var_9, 1);
      }

      var_6 thread _id_5783(var_9.origin, var_9.radius);
      wait 0.38;
    }

    if(!isDefined(level._id_1499) || !scripts\engine\utility::is_true(level._id_1499[var_2])) {
      scripts\engine\utility::exploder(var_4[var_2]);

      if(!isDefined(level._id_1499)) {
        level._id_1499 = [];
      }

      level._id_1499[var_2] = 1;
      var_11 = 0;
      var_12 = 0;
      var_13 = 0;
      var_14 = var_7.size;

      foreach(var_9 in var_7) {
        var_16 = var_9.origin;
        var_11 = var_11 + var_16[0];
        var_12 = var_12 + var_16[1];
        var_13 = var_13 + var_16[2];
      }

      var_11 = var_11 / var_14;
      var_12 = var_12 / var_14;
      var_13 = var_13 / var_14;
      var_18 = (var_11, var_12, var_13);
      var_19 = scripts\engine\utility::spawn_tag_origin(var_18);
      var_19.targetname = "strafe_fire_tag_origin";
      var_19 thread scripts\sp\utility::play_loop_sound_on_tag("emt_fire_large_lp_01", "tag_origin");
    }

    if(scripts\engine\utility::is_true(var_3)) {
      radiusdamage(level.player.origin, 500, 500, 250, self, "MOD_EXPLOSIVE");
    }
  }
}

_id_5783(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 256;
  }

  var_2 = 1000;
  var_3 = 500;
  playFX(scripts\engine\utility::getfx("mars_killstreak_missile_expl"), var_0, anglesToForward((0, randomfloat(360), 0)), (0, 0, 1));
  playworldsound("rocket_explode_energy", var_0);
  scripts\sp\utility::_id_5FC7(var_0);
  radiusdamage(var_0, var_1, var_2, var_3, self, "MOD_EXPLOSIVE");
}

_id_67E6() {
  var_0 = 8;
  var_1 = 19;
  var_2 = 3;

  while(!scripts\engine\utility::flag("flag_burning_man_scene_start")) {
    _id_5765(randomint(var_2 - 1));
    wait(randomfloatrange(var_0, var_1));
  }

  var_3 = scripts\sp\utility::_id_8200("veh_enemy_jackal_aa2_strafe_00", "targetname");
  var_3 delete();
  var_4 = scripts\sp\utility::_id_8200("veh_enemy_jackal_aa2_strafe_01", "targetname");
  var_4 delete();
}

_id_5765(var_0) {
  var_1 = ["spl_enemy_jackal_aa2_strafe_a_0", "spl_enemy_jackal_aa2_strafe_b_0", "spl_enemy_jackal_aa2_strafe_c_0"];
  var_2 = ["trig_aa2_jackal_explosions_a", "trig_aa2_jackal_explosions_a", "trig_aa2_jackal_explosions_a"];
  var_3 = ["s_aa2_end_explosion_a", "s_aa2_end_explosion_a", "s_aa2_end_explosion_a"];
  var_4 = var_1[var_0];
  var_5 = "veh_enemy_jackal_aa2_strafe_0";
  var_6 = var_2[var_0];
  var_7 = var_3[var_0];
  var_8 = 2;

  for(var_9 = 0; var_9 < var_8; var_9++) {
    var_10 = var_4 + var_9;
    var_11 = var_5 + var_9;
    level thread scripts\sp\maps\marsbase\marsbase_util::_id_A1CA(var_11, var_10, 129, 8);

    if(scripts\engine\utility::flag("flag_burning_man_cave_approach_reached")) {
      level thread _id_14CA(var_11, var_6, var_7, 0);
    }

    wait(randomfloatrange(0.05, 0.15));
  }
}

_id_14CA(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_1, "targetname");
  var_5 = scripts\sp\utility::_id_7D40(var_0, "targetname");
  var_5 endon("death");
  var_5 setneargoalnotifydist(16);

  if(isDefined(var_4) && isDefined(var_5)) {
    while(!var_5 istouching(var_4)) {
      scripts\engine\utility::waitframe();
    }

    var_6 = scripts\engine\utility::getStructArray(var_2, "targetname");
    var_6 = scripts\engine\utility::array_randomize(var_6);

    foreach(var_8 in var_6) {
      if(scripts\engine\utility::is_true(var_3) && scripts\engine\utility::cointoss()) {
        var_5 thread _id_0B76::_id_1992("tag_origin", level.player, 1);
      } else {
        var_5 thread _id_0B76::_id_1992("tag_origin", var_8, 1);
      }

      var_5 thread _id_5766(var_8.origin, var_8.radius);
      wait 0.38;
    }

    if(scripts\engine\utility::is_true(var_3)) {
      radiusdamage(level.player.origin, 500, 500, 250, self, "MOD_EXPLOSIVE");
    }
  }
}

_id_5766(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 256;
  }

  var_2 = 1000;
  var_3 = 500;
  playFX(scripts\engine\utility::getfx("mars_killstreak_missile_expl"), var_0, anglesToForward((0, randomfloat(360), 0)), (0, 0, 1));
  playworldsound("rocket_explode_energy", var_0);
  scripts\sp\utility::_id_5FC7(var_0);
  radiusdamage(var_0, var_1, var_2, var_3, self, "MOD_EXPLOSIVE");
}

_id_856B() {
  scripts\engine\utility::flag_wait("flag_greenhouse_approach_end");
  level._id_8569 scripts\sp\utility::_id_65E1("flag_greenhouse_unlock_door");
  level waittill("exitdoor_opened");
  level notify("exitdoor_open_enabled");
  scripts\engine\utility::flag_set("gator_death_start");
  scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_12641, "marsbase_combat_meatgrinder_tr");
  scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_12641, "marsbase_vista_train_station_tr");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_B3AB("aa2_destruction");
  thread _id_14D3();
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_2");
  thread _id_14AD();
}

_id_6974() {
  var_0 = ["vfx_mars_electric_explosion_sparks", "vfx_mars_sparks_burst_child"];
  var_1 = scripts\engine\utility::getStruct("s_exitdoor_pull_fx", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);

  while(!scripts\engine\utility::flag("exitdoor_boss_dropship_started")) {
    level waittill("buddydoor_pry_open_start");
    playFXOnTag(scripts\engine\utility::getfx(var_0[1]), var_2, "tag_origin");
    wait 0.1;
    earthquake(0.35, 1.4, level._id_76FB.origin, 500);
  }

  var_2 delete();
}

_id_6971() {
  level endon("exitdoor_boss_dropship_exited");
  var_0 = spawn("script_origin", level.player.origin);
  var_0 thread _id_6973();

  for(;;) {
    level waittill("buddydoor_pry_open_start");
    var_0 playLoopSound("gator_door_servo_loop");
    level scripts\engine\utility::waittill_either("buddydoor_pry_open_failed", "buddydoor_pry_open_success");
    var_0 stoploopsound();
  }
}

_id_6973() {
  level waittill("exitdoor_boss_dropship_exited");
  self delete();
}

_id_6972() {
  scripts\engine\utility::flag_wait("flag_greenhouse_approach_end");
  var_0 = level._id_EA2C._id_1FBB + "_door_sequence_complete";

  if(!level._id_EA2C scripts\engine\utility::flag_exist(var_0)) {
    level._id_EA2C scripts\engine\utility::flag_init(var_0);
  }

  var_1 = getEntArray("generic_door", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("s_exitdoor_ref", "targetname");
  scripts\engine\utility::flag_init("salter_exitdoor_react_played");

  if(isDefined(var_2)) {
    var_2 thread _id_EA69();
    var_2 thread _id_EA6B();
    var_2 thread _id_EA6A();
    var_2 _id_EA6C();
    level waittill("exitdoor_boss_dropship_exited");
    wait 1;
    var_2 notify("stop_loop");
    level._id_EA2C notify("stop_loop");
    level._id_EA2C _meth_83A1();
  }
}

_id_EA69() {
  level endon("exitdoor_open_enabled");
  level endon("buddydoor_player_pry_open");
  level._id_EA2C allowedstances("stand");
  scripts\sp\anim::_id_1F1B([level._id_EA2C], "exitdoor_intro", undefined, "salter", scripts\sp\anim::_id_DD14, scripts\sp\anim::_id_DD15, "Exposed");
  scripts\sp\anim::_id_1F35(level._id_EA2C, "exitdoor_intro");
  thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "exitdoor_idle");
  wait 1;
  _id_EA68();
}

_id_EA6B() {
  level endon("buddydoor_player_pry_open");
  level waittill("exitdoor_open_enabled");
  wait 0.25;
  _id_EA68();
}

_id_EA68() {
  if(!scripts\engine\utility::flag("salter_exitdoor_react_played")) {
    scripts\engine\utility::flag_set("salter_exitdoor_react_played");
    self notify("stop_loop");
    scripts\sp\anim::_id_1F35(level._id_EA2C, "exitdoor_react_intro");
    thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "exitdoor_react_idle");
  }
}

_id_EA6C() {
  level endon("buddydoor_player_outro");
  level endon("greenhouse_enter_done");

  for(;;) {
    level waittill("buddydoor_player_pry_open");
    _id_EA68();
    self notify("stop_loop");
    scripts\sp\anim::_id_1F35(level._id_EA2C, "exitdoor_react_to_pull");
    thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "exitdoor_pull");
  }
}

_id_EA6A() {
  level endon("greenhouse_enter_done");
  level waittill("buddydoor_actors_outro_done");

  if(!scripts\engine\utility::flag("flag_greenhouse_exit_end")) {
    self notify("stop_loop");
    scripts\sp\anim::_id_1EEA(level._id_EA2C, "exitdoor_outro_idle");
  }
}

_id_6845() {
  level._id_8569 waittill("buddydoor_outro");
  thread _id_7700();
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_541B();
  level.player playSound("mars_base_gator_shotup");
  wait 1.5;
  level._id_76FB thread _id_76FF();
  setmusicstate("gator_sacrifice");
  wait 1.5;
  level._id_8569.collision connectpaths();
  level._id_8569.collision delete();
  level._id_76FB.a.nodeath = 1;
  level._id_76FB scripts\sp\maps\marsbase\marsbase_util::_id_4046(1, level._id_2CDF.origin);

  foreach(var_1 in scripts\sp\utility::_id_77DA("group_ally_dropship2_engineers")) {
    var_1 scripts\sp\maps\marsbase\marsbase_util::_id_4046(1, level._id_2CDF.origin);
  }

  foreach(var_1 in scripts\sp\utility::_id_77DA("group_ally_dropship3_marines")) {
    var_1 scripts\sp\maps\marsbase\marsbase_util::_id_4046(1, level._id_2CDF.origin);
  }
}

_id_76FF() {
  wait 2.2;
  level._id_76FB thread _id_76FC();
  thread _id_76FD();
  wait 5;
  level notify("gator_smear_stop");
}

_id_76FC() {
  scripts\sp\utility::_id_10FEC("vfx_exp_greenhouse_front");
  scripts\sp\utility::_id_10FEC("vfx_exp_greenhouse_middle");
  scripts\sp\utility::_id_10FEC("vfx_exp_greenhouse_back");
  var_0 = getEntArray("strafe_fire_tag_origin", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      var_2 delete();
    }
  }

  var_4 = ["j_spineupper", "j_spinelower", "j_neck", "j_shoulder_le", "j_shoulder_ri", "j_spineupper", "j_spinelower", "j_neck", "j_shoulder_le", "j_shoulder_ri"];
  var_5 = 0;
  var_6 = scripts\engine\utility::getStruct("s_gator_squib_magicbullet_start", "targetname");
  var_7 = var_6.origin;
  var_8 = 5;

  for(var_9 = 0; var_9 < var_8; var_9++) {
    var_5 = randomint(var_4.size - 1);
    var_10 = var_4[var_9];
    var_11 = self gettagorigin(var_10);
    var_12 = self gettagangles(var_10);
    var_13 = var_11 - anglestoup(var_12) * 100;
    var_14 = var_11 + anglestoup(var_12) * 20;
    var_15 = var_7 - var_11;
    var_16 = -1 * var_12;
    wait 0.1;
    playFX(level._effect["vfx_mars_blood_spurt_tracer_gator"], var_11, var_15);
    wait 0.1;
    playFX(level._effect["deathfx_bloodpool_generic"], var_14, var_16);
    self playSound("gator_death_blood_squib");
  }
}

_id_7701() {
  wait 0.5;
  scripts\engine\utility::exploder("vfx_exp_gator_squibs");
  level waittill("gator_slowmo_done");
  scripts\sp\utility::_id_10FEC("vfx_exp_gator_squibs");
}

_id_76FD() {
  level endon("gator_smear_stop");
  self endon("death");
  var_0 = "J_SpineLower";
  var_1 = "tag_origin";
  var_2 = 0.1;
  var_3 = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a._id_486A)) {
    var_2 = self.a._id_486A;
  }

  if(isDefined(self.a._id_4869)) {
    var_3 = level._effect[self.a._id_4869];
  }

  while(var_2) {
    var_4 = self gettagorigin(var_0);
    var_5 = self gettagangles(var_1);
    var_6 = anglestoright(var_5);
    var_7 = anglesToForward((270, 0, 0));
    playFX(var_3, var_4, var_7, var_6);
    wait(var_2);
  }
}

_id_7700() {
  var_0 = spawn("script_origin", level.player.origin);
  var_1 = spawn("script_origin", level.player.origin);
  wait 3.75;
  _id_0B0B::_id_F5A0();
  setslowmotion(1, 0.19, 0.25);
  level thread _id_7717();
  var_0 playSound("gator_death_slowmo_in_f");
  wait 0.65;
  setslowmotion(0.19, 1, 1);
  var_1 playSound("gator_death_slowmo_out_f");
  var_0 stopsounds();
  _id_0B0B::_id_F59F();
  level notify("gator_slowmo_done");
  level waittill("boss_dropship_gunner_killed_by_player");
  var_1 delete();
  var_0 delete();
}

_id_7717() {
  level.player setsoundsubmix("mars_gator_death");
  soundsettimescalefactor("vehicle_air_flyby_close_3d_lim", 0.5);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0.5);
  soundsettimescalefactor("weap_npc_main_3d", 0.5);
  soundsettimescalefactor("weap_npc_main_3d", 0.5);
  soundsettimescalefactor("weap_npc_mech_3d", 0.5);
  soundsettimescalefactor("weap_npc_mid_3d", 0.5);
  soundsettimescalefactor("weap_npc_lfe_3d", 0.5);
  soundsettimescalefactor("weap_npc_dist_3d", 0.5);
  soundsettimescalefactor("weap_npc_lo_3d", 0.5);
  soundsettimescalefactor("melee_npc_3d", 0.5);
  soundsettimescalefactor("scn_fx_special_unres_3d", 0.4);
  soundsettimescalefactor("amb_bed_2d", 0.5);
  soundsettimescalefactor("amb_elm_int_unres_3d", 0.5);
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0.5);
  soundsettimescalefactor("whizby_out_unres_3d_lim", 0.5);
  level waittill("gator_slowmo_done");
  soundsettimescalefactor("vehicle_air_flyby_close_3d_lim", 0);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0);
  soundsettimescalefactor("weap_npc_main_3d", 0);
  soundsettimescalefactor("weap_npc_main_3d", 0);
  soundsettimescalefactor("weap_npc_mech_3d", 0);
  soundsettimescalefactor("weap_npc_mid_3d", 0);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0);
  soundsettimescalefactor("weap_npc_lo_3d", 0);
  soundsettimescalefactor("melee_npc_3d", 0);
  soundsettimescalefactor("scn_fx_special_unres_3d", 0);
  soundsettimescalefactor("amb_bed_2d", 0);
  soundsettimescalefactor("amb_elm_int_unres_3d", 0);
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0);
  soundsettimescalefactor("whizby_out_unres_3d_lim", 0);
  wait 0.3;
  level.player clearsoundsubmix();
}

_id_6968() {
  var_0 = [];
  var_0["veh_spawner"] = "veh_enemy_boss_dropship_aa2";
  var_0["turret"] = "hill_enemy_mg_dropship_mg";
  var_0["light"] = "hill_enemy_mg_dropship_light";
  var_1 = [];
  var_1["shootat_target"] = ::scripts\engine\utility::getStruct("s_shootgator_bullet_trail_end", "targetname");
  var_1["n_deviate_x"] = 0.05;
  var_1["n_deviate_y"] = 0.05;
  var_1["num_bursts_min"] = 119;
  var_1["num_bursts_max"] = 120;
  var_1["rest_time_min"] = 0.25;
  var_1["rest_time_max"] = 0.3;
  var_1["stop_shooting_on_exit"] = 1;
  var_1["func_turret_aim"] = ::_id_696D;
  var_2 = [];
  var_2["start"] = "struct_boss_dropship_enter_00";
  var_2["exit"] = "struct_boss_dropship_exit";
  var_2["func_shoot"] = ::_id_696B;
  var_2["func_exit"] = ::_id_696A;
  var_2["exit_notify"] = "exitdoor_boss_dropship_exited";
  level thread _id_696C();
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
  level notify("exitdoor_boss_dropship_done");
}

_id_696C() {
  level endon("aa2_finished");
  level waittill("boss_dropship_gunner_killed_by_player");
  level._id_270D = 1;
}

_id_696B(var_0) {
  thread _id_0BBD::_id_5DB9("right");
  wait 0.125;
  level notify("exitdoor_dropship_start_shooting");
  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
  thread _id_7701();
  wait 5;
  var_1 = scripts\engine\utility::getStruct("struct_ghexit_murdertarget", "targetname");

  if(!isDefined(var_1)) {
    var_1 = level._id_76FB;
  }

  var_0["shootat_target"] = var_1;
  var_0["n_deviate_x"] = 10;
  var_0["n_deviate_y"] = 10;
  var_0["num_bursts_min"] = 15;
  var_0["num_bursts_max"] = 19;
  var_0["rest_time_min"] = 2;
  var_0["rest_time_max"] = 3;
  var_0["func_turret_aim"] = undefined;
  self.turret notify("stop_fire");
  wait 1;
  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_696A() {
  self endon("death");
  scripts\sp\utility::_id_16B7(::_id_6969);
  self.gunner scripts\sp\utility::_id_16B7(::_id_6969);

  if(isDefined(self.gunner) && isalive(self.gunner)) {
    scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "shot_by_player");
    self.gunner scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "shot_by_player");
    level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "flag_greenhouse_exit_end");
    scripts\sp\utility::_id_57D6();
  }

  scripts\sp\utility::_id_DFE6(::_id_6969);

  if(isDefined(self.gunner)) {
    self.gunner scripts\sp\utility::_id_DFE6(::_id_6969);
  }
}

_id_6969(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_1 == level.player) {
    self._id_271F = 1;
    self notify("shot_by_player");
  }
}

_id_696D(var_0) {
  var_1 = scripts\engine\utility::getStruct("s_shootgator_bullet_trail_start", "targetname");

  if(!isDefined(var_1)) {
    var_1 = level._id_76FB;
  }

  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  self settargetentity(var_2);

  if(!isDefined(var_0["n_deviate_x"])) {
    var_0["n_deviate_x"] = 10;
  }

  if(!isDefined(var_0["n_deviate_y"])) {
    var_0["n_deviate_y"] = 10;
  }

  var_3 = var_0["shootat_target"];
  var_4 = var_0["n_deviate_x"];
  var_5 = var_0["n_deviate_y"];
  thread _id_2CE6();
  var_6 = 3.5;
  level waittill("exitdoor_dropship_start_shooting");

  while(isDefined(var_3) && (isDefined(self.gunner) && isalive(self.gunner))) {
    var_7 = var_3.origin + (randomfloatrange(-1 * var_4, var_4), randomfloatrange(-1 * var_5, var_5), 0);
    var_2 moveTo(var_7, var_6);
    var_2 waittill("movedone");

    for(var_8 = 0; var_8 < 20; var_8++) {
      var_7 = var_3.origin + (randomfloatrange(-1 * var_4, var_4), randomfloatrange(-1 * var_5, var_5), 0);
      var_2 moveTo(var_7, 0.1);
      var_2 waittill("movedone");
      playFX(level._effect["blood_spurt_large"], var_7);
    }
  }

  var_2 delete();
}

_id_2CE6() {
  self playSound("mars_base_gator_dropship_flyin");
}

_id_14BB() {
  level endon("aa2_flood_spawn_stop");
  level endon("boss_dropship_gunner_killed_by_player");
  var_0 = 30;
  var_1 = getEnt("trig_aa2_near_area", "targetname");
  var_2 = [::_id_14B1, ::_id_14B7, ::_id_14B1, ::_id_14B7];
  var_3 = [::_id_14B3, ::_id_14B9, ::_id_14B3, ::_id_14B9];

  while(!scripts\engine\utility::is_true(level._id_270D)) {
    wait(var_0);
    var_4 = undefined;

    if(level.player istouching(var_1)) {
      var_5 = randomint(var_2.size - 1);
      var_4 = var_2[var_5];
    } else {
      var_5 = randomint(var_3.size - 1);
      var_4 = var_3[var_5];
    }

    if(isDefined(var_4)) {
      [[var_4]]();
    }
  }
}

_id_14AF() {
  var_0 = [];
  var_0["veh_spawner"] = "veh_enemy_boss_dropship_aa2";
  var_0["turret"] = "hill_enemy_mg_dropship_mg";
  var_0["light"] = "hill_enemy_mg_dropship_light";
  var_1 = [];
  var_1["shootat_target"] = level.player;
  var_1["n_deviate_x"] = 5;
  var_1["n_deviate_y"] = 5;
  var_1["stop_shooting_on_exit"] = 1;
  var_2 = [];
  var_2["start"] = "struct_boss_dropship_enter_a_00";
  var_2["exit"] = "struct_boss_dropship_exit_a_00";
  var_2["func_shoot"] = ::_id_14B0;
  var_2["func_exit"] = undefined;
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
}

_id_14B0(var_0) {
  var_1 = getEnt("trig_boss_dropship_a_start_shooting", "targetname");
  var_1 waittill("trigger", var_2);
  thread _id_0BBD::_id_5DB9("right");
  wait 1;
  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_14B1() {
  var_0 = [];
  var_0["veh_spawner"] = "veh_enemy_boss_dropship_aa2";
  var_0["turret"] = "hill_enemy_mg_dropship_mg";
  var_0["light"] = "hill_enemy_mg_dropship_light";
  var_1 = [];
  var_1["shootat_target"] = level.player;
  var_1["n_deviate_x"] = 10;
  var_1["n_deviate_y"] = 7;
  var_1["stop_shooting_on_exit"] = 1;
  var_2 = [];
  var_2["start"] = "struct_boss_dropship_enter_b_00";
  var_2["exit"] = "struct_boss_dropship_exit_b_00";
  var_2["func_shoot"] = ::_id_14B2;
  var_2["hovertime_min"] = 2;
  var_2["hovertime_max"] = 4;
  var_2["func_exit"] = ::scripts\sp\maps\marsbase\marsbase_util::_id_2CE2;
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
}

_id_14B2(var_0) {
  var_1 = getEnt("trig_boss_dropship_b_start_shooting", "targetname");

  for(var_2 = 0; !scripts\engine\utility::is_true(var_2); var_2 = var_3 == self) {
    var_1 waittill("trigger", var_3);
  }

  thread _id_0BBD::_id_5DB9("right");
  wait 7;
  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_14B3() {
  var_0 = [];
  var_0["veh_spawner"] = "veh_enemy_boss_dropship_aa2";
  var_0["turret"] = "hill_enemy_mg_dropship_mg";
  var_0["light"] = "hill_enemy_mg_dropship_light";
  var_1 = [];
  var_1["shootat_target"] = level.player;
  var_1["n_deviate_x"] = 5;
  var_1["n_deviate_y"] = 5;
  var_1["stop_shooting_on_exit"] = 0;
  var_2 = [];
  var_2["start"] = "struct_boss_dropship_enter_c_00";
  var_2["exit"] = "struct_boss_dropship_exit_c_00";
  var_2["func_shoot"] = ::_id_14B4;
  var_2["hovertime_min"] = 2;
  var_2["hovertime_max"] = 5;
  var_2["func_exit"] = ::scripts\sp\maps\marsbase\marsbase_util::_id_2CE2;
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
}

_id_14B4(var_0) {
  wait 5;
  thread _id_0BBD::_id_5DB9("right");
  wait 0.5;
  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_14B5() {
  var_0 = [];
  var_0["veh_spawner"] = "veh_enemy_boss_dropship_aa2";
  var_0["turret"] = "hill_enemy_mg_dropship_mg";
  var_0["light"] = "hill_enemy_mg_dropship_light";
  var_1 = [];
  var_1["shootat_target"] = level.player;
  var_1["n_deviate_x"] = 5;
  var_1["n_deviate_y"] = 5;
  var_1["stop_shooting_on_exit"] = 1;
  var_2 = [];
  var_2["start"] = "struct_boss_dropship_enter_d_00";
  var_2["exit"] = "struct_boss_dropship_exit_d_00";
  var_2["func_shoot"] = ::_id_14B6;
  var_2["func_exit"] = undefined;
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
}

_id_14B6(var_0) {
  wait 5;
  thread _id_0BBD::_id_5DB9("right");
  wait 1;
  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_14B7() {
  var_0 = [];
  var_0["veh_spawner"] = "veh_enemy_boss_dropship_aa2";
  var_0["turret"] = "hill_enemy_mg_dropship_mg";
  var_0["light"] = "hill_enemy_mg_dropship_light";
  var_1 = [];
  var_1["shootat_target"] = level.player;
  var_1["n_deviate_x"] = 5;
  var_1["n_deviate_y"] = 5;
  var_1["stop_shooting_on_exit"] = 1;
  var_2 = [];
  var_2["start"] = "struct_boss_dropship_enter_e_00";
  var_2["exit"] = "struct_boss_dropship_exit_e_00";
  var_2["func_shoot"] = ::_id_14B8;
  var_2["hovertime_min"] = 2;
  var_2["hovertime_max"] = 3;
  var_2["func_exit"] = ::scripts\sp\maps\marsbase\marsbase_util::_id_2CE2;
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
}

_id_14B8(var_0) {
  thread _id_0BBD::_id_5DB9("right");
  wait 1;
  var_1 = getEnt("trig_boss_dropship_e_start_shooting", "targetname");
  var_2 = 0;

  while(!scripts\engine\utility::is_true(var_2)) {
    var_1 waittill("trigger", var_3);

    if(var_3 == self) {
      var_2 = 1;
    }
  }

  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_14B9() {
  var_0 = [];
  var_0["veh_spawner"] = "veh_enemy_boss_dropship_aa2";
  var_0["turret"] = "hill_enemy_mg_dropship_mg";
  var_0["light"] = "hill_enemy_mg_dropship_light";
  var_1 = [];
  var_1["shootat_target"] = level.player;
  var_1["n_deviate_x"] = 5;
  var_1["n_deviate_y"] = 5;
  var_1["stop_shooting_on_exit"] = 1;
  var_2 = [];
  var_2["start"] = "struct_boss_dropship_enter_f_00";
  var_2["exit"] = "struct_boss_dropship_exit_f_00";
  var_2["func_shoot"] = ::_id_14BA;
  var_2["hovertime_min"] = 2;
  var_2["hovertime_max"] = 4;
  var_2["func_exit"] = ::scripts\sp\maps\marsbase\marsbase_util::_id_2CE2;
  scripts\sp\maps\marsbase\marsbase_util::_id_2CDF(var_0, var_1, var_2);
}

_id_14BA(var_0) {
  thread _id_0BBD::_id_5DB9("right");
  wait 1;
  var_1 = getEnt("trig_boss_dropship_f_start_shooting", "targetname");
  var_2 = 0;

  while(!scripts\engine\utility::is_true(var_2)) {
    var_1 waittill("trigger", var_3);

    if(var_3 == self) {
      var_2 = 1;
    }
  }

  self.turret thread scripts\sp\maps\marsbase\marsbase_util::_id_035A(var_0);
}

_id_10B92() {
  var_0 = ["salter", "griff", "ethan", "brooks"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_aa2");
  scripts\engine\utility::array_thread(scripts\sp\utility::_id_77DA("group_ally_dropship2_engineers"), scripts\sp\utility::_id_F3B5, "r");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_aa2", "targetname"));
  var_1 = getEntArray("spawners_dontuse_if_jumpto_aa2", "script_noteworthy");
  scripts\engine\utility::array_call(var_1, ::delete);
  scripts\engine\utility::array_thread(level._id_1684, scripts\sp\utility::_id_F3B5, "r");
  scripts\sp\utility::_id_15F5("trig_aa2_allies_1");
  level thread scripts\sp\maps\marsbase\marsbase_util::_id_DC75();
  level thread _id_14AE(1);
  thread scripts\sp\maps\marsbase\marsbase_greenhouse::_id_8AEA("burning_man_done");
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_2");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AA("fxanim_sp_mars_crane");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AB("aa2_destruction");
  _id_14D3();
  _id_14AD();
  level._id_2700 = 1;
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
}

_id_B175() {
  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_2669("AA2");

  if(!scripts\engine\utility::flag_exist("aa2_destroyed")) {
    scripts\engine\utility::flag_init("aa2_destroyed");
  }

  if(!scripts\engine\utility::flag_exist("player_and_heroes_in_aa2")) {
    scripts\engine\utility::flag_init("player_and_heroes_in_aa2");
  }

  scripts\sp\maps\marsbase\marsbase_greenhouse::_id_855F();

  if(!scripts\engine\utility::is_true(level._id_2700)) {
    level thread _id_14D2();
  } else {
    thread scripts\sp\maps\marsbase\marsbase_greenhouse::_id_8561();
  }

  thread _id_14C0();
  level thread _id_14DA();
  thread _id_14CF();
  thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_542C();
  scripts\engine\utility::flag_set("flag_obj_aa2_start");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa2");
  thread _id_14C8();
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14E8("aa_gun_2", 1);
  _id_14D5();
  level notify("aa2_flood_spawn_stop");
  scripts\sp\maps\marsbase\marsbase_killstreak::_id_B391();
  level notify("aa2_jackals_stop");
  wait 0.1;
  _id_14CB();
  scripts\engine\utility::flag_set("flag_aa2_end");
  level notify("aa2_finished");
  level thread _id_67E6();
}

_id_14C9() {
  var_0 = getEntArray("aa2_destruction", "targetname");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 delete();
    }
  }

  thread _id_14D6();
  scripts\sp\maps\marsbase\marsbase_util::_id_5196("fxanim_tarps_area_01");
  scripts\sp\maps\marsbase\marsbase_util::_id_5196("fxanim_tarps_area_02");
}

_id_14D2() {
  scripts\engine\utility::flag_wait("flag_greenhouse_exit_end");
  wait 1;
  var_0 = getEnt("trig_aa2_allies_1", "targetname");
  var_1 = 0;
  var_2 = getEnt("mdl_gatordoor_closed_clip", "targetname");
  var_3 = getEnt("mdl_gatordoor_closed", "targetname");
  var_2 linkTo(var_3);
  scripts\sp\utility::_id_16AE(var_3, "aa2");
  scripts\sp\utility::_id_16AE(var_2, "aa2");
  level._id_EA2C thread scripts\sp\coverwall::_id_596D();
  level._id_6754 thread scripts\sp\coverwall::_id_596D();
  level._id_30F6 thread scripts\sp\coverwall::_id_596D();
  level._id_8604 thread scripts\sp\coverwall::_id_596D();
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  for(var_8 = 0; isDefined(var_0) && !scripts\engine\utility::is_true(var_1); var_1 = var_9 && !var_10) {
    wait 0.1;
    var_9 = level.player istouching(var_0);

    if(level._id_6754 istouching(var_0)) {
      var_4 = 1;
    } else {
      var_4 = 0;
    }

    if(level._id_EA2C istouching(var_0)) {
      var_5 = 1;
    } else {
      var_5 = 0;
    }

    if(level._id_30F6 istouching(var_0)) {
      var_6 = 1;
    } else {
      var_6 = 0;
    }

    if(level._id_8604 istouching(var_0)) {
      var_7 = 1;
    } else {
      var_7 = 0;
    }

    if(!var_8 && var_4 && var_5 && var_6 && var_7) {
      var_8 = 1;
      var_2 disconnectPaths();
    }

    var_9 = var_9 && var_4 && var_5 && var_6 && var_7;
    var_10 = level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_3, 0.4, 1);
  }

  var_11 = _id_0E2D::get_all_drones();
  var_12 = 5;
  var_13 = 0;
  var_14 = 0;

  while(!var_14) {
    var_14 = 1;

    foreach(var_17, var_16 in var_11) {
      if(!isDefined(var_16) || !isalive(var_16)) {
        continue;
      } else if(var_16.origin[1] >= 18730) {
        continue;
      } else if(var_16.origin[1] >= 18560 && var_13 <= var_12) {
        var_13++;
        var_14 = 0;
        wait 1.0;
        break;
      }

      var_16 notify("lethal_damage");
      var_11[var_17] = undefined;
    }

    wait 0.05;
  }

  var_18 = var_3.origin + (0, 0, 100);
  var_3 moveTo(var_18, 0.1);
  var_2 disconnectPaths();
  level.player thread scripts\sp\utility::play_sound_on_entity(level.doors["greenhouse_exit_doors"]._id_C62B);
  thread scripts\sp\maps\marsbase\marsbase_greenhouse::_id_8561();
  scripts\engine\utility::flag_set("player_and_heroes_in_aa2");
  scripts\sp\utility::_id_1264E("marsbase_combat_intro_tr");
  scripts\sp\utility::_id_1264E("marsbase_olympus_mons_guts_tr");
  level._id_EA2C thread scripts\sp\coverwall::_id_551C();
  level._id_6754 thread scripts\sp\coverwall::_id_551C();
  level._id_30F6 thread scripts\sp\coverwall::_id_551C();
  level._id_8604 thread scripts\sp\coverwall::_id_551C();
  level notify("loot_crate_greenhouse_cleanup");
}

_id_14C0() {
  var_0 = getEnt("fxanim_sp_mars_crane", "targetname");

  if(isDefined(var_0)) {
    var_0 scripts\sp\utility::_id_23B7("fxanim_aa2_crane");
    var_0 thread scripts\sp\anim::_id_1EEA(var_0, "crane_idle");
    var_0 playLoopSound("mars_base_cable_swing");
  }

  level waittill("hill_airlock_opened");
  var_0 delete();

  if(!level.console) {
    waitfortransient("marsbase_combat_pre_elevator_tr");
  }
}

_id_14C8() {
  var_0 = level.gun["aa_gun_2"].turret.origin;
  scripts\engine\utility::flag_wait("aa2_destroyed");
  var_1 = getaiarray("axis");
  var_2 = getEnt("trig_aa2_blast", "targetname");

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4) && var_4 istouching(var_2)) {
      var_4 thread scripts\sp\maps\marsbase\marsbase_killstreak::_id_6F2A(var_0, 0.5);
    }
  }
}

_id_14C7(var_0) {
  self dodamage(self.health * 2, var_0, level.player, level.player, "MOD_EXPLOSIVE");
}

_id_14C6() {
  scripts\engine\utility::flag_wait("player_and_heroes_in_aa2");
  var_0 = ["trig_aa2_allies_1", "trig_aa2_allies_2a", "trig_aa2_allies_2b", "trig_aa2_allies_2c"];

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "targetname");

    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}

_id_14D7() {
  var_0 = getEntArray("spawner_aa2_recurring", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isspawner(var_2)) {
      var_2 delete();
    }
  }

  for(var_4 = 1; var_4 < 4; var_4++) {
    var_5 = "trig_aa2_spawns_0" + var_4;
    var_6 = getEnt(var_5, "script_noteworthy");

    if(isDefined(var_6)) {
      var_6 delete();
    }
  }
}

_id_14CB() {
  wait 1;
  var_0 = 0;
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3.health = 5;
      var_3 scripts\sp\utility::_id_F3D9(getnode("aa2_upper_area_last_defense", "targetname"));
      var_3._id_EDB0 = 1;
      var_3 scripts\sp\utility::_id_F3DD(256);
    }
  }

  while(!scripts\engine\utility::is_true(var_0) && !scripts\engine\utility::flag("flag_burning_man_cave_approach_reached")) {
    var_5 = getaiarray("axis");

    if(var_5.size <= 0) {
      var_0 = 1;
      break;
    }

    wait 0.1;
  }

  level notify("aa2_safe_to_cross");
  wait 3.0;
  var_1 = getaiarray("axis");
  var_6 = [level._id_EA2C, level._id_6754, level._id_30F6];
  thread scripts\sp\maps\marsbase\marsbase_code::_id_A657(var_1, var_6);
}

_id_14AE(var_0) {
  level._id_E8E4 = spawnStruct();
  thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("airlock_aa2_left", "flag_aa2_end", "aa2_finished", undefined, "aa2");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("airlock_aa2_center", "flag_aa2_end", "aa2_finished", undefined, "aa2");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("airlock_aa2_right", "flag_aa2_end", "aa2_finished", undefined, "aa2");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_10685("airlock_aa2_crane", "flag_aa2_end", "aa2_finished", undefined, "aa2");
  thread _id_14CC("trig_aa2_spawns_00");

  if(!scripts\engine\utility::is_true(var_0)) {
    level waittill("exitdoor_boss_dropship_exited");
  }

  level._id_E8E4 thread _id_14D0();
  level._id_E8E4 thread _id_14BE();
  scripts\engine\utility::waitframe();
  level._id_E8E4 thread _id_14CC("trig_aa2_spawns_crane");
  scripts\engine\utility::waitframe();
  level._id_E8E4 thread _id_14CC("trig_aa2_spawns_airlock_left", 1);
  scripts\engine\utility::waitframe();
  level._id_E8E4 thread _id_14CC("trig_aa2_spawns_airlock_center", 1);
  scripts\engine\utility::waitframe();
  level._id_E8E4 thread _id_14CC("trig_aa2_spawns_airlock_right", 1);
  scripts\engine\utility::waitframe();
  level._id_E8E4 thread _id_14BD();
  scripts\engine\utility::waitframe();
  thread _id_14BB();
}

_id_14BD() {
  var_0 = getspawnerarray("aa2_c8");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_14BC);
  _id_14CC("trig_aa2_spawns_04");
}

_id_14BC() {
  self endon("death");
  self._id_5580 = 1;
  scripts\sp\utility::_id_F2D8(150);
  self._id_1FBB = "c8";
  var_0 = ["aa2_c8_jumpdown_01", "aa2_c8_jumpdown_02", "aa2_c8_jumpdown_01", "aa2_c8_jumpdown_02"];
  var_1 = ["tag_align_aa2_cliff", "tag_align_aa2_crane", "tag_align_aa2_cliff", "tag_align_aa2_crane"];
  var_2 = undefined;
  var_3 = undefined;
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_3 = var_1[var_5];
    var_6 = scripts\engine\utility::getStruct(var_3, "targetname");
    var_4[var_5] = level.player scripts\sp\maps\marsbase\marsbase_util::_id_6A8C(var_6, 1);

    if(level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_6, 0.6, 1)) {
      var_2 = var_0[var_5];
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_7 = randomint(var_0.size - 1);
    var_2 = var_0[var_7];
    var_3 = var_1[var_7];
  }

  scripts\sp\maps\marsbase\marsbase_util::_id_341E(var_3, var_2);
  var_8 = getnodearray(self.target, "targetname");
  thread scripts\sp\maps\marsbase\marsbase_util::_id_138D6(var_8, 30, 31, 5, 15);
  level waittill("aa2_gun_destroyed");

  if(isDefined(self) && isalive(self)) {
    self.health = 5;
  }
}

_id_14D0() {
  self._id_149E = [];
  var_0 = getEntArray("spawner_enemy_ledge_lmg", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_3 = var_2 scripts\sp\utility::_id_10619(1);
      var_3._id_1FBB = "generic";
      var_3._id_72C7 = 1;
      var_3 thread _id_14D1();
      scripts\engine\utility::array_add(self._id_149E, var_3);
    }
  }
}

_id_14D1() {
  scripts\engine\utility::waittill_any("goal", "near_goal");

  while(isalive(self) && isalive(level.player)) {
    self shoot(50, level.player);
    wait 5;
  }
}

_id_14BE() {
  var_0 = getspawnerarray();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "aa2_cqb") {
      var_2 scripts\sp\utility::_id_1747(::_id_14BF);
    }
  }
}

_id_14BF() {
  self.goalradius = 200;
  self setgoalentity(level.player);
  self.targetname = "enemy_cqb_aa2";
}

_id_14DA() {
  wait 1;
  var_0 = scripts\engine\utility::getStruct("s_ref_aa2_vignettes", "targetname");
  var_0.angles = (0, 0, 0);
  var_0 thread _id_14D9();
}

_id_14D9() {
  var_0 = level._id_6754;
  var_1 = scripts\sp\maps\marsbase\marsbase_util::_id_10711("spawner_aa2_start_kill_enemy");
  var_1._id_1FBB = "generic";
  var_0._id_1FBB = "ethan";
  var_2 = [var_0, var_1];
  var_1 scripts\sp\utility::_id_F416(1);
  scripts\sp\anim::_id_1F17(level._id_6754, "aa2_start_kill");

  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  thread scripts\sp\anim::_id_1F2C(var_2, "aa2_start_kill");
  var_1 setCanDamage(1);
  var_1 scripts\sp\utility::_id_F2A8(1);
  var_1._id_10265 = 1;
  var_1.forceragdollimmediate = 1;
  var_1 scripts\sp\utility::_id_135F1("death", 5);

  if(!isDefined(var_1) || !isalive(var_1)) {
    level._id_6754 _meth_83A1();
    return;
  }

  var_1 setCanDamage(0);
  var_1 scripts\sp\utility::_id_F2A8(0);
  wait(getanimlength(var_1 scripts\sp\utility::_id_7DC1("aa2_start_kill")) - 5);
  var_1 _meth_81D0();
}

_id_14D8() {
  var_0 = getEnt("spawner_aa2_start_kill_enemy", "targetname");
  var_1 = scripts\sp\maps\marsbase\marsbase_util::_id_10711("spawner_aa2_start_kill_enemy");
  var_1 setCanDamage(1);
  scripts\sp\anim::_id_1F35(var_1, "aa2_signaling_soldier");
}

_id_14CC(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = getspawnerarray(var_2.target);

  foreach(var_5 in var_3) {
    var_5 scripts\sp\utility::_id_1747(::_id_14CD, var_2.target);
  }

  thread scripts\sp\maps\marsbase\marsbase_util::_id_6F56(var_0, "targetname");

  if(scripts\engine\utility::is_true(var_1)) {
    thread _id_14CE(var_0);
  }

  level waittill("aa2_flood_spawn_stop");
  scripts\sp\maps\marsbase\marsbase_util::_id_6F57(var_0, "targetname", 1);
}

_id_14CE(var_0) {
  level endon("aa2_flood_spawn_stop");
  var_1 = var_0 + "_close";

  for(;;) {
    scripts\engine\utility::flag_wait(var_1);
    scripts\sp\maps\marsbase\marsbase_util::_id_6F57(var_0, "targetname", 0);

    while(scripts\engine\utility::flag(var_1)) {
      wait 0.5;
    }

    scripts\sp\maps\marsbase\marsbase_util::_id_6F56(var_0, "targetname");
    wait 0.5;
  }
}

_id_14CD(var_0) {
  self.targetname = var_0;
}

_id_10C5E() {
  var_0 = ["salter", "griff", "ethan", "brooks"];
  scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_aa2");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_gate_2", "targetname"));
  scripts\sp\maps\marsbase\marsbase_code::_id_14EB("aa_gun_2");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AA("fxanim_sp_mars_crane");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AB("aa2_destruction");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AB("aa2_rubble");
  level thread _id_14D5(1);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14E8("aa_gun_2", 1);
  level notify("aagun_destroyed", "aa_gun_2");
  scripts\engine\utility::delaythread(0.15, scripts\sp\maps\marsbase\marsbase_killstreak::_id_B391);
  level.player thread scripts\sp\utility::_id_C12D("new_hint", 0.15);
}

_id_B1E9() {
  scripts\sp\utility::_id_2669("Gate Support 2");
  scripts\engine\utility::array_thread(level._id_1684, scripts\sp\utility::_id_F3B5, "r");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa2_complete");
  scripts\sp\utility::_id_15F5("trig_caves_allies_1");
}

_id_3B6B() {
  var_0 = getEnt("brush_caves_gate", "targetname");

  if(isDefined(var_0)) {
    var_0 connectpaths();
    var_0 delete();
  }
}

_id_14D3() {
  var_0 = getEntArray("aa2_rubble", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 hide();
      scripts\sp\utility::_id_16AE(var_2, "aa2");
    }
  }
}

_id_14D5(var_0) {
  var_1 = getEntArray("aa2_destruction", "targetname");

  if(!scripts\engine\utility::is_true(var_0)) {
    level waittill("aa_gun_2_destroyed");
  }

  thread _id_14D4(var_0);
  thread _id_14AC();
  scripts\engine\utility::flag_set("aa2_destroyed");
  level notify("aa2_gun_destroyed");

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_3 delete();
    }
  }

  scripts\sp\maps\marsbase\marsbase_util::_id_B3AB("aa2_rubble");
}

_id_14D6() {
  var_0 = getEntArray("aa2_rubble", "targetname");

  if(isDefined(var_0) && var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2)) {
        var_2 show();
      }
    }
  }
}

_id_14D4(var_0) {
  if(!scripts\engine\utility::is_true(var_0)) {
    wait 1.5;
  }

  thread _id_0BDC::_id_D527("mars_base_jackal_aa1_crash", (32878, 20877, -11401));
  thread _id_329A();
  scripts\engine\utility::exploder("vfx_exp_tunnel_explosion");
}

_id_329A() {
  var_0 = ["emt_fire_gas_jet", "emt_fire_gas_jet", "emt_fire_gas_jet", "emt_fire_small_lp_01", "emt_fire_large_lp_01", "emt_fire_med_lp_01", "emt_fire_med_crackle_lp_01"];
  var_1 = [(33069, 21111, -11189), (33867, 21816, -11228), (34083, 21646, -11076), (33106, 21241, -11195), (33184, 21546, -11359), (34178, 21526, -11234), (34607, 21534, -11230)];
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2[var_3] = ::scripts\engine\utility::play_loopsound_in_space(var_0[var_3], var_1[var_3]);
  }

  level waittill("burning_man_done");

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2[var_3] scripts\engine\utility::stop_loop_sound_on_entity(var_0[var_3]);
    var_2[var_3] delete();
  }
}

_id_14C3() {
  var_0 = scripts\engine\utility::getStruct("tag_align_aa2", "targetname");
  var_0.angles = (0, 0, 0);
  var_1 = ["dead_robot_01", "dead_robot_02", "dead_robot_03"];
  var_2 = getspawnerarray("spawner_c6_deadrobot");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3] scripts\sp\utility::_id_10619(1);
    var_4 thread _id_14C2(var_0, var_1[var_3]);
  }
}

_id_14C2(var_0, var_1) {
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  self._id_87F6 = 0;
  self._id_1FBB = "c6";
  scripts\sp\utility::_id_86E4();
  self._id_2708 = 1;
  self _meth_84AE();
  self _meth_847C();
  thread scripts\sp\maps\marsbase\marsbase_util::_id_4067("cleanup_dead_bodies_burning_man");
  var_0 thread scripts\sp\anim::_id_1EEA(self, var_1);
  wait 1.0;
  scripts\sp\utility::_id_54C6();
}

_id_14AD() {
  var_0 = getEntArray("fxanim_sp_mars_airlock_door_explosion", "targetname");
  var_1 = scripts\engine\utility::getStruct("fxanim_sp_mars_airlock_door_explosion_struct", "targetname");

  foreach(var_3 in var_0) {
    var_3 scripts\sp\utility::_id_23B7("fxanim_aa2_airlock");
    var_1 thread scripts\sp\anim::_id_1EC3(var_3, "explode");
    scripts\sp\utility::_id_16AE(var_3, "aa2");
  }
}

_id_14AC(var_0) {
  var_1 = getEntArray("fxanim_sp_mars_airlock_door_explosion", "targetname");
  var_2 = scripts\engine\utility::getStruct("fxanim_sp_mars_airlock_door_explosion_struct", "targetname");
  playworldsound("mars_base_tunnel_explo", (32953, 20985, -11332));

  foreach(var_4 in var_1) {
    var_4 scripts\sp\utility::_id_23B7("fxanim_aa2_airlock");

    if(!scripts\engine\utility::is_true(var_0)) {
      var_2 thread scripts\sp\anim::_id_1F35(var_4, "explode");
      continue;
    }

    var_2 thread scripts\sp\anim::_id_1EE0(var_4, "explode");
  }
}

_id_14C5(var_0) {
  var_1 = getEnt("fxanim_sp_mars_burning_tunnel_debris_01", "targetname");
  var_2 = scripts\engine\utility::getStruct("fxanim_sp_mars_burning_tunnel_debris_01_struct", "targetname");
  var_3 = getEnt("fxanim_sp_mars_burning_tunnel_debris_02", "targetname");
  var_4 = scripts\engine\utility::getStruct("fxanim_sp_mars_burning_tunnel_debris_02_struct", "targetname");
  var_1 scripts\sp\utility::_id_23B7("fxanim_aa2_debris01");
  var_3 scripts\sp\utility::_id_23B7("fxanim_aa2_debris02");
  var_2 thread scripts\sp\anim::_id_1EC3(var_1, "explode");
  var_4 thread scripts\sp\anim::_id_1EC3(var_3, "explode");
}

_id_14C4(var_0) {
  var_1 = getEnt("fxanim_sp_mars_burning_tunnel_debris_01", "targetname");
  var_2 = scripts\engine\utility::getStruct("fxanim_sp_mars_burning_tunnel_debris_01_struct", "targetname");
  var_3 = getEnt("fxanim_sp_mars_burning_tunnel_debris_02", "targetname");
  var_4 = scripts\engine\utility::getStruct("fxanim_sp_mars_burning_tunnel_debris_02_struct", "targetname");
  var_1 scripts\sp\utility::_id_23B7("fxanim_aa2_debris01");
  var_3 scripts\sp\utility::_id_23B7("fxanim_aa2_debris02");

  if(scripts\engine\utility::is_true(var_0)) {
    var_2 thread scripts\sp\anim::_id_1EE0(var_1, "explode");
    var_4 thread scripts\sp\anim::_id_1EE0(var_3, "explode");
  } else {
    var_2 thread scripts\sp\anim::_id_1F35(var_1, "explode");
    var_4 thread scripts\sp\anim::_id_1F35(var_3, "explode");
  }
}

_id_14CF() {
  level endon("aa2_destroyed");

  for(;;) {
    level.player waittill("mars_killstreak_missiles_done");
    scripts\sp\maps\marsbase\marsbase_killstreak::_id_B391(45);
  }
}
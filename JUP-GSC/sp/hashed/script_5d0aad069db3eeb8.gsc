/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5d0aad069db3eeb8.gsc
*************************************************/

#using script_32876a523f324870;
#using script_4ab4bd3ef85fb34c;
#using script_71b48ffe76b07d2;
#using script_a6f526f54ee52f7;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\fakeactor;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_lighting;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace namespace_6da3ab6a51378913;

function function_b174136af07c1f9a() {}

function function_45448beba0e951ac() {
  function_3b85dd1a77c3e831();
  function_c1d05e9a4dd19f87();
}

function function_68a6dd38cd7f8f1d() {
  function_c1d05e9a4dd19f87();
}

function function_c1d05e9a4dd19f87() {
  level.shepherd = spawn_script_origin();
  level.shepherd.team = "allies";
}

function function_3b85dd1a77c3e831() {
  utility::function_1ae8f046dee579e0(1);
  delaythread(1, &utility::function_1ae8f046dee579e0, 0);
}

function function_99018d84375f7aa0() {
  flag_set("infil_vehicle_stop_at_gate");
  thread fb_lighting::function_403b8070ead43a7();
}

function function_c35921bba378f25f() {
  function_3b85dd1a77c3e831();
  thread function_4eb95ac8e82250ea();
}

function function_3892ff81017d2d5b() {
  flag_init("introscreen_start_wait");
  level.player thread function_1be9f3b69b4cbd3f();
  namespace_47819225b08b445d::spawn_price(0);
  namespace_47819225b08b445d::function_350377b71c3dfd2e();

  foreach(ally in level.allies) {
    ally.og_name = ally.name;
    ally.name = "";
    ally.og_callsign = ally.callsign;
    ally.callsign = undefined;
  }

  function_6528e5d970e1af01();
  thread fb_lighting::function_230ecfc530cd108a();
  thread function_aeff8d93ef0f673c();
  thread exploder("intro_crowdfx");
  thread exploder("intro_smoke_plume_lrg");
  level.player setsoundsubmix("sp_jup_flashback_intro_ext", 0.5);
  thread namespace_813e4ba6b29c9ad8::function_9adf8f2a9deef100(undefined);
  thread infil_animation();
  level.var_72235c2923f36d22 = [];
  thread function_324d2c4cc1397aa4();
  thread function_61c7a64151030e8a();
  flag_wait("infil_vehicle_stop_at_gate");
  function_4fde87e878d0a64c();
}

function function_4eb95ac8e82250ea() {
  level.player lerpfovscalefactor(0, 0);
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player modifybasefov(85, 0);
}

function function_1be9f3b69b4cbd3f() {
  function_1ee1bb8c20d6eaf1();
  thread function_4eb95ac8e82250ea();
  thread function_bb8865e2c6ea07f();
  thread function_e7d3f8817c30d9db();
  wait 5;
  function_5e7c60d2022142a2();
  start_chyron();

  if(isDefined(level.anim_soap)) {
    level.infilvehicle.actors = array_remove(level.infilvehicle.actors, level.anim_soap);
    level.anim_soap delete();
  }

  foreach(ally in level.allies) {
    ally.name = ally.og_name;
    ally.callsign = ally.og_callsign;
  }
}

function function_5e7c60d2022142a2() {
  self lerpviewangleclamp(0, 0, 0, 70, 90, 20, 12);
}

function function_e7d3f8817c30d9db() {
  var_65721b6704a80b3e = 3;
  var_acba814b0cb5904c = 20;
  var_9e94c057e4575e11 = 42;
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(var_65721b6704a80b3e, var_9e94c057e4575e11);
  flag_wait("nt_infil_dof_blend_start");
  var_5421ffd7016c2888 = level.player.rig getanim("fbk_0110");
  var_537c7073c5679486 = get_notetrack_time(var_5421ffd7016c2888, "lense_fx_blend_start");
  var_5c7d5ae89346dcca = get_notetrack_time(var_5421ffd7016c2888, "lense_fx_blend_stop");
  var_fd5189a667b79aeb = getanimlength(var_5421ffd7016c2888);

  while(true) {
    var_26382cc94e327787 = gettime() / 1000;
    var_abcd6525f38caf87 = normalize_value(var_537c7073c5679486, var_5c7d5ae89346dcca, var_26382cc94e327787);

    if(var_26382cc94e327787 > var_5c7d5ae89346dcca) {
      break;
    }

    var_bce2a9ff10bc06b8 = math::lerp(var_65721b6704a80b3e, var_acba814b0cb5904c, var_abcd6525f38caf87);
    level.player setphysicaldepthoffield(var_bce2a9ff10bc06b8, var_9e94c057e4575e11);

    waitframe();
  }

  level.player disablephysicaldepthoffieldscripting();
}

function function_bb8865e2c6ea07f() {
  showcinematicletterboxing(0, 0, level.player);
  wait 3;
  hidecinematicletterboxing(2, 0, level.player);
}

function start_chyron() {
  flag_set("introscreen_start_wait");
  thread infil_music();
}

function infil_music() {
  setmusicstate("mx_flashback_infil");
}

function function_1ee1bb8c20d6eaf1() {
  level.player.var_336db6c8b15ad3df = 1;
  scripts\engine\sp\utility::set_player_demeanor("safe");
  scripts\common\values::set_array("stadium_infil", ["sprint", "allow_movement", "prone", "crouch", "fire", "ads", "offhand_weapons"], 0);
}

function function_9d3a5764e9212213() {
  level.player.var_336db6c8b15ad3df = 0;
  scripts\engine\sp\utility::set_player_demeanor("normal");
  scripts\common\values::reset_all("stadium_infil");
}

function function_8e91eb0fdf90a2ce() {
  flag_set("infil_vehicle_stopping");
  fb_lighting::function_7ba7b6df6537fc07();
}

function function_de0444fdec5e5731() {
  namespace_47819225b08b445d::spawn_price(0);
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  function_6528e5d970e1af01();
  level.player function_1ee1bb8c20d6eaf1();
  level.player function_3029f5e4bbc0397d(1, 90, 90, 90, 30, 1);
  thread function_4eb95ac8e82250ea();
  function_4fde87e878d0a64c();

  foreach(ent in level.infilvehicle.actors) {
    level.infilvehicle anim_first_frame_solo(ent, "fbk_0150", "tag_body");
    ent linkTo(level.infilvehicle, "tag_body");
  }

  level.infilvehicle anim_first_frame(level.infilvehicle.actors, "fbk_0150", "tag_body");
  level.var_72235c2923f36d22 = [];
  thread function_61c7a64151030e8a();
  level.player function_5e7c60d2022142a2();
}

function function_b736dc843d9b00a1() {
  thread function_f66e00bbe47638b6();
  thread garage_animation();
  thread function_d32a8af21f47208d();
  level.player clearsoundsubmix("sp_jup_flashback_intro_ext", 3.5);
  level.player setsoundsubmix("sp_jup_flashback_intro_garage", 3.5);
  glass_debris = getEntArray("infil_vehicle_window_glass_debris", "targetname");

  if(isDefined(glass_debris)) {
    array_call(glass_debris, &hide);
  }

  flag_wait("infil_vehicle_stopping");
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_cac0d6c867a55103);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }
}

function function_d2a51882734ebb4d() {
  flag_set("infil_stairs_police_kill_scene_done");
  flag_set("vo_infil_stairs_done");
  flag_set("radtrig_player_in_stairwell");
  thread namespace_47819225b08b445d::outofbounds_logic();
  thread set_flag_on_targetname_trigger("trigger_concourse_start");
}

function function_d32a8af21f47208d() {
  flag_wait("nt_start_garage_exit");
}

function function_2eb23a246bdb786a() {
  level.var_7855553c51d94f06 = namespace_47819225b08b445d::function_6abf9776eba08eb8("Level Info");
  namespace_47819225b08b445d::spawn_price(0);
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  function_6528e5d970e1af01();
  var_c769aade43212080 = getStruct("animnode_stadium_infil", "targetname");
  level.infilvehicle dontinterpolate();
  var_c769aade43212080 anim_first_frame_solo(level.infilvehicle, "fbk_0150");
  level.player function_1ee1bb8c20d6eaf1();
  level.player function_3029f5e4bbc0397d(1, 60, 80, 50, 30, 1);
  level.player function_5e7c60d2022142a2();

  foreach(actor in level.infilvehicle.actors) {
    actor linkTo(level.infilvehicle, "tag_body");
    level.infilvehicle anim_first_frame_solo(actor, "fbk_0150", "tag_body");
  }

  thread function_945261e44d87465e();
  thread function_5ce23b7a004b60d3();

  foreach(transient in level.var_4291dad1008f93e6) {
    settransientvisibility(transient, 0);
  }
}

function function_1af348af75d2331c() {
  thread function_2e861cfaf8e830b6();
  level.player clearsoundsubmix("sp_jup_flashback_intro_garage", 3.5);
  level.player setsoundsubmix("sp_jup_flashback_intro_stairwell", 3.5);
  flag_init("infil_team_exited_vehicle");
  flag_init("player_stopped_shield_moment");
  thread set_flag_on_targetname_trigger("trigger_concourse_start");
  thread namespace_ccad715273481961::function_68562e15bb2bd6f0("sp_jup_flashback_intro_arrive", 1, 1, 7, 8);
  thread function_28091e100e1025ec();
  flag_wait("infil_team_exited_vehicle");
  thread function_689bbb7cb659195();
  thread namespace_47819225b08b445d::outofbounds_logic();
  utility::flag_wait_either("slaughter_police_dead", "radtrig_player_in_stairwell");
  utility::activate_trigger_with_targetname("color_allies_stairs_stackup");
  thread utility::autosave_by_name();
}

function function_689bbb7cb659195() {
  wait 0.5;
  level.player lerpfovscalefactor(1, 3);

  if(isDefined(level.player.var_f296f7e55b9e9150)) {
    level.player modifybasefov(level.player.var_f296f7e55b9e9150, 1);
  }
}

function function_2e861cfaf8e830b6() {
  flag_init("vo_infil_stairs_done");
  result = flag_wait_any_return("infil_stairs_police_kill_scene_done", "slaughter_police_dead", "trigger_concourse_start");
  battlechatter_off();

  if(result != "trigger_concourse_start") {
    level.price say_team("dx_sp_flas_infs_pric_clear", undefined, undefined, undefined, 1.2);
  }

  level.player say_team("dx_sp_flas_infs_soap_innercirclesposingas", undefined, undefined, undefined, 0.2);
  level.redshirt say_team("dx_sp_flas_infs_burn_theydhaveaccesstothe", undefined, undefined, undefined, 0.2);
  level.price say_team("dx_sp_flas_infs_pric_itsonthethirdfloorle", undefined, undefined, undefined, 0.2);
  battlechatter_on();
  flag_set("vo_infil_stairs_done");
}

function function_94c94ea48630e5ca() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_shield_moment", array_add(level.allies, level.player));
  level.player setsoundsubmix("sp_jup_flashback_intro_stairwell", 3.5);
}

function function_d265cd707bc770fc() {
  thread function_86b958eef2b7a77b();
  thread function_87c520afdb83917f();
  thread shield_moment();
  stop_exploder("intro_crowdfx");
  thread concourse_stackup();
}

function function_6b61f237a053c9ad() {
  flag_set("shield_moment_done");
  flag_set("infil_stairs_player_at_top");
  flag_set("vo_shield_moment_done");
  flag_set("p1stairs_shield_done");
}

function function_86b958eef2b7a77b() {
  level endon("stop_repeating_doorway_stairs_walla");

  while(true) {
    level thread play_sound_in_space("fb_crowd_panic_doorway_1st_stairs", (31485, 2749, -612));
    wait 6;
  }
}

function function_87c520afdb83917f() {
  flag_wait("vo_infil_stairs_done");

  if(!flag("trigger_concourse_start")) {
    if(!flag("radtrig_player_in_stairwell")) {
      nags = ["dx_sp_flas_infs_pric_rallyatthestairs", "dx_sp_flas_infs_pric_atthestairssergeant", "dx_sp_flas_infs_pric_soapgettothestairs"];
      level.price thread nagtill([level, "radtrig_player_in_stairwell"], nags, 11);
    }

    flag_wait("price_starts_meatshield_shooting");

    if(!flag("shield_moment_done")) {
      nags = ["dx_sp_flas_shld_pric_targetsuptop", "dx_sp_flas_shld_pric_soapengage"];
      level.price thread nagtill([level, "shield_moment_done"], nags, 11, 0.2);
    }

    flag_wait_all("shield_moment_done", "police02_dead", "shield_moment_backup_dead");
    thread function_a6e3d4f80da17c9();
    level.player say_team("dx_sp_flas_shld_soap_stairsclear", undefined, undefined, undefined, 0.2);
    thread function_c8283c6d166c8450();
    flag_wait_either("vo_post_shield_moment_done", "trigger_concourse_start");
  }

  flag_set("vo_shield_moment_done");
}

function function_c8283c6d166c8450() {
  level endon("trigger_concourse_start");

  if(!flag("trigger_concourse_start")) {
    var_c2ae50741a871509 = getStruct("obj_concourse_enter", "targetname");

    if(level.player scripts\engine\trace::can_see_origin(var_c2ae50741a871509.origin)) {
      level.player say_team("dx_sp_flas_shld_soap_concourseisupahead", undefined, undefined, undefined, 0.2);
    } else {
      level.price say_team("dx_sp_flas_shld_pric_concourseisupahead", undefined, undefined, undefined, 0.2);
    }

    level.redshirt say_team("dx_sp_flas_shld_burn_stairwellsontheother", undefined, undefined, undefined, 0.2);
    flag_wait("p1stairs_shield_done");
    level.price say_team("dx_sp_flas_shld_pric_checkyourshotsinther", undefined, undefined, undefined, 0.2);
  }

  flag_set("vo_post_shield_moment_done");
}

function concourse_stackup() {
  flag_wait("shield_moment_done");
  thread utility::autosave_by_name();
  activate_trigger_with_targetname("trigger_color_concourse_stackup");
}

function function_a6e3d4f80da17c9() {
  stopmusicstate("mx_flashback_infil");
}

function function_840b1feb8f7f53a7() {
  flag_wait("nt_start_garage_exit");
  utility::flag_wait("slaughter_police_dead");
}

function function_3029f5e4bbc0397d(view_fraction, right_arc, left_arc, top_arc, bottom_arc, var_dbe269f3b6799cb4, set_player_angles) {
  assert(isDefined(self.rig));
  var_dbe269f3b6799cb4 = default_to(var_dbe269f3b6799cb4, 0);
  set_player_angles = default_to(set_player_angles, 1);
  self playerlinktodelta(self.rig, "tag_player", view_fraction, right_arc, left_arc, top_arc, bottom_arc);

  if(set_player_angles) {
    self setplayerangles(self.rig gettagangles("tag_player"));
  }

  self dontinterpolate();
  self.rig dontinterpolate();

  if(var_dbe269f3b6799cb4) {
    self.rig hide();
    return;
  }

  self.rig show();
}

function function_c7a82f28d29caf63() {
  finalorigin = (31818, 2528, -936);
  finalangles = (0, 180, 0);
  dist = squared(600);

  while(!function_6db117296b9b05fa(level.infilvehicle.origin, finalorigin, dist)) {
    waitframe();
  }

  flag_set("infil_vehicle_arriving");
  flag_set("infil_vehicle_stopping");
}

function function_e1669c4e37d61ff9() {
  if(isDefined(level.var_59ef7b8f0b1ed260)) {
    foreach(civ in level.var_59ef7b8f0b1ed260) {
      if(is_dead_or_dying(civ)) {
        continue;
      }

      if(istrue(civ.magic_bullet_shield)) {
        civ stop_magic_bullet_shield();
      }

      if(civ isinscriptedstate()) {
        civ stopanimScripted();
      }

      civ delete();
    }
  }

  if(isDefined(level.var_375090d896d72a46)) {
    array_delete(level.var_375090d896d72a46);
  }

  if(isDefined(level.var_88ddddbcc9770154)) {
    foreach(actor in level.var_88ddddbcc9770154) {
      if(istrue(actor.magic_bullet_shield)) {
        actor stop_magic_bullet_shield();
      }
    }

    array_delete(level.var_88ddddbcc9770154);
  }
}

function spawn_enemy(spawnorigin, goalorigin, radius) {
  spawner = getspawnerarray("dynamic_spawner")[0];
  guy = spawn_aitype(spawner.classname, spawner.origin, spawner.angles, 1);
  guy forceteleport(spawnorigin, (0, 0, 0));
  guy set_goal_pos(goalorigin);
  guy set_goal_radius(radius);
  guy.grenadeammo = 0;
}

function dead_vehicles() {
  var_a76758de991d26cc = getStructArray("dead_vehicles", "targetname");

  foreach(struct in var_a76758de991d26cc) {
    spawner = utility::getvehiclespawner("infil_ally_spawner", "targetname");
    veh = spawner utility::spawn_vehicle();
    veh vehphys_parkingbrake(1);
    veh dontinterpolate();
    veh vehicle_teleport(struct.origin + (0, 0, 42), struct.angles);
    wait 0.1;
    veh vehicle_kill();
    var_c8b76776bac49972 = veh spawn_tag_origin();
  }
}

function function_86cb23df872554c7() {
  var_a76758de991d26cc = getStructArray("garage_ambulance", "targetname");
  vehicles = [];

  foreach(struct in var_a76758de991d26cc) {
    spawner = utility::getvehiclespawner("hatchback_spawner", "targetname");
    veh = spawner utility::spawn_vehicle();
    veh vehphys_parkingbrake(1);
    veh dontinterpolate();
    veh vehicle_teleport(struct.origin + (0, 0, 42), struct.angles);
    vehicles[vehicles.size] = veh;
    wait 0.1;
    veh hideallparts();
    veh.var_84f41e51a3d8d369 = spawn("script_model", veh.origin + (0, 0, -30));
    veh.var_84f41e51a3d8d369 notsolid();
    veh.var_84f41e51a3d8d369 dontinterpolate();
    veh.var_84f41e51a3d8d369.angles = veh.angles;
    veh.var_84f41e51a3d8d369 setModel("veh8_civ_lnd_palfa_static_ambulance_ukraine");
    veh.var_84f41e51a3d8d369 linkTo(veh);
    playFXOnTag(getfx("vfx_flashback_ambulance_lights"), veh.var_84f41e51a3d8d369, "tag_origin");
  }

  flag_wait("infil_vehicle_stopping");

  foreach(veh in vehicles) {
    if(isDefined(veh) && isDefined(veh.var_84f41e51a3d8d369)) {
      stopFXOnTag(getfx("vfx_flashback_ambulance_lights"), veh.var_84f41e51a3d8d369, "tag_origin");
      waitframe();
      veh.var_84f41e51a3d8d369 delete();
      veh delete();
    }
  }
}

function function_848dc4ef0ef761c3() {
  var_2ff1cd1cbe5d0e59 = spawn_tag_origin((29156, -2183, 0), (0, -140, 0));
  playFXOnTag(getfx("vfx_convoy_wt_smoke_plume_lrg_01"), var_2ff1cd1cbe5d0e59, "tag_origin");
  var_2ff1ca1cbe5d07c0 = spawn_tag_origin((26616, -400, -8), (0, -120, 0));
  playFXOnTag(getfx("vfx_convoy_wt_smoke_plume_lrg_01"), var_2ff1ca1cbe5d07c0, "tag_origin");
  flag_wait("infil_vehicle_stopping");
  stopFXOnTag(getfx("vfx_convoy_wt_smoke_plume_lrg_01"), var_2ff1cd1cbe5d0e59, "tag_origin");
  var_2ff1cd1cbe5d0e59 delaycall(0.05, &delete);
  stopFXOnTag(getfx("vfx_convoy_wt_smoke_plume_lrg_01"), var_2ff1ca1cbe5d07c0, "tag_origin");
  var_2ff1ca1cbe5d07c0 delaycall(0.05, &delete);
}

function ai_printer() {
  while(true) {
    waitframe();
  }
}

function crowd_infil_street() {
  civspawners = getspawnerarray("alpha_civ_spawners");
  var_b7c1f5150154d4b4 = getStructArray("crowd_infil_street_corner", "targetname");
  spawnerindex = 0;

  foreach(struct in var_b7c1f5150154d4b4) {
    spawner = civspawners[spawnerindex];
    spawnerindex = ter_op(spawnerindex == 0, 1, 0);
    guy = spawn_aitype(spawner.classname, spawner.origin, spawner.angles, 1);
    guy.ignoreall = 1;
    guy dontinterpolate();
    guy.ignoreall = 1;
    guy forceteleport(struct.origin, struct.angles);
    guy thread function_af42dd617ea2e0c4(struct);
    wait 0.1;
  }
}

function function_4c6c72e2e07348a7() {
  var_b7c1f5150154d4b4 = getStructArray("crowd_infil_street", "targetname");
  civspawners = getspawnerarray("alpha_civ_spawners");
  spawnerindex = 0;

  for(x = 0; x < 2; x++) {
    for(t = 0; t < 1; t++) {
      foreach(struct in var_b7c1f5150154d4b4) {
        spawner = civspawners[spawnerindex];
        spawnerindex = ter_op(spawnerindex == 0, 1, 0);
        guy = spawn_aitype(spawner.classname, spawner.origin, spawner.angles, 1);
        guy.ignoreall = 1;
        guy dontinterpolate();

        if(x == 0) {
          struct = getStruct(struct.target, "targetname");
        }

        guy forceteleport(struct.origin, struct.angles);
        guy thread function_8e587234ef083977((28130, -6260, -434));
      }

      wait 0.1;
    }

    wait 1;
  }
}

function function_e8623dcf9dbedfc3(spawners, spawnstructarray, wavecount, wavedelay) {
  level endon("stop_fake_civs");
  var_b7c1f5150154d4b4 = getStructArray(spawnstructarray, "targetname");

  for(t = 0; t < wavecount; t++) {
    foreach(struct in var_b7c1f5150154d4b4) {
      var_fee9ce0d96dd084b = random(getspawnerarray(spawners));
      var_52b7d0753afa3351 = bodyonlyspawn(var_fee9ce0d96dd084b);
      var_52b7d0753afa3351 namespace_47819225b08b445d::function_4a4895a4576a8fa9();
      var_52b7d0753afa3351 dontinterpolate();
      var_52b7d0753afa3351 assign_animtree("civ");
      var_52b7d0753afa3351.origin = struct.origin;
      var_52b7d0753afa3351.angles = struct.angles;
      var_52b7d0753afa3351 thread function_501f165fc0861dda(struct);
      level.var_72235c2923f36d22[level.var_72235c2923f36d22.size] = var_52b7d0753afa3351;
      wait 0.65 + randomfloat(1);

      if(flag("infil_vehicle_stop_at_gate") && i == 1) {
        break;
      }
    }

    wait wavedelay;
  }
}

function function_501f165fc0861dda(struct) {
  animtag = spawn_tag_origin();
  self linkTo(animtag);
  animtag thread anim_loop_solo(self, "civ_jup_fake_pnc_run");
  speed = randomfloatrange(220, 260);

  while(isDefined(struct.target)) {
    nextstruct = getStruct(struct.target, "targetname");
    dist = distance2d(struct.origin, nextstruct.origin);
    angles = vectortoangles(nextstruct.origin - struct.origin);
    time = dist / speed;
    animtag moveTo(nextstruct.origin, time);
    animtag rotateTo(angles, time);
    wait time;
    struct = getStruct(struct.target, "targetname");
  }

  animtag delete();

  if(!isDefined(self)) {
    return;
  }

  level.var_72235c2923f36d22 = array_remove(level.var_72235c2923f36d22, self);
  self delete();
}

function function_324d2c4cc1397aa4() {
  civspawners = getspawnerarray("alpha_civ_spawners");
  delaythread(3, &function_e8623dcf9dbedfc3, "alpha_civ_spawners", "crowd_infil_entrance_left", 8, 1);
  delaythread(0.1, &function_e8623dcf9dbedfc3, "alpha_civ_spawners", "crowd_infil_entrance_middle", 8, 2);
  delaythread(5, &function_e8623dcf9dbedfc3, "alpha_civ_spawners", "crowd_infil_entrance_right", 4, 2);
  delaythread(7, &function_e8623dcf9dbedfc3, "alpha_civ_spawners", "crowd_infil_entrance_pathway", 2, 2);
}

function function_8647405d0f5dbaaf() {
  while(!isDefined(level.infilvehicle)) {
    waitframe();
  }

  dist = squared(3000);

  while(!function_6db117296b9b05fa(level.infilvehicle.origin, (25795.3, -2713.21, -725.09), dist)) {
    waitframe();
  }

  wait 1;
  civspawners = getspawnerarray("alpha_civ_spawners");
  var_b7c1f5150154d4b4 = getStructArray("crowd_infil_garage_entrance", "targetname");

  for(x = 0; x < 1; x++) {
    foreach(struct in var_b7c1f5150154d4b4) {
      spawner = getspawnerarray("alpha_civ_spawners")[0];
      guy = spawn_aitype(spawner.classname, spawner.origin, spawner.angles, 1);
      guy.ignoreall = 1;
      guy dontinterpolate();
      struct = getStruct(struct.target, "targetname");
      guy forceteleport(struct.origin, struct.angles);
      guy thread function_af42dd617ea2e0c4(struct);
    }

    wait 2;
  }
}

function function_61c7a64151030e8a() {
  flag_wait("infil_vehicle_stop_at_gate");
  animnode = getStruct("animnode_makarov_anmulance", "targetname");
  thread function_cedb4221a91473b6("crowd_infil_garage_entrance_rear", 1, 0);
  dist = squared(6500);

  while(!function_6db117296b9b05fa(level.infilvehicle.origin, (31553, 2709, -864), dist)) {
    waitframe();
  }

  thread function_cedb4221a91473b6("crowd_infil_garage_field_exit", 12, 1.5);
  thread function_cedb4221a91473b6("crowd_infil_garage_field_exit_sidewalk", 11, 1);
}

function function_cedb4221a91473b6(struct_targetname, wave_count, wave_delay) {
  for(i = 0; i < wave_count; i++) {
    spawners = getspawnerarray("alpha_civ_spawners");
    structs = getStructArray(struct_targetname, "targetname");

    foreach(struct in structs) {
      spawner = spawners[randomint(spawners.size)];
      civ = spawn_aitype(spawner.classname, struct.origin, struct.angles);

      if(isDefined(civ)) {
        civ namespace_fbd1c1b57d4f60c0::function_9a4a78ea609bc08b();
        civ set_movement_speed(randomintrange(180, 186));
        civ thread go_to_node(struct);
        civ thread function_652b01263092758c();
      }
    }

    wait wave_delay;
  }
}

function function_652b01263092758c() {
  self endon("death");
  waittill_any_ents(level, "infil_team_exited_vehicle", self, "reached_path_end");
  self delete();
}

function function_af42dd617ea2e0c4(struct) {
  if(!isDefined(self)) {
    return;
  }

  self endon("death");
  self function_b661b022700ba72f("script", 1);
  self setcivstate("flee");
  self.goalradius = 50;
  self.disablearrivals = 1;
  self visiblenotsolid();

  for(struct = getStruct(struct.target, "targetname"); isDefined(struct.target); struct = getStruct(struct.target, "targetname")) {
    self setgoalpos(struct.origin);
    self waittill("goal");
  }

  self setgoalpos(struct.origin);
  waitframe();
  self waittill("goal");
  self delete();
}

function function_8e587234ef083977(origin) {
  if(!isDefined(self)) {
    return;
  }

  self endon("death");
  self function_b661b022700ba72f("script", 1);
  self setcivstate("flee");
  self.disablearrivals = 1;
  self.goalradius = 50;
  waitframe();
  self visiblenotsolid();
  self setgoalpos(origin);
  self waittill("goal");
  self delete();
}

function function_ebc7f5336bd347c5() {
  spawners = ["sedan_spawner", "hatchback_spawner", "sedan_spawner", "infil_ally_spawner", "hatchback_spawner", "sedan_spawner"];
  var_a76758de991d26cc = getStructArray("infil_entrance_stopped_vehicles", "targetname");
  vehicles = [];

  foreach(struct in var_a76758de991d26cc) {
    spawner = utility::getvehiclespawner(random(spawners), "targetname");
    veh = spawner utility::spawn_vehicle();
    veh vehphys_parkingbrake(1);
    veh dontinterpolate();
    veh vehicle_teleport(struct.origin + (0, 0, 42), struct.angles);
    vehicles[vehicles.size] = veh;
  }

  for(i = 0; i < 6; i++) {
    delay = 3.75;
    var_5a22d89fddb19d48 = 300;
    speed = 25;
    nodetargetname = "stadium_infil_veh_exit_path_start";

    if(i == 0) {
      nodetargetname = getvehiclenode("stadium_infil_veh_exit_path_start", "targetname").target;
      nodetargetname = getvehiclenode(nodetargetname, "targetname").target;
      nodetargetname = getvehiclenode(nodetargetname, "targetname").target;
      var_5a22d89fddb19d48 = 600;
      speed = 30;
      delay = 1.5;
    }

    if(i == 4) {
      delay = 4;
    }

    spawner = utility::getvehiclespawner(spawners[i], "targetname");
    veh = spawner utility::spawn_vehicle();
    veh function_28011fd603a10c83(nodetargetname);
    veh function_ebd67df953a0be11(speed);
    veh thread function_d94004634dfc9af5();
    veh setconfigvalue("path", "radiusToStep", var_5a22d89fddb19d48);
    vehicles[vehicles.size] = veh;
    wait delay;
  }

  flag_wait("infil_vehicle_stopping");

  foreach(veh in vehicles) {
    if(isDefined(veh)) {
      if(isDefined(veh.var_84f41e51a3d8d369)) {
        stopFXOnTag(getfx("vfx_flashback_ambulance_lights"), veh.var_84f41e51a3d8d369, "tag_origin");
        waitframe();
      }

      veh delete();
    }
  }
}

function function_d94004634dfc9af5() {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(getcurrentnode().target)) {
    waitframe();
  }

  self delete();
}

function function_96b496eec23333cb() {
  self.disablearrivals = 1;
  self function_b661b022700ba72f("script", 1);
  self setcivstate("flee");
  set_ignoreme(1);
  set_ignoreall(1);
  self waittill("reached_path_end");
  self delete();
}

function function_a5088ac56edf76b8() {
  fakeactorspawn();
  scripts\common\ai::gun_remove();
}

function function_ed5443e4e1482347() {
  namespace_47819225b08b445d::spawn_price();
  level.price.script_startingposition = 0;
  scripts\common\vehicle_aianim::guy_enter(level.price);
}

function function_6db117296b9b05fa(pointa, pointb, distance_squared) {
  if(!isDefined(pointa) || !isDefined(pointb)) {
    return true;
  }

  return distance2dsquared(pointa, pointb) < distance_squared;
}

function function_ebd67df953a0be11(mph, goalthreshold) {
  self endon("pause_p2p");
  self endon("death");
  waitframe();

  if(istrue(self.pace_vehicle)) {
    return;
  }

  node = default_to(self.currentnode, undefined);
  function_b61f675503083701();
  self setconfigvalue("p2p", "goalThreshold", 200);
  self setconfigvalue("p2p", "pause", 1);
  nodeindex = getvehiclenodeindex(node.targetname, "targetname");
  self setconfigvalue("path", "radiantId", nodeindex);
  var_ef52d4bc7f382914 = mph_to_ips(mph);
  self setconfigvalue("p2p", "manualSpeed", var_ef52d4bc7f382914);
  self.basespeed = var_ef52d4bc7f382914;
  self.defaultspeed = 0;

  if(isDefined(goalthreshold)) {
    self setconfigvalue("p2p", "goalThreshold", goalthreshold);
  }

  self notify("p2p_initialized");
}

function function_f3ed4610d08a5fcb(extraspeed, var_97f3305ab2c25971) {
  self endon("death");
  self endon("entitydeleted");
  extraspeed = default_to(mph_to_ips(extraspeed), 0);
  var_46575f92b66fafe7 = squared(5000);

  if(istrue(var_97f3305ab2c25971)) {
    node = getcurrentnode();

    if(isDefined(node) && isDefined(node.speed)) {
      speed = node.speed + extraspeed;
      self vehicle_setspeedimmediate(ips_to_mph(speed));
      waitframe();
      self setconfigvalue("p2p", "manualSpeed", speed);
    }
  }

  while(true) {
    node = getcurrentnode();

    if(isDefined(node) && isDefined(node.speed)) {
      speed = node.speed + extraspeed;
      self setconfigvalue("p2p", "manualSpeed", speed);
    }

    wait 0.1;
  }
}

function getcurrentnode() {
  var_6901d481c0e90cc1 = self path_getcurrentnode();
  return getvehiclenode(var_6901d481c0e90cc1);
}

function function_28011fd603a10c83(nodetargetname) {
  self.currentnode = getvehiclenode(nodetargetname, "targetname");
  nextnode = getvehiclenode(self.currentnode.target, "targetname");
  angles = vectortoangles(nextnode.origin - self.currentnode.origin);
  self dontinterpolate();
  self vehicle_teleport(self.currentnode.origin + (0, 0, 42), angles);
}

function function_b61f675503083701() {
  if(!self hascomponent("p2p")) {
    self addcomponent("p2p");
  }

  if(!self hascomponent("path")) {
    self addcomponent("path");
  }

  if(!self hascomponent("animator")) {
    self addcomponent("animator");
  }

  self setconfigvalue("p2p", "brakeAtGoal", 0);
  self setconfigvalue("p2p", "automaticFast", 1);
  self setconfigvalue("p2p", "brakeOnGoalGasbrake", 1);
  self setconfigvalue("p2p", "goalPoint", self.origin);
  self setconfigvalue("p2p", "goalThreshold", 200);
  self setconfigvalue("p2p", "throttleSpeedThreshold", 1);
  self setconfigvalue("p2p", "automaticFastTopspeedFraction", 1);
  self setconfigvalue("p2p", "throttleSpeedFarBelow", 7);
  self setconfigvalue("p2p", "throttleSpeedFarAbove", 4);
  self setconfigvalue("p2p", "throttleSpeedClose", 1);
  self setconfigvalue("p2p", "gasToStopMovement", 1);
  self setconfigvalue("p2p", "steeringMultiplier", 1);
  self setconfigvalue("path", "radiusToStep", 800);
  self.stopping = 0;
}

function function_c35a6328f38d1ec7() {
  civspawners = getspawnerarray("civ_infil_stair");
  array_spawn_function(civspawners, &namespace_fbd1c1b57d4f60c0::function_f7941b6f37af6a94);
  finalorigin = (31818, 2528, -936);
  finalangles = (0, 180, 0);
  dist = squared(1400);

  while(!function_6db117296b9b05fa(level.infilvehicle.origin, finalorigin, dist)) {
    waitframe();
  }

  array_spawn(civspawners);
}

function function_970b7a3720f72e12() {
  finalorigin = (31818, 2528, -936);
  finalangles = (0, 180, 0);
  dist = squared(1700);

  while(!function_6db117296b9b05fa(level.infilvehicle.origin, finalorigin, dist)) {
    waitframe();
  }

  if(!isDefined(level.var_72235c2923f36d22)) {
    level.var_72235c2923f36d22 = [];
  }

  structarray = getStructArray("struct_path_infil_stair", "targetname");
  var_e7494b78ddf4eb21 = function_907435ff09d5c261(structarray, "wave2");
  var_e7494a78ddf4e8ee = function_907435ff09d5c261(structarray, "wave3");

  for(i = 0; i < 2; i++) {
    foreach(struct in structarray) {
      rng = randomfloatrange(0.6, 1);
      delaythread(rng, &function_1965c4cf71bc3bd5, struct);
    }

    rng = randomfloatrange(0.8, 1.2);
    wait rng;
    i++;
  }

  for(i = 0; i < 2; i++) {
    foreach(struct in var_e7494b78ddf4eb21) {
      rng = randomfloatrange(0.6, 0.8);
      delaythread(rng, &function_1965c4cf71bc3bd5, struct);
    }

    rng = randomfloatrange(0.8, 1);
    wait rng;
    i++;
  }

  foreach(struct in var_e7494a78ddf4e8ee) {
    rng = randomfloatrange(0.4, 0.8);
    delaythread(rng, &function_1965c4cf71bc3bd5, struct);
  }
}

function function_907435ff09d5c261(structarray, script_noteworthy) {
  var_81cd6d6462bb16b5 = [];

  foreach(struct in structarray) {
    if(isDefined(struct.script_noteworthy)) {
      if(struct.script_noteworthy == script_noteworthy) {
        var_81cd6d6462bb16b5[var_81cd6d6462bb16b5.size] = struct;
      }
    }
  }

  return var_81cd6d6462bb16b5;
}

function function_1965c4cf71bc3bd5(struct) {
  var_fee9ce0d96dd084b = random(getspawnerarray("civ_concourse_far_side"));
  var_52b7d0753afa3351 = bodyonlyspawn(var_fee9ce0d96dd084b);
  var_52b7d0753afa3351 dontinterpolate();
  var_52b7d0753afa3351 assign_animtree("civ");
  var_52b7d0753afa3351.origin = struct.origin;
  var_52b7d0753afa3351.angles = struct.angles;
  var_52b7d0753afa3351 thread function_501f165fc0861dda(struct);
  level.var_72235c2923f36d22[level.var_72235c2923f36d22.size] = var_52b7d0753afa3351;
}

function function_773ae07c3412a04d() {
  struct = getStruct("struct_infil_stair_shoot", "targetname");
  aim_at(struct.origin);
  thread function_daca887213274c77();
  wait 3;
  self notify("stop_fake_fire");
}

function function_daca887213274c77() {
  self endon("stop_fake_fire");
  self endon("death");
  thread function_ea4fe48acf145061();

  while(true) {
    self shoot();
    rng = randomfloatrange(0.05, 0.2);
    wait rng;
  }
}

function function_cff91f0a515c87d6() {
  self endon("death");
  struct = getStruct("struct_infil_stair_ally", "targetname");
  enemynode = getnode("node_stair_infil_enemy", "targetname");
  utility::function_1a479cad9c3adbb1(0);
  set_goal_radius(32);
  set_ignoreme(0);
  set_ignoreall(0);
  disable_arrivals();
  self.animname = "infil_stairs_enemy";
  level.price disable_pain();
  level.price set_goal_radius(32);
  animstruct = getStruct("struct_anim_infil_stair_takedown", "targetname");
  actors = [self, level.price];
  animstruct anim_reach_solo(level.price, "infil_stairs_takedown");
  set_allowdeath(0);
  animstruct anim_single(actors, "infil_stairs_takedown");
  die_frozen();
}

function function_8eeaaa04a65932cd(var_408d70e79cfd9201) {
  var_408d70e79cfd9201 waittill("death");
  level.price enable_pain();

  if(isalive(self)) {
    set_ignoreme(0);
    self.ignoreall = 0;
    set_favoriteenemy(level.price);
    self setgoalpos(level.price.origin);
  }
}

function function_c001b0d2430ed05d() {
  self endon("death");
  flag_wait("infil_stairs_stair");
  set_ignoreme(0);
  self.ignoreall = 0;
  scripts\engine\sp\utility::disable_dontevershoot();
  scripts\engine\sp\utility::set_goal_radius(32);
  node = getnode("node_stair_infil_top_enemy", "targetname");
  scripts\sp\spawner::go_to_node(node);
  scripts\engine\sp\utility::set_goal_radius(32);
  self allowedstances("crouch");
}

function function_c4bbc2c97e77452f() {
  trigger_wait_targetname("trigger_infil_stairs_stairs");
  flag_set("infil_stairs_stair");
}

function function_ea4fe48acf145061() {
  self endon("death");
  flag_wait("infil_stairs_stair");
  self notify("stop_fake_fire");
  set_ignoreall(0);
}

function init_dialogue() {
  level.player_dialogue_struct = spawnStruct();
  level.player_dialogue_struct.origin = (0, 0, 0);
  level.player_dialogue_struct.team = "ally";
  level.player_dialogue_struct.name = "Soap";
  level.var_bf6af2923ec62287 = spawnStruct();
  level.var_bf6af2923ec62287.origin = (0, 0, 0);
  level.var_bf6af2923ec62287.team = "allies";
  level.var_bf6af2923ec62287.name = "Captain Price";
  level.var_de1090d70382f016 = spawnStruct();
  level.var_de1090d70382f016.origin = (0, 0, 0);
  level.var_de1090d70382f016.team = "allies";
  level.var_de1090d70382f016.name = "Yasim";
}

function dialogue(string, delay, endonentities, endonmessages, overradio) {
  self endon("death");

  if(isDefined(endonentities) && isDefined(endonmessages)) {
    if(!isarray(endonentities)) {
      endonentities = [endonentities];
    }

    if(!isarray(endonmessages)) {
      endonmessages = [endonmessages];
    }

    foreach(entity in endonentities) {
      foreach(message in endonmessages) {
        entity endon(message);
      }
    }
  }

  if(isDefined(delay) && delay) {
    wait delay;
  }

  flag_set("level_dialogue_playing");

  if(soundexists(string)) {
    var_5daf9049006645fb = lookupsoundlength(string) * 0.001;
    delaythread(var_5daf9049006645fb, &flag_clear, "level_dialogue_playing");

    if(isPlayer(self)) {
      smart_player_dialogue(string);
    } else if(istrue(overradio)) {
      smart_radio_dialogue(string);
    } else {
      smart_dialogue(string);
    }

    self notify("DIALOGUE_FINISHED_NOTIFY");
    return;
  }

  if(is_equal(self.team, "axis")) {
    color = "^1";
  } else {
    color = "^2";
  }

  if(istrue(overradio)) {
    var_348236a6e4d0dd31 = color + self.name + " Over Radio" + ": " + "^7" + string;
  } else {
    var_348236a6e4d0dd31 = color + self.name + ": " + "^7" + string;
  }

  thread dialogue_proc(var_348236a6e4d0dd31, delay);
}

function dialogue_proc(string, delay) {
  level notify("new_dialogue");
  level endon("new_dialogue");
  var_4321c6192701317e = 0.3;
  holdtime = 5;
  fadetime = 2;
  fontscale = 1.2;
  var_b54520c420443a7c = int(5.9 * fontscale);
  var_d102c78475d99749 = int(24 * fontscale);
  endy = 100;

  if(isDefined(level.dialoguehud)) {
    foreach(hud in level.dialoguehud) {
      hud fadeovertime(var_4321c6192701317e);
      hud.alpha = 0;
      hud delaycall(var_4321c6192701317e, &destroy);
    }
  }

  bg = newhudelem();
  text = newhudelem();
  min_width = 350;
  width = int(max(string.size * var_b54520c420443a7c, min_width));
  array = [bg, text];
  level.dialoguehud = array;

  foreach(hud in array) {
    hud.alignx = "center";
    hud.aligny = "middle";
    hud.x = 320;
    hud.y = var_d102c78475d99749 * -1;
    hud.sort = 5;
  }

  bg.alpha = 0.5;
  bg setshader("black", width, var_d102c78475d99749);
  text settext(string);
  text.fontscale = fontscale;

  foreach(hud in array) {
    hud moveovertime(var_4321c6192701317e);
    hud.y = endy;
  }

  wait var_4321c6192701317e + holdtime;

  foreach(hud in array) {
    hud fadeovertime(fadetime);
    hud.alpha = 0;
  }

  wait fadetime;

  foreach(hud in array) {
    hud destroy();
  }

  level.dialoguehud = undefined;
}

function function_6528e5d970e1af01() {
  if(isDefined(level.infilvehicle)) {
    DevOp(0x94);
    return;
  }

  level.infilvehicle = spawn_anim_model("infilVehicle", (0, 0, 0), (0, 0, 0));
  level.infilvehicle dontinterpolate();
  level.player.rig = spawn_anim_model("player_rig");
  level.infilvehicle.actors = [level.price, level.redshirt, level.player.rig];
  level.infilvehicle hidepart("tag_window_front_right");
  level.infilvehicle hidepart("tag_wheel_center_front_left_flat");
  level.infilvehicle hidepart("tag_wheel_center_front_right_flat");
  level.infilvehicle hidepart("tag_wheel_center_back_left_flat");
  level.infilvehicle hidepart("tag_wheel_center_back_right_flat");
  level.infilvehicle.collision = getEnt("infilvan_collision_root", "targetname");

  if(isDefined(level.infilvehicle.collision)) {
    level.infilvehicle.collision linkTo(level.infilvehicle);
    level.infilvehicle.colision.origin = level.infilvehicle.origin;
    level.infilvehicle.colision.angles = level.infilvehicle.angles;
  }

  level.infilvehicle.var_e6f87d9c1d194fa3 = spawn_script_origin(level.infilvehicle.origin + (40, 0, 20));
  level.infilvehicle.var_e6f87d9c1d194fa3 linkTo(level.infilvehicle, "tag_origin");
  level.infilvehicle.var_fdd8d757a4e3c42d = spawn_script_origin(level.infilvehicle.origin + (-45, 0, 20));
  level.infilvehicle.var_fdd8d757a4e3c42d linkTo(level.infilvehicle, "tag_origin");
}

function infil_animation() {
  assert(isDefined(level.infilvehicle));
  level.player setcinematicmotionoverride("disabled");
  var_c769aade43212080 = getStruct("animnode_stadium_infil", "targetname");
  var_c769aade43212080 anim_first_frame_solo(level.infilvehicle, "fbk_0110");
  level.anim_soap = namespace_47819225b08b445d::function_320fe24554ccda96();
  level.infilvehicle.actors = array_add(level.infilvehicle.actors, level.anim_soap);

  foreach(actor in level.infilvehicle.actors) {
    level.infilvehicle anim_first_frame_solo(actor, "fbk_0110", "tag_body");
    actor linkTo(level.infilvehicle, "tag_body");
  }

  level.player function_3029f5e4bbc0397d(1, 0, 0, 0, 0, 1);
  var_a0c6c69d547e0f68 = ["body_c_jup_sp_civ_soccerfan_f_01_uk", "body_c_jup_sp_civ_soccerfan_f_01_russia"];
  male_spawner = getspawner("alpha_civ_spawner_male", "script_noteworthy");
  female_spawner = getspawner("alpha_civ_spawner_female", "script_noteworthy");
  civ_spawners = [male_spawner, female_spawner];
  var_1e889f99ab457ac0 = [level.infilvehicle];

  for(i = 1; i < 5; i++) {
    animname = "infil_civ0" + i;
    spawner = random(civ_spawners);

    if(animname == "infil_civ01") {
      spawner = female_spawner;
    } else if(animname == "infil_civ02") {
      continue;
    } else if(animname == "infil_civ03") {
      spawner = female_spawner;
    } else if(animname == "infil_civ04") {
      spawner = female_spawner;
    }

    guy = bodyonlyspawn(spawner);
    guy.animname = animname;

    if(animname == "infil_civ01") {
      guy detach(guy.headmodel);
      guy.headmodel = "head_sc_f_stokes_civ_flashback";
      guy attach(guy.headmodel);
      guy setModel(random(var_a0c6c69d547e0f68));
      guy notify("disable_proximity_yelling");
    }

    var_1e889f99ab457ac0[var_1e889f99ab457ac0.size] = guy;
  }

  cars = ["policecar01"];

  for(i = 1; i < 2; i++) {
    cars[cars.size] = "truck0" + i;
  }

  for(i = 1; i < 24; i++) {
    if(i == 18) {
      continue;
    }

    if(i < 10) {
      cars[cars.size] = "car0" + i;
      continue;
    }

    cars[cars.size] = "car" + i;
  }

  foreach(animname in cars) {
    var_c80798b7d79ae0b6 = "passenger_infil";

    switch (animname) {
      case #"hash_5c4b997773ad4583":
        has_driver = 1;
        has_passenger = 0;
        var_c80798b7d79ae0b6 = "outside_driver";
        break;
      case #"hash_5c52287773b2a3ce":
        has_driver = 0;
        has_passenger = 0;
        break;
      case #"hash_5c4ba27773ad53ae":
      case #"hash_5c4ba37773ad5541":
        var_c80798b7d79ae0b6 = "passenger_infil_crash";
        has_driver = 1;
        has_passenger = 0;
        break;
      default:
        has_driver = 1;
        has_passenger = 0;
        break;
    }

    model = namespace_47819225b08b445d::function_975802ac7c0a7333(animname, undefined, undefined, undefined, has_driver, has_passenger);
    model thread function_4ade1fffc0fcce5d(var_c769aade43212080, "fbk_0110", var_c80798b7d79ae0b6);
    var_1e889f99ab457ac0[var_1e889f99ab457ac0.size] = model;
    model dontinterpolate();
    model thread namespace_47819225b08b445d::car_exhaust();

    if(animname == "car11" || animname == "car21") {
      model.delay_delete = 1;
    }
  }

  level.var_1e889f99ab457ac0 = var_1e889f99ab457ac0;
  level.infilvehicle dontinterpolate();
  flag_set("start_110");
  thread function_4ba314cdb049b5c3();
  level.infilvehicle thread function_ecd3b26cc3af43f5();
  var_c769aade43212080 thread anim_single(var_1e889f99ab457ac0, "fbk_0110");
  flag_wait("infil_vehicle_stop_at_gate");
  var_1e889f99ab457ac0 = array_remove(var_1e889f99ab457ac0, level.infilvehicle);
  wait 7;
  stop_exploder("intro_smoke_plume_lrg");
  array_delete(array_removeundefined(var_1e889f99ab457ac0));
}

function function_9b282a37a4010f07() {
  self endon("death");

  while(true) {
    print3d(self.origin, self.animname, (1, 0, 0), 1, 1, 1);

    wait 0.1;
  }
}

function function_4ba314cdb049b5c3() {
  while(level.player.origin[2] > -759) {
    waitframe();
  }

  level notify("stop_fake_civs");
  array_delete(level.var_72235c2923f36d22);
}

function function_aeff8d93ef0f673c() {
  var_7abed1bd3806d09b = [];
  var_7abed1bd3806d09b["m2"] = 1;
  var_7abed1bd3806d09b["m3"] = 1;
  var_7abed1bd3806d09b["m4"] = 1;
  var_7abed1bd3806d09b["f1"] = 1;
  var_7abed1bd3806d09b["f3"] = 1;
  var_7abed1bd3806d09b["m10"] = 1;
  var_7abed1bd3806d09b["m11"] = 1;
  var_7abed1bd3806d09b["f5"] = 1;
  var_7abed1bd3806d09b["f6"] = 1;
  var_7abed1bd3806d09b["m3"] = 1;
  var_7abed1bd3806d09b["m13"] = 1;
  var_b492f9ebb3eae257 = getspawner("alpha_civ_spawner_female", "script_noteworthy");
  var_a24778a219c48788 = getspawner("alpha_civ_spawner_male", "script_noteworthy");
  streetnode = {
    #angles: (0, 0, 0), #origin: (26500, -6400, -455)
  };
  var_111d7a847ff2ac50 = {
    #angles: (0, 0, 0), #origin: (27400, -5400, -456)
  };
  var_eb146cfe5840f516 = utility::function_df57c8a03e293db4("infil_street");
  var_46fa2cc1676fbdd6 = utility::function_df57c8a03e293db4("stadium_flee");
  var_49e7f0666b848eaa = [];
  var_73c9dea9dc532d9b = [];
  var_cb658cabeaf85909 = [];
  var_308a474d51a53907 = 15;

  foreach(i, name in var_eb146cfe5840f516) {
    spawner = name[0] == "f" ? var_b492f9ebb3eae257 : var_a24778a219c48788;
    spawner.count++;
    actor = spawner scripts\sp\fakeactor::spawndrone();
    actor namespace_47819225b08b445d::function_4a4895a4576a8fa9();
    actor.animname = name;
    actor function_9d2a5a3f7d9befe4();
    streetnode animation::anim_first_frame_solo(actor, "infil_street");
    var_73c9dea9dc532d9b[var_73c9dea9dc532d9b.size] = actor;

    if(isDefined(var_7abed1bd3806d09b[actor.animname])) {
      actor.phone = spawn("script_model", (0, 0, 0));
      actor.phone setModel("misc_wm_smartphone_civilian_canal");
      actor.phone linkTo(actor, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
      actor thread utility::delete_on_death(actor.phone);
    }

    if(i == var_308a474d51a53907) {
      break;
    }

    if(i % 4 == 0) {
      waitframe();
    }
  }

  foreach(i, name in var_46fa2cc1676fbdd6) {
    spawner = name[0] == "f" ? var_b492f9ebb3eae257 : var_a24778a219c48788;
    spawner.count++;
    actor = spawner scripts\sp\fakeactor::spawndrone();
    actor namespace_47819225b08b445d::function_4a4895a4576a8fa9();
    actor.animname = name;
    actor function_9d2a5a3f7d9befe4();
    var_111d7a847ff2ac50 animation::anim_first_frame_solo(actor, "stadium_flee");
    var_cb658cabeaf85909[var_cb658cabeaf85909.size] = actor;

    if(i == var_308a474d51a53907) {
      break;
    }

    if(i % 4 == 0) {
      waitframe();
    }
  }

  car = utility::spawn_anim_model("stadium_flee_car", (0, 0, 0), (0, 0, 0));
  var_a24778a219c48788.count++;
  driver = var_a24778a219c48788 scripts\sp\fakeactor::spawndrone();
  driver namespace_47819225b08b445d::function_4a4895a4576a8fa9();
  driver.animname = "stadium_flee_driver";
  driver function_9d2a5a3f7d9befe4();
  car animation::anim_first_frame_solo(driver, "stadium_flee_drive", "tag_body");
  car thread animation::anim_single_solo(driver, "stadium_flee_drive", "tag_body");
  waitframe();
  driver linkTo(car);
  waitframe();
  var_111d7a847ff2ac50 animation::anim_first_frame_solo(car, "stadium_flee_drive");
  flag_set("infil_street_civs_ready");
  flag_wait("start_110");

  foreach(actor in var_73c9dea9dc532d9b) {
    streetnode thread animation::anim_single_solo(actor, "infil_street");
  }

  foreach(actor in var_cb658cabeaf85909) {
    var_111d7a847ff2ac50 thread animation::anim_single_solo(actor, "stadium_flee");
  }

  var_111d7a847ff2ac50 thread animation::anim_single_solo(car, "stadium_flee_drive");
  wait 6;
  var_49e7f0666b848eaa = array_combine(var_73c9dea9dc532d9b, var_cb658cabeaf85909, level.var_1e889f99ab457ac0);
  var_49e7f0666b848eaa[var_49e7f0666b848eaa.size] = car;
  var_49e7f0666b848eaa[var_49e7f0666b848eaa.size] = driver;

  while(true) {
    foreach(actor in var_49e7f0666b848eaa) {
      if(actor == level.infilvehicle || istrue(actor.delay_delete)) {
        continue;
      }

      if(isDefined(actor) && !isDefined(actor.var_cf1e31fc18a3308c) && !level.infilvehicle math::is_point_in_front(actor.origin)) {
        actor.var_cf1e31fc18a3308c = 1;
        actor delaycall(2, &delete);
      }
    }

    var_49e7f0666b848eaa = utility::array_removeundefined(var_49e7f0666b848eaa);

    if(!var_49e7f0666b848eaa.size) {
      return;
    }

    waitframe();
  }
}

function function_4fde87e878d0a64c() {
  var_c769aade43212080 = getStruct("animnode_stadium_infil", "targetname");
  level.var_896b312fc167ed76 = [];

  for(i = 1; i < 10; i++) {
    if(i == 7) {
      continue;
    }

    num_prefix = "";

    if(i < 10) {
      num_prefix = "0";
    }

    has_driver = 1;
    var_2fcf4828f84024 = undefined;
    has_passenger = cointoss();
    animname = "garage_car" + num_prefix + i;
    passenger_anim = "passenger_infil";

    switch (animname) {
      case #"hash_764e1ea7daf64c7a":
        has_driver = 0;
        has_passenger = 0;
        break;
      case #"hash_764e1fa7daf64e0d":
        has_driver = 1;
        has_passenger = 0;
        break;
      case #"hash_764e15a7daf63e4f":
        var_2fcf4828f84024 = 0;
        has_passenger = 0;
        passenger_anim = "fbk_0150";
      default:
        break;
    }

    model = namespace_47819225b08b445d::function_975802ac7c0a7333(animname, undefined, undefined, undefined, has_driver, has_passenger, var_2fcf4828f84024);
    model thread function_4ade1fffc0fcce5d(var_c769aade43212080, "fbk_0150", passenger_anim);

    switch (animname) {
      case #"hash_764e1ea7daf64c7a":
        playFXOnTag(getfx("vfx_flashback_ambulance_lights_mak"), model, "tag_body_animate");
        break;
      case #"hash_764e15a7daf63e4f":
        model.driver detach(model.driver.headmodel);
        model.driver.headmodel = "head_sc_f_mostafavi_civ_flashback";
        model.driver attach(model.driver.headmodel);
        break;
      default:
        break;
    }

    level.var_896b312fc167ed76[level.var_896b312fc167ed76.size] = model;
    model dontinterpolate();
  }

  for(i = 1; i < 5; i++) {
    is_male = 1;
    var_ebb333c01d33e5a4 = 0;
    animname = "civ0" + i;

    switch (animname) {
      case #"hash_743e44a7aaadb764":
        is_male = 1;
        var_ebb333c01d33e5a4 = 1;
        break;
      case #"hash_743e43a7aaadb5d1":
        is_male = 0;
        var_ebb333c01d33e5a4 = 1;
        break;
    }

    civ = namespace_47819225b08b445d::spawn_civ(undefined, undefined, is_male, undefined, undefined, undefined, var_ebb333c01d33e5a4);

    if(animname == "civ03") {
      civ setModel("body_c_jup_sp_civ_soccerfan_f_01_russia");
    } else if(animname == "civ04") {
      civ detach(civ.headmodel);
      civ.headmodel = "head_sc_f_mostafavi_civ_flashback";
      civ attach(civ.headmodel);
    }

    civ.animname = animname;
    level.var_896b312fc167ed76[level.var_896b312fc167ed76.size] = civ;
    animname = "civ0" + i + "_f";
    civ_f = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 0);
    civ_f.animname = animname;
    level.var_896b312fc167ed76[level.var_896b312fc167ed76.size] = civ_f;
  }

  for(i = 5; i < 8; i++) {
    animname = "civ0" + i;
    civ = namespace_47819225b08b445d::spawn_civ();
    civ.animname = animname;
    level.var_896b312fc167ed76[level.var_896b312fc167ed76.size] = civ;
  }

  var_c769aade43212080 anim_first_frame(level.var_896b312fc167ed76, "fbk_0150");
}

function function_3cc31886e58a2d52(bool) {
  if(istrue(bool) && !ent_flag("scripted_headlights")) {
    foreach(name in ["tag_light_front_left", "tag_light_front_right"]) {
      playFXOnTag(utility::getfx("vfx_flashback_car_headlights_01"), self, name);
    }

    ent_flag_set("script_headlights");
    return;
  }

  if(ent_flag("script_headlights")) {
    foreach(name in ["tag_light_front_left", "tag_light_front_right"]) {
      stopFXOnTag(utility::getfx("vfx_flashback_car_headlights_01"), self, name);
    }

    ent_flag_clear("script_headlights");
  }
}

function function_4ade1fffc0fcce5d(animnode, car_anim, passenger_anim) {
  animnode anim_first_frame_solo(self, car_anim);
  waitframe();

  if(!isDefined(self.occupants)) {
    return;
  }

  foreach(occupant in self.occupants) {
    if(array_contains_key(level.scr_anim, occupant.animname)) {
      anim_first_frame_solo(occupant, passenger_anim, "tag_body");
      occupant linkTo(self, "tag_body", (0, 0, 0), (0, 0, 0));
      thread anim_single_solo(occupant, passenger_anim, "tag_body");
      continue;
    }

    iprintln(occupant.animname + "<dev string:x1c>");
  }
}

function garage_animation() {
  assert(isDefined(level.var_896b312fc167ed76) && isDefined(level.infilvehicle));
  animnode = getStruct("animnode_stadium_infil", "targetname");
  thread function_945261e44d87465e();
  thread function_5ce23b7a004b60d3();
  array_thread(level.var_896b312fc167ed76, &cleanup_check);
  animnode thread anim_single(level.var_896b312fc167ed76, "fbk_0150");

  if(level.start_point == "infil_garage") {
    var_c769aade43212080 = getStruct("animnode_stadium_infil", "targetname");
    var_c769aade43212080 thread anim_single([level.infilvehicle], "fbk_0110");
    level.infilvehicle thread function_ecd3b26cc3af43f5();
    waitframe();
    var_5421ffd7016c2888 = level.player.rig getanim("fbk_0110");
    var_537c7073c5679486 = get_notetrack_time(var_5421ffd7016c2888, "150_start");
    var_fdf45c8bbb0321c = getanimlength(var_5421ffd7016c2888);
    teleporters = array_add(level.infilvehicle.actors, level.infilvehicle);
    anim_set_time(teleporters, "fbk_0110", var_537c7073c5679486 / var_fdf45c8bbb0321c);
    glass_debris = getEntArray("infil_vehicle_window_glass_debris", "targetname");

    if(isDefined(glass_debris)) {
      array_call(glass_debris, &hide);
    }

    wait var_fdf45c8bbb0321c - var_537c7073c5679486;
  }
}

function function_ecd3b26cc3af43f5() {
  anim_single(self.actors, "fbk_0110", "tag_body");
  level.price namespace_47819225b08b445d::function_264ea5c38c1ae771();
  flag_set("infil_vehicle_stopping");
}

function cleanup_check() {
  if(isDefined(level.infilvehicle) && self == level.infilvehicle) {
    return;
  }

  self waittillmatch("single anim", "end");

  if(ent_flag("script_headlights")) {}

  wait 1;

  if(isDefined(self)) {
    self delete();
  }
}

function function_f66e00bbe47638b6() {
  animnode = getStruct("animnode_makarov_anmulance", "targetname");
  duffel_bag = spawn_anim_model("duffel_bag");
  makarov = namespace_47819225b08b445d::function_dc2aa213aa5830aa();
  makarov detach("zip_tie_handcuffs_tag_accessory_left_b", "tag_accessory_left");
  makarov detach(makarov.headmodel);
  makarov.headmodel = "c_jup_head_hero_makarov";
  makarov attach(makarov.headmodel);
  makarov setModel("body_c_jup_sp_villain_makarov_paramedic");
  makarov scripts\anim\shared::placeweaponon(makarov.sidearm, "none");
  makarov.script_friendname = "";
  spawner = getspawner("enemy_concourse_hostage", "targetname");
  enemy = spawn_aitype(spawner.classname, spawner.origin, spawner.angles, 1);
  enemy.animname = "ambulace_enemy";
  enemy gun_remove();
  animators = [makarov, enemy, duffel_bag];

  foreach(animated_character in animators) {
    animated_character.team = "allies";
  }

  animnode animation::anim_single(animators, "garage_ambulance_hide");
  animnode namespace_47819225b08b445d::function_b5b7c971ef980a7(animators, "garage_ambulance_hide");
  wait 1;
  array_delete(animators);
}

function function_945261e44d87465e() {
  thread function_840b1feb8f7f53a7();
  scene_name = "fbk_0185";
  animnode = getStruct("animnode_police_slaughter", "targetname");
  animators = [];
  level.var_55f8dffab2307d70 = [];

  for(i = 1; i < 4; i++) {
    guy = namespace_47819225b08b445d::spawn_civ();
    guy.animname = "civ0" + i;
    guy thread namespace_47819225b08b445d::kill_on_anim_end();
    level.var_55f8dffab2307d70[level.var_55f8dffab2307d70.size] = guy;
    animators[animators.size] = guy;
  }

  level.slaughter_police = [];

  for(i = 1; i < 3; i++) {
    spawner = getspawner("enemy_infil_smg", "targetname");
    guy = spawn_aitype(spawner.classname, spawner.origin, spawner.angles, 1);
    guy.animname = "slaughter_police0" + i;
    guy.script_noteworthy = guy.animname;
    guy.targetname = guy.animname;
    guy.goalradius = 32;
    guy enableavoidance(0);
    guy namespace_47819225b08b445d::function_17177a175dd8f243(make_weapon("iw9_ar_akilo_sp"));
    level.slaughter_police[level.slaughter_police.size] = guy;
    animators[animators.size] = guy;
  }

  array_call(animators, &dontinterpolate);
  animnode anim_first_frame(animators, scene_name);
  flag_wait("nt_start_garage_exit");
  thread utility::autosave_by_name();
  animnode anim_single(animators, scene_name);
  thread function_48d9c95f8d3e3c13();
  thread function_f322eac40147066e();
  namespace_47819225b08b445d::function_5da13e5444950c67(level.slaughter_police, "slaughter_police_dead");
}

function function_48d9c95f8d3e3c13() {
  police01 = get_living_ai("slaughter_police01", "script_noteworthy");
  police01 endon("death");
  police01 namespace_47819225b08b445d::function_264ea5c38c1ae771();
  police01.favoriteenemy = level.price;
  trig = getEnt("trigger_player_vehicle_exit", "targetname");

  while(level.player istouching(trig)) {
    waitframe();
  }

  police01.favoriteenemy = undefined;
  flag_wait("radflag_player_stairs_top");
  police01 kill();
}

function function_f322eac40147066e() {
  police02 = get_living_ai("slaughter_police02", "script_noteworthy");
  police02 endon("death");
  police02 namespace_47819225b08b445d::function_264ea5c38c1ae771();
  police02.favoriteenemy = level.player;
  police02.og_accuracy = police02.accuracy;
  police02.accuracy = 0.2;
  police02 setgoalpos(police02.origin, 32);
  wait 2;
  police02.accuracy = police02.og_accuracy;
  flag_wait("radflag_player_stairs_top");
  police02 kill();
}

function function_28091e100e1025ec() {
  if(level.start_point == "infil_stairs") {
    var_c769aade43212080 = getStruct("animnode_stadium_infil", "targetname");
    var_c769aade43212080 thread anim_single_solo(level.infilvehicle, "fbk_0110");
    level.infilvehicle thread function_ecd3b26cc3af43f5();
    waitframe();
    var_5421ffd7016c2888 = level.player.rig getanim("fbk_0110");
    var_537c7073c5679486 = get_notetrack_time(var_5421ffd7016c2888, "start_0185");
    var_fd5189a667b79aeb = getanimlength(var_5421ffd7016c2888);
    teleporters = array_add(level.infilvehicle.actors, level.infilvehicle);
    anim_set_time(teleporters, "fbk_0110", var_537c7073c5679486 / var_fd5189a667b79aeb);
    glass_debris = getEntArray("infil_vehicle_window_glass_debris", "targetname");

    if(isDefined(glass_debris)) {
      array_call(glass_debris, &hide);
    }

    wait var_fd5189a667b79aeb - var_537c7073c5679486;
  }

  level.player playSound("scn_fb_intro_37_garage_windshield_impact");
  level.player thread player_exit_vehicle();
  level.price namespace_47819225b08b445d::function_c28854ded28e9b4d("tag_stowed_back");
  array_thread([level.redshirt, level.price], &function_8f0ed46ddcb995b2);
  flag_set("infil_team_exited_vehicle");
  activate_trigger_with_targetname("color_allies_exit_vehicle");
  wait 5;
  level.infilvehicle.var_e6f87d9c1d194fa3 delete();
  level.infilvehicle.var_fdd8d757a4e3c42d delete();
}

function function_8f0ed46ddcb995b2() {
  self unlink();
  level.infilvehicle anim_single_solo(self, "fbk_0190_vehicle_exit", "tag_body");
}

function function_5ce23b7a004b60d3() {
  scene_name = "fbk_0200";
  animnode = getStruct("animnode_stairs_police_kill", "targetname");
  animators = [];
  level.var_fd0361e251cefdbb = [];

  for(i = 1; i < 5; i++) {
    animname = "civ0" + i;
    spawner = undefined;

    if(animname == "civ02") {
      guy = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 0);
    } else {
      guy = namespace_47819225b08b445d::spawn_civ(undefined, undefined, 1);
    }

    guy thread namespace_47819225b08b445d::kill_on_anim_end();
    guy.animname = animname;
    guy.targetname = animname;
    level.var_fd0361e251cefdbb[level.var_fd0361e251cefdbb.size] = guy;
    animators[animators.size] = guy;
  }

  level.stairs_police = [];

  for(i = 1; i < 3; i++) {
    spawner = getspawner("enemy_infil_ar", "targetname");
    guy = utility::spawn_aitype(spawner.classname, spawner.origin, spawner.angles, 1);
    guy.animname = "police0" + i;
    guy.targetname = guy.animname;
    guy set_allowdeath(1);
    level.stairs_police[level.stairs_police.size] = guy;
    animators[animators.size] = guy;
  }

  array_call(animators, &dontinterpolate);
  police01 = utility::get_living_ai("police01", "targetname");
  police02 = utility::get_living_ai("police02", "targetname");
  animnode animation::anim_first_frame(animators, "fbk_0200");
  animators = array_remove(animators, police01);
  animators = array_remove(animators, police02);
  flag_wait("nt_start_garage_exit");
  wait 2.5;
  thread function_8b9129e2fb58c629();
  police01 thread function_912f475ff06632fd(animnode);
  police02 thread function_8b50cebbae4db544(animnode);
  animnode animation::anim_single(animators, "fbk_0200");
  thread namespace_47819225b08b445d::function_5da13e5444950c67(level.stairs_police, "infil_stairs_police_kill_scene_done");
}

function function_8b9129e2fb58c629() {
  array_call(level.allies, &setthreatbiasgroup, "infil_allies");

  foreach(enemy in level.stairs_police) {
    if(!is_dead_or_dying(enemy)) {
      enemy setthreatbiasgroup("attack_infil_allies");
    }
  }

  flag_wait("player_exited_infil_vehicle");
  thread function_e6658a672b0337a6();
  trigger = getEnt("trigger_player_vehicle_exit", "targetname");

  while(level.player istouching(trigger) && !flag("stairs_scene_player_attacked")) {
    waitframe();
  }

  level notify("disable_stairs_police_threat_bias");

  foreach(enemy in level.stairs_police) {
    if(!is_dead_or_dying(enemy)) {
      enemy setthreatbiasgroup("axis");
    }
  }

  array_call(level.allies, &setthreatbiasgroup, "allies");
}

function function_e6658a672b0337a6() {
  level endon("disable_stairs_police_threat_bias");
  flag_init("stairs_scene_player_attacked");

  while(true) {
    result = function_3c010dc06eabfe5f(level.stairs_police[0], "damage", level.stairs_police[1], "damage");

    if(isDefined(result[1]) && result[1] == level.player) {
      break;
    }
  }

  flag_set("stairs_scene_player_attacked");
}

function function_912f475ff06632fd(animnode) {
  self endon("death");
  animnode anim_first_frame_solo(self, "fbk_0200");
  animnode anim_single_solo(self, "fbk_0200");
  self setgoalpos(self.origin, 32);

  for(i = 0;; i++) {
    if(!namespace_47819225b08b445d::function_fe5fb53651d57aa2()) {
      self shoot(self.accuracy, self.favoriteenemy);
    }

    wait 0.1;

    if(i % 3 == 0) {
      wait 1;
    }
  }
}

function function_bf85c23a29b3bda1(animnode) {
  magic_bullet_shield();
  self waittill("damage");
  stop_magic_bullet_shield();
  self stopanimScripted();
  waitframe();
  animnode anim_single_solo(self, "fbk_0200_death");
  die_frozen();
}

function function_8b50cebbae4db544(animnode) {
  self endon("death");
  animnode anim_first_frame_solo(self, "fbk_0200");
  animnode anim_single_solo(self, "fbk_0200");
  self.script_forcegoal = 1;
  self setgoalpos(self.origin, 32);
  self.favoriteenemy = level.price;
  flag_wait("radtrig_player_in_stairwell");
  self.favoriteenemy = undefined;
}

function player_exit_vehicle() {
  thread function_47bb6f8971f5ac7d();
  self.rig show();
  var_c769aade43212080 = getStruct("animnode_stadium_infil", "targetname");
  var_c769aade43212080 thread anim_single_solo(level.infilvehicle, "fbk_0190_plr");
  lerp_time = 0.3;
  level.player lerpviewangleclamp(lerp_time, lerp_time * 0.2, lerp_time * 0.5, 5, 5, 5, 5);
  level.infilvehicle anim_single_solo(self.rig, "fbk_0190", "tag_body");
  flag_set("player_exited_infil_vehicle");
  var_c769aade43212080 anim_first_frame_solo(level.infilvehicle, "fbk_0190_idle");
  self unlink();
}

function function_47bb6f8971f5ac7d() {
  shot_start = getStruct("spiderweb_shot_start", "targetname");
  shot_end = getStruct(shot_start.target, "targetname");
  shot_num = 1;
  level.player scripts\common\values::set_array("windwhield_spiderweb", ["damage", "damageshield"], 0);

  while(true) {
    police01 = get_living_ai("slaughter_police01", "script_noteworthy");
    shot_origin = police01 getshootfrompos();
    shooter = random(level.slaughter_police);
    magicbullet("iw9_sm_aviktor_sp", shot_origin, shot_end.origin, shooter, shooter);
    thread play_sound_in_space("infil_vehicle_glass_shot", level.player.origin);
    wait 0.1;

    if(isDefined(shot_end.target)) {
      shot_end = getStruct(shot_end.target, "targetname");
      shot_num++;

      if(shot_num == 10) {
        wait 0.5;
      }

      continue;
    }

    break;
  }

  if(!flag("slaughter_police_dead")) {
    level.infilvehicle function_6b9d4d82187476d2("tag_window_front_left", 0);
    level.infilvehicle hidepart("tag_mirror_right");
    mirror = spawn("script_model", (0, 0, 0));
    mirror setModel("veh9_civ_lnd_suv_overland_2016_tech_mirror_r");
    mirror.origin = level.infilvehicle gettagorigin("tag_mirror_right");
    mirror.angles = level.infilvehicle gettagangles("tag_mirror_right");
    mirror physicslaunchserver(mirror.origin, (0, 0, -5));
    glass_debris = getEntArray("infil_vehicle_window_glass_debris", "targetname");

    foreach(debris in glass_debris) {
      if(is_equal(debris.script_noteworthy, "player_glass")) {
        debris delete();
        continue;
      }

      debris show();
    }
  }

  wait 2;
  scripts\common\values::reset_all("windwhield_spiderweb");
}

function function_6b9d4d82187476d2(window_tag, var_b2a8254ba688e309) {
  var_b62c2536ce23d7ec = self gettagorigin(window_tag);

  if(istrue(var_b2a8254ba688e309)) {
    thread play_sound_in_space("infil_vehicle_glass_shatter", var_b62c2536ce23d7ec);
  }

  self hidepart(window_tag);
  playFX(getfx("vfx_vehicle_glass_shatter"), var_b62c2536ce23d7ec);
}

function function_59a8c12ec197d91e() {
  level endon("price_teleported_to_stairs");
  result = flag_wait_either_return("infil_stairs_police_kill_scene_done", "radflag_price_to_stairs");
  level.price namespace_47819225b08b445d::function_9759891d24e704e7("price_lead_player");
  level.price scripts\sp\utility::enable_stayahead(level.player);
  level.var_b570d19ac8822090.animnode anim_reach_solo(level.price, "p1stairs_shield_enter");
  level.price scripts\sp\utility::disable_stayahead();
  flag_set("price_ready_for_shield_anim");
}

function function_2b04b937e1fc7ed6() {
  level endon("nt_price_pre_shield_shoot");
  assert(isDefined(level.var_b570d19ac8822090));
  human_shield = level.var_b570d19ac8822090.human_shield;
  result = waittill_any_ents_return(human_shield, "death", human_shield, "damage", level, "force_stop_shield_scene");

  if(!is_dead_or_dying(level.var_b570d19ac8822090.human_shield)) {
    level.var_b570d19ac8822090.animnode notify("stop_price_stair_loop");
    level.var_b570d19ac8822090.animnode notify("stop_stair_shield_loop");
    level.var_b570d19ac8822090.human_shield stop_magic_bullet_shield();
    level.var_b570d19ac8822090.human_shield function_1a479cad9c3adbb1(1);
    level.var_b570d19ac8822090.human_shield actoraimassiston();
    level.var_b570d19ac8822090.human_shield setgoalpos(level.var_b570d19ac8822090.human_shield.origin, 32);
    level.var_b570d19ac8822090.human_shield stopanimScripted();
    level.var_b570d19ac8822090.human_shield.ignoreme = 0;
    level.var_b570d19ac8822090.human_shield.ignoreall = 0;
    level.var_b570d19ac8822090.human_shield setgoalpos(level.var_b570d19ac8822090.human_shield.origin, 32);
    police02 = get_living_ai("infil_police02", "script_noteworthy");
    police02.health = police02.og_health;
    police02.ignoreall = 0;
    police02.dontevershoot = 0;
    police02.ignoreme = 0;
    police02 notify("stop_going_to_node");
    police02 setgoalpos((31252, 2554, -656), 32);
    level.price stopanimScripted();
    level.price enable_ai_color();
    activate_trigger_with_targetname("trigger_color_concourse_stackup");
  }

  flag_set("player_stopped_shield_moment");
  flag_set("shield_moment_done");
  flag_set("p1stairs_shield_done");
  flag_set("price_starts_meatshield_shooting");
  flag_set("shield_moment_backup_dead");
}

function function_5ef6f1ddd5304549() {
  level endon("shield_scene_started");
  childthread function_690c430e8b0e2518();
  level.var_b570d19ac8822090.animnode anim_single_solo(self, "p1stairs_shield_enter");
  level.var_b570d19ac8822090.animnode childthread anim_loop_solo(self, "p1stairs_shield_enter_idle", "stop_stair_shield_loop");
}

function function_690c430e8b0e2518() {
  flag_wait("radflag_player_stairs_top");
  var_ca66db39f5f5be3c = level.player.origin[2] - level.price.origin[2] > 80;

  if(var_ca66db39f5f5be3c && flag("radtrig_player_in_stairwell")) {
    flag_set("force_stop_shield_scene");
  }
}

function function_88ba7ad0da36c71a() {
  return distance2dsquared(level.player.origin, level.price.origin) < squared(500) && within_fov(level.player.origin, level.player getplayerangles(), level.price.origin, 0.642788);
}

function shield_moment() {
  level endon("player_stopped_shield_moment");
  function_f361496aeb4458f6();
  level.var_b570d19ac8822090.human_shield thread function_5ef6f1ddd5304549();
  thread function_cc74c1fa76bb8e68();
  assertex(isDefined(level.var_b570d19ac8822090), "Trying to play shield moment but it was not initialized yet!");
  thread player_at_meatshield();
  thread function_59a8c12ec197d91e();
  flag_wait("price_ready_for_shield_anim");
  var_6971c92de78a4f1f = 0;

  if(function_88ba7ad0da36c71a()) {
    var_6971c92de78a4f1f = 1;
    level.var_b570d19ac8822090.animnode anim_single_solo(level.price, "p1stairs_shield_fast_enter");
  } else {
    level.var_b570d19ac8822090.animnode anim_single_solo(level.price, "p1stairs_shield_enter");
    level.var_b570d19ac8822090.animnode thread anim_loop_solo_with_nags(level.price, "p1stairs_shield_enter_idle", "stop_price_stair_loop");

    while(!function_88ba7ad0da36c71a()) {
      waitframe();
    }

    level.var_b570d19ac8822090.animnode notify("stop_price_stair_loop");
  }

  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  police02 = get_living_ai("infil_police02", "script_noteworthy");

  if(!is_dead_or_dying(police02)) {
    police02 thread function_1dea7bf267949742();
  }

  thread function_22cddab8c42ffa14();
  flag_set("shield_scene_started");
  animators = [level.price, level.var_b570d19ac8822090.human_shield];

  if(!var_6971c92de78a4f1f) {
    level.var_b570d19ac8822090.animnode anim_single_solo(level.price, "p1stairs_shield_enter_idle_exit");
  }

  level.var_b570d19ac8822090.human_shield delaythread(4, &play_sound_on_entity, "generic_death_falling_scream");
  level.var_b570d19ac8822090.animnode anim_single(animators, "p1stairs_shield_intro");
  level.price thread function_45849e01915a417f();
  level.var_b570d19ac8822090.human_shield thread bullet_dance();
  flag_wait_all("shield_moment_backup_dead", "police02_dead");
  self.var_fccac1a1070691b2 = 1;
  level.var_b570d19ac8822090.human_shield notify("stop_bullet_dance");
  level.var_b570d19ac8822090.animnode notify("stop_loop");
  level.price notify("stop_price_idle_shoot");
  level.var_b570d19ac8822090.animnode notify("stop_shield_idle");
  flag_set("shield_moment_done");
  level.var_b570d19ac8822090.human_shield thread namespace_47819225b08b445d::kill_on_anim_end();
  level.var_b570d19ac8822090.animnode thread anim_single_solo(level.var_b570d19ac8822090.human_shield, "p1stairs_shield_exit");
  level.var_b570d19ac8822090.animnode anim_single_solo(level.price, "p1stairs_shield_exit");

  if(!is_dead_or_dying(level.var_b570d19ac8822090.human_shield)) {
    level.var_b570d19ac8822090.human_shield kill();
  }

  flag_set("p1stairs_shield_done");
  level.price enable_ai_color();
  namespace_47819225b08b445d::function_f1864fb398798ed6(1);
}

function function_cc74c1fa76bb8e68() {
  flag_wait("price_ready_for_shield_anim");
  wait randomfloatrange(0.2, 1);
  police01 = get_living_ai("police01", "targetname");

  if(!is_dead_or_dying(police01)) {
    level.price shoot(1, police01);
    police01 kill();
  }

  wait randomfloatrange(0.2, 2);
  police02 = get_living_ai("police02", "targetname");

  if(!is_dead_or_dying(police02)) {
    level.price shoot(1, police02);
    police02 kill();
  }
}

function function_1dea7bf267949742() {
  self endon("death");
  level endon("shield_moment_done");
  wait 4;
  node = getnode("shield_moment_stairs_top_node", "targetname");
  thread spawner::go_to_node(node);
  flag_wait_either("nt_price_spotted_police02", "radflag_player_stairs_top");
  wait 1;
  self.dontevershoot = 0;
}

function player_at_meatshield() {
  level endon("shield_moment_done");

  while(true) {
    if(level.player.origin[2] > -823 && within_fov(level.player.origin, level.player.angles, level.price.origin, 0.642788) || level.player can_see_origin((31240, 2600, -640))) {
      utility::flag_set("player_at_meatshield");
      flag_wait("price_starts_meatshield_shooting");
      thread utility::flag_set_delayed("meat_shield_timeout", 5);
      return;
    }

    wait 0.3;
  }
}

function can_see_origin(origin) {
  if(!math::point_in_fov(origin, cos(getdvarint(@ "hash_b38fcf293d1e91a8")))) {
    return 0;
  }

  return scripts\engine\trace::ray_trace_passed(self getEye(), origin, self, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1));
}

function function_45849e01915a417f() {
  self endon("stop_price_idle_shoot");
  flag_set("price_starts_meatshield_shooting");
  animnode = level.var_b570d19ac8822090.animnode;
  shoot_anims = ["p1stairs_shield_shoot01", "p1stairs_shield_shoot02"];

  while(true) {
    animnode thread anim_loop_solo(self, "p1stairs_shield_idle", "stop_shield_idle");
    wait randomfloatrange(0.2, 0.7);
    animnode notify("stop_shield_idle");
    target = undefined;
    infil_police02 = get_living_ai("infil_police02", "script_noteworthy");

    if(!is_dead_or_dying(infil_police02)) {
      target = infil_police02;
    } else {
      level.var_b570d19ac8822090.enemy_backup = array_removedead_or_dying(level.var_b570d19ac8822090.enemy_backup);
      target = random(level.var_b570d19ac8822090.enemy_backup);
    }

    if(!isDefined(target)) {
      break;
    }

    num_count = randomintrange(1, 3);

    for(i = 0; i < num_count; i++) {
      animnode anim_single_solo(self, "p1stairs_shield_shoot01");

      if(flag("player_at_meatshield") && randomint(100) < 10 || flag("meat_shield_timeout")) {
        if(!is_dead_or_dying(target)) {
          target dodamage(target.health + 1, target getEye(), self, undefined, "MOD_PISTOL_BULLET");
        }
      }
    }
  }
}

function bullet_dance() {
  self endon("stop_bullet_dance");
  tags = ["j_head", "j_neck", "j_shoulder_le", "j_shoulder_ri", "j_spine4", "j_spinelower", "j_spineupper", "j_elbow_le", "j_elbow_ri"];
  firsttime = 0;
  self.var_fccac1a1070691b2 = 0;
  animnode = level.var_b570d19ac8822090.animnode;
  shot_anims = ["p1stairs_shield_shot01", "p1stairs_shield_shot02"];
  level.var_b570d19ac8822090.animnode notify("stop_stair_shield_loop");

  while(true) {
    level.var_b570d19ac8822090.animnode thread anim_loop_solo(level.var_b570d19ac8822090.human_shield, "p1stairs_shield_idle", "stop_shield_loop");
    level waittill("bullet_dance");
    level.var_b570d19ac8822090.animnode notify("stop_shield_loop");
    animnode anim_single_solo(self, random(shot_anims));

    if(!self.var_fccac1a1070691b2) {
      shot_tag = tags[randomint(tags.size)];

      if(firsttime) {
        thread play_sound_in_space("generic_death_falling_scream", self gettagorigin(shot_tag));
        firsttime = 0;
      }

      playFXOnTag(getfx("vfx_imp_flesh_lrg"), self, shot_tag);
      thread play_sound_in_space("npc_bullet_impact_script", self gettagorigin(shot_tag));
    }
  }
}

function function_f361496aeb4458f6() {
  assert(!isDefined(level.var_b570d19ac8822090));
  flag_init("shield_moment_done");
  flag_init("shield_moment_backup_dead");
  flag_init("shield_scene_started");
  flag_init("p1stairs_shield_start");
  flag_init("p1stairs_shield_done");
  flag_init("price_ready_for_shield_anim");
  level.var_b570d19ac8822090 = spawnStruct();
  level.var_b570d19ac8822090.animnode = getStruct("animnode_stairs_police_kill", "targetname");
  function_f88987eeab678fe4();
  level.var_b570d19ac8822090.human_shield = get_living_ai("infil_police01", "script_noteworthy");
  level.var_b570d19ac8822090.human_shield magic_bullet_shield();
  level.var_b570d19ac8822090.human_shield function_1a479cad9c3adbb1(0);
  level.var_b570d19ac8822090.human_shield actoraimassistoff();
  level.var_b570d19ac8822090.human_shield.allowdeath = 1;
  level.var_b570d19ac8822090.human_shield setgoalpos(level.var_b570d19ac8822090.human_shield.origin, 32);
  police02 = get_living_ai("infil_police02", "script_noteworthy");
  police02.dontevershoot = 1;
  police02.script_forcegoal = 1;
  police02.og_health = police02.health;
  police02 setgoalpos(police02.origin, 32);
  thread namespace_47819225b08b445d::function_5da13e5444950c67([police02], "police02_dead");
  level.var_b570d19ac8822090.animators = [level.var_b570d19ac8822090.human_shield, level.price];
  level.var_b570d19ac8822090.enemies = [level.var_b570d19ac8822090.human_shield];
  level.var_b570d19ac8822090.animnode anim_first_frame_solo(level.var_b570d19ac8822090.human_shield, "p1stairs_shield_enter");
  thread function_2b04b937e1fc7ed6();
}

function function_f88987eeab678fe4() {
  enemyspawners = getspawnerarray("enemy_infil_stair");
  array_spawn_function(enemyspawners, &set_grenadeammo, 0);
  array_spawn_function(enemyspawners, &set_allowdeath, 1);
  return array_spawn(enemyspawners, 1);
}

function function_22cddab8c42ffa14() {
  level endon("shield_moment_done");
  wait 7;

  if(level.player.origin[2] > -752) {
    flag_set("shield_moment_backup_dead");
    return;
  }

  var_8e67dcdc32242856 = getspawnerarray("enemy_infil_stairs_shield_backup");
  array_spawn_function(var_8e67dcdc32242856, &function_81b4752f97c66fb4);
  level.var_b570d19ac8822090.enemy_backup = array_spawn(var_8e67dcdc32242856, 1);
  thread namespace_47819225b08b445d::function_5da13e5444950c67(level.var_b570d19ac8822090.enemy_backup, "shield_moment_backup_dead");
}

function function_81b4752f97c66fb4() {
  self endon("death");
  set_grenadeammo(0);
  disable_long_death();
  enable_sprint();
  self enableavoidance(0, 0);
  self.script_forcegoal = 1;
  self.sidearm = nullweapon();
  self waittill("goal");
  thread function_8bad0a2662fffa7a();
}

function function_8bad0a2662fffa7a() {
  self endon("death");
  shooting = 0;

  while(true) {
    var_f701d817842bc754 = distance2dsquared(self.origin, level.player.origin);

    if(var_f701d817842bc754 > 22500) {
      if(!shooting) {
        shooting = 1;
        namespace_47819225b08b445d::function_15e8419bc7722d0b();
        self.fake_enemy.health = 999;
        self.baseaccuracy = 10;
        childthread notify_shooting();
        childthread updatemeatshieldtarget();
      }
    } else {
      var_c0807d0c0a545528 = level.player.origin[2] > -784;

      if(shooting && var_c0807d0c0a545528) {
        shooting = 0;
        namespace_47819225b08b445d::ignore_fake_enemy();
        self.baseaccuracy = 1;
      }
    }

    wait 0.2;
  }
}

function updatemeatshieldtarget() {
  self notify("updateMeatshieldTarget");
  self endon("updateMeatshieldTarget");
  self.fake_enemy endon("death");

  while(true) {
    self.bulletsinclip = weaponclipsize(self.weapon);
    from = self getshootfrompos();
    to = level.price gettagorigin("j_spine4");
    angles = vectortoangles(to - from);
    spot = from + anglesToForward(angles) * 60;
    self.fake_enemy.origin = spot;
    self cansee(self.fake_enemy, 0);
    wait 1;
  }
}

function notify_shooting() {
  self notify("notify_shooting");
  self endon("notify_shooting");

  while(true) {
    waittill_any_2("weapon_fired", "shooting");
    level notify("bullet_dance");
  }
}

#using_animtree("generic_human");

function function_9d2a5a3f7d9befe4() {
  self useanimtree(#animtree);
}
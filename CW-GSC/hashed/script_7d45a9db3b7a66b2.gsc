/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7d45a9db3b7a66b2.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using script_5a7c9cfbe3d9580c;
#using script_61fee52bb750ac99;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\smart_bundle;
#using scripts\cp_common\util;
#namespace namespace_b092382c;

function function_c26b0bc0() {
  level flag::init("player_in_infinite_hallway");
  level flag::init("infinite_hallway_visit_1");
  level flag::init("infinite_hallway_visit_2");
  level flag::init("infinite_hallway_visit_3");
  level flag::init("infinite_hallway_visit_4");
  level flag::init("infinite_hallway_corridor_loop_1");
  level flag::init("infinite_hallway_corridor_loop_2");
  level flag::init("infinite_hallway_corridor_loop_3");
  level flag::init("infinite_hallway_corridor_loop_4");
  level flag::init("infinite_hallway_visit_door_jump");
  level flag::init("infinite_hallway_visit_loop");
  level flag::init("infinite_hallway_visit_lab");
  level flag::init("infinite_hallway_visit_loop_complete");
  level flag::init("flag_injection_response_vo_said");
  level flag::init("flag_infinite_hallway_corridor_blocker_1");
  level flag::init("flag_infinite_hallway_corridor_blocker_2");
  level flag::init("flag_infinite_hallway_loop_door_blocker");
  level flag::init("flag_exit_door_pos_1_wall");
  level flag::init("flag_exit_door_pos_2_wall");
  level flag::init("flag_exit_door_pos_3_wall");
  level flag::init("flag_exit_door_pos_4_wall");
  level flag::init("flag_delete_shrinking_loop");
  level flag::init("infinite_hallway_exit_ready");
  level flag::init("infinite_hallway_exited");
}

function function_4d08a806() {
  level flag::wait_till("player_in_infinite_hallway");

  if(!isDefined(level.var_2ae942a4) || isDefined(level.var_2ae942a4) && level.var_2ae942a4 == 0) {
    while(!isDefined(level.var_2ae942a4) || isDefined(level.var_2ae942a4) && level.var_2ae942a4 == 0) {
      wait 0.05;
    }
  }

  if(level.var_2ae942a4 == 1) {
    dialogue::radio("vox_cp_prsn_09000_adlr_idontcareifthed_de");
    level childthread namespace_d9b153b9::function_f6cbf7fd(&function_aecd6152, 1, 10, "infinite_hallway_visit_door_jump");
    level flag::wait_till("infinite_hallway_visit_door_jump");
  }

  if(level.var_2ae942a4 == 2) {
    namespace_d9b153b9::function_f76551eb("vox_cp_prsn_09000_adlr_parkgivebellano_46", "vox_cp_prsn_09000_adlr_lazargivebellan_b2", "vox_cp_prsn_09000_adlr_simsgivebellano_54");
    level thread function_87dcd561();
    level flag::wait_till_any(array("flag_start_injection_failsafe", "flag_injection_response_vo_said"));
    level thread dialogue::radio("vox_cp_prsn_09000_adlr_doitnow_53", undefined, 1);

    if(level flag::get("flag_start_injection_failsafe")) {
      wait 1.25;
    } else {
      level flag::wait_till("flag_start_injection_failsafe");
    }

    level notify(#"hash_3b491810b066469a");
    level.player clientfield::set_to_player("lerp_fov", 7);
    wait 3;
    namespace_d9b153b9::function_f76551eb("vox_cp_prsn_09000_park_heartrateisspik_04", "vox_cp_prsn_09000_lazr_thosearesomeser_6f", "vox_cp_prsn_09000_sims_thisissomefucke_67");
    level flag::wait_till("flag_start_door_jump_3");
    level.player clientfield::set_to_player("lerp_fov", 6);
    wait 2;
    namespace_d9b153b9::function_f76551eb("vox_cp_prsn_09000_park_goodeverythings_77", "vox_cp_prsn_09000_lazr_waititlookslike_a2", "vox_cp_prsn_09000_sims_hangintherebell_c3");
    level flag::wait_till("infinite_hallway_visit_loop");
  }

  if(level.var_2ae942a4 == 3) {
    level waittilltimeout(60, #"corridor_1_door_3");
    level thread namespace_b6fe1dbe::function_1302e69b("vox_cp_prsn_09000_adlr_bellgothroughad_38");

    while(true) {
      level flag::wait_till("corridor_2_activate");

      if(level.var_f668e14a == 2) {
        break;
      }

      wait 0.1;
    }

    str_vo = util::function_3ac6fa36("vox_cp_prsn_09000_adlr_whyisbellrepeat_f9", "vox_cp_prsn_09000_adlr_whyisbellrepeat_fa", "vox_cp_prsn_09000_adlr_whyisbellrepeat_56");
    level thread namespace_b6fe1dbe::function_1302e69b(str_vo);
    level thread function_985e188();
    level flag::wait_till("infinite_hallway_visit_lab");
  }

  if(level.var_2ae942a4 == 4) {
    dialogue::radio("vox_cp_prsn_09000_adlr_whatthelabfacin_d9");
    level flag::wait_till_any(array("flag_drop_player_through_floor_vo", "flag_start_memory_perseus"));

    if(level flag::get("flag_drop_player_through_floor_vo")) {
      wait 0.8;
      dialogue::radio("vox_cp_prsn_09000_adlr_bellforgetabout_a3");
    }
  }
}

function function_87dcd561() {
  level endon(#"flag_start_injection_failsafe");

  if(!level flag::get("flag_start_injection_failsafe")) {
    level thread namespace_d9b153b9::function_f76551eb("vox_cp_prsn_09000_park_thatcouldbeleth_ec", "vox_cp_prsn_09000_lazr_idontknowifthat_05", "vox_cp_prsn_09000_sims_yousurebellshea_fc");
    wait 3;
    level flag::set("flag_injection_response_vo_said");
  }
}

function function_aecd6152() {
  dialogue::radio("vox_cp_prsn_09000_adlr_aghjustforgetit_90");
}

function function_985e188() {
  level.infinite_hallway_loop_unlock_door_struct.door_interact endon(#"trigger");
  level endon(#"infinite_hallway_visit_lab");
  level endon(#"infinite_hallway_visit_loop_complete");
  level flag::wait_till("flag_delete_shrinking_loop");
  level thread namespace_b6fe1dbe::function_1302e69b("vox_cp_prsn_09000_adlr_bellstopspeakin_2d");
  wait randomintrange(8, 12);
  level thread namespace_b6fe1dbe::function_1302e69b("vox_cp_prsn_09000_adlr_stopwastingmyti_8c");
  wait randomintrange(8, 12);
  level thread namespace_b6fe1dbe::function_1302e69b("vox_cp_prsn_09000_adlr_turnaroundbell_4b");
}

function function_ce927147() {
  level.infinite_hallway_exit_unlock_door_struct = namespace_d9b153b9::door_setup("infinite_hallway_exit_unlock_door_struct", undefined, 1);
  level.infinite_hallway_loop_unlock_door_struct = namespace_d9b153b9::door_setup("infinite_hallway_loop_unlock_door_struct");
  level.infinite_hallway_loop_unlock_door_struct thread function_906a95e5();
  level flag::clear("flag_exit_door_pos_1_wall");
  level flag::set("flag_exit_door_pos_2_wall");
  level flag::set("flag_exit_door_pos_3_wall");
  level flag::set("flag_exit_door_pos_4_wall");
  level flag::clear("flag_infinite_hallway_loop_door_blocker");
  level flag::set("flag_infinite_hallway_corridor_blocker_1");
  level flag::set("flag_infinite_hallway_corridor_blocker_2");
  level.infinite_hallway_exit_door_facade = getEntArray("infinite_hallway_exit_door_facade", "script_noteworthy");
  level.infinite_hallway_loop_door_facade = getEntArray("infinite_hallway_loop_door_facade", "script_noteworthy");
  level.infinite_hallway_cart_clip = getent("infinite_hallway_cart_clip", "targetname");
  level.var_5ab10178 = [];
  level.var_4adb0f8 = struct::get_array("infinite_hallway_hallway_door_struct", "targetname");

  foreach(struct in level.var_4adb0f8) {
    struct = namespace_d9b153b9::door_setup(undefined, struct);
    struct.original_origin = struct.origin;
    struct.original_angles = struct.angles;
    struct thread function_801debe2();

    if(isDefined(struct.script_noteworthy)) {
      if(struct.script_noteworthy == "corridor_1_door_1" || struct.script_noteworthy == "corridor_1_door_2") {
        if(isDefined(struct.door_left)) {
          if(!isDefined(level.var_5ab10178)) {
            level.var_5ab10178 = [];
          } else if(!isarray(level.var_5ab10178)) {
            level.var_5ab10178 = array(level.var_5ab10178);
          }

          level.var_5ab10178[level.var_5ab10178.size] = struct.door_left;
        }

        if(isDefined(struct.door_frame)) {
          if(!isDefined(level.var_5ab10178)) {
            level.var_5ab10178 = [];
          } else if(!isarray(level.var_5ab10178)) {
            level.var_5ab10178 = array(level.var_5ab10178);
          }

          level.var_5ab10178[level.var_5ab10178.size] = struct.door_frame;
        }
      }

      struct.var_3deb0c3d = struct::get(struct.script_noteworthy + "_shrinking_pos", "targetname");
    }
  }

  level.infinite_hallway_lab_backtrack_blocker = getent("infinite_hallway_lab_backtrack_blocker", "targetname");
  level.infinite_hallway_lab_floor = getEntArray("infinite_hallway_lab_floor", "targetname");
  level.infinite_hallway_bunker_ceiling = getEntArray("infinite_hallway_bunker_ceiling", "targetname");
  level.corridor_1_pipe_script_brushmodels = getEntArray("corridor_1_pipe_script_brushmodels", "targetname");
  level.corridor_2_corner_pipe_script_brushmodels = getEntArray("corridor_2_corner_pipe_script_brushmodels", "targetname");
  level.corridor_2_pipe_script_brushmodels = getEntArray("corridor_2_pipe_script_brushmodels", "targetname");
  level.corridor_3_pipe_script_brushmodels = getEntArray("corridor_3_pipe_script_brushmodels", "targetname");
  level.player_exiting_shrinking_loop_trigger = getent("player_exiting_shrinking_loop_trigger", "targetname");
  level.player_exiting_shrinking_loop_trigger triggerenable(0);
  level.player_exiting_shrinking_loop_trigger.trigger_off = 1;
  level thread function_e0c00554();
  level thread function_bb1aba0a();
  level thread function_8eda618a();
  level thread function_d7ce7371();
  level.corner_1_curved_geo = getEntArray("corner_1_curved_geo", "targetname");

  foreach(ent in level.corner_1_curved_geo) {
    if(isDefined(ent)) {
      ent hide();
    }
  }

  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_07");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_07");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_07");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_08");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_08");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_09");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_09");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_09");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_10");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_10");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_10");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_11");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_11");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_01");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_01");
  level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_01");
}

function function_e0c00554() {
  level endon(#"infinite_hallway_exited");
  level flag::set("flag_corridor_1_hall");
  corridor_1_hall_sb = smart_bundle::function_6c12ff6("corridor_1_hall_sb");
  corridor_1_hall_sb waittill(#"hash_2c5cc8d3d6ed8b34");
  level.var_57e54c86 = getEntArray("corridor_1_corner", "targetname");
  level.var_4620ea49 = getEntArray("corridor_1_hall", "targetname");
  level.var_cf2a2b72 = struct::get("corridor_1_corner_start", "targetname");
  level.var_2a353790 = spawn("script_model", struct::get("corridor_1_corner_original_struct", "targetname").origin);
  level.var_2a353790 setModel(#"tag_origin");

  foreach(ent in level.var_4620ea49) {
    if(isDefined(ent)) {
      ent linkto(level.var_2a353790, "tag_origin");
    }
  }
}

function function_bb1aba0a() {
  level endon(#"infinite_hallway_exited");
  level flag::set("flag_corridor_2_corner");
  corridor_2_corner_sb = smart_bundle::function_6c12ff6("corridor_2_corner_sb");
  corridor_2_corner_sb waittill(#"hash_2c5cc8d3d6ed8b34");
  level flag::set("flag_corridor_2_hall");
  corridor_2_hall_sb = smart_bundle::function_6c12ff6("corridor_2_hall_sb");
  corridor_2_hall_sb waittill(#"hash_2c5cc8d3d6ed8b34");
  level.var_be8a7ed0 = getEntArray("corridor_2_corner", "targetname");
  level.var_30d625b7 = getEntArray("corridor_2_hall", "targetname");
  level.var_dcfead6b = struct::get("corridor_2_corner_start", "targetname");
  level.var_3814631a = spawn("script_model", struct::get("corridor_2_corner_original_struct", "targetname").origin);
  level.var_3814631a setModel(#"tag_origin");
  level.var_a77dd496 = spawn("script_model", struct::get("corridor_2_corner_original_struct", "targetname").origin);
  level.var_a77dd496 setModel(#"tag_origin");

  foreach(ent in level.var_be8a7ed0) {
    if(isDefined(ent)) {
      ent linkto(level.var_3814631a, "tag_origin");
    }
  }

  foreach(ent in level.var_30d625b7) {
    if(isDefined(ent)) {
      ent linkto(level.var_a77dd496, "tag_origin");
    }
  }
}

function function_8eda618a() {
  level endon(#"infinite_hallway_exited");
  level flag::set("flag_corridor_3_corner");
  corridor_3_corner_sb = smart_bundle::function_6c12ff6("corridor_3_corner_sb");
  corridor_3_corner_sb waittill(#"hash_2c5cc8d3d6ed8b34");
  level flag::set("flag_corridor_3_hall");
  corridor_3_hall_sb = smart_bundle::function_6c12ff6("corridor_3_hall_sb");
  corridor_3_hall_sb waittill(#"hash_2c5cc8d3d6ed8b34");
  level.var_340b140b = getEntArray("corridor_3_corner", "targetname");
  level.var_723c531e = getEntArray("corridor_3_hall", "targetname");
  level.var_9bae4ba1 = struct::get("corridor_3_corner_start", "targetname");
  level.var_1193c77e = spawn("script_model", struct::get("corridor_3_corner_original_struct", "targetname").origin);
  level.var_1193c77e setModel(#"tag_origin");
  level.var_a47ab6eb = spawn("script_model", struct::get("corridor_3_corner_original_struct", "targetname").origin);
  level.var_a47ab6eb setModel(#"tag_origin");

  foreach(ent in level.var_340b140b) {
    if(isDefined(ent)) {
      ent linkto(level.var_1193c77e, "tag_origin");
    }
  }

  foreach(ent in level.var_723c531e) {
    if(isDefined(ent)) {
      ent linkto(level.var_a47ab6eb, "tag_origin");
    }
  }
}

function function_d7ce7371() {
  level endon(#"infinite_hallway_exited");
  level flag::set("flag_corridor_4_corner");
  corridor_4_corner_sb = smart_bundle::function_6c12ff6("corridor_4_corner_sb");
  corridor_4_corner_sb waittill(#"hash_2c5cc8d3d6ed8b34");
  level flag::set("flag_corridor_4_hall");
  corridor_4_hall_sb = smart_bundle::function_6c12ff6("corridor_4_hall_sb");
  corridor_4_hall_sb waittill(#"hash_2c5cc8d3d6ed8b34");
  level.var_8f1b4e46 = getEntArray("corridor_4_corner", "targetname");
  level.var_624718c0 = getEntArray("corridor_4_hall", "targetname");
  level.var_9c6cfa20 = struct::get("corridor_4_corner_start", "targetname");
  level.var_92bf0856 = spawn("script_model", struct::get("corridor_4_corner_original_struct", "targetname").origin);
  level.var_92bf0856 setModel(#"tag_origin");
  level.var_ff9012a = spawn("script_model", struct::get("corridor_4_corner_original_struct", "targetname").origin);
  level.var_ff9012a setModel(#"tag_origin");

  foreach(ent in level.var_8f1b4e46) {
    if(isDefined(ent)) {
      ent linkto(level.var_92bf0856, "tag_origin");
    }
  }

  foreach(ent in level.var_624718c0) {
    if(isDefined(ent)) {
      ent linkto(level.var_ff9012a, "tag_origin");
    }
  }
}

function function_906a95e5() {
  level flag::wait_till("infinite_hallway_exit_ready");
  self.door_left setModel("p9_vnm_door_bunker_metal_01c");
  self thread namespace_d9b153b9::function_736b8a03(1);
  self thread namespace_b6fe1dbe::function_2982df9f();
  level thread function_dbcfb3e2(self);
}

function function_6716d9ce() {
  level.var_464aabd3 = 0;
  tv = spawn("script_model", self.origin);
  tv.angles = self.angles;
  tv setModel("cp_disco_tv_crt_01_off");

  if(isDefined(self.script_noteworthy) && (issubstr(self.script_noteworthy, "1") || issubstr(self.script_noteworthy, "3"))) {
    level flag::wait_till("infinite_hallway_visit_2");
  } else if(isDefined(self.script_noteworthy) && issubstr(self.script_noteworthy, "2")) {
    level flag::wait_till("infinite_hallway_visit_3");
  }

  tv.usable = spawn("script_model", self.origin);
  tv.usable setModel("tag_origin");
  fwd = anglesToForward(self.angles + (0, -90, 0));
  offset = (fwd[0] * 12, fwd[1] * 12, 8);
  tv.usable util::create_cursor_hint("tag_origin", (0, 0, 0) + offset, #"hash_19a0613cf790542e");
  util::waittill_any_ents(tv.usable, "trigger", level, "infinite_hallway_exited", level, "infinite_hallway_visit_loop");

  if(!level flag::get("infinite_hallway_visit_loop") && !level flag::get("infinite_hallway_exited")) {
    tv setModel("cp_disco_tv_crt_01_on");
    level.var_464aabd3++;
  }

  tv.usable util::remove_cursor_hint();

  if(level.var_464aabd3 == 3) {
    level flag::set("infinite_hallway_exit_ready");
  }

  if(!level flag::get("infinite_hallway_exited")) {
    level flag::wait_till("infinite_hallway_exited");
  }

  if(isDefined(tv.usable)) {
    tv.usable delete();
  }

  if(isDefined(tv)) {
    tv delete();
  }
}

function function_801debe2() {
  self thread namespace_d9b153b9::ent_cleanup("infinite_hallway_exited", 1);

  if(isDefined(self.script_noteworthy)) {
    clip = getent(self.script_noteworthy + "_clip", "targetname");

    if(isDefined(clip)) {
      clip linkto(self.door_left);
      clip thread namespace_d9b153b9::ent_cleanup("infinite_hallway_exited", 1);
    }
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "corridor_2_door_6") {
    level flag::wait_till("infinite_hallway_visit_2");
    self.door_left thread function_3f816598(1);
  }

  level waittill(#"hash_aeb81dcad8cbb5d");
  self.door_left thread function_3f816598(1, 0.05);
}

function function_3f816598(open, time, sfx, var_e0b06bb2) {
  self endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(time)) {
    time = 0.5;
  }

  if(isDefined(open)) {
    if(!isDefined(self.open)) {
      self.open = 1;
      fwd = anglesToForward(self.angles);
      yaw_angle = int(fwd[1]) + 90;
      self rotateyaw(yaw_angle, time);
      wait time;
    }

    return;
  }

  if(isDefined(self.open)) {
    self.open = undefined;
    fwd = anglesToForward(self.angles);
    yaw_angle = int(fwd[1]) + -90;
    self rotateyaw(yaw_angle, time);

    if(isDefined(sfx)) {
      level thread namespace_b6fe1dbe::function_46fb07f8(self);
    }

    wait time;

    if(isDefined(var_e0b06bb2) && isstring(var_e0b06bb2)) {
      level notify(var_e0b06bb2);
    }

    level.player playrumbleonentity("anim_med");
  }
}

function infinite_hallway() {
  level thread savegame::checkpoint_save();
  level.var_3f5c80c8 = "infinite_hallway";
  level thread namespace_b6fe1dbe::pre_injection_hallway_sfx();
  level function_ce927147();
  level.infinite_hallway_loop_unlock_door_struct scene::init("scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left);

  if(!isDefined(level.var_2ae942a4)) {
    level.var_2ae942a4 = 0;
    level.infinite_hallway_exit_unlock_door_struct scene::init("scene_pri_bunker_open_locked", array(level.infinite_hallway_exit_unlock_door_struct.door_left, level.players[0]));
    level.infinite_hallway_exit_unlock_door_struct scene::play("scene_pri_bunker_open_locked");
  }

  level.player util::function_7f49ffb7(6);
  level flag::set("player_in_infinite_hallway");
  level endon(#"infinite_hallway_exited");
  level.infinite_hallway_loop_unlock_door_struct.door_left.original_origin = level.infinite_hallway_loop_unlock_door_struct.door_left.origin;
  level.infinite_hallway_loop_unlock_door_struct.door_left.original_angles = level.infinite_hallway_loop_unlock_door_struct.door_left.angles;
  level.player clientfield::set_to_player("lerp_fov", 6);
  level.var_b551b5a = "infinite_hallway_loop_unlock_door_scene";

  while(true) {
    level thread function_c51fa7f2();

    if(level.var_2ae942a4 != 4) {
      level.infinite_hallway_loop_unlock_door_struct thread namespace_b6fe1dbe::function_2982df9f();
    }

    level.infinite_hallway_loop_unlock_door_struct.door_interact waittill(#"trigger");
    level exploder::exploder("lgt_doorlight");

    if(level.var_2ae942a4 == 3) {
      level.player clientfield::set_to_player("lerp_fov", 0);
      level exploder::exploder("lgt_cleanhalldrop");
    }

    level.infinite_hallway_exit_unlock_door_struct.door_left hide();
    level util::delay(0.5, undefined, &namespace_d9b153b9::pstfx_teleport, 1, 0, "door");
    level util::delay(1, undefined, &flag::set, "flag_clear_teleport_fx");
    level scene::play(level.var_b551b5a, level.infinite_hallway_loop_unlock_door_struct.door_left);
    level notify(#"hash_74917a0c21f8e670");

    if(level.var_2ae942a4 == 3) {
      level scene::play("infinite_hallway_lab_unlock_door_scene");
      level scene::stop("infinite_hallway_lab_unlock_door_scene", 1);
      level notify(#"hash_5d251e3bf4fc5f57");
    } else {
      level scene::play("infinite_hallway_loop_open_door_scene");
      level scene::stop("infinite_hallway_loop_open_door_scene", 1);
      level notify(#"hash_5d251e3bf4fc5f57");
    }

    level exploder::stop_exploder("lgt_doorlight");
    level.infinite_hallway_exit_unlock_door_struct.door_left show();
    level.infinite_hallway_exit_unlock_door_struct scene::init("scene_pri_bunker_unlock", level.infinite_hallway_exit_unlock_door_struct.door_left);

    if(level.var_2ae942a4 == 2) {
      level.infinite_hallway_loop_unlock_door_struct waittill(#"hash_4c6b60cd2908ac8");
    }

    level.infinite_hallway_loop_unlock_door_struct scene::init("scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left);
    level.player util::function_7f49ffb7(6);
  }
}

function function_7841bdbc(door_struct, door_model, var_139422, var_7360fbce) {
  var_e4697d75 = spawn("script_model", door_struct.origin);
  var_e4697d75.angles = door_struct.angles;
  var_e4697d75 setModel(door_model);

  if(isDefined(var_139422)) {
    var_9e32ce68 = spawn("script_model", door_struct.origin);
    var_9e32ce68.angles = door_struct.angles;
    var_9e32ce68 setModel(var_139422);
  }

  origin = getstartorigin(door_struct.origin, door_struct.angles, "t9_pri_bunker_door_player_open");
  angles = getstartangles(door_struct.origin, door_struct.angles, "t9_pri_bunker_door_player_open");
  level.player setorigin(origin);
  level.player setplayerangles(angles);
  waitframe(1);
  door_struct scene::play(var_7360fbce, var_e4697d75);
  level notify(#"hash_5d251e3bf4fc5f57");
  var_e4697d75 delete();

  if(isDefined(var_139422)) {
    var_9e32ce68 delete();
  }
}

function function_c51fa7f2() {
  level.var_2ae942a4++;
  flag = "infinite_hallway_visit_" + level.var_2ae942a4;

  if(level flag::exists(flag)) {
    level flag::set(flag);
  }

  if(level.var_2ae942a4 == 1) {
    level.var_b551b5a = "infinite_hallway_loop_unlock_door_scene";
    level thread infinite_hallway_visit_1();
    level thread namespace_b6fe1dbe::function_c635eb23(1);
    return;
  }

  if(level.var_2ae942a4 == 2) {
    level.var_b551b5a = "infinite_hallway_loop_2_unlock_door_scene";
    level thread infinite_hallway_visit_2();
    level thread namespace_b6fe1dbe::function_c635eb23(2);
    return;
  }

  if(level.var_2ae942a4 == 3) {
    level thread infinite_hallway_visit_3();
    level thread namespace_b6fe1dbe::function_c635eb23(3);
    return;
  }

  if(level.var_2ae942a4 == 4) {
    level.var_b551b5a = "infinite_hallway_loop_unlock_door_scene";
    level thread infinite_hallway_visit_4();
    level thread namespace_b6fe1dbe::function_c635eb23(4);
  }
}

function infinite_hallway_visit_1() {
  var_4dd78966 = [];
  is_offscreen = 0;

  while(!is_offscreen) {
    foreach(ent in level.infinite_hallway_exit_door_facade) {
      if(!util::within_fov(level.players[0].origin, level.players[0].angles, ent.origin + (0, -48, 0), cos(70)) && !level flag::get("flag_infinite_hallway_player_near_door") && !util::within_fov(level.players[0].origin, level.players[0].angles, ent.origin + (64, -48, 0), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, ent.origin + (-64, -48, 0), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, ent.origin + (64, -48, 48), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, ent.origin + (64, -48, -48), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, ent.origin + (-64, -48, 48), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, ent.origin + (-64, -48, -48), cos(70))) {
        if(!isinarray(var_4dd78966, ent)) {
          if(!isDefined(var_4dd78966)) {
            var_4dd78966 = [];
          } else if(!isarray(var_4dd78966)) {
            var_4dd78966 = array(var_4dd78966);
          }

          if(!isinarray(var_4dd78966, ent)) {
            var_4dd78966[var_4dd78966.size] = ent;
          }
        }

        continue;
      }

      if(array::contains(ent)) {
        arrayremovevalue(var_4dd78966, ent);
      }
    }

    if(var_4dd78966.size == level.infinite_hallway_exit_door_facade.size) {
      is_offscreen = 1;
      continue;
    }

    wait 0.1;
  }

  foreach(ent in level.infinite_hallway_exit_door_facade) {
    if(isDefined(ent)) {
      ent hide();
    }
  }

  level flag::set("flag_exit_door_pos_1_wall");
  level thread namespace_b508dca::function_ed113f39(1, "infinite_hallway_exit_unlock_door_struct");
  level.infinite_hallway_loop_unlock_door_struct.door_interact waittill(#"trigger");
  level flag::clear("flag_exit_door_pos_1_wall");
  level waittill(#"hash_5d251e3bf4fc5f57");

  foreach(ent in level.infinite_hallway_exit_door_facade) {
    if(isDefined(ent)) {
      ent show();
    }
  }

  level thread namespace_b508dca::function_ed113f39(undefined, "infinite_hallway_exit_unlock_door_struct");
  level.infinite_hallway_exit_unlock_door_struct thread namespace_d9b153b9::function_736b8a03();
  level.infinite_hallway_exit_unlock_door_struct.door_left setModel("p9_vnm_door_bunker_metal_01c_gray");
}

function function_19d60154(var_35b4eb77) {
  level.var_ffd4e184 = spawn("script_model", self.origin);
  level.var_ffd4e184.angles = self.angles;

  foreach(ent in self.linked_ents) {
    if(isDefined(ent)) {
      ent enablelinkto();
      ent linkto(level.var_ffd4e184);
    }
  }

  foreach(ent in var_35b4eb77) {
    if(isDefined(ent)) {
      ent enablelinkto();
      ent linkto(level.var_ffd4e184);
    }
  }
}

function infinite_hallway_visit_2() {
  level endon(#"infinite_hallway_exited");
  level flag::set("infinite_hallway_visit_door_jump");
  level.infinite_hallway_loop_unlock_door_struct namespace_d9b153b9::function_736b8a03(1);
  level thread function_45d4b385();
  level flag::wait_till("flag_start_door_jump_1");

  if(!isDefined(level.var_ffd4e184)) {
    level.infinite_hallway_loop_unlock_door_struct function_19d60154(level.infinite_hallway_loop_door_facade);
  }

  infinite_hallway_jump_1 = struct::get("infinite_hallway_jump_1", "targetname");
  level.var_ffd4e184.origin = infinite_hallway_jump_1.origin;
  level thread namespace_b6fe1dbe::evt_cp_nam_bunk_door_jumpback_01();
  level flag::wait_till("flag_start_door_jump_2");
  infinite_hallway_jump_2 = struct::get("infinite_hallway_jump_2", "targetname");
  level.var_ffd4e184.origin = infinite_hallway_jump_2.origin;
  level thread namespace_b6fe1dbe::evt_cp_nam_bunk_door_jumpback_02();
  level thread exploder::exploder("lgt_hallway_doorjump_02");
  level flag::wait_till("flag_start_door_jump_3");
  infinite_hallway_jump_3 = struct::get("infinite_hallway_jump_3", "targetname");
  level.var_ffd4e184.origin = infinite_hallway_jump_3.origin;
  level thread namespace_b6fe1dbe::evt_cp_nam_bunk_door_jumpback_03();
  level thread exploder::stop_exploder("lgt_hallway_doorjump_02");
  level thread exploder::exploder("lgt_hallway_doorjump");
  level.infinite_hallway_loop_unlock_door_struct.door_interact waittill(#"trigger");
  level notify(#"hash_aeb81dcad8cbb5d");
  var_158dfaa2 = 1;
  loop_count = 1;
  var_6cd0b669 = "infinite_hallway_corridor_" + var_158dfaa2 + "_loop_" + loop_count;
  var_7525f383 = struct::get_array("infinite_hallway_corridor_" + var_158dfaa2 + "_loop_" + loop_count, "targetname");
  array::thread_all(var_7525f383, &function_5f2165df, 1, var_6cd0b669);
  level waittill(#"hash_5d251e3bf4fc5f57");
  level.infinite_hallway_loop_unlock_door_struct scene::stop("scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left);
  wait 0.1;
  level.var_ffd4e184.origin = level.infinite_hallway_loop_unlock_door_struct.origin;
  wait 0.1;

  foreach(ent in level.infinite_hallway_loop_unlock_door_struct.linked_ents) {
    if(isDefined(ent)) {
      ent unlink();
    }
  }

  foreach(ent in level.infinite_hallway_loop_door_facade) {
    if(isDefined(ent)) {
      ent unlink();
    }
  }

  wait 0.1;
  level.var_ffd4e184 delete();
  level.infinite_hallway_loop_unlock_door_struct.door_left.origin = level.infinite_hallway_loop_unlock_door_struct.door_left.original_origin;
  waitframe(1);
  level.infinite_hallway_loop_unlock_door_struct notify(#"hash_4c6b60cd2908ac8");
  level thread exploder::stop_exploder("lgt_hallway_doorjump");
}

function function_45d4b385() {
  level waittill(#"hash_3b491810b066469a");
  level.player util::blend_movespeedscale(0.4, 0.05);
  level.player val::set("intro_player_anim", "allow_sprint", 0);
  level.player namespace_d9b153b9::pstfx_injection(1);
  level flag::wait_till("flag_start_door_jump_2");
  level flag::wait_till("flag_start_door_jump_3");
  level.player namespace_d9b153b9::pstfx_injection(0);
  level.player util::blend_movespeedscale(1, 2);
  level.player val::reset("intro_player_anim", "allow_sprint");
}

function function_eb3444fe() {
  level.player endon(#"death");

  while(!level flag::get("flag_start_door_jump_3")) {
    level.player playrumbleonentity("heartbeat_low");
    wait 0.1;
    wait 0.2;
    level.player playrumbleonentity("heartbeat_low");
    wait 0.1;
    wait 0.2;
  }
}

function infinite_hallway_visit_3() {
  level endon(#"infinite_hallway_exited");
  level flag::set("infinite_hallway_visit_loop");
  level thread namespace_b508dca::function_ed113f39(1, "infinite_hallway_loop_unlock_door_struct");
  level.infinite_hallway_loop_unlock_door_struct.hidden = 1;

  foreach(ent in level.infinite_hallway_loop_door_facade) {
    if(isDefined(ent)) {
      ent hide();
    }
  }

  level thread function_14147c77();
  level thread function_87b67c58();
  level flag::set("flag_infinite_hallway_loop_door_blocker");
  level flag::clear("flag_infinite_hallway_corridor_blocker_1");
  level flag::wait_till("corridor_2_activate");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_07");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_07");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_07");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_08");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_08");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_09");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_09");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_09");
  level flag::wait_till("corridor_3_activate");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_10");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_10");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_10");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_11");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_11");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_01");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_01");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_01");
  level flag::wait_till("unblock_infinite_hallway_corridor_blocker_2");
  level flag::clear("flag_infinite_hallway_corridor_blocker_2");
  level flag::set("flag_infinite_hallway_corridor_1_corner_geo");

  foreach(ent in level.corner_1_curved_geo) {
    if(isDefined(ent)) {
      ent show();
    }
  }

  wait 0.25;
  level thread namespace_b508dca::function_ed113f39(1, "infinite_hallway_exit_unlock_door_struct");
  level.infinite_hallway_exit_unlock_door_struct.hidden = 1;

  foreach(ent in level.infinite_hallway_exit_door_facade) {
    if(isDefined(ent)) {
      ent hide();
    }
  }

  level flag::set("flag_exit_door_pos_1_wall");
  level thread function_7e5818d6();
  level.infinite_hallway_loop_unlock_door_struct.door_interact waittill(#"trigger");
  level waittill(#"hash_74917a0c21f8e670");
  level waittill(#"hash_5d251e3bf4fc5f57");
  level.infinite_hallway_loop_unlock_door_struct.door_left hide();

  foreach(ent in level.infinite_hallway_exit_door_facade) {
    if(isDefined(ent)) {
      ent show();
    }
  }

  foreach(ent in level.infinite_hallway_loop_door_facade) {
    if(isDefined(ent)) {
      ent show();
    }
  }

  level flag::clear("flag_exit_door_pos_1_wall");
  level flag::clear("flag_infinite_hallway_loop_door_blocker");
  level flag::set("flag_infinite_hallway_corridor_blocker_1");
  level flag::set("flag_infinite_hallway_corridor_blocker_2");
  level.var_ffd4e184.origin = level.infinite_hallway_loop_unlock_door_struct.origin;
  level.var_ffd4e184.angles = level.infinite_hallway_loop_unlock_door_struct.angles;

  if(isDefined(level.var_74dde09e)) {
    foreach(ent in level.var_74dde09e) {
      if(isDefined(ent.linkname) && ent.linkname != "exit_door_pos_1_wall") {
        flag = "flag_" + ent.linkname;

        if(level flag::exists(flag) && !level flag::get(flag)) {
          level flag::set(flag);
        }
      }
    }
  }

  level thread namespace_b508dca::function_ed113f39(undefined, "infinite_hallway_exit_unlock_door_struct");
  level.infinite_hallway_loop_unlock_door_struct.door_left scene::stop();
  level.infinite_hallway_loop_unlock_door_struct.door_left.origin = level.infinite_hallway_loop_unlock_door_struct.door_left.original_origin;
  level.infinite_hallway_loop_unlock_door_struct.door_left.angles = level.infinite_hallway_loop_unlock_door_struct.door_left.original_angles;
  level.infinite_hallway_loop_unlock_door_struct scene::init("scene_pri_bunker_unlock", level.infinite_hallway_loop_unlock_door_struct.door_left);
  level.infinite_hallway_loop_unlock_door_struct.door_left show();
  level flag::clear("flag_infinite_hallway_corridor_1_corner_geo");
  level flag::set("infinite_hallway_visit_loop_complete");
}

function function_24c67e2a(var_d5ebd613) {
  struct = struct::get("exit_door_pos_" + var_d5ebd613 + "_struct", "targetname");
  flag = "flag_update_exit_door_to_pos_" + var_d5ebd613;

  while(level flag::get(flag)) {
    if(!util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (0, 0, 64), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, self.door_left.origin + (0, 0, 64), cos(70))) {
      self.door_left scene::stop();

      if(!isDefined(level.var_ffd4e184)) {
        self function_19d60154(level.infinite_hallway_loop_door_facade);
      }

      door_struct = struct::get("exit_door_pos_" + var_d5ebd613 + "_door_struct", "targetname");
      level.var_ffd4e184.origin = door_struct.origin;
      level.var_ffd4e184.angles = door_struct.angles;

      if(isDefined(self.hidden)) {
        level thread namespace_b508dca::function_ed113f39(undefined, "infinite_hallway_loop_unlock_door_struct");
        level.infinite_hallway_loop_unlock_door_struct.hidden = undefined;
      }

      if(isDefined(level.var_74dde09e)) {
        foreach(ent in level.var_74dde09e) {
          if(isDefined(ent.script_noteworthy)) {
            flag = "flag_" + ent.script_noteworthy;

            if(level flag::exists(flag) && !level flag::get(flag)) {
              level flag::set(flag);
            }
          }
        }
      }

      level.var_74dde09e = getEntArray("exit_door_pos_" + var_d5ebd613 + "_wall", "script_noteworthy");

      foreach(ent in level.var_74dde09e) {
        if(isDefined(ent.script_noteworthy)) {
          flag = "flag_" + ent.script_noteworthy;

          if(level flag::exists(flag) && level flag::get(flag)) {
            level flag::clear(flag);
          }
        }
      }

      level.var_b551b5a = "infinite_hallway_loop_corner_" + var_d5ebd613 + "_unlock_door_scene";
      level scene::init(level.var_b551b5a, self.door_left);
      return;
    }

    wait 0.1;
  }
}

function function_7e5818d6() {
  level.infinite_hallway_loop_unlock_door_struct.door_interact endon(#"trigger");
  var_2bcd20d6 = "flag_update_exit_door_to_pos_4";

  while(true) {
    level flag::wait_till("flag_update_exit_door_to_pos_1");
    level.infinite_hallway_loop_unlock_door_struct function_24c67e2a(1);
    level flag::wait_till("flag_update_exit_door_to_pos_2");
    level.infinite_hallway_loop_unlock_door_struct function_24c67e2a(2);
    level flag::wait_till("flag_update_exit_door_to_pos_3");
    level.infinite_hallway_loop_unlock_door_struct function_24c67e2a(3);
    level flag::wait_till("flag_update_exit_door_to_pos_4");
    level.infinite_hallway_loop_unlock_door_struct function_24c67e2a(4);
    wait 0.05;
  }
}

function function_5f2165df(hide, var_6cd0b669) {
  if(isDefined(hide)) {
    if(isstruct(self)) {
      if(isDefined(self.targetname) && issubstr(self.targetname, var_6cd0b669)) {
        if(!isDefined(self.var_8cfd0ab2)) {
          self.var_8cfd0ab2 = spawn("script_model", self.origin);
          self.var_8cfd0ab2.angles = self.angles;
          self.var_8cfd0ab2 setModel(self.model);
          self.var_8cfd0ab2 thread namespace_d9b153b9::ent_cleanup("infinite_hallway_exited", 1);
        }

        self.var_8cfd0ab2 show();
      }
    }

    return;
  }

  if(isstruct(self)) {
    if(isDefined(self.targetname) && isDefined(self.var_8cfd0ab2) && issubstr(self.targetname, var_6cd0b669)) {
      self.var_8cfd0ab2 hide();
    }
  }
}

function function_bf2933ed(var_158dfaa2, loop_count, activate) {
  level endon(#"infinite_hallway_visit_loop_complete");
  var_6dcda4d1 = getent("corridor_" + var_158dfaa2 + "_volume", "targetname");
  var_5f7546ed = "infinite_hallway_corridor_loop_" + loop_count;
  var_c79810e5 = struct::get_array(var_5f7546ed, "targetname");
  var_6cd0b669 = "infinite_hallway_corridor_" + var_158dfaa2 + "_loop_" + loop_count;
  var_7525f383 = struct::get_array("infinite_hallway_corridor_" + var_158dfaa2 + "_loop_" + loop_count, "targetname");

  if(isDefined(activate)) {
    array::thread_all(var_7525f383, &function_5f2165df, 1, var_6cd0b669);

    if(loop_count == 1) {
      foreach(struct in level.var_4adb0f8) {
        if(isDefined(struct.script_noteworthy) && issubstr(struct.script_noteworthy, "corridor_" + var_158dfaa2) && struct.script_noteworthy != "corridor_2_door_6") {
          struct.door_left function_3f816598(1, 0.05);
          wait 0.05;
          struct thread function_acfb9b2d(var_5f7546ed);
        }
      }

      if(var_158dfaa2 == 3) {
        level thread scene::play("scene_pri_hallway_loop_adler");
        level thread namespace_b6fe1dbe::function_d4255748();
        setDvar(#"r_motionblurstrength", 1);
        level thread exploder::exploder("FX_hallway_shaky_head_adler");
      }

      if(var_158dfaa2 == 4) {}
    } else if(loop_count == 2) {
      level.player clientfield::set_to_player("lerp_fov", 5);

      if(var_158dfaa2 == 1) {
        level.var_2ac670e8 = 1;

        if(isDefined(level.var_3814631a)) {
          level.var_3814631a.origin = level.var_dcfead6b.origin;

          foreach(brushmodel in level.var_be8a7ed0) {
            if(isDefined(brushmodel)) {
              brushmodel show();
            }
          }

          level.var_f0d3e73b = level.var_dcfead6b.origin;
          level.var_2a353790.origin = level.var_cf2a2b72.origin;

          foreach(brushmodel in level.var_4620ea49) {
            if(isDefined(brushmodel)) {
              brushmodel show();
            }
          }

          level namespace_d9b153b9::function_cf0f5dc6(level.var_5ab10178, 1);

          if(isDefined(level.infinite_hallway_cart_clip)) {
            level.infinite_hallway_cart_clip notsolid();
          }

          level util::function_bfa9c188("corridor_1_dynmodel", 1);
          level namespace_d9b153b9::function_cf0f5dc6(level.corridor_1_pipe_script_brushmodels, 1);
          level util::function_bfa9c188("corridor_2_corner_dynmodel", 1);
          level namespace_d9b153b9::function_cf0f5dc6(level.corridor_2_corner_pipe_script_brushmodels, 1);
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_02");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_02");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_03");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_03");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_03");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_04");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_04");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_04");
          level exploder::exploder("lgt_shrinkhall_01");
        }
      }

      if(var_158dfaa2 == 2) {
        level.var_4196ac75 = 1;

        if(isDefined(level.var_1193c77e)) {
          level.var_1193c77e.origin = level.var_9bae4ba1.origin;

          foreach(brushmodel in level.var_340b140b) {
            if(isDefined(brushmodel)) {
              brushmodel show();
            }
          }

          level.var_26e508a8 = level.var_9bae4ba1.origin;
          level.var_a77dd496.origin = level.var_dcfead6b.origin;

          foreach(brushmodel in level.var_30d625b7) {
            if(isDefined(brushmodel)) {
              brushmodel show();
            }
          }

          level util::function_bfa9c188("corridor_2_dynmodel", 1);
          level namespace_d9b153b9::function_cf0f5dc6(level.corridor_2_pipe_script_brushmodels, 1);
          corridor_2_corner = getEntArray("infinite_hallway_loop_door_blocker", "script_noteworthy");

          foreach(ent in corridor_2_corner) {
            if(isDefined(ent.model) && ent.model == "p9_vnm_laboratory_ceiling_02") {
              ent hide();
            }
          }

          var_ce0740d0 = getEntArray("corridor_2_ceiling_pieces", "script_noteworthy");

          foreach(ent in var_ce0740d0) {
            if(isDefined(ent.model) && ent.model == "p9_vnm_lab_ceiling_scripted_01") {
              ent hide();
            }
          }

          level util::function_bfa9c188("corridor_3_corner_dynmodel", 1);
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_05");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_05");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_06");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_06");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_06");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_07");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_07");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_07");
          level exploder::exploder("lgt_shrinkhall_02");
          level thread namespace_b6fe1dbe::shrinking_hallway_start();
          level thread namespace_b6fe1dbe::shrinking_hallway2_unhide();
        }
      }

      if(var_158dfaa2 == 3) {
        level.var_2ade2100 = 1;

        if(isDefined(level.var_92bf0856)) {
          level.var_92bf0856.origin = level.var_9c6cfa20.origin;

          foreach(brushmodel in level.var_8f1b4e46) {
            if(isDefined(brushmodel)) {
              brushmodel show();
            }
          }

          level.var_60000886 = level.var_9c6cfa20.origin;
          level.var_a47ab6eb.origin = level.var_9bae4ba1.origin;

          foreach(brushmodel in level.var_723c531e) {
            if(isDefined(brushmodel)) {
              brushmodel show();
            }
          }

          level util::function_bfa9c188("corridor_3_dynmodel", 1);
          level namespace_d9b153b9::function_cf0f5dc6(level.corridor_3_pipe_script_brushmodels, 1);
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_08");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_08");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_09");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_09");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_09");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_10");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_10");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_10");
          level exploder::exploder("lgt_shrinkhall_03");
          level thread namespace_b6fe1dbe::shrinking_hallway3_unhide();
        }
      }

      if(var_158dfaa2 == 4) {
        if(isDefined(level.var_ff9012a)) {
          level.var_ff9012a.origin = level.var_9c6cfa20.origin;

          foreach(brushmodel in level.var_624718c0) {
            if(isDefined(brushmodel)) {
              brushmodel show();
            }
          }

          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_11");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_11");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_01");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_01");
          level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_01");
          level exploder::exploder("lgt_shrinkhall_04");
          level thread namespace_b6fe1dbe::shrinking_hallway4_unhide();
        }
      }
    } else if(loop_count == 3) {
      level.player clientfield::set_to_player("lerp_fov", 0);

      if(var_158dfaa2 == 1) {
        foreach(brushmodel in level.var_be8a7ed0) {
          if(isDefined(brushmodel)) {
            brushmodel hide();
          }
        }

        foreach(brushmodel in level.var_4620ea49) {
          if(isDefined(brushmodel)) {
            brushmodel hide();
          }
        }

        if(!level flag::get("infinite_hallway_visit_loop_complete") && !level flag::get("flag_player_exiting_shrinking_loop")) {
          level namespace_d9b153b9::function_cf0f5dc6(level.var_5ab10178);

          if(isDefined(level.infinite_hallway_cart_clip)) {
            level.infinite_hallway_cart_clip solid();
          }

          level util::function_bfa9c188("corridor_1_dynmodel", 0);
          level namespace_d9b153b9::function_cf0f5dc6(level.corridor_1_pipe_script_brushmodels);
          level util::function_bfa9c188("corridor_2_corner_dynmodel", 0);
          level namespace_d9b153b9::function_cf0f5dc6(level.corridor_2_corner_pipe_script_brushmodels);
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_02");
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_02");
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_03");
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_03");
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_03");
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_04");
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_04");
          level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_04");
          level exploder::stop_exploder("lgt_shrinkhall_01");
          level thread namespace_b6fe1dbe::shrinking_hallway1_hide();
        }

        if(isDefined(level.player_exiting_shrinking_loop_trigger.trigger_off)) {
          level.player_exiting_shrinking_loop_trigger triggerenable(1);
          level.player_exiting_shrinking_loop_trigger.trigger_off = undefined;
          level flag::set("flag_enable_corridor_loop_cleanup");
        }
      }
    }

    return;
  }

  if(level.var_f668e14a == loop_count) {
    array::thread_all(var_7525f383, &function_5f2165df, undefined, var_6cd0b669);
  }

  if(loop_count == 1) {
    foreach(struct in level.var_4adb0f8) {
      if(isDefined(struct.script_noteworthy) && issubstr(struct.script_noteworthy, "corridor_" + var_158dfaa2)) {
        struct.door_left thread function_3f816598();
      }
    }

    if(level.var_f668e14a != loop_count && var_158dfaa2 == 2) {
      if(level scene::is_active("scene_pri_hallway_loop_adler")) {
        level thread scene::stop("scene_pri_hallway_loop_adler");
        level scene::delete_scene_spawned_ents("scene_pri_hallway_loop_adler");
        setDvar(#"r_motionblurstrength", 0.2);
        level thread exploder::kill_exploder("FX_hallway_shaky_head_adler");
      }
    }

    return;
  }

  if(loop_count == 2) {
    if(level.var_f668e14a == loop_count && var_158dfaa2 == 1) {
      foreach(brushmodel in level.var_be8a7ed0) {
        if(isDefined(brushmodel)) {
          brushmodel hide();
        }
      }

      foreach(brushmodel in level.var_4620ea49) {
        if(isDefined(brushmodel)) {
          brushmodel hide();
        }
      }

      if(!level flag::get("infinite_hallway_visit_loop_complete") && !level flag::get("flag_player_exiting_shrinking_loop")) {
        level namespace_d9b153b9::function_cf0f5dc6(level.var_5ab10178);

        if(isDefined(level.infinite_hallway_cart_clip)) {
          level.infinite_hallway_cart_clip solid();
        }

        level util::function_bfa9c188("corridor_1_dynmodel", 0);
        level namespace_d9b153b9::function_cf0f5dc6(level.corridor_1_pipe_script_brushmodels);
        level util::function_bfa9c188("corridor_2_corner_dynmodel", 0);
        level namespace_d9b153b9::function_cf0f5dc6(level.corridor_2_corner_pipe_script_brushmodels);
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_02");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_02");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_03");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_03");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_03");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_04");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_04");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_04");
        level exploder::stop_exploder("lgt_shrinkhall_01");
        level thread namespace_b6fe1dbe::shrinking_hallway1_hide();
      }
    } else if(level.var_f668e14a != loop_count && var_158dfaa2 == 1) {}

    if(level.var_f668e14a == loop_count && var_158dfaa2 == 2) {
      foreach(brushmodel in level.var_340b140b) {
        if(isDefined(brushmodel)) {
          brushmodel hide();
        }
      }

      foreach(brushmodel in level.var_30d625b7) {
        if(isDefined(brushmodel)) {
          brushmodel hide();
        }
      }

      if(!level flag::get("infinite_hallway_visit_loop_complete") && !level flag::get("flag_player_exiting_shrinking_loop")) {
        level util::function_bfa9c188("corridor_2_dynmodel", 0);
        level namespace_d9b153b9::function_cf0f5dc6(level.corridor_2_pipe_script_brushmodels);
        corridor_2_corner = getEntArray("infinite_hallway_loop_door_blocker", "script_noteworthy");

        foreach(ent in corridor_2_corner) {
          if(isDefined(ent.model) && ent.model == "p9_vnm_laboratory_ceiling_02") {
            ent show();
          }
        }

        var_ce0740d0 = getEntArray("corridor_2_ceiling_pieces", "script_noteworthy");

        foreach(ent in var_ce0740d0) {
          if(isDefined(ent.model) && ent.model == "p9_vnm_lab_ceiling_scripted_01") {
            ent show();
          }
        }

        level util::function_bfa9c188("corridor_3_corner_dynmodel", 0);
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_05");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_05");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_06");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_06");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_06");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_07");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_07");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_07");
        level exploder::stop_exploder("lgt_shrinkhall_02");
        level thread namespace_b6fe1dbe::shrinking_hallway2_hide();
      }
    }

    if(level.var_f668e14a == loop_count && var_158dfaa2 == 3) {
      foreach(brushmodel in level.var_8f1b4e46) {
        if(isDefined(brushmodel)) {
          brushmodel hide();
        }
      }

      foreach(brushmodel in level.var_723c531e) {
        if(isDefined(brushmodel)) {
          brushmodel hide();
        }
      }

      if(!level flag::get("infinite_hallway_visit_loop_complete") && !level flag::get("flag_player_exiting_shrinking_loop")) {
        level util::function_bfa9c188("corridor_3_dynmodel", 0);
        level namespace_d9b153b9::function_cf0f5dc6(level.corridor_3_pipe_script_brushmodels);
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_08");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_08");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_09");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_09");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_09");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_10");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_10");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_10");
        level exploder::stop_exploder("lgt_shrinkhall_03");
        level thread namespace_b6fe1dbe::shrinking_hallway3_hide();
      }
    }

    if(level.var_f668e14a == loop_count && var_158dfaa2 == 4) {
      foreach(brushmodel in level.var_624718c0) {
        if(isDefined(brushmodel)) {
          brushmodel hide();
        }
      }

      if(!level flag::get("infinite_hallway_visit_loop_complete") && !level flag::get("flag_player_exiting_shrinking_loop")) {
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_11");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_11");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_01");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_01");
        level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_01");
        level exploder::stop_exploder("lgt_shrinkhall_04");
        level thread namespace_b6fe1dbe::shrinking_hallway4_hide();
      }
    }

    return;
  }

  if(loop_count == 3) {
    if(level.var_f668e14a == loop_count && var_158dfaa2 == 1) {
      foreach(brushmodel in level.var_be8a7ed0) {
        if(isDefined(brushmodel)) {
          brushmodel show();
        }
      }

      foreach(brushmodel in level.var_4620ea49) {
        if(isDefined(brushmodel)) {
          brushmodel show();
        }
      }

      if(!level flag::get("infinite_hallway_visit_loop_complete") && !level flag::get("flag_player_exiting_shrinking_loop")) {
        level namespace_d9b153b9::function_cf0f5dc6(level.var_5ab10178, 1);

        if(isDefined(level.infinite_hallway_cart_clip)) {
          level.infinite_hallway_cart_clip notsolid();
        }

        level util::function_bfa9c188("corridor_1_dynmodel", 1);
        level namespace_d9b153b9::function_cf0f5dc6(level.corridor_1_pipe_script_brushmodels, 1);
        level util::function_bfa9c188("corridor_2_corner_dynmodel", 1);
        level namespace_d9b153b9::function_cf0f5dc6(level.corridor_2_corner_pipe_script_brushmodels, 1);
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_02");
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_02");
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_03");
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_03");
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_03");
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_key_04");
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_ballast_04");
        level thread namespace_d9b153b9::function_c318ce4a("lgt_infhall_kick_04");
        level exploder::exploder("lgt_shrinkhall_01");
        level thread namespace_b6fe1dbe::shrinking_hallway1_unhide();
      }

      if(!isDefined(level.player_exiting_shrinking_loop_trigger.trigger_off)) {
        level.player_exiting_shrinking_loop_trigger triggerenable(0);
        level.player_exiting_shrinking_loop_trigger.trigger_off = 1;
      }

      level flag::clear("flag_enable_corridor_loop_cleanup");
    }
  }
}

function function_b9455f01(modelscale, var_158dfaa2) {
  if(level flag::get("flag_delete_shrinking_loop")) {
    return;
  }

  if(isDefined(modelscale)) {
    foreach(struct in level.var_4adb0f8) {
      if(isDefined(struct.script_noteworthy) && issubstr(struct.script_noteworthy, "corridor_" + var_158dfaa2)) {
        if(isDefined(struct.var_3deb0c3d)) {
          if(isDefined(struct.door_frame)) {
            if(isDefined(struct.linked_ents)) {
              foreach(linked_ent in struct.linked_ents) {
                if(isDefined(linked_ent.script_noteworthy) && linked_ent.script_noteworthy != "door_frame") {
                  linked_ent linkto(struct.door_frame);
                }

                if(isDefined(struct.var_3deb0c3d.script_parameters) && (linked_ent.script_noteworthy == "door_left" || linked_ent.script_noteworthy == "door_frame" || linked_ent.script_noteworthy == "door_script_brushmodels")) {
                  linked_ent setscale(float(struct.var_3deb0c3d.script_parameters));
                }
              }
            }
          }

          struct.door_frame.origin = (struct.var_3deb0c3d.origin[0], struct.var_3deb0c3d.origin[1], struct.door_frame.origin[2]);
          struct.door_frame.angles = struct.var_3deb0c3d.angles;
        }
      }
    }

    return;
  }

  foreach(struct in level.var_4adb0f8) {
    if(isDefined(struct.script_noteworthy) && issubstr(struct.script_noteworthy, "corridor_" + var_158dfaa2)) {
      if(isDefined(struct.var_3deb0c3d)) {
        if(isDefined(struct.door_frame)) {
          if(isDefined(struct.linked_ents)) {
            foreach(linked_ent in struct.linked_ents) {
              if(isDefined(struct.var_3deb0c3d.script_parameters) && (linked_ent.script_noteworthy == "door_left" || linked_ent.script_noteworthy == "door_frame" || linked_ent.script_noteworthy == "door_script_brushmodels")) {
                linked_ent setscale(1);
              }
            }
          }
        }

        struct.door_frame.origin = struct.original_origin;
        struct.door_frame.angles = struct.original_angles;
      }
    }
  }
}

function function_87b67c58() {
  level flag::wait_till_any(array("flag_player_exiting_shrinking_loop", "infinite_hallway_visit_loop_complete"));

  if(!level flag::get("infinite_hallway_visit_loop_complete")) {
    var_7fb8936 = [];
    is_offscreen = 0;

    while(!is_offscreen && !level flag::get("corridor_2_activate")) {
      struct = struct::get("infinite_hallway_shrinking_hallway_end_struct", "targetname");

      if(!util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin, cos(70)) && level flag::get("flag_player_exited_shrinking_loop") && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (-48, 0, 0), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (-48, 64, 0), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (-48, -64, 0), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (-48, 64, 64), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (-48, -64, -64), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (-48, 64, 64), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (-48, -64, -64), cos(70)) && !util::within_fov(level.players[0].origin, level.players[0].angles, struct.origin + (64, 64, 64), cos(70))) {
        is_offscreen = 1;
      }

      wait 0.1;
    }
  }

  if(level flag::get("infinite_hallway_visit_loop_complete")) {
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_02");
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_02");
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_03");
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_03");
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_03");
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_04");
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_04");
    level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_04");
    level exploder::stop_exploder("lgt_shrinkhall_01");
    level util::function_bfa9c188("corridor_1_dynmodel", 0);
    level util::function_bfa9c188("corridor_2_corner_dynmodel", 0);
    level namespace_d9b153b9::function_cf0f5dc6(level.var_5ab10178);

    if(isDefined(level.infinite_hallway_cart_clip)) {
      level.infinite_hallway_cart_clip solid();
    }
  }

  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_05");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_05");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_06");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_06");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_06");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_07");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_07");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_07");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_08");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_08");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_09");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_09");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_09");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_10");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_10");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_10");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_11");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_11");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_key_01");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_ballast_01");
  level thread namespace_d9b153b9::function_b96db417("lgt_infhall_kick_01");
  level exploder::stop_exploder("lgt_shrinkhall_02");
  level exploder::stop_exploder("lgt_shrinkhall_03");
  level exploder::stop_exploder("lgt_shrinkhall_04");
  level util::function_bfa9c188("corridor_2_dynmodel", 0);
  level util::function_bfa9c188("corridor_3_dynmodel", 0);
  level util::function_bfa9c188("corridor_3_corner_dynmodel", 0);
  level namespace_d9b153b9::function_cf0f5dc6(level.corridor_2_pipe_script_brushmodels);
  level namespace_d9b153b9::function_cf0f5dc6(level.corridor_3_pipe_script_brushmodels);
  corridor_2_corner = getEntArray("infinite_hallway_loop_door_blocker", "script_noteworthy");

  foreach(ent in corridor_2_corner) {
    if(isDefined(ent.model) && ent.model == "p9_vnm_laboratory_ceiling_02") {
      ent show();
    }
  }

  var_ce0740d0 = getEntArray("corridor_2_ceiling_pieces", "script_noteworthy");

  foreach(ent in var_ce0740d0) {
    if(isDefined(ent.model) && ent.model == "p9_vnm_lab_ceiling_scripted_01") {
      ent show();
    }
  }

  array::thread_all(level.var_57e54c86, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_corridor_1_hall");
  array::thread_all(level.var_4620ea49, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_corridor_2_corner");
  array::thread_all(level.var_be8a7ed0, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_corridor_2_hall");
  array::thread_all(level.var_30d625b7, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_corridor_3_corner");
  array::thread_all(level.var_340b140b, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_corridor_3_hall");
  array::thread_all(level.var_723c531e, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_corridor_4_corner");
  array::thread_all(level.var_8f1b4e46, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("flag_corridor_4_hall");
  array::thread_all(level.var_624718c0, &namespace_d9b153b9::ent_cleanup);

  if(!isDefined(level.player_exiting_shrinking_loop_trigger.trigger_off)) {
    level.player_exiting_shrinking_loop_trigger triggerenable(0);
    level.player_exiting_shrinking_loop_trigger.trigger_off = 1;
  }

  if(isDefined(level.var_ab6fa9fc)) {
    level.var_ab6fa9fc delete();
  }

  if(isDefined(level.var_2a353790)) {
    level.var_2a353790 delete();
  }

  if(isDefined(level.var_3814631a)) {
    level.var_3814631a delete();
  }

  if(isDefined(level.var_a77dd496)) {
    level.var_a77dd496 delete();
  }

  if(isDefined(level.var_1193c77e)) {
    level.var_1193c77e delete();
  }

  if(isDefined(level.var_a47ab6eb)) {
    level.var_a47ab6eb delete();
  }

  if(isDefined(level.var_92bf0856)) {
    level.var_92bf0856 delete();
  }

  if(isDefined(level.var_ff9012a)) {
    level.var_ff9012a delete();
  }

  level flag::set("flag_delete_shrinking_loop");
  level thread namespace_b6fe1dbe::shrinking_hallway_end();
}

function function_e5fea6b0() {
  xoffset = 15;
  yoffset = 175;
  var_981bb6ec = 15;
  namespace_d9b153b9::function_6c8fccf2("<dev string:x38>", xoffset, yoffset + var_981bb6ec * 12);

  while(true) {
    foreach(var_86275d63 in level.var_86275d63) {
      if(issubstr(tolower(var_86275d63.str), "<dev string:x55>")) {
        var_86275d63 settext(var_86275d63.str + level.var_f668e14a);
      }

      level waittilltimeout(5, #"hash_7e0ec26676ae3d41");
    }
  }
}

function function_14147c77() {
  level endon(#"infinite_hallway_exited");
  level endon(#"infinite_hallway_visit_loop_complete");
  level.var_f668e14a = 0;
  var_bdceaa3e = 0;
  last_trigger = 0;
  last_trigger = "corridor_4_activate";
  level flag::set("corridor_1_activate");
  level thread util::delay(0.1, undefined, &flag::clear, "corridor_1_activate");

  while(true) {
    level flag::wait_till_any(array("corridor_1_activate", "corridor_2_activate", "corridor_3_activate", "corridor_4_activate"));

    if(level flag::get("corridor_1_activate")) {
      if(last_trigger != "corridor_1_activate") {
        if(last_trigger == "corridor_4_activate") {
          level.var_f668e14a++;
          level notify(#"hash_7e0ec26676ae3d41");
          flag = "infinite_hallway_corridor_loop_" + level.var_f668e14a;

          if(level flag::exists(flag)) {
            level flag::set(flag);
          }

          var_bdceaa3e = 1;
          level thread function_bf2933ed(2, level.var_f668e14a - 1);
          level thread function_bf2933ed(1, level.var_f668e14a, 1);
        } else if(last_trigger == "corridor_2_activate") {
          if(var_bdceaa3e > 0) {
            var_bdceaa3e--;
          }

          level thread function_bf2933ed(2, level.var_f668e14a);
        }

        last_trigger = "corridor_1_activate";
      }
    } else if(level flag::get("corridor_2_activate")) {
      if(last_trigger != "corridor_2_activate") {
        if(last_trigger == "corridor_1_activate") {
          var_bdceaa3e++;
          level thread function_bf2933ed(3, level.var_f668e14a - 1);
          level thread function_bf2933ed(2, level.var_f668e14a, 1);
        } else if(last_trigger == "corridor_3_activate") {
          if(var_bdceaa3e > 0) {
            var_bdceaa3e--;
          }

          level thread function_bf2933ed(3, level.var_f668e14a);
        }

        last_trigger = "corridor_2_activate";
      }
    } else if(level flag::get("corridor_3_activate")) {
      if(last_trigger != "corridor_3_activate") {
        if(last_trigger == "corridor_2_activate") {
          var_bdceaa3e++;
          level thread function_bf2933ed(4, level.var_f668e14a - 1);
          level thread function_bf2933ed(3, level.var_f668e14a, 1);
        } else if(last_trigger == "corridor_4_activate") {
          if(var_bdceaa3e > 0) {
            var_bdceaa3e--;
          }

          level thread function_bf2933ed(4, level.var_f668e14a);
        }

        last_trigger = "corridor_3_activate";
      }
    } else if(level flag::get("corridor_4_activate")) {
      if(last_trigger != "corridor_4_activate") {
        if(last_trigger == "corridor_3_activate") {
          var_bdceaa3e++;
          level thread function_bf2933ed(1, level.var_f668e14a - 1);
          level thread function_bf2933ed(4, level.var_f668e14a, 1);
        } else if(last_trigger == "corridor_1_activate") {
          level notify(#"hash_7e0ec26676ae3d41");
          flag = "infinite_hallway_corridor_loop_" + level.var_f668e14a;

          if(level flag::exists(flag)) {
            level flag::clear(flag);
          }

          var_bdceaa3e = 4;
          level thread function_bf2933ed(1, level.var_f668e14a);

          if(level.var_f668e14a > 0) {
            level.var_f668e14a--;
          }
        }

        last_trigger = "corridor_4_activate";
      }
    }

    wait 0.05;
  }
}

function function_acfb9b2d(var_5f7546ed) {
  level endon(#"infinite_hallway_exited");
  level endon(var_5f7546ed);
  self.door_left thread namespace_b6fe1dbe::function_46e4b64f();
  var_1403135a = struct::get(self.script_noteworthy + "_magicbullet_start", "targetname");

  while(true) {
    distance = distancesquared(level.players[0].origin, self.door_left.origin);

    if(distance < 36100) {
      if(isDefined(var_1403135a)) {
        if(!isDefined(self.var_b67257e7)) {
          self.var_b67257e7 = 1;
          self thread function_15a302bb(var_1403135a);
        }
      }
    }

    if(distance < 30625) {
      break;
    }

    wait 0.1;
  }

  var_e0b06bb2 = undefined;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "corridor_1_door_3") {
    level notify(#"corridor_1_door_3");
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "corridor_3_door_4") {
    var_e0b06bb2 = self.script_noteworthy;
  }

  self.door_left thread function_3f816598(undefined, 0.5, 1, var_e0b06bb2);
  self.var_b67257e7 = undefined;
}

function function_15a302bb(start_struct) {
  end_struct = struct::get(start_struct.target, "targetname");
  magicbullet(getweapon(#"hash_4ff481a4f55ed901"), start_struct.origin, end_struct.origin + (-10, 0, -40));
  wait randomfloatrange(0.1, 0.15);
  magicbullet(getweapon(#"hash_4ff481a4f55ed901"), start_struct.origin, end_struct.origin + (5, 0, -20));
  wait randomfloatrange(0.1, 0.15);
  magicbullet(getweapon(#"hash_4ff481a4f55ed901"), start_struct.origin, end_struct.origin);
}

function infinite_hallway_visit_4() {
  level endon(#"infinite_hallway_exited");
  level thread scene::init("scene_pri_lab_floor");
  level flag::set("infinite_hallway_visit_lab");
  level flag::set("infinite_hallway_exit_ready");
  level.infinite_hallway_loop_unlock_door_struct namespace_d9b153b9::function_736b8a03(1);
  level.infinite_hallway_exit_unlock_door_struct thread namespace_d9b153b9::function_736b8a03();
  level flag::set("flag_infinite_hallway_lab_door");
  level.infinite_hallway_lab_backtrack_blocker notsolid();
  level.player setmovespeedscale(0.75);
  level flag::wait_till("flag_player_not_at_floor_fall");
  level thread namespace_b6fe1dbe::stop_hallway_sfx();
  level flag::wait_till_clear("flag_player_not_at_floor_fall");
  level.player setmovespeedscale(0.5);
  level thread namespace_b6fe1dbe::evt_cp_nam_bunk_trap_floor();
  level thread scene::play("scene_pri_lab_floor");
  level thread exploder::exploder("CinFX_InfHall_FloorCollapse");
  screenshake(level.player.origin, 1, 0, 1, 2, 0, -1, 0, 4, 0, 7, 2);
  level.player playrumbleonentity("damage_heavy");
  level.player clientfield::set_to_player("lerp_fov", 5);
  level thread function_6a361dc1();
  level.infinite_hallway_lab_backtrack_blocker solid();
  wait 0.45;

  foreach(ent in level.infinite_hallway_lab_floor) {
    if(isDefined(ent)) {
      if(!isDefined(ent.script_noteworthy)) {
        ent hide();
      }

      ent notsolid();
    }
  }

  foreach(ent in level.infinite_hallway_bunker_ceiling) {
    if(isDefined(ent)) {
      ent hide();
      ent notsolid();
    }
  }

  level flag::set("flag_lab_fall_debris");
  level.player setmovespeedscale(1);
  level.player allowsprint(1);
  level thread scene::play("scene_pri_hallway_fall");
  level.infinite_hallway_loop_unlock_door_struct.door_interact waittill(#"trigger");
  level.player clientfield::set_to_player("lerp_fov", 0);
  level flag::clear("flag_infinite_hallway_lab_door");
  level flag::clear("flag_lab_fall_debris");
  level thread scene::stop("scene_pri_lab_floor");
  level scene::delete_scene_spawned_ents("scene_pri_lab_floor");
}

function function_6a361dc1() {
  level endon(#"infinite_hallway_exited");
  level.player enableinvulnerability();
  corridor_2_volume = getent("corridor_2_volume", "targetname");
  count = 0;

  while(!level.player istouching(corridor_2_volume) || count > 150) {
    count++;
    wait 0.1;
  }

  wait 1;
  level.player disableinvulnerability();
}

function function_dbcfb3e2(door_struct) {
  door_struct.door_interact waittill(#"trigger");
  level thread namespace_b6fe1dbe::infinite_hallway_ambience_end();
  level thread namespace_d9b153b9::pstfx_teleport(1, 0, "door");
  level scene::play(level.var_b551b5a, level.infinite_hallway_loop_unlock_door_struct.door_left);
  level flag::set("flag_clear_teleport_fx");
  level flag::set("infinite_hallway_exited");

  if(isDefined(level.infinite_hallway)) {
    level.var_ffd4e184 delete();
  }

  level exploder::stop_exploder("lgt_cleanhalldrop");
  level.player util::function_7f49ffb7();
}

function function_be61f4c4() {
  if(level flag::exists("flag_exit_door_pos_1_wall") && level flag::get("flag_exit_door_pos_1_wall")) {
    level flag::clear("flag_exit_door_pos_1_wall");
  }

  if(level flag::exists("flag_exit_door_pos_2_wall") && level flag::get("flag_exit_door_pos_2_wall")) {
    level flag::clear("flag_exit_door_pos_2_wall");
  }

  if(level flag::exists("flag_exit_door_pos_3_wall") && level flag::get("flag_exit_door_pos_3_wall")) {
    level flag::clear("flag_exit_door_pos_3_wall");
  }

  if(level flag::exists("flag_exit_door_pos_4_wall") && level flag::get("flag_exit_door_pos_4_wall")) {
    level flag::clear("flag_exit_door_pos_4_wall");
  }

  if(level flag::exists("flag_infinite_hallway_loop_door_blocker") && level flag::get("flag_infinite_hallway_loop_door_blocker")) {
    level flag::clear("flag_infinite_hallway_loop_door_blocker");
  }

  if(level flag::exists("flag_infinite_hallway_corridor_blocker_1") && level flag::get("flag_infinite_hallway_corridor_blocker_1")) {
    level flag::clear("flag_infinite_hallway_corridor_blocker_1");
  }

  if(level flag::exists("flag_infinite_hallway_corridor_blocker_2") && level flag::get("flag_infinite_hallway_corridor_blocker_2")) {
    level flag::clear("flag_infinite_hallway_corridor_blocker_2");
  }

  if(level flag::exists("flag_infinite_hallway_corridor_1_corner_geo") && level flag::get("flag_infinite_hallway_corridor_1_corner_geo")) {
    level flag::clear("flag_infinite_hallway_corridor_1_corner_geo");
  }

  if(!isDefined(level.infinite_hallway_cart_clip)) {
    level.infinite_hallway_cart_clip = getent("infinite_hallway_cart_clip", "targetname");
  }

  level.infinite_hallway_cart_clip thread namespace_d9b153b9::ent_cleanup();

  if(!isDefined(level.infinite_hallway_exit_unlock_door_struct)) {
    level.infinite_hallway_exit_unlock_door_struct = namespace_d9b153b9::door_setup("infinite_hallway_exit_unlock_door_struct", 1, 1);
  }

  level.infinite_hallway_exit_unlock_door_struct thread namespace_d9b153b9::ent_cleanup();

  if(!isDefined(level.infinite_hallway_loop_unlock_door_struct)) {
    level.infinite_hallway_loop_unlock_door_struct = namespace_d9b153b9::door_setup("infinite_hallway_loop_unlock_door_struct", 1, 1);
  }

  level.infinite_hallway_loop_unlock_door_struct thread namespace_d9b153b9::ent_cleanup();
  infinite_hallway_wall_blockers = getEntArray("infinite_hallway_wall_blockers", "targetname");
  array::thread_all(infinite_hallway_wall_blockers, &namespace_d9b153b9::ent_cleanup);
  infinite_hallway_door_facades = getEntArray("infinite_hallway_door_facades", "targetname");
  array::thread_all(infinite_hallway_door_facades, &namespace_d9b153b9::ent_cleanup);

  if(!isDefined(level.infinite_hallway_lab_backtrack_blocker)) {
    level.infinite_hallway_lab_backtrack_blocker = getent("infinite_hallway_lab_backtrack_blocker", "targetname");
  }

  level.infinite_hallway_lab_backtrack_blocker thread namespace_d9b153b9::ent_cleanup();

  if(!isDefined(level.infinite_hallway_lab_floor)) {
    level.infinite_hallway_lab_floor = getEntArray("infinite_hallway_lab_floor", "targetname");
  }

  array::thread_all(level.infinite_hallway_lab_floor, &namespace_d9b153b9::ent_cleanup);

  if(!isDefined(level.infinite_hallway_bunker_ceiling)) {
    level.infinite_hallway_bunker_ceiling = getEntArray("infinite_hallway_bunker_ceiling", "targetname");
  }

  array::thread_all(level.infinite_hallway_bunker_ceiling, &namespace_d9b153b9::ent_cleanup);

  if(!isDefined(level.var_57e54c86)) {
    level.var_57e54c86 = getEntArray("corridor_1_corner", "targetname");
  }

  if(!isDefined(level.var_4620ea49)) {
    level.var_4620ea49 = getEntArray("corridor_1_hall", "targetname");
  }

  if(!isDefined(level.var_be8a7ed0)) {
    level.var_be8a7ed0 = getEntArray("corridor_2_corner", "targetname");
  }

  if(!isDefined(level.var_30d625b7)) {
    level.var_30d625b7 = getEntArray("corridor_2_hall", "targetname");
  }

  if(!isDefined(level.var_340b140b)) {
    level.var_340b140b = getEntArray("corridor_3_corner", "targetname");
  }

  if(!isDefined(level.var_723c531e)) {
    level.var_723c531e = getEntArray("corridor_3_hall", "targetname");
  }

  if(!isDefined(level.var_8f1b4e46)) {
    level.var_8f1b4e46 = getEntArray("corridor_4_corner", "targetname");
  }

  if(!isDefined(level.var_624718c0)) {
    level.var_624718c0 = getEntArray("corridor_4_hall", "targetname");
  }

  if(!isDefined(level.corridor_1_pipe_script_brushmodels)) {
    level.corridor_1_pipe_script_brushmodels = getEntArray("corridor_1_pipe_script_brushmodels", "targetname");
  }

  if(!isDefined(level.corridor_2_corner_pipe_script_brushmodels)) {
    level.corridor_2_corner_pipe_script_brushmodels = getEntArray("corridor_2_corner_pipe_script_brushmodels", "targetname");
  }

  if(!isDefined(level.corridor_2_pipe_script_brushmodels)) {
    level.corridor_2_pipe_script_brushmodels = getEntArray("corridor_2_pipe_script_brushmodels", "targetname");
  }

  if(!isDefined(level.corridor_3_pipe_script_brushmodels)) {
    level.corridor_3_pipe_script_brushmodels = getEntArray("corridor_3_pipe_script_brushmodels", "targetname");
  }

  array::thread_all(level.var_57e54c86, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.var_4620ea49, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.var_be8a7ed0, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.var_30d625b7, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.var_340b140b, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.var_723c531e, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.var_8f1b4e46, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.var_624718c0, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.corridor_1_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.corridor_2_corner_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.corridor_2_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup);
  array::thread_all(level.corridor_3_pipe_script_brushmodels, &namespace_d9b153b9::ent_cleanup);
  level util::function_bfa9c188("corridor_1_dynmodel", 1);
  level util::function_bfa9c188("corridor_2_corner_dynmodel", 1);
  level util::function_bfa9c188("corridor_2_dynmodel", 1);
  level util::function_bfa9c188("corridor_3_corner_dynmodel", 1);
  level util::function_bfa9c188("corridor_3_dynmodel", 1);

  if(!isDefined(level.corner_1_curved_geo)) {
    level.corner_1_curved_geo = getEntArray("corner_1_curved_geo", "targetname");
  }

  array::thread_all(level.corner_1_curved_geo, &namespace_d9b153b9::ent_cleanup);
  infinite_hallway_triggers = getEntArray("infinite_hallway_triggers", "script_noteworthy");
  array::thread_all(infinite_hallway_triggers, &namespace_d9b153b9::ent_cleanup);
  infinite_hallway_volumes = getEntArray("infinite_hallway_volumes", "script_noteworthy");
  array::thread_all(infinite_hallway_volumes, &namespace_d9b153b9::ent_cleanup);
  infinite_hallway_lights = getEntArray("infinite_hallway_lights", "script_noteworthy");
  array::thread_all(infinite_hallway_lights, &namespace_d9b153b9::ent_cleanup);
  level flag::clear("infinite_hallway_exited");
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_51f0a664afd44022.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\anim;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace namespace_ce1886acb51f534b;

function main() {
  getdvarint(@ "hash_3035d5957f5b8314", 0);
  thread function_b91f2272236bff05();
  thread function_399046188ab6af22();
  thread function_f3cbc1ef29772df2();
  thread elevator_restart();
  thread function_5d3d0830eacf52ab();
  thread function_b7b5f77fff8eba5e();
  thread function_519985c5d823aa4();
  thread function_563616756210fdeb();
  thread function_2568e6305419373();
  thread function_5e54514410e59da9();
  thread function_5e9931f4eb825570();
  thread function_6622f7ba9c50f57a();
  flag_init("flag_aud_makarov_answered");
  flag_init("flag_aud_elevator_fake_battle_amb_pt2");
  flag_init("flag_makarov_reveal_igc_start_submix");
  flag_init("makarov_reveal_pcap_end");
  flag_init("flag_aud_courtyard2_last_truck_explo");
  level.var_c3934394c0f5cb03 = "deaths_door_sp_vip";
}

function function_c2e5ebbb02a71b15(alias, delay_time, location) {
  if(!isDefined(location)) {
    location = level.player;
  }

  wait delay_time / 1000;
  snd = snd_play(alias, location);
}

function function_b2601fe6c354199d(alias, start_loc, end_loc, move_time, delay_time) {
  wait delay_time / 1000;
  moving_sound = snd_play(alias, start_loc);
  moving_sound moveTo(end_loc, move_time / 1000);
}

function function_f5b68486b45309f9() {}

function function_a206babc50297a7e() {}

function function_5d3d0830eacf52ab() {
  flag_wait("introscreen_start_wait");
  waitframe();
  level.player setsoundsubmix("sp_jup_vip_global", 0.2);
  level.player stopsoundchannel("amb_bed_2d");
  level.player setsoundsubmix("sp_jup_vip_scuba_intro");
  scooter_wind_down = snd_play("jup_water_scooter_wind_down");
  wait 3;
  var_df7565edba61bbcb = snd_play("dx_sp_jvip_jvrl_koa1_staytight");
  snd_wait(var_df7565edba61bbcb);
  wait 1;
  var_ba60a1f5ebe25675 = snd_play("dx_sp_jvip_jvrl_koa2_rognomovement");
}

function function_96cc4e998f08aca5() {
  if(!isDefined(level.var_270a6f60e1cc3d65)) {
    level.var_270a6f60e1cc3d65 = 1;
    level.player scalevolume(1, 0.2);
    function_adfd4002c83fe6b2("amb_bed_2d", 1, 0.2);
    level.player setsoundsubmix("sp_jup_vip_wall_base");
    level.player clearsoundsubmix("sp_jup_vip_scuba_intro", 0.05);
    battlechatter_off("axis");
    battlechatter_off("allies");
    level.player scalesoundsubmix("sp_jup_vip_underwater_scuba", 0.65);
    wait 2.1;
    level.player clearsoundsubmix("sp_jup_vip_underwater_scuba");
  }
}

function function_5ec1f44b04115fd7() {
  level.player setsoundsubmix("sp_jup_vip_ascend_ladder", 1);
  level.player playSound("vip_grapple_plr_ladder_grab_foley");
}

function function_853e7e2a9a736f5() {
  level.player playSound("vip_grapple_plr_gun_raise");
}

function function_2695736be1020d66() {
  level.player setsoundsubmix("sp_jup_vip_ascend_shot");
  level.player playSound("vip_grapple_plr_grapple_fire_shot");
  thread function_fbe9d8560f5ece3b("vip_grapple_ally_left_grapple_fire", 650, level.ally1);
  thread function_fbe9d8560f5ece3b("vip_grapple_ally_right_grapple_fire", 1010, level.ally2);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_grapple_impact", 3060);
  wait 3;
  level.player clearsoundsubmix("sp_jup_vip_ascend_shot", 3);
  level.player clearsoundsubmix("sp_jup_vip_wall_base", 1);
}

function ascend() {
  level.player setsoundsubmix("sp_jup_vip_ascend");
  level.player playSound("vip_grapple_plr_gun_lower");
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_clip_in_foley", 434);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_clip_in_mech", 1805);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p1", 4901);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p1_land_foley", 6674);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p2", 8013);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p2_step1", 11997);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p2_step2", 12855);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p2_land_foley", 13824);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p3", 14116);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p3_land_foley", 15755);
  thread function_fbe9d8560f5ece3b("vip_grapple_plr_ascend_p3_unclip", 17572);
  thread function_fbe9d8560f5ece3b("vip_grapple_ally_left_ascend_p1", 4013, level.ally1);
  thread function_fbe9d8560f5ece3b("vip_grapple_ally_left_ascend_p2", 7424, level.ally1);
  thread function_fbe9d8560f5ece3b("vip_grapple_ally_left_ascend_p3", 13051, level.ally1);
  thread function_fbe9d8560f5ece3b("vip_grapple_ally_right_ascend_p1", 4596, level.ally2);
  thread function_fbe9d8560f5ece3b("vip_grapple_ally_right_ascend_p3", 13612, level.ally2);
  wait 20;
  level.player clearsoundsubmix("sp_jup_vip_ascend_ladder", 3);
  level.player clearsoundsubmix("sp_jup_vip_ascend", 3);
}

function function_fbe9d8560f5ece3b(alias, delay_time, ent) {
  if(!isDefined(ent)) {
    ent = level.player;
  }

  wait delay_time / 1000;
  ent playSound(alias);
}

function function_700d64c683020ac9() {}

function function_69fd80c891416414() {
  setglobalsoundcontext("jup_fly_fs_terrain", "wet");
}

function function_59c2bb1772a78f2e() {
  setglobalsoundcontext("jup_fly_fs_terrain", "");
}

function function_ea293b64d8fecd6d() {
  battlechatter_off("axis");
  battlechatter_off("allies");
  level.player clearsoundsubmix("sp_jup_vip_wall_base", 1);
}

function function_476aed0f6557231b() {
  battlechatter_on("axis");
}

function function_ea6067a2ca8fb1ff() {
  var_708f951a2679ceb = (-9432, -14365, 1517);
  playsoundatpos(var_708f951a2679ceb, "jup_vip_helicopter_static_start");
}

function function_706ab63d4d8f034b() {
  var_f2aa214cfc7d511c = (-9432, -14365, 1517);
  var_3565090736b4c4b5 = snd_play([5, "jup_vip_helicopter_static_lp", 3], var_f2aa214cfc7d511c);
  snd_stop_on_level_notify(var_3565090736b4c4b5, "flag_infil_chopper_land", 6);
}

function function_3024fd1bd3bebfe() {
  level.heli playSound("jup_vip_helicopter_descend_start");
  var_7b04d77cb9dacb0d = snd_play([5.2, "jup_vip_helicopter_descend_hover_lp", 5.4], level.heli);
  snd_stop_on_level_notify(var_7b04d77cb9dacb0d, "flag_charlie_explosion", 4.5);
}

function function_45f94918253b138a() {
  level.heli playsoundonmovingent("jup_vip_helicopter_descend_takeoff");
}

function function_f3657f158f212b7d() {
  level.heli playSound("jup_vip_helicopter_descend_lp_dist_start");
  var_1485b23140fefc63 = snd_play([7, "jup_vip_helicopter_descend_lp_dist", 4.5], level.heli);
  snd_stop_on_level_notify(var_1485b23140fefc63, "infil_heli_stop_targeting", 8);
}

function function_1334612993990dfa() {}

function function_91fc06baa8e56f0d(truck) {
  flag_wait("flag_send_truck_1");
  prisoner_truck = snd_play("jup_vip_courtyard_truck_engine", truck);
}

function function_6b72014931968dc5() {
  var_d299693c61356de3 = (-12570, -8928, 1914);
  playsoundatpos(var_d299693c61356de3, "scn_vip_explo_trans");
  level.player setsoundsubmix("sp_jup_vip_courtyard_combat_scripted", 0.05);
  flag_wait_either("flag_hatch_nags", "flag_ally_hatch_vo");
  level.player clearsoundsubmix("sp_jup_vip_courtyard_combat_scripted", 2);
}

function function_5ef8ac1cdc725e45() {
  wait 3;
  var_e23ac03c91dc8f4a = (-8837, -16471, 1577);
  level.var_e05fb44af318872e = spawn("script_model", var_e23ac03c91dc8f4a);
  level.var_e05fb44af318872e playLoopSound("jup_vip_alarm_lp_ext");
}

function function_b80f653e86c98321() {
  wait 7;
  var_bb8f70e6e5ea3a69 = (-8887, -14191, 1018);
  level.var_e05fb24af31882c8 = spawn("script_model", var_bb8f70e6e5ea3a69);
  level.var_e05fb24af31882c8 playLoopSound("jup_vip_alarm_lp_int_tunnel");
}

function function_b80f623e86c97c88() {
  level.var_e05fb44af318872e stoploopsound("jup_vip_alarm_lp_ext", 1);
  level.var_e05fb44af318872e delete();
}

function function_8f4fac61a4ac9526() {
  if(isDefined(level.var_e05fb24af31882c8)) {
    level.var_e05fb24af31882c8 stoploopsound("jup_vip_alarm_lp_int_tunnel", 1);
    level.player clearsoundsubmix("sp_jup_vip_descend_alarm_tunnel_grate_open");
    level.var_e05fb24af31882c8 delete();
  }

  var_4f33265f62bf344c = (-8887, -14191, 1018);
  playsoundatpos(var_4f33265f62bf344c, "jup_vip_alarm_int_tunnel_end");
}

function function_81dcf0a672ccda1d() {
  if(!isDefined(level.var_dd98ad2cb1e25474)) {
    var_bb8f70e6e5ea3a69 = (-8887, -14191, 1018);
    level.var_e05fb24af31882c8 = spawn("script_model", var_bb8f70e6e5ea3a69);
    level.var_e05fb24af31882c8 playLoopSound("jup_vip_alarm_lp_int_tunnel");
  }
}

function function_b7b5f77fff8eba5e() {
  flag_wait("flag_player_triggered_grate_open_vo");
  level.player setsoundsubmix("sp_jup_vip_courtyard_open_grate", 0.2);
  flag_wait("flag_obj_infil_maintenance_complete");
  level.player clearsoundsubmix("sp_jup_vip_courtyard_open_grate", 0.2);
}

function function_7f2d4a3eb262b01d() {}

function function_33dd9108ce8fd72e() {
  level.player playSound("vip_pipe_exit_grate_latch");
  level.player clearsoundsubmix("sp_jup_vip_courtyard_combat", 0.05);
  wait 4;
  level.player setsoundsubmix("sp_jup_vip_descend_alarm_tunnel_grate_open");
}

function function_632bfcbdb195bc04() {
  nvg = snd_play("jup_vip_nightvision_on");
}

function function_e0416375588d2899() {
  level.player playSound("vip_pipe_exit_swing_out_descender");
}

function function_ae2505fbe8427706() {
  level.player playSound("jup_vip_lights_out_lower_decks");
}

function function_94d88335f8d56485() {
  level.player playSound("jup_vip_lights_out_top_deck_end");
}

function function_387c7e41e257f7e3() {
  thread function_bfc1c07b4680767e();
  level.player playSound("takeover_control_room_guns");
  thread function_77cafe00a7d7296b();
}

function function_bfc1c07b4680767e() {
  level.player setsoundsubmix("sp_jup_vip_descend_control_takeover", 1);
  wait 5.5;
  level.player clearsoundsubmix("sp_jup_vip_descend_control_takeover", 1);
}

function function_77cafe00a7d7296b() {
  last_action = "ascender_stop";
  action = level.player waittill_any_return_4("ascender_stop", "ascender_start_up", "ascender_start_down", "ascender_detached");

  while(isalive(level.player) && !flag("flag_descend_player_detached")) {
    if(action == "ascender_start_down") {
      var_84c2b7b6171e2beb = snd_play("jup_vip_descender_lp_ratchet_sm");
      function_e70d88e85d5fb19a(var_84c2b7b6171e2beb, 0);
      function_e70d88e85d5fb19a(var_84c2b7b6171e2beb, 1, 0.5);
    } else if(action == "ascender_start_up") {
      snd_play("jup_vip_descender_lp_servo_start");
      var_84c2b7b6171e2beb = snd_play("jup_vip_descender_lp_ratchet_lg");
      function_e70d88e85d5fb19a(var_84c2b7b6171e2beb, 0);
      function_e70d88e85d5fb19a(var_84c2b7b6171e2beb, 1, 0.5);
    }

    last_action = action;
    action = level.player waittill_any_return_4("ascender_stop", "ascender_start_up", "ascender_start_down", "ascender_detached");

    if(isDefined(var_84c2b7b6171e2beb)) {
      snd_stop(var_84c2b7b6171e2beb, 0.2);
    }

    if(last_action == "ascender_start_up") {
      snd_play("jup_vip_descender_lp_servo_stop");
    }
  }

  if(isDefined(var_84c2b7b6171e2beb)) {
    snd_stop(var_84c2b7b6171e2beb);
  }

  if(last_action == "ascender_start_up") {
    snd_play("jup_vip_descender_lp_servo_stop");
  }
}

function function_e89a46d1508b964b() {
  wait 1.16;
  playsoundatpos(level.ally1.origin, "jup_vip_descender_ally_front_unclip");
}

function function_3d4fa2577f2d7512() {
  playsoundatpos(level.ally2.origin, "jup_vip_descender_ally_behind_unclip");
}

function function_d89fe7f8e99f072e() {
  level.player setsoundsubmix("sp_jup_vip_descend_prisoner_riot_amb");
}

function function_b59010081eb9575() {
  level.player clearsoundsubmix("sp_jup_vip_descend_prisoner_riot_amb");
}

function function_b91f2272236bff05() {
  flag_wait("flag_cell_doors_level_1_open");
  door_model = getEnt("descend_level_1_door_3", "targetname");
  playsoundatpos(door_model.origin, "evt_sp_jup_vip_prison_cell_doors_open_multi");
}

function function_399046188ab6af22() {
  flag_wait("flag_cell_doors_multiple_open");
  door_model = getEnt("descend_level_2_door_3", "targetname");
  playsoundatpos(door_model.origin, "evt_sp_jup_vip_prison_cell_doors_open_multi");
}

function function_f3cbc1ef29772df2() {
  flag_wait("flag_reach_vip_door_2_open");
  var_2f883a5159fc96f6 = getStruct("vip_reach_vip_halldoor_02_dest", "targetname");
  var_ed09d701eef1f409 = getStruct("vip_reach_vip_halldoor_03_dest", "targetname");
  playsoundatpos(var_2f883a5159fc96f6.origin, "evt_sp_jup_vip_prison_cell_door_open_01");
  waitframe();
  playsoundatpos(var_ed09d701eef1f409.origin, "evt_sp_jup_vip_prison_cell_door_open_02");
}

function function_bb508ef505b312b2(bottom_left_riot_shield_guy_01, bottom_left_riot_shield_guy_02, bottom_left_riot_shield_guy_03, bottom_left_riot_shield_guy_04) {
  var_fa6bbffa9d580d68 = snd_play("jup_vip_descend_riot_guards_step_toward_prisoners", bottom_left_riot_shield_guy_01);
  wait 4.65;
  var_d6e8221d58ac5340 = snd_play("jup_vip_descend_riot_shield_lp_01", bottom_left_riot_shield_guy_01);
  var_3f307c332cffe3a7 = snd_play("jup_vip_descend_riot_shield_lp_02", bottom_left_riot_shield_guy_02);
  var_820c6650f38e6d26 = snd_play("jup_vip_descend_riot_shield_lp_03", bottom_left_riot_shield_guy_03);
  var_475f70641c9059e5 = snd_play("jup_vip_descend_riot_shield_lp_04", bottom_left_riot_shield_guy_04);
  snd_stop_on_ent_notify(var_d6e8221d58ac5340, bottom_left_riot_shield_guy_01, "aud_riot_guy_interuppted", 0.25);
  snd_stop_on_ent_notify(var_3f307c332cffe3a7, bottom_left_riot_shield_guy_02, "aud_riot_guy_interuppted", 0.25);
  snd_stop_on_ent_notify(var_820c6650f38e6d26, bottom_left_riot_shield_guy_03, "aud_riot_guy_interuppted", 0.25);
  snd_stop_on_ent_notify(var_475f70641c9059e5, bottom_left_riot_shield_guy_04, "aud_riot_guy_interuppted", 0.25);
}

function function_6bf4417f8523d77f(bottom_right_riot_shield_guy_01, bottom_right_riot_shield_guy_02, bottom_right_riot_shield_guy_03, bottom_right_riot_shield_guy_04, bottom_right_riot_shield_guy_06) {
  wait 4.65;
  var_7b1ff561c65f6bcb = snd_play("jup_vip_descend_riot_shield_lp_01", bottom_right_riot_shield_guy_01);
  var_33bafb43fad44e64 = snd_play("jup_vip_descend_riot_shield_lp_02", bottom_right_riot_shield_guy_02);
  var_cf6fb12e2ae43305 = snd_play("jup_vip_descend_riot_shield_lp_03", bottom_right_riot_shield_guy_03);
  var_e81a71b06b63c46 = snd_play("jup_vip_descend_riot_shield_lp_04", bottom_right_riot_shield_guy_04);
  var_c73fbcfd3b5189c7 = snd_play("jup_vip_descend_riot_shield_lp_05", bottom_right_riot_shield_guy_06);
  snd_stop_on_ent_notify(var_7b1ff561c65f6bcb, bottom_right_riot_shield_guy_01, "aud_riot_guy_interuppted", 0.25);
  snd_stop_on_ent_notify(var_33bafb43fad44e64, bottom_right_riot_shield_guy_02, "aud_riot_guy_interuppted", 0.25);
  snd_stop_on_ent_notify(var_cf6fb12e2ae43305, bottom_right_riot_shield_guy_03, "aud_riot_guy_interuppted", 0.25);
  snd_stop_on_ent_notify(var_e81a71b06b63c46, bottom_right_riot_shield_guy_04, "aud_riot_guy_interuppted", 0.25);
  snd_stop_on_ent_notify(var_c73fbcfd3b5189c7, bottom_right_riot_shield_guy_06, "aud_riot_guy_interuppted", 0.25);
}

function mattress_drop() {
  var_2c1ab358f1117d5d = (-8974.62, -14675.2, -242.25);
  wait 0.67;
  playsoundatpos(var_2c1ab358f1117d5d, "jup_vip_descend_mattress_drop");
}

function function_35be43e20f294568() {
  var_5b7b521d5ffde9e2 = (-8565.62, -14191.8, 816.97);
  level.var_9dfdc0d45b5de167 = spawn("script_model", var_5b7b521d5ffde9e2);
  level.var_9dfdc0d45b5de167 playLoopSound("jup_vip_descend_guard_held_against_cell_lp");
  flag_wait("level_1_enemy_damaged");
  level.var_9dfdc0d45b5de167 stoploopsound("jup_vip_descend_guard_held_against_cell_lp");
}

function metal_door_slam_open() {
  var_f96a03ba56bc01c = (-8657.79, -14401.8, 301.1);
  playsoundatpos(var_f96a03ba56bc01c, "jup_vip_descend_metal_door_slam_open");
}

function function_1a6b7aca21336595() {}

function function_7bc3d7f287b24070() {
  flag_set("flag_makarov_reveal_igc_start_submix");
  level.player setsoundsubmix("sp_jup_vip_makarov_reveal", 3);
}

function function_6502e648d37cf222() {
  level.player setsoundsubmix("sp_jup_vip_makarov_reveal_2", 0.3);
  spawned_drips = snd_play([0, "makrov_reveal_water_drips", 1.5]);
  thread function_1d7be3913d039311();
  wait 35;
  flag_set("makarov_reveal_pcap_end");
  snd_stop(spawned_drips, 5);
}

function function_1d7be3913d039311() {
  level endon("makarov_reveal_pcap_end");
  wait 5;

  while(!flag("makarov_reveal_pcap_end")) {
    spawned_debris = snd_play("debris_makarov_reveal");
    wait_time = randomintrange(5, 8);
    wait wait_time;
  }
}

function function_638ed32cb658b936() {
  level.player clearsoundsubmix("sp_jup_vip_makarov_reveal", 1.5);
  level.player clearsoundsubmix("sp_jup_vip_makarov_reveal_2", 1.5);
}

function function_b6b7b6bbc985eb26() {
  var_f91cbfc4ebfce4dd = snd_play("jup_vip_pre_hallway_guards", (-9621, -15468, 241));
}

function function_4441d36febd657ca() {
  level.player setsoundsubmix("sp_jup_vip_hallway_mute_npc_shots");
}

function function_478c8399563b08ec() {
  setglobalsoundcontext("jup_vip_smoke_grn", "smoke_grenade_override");
}

function function_9531e438a3fc1f06() {
  setglobalsoundcontext("jup_vip_smoke_grn", "");
}

function function_5761cd4381c219c1() {
  level.player clearsoundsubmix("sp_jup_vip_hallway_mute_npc_shots");
}

function function_18c3a854972ebfc1(var_1f2ffb92adf905f3) {
  guard1 = random(var_1f2ffb92adf905f3);
  guard2 = random(var_1f2ffb92adf905f3);
  wait 1.5;
  snd_play("dx_bc_rusc_aqsp_ru06_suppressingfire", (-8976, -15774, -218));
  wait 1.5;
  snd_play("dx_bc_rusc_aqsp_ru02_imcoveringyou", (-9118, -15756, -218));
}

function function_45dfc579868ae9aa() {}

function function_6e6ec37968927aa8() {
  level.player setsoundsubmix("sp_jup_vip_elevator_scene", 0.2);
}

function elevator_restart() {
  makarov = getEnt("Makarov", "targetname");
  level waittill("elevator_restart");
  elevator_restart = snd_play("jup_vip_elevator_movement_restart");
  level waittill("elevator_end");
  snd_play("jup_vip_elevator_makarov_foley_05", makarov);
  snd_play("jup_vip_elevator_movement_end");
  snd_stop(elevator_restart, 0.5);
}

function function_61a814032658221b() {
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_01", 10005);
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_02", 13572);
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_03", 17960);
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_04", 24389);
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_05", 30210);
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_06", 35753);
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_07", 41665);
  flag_wait("flag_aud_makarov_answered");
  thread function_c2e5ebbb02a71b15("vip_elevator_small_arms_part1", 0);
  flag_wait("flag_aud_elevator_fake_battle_amb_pt2");
  thread function_c2e5ebbb02a71b15("vip_elevator_bombshake_08", 0);
}

function function_1ac4ea5acb931a6c(rpg, var_481cd098638ae908, var_9c907e07a6045299) {
  var_e2fdb288bc0800c0 = (-5857, -12092, 1189);
  playsoundatpos(var_481cd098638ae908.origin, "incoming_flyby_close");
  snd_play("incoming_flyby_close_by", rpg);
  wait 0.9;
  playsoundatpos(var_9c907e07a6045299.origin, "explo_trans_finale_01");
  playsoundatpos(var_9c907e07a6045299.origin, "explo_debris_rock_01");
  wait 0.25;
  playsoundatpos(var_e2fdb288bc0800c0, "explo_react_npc");
  wait 0.3;
  level.player playSound("explo_react_plr");
}

function function_1ac4ed5acb932105(rpg, var_481cd098638ae908, var_9c907e07a6045299) {
  playsoundatpos(var_481cd098638ae908.origin, "incoming_flyby_close");
  snd_play("incoming_flyby_close_by", rpg);
  wait 0.9;
  playsoundatpos(var_9c907e07a6045299.origin, "explo_trans_finale_02");
}

function function_79c32affccf83e0() {
  var_1096ef70636dbbaa = level.player.origin;
  var_e2fdb288bc0800c0 = (-5616, -11447, 1259);
  playsoundatpos(var_1096ef70636dbbaa, "explo_debris_tree_02");
  wait 0.25;
  playsoundatpos(var_e2fdb288bc0800c0, "explo_react_npc");
  wait 0.5;
  level.player playSound("explo_react_plr");
}

function function_1ac4ec5acb931ed2(rpg, var_481cd098638ae908, var_9c907e07a6045299) {
  playsoundatpos(var_481cd098638ae908.origin, "incoming_flyby_close");
  snd_play("incoming_flyby_close_by", rpg);
  wait 1;
  playsoundatpos(var_9c907e07a6045299.origin, "explo_trans_finale_03");
  playsoundatpos(var_9c907e07a6045299.origin, "explo_debris_rock_03");
}

function function_5e54514410e59da9() {
  flag_wait("flag_infil_vo_ally2_stair_descent_begin");
  var_a0cf377dacff9c46 = ["jup_vip_infil_courtyard_ext_convo_guy4_10", "jup_vip_infil_courtyard_ext_convo_guy4_11", "jup_vip_infil_courtyard_ext_convo_guy4_12", "jup_vip_infil_courtyard_ext_convo_guy4_13", "jup_vip_infil_courtyard_ext_convo_guy4_14", "jup_vip_infil_courtyard_ext_convo_guy4_15", "jup_vip_infil_courtyard_ext_convo_guy4_16"];
  var_c29edc318cdcdc35 = ["jup_vip_infil_courtyard_ext_convo_guy3_07", "jup_vip_infil_courtyard_ext_convo_guy3_08", "jup_vip_infil_courtyard_ext_convo_guy3_09", "jup_vip_infil_courtyard_ext_convo_guy3_10", "jup_vip_infil_courtyard_ext_convo_guy2_09", "jup_vip_infil_courtyard_ext_convo_guy2_10", "jup_vip_infil_courtyard_ext_convo_guy2_11", "jup_vip_infil_courtyard_ext_convo_guy2_08"];
  var_df556a1113580d9c = ["jup_vip_infil_courtyard_ext_convo_guy1_01", "jup_vip_infil_courtyard_ext_convo_guy1_02", "jup_vip_infil_courtyard_ext_convo_guy1_03", "jup_vip_infil_courtyard_ext_convo_guy1_04", "jup_vip_infil_courtyard_ext_convo_guy1_05", "jup_vip_infil_courtyard_ext_convo_guy1_06", "jup_vip_infil_courtyard_ext_convo_guy1_07", "jup_vip_infil_courtyard_ext_convo_guy1_08", "jup_vip_infil_courtyard_ext_convo_guy1_09", "jup_vip_infil_courtyard_ext_convo_guy1_05"];
  var_fb58c76c64ec46fb = ["jup_vip_infil_courtyard_ext_convo_guy2_01", "jup_vip_infil_courtyard_ext_convo_guy2_02", "jup_vip_infil_courtyard_ext_convo_guy2_03", "jup_vip_infil_courtyard_ext_convo_guy2_04", "jup_vip_infil_courtyard_ext_convo_guy2_05", "jup_vip_infil_courtyard_ext_convo_guy2_06", "jup_vip_infil_courtyard_ext_convo_guy2_07", "jup_vip_infil_courtyard_ext_convo_guy2_12"];
  var_3339c96377b69a43 = (-8290, -15500, 1725);
  thread function_6541be2ec1b70f3e(var_3339c96377b69a43, var_a0cf377dacff9c46, var_c29edc318cdcdc35, [0, 1.5], [0, 1.5], [0, 4]);
  thread function_959a2f9900e40dd2(var_3339c96377b69a43, var_df556a1113580d9c, var_fb58c76c64ec46fb, [0, 0.1], [0, 0.1], [4, 5]);
}

function function_6541be2ec1b70f3e(var_13cd8f37c03fca8a, var_848683c647b1168e, var_848682c647b1145b, var_e3f6933643e68137, var_fa12cbe4bd9e81e8, var_13507baea85cfbbe) {
  level endon("flag_infil_to_maintenance_switch");
  var_6d8e7d60710a90c1 = 1;

  for(var_376eabd83af7f73e = 1; !flag("flag_infil_to_maintenance_switch"); var_376eabd83af7f73e = 1) {
    if(istrue(var_6d8e7d60710a90c1) && istrue(var_376eabd83af7f73e)) {
      var_6d8e7d60710a90c1 = 0;
      var_376eabd83af7f73e = 0;
      var_2a410b8d5d117be2 = var_848683c647b1168e.size;
      var_96dc818ad61a7125 = var_848682c647b1145b.size;

      if(var_2a410b8d5d117be2 >= var_96dc818ad61a7125) {
        var_d37282837c4b3673 = var_848683c647b1168e;
        var_d37283837c4b38a6 = var_848682c647b1145b;
      } else {
        var_d37282837c4b3673 = var_848682c647b1145b;
        var_d37283837c4b38a6 = var_848683c647b1168e;
      }

      for(i = 0; i < var_d37282837c4b3673.size; i++) {
        var_3c53984d5e5a889e = snd_play(var_d37282837c4b3673[i], var_13cd8f37c03fca8a);
        snd_wait(var_3c53984d5e5a889e);
        wait randomfloatrange(var_e3f6933643e68137[0], var_e3f6933643e68137[1]);

        if(i < var_d37283837c4b38a6.size) {
          var_41c6fc2bb00655c7 = snd_play(var_d37283837c4b38a6[i], var_13cd8f37c03fca8a);
          snd_wait(var_41c6fc2bb00655c7);
          wait randomfloatrange(var_fa12cbe4bd9e81e8[0], var_fa12cbe4bd9e81e8[1]);
        }
      }
    }

    wait randomfloatrange(var_13507baea85cfbbe[0], var_13507baea85cfbbe[1]);
    var_6d8e7d60710a90c1 = 1;
  }
}

function function_959a2f9900e40dd2(var_13cd8f37c03fca8a, var_848683c647b1168e, var_848682c647b1145b, var_e3f6933643e68137, var_fa12cbe4bd9e81e8, var_13507baea85cfbbe) {
  level endon("flag_infil_to_maintenance_switch");
  var_6d8e7d60710a90c1 = 1;

  for(var_376eabd83af7f73e = 1; !flag("flag_infil_to_maintenance_switch"); var_376eabd83af7f73e = 1) {
    if(istrue(var_6d8e7d60710a90c1) && istrue(var_376eabd83af7f73e)) {
      var_6d8e7d60710a90c1 = 0;
      var_376eabd83af7f73e = 0;
      var_2a410b8d5d117be2 = var_848683c647b1168e.size;
      var_96dc818ad61a7125 = var_848682c647b1145b.size;

      if(var_2a410b8d5d117be2 >= var_96dc818ad61a7125) {
        var_d37282837c4b3673 = var_848683c647b1168e;
        var_d37283837c4b38a6 = var_848682c647b1145b;
      } else {
        var_d37282837c4b3673 = var_848682c647b1145b;
        var_d37283837c4b38a6 = var_848683c647b1168e;
      }

      for(i = 0; i < var_d37282837c4b3673.size / 2; i++) {
        var_3c53984d5e5a889e = snd_play(var_d37282837c4b3673[i], var_13cd8f37c03fca8a);
        snd_wait(var_3c53984d5e5a889e);
        wait randomfloatrange(var_e3f6933643e68137[0], var_e3f6933643e68137[1]);

        if(i < int(var_d37283837c4b38a6.size / 2)) {
          var_41c6fc2bb00655c7 = snd_play(var_d37283837c4b38a6[i], var_13cd8f37c03fca8a);
          snd_wait(var_41c6fc2bb00655c7);
          wait randomfloatrange(var_fa12cbe4bd9e81e8[0], var_fa12cbe4bd9e81e8[1]);
        }
      }

      wait randomfloatrange(var_13507baea85cfbbe[0], var_13507baea85cfbbe[1]);

      for(i = int(var_d37282837c4b3673.size / 2); i < var_d37282837c4b3673.size; i++) {
        var_3c53984d5e5a889e = snd_play(var_d37282837c4b3673[i], var_13cd8f37c03fca8a);
        snd_wait(var_3c53984d5e5a889e);
        wait randomfloatrange(var_e3f6933643e68137[0], var_e3f6933643e68137[1]);

        if(i < var_d37283837c4b38a6.size) {
          var_41c6fc2bb00655c7 = snd_play(var_d37283837c4b38a6[i], var_13cd8f37c03fca8a);
          snd_wait(var_41c6fc2bb00655c7);
          wait randomfloatrange(var_fa12cbe4bd9e81e8[0], var_fa12cbe4bd9e81e8[1]);
        }
      }
    }

    wait randomfloatrange(var_13507baea85cfbbe[0], var_13507baea85cfbbe[1]);
    var_6d8e7d60710a90c1 = 1;
  }
}

function function_5e9931f4eb825570() {
  flag_wait("flag_infil_to_maintenance_switch");
  var_6d15ab15089b2d1f = ["jup_vip_courtyard_int_convo_guy3_01", "jup_vip_courtyard_int_convo_guy3_02", "jup_vip_courtyard_int_convo_guy3_03", "jup_vip_courtyard_int_convo_guy3_04"];
  var_cb5f7480c627f9b3 = ["jup_vip_courtyard_int_convo_guy2_01", "jup_vip_courtyard_int_convo_guy2_02", "jup_vip_courtyard_int_convo_guy2_03", "jup_vip_courtyard_int_convo_guy2_04", "jup_vip_courtyard_int_convo_guy2_05"];
  var_851fafbe6e01a60f = ["jup_vip_courtyard_ext_convo_guy1_01", "jup_vip_courtyard_ext_convo_guy1_02", "jup_vip_courtyard_ext_convo_guy1_03", "jup_vip_courtyard_ext_convo_guy1_04", "jup_vip_courtyard_ext_convo_guy1_05", "jup_vip_courtyard_ext_convo_guy1_06", "jup_vip_courtyard_ext_convo_guy1_07", "jup_vip_courtyard_ext_convo_guy1_08", "jup_vip_courtyard_ext_convo_guy1_09", "jup_vip_courtyard_ext_convo_guy1_10", "jup_vip_courtyard_ext_convo_guy1_11", "jup_vip_courtyard_ext_convo_guy1_12", "jup_vip_courtyard_ext_convo_guy1_13"];
  var_6fbaf2b580aa302c = ["jup_vip_courtyard_ext_convo_guy2_01", "jup_vip_courtyard_ext_convo_guy2_02", "jup_vip_courtyard_ext_convo_guy2_03", "jup_vip_courtyard_ext_convo_guy2_04", "jup_vip_courtyard_ext_convo_guy2_05", "jup_vip_courtyard_ext_convo_guy2_06", "jup_vip_courtyard_ext_convo_guy2_07", "jup_vip_courtyard_ext_convo_guy2_08", "jup_vip_courtyard_ext_convo_guy2_09", "jup_vip_courtyard_ext_convo_guy2_10", "jup_vip_courtyard_ext_convo_guy2_11", "jup_vip_courtyard_ext_convo_guy2_12"];
  var_fd550cbd0ceee45 = ["jup_vip_courtyard_ext_convo_guy3_01", "jup_vip_courtyard_ext_convo_guy3_02", "jup_vip_courtyard_ext_convo_guy3_03", "jup_vip_courtyard_ext_convo_guy3_04", "jup_vip_courtyard_ext_convo_guy3_05", "jup_vip_courtyard_ext_convo_guy3_06", "jup_vip_courtyard_ext_convo_guy3_07", "jup_vip_courtyard_ext_convo_guy3_08", "jup_vip_courtyard_ext_convo_guy3_09", "jup_vip_courtyard_ext_convo_guy3_10"];
  var_491793f19294061f = ["jup_vip_courtyard_ext_convo_guy4_01", "jup_vip_courtyard_ext_convo_guy4_02", "jup_vip_courtyard_ext_convo_guy4_03", "jup_vip_courtyard_ext_convo_guy4_04", "jup_vip_courtyard_ext_convo_guy4_05", "jup_vip_courtyard_ext_convo_guy4_06", "jup_vip_courtyard_ext_convo_guy4_07", "jup_vip_courtyard_ext_convo_guy4_08", "jup_vip_courtyard_ext_convo_guy4_09"];
  var_a77fdf68884fb3f7 = (-7178, -15892, 1238);
  var_241c62df1bea4cf6 = (-8390, -15648, 1272);
  var_7d1331c106e9bf9e = (-8175, -15060, 1313);
  reinforcement_loc = (-7680, -14760, 1280);
  thread function_f952e15f0689e383(var_7d1331c106e9bf9e, var_851fafbe6e01a60f, var_6fbaf2b580aa302c);
  thread function_f952e15f0689e383(var_241c62df1bea4cf6, var_fd550cbd0ceee45, var_491793f19294061f);
  wait 2;
  thread function_f952e15f0689e383(var_a77fdf68884fb3f7, var_6d15ab15089b2d1f, var_cb5f7480c627f9b3);
  flag_wait("flag_spawn_reinforcements_phase_2");
  snd_play([0, "jup_vip_walla_courtyard_ext_reinforcements_01", 0], reinforcement_loc);
  snd_play([2, "jup_vip_walla_courtyard_ext_reinforcements_02", 0], reinforcement_loc);
  snd_play([4, "jup_vip_walla_courtyard_ext_reinforcements_03", 0], reinforcement_loc);
}

function function_f952e15f0689e383(var_13cd8f37c03fca8a, var_848683c647b1168e, var_848682c647b1145b) {
  level endon("flag_begin_explosions");
  level endon("flag_player_engaged");
  level endon("flag_charlie_explosion");
  var_6d8e7d60710a90c1 = 1;

  for(var_376eabd83af7f73e = 1; !flag("flag_charlie_explosion") || !flag("flag_player_engaged") || !!flag("flag_begin_explosions"); var_376eabd83af7f73e = 1) {
    if(istrue(var_6d8e7d60710a90c1) && istrue(var_376eabd83af7f73e)) {
      var_6d8e7d60710a90c1 = 0;
      var_376eabd83af7f73e = 0;
      var_2a410b8d5d117be2 = var_848683c647b1168e.size;
      var_96dc818ad61a7125 = var_848682c647b1145b.size;

      if(var_2a410b8d5d117be2 >= var_96dc818ad61a7125) {
        var_d37282837c4b3673 = var_848683c647b1168e;
        var_d37283837c4b38a6 = var_848682c647b1145b;
      } else {
        var_d37282837c4b3673 = var_848682c647b1145b;
        var_d37283837c4b38a6 = var_848683c647b1168e;
      }

      for(i = 0; i < var_d37282837c4b3673.size; i++) {
        var_3c53984d5e5a889e = snd_play(var_d37282837c4b3673[i], var_13cd8f37c03fca8a);
        snd_wait(var_3c53984d5e5a889e);
        wait randomfloat(1.5);

        if(i < var_d37283837c4b38a6.size) {
          var_41c6fc2bb00655c7 = snd_play(var_d37283837c4b38a6[i], var_13cd8f37c03fca8a);
          snd_wait(var_41c6fc2bb00655c7);
          wait randomfloat(1.5);
        }
      }
    }

    wait randomfloat(4);
    var_6d8e7d60710a90c1 = 1;
  }
}

function function_6622f7ba9c50f57a() {
  var_f62cb4db1a3422a5 = (-8311, -15683, 1320);
  var_f62cb1db1a341c0c = (-8000, -15455, 1320);
  var_f62cb2db1a341e3f = (-8013, -15083, 1320);
  var_ac893d1c6938cae6 = flag_wait_any_return("flag_charlie_explosion", "flag_player_engaged", "flag_begin_explosions");
  wait 0.25;
  snd_play("jup_vip_walla_courtyard_ext_guards_panic_04", var_f62cb4db1a3422a5);
  snd_play("jup_vip_walla_courtyard_ext_guards_panic_03", var_f62cb1db1a341c0c);
  snd_play("jup_vip_walla_courtyard_ext_guards_panic_01", var_f62cb2db1a341e3f);

  for(i = 0; i < 2; i++) {
    wait randomfloat(1.25);
    snd_play("jup_vip_walla_courtyard_ext_guards_panic_01", var_f62cb1db1a341c0c);
    snd_play("jup_vip_walla_courtyard_ext_guards_panic_02", var_f62cb4db1a3422a5);
    wait randomfloat(1.25);
    snd_play("jup_vip_walla_courtyard_ext_guards_panic_04", var_f62cb1db1a341c0c);
    snd_play("jup_vip_walla_courtyard_ext_guards_panic_05", var_f62cb2db1a341e3f);
    wait randomfloat(1.55);
  }
}

function function_35621b694094d7de() {
  var_3679e7a1928093b0 = (-8887, -14191, 1018);
  var_aa49746372206bb4 = snd_play("jup_vip_descend_walla_hatch_approach_lp", var_3679e7a1928093b0);
  flag_wait("flag_descend_start_anim");
  wait 4;
  snd_stop(var_aa49746372206bb4, 1);
}

function function_fc02814045757b93() {
  if(!isDefined(level.var_aa49746372206bb4)) {
    var_3679e7a1928093b0 = (-8887, -14191, 1018);
    var_aa49746372206bb4 = snd_play("jup_vip_descend_walla_hatch_approach_lp", var_3679e7a1928093b0);
  }

  flag_wait("flag_descend_start_anim");
  wait 4;
  snd_stop(var_aa49746372206bb4, 1);
}

function function_e727938bd32b97b2(arrayname, var_67b12b6b3a0483cf, var_678e196b39de1481, range, zrange, var_7949632c14febddb, position) {
  var_7844a9ea7c6ec461 = range * -1;

  while(!flag(var_7949632c14febddb)) {
    if(isent(position)) {
      if(isDefined(position)) {
        entpos = 1;
      } else {
        return;
      }
    }

    if(isDefined(position)) {
      var_edaa83fd54ba8115 = position;
    } else {
      var_edaa83fd54ba8115 = level.player.origin;
    }

    var_90a08b9456a54f84 = randomfloatrange(var_67b12b6b3a0483cf, var_678e196b39de1481);
    thread function_853401bf140b6d6d(var_edaa83fd54ba8115, arrayname, var_7844a9ea7c6ec461, range, var_7844a9ea7c6ec461, range, zrange, entpos);
    wait var_90a08b9456a54f84;
  }
}

function function_853401bf140b6d6d(origin_loc, alias_name, x_min, x_max, y_min, y_max, variation_z, entpos) {
  if(!istrue(entpos)) {
    variation_x = randomfloatrange(x_min, x_max);
    variation_y = randomfloatrange(y_min, y_max);

    if(variation_x < 0) {
      variation_x -= 1;
    } else {
      variation_x += 1;
    }

    if(variation_y < 0) {
      variation_y -= 1;
    } else {
      variation_y += 1;
    }

    var_7ba6384785142a5 = origin_loc + (variation_x, variation_y, variation_z);
  } else {
    var_7ba6384785142a5 = origin_loc;
  }

  if(isarray(alias_name)) {
    var_90f467fe89cff24e = random(alias_name);
    var_991f7cbb312d8b10 = snd_play(var_90f467fe89cff24e, var_7ba6384785142a5);
    return;
  }

  var_991f7cbb312d8b10 = snd_play(alias_name, var_7ba6384785142a5);
}

function function_96b064d2df0f3369(arrayname, var_67b12b6b3a0483cf, var_678e196b39de1481, range, zrange, var_f499342972f69e56, var_dbba2a8e82b00e31, position, var_67b4770c76f39206) {
  thread function_d9fa3318ced66d52(var_f499342972f69e56, var_dbba2a8e82b00e31, position);
  var_7844a9ea7c6ec461 = range * -1;

  while(!flag(var_dbba2a8e82b00e31) || !flag(var_67b4770c76f39206)) {
    if(isent(position)) {
      if(isDefined(position) && isalive(position)) {
        entpos = 1;
        thread function_853401bf140b6d6d(position, arrayname, var_7844a9ea7c6ec461, range, var_7844a9ea7c6ec461, range, zrange, entpos);
      } else {
        return;
      }
    }

    var_90a08b9456a54f84 = randomfloatrange(var_67b12b6b3a0483cf, var_678e196b39de1481);
    wait var_90a08b9456a54f84;
  }

  flag_clear(var_dbba2a8e82b00e31);
}

function function_d9fa3318ced66d52(var_f499342972f69e56, var_dbba2a8e82b00e31, var_3989ef30c429e90e) {
  if(!flag_exist(var_dbba2a8e82b00e31)) {
    flag_init(var_dbba2a8e82b00e31);
  }

  var_3989ef30c429e90e waittill(var_f499342972f69e56);
  flag_set(var_dbba2a8e82b00e31);
}

function function_694ab3344595497a(pos) {
  var_3139db3a39bdda1a = ["jup_vip_descend_walla_guy1_idle_runner", "jup_vip_descend_walla_guy2_idle_runner", "jup_vip_descend_walla_guy3_idle_runner", "jup_vip_descend_walla_guy4_idle_runner", "jup_vip_descend_walla_guy5_idle_runner", "jup_vip_descend_walla_guy6_idle_runner"];
  var_b8314245e522d822 = random(var_3139db3a39bdda1a);
  snd_play(var_b8314245e522d822, pos);
}

function function_f553715d7011255d(pos) {
  var_965aaa31be1768d1 = ["jup_vip_descend_walla_guy1_yell", "jup_vip_descend_walla_guy4_yell", "jup_vip_descend_walla_guy6_yell", "jup_vip_descend_walla_guy2_yell"];
  var_b8314245e522d822 = random(var_965aaa31be1768d1);
  snd_play(var_b8314245e522d822, pos);
}

function function_a7e5725d5345fa2d() {}

function function_f7d9f3bce91871a1() {}

function function_667fc48a5675425a() {
  var_9daf566f28d76f27 = (-8700, -14060, 835);
  var_9945e99fe3157de9 = (-8578, -14202, 540);
  var_43b8708cb49f2c2c = (-8632, -14050, 835);
  var_a595ea41478b3d6a = (-8632, -14050, 550);
  var_975f1f54a35e434 = (-8603, -14223, 835);
  var_1b954bf976165d52 = (-8603, -14223, 550);
  var_81222797083904f3 = (-8900, -14150, 1000);
  var_89d0c4cfc80ec2b9 = (-8685, -14212, 835);
  var_7aa55e9086a2bc43 = (-8685, -14212, 550);
  var_b606a85da73b178 = (-8800, -14500, 300);
  var_4d8b938067384f24 = (-8760, -14775, -250);
  var_b02ae8bb5de497f5 = (-9032, -14931, -250);
  var_e72657bcfcfdac42 = (-9363, -14975, -250);
  var_83dd199af86a84bf = (-8500, -14250, -250);
  var_700379ed65085f62 = (-9930, -14685, -250);
  var_e0cf73d8f5b02abf = ["jup_vip_descend_walla_guy1_idle", "jup_vip_descend_walla_guy2_idle", "jup_vip_descend_walla_guy3_idle", "jup_vip_descend_walla_guy4_idle", "jup_vip_descend_walla_guy5_idle", "jup_vip_descend_walla_guy6_idle"];
  var_6bddaa729042587f = ["jup_vip_descend_walla_guy1_idle_1f", "jup_vip_descend_walla_guy2_idle_1f", "jup_vip_descend_walla_guy3_idle_1f", "jup_vip_descend_walla_guy4_idle_1f", "jup_vip_descend_walla_guy5_idle_1f", "jup_vip_descend_walla_guy6_idle_1f"];
  var_6be2c8729048c350 = ["jup_vip_descend_walla_guy1_idle_2f", "jup_vip_descend_walla_guy2_idle_2f", "jup_vip_descend_walla_guy3_idle_2f", "jup_vip_descend_walla_guy4_idle_2f", "jup_vip_descend_walla_guy5_idle_2f", "jup_vip_descend_walla_guy6_idle_2f"];
  var_2bee268f7be0029a = ["jup_vip_descend_walla_guy1_yell", "jup_vip_descend_walla_guy4_yell", "jup_vip_descend_walla_guy6_yell", "jup_vip_descend_walla_guy2_yell"];
  var_c7b908a75aa60a94 = ["jup_vip_descend_walla_guy1_yell_rails", "jup_vip_descend_walla_guy4_yell_rails", "jup_vip_descend_walla_guy6_yell_rails", "jup_vip_descend_walla_guy2_yell_rails"];
  var_ccb0ccfbbad91ff1 = ["jup_vip_descend_walla_guy1_idle_rails", "jup_vip_descend_walla_guy2_idle_rails", "jup_vip_descend_walla_guy3_idle_rails", "jup_vip_descend_walla_guy4_idle_rails", "jup_vip_descend_walla_guy5_idle_rails", "jup_vip_descend_walla_guy6_idle_rails"];
  var_21fd8c6eef4415dc = ["jup_vip_descend_walla_guy5_idle_verb", "jup_vip_descend_walla_guy6_idle_verb", "jup_vip_descend_walla_guard2_verb", "jup_vip_descend_walla_guard3_verb", "jup_vip_walla_descend_trios_cheer_verb", "jup_vip_walla_descend_trios_chant_verb"];
  var_4c7d6d15f0ca577a = ["jup_vip_descend_walla_guy5_idle_verb_1f", "jup_vip_descend_walla_guy6_idle_verb_1f", "jup_vip_descend_walla_guard2_verb_1f", "jup_vip_descend_walla_guard3_verb_1f"];
  var_6a5239db18cd8baa = ["jup_vip_descend_walla_mult_chant_verb_atmo", "jup_vip_descend_walla_mult_cheer_verb_atmo"];
  var_9c1de631d616154 = ["jup_vip_descend_walla_mult_chant_room_rails", "jup_vip_descend_walla_mult_cheer_room_rails"];
  var_7de30b0b9e8928ef = ["jup_vip_descend_walla_mult_chant_room", "jup_vip_descend_walla_mult_cheer_room"];
  utility::flag_wait("flag_descend_start_anim");
  level.player setsoundsubmix("sp_jup_vip_descend_walla_grate_open", 1);
  wait 4.2;
  var_b79a41c47a0baa2a = snd_play("jup_vip_descend_walla_hatch_open");
  var_4c518896a1c2f6b2 = snd_play("jup_vip_descend_walla_hatch_open_base");
  var_b6ca9eb22aeabdae = snd_play("jup_vip_descend_walla_hatch_open_verb");
  thread function_a7b47b4c5be33072(var_4c7d6d15f0ca577a, "level_1_enemy_damaged", "rear_left", 2, 5);
  thread function_a7b47b4c5be33072(var_4c7d6d15f0ca577a, "level_1_enemy_damaged", "rear_right", 2, 5);
  var_2584bda1e60f8c9 = snd_play("jup_vip_descend_walla_base_lp");
  var_517722880d83c61f = snd_play([2, "jup_vip_descend_walla_confused_lp", 3]);
  utility::flag_wait("flag_descend_goggles_back_on");
  level.player clearsoundsubmix("sp_jup_vip_descend_walla_grate_open", 1);
  wait 3.5;
  var_13dc7e19c9d28850 = snd_play([0, "jup_vip_descend_walla_base_rear_lp", 1]);
  var_4ab245af16085bfe = snd_play([0, "jup_vip_descend_walla_confused_lp_rear", 1]);
  utility::flag_wait("flag_start_descend");
  level.player setsoundsubmix("sp_jup_vip_descend_walla_floor_one", 3);
  thread function_e727938bd32b97b2("jup_vip_descend_walla_guard_radio_1f", 3, 9, 1, 1, "level_1_enemy_damaged", var_975f1f54a35e434);
  thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_chant_verb_1f", 6, 11, 1, 1, "level_1_enemy_damaged", var_975f1f54a35e434);
  thread function_e727938bd32b97b2(var_6bddaa729042587f, 2, 5, 1, 1, "level_1_enemy_damaged", var_975f1f54a35e434);
  thread function_e727938bd32b97b2(var_6bddaa729042587f, 4, 7, 1, 1, "level_1_enemy_damaged", var_43b8708cb49f2c2c);
  utility::flag_wait("level_1_enemy_damaged");
  thread function_a7b47b4c5be33072(var_21fd8c6eef4415dc, "flag_open_door_2", "rear_left", 9, 13);
  thread function_a7b47b4c5be33072(var_21fd8c6eef4415dc, "flag_open_door_2", "rear_right", 8, 14);
  thread function_a7b47b4c5be33072(var_c7b908a75aa60a94, "flag_open_door_2", "rear_left", 6, 11);
  thread function_a7b47b4c5be33072(var_c7b908a75aa60a94, "flag_open_door_2", "right", 7, 12);
  thread function_a7b47b4c5be33072(var_ccb0ccfbbad91ff1, "flag_open_door_2", "left", 10, 15);
  thread function_a7b47b4c5be33072(var_ccb0ccfbbad91ff1, "flag_open_door_2", "rear_right", 11, 18);
  thread function_a7b47b4c5be33072(var_9c1de631d616154, "flag_open_door_2", "rear_left", 12, 22);
  thread function_a7b47b4c5be33072(var_9c1de631d616154, "flag_open_door_2", "rear_right", 11, 20);
  level.player clearsoundsubmix("sp_jup_vip_descend_walla_floor_one", 3);
  wait 1.6;
  thread function_a164518cdca8cb9c(1, 3, 7);
  var_aebc702863e5d762 = snd_play("jup_vip_descend_walla_release_cheer_short", var_89d0c4cfc80ec2b9);
  var_459e96d68f3ae4c9 = snd_play("jup_vip_descend_walla_release_cheer_post");
  var_23895410f701ba8 = snd_play("jup_vip_descend_walla_release_cheer_post_rear");
  snd_stop(var_517722880d83c61f, 2);
  snd_stop(var_4ab245af16085bfe, 2);
  var_daa71a430472fbdc = snd_play([0, "jup_vip_descend_walla_more_lp", 2]);
  var_61e254fccea981a7 = snd_play([0, "jup_vip_descend_walla_more_rear_lp", 2]);
  thread function_e727938bd32b97b2(var_2bee268f7be0029a, 1, 2, 1, 1, "flag_killed_all_level_1_enemies", var_89d0c4cfc80ec2b9);
  utility::flag_wait("flag_stop_3");
  thread function_e727938bd32b97b2("jup_vip_descend_walla_guard_radio", 3, 6, 1, 1, "flag_open_level_2_doors", var_1b954bf976165d52);
  thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_chant_verb", 6, 8, 1, 1, "flag_open_level_2_doors", var_1b954bf976165d52);
  thread function_e727938bd32b97b2(var_6be2c8729048c350, 2, 5, 1, 1, "flag_open_level_2_doors", var_1b954bf976165d52);
  thread function_e727938bd32b97b2(var_6be2c8729048c350, 4, 7, 1, 1, "flag_open_level_2_doors", var_a595ea41478b3d6a);
  utility::flag_wait("flag_level_2_player_spotted_vo");
  waitframe();
  utility::flag_wait_any("flag_open_level_2_doors", "vip_fov_reachvip_start");
  wait 2.5;
  thread function_a164518cdca8cb9c(2, 2, 8);
  snd_play([0, "jup_vip_descend_walla_guy2_exerts_yell", 0], var_7aa55e9086a2bc43);
  snd_play([0.8, "jup_vip_descend_walla_guy3_exerts_yell", 0], var_7aa55e9086a2bc43);
  var_8daad7f7d3eec75a = snd_play([0.25, "jup_vip_descend_walla_release_cheer_post_2f", 1]);
  var_3d537ac0444fb245 = snd_play([0.25, "jup_vip_descend_walla_release_cheer_post_rear_2f", 1]);
  snd_stop(var_2584bda1e60f8c9, 2);
  snd_stop(var_13dc7e19c9d28850, 2);
  snd_stop(var_daa71a430472fbdc, 2);
  snd_stop(var_61e254fccea981a7, 2);
  thread function_e0a23069a39c5b5f();
  level.var_ecda36875e66690c = 1;
  utility::flag_wait("flag_force_flashlight_ambush");
  snd_play([1, "jup_vip_descend_walla_guard1_scripted", 0.25], var_b606a85da73b178);
  snd_play([2.5, "jup_vip_descend_walla_guard3_scripted", 0.25], var_b606a85da73b178);
  utility::flag_wait("flag_killed_level_3_enemies");
  thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_chant_verb", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", var_700379ed65085f62);
  thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_cheer_room", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", var_4d8b938067384f24);
  thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_cheer_room_middle", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", var_b02ae8bb5de497f5);
  thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_cheer_room", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", var_e72657bcfcfdac42);
  thread function_e727938bd32b97b2(var_e0cf73d8f5b02abf, 1, 3, 1, 1, "flag_makarov_reveal_igc_start_submix", var_4d8b938067384f24);
  thread function_e727938bd32b97b2(var_e0cf73d8f5b02abf, 2, 3, 1, 1, "flag_makarov_reveal_igc_start_submix", var_b02ae8bb5de497f5);
  thread function_e727938bd32b97b2(var_e0cf73d8f5b02abf, 2, 4, 1, 1, "flag_makarov_reveal_igc_start_submix", var_e72657bcfcfdac42);
  level.var_2d4a2cdf8e7d3eed = 1;
  utility::flag_wait("flag_reach_vip_open_door_2");
  var_2ce2fae628d46e = snd_play("jup_vip_descend_walla_ground_floor_emt_lp", (-9635, -14795, -180));
  level.var_9156dadf0912c25e = 1;
  flag_wait("flag_makarov_reveal_igc_start_submix");
  snd_stop(var_2ce2fae628d46e);
}

function function_e0a23069a39c5b5f() {
  var_dbcda31c1ed7c1b1 = snd_play([0, "jup_vip_descend_walla_ground_floor_lp", 2]);
  var_2f8feefe103d6478 = snd_play([0, "jup_vip_descend_walla_ground_floor_rear_lp", 2]);
  flag_wait("flag_player_approach_dungeon_choke");
  var_84156e3ba751e377 = 0;
  var_800606d634ff5ddb = (-9992, -15288, -241);
  var_9bcf90b752cdb1f0 = (-10254, -15171, -311);
  var_f65a7347a591caef = (-10551, -15651, -371);

  while(!flag("flag_makarov_reveal_igc_start_submix")) {
    if(distance(level.player.origin, var_f65a7347a591caef) > 850 && istrue(var_84156e3ba751e377)) {
      var_84156e3ba751e377 = 0;
      level.player clearsoundsubmix("sp_jup_vip_descend_walla_ground_floor_2d", 0.25);
    }

    if(distance(level.player.origin, var_800606d634ff5ddb) < 135 && distance(level.player.origin, var_9bcf90b752cdb1f0) < 350 && !istrue(var_84156e3ba751e377)) {
      var_84156e3ba751e377 = 1;
      level.player setsoundsubmix("sp_jup_vip_descend_walla_ground_floor_2d", 0.25);
    }

    wait 0.25;
  }

  snd_stop(var_dbcda31c1ed7c1b1);
  snd_stop(var_2f8feefe103d6478);
  level.player clearsoundsubmix("sp_jup_vip_descend_walla_ground_floor_2d");
}

function function_a7b47b4c5be33072(aliasname, var_7949632c14febddb, position, var_67b12b6b3a0483cf, var_678e196b39de1481) {
  entpos = 0;

  switch (position) {
    case #"hash_c9b3133a17a3b2d0":
      position = (-8775, -14100, 0);
    case #"hash_96815ce4f2a3dbc5":
      position = (-8820, -14300, 0);
    case #"hash_c1727e726d27175":
      position = (-9000, -13900, 0);
    case #"hash_eab796ec3eba88e":
      position = (-9000, -14200, 0);
      break;
  }

  while(!flag(var_7949632c14febddb)) {
    var_4bb61811b9080546 = level.player.origin[2];
    var_edaa83fd54ba8115 = position + (0, 0, var_4bb61811b9080546);
    var_90a08b9456a54f84 = randomfloatrange(var_67b12b6b3a0483cf, var_678e196b39de1481);
    thread function_853401bf140b6d6d(var_edaa83fd54ba8115, aliasname, -5, 5, -5, 5, 100, entpos);
    wait var_90a08b9456a54f84;
  }
}

function function_a164518cdca8cb9c(fadein, fadeout, waittime) {
  level.player setsoundsubmix("sp_jup_vip_descend_walla_prisoner_cheer", fadein);
  wait waittime;
  level.player clearsoundsubmix("sp_jup_vip_descend_walla_prisoner_cheer", fadeout);
}

function function_22f559c53423d1c6(var_a87dc3ebebd2b022) {
  wait 3;

  foreach(prisoner in var_a87dc3ebebd2b022) {
    randwait = randomintrange(500, 2000);
    wait randwait / 1000;
    function_f553715d7011255d(prisoner);
  }
}

function function_c1387e6531f8ae71(var_e4cb6aaa2b9b005d, var_e4cb67aa2b9af9c4) {
  var_b7d0e62261fd250f = ["jup_vip_descend_walla_guy2_exerts_2f", "jup_vip_descend_walla_guy3_exerts_2f", "jup_vip_descend_walla_exerts_2f", "jup_vip_descend_walla_guy2_exerts_yell_2f", "jup_vip_descend_walla_guy3_exerts_yell_2f"];
  flag_wait("flag_level_2_player_actually_spotted");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 4, 6, 1, 1, "aud_grapple_guy_interuppted", "flag_stop_exert_guard_01a", var_e4cb6aaa2b9b005d, "flag_open_door_2");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 4, 6, 1, 1, "aud_grapple_guy_interuppted", "flag_stop_exert_guard_02b", var_e4cb67aa2b9af9c4, "flag_open_door_2");
}

function function_553372e150ab6c08(var_1de152d81da73ca8, var_f954c1ba9db9b75f) {
  wait 4;

  foreach(prisoner in var_1de152d81da73ca8) {
    randwait = randomintrange(1, 1000);
    wait randwait / 1000;
    function_f553715d7011255d(prisoner);
  }

  wait 2.5;
  thread function_90c5570c2091e9fe(var_f954c1ba9db9b75f);
}

function function_90c5570c2091e9fe(var_1de152d81da73ca8) {
  while(!flag("flag_open_door_2")) {
    if(isDefined(var_1de152d81da73ca8)) {
      var_1de152d81da73ca8 = array_removedead_or_dying(var_1de152d81da73ca8);
      randwait = randomintrange(3, 6);
    } else {
      return;
    }

    if(var_1de152d81da73ca8.size > 2) {
      randnum = randomintrange(0, 2);
      var_bdb0cf37703beba4 = get_array_of_closest(level.player.origin, var_1de152d81da73ca8);
      var_44bbd50acc1b513f = get_array_of_farthest(level.player.origin, var_1de152d81da73ca8);
      thread function_828cffaac2c37ee3(var_bdb0cf37703beba4, var_44bbd50acc1b513f, randnum);
      wait randwait;
      continue;
    }

    return;
  }
}

function function_828cffaac2c37ee3(var_bdb0cf37703beba4, var_44bbd50acc1b513f, randnum) {
  if(randnum != 0) {
    var_b447dabfd3feebde = randomintrange(0, randnum);
    var_8de6c0d245632f9f = randnum - var_b447dabfd3feebde;
  } else {
    var_b447dabfd3feebde = 0;
    var_8de6c0d245632f9f = 0;
  }

  randwait = randomfloatrange(0, 2);

  for(i = 0; i <= var_b447dabfd3feebde; i++) {
    if(isalive(var_bdb0cf37703beba4[i])) {
      thread function_694ab3344595497a(var_bdb0cf37703beba4[i]);
      wait randwait;
    }
  }

  for(j = 0; j <= var_8de6c0d245632f9f; j++) {
    if(isalive(var_bdb0cf37703beba4[i])) {
      thread function_f553715d7011255d(var_44bbd50acc1b513f[j]);
      wait randwait;
    }
  }
}

function function_3fc486a245c54b0(var_e4cb6aaa2b9b005d, var_e4cb67aa2b9af9c4, var_e4cb68aa2b9afbf7, var_e4cb65aa2b9af55e, var_e4cb63aa2b9af0f8) {
  var_b7d0e62261fd250f = ["jup_vip_descend_walla_guy2_exerts", "jup_vip_descend_walla_guy3_exerts", "jup_vip_descend_walla_exerts", "jup_vip_descend_walla_guy2_exerts_yell", "jup_vip_descend_walla_guy3_exerts_yell"];
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 5, 9, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_01", var_e4cb6aaa2b9b005d, "flag_makarov_reveal_igc_start_submix");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 6, 9, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_02", var_e4cb67aa2b9af9c4, "flag_makarov_reveal_igc_start_submix");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 4, 8, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_03", var_e4cb68aa2b9afbf7, "flag_makarov_reveal_igc_start_submix");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 4, 9, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_04", var_e4cb65aa2b9af55e, "flag_makarov_reveal_igc_start_submix");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 3, 6, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_05", var_e4cb63aa2b9af0f8, "flag_makarov_reveal_igc_start_submix");
}

function function_461058a3a2d50aff(var_e4cb6aaa2b9b005d, var_e4cb67aa2b9af9c4, var_e4cb68aa2b9afbf7, var_e4cb65aa2b9af55e) {
  var_b7d0e62261fd250f = ["jup_vip_descend_walla_guy2_exerts", "jup_vip_descend_walla_guy3_exerts", "jup_vip_descend_walla_exerts", "jup_vip_descend_walla_guy2_exerts_yell", "jup_vip_descend_walla_guy3_exerts_yell"];
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 5, 9, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_06", var_e4cb6aaa2b9b005d, "flag_makarov_reveal_igc_start_submix");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 6, 9, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_07", var_e4cb67aa2b9af9c4, "flag_makarov_reveal_igc_start_submix");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 4, 8, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_08", var_e4cb68aa2b9afbf7, "flag_makarov_reveal_igc_start_submix");
  thread function_96b064d2df0f3369(var_b7d0e62261fd250f, 3, 8, 1, 1, "aud_riot_guy_interuppted", "flag_stop_exert_guard_09", var_e4cb65aa2b9af55e, "flag_makarov_reveal_igc_start_submix");
}

function function_76b9d2def4764bfb() {}

function function_7d9c34fea7abba03() {
  if(!istrue(level.var_ecda36875e66690c) && !istrue(level.var_9156dadf0912c25e) && !istrue(level.var_2d4a2cdf8e7d3eed)) {
    thread function_e0a23069a39c5b5f();
    var_2ce2fae628d46e = snd_play("jup_vip_descend_walla_ground_floor_emt_lp", (-9635, -14795, -180));
    thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_chant_verb", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", level.var_700379ed65085f62);
    thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_cheer_room", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", level.var_4d8b938067384f24);
    thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_chant_room", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", level.var_b02ae8bb5de497f5);
    thread function_e727938bd32b97b2("jup_vip_descend_walla_mult_cheer_room", 7, 11, 1, 1, "flag_makarov_reveal_igc_start_submix", level.var_e72657bcfcfdac42);
    thread function_e727938bd32b97b2(level.var_e0cf73d8f5b02abf, 1, 3, 1, 1, "flag_makarov_reveal_igc_start_submix", level.var_4d8b938067384f24);
    thread function_e727938bd32b97b2(level.var_e0cf73d8f5b02abf, 2, 5, 1, 1, "flag_makarov_reveal_igc_start_submix", level.var_b02ae8bb5de497f5);
    thread function_e727938bd32b97b2(level.var_e0cf73d8f5b02abf, 2, 4, 1, 1, "flag_makarov_reveal_igc_start_submix", level.var_e72657bcfcfdac42);
    flag_wait("flag_makarov_reveal_igc_start_submix");
    snd_stop(var_2ce2fae628d46e);
  }
}

function function_507cbfa5f5f9846d() {}

function function_cfe71de2170ae357() {
  level.player setsoundsubmix("sp_jup_vip_courtyard2", 3);
}

function function_46c68eacc66e61e() {
  level.player setsoundsubmix("sp_jup_vip_courtyard2_entrance", 1);
}

function function_5113bf8402da1f07(mg_loc, burst_size, var_978cde78898e61ee) {
  if(burst_size < 9) {
    if(var_978cde78898e61ee) {
      snd_play("vip_courtyard2_fake_mg_short", mg_loc);
    } else {
      snd_play("vip_courtyard2_fake_mg_short_prisoner", mg_loc);
    }

    return;
  }

  if(var_978cde78898e61ee) {
    snd_play("vip_courtyard2_fake_mg_long", mg_loc);
    return;
  }

  snd_play("vip_courtyard2_fake_mg_long_prisoner", mg_loc);
}

function courtyard2_fake_mg_bullet_impact(loc) {
  snd_play("vip_courtyard2_fake_mg_bullet_impact", loc);
}

function function_8b9f69a35e622471(rocket) {
  snd_play("vip_courtyard2_rocket_flyby", rocket);
}

function function_31cca1dfb5876cfb(var_273902bbc18084f7) {
  level.player setsoundsubmix("sp_jup_vip_courtyard2_opening_mg_scene", 0.1);
  mg_location = (-9429, -12761, 2249);
  right_arch = (-11514, -15119, 1309);
  var_485d4f6d7c785219 = (-11791, -15444, 1309);
  dude_loc = (-11667, -15287, 1234);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt1_mg_firing", 250, mg_location);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt1_first_whizby", 250, var_485d4f6d7c785219);
  wait var_273902bbc18084f7;
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt1_fence_impact", 0, right_arch);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt1_dude_shot", 12, dude_loc);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt1_interior_impact", 124, var_485d4f6d7c785219);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt1_crate_explode", 641, right_arch);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt1_bullet_spray", 1494, right_arch);
  front_crate = (-11823, -14827, 1302);
  back_crate = (-12028, -14818, 1302);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt2_mg_fire", 2371, mg_location);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt2_front_crate_explode", 3171, front_crate);
  thread function_b2601fe6c354199d("vip_courtyard2_opening_pt2_bullet_spray", front_crate, back_crate, 250, 3587);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt2_back_crate_explode", 3887, back_crate);
  wait 4;
  level.player clearsoundsubmix("sp_jup_vip_courtyard2_opening_mg_scene", 5);
}

function function_5a7cc57b7debf84e() {
  level.player setsoundsubmix("sp_jup_vip_courtyard2_opening_mg_scene", 0.1);
  mg_location = (-9429, -12761, 2249);
  first_bullet = (-11768, -14889, 1305);
  var_35825f70499dbc48 = (-11578, -14593, 1303);
  var_a637df29acb0e377 = (-11238, -14542, 1221);
  var_773a2e2de661b372 = (-11541, -14777, 1264);
  var_a7f7cb82937dab8a = (-11744, -14806, 1227);
  var_5c19470cd98d10c9 = (-11768, -14889, 1305);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt3_mg_firing", 0, mg_location);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt3_first_bullet", 0, mg_location);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt3_first_spray", 0, first_bullet);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt3_arch_left_spray", 1023, var_35825f70499dbc48);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt3_interior_spray", 1379, var_a7f7cb82937dab8a);
  thread function_b2601fe6c354199d("vip_courtyard2_opening_pt3_ground_spray", var_a637df29acb0e377, var_773a2e2de661b372, 693, 1824);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_pt3_final_bullet", 2819, var_5c19470cd98d10c9);
  var_c852ca8e591adda6 = (-11302, -16144, 2165);
  var_b816cb95ba66e7c3 = (-11807, -12921, 2165);
  var_2bfe0c2f306526a9 = (-11622, -14947, 1867);
  var_45bc0106e89a4368 = (-9429, -12761, 2249);
  thread function_b2601fe6c354199d("vip_courtyard2_opening_tower_jet_flyby", var_c852ca8e591adda6, var_b816cb95ba66e7c3, 1600, 2745);
  thread function_b2601fe6c354199d("vip_courtyard2_opening_tower_missile", var_2bfe0c2f306526a9, var_45bc0106e89a4368, 1127, 3544);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_tower_exp1_transient", 4672, mg_location);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_tower_collapse", 5923, mg_location);
  thread function_c2e5ebbb02a71b15("vip_courtyard2_opening_tower_exp2_main", 12962, mg_location);
  wait 3;
  level.player clearsoundsubmix("sp_jup_vip_courtyard2_opening_mg_scene", 5);
}

function function_8b28f9fd65f493d1(truck) {
  snd_play("vip_courtyard2_truck1_engine", truck);
}

function function_8b28f6fd65f48d38(truck) {
  snd_play("vip_courtyard2_truck2_engine", truck);
}

function function_4704fbc716921ec6(truck) {
  sfx_position = truck gettagorigin("tag_origin");
  exp_sfx = playsoundatpos(sfx_position, "vip_courtyard2_truck2_explode_transient");
}

function function_c66d03aeb8392cc3(truck) {
  snd_play("vip_courtyard2_truck3_engine", truck);
  thread function_58c142aad13a14f8();
}

function function_d6157457a14fb91e(truck, rocket, rocket_start) {
  snd_play("vip_courtyard2_truck3_explode_rocket_fire", rocket_start);
  snd_play("vip_courtyard2_truck3_explode_rocket_incoming", rocket);
}

function function_8df9693aa3cc1551(truck) {
  sfx_position = truck gettagorigin("tag_origin");
  exp_sfx = playsoundatpos(sfx_position, "vip_courtyard2_truck3_explode_transient");
  truck_fire = snd_play("vip_courtyard2_truck3_fire", sfx_position);
  flag_set("flag_aud_courtyard2_last_truck_explo");
}

function function_d217e2c3a16b8d79() {
  level.player clearsoundsubmix("sp_jup_vip_courtyard2", 3);
}

function function_58c142aad13a14f8() {
  loc = (-7150, -10047, 1360);
  var_25772653942ce3ca = snd_play("vip_courtyard2_end_distant_battle_lp", loc);
  var_885d8431a724b795 = snd_play("vip_courtyard2_end_distant_battle_explo_lp", loc);
  flag_wait("flag_escape_redirect_scene_start");
  snd_stop(var_25772653942ce3ca, 10);
  snd_stop(var_885d8431a724b795, 10);
}

function function_519985c5d823aa4() {
  flag_wait("flag_obj_reach_gatehouse_activate");

  while(!flag("flag_courtyard_exit_passed_helipad")) {
    thread function_950450b32754e306(level.var_7213d5845d183df8, 3, 5, "both", "vista");
    thread function_950450b32754e306(level.courtyard_prisoners, 0, 2, "both", "courtyard");
    wait randomintrange(1, 4);
  }

  while(!flag("flag_aud_courtyard2_last_truck_explo")) {
    thread function_950450b32754e306(level.courtyard_prisoners, 2, 4, "close", "helipad");
    wait randomintrange(1, 2);
  }
}

function function_2568e6305419373() {
  flag_wait("flag_escape_tunnel_prisoners_push");

  while(!flag("flag_escape_cliff_start")) {
    thread function_950450b32754e306(level.tunnel_prisoners, 3, 5, "close", "tunnel");
    wait randomintrange(2, 5);
  }
}

function function_563616756210fdeb() {
  flag_wait("flag_escape_cliff_start");

  while(!flag("flag_slide_scene_start")) {
    thread function_950450b32754e306(level.var_bde3a1f0e4f5cc7e, 2, 6, "both", "cliff");
    wait randomintrange(3, 5);
  }
}

function function_950450b32754e306(var_1de152d81da73ca8, waitmin, waitmax, var_427b75a3e1f6cc4f, playlistname) {
  if(isDefined(var_1de152d81da73ca8)) {
    var_1de152d81da73ca8 = array_removedead_or_dying(var_1de152d81da73ca8);
    randwait = randomintrange(2, 4);

    if(var_1de152d81da73ca8.size > 2) {
      randnum = randomintrange(0, 3);
      var_bdb0cf37703beba4 = get_array_of_closest(level.player.origin, var_1de152d81da73ca8);
      var_44bbd50acc1b513f = get_array_of_farthest(level.player.origin, var_1de152d81da73ca8);
      thread function_c88082c5ec4d316d(var_bdb0cf37703beba4, var_44bbd50acc1b513f, waitmin, waitmax, var_427b75a3e1f6cc4f, randnum, playlistname);
      wait randwait;
    }
  }
}

function function_c88082c5ec4d316d(var_bdb0cf37703beba4, var_44bbd50acc1b513f, waitmin, waitmax, var_427b75a3e1f6cc4f, randnum, playlistname) {
  if(var_427b75a3e1f6cc4f == "close" && randnum != 0) {
    var_b447dabfd3feebde = randomintrange(0, randnum);
    randwait = randomfloatrange(waitmin, waitmax);

    for(i = 0; i <= var_b447dabfd3feebde; i++) {
      if(isDefined(var_bdb0cf37703beba4[i])) {
        thread function_e3395ca9684a422c(var_bdb0cf37703beba4[i], playlistname);
      }

      wait randwait;
    }
  }

  if(randnum != 0) {
    var_b447dabfd3feebde = randomintrange(0, randnum);
    var_8de6c0d245632f9f = randnum - var_b447dabfd3feebde;
  } else {
    var_b447dabfd3feebde = 0;
    var_8de6c0d245632f9f = 0;
  }

  randwait = randomfloatrange(waitmin, waitmax);

  for(i = 0; i <= var_b447dabfd3feebde; i++) {
    if(isDefined(var_bdb0cf37703beba4[i])) {
      thread function_e3395ca9684a422c(var_bdb0cf37703beba4[i], playlistname);
    }

    wait randwait;
  }

  for(j = 0; j <= var_8de6c0d245632f9f; j++) {
    if(isDefined(var_44bbd50acc1b513f[j])) {
      thread function_ae865a3fff5435a9(var_44bbd50acc1b513f[j], playlistname);
    }

    wait randwait;
  }
}

function function_e3395ca9684a422c(pos, playlistname) {
  var_8a5e99d315f6fd40 = ["jup_vip_courtyard2_walla_guy2_yell_dry", "jup_vip_courtyard2_walla_guy4_yell_dry", "jup_vip_courtyard2_walla_guy6_yell_dry"];
  var_2f964055951b4e82 = ["jup_vip_walla_courtyard2_vista_guy1_dry", "jup_vip_walla_courtyard2_vista_guy2_dry", "jup_vip_walla_courtyard2_vista_guy3_dry"];
  var_b0d1e9af9db62f6d = ["jup_vip_walla_courtyard2_guy1_dry", "jup_vip_walla_courtyard2_guy2_dry", "jup_vip_walla_courtyard2_guy3_dry", "jup_vip_walla_courtyard2_guy4_dry", "jup_vip_walla_courtyard2_guy5_dry"];
  var_b1a13f16bc5b5afb = ["jup_vip_courtyard2_walla_guy2_yell_dry", "jup_vip_courtyard2_walla_guy4_yell_dry", "jup_vip_courtyard2_walla_guy6_yell_dry"];

  switch (playlistname) {
    case #"hash_bbf7bcdca4b31708":
      playlistname = var_8a5e99d315f6fd40;
    case #"hash_1e60de50d673aa8a":
      playlistname = var_8a5e99d315f6fd40;
    case #"hash_b72fb3e759175592":
      playlistname = var_2f964055951b4e82;
    case #"hash_47f65233c6fcd9b7":
      playlistname = var_b0d1e9af9db62f6d;
    case #"hash_8ff02eb8ab5d8721":
      playlistname = var_b1a13f16bc5b5afb;
      break;
  }

  var_b8314245e522d822 = random(playlistname);
  snd_play(var_b8314245e522d822, pos);
}

function function_ae865a3fff5435a9(pos, playlistname) {
  var_8224f76d3cd9afdd = ["jup_vip_walla_courtyard2_guy1_verb", "jup_vip_walla_courtyard2_guy2_verb", "jup_vip_walla_courtyard2_guy3_verb", "jup_vip_walla_courtyard2_guy4_verb", "jup_vip_walla_courtyard2_guy5_verb"];
  var_6b2909c96da285d3 = ["jup_vip_walla_courtyard2_vista_guy1_verb", "jup_vip_walla_courtyard2_vista_guy2_verb", "jup_vip_walla_courtyard2_vista_guy3_verb"];
  var_c4f62216946c19bc = ["jup_vip_walla_courtyard2_guy1_verb", "jup_vip_walla_courtyard2_guy2_verb", "jup_vip_walla_courtyard2_guy3_verb", "jup_vip_walla_courtyard2_guy4_verb", "jup_vip_walla_courtyard2_guy5_verb"];
  var_e4e951ac987118e6 = ["jup_vip_walla_courtyard2_guy1_dry", "jup_vip_walla_courtyard2_guy2_dry", "jup_vip_walla_courtyard2_guy3_dry", "jup_vip_walla_courtyard2_guy4_dry", "jup_vip_walla_courtyard2_guy5_dry"];

  switch (playlistname) {
    case #"hash_bbf7bcdca4b31708":
      playlistname = var_8224f76d3cd9afdd;
    case #"hash_1e60de50d673aa8a":
      playlistname = var_8224f76d3cd9afdd;
    case #"hash_b72fb3e759175592":
      playlistname = var_6b2909c96da285d3;
    case #"hash_47f65233c6fcd9b7":
      playlistname = var_c4f62216946c19bc;
    case #"hash_8ff02eb8ab5d8721":
      playlistname = var_e4e951ac987118e6;
      break;
  }

  var_b8314245e522d822 = random(playlistname);
  snd_play(var_b8314245e522d822, pos);
}

function function_3c07b25b2cbe9403() {
  setglobalsoundcontext("prj_terrain_override", "sp_jup_heli_impact");
  level.player clearsoundsubmix("sp_jup_vip_courtyard2_entrance", 1);
}

function function_17574a02c3d82efe() {
  setglobalsoundcontext("prj_terrain_override", "sp_jup_heli_impact");
}

function function_c3a4d38367470b67() {
  setglobalsoundcontext("prj_terrain_override", "");
}

function function_fdf48407f0c84ed1() {
  level.heli playsoundonmovingent("jup_vip_helicopter_courtyard2_start");
  var_7b04d77cb9dacb0d = snd_play([8, "jup_vip_helicopter_courtyard2_patrol_engine_lp", 6], level.heli);
  snd_stop_on_level_notify(var_7b04d77cb9dacb0d, "flag_courtyard_exit_passed_helipad", 8);
}

function function_d209a72b1029d79e() {
  impact_loc = (-7896, -11383, 1206);
  level.player setsoundsubmix("sp_jup_vip_helicopter_tunnel");
  level.var_8906fd70bcda7978 playsoundonmovingent("jup_vip_helicopter_tunnel_start");
  var_69b61d0daa86d032 = snd_play([5.3, "jup_vip_helicopter_courtyard2_tunnel_turret_shots"], level.var_8906fd70bcda7978);
  var_19e04057a2ed2455 = snd_play([5.3, "jup_vip_helicopter_courtyard2_tunnel_turret_impacts"], impact_loc);
  var_bfe0482014f91c86 = snd_play([10, "jup_vip_helicopter_tunnel_hover_engine_lp", 4], level.var_8906fd70bcda7978);
  wait 8;
  level.player clearsoundsubmix("sp_jup_vip_helicopter_tunnel", 1);
  snd_stop_on_level_notify(var_bfe0482014f91c86, "flag_slide_scene_start", 8);
  thread function_b647e5bac9f2836e();
}

function function_b647e5bac9f2836e() {
  level.var_cfffcccc0d507c73 = snd_play("sp_jup_vip_exfil_dist_gunfire_lp", (-374, -11518, -161));
}

function function_7ce163e72544d19() {
  level.player playSound("jup_vip_1700_exfil_leapoffaith_0ms_c");
  level.player setsoundsubmix("sp_jup_vip_finale_scn_exfil_jump");
  wait 7.3;
  level.player setsoundsubmix("sp_jup_vip_finale_scn_exfil_jump_underwater");
  waitframe();
  snd_stop(level.var_cfffcccc0d507c73);
}

function function_8b730ff032f5bad8() {
  level.player clearsoundsubmix("sp_jup_vip_finale_scn_exfil_jump");
  level.player clearsoundsubmix("sp_jup_vip_finale_scn_exfil_jump_underwater");
  level.player setsoundsubmix("sp_jup_vip_finale_scn_exfil_boat_underwater");
  wait 6.7;
  level.player clearsoundsubmix("sp_jup_vip_finale_scn_exfil_boat_underwater");
  level.player setsoundsubmix("sp_jup_vip_finale_scn_exfil_boat");
}

function function_7d0d86b34c77f571() {
  level.player clearsoundsubmix("sp_jup_vip_finale_scn_exfil_boat");
  waitframe();
  level.player setsoundsubmix("sp_jup_vip_finale_scn_exfil_boat_fade_black");
}
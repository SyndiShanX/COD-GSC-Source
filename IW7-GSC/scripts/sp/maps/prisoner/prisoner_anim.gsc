/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_anim.gsc
******************************************************/

main() {
  player();
  _id_775B();
  _id_3353();
  vehicle();
  script_model();
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["dropship_chair_enter"] = % dropship_chair_enter_player;
  level._id_EC85["player_rig"]["dropship_chair_idle"][0] = % dropship_chair_idle_player;
  level._id_EC85["player_rig"]["dropship_chair_exit"] = % sh_mn_1_21_ethan_rig_plr_getout;
  level._id_EC85["player_rig"]["injured_august_scene"] = % prisoner_injured_atom_player;
  level._id_EC85["player_rig"]["church_door_open_scripted"] = % prisoner_gesture_church_door_open_scripted;
  level._id_EC85["player_rig"]["prisoner_courtyard_plr_window_open_45"] = % prisoner_courtyard_plr_window_open_45;
  level._id_EC85["player_rig"]["prisoner_courtyard_plr_window_open"] = % prisoner_courtyard_plr_window_open;
  level._id_EC85["player_rig"]["churchfall_door_open"] = % pnr_churchfall_plr_door_open;
}

#using_animtree("generic_human");

_id_775B() {
  level._id_EC87["salter"] = #animtree;
  level._id_EC87["hvt"] = #animtree;
  level._id_EC87["atom"] = #animtree;
  level._id_EC87["civ_corpse"] = #animtree;
  level._id_EC85["atom"]["dropship_sit_idle"][0] = % xodus_robot_02_sit_idle;
  level._id_EC85["atom"]["dropship_chair_enter"] = % dropship_chair_enter_ai;
  level._id_EC85["atom"]["dropship_chair_idle"][0] = % dropship_chair_idle_ai;
  level._id_EC85["atom"]["dropship_chair_exit"] = % prisoner_dropship_ethan_exit;
  level._id_EC85["generic"]["stand_idle"][0] = % hm_grnd_grn_casual_stand_idle;
  level._id_EC85["salter"]["intro_sit_idle"][0] = % xodus_robot_02_sit_idle;
  level._id_EC85["atom"]["prisoner_ally_debris_jump"] = % pnr_eth3n_debris_jump;
  level._id_EC85["atom"]["prisoner_august_truck"] = % prisoner_injured_atom_ethan;
  level._id_EC85["generic"]["prisoner_august_truck"] = % prisoner_injured_atom_brooks;
  level._id_EC85["generic"]["prisoner_august_truck_idle"][0] = % prisoner_injured_atom_brooks_idle;
  level._id_EC85["atom"]["prisoner_august_truck_idle"][0] = % prisoner_injured_atom_ethan_idle;
  level._id_EC85["generic"]["truck_injured_idle"][0] = % shipcribmoon_elevator_injured_loop_02;
  scripts\sp\anim::_id_17F6("generic", "mayhem_start", ::_id_2614, "prisoner_august_truck");
  scripts\sp\anim::_id_17F6("generic", "mayhem_end", ::_id_2613, "prisoner_august_truck");
  level._id_EC85["civ_corpse"]["un_corpse01"] = % generic_dead_civ_01;
  level._id_EC85["civ_corpse"]["un_corpse02"] = % ph_dead_civi_car_passenger_03;
  level._id_EC85["hvt"]["prisoner_hvt_glimpse_library"] = % prisoner_hvt_glimpse_library;
  level._id_EC85["hvt"]["pnr_alley_ent_hvt"] = % pnr_alley_ent_hvt;
  level._id_EC85["generic"]["ph_cafe_civis_ambient_civ11"][0] = % ph_cafe_civis_ambient_civ11;
  level._id_EC85["hvt"]["pnr_bikeshop_idle"][0] = % prisoner_bikeshop_door_peek_idle_sdf1;
  level._id_EC85["generic"]["pnr_bikeshop_idle"][0] = % prisoner_bikeshop_door_peek_idle_sdf2;
  level._id_EC85["hvt"]["pnr_bikeshop_shove"] = % prisoner_bikeshop_door_peek_sdf1;
  level._id_EC85["generic"]["pnr_bikeshop_shove"] = % prisoner_bikeshop_door_peek_sdf2;
  level._id_EC85["generic"]["dropship_jumpout"] = % traverse_jumpdown_130;
  level._id_EC87["van1rider1"] = #animtree;
  level._id_EC87["van1rider2"] = #animtree;
  level._id_EC87["van1rider3"] = #animtree;
  level._id_EC87["van1rider4"] = #animtree;
  level._id_EC87["van1rider5"] = #animtree;
  level._id_EC87["van2rider1"] = #animtree;
  level._id_EC87["van2rider2"] = #animtree;
  level._id_EC87["van2rider3"] = #animtree;
  level._id_EC87["van2rider4"] = #animtree;
  level._id_EC87["van2rider5"] = #animtree;
  level._id_EC85["van1rider1"]["flowershop_scene"] = % pnr_courtyard_van1_rider1;
  level._id_EC85["van1rider2"]["flowershop_scene"] = % pnr_courtyard_van1_rider2;
  level._id_EC85["van1rider3"]["flowershop_scene"] = % pnr_courtyard_van1_rider3;
  level._id_EC85["van1rider4"]["flowershop_scene"] = % pnr_courtyard_van1_rider4;
  level._id_EC85["van1rider5"]["flowershop_scene"] = % pnr_courtyard_van1_rider5;
  level._id_EC85["van2rider1"]["flowershop_scene"] = % pnr_courtyard_van2_rider1;
  level._id_EC85["van2rider2"]["flowershop_scene"] = % pnr_courtyard_van2_rider2;
  level._id_EC85["van2rider3"]["flowershop_scene"] = % pnr_courtyard_van2_rider3;
  level._id_EC85["van2rider4"]["flowershop_scene"] = % pnr_courtyard_van2_rider4;
  level._id_EC85["van2rider5"]["flowershop_scene"] = % pnr_courtyard_van2_rider5;
  level._id_EC85["hvt"]["flowershop_scene"] = % pnr_courtyard_van2_hvt;
  level._id_EC85["generic"]["doorburst_wave"] = % doorburst_wave;
  level._id_EC85["hvt"]["flowershop_run"] = % civilian_run_hunched_turnl45;
  level._id_EC85["ladderguy"]["chunk2_ladderclimb"] = % pnr_ladder_climb;
  level._id_EC85["ladderguy"]["chunk2_ladderdeath"] = % pnr_ladder_death;
  level._id_EC85["civilian"]["terrace_window_fall"] = % ph_civi_sq_kicked_over_railing_civi;
  level._id_EC85["windowguy"]["window_kick"] = % door_kick_in;
  level._id_EC85["church_door_guy1"]["church_entrance_door_enter"] = % prisoner_church_enemy_door_close;
  scripts\sp\anim::_id_17FA("church_door_guy1", "in_position", "church_runin_scene_guy1_inposition", "church_entrance_door_enter");
  scripts\sp\anim::_id_17FA("church_door_guy1", "close_door", "church_runin_scene_guy1_startclose", "church_entrance_door_enter");
  level._id_EC85["church_door_guy2"]["church_entrance_door_enter"] = % prisoner_church_enemy_door_close_run;
  scripts\sp\anim::_id_17FA("church_door_guy2", "thru_door", "church_runin_scene_guy2_atdoor", "church_entrance_door_enter");
  level._id_EC85["church_door_guy1"]["church_entrance_door_enter_quick"] = % prisoner_church_enemy_door_close_quick;
  level._id_EC85["generic"]["cqb_crouch_stop_8"] = % cqb_crouch_stop_8;
  level._id_EC85["churchroad_enemy"]["curved_wallrun_left"] = % pnr_curved_wall_run_left;
  level._id_EC85["churchroad_enemy"]["curved_wallrun_right"] = % pnr_curved_wall_run_right;
  level._id_EC85["hvt"]["hvt_stair_glimpse"] = % pnr_hvt_glimpse_shoot;
  level._id_EC85["hvt"]["churchfall_door_open"] = % pnr_churchfall_hvt_door_open;
}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["roofguy"]["roof_slide"] = % pnr_terrace_roofslide_c6;
}

#using_animtree("vehicles");

vehicle() {
  level._id_EC87["truck_cab"] = #animtree;
  level._id_EC87["truck_trailer"] = #animtree;
  level._id_EC85["truck_cab"]["bridge_truck_crash"] = % pnr_truck_crash_cab;
  level._id_EC85["truck_trailer"]["bridge_truck_crash"] = % pnr_truck_crash_trailer;
  level._id_EC87["van1"] = #animtree;
  level._id_EC8C["van1"] = "veh_civ_lnd_utility_van";
  level._id_EC87["van2"] = #animtree;
  level._id_EC8C["van2"] = "veh_civ_lnd_utility_van";
  level._id_EC85["van1"]["flowershop_scene_idle"][0] = % pnr_courtyard_van1_van_idle;
  level._id_EC85["van2"]["flowershop_scene"] = % pnr_courtyard_van2_van;
  level._id_EC85["van2"]["flowershop_scene_idle"][0] = % pnr_courtyard_van2_van_idle;
  level._id_EC8C["collapse_truck"] = "veh_mil_lnd_un_prisoner_transport";
  level._id_EC87["collapse_truck"] = #animtree;
  level._id_EC85["collapse_truck"]["collapse_truck_anim"] = % prisoner_injured_atom_truck;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["atomModel"] = #animtree;
  level._id_EC87["hvrModel"] = #animtree;
  level._id_EC87["church_door"] = #animtree;
  level._id_EC87["churchfall_door"] = #animtree;
  level._id_EC8C["churchfall_door"] = "door_wood_01_door";
  level._id_EC85["churchfall_door"]["churchfall_door_open"] = % pnr_churchfall_door_door_open;
  level._id_EC87["pillar_fall"] = #animtree;
  level._id_EC8C["pillar_fall"] = "pillar_dmg_concrete_01_long_wet";
  level._id_EC85["pillar_fall"]["prisoner_debris_fall"] = % prisoner_debris_fall;
  level._id_EC87["dropship_seat_mount01"] = #animtree;
  level._id_EC8C["dropship_seat_mount01"] = "equipment_industrial_weapon_mount_01";
  level._id_EC85["dropship_seat_mount01"]["seat_mount_ff"] = % titan_dropship_weapon_mount_01;
  level._id_EC85["dropship_seat_mount01"]["SH_PRI_7_19_MISSION_SEAT_MNT_enter"] = % sh_pri_7_19_mission_seat_mnt_enter;
  level._id_EC85["dropship_seat_left_cockpit"]["dropship_chair_exit"] = % prisoner_dropship_seat_exit;
  level._id_EC85["dropship_seat_right_cockpit"]["dropship_chair_exit_seat"] = % prisoner_dropship_seat_exit;
  level._id_EC87["bridge_railing"] = #animtree;
  level._id_EC87["bridge_cars"] = #animtree;
  level._id_EC8C["bridge_cars"] = "prisoner_bridge_cars_rig";
  level._id_EC85["bridge_railing"]["bridge_truck_crash"] = % prisoner_bridge_railing_truck_plow;
  level._id_EC85["bridge_cars"]["bridge_truck_crash"] = % prisoner_bridge_cars_truck_plow;
  level._id_EC87["church_entrance_door_l"] = #animtree;
  level._id_EC87["church_entrance_door_r"] = #animtree;
  level._id_EC8C["church_entrance_door_l"] = "door_metal_01_leftside";
  level._id_EC8C["church_entrance_door_r"] = "door_metal_01_rightside";
  level._id_EC85["church_entrance_door_l"]["church_entrance_door_enter"] = % prisoner_church_door_close_door_l;
  level._id_EC85["church_entrance_door_r"]["church_entrance_door_enter"] = % prisoner_church_door_close_door_r;
  level._id_EC85["church_entrance_door_l"]["church_entrance_door_enter_quick"] = % prisoner_church_door_close_door_l_quick;
  level._id_EC85["church_entrance_door_r"]["church_entrance_door_enter_quick"] = % prisoner_church_door_close_door_r_quick;
  level._id_EC8C["church_door"] = "door_nml_house_iw6";
  level._id_EC85["church_door"]["church_door_open_scripted"] = % prisoner_gesture_church_door_open_scripted_door;
  level._id_EC8C["church_table"] = "furniture_greece_wooden_old_table_01";
  level._id_EC87["church_table"] = #animtree;
  level._id_EC85["church_table"]["church_table_anim"] = % pnr_attic_table_flip_table;
  level._id_EC87["knife"] = #animtree;
  level._id_EC8C["knife"] = "tactical_knife_iw7_wm";
}

#using_animtree("generic_human");

_id_2614(var_0) {
  level._id_2612 _meth_82A2(%mayhem_prisoner_injured_atom_auguste, 1.0, 0.0, 1.0);
  level._id_2612 detach(level._id_2612.headmodel);
}

_id_2613(var_0) {
  level._id_2612 clearanim(%mayhem_prisoner_injured_atom_auguste, 0.0);
  level._id_2612 attach(level._id_2612.headmodel);
}
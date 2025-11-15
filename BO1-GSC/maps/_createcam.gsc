/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_createcam.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_createmenu;
#include maps\_camsys;

main() {
  camsys_init();
}

main2() {}
createcam_precache() {}
remove_player_weapons() {}
set_crosshair() {}
level_vars() {}
setup_types() {}
add_shot_type(name) {
  if(!isDefined(level.shottypes)) {
    level.shottypes = [];
  }
  level.shottypes[level.shottypes.size] = name;
}

setup_menus() {}
setup_menu_buttons() {}
create_track() {}
create_track_thread() {}
create_target() {}
create_target_thread() {}
shot_type() {}
place_track_cp() {}
place_target_cp() {}
select_track() {}
select_track_highlight(num) {}
create_shot(shot_name, track_name, target_name) {}
select_target() {}
select_target_highlight(num) {}
play_selected_track() {}
name_shot() {}
select_shot() {}
play_selected_shot() {}
edit_track_select_track() {}
edit_shot() {}
edit_shot_track() {}
edit_shot_track_thread() {}
edit_shot_target() {}
edit_shot_target_thread() {}
edit_shot_track_hud(edit_target) {}
edit_shot_track_cp_hud_info(edit_target) {}
edit_track_cp_update_info(edit_target) {}
edit_update_cpoint_attrib(attrib_name, value, edit_target) {}
edit_update_cpoint_origin(edit_target) {}
edit_add_target_cpoint() {}
edit_add_cpoint(edit_target) {}
edit_delete_target_cpoint() {}
edit_delete_cpoint(edit_target) {}
edit_sync_time_to_target() {}
edit_sync_time_to_track() {}
edit_shot_track_buttons() {}
edit_shot_track_input(edit_target) {}
edit_cp_highlight(pos, edit_target) {}
edit_shot_change_track() {}
edit_shot_change_target() {}
compose_scene() {}
scene_editor_menu(strings, func) {}
scene_editor_add_huds(x, y, scale, num) {}
scene_editor_select_shot(x, y, strings) {}
draw_fancy_hudline(type, start_x, start_y, length, time, color, alpha, thickness) {}
move_huds(huds, x_shift, y_shift, current_pos, max_num_fading, min_alpha) {}
set_huds_alphas(huds, current_pos, max_num_fading, min_alpha) {}
name_scene() {}
copy_scene(name, copy_name) {}
remove_scene(name_of_scene) {}
save_all() {}
save_shots(file) {}
save_scenes(file) {}
save_complete(msg) {}
text_box(msg1, msg2, chars) {}
add_cp_to_track(num, type, cp) {}
add_cp_to_target(num, type, cp) {}
copy_shot(name, copy_name) {}
remove_shot(shot_name) {}
draw_all_shots() {}
draw_all_tracks_and_targets() {}
draw_all_tracks() {}
draw_track(num) {}
draw_point(origin, point_type, num, color) {}
draw_point_thread(origin, num, color) {}
get_square_points(origin, square_width) {
  points = [];
  square_width = square_width * 0.5;
  points[0] = origin + (square_width, square_width, square_width);
  points[1] = origin + (square_width, square_width * -1, square_width);
  points[2] = origin + (square_width * -1, square_width * -1, square_width);
  points[3] = origin + (square_width * -1, square_width, square_width);
  points[4] = origin + (square_width, square_width, square_width * -1);
  points[5] = origin + (square_width, square_width * -1, square_width * -1);
  points[6] = origin + (square_width * -1, square_width * -1, square_width * -1);
  points[7] = origin + (square_width * -1, square_width, square_width * -1);
  return points;
}

draw_all_targets() {}
draw_target(num) {}
edit_help(msg) {}
set_default_path() {}
spawn_cam_model(scene_name, pos, angles) {}
draw_scene_lines(scene_name) {}
draw_scene_node_info(scene_name, end_on) {}
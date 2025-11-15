/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_createmenu.gsc
**************************************/

#include common_scripts\utility;

add_menu(menu_name, title) {}
add_menuoptions(menu_name, option_text, func, key) {}
add_menu_child(parent_menu, child_menu, child_title, child_number_override, func) {}
set_no_back_menu(menu_name) {}
enable_menu(menu_name) {}
disable_menu(menu_name) {}
set_menu_hudelem(text, type, y_offset) {}
set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem) {}
menu_input() {}
force_menu_back(waittill_msg) {}
list_menu(list, x, y, scale, func, sort, start_num) {}
new_move_list_menu(hud_array, list, num) {}
move_list_menu(hud_array, dir, space, num, min_alpha, num_of_fades) {}
hud_selector(x, y) {}
hud_selector_fade_out(time) {}
selection_error(msg, x, y) {}
hud_font_scaler(mult) {}
menu_cursor() {}
new_hud(hud_name, msg, x, y, scale) {}
remove_hud(hud_name) {}
destroy_hud(hud) {}
set_menus_pos_by_num(hud_array, num, x, y, space, min_alpha, num_of_fades) {}
popup_box(x, y, width, height, time, color, alpha) {}
destroy_popup() {}
dialog_text_box(dialog_msg, dialog_msg2, word_length) {}
dialog_text_box_input(cursor_x, cursor_y, word_length) {}
dialog_text_box_buttons() {}
dialog_text_box_cursor() {}
get_letter_space(letter) {}
add_universal_button(button_group, name) {}
clear_universal_buttons(button_group) {}
universal_input_loop(button_group, end_on, use_attackbutton, mod_button, no_mod_button) {}
disable_buttons(button_group) {}
enable_buttons(button_group) {}
any_button_hit(button_hit, type) {}
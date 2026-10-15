/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_zombie_museum.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\mp_common\load;

#namespace mp_zombie_museum;

event_handler[level_init] main(eventstruct) {
  load::main();
  level.cleandepositpoints = array((-1664, 716, 134), (1996, 0, 14), (-696, -168, 110), (2208, -2240, 78), (-36, -2084, 78));
  compass::setupminimap("");
  var_6ed52f9d = spawn("script_model", (-11, -1843, 71.5));
  var_6ed52f9d.angles = (0, 281.427, 0);
  var_6ed52f9d setModel("p7_mou_flat_tarp_01_blue");
  var_869bfc5f = spawn("script_model", (62.5, -1891, 74));
  var_869bfc5f.angles = (0, 48.96, -180);
  var_869bfc5f setModel("p8_col_board_plywood_old_large_01");
  var_68cdc0c3 = spawn("script_model", (46.5, -1939, 73));
  var_68cdc0c3.angles = (0, 31.36, 0);
  var_68cdc0c3 setModel("p8_col_board_plywood_old_large_01");
  carpet = spawn("script_model", (111.5, -2010, 72));
  carpet.angles = (0, 339.9, 0);
  carpet setModel("p8_zm_esc_rug_rectangle_02_crooked");
}
/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2863.gsc
*********************************************/

func_9752() {
  if(!isDefined(level.flag)) {
    scripts\common\flags::init_flags();
  } else {
    var_0 = getarraykeys(level.flag);
    scripts\engine\utility::array_levelthread(var_0, ::func_3D74);
  }

  scripts\engine\utility::flag_init("auto_adjust_initialized");
  if(!scripts\engine\utility::flag_exist("load_finished")) {
    scripts\engine\utility::flag_init("load_finished");
  }

  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }
}

func_3D74(var_0) {
  if(getsubstr(var_0, 0, 3) != "aa_") {
    return;
  }

  [[level.func["sp_stat_tracking_func"]]](var_0);
}
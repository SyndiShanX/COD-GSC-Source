/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3830.gsc
***************************************/

func_E3F4() {}

func_F0E1(var_0, var_1, var_2) {
  return;

  if(isDefined(level.var_F0DE)) {
    level.var_F0DE delete();
  }

  if(!isDefined(var_1)) {
    var_1 = 65;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_0 = func_0EFB::func_7CBC("security_camera", "targetname", var_0);
  level.var_F0DE = var_0 scripts\engine\utility::spawn_tag_origin();
  scripts\sp\pip_util::func_CBB5(level.var_F0DE, "tag_origin", var_1);

  if(var_2) {
    setomnvar("ui_show_pip", 1);
  }
}

func_F0DF() {
  if(isDefined(level.var_F0DE)) {
    level.var_F0DE delete();
    setomnvar("ui_show_pip", 0);
  }
}
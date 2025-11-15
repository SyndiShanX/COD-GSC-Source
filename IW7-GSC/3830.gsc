/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3830.gsc
***************************************/

func_E3F4() {}

func_F0E1(var_00, var_01, var_02) {
  return;

  if(isDefined(level.func_F0DE))
    level.func_F0DE delete();

  if(!isDefined(var_01))
    var_01 = 65;

  if(!isDefined(var_02))
    var_02 = 1;

  var_00 = func_0EFB::func_7CBC("security_camera", "targetname", var_00);
  level.func_F0DE = var_00 scripts\engine\utility::spawn_tag_origin();
  scripts\sp\pip_util::func_CBB5(level.func_F0DE, "tag_origin", var_01);

  if(var_02)
    setomnvar("ui_show_pip", 1);
}

func_F0DF() {
  if(isDefined(level.func_F0DE)) {
    level.func_F0DE delete();
    setomnvar("ui_show_pip", 0);
  }
}
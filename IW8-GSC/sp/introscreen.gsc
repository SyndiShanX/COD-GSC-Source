/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\introscreen.gsc
***********************************************/

init_introscreen() {
  scripts\engine\utility::flag_init("introscreen_complete");
}

main() {
  precacheshader("black");
  setomnvar("ui_chyron_on", 0);
  thread main_thread();
}

main_thread() {
  scripts\engine\utility::flag_wait("start_is_set");
  var_0 = 0;

  if(!level_has_chyron())
    thread quick_fadeup();

  if(!scripts\engine\sp\utility::is_default_start() || var_0)
    scripts\engine\utility::delaythread(0.05, scripts\engine\utility::flag_set, "introscreen_complete");
  else {
    if(isDefined(level.introscreen) && isDefined(level.introscreen.customfunc)) {
      [[level.introscreen.customfunc]]();
      return;
    }

    scripts\engine\utility::delaythread(1, ::introscreen);
  }
}

level_has_chyron() {
  var_0 = tablelookup("sp/levels.csv", 1, level.script, 14);
  return var_0 != "";
}

quick_fadeup() {
  thread scripts\sp\hud_util::fade_out(0);
  wait 0.2;
  thread scripts\sp\hud_util::fade_in(0);
}

introscreen(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("introscreen_start_wait"))
    scripts\engine\utility::flag_wait("introscreen_start_wait");

  var_2 = scripts\sp\endmission::getlevelindex(level.script);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 = var_2 + 1;
  setomnvar("ui_chyron_level_index", var_2);
  setomnvar("ui_chyron_on", 1);
  setomnvar("ui_hide_dpad_hud", 1);
  wait 6;
  setomnvar("ui_hide_dpad_hud", 0);
  setomnvar("ui_chyron_on", 0);
  scripts\engine\utility::flag_set("introscreen_complete");
}
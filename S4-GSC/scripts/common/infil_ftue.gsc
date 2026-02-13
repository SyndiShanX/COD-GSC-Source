/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\infil_ftue.gsc
*************************************************/

init_infil_ftue() {
  if(!isDefined(level.base_warnings)) {
    level.base_warnings = spawnStruct();
  }
}

create_infil_ftue(var_0) {
  var_1 = self;

  if(isDefined(var_1.currentinfilftue)) {
    return;
  }
  var_1.currentinfilftue = var_0;
  var_2 = spawnStruct();
  var_1 _id_079F::_id_CF62("InfilFtue", "scripted_widget_infil_tutorial", var_2);
  var_1 _id_079F::scripted_widget_set_position("InfilFtue", 0, 0, 1, 1);
  var_3 = 1;

  if(isDefined(var_1.currentinfilftueindex)) {
    var_3 = var_1.currentinfilftueindex + 1;
  }

  var_4 = var_1.currentinfilftue + var_3;
  var_1 _id_079F::scripted_widget_set_param("InfilFtue", var_4);
  var_1.currentinfilftueindex = var_3;
  var_1 thread monitor_infil_ftue_end();
}

create_base_infil_ftue() {
  thread create_infil_ftue("base_infil_message_");
}

infil_ftue_next() {
  var_0 = self;

  if(!isDefined(var_0.currentinfilftue)) {
    return;
  }
  var_1 = 0;

  if(isDefined(var_0.currentinfilftueindex)) {
    var_1 = var_0.currentinfilftueindex + 1;
  }

  var_2 = var_0.currentinfilftue + var_1;
  var_0 _id_079F::scripted_widget_set_param("InfilFtue", var_2);
  var_0.currentinfilftueindex = var_1;
}

infil_ftue_end() {
  var_0 = self;
  var_0 _id_079F::_id_CF63("InfilFtue");
  var_0.currentinfilftueindex = undefined;
  var_0.currentinfilftue = undefined;
}

monitor_infil_ftue_end() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 waittill("prematch_waitForPlayers_Complete");
  var_0 infil_ftue_end();
}
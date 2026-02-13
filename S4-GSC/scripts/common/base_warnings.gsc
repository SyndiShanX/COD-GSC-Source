/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\common\base_warnings.gsc
*************************************************/

init_base_warnings() {
  if(!isDefined(level.base_warnings)) {
    level.base_warnings = spawnStruct();
  }
}

getclosestbaseid(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_A8E8) {
    var_6 = var_5.origin;
    var_3 = distancesquared(var_0.origin, var_6);

    if(!isDefined(var_1) || var_3 < var_2) {
      var_1 = var_5;
      var_2 = var_3;
    }
  }

  var_8 = (var_1._id_A908 + 1) * scripts\engine\utility::ter_op(var_0.team == var_1._id_ADAE, 1, -1);
  return var_8;
}

create_base_warnings() {
  var_0 = self;
  var_1 = _func_00BE("ui_match_over");

  if(var_1 || isDefined(var_0.base_warnings_created) && var_0.base_warnings_created == 1) {
    return;
  }
  var_2 = spawnStruct();
  var_0 _id_079F::_id_CF62("BaseWarnings", "scripted_widget_base_warning_message", var_2);
  var_0 _id_079F::scripted_widget_set_position("BaseWarnings", 0, 0, 1, 1);
  var_0.base_warnings_created = 1;
}

base_warnings_show(var_0) {
  var_1 = self;

  if(!isDefined(var_1.base_warnings_created)) {
    var_1 create_base_warnings();
  }

  var_1 _id_079F::scripted_widget_set_param("BaseWarnings", var_0);
  base_warnings_change_state("show_warning");
}

base_warning_hide() {
  var_0 = self;

  if(!isDefined(var_0.base_warnings_created)) {
    return;
  }
  var_0 base_warnings_change_state("hide_warning");
}

base_warnings_change_state(var_0) {
  var_1 = self;

  if(!isDefined(var_1.base_warnings_created)) {
    var_1 create_base_warnings();
  }

  if(!isDefined(var_1.active_base_warning_state) || var_0 != var_1.active_base_warning_state) {
    _id_079F::_id_CF66("BaseWarnings", var_0);
    var_1.active_base_warning_state = var_0;
  }
}

base_warnings_show_overtime(var_0) {
  var_1 = self;

  if(!isDefined(var_1.base_warnings_created)) {
    var_1 create_base_warnings();
  }

  var_1 _id_079F::scripted_widget_set_param("BaseWarnings", var_0);
  base_warnings_change_state("show_overtime");
  var_1 setclientomnvar("ui_base_objective_overtime_target", getclosestbaseid(var_1));
}

base_warnings_show_overtime_critical(var_0) {
  var_1 = self;

  if(!isDefined(var_1.base_warnings_created)) {
    var_1 create_base_warnings();
  }

  var_1 _id_079F::scripted_widget_set_param("BaseWarnings", var_0);
  base_warnings_change_state("show_overtime_critical");
  var_1 setclientomnvar("ui_base_objective_overtime_target", getclosestbaseid(var_1));
}

base_warning_hide_overtime() {
  var_0 = self;

  if(!isDefined(var_0.base_warnings_created)) {
    return;
  }
  var_0 base_warnings_change_state("hide_overtime");
  var_0 setclientomnvar("ui_base_objective_overtime_target", 0);
}

base_warnings_hide_all() {
  var_0 = self;

  if(!isDefined(var_0.base_warnings_created)) {
    return;
  }
  var_0 base_warnings_change_state("hide_all");
  var_0 setclientomnvar("ui_base_objective_overtime_target", 0);
}
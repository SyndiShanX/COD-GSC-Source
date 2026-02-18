/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\radiation_ui.gsc
***********************************************/

#using script_c8d806d2487b617;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\radiation;
#using scripts\core_common\system_shared;
#namespace radiation_ui;

function private autoexec __init__system__() {
  system::register(#"radiation_ui", &preinit, undefined, undefined, #"radiation");
}

function private preinit() {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  callback::on_spawned(&_on_player_spawned);
  clientfield::register_clientuimodel("hudItems.incursion.radiationDamage", 1, 5, "float");
  clientfield::register_clientuimodel("hudItems.incursion.radiationProtection", 1, 5, "float");
  clientfield::register_clientuimodel("hudItems.incursion.radiationHealth", 1, 5, "float");
  clientfield::register("toplayer", "radiation", 1, 10, "int");
}

function private _on_player_spawned() {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  self function_137e7814(self, 0);
}

function function_59621e3c(player, sickness) {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  radiationlevel = radiation::function_c9c6dda1(player);

  if(!isDefined(radiationlevel)) {
    assert(0);
    return;
  }

  var_2ba8769e = namespace_956bd4dd::function_6b384c0f(radiationlevel, sickness);

  if(!isDefined(var_2ba8769e)) {
    assert(0);
    return;
  }

  var_d4393988 = player clientfield::get_to_player("radiation");
  var_4e56b794 = var_d4393988 >> 3;
  var_4e56b794 |= 1 << var_2ba8769e;
  var_66bba724 = radiationlevel;
  var_d4393988 = var_4e56b794 << 3 | var_66bba724;
  player clientfield::set_to_player("radiation", var_d4393988);
}

function function_cca7424d(player, percentage) {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  percentage = max(min(5, percentage), 0);
  player clientfield::set_player_uimodel("hudItems.incursion.radiationProtection", percentage / 5);
}

function function_5cf1c0a(player, sickness) {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  radiationlevel = radiation::function_c9c6dda1(player);
  var_66bba724 = radiationlevel;

  if(!isDefined(radiationlevel)) {
    assert(0);
    return;
  }

  var_2ba8769e = namespace_956bd4dd::function_6b384c0f(radiationlevel, sickness);

  if(!isDefined(var_2ba8769e)) {
    assert(0);
    return;
  }

  var_d4393988 = player clientfield::get_to_player("radiation");
  var_4e56b794 = var_d4393988 >> 3;
  var_4e56b794 &= ~(1 << var_2ba8769e);
  var_d4393988 = var_4e56b794 << 3 | var_66bba724;
  player clientfield::set_to_player("radiation", var_d4393988);
}

function function_36a2c924(player, var_c49d0215) {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  player clientfield::set_player_uimodel("hudItems.incursion.radiationDamage", var_c49d0215);
}

function function_137e7814(player, radiationlevel) {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  var_d4393988 = player clientfield::get_to_player("radiation");
  assert(radiationlevel >= 0);
  assert(radiationlevel < pow(2, 3));
  var_842e1a12 = var_d4393988 >> 3 << 3 | radiationlevel & 8 - 1;
  player clientfield::set_to_player("radiation", var_842e1a12);
}

function function_835a6746(player, var_ac3a86ea) {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  player clientfield::set_player_uimodel("hudItems.incursion.radiationHealth", 1 - var_ac3a86ea);
}
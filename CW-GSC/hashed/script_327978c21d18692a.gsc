/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_327978c21d18692a.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace namespace_4914de7c;

function event_handler[level_init] main(eventstruct) {
  if(util::get_map_name() !== "wz_russia") {
    return;
  }

  callback::add_callback(#"objective_started", &function_386821d6);
  callback::add_callback(#"objective_ended", &function_b1eb7f05);
}

function function_386821d6(eventstruct) {
  if(level.contentmanager.activeobjective.content_script_name === "holdout") {
    clientfield::set("set_objective_fog", 2);
  }
}

function function_b1eb7f05(eventstruct) {
  clientfield::set("set_objective_fog", 0);
}
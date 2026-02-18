/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\load_shared.csc
***********************************************/

#using script_18b9d0e77614c97;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\delete;
#using scripts\core_common\dev_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace load;

function private autoexec __init__system__() {
  system::register(#"load", &preinit, undefined, undefined, undefined);
}

function main() {
  assert(isDefined(level.var_f18a6bd6));
  [[level.var_f18a6bd6]]();
}

function private preinit() {
  if(sessionmodeiscampaigngame()) {
    level.game_mode_suffix = "_cp";
  } else if(sessionmodeiszombiesgame()) {
    level.game_mode_suffix = "_zm";
  } else {
    level.game_mode_suffix = "_mp";
  }

  level thread first_frame();

  apply_mature_filter();
}

function first_frame() {
  level.first_frame = 1;
  waitframe(1);
  level.first_frame = undefined;
  level.var_22944a63 = 1;
}

function apply_mature_filter() {
  if(!util::is_mature()) {
    a_mature_models = findstaticmodelindexarray("mature_content");

    foreach(model in a_mature_models) {
      hidestaticmodel(model);
    }
  }
}

function art_review() {
  if(getdvarint(#"art_review", 0)) {
    level waittill(#"forever");
  }
}
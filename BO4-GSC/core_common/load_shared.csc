/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\load_shared.csc
***********************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\delete;
#include scripts\core_common\dev_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace load;

autoexec __init__system__() {
  system::register(#"load", &__init__, undefined, undefined);
}

__init__() {
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

first_frame() {
  level.first_frame = 1;
  waitframe(1);
  level.first_frame = undefined;
}

apply_mature_filter() {
  if(!util::is_mature()) {
    a_mature_models = findstaticmodelindexarray("mature_content");

    foreach(model in a_mature_models) {
      hidestaticmodel(model);
    }
  }
}

art_review() {
  if(getdvarint(#"art_review", 0)) {
    level waittill(#"forever");
  }
}
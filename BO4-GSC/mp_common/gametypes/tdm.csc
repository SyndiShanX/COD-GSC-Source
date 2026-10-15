/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\tdm.csc
***********************************************/

#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;
#include scripts\mp_common\gametypes\globallogic_score;

#namespace tdm;

event_handler[gametype_init] main(eventstruct) {
  if(util::function_8570168d()) {
    ct_tutorial_skirmish::init();
  }
}
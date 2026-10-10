/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\conf.csc
***********************************************/

#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;
#namespace conf;

event_handler[gametype_init] main(eventstruct) {
  if(util::function_8570168d()) {
    ct_tutorial_skirmish::init();
  }

  forcestreamxmodel(#"p8_dogtags_specialist_enemy_ajax", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_battery", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_crash", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_firebreak", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_nomad", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_prophet", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_recon", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_ruin", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_seraph", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_enemy_torque", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_ajax", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_battery", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_crash", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_firebreak", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_nomad", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_prophet", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_recon", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_ruin", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_seraph", 8, -1);
  forcestreamxmodel(#"p8_dogtags_specialist_friendly_torque", 8, -1);
}
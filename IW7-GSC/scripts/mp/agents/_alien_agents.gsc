/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\_alien_agents.gsc
***********************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }

  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  level thread scripts\mp\agents\_agent_common::init();
  level.var_10A2A = 0;
}
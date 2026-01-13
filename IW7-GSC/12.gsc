/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 12.gsc
**************************************/

main() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;
  level thread scripts\mp\agents\agent_common::init();
  level.var_10A2A = 0;
}
/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_scene.csc
*****************************************************/

#include scripts\core_common\scene_shared;

#namespace flowgraph_scene;

playscenefunc(x, e_entity, sb_name, b_thread) {
  target = e_entity;

  if(!isDefined(target)) {
    target = level;
  }

  if(b_thread) {
    target thread scene::play(sb_name);
    return;
  }

  target scene::play(sb_name);
}
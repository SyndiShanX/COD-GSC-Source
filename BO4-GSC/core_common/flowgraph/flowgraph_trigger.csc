/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_trigger.csc
*******************************************************/

#include scripts\core_common\flowgraph\flowgraph_core;

#namespace flowgraph_trigger;

ontriggerentered(x, e_trigger) {
  e_trigger endon(#"death");

  while(true) {
    waitresult = e_trigger waittill(#"trigger");
    e_entity = waitresult.activator;
    self flowgraph::kick(array(1, e_entity));
  }
}
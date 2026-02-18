/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_trigger.gsc
*******************************************************/

#using scripts\core_common\flowgraph\flowgraph_core;
#namespace flowgraph_trigger;

function ontriggerentered(x, e_trigger) {
  e_trigger endon(#"death");

  while(true) {
    waitresult = e_trigger waittill(#"trigger");
    self flowgraph::kick(array(1, waitresult.activator));
  }
}
/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\flowgraph\flowgraph_entity.gsc
******************************************************/

#using scripts\core_common\flowgraph\flowgraph_core;
#namespace flowgraph_entity;

function isentitydefinedfunc(e_entity) {
  return isDefined(e_entity);
}

function getentityorigin(e_entity) {
  return e_entity.origin;
}

function getentityangles(e_entity) {
  return e_entity.angles;
}

function onentityspawned(e_entity) {
  e_entity waittill(#"spawned");
  return true;
}

function onentitydamaged(x, e_entity) {
  e_entity endon(#"death");

  while(true) {
    waitresult = e_entity waittill(#"damage");
    self flowgraph::kick(array(1, e_entity, waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.model_name, waitresult.tag_name, waitresult.part_name, waitresult.weapon, waitresult.flags));
  }
}

function function_fd19ef53(e_entity, str_field) {
  return e_entity.(str_field);
}

function function_7e40ae2d(x, e_entity, str_field, var_value) {
  e_entity.(str_field) = var_value;
  return true;
}
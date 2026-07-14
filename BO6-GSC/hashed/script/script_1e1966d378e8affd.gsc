/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1e1966d378e8affd.gsc
*****************************************************/

#using scripts\common\values;
#namespace entity_mark;

function autoexec main() {
  val::register("entity_mark_equipment", 0, 0, "$self", &set_entity_mark_equipment, "$value");
  val::register("entity_mark_killstreak", 0, 0, "$self", &set_entity_mark_killstreak, "$value");
  val::register("entity_mark_air_killstreak", 0, 0, "$self", &set_entity_mark_air_killstreak, "$value");
  val::register("entity_mark_origin_equipment", 0, 0, "$self", &set_entity_mark_origin_equipment, "$value");
  val::register("entity_mark_origin_killstreak", 0, 0, "$self", &set_entity_mark_origin_killstreak, "$value");
  val::register("entity_mark_origin_air_killstreak", 0, 0, "$self", &function_a75da8698fd6154f, "$value");
}

function private set_entity_mark_equipment(radius = 0) {
  function_fc885458927cc4a4(#"equipment", radius, "entity_mark_equipment");
}

function private set_entity_mark_killstreak(radius = 0) {
  function_fc885458927cc4a4(#"killstreak", radius, "entity_mark_killstreak");
}

function private set_entity_mark_air_killstreak(radius = 0) {
  function_fc885458927cc4a4(#"air_killstreak", radius, "entity_mark_air_killstreak");
}

function private function_fc885458927cc4a4(mark_type, mark_distance, value_id) {
  assert(isPlayer(self));

  if(!isDefined(mark_type)) {
    return;
  }

  active_values = self.values[value_id];

  foreach(value in active_values) {
    if(value > mark_distance) {
      mark_distance = value;
    }
  }

  if(mark_distance <= 0) {
    self disableentitymarks(mark_type);
    return;
  }

  self enableentitymarks(mark_type, mark_distance);
}

function private set_entity_mark_origin_equipment(status = 0) {
  function_fe09f8f20a29f513(#"equipment", status, "entity_mark_origin_equipment");
}

function private set_entity_mark_origin_killstreak(status = 0) {
  function_fe09f8f20a29f513(#"killstreak", status, "entity_mark_origin_killstreak");
}

function private function_a75da8698fd6154f(status = 0) {
  function_fe09f8f20a29f513(#"air_killstreak", status, "entity_mark_origin_air_killstreak");
}

function private function_fe09f8f20a29f513(mark_type, var_1c139edaf43ca40d, value_id) {
  assert(isPlayer(self));

  if(!isDefined(mark_type)) {
    return;
  }

  if(!var_1c139edaf43ca40d) {
    active_values = self.values[value_id];

    foreach(value in active_values) {
      if(value) {
        var_1c139edaf43ca40d = 1;
        break;
      }
    }
  }

  origin = (0, 0, 0);

  if(var_1c139edaf43ca40d) {
    origin = self.origin;
  }

  self function_37097bbe1bca8f6c(mark_type, var_1c139edaf43ca40d);
  self function_3a4525281cf413a2(mark_type, origin);
}
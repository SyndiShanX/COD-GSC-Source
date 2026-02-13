/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\perks\zm_perks.gsc
*************************************************/

init() {
  level.zm_perks = [];
  scripts\cp\zombies\perks\zm_perk_hp::init();
  scripts\cp\zombies\perks\zm_perk_critical_damage::init();
  scripts\cp\zombies\perks\zm_perk_reload_speed::init();
  scripts\cp\zombies\perks\zm_perk_move_speed::init();
  scripts\cp\zombies\perks\zm_perk_hp_regen_speed::init();
}

register_perk(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.interaction_hint_string = var_1;
  var_5.interaction_hint_string_no_funds = var_2;
  var_5.perk_level_changed_callback = var_3;
  var_5.perk_minimap_icon = var_4;
  level.zm_perks[var_0] = var_5;
}

get_perk_level(var_0) {
  if(!isDefined(self._id_11086)) {
    return 0;
  }

  return scripts\cp\utility::_id_459B(self._id_11086[var_0], 0);
}

is_perk_max_level(var_0) {
  return get_perk_level(var_0) >= 4;
}

_id_6652(var_0) {
  if(is_perk_max_level(var_0)) {
    return 0;
  }

  var_1 = get_perk_level(var_0);

  if(var_1 == 0) {
    return 0;
  }

  return 2500 + 2500 * (var_1 - 1);
}

set_perk_level(var_0, var_1) {
  if(!isDefined(self._id_11086)) {
    self._id_11086 = [];
  }

  var_2 = get_perk_level(var_0);
  self._id_11086[var_0] = var_1;
  [[level.zm_perks[var_0].perk_level_changed_callback]](var_1, var_2);
  perk_level_changed(var_0, var_1, var_2);
}

increment_perk(var_0, var_1) {
  var_2 = get_perk_level(var_0);
  set_perk_level(var_0, var_2 + 1);
  _id_074E::_id_7DDF(self);

  if(istrue(var_1)) {
    _id_0741::_id_BD77("mt_purchase_perks");
  }

  if(is_perk_max_level(var_0)) {
    _id_070F::createmaxperksevent(self);
  }
}

decrement_perk(var_0) {
  var_1 = get_perk_level(var_0);

  if(var_1 > 0) {
    set_perk_level(var_0, var_1 - 1);
  }
}

remove_all_perks() {
  if(!isDefined(self._id_11086)) {
    return;
  }
  foreach(var_2, var_1 in self._id_11086) {
    if(get_perk_level(var_2) <= 0) {
      continue;
    }
    set_perk_level(var_2, 0);
  }
}

perk_level_changed(var_0, var_1, var_2) {
  if(!isDefined(self.purchased_zm_perks)) {
    self.purchased_zm_perks = [];
  }

  if(var_1 == 0) {
    self.purchased_zm_perks[var_0] = undefined;
  } else {
    self.purchased_zm_perks[var_0] = var_1;
  }

  _id_06FA::_id_FB31("ZM_THIRST_QUENCHER", self.purchased_zm_perks.size);
  perk_level_changed_notify_ui(var_0, var_1);
}

perk_level_changed_notify_ui(var_0, var_1) {
  self setclientomnvar("ui_" + var_0, var_1);
}

get_perk_max_level() {
  return 4;
}
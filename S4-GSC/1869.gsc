/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1869.gsc
*************************************************/

_id_C1EF() {
  level.perk_gesture_weapons["zm_perk_hp"] = "s4_zm_vm_ges_goblet_health";
  level.perk_gesture_weapons["zm_perk_critical_damage"] = "s4_zm_vm_ges_goblet_crit_damage";
  level.perk_gesture_weapons["zm_perk_reload_speed"] = "s4_zm_vm_ges_goblet_reload_speed";
  level.perk_gesture_weapons["zm_perk_move_speed"] = "s4_zm_vm_ges_goblet_move_speed";
  level.perk_gesture_weapons["zm_perk_hp_regen_speed"] = "s4_zm_vm_ges_goblet_health_regen";
  level.perk_machine_model["zm_perk_hp"] = "s4_zm_demonic_fountain_05";
  level.perk_machine_model["zm_perk_critical_damage"] = "s4_zm_demonic_fountain_04";
  level.perk_machine_model["zm_perk_reload_speed"] = "s4_zm_demonic_fountain_03";
  level.perk_machine_model["zm_perk_move_speed"] = "s4_zm_demonic_fountain_02";
  level.perk_machine_model["zm_perk_hp_regen_speed"] = "s4_zm_demonic_fountain_01";

  foreach(var_2, var_1 in level.zm_perks) {
    level._id_835D[var_2] = var_1.interaction_hint_string;
    level._id_835D[var_2 + "_no_funds"] = var_1.interaction_hint_string_no_funds;
    _id_0737::_id_C266(var_2, ::_id_7977, ::_id_0EC9, ::_id_8044, undefined, undefined, undefined, undefined, 1, var_1.perk_minimap_icon, undefined, !getdvarint("#x3dee089cb49164e4e", 0));
    level._id_8393[var_2]._id_3108 = ::can_use_perk_machine;
    level._id_8393[var_2]._id_3D92 = ::_id_6653;
    level._id_8393[var_2].hint_type_func = ::get_hint_type;
  }

  _id_0737::_id_C266("random_machine", undefined, undefined, ::init_random_machine_func);
}

init_random_machine_func(var_0) {
  if(!isDefined(level.random_perks)) {
    level.random_perks = [];

    foreach(var_3, var_2 in level.zm_perks) {
      level.random_perks[level.random_perks.size] = var_3;
    }
  }

  level.random_anim_perks = level.random_perks;

  foreach(var_5 in var_0) {
    var_5 thread init_random_perk_machine();
  }
}

shake_random_perk_machine() {
  var_0 = -2;
  var_1 = self.angles;
  self.angles = var_1 + (0, 0, var_0);
  var_2 = 5.0;
  var_0 = var_0 * 2;

  while(var_2 > 0) {
    var_0 = var_0 * -1;
    self rotateroll(var_0, 0.4, 0.1, 0.05);
    var_2 = var_2 - 0.4;
    wait 0.4;
  }

  self rotateto(var_1, 0.2);
  wait 0.25;
  self.angles = var_1;
}

init_random_perk_machine() {
  level endon("game_ended");
  self._id_4A88 = 1;
  self.model = getent(self._id_0481, "target");
  self.model setModel("s4_zm_broken_demonic_fountain_revive");
  scripts\engine\utility::_id_5C24(self._id_CD4B);
  var_0 = 0;
  var_1 = "";
  var_2 = 5.5;
  var_3 = self.model.origin;
  playFXOnTag(scripts\engine\utility::getfx("random_perk_start"), self.model, "tag_origin");
  self.model playSound("zmb_fountain_randomize");
  self.model moveto(var_3 + (0, 0, 16), var_2);
  self.model childthread shake_random_perk_machine();

  while(var_2 > 0) {
    var_0 = (var_0 + 1) % level.random_anim_perks.size;
    var_1 = level.random_anim_perks[var_0];
    self.model setModel(level.perk_machine_model[var_1]);
    playFXOnTag(scripts\engine\utility::getfx(var_1), self.model, "tag_origin");
    var_2 = var_2 - 0.2;
    wait 0.2;
    _func_012F(scripts\engine\utility::getfx(var_1), self.model, "tag_origin");
  }

  var_0 = randomint(level.random_perks.size);
  var_1 = level.random_perks[var_0];
  self._id_039B = var_1;
  level.random_perks = scripts\engine\utility::array_remove_index(level.random_perks, var_0);
  self.model setModel(level.perk_machine_model[var_1]);
  self.model moveto(var_3, 0.2);
  playFXOnTag(scripts\engine\utility::getfx(var_1), self.model, "tag_origin");
  wait 0.25;
  self.model.origin = var_3;
  self._id_4A88 = undefined;
  waitframe();
  var_4 = _func_03C5(level.perk_machine_model[var_1] + "_noentity", self.model.origin, self.model.angles);
  var_4 _meth_8746(self.model);
  thread _id_8043();
  _id_0737::add_interaction_marker_internal(self, var_1, level.zm_perks[var_1].perk_minimap_icon, 0);
}

_id_8044(var_0) {
  foreach(var_2 in var_0) {
    var_2 thread _id_8043();
  }
}

_id_8043() {
  self.perk_name = self._id_039B;
  self.machine_disabled = [];
  _id_0720::init_approach_dialogue(self.origin, "hdf", 1, 6400);
}

can_use_perk_machine(var_0, var_1) {
  if(!isDefined(var_0.perk_name)) {
    return 0;
  }

  return !var_1 scripts\cp\zombies\perks\zm_perks::is_perk_max_level(var_0.perk_name);
}

_id_6653(var_0, var_1, var_2) {
  if(!isDefined(var_0.perk_name) || is_machine_disabled(var_0, var_1)) {
    return 0;
  }

  return var_1 scripts\cp\zombies\perks\zm_perks::_id_6652(var_0.perk_name);
}

_id_7977(var_0, var_1) {
  if(!isDefined(var_0.perk_name) || is_machine_disabled(var_0, var_1)) {
    return "";
  }

  if(var_1 scripts\cp\zombies\perks\zm_perks::get_perk_level(var_0.perk_name) == 0) {
    switch (var_0.perk_name) {
      case "zm_perk_hp":
        return &"COOP_PERK_MACHINES/HP_FIRST_LEVEL";
      case "zm_perk_critical_damage":
        return &"COOP_PERK_MACHINES/CRITICAL_DAMAGE_FIRST_LEVEL";
      case "zm_perk_reload_speed":
        return &"COOP_PERK_MACHINES/RELOAD_SPEED_FIRST_LEVEL";
      case "zm_perk_move_speed":
        return &"COOP_PERK_MACHINES/MOVE_SPEED_FIRST_LEVEL";
      case "zm_perk_hp_regen_speed":
        return &"COOP_PERK_MACHINES/HP_REGEN_SPEED_FIRST_LEVEL";
    }
  }

  if(var_1 scripts\cp\zombies\perks\zm_perks::is_perk_max_level(var_0.perk_name)) {
    switch (var_0.perk_name) {
      case "zm_perk_hp":
        return &"COOP_PERK_MACHINES/HP_MAX_LEVEL";
      case "zm_perk_critical_damage":
        return &"COOP_PERK_MACHINES/CRITICAL_DAMAGE_MAX_LEVEL";
      case "zm_perk_reload_speed":
        return &"COOP_PERK_MACHINES/RELOAD_SPEED_MAX_LEVEL";
      case "zm_perk_move_speed":
        return &"COOP_PERK_MACHINES/MOVE_SPEED_MAX_LEVEL";
      case "zm_perk_hp_regen_speed":
        return &"COOP_PERK_MACHINES/HP_REGEN_SPEED_MAX_LEVEL";
    }
  }

  var_2 = var_1 scripts\cp\zombies\perks\zm_perks::_id_6652(var_0.perk_name);
  var_3 = var_1 scripts\cp\zombies\perks\zm_perks::get_perk_level(var_0.perk_name) + 1;

  switch (var_3) {
    case 2:
      var_4 = &"COOP_PERK_MACHINES/FOUNTAIN_TIER_2";
      break;
    case 3:
      var_4 = &"COOP_PERK_MACHINES/FOUNTAIN_TIER_3";
      break;
    case 4:
      var_4 = &"COOP_PERK_MACHINES/FOUNTAIN_TIER_4";
      break;
    default:
      var_4 = &"COOP_PERK_MACHINES/FOUNTAIN_TIER_5";
      break;
  }

  var_5 = scripts\engine\utility::ter_op(var_1 _id_074E::_id_B4C5(var_2), var_0.perk_name, var_0.perk_name + "_no_funds");
  var_1._id_8388 _meth_8557(int(var_2), var_4);
  return level._id_835D[var_5];
}

get_hint_type(var_0, var_1) {
  if(!isDefined(var_0.perk_name) || is_machine_disabled(var_0, var_1)) {
    return "HINT_NODISPLAY";
  }

  if(var_1 scripts\cp\zombies\perks\zm_perks::is_perk_max_level(var_0.perk_name)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

_id_0EC9(var_0, var_1) {
  var_1 endon("disconnect");

  if(is_machine_disabled(var_0, var_1)) {
    return;
  }
  set_machine_disabled(var_0, var_1, 1);
  var_1 playlocalsound("zmb_ui_purchase_accept");
  var_1 _id_0720::_id_BEC0("upgrade_perk", 1);
  var_1 _id_B29D(var_0.perk_name);
  var_1 scripts\cp\zombies\perks\zm_perks::increment_perk(var_0.perk_name, 1);
  update_perk_machine_activations(var_1, var_0.perk_name);
  _id_070F::createperkgainevent(var_1, var_0.perk_name);
  set_machine_disabled(var_0, var_1, 0);
}

_id_B29D(var_0) {
  var_1 = undefined;

  if(isDefined(level.perk_gesture_weapons[var_0])) {
    var_1 = level.perk_gesture_weapons[var_0];
  } else {
    return;
  }

  var_2 = self getcurrentweapon();

  if(var_2.type == "riotshield") {
    return;
  } else {
    scripts\cp\utility::playgestureweaponanim(var_1);
  }
}

is_machine_disabled(var_0, var_1) {
  return isDefined(var_0.machine_disabled) && istrue(var_0.machine_disabled[var_1.name]);
}

set_machine_disabled(var_0, var_1, var_2) {
  var_0.machine_disabled[var_1.name] = var_2;
  var_1 _id_0737::_id_C1A2();
}

update_perk_machine_activations(var_0, var_1) {
  if(!isDefined(var_0.perk_machine_activate_total)) {
    var_0.perk_machine_activate_total = [];
  }

  if(!isDefined(var_0.perk_machine_activate_total[var_1])) {
    var_0.perk_machine_activate_total[var_1] = 0;
  }

  var_0.perk_machine_activate_total[var_1]++;

  if(!isDefined(var_0.perk_machine_activate_time)) {
    var_0.perk_machine_activate_time = [];
  }

  var_0.perk_machine_activate_time[var_1] = gettime();
}

get_perk_machine_activations(var_0, var_1) {
  if(!isDefined(var_0.perk_machine_activate_total)) {
    return 0;
  }

  return scripts\cp\utility::_id_459B(var_0.perk_machine_activate_total[var_1], 0);
}

set_minimap_icon_persistent(var_0) {
  foreach(var_5, var_2 in level.zm_perks) {
    var_3 = scripts\engine\utility::getStructArray(var_5, "script_noteworthy");

    if(var_3.size == 0) {
      continue;
    }
    var_4 = _id_0737::instantiate_interaction_marker_params(var_3[0], var_5, var_2.perk_minimap_icon, var_0);
    _id_0987::_id_FB91(var_5, var_4);
  }
}
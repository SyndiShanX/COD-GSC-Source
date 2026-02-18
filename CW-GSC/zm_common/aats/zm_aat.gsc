/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\zm_aat.gsc
***********************************************/

#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\system_shared;
#using scripts\zm_common\aats\ammomods\ammomod_brainrot;
#using scripts\zm_common\aats\ammomods\ammomod_cryofreeze;
#using scripts\zm_common\aats\ammomods\ammomod_deadwire;
#using scripts\zm_common\aats\ammomods\ammomod_electriccherry;
#using scripts\zm_common\aats\ammomods\ammomod_napalmburst;
#using scripts\zm_common\aats\ammomods\ammomod_shatterblast;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_weapons;
#namespace zm_aat;

function private autoexec __init__system__() {
  system::register(#"zm_aat", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  level.var_9d1d502c = 1;
  level.aat_initializing = 1;
  level aat::function_571fceb("ammomod_brainrot", &ammomod_brainrot::init_brainrot);
  level aat::function_571fceb("ammomod_cryofreeze", &ammomod_cryofreeze::init_cryofreeze);
  level aat::function_571fceb("ammomod_deadwire", &ammomod_deadwire::init_deadwire);
  level aat::function_571fceb("ammomod_napalmburst", &ammomod_napalmburst::init_napalmburst);
  level aat::function_571fceb("ammomod_electriccherry", &ammomod_electriccherry::init_electriccherry);
  level aat::function_571fceb("ammomod_shatterblast", &ammomod_shatterblast::init_shatterblast);
  clientfield::register("toplayer", "" + # "hash_10f9eacd143d57ae", 6000, 1, "int");
  clientfield::register("toplayer", "ammomod_play_rob_tier", 15000, 3, "int");
  clientfield::register("toplayer", "ammomod_cryofreeze_idle", 1, 1, "int");
  clientfield::register("toplayer", "ammomod_napalmburst_idle", 1, 1, "int");
  clientfield::register("toplayer", "ammomod_brainrot_idle", 1, 1, "int");
  clientfield::register("toplayer", "ammomod_deadwire_idle", 1, 1, "int");
  callback::on_rappel(&function_1858cdf2);
  callback::function_c16ce2bc(&function_7e99ed03);
  level aat::function_2b3bcce0();
  level.var_a839c34d = &function_3ac3c47e;
  callback::on_connect(&_on_player_connect);
}

function private _on_player_connect() {
  self callback::add_callback("weapon_melee", &function_8cff617);
}

function private function_8cff617(params) {
  self thread function_134b933a();
}

function function_134b933a() {
  self notify("78f291d585d59a8f");
  self endon("78f291d585d59a8f");
  self endon(#"death");
  self function_bf51f3cc();

  while(self ismeleeing()) {
    waitframe(1);
  }

  self function_ec7953fa();
}

function function_1858cdf2() {
  self function_bf51f3cc();
}

function function_7e99ed03() {
  self function_ec7953fa();
}

function function_bf51f3cc() {
  clientfield::set_to_player("ammomod_play_rob_tier", 0);
  clientfield::set_to_player("ammomod_cryofreeze_idle", 0);
  clientfield::set_to_player("ammomod_napalmburst_idle", 0);
  clientfield::set_to_player("ammomod_brainrot_idle", 0);
  clientfield::set_to_player("ammomod_deadwire_idle", 0);
  clientfield::set_to_player("" + # "hash_10f9eacd143d57ae", 0);
}

function function_ec7953fa() {
  weapon = self getcurrentweapon();
  w_stat = zm_weapons::get_base_weapon(weapon);
  var_947d01ee = level.zombie_weapons[w_stat].weapon_classname;

  if(var_947d01ee === "melee" || weapon.name === # "special_ballisticknife_t9_dw" || weapon.name === # "special_ballisticknife_t9_dw_upgraded") {
    return;
  }

  item = item_inventory::function_230ceec4(weapon);

  if(isDefined(item.aat)) {
    aat_name = item.aat;
  }

  if(isDefined(aat_name)) {
    if(function_4b36d8a(aat_name)) {
      tier = function_4b36d8a(aat_name);
      clientfield::set_to_player("ammomod_play_rob_tier", tier);
      clientfield::set_to_player("ammomod_cryofreeze_idle", 1);
      clientfield::set_to_player("ammomod_napalmburst_idle", 0);
      clientfield::set_to_player("ammomod_brainrot_idle", 0);
      clientfield::set_to_player("ammomod_deadwire_idle", 0);
      clientfield::set_to_player("" + # "hash_10f9eacd143d57ae", 0);
    } else if(function_9022de1(aat_name)) {
      tier = function_9022de1(aat_name);
      clientfield::set_to_player("ammomod_play_rob_tier", tier);
      clientfield::set_to_player("ammomod_cryofreeze_idle", 0);
      clientfield::set_to_player("ammomod_napalmburst_idle", 1);
      clientfield::set_to_player("ammomod_brainrot_idle", 0);
      clientfield::set_to_player("ammomod_deadwire_idle", 0);
      clientfield::set_to_player("" + # "hash_10f9eacd143d57ae", 0);
    } else if(function_8bd7087d(aat_name)) {
      tier = function_8bd7087d(aat_name);
      clientfield::set_to_player("ammomod_play_rob_tier", tier);
      clientfield::set_to_player("ammomod_cryofreeze_idle", 0);
      clientfield::set_to_player("ammomod_napalmburst_idle", 0);
      clientfield::set_to_player("ammomod_brainrot_idle", 1);
      clientfield::set_to_player("ammomod_deadwire_idle", 0);
      clientfield::set_to_player("" + # "hash_10f9eacd143d57ae", 0);
    } else if(function_eb854b26(aat_name)) {
      tier = function_eb854b26(aat_name);
      clientfield::set_to_player("ammomod_play_rob_tier", tier);
      clientfield::set_to_player("ammomod_cryofreeze_idle", 0);
      clientfield::set_to_player("ammomod_napalmburst_idle", 0);
      clientfield::set_to_player("ammomod_brainrot_idle", 0);
      clientfield::set_to_player("ammomod_deadwire_idle", 1);
      clientfield::set_to_player("" + # "hash_10f9eacd143d57ae", 0);
    } else if(function_ef10106(aat_name)) {
      tier = function_ef10106(aat_name);
      clientfield::set_to_player("ammomod_play_rob_tier", tier);
      clientfield::set_to_player("ammomod_cryofreeze_idle", 0);
      clientfield::set_to_player("ammomod_napalmburst_idle", 0);
      clientfield::set_to_player("ammomod_brainrot_idle", 0);
      clientfield::set_to_player("ammomod_deadwire_idle", 0);
      clientfield::set_to_player("" + # "hash_10f9eacd143d57ae", 1);
    }

    return;
  }

  clientfield::set_to_player("ammomod_play_rob_tier", 0);
  clientfield::set_to_player("ammomod_cryofreeze_idle", 0);
  clientfield::set_to_player("ammomod_napalmburst_idle", 0);
  clientfield::set_to_player("ammomod_brainrot_idle", 0);
  clientfield::set_to_player("ammomod_deadwire_idle", 0);
  clientfield::set_to_player("" + # "hash_10f9eacd143d57ae", 0);
}

function function_4b36d8a(aat_name = "none") {
  switch (aat_name) {
    case # "ammomod_cryofreeze":
      return 1;
    case # "ammomod_cryofreeze_1":
      return 2;
    case # "ammomod_cryofreeze_2":
      return 3;
    case # "ammomod_cryofreeze_3":
      return 4;
    case # "ammomod_cryofreeze_4":
      return 5;
    case # "ammomod_cryofreeze_5":
      return 6;
  }

  return 0;
}

function function_9022de1(aat_name = "none") {
  switch (aat_name) {
    case # "ammomod_napalmburst":
      return 1;
    case # "ammomod_napalmburst_1":
      return 2;
    case # "ammomod_napalmburst_2":
      return 3;
    case # "ammomod_napalmburst_3":
      return 4;
    case # "ammomod_napalmburst_4":
      return 5;
    case # "ammomod_napalmburst_5":
      return 6;
  }

  return 0;
}

function function_8bd7087d(aat_name = "none") {
  switch (aat_name) {
    case # "ammomod_brainrot":
      return 1;
    case # "ammomod_brainrot_1":
      return 2;
    case # "ammomod_brainrot_2":
      return 3;
    case # "ammomod_brainrot_3":
      return 4;
    case # "ammomod_brainrot_4":
      return 5;
    case # "ammomod_brainrot_5":
      return 6;
  }

  return 0;
}

function function_eb854b26(aat_name = "none") {
  switch (aat_name) {
    case # "ammomod_deadwire":
      return 1;
    case # "ammomod_deadwire_1":
      return 2;
    case # "ammomod_deadwire_2":
      return 3;
    case # "ammomod_deadwire_3":
      return 4;
    case # "ammomod_deadwire_4":
      return 5;
    case # "ammomod_deadwire_5":
      return 6;
  }

  return 0;
}

function function_ef10106(aat_name = "none") {
  switch (aat_name) {
    case # "ammomod_shatterblast":
      return 1;
    case # "ammomod_shatterblast_1":
      return 2;
    case # "ammomod_shatterblast_2":
      return 3;
    case # "ammomod_shatterblast_3":
      return 4;
    case # "ammomod_shatterblast_4":
      return 5;
    case # "ammomod_shatterblast_5":
      return 6;
  }

  return 0;
}

function function_296cde87(aat_name) {
  if(isDefined(aat_name)) {
    switch (aat_name) {
      case # "ammomod_cryofreeze":
      case # "ammomod_cryofreeze_5":
      case # "ammomod_cryofreeze_4":
      case # "ammomod_cryofreeze_1":
      case # "ammomod_cryofreeze_3":
      case # "ammomod_cryofreeze_2":
        return "ammomod_cryofreeze";
      case # "ammomod_napalmburst":
      case # "ammomod_napalmburst_1":
      case # "ammomod_napalmburst_2":
      case # "ammomod_napalmburst_3":
      case # "ammomod_napalmburst_4":
      case # "ammomod_napalmburst_5":
        return "ammomod_napalmburst";
      case # "ammomod_brainrot_4":
      case # "ammomod_brainrot_5":
      case # "ammomod_brainrot_1":
      case # "ammomod_brainrot_2":
      case # "ammomod_brainrot_3":
      case # "ammomod_brainrot":
        return "ammomod_brainrot";
      case # "ammomod_deadwire_2":
      case # "ammomod_deadwire_3":
      case # "ammomod_deadwire_1":
      case # "ammomod_deadwire_4":
      case # "ammomod_deadwire_5":
      case # "ammomod_deadwire":
        return "ammomod_deadwire";
      case # "ammomod_shatterblast":
      case # "ammomod_shatterblast_4":
      case # "ammomod_shatterblast_5":
      case # "ammomod_shatterblast_1":
      case # "ammomod_shatterblast_2":
      case # "ammomod_shatterblast_3":
        return "ammomod_shatterblast";
      case # "ammomod_electriccherry":
        return "ammomod_electriccherry";
    }
  }

  return # "none";
}

function function_70c0e823(aat_name) {
  assert(isDefined(level.aat[aat_name]), "<dev string:x38>" + (ishash(aat_name) ? function_9e72a96(aat_name) : aat_name));
  return level.aat[aat_name].element;
}

function function_3ac3c47e(name, now, attacker) {
  if(is_true(level.var_12f54bf)) {
    return false;
  }

  n_multiplier = 1;

  if(isPlayer(attacker)) {
    if(attacker namespace_e86ffa8::function_cd6787b(2)) {
      n_multiplier = 0.8;
    }
  } else {
    return false;
  }

  if(isDefined(level.aat[name]) && isDefined(level.aat) && isDefined(self.aat_cooldown_start[name]) && isDefined(self.aat_cooldown_start) && isDefined(level.aat[name].cooldown_time_entity) && now <= self.aat_cooldown_start[name] + level.aat[name].cooldown_time_entity * n_multiplier) {
    return true;
  }

  if(isDefined(attacker.aat_cooldown_start) && isDefined(attacker.aat_cooldown_start[name]) && now <= attacker.aat_cooldown_start[name] + level.aat[name].cooldown_time_attacker * n_multiplier) {
    return true;
  }

  if(now <= level.aat[name].cooldown_time_global_start + level.aat[name].cooldown_time_global * n_multiplier) {
    return true;
  }

  return false;
}

function function_6b15092(aat_name, damage, victim) {
  switch (aat_name) {
    case # "ammomod_cryofreeze_5":
    case # "ammomod_cryofreeze_4":
    case # "ammomod_cryofreeze_1":
    case # "ammomod_cryofreeze_3":
    case # "ammomod_cryofreeze_2":
      if(is_true(victim.var_958cf9c5)) {
        damage += damage * 0.25;
      }

      break;
  }

  return damage;
}

function function_14ccd92a(str_name) {
  var_c07a4345 = getdvarint(#"hash_37466543dd4004e5", 0);

  if(var_c07a4345 > 0) {
    return var_c07a4345;
  }

  var_8c590502 = isDefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;

  if(var_8c590502 > 0) {
    return var_8c590502;
  }

  switch (str_name) {
    case # "ammomod_cryofreeze":
      return self zm_stats::function_12b698fa(#"hash_63114aea3939d941");
    case # "ammomod_napalmburst":
      return self zm_stats::function_12b698fa(#"ammomod_napalmburst_tier");
    case # "ammomod_brainrot":
      return self zm_stats::function_12b698fa(#"ammomod_brainrot_tier");
    case # "ammomod_deadwire":
      return self zm_stats::function_12b698fa(#"ammomod_deadwire_tier");
    case # "ammomod_shatterblast":
      return self zm_stats::function_12b698fa(#"hash_38f1aae51e2d5f58");
  }
}

function function_f4f4730f(str_name) {
  var_c1da9bb4 = str_name;
  tier = function_14ccd92a(str_name);

  switch (str_name) {
    case # "ammomod_brainrot":
      switch (tier) {
        case 1:
          var_c1da9bb4 = "ammomod_brainrot_1";
          break;
        case 2:
          var_c1da9bb4 = "ammomod_brainrot_2";
          break;
        case 3:
          var_c1da9bb4 = "ammomod_brainrot_3";
          break;
        case 4:
          var_c1da9bb4 = "ammomod_brainrot_4";
          break;
        case 5:
          var_c1da9bb4 = "ammomod_brainrot_5";
          break;
      }

      break;
    case # "ammomod_cryofreeze":
      switch (tier) {
        case 1:
          var_c1da9bb4 = "ammomod_cryofreeze_1";
          break;
        case 2:
          var_c1da9bb4 = "ammomod_cryofreeze_2";
          break;
        case 3:
          var_c1da9bb4 = "ammomod_cryofreeze_3";
          break;
        case 4:
          var_c1da9bb4 = "ammomod_cryofreeze_4";
          break;
        case 5:
          var_c1da9bb4 = "ammomod_cryofreeze_5";
          break;
      }

      break;
    case # "ammomod_deadwire":
      switch (tier) {
        case 1:
          var_c1da9bb4 = "ammomod_deadwire_1";
          break;
        case 2:
          var_c1da9bb4 = "ammomod_deadwire_2";
          break;
        case 3:
          var_c1da9bb4 = "ammomod_deadwire_3";
          break;
        case 4:
          var_c1da9bb4 = "ammomod_deadwire_4";
          break;
        case 5:
          var_c1da9bb4 = "ammomod_deadwire_5";
          break;
      }

      break;
    case # "ammomod_napalmburst":
      switch (tier) {
        case 1:
          var_c1da9bb4 = "ammomod_napalmburst_1";
          break;
        case 2:
          var_c1da9bb4 = "ammomod_napalmburst_2";
          break;
        case 3:
          var_c1da9bb4 = "ammomod_napalmburst_3";
          break;
        case 4:
          var_c1da9bb4 = "ammomod_napalmburst_4";
          break;
        case 5:
          var_c1da9bb4 = "ammomod_napalmburst_5";
          break;
      }

      break;
    case # "ammomod_shatterblast":
      switch (tier) {
        case 1:
          var_c1da9bb4 = "ammomod_shatterblast_1";
          break;
        case 2:
          var_c1da9bb4 = "ammomod_shatterblast_2";
          break;
        case 3:
          var_c1da9bb4 = "ammomod_shatterblast_3";
          break;
        case 4:
          var_c1da9bb4 = "ammomod_shatterblast_4";
          break;
        case 5:
          var_c1da9bb4 = "ammomod_shatterblast_5";
          break;
      }

      break;
  }

  return var_c1da9bb4;
}
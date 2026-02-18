/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_wallbuy.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_wallbuy;

function private autoexec __init__system__() {
  system::register(#"zm_wallbuy", &preinit, &postinit, undefined, #"zm");
}

function private preinit() {
  if(!is_true(getgametypesetting(#"zmwallbuysenabled"))) {
    return;
  }

  level flag::init("weapon_wallbuys_created");

  if(zm_utility::get_story() != 1 && !zm_utility::is_survival()) {
    level._effect[# "wallbuy_ambient_fx"] = "zombie/fx8_wallbuy_amb";
    level._effect[# "hash_6928ec90dff78e0c"] = "zombie/fx8_wallbuy_amb_reverse";
    level._effect[# "wallbuy_reveal_fx"] = "zombie/fx8_wallbuy_reveal";
    clientfield::register("scriptmover", "wallbuy_ambient_fx", 1, 3, "int", &function_51f5fb94, 0, 0);
    clientfield::register("scriptmover", "wallbuy_reveal_fx", 1, 1, "int", &function_5ed44212, 0, 0);
  }

  init();
}

function private postinit() {
  if(!getgametypesetting(#"zmwallbuysenabled")) {
    return;
  }
}

function init() {
  spawn_list = [];
  spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
  spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);

  if(is_true(level.use_autofill_wallbuy)) {
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
  }

  if(!is_true(level.headshots_only)) {
    spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
  }

  location = level.scr_zm_map_start_location;

  if((location == "default" || location == "") && isDefined(level.default_start_location)) {
    location = level.default_start_location;
  }

  match_string = level.scr_zm_ui_gametype;

  if("" != location) {
    match_string = match_string + "_" + location;
  }

  match_string_plus_space = " " + match_string;

  for(i = 0; i < spawnable_weapon_spawns.size; i++) {
    spawnable_weapon = spawnable_weapon_spawns[i];
    spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
    weapon_group = function_e2703c27(spawnable_weapon.weapon);

    if(weapon_group == # "weapon_pistol" && !getgametypesetting(#"zmweaponspistol") || weapon_group == # "weapon_cqb" && !getgametypesetting(#"zmweaponsshotgun") || weapon_group == # "weapon_smg" && !getgametypesetting(#"zmweaponssmg") || weapon_group == # "weapon_assault" && !getgametypesetting(#"zmweaponsar") || weapon_group == # "weapon_tactical" && !getgametypesetting(#"zmweaponstr") || weapon_group == # "weapon_lmg" && !getgametypesetting(#"zmweaponslmg") || weapon_group == # "weapon_sniper" && !getgametypesetting(#"zmweaponssniper") || weapon_group == # "weapon_knife" && !getgametypesetting(#"zmweaponsknife")) {
      continue;
    }

    if(isDefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && is_true(level.headshots_only)) {
      continue;
    }

    if(!isDefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "") {
      spawn_list[spawn_list.size] = spawnable_weapon;
      continue;
    }

    matches = strtok(spawnable_weapon.script_noteworthy, ",");

    for(j = 0; j < matches.size; j++) {
      if(matches[j] == match_string || matches[j] == match_string_plus_space) {
        spawn_list[spawn_list.size] = spawnable_weapon;
      }
    }
  }

  level._active_wallbuys = [];

  for(i = 0; i < spawn_list.size; i++) {
    spawn_list[i].script_label = spawn_list[i].zombie_weapon_upgrade + "_" + spawn_list[i].origin;
    level._active_wallbuys[spawn_list[i].script_label] = spawn_list[i];
    numbits = 2;

    if(isDefined(level._wallbuy_override_num_bits)) {
      numbits = level._wallbuy_override_num_bits;
    }

    clientfield::register("world", spawn_list[i].script_label, 1, numbits, "int", &wallbuy_callback, 0, 1);
    target_struct = struct::get(spawn_list[i].target, "targetname");

    if(spawn_list[i].targetname == "buildable_wallbuy") {
      bits = 4;

      if(isDefined(level.buildable_wallbuy_weapons)) {
        bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
      }

      clientfield::register("world", spawn_list[i].script_label + "_idx", 1, bits, "int", &wallbuy_callback_idx, 0, 1);
    }
  }

  level flag::set("weapon_wallbuys_created");
  callback::on_localclient_connect(&wallbuy_player_connect);
}

function is_wallbuy(w_to_check) {
  w_base = w_to_check.rootweapon;

  if(!isDefined(level._active_wallbuys)) {
    level._active_wallbuys = [];
  }

  foreach(s_wallbuy in level._active_wallbuys) {
    if(s_wallbuy.weapon == w_base) {
      return true;
    }
  }

  if(isDefined(level._additional_wallbuy_weapons)) {
    if(isinarray(level._additional_wallbuy_weapons, w_base)) {
      return true;
    }
  }

  return false;
}

function wallbuy_player_connect(localclientnum) {
  keys = getarraykeys(level._active_wallbuys);
  println("<dev string:x38>" + localclientnum);

  for(i = 0; i < keys.size; i++) {
    wallbuy = level._active_wallbuys[keys[i]];

    if(wallbuy.weapon == level.weaponnone) {
      assertmsg("<dev string:x51>" + wallbuy.zombie_weapon_upgrade);
      continue;
    }

    fx = level._effect[# "870mcs_zm_fx"];

    if(isDefined(level._effect[wallbuy.zombie_weapon_upgrade + "_fx"])) {
      fx = level._effect[wallbuy.zombie_weapon_upgrade + "_fx"];
    }

    target_struct = struct::get(wallbuy.target, "targetname");
    target_model = zm_utility::spawn_buildkit_weapon_model(localclientnum, wallbuy.weapon, undefined, target_struct.origin, target_struct.angles);
    target_model hide();
    target_model.parent_struct = target_struct;
    wallbuy.models[localclientnum] = target_model;
    wallbuy function_8f12abec(localclientnum);
  }

  var_63734e5 = struct::get_array("wallbuy_chalk", "content_key");

  foreach(wallbuy in var_63734e5) {
    if(wallbuy.script_noteworthy !== "random") {
      wallbuy function_8f12abec(localclientnum);
    }
  }
}

function private function_86b59fcc(chalk_model) {
  switch (chalk_model) {
    case # "p9_zm_chalk_buy_ar_accurate_t9_epic":
    case # "p9_zm_chalk_buy_ar_accurate_t9_ultra":
    case # "p9_zm_chalk_buy_ar_accurate_t9_uncommon":
    case # "p9_zm_chalk_buy_ar_accurate_t9_rare":
    case # "p9_zm_chalk_buy_ar_accurate_t9_legendary":
      type = "ar_accurate_t9";
      break;
    case # "p9_zm_chalk_buy_ar_fastfire_t9_ultra":
    case # "p9_zm_chalk_buy_ar_fastfire_t9_epic":
    case # "p9_zm_chalk_buy_ar_fastfire_t9_uncommon":
    case # "p9_zm_chalk_buy_ar_fastfire_t9_legendary":
    case # "p9_zm_chalk_buy_ar_fastfire_t9_rare":
      type = "ar_fastfire_t9";
      break;
    case # "p9_zm_chalk_buy_ar_mobility_t9_epic":
    case # "p9_zm_chalk_buy_ar_mobility_t9_uncommon":
    case # "p9_zm_chalk_buy_ar_mobility_t9_ultra":
    case # "p9_zm_chalk_buy_ar_mobility_t9_rare":
    case # "p9_zm_chalk_buy_ar_mobility_t9_legendary":
      type = "ar_mobility_t9";
      break;
    case # "p9_zm_chalk_buy_ar_slowfire_t9_legendary":
    case # "p9_zm_chalk_buy_ar_slowfire_t9_rare":
    case # "p9_zm_chalk_buy_ar_slowfire_t9_uncommon":
    case # "p9_zm_chalk_buy_ar_slowfire_t9_epic":
    case # "p9_zm_chalk_buy_ar_slowfire_t9_ultra":
      type = "ar_slowfire_t9";
      break;
    case # "p9_zm_chalk_buy_ar_standard_t9_ultra":
    case # "p9_zm_chalk_buy_ar_standard_t9_uncommon":
    case # "p9_zm_chalk_buy_ar_standard_t9_epic":
    case # "p9_zm_chalk_buy_ar_standard_t9_legendary":
    case # "p9_zm_chalk_buy_ar_standard_t9_rare":
      type = "ar_standard_t9";
      break;
    case # "p9_zm_chalk_buy_ar_damage_t9_epic":
    case # "p9_zm_chalk_buy_ar_damage_t9_rare":
    case # "p9_zm_chalk_buy_ar_damage_t9_ultra":
    case # "p9_zm_chalk_buy_ar_damage_t9_uncommon":
    case # "p9_zm_chalk_buy_ar_damage_t9_legendary":
      type = "ar_damage_t9";
      break;
    case # "p9_zm_chalk_buy_pistol_burst_t9_legendary":
    case # "p9_zm_chalk_buy_pistol_burst_t9_uncommon":
    case # "p9_zm_chalk_buy_pistol_burst_t9_epic":
    case # "p9_zm_chalk_buy_pistol_burst_t9_rare":
    case # "p9_zm_chalk_buy_pistol_burst_t9_ultra":
      type = "pistol_burst_t9";
      break;
    case # "p9_zm_chalk_buy_pistol_revolver_t9_epic":
    case # "p9_zm_chalk_buy_pistol_revolver_t9_legendary":
    case # "p9_zm_chalk_buy_pistol_revolver_t9_rare":
    case # "p9_zm_chalk_buy_pistol_revolver_t9_ultra":
    case # "p9_zm_chalk_buy_pistol_revolver_t9_uncommon":
      type = "pistol_revolver_t9";
      break;
    case # "hash_1695732d671ca57a":
    case # "hash_68c106d81829db40":
    case # "hash_35066567b4a46dad":
    case # "hash_1d2a087e061b932d":
    case # "hash_e9d49629e62c0d2":
      type = "pistol_standard_t9";
      break;
    case # "p9_zm_chalk_buy_shotgun_pump_t9_rare":
    case # "p9_zm_chalk_buy_shotgun_pump_t9_uncommon":
    case # "p9_zm_chalk_buy_shotgun_pump_t9_legendary":
    case # "p9_zm_chalk_buy_shotgun_pump_t9_epic":
    case # "p9_zm_chalk_buy_shotgun_pump_t9_ultra":
      type = "shotgun_pump_t9";
      break;
    case # "p9_zm_chalk_buy_shotgun_fullauto_t9_legendary":
    case # "p9_zm_chalk_buy_shotgun_fullauto_t9_epic":
    case # "p9_zm_chalk_buy_shotgun_fullauto_t9_rare":
    case # "p9_zm_chalk_buy_shotgun_fullauto_t9_ultra":
    case # "p9_zm_chalk_buy_shotgun_fullauto_t9_uncommon":
      type = "shotgun_fullauto_t9";
      break;
    case # "p9_zm_chalk_buy_shotgun_semiauto_t9_rare":
    case # "p9_zm_chalk_buy_shotgun_semiauto_t9_epic":
    case # "p9_zm_chalk_buy_shotgun_semiauto_t9_uncommon":
    case # "p9_zm_chalk_buy_shotgun_semiauto_t9_legendary":
    case # "p9_zm_chalk_buy_shotgun_semiauto_t9_ultra":
      type = "shotgun_semiauto_t9";
      break;
    case # "p9_zm_chalk_buy_smg_burst_t9_rare":
    case # "p9_zm_chalk_buy_smg_burst_t9_uncommon":
    case # "p9_zm_chalk_buy_smg_burst_t9_ultra":
    case # "p9_zm_chalk_buy_smg_burst_t9_legendary":
    case # "p9_zm_chalk_buy_smg_burst_t9_epic":
      type = "smg_burst_t9";
      break;
    case # "p9_zm_chalk_buy_smg_capacity_t9_uncommon":
    case # "p9_zm_chalk_buy_smg_capacity_t9_legendary":
    case # "p9_zm_chalk_buy_smg_capacity_t9_ultra":
    case # "p9_zm_chalk_buy_smg_capacity_t9_epic":
    case # "p9_zm_chalk_buy_smg_capacity_t9_rare":
      type = "smg_capacity_t9";
      break;
    case # "p9_zm_chalk_buy_smg_fastfire_t9_legendary":
    case # "p9_zm_chalk_buy_smg_fastfire_t9_rare":
    case # "p9_zm_chalk_buy_smg_fastfire_t9_epic":
    case # "p9_zm_chalk_buy_smg_fastfire_t9_ultra":
    case # "p9_zm_chalk_buy_smg_fastfire_t9_uncommon":
      type = "smg_fastfire_t9";
      break;
    case # "p9_zm_chalk_buy_smg_standard_t9_uncommon":
    case # "p9_zm_chalk_buy_smg_standard_t9_epic":
    case # "p9_zm_chalk_buy_smg_standard_t9_rare":
    case # "p9_zm_chalk_buy_smg_standard_t9_ultra":
    case # "p9_zm_chalk_buy_smg_standard_t9_legendary":
      type = "smg_standard_t9";
      break;
    case # "p9_zm_chalk_buy_smg_heavy_t9_epic":
    case # "p9_zm_chalk_buy_smg_heavy_t9_rare":
    case # "p9_zm_chalk_buy_smg_heavy_t9_legendary":
    case # "p9_zm_chalk_buy_smg_heavy_t9_uncommon":
    case # "p9_zm_chalk_buy_smg_heavy_t9_ultra":
      type = "smg_heavy_t9";
      break;
    case # "p9_zm_chalk_buy_smg_handling_t9_legendary":
    case # "p9_zm_chalk_buy_smg_handling_t9_epic":
    case # "p9_zm_chalk_buy_smg_handling_t9_ultra":
    case # "p9_zm_chalk_buy_smg_handling_t9_uncommon":
    case # "p9_zm_chalk_buy_smg_handling_t9_rare":
      type = "smg_handling_t9";
      break;
    case # "p9_zm_chalk_buy_sniper_powersemi_t9_uncommon":
    case # "p9_zm_chalk_buy_sniper_powersemi_t9_legendary":
    case # "p9_zm_chalk_buy_sniper_powersemi_t9_epic":
    case # "p9_zm_chalk_buy_sniper_powersemi_t9_ultra":
    case # "p9_zm_chalk_buy_sniper_powersemi_t9_rare":
      type = "sniper_powersemi_t9";
      break;
    case # "p9_zm_chalk_buy_sniper_quickscope_t9_legendary":
    case # "p9_zm_chalk_buy_sniper_quickscope_t9_epic":
    case # "p9_zm_chalk_buy_sniper_quickscope_t9_uncommon":
    case # "p9_zm_chalk_buy_sniper_quickscope_t9_ultra":
    case # "p9_zm_chalk_buy_sniper_quickscope_t9_rare":
      type = "sniper_quickscope_t9";
      break;
    case # "p9_zm_chalk_buy_sniper_standard_t9_epic":
    case # "p9_zm_chalk_buy_sniper_standard_t9_rare":
    case # "p9_zm_chalk_buy_sniper_standard_t9_ultra":
    case # "p9_zm_chalk_buy_sniper_standard_t9_uncommon":
    case # "p9_zm_chalk_buy_sniper_standard_t9_legendary":
      type = "sniper_standard_t9";
      break;
    case # "p9_zm_chalk_buy_tr_damagesemi_t9_epic":
    case # "p9_zm_chalk_buy_tr_damagesemi_t9_rare":
    case # "p9_zm_chalk_buy_tr_damagesemi_t9_ultra":
    case # "p9_zm_chalk_buy_tr_damagesemi_t9_legendary":
    case # "p9_zm_chalk_buy_tr_damagesemi_t9_uncommon":
      type = "tr_damagesemi_t9";
      break;
    case # "p9_zm_chalk_buy_tr_fullauto_t9_epic":
    case # "p9_zm_chalk_buy_tr_fullauto_t9_ultra":
    case # "p9_zm_chalk_buy_tr_fullauto_t9_rare":
    case # "p9_zm_chalk_buy_tr_fullauto_t9_uncommon":
    case # "p9_zm_chalk_buy_tr_fullauto_t9_legendary":
      type = "tr_fullauto_t9";
      break;
    case # "p9_zm_chalk_buy_tr_longburst_t9_legendary":
    case # "p9_zm_chalk_buy_tr_longburst_t9_rare":
    case # "p9_zm_chalk_buy_tr_longburst_t9_ultra":
    case # "p9_zm_chalk_buy_tr_longburst_t9_uncommon":
    case # "p9_zm_chalk_buy_tr_longburst_t9_epic":
      type = "tr_longburst_t9";
      break;
    case # "p9_zm_chalk_buy_tr_powerburst_t9_ultra":
    case # "p9_zm_chalk_buy_tr_powerburst_t9_epic":
    case # "p9_zm_chalk_buy_tr_powerburst_t9_legendary":
    case # "p9_zm_chalk_buy_tr_powerburst_t9_uncommon":
    case # "p9_zm_chalk_buy_tr_powerburst_t9_rare":
      type = "tr_powerburst_t9";
      break;
    case # "hash_27c596b133ab8f6":
    case # "hash_6600b1d26d7e6591":
    case # "hash_5c6dc71c4b620f8f":
    case # "hash_79507506b126feb7":
    case # "hash_7aac84dfbabbc8c4":
      type = "tr_precisionsemi_t9";
      break;
    case # "p9_zm_chalk_buy_lmg_accurate_t9_uncommon":
    case # "p9_zm_chalk_buy_lmg_accurate_t9_rare":
    case # "p9_zm_chalk_buy_lmg_accurate_t9_epic":
    case # "p9_zm_chalk_buy_lmg_accurate_t9_ultra":
    case # "p9_zm_chalk_buy_lmg_accurate_t9_legendary":
      type = "lmg_accurate_t9";
      break;
    case # "p9_zm_chalk_buy_lmg_light_t9_epic":
    case # "p9_zm_chalk_buy_lmg_light_t9_uncommon":
    case # "p9_zm_chalk_buy_lmg_light_t9_ultra":
    case # "p9_zm_chalk_buy_lmg_light_t9_legendary":
    case # "p9_zm_chalk_buy_lmg_light_t9_rare":
      type = "lmg_light_t9";
      break;
    case # "p9_zm_chalk_buy_lmg_slowfire_t9_ultra":
    case # "p9_zm_chalk_buy_lmg_slowfire_t9_uncommon":
    case # "p9_zm_chalk_buy_lmg_slowfire_t9_legendary":
    case # "p9_zm_chalk_buy_lmg_slowfire_t9_epic":
    case # "p9_zm_chalk_buy_lmg_slowfire_t9_rare":
      type = "lmg_slowfire_t9";
      break;
    default:
      println("<dev string:x70>" + chalk_model);
      type = 0;
      break;
  }

  return type;
}

function function_8f12abec(localclientnum) {
  if(isDefined(self.var_4972e475)) {
    return;
  }

  var_254469d1 = undefined;
  var_9ac76ba3 = 1;
  var_ddaf9f97 = undefined;
  weapon_type = isDefined(self.script_noteworthy) ? self.script_noteworthy : 0;

  if(weapon_type === "random" || weapon_type === 0) {
    weapon_type = function_86b59fcc(self.model);

    if(weapon_type === 0) {
      return;
    }
  }

  switch (weapon_type) {
    case # "ar_damage_t9":
      var_254469d1 = # "p9_zm_chalk_buy_ar_damage_t9_col";
      name_hash = # "hash_4d8398888735db8";
      break;
    case # "ar_fastfire_t9":
      var_254469d1 = # "p9_zm_chalk_buy_ar_fastfire_t9_col";
      name_hash = # "hash_717baccca4cf03d1";
      break;
    case # "ar_mobility_t9":
      var_254469d1 = # "p9_zm_chalk_buy_ar_mobility_t9_col";
      name_hash = # "hash_7bd4f5716e446b78";
      break;
    case # "ar_slowfire_t9":
      var_254469d1 = # "p9_zm_chalk_buy_ar_slowfire_t9_col";
      name_hash = # "hash_63e8969bae8c6414";
      break;
    case # "ar_standard_t9":
      var_254469d1 = # "p9_zm_chalk_buy_ar_standard_t9_col";
      name_hash = # "hash_67e1bb4dbdf802d8";
      break;
    case # "ar_accurate_t9":
      var_254469d1 = # "p9_zm_chalk_buy_ar_accurate_t9_col";
      name_hash = # "hash_4ea07dc5c94ab7f9";
      break;
    case # "pistol_burst_t9":
      var_254469d1 = # "p9_zm_chalk_buy_pistol_burst_t9_col";
      name_hash = # "hash_703b41f88b42f343";
      break;
    case # "pistol_revolver_t9":
      var_254469d1 = # "p9_zm_chalk_buy_pistol_revolver_t9_col";
      name_hash = # "hash_5091c4707ec6b942";
      break;
    case # "pistol_semiauto_t9":
      var_254469d1 = # "p9_zm_chalk_buy_pistol_semiauto_t9_col";
      name_hash = # "hash_2439a2ff4beb86b0";
      break;
    case # "shotgun_fullauto_t9":
      var_254469d1 = # "p9_zm_chalk_buy_shotgun_fullauto_t9_col";
      name_hash = # "hash_6df0ff702b2613be";
      break;
    case # "shotgun_semiauto_t9":
      var_254469d1 = # "p9_zm_chalk_buy_shotgun_semiauto_t9_col";
      name_hash = # "hash_6dcf0445e7c7257b";
      break;
    case # "shotgun_pump_t9":
      var_254469d1 = # "p9_zm_chalk_buy_shotgun_pump_t9_col";
      name_hash = # "hash_1631ac670b00dbfa";
      break;
    case # "smg_burst_t9":
      var_254469d1 = # "p9_zm_chalk_buy_smg_burst_t9_col";
      name_hash = # "hash_2c75287d04644bcb";
      break;
    case # "smg_capacity_t9":
      var_254469d1 = # "p9_zm_chalk_buy_smg_capacity_t9_col";
      name_hash = # "hash_423632bb711a406b";
      break;
    case # "smg_fastfire_t9":
      var_254469d1 = # "p9_zm_chalk_buy_smg_fastfire_t9_col";
      name_hash = # "hash_6def002686374645";
      break;
    case # "smg_handling_t9":
      var_254469d1 = # "p9_zm_chalk_buy_smg_handling_t9_col";
      name_hash = # "hash_410c31e1c403b298";
      break;
    case # "smg_heavy_t9":
      var_254469d1 = # "p9_zm_chalk_buy_smg_heavy_t9_col";
      name_hash = # "hash_42c7bf7c8a2eaad8";
      break;
    case # "smg_standard_t9":
      var_254469d1 = # "p9_zm_chalk_buy_smg_standard_t9_col";
      name_hash = # "hash_1895010b5180880c";
      break;
    case # "sniper_powersemi_t9":
      var_254469d1 = # "p9_zm_chalk_buy_sniper_powersemi_t9_col";
      name_hash = # "hash_1fed797b830c9f74";
      break;
    case # "sniper_quickscope_t9":
      var_254469d1 = # "p9_zm_chalk_buy_sniper_quickscope_t9_col";
      name_hash = # "hash_4cf07e30456d6a24";
      break;
    case # "sniper_standard_t9":
      var_254469d1 = # "p9_zm_chalk_buy_sniper_standard_t9_col";
      name_hash = # "hash_755d23459c2344cc";
      break;
    case # "tr_damagesemi_t9":
      var_254469d1 = # "p9_zm_chalk_buy_tr_damagesemi_t9_col";
      name_hash = # "hash_14e7b988f9459207";
      break;
    case # "tr_fullauto_t9":
      var_254469d1 = # "p9_zm_chalk_buy_tr_fullauto_t9_col";
      break;
    case # "tr_longburst_t9":
      var_254469d1 = # "p9_zm_chalk_buy_tr_longburst_t9_col";
      name_hash = # "hash_696d8b6b3a595612";
      break;
    case # "tr_powerburst_t9":
      var_254469d1 = # "p9_zm_chalk_buy_tr_powerburst_t9_col";
      name_hash = # "hash_7e1fb00fccc464b5";
      break;
    case # "tr_precisionsemi_t9":
      var_254469d1 = # "p9_zm_chalk_buy_tr_precisionsemi_t9_col";
      name_hash = # "hash_1a652a02b8f8208";
      break;
    case # "lmg_slowfire_t9":
      var_254469d1 = # "p9_zm_chalk_buy_lmg_slowfire_t9_col";
      name_hash = # "hash_5eca49abef9d89ed";
      break;
    case # "lmg_light_t9":
      var_254469d1 = # "p9_zm_chalk_buy_lmg_light_t9_col";
      name_hash = # "hash_115345b891f63176";
      break;
    case # "lmg_accurate_t9":
      var_254469d1 = # "p9_zm_chalk_buy_lmg_accurate_t9_col";
      name_hash = # "hash_7eb1b81fdce9b908";
      break;
    default:
      var_254469d1 = # "p9_zm_chalk_buy_ar_standard_t9_col";
      name_hash = # "hash_151d1b68c65d9d05";
      var_9ac76ba3 = 0;
      break;
  }

  var_4972e475 = util::spawn_model(localclientnum, var_254469d1, self.origin, self.angles);
  var_4972e475.var_fc558e74 = "wallbuy";

  if(var_9ac76ba3) {
    var_4972e475.var_ed875153 = name_hash;
  }

  var_4972e475 function_619a5c20();
  self.var_4972e475 = var_4972e475;
}

function wallbuy_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname) {
    while(!isDefined(level._active_wallbuys) || !isDefined(level._active_wallbuys[bwastimejump])) {
      waitframe(1);
    }
  }

  struct = level._active_wallbuys[bwastimejump];
  println("<dev string:xc7>" + bnewent);

  if(!isDefined(struct) || !isDefined(struct.models[bnewent]) || !isDefined(struct.models[bnewent].parent_struct)) {
    assertmsg("<dev string:xdc>" + bwastimejump);
    return;
  }

  switch (binitialsnap) {
    case 0:
      struct.models[bnewent].origin = struct.models[bnewent].parent_struct.origin;
      struct.models[bnewent].angles = struct.models[bnewent].parent_struct.angles;
      struct.models[bnewent] hide();
      break;
    case 1:
      if(fieldname) {
        if(!isDefined(struct.models)) {
          while(!isDefined(struct.models)) {
            waitframe(1);
          }

          while(!isDefined(struct.models[bnewent])) {
            waitframe(1);
          }
        }

        struct.models[bnewent] show();
        struct.models[bnewent].origin = struct.models[bnewent].parent_struct.origin;
      } else {
        waitframe(1);

        if(bnewent == 0) {
          playSound(0, #"zmb_weap_wall", struct.origin);
        }

        vec_offset = (0, 0, 0);

        if(isDefined(struct.models[bnewent].parent_struct.script_vector)) {
          vec_offset = struct.models[bnewent].parent_struct.script_vector;
        }

        struct.models[bnewent].origin = struct.models[bnewent].parent_struct.origin + anglestoright(struct.models[bnewent].angles + vec_offset) * 8;
        struct.models[bnewent] show();
        struct.models[bnewent] moveto(struct.models[bnewent].parent_struct.origin, 1);
      }

      break;
    case 2:
      if(isDefined(level.var_680d143d)) {
        struct.models[bnewent][[level.var_680d143d]]();
      }

      break;
  }
}

function wallbuy_callback_idx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  basefield = getsubstr(bwastimejump, 0, bwastimejump.size - 4);
  struct = level._active_wallbuys[basefield];

  if(fieldname == 0) {
    if(isDefined(struct.models[binitialsnap])) {
      struct.models[binitialsnap] hide();
    }

    return;
  }

  if(fieldname > 0) {
    weaponname = level.buildable_wallbuy_weapons[fieldname - 1];
    weapon = getweapon(weaponname);

    if(!isDefined(struct.models)) {
      struct.models = [];
    }

    if(!isDefined(struct.models[binitialsnap])) {
      target_struct = struct::get(struct.target, "targetname");
      model = undefined;

      if(isDefined(level.buildable_wallbuy_weapon_models[weaponname])) {
        model = level.buildable_wallbuy_weapon_models[weaponname];
      }

      angles = target_struct.angles;

      if(isDefined(level.var_d9d93dd9[weaponname])) {
        switch (level.var_d9d93dd9[weaponname]) {
          case 90:
            angles = vectortoangles(anglestoright(angles));
            break;
          case 180:
            angles = vectortoangles(anglesToForward(angles) * -1);
            break;
          case 270:
            angles = vectortoangles(anglestoright(angles) * -1);
            break;
        }
      }

      target_model = zm_utility::spawn_buildkit_weapon_model(binitialsnap, weapon, undefined, target_struct.origin, angles);
      target_model hide();
      target_model.parent_struct = target_struct;
      struct.models[binitialsnap] = target_model;

      if(isDefined(struct.fx[binitialsnap])) {
        stopfx(binitialsnap, struct.fx[binitialsnap]);
        struct.fx[binitialsnap] = undefined;
      }

      fx = level._effect[# "870mcs_zm_fx"];

      if(isDefined(level._effect[weaponname + "_fx"])) {
        fx = level._effect[weaponname + "_fx"];
      }

      struct.fx[binitialsnap] = playFX(binitialsnap, fx, struct.origin, anglesToForward(struct.angles), anglestoup(struct.angles), 0.1);
      level notify(#"wallbuy_updated");
    }
  }
}

function function_51f5fb94(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_11154944)) {
    stopfx(fieldname, self.var_11154944);
    self.var_11154944 = undefined;
  }

  if(bwastimejump) {
    switch (bwastimejump) {
      case 3:
        fx_to_play = # "hash_7df7fa64b947f085";
        break;
      case 4:
        fx_to_play = # "hash_1c2f33d581b291d2";
        break;
      case 5:
        fx_to_play = # "hash_19ef730d1f1a0f98";
        break;
      case 6:
        fx_to_play = # "hash_4c7d47bec47dda6c";
        break;
      case 7:
        fx_to_play = # "hash_2126649becba5c72";
        break;
    }

    if(isDefined(fx_to_play)) {
      self.var_11154944 = util::playFXOnTag(fieldname, fx_to_play, self, "tag_origin");
    }
  }
}

function function_5ed44212(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    util::playFXOnTag(fieldname, level._effect[# "wallbuy_reveal_fx"], self, "tag_fx_wall_buy");
  }
}
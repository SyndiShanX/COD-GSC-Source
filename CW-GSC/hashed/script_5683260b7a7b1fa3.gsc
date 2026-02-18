/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5683260b7a7b1fa3.gsc
***********************************************/

#using script_193d6fcd3b319d05;
#using script_340a2e805e35f7a2;
#using script_34e9dd62fc371077;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_e6fea84d;

function private autoexec __init__system__() {
  system::register(#"hash_1aecd78b7244ff81", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_1aecd78b7244ff81") {
    callback::add_callback(#"hash_7852c3cae4d4082a", &function_2d9abf0f);
    callback::add_callback(#"hash_75d9baf9eed8610b", &function_4e9f972a);
    callback::add_callback(#"hash_668017ea3d415b3b", &function_bc1832a2);
    level.var_b0f1ddbc = 1;
    clientfield::register_clientuimodel("hudItems.onslaught.lottoloadouts_rarity", 1, 2, "int");
    clientfield::register_clientuimodel("hudItems.onslaught.lottoloadouts_atttype", 1, 4, "int");

    util::add_debug_command("<dev string:x38>");
    util::add_debug_command("<dev string:xbf>");
    util::add_debug_command("<dev string:x141>");
    util::add_debug_command("<dev string:x1c5>");
    zm_devgui::add_custom_devgui_callback(&function_8df2fc68);
  }
}

function function_c090ac9c() {
  level flag::wait_till("rounds_started");
}

function private function_8df2fc68(cmd) {
  switch (cmd) {
    case # "hash_21b5fc9db9accec7":
      level thread function_4e9f972a(1);
      break;
    case # "hash_35aacbfc1cc6d1b0":
      level thread function_4e9f972a(3);
      break;
    case # "hash_25a40277684d32ee":
      level thread function_4e9f972a(6);
      break;
    case # "hash_26a37be826de2ef6":
      level thread function_4e9f972a(10);
      break;
  }
}

function function_2d9abf0f() {
  if(getdvarint(#"hash_226d79954e87df70", 0)) {
    foreach(player in getplayers()) {
      player zm_stats::increment_challenge_stat(#"hash_45b90af94bc28199");
    }
  }
}

function function_4e9f972a(var_4d2ad93e) {
  self notify("2617ebb80093e4be");
  self endon("2617ebb80093e4be");
  level flag::set(#"hash_554d70a6779336e1");

  foreach(player in getplayers()) {
    player playlocalsound(#"hash_17c36e83d2e0bc31");
    level.onslaught_hud onslaught_hud::function_71fd1345(player, 1);
    player clientfield::set_player_uimodel("hudItems.onslaught.lottoloadouts_rarity", function_4bac897(var_4d2ad93e));
  }

  objective_manager::stop_timer();
  objective_manager::start_timer(5);

  foreach(player in getplayers()) {
    player thread function_e3871553(var_4d2ad93e);
    player playlocalsound(#"hash_6ff6896abbcdb20e");
  }

  wait 1.5;
  level flag::clear(#"hash_554d70a6779336e1");
}

function function_bc1832a2() {
  level flag::set(#"hash_554d70a6779336e1");
}

function function_3e8a5580(str_notify) {
  self val::reset(#"lotto_loadouts", "disable_weapons");
  self val::reset("#lotto_loadouts", "disable_offhand_weapons");
}

function function_e3871553(var_4d2ad93e) {
  self endoncallback(&function_3e8a5580, #"death");

  if(!isDefined(self.var_5f08a4b1)) {
    self.var_5f08a4b1 = [];
  }

  var_2b930188 = isDefined(var_4d2ad93e) ? var_4d2ad93e : level.var_9b7bd0e8;
  self val::set("#lotto_loadouts", "disable_offhand_weapons", 1);

  while(self zm_utility::is_drinking() || self laststand::player_is_in_laststand() || is_true(self.var_12d4c9e8)) {
    waitframe(1);
  }

  self val::set(#"lotto_loadouts", "disable_weapons", 1);
  wait 0.25;

  foreach(weapon in self getweaponslistprimaries()) {
    if(weapon != level.weaponbasemeleeheld) {
      self zm_weapons::weapon_take(weapon);
    }
  }

  var_f64582b4 = getarraykeys(level.var_ec04a8a4);
  var_daa9a51c = [];

  foreach(weapon in level.var_cb55e72e) {
    if(!isDefined(var_daa9a51c)) {
      var_daa9a51c = [];
    } else if(!isarray(var_daa9a51c)) {
      var_daa9a51c = array(var_daa9a51c);
    }

    if(!isinarray(var_daa9a51c, weapon.name)) {
      var_daa9a51c[var_daa9a51c.size] = weapon.name;
    }
  }

  var_f64582b4 = array::exclude(var_f64582b4, var_daa9a51c);
  var_a9c2b895 = array::exclude(var_f64582b4, self.var_5f08a4b1);
  str_weapon_name = array::random(var_a9c2b895);

  if(!isDefined(str_weapon_name)) {
    str_weapon_name = array::random(var_f64582b4);
  }

  if(isDefined(str_weapon_name)) {
    if(!isDefined(self.var_5f08a4b1)) {
      self.var_5f08a4b1 = [];
    } else if(!isarray(self.var_5f08a4b1)) {
      self.var_5f08a4b1 = array(self.var_5f08a4b1);
    }

    if(!isinarray(self.var_5f08a4b1, str_weapon_name)) {
      self.var_5f08a4b1[self.var_5f08a4b1.size] = str_weapon_name;
    }
  } else {
    assertmsg("<dev string:x24e>");
    return;
  }

  switch (var_2b930188) {
    case 0:
    case 1:
    case 2:
      str_item_name = isDefined(level.var_29d88fe5[str_weapon_name][# "green"]) ? level.var_29d88fe5[str_weapon_name][# "green"] : level.var_ec04a8a4[str_weapon_name][# "green"];
      n_rarity = 0;
      var_27751b99 = 0;
      break;
    case 3:
    case 4:
      str_item_name = isDefined(level.var_29d88fe5[str_weapon_name][# "blue"]) ? level.var_29d88fe5[str_weapon_name][# "blue"] : level.var_ec04a8a4[str_weapon_name][# "blue"];
      n_rarity = 1;
      var_27751b99 = 1;
      break;
    case 5:
    case 6:
    case 7:
      str_item_name = isDefined(level.var_29d88fe5[str_weapon_name][# "purple"]) ? level.var_29d88fe5[str_weapon_name][# "purple"] : level.var_ec04a8a4[str_weapon_name][# "purple"];
      n_rarity = 2;
      var_27751b99 = 2;
      str_aat = array::random(["ammomod_brainrot", "ammomod_cryofreeze", "ammomod_deadwire", "ammomod_napalmburst", "ammomod_shatterblast"]);
      break;
    case 8:
    default:
      str_item_name = isDefined(level.var_29d88fe5[str_weapon_name][# "orange"]) ? level.var_29d88fe5[str_weapon_name][# "orange"] : level.var_ec04a8a4[str_weapon_name][# "orange"];
      n_rarity = 3;
      var_27751b99 = 3;
      str_aat = array::random(["ammomod_brainrot", "ammomod_cryofreeze", "ammomod_deadwire", "ammomod_napalmburst", "ammomod_shatterblast"]);
      break;
  }

  if(isDefined(str_item_name)) {
    point = function_4ba8fde(str_item_name);

    if(isDefined(point.itementry) && var_27751b99 > 0 && isDefined(level.var_fee1eaaf)) {
      random_attachments = point.itementry.random_attachments;
      var_d0e99a2a = point.itementry.var_d0e99a2a;
      var_8e212f46 = point.itementry.var_8e212f46;
      var_3e805062 = point.itementry.var_3e805062;
      new_item = [[level.var_fee1eaaf]](point);

      if(isDefined(new_item)) {
        point = new_item;
        point.paplv = var_27751b99;
        point.itementry.random_attachments = random_attachments;
        point.itementry.var_d0e99a2a = var_d0e99a2a;
        point.itementry.var_8e212f46 = var_8e212f46;
        point.itementry.var_3e805062 = var_3e805062;
      }
    }

    if(isDefined(point) && isDefined(str_aat)) {
      point.aat = str_aat;
    }

    if(isDefined(point.itementry.random_attachments)) {
      weapon = namespace_65181344::function_67456242(point.itementry);
      dropitem = item_drop::drop_item(0, weapon, 1, weapon.maxammo, point.id, self.origin, self.angles);
      dropitem.hidetime = 1;
      dropitem hide();
      self zm_weapons::function_98776900(dropitem, 0, 0, 1);
    } else {
      self zm_weapons::function_98776900(point, 0, 0, 1);
    }

    if(var_27751b99 > 0) {
      self item_inventory::function_d92c6b5b(self.currentweapon, 0, var_27751b99, point);
      maxammo = self.currentweapon.maxammo;
      maxclip = self getclipsize(self.currentweapon);
      self setweaponammoclip(self.currentweapon, maxclip);
      self setweaponammostock(self.currentweapon, maxammo);
      self notify(#"hash_75ec9942d2d5fd0f");
    }
  }

  if(isDefined(self.currentweapon)) {
    weapon = zm_weapons::get_base_weapon(self.currentweapon);

    if((weapon.weapclass === "melee" || is_true(weapon.issniperweapon) || weapon.weapclass === # "pistol") && (level.wave_number % 3 == 0 || level.wave_number >= 6) || is_true(weapon.islauncher) && var_27751b99 == 0 || weapon.name === # "special_crossbow_t9" && level.wave_number >= 3) {
      self thread zm_vo::function_8abe0568(#"game_over");
    }
  }

  wait 0.25;
  self val::reset(#"lotto_loadouts", "disable_weapons");
  self val::reset("#lotto_loadouts", "disable_offhand_weapons");

  if(isDefined(str_aat)) {
    self clientfield::set_player_uimodel("hudItems.onslaught.lottoloadouts_atttype", function_525c846d(str_aat));
  } else {
    self clientfield::set_player_uimodel("hudItems.onslaught.lottoloadouts_atttype", 0);
  }

  networkid = item_inventory::function_ec087745();

  if(networkid != 32767) {
    var_a781b3e1 = item_inventory::get_inventory_item(networkid);
    weapon = item_inventory::get_current_weapon();

    if(var_27751b99 > 0) {
      var_a781b3e1.paplv = var_27751b99;
    }

    var_a781b3e1.aat = str_aat;

    if(isDefined(var_a781b3e1.paplv)) {
      self clientfield::set_player_uimodel("pap_current", var_a781b3e1.paplv);
    } else {
      self clientfield::set_player_uimodel("pap_current", 0);
    }

    if(!zm_weapons::is_wonder_weapon(weapon)) {
      if(isDefined(var_a781b3e1.aat)) {
        if(weapon.weapclass != "melee" && weapon.name != # "special_ballisticknife_t9_dw" && weapon.name != # "special_ballisticknife_t9_dw_upgraded") {
          self function_bf3044dc(weapon, 1);
        }
      } else {
        self function_bf3044dc(weapon, 0);
      }
    }

    util::wait_network_frame();
    self zm_aat::function_ec7953fa();
  }

  level.onslaught_hud onslaught_hud::function_71fd1345(self, 2);
  self thread function_3c487e20();
}

function function_4bac897(var_4d2ad93e) {
  var_2b930188 = isDefined(var_4d2ad93e) ? var_4d2ad93e : level.var_9b7bd0e8;

  switch (var_2b930188) {
    case 0:
    case 1:
    case 2:
      n_rarity = 0;
      break;
    case 3:
    case 4:
      n_rarity = 1;
      break;
    case 5:
    case 6:
    case 7:
      n_rarity = 2;
      break;
    case 8:
    default:
      n_rarity = 3;
      break;
  }

  return n_rarity;
}

function function_525c846d(ammomod) {
  switch (ammomod) {
    case # "ammomod_brainrot":
      return 6;
    case # "ammomod_cryofreeze":
      return 1;
    case # "ammomod_deadwire":
      return 4;
    case # "ammomod_napalmburst":
      return 3;
    case # "ammomod_shatterblast":
      return 7;
  }

  return 0;
}

function function_3c487e20() {
  self endon(#"disconnect");
  wait 2;
  level.onslaught_hud onslaught_hud::function_71fd1345(self, 0);
}
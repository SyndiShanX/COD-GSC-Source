/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6bffae1b97f70547.gsc
*************************************************/

#using script_6bffae1b97f70547;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace ammo_mod;

function function_9623157b28098d1() {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  flag_init("ammo_mods_ready");
  level.ammo_mods = [];
  level.var_e090390c16d34b65 = [];
  level.var_a69c3b32e659291a = [];
  level.ammo_mods["none"] = spawnStruct();
  level.ammo_mods["none"].name = "none";
  level callback::add("player_connect", &function_66f877e287154069);
  level callback::add("player_weapon_change", &function_81650f24bdaebbf6);
  registersharedfunc("zombie", "ammo_mod_cooldown_init", &ammo_mod_cooldown_init);
  registersharedfunc("zombie", "has_ammo_mod", &has_ammo_mod);
  registersharedfunc("zombie", "get_ammo_mod_name", &get_ammo_mod_name);
  flag_set("ammo_mods_ready");

  level thread function_6f55a7e8fe9f4746();

  assertex(isDefined(level.gamemodebundle.var_4f59eded21c43059), "<dev string:x1c>");
  level.var_f1240a9ac4f65616 = getscriptbundle("ammomod:" + level.gamemodebundle.var_4f59eded21c43059);
}

function function_7f759db5de1b44b0(ammomodname, var_49acfea1433dc914, percentage, special_percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func, element, var_ba6c8434012a2654, var_f253123a174ef757) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  assert(isDefined(ammomodname), "<dev string:x70>");
  assert("<dev string:xa7>" != ammomodname, "<dev string:xaf>");
  assert(!isDefined(level.ammo_mods[ammomodname]), "<dev string:x11c>" + ammomodname + "<dev string:x149>");
  assert(isDefined(percentage), "<dev string:x16a>" + ammomodname + "<dev string:x18d>");
  assert(0 <= percentage && 1 > percentage, "<dev string:x16a>" + ammomodname + "<dev string:x1ae>");
  assert(isDefined(cooldown_time_entity), "<dev string:x16a>" + ammomodname + "<dev string:x1fa>");
  assert(0 <= cooldown_time_entity, "<dev string:x16a>" + ammomodname + "<dev string:x225>");
  assert(isDefined(cooldown_time_entity), "<dev string:x16a>" + ammomodname + "<dev string:x26b>");
  assert(0 <= cooldown_time_entity, "<dev string:x16a>" + ammomodname + "<dev string:x298>");
  assert(isDefined(cooldown_time_global), "<dev string:x16a>" + ammomodname + "<dev string:x2e0>");
  assert(0 <= cooldown_time_global, "<dev string:x16a>" + ammomodname + "<dev string:x30b>");
  assert(isDefined(occurs_on_death), "<dev string:x16a>" + ammomodname + "<dev string:x351>");
  assert(isDefined(result_func), "<dev string:x16a>" + ammomodname + "<dev string:x377>");
  assert(isDefined(damage_feedback_icon), "<dev string:x16a>" + ammomodname + "<dev string:x399>");
  assert(isstring(damage_feedback_icon), "<dev string:x16a>" + ammomodname + "<dev string:x3c4>");
  assert(isDefined(damage_feedback_sound), "<dev string:x16a>" + ammomodname + "<dev string:x3f0>");
  assert(isstring(damage_feedback_sound), "<dev string:x16a>" + ammomodname + "<dev string:x41c>");
  level.ammo_mods[ammomodname] = spawnStruct();
  level.ammo_mods[ammomodname].name = ammomodname;
  level.ammo_mods[ammomodname].id = var_49acfea1433dc914;
  level.ammo_mods[ammomodname].percentage = percentage;
  level.ammo_mods[ammomodname].special_percentage = special_percentage;
  level.ammo_mods[ammomodname].cooldown_time_entity = cooldown_time_entity;
  level.ammo_mods[ammomodname].cooldown_time_attacker = cooldown_time_attacker;
  level.ammo_mods[ammomodname].cooldown_time_global = cooldown_time_global;
  level.ammo_mods[ammomodname].cooldown_time_global_start = 0;
  level.ammo_mods[ammomodname].occurs_on_death = occurs_on_death;
  level.ammo_mods[ammomodname].result_func = result_func;
  level.ammo_mods[ammomodname].damage_feedback_icon = damage_feedback_icon;
  level.ammo_mods[ammomodname].damage_feedback_sound = damage_feedback_sound;
  level.ammo_mods[ammomodname].validation_func = validation_func;
  level.ammo_mods[ammomodname].immune_trigger = [];
  level.ammo_mods[ammomodname].immune_result_direct = [];
  level.ammo_mods[ammomodname].immune_result_indirect = [];
  level.ammo_mods[ammomodname].var_ba6c8434012a2654 = var_ba6c8434012a2654;
  level.ammo_mods[ammomodname].var_f253123a174ef757 = var_f253123a174ef757;
  level.ammo_mods[ammomodname].element = element;
  default_to(level.var_6bab2b30ec5ad7e1, []);
}

function private function_eba55122e11c8f35(weapon) {
  ammo_mod_name = undefined;
  altweaponoriginal = weapon;

  if(istrue(weapon.isalternate)) {
    altweaponoriginal = weapon getnoaltweapon();
  }

  foreach(var_e8b54d8a9deac064 in self.ammo_mod) {
    if(isDefined(var_e8b54d8a9deac064.weapon) && (var_e8b54d8a9deac064.weapon == weapon || var_e8b54d8a9deac064.weapon == altweaponoriginal)) {
      ammo_mod_name = var_e8b54d8a9deac064.ammomodname;
    }
  }

  return ammo_mod_name;
}

function function_352659ff5187d66d(damagestruct) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  if(!isPlayer(damagestruct.eattacker)) {
    return;
  }

  b_death = damagestruct.idamage > self.health;
  function_5a96f5a116c2b46e(b_death, damagestruct.einflictor, damagestruct.eattacker, damagestruct.idamage, damagestruct.idflags, damagestruct.smeansofdeath, damagestruct.sweapon, damagestruct.vpoint, damagestruct.vdir, damagestruct.shitloc, damagestruct.timeoffset, damagestruct.modelindex, damagestruct.partname, damagestruct.objweapon);
  ammo_mod_name = damagestruct.eattacker function_eba55122e11c8f35(damagestruct.sweapon);

  if(isDefined(ammo_mod_name) && b_death) {
    if(isDefined(level.ammo_mods[ammo_mod_name].var_ba6c8434012a2654) && b_death) {
      self thread[[level.ammo_mods[ammo_mod_name].var_ba6c8434012a2654]](damagestruct.idamage, damagestruct.eattacker, damagestruct.sweapon);
    }
  }
}

function function_5a96f5a116c2b46e(death, einflictor, eattacker, idamage, idflags, mod, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!function_efdce4b346c97324(eattacker) || !isDefined(eattacker.ammo_mod) || !isDefined(sweapon)) {
    return false;
  }

  if(mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT" && mod != "MOD_MELEE" && mod != "MOD_EXPLOSIVE_BULLET") {
    return false;
  }

  if(isDefined(level.var_fa6563c6f00a1ef1) && mod == "MOD_MELEE") {
    if(![[level.var_fa6563c6f00a1ef1]](sweapon)) {
      return false;
    }
  }

  if(isDefined(einflictor) && isPlayer(einflictor) && !isDefined(einflictor.ammo_mod)) {
    return false;
  }

  ammo_mod_name = eattacker function_eba55122e11c8f35(sweapon);

  if(!isDefined(ammo_mod_name)) {
    return false;
  }

  if(istrue(death) && !istrue(level.ammo_mods[ammo_mod_name].occurs_on_death)) {
    return false;
  }

  if(!isDefined(self.basearchetype)) {
    return false;
  }

  if(istrue(self.var_b9527ed408c69385)) {
    return false;
  }

  if(ent_flag("turned")) {
    return false;
  }

  if(istrue(level.ammo_mods[ammo_mod_name].immune_trigger[self.basearchetype])) {
    return false;
  }

  now = gettime() / 1000;

  if(isDefined(level.var_c51f26733d1d1d84)) {
    if(self[[level.var_c51f26733d1d1d84]](ammo_mod_name, now, eattacker)) {
      return false;
    }
  } else {
    var_d54958eb0301d644 = 0;

    if(getdvarint(@ "hash_52dae5d17f82ce51", 0)) {
      var_d54958eb0301d644 = 1;
    }

    if(!var_d54958eb0301d644 && isDefined(self.var_1b9bba89a566cb5f) && now <= self.var_1b9bba89a566cb5f[ammo_mod_name] + level.ammo_mods[ammo_mod_name].cooldown_time_entity) {
      return false;
    }

    if(!var_d54958eb0301d644 && now <= eattacker.var_1b9bba89a566cb5f[ammo_mod_name] + level.ammo_mods[ammo_mod_name].cooldown_time_attacker) {
      return false;
    }

    if(!var_d54958eb0301d644 && now <= level.ammo_mods[ammo_mod_name].cooldown_time_global_start + level.ammo_mods[ammo_mod_name].cooldown_time_global) {
      return false;
    }
  }

  if(isDefined(level.ammo_mods[ammo_mod_name].validation_func)) {
    if(![[level.ammo_mods[ammo_mod_name].validation_func]]()) {
      return false;
    }
  }

  success = 0;
  reroll_icon = undefined;
  var_207306346a548632 = 1;
  percentage = 0;

  if(self.aicategory == "elite" || self.aicategory == "boss") {
    var_207306346a548632 = 0;
    percentage = 0;
  } else if(self.aicategory == "special") {
    percentage = level.ammo_mods[ammo_mod_name].special_percentage;
  } else {
    percentage = level.ammo_mods[ammo_mod_name].percentage;
  }

  if(istrue(var_207306346a548632) && isDefined(level.var_a69c3b32e659291a[ammo_mod_name])) {
    if(level.var_a69c3b32e659291a[ammo_mod_name] < percentage) {
      percentage = level.var_a69c3b32e659291a[ammo_mod_name];
    }
  }

  if(istrue(var_207306346a548632) && isDefined(eattacker.var_73a10012ece4e6f5)) {
    percentage = eattacker.var_73a10012ece4e6f5;
  }

  var_742896d6094322ae = getdvarfloat(@ "hash_46a29d9f01b6b83d", 0);

  if(istrue(var_207306346a548632) && var_742896d6094322ae > 0) {
    percentage = var_742896d6094322ae;
  }

  if(percentage >= randomfloat(1)) {
    success = 1;
  }

  if(!success) {
    return false;
  }

  level.ammo_mods[ammo_mod_name].cooldown_time_global_start = now;
  eattacker.var_1b9bba89a566cb5f[ammo_mod_name] = now;
  self thread[[level.ammo_mods[ammo_mod_name].result_func]](death, eattacker, mod, sweapon, vpoint, shitloc, modelindex);
  sparams = spawnStruct();
  sparams.ammomod_name = ammo_mod_name;
  sparams.var_19560ec564499c6c = 0;
  sparams.zombie = self;

  if(isDefined(self.aicategory) && self.aicategory == "special") {
    sparams.var_19560ec564499c6c = 1;
  }

  eattacker callback::callback("ammomod_proc", sparams);

  if(isPlayer(eattacker)) {
    eattacker playlocalsound("uin_ammomod_proc_to_player_2d");
  }

  return true;
}

function add_ammo_mod_to_weapon(weapon, ammo_mod_name, var_3d61bd5c1fd55131) {
  if(!isDefined(var_3d61bd5c1fd55131)) {
    var_3d61bd5c1fd55131 = 1;
  }

  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  assert(isDefined(weapon), "<dev string:x449>");

  if(is_exempt_weapon(weapon)) {
    return;
  }

  if(isDefined(ammo_mod_name)) {
    assert(isDefined(level.ammo_mods[ammo_mod_name]), "<dev string:x487>" + ammo_mod_name + "<dev string:x495>");

    if(!has_ammo_mod(weapon)) {
      var_e8b54d8a9deac064 = spawnStruct();
      var_e8b54d8a9deac064.weapon = weapon getnoaltweapon();
      var_e8b54d8a9deac064.ammomodname = ammo_mod_name;
      self.ammo_mod = array_add(self.ammo_mod, var_e8b54d8a9deac064);
    } else {
      weapon = weapon getnoaltweapon();

      foreach(i, var_e8b54d8a9deac064 in self.ammo_mod) {
        if(var_e8b54d8a9deac064.weapon == weapon) {
          self.ammo_mod[i].ammomodname = ammo_mod_name;
        }
      }
    }

    params = spawnStruct();
    params.player = self;
    params.ammo_mod_name = ammo_mod_name;
    callback::callback("ammo_mod_equipped", params);

    if(var_3d61bd5c1fd55131) {
      function_f645fcd5bf711882();
    }

    self notify("ammo_mod_acquired");
  }
}

function function_b4da81e43557ada1(weapon, var_3d61bd5c1fd55131) {
  if(!isDefined(var_3d61bd5c1fd55131)) {
    var_3d61bd5c1fd55131 = 1;
  }

  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  assert(isDefined(weapon), "<dev string:x4af>");
  weapon = weapon getnoaltweapon();
  var_225a577cbeda65c2 = weapon.var_9d7facbe889e667c;

  foreach(i, var_e8b54d8a9deac064 in self.ammo_mod) {
    if(var_e8b54d8a9deac064.weapon == weapon) {
      self.ammo_mod = array_remove(self.ammo_mod, self.ammo_mod[i]);
    }
  }

  if(var_3d61bd5c1fd55131) {
    self setclientomnvar("ui_pap_current_ammomod", 0);
  }
}

function private function_81650f24bdaebbf6(params) {
  function_f645fcd5bf711882();
}

function private function_f645fcd5bf711882(weapon) {
  weapon = default_to(weapon, self getcurrentweapon());
  var_6e60559721c5abee = undefined;

  if(namespace_dc2e59577d3a271f::has_ammo_mod(weapon)) {
    var_6e60559721c5abee = namespace_dc2e59577d3a271f::get_ammo_mod_name(weapon);
  }

  if(isDefined(var_6e60559721c5abee)) {
    self setclientomnvar("ui_pap_current_ammomod", default_to(level.ammo_mods[var_6e60559721c5abee].id, 0));
    return;
  }

  self setclientomnvar("ui_pap_current_ammomod", 0);
}

function function_66f877e287154069(params) {
  self.ammo_mod = [];
  self.var_1b9bba89a566cb5f = [];

  foreach(key, v in level.ammo_mods) {
    self.var_1b9bba89a566cb5f[key] = 0;
  }
}

function function_efdce4b346c97324(entity) {
  if(isDefined(entity) && (isPlayer(entity) || istrue(entity.var_d419fad5b3e4517b))) {
    return true;
  }

  return false;
}

function is_exempt_weapon(weapon) {
  var_225a577cbeda65c2 = weapon.var_9d7facbe889e667c;

  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return false;
  }

  return isDefined(level.var_e090390c16d34b65[var_225a577cbeda65c2]);
}

function function_6a22621172a35366(weapon) {
  if(is_exempt_weapon(weapon)) {
    return 0;
  }

  if(istrue(iskillstreakweapon(weapon))) {
    return 0;
  }

  if(weapon.ismelee && isDefined(level.var_fa6563c6f00a1ef1)) {
    return [[level.var_fa6563c6f00a1ef1]](weapon);
  }

  if(istrue(iswonderweapon(weapon))) {
    return 0;
  }

  return 1;
}

function ammo_mod_cooldown_init() {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  self.var_1b9bba89a566cb5f = [];

  foreach(key, v in level.ammo_mods) {
    self.var_1b9bba89a566cb5f[key] = 0;
  }
}

function register_immunity(ammo_mod_name, archetype, immune_trigger, immune_result_direct, immune_result_indirect) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  assert(isDefined(ammo_mod_name), "<dev string:x4f2>");
  assert(isDefined(archetype), "<dev string:x529>");
  assert(isDefined(immune_trigger), "<dev string:x565>");
  assert(isDefined(immune_result_direct), "<dev string:x5a6>");
  assert(isDefined(immune_result_indirect), "<dev string:x5ed>");

  if(!isDefined(level.ammo_mods[ammo_mod_name].immune_trigger)) {
    level.ammo_mods[ammo_mod_name].immune_trigger = [];
  }

  if(!isDefined(level.ammo_mods[ammo_mod_name].immune_result_direct)) {
    level.ammo_mods[ammo_mod_name].immune_result_direct = [];
  }

  if(!isDefined(level.ammo_mods[ammo_mod_name].immune_result_indirect)) {
    level.ammo_mods[ammo_mod_name].immune_result_indirect = [];
  }

  level.ammo_mods[ammo_mod_name].immune_trigger[archetype] = immune_trigger;
  level.ammo_mods[ammo_mod_name].immune_result_direct[archetype] = immune_result_direct;
  level.ammo_mods[ammo_mod_name].immune_result_indirect[archetype] = immune_result_indirect;
}

function register_aat_exemption(weapon_root_name) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return;
  }

  level.var_e090390c16d34b65[weapon_root_name] = 1;
}

function has_ammo_mod(w_current) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return false;
  }

  if(isPlayer(self) && isDefined(self.ammo_mod) && isDefined(w_current)) {
    altweaponoriginal = w_current;

    if(istrue(w_current.isalternate)) {
      altweaponoriginal = w_current getnoaltweapon();
    }

    foreach(var_e8b54d8a9deac064 in self.ammo_mod) {
      if(isDefined(var_e8b54d8a9deac064.weapon) && (var_e8b54d8a9deac064.weapon == w_current || var_e8b54d8a9deac064.weapon == altweaponoriginal)) {
        return true;
      }
    }
  }

  return false;
}

function function_60ade27585bef67(w_current, ammo_mod_name) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return false;
  }

  altweaponoriginal = w_current;

  if(istrue(w_current.isalternate)) {
    altweaponoriginal = w_current getnoaltweapon();
  }

  foreach(var_e8b54d8a9deac064 in self.ammo_mod) {
    if(isDefined(var_e8b54d8a9deac064.weapon) && (var_e8b54d8a9deac064.weapon == w_current || var_e8b54d8a9deac064.weapon == altweaponoriginal) && var_e8b54d8a9deac064.ammomodname == ammo_mod_name) {
      return true;
    }
  }

  return false;
}

function function_10839073a33f4feb(w_current) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return int(0);
  }

  altweaponoriginal = w_current;

  if(istrue(w_current.isalternate)) {
    altweaponoriginal = w_current getnoaltweapon();
  }

  foreach(var_e8b54d8a9deac064 in self.ammo_mod) {
    if(isDefined(var_e8b54d8a9deac064.weapon) && (var_e8b54d8a9deac064.weapon == w_current || var_e8b54d8a9deac064.weapon == altweaponoriginal)) {
      ammomodname = var_e8b54d8a9deac064.ammomodname;
      return level.ammo_mods[ammomodname].id;
    }
  }

  return int(0);
}

function get_ammo_mod_name(w_current) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return "";
  }

  altweaponoriginal = w_current;

  if(istrue(w_current.isalternate)) {
    altweaponoriginal = w_current getnoaltweapon();
  }

  foreach(var_e8b54d8a9deac064 in self.ammo_mod) {
    if(isDefined(var_e8b54d8a9deac064.weapon) && (var_e8b54d8a9deac064.weapon == w_current || var_e8b54d8a9deac064.weapon == altweaponoriginal)) {
      return var_e8b54d8a9deac064.ammomodname;
    }
  }

  return "";
}

function function_bd988da177969d52(id) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return "";
  }

  if(!isDefined(id) || id == 0) {
    return "";
  }

  foreach(ammo_mod_name, ammo_mod in level.ammo_mods) {
    if(isDefined(ammo_mod.id) && ammo_mod.id == id) {
      return ammo_mod_name;
    }
  }

  return "";
}

function function_2373b67af9c1cfc0(name) {
  if(!istrue(level.var_bfa98c9dd6edb929)) {
    return 0;
  }

  if(!isDefined(name) || name == "") {
    return 0;
  }

  foreach(ammo_mod_name, ammo_mod in level.ammo_mods) {
    if(name == ammo_mod_name) {
      return ammo_mod.id;
    }
  }

  return 0;
}

function function_3275fc3cab7a7a32() {
  if(getdvarfloat(@ "hash_46a29d9f01b6b83d", 0) > 0) {
    setDvar(@ "hash_46a29d9f01b6b83d", 0);
  } else {
    setDvar(@ "hash_46a29d9f01b6b83d", 0.99);
  }

  iprintlnbold("<dev string:x636>" + getdvarfloat(@ "hash_46a29d9f01b6b83d", 0));
}

function function_b9f455f8500b002e() {
  if(getdvarint(@ "hash_52dae5d17f82ce51", 0)) {
    setDvar(@ "hash_52dae5d17f82ce51", 0);
  } else {
    setDvar(@ "hash_52dae5d17f82ce51", 1);
  }

  iprintlnbold("<dev string:x65c>" + getdvarint(@ "hash_52dae5d17f82ce51", 0));
}

function function_6f55a7e8fe9f4746() {
  function_6e7290c8ee4f558b("<dev string:x67d>");
  function_a9a864379a098ad6("<dev string:x68e>", "<dev string:x6ae>", &function_3275fc3cab7a7a32, 0);
  function_a9a864379a098ad6("<dev string:x6c6>", "<dev string:x6e3>", &function_b9f455f8500b002e, 0);
  function_fe953f000498048f();
}

# /
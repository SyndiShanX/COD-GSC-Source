/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_77cef444e824c23.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_38db8bccc9eb301f;
#using script_58682e6578ce0515;
#using script_63d03bd53d001217;
#using script_7edf952f8921aa6b;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\supers;
#using scripts\mp\utility\perk;
#namespace namespace_25dc7c066230bd21;

function init() {
  level._effect["frost_blast_aoe"] = loadfx("vfx/jup/ob/gameplay/zm_weapons/vfx_fld_frost_blast.vfx");
  scripts\mp\supers::function_53110a12409d01da("super_frost_blast", &function_f69fd160104f81cf, &function_e859744038631e6a, &function_c8f80bb08bb7e042, &function_de53ca4e5d02597e, undefined);
  function_b5e57408c7878df7(&on_ai_damage);

  function_6e7290c8ee4f558b("<dev string:x1c>");
  add_devgui_command("<dev string:x35>", "<dev string:x49>");
  add_devgui_command("<dev string:x79>", "<dev string:x90>");
  function_fe953f000498048f();

  supertable = getscriptbundle(level.supertable);

  foreach(super in supertable.super_list) {
    if(super.ref == "super_frost_blast") {
      level.var_f04301db8ca5ecfa["super_frost_blast"] = getscriptbundle("super:" + super.bundle);
      break;
    }
  }
}

function function_f69fd160104f81cf() {
  extra_charge = function_b2f0a842c1cbcb2b("extra_charge");

  if(!isint(extra_charge) || extra_charge <= 0) {
    return;
  }

  scripts\mp\utility\perk::giveperk("specialty_overcharge_field_upgrade");
}

function function_e859744038631e6a() {
  extra_charge = function_b2f0a842c1cbcb2b("extra_charge");

  if(!isint(extra_charge) || extra_charge <= 0) {
    return;
  }

  if(istrue(scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade"))) {
    scripts\mp\utility\perk::removeperk("specialty_overcharge_field_upgrade");
  }
}

function function_c8f80bb08bb7e042() {
  if(isDefined(level.var_f04301db8ca5ecfa["super_frost_blast"])) {
    var_6a7ac7ba29bd7091 = level.var_f04301db8ca5ecfa["super_frost_blast"].offhandweapon;
    deploysuccess = namespace_e23f629a8349dfaf::function_75abcff430ed00b7(var_6a7ac7ba29bd7091);

    if(istrue(deploysuccess)) {
      self setscriptablepartstate("wand_fx", "wand_on_frost_blast", 0);
      thread function_17aa7ae7adc05fea();
      return true;
    }
  }

  return false;
}

function function_de53ca4e5d02597e(fromdeath, attacker) {
  return false;
}

function function_17aa7ae7adc05fea() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  thread function_a09e395daeb68f70();
}

function private function_fdb8e2f52b8ca1d2(ent_area) {
  waittill_any_2("death_or_disconnect", "frost_blast_ended");

  if(isDefined(ent_area)) {
    ent_area.scriptable setscriptablepartstate("audio", "deactivate");
    waitframe();
    ent_area.scriptable freescriptable();
    ent_area function_ad9433aab9fcdf04(15, "death", &delete);
  }
}

function private function_f7c203e43c0e7737() {
  var_12baea29dc62088 = function_2e9e02e8bda61ef2();

  if(isDefined(var_12baea29dc62088) && isDefined(var_12baea29dc62088.groundent) && isDefined(var_12baea29dc62088.localorigin) && isDefined(var_12baea29dc62088.localangles)) {
    if(isDefined(self.linkedparent)) {
      self.linkedparent linkTo(var_12baea29dc62088.groundent, "", var_12baea29dc62088.localorigin, var_12baea29dc62088.localangles);
      return;
    }

    self linkTo(var_12baea29dc62088.groundent, "", var_12baea29dc62088.localorigin, var_12baea29dc62088.localangles);
  }
}

function function_a09e395daeb68f70() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  radius = function_b2f0a842c1cbcb2b("frost_blast_base_radius");
  damage_radius = function_b2f0a842c1cbcb2b("frost_blast_base_damage_radius");
  duration = 2;
  var_ec6719abe43520a3 = 1;
  self.var_d024694422cf29ac = 1;
  area = spawn_tag_origin(self.origin, anglesToForward(self.angles));
  area.remaining_durationms = duration * 1000;
  area.var_d099defdb7f04dd1 = gettime();
  area.var_44dbf7668c66e452 = [];
  area.owner = self;
  area.should_freeze = 1;
  var_4ec22504ea4836f0 = [];
  waitframe();
  thread damage_items(area);
  thread function_fdb8e2f52b8ca1d2(area);

  while(isDefined(area) && area.remaining_durationms > 0) {
    cur_time = gettime();
    delta_time = cur_time - area.var_d099defdb7f04dd1;
    area.var_d099defdb7f04dd1 = cur_time;
    area.remaining_durationms -= delta_time;
    var_59d8a38b844d1e11 = getaiarrayinradius(area.origin, radius);

    foreach(ai_data in area.var_44dbf7668c66e452) {
      ai = ai_data.ai;

      if(!array_contains(var_59d8a38b844d1e11, ai)) {
        if(isDefined(ai)) {
          ai function_71d2ef391b770c6e();
          ai function_b1ecaa5886f4bf2b(0);
          ai function_b7c09ba6ad057c79(0);
        }

        area.var_44dbf7668c66e452 = array_remove(area.var_44dbf7668c66e452, ai_data);
      }
    }

    foreach(current_ai in var_59d8a38b844d1e11) {
      if(!isalive(current_ai)) {
        continue;
      }

      if(isDefined(current_ai.team) && current_ai.team == self.team) {
        continue;
      }

      current_ai function_b7c09ba6ad057c79(1, self);
      var_4ec22504ea4836f0[current_ai getentitynumber()] = current_ai;

      if(!array_contains_key(area.var_44dbf7668c66e452, current_ai getentitynumber())) {
        if(var_ec6719abe43520a3) {
          if(distancesquared(current_ai.origin, area.origin) <= damage_radius * damage_radius) {
            current_ai function_fea8b8d300f71280(self);

            if(!isalive(current_ai)) {
              waitframe();
              continue;
            }
          }
        }

        var_a81fb1712ccea251 = spawnStruct();
        var_a81fb1712ccea251.ai = current_ai;
        var_a81fb1712ccea251.enter_time = cur_time;
        area.var_44dbf7668c66e452[current_ai getentitynumber()] = var_a81fb1712ccea251;
      }

      var_9f88f5c467218406 = area.var_44dbf7668c66e452[current_ai getentitynumber()];
      is_slowed = current_ai function_2fb9b4401941c475();

      if(!istrue(is_slowed) && !utility::is_equal(current_ai.type, "human")) {
        current_ai thread slow_ai(self, area.remaining_durationms / 1000);
        waitframe();
      }
    }

    var_ec6719abe43520a3 = 0;
    waitframe();
  }

  self.var_d024694422cf29ac = undefined;

  foreach(ai in var_4ec22504ea4836f0) {
    ai function_b7c09ba6ad057c79(0);
  }

  self notify("frost_blast_ended");
}

function private function_b7c09ba6ad057c79(b_enabled, e_attacker) {
  if(!isalive(self)) {
    return;
  }

  if(b_enabled) {
    self.var_fb0325e04fae6ce8 = e_attacker;

    if(!ent_flag_exist("frost_blast_active")) {
      ent_flag_init("frost_blast_active");
    }

    ent_flag_set("frost_blast_active");
    return;
  }

  self.var_fb0325e04fae6ce8 = undefined;

  if(ent_flag_exist("frost_blast_active")) {
    ent_flag_clear("frost_blast_active");
  }
}

function damage_items(area) {
  area show();
  area function_f7c203e43c0e7737();
  playFXOnTag(getfx("frost_blast_aoe"), area, "tag_origin");
  scriptable = spawnscriptable("super_frost_blast", area.origin);
  area.scriptable = scriptable;
  area.scriptable setscriptablepartstate("audio", "on");
  damage_radius = function_b2f0a842c1cbcb2b("frost_blast_base_radius");
  damage_amount = function_b2f0a842c1cbcb2b("frost_blast_base_damage_amount");
  self radiusdamage(self.origin, damage_radius, damage_amount, damage_amount, self, "MOD_EXPLOSIVE", undefined, 1);
}

function function_fea8b8d300f71280(attacker) {
  damage = 0;

  if(utility::is_equal(self.aicategory, "normal")) {
    damage = self.maxhealth;
    val::set("insta_kill", "kill_on_damage", 1);
    ent_flag_set("frost_killed");
  }

  if(damage == 0 && utility::is_equal(self.type, "human")) {
    if(isDefined(self.subclass) && issubstr(self.subclass, "warlord")) {
      var_43ea7ee7224a5f65 = namespace_53fc9ddbb516e6e1::function_560b2e700ce084a2(self.origin);
      damage_base = function_b2f0a842c1cbcb2b("frost_blast_base_damage_amount");
      damage = namespace_73f07f62510f0f5b::function_6f4c937aa843fac2(damage_base, var_43ea7ee7224a5f65, "frag_grenade", "elite", self.maxhealth);
    } else {
      damage = default_to(function_b2f0a842c1cbcb2b("frost_blast_ai_soldier_damage"), 0);
    }
  }

  if(damage == 0 && isDefined(self.aicategory)) {
    var_43ea7ee7224a5f65 = namespace_53fc9ddbb516e6e1::function_560b2e700ce084a2(self.origin);
    damage_base = function_b2f0a842c1cbcb2b("frost_blast_base_damage_amount");
    damage = namespace_73f07f62510f0f5b::function_6f4c937aa843fac2(damage_base, var_43ea7ee7224a5f65, "frag_grenade", self.aicategory, self.maxhealth);
  }

  sweapon = "none";

  if(isDefined(level.weaponmetadata[%"frost_blast"])) {
    if(!isDefined(level.weaponmetadata[%"frost_blast"].weaponobj)) {
      sweapon = makeweapon(level.weaponmetadata[%"frost_blast"].weapon);
      level.weaponmetadata[%"frost_blast"].weaponobj = sweapon;
    } else {
      sweapon = level.weaponmetadata[%"frost_blast"].weaponobj;
    }
  }

  if(damage >= self.health) {
    val::set("insta_kill", "kill_on_damage", 1);
    val::set("zm_allow_give_super_point", "allow_give_super_point", 0);
  }

  self dodamage(damage, self.origin, attacker, attacker, "MOD_ELEMENTAL_COLD", sweapon, "none", undefined, 65536);
}

function slow_ai(attacker, duration) {
  level endon("game_ended");
  self endon("death");

  if(duration <= 0.1) {
    return;
  }

  if(isDefined(self.aisettings) && istrue(self.aisettings.var_c9cbc4a3332e44c6)) {
    slow_percentage = function_b2f0a842c1cbcb2b("frost_blast_ai_slow_percentage");
    slow("frost_blast", slow_percentage, duration, attacker, &function_4f2ca6985698e967);

    if(self isscriptable() && self getscriptablehaspart("cryofreeze")) {
      self setscriptablepartstate("cryofreeze", "cryofreeze_on");
    }
  }
}

function function_b6c568cd7589eed8(str_label, str_tag) {
  level endon("game_ended");
  waitframe();
  fx = getfx(str_label);

  if(isalive(self)) {
    stopFXOnTag(fx, self, str_tag);
  }

  waitframe();

  if(isalive(self)) {
    playFXOnTag(fx, self, str_tag);
  }
}

function function_4f2ca6985698e967() {
  if(!isDefined(self)) {
    return;
  }

  if(self isscriptable() && self getscriptablehaspart("cryofreeze")) {
    self setscriptablepartstate("cryofreeze", "cryofreeze_shatter");
  }
}

function function_71d2ef391b770c6e() {
  if(function_2fb9b4401941c475()) {
    stop_slow("frost_blast");
  }
}

function function_2fb9b4401941c475() {
  return has_slow("frost_blast");
}

function on_ai_damage(params) {
  if(function_2fb9b4401941c475() && isDefined(params.eattacker)) {
    return function_136a046f13726c77(params.idamage, params.eattacker, params.smeansofdeath, params.shitloc, params.sweapon);
  }

  return -1;
}

function function_136a046f13726c77(idamage, eattacker, smeansofdeath, shitloc, sweapon) {
  idamage = 1.25 * idamage;
  return idamage;
}

function freeze_ai() {
  function_b1ecaa5886f4bf2b(1);
}

function function_6bcb782f3aa81d3c() {
  return true;
}

function function_3e8a1f7e5d6d1037() {
  return self.var_5ea46721aab49440;
}

function function_b1ecaa5886f4bf2b(b_value) {
  self.var_5ea46721aab49440 = b_value;
}

function function_b2f0a842c1cbcb2b(str_field) {
  return namespace_e23f629a8349dfaf::function_e7b6474ebd683537("super_frost_blast", str_field);
}
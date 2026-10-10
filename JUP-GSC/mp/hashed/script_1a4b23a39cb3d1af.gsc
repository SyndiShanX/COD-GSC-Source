/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1a4b23a39cb3d1af.gsc
*************************************************/

#using script_570cdb4e38f0225b;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_207a1269d42456e7;

function function_e21b71f0f396bb06() {
  callback::function_e7fddda1f0b46b5e(self.animsetname) callback::add("on_zombie_ai_damaged", &function_3b8499d83d52380e);
}

function function_688e6bf6742914c0() {
  function_b5e57408c7878df7(&function_fc8dd3d00ebca77b);
  self.var_ebd8439d96ec5a19 = 0;

  function_14b998b3a980d6fe();
}

function function_f042d86bacba063b() {
  if(isDefined(self.var_ebd8439d96ec5a19)) {
    var_179bf7d9d8c893b1 = gettime() - self.var_ebd8439d96ec5a19;
    var_f1f1c1b020be2bec = 5000;

    if(var_179bf7d9d8c893b1 < var_f1f1c1b020be2bec) {
      return true;
    }
  }

  return false;
}

function private function_3b8499d83d52380e(dmg_struct) {
  function_f9f0c202070afb63(dmg_struct);
}

function private function_f9f0c202070afb63(dmg_struct) {
  meansofdeath = dmg_struct.smeansofdeath;

  if(meansofdeath != "MOD_IMPACT") {
    return;
  }

  weapon_obj = dmg_struct.sweapon;

  if(!isDefined(weapon_obj) || weapon_obj.classname != "grenade") {
    function_2cb1324178d89dec("<dev string:x1c>");

    return;
  }

  var_357455e188e9e3b8 = dmg_struct.metabonename;

  if(!isDefined(var_357455e188e9e3b8)) {
    function_2cb1324178d89dec("<dev string:x2d>");

    return;
  }

  head_index = scripts\aitypes\zombie_abom\zombie_abom_metabones::function_e5db29e6fd6f6a88(var_357455e188e9e3b8);

  if(!isDefined(head_index)) {
    function_2cb1324178d89dec("<dev string:x40>" + var_357455e188e9e3b8);

    return;
  }

  head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(self, head_index);

  if(head_state != 2) {
    function_2cb1324178d89dec("<dev string:x5b>" + head_state);

    return;
  }

  if(function_f042d86bacba063b()) {
    function_2cb1324178d89dec("<dev string:x78>");

    return;
  }

  abom_swallow(dmg_struct, head_index);
}

function private abom_swallow(dmg_struct, head_index) {
  grenade = dmg_struct.einflictor;

  if(!isDefined(grenade)) {
    function_2cb1324178d89dec("<dev string:x9a>");

    return;
  }

  assert(isDefined(head_index));
  self.var_ebd8439d96ec5a19 = gettime();
  var_8fa538a1d4db452c = "swallow_in";

  if(isDefined(grenade.equipmentref)) {
    if(grenade.equipmentref == "equip_monkey_bomb") {
      self setscriptablepartstate("audio_monkeybomb_swallow", "on");
    }
  }

  scripts\asm\asm::asm_setstate(var_8fa538a1d4db452c);
  tag = "j_" + level.var_28e4ea2998e3439b[head_index];
  grenade linkTo(self, tag, (0, 0, 0), (0, 0, 0));
  grenade ent_flag_set("abom_swallowed");
  grenade.var_59d004d14d13b52b = head_index;
  grenade notify("missile_stuck");
  self.var_739e0470ae2ed359 = spawnStruct();
  self.var_739e0470ae2ed359.head_index = head_index;
  self.var_739e0470ae2ed359.eattacker = dmg_struct.eattacker;
  self.var_739e0470ae2ed359.time = gettime();
  wait 2;

  if(isDefined(self) && isDefined(grenade)) {
    grenade notify("detonateExplosive", self);
  }
}

function private function_fc8dd3d00ebca77b(dmg_struct) {
  var_c02b1f6c1721c844 = undefined;

  if(isDefined(dmg_struct.einflictor)) {
    if(!isDefined(dmg_struct.einflictor.var_59d004d14d13b52b) || !dmg_struct.einflictor ent_flag("abom_swallowed")) {
      return -1;
    }

    function_2cb1324178d89dec("<dev string:xbf>");

    var_c02b1f6c1721c844 = level.var_28e4ea2998e3439b[dmg_struct.einflictor.var_59d004d14d13b52b];
  } else {
    if(!isDefined(self.var_739e0470ae2ed359)) {
      return -1;
    }

    var_179bf7d9d8c893b1 = gettime() - self.var_739e0470ae2ed359.time;

    if(var_179bf7d9d8c893b1 > 3500) {
      function_2cb1324178d89dec("<dev string:xe8>" + var_179bf7d9d8c893b1);

      self.var_739e0470ae2ed359 = undefined;
      return -1;
    }

    if(self.var_739e0470ae2ed359.eattacker != dmg_struct.eattacker || dmg_struct.sweapon.classname != "grenade" || dmg_struct.smeansofdeath != "MOD_GRENADE_SPLASH" && dmg_struct.smeansofdeath != "MOD_EXPLOSIVE") {
      if(self.var_739e0470ae2ed359.eattacker != dmg_struct.eattacker) {
        function_2cb1324178d89dec("<dev string:x101>");
      } else {
        function_2cb1324178d89dec("<dev string:x12f>" + dmg_struct.sweapon.classname + "<dev string:x150>" + dmg_struct.smeansofdeath);
      }

      return -1;
    }

    var_c02b1f6c1721c844 = level.var_28e4ea2998e3439b[self.var_739e0470ae2ed359.head_index];

    if(!isDefined(dmg_struct.metabonename) || dmg_struct.metabonename != var_c02b1f6c1721c844) {
      tag = "j_" + var_c02b1f6c1721c844;
      tag_origin = self gettagorigin(tag);
      var_35391e999d5450b1 = lengthsquared(tag_origin - dmg_struct.vpoint);

      if(var_35391e999d5450b1 > 100) {
        function_2cb1324178d89dec("<dev string:x15a>" + var_c02b1f6c1721c844 + "<dev string:x187>" + sqrt(var_35391e999d5450b1));

        return -1;
      }
    }
  }

  self.var_739e0470ae2ed359 = undefined;

  if(!isDefined(var_c02b1f6c1721c844)) {
    return -1;
  }

  increased_damage = dmg_struct.idamage * 20;
  head_health = function_8c1f2f897dfe5982(var_c02b1f6c1721c844, "open");

  if(head_health <= 0) {
    return -1;
  }

  new_damage = max(increased_damage, dmg_struct.idamage);
  new_damage = min(new_damage, head_health);
  dmg_struct.damagemaxhealthcap = max(dmg_struct.damagemaxhealthcap, 1);
  dmg_struct.var_14edc6d1db3695bc = 1;
  function_dfd6d030978a7650(var_c02b1f6c1721c844, new_damage, "open", dmg_struct.eattacker, dmg_struct.einflictor);
  params = spawnStruct();
  params.incomingdamage = new_damage;
  callback::callback("abomination_swallow_grenade");
  return new_damage;
}

function private function_14b998b3a980d6fe() {
  function_6e7290c8ee4f558b("<dev string:x192>");
  function_a9a864379a098ad6("<dev string:x1b2>", "<dev string:x1c3>", &function_dce8d747fc906ca1);
  function_fe953f000498048f();
}

function private function_dce8d747fc906ca1() {
  function_2fb888667001fc39("<dev string:x1c3>", @ "hash_e6612e812211addd");
}

function private function_502e2f61c14586cc() {
  return getdvarint(@ "hash_e6612e812211addd", 0) > 0;
}

function private function_2cb1324178d89dec(text, pos) {
  if(function_502e2f61c14586cc()) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:x1d9>" + text, (1, 0, 0));
  }
}

# /
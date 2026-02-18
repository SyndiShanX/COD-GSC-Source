/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2467fe25132955b8.gsc
***********************************************/

#using script_24c32478acf44108;
#using script_72401f526ba71638;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_weapons;
#namespace namespace_cf2b4f27;

function private autoexec __init__system__() {
  system::register(#"hash_62a392bb15b68ccd", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("actor", "fx_frost_blast_clientfield", 1, 3, "int");
  clientfield::register("toplayer", "fx_frost_blast_1p_lv1_clientfield", 1, 1, "counter");
  clientfield::register("toplayer", "fx_frost_blast_1p_lv3_clientfield", 1, 1, "counter");
  namespace_1b527536::function_36e0540e(#"frost_blast", 1, 25, #"field_upgrade_frost_blast_item_sr");
  namespace_1b527536::function_36e0540e(#"frost_blast_1", 1, 25, #"field_upgrade_frost_blast_1_item_sr");
  namespace_1b527536::function_36e0540e(#"frost_blast_2", 2, 25, #"field_upgrade_frost_blast_2_item_sr");
  namespace_1b527536::function_36e0540e(#"frost_blast_3", 2, 25, #"field_upgrade_frost_blast_3_item_sr");
  namespace_1b527536::function_36e0540e(#"frost_blast_4", 3, 25, #"field_upgrade_frost_blast_4_item_sr");
  namespace_1b527536::function_36e0540e(#"frost_blast_5", 3, 25, #"field_upgrade_frost_blast_5_item_sr");
  namespace_1b527536::function_dbd391bf(#"frost_blast", &function_d7d09902);
  namespace_1b527536::function_dbd391bf(#"frost_blast_1", &function_de15a58c);
  namespace_1b527536::function_dbd391bf(#"frost_blast_2", &function_3542d3e9);
  namespace_1b527536::function_dbd391bf(#"frost_blast_3", &function_4980fc65);
  namespace_1b527536::function_dbd391bf(#"frost_blast_4", &function_353fd3e7);
  namespace_1b527536::function_dbd391bf(#"frost_blast_5", &function_4959fc1b);
  namespace_9ff9f642::register_slowdown(#"frost_blast", 0.5, 3);
  namespace_9ff9f642::register_slowdown(#"frost_blast_5", 0.1, 5);
  zombie_utility::add_zombie_gib_weapon_callback("frost_blast_5", &no_gib, &no_gib);
  frost_blast_0 = getweapon(#"frost_blast");
  frost_blast_1 = getweapon(#"frost_blast");
  frost_blast_2 = getweapon(#"frost_blast");
  frost_blast_3 = getweapon(#"frost_blast");
  frost_blast_4 = getweapon(#"frost_blast");
  frost_blast_5 = getweapon(#"frost_blast");
  zm_weapons::function_90953640(frost_blast_0, 3, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(frost_blast_1, 3, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(frost_blast_2, 3, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(frost_blast_3, 3, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(frost_blast_4, 3, float(function_60d95f53()) / 1000);
  zm_weapons::function_90953640(frost_blast_5, 3, float(function_60d95f53()) / 1000);
}

function no_gib(percent) {
  return false;
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function function_6736205c(var_638b775a = 0) {
  self endon(#"death", #"hash_34e7ef4239d22ba9");
  self namespace_1b527536::function_460882e2(1);
  var_189ef5f2 = spawnStruct();
  v_forward = vecscale(vectornormalize(anglesToForward(self.angles)), 64);
  var_189ef5f2.origin = self.origin;
  var_189ef5f2.origin += v_forward;

  switch (var_638b775a) {
    case 0:
      playFX("zm_weapons/fx9_fld_frost_blast_lvl0_3p", var_189ef5f2.origin);
      self clientfield::increment_to_player("fx_frost_blast_1p_lv1_clientfield", 1);
      break;
    case 1:
    case 2:
      playFX("zm_weapons/fx9_fld_frost_blast_lvl1_3p", var_189ef5f2.origin);
      self clientfield::increment_to_player("fx_frost_blast_1p_lv3_clientfield", 1);
      break;
    case 3:
    case 4:
    case 5:
      playFX("zm_weapons/fx9_fld_frost_blast_lvl3_3p", var_189ef5f2.origin);
      self clientfield::increment_to_player("fx_frost_blast_1p_lv3_clientfield", 1);
      break;
    default:
      playFX("zm_weapons/fx9_fld_frost_blast_lvl1_3p", var_189ef5f2.origin);
      self clientfield::increment_to_player("fx_frost_blast_1p_lv3_clientfield", 1);
      break;
  }

  radius = 128;
  duration = 3;
  damage = 100;
  weapon = getweapon(#"frost_blast");
  var_3decbda2 = # "hash_59f3861d4983e53";
  var_89ae2770 = # "hash_6096d838f90bc781";
  slowdown = # "frost_blast";

  switch (var_638b775a) {
    case 2:
      weapon = getweapon(#"frost_blast_2");
      var_89ae2770 = # "hash_6096d538f90bc268";
      break;
    case 3:
      weapon = getweapon(#"frost_blast_3");
      var_89ae2770 = # "hash_6096d638f90bc41b";
      radius = 256;
      damage = 200;
      break;
    case 4:
      weapon = getweapon(#"frost_blast_4");
      var_89ae2770 = # "hash_6096db38f90bcc9a";
      radius = 256;
      damage = 200;
      break;
    case 5:
      weapon = getweapon(#"frost_blast_5");
      var_89ae2770 = # "hash_6096dc38f90bce4d";
      radius = 256;
      damage = 200;
      duration = 5;
      slowdown = # "frost_blast_5";
      break;
  }

  self playSound(var_3decbda2);
  playsoundatposition(var_89ae2770, self.origin);
  nearbyzombies = getentitiesinradius(var_189ef5f2.origin, radius, 15);

  foreach(zombie in nearbyzombies) {
    if(isalive(zombie) && zombie.team === level.zombie_team) {
      zombie dodamage(damage, zombie.origin, self, undefined, undefined, "MOD_UNKNOWN", 0, weapon);
    }
  }

  if(var_638b775a >= 1) {
    self thread function_46f32076();
  }

  while(true) {
    nearbyzombies = getentitiesinradius(var_189ef5f2.origin, radius, 15);

    foreach(zombie in nearbyzombies) {
      if(isalive(zombie) && zombie.team === level.zombie_team && (zombie.zm_ai_category === # "normal" || zombie.archetype === # "zombie_dog" || var_638b775a >= 3 && zombie.zm_ai_category === # "special")) {
        var_2b1ad45b = 0;

        if(is_true(zombie.var_958cf9c5)) {
          continue;
        }

        if(zombie clientfield::get("fx_frost_blast_clientfield") == 0) {
          var_2b1ad45b = 1;
          zombie callback::callback(#"hash_7f690ab86160d4f6");
          util::wait_network_frame();

          if(!isalive(zombie)) {
            continue;
          }
        }

        if(var_638b775a == 0) {
          zombie clientfield::set("fx_frost_blast_clientfield", 1);
        } else {
          zombie clientfield::set("fx_frost_blast_clientfield", var_638b775a);
        }

        if(var_638b775a >= 3 && zombie.zm_ai_category === # "special" || zombie.zm_ai_category === # "normal" || zombie.archetype === # "zombie_dog") {
          self stats::function_622feb0d(#"frost_blast", #"hash_485f780a2a3da36a", 1);
          zombie thread namespace_9ff9f642::slowdown(slowdown);
          zombie.var_958cf9c5 = 1;
          zombie.var_991315b5 = self;

          if(var_638b775a == 5 && var_2b1ad45b) {
            if(zombie.zm_ai_category === # "normal" || zombie.archetype === # "zombie_dog") {
              zombie damagemode("next_shot_kills");
            }
          }

          zombie thread function_e287f5c2(duration, var_638b775a);
        }

        waitframe(1);
      }
    }

    if(var_638b775a >= 1) {
      wait 0.2;
      continue;
    }

    return;
  }
}

function function_46f32076() {
  self endon(#"death");
  self flag::increment("zm_field_upgrade_in_use");
  wait 3;
  self flag::decrement("zm_field_upgrade_in_use");
  self notify(#"hash_34e7ef4239d22ba9");
}

function function_d7d09902(params) {
  self thread function_6736205c(0);
}

function function_de15a58c(params) {
  self thread function_6736205c(1);
}

function function_3542d3e9(params) {
  self thread function_6736205c(2);
}

function function_4980fc65(params) {
  self thread function_6736205c(3);
}

function function_353fd3e7(params) {
  self thread function_6736205c(4);
}

function function_4959fc1b(params) {
  self thread function_6736205c(5);
}

function function_e287f5c2(duration, var_638b775a) {
  self notify(#"frost_blast");
  self endon(#"death", #"frost_blast");
  wait duration;
  self damagemode("normal");
  self.var_958cf9c5 = undefined;
  self.var_991315b5 = undefined;
  self clientfield::set("fx_frost_blast_clientfield", 0);
  self function_93765018(var_638b775a);
  self callback::callback(#"hash_40f6b51ae82126a4");
}

function function_93765018(var_638b775a) {
  if(var_638b775a < 5) {
    self namespace_9ff9f642::function_520f4da5(#"frost_blast");
    return;
  }

  self namespace_9ff9f642::function_520f4da5(#"frost_blast_5");
}
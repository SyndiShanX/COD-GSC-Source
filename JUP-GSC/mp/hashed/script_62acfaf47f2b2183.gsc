/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_62acfaf47f2b2183.gsc
*************************************************/

#using script_443d99fe707f1d9f;
#using script_5d813d45c6b1b1be;
#using script_6bffae1b97f70547;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace namespace_fcdac53e90589a14;

function private function_de6fbb5c61ddf941() {
  var_5179c48492d1d2c2 = function_441cb85860275371("mrp_respect_challenge");

  if(!isDefined(var_5179c48492d1d2c2)) {
    return;
  }

  grave_struct = getStruct(var_5179c48492d1d2c2.target, "targetname");
  assertex(isDefined(grave_struct), "<dev string:x1c>");
  function_efabc5ae0422de9e(var_5179c48492d1d2c2);
  grave = spawnscriptable("ob_jup_item_cache_mrp_grave", grave_struct.origin, grave_struct.angles);
  interact_location = grave_struct.origin + (0, 0, 45);
  var_c29b03c22a69b0b2 = scripts\cp_mp\interaction::register_interact(interact_location, 70, &function_e33d81ae37e492cf, &"JUP_OB_OBJECTIVES/MRP_PAY_RESPECTS");
  var_c29b03c22a69b0b2.grave_struct = grave_struct;

  sphere(var_c29b03c22a69b0b2.origin, 30, (0, 0, 1), 0, 1);
}

function function_e33d81ae37e492cf(player) {
  if(!isPlayer(player)) {
    return;
  }

  if(istrue(player.inlaststand) || !isalive(player)) {
    return;
  }

  if(player isreloading() || player isgestureplaying()) {
    return;
  }

  self disableplayeruse(player);
  rewards = player function_36f8ec252902994();
  time = randomfloatrange(3, 5);
  player playsoundtoplayer("evt_ob_mrpeeks_stinger_activation", player, player);
  wait time;
  namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652(player, self.grave_struct, rewards);
}

function private function_36f8ec252902994() {
  currentweapon = self getcurrentweapon();
  w_old = currentweapon getnoaltweapon();
  ammo_mod_name = function_d4897d4fc2a76e56(currentweapon);
  weapon_rarity = function_75e73212bbe447d9(w_old);
  var_594b03a08ee56c4a = get_pap_level(w_old);
  rewards = function_396c7e713507f53a(weapon_rarity, var_594b03a08ee56c4a, ammo_mod_name);

  if(!isweapon(w_old)) {
    return rewards;
  }

  if(weapon_rarity == 0 && var_594b03a08ee56c4a == 0 && ammo_mod_name == "") {
    return rewards;
  }

  if(weapon_rarity < 5) {
    function_3a0412b800f3331d(w_old, 0);
  }

  w_new = function_f2dd15c78e013bd7(w_old);
  var_7d014f270bcc9853 = undefined;

  if(w_old != currentweapon) {
    var_7d014f270bcc9853 = w_new getaltweapon();
  }

  self takeweapon(w_old);
  self giveweapon(w_new);
  self switchtoweapon(default_to(var_7d014f270bcc9853, w_new));
  ammo_mod::function_b4da81e43557ada1(w_new);
  return rewards;
}

function private function_396c7e713507f53a(rarity, pap_lvl, ammo_mod) {
  rewards = [];

  if(isDefined(rarity) && rarity > 0 && rarity < 5) {
    tool = function_bc2f4857c90f5344("ob_jup_respects_tool_" + rarity, 1);

    if(isDefined(tool)) {
      if(isarray(tool)) {
        foreach(t in tool) {
          rewards[rewards.size] = t;
        }
      } else {
        rewards[rewards.size] = tool;
      }
    }
  }

  if(isDefined(pap_lvl) && pap_lvl > 0) {
    crystal = function_bc2f4857c90f5344("ob_jup_respects_crystal_" + pap_lvl, 1);

    if(isDefined(crystal)) {
      if(isarray(crystal)) {
        foreach(c in crystal) {
          rewards[rewards.size] = c;
        }
      } else {
        rewards[rewards.size] = crystal;
      }
    }
  }

  if(isDefined(ammo_mod)) {
    switch (ammo_mod) {
      case #"hash_853faa00a9ff1020":
        mod = function_bc2f4857c90f5344("ob_jup_respects_mod_" + "brainrot", 1);
        break;
      case #"hash_fe0fd5228eda0f07":
        mod = function_bc2f4857c90f5344("ob_jup_respects_mod_" + "cryofreeze", 1);
        break;
      case #"hash_afaaf053b2461f8a":
        mod = function_bc2f4857c90f5344("ob_jup_respects_mod_" + "deadwire", 1);
        break;
      case #"hash_4f5cd54aaf7f106":
        mod = function_bc2f4857c90f5344("ob_jup_respects_mod_" + "napalmburst", 1);
        break;
      case #"hash_41d942d30dd3f804":
        mod = function_bc2f4857c90f5344("ob_jup_respects_mod_" + "shatterblast", 1);
        break;
      default:
        break;
    }

    if(isDefined(mod)) {
      if(isarray(mod)) {
        foreach(item in mod) {
          rewards[rewards.size] = item;
        }
      } else {
        rewards[rewards.size] = mod;
      }
    }
  }

  if(rewards.size == 0) {
    prize = function_bc2f4857c90f5344("ob_jup_respects_consolation", 1);

    if(isarray(prize)) {
      foreach(item in prize) {
        rewards[rewards.size] = item;
      }
    } else {
      rewards[rewards.size] = prize;
    }
  }

  return rewards;
}

function private function_f2dd15c78e013bd7(currentweapon) {
  reticle = getweaponreticlename(currentweapon);

  if(issubstr(reticle, "scope")) {
    reticle = int(removesubstr(reticle, "scope"));

    if(reticle == 0) {
      reticle = undefined;
    }
  } else if(!isDefined(scripts\cp_mp\weapon::getreticleindex(reticle))) {
    reticle = undefined;
  }

  variantid = getweaponvariantindex(currentweapon);
  stickers = [currentweapon.stickerslot0, currentweapon.stickerslot1, currentweapon.stickerslot2, currentweapon.stickerslot3, default_to(currentweapon.var_b39ac546cc8621f8, "none")];
  currentattachments = [];
  var_7c77dea6fd417685 = [];

  foreach(attachment in currentweapon.attachments) {
    if(issubstr(attachment, "_pack")) {
      var_7c77dea6fd417685[var_7c77dea6fd417685.size] = attachment;
      continue;
    }

    currentattachments[currentattachments.size] = attachment;
  }

  currentattachmentids = [];

  foreach(index, value in currentweapon.attachmentvarindices) {
    if(array_contains(var_7c77dea6fd417685, index)) {
      continue;
    }

    currentattachmentids[index] = value;
  }

  w_new = scripts\cp_mp\weapon::buildweapon(currentweapon.basename, currentattachments, "none", reticle, variantid, currentattachmentids, undefined, stickers);
  return w_new;
}
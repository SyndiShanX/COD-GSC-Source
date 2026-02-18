/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_725554a59d6a75b9.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapon_utils;
#namespace battlechatter;

function function_30146e82(player) {
  if(player hasperk(#"specialty_quieter")) {
    return;
  }

  playerbundle = function_58c93260(player);

  if(!isDefined(playerbundle)) {
    return;
  }

  voiceprefix = playerbundle.voiceprefix;
  dialogkey = playerbundle.var_b12a1e12;

  if(!isDefined(voiceprefix) || !isDefined(dialogkey)) {
    return;
  }

  dialogalias = voiceprefix + dialogkey;
  self.var_6765d33e = 1;
  self thread function_a48c33ff(dialogalias, 18);
}

function pain_vox(meansofdeath, weapon) {
  if(self.var_f16a71ae === 1) {
    return;
  }

  if(meansofdeath == "MOD_DEATH_CIRCLE" || meansofdeath == "MOD_BLED_OUT") {
    return;
  }

  playerbundle = function_58c93260(self, meansofdeath);

  if(!isDefined(playerbundle)) {
    return;
  }

  voiceprefix = playerbundle.voiceprefix;

  if(!isDefined(voiceprefix)) {
    return;
  }

  if(!dialog_chance("smallPainChance")) {
    return;
  }

  if(meansofdeath == "MOD_DROWN") {
    var_1f2bdb96 = playerbundle.exertpaindrowning;
    self.voxdrowning = 1;
  } else if(meansofdeath == "MOD_DOT" || meansofdeath == "MOD_DOT_SELF") {
    if(!isDefined(self.var_dbffaa32)) {
      return;
    }

    if(isDefined(weapon)) {
      if(weapon.doesfiredamage) {
        var_1f2bdb96 = playerbundle.var_c3b67de0;
      }
    } else {
      var_1f2bdb96 = playerbundle.exertpaindamagetick;
    }
  } else if(meansofdeath == "MOD_FALLING") {
    if(self hasperk(#"specialty_quieter")) {
      return;
    }

    var_1f2bdb96 = playerbundle.exertpainfalling;
  } else if(meansofdeath == "MOD_BURNED") {
    var_1f2bdb96 = playerbundle.var_c3b67de0;
  } else if(meansofdeath == "MOD_ELECTROCUTED") {
    var_1f2bdb96 = playerbundle.var_68bb30c1;
  } else if(self isplayerunderwater()) {
    var_1f2bdb96 = playerbundle.exertpainunderwater;
  } else if(weapons::ismeleemod(meansofdeath)) {
    var_1f2bdb96 = playerbundle.var_b801796c;
  } else if(weapons::isexplosivedamage(meansofdeath)) {
    if(weapon.name === # "eq_flash_grenade") {
      var_1f2bdb96 = playerbundle.var_af97fe9b;
    } else if(weapon.name === # "eq_slow_grenade") {
      var_1f2bdb96 = playerbundle.var_ed50283e;
    }
  } else if(weapons::isbulletdamage(meansofdeath)) {
    var_1f2bdb96 = playerbundle.var_a9b4dabb;
  } else {
    var_1f2bdb96 = playerbundle.exertpain;
  }

  if(!isDefined(var_1f2bdb96)) {
    return;
  }

  exertbuffer = mpdialog_value("playerExertBuffer", 0);

  if(isDefined(self.var_1ba38d8b) && gettime() - self.var_1ba38d8b < int(exertbuffer * 1000)) {
    return;
  }

  dialogkey = voiceprefix + var_1f2bdb96;
  self thread function_a48c33ff(dialogkey, 30, exertbuffer);
  self.var_6765d33e = 1;
  self.var_1ba38d8b = gettime();
}

function function_78c16252() {
  playerbundle = function_58c93260(self);

  if(!isDefined(playerbundle)) {
    return;
  }

  voiceprefix = playerbundle.voiceprefix;

  if(!isDefined(voiceprefix)) {
    return;
  }

  var_1f2bdb96 = playerbundle.exertfullyhealedbreath;

  if(isDefined(var_1f2bdb96)) {
    dialogkey = voiceprefix + var_1f2bdb96;
    self thread function_a48c33ff(dialogkey, 16);
  }
}

function play_death_vox(body, attacker, weapon, meansofdeath) {
  playerbundle = function_58c93260(self, meansofdeath);

  if(!isDefined(playerbundle)) {
    return;
  }

  voiceprefix = playerbundle.voiceprefix;

  if(!isDefined(voiceprefix)) {
    return;
  }

  deathalias = self get_death_vox(weapon, playerbundle, meansofdeath);

  if(self function_8b1a219a()) {
    if(isDefined(deathalias)) {
      var_27e6026e = function_5d15920e(deathalias, playerbundle);
      entitynumber = self getentitynumber();
      attacker function_661a6cc1(var_27e6026e, entitynumber);
    }

    return;
  }

  if(isDefined(deathalias)) {
    if(attacker hasdobj() && attacker haspart("J_Head")) {
      attacker playsoundontag(voiceprefix + deathalias, "J_Head");
      return;
    }

    attacker playsoundontag(voiceprefix + deathalias, "tag_origin");
  }
}

function get_death_vox(weapon, playerbundle, meansofdeath) {
  if(self isplayerunderwater()) {
    var_1f2bdb96 = playerbundle.exertdeathdrowned;
    return var_1f2bdb96;
  }

  if(self weapons::isexplosivedamage(meansofdeath)) {
    var_1f2bdb96 = playerbundle.var_44d86dec;
  }

  if(isDefined(meansofdeath)) {
    switch (meansofdeath) {
      case # "mod_rifle_bullet":
      case # "mod_pistol_bullet":
        var_1f2bdb96 = playerbundle.exertdeath;
        break;
      case # "mod_burned":
        var_1f2bdb96 = playerbundle.exertdeathburned;
        break;
      case # "mod_melee_weapon_butt":
        var_1f2bdb96 = playerbundle.var_53f25688;
        break;
      case # "mod_head_shot":
        var_1f2bdb96 = playerbundle.var_207908de;
        break;
      case # "mod_trigger_hurt":
        if(self getvelocity()[2] < -100) {
          var_1f2bdb96 = playerbundle.var_1dfcabbd;
        } else {
          var_1f2bdb96 = playerbundle.exertdeath;
        }

        break;
      case # "mod_falling":
        var_1f2bdb96 = playerbundle.var_1dfcabbd;
        break;
      case # "mod_drown":
        var_1f2bdb96 = playerbundle.exertdeathdrowned;
        break;
      case # "mod_gas":
        var_1f2bdb96 = playerbundle.var_7a45f37b;
        break;
      case # "mod_dot":
        if(weapon == getweapon(#"gadget_radiation_field")) {
          if(is_true(self.suicide)) {
            var_1f2bdb96 = playerbundle.var_48305ed9;
          } else {
            var_1f2bdb96 = playerbundle.var_f8b4bcc1;
          }
        } else if(weapon == getweapon(#"tear_gas")) {
          var_1f2bdb96 = playerbundle.var_7a45f37b;
        }

        if(weapon.doesfiredamage) {
          var_1f2bdb96 = playerbundle.exertdeathburned;
        }

        break;
      case # "mod_crush":
        stance = self getstance();

        if(stance === "prone") {
          var_1f2bdb96 = playerbundle.var_61f04861;
        } else {
          var_1f2bdb96 = playerbundle.var_35f92256;
        }

        break;
    }
  }

  if(!isDefined(var_1f2bdb96) && isDefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
    switch (weapon.rootweapon.name) {
      case # "knife_loadout":
      case # "hatchet":
        var_1f2bdb96 = playerbundle.exertdeathstabbed;
        break;
      case # "melee_slaybell_t8":
        var_1f2bdb96 = playerbundle.var_53f25688;
        break;
      case # "shock_rifle":
        var_1f2bdb96 = playerbundle.exertdeathelectrocuted;
        break;
    }
  }

  if(!isDefined(var_1f2bdb96)) {
    return;
  }

  return var_1f2bdb96;
}

function function_90cedf5b() {
  playerbundle = function_58c93260(self);

  if(!isDefined(playerbundle)) {
    return;
  }

  voiceprefix = playerbundle.voiceprefix;

  if(!isDefined(voiceprefix) || !isDefined(playerbundle.var_1ca33ad4)) {
    return;
  }

  dialogalias = voiceprefix + playerbundle.var_1ca33ad4;
  self thread function_a48c33ff(dialogalias, 22, mpdialog_value("playerExertBuffer", 0));
}

function function_624f04c6(playerbundle) {
  if(!isDefined(playerbundle.var_c1674108)) {
    return;
  }

  dialogalias = playerbundle.voiceprefix + playerbundle.var_c1674108;
  self.var_6765d33e = 1;
  self thread function_a48c33ff(dialogalias, 22, mpdialog_value("playerExertBuffer", 0));
}

function function_e9f06034(player, playbreath) {
  if(player hasperk(#"specialty_quieter")) {
    return;
  }

  playerbundle = function_58c93260(self);

  if(!isDefined(playerbundle)) {
    return;
  }

  voiceprefix = playerbundle.voiceprefix;

  if(!isDefined(voiceprefix)) {
    return;
  }

  if(playbreath && isDefined(playerbundle.exertemergegasp)) {
    dialogalias = voiceprefix + playerbundle.exertemergegasp;
    self thread function_a48c33ff(dialogalias, 22, mpdialog_value("playerExertBuffer", 0));
    return;
  }

  if(!playbreath && isDefined(playerbundle.exertemergebreath)) {
    dialogalias = voiceprefix + playerbundle.exertemergebreath;
    self thread function_a48c33ff(dialogalias, 22, mpdialog_value("playerExertBuffer", 0));
  }
}
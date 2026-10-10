/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\ai_armor.gsc
***********************************************/

#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\damagefeedback;
#namespace ai_armor;

function precache() {
  level._effect["vfx_helmet_tier3"] = loadfx("vfx/iw9/gameplay/sp/vfx_al_qatala_helmet_tier_3.vfx");
  level._effect["vfx_opforce_cartel_helmet_tier_3"] = loadfx("vfx/iw9/gameplay/sp/vfx_opforce_cartel_helmet_tier_3.vfx");
  level._effect["vfx_mex_mil_helmet_tier3"] = loadfx("vfx/iw9/gameplay/sp/vfx_mex_mil_helmet_tier_3.vfx");
  level._effect["vfx_shadow_co_helmet_tier3"] = loadfx("vfx/iw9/gameplay/sp/vfx_shadow_co_helmet_tier_3.vfx");
}

function function_1ddcdf764c5bdd84() {
  self.armored = 1;

  if(function_35cc826aceeeb635()) {
    if(istrue(level.var_2409f550b8a85394)) {
      return;
    }
  }

  if(istier3()) {
    function_b6ca17d480f22f01();
    self.var_b4378fc1b757b1b1 = 0;
    self.mask_on = 1;
  }

  self.spawnhealth = self.health;
  self.health = 99999;
  self.script_health = 99999;
  self.var_7a9debb6495e4fbe = ter_op(function_35cc826aceeeb635(), default_to(level.var_2986ed25936b6d23, 350), default_to(level.var_f203b64b98764f4, 1000));
  self.var_9aa77ab756fdca82 = 1000;
  self.var_43e2ad424676b8d4 = 100;
  self.fnshouldplaypainanim = &function_7477b2702d715c48;
  function_d18ffb2829a256ac();
  add_damage_function(&function_396b6f70220bfcf7);
}

function function_b6ca17d480f22f01() {
  if(issubstr(self.code_classname, "_rus_pmc")) {
    self.var_fbf555896f954157 = level._effect["vfx_shadow_co_helmet_tier3"];
    return;
  }

  if(issubstr(self.code_classname, "_pmc")) {
    self.var_fbf555896f954157 = level._effect["vfx_shadow_co_helmet_tier3"];
    return;
  }

  if(issubstr(self.code_classname, "_cartel")) {
    self.var_fbf555896f954157 = level._effect["vfx_opforce_cartel_helmet_tier_3"];
    return;
  }

  if(issubstr(self.code_classname, "_mex")) {
    self.var_fbf555896f954157 = level._effect["vfx_mex_mil_helmet_tier3"];
    return;
  }

  self.var_fbf555896f954157 = level._effect["vfx_helmet_tier3"];
}

function function_396b6f70220bfcf7(amount, attacker, direction, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon) {
  if(istrue(self.armored)) {
    self.health = 99999;
    self.script_health = 99999;
  }

  if(!utility::function_bbebfbddd1b77a34() && (istrue(level.var_288f1e20196e36b8) || istrue(self.var_288f1e20196e36b8))) {
    if(function_b653eb95e7d86ec0(partname)) {
      if(function_35cc826aceeeb635()) {
        function_758ea9f162c62fdc("hit_marker_3d_armor", "hithelmetlight");
      } else {
        function_758ea9f162c62fdc("hit_marker_3d_armor", "hithelmetheavy");
      }

      return;
    }

    if(function_35cc826aceeeb635()) {
      function_758ea9f162c62fdc("hit_marker_3d_armor", "hitarmorlight");
      return;
    }

    if(issubstr(self.animsetname, "shield")) {
      function_758ea9f162c62fdc("hit_marker_heavy", "hitblastshield");
      return;
    }

    function_758ea9f162c62fdc("hit_marker_3d_armor", "hitarmorheavy");
    return;
  }

  player_attacker = is_equal(attacker, level.player);

  if(is_equal(self.attacker, self) || utility::function_bbebfbddd1b77a34() || amount <= 1 || !function_3884bec8f53b84f6(meansofdeath, objweapon)) {
    if(meansofdeath == "MOD_MELEE" && !utility::function_bbebfbddd1b77a34()) {
      if(player_attacker) {
        thread play_sound_in_space("hit_marker_heavy", level.player.origin);
      }

      if(objweapon.basename == "iw9_me_riotshield_sp") {
        if(self.var_7a9debb6495e4fbe > 200) {
          if(function_35cc826aceeeb635()) {
            self.var_7a9debb6495e4fbe = 100;
          } else {
            self.var_7a9debb6495e4fbe = 200;
          }
        } else if(self.health <= 100) {
          function_6170c11c14c26ebd();
          return;
        }
      } else if(player_attacker) {
        if(istrue(level.var_bedd2f231189dcb3) || istrue(self.var_bedd2f231189dcb3)) {
          if(self.var_7a9debb6495e4fbe > 0 && (!isDefined(self.var_fcb646f1134732fc) || time_has_passed(self.var_fcb646f1134732fc, 0.5))) {
            self.var_fcb646f1134732fc = gettime();
            function_758ea9f162c62fdc(undefined, "hitarmorlight");
          }

          return;
        }

        amount = 100;
      }
    } else {
      return;
    }
  }

  if(player_attacker) {
    if(istrue(self.mask_on) && function_b653eb95e7d86ec0(partname)) {
      class = weaponclass(objweapon.basename);
      self.var_b4378fc1b757b1b1++;

      if(class != "sniper" && self.var_b4378fc1b757b1b1 < 3 && amount < 700) {
        if(function_35cc826aceeeb635()) {
          function_758ea9f162c62fdc("hit_marker_3d_armor", "hithelmetlight");
        } else {
          function_758ea9f162c62fdc("hit_marker_3d_armor", "hithelmetheavy");
        }

        return;
      }

      if(!istrue(self.mask_broken)) {
        if(class == "sniper" || amount >= 700) {
          thread function_d93c0ae1f417abb3(player_attacker, 0);
          function_6170c11c14c26ebd();
          return;
        }

        thread function_d93c0ae1f417abb3(player_attacker, 1);
      }

      return;
    }

    attacker notify("ai_armorDamaged", meansofdeath);
  }

  if(istrue(self.burningtodeath)) {
    function_bb6c0b67e147ba97();
    return;
  }

  if(self.armored) {
    if(player_attacker && isai(attacker)) {
      amount = int(amount * 0.33);
    }

    if(function_ce7e20508ce59a4c(meansofdeath) && !istrue(self.var_f4d5cb5646bd73e1)) {
      self.var_7a9debb6495e4fbe = 0;
    } else {
      self.var_7a9debb6495e4fbe -= amount;
    }

    if(!istrue(self.mask_on)) {
      if(function_b653eb95e7d86ec0(partname)) {
        function_6170c11c14c26ebd();
        return;
      }
    }

    if(self.var_7a9debb6495e4fbe > 1) {
      if(player_attacker) {
        if(function_35cc826aceeeb635()) {
          function_758ea9f162c62fdc("hit_marker_3d_armor", "hitarmorlight");
        } else if(issubstr(self.animsetname, "shield")) {
          function_758ea9f162c62fdc("hit_marker_heavy", "hitblastshield");
        } else {
          function_758ea9f162c62fdc("hit_marker_3d_armor", "hitarmorheavy");
        }
      }

      function_1d79a3f4f602f210(meansofdeath);
      return;
    }

    function_3dd3f7ea85b1e33a(player_attacker);

    if(function_35cc826aceeeb635() && function_ce7e20508ce59a4c(meansofdeath)) {
      function_6170c11c14c26ebd();
    }
  }
}

function function_7477b2702d715c48() {
  if(is_equal(self.damagemod, "MOD_MELEE")) {
    return true;
  }

  return false;
}

function function_d93c0ae1f417abb3(player_attacker, var_7ad84dc73ff10ea8) {
  if(player_attacker) {
    if(function_35cc826aceeeb635()) {
      function_758ea9f162c62fdc("hit_marker_3d_armor_break", "hithelmetlightbreak");
    } else {
      function_758ea9f162c62fdc("hit_marker_3d_armor_break", "hithelmetheavybreak");
    }
  }

  self notify("armor_break");
  playFXOnTag(self.var_fbf555896f954157, self, "j_head");
  thread ai_attachhead();
  self.mask_broken = 1;

  if(var_7ad84dc73ff10ea8) {
    ai_flashbang();
  }

  wait 1;
  self.mask_on = undefined;
}

function function_758ea9f162c62fdc(sound, value, var_436ac5b58aa21220) {
  level.player setclientomnvar("damage_feedback_icon", value);

  if(isDefined(var_436ac5b58aa21220)) {
    level.player setclientomnvar("damage_icon_amount", var_436ac5b58aa21220);
  } else {
    level.player setclientomnvar("damage_icon_amount", 1);
  }

  level.player setclientomnvar("damage_feedback_icon_notify", gettime());

  if(isDefined(sound)) {
    thread play_sound_in_space(sound, self.origin);
  }
}

function function_3dd3f7ea85b1e33a(player_attacker) {
  self notify("armor_break");
  self.var_b4378fc1b757b1b1 = 3;

  if(player_attacker && istrue(self.armored)) {
    if(function_35cc826aceeeb635()) {
      function_758ea9f162c62fdc("hit_marker_3d_armor_break", "hitarmorlightbreak");
    } else if(issubstr(self.animsetname, "shield")) {
      function_758ea9f162c62fdc("hit_marker_3d_armor_break", "hitarmorheavybreak");
    } else {
      function_758ea9f162c62fdc("hit_marker_3d_armor_break", "hitarmorheavybreak");
    }
  }

  if(istrue(self.magic_bullet_shield)) {
    stop_magic_bullet_shield();
  }

  self.health = self.spawnhealth;
  self.script_health = self.spawnhealth;
  self.armored = 0;
  ai_flashbang();
}

function function_3884bec8f53b84f6(meansofdeath, objweapon) {
  result = 1;

  if(function_d90870d4a1e92ff9(meansofdeath, objweapon)) {
    result = 0;
  }

  return result;
}

function function_d90870d4a1e92ff9(meansofdeath, objweapon) {
  if(meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_MELEE" && !utility::function_bbebfbddd1b77a34()) {
    return true;
  }

  if(isDefined(self.var_4c96ba0093ca475[meansofdeath]) && array_contains(self.var_4c96ba0093ca475[meansofdeath], objweapon.basename)) {
    return true;
  }

  return false;
}

function function_d18ffb2829a256ac() {
  self.var_4c96ba0093ca475["MOD_GRENADE_SPLASH"] = ["bottle", "flash", "smoke", "smoke_bomb", "gas_grenade_sp", "noisemaker"];
  self.var_4c96ba0093ca475["MOD_GRENADE"] = ["semtex", "molotov"];
}

function function_ce7e20508ce59a4c(meansofdeath) {
  switch (meansofdeath) {
    case #"hash_3c20f39c73a1422b":
    case #"hash_571e46e17a3cf2e3":
    case #"hash_66cb246f3e55fbe2":
    case #"hash_a911a1880d996edb":
    case #"hash_c22b13f81bed11f0":
      return 1;
    default:
      return 0;
  }
}

function function_1d79a3f4f602f210(meansofdeath) {
  if(!function_ce7e20508ce59a4c(meansofdeath)) {
    return 0;
  }

  self notify("flashbang", (0, 0, 0), 1, 1, level.player, "axis");
}

function ai_attachhead() {
  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
  }

  if(self tagexists("j_helmet")) {
    self hidepart("j_helmet", self.headmodel);
  }

  if(self tagexists("j_helmet_hide")) {
    self hidepart("j_helmet_hide", self.headmodel);
  }

  if(self tagexists("j_mask")) {
    self hidepart("j_mask", self.headmodel);
  }

  if(self tagexists("j_nvg")) {
    self hidepart("j_nvg", self.headmodel);
  }

  if(isDefined(self.hatmodel)) {
    self attach(self.hatmodel);
  }
}

function ai_flashbang() {
  if(!istrue(self.var_26a3131d00c1e6f3)) {
    self notify("flashbang", (0, 0, 0), 1, 1, level.player, "axis");
  }
}

function function_35cc826aceeeb635() {
  return is_equal(self.subclass, "tier2");
}

function istier3() {
  return is_equal(self.subclass, "tier3");
}

function function_b653eb95e7d86ec0(partname) {
  return isDefined(partname) && (scripts\sp\damagefeedback::isheadshot(partname) || partname == "j_helmet");
}

function function_bb6c0b67e147ba97() {
  self notify("kill_armorLogic");
  self.armored = 0;
  self.var_b4378fc1b757b1b1 = 3;

  if(istrue(self.magic_bullet_shield)) {
    stop_magic_bullet_shield();
  }

  if(self.health > self.spawnhealth) {
    self.health = self.spawnhealth;
  }

  self.script_health = self.health;
  remove_damage_function(&function_396b6f70220bfcf7);
}

function function_6170c11c14c26ebd() {
  self.var_b4378fc1b757b1b1 = 3;

  if(istrue(self.magic_bullet_shield)) {
    stop_magic_bullet_shield();
  }

  self kill();
}
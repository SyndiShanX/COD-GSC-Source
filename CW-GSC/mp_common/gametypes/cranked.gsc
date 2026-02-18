/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\cranked.gsc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\player\player_utils;
#namespace cranked;

function init() {
  callback::on_spawned(&onplayerspawned);
  player::function_cf3aa03d(&onplayerkilled);
  player::function_3c5cc656(&function_48a0864e);
  level.var_6e43020f = getgametypesetting(#"hash_128c92c1d485fef4");
  level.var_eaef5623 = getgametypesetting(#"hash_392901688b38e09");
  level.var_6e7d4cbc = getgametypesetting(#"hash_2243930edb0eb3c4");
  level.var_247906a9 = getgametypesetting(#"hash_586f77a1ef2d69c1");
  level.var_a8fa842f = getgametypesetting(#"hash_651f25fd21c3c150");
  level.var_baf51b1a = getgametypesetting(#"hash_1d8bebc7ca8fba63");
  level.var_9dc10d2f = getgametypesetting(#"hash_f36e77213cb26ae");
  level.var_9dba0d13 = getgametypesetting(#"hash_43d12ffbdffe0fc7");
  level.var_1b3b9a89 = getgametypesetting(#"hash_28c2ddff48841c48");
  clientfield::register_clientuimodel("hudItems.nakatomiDetonatorMeter", 1, 5, "int", 0);
  clientfield::register_clientuimodel("hud_items_cranked.crankedMax", 6000, 5, "int", 0);
  clientfield::register_clientuimodel("hud_items_cranked.crankedPct", 6000, 16, "float", 0);
  clientfield::register_clientuimodel("hud_items_cranked.crankedTimerReset", 6000, 1, "counter", 0);
  clientfield::register_clientuimodel("hud_items_cranked.crankedTimerResetCap", 6000, 1, "counter", 0);
  clientfield::register_clientuimodel("hud_items_cranked.crankedTier", 6000, 3, "int", 0);
  level.var_ce802423 = 1;

  if(!isDefined(level.var_224e376a)) {
    level.var_224e376a = 0.1;
  }

  level.var_3da05e50 = 1;
}

function onplayerspawned() {
  self function_2b750594();
  self clientfield::set_player_uimodel("hud_items_cranked.crankedTier", 0);
  self clientfield::set_player_uimodel("hud_items_cranked.crankedPct", 0);
}

function function_2b750594() {
  if(!isPlayer(self)) {
    return;
  }

  self.var_78f1a155 = 0;
  self.var_313fc9f2 = 0;
  self.var_a53bf240 = 0;
  self.var_2a9b3d6d = 0;
  self.var_358eb81d = 0;
  self stoptickingsound();
  self.var_be0cf222 = 0;
  self notify(#"hash_b3f3215ffbef5f6");
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  victim = self;

  if(isPlayer(victim)) {
    if(victim.var_78f1a155 === 1) {
      victim function_2a230737();
    }

    victim thread function_2b750594();
  }
}

function function_48a0864e(einflictor, victim, idamage, weapon) {
  attacker = self;

  if(isPlayer(attacker) && isalive(attacker) && attacker !== idamage && attacker.team !== idamage.team) {
    iskillstreakweapon = killstreaks::is_killstreak_weapon(weapon);

    if(iskillstreakweapon && !weapon.iscarriedkillstreak) {
      return;
    }

    if(attacker !== victim) {
      var_3184d29e = victim.birthtime;
      var_80bd0586 = isDefined(attacker.spawntime) ? attacker.spawntime : 0;

      if(isDefined(var_3184d29e) && var_3184d29e < var_80bd0586) {
        return;
      }
    }

    var_1cfdf798 = attacker === idamage.lastattacker && idamage.lastdamagewasfromenemy === 1;

    if(!var_1cfdf798) {
      var_e7514ecf = idamage.attackerdamage[attacker.clientid].lastdamagetime;
      var_80bd0586 = isDefined(attacker.spawntime) ? attacker.spawntime : 0;

      if(isDefined(var_e7514ecf) && var_e7514ecf < var_80bd0586) {
        return;
      }
    }

    if(!iskillstreakweapon) {
      attacker.var_a53bf240++;

      if(attacker.var_a53bf240 >= level.var_9dc10d2f && attacker.var_2a9b3d6d !== 1) {
        attacker.var_2a9b3d6d = 1;
        attacker playlocalsound("mpl_d_hard_full_meter");
      }
    }

    attacker clientfield::increment_uimodel("hud_items_cranked.crankedTimerReset");
    attacker function_7f7ea50(level.var_eaef5623);
  }
}

function function_2a230737() {
  if(!isPlayer(self) || self.var_78f1a155 !== 1) {
    return;
  }

  level endon(#"game_ended");
  var_7c0661e4 = gettime() - (isDefined(self.var_358eb81d) ? self.var_358eb81d : 0);

  if(var_7c0661e4 < 1000) {
    return;
  }

  self.var_358eb81d = gettime();
  damage = level.var_a8fa842f;
  radius = level.var_baf51b1a;
  fx = # "hash_5206e3009c8fa11d";
  sound = "mpl_d_hard_explo_sml";

  if(self.var_2a9b3d6d === 1) {
    damage = level.var_9dba0d13;
    radius = level.var_1b3b9a89;
    fx = # "hash_148b2600797f1690";
    sound = "mpl_d_hard_explo_lrg";
  }

  explosionorigin = isDefined(self gettagorigin("j_spineupper")) ? self gettagorigin("j_spineupper") : self.origin;
  var_7825522a = randomfloat(360);
  explosioneffect = spawnfx(fx, explosionorigin, (0, 0, 1), (cos(var_7825522a), sin(var_7825522a), 0));
  triggerfx(explosioneffect);
  thread sound::play_in_space(sound, explosionorigin);
  self thread function_98abc2e2();

  if(isDefined(self.var_313fc9f2) && self.var_313fc9f2 <= 0) {
    var_c0652821 = "MOD_DIEHARD";
  } else {
    var_c0652821 = "MOD_EXPLOSIVE";
  }

  self dodamage(self.health + 1000, explosionorigin, self, undefined, undefined, var_c0652821);
  radiusdamage(explosionorigin, radius, damage, damage, self, "MOD_EXPLOSIVE");
}

function function_98abc2e2() {
  level endon(#"game_ended");
  waittillframeend();

  if(!isDefined(self.body) || isalive(self)) {
    return;
  }

  var_4c4a5215 = spawnStruct();
  var_4c4a5215.player = self;
  var_4c4a5215.var_c3317960 = 0;
  gibserverutils::function_b14ffba8(var_4c4a5215);
  gibserverutils::playergiblegsvel(var_4c4a5215);
  gibserverutils::playergibleftarmvel(var_4c4a5215);
  gibserverutils::playergibrightarmvel(var_4c4a5215);
}

function function_cf725f10() {
  player = self;

  if(!isPlayer(player)) {
    return;
  }

  player clientfield::increment_uimodel("hud_items_cranked.crankedTimerReset");
  player function_7f7ea50(level.var_6e7d4cbc);
}

function function_d6e487ba(objective, contested) {
  player = self;

  if(isPlayer(player) && contested !== 1) {
    player clientfield::increment_uimodel("hud_items_cranked.crankedTimerResetCap");
    player function_7f7ea50(level.var_6e7d4cbc);
  }

  function_cd2a2af2(objective, contested);
}

function function_330029b4(objective, contested) {
  player = self;

  if(isPlayer(player) && level.var_247906a9 === 1) {
    player function_d95a7254();
  }

  function_cd2a2af2(objective, contested);
}

function function_cd2a2af2(objective, contested = 0) {
  var_464f0169 = isDefined(objective.var_edbf7cb7) ? objective.var_edbf7cb7 : 0;
  objective.var_edbf7cb7 = contested;

  if(isDefined(objective.users)) {
    foreach(user in objective.users) {
      foreach(struct in user.touching.players) {
        player = struct.player;

        if(level.var_247906a9 === 1) {
          if(contested === 1) {
            player function_d95a7254();
          } else {
            player function_50fdfcf7();
          }
        }

        if(var_464f0169 && !contested) {
          player clientfield::increment_uimodel("hud_items_cranked.crankedTimerResetCap");
          player function_7f7ea50(level.var_6e7d4cbc);
        }
      }
    }
  }
}

function function_7f7ea50(timetoadd = 0) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(self.var_313fc9f2)) {
    self.var_313fc9f2 = 0;
  }

  self.var_313fc9f2 = math::clamp(self.var_313fc9f2 + timetoadd, 0, level.var_6e43020f);
  self function_fe200fab();
}

function function_fe200fab() {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(self.var_a53bf240) || self.var_a53bf240 < 1) {
    self.var_a53bf240 = 1;
  }

  self clientfield::set_player_uimodel("hudItems.nakatomiDetonatorMeter", self.var_a53bf240);
  self function_1c4fb667();

  if(self.var_d16fbc3e !== 1 || self.var_313fc9f2 >= level.var_6e43020f) {
    self thread function_b50524c8();
  }

  if(self.var_78f1a155 !== 1) {
    self thread function_690ccad8();
    self.var_78f1a155 = 1;
    self.var_be0cf222 = 1;
    self playlocalsound("mpl_d_hard_activation");
  }
}

function function_1c4fb667() {
  if(!isalive(self)) {
    return;
  }

  tier = self.var_a53bf240 <= 5 ? self.var_a53bf240 : 5;
  self clientfield::set_player_uimodel("hud_items_cranked.crankedTier", tier);
  var_43df0177 = # "hash_50731bef82e61c83" + (isDefined(self.var_a53bf240) ? self.var_a53bf240 : 1) + "_mp";

  if(!self hastalent(var_43df0177)) {
    self addtalent(var_43df0177);
    perks = self getloadoutperks(self.class_num);

    foreach(perk in perks) {
      self setperk(perk);
    }
  }
}

function function_498e0b1d() {
  if(!isPlayer(self)) {
    return;
  }

  self clientfield::set_player_uimodel("hud_items_cranked.crankedMax", 30);

  if(isDefined(self.var_313fc9f2) && self.var_313fc9f2 > 0) {
    self clientfield::set_player_uimodel("hud_items_cranked.crankedPct", min(1, self.var_313fc9f2 / 30));
    return;
  }

  self clientfield::set_player_uimodel("hud_items_cranked.crankedPct", 0);
}

function function_690ccad8() {
  self notify("5fadd76874f9725c");
  self endon("5fadd76874f9725c");
  level endon(#"game_ended");
  self endon(#"death", #"hash_b3f3215ffbef5f6");
  self function_498e0b1d();
  interval_time = 0.05;

  while(isalive(self) && self.var_313fc9f2 > 0) {
    wait interval_time;
    hostmigration::waittillhostmigrationdone();

    if(isalive(self)) {
      self function_498e0b1d();

      if(self.var_86596c20 === 1) {
        self waittill(#"hash_5b9b8c65f4533a35");
      }

      if(isDefined(self.usingremote)) {
        continue;
      }

      self.var_313fc9f2 -= interval_time;
    }
  }

  if(!isalive(self)) {
    return;
  }

  self clientfield::set_player_uimodel("hud_items_cranked.crankedPct", 0);
  self thread function_2a230737();
}

function function_50fdfcf7() {
  self.var_86596c20 = 1;
  self notify(#"hash_15a66b825f924e82");
}

function function_d95a7254() {
  self.var_86596c20 = 0;
  self notify(#"hash_5b9b8c65f4533a35");
}

function private function_b50524c8() {
  if(!isDefined(self)) {
    return;
  }

  self notify("5fffdd27eb443c54");
  self endon("5fffdd27eb443c54");
  self endon(#"death", #"hash_b3f3215ffbef5f6", #"hash_30f67e5b667473be");
  level endon(#"game_ended");
  var_b2022825 = 0;
  var_e1b74407 = 0;
  var_5476874d = 0;

  while(isDefined(self)) {
    if(self.var_2a9b3d6d === 1) {
      self function_67f17457("mpl_d_hard_p_timer_a_npc", self.team);
    }

    self.var_d16fbc3e = 1;
    var_b444201d = isDefined(self.var_313fc9f2) && self.var_313fc9f2 <= 10.1;
    var_b2022825 = isDefined(self.var_313fc9f2) && self.var_313fc9f2 <= 5.1;

    if(var_b444201d) {
      var_df4e70cd = "mpl_d_hard_p_timer_b_plr";
    } else {
      var_df4e70cd = "mpl_d_hard_p_timer_a_plr";
    }

    if(var_b2022825 && !var_5476874d) {
      n_count = int(self.var_313fc9f2);

      if(self.var_313fc9f2 - n_count >= 0.9) {
        n_count++;
      }

      var_df4e70cd = "mpl_d_hard_p_timer_5seconds_" + n_count;
      var_5476874d = 1;
    } else {
      var_5476874d = 0;
    }

    self playlocalsound(var_df4e70cd);

    if(var_b2022825) {
      waittime = 0.5;
      var_e1b74407 = 1;
    } else if(isDefined(self.var_313fc9f2) && var_e1b74407) {
      waittime = self.var_313fc9f2 - int(self.var_313fc9f2);

      if(waittime <= 0) {
        waittime = 1;
      }

      var_e1b74407 = 0;
    } else {
      waittime = 1;
    }

    wait waittime;

    if(self.var_86596c20 === 1 || isDefined(self.usingremote)) {
      while(self.var_86596c20 === 1 || isDefined(self.usingremote)) {
        if(self.var_86596c20 === 1) {
          self waittill(#"hash_5b9b8c65f4533a35");
          continue;
        }

        wait 0.1;
      }

      waittime = self.var_313fc9f2 - int(self.var_313fc9f2);

      if(waittime > 0) {
        wait waittime;
      }
    }

    hostmigration::waittillhostmigrationdone();
  }
}

function private stoptickingsound() {
  if(!isDefined(self)) {
    return;
  }

  self.var_d16fbc3e = 0;
  self notify(#"hash_30f67e5b667473be");
}
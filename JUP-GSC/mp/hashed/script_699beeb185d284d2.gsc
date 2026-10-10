/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_699beeb185d284d2.gsc
*************************************************/

#using script_4e5018973422744d;
#using script_699beeb185d284d2;
#using scripts\common\callbacks;
#using scripts\cp_mp\challenges;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#using scripts\mp\utility\game;
#namespace namespace_4005e39d519fcb0d;

function main() {
  function_c93b23bb9922f962(3, &function_e452c990ed15f1f4);
  function_c93b23bb9922f962(3, &function_ab74507383cbf2f2);
  function_c93b23bb9922f962(3, &function_28cfcb99965e96dc);
  function_c93b23bb9922f962(5, &function_c2a7489563a6adc3);
  function_c93b23bb9922f962(5, &function_9fa0452210d65aa1);
  function_c93b23bb9922f962(5, &function_716ff25a947c0f33);
  function_c93b23bb9922f962(5, &function_28cfcb99965e96dc);
  function_c93b23bb9922f962(7, &function_1adc246b5aa124de);
  function_c93b23bb9922f962(7, &function_9fa0442210d6586e);
  function_c93b23bb9922f962(7, &function_716ff25a947c0f33);
  function_c93b23bb9922f962(7, &function_28cfcb99965e96dc);
  function_c93b23bb9922f962(12, &function_61ecfe68e049247d);
  function_c93b23bb9922f962(12, &function_9fa0472210d65f07);
  function_c93b23bb9922f962(12, &function_28cfcb99965e96dc);
  function_c93b23bb9922f962(20, &function_3f4a3832eae83768);
  function_c93b23bb9922f962(20, &function_9fa0462210d65cd4);
  function_c93b23bb9922f962(20, &function_28cfcb99965e96dc);
  level callback::add("player_death", &onplayerdeath);
  level callback::add("player_connect", &onplayerconnect);
  level callback::add("player_spawned", &onplayerspawned);
  setdvarifuninitialized(@ "hash_4c75c8f84cdc0a29", 300);
  setdvarifuninitialized(@ "hash_121c4f713ddefab6", 1);
  setdvarifuninitialized(@ "hash_92531f573a18cfee", 4);
  setdvarifuninitialized(@ "hash_92531e573a18cdbb", 6.67);
  setdvarifuninitialized(@ "hash_92531d573a18cb88", 10);
  setdvarifuninitialized(@ "hash_925324573a18daed", 16.67);
  setdvarifuninitialized(@ "hash_925323573a18d8ba", 33.33);
  function_6752aec364da9b06();

  level thread function_9b4840d764cd7aee();
}

function onplayerconnect(params) {
  player = self;
  player.var_368482a07f9eb2fe = default_to(player.var_368482a07f9eb2fe, 0);
  player.var_94908079eda0edb0 = default_to(player.var_94908079eda0edb0, 0);
  player.var_af6a8b7032a47cc = default_to(player.var_af6a8b7032a47cc, 0);
  player.var_36e73c07f465d4b1 = default_to(player.var_36e73c07f465d4b1, 0);
  player setthreatbiasgroup("limbo_ai_threat_bias_0");
}

function onplayerspawned(params) {
  player = self;
  player thread function_bb64e69831584222();
}

function function_bdf7f1777331997d(bias, lock, restore, var_cf4eaa9473fb2b58) {
  if(!istrue(var_cf4eaa9473fb2b58)) {
    self.var_ae4fe1908c5a6b2a = bias;
  }

  if(istrue(restore)) {
    self.var_63ae7ddbf47f9041 = undefined;
  }

  if(istrue(self.var_63ae7ddbf47f9041)) {
    return;
  }

  if(istrue(lock)) {
    self.var_63ae7ddbf47f9041 = 1;
  }

  self setthreatbiasgroup(bias);
}

function function_c0def9decca38438() {
  function_bdf7f1777331997d("limbo_ai_threat_bias_0", 1, 0, 1);
}

function function_54000b07cf38cbc3() {
  if(isDefined(self.var_ae4fe1908c5a6b2a)) {
    function_bdf7f1777331997d(self.var_ae4fe1908c5a6b2a, 0, 1);
    return;
  }

  function_bdf7f1777331997d("limbo_ai_threat_bias_0", 0, 1);
}

function function_bb64e69831584222() {
  self endon("death_or_disconnect");
  self endon("starRankAquired");

  while(true) {
    self waittill("weapon_fired");
    function_bdf7f1777331997d("limbo_ai_threat_bias_small");
    wait 5;
    function_bdf7f1777331997d("limbo_ai_threat_bias_0");
  }
}

function function_36260c61d94230e7(player) {
  if(isDefined(player) && isPlayer(player)) {
    player function_1a20bd7e4b974550();
    namespace_2c917b98351ca497::function_1d6b7b205b970e2e(player);
  }
}

function onplayerdeath(data) {
  if(!(isDefined(data.attacker) && isDefined(data) && isDefined(data.victim))) {
    return;
  }

  if(is_equal(data.attacker, data.victim)) {
    function_36260c61d94230e7(data.victim);
    return;
  }

  if(!isPlayer(data.attacker)) {
    function_36260c61d94230e7(data.victim);
    return;
  }

  victim = data.victim;
  attacker = data.attacker;
  attacker function_ec58ec5e38fcb3c0();
  function_778f16356c79b364(attacker, victim);
  function_36260c61d94230e7(data.victim);
}

function function_1a20bd7e4b974550() {
  self.var_94908079eda0edb0 = 0;
  self.var_368482a07f9eb2fe = 0;
  self.var_909485dde437b80c = 0;
  function_754ba950b1cc211d(self);
}

function function_ec58ec5e38fcb3c0() {
  self.var_368482a07f9eb2fe++;

  if(self.var_94908079eda0edb0 != function_8dd59efae7f5243e()) {
    self.var_94908079eda0edb0 = function_8dd59efae7f5243e();
    splashref = "limbo_star_increase_" + self.var_94908079eda0edb0;
    thread scripts\mp\hud_message::showsplash(splashref, undefined, undefined, undefined, undefined, "splash_list_br_jup_limbo");
    scripts\cp_mp\challenges::function_9dd45fb7c1b7de56("event_limbo_star_level_reached", self.var_94908079eda0edb0);
    namespace_2c917b98351ca497::function_ebb47a7870bb63fb(self);
  }

  function_754ba950b1cc211d(self);
}

function function_754ba950b1cc211d(player) {
  if(!isDefined(player.var_94908079eda0edb0)) {
    return;
  }

  player setclientomnvar("ui_br_player_star_rating", player.var_94908079eda0edb0);
}

function function_8dd59efae7f5243e() {
  var_368482a07f9eb2fe = self.var_368482a07f9eb2fe;
  var_a55d725ead24ffde = [3, 5, 7, 12, 20];

  for(i = var_a55d725ead24ffde.size - 1; i >= 0; i--) {
    if(var_368482a07f9eb2fe >= var_a55d725ead24ffde[i]) {
      return (i + 1);
    }
  }

  return 0;
}

function function_ac4ea7f1e6ac08e9(var_9e3ae5d3c37d4f23) {
  var_9e3ae5d3c37d4f23 = default_to(var_9e3ae5d3c37d4f23, 0);
  return var_9e3ae5d3c37d4f23 ? self.var_8dfc3725b5336b27 : self.var_ed665b140e92c2af;
}

function function_115fdb711aab6960() {
  var_e8057d619b8258bc = getdvarfloat(@ "hash_121c4f713ddefab6", 1);
  var_f09fffd4dd6a24c4 = spawnStruct();
  var_f09fffd4dd6a24c4.var_72d2243319611737 = function_ac4ea7f1e6ac08e9();
  var_f09fffd4dd6a24c4.var_a6f92fabf6fe9eb6 = clamp(var_f09fffd4dd6a24c4.var_72d2243319611737, 0, getdvarfloat(@ "hash_4c75c8f84cdc0a29", 300));
  xpmultiplier = getdvarfloat(hashcat(@ "hash_b33d9f0b1161ce6b", self.var_94908079eda0edb0), 4);
  var_f09fffd4dd6a24c4.totalxp = var_e8057d619b8258bc * xpmultiplier * var_f09fffd4dd6a24c4.var_a6f92fabf6fe9eb6;
  return var_f09fffd4dd6a24c4;
}

function function_778f16356c79b364(attacker, victim) {
  var_a55d725ead24ffde = [3, 5, 7, 12, 20];
  var_7f2ce18e66136586 = attacker function_115fdb711aab6960();
  var_e7accfa94699895f = victim function_115fdb711aab6960();

  if(victim.var_94908079eda0edb0 >= 1 && victim.var_94908079eda0edb0 <= 5) {
    if(issharedfuncdefined("player", "doScoreEvent")) {
      victim thread[[getsharedfunc("player", "doScoreEvent")]](hashcat(#"hash_7fad537897216d50", victim.var_94908079eda0edb0), undefined, var_e7accfa94699895f.totalxp, var_e7accfa94699895f.totalxp, undefined, 0);
    }

    if(var_e7accfa94699895f.var_72d2243319611737 >= 60) {
      minutes = int(round(var_e7accfa94699895f.var_72d2243319611737 / 60));

      if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
        level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("br_limbo_star_killed_" + victim.var_94908079eda0edb0, victim, undefined, minutes);
      }
    }

    if(issharedfuncdefined("player", "doScoreEvent")) {
      attacker thread[[getsharedfunc("player", "doScoreEvent")]](hashcat(#"hash_9e002c297ae849cb", victim.var_94908079eda0edb0));
    }
  }

  if(attacker.var_94908079eda0edb0 >= 1 && attacker.var_94908079eda0edb0 <= 5 && array_contains(var_a55d725ead24ffde, attacker.var_368482a07f9eb2fe)) {
    if(issharedfuncdefined("player", "doScoreEvent")) {
      attacker thread[[getsharedfunc("player", "doScoreEvent")]](hashcat(#"hash_1bb7fd04f78b2fd3", attacker.var_94908079eda0edb0), undefined, var_7f2ce18e66136586.totalxp, var_7f2ce18e66136586.totalxp, undefined, 0);
    }
  }
}

function function_bddecd56f4b2d8b0(var_94908079eda0edb0) {
  var_fae400e04525bed1 = [3, 5, 7, 12, 20];
  var_b76953eaa0edd68c = var_94908079eda0edb0 - 1;
  assert(var_b76953eaa0edd68c < var_fae400e04525bed1.size, "<dev string:x1c>" + var_fae400e04525bed1.size + "<dev string:x64>");
  var_c90329e9e9f3e84d = var_fae400e04525bed1[var_b76953eaa0edd68c];
  self.var_94908079eda0edb0 = var_94908079eda0edb0;
  self.var_368482a07f9eb2fe = !isDefined(self.var_368482a07f9eb2fe) || self.var_368482a07f9eb2fe < var_c90329e9e9f3e84d ? var_c90329e9e9f3e84d : self.var_368482a07f9eb2fe;
  namespace_2c917b98351ca497::function_ebb47a7870bb63fb(self);
  function_754ba950b1cc211d(self);
}

function function_9b4840d764cd7aee() {
  while(true) {
    if(getdvarint(@ "hash_11581a95c446b1e5", 0)) {
      setDvar(@ "hash_11581a95c446b1e5", 0);

      if(getdvarint(@ "hash_a610299f1081570", 0)) {
        foreach(player in level.players) {
          if(player.var_94908079eda0edb0 >= 5) {
            continue;
          }

          player function_8cc3e714c1b45e46();
          waitframe();
        }
      } else {
        if(level.player.var_94908079eda0edb0 >= 5) {
          continue;
        }

        level.player function_8cc3e714c1b45e46();
      }
    }

    if(getdvarint(@ "hash_ea619cd6d92965f9", 0)) {
      setDvar(@ "hash_ea619cd6d92965f9", 0);

      if(getdvarint(@ "hash_a610299f1081570", 0)) {
        foreach(player in level.players) {
          if(player.var_94908079eda0edb0 >= 5) {
            continue;
          }

          player namespace_83b142ab0b1210c0::function_bddecd56f4b2d8b0(5);
          waitframe();
        }
      } else {
        if(level.player.var_94908079eda0edb0 >= 5) {
          continue;
        }

        level.player namespace_83b142ab0b1210c0::function_bddecd56f4b2d8b0(5);
      }
    }

    waitframe();
  }
}

function function_8cc3e714c1b45e46() {
  var_2d6320bcee7d9b61 = function_8dd59efae7f5243e() + 1;

  while(self.var_94908079eda0edb0 < var_2d6320bcee7d9b61) {
    function_ec58ec5e38fcb3c0();
    waitframe();
  }
}

function function_6752aec364da9b06() {
  array = ["limbo_ai_threat_bias_0", "limbo_ai_threat_bias_1", "limbo_ai_threat_bias_2", "limbo_ai_threat_bias_3", "limbo_ai_threat_bias_4", "limbo_ai_threat_bias_5"];

  foreach(bias in array) {
    if(!threatbiasgroupexists(bias)) {
      createthreatbiasgroup(bias);
    }
  }

  createthreatbiasgroup("limbo_ai_threat_bias");
  createthreatbiasgroup("limbo_ai_threat_bias_small");
  setignoremegroup("limbo_ai_threat_bias_0", "limbo_ai_threat_bias");
  setthreatbias("limbo_ai_threat_bias", "limbo_ai_threat_bias_1", 100);
  setthreatbias("limbo_ai_threat_bias", "limbo_ai_threat_bias_2", 200);
  setthreatbias("limbo_ai_threat_bias", "limbo_ai_threat_bias_3", 300);
  setthreatbias("limbo_ai_threat_bias", "limbo_ai_threat_bias_4", 400);
  setthreatbias("limbo_ai_threat_bias", "limbo_ai_threat_bias_5", 500);
}
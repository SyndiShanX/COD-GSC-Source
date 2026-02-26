/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gamedifficulty.gsc
***********************************************/

#using scripts\core_common\ai\systems\weaponlist;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\ui\warning_message;
#namespace gamedifficulty;

function autoexec init() {
  level.gameskill = 1;
  level.var_3426461d = &function_8ffb61a;
}

function setskill(reset, var_648a2ef0) {
  if(!isDefined(level.script)) {
    level.script = util::get_map_name();
  }

  if(!is_true(reset)) {
    if(is_true(level.var_a26aa64a)) {
      return;
    }

    thread function_f4a93c9c();

    level.var_a26aa64a = 1;
  }

  level thread function_57ba1474(var_648a2ef0);
  level.var_b6db9d5a = 1;
  set_difficulty_from_locked_settings();
  level function_4ba867b();
}

function function_c0aae431(var_7317b1dc) {
  level.playerhealth_regularregendelay = function_a34942a0();

  if(level.var_b6db9d5a) {
    thread function_f80a8b13(var_7317b1dc);
  }

  level.longregentime = function_faea9c9e();
  level.animation.misstimeconstant = function_5ae527c5();
  level.animation.misstimedistancefactor = function_f2ec5636();
}

function function_f80a8b13(var_7317b1dc) {
  level flag::wait_till("all_players_connected");
  players = level.players;

  for(i = 0; i < players.size; i++) {
    players[i].threatbias = int(function_1cfd1920());
  }
}

function set_difficulty_from_locked_settings() {
  function_c0aae431(&function_66c52cbf);
}

function function_66c52cbf(msg, ignored) {
  return level.difficultysettings[ignored][level.currentdifficulty];
}

function function_f4a93c9c() {
  waittillframeend();

  while(true) {
    while(true) {
      if(getdvarint(#"scr_health_debug", 0)) {
        break;
      }

      wait 0.5;
    }

    thread function_fe49c4b4();

    while(true) {
      if(!getdvarint(#"scr_health_debug", 0)) {
        break;
      }

      wait 0.5;
    }

    level notify(#"hash_4fff5870dd60a939");
    function_d1f1cf52();
  }
}

function function_fe49c4b4() {
  level notify(#"hash_7eabe7ecd3c67fd");
  level endon(#"hash_7eabe7ecd3c67fd");
  y = 40;
  level.var_60023d69 = [];
  level.var_1c9484[0] = "<dev string:x38>";
  level.var_1c9484[1] = "<dev string:x42>";
  level.var_1c9484[2] = "<dev string:x51>";

  if(!isDefined(level.var_5a1abaae)) {
    level.var_5a1abaae = 0;
  }

  if(!isDefined(level.var_30235742)) {
    level.var_30235742 = 0;
  }

  for(i = 0; i < level.var_1c9484.size; i++) {
    key = level.var_1c9484[i];
    textelem = newdebughudelem();
    textelem.x = 150;
    textelem.y = y;
    textelem.alignx = "<dev string:x60>";
    textelem.aligny = "<dev string:x68>";
    textelem.horzalign = "<dev string:x6f>";
    textelem.vertalign = "<dev string:x6f>";
    textelem settext(key);
    bgbar = newdebughudelem();
    bgbar.x = 150 + 79;
    bgbar.y = y + 1;
    bgbar.z = 1;
    bgbar.alignx = "<dev string:x60>";
    bgbar.aligny = "<dev string:x68>";
    bgbar.horzalign = "<dev string:x6f>";
    bgbar.vertalign = "<dev string:x6f>";
    bgbar.maxwidth = 3;
    bgbar setshader(#"white", bgbar.maxwidth, 10);
    bgbar.color = (0.5, 0.5, 0.5);
    bar = newdebughudelem();
    bar.x = 150 + 80;
    bar.y = y + 2;
    bar.alignx = "<dev string:x60>";
    bar.aligny = "<dev string:x68>";
    bar.horzalign = "<dev string:x6f>";
    bar.vertalign = "<dev string:x6f>";
    bar setshader(#"black", 1, 8);
    bar.sort = 1;
    textelem.bar = bar;
    textelem.bgbar = bgbar;
    textelem.key = key;
    y += 10;
    level.var_60023d69[key] = textelem;
  }

  level flag::wait_till("<dev string:x7d>");

  while(true) {
    waitframe(1);
    players = level.players;

    for(i = 0; i < level.var_1c9484.size && players.size > 0; i++) {
      key = level.var_1c9484[i];
      player = players[0];
      width = 0;

      if(i == 0) {
        width = player.health / player.maxhealth * 300;
        level.var_60023d69[key] settext(level.var_1c9484[0] + "<dev string:x94>" + player.health);
      } else if(i == 1) {
        width = (level.var_5a1abaae - gettime()) / 1000 * 40;
      } else if(i == 2) {
        width = (level.var_30235742 - gettime()) / 1000 * 40;
      }

      width = int(max(width, 1));
      width = int(min(width, 300));
      bar = level.var_60023d69[key].bar;
      bar setshader(#"black", width, 8);
      bgbar = level.var_60023d69[key].bgbar;

      if(width + 2 > bgbar.maxwidth) {
        bgbar.maxwidth = width + 2;
        bgbar setshader(#"white", bgbar.maxwidth, 10);
        bgbar.color = (0.5, 0.5, 0.5);
      }
    }
  }
}

function function_d1f1cf52() {
  level notify(#"hash_7eabe7ecd3c67fd");

  if(!isDefined(level.var_60023d69)) {
    return;
  }

  for(i = 0; i < level.var_1c9484.size; i++) {
    level.var_60023d69[level.var_1c9484[i]].bgbar destroy();
    level.var_60023d69[level.var_1c9484[i]].bar destroy();
    level.var_60023d69[level.var_1c9484[i]] destroy();
  }
}

function function_c6f98249() {
  self notify("54802cc95ae5ac77");
  self endon("54802cc95ae5ac77");
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"damage");

    if(isDefined(waitresult.attacker) && isPlayer(waitresult.attacker) && !is_true(isbot(waitresult.attacker))) {
      continue;
    }

    self.damagepoint = waitresult.position;
    self.damageattacker = waitresult.attacker;

    if(isDefined(waitresult.mod) && waitresult.mod == "MOD_BURNED") {
      self setburn(0.5);
      self playSound(#"chr_burn");
    }

    level notify(#"hit_again");
  }
}

function function_2339ca92() {
  var_9b6ba81f = function_ad49ef5b();

  if(var_9b6ba81f > 0) {
    self thread function_22107f87(var_9b6ba81f);
  }

  level.var_5a1abaae = gettime() + var_9b6ba81f * 1000;
}

function private function_22107f87(timer) {
  self endon(#"death", #"disconnect");

  if(self flag::get("player_is_invulnerable")) {
    return;
  }

  self flag::set("player_is_invulnerable");
  level notify(#"hash_245285a0c17aa5cb");
  var_ae0703af = self getnoncheckpointdata("DeathsDoorWarnings");
  var_5273c86b = self getnoncheckpointdata("DeathsDoorWarningTime");

  if((isDefined(var_ae0703af) ? var_ae0703af : 0) > 0 && getrealtime() >= (isDefined(var_5273c86b) ? var_5273c86b : 0) && !self flag::get("no_deaths_door_warning") && !isgodmode(self)) {
    self setnoncheckpointdata("DeathsDoorWarnings", var_ae0703af - 1);
    self setnoncheckpointdata("DeathsDoorWarningTime", getrealtime() + 60000);
    self thread warning_message::create(#"hash_1b8a733f0d461a2c", [#"hash_2b62b2990144ebf6", #"healing", "no_deaths_door_warning"], 1, ["death", "in_igc"]);
  }

  self thread function_ab69b983();

  if(timer > 0) {
    function_fef4c10f(timer, 1);
  }

  self flag::clear("player_is_invulnerable");
}

function function_fef4c10f(timer, var_19c9196 = 0) {
  if(var_19c9196) {
    self notify(#"hash_61ab322c075ab540");
  } else if(self flag::get("player_zero_attacker_accuracy")) {
    return;
  }

  self endon(#"hash_61ab322c075ab540", #"death");

  if(!isDefined(self.var_c040f22f)) {
    self.var_c040f22f = self.attackeraccuracy;
  } else {
    assert(self.attackeraccuracy == 0, "<dev string:x99>");
  }

  self function_f5c273fc();
  wait timer;
  self function_b9d6a17c();
}

function private function_f5c273fc() {
  self flag::set("player_zero_attacker_accuracy");
  self.attackeraccuracy = 0;
}

function private function_b9d6a17c() {
  self flag::clear("player_zero_attacker_accuracy");
  assert(isDefined(self.var_c040f22f), "<dev string:xe0>");
  assert(self.var_c040f22f != 0, "<dev string:x127>");
  self.attackeraccuracy = self.var_c040f22f;
  self.var_c040f22f = undefined;
}

function private function_ab69b983() {
  self endon(#"death");
  self.var_2869a26a = 0;
  assert(self flag::get("<dev string:x173>"));
  self flag::wait_till_clear("player_is_invulnerable");
  cooldowntime = function_81e40993();

  level.var_30235742 = gettime() + cooldowntime * 1000;

  wait cooldowntime;
  self.var_2869a26a = 1;
}

function function_57ba1474(var_648a2ef0) {
  level notify(#"hash_75a2e0ea99b6eba1");
  level endon(#"hash_75a2e0ea99b6eba1");
  transient = savegame::function_6440b06b(#"transient");

  if(!isDefined(transient.var_9ac9bc79)) {
    transient.var_9ac9bc79 = 9999;
  }

  if(!isDefined(transient.var_a0bc0e2c)) {
    transient.var_a0bc0e2c = 0;
  }

  var_d92990c1 = -1;

  while(!isDefined(var_648a2ef0)) {
    level.gameskill = getlocalprofileint("g_gameskill");

    var_89694459 = getdvarstring(#"overridedifficulty", "<dev string:x18d>");

    switch (tolower(var_89694459)) {
      case # "recruit":
        level.gameskill = 0;
        break;
      case # "regular":
        level.gameskill = 1;
        break;
      case # "hardened":
        level.gameskill = 2;
        break;
      case # "veteran":
        level.gameskill = 3;
        break;
      case # "realistic":
        level.gameskill = 4;
        break;
    }

    if(level.gameskill != var_d92990c1) {
      if(!isDefined(level.gameskill)) {
        level.gameskill = 1;
      }

      switch (level.gameskill) {
        case 0:
          setDvar(#"currentdifficulty", "recruit");
          level.currentdifficulty = "recruit";
          break;
        case 1:
          setDvar(#"currentdifficulty", "regular");
          level.currentdifficulty = "regular";
          break;
        case 2:
          setDvar(#"currentdifficulty", "hardened");
          level.currentdifficulty = "hardened";
          break;
        case 3:
          setDvar(#"currentdifficulty", "veteran");
          level.currentdifficulty = "veteran";
          break;
        case 4:
          setDvar(#"currentdifficulty", "realistic");
          level.currentdifficulty = "realistic";
          break;
      }

      println("<dev string:x191>" + level.gameskill);
      setDvar(#"saved_gameskill", level.gameskill);
      setlocalprofilevar("g_gameskill", level.gameskill);

      if(level.gameskill < transient.var_9ac9bc79) {
        transient.var_9ac9bc79 = level.gameskill;
      }

      if(level.gameskill > transient.var_a0bc0e2c) {
        transient.var_a0bc0e2c = level.gameskill;
      }

      level flag::wait_till("all_players_connected");

      foreach(player in getplayers()) {
        player clientfield::set_player_uimodel("hudItems.serverDifficulty", level.gameskill);
        player stats::set_stat(#"currentdifficulty", level.gameskill);
        uploadstats(player);
        var_ae0703af = player getnoncheckpointdata("DeathsDoorWarnings");

        if(!isDefined(var_ae0703af) || var_d92990c1 == -1) {
          player setnoncheckpointdata("DeathsDoorWarnings", 4 - level.gameskill);
          continue;
        }

        player setnoncheckpointdata("DeathsDoorWarnings", int(max(0, 4 - level.gameskill - 4 - var_d92990c1 - var_ae0703af)));
      }

      var_d92990c1 = level.gameskill;
    }

    wait 1;
  }
}

function function_c7551020() {
  if(!isDefined(level.var_21347b32)) {
    level.var_21347b32 = [];
    level.var_21347b32[0] = getscriptbundle(#"gamedifficulty_recruit");
    level.var_21347b32[1] = getscriptbundle(#"gamedifficulty_regular");
    level.var_21347b32[2] = getscriptbundle(#"gamedifficulty_hardened");
    level.var_21347b32[3] = getscriptbundle(#"gamedifficulty_veteran");
    level.var_21347b32[4] = getscriptbundle(#"gamedifficulty_realistic");
  }
}

function function_1cfd1920() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].threatbias;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_8ffb61a(event) {
  function_c7551020();
  var_2b9b388d = level.var_21347b32[level.gameskill].difficulty_xp_multiplier;

  if(isDefined(var_2b9b388d)) {
    return var_2b9b388d;
  }

  return 1;
}

function function_4a1bd46e() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].healthoverlaycutoff;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_f6f41f76() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].var_ff7fb6bb;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_ad49ef5b() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].player_deathinvulnerabletime;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_81e40993() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].var_40865ff8;
  return isDefined(var_b0210d64) ? var_b0210d64 : 0;
}

function function_e4046aa6() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].base_enemy_accuracy;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_eb59c79() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].playerdifficultyhealth;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 100;
}

function function_5ae527c5() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].misstimeconstant;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_22fc6679() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].misstimeresetdelay;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_f2ec5636() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].misstimedistancefactor;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_f754b1bc() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].dog_health;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_ad6fb6da() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].var_f84eb1d6;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_8bf0a382() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].var_bd3beebd;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_faea9c9e() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].longregentime;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_a34942a0() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].playerhealth_regularregendelay;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_f4052850() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].worthydamageratio;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 0;
}

function function_b5b7d60e() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].var_b768020b;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 2;
}

function function_5151f9d0() {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].var_5657206f;

  if(isDefined(var_b0210d64)) {
    return var_b0210d64;
  }

  return 4.5;
}

function function_52f56aea(var_d020b056) {
  function_c7551020();
  var_b0210d64 = level.var_21347b32[level.gameskill].var_bb4e24d2;

  if(isDefined(var_b0210d64)) {
    misstime = var_b0210d64;
  } else {
    misstime = 0.3;
  }

  scalar = 1;

  if(var_d020b056 === "fullauto") {
    scalar = 0.5;
  } else if(var_d020b056 === "singleshot") {
    scalar = 1.5;
  }

  return misstime * scalar;
}

function get_general_difficulty_level() {
  value = level.gameskill + level.players.size - 1;

  if(value < 0) {
    value = 0;
  }

  return value;
}

function function_7dbe6a66() {
  player = self;

  if(function_ad49ef5b() == 0) {
    return 0;
  }

  return is_true(self.var_2869a26a);
}

function function_2aed7a44(player, eattacker, einflictor, idamage, weapon, shitloc, var_b646048d) {
  if((var_b646048d == "MOD_MELEE" || var_b646048d == "MOD_MELEE_WEAPON_BUTT") && isentity(weapon) && !isPlayer(weapon)) {
    if(isactor(weapon)) {
      var_c86b4d97 = int(function_eb59c79() * 0.8);
      return var_c86b4d97;
    }
  }

  return shitloc;
}

function function_23dcd1f6(player, eattacker, einflictor, idamage, weapon, shitloc, var_b646048d) {
  var_68bc2059 = float(function_eb59c79());
  assert(var_68bc2059 > 0);
  var_86342214 = float(100) / var_68bc2059;
  return max(var_b646048d * var_86342214, min(1, var_b646048d));
}

function function_4ba867b() {
  function_c7551020();
  var_938ce325 = level.var_21347b32[level.gameskill].player_laststandbleedouttime;
  var_4cfdf1fc = level.var_21347b32[level.gameskill].var_949c9924;
  var_22e7a516 = level.var_21347b32[level.gameskill].player_laststandsuicidedelay;
  var_33682ca0 = level.var_21347b32[level.gameskill].var_58500288;
  var_fd9d63a8 = level.var_21347b32[level.gameskill].player_respawndelay;
  var_dd639ef7 = level.var_21347b32[level.gameskill].var_1bc10f3a;
  var_8c4f976a = level.var_21347b32[level.gameskill].var_c5c20d41;
  var_88dcf868 = level.var_21347b32[level.gameskill].var_4ca741c2;
  var_8f59489c = level.var_21347b32[level.gameskill].var_e3e8d3a1;
  var_880dfe56 = level.var_21347b32[level.gameskill].var_7b55ea2b;
  setDvar(#"player_laststandbleedouttime", var_938ce325);
  setDvar(#"hash_7036719f41a78d54", var_4cfdf1fc);
  setDvar(#"player_laststandsuicidedelay", var_22e7a516);
  setDvar(#"hash_6e3f1e26256fe0b5", var_33682ca0);
  setDvar(#"player_respawndelay", var_fd9d63a8);
  level.var_a4107aed = var_fd9d63a8;
  level.var_cf393bff = var_dd639ef7;
  level.var_a164210a = var_8c4f976a;
  level.var_a6a26da0 = var_88dcf868;
  level.var_1cac200a = var_8f59489c;
  level.var_22895486 = var_880dfe56;
}
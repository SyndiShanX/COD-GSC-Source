/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_164a456ce05c3483.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1d730eca5a7f1fa8;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_role;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_7f5aeb59;

function function_c17e1c0e() {
  if(!isDefined(self.entnum)) {
    self.entnum = self getentitynumber();
  }

  count = getplayerroletemplatecount(currentsessionmode());

  if(!isDefined(self.doa.characterindex)) {
    self detachall();

    if(isbot(self)) {
      self.doa.characterindex = (self.entnum + 1) % count;
    } else {
      self.doa.characterindex = self player_role::function_2a911680();

      if(player_role::is_valid(self.doa.characterindex) == 0) {
        self.doa.characterindex = (self.entnum + 1) % count;
      }
    }

    self.pers[#"characterindex"] = self.doa.characterindex;
    self player_role::set(self.doa.characterindex);

    if(isbot(self)) {
      self setcharacterbodytype(self.doa.characterindex);
    }
  }
}

function function_f3143608() {
  self namespace_ec06fe4a::function_4f72130c();
  self.doa = spawnStruct();
  self function_c17e1c0e();
  self function_fcc90081(1);
  self enablelinkto();
  self.var_248bd83 = isDefined(level.doa.roundnumber) ? level.doa.roundnumber : 0;
  self.var_90b81208 = self.var_248bd83;

  if(isDefined(level.doa) && isDefined(level.doa.var_5c6568f4)) {
    self thread[[level.doa.var_5c6568f4]]();
  }

  self thread function_d09d2055();
  spawn_points = struct::get_array("info_player_start", "targetname");
  entnumber = self getentitynumber();

  if(spawn_points.size > entnumber) {
    self setorigin(spawn_points[entnumber].origin);
  }

  self thread function_c0310e2a();
}

function function_d09d2055() {
  self endon(#"disconnect");
  level endon(#"game_over");

  while(array::contains(function_a1ef346b(), self) == 0 || is_true(self.var_fcb4914a)) {
    self.ignoreme = 1;
    waitframe(1);
  }

  self.ignoreme = 0;
}

function function_b1a82efa(on) {
  self setclientuivisibilityflag("weapon_hud_visible", 0);
  self setclientuivisibilityflag("g_compassShowEnemies", 0);
  self setclientuivisibilityflag("hud_visible", 0);
  self setclientuivisibilityflag("radar_client", 0);
  self setclientuivisibilityflag("killcam_nemesis", 0);

  if(on) {
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("radar_client", 1);
    self setclientuivisibilityflag("g_compassShowEnemies", 1);
  }
}

function function_5b373dae() {
  if(isDefined(self) && isDefined(self.doa)) {
    self.doa.respawning = 0;
  }

  outcome = is_true(self.doa.var_5598fe58) ? # "win" : # "loss";
  self.pers[#"outcome"] = outcome;
}

function function_c5f9ea85() {
  self endon(#"disconnect");
  level endon(#"game_over");
  self notify("5cd715566984df2b");
  self endon("5cd715566984df2b");
  self.doa.var_370ac26d = 0;
  self.doa.var_d362196a = 0;
  self.doa.var_3b5fa231 = 0;
  var_8c201285 = getdvarint(#"hash_548f3080d78da0bf", 15000);
  var_e984c3d6 = getdvarint(#"hash_3a50a740f2de580a", 1);
  var_cdcdd992 = getdvarint(#"hash_7d3a5d6f06e77084", 1);
  var_e7044ceb = getdvarint(#"hash_507a96ed3222f607", 30) * 1000;
  gracetime = 0;
  var_b4cd1e7 = getdvarint(#"hash_eecbe9362e43cfb", 1);

  if(var_e984c3d6 <= 0) {
    return;
  }

  while(true) {
    wait var_cdcdd992;

    if(level.doa.world_state != 0) {
      continue;
    }

    if(isDefined(level.doa.var_6f3d327)) {
      continue;
    }

    time = gettime();

    if(level flag::get("doa_round_spawning") == 1) {
      gracetime = time + var_e7044ceb;
    }

    if(time - self.doa.var_9f897c4d > var_8c201285) {
      continue;
    }

    if(time > gracetime) {
      continue;
    }

    if(!is_true(self.doa.var_de92b533)) {
      continue;
    }

    if(is_true(self.doa.var_3b986d13)) {
      continue;
    }

    if(var_b4cd1e7 && self.doa.var_e940d370 > 60) {
      continue;
    }

    self.doa.var_d362196a += var_e984c3d6;
    self.doa.var_e46a9e57.var_e519217b += var_e984c3d6;
  }
}

function function_1782c6ad() {
  self notify("400c2841b71109a2");
  self endon("400c2841b71109a2");
  self endon(#"disconnect");
  level endon(#"game_over");

  if(!isDefined(self.doa.var_e940d370)) {
    self.doa.var_e940d370 = 0;
  }

  var_f3e30707 = 1;
  thresh = sqr(0.1);

  while(true) {
    wait var_f3e30707;
    self.doa.var_e940d370 += var_f3e30707;

    if(self function_8bc54983()) {
      continue;
    }

    if(is_true(self.laststand)) {
      continue;
    }

    var_f0202cc8 = self getnormalizedmovement();
    var_7e9d4f5b = lengthsquared(var_f0202cc8);

    if(var_7e9d4f5b > thresh) {
      self.doa.var_e940d370 = 0;
      continue;
    }

    var_85723ac6 = self getnormalizedcameramovement();
    var_7e9d4f5b = lengthsquared(var_85723ac6);

    if(var_7e9d4f5b > thresh) {
      self.doa.var_e940d370 = 0;
    }
  }
}

function function_bb0408ca() {
  self notify("9e38e954743f8e9");
  self endon("9e38e954743f8e9");

  if(!isDefined(self.doa.var_c739e4eb)) {
    self.doa.var_c739e4eb = 0;
  }

  if(!isDefined(self.doa.var_b8232cd0)) {
    self.doa.var_b8232cd0 = 0;
  }

  if(!isDefined(self.doa.var_8f47d882)) {
    self.doa.var_8f47d882 = 0;
  }

  if(!isDefined(self.doa.var_43c43abc)) {
    self.doa.var_43c43abc = 0;
  }

  if(!isDefined(self.doa.var_7f8d38c2)) {
    self.doa.var_7f8d38c2 = 0;
  }

  if(!getdvarint(#"hash_6f6352f5b03014a8", 1)) {
    return;
  }

  if(isbot(self)) {
    return;
  }

  self thread function_1782c6ad();
  self endon(#"disconnect", #"kicked");
  level endon(#"game_over");
  var_f3e30707 = 5;
  var_bc153d9a = getdvarint(#"hash_5cc1c07efe048c56", 300);
  var_af82a000 = var_bc153d9a - 30;

  while(level flag::get("doa_round_spawning") == 0) {
    wait 1;
  }

  self.doa.var_8f47d882 = 0;
  self.doa.var_b8232cd0 = level.doa.roundnumber;
  self.doa.var_e45f072b = gettime();

  while(true) {
    lastlevel = self.doa.var_8f47d882;

    wait var_f3e30707;

    if(level.doa.world_state !== 0) {
      self.doa.var_8f47d882 = 0;
      continue;
    }

    if(isDefined(level.doa.var_6f3d327)) {
      continue;
    }

    if(level flag::get("doa_round_spawning") == 0) {
      continue;
    }

    if(self function_8bc54983()) {
      continue;
    }

    var_b3b05c12 = 0;

    if(level.doa.roundnumber > self.var_90b81208) {
      var_b3b05c12 = level.doa.roundnumber - self.doa.var_b8232cd0;
    }

    if(is_true(self.laststand)) {
      if(var_b3b05c12 <= 1 && self.doa.var_7f8d38c2 < 300) {
        continue;
      }
    }

    time = gettime();

    if(time - self.doa.var_e45f072b > 60000) {
      self.doa.var_8f47d882 += var_f3e30707 + var_b3b05c12;
    } else if(self.doa.var_7f8d38c2 < 120) {
      self.doa.var_8f47d882 = 0;
    } else {
      self.doa.var_8f47d882 += var_f3e30707 + var_b3b05c12;
      self.doa.var_8f47d882 += int(self.doa.var_7f8d38c2 / 100);
    }

    if(lastlevel < var_af82a000 && self.doa.var_8f47d882 >= var_af82a000) {
      self iprintlnbold(#"hash_59bd89e170a924ac");
      namespace_1e25ad94::debugmsg("<dev string:x38>" + self.name);
    }

    if(self.doa.var_8f47d882 > var_bc153d9a) {
      namespace_1e25ad94::debugmsg("xxxxxxx Player being kicked for inactivity:" + self.name);
      var_9ebc9df6 = {
        #var_8f47d882: self.doa.var_8f47d882, #var_43c43abc: self.doa.var_43c43abc, #var_7f8d38c2: self.doa.var_7f8d38c2, #roundnumber: level.doa.roundnumber, #matchtime: gettime(), #ishost: self ishost()
      };
      var_9a24b67c = level.var_73ffa220[self.name];

      if(isDefined(var_9a24b67c)) {
        if(!isDefined(var_9a24b67c.var_7411a081)) {
          var_9a24b67c.var_7411a081 = 0;
        }

        var_9a24b67c.var_7411a081 += 1;
        level.var_73ffa220[self.name] = var_9a24b67c;
        var_9ebc9df6.var_502dc598 = var_9a24b67c.var_7411a081;
      }

      self function_678f57c8(#"hash_3e2a5a24655cd8c1", var_9ebc9df6);

      if(isdedicated()) {
        kick(self getentitynumber(), "GAME/DROPPEDFORINACTIVITY");
      } else if(self ishost() == 0) {
        kick(self getentitynumber(), "GAME/DROPPEDFORINACTIVITY");
      }

      self.doa.var_3b986d13 = 1;
      self notify(#"kicked");
      return;
    }
  }
}

function function_fcc90081(var_45b95f80 = 0) {
  if(!isDefined(self)) {
    return;
  }

  if(var_45b95f80) {
    namespace_1e25ad94::debugmsg("OoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOo");
    namespace_1e25ad94::debugmsg("PLAYER FULL INITIALIZE");
    self.doa.entnum = self getentitynumber();
    self.topdowncamera = 1;
    self.doa.infps = undefined;
    self.doa.var_370ac26d = 0;
    self.doa.var_e940d370 = 0;
    self.doa.camera_yaw = 0;
    self.doa.weapontype = 0;
    self.doa.weaponlevel = 0;
    self.doa.var_fd5fcb75 = "";
    self.doa.var_909a4dd5 = 0;
    self.doa.var_484cc88b = 0;
    self.doa.rof = undefined;
    self.doa.roj = undefined;
    self.doa.color = function_83fe843d(self);
    self.doa.var_d6b75dff = 0;
    self.doa.weapontime = 0;
    self.doa.var_d8955419 = 0;
    self.doa.var_e5805edb = 1;
    self.doa.var_77c8b9d4 = 0;
    self.doa.var_2d965438 = 0;
    self.doa.var_99c6ee47 = 0;
    self.doa.var_2c18f1d5 = 0;
    self.doa.var_d1d5998d = 0;
    self.doa.var_82fb5d17 = 0;
    self.doa.var_f583234e = 0;
    self.doa.var_ab338943 = 0;
    self.var_f16a71ae = 1;
    self.doa.var_4f3aee7b = undefined;
    self.doa.hintmask = 0;
    self.doa.var_ed8fde10 = "zombietron_lmg";
    self.lastnonkillstreakweapon = getweapon(self.doa.var_ed8fde10);
    self.doa.var_6b4163f1 = randomint(250);
    self.doa.var_ad888d1f = [];
    self setmovespeedscale(self.doa.var_e5805edb);
    self function_b1a82efa(1);
    self.health = 150;
    self.maxhealth = 150;
    self.doa.var_d0d6ce92 = [];
    self.doa.var_96ca2395 = 1;
    self.doa.var_7e445455 = 0;
    self.doa.var_90e186f2 = 0;
    self.doa.var_20c63763 = [];
    self.doa.var_bb4d9604 = [];

    if(isDefined(level.doa.var_d0b39b1a)) {
      self[[level.doa.var_d0b39b1a]]();
    }

    if(isDefined(level.doa.var_3bc55386)) {
      self[[level.doa.var_3bc55386]]();
    }

    if(isDefined(level.doa.var_502e9288)) {
      self[[level.doa.var_502e9288]]();
    }

    self.doa.var_11abc438 = self.origin;
    self function_c17e1c0e();
    self setperk("specialty_sprint");
    self setperk("specialty_seethroughjammer");
    self setperk("specialty_sprintreload");
    self setperk("specialty_slide");
    self setperk("specialty_showenemyvehicles");
    self.var_f07d3654 = 1;
    self thread function_77785447(0, 1);
    self thread namespace_491fa2b2::function_ebbc302();
    self hud_message::clearlowermessage();
    self setclientminiscoreboardhide(0);
    self.kills = 0;
    self.deaths = 0;
    self.headshots = 0;
    self.revives = 0;
    self.downs = 0;
    self.doa.var_9f897c4d = 0;
    self.doa.var_de92b533 = getdvarint(#"hash_d874e4e73e9f18", 0);
    self namespace_83eb6304::function_3ecfde67("player_trail_" + self.doa.color);
    self thread function_c5f9ea85();
    self thread function_bb0408ca();
  }

  assert(isDefined(self.doa.entnum), "<dev string:x5c>");
  self.ignoreme = 0;
  self.ignoremelee = 0;
  self.laststand = 0;
  self.doa.var_a5eb0385 = 0;
  self.doa.var_d524abd8 = 0;
  self.doa.var_dbe90a1f = 0;
  self.doa.var_9ff62c1c = 0;
  self.doa.var_9ca03c2f = 0;
  self.doa.var_ccd8393c = 0;
  self clientfield::set_to_player("showMap", 0);
  self namespace_41cb996::function_6c4d9896(self.doa.var_ed8fde10);
  self setplayercollision(1);
  self cleardamageindicator();
  self thread function_d690f109();

  if(isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback destroy();
    self.hud_damagefeedback = undefined;
  }

  self function_fae39d88();
  self thread function_e2104e07();

  if(isDefined(level.var_cee39136)) {
    self[[level.var_cee39136]](var_45b95f80);
  }

  if(isDefined(level.var_52f56101)) {
    self[[level.var_52f56101]](var_45b95f80);
  }

  if(self namespace_1c2a96f9::function_8a19ece()) {
    self namespace_b754744b::function_b784c6bd(46);
  }

  if(!isbot(self) && is_true(level.doa.var_318aa67a)) {
    self thread namespace_a4bedd45::function_1f704cee(1);
  }
}

function function_d690f109() {
  self endon(#"disconnect");
  waitframe(1);
  self clientfield::increment_to_player("controlBinding");
}

function function_fae39d88() {
  if(!is_true(level.var_fdf900b7)) {
    self disableweaponcycling();
  }

  self allowjump(is_true(self.doa.infps));
  self allowcrouch(0);
  self allowprone(0);
  self allowslide(is_true(self.doa.infps));
  self allowdoublejump(0);
  self allowwallrun(0);
  self allowmantle(0);
  self allowsprint(is_true(self.doa.infps));
  self allowads(is_true(self.doa.infps));
  self setstance("stand");
  self function_205350ab();
  self solid();
}

function function_83fe843d(player) {
  i = 0;

  if(is_true(level.var_29628b5f)) {
    if(self.team == # "allies") {
      return "blue";
    } else if(self.team == # "axis") {
      return "red";
    } else if(self.team == # "team3") {
      return "green";
    } else if(self.team == # "team4") {
      return "yellow";
    } else {
      return "yellow";
    }
  } else {
    i = player.entnum;
  }

  if(is_true(level.var_4ed7ab1b)) {
    i %= 4;
  }

  switch (i) {
    case 0:
      return "green";
    case 1:
      return "blue";
    case 2:
      return "red";
    case 3:
      return "yellow";
    default:
      assert(0, "<dev string:x8a>");
      break;
  }
}

function function_7781556b(origin, var_396c606d = 0) {
  valid_player_found = 0;
  players = getplayers();

  if(players.size > 1) {
    players = arraysortclosest(players, origin);
  }

  foreach(player in players) {
    if(isplayervalid(player, var_396c606d)) {
      return player;
    }
  }

  return undefined;
}

function isplayervalid(player, var_396c606d = 0) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isPlayer(player)) {
    return false;
  }

  if(var_396c606d && is_true(player.ignoreme)) {
    return false;
  }

  if(player.sessionstate == "spectator") {
    return false;
  }

  if(player.sessionstate == "intermission") {
    return false;
  }

  return true;
}

function function_2e8dc9d3(volume) {
  players = function_23e1f90f();

  foreach(player in players) {
    if(!player istouching(volume)) {
      return false;
    }
  }

  return true;
}

function function_23e1f90f() {
  players = [];

  foreach(player in getplayers()) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.doa)) {
      players[players.size] = player;
    }
  }

  return players;
}

function function_518c4c78() {
  players = [];

  foreach(player in getplayers()) {
    if(!isDefined(player)) {
      continue;
    }

    if(is_true(player.laststand)) {
      continue;
    }

    if(isDefined(player.doa)) {
      players[players.size] = player;
    }
  }

  return players;
}

function function_878118b() {
  var_a4af7793 = [];
  players = function_23e1f90f();

  foreach(player in players) {
    if(!is_true(player.laststand)) {
      continue;
    }

    if(player.doa.score.lives > 0) {
      continue;
    }

    var_a4af7793[var_a4af7793.size] = player;
  }

  return var_a4af7793;
}

function function_f08b75c1() {
  players = function_23e1f90f();
  return players.size;
}

function function_88b90714(var_9618185e = 2) {
  players = function_23e1f90f();
  most = undefined;
  var_8bc263b9 = 0;

  foreach(player in players) {
    if(player.doa.score.lives <= var_9618185e) {
      continue;
    }

    if(player.doa.score.lives > var_8bc263b9) {
      most = player;
      var_8bc263b9 = player.doa.score.lives;
    }
  }

  return most;
}

function function_519ae1ed(origin, &entarray, maxdist = 2048) {
  if(!isDefined(entarray)) {
    return;
  }

  if(entarray.size == 0) {
    return;
  }

  if(entarray.size == 1) {
    return entarray[0];
  }

  return arraygetclosest(origin, entarray, maxdist);
}

function function_b9e8248(origin, var_af6dcc26 = 1024) {
  sqrdist = sqr(var_af6dcc26);
  playersinrange = [];
  players = getplayers();

  foreach(player in players) {
    distsq = distancesquared(origin, player.origin);

    if(distsq < sqrdist) {
      if(!isDefined(playersinrange)) {
        playersinrange = [];
      } else if(!isarray(playersinrange)) {
        playersinrange = array(playersinrange);
      }

      playersinrange[playersinrange.size] = player;
    }
  }

  return playersinrange;
}

function function_aab26933(origin, var_af6dcc26 = 1024) {
  return function_b9e8248(origin, var_af6dcc26).size;
}

function function_19616199() {
  self endon(#"disconnect");
  level endon(#"game_over");
  self notify("<dev string:xac>");
  self endon("<dev string:xac>");

  while(is_true(level.doa.var_2e491399)) {
    waitframe(1);

    if(self getinvulnerability() || is_true(self.doa.var_221ef439)) {
      level thread namespace_1e25ad94::function_e8f2d12c(self.origin, 60, 72, 1, (1, 0, 0));
    }
  }
}

function function_77785447(on, clear = 0) {
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }

  if(!isDefined(self.doa.var_221ef439)) {
    self.doa.var_221ef439 = 0;
  }

  namespace_1e25ad94::debugmsg("Player(" + self.doa.color + ") playerInvulnerability active: " + (on ? "true" : "false") + "clear: " + (clear ? "true" : "false"));

  if(clear) {
    self.doa.var_221ef439 = 0;
  }

  if(on) {
    self.doa.var_221ef439++;
  } else {
    self.doa.var_221ef439--;
  }

  if(self.doa.var_221ef439 > 0) {
    self enableinvulnerability();
    self.takedamage = 0;
  } else {
    self.doa.var_221ef439 = 0;
    self disableinvulnerability();
    self.takedamage = 1;
  }

  namespace_1e25ad94::debugmsg("Player(" + self.doa.color + ") invulRefCount: " + (isDefined(self.doa.var_221ef439) ? self.doa.var_221ef439 : "undefined"));
}

function function_61bccc9() {
  return isDefined(self.doa.var_9cd55f0c) && self.doa.var_9cd55f0c.activetime >= gettime();
}

function function_9fb6b320() {
  if(isDefined(self.doa.var_9cd55f0c)) {
    self.doa.var_9cd55f0c.activetime = 0;
  }

  self namespace_83eb6304::turnofffx("player_shield_short");
  self namespace_83eb6304::turnofffx("player_shield_short_sideView");
  self namespace_83eb6304::turnofffx("player_shield_long");
  self namespace_83eb6304::turnofffx("player_shield_long_sideView");
}

function turnplayershieldon(var_b5c21d1f = 1) {
  if(!isPlayer(self)) {
    return;
  }

  self endon(#"disconnect");
  self endon(#"enter_vehicle");
  self notify("431def54bc611a4b");
  self endon("431def54bc611a4b");

  if(!isDefined(self.doa) || isDefined(self.doa.vehicle)) {
    return;
  }

  if(!is_true(self.doa.var_c026f7c9)) {
    self namespace_e32bb68::function_3a59ec34("evt_doa_player_shield_start");
  }

  if(!var_b5c21d1f) {
    self namespace_e32bb68::function_3a59ec34("evt_doa_player_shield_full");
  }

  if(!isDefined(self.doa.var_9cd55f0c)) {
    self.doa.var_9cd55f0c = namespace_ec06fe4a::spawntrigger("trigger_radius", self.origin, 1 | 512 | 8 | 16, 60, 72);
    self.doa.var_9cd55f0c.activetime = 0;
    self.doa.var_9cd55f0c thread namespace_ec06fe4a::function_ae010bb4(self);
    self.doa.var_9cd55f0c thread namespace_ec06fe4a::function_d55f042c(level, "game_over");
    self.doa.var_9cd55f0c.targetname = "turnPlayerShieldOn";
    self.doa.var_9cd55f0c enablelinkto();
    self.doa.var_9cd55f0c linkto(self);
    self.doa.var_9cd55f0c thread function_19f387a(self);
  }

  if(var_b5c21d1f) {
    activetime = gettime() + 3500;

    if(self.doa.var_9cd55f0c.activetime < activetime) {
      self.doa.var_9cd55f0c.activetime = activetime;
    }

    if(!is_true(level.doa.var_af74d0b)) {
      self namespace_83eb6304::function_3ecfde67("player_shield_short");
    } else {
      self namespace_83eb6304::function_3ecfde67("player_shield_short_sideView");
    }
  } else {
    self.doa.var_9cd55f0c.activetime = gettime() + 9500;

    if(!is_true(level.doa.var_af74d0b)) {
      self namespace_83eb6304::function_3ecfde67("player_shield_long");
    } else {
      self namespace_83eb6304::function_3ecfde67("player_shield_long_sideView");
    }

    wait 6;
  }

  self namespace_e32bb68::function_3a59ec34("evt_doa_player_shield_half");
  wait 3;
  self namespace_e32bb68::function_3a59ec34("evt_doa_player_shield_stop");
}

function function_9f177b30(player) {
  self endon(#"death");
  level endon(#"game_over");

  while(true) {
    if(player function_61bccc9()) {
      level thread namespace_1e25ad94::function_e8f2d12c(self.origin, 60, 72, 1, (1, 0, 0));
    }

    waitframe(1);
  }
}

function function_19f387a(player, var_ca85cba1, thresh, boosting = 0) {
  self endon(#"death");

  if(getdvarint(#"hash_e71870b070f9374", 0)) {
    self thread function_9f177b30(player);
  }

  self thread function_e93fae6f(player);
  self.player = player;

  while(isDefined(player)) {
    waitresult = self waittill(#"trigger");

    if(self.activetime < gettime()) {
      continue;
    }

    guy = waitresult.activator;

    if(!isDefined(player.team)) {
      continue;
    }

    if(!isDefined(guy)) {
      continue;
    }

    if(isPlayer(guy)) {
      continue;
    }

    if(isDefined(guy.launched)) {
      continue;
    }

    if(!issentient(guy)) {
      continue;
    }

    if(!is_true(guy.takedamage)) {
      continue;
    }

    if(is_true(guy.var_3505487) || is_true(guy.boss)) {
      continue;
    }

    if(!isDefined(guy.team)) {
      continue;
    }

    if(guy.team === player.team) {
      continue;
    }

    if(isDefined(guy.var_9cb9d79f) && gettime() < guy.var_9cb9d79f) {
      continue;
    }

    ok = 1;

    if(isDefined(var_ca85cba1)) {
      v_velocity = var_ca85cba1 getvelocity();
      speed = lengthsquared(v_velocity);

      ok = speed < sqr(thresh);
    }

    if(!ok) {
      continue;
    }

    guy setplayercollision(0);
    guy.var_eeaac918 = boosting;
    guy.shieldhit = 1;

    if(!isvehicle(guy)) {
      if(!is_true(guy.var_e66cd6fb)) {
        guy.launched = 1;

        if(is_true(guy.var_4dcf6637) || randomint(100) < 50) {
          velocity = namespace_ec06fe4a::function_9d713536(player getvelocity());

          if(velocity > 30 && !is_true(guy.no_gib)) {
            guy thread namespace_83eb6304::function_3ecfde67("boost_explode");
            namespace_ed80aead::trygibbinglimb(guy, 5000);
            namespace_ed80aead::trygibbinglegs(guy, 5000, undefined, undefined, undefined, 1, player);
          }

          assert(!is_true(guy.boss));
          guy thread namespace_ec06fe4a::function_b4ff2191((0, 0, 220), 180, 0.3, player);
          guy namespace_e32bb68::function_3a59ec34("zmb_ragdoll_launched");
        } else {
          guy.annihilate = 1;
          guy dodamage(guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE", 0, level.doa.default_weapon);
        }
      } else {
        guy dodamage(guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE", 0, level.doa.default_weapon);
      }

      continue;
    }

    guy dodamage(guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE", 0, level.doa.default_weapon);
  }

  self delete();
}

function private function_e93fae6f(player) {
  self endon(#"death");

  if(!isDefined(level.doa) || !isDefined(level.doa.var_f9c9c0)) {
    return;
  }

  while(true) {
    foreach(hazard in level.doa.var_f9c9c0) {
      if(isDefined(hazard) && self istouching(hazard) && isDefined(hazard.death_func)) {
        hazard thread[[hazard.death_func]]();
      }
    }

    wait 0.1;
  }
}

function function_a8b57c52(var_2784b779, angles, ignore, var_b498e4b0) {
  players = getplayers();

  foreach(player in players) {
    player notify(#"hash_279998c5df86c04d");
    player notify(#"hash_7893364bd228d63e");
  }

  wait 0.2;
  players = getplayers();
  offset = (8, -8, 0);

  foreach(player in players) {
    player thread turnplayershieldon(0);

    if(isDefined(ignore)) {
      if(isarray(ignore)) {
        if(isinarray(ignore, player)) {
          continue;
        }
      } else if(player === ignore) {
        continue;
      }
    }

    if(isDefined(var_b498e4b0) && player istouching(var_b498e4b0)) {
      continue;
    }

    player setorigin(var_2784b779);
    player setplayerangles(angles);
    var_2784b779 += offset;
    offset *= -1;
  }
}

function function_c0310e2a() {
  if(!getdvarint(#"hash_2364dfae0e289844", 0)) {
    return;
  }

  while(true) {
    if(self stancebuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:xc0>");
    }

    if(self fragButtonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:xe1>");
    }

    if(self reloadbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x100>");
    }

    if(self secondaryoffhandbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x121>");
    }

    if(self inventorybuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x14c>");
    }

    if(self offhandspecialbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x170>");
    }

    if(self weaponswitchbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x199>");
    }

    if(self vehiclemoveupbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x1c0>");
    }

    if(self actionbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x1e8>");
    }

    if(self jumpbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x209>");
    }

    if(self sprintbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x228>");
    }

    if(self meleeButtonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x249>");
    }

    if(self throwbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x269>");
    }

    if(self adsButtonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x289>");
    }

    if(self actionslotfourbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x2a7>");
    }

    if(self actionslotthreebuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x2d0>");
    }

    if(self actionslottwobuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x2fa>");
    }

    if(self actionslotonebuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x322>");
    }

    if(self attackButtonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x34a>");
    }

    if(self boostbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x36b>");
    }

    if(self changeseatbuttonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x38b>");
    }

    if(self useButtonPressed()) {
      namespace_1e25ad94::debugmsg("<dev string:x3b0>");
    }

    waitframe(1);
  }
}

function function_5ed5daa7() {
  assert(isDefined(self.doa));

  if(self namespace_1c2a96f9::function_d17f9bcb()) {
    self.doa.score.boosts = int(max(self.doa.score.boosts, 2));
  } else if(!is_true(level.doa.hardcoremode)) {
    self.doa.score.boosts = int(max(self.doa.score.boosts, 1));
  }

  if(self namespace_1c2a96f9::function_8a19ece()) {
    self.doa.score.bombs = int(max(self.doa.score.bombs, 2));
    roll = randomint(30);

    if(roll < 10) {
      level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_barrel"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    } else if(roll < 10) {
      level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_boxing_glove"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    } else {
      level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_sawblade"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    }
  } else if(!is_true(level.doa.hardcoremode)) {
    self.doa.score.bombs = int(max(self.doa.score.bombs, 1));
  }

  self.health = self.maxhealth;
  self.ignoreme = 0;
}

function function_d0251f76(var_8987df35 = 1) {
  players = function_23e1f90f();

  foreach(player in players) {
    if(!isalive(player) || is_true(player.doa.respawning)) {
      player function_513831e1();
    }

    if(is_true(var_8987df35)) {
      player function_5ed5daa7();
    }

    player.doa.var_d320bb5d = undefined;
    player namespace_83eb6304::turnofffx("lantern_fade");
    player namespace_83eb6304::turnofffx("lantern");
    player notify(#"lantern_terminated");

    if(isDefined(player.doa.var_ad639ebd)) {
      player.doa.var_ad639ebd delete();
    }

    player.doa.var_f583234e = 0;
    player clientfield::set_to_player("toggleflashlight", player.doa.var_f583234e);
  }
}

function function_f1584766() {
  self endon(#"disconnect");
  level endon(#"game_over");
  self notify("36b3a11379cb0ab6");
  self endon("36b3a11379cb0ab6");
  self clientfield::set_to_player("lastStand", 3);
  util::wait_network_frame();
  self clientfield::set_to_player("lastStand", 0);
}

function function_513831e1(var_c4b5b87c = 0, spot = undefined) {
  self endon(#"disconnect");
  level endon(#"game_over");

  if(!isDefined(self)) {
    return;
  }

  assert(isDefined(self.doa));
  namespace_1e25ad94::debugmsg("player respawning now");
  self.doa.respawning = 0;
  self namespace_ec06fe4a::function_4f72130c();
  self notify(#"hash_10722eb37778c51c");
  self undolaststand();
  self.laststand = 0;
  level.doa.var_a4af7793 = function_878118b();
  self solid();
  self thread function_f1584766();
  namespace_1e25ad94::debugmsg("player respawning stage 1 complete");
  self.doa.var_fd5fcb75 = "";
  self laststand_enable_player_weapons();
  self reviveplayer();
  self.health = 150;

  if(!isDefined(spot)) {
    spot = self.origin;
  }

  if(isDefined(self.revivetrigger)) {
    self.revivetrigger delete();
  }

  self setorigin(spot);
  namespace_1e25ad94::debugmsg("player respawning stage 2 complete");

  if(namespace_ec06fe4a::function_a8975c67()) {
    self playSound("zmb_player_respawn");
  }

  self namespace_83eb6304::turnofffx("remote_player_busy");
  self namespace_83eb6304::function_3ecfde67("player_respawn_" + self.doa.color);
  self function_9fb6b320();
  self function_77785447(0, 1);
  self thread function_fcc90081(var_c4b5b87c);
  namespace_1e25ad94::debugmsg("player respawning stage 3 complete");

  if(!var_c4b5b87c) {
    self thread turnplayershieldon(0);
  }

  self setplayercollision(1);
  self namespace_ec06fe4a::freezeplayercontrols(0);
  self.dead = undefined;
  self.var_4a81243b = undefined;
  self notify(#"player_respawned");
  namespace_1e25ad94::debugmsg("player respawning stage 4 complete");

  if(!var_c4b5b87c && self.doa.score.lives) {
    self.doa.score.lives--;

    if(self.doa.score.lives < 0) {
      self.doa.score.lives = 0;
    }
  }

  if(self namespace_1c2a96f9::function_b01c3b20()) {
    self thread function_a99cfd4f();
  }

  namespace_1e25ad94::debugmsg("player respawn done");
}

function function_ebcb2cca() {
  self notify("1f5d820c2540adbe");
  self endon("1f5d820c2540adbe");
  self endon(#"hash_79990404aaa9d9df");
  level endon(#"game_over");
  rate = 2;

  if(self namespace_1c2a96f9::function_b01c3b20()) {
    rate += 2;
  }

  while(isDefined(self)) {
    if(self.health < self.maxhealth && !is_true(self.doa.respawning)) {
      self.health += rate;

      if(self.health > self.maxhealth) {
        self.health = self.maxhealth;
      }
    }

    wait 1;
  }
}

function function_5934bbc8() {
  switch (self.doa.color) {
    case # "green":
      return (0, 1, 0);
    case # "blue":
      return (0, 0, 1);
    case # "red":
      return (1, 0, 0);
    case # "yellow":
      return (1, 1, 0);
    default:
      return (1, 1, 1);
  }
}

function function_f8645db3(var_370ac26d, var_2f0c0007 = 0) {
  if(!getdvarint(#"hash_73899531201aebda", 1)) {
    return;
  }

  var_b4cd1e7 = getdvarint(#"hash_eecbe9362e43cfb", 1);

  if(getdvarint(#"hash_262e5087a510a8dc", 0)) {
    var_370ac26d = int(var_370ac26d * getdvarfloat(#"hash_7c25854640e0d84", 1));

    if(var_370ac26d <= 0) {
      return;
    }

    foreach(player in function_23e1f90f()) {
      if(!is_true(player.doa.var_de92b533)) {
        continue;
      }

      if(is_true(player.doa.var_3b986d13)) {
        continue;
      }

      if(var_b4cd1e7 && player.doa.var_e940d370 > 60) {
        continue;
      }

      player.doa.var_370ac26d += var_370ac26d;
      player addrankxpvalue("wave_end_xp", var_370ac26d, 4);
      player.doa.var_d362196a += var_2f0c0007;
      player.doa.var_e46a9e57.var_e519217b += var_2f0c0007;
      player luinotifyevent(#"hash_3e6dd0ad7b864154", 1, var_370ac26d);
    }
  }
}

function function_67f054d7(duration = 2) {
  if(is_true(level.var_b62ca8c)) {
    return;
  }

  self notify("6c6ed02dd79ce3ab");
  self endon("6c6ed02dd79ce3ab");
  level notify(#"hash_7893364bd228d63e");
  players = getplayers();

  foreach(player in players) {
    player thread lui::screen_fade_out(duration);
  }

  while(duration > 0) {
    waitframe(1);
    duration -= float(function_60d95f53()) / 1000;
    namespace_ec06fe4a::function_445bad70(1);
  }

  util::wait_network_frame();
  self notify(#"hash_1b322de3d2e3e781");
}

function function_ec758d18() {
  players = getplayers();

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.birthtime == gettime()) {
      waitframe(1);
    }

    player clientfield::increment_to_player("controlBinding");
  }
}

function function_836aeb74(duration = 2) {
  if(is_true(level.var_b62ca8c)) {
    return;
  }

  self notify("5404e528969e8691");
  self endon("5404e528969e8691");
  level notify(#"hash_7893364bd228d63e");
  namespace_ec06fe4a::function_445bad70(0);
  players = getplayers();

  foreach(player in players) {
    if(isDefined(player.var_d57eeb7f) && player.var_d57eeb7f == 0) {
      continue;
    }

    if(is_true(player.is_ready)) {
      player thread lui::function_a6eb5334(duration);
    }
  }

  wait duration;
  level.doa.var_270a21a3 = undefined;
  self notify(#"hash_58caf0ade03043bb");
}

function function_96c20925(duration = 2) {
  self namespace_ec06fe4a::freezeplayercontrols(0);
  self thread lui::function_a6eb5334(duration);
  wait duration;
}

function private function_f83ea3c(var_832465bf = 0, timeout = 30) {
  self notify("71224d58adf53617");
  self endon("71224d58adf53617");
  self endon(#"disconnect");
  result = self waittilltimeout(timeout, #"speed_change", #"entering_last_stand", #"speed_expired");

  if(!var_832465bf) {
    self.doa.fast_feet = undefined;
    self namespace_83eb6304::turnofffx("boots");
    self namespace_e32bb68::function_ae271c0b("evt_doa_pickup_boots_active_lp");
  } else {
    self.doa.var_51a3bdbd = undefined;
    self namespace_83eb6304::turnofffx("nova_crawler_aura_fx");
    self namespace_e32bb68::function_ae271c0b("zmb_pwup_slowspeed_loop");
    self namespace_e32bb68::function_3a59ec34("zmb_pwup_slowspeed_end");
  }

  self setmovespeedscale(self.doa.var_e5805edb);
}

function function_ec9a307f(time = 5, rate = 0.7, var_72515092) {
  if(self function_61bccc9()) {
    return;
  }

  if(self getinvulnerability() || is_true(self.doa.var_221ef439)) {
    return;
  }

  self endon(#"disconnect", #"speed_expired");
  self notify("76d57869838de475");
  self endon("76d57869838de475");

  if(isDefined(self.doa.fast_feet)) {
    self notify(#"speed_change");
    waitframe(1);
  }

  self thread function_f83ea3c(1, time + 1);

  if(!isDefined(self.doa.var_51a3bdbd)) {
    self.doa.var_51a3bdbd = 1;
    self namespace_e32bb68::function_3a59ec34("zmb_pwup_slowspeed_loop");
    self namespace_83eb6304::function_3ecfde67("nova_crawler_aura_fx");
    self setmovespeedscale(rate);
  }

  if(isDefined(var_72515092)) {
    var_8937f972 = gettime() + var_72515092 * 1000;

    while(isDefined(level.doa.var_6f3d327) && gettime() < var_8937f972) {
      wait 0.25;
    }
  }

  self.doa.var_2161f996 = gettime() + time * 1000;

  while(self.doa.var_2161f996 > gettime() && is_true(self.doa.var_51a3bdbd)) {
    wait 0.25;
  }

  if(is_true(self.doa.var_51a3bdbd)) {
    self notify(#"speed_expired");
  }
}

function function_a99cfd4f(time = 25, rate = 1.5) {
  self endon(#"disconnect", #"speed_expired");
  self notify("7b715a49733901ae");
  self endon("7b715a49733901ae");

  if(isDefined(self.doa.var_51a3bdbd)) {
    self notify(#"speed_change");
    waitframe(1);
  }

  self thread function_f83ea3c(0, time);

  if(!is_true(self.doa.fast_feet)) {
    self.doa.fast_feet = 1;
    self namespace_e32bb68::function_3a59ec34("evt_doa_pickup_boots_active_lp");
    self thread namespace_83eb6304::function_3ecfde67("boots");
    self setmovespeedscale(rate);
  }

  self.doa.var_3c533d1a = gettime() + time * 1000;

  while(self.doa.var_3c533d1a > gettime() && is_true(self.doa.fast_feet)) {
    wait 0.35;
  }

  if(is_true(self.doa.fast_feet)) {
    self notify(#"speed_expired");
  }
}

function laststand_disable_player_weapons() {
  self giveweapon(level.laststandweapon);
  self givemaxammo(level.laststandweapon);
  self switchtoweaponimmediate(level.laststandweapon, 1);
  self disableweaponcycling();
  self disableoffhandweapons();
}

function laststand_enable_player_weapons() {
  self endon(#"disconnect");
  self takeweapon(level.laststandweapon);
  self enableweaponcycling();
  self enableoffhandweapons();
  self enableusability();
  self namespace_41cb996::function_6c4d9896(self.doa.var_ed8fde10);
}

function function_884143e(attacker) {
  if(isDefined(attacker)) {
    level thread namespace_1e25ad94::debugcircle(attacker.origin + (0, 0, 12), 40, 10, (1, 0, 0));
    level thread namespace_1e25ad94::debugline(self.origin + (0, 0, 12), attacker.origin + (0, 0, 12), 10, (1, 0, 0));
    attacker thread namespace_1e25ad94::debugorigin(10, 24, (1, 0, 0));

    if(isDefined(attacker.zombie_type)) {
      text = attacker.zombie_type;
    } else if(isDefined(attacker.var_fd5301f9)) {
      text = attacker.var_fd5301f9;
    } else if(isDefined(attacker.model)) {
      text = function_9e72a96(attacker.model);
    } else if(isDefined(attacker.targetname)) {
      text = function_9e72a96(attacker.targetname);
    } else if(isDefined(attacker.classname)) {
      text = function_9e72a96(attacker.classname);
    } else {
      text = "<dev string:x3ce>";
    }

    level thread namespace_1e25ad94::function_75ebaff2(text, 10, attacker);
  }
}

function function_52392bd1(long = 0) {
  self endon(#"disconnect");
  level endon(#"game_over");

  if(!long) {
    self thread namespace_6e90e490::function_47e11416(2, undefined, 1);
    return;
  }

  while(is_true(self.laststand)) {
    wait randomint(15);

    if(level flag::get("doa_round_paused")) {
      continue;
    }

    if(is_true(self.laststand)) {
      self thread namespace_6e90e490::function_47e11416(3);
    }
  }
}

function function_12bdee53(clone, player) {
  if(isPlayer(player) && isai(clone)) {
    if(player function_390cb543()) {
      var_1749f1e8 = player function_92ea4100();

      if(isDefined(var_1749f1e8)) {
        clone setModel(var_1749f1e8);
      }

      headmodel = player startquantity();

      if(isDefined(headmodel)) {
        if(isDefined(clone.head)) {
          clone detach(clone.head);
        }

        clone attach(headmodel);
      }

      if(isDefined(clone.legs)) {
        clone detach(clone.legs);
      }

      if(isDefined(clone.torso)) {
        clone detach(clone.torso);
      }
    } else {
      var_41206ae3 = player function_5d23af5b();

      if(isDefined(var_41206ae3)) {
        clone setModel(var_41206ae3);
      }

      headmodel = player startquantity();

      if(isDefined(headmodel) && headmodel != # "tag_origin") {
        if(isDefined(clone.head)) {
          clone detach(clone.head);
        }

        clone attach(headmodel);
      }

      var_b4d88433 = player function_cde23658();

      if(isDefined(var_b4d88433) && var_b4d88433 != # "tag_origin") {
        if(isDefined(clone.legs)) {
          clone detach(clone.legs);
        }

        clone attach(var_b4d88433);
      }

      var_1749f1e8 = player function_92ea4100();

      if(isDefined(var_1749f1e8) && var_1749f1e8 != # "tag_origin") {
        if(isDefined(clone.torso)) {
          clone detach(clone.torso);
        }

        clone attach(var_1749f1e8);
      }
    }

    clone function_1fac41e4(player function_19124308());
  }
}

function function_31df67c1(player) {
  if(isDefined(player.doa.currentweapon)) {
    self shared::placeweaponon(player.doa.currentweapon, "right");
  }
}

function function_f98b7b5f(player) {
  var_41206ae3 = player function_5d23af5b();
  headmodel = player startquantity();
  var_b4d88433 = player function_cde23658();
  var_1749f1e8 = player function_92ea4100();
  clone = namespace_ec06fe4a::spawnmodel(player.origin, "tag_origin", player.angles, "player clone model");

  if(isDefined(var_41206ae3)) {
    clone setModel(var_41206ae3);
  }

  if(isDefined(headmodel) && headmodel != # "tag_origin") {
    clone attach(headmodel);
  }

  if(isDefined(var_b4d88433) && var_b4d88433 != # "tag_origin") {
    clone attach(var_b4d88433);
  }

  if(isDefined(var_1749f1e8) && var_1749f1e8 != # "tag_origin") {
    clone attach(var_1749f1e8);
  }

  return clone;
}

function function_e2104e07() {
  self endon(#"disconnect");
  self notify("df477f468230c60");
  self endon("df477f468230c60");

  while(true) {
    waitframe(1);
    self function_8fef418b();
  }
}

function function_6c074975() {
  switch (level.doa.world_state) {
    case 0:
      lookahead = 0.45;
      break;
    case 4:
      lookahead = 0.65;
      break;
    case 5:
      lookahead = 0.55;
      break;
    default:
      lookahead = 0.45;
      break;
  }

  if(!isDefined(self.doa.predicted_pos)) {
    self.doa.predicted_pos = self.origin;
  }

  velocity = self getvelocity();
  self.doa.predicted_pos = self.origin + velocity * lookahead;
  return self.doa.predicted_pos;
}

function function_8fef418b() {
  if(!isDefined(self.last_valid_position)) {
    self.last_valid_position = getclosestpointonnavmesh(self.origin, 2048, 0);
  }

  if(!isDefined(self.playerradius)) {
    self.playerradius = 24;
  }

  if(!isDefined(self.var_f09063b2)) {
    self.var_f09063b2 = sqr(self.playerradius);
  }

  if(!isDefined(self.last_valid_position)) {
    return;
  }

  if(isDefined(self.doa.vehicle)) {
    if(isDefined(self.doa.var_baad518e)) {
      origin = self.doa.var_baad518e;
    } else {
      origin = self.doa.vehicle.origin;
    }
  } else if(1 && !is_true(self.doa.var_ce4f08d9)) {
    if(is_true(self.doa.var_c026f7c9)) {
      origin = self.origin;
    } else {
      origin = function_6c074975();
    }
  } else {
    origin = self.origin;
  }

  if(ispointonnavmesh(self.last_valid_position) && distance2dsquared(origin, self.last_valid_position) < sqr(self.playerradius) && sqr(origin[2] - self.last_valid_position[2]) < sqr(16)) {
    return;
  }

  if(self isplayerswimming()) {
    if(isDefined(self.var_5d991645)) {
      if(distancesquared(origin, self.var_5d991645) < sqr(self.playerradius)) {
        return;
      }
    }

    ground_pos = groundtrace(origin + (0, 0, 8), origin + (0, 0, -100000), 0, self)[#"position"];

    if(!isDefined(ground_pos)) {
      return;
    }

    position = getclosestpointonnavmesh(ground_pos, 256, self.playerradius);

    if(isDefined(position)) {
      self.last_valid_position = position;
      self.var_5d991645 = origin;
    }

    return;
  }

  if(ispointonnavmesh(origin, self.playerradius)) {
    self.last_valid_position = origin;
    return;
  }

  if(ispointonnavmesh(self.last_valid_position, self.playerradius) && distance2dsquared(origin, self.last_valid_position) < self.var_f09063b2 && sqr(origin[2] - self.last_valid_position[2]) < self.var_f09063b2) {
    return;
  }

  position = getclosestpointonnavmesh(origin, 100, self.playerradius);

  if(isDefined(position)) {
    self.last_valid_position = position;
  }
}

function function_a74228bc(value = 450) {
  self notify("2478a2fd5b5b309f");
  self endon("2478a2fd5b5b309f");
  self endon(#"disconnect");
  self.doa.var_9ff62c1c += value;
  var_60323adb = 6;

  while(self.doa.var_9ff62c1c > 0) {
    waitframe(1);
    self.doa.var_9ff62c1c = math::clamp(self.doa.var_9ff62c1c - var_60323adb, 0, self.doa.var_9ff62c1c);
  }
}

function function_61d74d57() {
  self.var_85f8774c = 1;
  arrayremovevalue(self.doa.var_20c63763, undefined);

  foreach(chicken in self.doa.var_20c63763) {
    if(isDefined(chicken)) {
      chicken.var_85f8774c = 1;
    }
  }
}
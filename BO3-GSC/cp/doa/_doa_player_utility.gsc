/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_player_utility.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\doa\_doa_arena;
#using scripts\cp\doa\_doa_core;
#using scripts\cp\doa\_doa_dev;
#using scripts\cp\doa\_doa_fate;
#using scripts\cp\doa\_doa_fx;
#using scripts\cp\doa\_doa_gibs;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_round;
#using scripts\cp\doa\_doa_score;
#using scripts\cp\doa\_doa_sfx;
#using scripts\cp\doa\_doa_shield_pickup;
#using scripts\cp\doa\_doa_tesla_pickup;
#using scripts\cp\doa\_doa_turret_pickup;
#using scripts\cp\doa\_doa_utility;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace namespace_831a4a7c;

function function_138c35de() {
  self show();
  if(!isDefined(self.entnum)) {
    self.entnum = self getentitynumber();
  }
  assert(!isDefined(self.doa), "");
  level flagsys::wait_till("doa_init_complete");
  self setthreatbiasgroup("players");
  self setcharacterbodytype(self.entnum, self.entnum);
  self setcharacterbodystyle(0);
  self setcharacterhelmetstyle(0);
  self.doa = spawnStruct();
  self enablelinkto();
  self thread turnplayershieldon(0);
  self thread function_bbb1254c(1);
  if(isDefined(level.doa) && isDefined(level.doa.var_bc9b7c71)) {
    self thread[[level.doa.var_bc9b7c71]]();
  }
  self thread function_7d7a7fde();
  self function_60123d1c();
  self thread function_70339630();
}

function function_70339630() {
  self endon("disconnect");
  while(array::contains(level.activeplayers, self) == 0) {
    self.ignoreme = 1;
    wait(0.05);
  }
  self.ignoreme = 0;
}

function function_bbb1254c(var_44eb97b0 = 0) {
  if(!isDefined(self)) {
    return;
  }
  self.doa.multiplier = 1;
  self.doa.var_d55e6679 = 0;
  self.doa.var_5d2140f2 = level.doa.rules.var_a9114441;
  self.doa.var_a3f61a60 = isDefined(self.doa.var_65f7f2a9) && (self.doa.var_65f7f2a9 ? 4 : 0);
  self.doa.default_movespeed = 1;
  self.doa.var_f89dbefa = 0;
  self.doa.var_91c268dc = 0;
  self.doa.weaponlevel = 0;
  self.doa.var_c2b9d7d0 = 0;
  if(!(isDefined(self.doa.var_65f7f2a9) && self.doa.var_65f7f2a9)) {
    self.topdowncamera = 1;
  }
  self.ignoreme = 0;
  self.doa.respawning = 0;
  self.doa.var_b08ad9f8 = [];
  self thread namespace_eaa992c::turnofffx("reviveAdvertise");
  self thread namespace_eaa992c::turnofffx("reviveActive");
  self thread namespace_eaa992c::turnofffx("down_marker_" + function_ee495f41(self.entnum));
  self thread namespace_eaa992c::turnofffx("stunbear");
  self thread namespace_eaa992c::turnofffx("stunbear_fade");
  self thread namespace_eaa992c::turnofffx("slow_feet");
  self thread namespace_eaa992c::turnofffx("web_contact");
  if(var_44eb97b0) {
    self.headshots = 0;
    self.downs = 0;
    self.revives = 0;
    self.score = 0;
    self.assists = 0;
    self.kills = 0;
    self.deaths = 0;
    self.chickens = 0;
    self.gems = 0;
    self.skulls = 0;
    self.doa.var_e1956fd2 = 0;
    self.doa.score = 0;
    self.doa.var_db3637c0 = 0;
    self.doa.kills = 0;
    self.doa.var_74c73153 = 0;
    self.doa.var_d92a8d3e = 0;
    self.doa.var_ec573900 = 0;
    self.doa.var_130471f = 0;
    self.doa.var_53bd6cfa = 0;
    self.doa.skulls = 0;
    self.doa.gems = 0;
    self.doa.var_52e89a72 = 0;
    self.doa.var_fda5a6e5 = 0;
    self.doa.var_6946711f = 0;
    self.doa.var_67cd9d65 = 0;
    self.doa.var_bfe4f859 = 0;
    self.doa.var_faf30682 = 0;
    self.doa.fate = 0;
    self.doa.bombs = level.doa.rules.var_812a15ac;
    self.doa.boosters = level.doa.rules.var_ec21c11e;
    self.doa.lives = level.doa.rules.var_1a69346e;
    self.doa.default_weap = getweapon(level.doa.rules.default_weapon);
    self.doa.var_295df6ca = level.doa.rules.var_61b88ecb;
    self.doa.var_9742391e = 1;
    self.doa.var_c5fe2763 = undefined;
    self.doa.var_80ffe475 = undefined;
    self.doa.var_af875fb7 = [];
    self notify("hash_44eb97b0");
    wait(0.05);
    if(isDefined(self.doa.var_3cdd8203)) {
      foreach(chicken in self.doa.var_3cdd8203) {
        if(isDefined(chicken.bird)) {
          chicken.bird delete();
        }
        chicken delete();
      }
      self.doa.var_3cdd8203 = [];
    }
    self thread function_e2a1a825();
  }
  if(self.doa.fate == 4 || self.doa.fate == 13 || (isDefined(self.doa.var_480b6280) && self.doa.var_480b6280)) {
    self.doa.default_movespeed = level.doa.rules.var_b92b82b;
  }
  self.doa.var_7c1bcaf3 = 0;
  if(self.doa.fate == 2) {
    self.doa.var_7c1bcaf3 = 1;
  } else if(self.doa.fate == 11) {
    self.doa.var_7c1bcaf3 = 2;
  }
  self setmovespeedscale(self.doa.default_movespeed);
  self function_aea40863();
  self thread function_4eabae51();
  self thread function_ab0e2cf3();
  self thread function_73d40751();
  self thread function_f19e9b07();
  self thread infiniteammo();
  self thread function_60123d1c();
  self thread function_7d7a7fde();
  self thread function_d7c57981();
  self thread function_e6b2517f();
  self thread function_a36ffe73();
  self thread function_2fee362e();
  self setplayercollision(1);
  self cleardamageindicator();
  self.health = self.maxhealth;
  self.ignoreme = 0;
  if(isDefined(self.hud_damagefeedback)) {
    self.hud_damagefeedback destroy();
    self.hud_damagefeedback = undefined;
  }
  self namespace_64c6b720::function_850bb47e();
}

function function_e2a1a825() {
  self notify("hash_e2a1a825");
  self endon("hash_e2a1a825");
  self endon("disconnect");
  self.doa.var_a483af0a = 0;
  self.doa.var_b55a8647 = 0;
  while(true) {
    self util::waittill_any("doa_round_is_over", "bossEventComplete", "playerLeaderboardUploader", "disconnect");
    if(level.doa.round_number >= getdvarint("scr_doa_min_level_stat_upload", 45)) {
      self thread namespace_693feb87::function_780f83fd(level.doa.round_number);
    }
  }
}

function function_eb67e3d2() {
  while(true) {
    if(self stancebuttonPressed()) {
      stance = 1;
    }
    if(self fragButtonPressed()) {
      frag = 1;
    }
    if(self reloadbuttonPressed()) {
      reload = 1;
    }
    if(self secondaryoffhandbuttonPressed()) {
      var_6275e96c = 1;
    }
    if(self inventorybuttonPressed()) {
      inventory = 1;
    }
    if(self offhandspecialbuttonPressed()) {
      var_41f5c788 = 1;
    }
    if(self weaponswitchbuttonPressed()) {
      var_ad9943fa = 1;
    }
    if(self vehiclemoveupbuttonPressed()) {
      var_affc5722 = 1;
    }
    if(self actionbuttonPressed()) {
      action = 1;
    }
    if(self jumpbuttonPressed()) {
      jump = 1;
    }
    if(self sprintbuttonPressed()) {
      sprint = 1;
    }
    if(self meleeButtonPressed()) {
      melee = 1;
    }
    if(self throwbuttonPressed()) {
      throw = 1;
    }
    if(self adsButtonPressed()) {
      ads = 1;
    }
    if(self actionslotfourbuttonPressed()) {
      action4 = 1;
    }
    if(self actionslotthreebuttonPressed()) {
      action3 = 1;
    }
    if(self actionslottwobuttonPressed()) {
      action2 = 1;
    }
    if(self actionslotonebuttonPressed()) {
      action1 = 1;
    }
    if(self attackButtonPressed()) {
      attack = 1;
    }
    if(self boostbuttonPressed()) {
      boost = 1;
    }
    if(self changeseatbuttonPressed()) {
      changeseat = 1;
    }
    if(self useButtonPressed()) {
      use = 1;
    }
    wait(0.05);
  }
}

function function_7e372abd() {
  self endon("disconnect");
  while(!isDefined(self.doa)) {
    wait(0.05);
  }
  if(isDefined(level.doa.var_e6653624)) {
    if(!isinarray(level.doa.var_e6653624, self.name)) {
      level.doa.var_e6653624[level.doa.var_e6653624.size] = self.name;
      level.doa.var_a9ba4ffb[self.name] = gettime();
    }
  }
  self function_ad1d5fcb(1);
}

function function_4db260cb() {
  foreach(player in getplayers()) {
    player thread function_7e372abd();
  }
}

function function_895845f9(origin, ignore_player) {
  valid_player_found = 0;
  players = getplayers();
  if(isDefined(ignore_player)) {
    for(i = 0; i < ignore_player.size; i++) {
      if(isDefined(ignore_player[i])) {
        players = arrayremovevalue(players, ignore_player[i]);
      }
    }
  }
  if(!valid_player_found) {
    for(;;) {
      player = doa_utility::getclosestto(origin, players);
      return undefined;
      players = arrayremovevalue(players, player);
    }
    if(!isDefined(player)) {}
    if(!isplayervalid(player, 1)) {}
    return player;
  }
}

function isplayervalid(player, checkignoremeflag) {
  if(!isDefined(player)) {
    return false;
  }
  if(!isalive(player)) {
    return false;
  }
  if(!isPlayer(player)) {
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

function function_5bcae97c(trigger) {
  trigger thread doa_utility::function_a625b5d3(self);
  trigger thread doa_utility::function_75e76155(self, "enter_vehicle");
  trigger thread doa_utility::function_75e76155(self, "turnPlayerShieldOn");
  trigger thread doa_utility::function_75e76155(self, "turnPlayerShieldOff");
  trigger waittill("death");
  if(isDefined(self)) {
    self function_4519b17(0);
    self.doa.shield_is_on = undefined;
    self thread namespace_eaa992c::turnofffx("player_shield_short");
    self thread namespace_eaa992c::turnofffx("player_shield_long");
  }
}

function turnplayershieldon(short_shield = 1) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");
  self endon("enter_vehicle");
  self notify("turnplayershieldon");
  self endon("turnplayershieldon");
  if(!isDefined(self.doa) || isDefined(self.doa.vehicle)) {
    return;
  }
  if(isDefined(self.doa.shield_is_on)) {
    self notify("turnplayershieldoff");
    waittillframeend();
  } else {
    if(short_shield) {
      self thread namespace_1a381543::function_90118d8c("zmb_player_shield_half");
    } else if(mayspawnentity()) {
      self playSound("zmb_player_shield_full");
    }
  }
  self function_4519b17(1);
  if(mayspawnfakeentity()) {
    trigger = spawn("trigger_radius", self.origin, 17, 50, 50);
    trigger.targetname = "turnPlayerShieldOn";
    self.doa.shield_is_on = trigger;
    trigger enablelinkto();
    trigger linkto(self);
    trigger thread shield_trigger_think(self);
    self thread function_5bcae97c(trigger);
    trigger thread doa_utility::function_1bd67aef(9.85);
    util::wait_network_frame();
  }
  if(short_shield) {
    self thread namespace_eaa992c::function_285a2999("player_shield_short");
  } else {
    self thread namespace_eaa992c::function_285a2999("player_shield_long");
    wait(6);
  }
  self thread namespace_1a381543::function_90118d8c("zmb_player_shield_half");
  wait(3);
  self thread namespace_1a381543::function_90118d8c("zmb_player_shield_end");
  wait(0.5);
  self function_4519b17(0);
  self notify("turnplayershieldoff");
}

function private function_6b0da7ff() {
  self endon("death");
  while(true) {
    wait(0.05);
  }
}

function shield_trigger_think(player, var_c1ff53d9, thresh) {
  self endon("death");
  self thread function_6b0da7ff();
  self thread function_ab9cf24b(player);
  self.player = player;
  while(isDefined(player)) {
    self waittill("trigger", guy);
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
    if(!(isDefined(guy.takedamage) && guy.takedamage)) {
      continue;
    }
    if(isDefined(guy.boss) && guy.boss) {
      continue;
    }
    if(guy.team == player.team) {
      continue;
    }
    ok = 1;
    if(isDefined(var_c1ff53d9)) {
      v_velocity = var_c1ff53d9 getvelocity();
      speed = lengthsquared(v_velocity);
      ok = speed < (thresh * thresh);
    }
    if(!ok) {
      continue;
    }
    guy setplayercollision(0);
    if(!isvehicle(guy)) {
      if(!(isDefined(guy.no_ragdoll) && guy.no_ragdoll)) {
        guy.launched = 1;
        if(randomint(100) < getdvarint("scr_doa_ragdoll_toss_up_chance", 25)) {
          velocity = function_93739933(player getvelocity());
          if(velocity > 30 && (!(isDefined(guy.var_ad61c13d) && guy.var_ad61c13d))) {
            guy clientfield::set("zombie_rhino_explosion", 1);
            namespace_fba031c8::trygibbinglimb(guy, 5000);
            namespace_fba031c8::trygibbinglegs(guy, 5000, undefined, 1, player);
          }
          assert(!(isDefined(guy.boss) && guy.boss));
          guy thread doa_utility::function_e3c30240(vectorscale((0, 0, 1), 220), 100, 0.3);
          guy thread doa_utility::function_ba30b321(0.2, player);
          guy thread namespace_1a381543::function_90118d8c("zmb_ragdoll_launched");
        } else {
          guy dodamage(guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE");
        }
      } else {
        guy dodamage(guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE");
      }
    } else {
      guy thread doa_utility::function_ba30b321(0, player);
    }
  }
  self delete();
}

function function_93739933(vel) {
  return length(vel) * 0.05681818;
}

function private function_ab9cf24b(player) {
  self endon("death");
  if(!isDefined(level.doa) || !isDefined(level.doa.hazards)) {
    return;
  }
  while(true) {
    foreach(hazard in level.doa.hazards) {
      if(isDefined(hazard) && self istouching(hazard) && isDefined(hazard.death_func)) {
        hazard thread[[hazard.death_func]]();
      }
    }
    wait(0.1);
  }
}

function infiniteammo() {
  self notify("hash_93c32bc6");
  self endon("hash_93c32bc6");
  self endon("disconnect");
  wait(1);
  while(true) {
    wait(2);
    weaponslist = self getweaponslistprimaries();
    for(idx = 0; idx < weaponslist.size; idx++) {
      self setweaponammoclip(weaponslist[idx], 666);
    }
  }
}

function function_1a86a494(var_d55fe723 = 0) {
  assert(isDefined(self.doa));
  if(self.doa.boosters < 1) {
    self.doa.boosters = 1;
  }
  if(self.doa.fate == 4) {
    if(self.doa.boosters < 2) {
      self.doa.boosters = 2;
    }
  } else {
    if(self.doa.fate == 13) {
      if(self.doa.boosters < 4) {
        self.doa.boosters = 4;
      }
    } else {
      if(self.doa.fate == 11) {
        if(!var_d55fe723 && !isDefined(self.doa.var_3df27425)) {
          self thread namespace_6df66aa5::function_2016b381(10);
        }
      } else if(self.doa.fate == 10) {
        if(self.doa.bombs < 1) {
          self.doa.bombs = 1;
        }
      }
    }
  }
  self.health = self.maxhealth;
  self.ignoreme = 0;
}

function function_82e3b1cb(var_d55fe723 = 0) {
  players = function_5eb6e4d1();
  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || (isDefined(players[i].doa.respawning) && players[i].doa.respawning)) {
      players[i] function_ad1d5fcb();
    }
    players[i] function_1a86a494(var_d55fe723);
  }
}

function function_aea40863() {
  self function_d5f89a15(self.doa.default_weap.name);
  self disableweaponcycling();
  self allowjump(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowslide(0);
  self allowdoublejump(0);
  self allowwallrun(0);
  self allowsprint(isDefined(self.doa.var_65f7f2a9) && self.doa.var_65f7f2a9);
  self allowads(isDefined(self.doa.var_65f7f2a9) && self.doa.var_65f7f2a9);
  self setstance("stand");
}

function function_6a52a347(count = 1) {
  assert(isDefined(self.doa));
  max = level.doa.rules.max_lives;
  if(self.doa.fate == 11) {
    max++;
  }
  self.doa.lives = doa_utility::clamp(self.doa.lives + count, 0, max);
}

function function_ba145a39(count = 1) {
  assert(isDefined(self.doa));
  max = level.doa.rules.max_bombs;
  if(self.doa.fate == 11) {
    max++;
  }
  self.doa.bombs = doa_utility::clamp(self.doa.bombs + count, 0, max);
}

function function_f3748dcb(count = 1) {
  assert(isDefined(self.doa));
  max = level.doa.rules.var_376b21db;
  if(self.doa.fate == 11) {
    max++;
  }
  self.doa.boosters = doa_utility::clamp(self.doa.boosters + count, 0, max);
}

function private function_3f041ff1() {
  self endon("disconnect");
  self util::waittill_any("new_speed_pickup", "player_died", "speed_expired", "disconnect");
  self thread namespace_eaa992c::turnofffx("boots");
  self.doa.fast_feet = undefined;
  self setmovespeedscale(self.doa.default_movespeed);
  self thread namespace_1a381543::function_4f06fb8("zmb_pwup_speed_loop");
  self thread namespace_1a381543::function_90118d8c("zmb_pwup_speed_end");
}

function function_832d21c2() {
  self notify("new_speed_pickup");
  self endon("new_speed_pickup");
  self endon("disconnect");
  self thread function_3f041ff1();
  wait(0.05);
  self thread namespace_1a381543::function_90118d8c("zmb_pwup_speed_loop");
  self setmovespeedscale(level.doa.rules.var_b92b82b);
  self thread namespace_eaa992c::function_285a2999("boots");
  self.doa.fast_feet = 1;
  self.doa.var_d5c84825 = undefined;
  timeleft = gettime() + (self doa_utility::function_1ded48e6(level.doa.rules.player_speed_time) * 1000);
  while(isDefined(self.doa.fast_feet) && self.doa.fast_feet && gettime() < timeleft) {
    wait(0.05);
  }
  self notify("hash_9284568c");
}

function private function_af5211c2() {
  self endon("disconnect");
  self util::waittill_any("new_speed_pickup", "player_died", "speed_expired", "snare_broken", "disconnect");
  self thread namespace_eaa992c::turnofffx("slow_feet");
  self thread namespace_eaa992c::turnofffx("web_contact");
  self thread namespace_1a381543::function_4f06fb8("zmb_pwup_slow_speed_loop");
  self thread namespace_1a381543::function_90118d8c("zmb_pwup_slow_speed_end");
  self.doa.var_d5c84825 = undefined;
  util::wait_network_frame();
  self setmovespeedscale(self.doa.default_movespeed);
}

function function_3840375a(speed = level.doa.rules.var_ee067ec) {
  self notify("hash_c70bfe29");
  self endon("hash_c70bfe29");
  self endon("disconnect");
  self thread function_af5211c2();
  wait(0.05);
  self thread namespace_1a381543::function_90118d8c("zmb_pwup_slow_speed_loop");
  self setmovespeedscale(speed);
  if(speed == 0) {
    self thread namespace_eaa992c::function_285a2999("web_contact");
    timeleft = gettime() + (level.doa.rules.var_dec839f3 * 1000);
  } else if(speed == level.doa.rules.var_ee067ec) {
    self thread namespace_eaa992c::function_285a2999("slow_feet");
    timeleft = gettime() + (level.doa.rules.var_353018d2 * 1000);
  }
  self.doa.var_d5c84825 = 1;
  self.doa.fast_feet = undefined;
  while(isDefined(self.doa.var_d5c84825) && self.doa.var_d5c84825 && gettime() < timeleft) {
    wait(0.05);
  }
  self notify("hash_9284568c");
}

function function_1ba980a() {
  self endon("disconnect");
  self notify("hash_1ba980a");
  self endon("hash_1ba980a");
  level waittill("hash_8817f58");
  self notify("hash_864ef970");
}

function function_6e1ed82() {
  self notify("hash_6e1ed82");
  self endon("hash_6e1ed82");
  self endon("hash_9284568c");
  self endon("disconnect");
  var_2fa8cbbd = 0;
  samples = [];
  idx = 0;
  self thread function_1ba980a();
  while(!var_2fa8cbbd && isDefined(self)) {
    norm_move = self getnormalizedmovement();
    var_11533e3b = length(norm_move);
    idx = (idx + 1) % 20;
    if(isDefined(var_11533e3b) && var_11533e3b > 0.5) {
      samples[idx] = norm_move;
    } else {
      samples[idx] = (0, 0, 0);
    }
    if(samples.size >= 20) {
      var_70a33bda = 0;
      var_96a5b643 = 0;
      var_249e4708 = 0;
      var_4aa0c171 = 0;
      var_8ad257e = 0;
      foreach(vec in samples) {
        if(vec == (0, 0, 0)) {
          var_70a33bda++;
          continue;
        }
        if(vec[0] > 0 && vec[1] > 0) {
          var_96a5b643++;
          continue;
        }
        if(vec[0] > 0 && vec[1] < 0) {
          var_249e4708++;
          continue;
        }
        if(vec[0] < 0 && vec[1] < 0) {
          var_4aa0c171++;
          continue;
        }
        var_8ad257e++;
      }
      if(var_70a33bda < 4) {
        if(var_96a5b643 >= 2 && var_249e4708 >= 2 && var_4aa0c171 >= 2 && var_8ad257e >= 2) {
          var_2fa8cbbd = 1;
        }
      }
    }
    wait(0.05);
  }
  self notify("hash_864ef970");
}

function function_a36ffe73() {
  self notify("hash_a36ffe73");
  self endon("hash_a36ffe73");
  self waittill("hash_89b28ec", attacker);
  self thread function_6e1ed82();
  self thread function_3840375a(0);
  self thread function_a36ffe73();
}

function function_d7c57981() {
  self notify("hash_d7c57981");
  self endon("hash_d7c57981");
  self waittill("hash_9132a424", attacker);
  self thread function_3840375a();
  self thread function_d7c57981();
}

function function_e5fa8e6a() {
  self thread namespace_1a381543::function_90118d8c("zmb_player_poisoned");
  self.doa.var_91c268dc = 0;
  self.doa.weaponlevel = 0;
  self function_d5f89a15(self.doa.default_weap.name);
  self notify("hash_8820b45b");
}

function function_e6b2517f() {
  self notify("hash_e6b2517f");
  self endon("hash_e6b2517f");
  self waittill("poisoned", attacker);
  self thread function_e5fa8e6a();
  self thread function_e6b2517f();
}

function function_ab0e2cf3() {
  self notify("hash_58a81b71");
  self endon("hash_58a81b71");
  self endon("disconnect");
  while(true) {
    wait(0.05);
    if(!isalive(self)) {
      continue;
    }
    if(isDefined(self.var_744a3931)) {
      continue;
    }
    if(isDefined(level.var_3259f885) && level.var_3259f885) {
      continue;
    }
    if(isDefined(self.doa.var_3e3bcaa1) && self.doa.var_3e3bcaa1) {
      continue;
    }
    if(isDefined(self.doa.var_3be905bb) && self.doa.var_3be905bb || (!isDefined(self.doa.vehicle) && self fragButtonPressed())) {
      self.doa.var_3be905bb = 0;
      if(isDefined(self.doa.boosters) && self.doa.boosters > 0) {
        self.doa.rhino_deaths = 0;
        self.doa.var_d5c84825 = undefined;
        if(mayspawnentity()) {
          self playSound("zmb_speed_boost_activate");
        }
        self.doa.boosters--;
        self thread turnplayershieldon();
        curdir = anglesToForward((0, 0, 0));
        if(mayspawnfakeentity()) {
          trigger = spawn("trigger_radius", self.origin, 1, 85, 50);
          trigger.targetname = "triggerBoost1";
          trigger enablelinkto();
          trigger linkto(self, "tag_origin", curdir * 200, self.angles);
          trigger thread shield_trigger_think(self);
          trigger thread doa_utility::function_a625b5d3(self);
          trigger thread doa_utility::function_75e76155(self, "boosterThink");
          trigger thread doa_utility::function_1bd67aef(0.6);
        }
        if(mayspawnfakeentity()) {
          trigger2 = spawn("trigger_radius", self.origin, 1, 85, 50);
          trigger2.targetname = "triggerBoost2";
          trigger2 enablelinkto();
          trigger2 linkto(self, "tag_origin", curdir * 50, self.angles);
          trigger2 thread shield_trigger_think(self);
          trigger2 thread doa_utility::function_a625b5d3(self);
          trigger2 thread doa_utility::function_75e76155(self, "boosterThink");
          trigger2 thread doa_utility::function_1bd67aef(0.6);
        }
        curdir = anglesToForward(self.angles);
        endtime = gettime() + 600;
        boost_vector = curdir * 2000;
        boost_vector = boost_vector + vectorscale((0, 0, 1), 200);
        self setvelocity(boost_vector);
        boost_vector = boost_vector - vectorscale((0, 0, 1), 200);
        self playrumbleonentity("zombietron_booster_rumble");
        if(self.doa.fate == 13 || (isDefined(self.doa.var_480b6280) && self.doa.var_480b6280)) {
          self thread doa_fate::function_3caf8e2(endtime);
        }
        while(gettime() < endtime) {
          self setvelocity(boost_vector);
          wait(0.05);
        }
        self.doa.rhino_deaths = undefined;
        if(isDefined(trigger)) {
          trigger delete();
        }
        if(isDefined(trigger2)) {
          trigger2 delete();
        }
      }
    }
  }
}

function function_7d7a7fde() {
  if(level.time == self.birthtime || !isDefined(self.doa)) {
    wait(0.05);
  }
  if(!(isDefined(self.doa.var_65f7f2a9) && self.doa.var_65f7f2a9)) {
    self clientfield::increment_to_player("controlBinding");
  } else {
    self clientfield::increment_to_player("goFPS");
  }
}

function private function_9fc6e261() {
  self waittill("actor_corpse", corpse);
  wait(0.05);
  if(isDefined(corpse)) {
    corpse clientfield::increment("burnCorpse");
  }
}

function private function_d392db04(var_adc420e5, origin, player, var_307c0d3) {
  self endon("death");
  assert(!(isDefined(self.boss) && self.boss));
  if(!isDefined(level.var_b3050900)) {
    level.var_b3050900 = 160 * 160;
    level.var_5e8840d3 = 512 * 512;
    level.var_c4dbc378 = 75;
    level.var_619a7a66 = 250;
    level.var_38e68ca7 = 1;
  }
  distsq = distancesquared(self.origin, origin);
  var_b3458cba = doa_utility::clamp(distsq / level.var_5e8840d3, 0.1, 1);
  time = doa_utility::clamp(var_adc420e5 * var_b3458cba, 0.05, var_adc420e5);
  wait(time);
  if(isDefined(self.archetype) && self.archetype == "robot") {
    self namespace_fba031c8::function_7b3e39cb();
  } else {
    self thread function_9fc6e261();
    if(!(isDefined(self.nofire) && self.nofire) && isactor(self)) {
      self clientfield::increment("burnZombie");
    }
  }
  if(self.archetype == "zombie") {
    roll = randomint(100);
    if(roll < 10) {
      self clientfield::set("zombie_rhino_explosion", 1);
      util::wait_network_frame();
    } else {
      if(roll < 40) {
        self clientfield::set("zombie_gut_explosion", 1);
        util::wait_network_frame();
      } else if(roll < 70) {
        self clientfield::set("zombie_saw_explosion", 1);
        util::wait_network_frame();
      }
    }
  }
  self.takedamage = 1;
  self.allowdeath = 1;
  self dodamage(self.health + 1, origin, (isDefined(player) ? player : undefined), undefined, "none", "MOD_EXPLOSIVE");
}

function function_73d40751() {
  self notify("hash_73d40751");
  self endon("hash_73d40751");
  self endon("disconnect");
  while(true) {
    wait(0.05);
    if(self weaponswitchbuttonPressed()) {
      if(!(isDefined(self.doa.var_655cbff1) && self.doa.var_655cbff1)) {
        self clientfield::increment_to_player("changeCamera");
        self notify("hash_348c5f29");
        level notify("hash_348c5f29", self);
      }
      while(self weaponswitchbuttonPressed()) {
        wait(0.05);
      }
    }
  }
}

function function_f19e9b07() {
  self notify("hash_f26fb3a4");
  self endon("hash_f26fb3a4");
  self endon("disconnect");
  while(true) {
    wait(0.05);
    if(!isalive(self)) {
      continue;
    }
    if(self stancebuttonPressed()) {
      if(isDefined(self.doa.vehicle)) {
        self notify("hash_d28ba89d");
      } else {
        self doa_pickups::function_9615d68f();
      }
      while(self stancebuttonPressed()) {
        wait(0.05);
      }
    }
  }
}

function function_4eabae51() {
  self notify("hash_97fb783");
  self endon("hash_97fb783");
  self endon("disconnect");
  while(true) {
    wait(0.05);
    if(!isalive(self)) {
      continue;
    }
    if(isDefined(self.var_744a3931)) {
      continue;
    }
    if(isDefined(self.doa.var_3024fd0f) && self.doa.var_3024fd0f) {
      continue;
    }
    if(isDefined(level.var_3259f885) && level.var_3259f885) {
      continue;
    }
    if(isDefined(self.doa.var_c1de140a)) {
      if(gettime() < self.doa.var_c1de140a) {
        continue;
      } else {
        self.doa.var_c1de140a = undefined;
      }
    }
    if(isDefined(self.doa.var_f30b49ec) && self.doa.var_f30b49ec) {
      if(self jumpbuttonPressed()) {
        continue;
      } else {
        self.doa.var_f30b49ec = undefined;
      }
    }
    if(isDefined(self.doa.var_f2870a9e) && self.doa.var_f2870a9e || self jumpbuttonPressed()) {
      self.doa.var_f2870a9e = 0;
      self.doa.var_f30b49ec = 1;
      if(isDefined(self.doa.bombs) && self.doa.bombs > 0) {
        self.doa.bombs--;
        player_org = self.origin;
        origin = player_org + (20, 0, 800);
        self clientfield::set("bombDrop", 1);
        self thread turnplayershieldon();
        doa_utility::clearallcorpses();
        wait(0.4);
        playrumbleonposition("artillery_rumble", self.origin);
        util::wait_network_frame();
        level notify("hash_8817f58");
        enemies = doa_utility::function_fb2ad2fb();
        camerapos = namespace_3ca3c537::function_5147636f();
        var_307c0d3 = vectornormalize(camerapos - player_org);
        var_adc420e5 = 0.3;
        foreach(guy in enemies) {
          if(isDefined(guy)) {
            if(isDefined(guy.boss) && guy.boss) {
              guy.nuked = gettime();
              continue;
            }
            if(isvehicle(guy)) {
              guy dodamage(guy.health + 1, player_org, self, self, "none", "MOD_EXPLOSIVE", 0, getweapon("none"));
            }
            guy thread function_d392db04(var_adc420e5, player_org, self, var_307c0d3);
          }
        }
        foreach(hazard in level.doa.hazards) {
          if(isDefined(hazard) && isDefined(hazard.death_func)) {
            hazard thread[[hazard.death_func]]();
          }
        }
        util::wait_network_frame();
        self clientfield::set("bombDrop", 0);
        physicsexplosionsphere(player_org, 1024, 1024, 3);
      }
    }
  }
}

function function_350f42fa(var_e1eb317e) {
  self endon("disconnect");
  self notify("hash_42ae3dd7");
  self endon("hash_42ae3dd7");
  while(true) {
    self waittill("missile_fire", projectile, weapon);
    if(weapon == level.doa.var_e30c10ec) {
      projectile thread function_48b5439d(self);
      projectile thread function_62c5034a(self);
    } else if(weapon == level.doa.var_ccb54987) {
      self thread function_5e373fc6();
    }
  }
}

function function_62c5034a(owner) {
  self endon("death");
  owner endon("hash_42ae3dd7");
  owner endon("disconnect");
  while(true) {
    self waittill("grenade_bounce", pos, normal, ent, surface);
    physicsexplosionsphere(pos, getdvarint("scr_doa_secondary_explo_rad", 64), getdvarint("scr_doa_secondary_explo_rad", 64), 3);
    radiusdamage(pos, getdvarint("scr_doa_secondary_explo_rad", 64), getdvarint("scr_doa_secondary_explo_dmg", 2000), getdvarint("scr_doa_secondary_explo_dmg", 2000), owner);
    playFX(level._effect["impact_raygun"], pos);
    wait(getdvarfloat("scr_doa_secondary_firerate_frac", 0.65));
  }
}

function function_48b5439d(owner) {
  self endon("death");
  owner endon("hash_42ae3dd7");
  owner endon("disconnect");
  owner.doa.var_cdd906a9 = 0;
  while(true) {
    owner waittill("hash_21f7a743", victim);
    time = gettime();
    if(owner.doa.var_cdd906a9 > time) {
      continue;
    }
    owner.doa.var_cdd906a9 = time;
    level thread namespace_3f3eaecb::function_395fdfb8(victim, owner);
  }
}

function missile_logic(target) {
  self waittill("missile_fire", missile, weap);
  if(isDefined(target)) {
    missile missile_settarget(target);
  }
}

function function_5e373fc6() {
  if(!isDefined(self.doa.var_5af6f9a9)) {
    self.doa.var_5af6f9a9 = getweapon("zombietron_rpg_2_secondary");
  }
  enemies = doa_utility::function_fb2ad2fb();
  if(enemies.size == 0) {
    return;
  }
  closetargets = arraysortclosest(enemies, self.origin, enemies.size, 0, 4096);
  fovtargets = [];
  foreach(guy in closetargets) {
    if(isDefined(guy.boss) && guy.boss) {
      continue;
    }
    if(util::within_fov(self.origin, self.angles, guy.origin, 0.8)) {
      fovtargets[fovtargets.size] = guy;
    }
    if(fovtargets.size >= 2) {
      break;
    }
  }
  if(fovtargets.size == 0) {
    return;
  }
  target1 = fovtargets[0];
  target2 = (fovtargets.size > 1 ? fovtargets[1] : fovtargets[0]);
  v_spawn = self gettagorigin("tag_flash");
  if(!isDefined(v_spawn)) {
    return;
  }
  v_dir = anglesToForward(self.angles);
  self.doa.var_b5d64970 = gettime() + (getdvarint("scr_doa_secondary_firerate", int(getdvarfloat("scr_doa_secondary_firerate_frac", 0.65) * 1000)));
  self thread missile_logic(target1);
  magicbullet(self.doa.var_5af6f9a9, v_spawn, v_spawn + (50 * v_dir), self);
  wait(0.05);
  self thread missile_logic(target2);
  magicbullet(self.doa.var_5af6f9a9, v_spawn, v_spawn + (50 * v_dir), self);
}

function function_baa7411e(weapon) {
  self takeallweapons();
  self giveweapon(weapon);
  self switchtoweaponimmediate(weapon);
  self thread function_f2507519(level.doa.arena_round_number == 3);
  self.doa.var_d898dd8e = weapon;
  self.doa.var_7a1de0da = 0;
  self.doa.var_88842727 = weapon;
  if(weapon == self.doa.default_weap) {
    self.doa.var_d898dd8e = undefined;
    if(weapon == level.doa.var_69899304) {
      self.doa.var_d898dd8e = level.doa.var_69899304;
    }
    if(weapon == level.doa.var_416914d0) {
      self.doa.var_d898dd8e = level.doa.var_416914d0;
    }
  } else {
    if(weapon.type == "gas") {
      self.doa.var_d898dd8e = level.doa.var_e6a7c945;
    } else {
      if(weapon.name == "zombietron_launcher") {
        self.doa.var_d898dd8e = level.doa.var_ab5c3535;
        self.doa.var_7a1de0da = -5;
      } else {
        if(weapon.name == "zombietron_launcher_1") {
          self.doa.var_d898dd8e = level.doa.var_5706a235;
          self.doa.var_7a1de0da = -5;
        } else if(weapon.name == "zombietron_launcher_2") {
          self.doa.var_d898dd8e = level.doa.var_7d091c9e;
          self.doa.var_7a1de0da = -5;
        }
      }
    }
  }
}

function function_71dab8e8(amount = 1) {
  if(!isDefined(self.doa.var_e1eb317e)) {
    return;
  }
  if(isDefined(self.doa.respawning) && self.doa.respawning) {
    return;
  }
  self.doa.var_91c268dc = self.doa.var_91c268dc + (int(getdvarint("scr_doa_weapon_increment", 64) * amount));
  if(self.doa.var_91c268dc >= getdvarint("scr_doa_weapon_increment_range", 1024)) {
    if(self.doa.weaponlevel < 2) {
      var_2e3af952 = self.doa.weaponlevel;
      self.doa.weaponlevel = self.doa.weaponlevel + (int(self.doa.var_91c268dc / getdvarint("scr_doa_weapon_increment_range", 1024)));
      if(self.doa.weaponlevel > 2) {
        self.doa.weaponlevel = 2;
      }
      self.doa.var_91c268dc = self.doa.var_91c268dc - (self.doa.weaponlevel - var_2e3af952) * getdvarint("scr_doa_weapon_increment_range", 1024);
      graceperiod = gettime() + 2000;
      if(isDefined(self.doa.var_c2b9d7d0) && self.doa.var_c2b9d7d0 < graceperiod) {
        self.doa.var_c2b9d7d0 = graceperiod;
      }
      self function_baa7411e(self.doa.var_e1eb317e[self.doa.weaponlevel]);
      if(mayspawnentity()) {
        self playsoundtoplayer("zmb_weapon_upgraded", self);
      }
      doa_utility::debugmsg((((("" + self.name) + "") + self.doa.weaponlevel) + "") + self.doa.var_e1eb317e[self.doa.weaponlevel].name);
    } else {
      self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
    }
  }
  self.doa.var_91c268dc = math::clamp(self.doa.var_91c268dc, 0, getdvarint("scr_doa_weapon_increment_range", 1024) - 1);
}

function updateweapon() {
  if(!isDefined(self.doa) || !isDefined(self.doa.var_a2d31b4a)) {
    return;
  }
  if(isDefined(self.doa.var_88842727) && self.doa.var_88842727 == level.doa.var_69899304) {
    self.doa.weaponlevel = 2;
    self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
    return;
  }
  if(gettime() < self.doa.var_c2b9d7d0) {
    return;
  }
  if(self.doa.var_91c268dc > 0) {
    decay = getdvarint("scr_doa_weapon_increment_decay", 1) + self.doa.var_f303ab59;
    self.doa.var_f303ab59 = 0;
    if(self isfiring()) {
      decay = int(decay * (getdvarint("scr_doa_weapon_increment_decayscale", 5) - self.doa.var_7c1bcaf3));
    }
    self.doa.var_91c268dc = self.doa.var_91c268dc - decay;
    if(self.doa.var_91c268dc < 0) {
      self.doa.var_91c268dc = 0;
    }
  } else if(self.doa.weaponlevel > 0) {
    self.doa.weaponlevel--;
    self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
    self function_baa7411e(self.doa.var_e1eb317e[self.doa.weaponlevel]);
    self thread function_f2507519(level.doa.arena_round_number == 3);
    doa_utility::debugmsg((((("" + self.name) + "") + self.doa.weaponlevel) + "") + self.doa.var_e1eb317e[self.doa.weaponlevel].name);
  }
  if(self.doa.var_a2d31b4a == self.doa.default_weap.name && (isDefined(self.doa.var_1b58e8ba) && self.doa.weaponlevel <= self.doa.var_1b58e8ba)) {
    self.doa.weaponlevel = self.doa.var_1b58e8ba;
    self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
    if(isDefined(self.doa.var_88842727) && self.doa.var_88842727 != self.doa.var_e1eb317e[self.doa.weaponlevel]) {
      self function_baa7411e(self.doa.var_e1eb317e[self.doa.weaponlevel]);
    }
  }
  if(self.doa.var_91c268dc == 0 && self.doa.weaponlevel == 0 && self.doa.var_a2d31b4a != self.doa.default_weap.name) {
    self function_d5f89a15(self.doa.default_weap.name);
  }
}

function function_d5f89a15(name, weaponpickup = 0) {
  if(!isDefined(self.doa)) {
    return;
  }
  if(isDefined(weaponpickup) && weaponpickup) {
    fill = 1;
    if(isDefined(self.doa.var_a2d31b4a) && self.doa.var_a2d31b4a == name) {
      self function_71dab8e8(getdvarint("scr_doa_weapon_increment_range", 1024) / getdvarint("scr_doa_weapon_increment", 64));
      return;
    }
  }
  if(!isDefined(self.doa.var_a2d31b4a) || (isDefined(self.doa.var_a2d31b4a) && self.doa.var_a2d31b4a != name)) {
    self.doa.var_e1eb317e = [];
    self.doa.var_a2d31b4a = name;
    self.doa.var_91c268dc = 0;
    self.doa.weaponlevel = 0;
    if(isDefined(self.doa.default_weap) && name != self.doa.default_weap.name && (self.doa.fate == 1 || self.doa.fate == 10)) {
      self.doa.weaponlevel = 1;
    }
    self.doa.var_c2b9d7d0 = 0;
    self.doa.var_b5d64970 = 0;
    self.doa.var_f303ab59 = 0;
    self takeallweapons();
    var_5f2870f1 = getweapon(name);
    assert(isDefined(var_5f2870f1));
    var_3925f688 = getweapon(name + "_1");
    var_ab2d65c3 = getweapon(name + "_2");
    self.doa.var_e1eb317e[0] = var_5f2870f1;
    self.doa.var_e1eb317e[1] = (var_3925f688 != level.weaponnone ? var_3925f688 : var_5f2870f1);
    self.doa.var_e1eb317e[2] = (var_ab2d65c3 != level.weaponnone ? var_ab2d65c3 : (var_3925f688 != level.weaponnone ? var_3925f688 : var_5f2870f1));
    self function_baa7411e(self.doa.var_e1eb317e[self.doa.weaponlevel]);
    self thread function_350f42fa(self.doa.var_a2d31b4a);
  } else {
    self function_baa7411e(self.doa.var_e1eb317e[self.doa.weaponlevel]);
  }
  if(isDefined(fill) && fill) {
    self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
  }
  doa_utility::debugmsg((((("" + self.name) + "") + self.doa.var_a2d31b4a) + "") + (isDefined(fill) && (fill ? "" : "")));
  self thread function_1318d1e4();
}

function function_1318d1e4() {
  self notify("hash_1318d1e4");
  self endon("hash_1318d1e4");
  self endon("disconnect");
  self waittill("weapon_fired", weapon);
  doa_utility::debugmsg("" + weapon.name);
}

function function_7f33210a() {
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }
  self.doa.var_9742391e = 0;
}

function function_b5843d4f(var_6a15db21) {
  self endon("disconnect");
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }
  if(isDefined(self.doa.vehicle)) {
    return;
  }
  self.doa.var_9742391e = (var_6a15db21 ? 2 : 1);
}

function function_f2507519(on = 1) {
  if(!isDefined(self)) {
    return;
  }
  self notify("hash_f2507519");
  self endon("hash_f2507519");
  self endon("disconnect");
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }
  if(isDefined(self.doa.vehicle)) {
    return;
  }
  self util::waittill_any_timeout(0.25, "weapon_change_complete", "disconnect", "turnOnFlashlight");
  if(isDefined(self) && isDefined(self.entnum)) {
    if(on) {
      self thread namespace_eaa992c::function_285a2999("player_flashlight");
    } else {
      self thread namespace_eaa992c::turnofffx("player_flashlight");
    }
  }
}

function function_7e85dbee() {
  var_b427d4ac = self.doa.multiplier;
  if(self.doa.fate == 2 || self.doa.fate == 11) {
    var_b427d4ac--;
  }
  if(var_b427d4ac > 1) {
    var_516eed4b = doa_utility::clamp(int(randomfloatrange(0.3, 0.5) * ((var_b427d4ac - 1) * 4)), 3);
    level thread doa_pickups::spawnubertreasure(self.origin, var_516eed4b, 85, 1, 1);
  }
}

function function_2fee362e() {
  self endon("disconnect");
  self notify("hash_2fee362e");
  self endon("hash_2fee362e");
  while(!(isDefined(level.hostmigrationtimer) && level.hostmigrationtimer)) {
    wait(1);
  }
  while(isDefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
    wait(0.05);
  }
  self thread turnplayershieldon(0);
}

function function_3682cfe4(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  self globallogic_score::incpersstat("deaths", 1, 1, 1);
  self thread namespace_1a381543::function_90118d8c("zmb_player_death");
  self notify("player_died");
  self freezecontrols(1);
  self setplayercollision(0);
  self thread function_7e85dbee();
  self.doa.var_91c268dc = 0;
  self.doa.weaponlevel = 0;
  self.doa.var_c2b9d7d0 = 0;
  self.var_5f951816 = gettime();
  self thread namespace_64c6b720::function_850bb47e();
  self.deaths = math::clamp(self.deaths + 1, 0, 1023);
  self.dead = 1;
  doa_utility::debugmsg((("" + smeansofdeath) + "") + idamage);
  if(isDefined(einflictor)) {
    doa_utility::debugmsg(((("" + einflictor getentitynumber()) + "") + einflictor.classname) + (isDefined(einflictor.targetname) ? "" + einflictor.targetname : ""));
  }
  if(isDefined(attacker)) {
    doa_utility::debugmsg(((("" + attacker getentitynumber()) + "") + attacker.classname) + (isDefined(attacker.targetname) ? "" + attacker.targetname : ""));
  }
  if(self.doa.lives == 0) {
    players = function_5eb6e4d1();
    count = 0;
    for(i = 0; i < players.size; i++) {
      if(!isalive(players[i]) && players[i].doa.lives == 0 || isDefined(players[i].var_744a3931)) {
        count++;
      }
    }
    if(count == players.size) {
      level flag::set("doa_game_is_over");
      level notify("hash_d1f5acf7");
    } else {
      self thread function_c7471371();
    }
  } else {
    self thread function_161ce9cd();
  }
}

function private function_fdf74b3() {
  self notify("new_ignore_attacker");
  self endon("new_ignore_attacker");
  self endon("disconnect");
  wait(level.rules.ignore_enemy_timer);
  self.doa.ignoreattacker = undefined;
}

function function_bfbc53f4(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
    idamage = 0;
  }
  if(isDefined(self.doa) && (isDefined(self.doa.var_ccf4ef81) && self.doa.var_ccf4ef81)) {
    idamage = 0;
  }
  if(isDefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
    idamage = 0;
  }
  if(!isDefined(self.doa)) {
    idamage = 0;
  } else {
    if(isDefined(self.doa.vehicle)) {
      idamage = 0;
    }
    if(isDefined(self.doa.shield_is_on)) {
      self cleardamageindicator();
      idamage = 0;
    }
    if(idamage && isDefined(eattacker)) {
      if(isDefined(eattacker.meleedamage)) {
        idamage = eattacker.meleedamage;
      }
      if(eattacker == self) {
        idamage = 0;
      }
      if(isDefined(self.doa.ignoreattacker) && self.doa.ignoreattacker == eattacker) {
        idamage = 0;
      }
      if(isDefined(eattacker.owner)) {
        eattacker = eattacker.owner;
      }
      if(eattacker.team == self.team) {
        idamage = 0;
      }
      if(eattacker isragdoll()) {
        idamage = 0;
        eattacker thread doa_utility::function_ba30b321(0.1);
      }
      if(isDefined(eattacker.knocked_out) && eattacker.knocked_out) {
        idamage = 0;
      }
      if(isDefined(self.doa.var_65f7f2a9) && self.doa.var_65f7f2a9) {
        curtime = gettime();
        if(curtime < self.doa.var_f9deeb49) {
          idamage = 0;
        }
        if(idamage > self.maxhealth) {
          idamage = self.maxhealth;
        }
        if(!(isDefined(eattacker.boss) && eattacker.boss)) {
          idamage = int(idamage * getdvarfloat("scr_doa_fps_dmg_mod", 0.35));
        }
        if(idamage > 0) {
          self.doa.var_f9deeb49 = curtime + 1000;
        }
      }
      if(isDefined(eattacker.is_zombie) && eattacker.is_zombie) {
        self.doa.ignoreattacker = eattacker;
        self thread function_fdf74b3();
      }
      if(isDefined(eattacker.var_f4795bf) && eattacker.var_f4795bf && smeansofdeath == "MOD_PROJECTILE") {
        self notify("hash_89b28ec", eattacker);
        idamage = 0;
      } else if(!(isDefined(eattacker.boss) && eattacker.boss) && (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_BURNED" || smeansofdeath == "MOD_EXPLOSIVE")) {
        self cleardamageindicator();
        idamage = 0;
      }
      if(isDefined(eattacker.custom_damage_func)) {
        idamage = eattacker[[eattacker.custom_damage_func]]();
      }
      if(isDefined(eattacker.boss) && eattacker.boss) {
        eattacker.damagedplayer = gettime();
      }
      if(isDefined(eattacker.var_65e0af26) && eattacker.var_65e0af26) {
        self notify("hash_9132a424", eattacker);
      }
      if(isDefined(eattacker.var_dcdf7239) && eattacker.var_dcdf7239) {
        self notify("poisoned", eattacker);
      }
    }
  }
  self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

function playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {}

function function_f847ee8c(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {}

function function_68ece679(entnum) {
  points = level.doa.arenas[level.doa.current_arena].player_spawn_points;
  assert(points.size);
  if(isDefined(entnum) && isDefined(points[entnum])) {
    return points[entnum];
  }
  return points[randomint(points.size)];
}

function private function_161ce9cd(delay = 2) {
  self endon("disconnect");
  wait(delay);
  if(self.doa.lives < 1) {
    return;
  }
  if(level flag::get("doa_game_is_over")) {
    return;
  }
  while(isDefined(level.hostmigrationtimer)) {
    wait(0.05);
  }
  self.doa.lives = doa_utility::clamp(self.doa.lives - 1, 0, level.doa.rules.max_lives);
  self notify("hash_e15bcd80");
  self function_ad1d5fcb();
}

function private function_ad1d5fcb(var_243f32c0 = 0) {
  self endon("disconnect");
  if(!isDefined(self)) {
    return;
  }
  assert(isDefined(self.doa));
  self.doa.respawning = 0;
  if(isDefined(self.var_1a898004)) {
    doa_utility::function_11f3f381(self.var_1a898004, 1);
    self.var_1a898004 = undefined;
  }
  self.var_9ea856f6 = 0;
  self.doa.var_f4a883ed = undefined;
  self disableinvulnerability();
  self show();
  if(!var_243f32c0 && isDefined(self.doa.var_bac6a79)) {
    switch (self.doa.var_bac6a79) {
      case "spawn_at_start": {
        spot = function_68ece679(self.entnum).origin;
        break;
      }
      case "spawn_at_safe": {
        spot = doa_utility::getclosestto(self.origin, level.doa.arenas[level.doa.current_arena].var_1d2ed40).origin;
        break;
      }
      default: {
        spot = function_68ece679(self.entnum).origin;
        break;
      }
    }
    self.doa.var_bac6a79 = undefined;
  }
  self notify("doa_respawn_player");
  self reviveplayer();
  if(!isDefined(spot)) {
    spot = self.origin;
  }
  self setorigin(spot);
  if(!var_243f32c0) {
    if(mayspawnentity()) {
      self playSound("zmb_player_respawn");
    }
    self thread namespace_eaa992c::function_285a2999("player_respawn_" + function_ee495f41(self.entnum));
    self thread turnplayershieldon(0);
    self thread function_f2507519(level.doa.arena_round_number == 3);
  }
  self thread function_b5843d4f(level.doa.arena_round_number == 3);
  wait(0.05);
  self thread function_bbb1254c(var_243f32c0);
  self setplayercollision(1);
  self freezecontrols(0);
  self.dead = undefined;
  self notify("player_respawned");
}

function private function_bbdc9bc0() {
  self endon("disconnect");
  self endon("player_respawned");
  level endon("doa_game_is_over");
  while(!level flag::get("doa_game_is_over")) {
    if(self.doa.lives > 0) {
      self function_161ce9cd(isDefined(self.doa.var_ec2548a9) && (self.doa.var_ec2548a9 ? 0 : 2));
      return;
    }
    wait(0.2);
  }
  self.doa.respawning = undefined;
}

function function_1c683070(distsq = 1296) {
  count = 0;
  foreach(player in getplayers()) {
    if(player == self) {
      continue;
    }
    if(distancesquared(self.origin, player.origin) <= distsq) {
      count++;
    }
  }
  return count;
}

function function_2b1d321f(player, downedplayer) {
  if(player == downedplayer) {
    return;
  }
  downedplayer endon("disconnect");
  player endon("disconnect");
  level endon("doa_game_is_over");
  downedplayer endon("player_respawned");
  while(true) {
    wait(0.05);
    if(!isDefined(player.doa)) {
      continue;
    }
    distsq = distancesquared(player.origin, downedplayer.origin);
    if(isDefined(player.doa.respawning) && player.doa.respawning) {
      distsq = 9999999;
    }
    if(isDefined(player.doa.vehicle)) {
      distsq = 9999999;
    }
    if(!isalive(player)) {
      distsq = 9999999;
    }
    if(distsq > (48 * 48)) {
      found = undefined;
      foreach(savior in downedplayer.doa.var_b08ad9f8) {
        if(!isDefined(savior.player)) {
          arrayremovevalue(downedplayer.doa.var_b08ad9f8, savior);
          break;
        }
        if(savior.player == player) {
          found = savior;
          break;
        }
      }
      if(isDefined(found)) {
        arrayremovevalue(downedplayer.doa.var_b08ad9f8, found);
      }
      continue;
    }
    found = undefined;
    foreach(savior in downedplayer.doa.var_b08ad9f8) {
      if(savior.player == player) {
        found = savior;
        break;
      }
    }
    if(!isDefined(found)) {
      savior = spawnStruct();
      savior.player = player;
      savior.timestamp = gettime();
      downedplayer.doa.var_b08ad9f8[downedplayer.doa.var_b08ad9f8.size] = savior;
    }
  }
}

function function_b1958e58() {
  self endon("disconnect");
  level endon("doa_game_is_over");
  self endon("player_respawned");
  self thread function_285fe1ad();
  foreach(player in getplayers()) {
    if(player == self) {
      continue;
    }
    level thread function_2b1d321f(player, self);
  }
  self.doa.var_97c2af1a = 0;
  self.doa.var_70b102c6 = 0;
  self thread namespace_eaa992c::turnofffx("reviveAdvertise");
  self thread namespace_eaa992c::turnofffx("reviveActive");
  while(self.var_9ea856f6 > 0) {
    util::wait_network_frame();
    self.doa.var_22d93250 = 0;
    self.doa.var_6ccec7c0 = self.doa.var_b08ad9f8.size;
    curtime = gettime();
    foreach(savior in self.doa.var_b08ad9f8) {
      if((curtime - savior.timestamp) > getdvarint("scr_doa_playrevive_delay", 250)) {
        self.doa.var_22d93250++;
      }
    }
    if(self.doa.var_97c2af1a == 0 && self.doa.var_6ccec7c0 > 0) {
      self thread namespace_eaa992c::function_285a2999("reviveAdvertise");
      self thread namespace_eaa992c::turnofffx("reviveActive");
    }
    if(self.doa.var_97c2af1a > 0 && self.doa.var_6ccec7c0 == 0) {
      self thread namespace_eaa992c::turnofffx("reviveAdvertise");
      self thread namespace_eaa992c::turnofffx("reviveActive");
    }
    if(self.doa.var_22d93250 > 0 && self.doa.var_70b102c6 == 0) {
      self thread namespace_eaa992c::turnofffx("reviveAdvertise");
      self thread namespace_eaa992c::function_285a2999("reviveActive");
    }
    self.doa.var_97c2af1a = self.doa.var_6ccec7c0;
    self.doa.var_70b102c6 = self.doa.var_22d93250;
  }
}

function function_285fe1ad() {
  self endon("disconnect");
  level endon("doa_game_is_over");
  self waittill("player_respawned");
  if(mayspawnentity()) {
    self playSound("evt_revived_respawn");
  }
}

function function_27202201() {
  self endon("disconnect");
  level endon("doa_game_is_over");
  self endon("player_respawned");
  self.doa.respawning = 1;
  self.var_9ea856f6 = level.doa.rules.var_575e919f;
  if(self.doa.fate == 2 || self.doa.fate == 11) {
    self.var_9ea856f6 = self.var_9ea856f6 - 10;
  }
  self thread function_b1958e58();
  self function_7f33210a();
  self thread namespace_eaa992c::function_285a2999("down_marker_" + function_ee495f41(self.entnum));
  while(self.var_9ea856f6 > 0) {
    wait(1);
    self.var_9ea856f6 = self.var_9ea856f6 - 1;
    if(self.doa.var_22d93250 > 0) {
      amount = int(math::clamp((self.doa.var_22d93250 - 1) + 3, 3, 5));
      if(mayspawnentity()) {
        playsoundatposition("evt_revive", self.origin);
      }
      self thread namespace_eaa992c::function_285a2999("reviveCredit");
      self.var_9ea856f6 = self.var_9ea856f6 - amount;
      foreach(savior in self.doa.var_b08ad9f8) {
        if(isDefined(savior.player)) {
          savior.player.doa.var_faf30682 = savior.player.doa.var_faf30682 + 1;
        }
      }
    }
    self freezecontrols(1);
    players = function_5eb6e4d1();
    count = 0;
    for(i = 0; i < players.size; i++) {
      if(!isalive(players[i]) || (isDefined(players[i].doa.respawning) && players[i].doa.respawning) && players[i].doa.lives == 0) {
        count++;
      }
    }
    if(count == players.size) {
      level flag::set("doa_game_is_over");
      level notify("hash_d1f5acf7");
      self.doa.respawning = 0;
      self.var_9ea856f6 = 0;
      return;
    }
  }
  self.doa.respawning = 0;
  self.var_9ea856f6 = 0;
  self function_ad1d5fcb();
}

function function_c7471371() {
  self endon("disconnect");
  level endon("doa_game_is_over");
  self thread function_bbdc9bc0();
  self thread function_27202201();
  while(self.lives == 0 && !level flag::get("doa_game_is_over")) {
    players = function_5eb6e4d1();
    richestplayer = undefined;
    biggestlives = 1;
    foreach(player in players) {
      if(player == self) {
        continue;
      }
      if(isDefined(player.var_744a3931)) {
        continue;
      }
      if(isDefined(player.doa.var_c5fe2763) && player.doa.var_c5fe2763) {
        continue;
      }
      if(player.doa.lives > biggestlives) {
        biggestlives = player.doa.lives;
        richestplayer = player;
      }
    }
    if(isDefined(richestplayer) && level flag::get("doa_round_active") && (isDefined(self.dead) && self.dead)) {
      level thread function_2f150493(richestplayer, self);
      return;
    }
    wait(1);
  }
}

function private function_79489c4c(time) {
  self endon("disconnect");
  level endon("doa_game_is_over");
  self notify("hash_79489c4c");
  self endon("hash_79489c4c");
  self.doa.var_c5fe2763 = 1;
  wait(time);
  self.doa.var_c5fe2763 = undefined;
}

function private function_c240f40e(source, dest, orb) {
  self endon("disconnect");
  dest endon("disconnect");
  level endon("doa_game_is_over");
  if(!isDefined(orb)) {
    orb = spawn("script_model", self.origin + vectorscale((0, 0, 1), 50));
    orb.targetname = "_lifeLink";
    orb setModel("tag_origin");
  }
  orb thread namespace_eaa992c::function_285a2999("trail_fast");
  orb thread doa_utility::function_a625b5d3(source);
  orb thread doa_utility::function_a625b5d3(dest);
  orb thread doa_utility::function_75e76155(source, "end_life_link");
  orb thread doa_utility::function_75e76155(dest, "playerLifeRespawn");
  orb thread doa_utility::function_783519c1("doa_game_is_over", 1);
  orb thread doa_utility::function_1bd67aef(4);
  end = dest.origin + vectorscale((0, 0, 1), 50);
  while(isDefined(orb)) {
    orb moveto(end, 0.2, 0, 0);
    wait(0.5);
    if(isDefined(orb)) {
      orb.origin = self.origin + vectorscale((0, 0, 1), 50);
    }
  }
}

function private function_2f150493(source, dest) {
  self endon("disconnect");
  level endon("doa_game_is_over");
  if(dest.doa.lives > 0) {
    return;
  }
  if(!isDefined(source) || source.doa.lives < 1) {
    return;
  }
  if(isDefined(source.doa.var_c5fe2763) && source.doa.var_c5fe2763) {
    return;
  }
  if(isDefined(dest.doa.var_c5fe2763) && dest.doa.var_c5fe2763) {
    return;
  }
  source thread function_79489c4c(60);
  source thread function_c240f40e(source, dest);
  dest thread function_79489c4c(level.doa.rules.var_378eec79 + 5);
  wait(1);
  origin = source.origin;
  pickup = spawn("script_model", origin);
  pickup.targetname = "_stealLifeFrom";
  pickup.angles = source.angles;
  pickup setModel(level.doa.extra_life_model);
  pickup thread namespace_eaa992c::function_285a2999("glow_white");
  source thread turnplayershieldon(1);
  pickup thread doa_utility::function_a625b5d3(source);
  pickup thread doa_utility::function_a625b5d3(dest);
  pickup thread doa_utility::function_75e76155(level, "doa_game_is_over");
  pickup moveto(dest.origin, 1, 0, 0);
  pickup thread namespace_1a381543::function_90118d8c("zmb_pickup_life_shimmer");
  pickup thread doa_utility::function_1bd67aef(3);
  pickup util::waittill_any_timeout(2, "movedone");
  source notify("end_life_link");
  pickup delete();
  if(!(isDefined(dest.doa.respawning) && dest.doa.respawning) || dest.doa.lives > 0) {
    return;
  }
  dest.doa.lives++;
  dest.doa.var_ec2548a9 = 1;
  dest.doa.var_67cd9d65++;
  source.doa.var_bfe4f859++;
  source.doa.lives--;
  if(source.doa.lives < 0) {
    source.doa.lives = 0;
  }
  if(isDefined(source.doa.vehicle)) {
    if(math::cointoss()) {
      doa_utility::debugmsg("" + source.name);
      level thread doa_pickups::directeditemawardto(source, level.doa.booster_model, 4);
    } else {
      doa_utility::debugmsg("" + source.name);
      level thread doa_pickups::directeditemawardto(source, level.doa.var_501f85b4, 3);
    }
    return;
  }
  roll = randomint(100);
  if(roll < 30 && gettime() > level.doa.var_d2b5415f) {
    level.doa.var_d2b5415f = gettime() + 60000;
    if(math::cointoss()) {
      doa_utility::debugmsg("" + source.name);
      source thread namespace_1a381543::function_90118d8c("zmb_army_skeleton");
      for(i = 0; i < 10; i++) {
        spot = doa_utility::function_14a10231(source.origin);
        level thread doa_pickups::function_411355c0(30, source, spot);
        wait(0.5);
      }
    } else {
      doa_utility::debugmsg("" + source.name);
      source thread namespace_1a381543::function_90118d8c("zmb_army_robot");
      for(i = 0; i < 4; i++) {
        spot = doa_utility::function_14a10231(source.origin);
        level thread doa_pickups::function_411355c0(31, source, spot);
        wait(0.5);
      }
    }
  } else {
    if(roll < 30) {
      wait(0.4);
      level thread doa_pickups::directeditemawardto(source, level.doa.var_97bbae9c);
      wait(0.4);
      level thread doa_pickups::directeditemawardto(source, level.doa.var_97bbae9c);
      wait(0.4);
      level thread doa_pickups::directeditemawardto(source, level.doa.var_97bbae9c);
      wait(0.4);
      level thread doa_pickups::directeditemawardto(source, level.doa.var_97bbae9c);
      level thread doa_pickups::directeditemawardto(source, level.doa.gloves);
    } else {
      if(roll < 40) {
        doa_utility::debugmsg("" + source.name);
        level thread doa_pickups::directeditemawardto(source, level.doa.var_501f85b4, 2);
      } else {
        if(roll < 50) {
          doa_utility::debugmsg("" + source.name);
          level thread doa_pickups::directeditemawardto(source, level.doa.booster_model, 3);
        } else {
          if(roll < 60) {
            doa_utility::debugmsg("" + source.name);
            level thread doa_pickups::directeditemawardto(source, level.doa.var_3b704a85);
          } else {
            if(roll < 70) {
              doa_utility::debugmsg("" + source.name);
              level thread doa_pickups::directeditemawardto(source, level.doa.var_f21ae3af);
            } else {
              if(roll < 80) {
                doa_utility::debugmsg("" + source.name);
                level thread doa_pickups::directeditemawardto(source, level.doa.var_d6256e83);
              } else {
                doa_utility::debugmsg("" + source.name);
                level thread doa_pickups::directeditemawardto(source, level.doa.var_8d63e734, 2);
              }
            }
          }
        }
      }
    }
  }
}

function function_60123d1c() {
  self notify("hash_cca1b1b9");
  self notify("kill_watch_player_in_combat");
  self notify("removehealthregen");
  self notify("nohealthoverlay");
  self notify("killspawnmonitor");
  self notify("killmonitorreloads");
  self notify("killrank");
  self notify("killspawnmonitor");
  self notify("killgrenademonitor");
  self notify("killhurtcheck");
  self notify("killteamchangemonitor");
  self notify("killhackermonitor");
  self notify("killreplaygunmonitor");
  self notify("track_riot_shield");
  self notify("killdtpmonitor");
  self notify("killgameendmonitor");
  self notify("killflashmonitor");
  self notify("killplayedtimemonitor");
  self notify("killplayersprintmonitor");
  self notify("killempmonitor");
  self notify("riotshieldtrackingstart");
  self notify("watch_remove_influencer");
  self notify("killoedmonitor");
  self notify("killmantlemonitor");
  self notify("new_cover_on_death_thread");
  self notify("bolttrackingstart");
  self notify("smoketrackingstart");
  self notify("emptrackingstart");
  self notify("proximitytrackingstart");
  self notify("insertiontrackingstart");
  self notify("grenadetrackingstart");
  self notify("hash_5c6cd2a");
  self notify("killonpainmonitor");
  self notify("killondeathmonitor");
  self notify("end_healthregen");
  level notify("stop_spawn_weight_debug");
}

function function_fea7ed75(num) {
  if(!isDefined(num)) {
    return (1, 1, 1);
  }
  switch (num) {
    case 0: {
      return (0, 1, 0);
    }
    case 1: {
      return (0, 0, 1);
    }
    case 2: {
      return (1, 0, 0);
    }
    case 3: {
      return (1, 1, 0);
    }
    default: {
      assert(0);
    }
  }
}

function function_e7e0aa7f(num) {
  return "glow_" + function_ee495f41(num);
}

function function_ee495f41(num) {
  switch (num) {
    case 0: {
      return "green";
    }
    case 1: {
      return "blue";
    }
    case 2: {
      return "red";
    }
    case 3: {
      return "yellow";
    }
    default: {
      assert(0);
    }
  }
}

function function_5eb6e4d1() {
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

function function_35f36dec(origin) {
  players = function_5eb6e4d1();
  if(players.size == 0) {
    return undefined;
  }
  if(players.size == 1) {
    return players[0];
  }
  bestent = players[0];
  bestsq = 8192 * 8192;
  foreach(player in players) {
    if(!isDefined(player) || !isalive(player)) {
      continue;
    }
    if(isDefined(player.ignoreme) && player.ignoreme) {
      continue;
    }
    distsq = distancesquared(player.origin, origin);
    if(distsq < bestsq) {
      bestent = player;
      bestsq = distsq;
    }
  }
  return bestent;
}

function function_f300c612() {
  self endon("disconnect");
  self notify("hash_f300c612");
  self endon("hash_f300c612");
  while(true) {
    wait(0.05);
    if(isDefined(self.doa.var_f4a883ed) && self.doa.var_f4a883ed) {
      namespace_2f63e553::drawcylinder(self.origin, 50, 50, 1, (1, 0, 0));
    }
  }
}

function function_4519b17(on, clear = 0) {
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }
  if(clear) {
    self.doa.var_f4a883ed = undefined;
    self disableinvulnerability();
    self.takedamage = 1;
  }
  if(isDefined(level.doa.var_e5a69065) && level.doa.var_e5a69065) {
    self thread function_f300c612();
  }
  if(on) {
    if(!isDefined(self.doa.var_f4a883ed)) {
      self.doa.var_f4a883ed = 1;
      self enableinvulnerability();
      self.takedamage = 0;
    } else {
      assert(self.doa.var_f4a883ed > 0);
      self.doa.var_f4a883ed++;
    }
  } else {
    if(isDefined(self.doa.var_f4a883ed)) {
      self.doa.var_f4a883ed--;
    }
    if(!isDefined(self.doa.var_f4a883ed) || self.doa.var_f4a883ed == 0) {
      self.doa.var_f4a883ed = undefined;
      self disableinvulnerability();
      self.takedamage = 1;
    }
  }
}

function function_139199e1(type) {
  while(!level flag::get("doa_round_active")) {
    wait(0.05);
  }
  if(!isDefined(type)) {
    if(randomint(100) > 50) {
      type = "fury";
    } else {
      type = "force";
    }
  }
  if(self.doa.fate == 10 && type == "fury") {
    type = "force";
  }
  if(self.doa.fate == 13 && type == "force") {
    type = "fury";
  }
  level thread doa_utility::function_c5f3ece8(&"DOA_CHALLENGE_VICTOR");
  wait(3);
  level.doa.var_9b77ca48 = 1;
  switch (type) {
    case "fury": {
      level thread doa_utility::function_37fb5c23(&"DOA_REWARD_FURY");
      var_213a57a7 = self.doa.default_weap;
      wait(2);
      level thread doa_fate::function_17fb777b(self, "zombietron_statue_fury", 0.5, &donothing);
      self.doa.default_weap = level.doa.var_69899304;
      self function_d5f89a15(self.doa.default_weap.name);
      while(level flag::get("doa_round_active")) {
        wait(0.05);
      }
      self.doa.default_weap = var_213a57a7;
      self function_d5f89a15(self.doa.default_weap.name);
      break;
    }
    case "force": {
      level thread doa_utility::function_37fb5c23(&"DOA_REWARD_FORCE");
      wait(1);
      level thread doa_pickups::directeditemawardto(self, level.doa.booster_model, 6);
      wait(1);
      level thread doa_fate::function_17fb777b(self, "zombietron_statue_force", 0.5, &donothing);
      self.doa.var_480b6280 = 1;
      var_2b4d4c09 = self.doa.default_movespeed;
      self.doa.default_movespeed = level.doa.rules.var_b92b82b;
      self setmovespeedscale(self.doa.default_movespeed);
      while(level flag::get("doa_round_active")) {
        wait(0.05);
      }
      self.doa.var_480b6280 = undefined;
      self.doa.default_movespeed = var_2b4d4c09;
      self setmovespeedscale(self.doa.default_movespeed);
      break;
    }
  }
  level thread doa_utility::function_c5f3ece8(&"DOA_REWARD_EXPIRE");
  wait(2);
  level thread doa_utility::function_37fb5c23(&"DOA_REWARD_EXPIRE2");
  wait(7);
  level.doa.var_9b77ca48 = undefined;
  level.doa.var_c03fe5f1 = undefined;
}

function donothing() {}
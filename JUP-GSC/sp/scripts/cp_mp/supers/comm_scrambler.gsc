/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\supers\comm_scrambler.gsc
***************************************************/



#using script_608c50392df8c7d1;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace comm_scrambler;

function autoexec main() {
  registersharedfunc("super_comm_scrambler", "init", &function_902e316237968d37);
  registersharedfunc("super_comm_scrambler", "get_and_handle_killstreak_blocking", &function_2ed5e780857f0eaf);
}

function function_902e316237968d37() {
  level.var_4e74070c2484e644 = [];

  if(issharedfuncdefined("team_utility", "joinrTeamAggregator")) {
    [[getsharedfunc("team_utility", "joinTeamAggregator")]](&function_5bb22bae2eafed7);
  }

  registersharedfunc("super_comm_scrambler", "commScrambler_used", &commscrambler_used);
  registersharedfunc("super_comm_scrambler", "commScrambler_onHacked", &commscrambler_onhacked);
}

function commscrambler_used(grenade) {
  grenade endon("death");
  level endon("game_ended");
  grenade.owner = self;
  grenade.issuper = 1;
  grenade.superid = level.superglobals.staticsuperdata["super_comm_scrambler"].id;
  grenade.bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_comm_scrambler");
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade thread function_cbc5bc96e58659c7();
  grenade thread function_44a7cc547d0a4415();
  grenade thread function_cf6202f14a8176f(self);
  grenade waittill("missile_stuck", stuckto);
  grenade function_d25ff4a17fd8fb37(stuckto);

  if(issharedfuncdefined("weapons", "onEquipmentPlanted")) {
    self[[getsharedfunc("weapons", "onEquipmentPlanted")]](grenade, "equip_comm_scrambler", &function_4ee728f14862d601);
  }

  grenade setscriptablepartstate("activate", "activate", 0);
  level.var_4e74070c2484e644[grenade getentitynumber()] = grenade;

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_2233a8cd9c48a336);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_93e55db60b551e17);
  }

  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_2233a8cd9c48a336);
  grenade scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_93e55db60b551e17);
  grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_89a8296f4d744235);
  grenade function_e26cc89366241706();
  grenade.isactive = 1;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);

  if(issharedfuncdefined("game", "createObjective")) {
    grenade.minimapid = grenade[[getsharedfunc("game", "createObjective")]]("jup_hud_icon_minimap_fieldupgrade_commscrambler", grenade.team, 0, 1, 1);
    triggerradius = getdvarfloat(@ "hash_304ea9c01d3fa58b", grenade.bundle.var_783b73889965c476);
    grenade scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("TestCircle", grenade.origin, triggerradius);
    grenade scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
  }

  grenade function_c3decb14deedd3d2();
  grenade setscriptablepartstate("enemies_present", "not_present", 0);
  grenade childthread function_b181719d99fb654e();
  grenade childthread function_a7a8818b75adcad8();

  if(!isai(self) && istrue(grenade.bundle.var_a6682e1889a48304) && issharedfuncdefined("player", "doScoreEvent")) {
    grenade childthread function_8a689b49bffeed79();
    grenade.var_2020fa0ae4d1323d = 0;
    grenade.var_4b15951dd656dcc0 = [];
    grenade childthread function_71f37f039649db2c();
    grenade childthread function_50c6e9ffe406b26e();
    grenade childthread function_3aed59109065b38a();
  }

  scripts\cp_mp\challenges::function_d997435895422ecc("super_comm_scrambler", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
}

function function_4ee728f14862d601(wasdestroyed) {
  deletiondelay = 0.1;
  moving_platform = undefined;
  fxoriginoffset = undefined;
  thread function_1d4ab8d63dbf796e(deletiondelay, wasdestroyed);

  if(isDefined(self)) {
    fxorigin = self.origin;
    fxforward = anglesToForward(self.angles);
    fxup = anglestoup(self.angles);
    var_dfdfaa4e665b31fc = self getlinkedparent();

    if(isDefined(var_dfdfaa4e665b31fc)) {
      moving_platform = var_dfdfaa4e665b31fc;
      fxoriginoffset = moving_platform.origin - fxorigin;
    }

    self setscriptablepartstate("destroy", "active", 0);

    if(isDefined(moving_platform) && isent(moving_platform)) {
      fxorigin = moving_platform.origin - fxoriginoffset;
    }
  }
}

function function_1d4ab8d63dbf796e(deletiondelay, wasdestroyed) {
  self notify("death");
  wait deletiondelay;
  self.isdestroyed = 1;
  self setCanDamage(0);
  self.exploding = 1;

  if(isDefined(self.owner) && issharedfuncdefined("weapons", "removeEquip")) {
    self.owner[[getsharedfunc("weapons", "removeEquip")]](self);
  }

  function_e016066e327d42b6();
  clearminimapid();
  scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();

  if(issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
    [[getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.superid, self.usedcount, istrue(wasdestroyed));
  }

  function_d82a67223a4e56d9();
  level.var_4e74070c2484e644[self getentitynumber()] = undefined;
  self.owner scripts\cp_mp\challenges::function_d997435895422ecc("super_comm_scrambler", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), self.usedcount);
  self delete();
}

function function_d82a67223a4e56d9() {
  if(!isDefined(self.trigger)) {
    return;
  }

  foreach(player in self.trigger.playersintrigger) {
    player function_95b4fc5672916c93(self, id);
  }

  self.trigger delete();
}

function function_c3decb14deedd3d2() {
  triggerradius = getdvarint(@ "hash_304ea9c01d3fa58b", self.bundle.var_783b73889965c476);
  triggerheight = getdvarint(@ "hash_d9d5ba0482f401a", self.bundle.var_1836009701d3c8b);
  spawnpoint = (self.origin[0], self.origin[1], self.origin[2] - triggerheight / 2);
  self.trigger = spawn("trigger_radius", spawnpoint, 0, triggerradius, triggerheight);
  self.trigger.playersintrigger = [];
  self.trigger.var_854cf4c64f4bdd9f = [];
  self.trigger.var_a81e3fef4236357a = [];
  self.trigger enablelinkTo();
  self.trigger linkTo(self);

  if(getdvarint(@ "hash_7a6de10a710dbdbe", 0) == 1) {
    end = (self.origin[0], self.origin[1], self.origin[2] + triggerheight / 2);
    lifetime = getdvarint(@ "hash_2467b36602d82d7f", self.bundle.maxlifetime);
    cylinder(spawnpoint, end, triggerradius, (1, 0, 0), 0, 20 * lifetime);
  }
}

function function_b181719d99fb654e() {
  while(true) {
    self.trigger waittill("trigger");
    var_5fd22bb97d499b04 = self.trigger getistouchingentities(level.players);

    foreach(player in var_5fd22bb97d499b04) {
      if(!isalive(player)) {
        continue;
      }

      entitynumber = player getentitynumber();

      if(!array_contains_key(self.trigger.playersintrigger, entitynumber)) {
        self.trigger.playersintrigger[entitynumber] = player;

        if(self.isactive) {
          player function_ac6ba9556aa071b2(self, entitynumber);
        }
      }
    }
  }
}

function function_ac6ba9556aa071b2(grenade, id) {
  if(isenemy(grenade.owner)) {
    if(grenade.trigger.var_a81e3fef4236357a.size == 0) {
      grenade setscriptablepartstate("enemies_present", "present", 0);
    }

    grenade.trigger.var_a81e3fef4236357a = function_6d6af8144a5131f1(grenade.trigger.var_a81e3fef4236357a, id);

    if(!isDefined(self.var_13c9d77f4a31f4cd)) {
      self.var_13c9d77f4a31f4cd = [];
    }

    self.var_13c9d77f4a31f4cd = function_6d6af8144a5131f1(self.var_13c9d77f4a31f4cd, grenade);
    self setclientomnvar("ui_gameplay_comm_scrambler_active", 1);
    self playsoundtoplayer("eqp_comm_scrambler_ui_enemyscrambled_transient", self);
    return;
  }

  grenade.trigger.var_854cf4c64f4bdd9f = function_6d6af8144a5131f1(grenade.trigger.var_854cf4c64f4bdd9f, id);
  self setplayerghost(1);
  self setplayeradvanceduavdot(1);
  self.var_8d9c40fe23269431 = 1;
}

function function_a7a8818b75adcad8() {
  while(true) {
    foreach(id, player in self.trigger.playersintrigger) {
      if(!isDefined(player)) {
        self.trigger.playersintrigger[id] = undefined;
        self.trigger.var_854cf4c64f4bdd9f = array_remove(self.trigger.var_854cf4c64f4bdd9f, id);
        self.trigger.var_a81e3fef4236357a = array_remove(self.trigger.var_a81e3fef4236357a, id);
        continue;
      }

      if(!player istouching(self.trigger) || !player scripts\cp_mp\utility\player_utility::_isalive()) {
        self.trigger.playersintrigger[id] = undefined;

        if(self.isactive) {
          player function_95b4fc5672916c93(self, id);
        }
      }
    }

    waitframe();
  }
}

function function_95b4fc5672916c93(grenade, id, owner) {
  if(!isDefined(owner)) {
    owner = grenade.owner;
  }

  if(isenemy(owner)) {
    grenade.trigger.var_a81e3fef4236357a = array_remove(grenade.trigger.var_a81e3fef4236357a, id);

    if(grenade.trigger.var_a81e3fef4236357a.size == 0) {
      grenade setscriptablepartstate("enemies_present", "not_present", 0);
    }

    self.var_13c9d77f4a31f4cd = array_remove(self.var_13c9d77f4a31f4cd, grenade);
    self setclientomnvar("ui_gameplay_comm_scrambler_active", 0);
    return;
  }

  grenade.trigger.var_854cf4c64f4bdd9f = array_remove(grenade.trigger.var_854cf4c64f4bdd9f, id);
  self setplayerghost(0);
  self setplayeradvanceduavdot(0);
  self.var_8d9c40fe23269431 = 0;
}

function function_2ed5e780857f0eaf(streakitem) {
  if(isDefined(self.var_13c9d77f4a31f4cd) && self.var_13c9d77f4a31f4cd.size > 0) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/COMM_SCRAMBLER_KILLSTREAK_BLOCKED_MESSAGE");
    }

    self playsoundtoplayer("eqp_comm_scrambler_ui_killstreak_disabled", self);

    foreach(commscrambler in self.var_13c9d77f4a31f4cd) {
      commscrambler notify("killstreak_blocked", self);
    }

    return 1;
  }

  return 0;
}

function function_8a689b49bffeed79() {
  self.var_9a1a850927bb996f = [];

  while(true) {
    self waittill("killstreak_blocked", playerblocked);
    playerentitynum = playerblocked getentitynumber();
    currenttime = gettime();
    mintime = self.bundle.var_c5ae6960f76c1782 * 1000;

    if(!array_contains_key(self.var_9a1a850927bb996f, playerentitynum) || currenttime - self.var_9a1a850927bb996f[playerentitynum] > mintime) {
      self.var_9a1a850927bb996f[playerentitynum] = currenttime;
      self.owner thread[[getsharedfunc("player", "doScoreEvent")]](#"hash_f3628c75d8e3e7c3");
    }
  }
}

function function_71f37f039649db2c() {
  var_fd999362783c862f = self.bundle.var_c93862714a3e756e * 1000;

  while(true) {
    var_294e2c9657f8efff = gettime() - self.var_2020fa0ae4d1323d;

    if(var_294e2c9657f8efff < var_fd999362783c862f) {
      wait(var_fd999362783c862f - var_294e2c9657f8efff) / 1000;
    }

    if(self.isactive) {
      var_7b847e685b032554 = 0;

      if(level.teambased) {
        var_7b847e685b032554 = default_to(level.activeuavs[self.owner.team], 0);
      } else {
        var_7b847e685b032554 = default_to(level.activeuavs[self.owner.guid], 0);
      }

      hasuav = level.totalactiveuavs - var_7b847e685b032554 > 0;

      if(!hasuav) {
        var_71f10319cd3043a9 = 0;

        if(level.teambased) {
          var_71f10319cd3043a9 = default_to(level.activeadvanceduavs[self.owner.team], 0);
        } else {
          var_71f10319cd3043a9 = default_to(level.activeadvanceduavs[self.owner.guid], 0);
        }

        hasuav = level.activeadvanceduavcount - var_71f10319cd3043a9 > 0;
      }

      if(hasuav) {
        var_88859a5a22b4de6e = array_difference(self.trigger.var_854cf4c64f4bdd9f, self.var_4b15951dd656dcc0);

        if(var_88859a5a22b4de6e.size > 0) {
          function_e082ef4196a28f0b(var_88859a5a22b4de6e);
        }
      }
    }

    wait 0.5;
  }
}

function function_50c6e9ffe406b26e() {
  while(true) {
    level waittill("portable_radar_ping", pingposition, pingplayer, pingradius);

    if(self.isactive && pingplayer isenemy(self.owner)) {
      function_721fd61e3d39a6fc(pingposition, pingradius);
    }
  }
}

function function_3aed59109065b38a() {
  while(true) {
    level waittill("portable_radar_ping_team", pingposition, pingteam, pingradius);

    if(self.isactive && pingteam != self.owner.team) {
      function_721fd61e3d39a6fc(pingposition, pingradius);
    }
  }
}

function function_721fd61e3d39a6fc(pingposition, pingradius) {
  var_fd999362783c862f = self.bundle.var_c93862714a3e756e * 1000;
  var_294e2c9657f8efff = gettime() - self.var_2020fa0ae4d1323d;

  if(var_294e2c9657f8efff < var_fd999362783c862f) {
    return;
  }

  var_5826f64c707f910b = array_difference(self.trigger.var_854cf4c64f4bdd9f, self.var_4b15951dd656dcc0);
  var_b9f63f8c68e691de = [];

  foreach(var_508f4872bf68fa46 in var_5826f64c707f910b) {
    var_433f5b38c7205a99 = self.trigger.playersintrigger[var_508f4872bf68fa46];
    var_8081987ef05481dd = distancesquared(var_433f5b38c7205a99.origin, pingposition);
    var_3b85a2c354f9ce88 = float(pingradius * pingradius);

    if(var_8081987ef05481dd < var_3b85a2c354f9ce88) {
      var_b9f63f8c68e691de = function_6d6af8144a5131f1(var_b9f63f8c68e691de, var_508f4872bf68fa46);
    }
  }

  if(var_b9f63f8c68e691de.size > 0) {
    function_e082ef4196a28f0b(var_b9f63f8c68e691de);
  }
}

function function_e082ef4196a28f0b(var_88859a5a22b4de6e) {
  self.owner thread[[getsharedfunc("player", "doScoreEvent")]](#"hash_a292bcf7d6cdc45");
  self.var_2020fa0ae4d1323d = gettime();
  self.var_4b15951dd656dcc0 = array_combine(self.var_4b15951dd656dcc0, var_88859a5a22b4de6e);
}

function function_741968e8ad6d8f0a(isactive) {
  if(isactive == self.isactive) {
    return;
  }

  if(isactive) {
    self.isactive = 1;

    foreach(id, player in self.trigger.playersintrigger) {
      player function_ac6ba9556aa071b2(self, id);
    }

    return;
  }

  self.isactive = 0;

  foreach(player in self.trigger.playersintrigger) {
    player function_95b4fc5672916c93(self, id);
  }
}

function function_e26cc89366241706() {
  if(issharedfuncdefined("damage", "monitorDamage")) {
    self thread[[getsharedfunc("damage", "monitorDamage")]](self.bundle.maxhealth, "hitequip", &function_5013def65fabcc8a, &function_79a97ee01dc267d3);
  }
}

function function_5013def65fabcc8a(data) {
  function_1b38460f9db6a610(data.attacker);
  thread function_4ee728f14862d601(1);
}

function function_38c09c457c05cec6() {
  if(isDefined(self.outlineid)) {
    if(issharedfuncdefined("outline", "outlineDisable")) {
      [[getsharedfunc("outline", "outlineDisable")]](self.outlineid, self);
    }
  }
}

function function_e016066e327d42b6() {
  if(isDefined(self.headiconid)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
    self.headiconid = undefined;
  }

  if(isDefined(self.headiconfaction)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconfaction);
    self.headiconfaction = undefined;
  }
}

function function_1b38460f9db6a610(attacker) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");

    if(issharedfuncdefined("player", "doScoreEvent")) {
      attacker thread[[getsharedfunc("player", "doScoreEvent")]](#"destroyed_equipment");
    }

    if(issharedfuncdefined("battlechatter", "equipmentDestroyed")) {
      [[getsharedfunc("battlechatter", "equipmentDestroyed")]](self);
    }
  }
}

function function_141dc243d9b500e1(data) {
  function_4ee728f14862d601(0);
}

function function_384bb480ddf5851c(data) {
  owner = self.owner;

  if(!isDefined(owner)) {
    return;
  }

  superinfo = undefined;

  if(issharedfuncdefined("player", "getCurrentSuper")) {
    superinfo = owner[[getsharedfunc("player", "getCurrentSuper")]]();
  }

  if(isDefined(superinfo) && level.allowsupers) {
    superinfo.wasrefunded = 1;

    if(issharedfuncdefined("supers", "getSuperPointsNeeded") && issharedfuncdefined("supers", "setSuperBasePoints")) {
      owner[[getsharedfunc("supers", "setSuperBasePoints")]](owner[[getsharedfunc("supers", "getSuperPointsNeeded")]]());
    }
  }

  function_4ee728f14862d601(0);
}

function function_d25ff4a17fd8fb37(stuckto) {
  data = spawnStruct();
  data.linkparent = stuckto;
  data.deathoverridecallback = &function_141dc243d9b500e1;
  data.invalidparentoverridecallback = &function_384bb480ddf5851c;
  data.endonstring = "death";
  data.validateaccuratetouching = 1;

  if(isDefined(stuckto) && scripts\cp_mp\utility\train_utility::is_train_ent(stuckto)) {
    data.plantedontrain = 1;
    self setmissileantilagged(1);
  }

  if(issharedfuncdefined("game", "handlemovingplatforms")) {
    self thread[[getsharedfunc("game", "handlemovingplatforms")]](data);
  }
}

function function_cf6202f14a8176f(player) {
  self endon("death");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }

  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  tracecontents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  var_3a7f0173b03f5767 = -2000;
  traceend = self.origin + (0, 0, var_3a7f0173b03f5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);

  if(traceresults["fraction"] < 1) {
    groundentity = traceresults["entity"];

    if(isDefined(groundentity)) {
      if(scripts\cp_mp\utility\train_utility::is_train_ent(groundentity)) {
        self.origin = player.origin;
      }
    }
  }
}

function function_cbc5bc96e58659c7() {
  self endon("death");

  if(issharedfuncdefined("hostmigration", "waitLongDurationWithPause")) {
    [[getsharedfunc("hostmigration", "waitLongDurationWithPause")]](getdvarfloat(@ "hash_2467b36602d82d7f", self.bundle.maxlifetime));
  }

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread function_4ee728f14862d601(0);
  }
}

function function_44a7cc547d0a4415() {
  self endon("death");
  self endon("comm_scrambler_hacked");
  self.owner waittill_any_return_no_endon_death_3("disconnect", "joined_team", "joined_spectators");

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    thread function_4ee728f14862d601(0);
  }
}

function function_2233a8cd9c48a336(data) {
  function_741968e8ad6d8f0a(0);

  if(isDefined(data.attacker)) {
    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("disabled_comm_scrambler");
    }
  }
}

function function_93e55db60b551e17(data) {
  function_741968e8ad6d8f0a(1);
}

function function_89a8296f4d744235(data) {
  attacker = data.attacker;
  function_1b38460f9db6a610(attacker);
  thread function_4ee728f14862d601(1);
}

function function_5bb22bae2eafed7(player) {
  foreach(commscrambler in level.var_4e74070c2484e644) {
    if(isDefined(commscrambler)) {
      commscrambler function_7b2d108a7fefb17(player);
    }
  }
}

function function_4957058182ec35a8() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_7b2d108a7fefb17(player);
  }
}

function function_7b2d108a7fefb17(player) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.owner)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  idfaction = self.headiconfaction;

  if(!isDefined(idfaction)) {
    return;
  }

  isfriendly = undefined;

  if(issharedfuncdefined("player", "isFriendly")) {
    isfriendly = [[getsharedfunc("player", "isFriendly")]](self.owner.team, player);
  }

  isused = isDefined(self.playersused) && isDefined(self.playersused[player getentitynumber()]);

  if(isfriendly && !isused) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(idfaction, player);
    return;
  }

  if(isfriendly) {
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(idfaction, player);
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(idfaction, player);
}

function commscrambler_onhacked(newowner, oldowner) {
  clearminimapid();

  if(issharedfuncdefined("game", "createObjective")) {
    self.minimapid = self[[getsharedfunc("game", "createObjective")]]("jup_hud_icon_minimap_fieldupgrade_commscrambler", self.team, 0, 1, 1);
  }

  foreach(player in self.trigger.playersintrigger) {
    player function_95b4fc5672916c93(self, id, oldowner);
  }

  self.trigger.playersintrigger = [];
  self.trigger.var_854cf4c64f4bdd9f = [];
  self.trigger.var_a81e3fef4236357a = [];
  self notify("comm_scrambler_hacked");
  thread function_44a7cc547d0a4415();
}
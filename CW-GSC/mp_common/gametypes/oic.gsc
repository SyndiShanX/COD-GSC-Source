/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\oic.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace oic;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  level.pointsperweaponkill = getgametypesetting("pointsPerWeaponKill") * 10;
  level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill") * 10;
  level.pointsforsurvivalbonus = getgametypesetting("pointsForSurvivalBonus") * 10;
  level.var_18823aed = 60;
  util::registerscorelimit(0, 50000);
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.givecustomloadout = &givecustomloadout;
  level.onplayerdamage = &onplayerdamage;
  level.onendgame = &onendgame;
  player::function_cf3aa03d(&onplayerkilled);
  callback::on_connect(&function_1ccf32e3);
  callback::on_disconnect(&onplayerdisconnect);
  oic_perks = [];

  if(!isDefined(oic_perks)) {
    oic_perks = [];
  } else if(!isarray(oic_perks)) {
    oic_perks = array(oic_perks);
  }

  oic_perks[oic_perks.size] = "specialty_sprint";

  if(!isDefined(oic_perks)) {
    oic_perks = [];
  } else if(!isarray(oic_perks)) {
    oic_perks = array(oic_perks);
  }

  oic_perks[oic_perks.size] = "specialty_slide";
  level.oic_perks = oic_perks;
  spawning::addsupportedspawnpointtype("ffa");
  weaponsetup();
  level.takelivesondeath = 1;
  clientfield::register_clientuimodel("hudItems.alivePlayerCount", 1, 4, "int", 1);
}

function onplayerdisconnect() {
  function_1ccf32e3();
  level notify(#"player_disconnected");
}

function private function_1ccf32e3() {
  count = getplayersleft().size;
  players = getplayers();

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isalive(player)) {
      player clientfield::set_player_uimodel("hudItems.alivePlayerCount", count - 1);
      continue;
    }

    player clientfield::set_player_uimodel("hudItems.alivePlayerCount", count);
  }
}

function weaponsetup() {
  loadouts = getscriptbundle(#"hash_70f762f93571635a");

  if(!isDefined(loadouts)) {
    assertmsg("<dev string:x38>");
    return;
  }

  var_c669d611 = isDefined(loadouts.var_4509f8e) ? loadouts.var_4509f8e : [];

  if(var_c669d611.size == 0) {
    assertmsg("<dev string:x52>");
    return;
  }

  tiers = isDefined(var_c669d611[0].tiers) ? var_c669d611[0].tiers : [];

  if(tiers.size == 0) {
    assertmsg("<dev string:x84>");
    return;
  }

  weaponoptions = isDefined(tiers[0].options) ? tiers[0].options : [];

  if(weaponoptions.size == 0) {
    assertmsg("<dev string:xaa>");
    return;
  }

  weaponoptions = array::randomize(weaponoptions);

  foreach(weaponoption in weaponoptions) {
    if(isDefined(weaponoption.weapon)) {
      level.var_bf82f6b0 = weaponoption.weapon;
      break;
    }
  }

  if(!isDefined(level.var_bf82f6b0)) {
    assertmsg("<dev string:xdc>");
    return;
  }
}

function onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(psoffsettime == "MOD_PISTOL_BULLET" || psoffsettime == "MOD_RIFLE_BULLET" || psoffsettime == "MOD_HEAD_SHOT" || psoffsettime == "MOD_MELEE_WEAPON_BUTT") {
    shitloc = self.maxhealth + 1;
  }

  return shitloc;
}

function givecustomloadout() {
  loadout::init_player(1);
  loadout::function_f436358b(self.curclass);
  actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
  self setactionslot(3, actionslot3);
  actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
  self setactionslot(4, actionslot4);
  weapon = level.var_bf82f6b0;
  weapon.var_a2e7031d = 1;
  self giveweapon(weapon);
  self switchtoweapon(weapon);
  clipammo = 1;

  if(isDefined(self.pers[# "clip_ammo"])) {
    clipammo = self.pers[# "clip_ammo"];
    self.pers[# "clip_ammo"] = undefined;
  }

  self setweaponammoclip(weapon, clipammo);
  stockammo = 0;

  if(isDefined(self.pers[# "stock_ammo"])) {
    stockammo = self.pers[# "stock_ammo"];
    self.pers[# "stock_ammo"] = undefined;
  }

  self setweaponammostock(weapon, stockammo);
  self setspawnweapon(weapon);
  self giveperks();
  e_whippings = isDefined(getgametypesetting(#"hash_4ca06c610b5d53bd")) ? getgametypesetting(#"hash_4ca06c610b5d53bd") : 0;

  if(!e_whippings) {
    secondaryoffhand = getweapon(#"gadget_health_regen");
    secondaryoffhandcount = 1;
    self giveweapon(secondaryoffhand);
    self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
    self switchtooffhand(secondaryoffhand);
    loadout = self loadout::get_loadout_slot("specialgrenade");
    loadout.weapon = secondaryoffhand;
    loadout.count = secondaryoffhandcount;
    self ability_util::gadget_power_full(secondaryoffhand);
  }

  self disableweaponpickup();
  self loadout::function_6573eeeb();
  return weapon;
}

function giveperks() {
  self clearperks();

  foreach(perkname in level.oic_perks) {
    if(!self hasperk(perkname)) {
      self setperk(perkname);
    }
  }
}

function onstartgametype() {
  allowed[0] = "oic";
  level.displayroundendtext = 0;
  level thread watchelimination();
}

function onspawnplayer(predictedspawn) {
  if(!level.inprematchperiod) {
    spawning::function_7a87efaa();
  }

  spawning::onspawnplayer(predictedspawn);
  clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a);

  if(self.pers[# "lives"] == 1) {
    self thread function_1929a66c();
  }

  function_1ccf32e3();
}

function function_1929a66c() {
  level endon(#"game_ended");
  wait 0.5;

  if(!isPlayer(self) || !isalive(self)) {
    return;
  }

  self globallogic_audio::leader_dialog_on_player("oicLastLife");
}

function onendgame(var_c1e98979) {
  player = round::function_b5f4c9d8();
  match::set_winner(player);
}

function saveoffallplayersammo() {
  wait 1;

  for(playerindex = 0; playerindex < level.players.size; playerindex++) {
    player = level.players[playerindex];

    if(!isDefined(player)) {
      continue;
    }

    if(player.pers[# "lives"] == 0) {
      continue;
    }

    currentweapon = player getcurrentweapon();
    player.pers[# "clip_ammo"] = player getweaponammoclip(currentweapon);
    player.pers[# "stock_ammo"] = player getweaponammostock(currentweapon);
  }
}

function isplayereliminated(player) {
  return isDefined(player.pers[# "lives"]) && player.pers[# "lives"] <= 0;
}

function isplayerspectating(player) {
  return player util::is_spectating();
}

function getplayersleft() {
  playersremaining = [];

  for(playerindex = 0; playerindex < level.players.size; playerindex++) {
    player = level.players[playerindex];

    if(!isDefined(player)) {
      continue;
    }

    if(!isplayereliminated(player) && !isplayerspectating(player)) {
      playersremaining[playersremaining.size] = player;
    }
  }

  return playersremaining;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(shitloc) && isPlayer(shitloc) && self != shitloc) {
    deathanimduration = level.var_bf82f6b0;
    attackerammo = shitloc getammocount(deathanimduration);
    victimammo = self getammocount(deathanimduration);

    if(attackerammo < 3) {
      shitloc giveammo(1);
    }

    shitloc playlocalsound("mpl_oic_bullet_pickup");

    if(psoffsettime == "MOD_MELEE" || psoffsettime == "MOD_MELEE_WEAPON_BUTT") {
      shitloc globallogic_score::givepointstowin(level.pointspermeleekill);

      if(attackerammo > 0) {
        scoreevents::processscoreevent(#"knife_with_ammo_oic", shitloc, self, deathanimduration);
      }

      if(victimammo > attackerammo) {
        scoreevents::processscoreevent(#"kill_enemy_with_more_ammo_oic", shitloc, self, deathanimduration);
      }
    } else {
      shitloc globallogic_score::givepointstowin(level.pointsperweaponkill);

      if(victimammo > attackerammo + 1) {
        scoreevents::processscoreevent(#"kill_enemy_with_more_ammo_oic", shitloc, self, deathanimduration);
      }
    }

    if(self.pers[# "lives"] == 0) {
      scoreevents::processscoreevent(#"eliminated_enemy", shitloc, self, deathanimduration);
    }
  }

  if(isDefined(self) && self.pers[# "lives"] == 0) {
    self thread function_864bcb5c();
  }

  function_1ccf32e3();
}

function private function_864bcb5c() {
  self luinotifyevent(#"oic_eliminated", 1, 1);
  self function_665f1a43();

  if(isDefined(self)) {
    self luinotifyevent(#"oic_eliminated", 1, 0);
  }
}

function function_665f1a43() {
  level endon(#"game_ended");

  if(!isDefined(self)) {
    return;
  }

  self waittilltimeout(5, #"begin_killcam", #"spawned", #"joined_spectator");
}

function giveammo(amount) {
  currentweapon = self getcurrentweapon();
  clipammo = self getweaponammoclip(currentweapon);
  self setweaponammoclip(currentweapon, clipammo + amount);
}

function shouldreceivesurvivorbonus() {
  if(isalive(self)) {
    return true;
  }

  if(self.hasspawned && self.pers[# "lives"] > 0) {
    return true;
  }

  return false;
}

function watchelimination() {
  level endon(#"game_ended");

  for(;;) {
    level waittill(#"player_eliminated", #"player_disconnected");
    players = level.players;

    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i]) && players[i] shouldreceivesurvivorbonus()) {
        players[i].pers[# "survived"]++;
        players[i].survived = players[i].pers[# "survived"];
        scoreevents::processscoreevent(#"survivor", players[i]);
        players[i] globallogic_score::givepointstowin(level.pointsforsurvivalbonus);
      }
    }

    survivors = getplayersleft();

    if(survivors.size == 2) {
      level thread function_ce7ffccb();
      continue;
    }

    if(survivors.size < 2) {
      winner = globallogic_score::function_15683f39();
      round::set_winner(winner);
      match::set_winner(winner);
      thread globallogic::end_round(6);
    }
  }
}

function private function_ce7ffccb(winner) {
  if(globallogic_utils::gettimeremaining() <= int(level.var_18823aed * 1000)) {
    return;
  }

  if(level.var_18823aed > 0) {
    level.timelimitoverride = 1;
    setgameendtime(gettime() + int(level.var_18823aed * 1000));
    hostmigration::waitlongdurationwithgameendtimeupdate(level.var_18823aed);

    if(game.state != # "playing") {
      return;
    }
  }

  winner = globallogic_score::function_15683f39();
  round::set_winner(winner);
  match::set_winner(winner);
  thread globallogic::end_round(2);
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\oic.gsc
***********************************************/

#include scripts\abilities\ability_util;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_defaults;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\globallogic_ui;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\gametypes\spawning;
#include scripts\mp_common\player\player_loadout;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\util;
#include scripts\weapons\weapon_utils;

#namespace oic;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  level.pointsperweaponkill = getgametypesetting("pointsPerWeaponKill") * 10;
  level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill") * 10;
  level.pointsforsurvivalbonus = getgametypesetting("pointsForSurvivalBonus") * 10;
  level.var_18823aed = 60;
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.givecustomloadout = &givecustomloadout;
  level.onplayerdamage = &onplayerdamage;
  level.onendgame = &onendgame;
  player::function_cf3aa03d(&onplayerkilled);
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
  globallogic_spawn::addsupportedspawnpointtype("ffa");
  var_1f99b9e8 = [];

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"hero_annihilator" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_standard_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_standard_t8" + "_oic", "uber");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_fullauto_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_topbreak_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "pistolscope");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "uber");
  level.gunselection = getgametypesetting(#"gunselection");
  level.var_bf82f6b0 = var_1f99b9e8[level.gunselection];
  level.takelivesondeath = 1;
  globallogic_audio::set_leader_gametype_dialog("startOneInTheChamber", "hcStartOneInTheChamber", undefined, undefined, "bbStartOneInTheChamber", "hcbbStartOneInTheChamber");
}

onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(level.gunselection === 7) {
    return idamage;
  }

  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT") {
    idamage = self.maxhealth + 1;
  }

  return idamage;
}

givecustomloadout() {
  loadout::init_player(1);
  loadout::function_f436358b(self.curclass);
  self setactionslot(3, "flourish_callouts");
  self setactionslot(4, "sprays_boasts");
  weapon = level.var_bf82f6b0;
  self giveweapon(weapon);
  self switchtoweapon(weapon);
  clipammo = 1;

  if(isDefined(self.pers[#"clip_ammo"])) {
    clipammo = self.pers[#"clip_ammo"];
    self.pers[#"clip_ammo"] = undefined;
  }

  self setweaponammoclip(weapon, clipammo);
  stockammo = 0;

  if(isDefined(self.pers[#"stock_ammo"])) {
    stockammo = self.pers[#"stock_ammo"];
    self.pers[#"stock_ammo"] = undefined;
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

  if(isbot(self) && !isDefined(level.botweapons[#"hero_annihilator_oic"])) {
    bot_action::register_bulletweapon(#"hero_annihilator_oic");
  }

  return weapon;
}

giveperks() {
  self clearperks();

  foreach(perkname in level.oic_perks) {
    if(!self hasperk(perkname)) {
      self setperk(perkname);
    }
  }
}

onstartgametype() {
  allowed[0] = "oic";
  globallogic_spawn::addspawns();
  level.displayroundendtext = 0;
  level thread watchelimination();
}

onspawnplayer(predictedspawn) {
  if(!level.inprematchperiod) {
    level.usestartspawns = 0;
  }

  spawning::onspawnplayer(predictedspawn);
  clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a);

  if(self.pers[#"lives"] == 1) {
    globallogic_audio::leader_dialog_on_player("oicLastLife");
  }
}

onendgame(var_c1e98979) {
  player = round::function_b5f4c9d8();
  match::set_winner(player);
}

saveoffallplayersammo() {
  wait 1;

  for(playerindex = 0; playerindex < level.players.size; playerindex++) {
    player = level.players[playerindex];

    if(!isDefined(player)) {
      continue;
    }

    if(player.pers[#"lives"] == 0) {
      continue;
    }

    currentweapon = player getcurrentweapon();
    player.pers[#"clip_ammo"] = player getweaponammoclip(currentweapon);
    player.pers[#"stock_ammo"] = player getweaponammostock(currentweapon);
  }
}

isplayereliminated(player) {
  return isDefined(player.pers[#"lives"]) && player.pers[#"lives"] <= 0;
}

getplayersleft() {
  playersremaining = [];

  for(playerindex = 0; playerindex < level.players.size; playerindex++) {
    player = level.players[playerindex];

    if(!isDefined(player)) {
      continue;
    }

    if(!isplayereliminated(player)) {
      playersremaining[playersremaining.size] = player;
    }
  }

  return playersremaining;
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(attacker) && isplayer(attacker) && self != attacker) {
    weapon = level.var_bf82f6b0;
    attackerammo = attacker getammocount(weapon);
    victimammo = self getammocount(weapon);

    if(attackerammo < 3) {
      attacker giveammo(1);
    }

    attacker playlocalsound("mpl_oic_bullet_pickup");

    if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_WEAPON_BUTT") {
      attacker globallogic_score::givepointstowin(level.pointspermeleekill);

      if(attackerammo > 0) {
        scoreevents::processscoreevent(#"knife_with_ammo_oic", attacker, self, sweapon);
      }

      if(victimammo > attackerammo) {
        scoreevents::processscoreevent(#"kill_enemy_with_more_ammo_oic", attacker, self, sweapon);
      }
    } else {
      attacker globallogic_score::givepointstowin(level.pointsperweaponkill);

      if(victimammo > attackerammo + 1) {
        scoreevents::processscoreevent(#"kill_enemy_with_more_ammo_oic", attacker, self, sweapon);
      }
    }

    if(self.pers[#"lives"] == 0) {
      scoreevents::processscoreevent(#"eliminated_enemy", attacker, self, sweapon);
    }
  }
}

giveammo(amount) {
  currentweapon = self getcurrentweapon();
  clipammo = self getweaponammoclip(currentweapon);
  self setweaponammoclip(currentweapon, clipammo + amount);
}

shouldreceivesurvivorbonus() {
  if(isalive(self)) {
    return true;
  }

  if(self.hasspawned && self.pers[#"lives"] > 0) {
    return true;
  }

  return false;
}

watchelimination() {
  level endon(#"game_ended");

  for(;;) {
    level waittill(#"player_eliminated");
    players = level.players;

    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i]) && players[i] shouldreceivesurvivorbonus()) {
        players[i].pers[#"survived"]++;
        players[i].survived = players[i].pers[#"survived"];
        scoreevents::processscoreevent(#"survivor", players[i]);
        players[i] globallogic_score::givepointstowin(level.pointsforsurvivalbonus);
      }
    }

    survivors = getplayersleft();

    if(survivors.size == 2) {
      level thread function_ce7ffccb();
    }
  }
}

private function_ce7ffccb(winner) {
  if(globallogic_utils::gettimeremaining() <= int(level.var_18823aed * 1000)) {
    return;
  }

  if(level.var_18823aed > 0) {
    level.timelimitoverride = 1;
    setgameendtime(gettime() + int(level.var_18823aed * 1000));
    hostmigration::waitlongdurationwithgameendtimeupdate(level.var_18823aed);

    if(game.state != "playing") {
      return;
    }
  }

  thread globallogic::end_round(2);
}
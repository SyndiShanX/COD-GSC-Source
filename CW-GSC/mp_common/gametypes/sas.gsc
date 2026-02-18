/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\sas.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weaponobjects;
#namespace sas;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  level.weapon_sas_primary_weapon = getweapon(#"special_crossbow_t9");
  level.weapon_sas_secondary_weapon = getweapon(#"special_ballisticknife_t9_dw");
  level.weapon_sas_primary_grenade_weapon = getweapon(#"hatchet");
  util::registerscorelimit(0, 5000);
  level.onstartgametype = &onstartgametype;
  level.onplayerdamage = &onplayerdamage;
  level.onendgame = &onendgame;
  callback::on_connect(&onplayerconnect);
  level.pointsperprimarykill = getgametypesetting("pointsPerPrimaryKill") * 10;
  level.pointspersecondarykill = getgametypesetting("pointsPerSecondaryKill") * 10;
  level.pointsperprimarygrenadekill = getgametypesetting("pointsPerPrimaryGrenadeKill") * 10;
  level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill") * 10;
  level.setbacks = getgametypesetting("setbacks");
  level.var_ce802423 = 1;
  player::function_cf3aa03d(&onplayerkilled);

  switch (getgametypesetting("gunSelection")) {
    case 0:
      level.setbackweapon = undefined;
      break;
    case 1:
      level.setbackweapon = level.weapon_sas_primary_grenade_weapon;
      break;
    case 2:
      level.setbackweapon = level.weapon_sas_primary_weapon;
      break;
    case 3:
      level.setbackweapon = level.weapon_sas_secondary_weapon;
      break;
    default:
      assert(1, "<dev string:x38>");
      break;
  }

  gameobjects::register_allowed_gameobject(level.gametype);
  level.givecustomloadout = &givecustomloadout;
  var_f429264b = [];

  if(!isDefined(var_f429264b)) {
    var_f429264b = [];
  } else if(!isarray(var_f429264b)) {
    var_f429264b = array(var_f429264b);
  }

  var_f429264b[var_f429264b.size] = "specialty_sprint";

  if(!isDefined(var_f429264b)) {
    var_f429264b = [];
  } else if(!isarray(var_f429264b)) {
    var_f429264b = array(var_f429264b);
  }

  var_f429264b[var_f429264b.size] = "specialty_slide";

  if(!isDefined(var_f429264b)) {
    var_f429264b = [];
  } else if(!isarray(var_f429264b)) {
    var_f429264b = array(var_f429264b);
  }

  var_f429264b[var_f429264b.size] = "specialty_sprintreload";

  if(!isDefined(var_f429264b)) {
    var_f429264b = [];
  } else if(!isarray(var_f429264b)) {
    var_f429264b = array(var_f429264b);
  }

  var_f429264b[var_f429264b.size] = "specialty_sprintheal";

  if(!isDefined(var_f429264b)) {
    var_f429264b = [];
  } else if(!isarray(var_f429264b)) {
    var_f429264b = array(var_f429264b);
  }

  var_f429264b[var_f429264b.size] = "specialty_showenemyequipment";
  level.var_f429264b = var_f429264b;
  weaponobjects::function_fbc4e45c(level.setbackweapon);
  level.var_911aef07 = 1;
  level.var_5ed53119 = 1;
  level.playthrowhatchet = &function_324bab37;
  spawning::addsupportedspawnpointtype("ffa");
  level thread function_3e09b22();
}

function onplayerconnect() {
  self.var_651874a2 = self stats::get_stat_global(#"score");
}

function function_324bab37(hatchet) {
  hatchet endon(#"death");
  hatchet waittill(#"stationary");
  hatchet clientfield::set("enemyequip", 1);
  hatchet clientfield::set("friendlyequip", 1);
}

function givecustomloadout() {
  defaultweapon = level.weapon_sas_primary_weapon;
  loadout::init_player(1);
  loadout::function_f436358b(self.curclass);
  self cleartalents();
  self giveperks();
  self giveweapon(defaultweapon);
  self.primaryloadoutweapon = defaultweapon;
  secondaryweapon = level.weapon_sas_secondary_weapon;
  self giveweapon(secondaryweapon);
  self setweaponammostock(secondaryweapon, 2);
  self.secondaryloadoutweapon = defaultweapon;
  offhandprimary = level.weapon_sas_primary_grenade_weapon;
  self giveweapon(offhandprimary);
  self setweaponammoclip(offhandprimary, 1);
  self.grenadetypeprimary = offhandprimary;
  self.grenadetypeprimarycount = 1;
  loadout = self loadout::get_loadout_slot("primarygrenade");
  loadout.weapon = offhandprimary;
  loadout.count = 1;
  self ability_util::gadget_reset(offhandprimary, 0, 0, 1, 0);
  self ability_util::gadget_power_full(offhandprimary);
  self.heroweapon = undefined;
  self switchtoweapon(defaultweapon);
  self setspawnweapon(defaultweapon);
  self.killswithsecondary = 0;
  self.killswithprimary = 0;
  self.killswithbothawarded = 0;
  self loadout::function_6573eeeb();
  return defaultweapon;
}

function giveperks() {
  self clearperks();

  foreach(perkname in level.var_f429264b) {
    if(!self hasperk(perkname)) {
      self setperk(perkname);
    }
  }
}

function onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(psoffsettime == level.weapon_sas_primary_weapon && shitloc == "MOD_IMPACT") {
    if(isDefined(vpoint) && isPlayer(vpoint)) {
      if(!isDefined(vpoint.pers[# "sticks"])) {
        vpoint.pers[# "sticks"] = 1;
      } else {
        vpoint.pers[# "sticks"]++;
      }

      vpoint.sticks = vpoint.pers[# "sticks"];
    }
  }

  return vdir;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(shitloc) && isPlayer(shitloc) && shitloc != self) {
    if(weapons::ismeleemod(psoffsettime) || psoffsettime === "MOD_EXECUTION") {
      shitloc globallogic_score::givepointstowin(level.pointspermeleekill);
      scoreevents::processscoreevent(#"hash_6c8030eb05b53d5a", shitloc, self, deathanimduration);
    } else if(deathanimduration == level.weapon_sas_primary_weapon) {
      shitloc.killswithprimary++;

      if(shitloc.killswithbothawarded == 0 && shitloc.killswithsecondary > 0) {
        shitloc.killswithbothawarded = 1;
      }

      shitloc globallogic_score::givepointstowin(level.pointsperprimarykill);
      scoreevents::processscoreevent(#"hash_614b27b37ccee280", shitloc, self, deathanimduration);
    } else if(deathanimduration == level.weapon_sas_primary_grenade_weapon) {
      shitloc globallogic_score::givepointstowin(level.pointsperprimarygrenadekill);
    } else {
      if(deathanimduration == level.weapon_sas_secondary_weapon) {
        shitloc.killswithsecondary++;

        if(shitloc.killswithbothawarded == 0 && shitloc.killswithprimary > 0) {
          shitloc.killswithbothawarded = 1;
        }

        scoreevents::processscoreevent(#"hash_25ec47f9609803a9", shitloc, self, deathanimduration);
      }

      shitloc globallogic_score::givepointstowin(level.pointspersecondarykill);
    }

    if(isDefined(level.setbackweapon) && deathanimduration == level.setbackweapon) {
      self.pers[# "humiliated"]++;
      self.humiliated = self.pers[# "humiliated"];

      if(level.setbacks == 0) {
        self globallogic_score::setpointstowin(0);
        globallogic_score::_setplayerscore(self, 0);
        self stats::set_stat_global(#"score", isDefined(self.var_651874a2) ? self.var_651874a2 : 0);
      } else {
        self globallogic_score::givepointstowin(level.setbacks * -1);
      }

      shitloc playlocalsound("mpl_fracture_sting_moved");
      self globallogic_audio::leader_dialog_on_player("sasHumiliated");
      scoreevents::processscoreevent(#"humiliation_sas", shitloc, self, deathanimduration);
    }

    return;
  }

  self.pers[# "humiliated"]++;
  self.humiliated = self.pers[# "humiliated"];

  if(level.setbacks == 0) {
    self globallogic_score::setpointstowin(0);
  } else {
    self globallogic_score::givepointstowin(level.setbacks * -1);
  }

  self playlocalsound(#"mpl_wager_humiliate");
}

function onendgame(var_c1e98979) {
  player = round::function_b5f4c9d8();
  match::set_winner(player);
}

function function_bbf3128e() {
  self endon(#"death");
}

function setupteam(team) {
  util::setobjectivetext(team, #"objectives_sas");

  if(level.splitscreen) {
    util::setobjectivescoretext(team, #"objectives_sas");
  } else {
    util::setobjectivescoretext(team, #"objectives_sas_score");
  }

  level.spawn_start = spawning::get_spawnpoint_array("mp_dm_spawn_start");
}

function onstartgametype() {
  influencers::create_map_placed_influencers();
}

function function_3e09b22() {
  level endon(#"game_ended", #"match_ending_very_soon", #"hash_15b8b6edc4ed3032");
  waitresult = level waittill(#"match_ending_soon");
  level notify(#"hash_15b8b6edc4ed3032", {
    #var_7090bf53: 1
  });
  level notify(#"hash_28434e94a8844dc5", {
    #n_delay: 52
  });
}
/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\sonar_pulse.gsc
***************************************************/



#using scripts\common\utility;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\damage;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace sonar_pulse;

function function_a09bd8d12b478568() {
  setdvarifuninitialized(@ "hash_46196919c37855a4", 1);
}

function function_12248061aabb5b60() {
  self endon("offhand_pullback");

  while(true) {
    grenade_weap = scripts\cp\weapon::waittill_grenade_fire();

    if(!isDefined(grenade_weap)) {
      continue;
    }

    if(!isDefined(grenade_weap.weapon_name)) {
      continue;
    }

    if(grenade_weap.weapon_name != "sonar_pulse_mp") {
      continue;
    }

    self notify("portable_radar_thrown", grenade_weap);
    return grenade_weap;
  }
}

function function_2d117eeb564f6ea3(grenade) {
  grenade endon("death");
  self endon("disconnect");
  grenade scripts\cp_mp\ent_manager::registerspawn(1, &function_2564841f84f5470c);
  thread scripts\cp\weapon::monitordisownedgrenade(self, grenade);
  grenade setscriptablepartstate("visibility", "show", 1);
  grenade waittill("missile_stuck", stuckto);
  grenade setscriptablepartstate("plant", "active", 0);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.deployingplayer = self;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  scripts\cp\weapon::onequipmentplanted(grenade, "sonar_pulse_mp", &function_2564841f84f5470c);
  level thread scripts\cp\weapon::monitordisownedequipment(self, grenade);
  grenade thread scripts\cp\weapon::monitordamage(75, "hitequip", &function_ce4c686b86693133, &function_87b9594a020ed3fd, 0);
  grenade set_apply_emp_callback(&function_93fd2cdcd109695b);

  if(isDefined(stuckto) && isPlayer(stuckto)) {
    thread scripts\cp\weapon::grenadestuckto(grenade, stuckto);
    grenade thread function_4ae3bcdc7576ebe4(stuckto);
  }

  grenade thread function_60d095cd40221aea();
  grenade thread function_b562d405020e0724();
  grenade function_4b1fcc56668622d1();
}

function function_4ae3bcdc7576ebe4(playerstuckto) {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  playerstuckto waittill("death_or_disconnect");
  self unlink();
}

function function_60d095cd40221aea() {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");

  while(true) {
    self waittill("enable_sonar");
    thread function_6f9be6b35f3dd478();
  }
}

function function_6f9be6b35f3dd478() {
  self endon("death");
  self endon("destroyed");
  self endon("disable_sonar");
  level endon("game_ended");
  wait 0.5;

  while(true) {
    radarradius = 1000;
    var_2ff0b7294cde30f8 = 1;

    if(islargemap()) {
      radarradius = 2500;
    }

    thread function_10ec22d7a74ce832(var_2ff0b7294cde30f8);
    thread function_e6f69ea82cb18d6();

    if(!isDefined(level.var_feb482868c0ee195)) {
      level.var_feb482868c0ee195 = [];
    }

    var_d0de4c8ed7f47a01 = getaiarrayinradius(self.origin, radarradius, "axis");
    var_3ba658fb6ee90fa0 = getentarrayinradius("drone_turret", "targetname", self.origin, radarradius);
    enemies = array_combine(var_d0de4c8ed7f47a01, var_3ba658fb6ee90fa0);
    level.var_feb482868c0ee195 = scripts\cp\utility::array_merge(enemies, level.var_feb482868c0ee195);
    enemycount = enemies.size;
    self.owner scripts\cp\challenges_cp::function_613a81f77b1154d0(enemycount);
    outlineids = [];

    foreach(enemy in enemies) {
      enemy.var_2ec3e2a60db662fb = scripts\cp\cp_outline_utility::outlineenableforall(enemy, "snapshotgrenade", "equipment");
      outlineids[outlineids.size] = enemy.var_2ec3e2a60db662fb;
    }

    if(istrue(level.teambased)) {
      triggerportableradarpingteam(self.origin, "allies", radarradius, int(var_2ff0b7294cde30f8 * 1000));
    } else {
      triggerportableradarping(self.origin, self.owner, radarradius, int(var_2ff0b7294cde30f8 * 1000));
    }

    wait 1;

    if(getdvarint(@ "hash_46196919c37855a4") == 1) {
      for(i = 0; i < enemies.size; i++) {
        scripts\cp\cp_outline_utility::outlinedisable(outlineids[i], enemies[i]);
        enemies[i].var_2ec3e2a60db662fb = undefined;
      }
    }

    wait 1;
  }
}

function function_10ec22d7a74ce832(var_2ff0b7294cde30f8) {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  self setscriptablepartstate("pulse", "active", 0);
  wait min(0.1, var_2ff0b7294cde30f8 - 0.5);
  self setscriptablepartstate("pulse", "neutral", 0);
}

function function_e6f69ea82cb18d6() {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  self setscriptablepartstate("anims", "open", 0);
  wait function_e2ad1107cffcf46();
  self setscriptablepartstate("anims", "close", 0);
}

#using_animtree("scriptables");

function function_e2ad1107cffcf46() {
  return getanimlength(%wm_sonar_pulse_ground_open);
}

function function_b562d405020e0724() {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  wait 30;
  function_2564841f84f5470c();
}

function function_16c572662acaaf67(player) {
  self endon("death");
  self endon("destroyed");
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
  groundentity = traceresults["entity"];

  if(isDefined(groundentity)) {
    if(is_train_ent(groundentity)) {
      self.origin += (0, 0, 1.6);
      self linkTo(groundentity);
    }
  }
}

function function_87b9594a020ed3fd(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  modifieddamage = damage;
  modifieddamage = utility::handlemeleedamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\cp\damage::handleapdamage(objweapon, type, modifieddamage, attacker);
  return modifieddamage;
}

function function_ce4c686b86693133(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
  }

  function_2564841f84f5470c(data);
}

function function_2564841f84f5470c(data) {
  hasattacker = 0;

  if(isDefined(data) && isDefined(data.attacker)) {
    hasattacker = 1;
    function_248b0fbbc5de7e43(data.attacker);
  }

  if(isDefined(self.headiconid)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
    self.headiconid = undefined;
  }

  thread function_9c91a67e3f179afd(hasattacker);
  self setscriptablepartstate("destroy", "active", 0);
  self notify("destroyed");
}

function function_9c91a67e3f179afd(wasdestroyed) {
  self endon("death");

  if(!isDefined(self)) {
    iprintln("<dev string:x1c>");
  }

  if(isDefined(level.var_feb482868c0ee195)) {
    foreach(enemy in level.var_feb482868c0ee195) {
      if(isDefined(enemy.var_2ec3e2a60db662fb)) {
        scripts\cp\cp_outline_utility::outlinedisable(enemy.var_2ec3e2a60db662fb, enemy);
      }
    }

    level.var_feb482868c0ee195 = undefined;
  }

  self.exploding = 1;

  if(isDefined(self.owner)) {
    self.owner scripts\cp_mp\challenges::function_bd59aa7e8cece1ab("super_sonar_pulse", self.usedcount);
  }

  wait 2;
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self)) {
    self delete();
  }
}

function function_248b0fbbc5de7e43(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
  }
}

function function_93fd2cdcd109695b(data) {
  data.victim endon("destroyed");
  data.victim setscriptablepartstate("empd", "active", 0);
  data.victim function_a8d0b1afb1554b5a();
  wait 6;
  data.victim setscriptablepartstate("empd", "neutral", 0);
  data.victim function_4b1fcc56668622d1();
}

function function_4b1fcc56668622d1() {
  self notify("enable_sonar");
}

function function_a8d0b1afb1554b5a() {
  self setscriptablepartstate("pulse", "neutral", 0);
  self notify("disable_sonar");
}
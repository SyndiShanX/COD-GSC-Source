/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\sound_veil.gsc
***********************************************/

#using scripts\anim\combat_utility;
#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace sound_veil;

function function_735ed2b006dce0eb() {
  setdevdvarifuninitialized(@ "hash_7ab7001b47624fdc", 0);
  setdevdvarifuninitialized(@ "hash_aa851e1cd1444734", 0);
}

function function_6d91f8514005d18(grenade) {
  grenade endon("death");
  self endon("disconnect");

  printgameaction("<dev string:x1c>", self);

  if(!isDefined(level.var_4405e76242d7cb8e)) {
    level.var_4405e76242d7cb8e = 0;
  }

  grenade scripts\cp_mp\ent_manager::registerspawn(1, &function_558d562eb33ea61d);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto) && stuckto isvehicle()) {
    grenade.vehicle_stuck = 1;
  }

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = grenade[[level.var_ca4e08767cbdae12]]();

    if(!canplant) {
      scripts\mp\supers::refundsuper();
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      grenade delete();
      return;
    }
  }

  grenade setscriptablepartstate("plant", "active", 0);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade setnonstick(1);
  grenade.issuper = 1;
  grenade.superid = level.superglobals.staticsuperdata["super_sound_veil"].id;
  grenade.usedcount = 0;
  grenade.deployingplayer = self;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  grenade.activetargets = [];
  trigger = spawn("trigger_rotatable_radius", grenade.origin, 0, 80, 300);
  trigger.angles = grenade.angles;
  grenade.trigger = trigger;
  trigger enablelinkTo();
  trigger linkTo(grenade);
  var_307667d0142f2035 = _hasperk("specialty_rugged_eqp");
  onequipmentplanted(grenade, "sound_veil_mp", &function_558d562eb33ea61d);
  level thread monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  maxhealth = ter_op(var_307667d0142f2035, 225, 150);
  grenade thread scripts\mp\damage::monitordamage(maxhealth, "hitequip", &function_f313405d166290be, &function_50b1d2352a6a686a, 0);
  grenade set_apply_emp_callback(&function_b434ea15774ed770);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_3b78125a41e822);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    grenade[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_844431456055a07b);
  }

  grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_391ebdde9e0eec71);
  grenade function_49197cd063a740ea(&function_558d562eb33ea61d);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(grenade);
    }
  }

  grenade function_74844a68121c9b36();
  scripts\cp_mp\challenges::function_d997435895422ecc("super_sound_veil", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
}

function function_7a9d11f284eb6bc3(timeout, var_cd96ae96391c79e6) {
  self endon("destroyed");
  self notify("reset_timeout");
  self endon("reset_timeout");
  level endon("game_ended");
  result = waittill_any_timeout_1(timeout, "death");

  if(istrue(var_cd96ae96391c79e6)) {
    function_a322c0dd80d5eff7();
    return;
  }

  function_558d562eb33ea61d();
}

function function_95a96c443ac9ea46(player) {
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

function function_50b1d2352a6a686a(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  modifieddamage = damage;
  modifieddamage = utility::handlemeleedamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handleapdamage(objweapon, type, modifieddamage, attacker);

  if(!isagent(attacker)) {
    scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, type);
  }

  return modifieddamage;
}

function function_f313405d166290be(data) {
  attacker = data.attacker;

  if(isPlayer(attacker) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread doscoreevent(#"destroyed_equipment");
    attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy(#"bc_fieldupgrade_killfirm_soundveil");
  }

  function_558d562eb33ea61d(data);
}

function function_558d562eb33ea61d(data) {
  if(!isDefined(self)) {
    return;
  }

  hasattacker = 0;

  if(isDefined(data) && isDefined(data.attacker)) {
    hasattacker = 1;
    function_7c9d9f1ca399b82c(data.attacker);
  }

  if(isDefined(self.headiconid)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  }

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
  }

  function_77bbce9593e3b2cc();
  thread function_53b79c2279dc402(hasattacker);
  self setscriptablepartstate("activate", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
  self notify("destroyed");
}

function function_53b79c2279dc402(wasdestroyed) {
  self endon("death");

  if(!isDefined(self)) {
    iprintln("<dev string:x32>");
  }

  self.exploding = 1;

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self.owner scripts\cp_mp\challenges::function_d997435895422ecc("super_sound_veil", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), self.usedcount);
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(wasdestroyed));
    self.owner removeequip(self);
  }

  wait 2;
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self)) {
    self delete();
  }
}

function function_7c9d9f1ca399b82c(attacker) {
  if(isPlayer(attacker) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread doscoreevent(#"destroyed_equipment");
    attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

function function_b434ea15774ed770(data) {
  if(!isDefined(data) || !isDefined(data.victim)) {
    return;
  }

  data.victim endon("death");
  data.victim endon("destroyed");
  data.victim setscriptablepartstate("empd", "active", 0);
  data.victim function_3e3ba6dfdea9465b();
  wait 6;
  data.victim setscriptablepartstate("empd", "neutral", 0);
  data.victim function_74844a68121c9b36();
}

function function_3b78125a41e822(data) {
  if(!isDefined(data) || !isDefined(data.victim)) {
    return;
  }

  data.victim endon("death");
  data.victim endon("destroyed");
  data.victim setscriptablepartstate("empd", "active", 0);
  data.victim function_3e3ba6dfdea9465b();
}

function function_844431456055a07b(data) {
  data.victim setscriptablepartstate("empd", "neutral", 0);
  data.victim function_74844a68121c9b36();
}

function function_391ebdde9e0eec71(data) {
  function_558d562eb33ea61d(data);
}

function function_74844a68121c9b36() {
  self notify("enable_" + "super_sound_veil");
  self setscriptablepartstate("arm", "active", 0);

  if(!istrue(self.var_eec43b28df0bc8d6) && !istrue(self.ignoretimeout)) {
    defaulttimeout = 60;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      defaulttimeout = 480;
    }

    timeoverride = getdvarint(@ "hash_aa851e1cd1444734", 0);

    if(timeoverride > 0) {
      defaulttimeout = timeoverride;
    }

    thread function_7a9d11f284eb6bc3(defaulttimeout);
  }

  if(istrue(self.triggered)) {
    self setscriptablepartstate("activate", "active", 0);
  }

  thread function_caab3d73a9d2b003();
  self.var_eec43b28df0bc8d6 = 1;
}

function function_caab3d73a9d2b003() {
  self endon("death");
  self endon("destroyed");
  self endon("disable_" + "super_sound_veil");
  level endon("game_ended");
  self.triggeredents = [];

  while(true) {
    self.trigger waittill("trigger", triggeredent);
    teamtocheck = triggeredent.team;

    if(!isDefined(teamtocheck) && isagent(triggeredent) && isDefined(triggeredent.agentteam)) {
      teamtocheck = triggeredent.agentteam;
    }

    if(istrue(level.teambased) && isDefined(teamtocheck) && teamtocheck == self.owner.team) {
      continue;
    }

    if(isagent(triggeredent) && !array_contains(self.triggeredents, triggeredent)) {
      if(istrue(self.var_fff21a869f9fa687) && !function_a5a768ec20759f3d(triggeredent)) {
        continue;
      }

      self.triggeredents[self.triggeredents.size] = triggeredent;
      triggeredent scripts\anim\combat_utility::flashbangstart(3);
    }

    if(!istrue(self.triggered)) {
      if(!function_2567c5ffae3aa0cc(triggeredent)) {
        continue;
      }

      self.triggered = 1;
      thread function_7a9d11f284eb6bc3(20, istrue(self.ignoretimeout));

      if(istrue(triggeredent.var_f19a8bf0b538aaf8)) {
        explosivetrigger(triggeredent, 0);
      }

      self setscriptablepartstate("trigger", "active", 0);
      wait 0.35;
      self setscriptablepartstate("activate", "active", 0);
      scripts\mp\shellshock::grenade_earthquakeatposition(self.origin, 0.25);

      if(!isDefined(self.vehicle_stuck) && !isDefined(self.navobstacle)) {
        half_height = 150;
        half_depth = 20;
        up_vec = anglestoup(self.angles);
        var_d5dd171f21b7daca = self.origin + up_vec * half_height - up_vec * half_depth;

        if(getgametype() == "koth_horde") {
          badplace_teams = ["axis", "allies"];
          self.navobstacle = createnavbadplacebyshape(var_d5dd171f21b7daca, self.angles, 8, 90, half_height + 40, badplace_teams);
        } else {
          self.navobstacle = createnavbadplacebyshape(var_d5dd171f21b7daca, self.angles, 8, 90, half_height + 40);
        }
      }

      continue;
    }

    function_ffb333a3a7d50710(triggeredent);
  }
}

function function_2567c5ffae3aa0cc(potentialtarget) {
  if(potentialtarget isvehicle()) {
    if(!isDefined(potentialtarget.streakinfo)) {
      vehicle = potentialtarget;
      vehicleoccupants = vehicle_occupancy_getalloccupants(vehicle);
      var_7f22902f9e860f6a = 0;

      if(isDefined(vehicleoccupants) && vehicleoccupants.size > 0) {
        foreach(occupant in vehicleoccupants) {
          if(!function_bd10b05c42bb5432(occupant, 1)) {
            continue;
          }

          var_7f22902f9e860f6a = 1;
          break;
        }
      }

      if(!istrue(var_7f22902f9e860f6a)) {
        return false;
      }
    } else {
      return false;
    }
  } else if(!function_bd10b05c42bb5432(potentialtarget)) {
    return false;
  }

  return true;
}

function function_bd10b05c42bb5432(potentialtarget, ignoresight, var_e6c0b49674829ef4) {
  if(!function_fb91ac0d17ce422e(potentialtarget, var_e6c0b49674829ef4)) {
    return false;
  }

  if(function_8be3970b7e22cb24(potentialtarget)) {
    return false;
  }

  if(!function_669bd251f952db32(potentialtarget) && !istrue(ignoresight)) {
    return false;
  }

  if(!function_47bba92311467ca4(potentialtarget)) {
    return false;
  }

  return true;
}

function function_8be3970b7e22cb24(potentialtarget) {
  return istrue(potentialtarget.var_baf99ff6e658c413);
}

function function_669bd251f952db32(potentialtarget) {
  if(!isDefined(potentialtarget)) {
    return false;
  }

  return potentialtarget sightconetrace(self.origin, self) > 0;
}

function function_47bba92311467ca4(potentialtarget) {
  if((isPlayer(potentialtarget) || isagent(potentialtarget)) && potentialtarget scripts\cp_mp\utility\player_utility::isinvehicle()) {
    potentialtarget = potentialtarget scripts\cp_mp\utility\player_utility::getvehicle();
  }

  if(!potentialtarget istouching(self.trigger)) {
    return false;
  }

  return true;
}

function function_b6727d48164ba951(potentialtarget, var_e6c0b49674829ef4, var_4a6a11a4f1e2c293) {
  if(!isreallyalive(potentialtarget)) {
    return false;
  }

  if(istrue(level.teambased)) {
    if(potentialtarget.team == self.owner.team) {
      if(potentialtarget == self.owner) {
        if(istrue(var_e6c0b49674829ef4) || istrue(var_4a6a11a4f1e2c293)) {
          return true;
        }
      }
    } else {
      return true;
    }
  } else if(potentialtarget == self.owner) {
    if(istrue(var_e6c0b49674829ef4) || istrue(var_4a6a11a4f1e2c293)) {
      return true;
    }
  } else {
    return true;
  }

  return false;
}

function function_a5a768ec20759f3d(potentialtarget) {
  if(isDefined(potentialtarget.agent_type) && issubstr(potentialtarget.agent_type, "civilian")) {
    return false;
  }

  if(!istrue(potentialtarget.isactive)) {
    return false;
  }

  teamtocheck = potentialtarget.team;

  if(!isDefined(teamtocheck) && isagent(potentialtarget) && isDefined(potentialtarget.agentteam)) {
    teamtocheck = potentialtarget.agentteam;
  }

  if(isDefined(teamtocheck) && potentialtarget.team == self.owner.team) {
    return false;
  }

  return true;
}

function function_fb91ac0d17ce422e(potentialtarget, var_e6c0b49674829ef4) {
  var_4a6a11a4f1e2c293 = 0;

  var_4a6a11a4f1e2c293 = getdvarint(@ "hash_7ab7001b47624fdc", 0);

  if(!isDefined(potentialtarget)) {
    return false;
  }

  if(isPlayer(potentialtarget) && !function_b6727d48164ba951(potentialtarget, var_e6c0b49674829ef4, var_4a6a11a4f1e2c293)) {
    return false;
  }

  if(isagent(potentialtarget) && !function_a5a768ec20759f3d(potentialtarget)) {
    return false;
  }

  return true;
}

function function_ffb333a3a7d50710(enemytarget) {
  shocktargets = [];

  if(enemytarget isvehicle()) {
    if(!isDefined(enemytarget.streakinfo)) {
      vehicleoccupants = vehicle_occupancy_getalloccupants(enemytarget);

      if(isDefined(vehicleoccupants) && vehicleoccupants.size > 0) {
        foreach(occupant in vehicleoccupants) {
          if(function_bd10b05c42bb5432(occupant, 1, 1)) {
            shocktargets[shocktargets.size] = occupant;
          }
        }
      }
    } else {
      return;
    }
  } else if(function_bd10b05c42bb5432(enemytarget, undefined, 1)) {
    shocktargets[shocktargets.size] = enemytarget;
  }

  foreach(target in shocktargets) {
    if(!isDefined(target)) {
      continue;
    }

    function_58224ad5db7ba3ef(target);
    enemytargetid = function_55f4107c03475907(target);
    function_dba08b318eb4224d(target, enemytargetid);
    thread function_20e0e81ccc2160e7(target, enemytargetid);

    if(isPlayer(target) && !isbot(target)) {
      function_99f74e04a216a21c(target, enemytargetid);
    }
  }
}

function function_55f4107c03475907(target) {
  level.var_4405e76242d7cb8e++;
  enemytargetid = 0;

  if(isPlayer(target) && !isbot(target)) {
    enemytargetid = target getxuid();
  } else {
    enemytargetid = target getentitynumber();
  }

  return enemytargetid + "_" + level.var_4405e76242d7cb8e;
}

function function_20e0e81ccc2160e7(enemytarget, enemytargetid) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + enemytargetid);
  self endon("disable_" + "super_sound_veil");
  level endon("game_ended");
  var_4a6a11a4f1e2c293 = 0;

  var_4a6a11a4f1e2c293 = getdvarint(@ "hash_7ab7001b47624fdc", 0);

  if(var_4a6a11a4f1e2c293 == 2) {
    return;
  }

  if(isDefined(enemytarget) && isPlayer(enemytarget) && isPlayer(self.owner) && enemytarget != self.owner) {
    self.owner thread doscoreevent(#"hash_62166c6d2fcb36c3");
  }

  while(isDefined(enemytarget)) {
    shockfile = "sound_veil_mp";

    if(isPlayer(enemytarget)) {
      if(enemytarget _hasperk("specialty_tac_resist") || enemytarget _hasperk("specialty_tac_resist_br")) {
        shockfile = "sound_veil_reduced_mp";
      }
    }

    enemytarget scripts\cp_mp\utility\shellshock_utility::_shellshock(shockfile, "stun", 0.5, 0);

    if(isDefined(self.owner)) {
      enemytarget dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_object, "torso_upper");
    }

    wait 0.5;
  }
}

function function_99f74e04a216a21c(enemytarget, enemytargetid) {
  if(enemytarget scripts\common\utility::isusingremote()) {
    thread function_a996433357117a3f(enemytarget, enemytargetid);
    return;
  }

  thread function_a8b8c5877fc13197(enemytarget, enemytargetid);
}

function function_a996433357117a3f(enemytarget, enemytargetid) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + enemytargetid);
  self endon("disable_" + "super_sound_veil");
  level endon("game_ended");

  while(isDefined(enemytarget) && enemytarget scripts\common\utility::isusingremote()) {
    waitframe();
  }

  thread function_a8b8c5877fc13197(enemytarget, enemytargetid);
}

function function_a8b8c5877fc13197(enemytarget, enemytargetid) {
  level endon("game_ended");
  var_4a6a11a4f1e2c293 = 0;

  var_4a6a11a4f1e2c293 = getdvarint(@ "hash_7ab7001b47624fdc", 0);

  if(var_4a6a11a4f1e2c293 == 2) {
    return;
  }

  shakeoverride = "player_soundveil_shake_mp";
  var_5c46a6026a0b4d43 = 5;

  if(enemytarget _hasperk("specialty_tac_resist")) {
    shakeoverride = "player_soundveil_shake_reduced_mp";
    var_5c46a6026a0b4d43 = 3;
  }

  scripts\cp_mp\utility\player_utility::function_f7348e400b4a608d(enemytarget, shakeoverride, 1);
  enemytarget setclientomnvar("ui_hud_shake", 1);
  enemytarget scripts\cp_mp\emp_debuff::play_emp_scramble(var_5c46a6026a0b4d43);
  level waittill_any_ents(self, "death", self, "destroyed", self, "lost_target_" + enemytargetid, self, "disable_" + "super_sound_veil");

  if(isDefined(enemytarget)) {
    scripts\cp_mp\utility\player_utility::function_56d83cde22535f96(enemytarget);
    enemytarget setclientomnvar("ui_hud_shake", 0);
    enemytarget scripts\cp_mp\emp_debuff::stop_emp_scramble(var_5c46a6026a0b4d43);
  }
}

function function_dba08b318eb4224d(enemytarget, enemytargetid) {
  thread function_de45ed589c44b1b6(enemytarget, enemytargetid);
  thread function_f6ff6461277e08e7(enemytarget, enemytargetid);
  thread function_5fdece59c0ffc021(enemytarget, enemytargetid);
  thread function_9ad53f155f459571(enemytarget, enemytargetid);
}

function function_f6ff6461277e08e7(enemytarget, enemytargetid) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + enemytargetid);
  self endon("disable_" + "super_sound_veil");
  level endon("game_ended");

  if(isPlayer(enemytarget)) {
    enemytarget waittill_any_2("death_or_disconnect", "killed_player");
  } else {
    enemytarget waittill("death");
  }

  self notify("lost_target_" + enemytargetid);
}

function function_5fdece59c0ffc021(enemytarget, enemytargetid) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + enemytargetid);
  self endon("disable_" + "super_sound_veil");
  level endon("game_ended");

  while(isDefined(enemytarget)) {
    if(!isDefined(enemytarget.vehicle)) {
      if(!function_669bd251f952db32(enemytarget)) {
        break;
      }
    }

    if(!function_47bba92311467ca4(enemytarget)) {
      break;
    }

    waitframe();
  }

  self notify("lost_target_" + enemytargetid);
}

function function_9ad53f155f459571(enemytarget, enemytargetid) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + enemytargetid);
  self endon("disable_" + "super_sound_veil");
  level endon("game_ended");
  enemytarget waittill("using_remote");
  self notify("lost_target_" + enemytargetid);
}

function function_de45ed589c44b1b6(enemytarget, enemytargetid) {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  waittill_any_2("lost_target_" + enemytargetid, "disable_" + "super_sound_veil");
  function_61d589d2064b53f2(enemytarget);
}

function function_3e3ba6dfdea9465b() {
  self notify("disable_" + "super_sound_veil");
  self setscriptablepartstate("activate", "neutral", 0);
  self setscriptablepartstate("arm", "neutral", 0);
}

function function_a322c0dd80d5eff7() {
  self setscriptablepartstate("arm", "active", 0);
  self setscriptablepartstate("activate", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
}

function function_58224ad5db7ba3ef(enemytarget) {
  enemytarget.var_baf99ff6e658c413 = 1;
  self.usedcount++;
  self.activetargets[self.activetargets.size] = enemytarget;
}

function function_3c43dcc55621952a(enemytarget) {
  if(isDefined(self) && self.activetargets.size > 0) {
    foreach(target in self.activetargets) {
      if(isDefined(target) && isDefined(enemytarget) && target == enemytarget) {
        return true;
      }
    }
  }

  return false;
}

function function_61d589d2064b53f2(enemytarget) {
  if(isDefined(enemytarget)) {
    enemytarget.var_baf99ff6e658c413 = undefined;
    self.activetargets = array_remove(self.activetargets, enemytarget);
  }
}

function function_77bbce9593e3b2cc() {
  if(isDefined(self.activetargets)) {
    foreach(target in self.activetargets) {
      function_61d589d2064b53f2(target);
    }
  }
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}
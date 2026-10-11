/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\shock_stick.gsc
***************************************************/

#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using script_cbb0697de4c5728;
#using scripts\asm\asm_bb;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\superdeploy;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots_util;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\nvg;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\rescue;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\laststand;
#using scripts\mp\perks\perks;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace shock_stick;

function function_54655641d3957e3(grenade, isgl) {
  setdevdvarifuninitialized(@ "hash_d677956e73b3bfb4", 0.8);

  ref = scripts\cp_mp\equipment::function_7f245729fcb6414d(grenade.weapon_name);
  grenade.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

  if(!isDefined(grenade.tableinfo.bundle)) {
    assertmsg("<dev string:x1c>");
  }

  if(istrue(grenade.tableinfo.bundle.var_b79e08e886b92d46)) {
    if(!isDefined(self.shocksticks)) {
      self.shocksticks = [];
      callback::add("onPlayerSpawn_destroyEquipment", &function_2bcd92a365fef09);
    }

    self.shocksticks[self.shocksticks.size] = grenade;
  }

  function_641996b5e113c5c6(grenade, &function_f7d28ac22f07d9c0);
  grenade thread function_c00fb7cc84f2d066();
  grenade thread function_50a6b61f28ff21c8();
  scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_shockstick", self, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  thread function_374b1abf46319e21(grenade);
}

function function_f7d28ac22f07d9c0(empstruct) {
  victim = empstruct.victim;
  attacker = empstruct.attacker;
  objweapon = empstruct.objweapon;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(victim.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(victim, objweapon);
  }

  self notify("enemy_destroyed_equipment", attacker);
  victim function_c44b639f5005afa(1);
}

function function_c00fb7cc84f2d066() {
  self endon("death");
  self endon("underwater_swap");
  self.owner waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread function_c44b639f5005afa();
}

function function_50a6b61f28ff21c8() {
  self endon("death");
  self endon("underwater_swap");
  self waittill("forceDeath");
  thread function_c44b639f5005afa();
}

function function_c44b639f5005afa(isimmediate) {
  if(istrue(self.exploding)) {
    return;
  }

  time = 0.25;

  if(istrue(isimmediate)) {
    time = 0;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  self.exploding = 1;
  self setscriptablepartstate("destroy", "on", 0);
  thread function_c5852887bdea3efb(time);
}

function function_c5852887bdea3efb(deletiondelay) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  function_83cebe0ae5318a7f(self);

  if(istrue(self.tableinfo.bundle.var_6bf09ccafb1e16d2)) {
    self setscriptablepartstate("electric", "neutral", 0);
    chaindelay = default_to(self.tableinfo.bundle.var_a3395b5076eb8a6c, 1);
    wait chaindelay + 0.5;
    self notify("death");
    wait deletiondelay;

    if(isDefined(self)) {
      if(isDefined(self.badplace)) {
        destroynavobstacle(self.badplace);
      }

      self.var_5bcbcef205cb1486 = undefined;
      self delete();
    }

    return;
  }

  self notify("death");

  if(deletiondelay > 0) {
    wait deletiondelay;
  }

  if(isDefined(self)) {
    if(isDefined(self.badplace)) {
      destroynavobstacle(self.badplace);
    }

    self.var_5bcbcef205cb1486 = undefined;
    self setscriptablepartstate("electric", "neutral", 0);
    self delete();
  }
}

function function_ca6c37e5d8f35c8b(data) {
  if(data.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  data.victim thread function_5d58ea6516bf050c(0.2);
  return true;
}

function function_2bcd92a365fef09(params) {
  if(isDefined(self.shocksticks)) {
    foreach(shockstick in self.shocksticks) {
      if(isDefined(shockstick)) {
        shockstick function_c44b639f5005afa();
      }
    }

    self.shocksticks = [];
  }
}

function function_a5e91eaa60d034d7(grenade) {
  newgrenade = scripts\mp\utility\weapon::_launchgrenade("shock_stick_underwater_mp", grenade.origin, (0, 0, 0), undefined, 1);
  scripts\mp\weapons::grenadeinitialize(newgrenade, makeweapon("shock_stick_underwater_mp"), 0, self);
  ref = scripts\cp_mp\equipment::function_7f245729fcb6414d(grenade.weapon_name);
  newgrenade.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);
  newgrenade.owner = self;
  grenade notify("underwater_swap");
  grenade delete();
  newgrenade setscriptablepartstate("danger-icon", "on", 0);
  newgrenade thread function_ab90d143e732b403();
  return newgrenade;
}

function function_374b1abf46319e21(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  grenade endon("death");
  bundle = grenade.tableinfo.bundle;
  stuckdata = grenade scripts\mp\equipment::function_f69ed22535d90b78();

  if(!isDefined(stuckdata)) {
    return;
  }

  stucktoplayer = 0;

  if(isDefined(stuckdata.stuckto)) {
    stuckto = stuckdata.stuckto;

    if(isDefined(stuckdata.stuckto.weapon_name) && istrue(stuckdata.stuckto.weapon_name == "deployed_decoy_mp") && istrue(stuckdata.stuckto.var_3fe87ed1237724cc)) {
      grenade thread scripts\mp\equipment\shock_stick::function_c44b639f5005afa(1);
      return;
    }

    if(isPlayer(stuckto) || isagent(stuckto)) {
      if(challengesenabledforplayer()) {
        scripts\cp_mp\challenges::function_8359cadd253f9604(self, "shock_stick_stuck", 1);
      }

      grenade thread scripts\mp\weapons::grenadestuckto(grenade, stuckdata.stuckto);
      stucktoplayer = 1;
    } else {
      grenade thread scripts\mp\equipment::function_4af015619e2534ba(stuckto, &function_c44b639f5005afa, 1);
    }

    grenade.stuckto = stuckto;
  }

  if(!stucktoplayer) {
    grenade thread function_ab90d143e732b403();
    fusetime = default_to(bundle.var_359bfa5663381124, 0.35);
    fusetime = getdvarfloat(@ "hash_b3e986ad3c157f80", fusetime);
    grenade setscriptablepartstate("electric", "fuse", 0);
    wait fusetime;
  }

  thread function_c205d3a32bf04340(grenade, stuckdata);
}

function private function_c205d3a32bf04340(grenade, stuckdata) {
  self endon("disconnect");
  level endon("game_ended");
  bundle = grenade.tableinfo.bundle;
  var_5fbadc0f9063d647 = istrue(bundle.var_b79e08e886b92d46);

  if(istrue(grenade.exploding)) {
    return;
  }

  if(isDefined(stuckdata.isunderwater)) {
    if(var_5fbadc0f9063d647) {
      grenade function_c44b639f5005afa();
    } else {
      grenade = function_a5e91eaa60d034d7(grenade);
    }
  }

  grenade endon("death");

  if(var_5fbadc0f9063d647) {
    if(!isDefined(stuckdata.isunderwater)) {
      grenade function_4d13735859a44508(stuckdata);
    }

    return;
  }

  grenade setscriptablepartstate("electric", "active", 0);
  grenade setscriptablepartstate("detonate", "detonate", 0);
  grenade thread function_f47ab824a48fe570();
}

function private function_ab90d143e732b403() {
  maxhp = default_to(self.tableinfo.bundle.var_890704710e61ebcc, 100);
  thread scripts\mp\damage::monitordamage(maxhp, "hitequip", &function_8e8a3b7d66fdc1b1, undefined);
}

function private function_8e8a3b7d66fdc1b1(data) {
  self notify("enemy_destroyed_equipment", data.attacker);
  function_4714b4df7581ef29(data.attacker);
  function_c44b639f5005afa();
}

function function_4714b4df7581ef29(attacker) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::doscoreevent(#"destroyed_equipment");
    attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

function shockstick_canbehaywire(shockstick, ignoresight) {
  if(self == shockstick) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(isPlayer(self)) {
    return function_d3690389f7d8334c(shockstick, ignoresight);
  } else if(istrue(self.exploding)) {
    return 0;
  } else if(istrue(self.var_98e373d243c1936f)) {
    return 0;
  } else {
    return function_407cdd75e41a385d(shockstick);
  }

  return 1;
}

function function_407cdd75e41a385d(shockstick) {
  if(!isDefined(self.classname)) {
    return false;
  }

  if(!isDefined(self.owner) && !isagent(self) && self.classname != "misc_turret" && self.classname != "script_vehicle") {
    return false;
  }

  if(shockstick == self) {
    return false;
  }

  bundle = shockstick.tableinfo.bundle;

  if(!istrue(bundle.var_5dd66ebda239d1b)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(self.team) && shockstick.team == self.team) {
      if(isagent(self) || isDefined(self.owner) && self.owner != shockstick.owner) {
        return false;
      }
    }
  }

  if(isDefined(self.weapon_name)) {
    weapontype = scripts\mp\utility\weapon::getweapontype(self.weapon_name);

    if(isDefined(weapontype)) {
      if(weapontype != "lethal" && weapontype != "tactical" && weapontype != "super" && !scripts\cp_mp\killstreaks\cluster_spike::function_60dface26506153e(self.weapon_name) && weapontype == "killstreak" && !isDefined(self.var_aa6fe6af4cbbdd47)) {
        return false;
      }
    }
  }

  return true;
}

function function_d3690389f7d8334c(shockstick, ignoresight) {
  print("<dev string:x3b>");

  bundle = shockstick.tableinfo.bundle;

  if(scripts\mp\utility\killstreak::isjuggernaut() && !scripts\mp\utility\game::isjuggermoshgamemode()) {
    return false;
  }

  if(istrue(bundle.var_b79e08e886b92d46) && (function_b80ed39805876e5c(shockstick) || self == shockstick.owner)) {
    return false;
  }

  if(level.teambased) {
    if(!isDefined(self.team)) {
      return true;
    }

    if(shockstick.team == self.team && self != shockstick.owner) {
      return false;
    }
  }

  if(isusingremote() || istrue(self.isusingcamera)) {
    return false;
  }

  isalive = scripts\cp_mp\utility\player_utility::_isalive();
  haywireduration = shockstick function_91a16c9b36fa1b5c(self);
  maxhaywireduration = default_to(5, bundle.var_95602b4d7262c11f);

  if(!isalive || haywireduration >= maxhaywireduration) {
    return false;
  }

  if(!istrue(ignoresight)) {
    if(self sightconetrace(shockstick.origin, shockstick) <= 0) {
      return false;
    }
  }

  return istrue(function_5e15cf3721cdcaab(shockstick));
}

function function_f793c14e21581402(shockstick, chainorigin) {
  bundle = shockstick.tableinfo.bundle;

  if(istrue(bundle.var_b79e08e886b92d46) && (function_b80ed39805876e5c(shockstick) || self == shockstick.owner)) {
    return false;
  }

  isalive = scripts\cp_mp\utility\player_utility::_isalive();
  haywireduration = shockstick function_91a16c9b36fa1b5c(self);
  maxhaywireduration = default_to(5, bundle.var_95602b4d7262c11f);

  if(!isalive || haywireduration >= maxhaywireduration) {
    return false;
  }

  if(self sightconetrace(chainorigin.origin, chainorigin) <= 0) {
    return false;
  }

  return istrue(function_5e15cf3721cdcaab(shockstick));
}

function function_91a16c9b36fa1b5c(target) {
  if(!isDefined(self.var_5bcbcef205cb1486)) {
    return 0;
  }

  duration = self.var_5bcbcef205cb1486[target getentitynumber()];

  if(!isDefined(duration)) {
    return 0;
  }

  return duration;
}

function function_b80ed39805876e5c(shockstick) {
  if(!isDefined(self.var_cb886ff3371f4df8)) {
    return false;
  }

  bundle = shockstick.tableinfo.bundle;
  var_c3fa36eb9aa40509 = default_to(bundle.var_33bce1558051ceb5, 0.3);
  var_c3fa36eb9aa40509 *= 1000;
  return gettime() - self.var_cb886ff3371f4df8 <= var_c3fa36eb9aa40509;
}

function function_f47ab824a48fe570() {
  self endon("death");
  self.owner endon("disconnect");
  var_ce431d3bba9e09e6 = 0;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_ce431d3bba9e09e6 = getdvarint(@ "hash_25b486e84d3b2909", 0);
  }

  bundle = self.tableinfo.bundle;
  ticks = 0;
  objweapon = makeweapon(bundle.useweapon);
  contents = ["physicscontents_item", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  totalduration = default_to(bundle.var_48d181037894a0fe, 5);
  totalduration = getdvarfloat(@ "hash_2c69cb8cd7d267cd", totalduration);
  tickrate = default_to(bundle.var_aba76142349af9c0, 0.2);
  tickrate = getdvarfloat(@ "hash_b2f16983a17dc833", tickrate);
  tickcount = totalduration / tickrate;
  detonationradius = default_to(bundle.var_f196cc01f2b12053, 125);
  electrocutedamage = default_to(bundle.var_4d5d534ef8820d0a, 6);
  var_46d6554bcb2371a1 = istrue(bundle.var_6bf09ccafb1e16d2);

  if(var_46d6554bcb2371a1) {
    self.var_dac6c64c0c59d452 = [];
  }

  self.badplace = function_9c95c914395a9d4a(self.origin, detonationradius);
  function_daf6c5596bb31dff("decoy_grenade", self.owner, self.origin, 512);
  thread function_1ff93e5069cbb8e2(self.origin, detonationradius, detonationradius);

  while(ticks < tickcount) {
    ents = scripts\mp\utility\entity::getentitiesinradius(self.origin, detonationradius, undefined, undefined, physics_createcontents(contents));

    print("<dev string:x60>" + ents.size);

    foreach(ent in ents) {
      if(!isDefined(ent)) {
        print("<dev string:x7c>" + ent getentitynumber() + "<dev string:x88>");

        continue;
      }

      if(ent == self) {
        print("<dev string:x7c>" + ent getentitynumber() + "<dev string:x99>");

        continue;
      }

      if(var_ce431d3bba9e09e6) {
        if(isDefined(ent.domflag) && isDefined(ent.domflag.trigger) && isDefined(ent.domflag.trigger.var_3545410459b16762)) {
          if(isDefined(ent.domflag.trigger.stronghold) && isDefined(ent.domflag.trigger.stronghold.capturedteam) && istrue(ent.domflag.trigger.stronghold.capturedteam == self.owner.team)) {
            continue;
          }

          applied = function_488eafef5447330e(ent.domflag.trigger);

          if(!applied) {
            continue;
          }
        }

        if(istrue(level.var_3976c9c03dc06d9b)) {
          if(istrue(ent.var_47d27267be4655fb) && isDefined(ent.var_3545410459b16762)) {
            applied = function_488eafef5447330e(ent);

            if(!applied) {
              continue;
            }
          }
        }

        if(istrue(level.deployablekiosks.var_8bf814f9559f53)) {
          if(isDefined(ent.type) && ent.type == "portable_buy_drone" && isDefined(ent.var_3545410459b16762)) {
            if(isDefined(ent.team) && ent.team == self.owner.team) {
              continue;
            }

            applied = function_488eafef5447330e(ent);

            if(!applied) {
              continue;
            }
          }
        }

        if(istrue(level.deployablekiosks.var_aaa31c1e28a5663c)) {
          if(isDefined(ent.type) && ent.type == "deployable_buystation" && isDefined(ent.var_3545410459b16762)) {
            if(isDefined(ent.team) && ent.team == self.owner.team) {
              continue;
            }

            applied = function_488eafef5447330e(ent);

            if(!applied) {
              continue;
            }
          }
        }
      }

      if(!ent shockstick_canbehaywire(self)) {
        print("<dev string:x7c>" + ent getentitynumber() + "<dev string:xaf>");

        continue;
      }

      print("<dev string:x7c>" + ent getentitynumber() + "<dev string:xc0>");

      if(isagent(ent) || isPlayer(ent)) {
        isswimming = ent isswimming();

        if(isswimming) {
          ent dodamage(electrocutedamage, self.origin, self.owner, self, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper");
        }

        if(ent scripts\mp\utility\perk::_hasperk("specialty_shock_immunity")) {
          continue;
        }

        if(!isswimming) {
          if(ent != self.owner) {
            if(ent scripts\mp\utility\perk::_hasperk("specialty_tac_resist") || ent scripts\mp\utility\perk::_hasperk("specialty_tac_resist_br")) {
              if(getdvarint(@ "hash_2909726ff0e12a7d", 0) == 1 && isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_e76a5e57e1ff6b9b)) {
                self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, 2, 1);
              } else {
                self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
              }
            } else if(getdvarint(@ "hash_2909726ff0e12a7d", 0) == 1 && isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_e76a5e57e1ff6b9b)) {
              self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("", undefined, undefined, 2);
            } else {
              self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("");
            }
          }
        }

        if(ent != self.owner) {
          self.owner scripts\mp\utility\stats::incpersstat("shockStickHits", 1);
        }
      }

      if(var_46d6554bcb2371a1) {
        self.var_dac6c64c0c59d452[self.var_dac6c64c0c59d452.size] = ent;
      }

      print("<dev string:x7c>" + ent getentitynumber() + "<dev string:xd3>");

      thread shockstick_applyhaywire(ent, objweapon, var_46d6554bcb2371a1);
      function_bba576fc720ed9c5(ent);
    }

    if(var_ce431d3bba9e09e6) {
      scriptables = getentitylessscriptablearray(undefined, undefined, self.origin, detonationradius);

      foreach(scriptable in scriptables) {
        if(!istrue(level.var_3976c9c03dc06d9b) && istrue(scriptable.var_47d27267be4655fb)) {
          continue;
        }

        if(isDefined(scriptable.var_3545410459b16762)) {
          if(isDefined(scriptable.activeteam) && scriptable.activeteam == self.owner.team) {
            continue;
          }

          applied = function_488eafef5447330e(scriptable);

          if(!applied) {}
        }
      }
    }

    ticks++;
    wait tickrate;
  }

  function_c44b639f5005afa();
}

function function_488eafef5447330e(ent) {
  if(!isDefined(ent.var_14f5316be5cf1613)) {
    ent.var_14f5316be5cf1613 = self;
  } else if(ent.var_14f5316be5cf1613 == self) {
    return false;
  } else {
    ent.var_14f5316be5cf1613 = self;
  }

  data = spawnStruct();
  data.time = 5;
  data.attacker = self.owner;
  data.reason = "SHOCK_STICK";
  ent thread[[ent.var_3545410459b16762]](data);
  return true;
}

function function_1ff93e5069cbb8e2(location, radius, height) {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(location, radius, height, self.owner.team, undefined, self.owner, 1, self, 1);
}

function function_bba576fc720ed9c5(ent) {
  entisvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();

  if(!istrue(entisvehicle)) {
    if(ent != self.owner) {
      if(level.teambased) {
        if(isDefined(ent.team) && isDefined(self.team)) {
          if(ent.team != self.team) {
            self.owner namespace_a850435086c88de3::doonactionscoreevent(0, "shockStickHit");
          }
        }
      } else {
        self.owner namespace_a850435086c88de3::doonactionscoreevent(0, "shockStickHit");
      }
    }

    return;
  }

  if(scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(ent, self.owner)) {
    self.owner namespace_a850435086c88de3::doonactionscoreevent(0, "shockStickHit");
  }
}

function function_afa7236ce2426c99(victim) {
  self endon("death");
  self.owner endon("disconnect");
  chaindelay = default_to(self.tableinfo.bundle.var_a3395b5076eb8a6c, 1);
  wait chaindelay;
  bundle = self.tableinfo.bundle;
  objweapon = makeweapon("shock_stick_mp");
  contents = ["physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  electrocutedamage = default_to(bundle.var_4d5d534ef8820d0a, 6);
  var_804ec4ef50698a33 = default_to(bundle.var_606c50913543c2f6, 3);
  var_b22bec491ee6513d = default_to(bundle.var_c0ee4e9b4b96de5a, 125);
  ents = scripts\mp\utility\entity::getentitiesinradius(victim.origin, var_b22bec491ee6513d, undefined, undefined, physics_createcontents(contents));
  targets = [];
  victimorigin = victim.origin;
  firsttimecheck = 1;
  maxdistance = -1;
  maxdistanceindex = 0;

  foreach(ent in ents) {
    if(!isDefined(ent)) {
      continue;
    }

    if(ent == victim) {
      continue;
    }

    if(isagent(ent) || isPlayer(ent)) {
      if(!ent function_f793c14e21581402(self, victim)) {
        continue;
      }

      if(level.teambased) {
        if(self.team == ent.team) {
          continue;
        }
      }

      if(array_contains(self.var_dac6c64c0c59d452, ent)) {
        continue;
      }

      if(ent isswimming()) {
        ent dodamage(electrocutedamage, self.origin, self.owner, self, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper");
      } else if(ent != self.owner) {
        self.owner scripts\cp_mp\damagefeedback::updatedamagefeedback("");
      }

      if(targets.size < var_804ec4ef50698a33) {
        targetstruct = spawnStruct();
        targetstruct.ent = ent;
        targets[targets.size] = targetstruct;
        continue;
      }

      if(firsttimecheck) {
        firsttimecheck = 0;

        for(i = 0; i < targets.size; i++) {
          targets[i].dist = distancesquared(victimorigin, targets[i].ent.origin);

          if(targets[i].dist > maxdistance) {
            maxdistance = targets[i].dist;
            maxdistanceindex = i;
          }
        }
      }

      targetdist = distancesquared(victimorigin, ent.origin);

      if(targetdist < maxdistance) {
        targets[maxdistanceindex].ent = ent;
        targets[maxdistanceindex].dist = targetdist;
        maxdistance = -1;
        maxdistanceindex = -1;

        for(i = 0; i < targets.size; i++) {
          if(targets[i].dist > maxdistance) {
            maxdistance = targets[i].dist;
            maxdistanceindex = i;
          }
        }
      }
    }
  }

  foreach(target in targets) {
    thread shockstick_applyhaywire(target.ent, objweapon, 0);
  }
}

function function_4d13735859a44508(stuckdata) {
  self endon("death");
  self setscriptablepartstate("beacon", "active", 0);
  contents = ["physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  var_775635eb25c3c213 = 0;
  bundle = self.tableinfo.bundle;
  triggerradius = default_to(bundle.var_4262c0e42874114f, 125);

  while(!var_775635eb25c3c213) {
    if(!isDefined(self.owner)) {
      function_c44b639f5005afa();
    }

    ents = scripts\mp\utility\entity::getentitiesinradius(self.origin, triggerradius, undefined, undefined, physics_createcontents(contents));

    foreach(ent in ents) {
      if(!isDefined(ent)) {
        continue;
      }

      if(ent == self) {
        continue;
      }

      if(!ent shockstick_canbehaywire(self)) {
        continue;
      }

      if(isagent(ent) || isPlayer(ent)) {
        var_775635eb25c3c213 = 1;
      }
    }

    if(!var_775635eb25c3c213) {
      wait 0.1;
    }
  }

  self setscriptablepartstate("electric", "active", 0);
  self setscriptablepartstate("detonate", "detonate", 0);
  thread function_f47ab824a48fe570();
}

function function_9b3d2da91a6665(victim) {
  victim endon("haywire_cleared");
  self endon("death");

  if(!isDefined(self.var_5bcbcef205cb1486)) {
    self.var_5bcbcef205cb1486 = [];
  }

  if(!isDefined(self.var_5bcbcef205cb1486[victim getentitynumber()])) {
    self.var_5bcbcef205cb1486[victim getentitynumber()] = 0;
  }

  bundle = self.tableinfo.bundle;
  maxduration = default_to(bundle.var_95602b4d7262c11f, 5);

  while(true) {
    self.var_5bcbcef205cb1486[victim getentitynumber()] += 0.05;

    if(self.var_5bcbcef205cb1486[victim getentitynumber()] >= maxduration) {
      victim notify("haywire_max_duration");
      break;
    }

    wait 0.05;
  }
}

function shockstick_applyhaywire(victim, objweapon, chain) {
  level endon("game_ended");
  victim endon("disconnect");
  victim notify("shockStick_haywireApplied");
  victim endon("shockStick_haywireApplied");
  assertex(isDefined(victim), "<dev string:xe7>");
  assertex(isDefined(objweapon), "<dev string:x11c>");

  if(isPlayer(victim)) {
    victim thread namespace_46e942396566f2da::function_943511ab1f39db66();
  }

  data = packdamagedata(self.owner, victim, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
  function_b3a0629a55a36978();

  if(chain) {
    childthread function_afa7236ce2426c99(victim);
  }

  if(isPlayer(victim) || isagent(victim)) {
    childthread function_9b3d2da91a6665(victim);
  }

  function_ea2863c73339ae9e(data);
  function_fb327fd48c0e34e0(data);
  fromdeath = 0;

  if(isPlayer(data.victim) || isagent(data.victim)) {
    fromdeath = !scripts\mp\utility\player::isreallyalive(data.victim);
  }

  function_46b866d198a76ddc(data, fromdeath);
}

function function_b3a0629a55a36978() {
  self.var_a23f35f8460d8857 = undefined;
}

function function_ea2863c73339ae9e(data) {
  assertex(isDefined(data), "<dev string:x15b>");
  assertex(isDefined(data.attacker), "<dev string:x193>");
  assertex(isDefined(data.victim), "<dev string:x1d6>");
  assertex(isDefined(data.objweapon), "<dev string:x217>");
  assertex(isweapon(data.objweapon), "<dev string:x25b>");
  assertex(isDefined(data.inflictor), "<dev string:x2a5>");

  if(!isDefined(data.damage)) {
    data.damage = 1;
  }

  if(!isDefined(data.meansofdeath)) {
    data.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!isDefined(data.point)) {
    data.point = (0, 0, 0);
  }

  if(!isDefined(data.direction_vec)) {
    data.direction_vec = (0, 0, 0);
  }

  if(!isDefined(data.modelname)) {
    data.modelname = 0;
  }

  if(!isDefined(data.partname)) {
    data.partname = "";
  }

  if(!isDefined(data.tagname)) {
    data.tagname = 0;
  }

  if(!isDefined(data.damageflags)) {
    data.damageflags = 0;
  }

  if(!isDefined(data.hitloc)) {
    data.hitloc = "none";
  }

  if(!isDefined(data.timeoffset)) {
    data.timeoffset = 0;
  }

  if(isagent(data.victim)) {
    thread shockstick_haywireagent(data);
    return;
  }

  if(isPlayer(data.victim)) {
    thread function_c927fd013fc6e502(data);
    return;
  }

  if(scripts\mp\utility\entity::isturret(data.victim) && !isDefined(data.victim.var_aa6fe6af4cbbdd47)) {
    thread function_805969ca0925b2bd(data);
    return;
  }

  thread function_5dd66ebda239d1b(data);
}

function function_805969ca0925b2bd(data) {
  level endon("game_ended");
  data.victim endon("death");
  data.victim endon("haywire_cleared");

  if(istrue(data.victim.ishaywire)) {
    return;
  }

  data.victim.ishaywire = 1;
  turretweapon = data.victim.objweapon;

  if(!isDefined(turretweapon)) {
    return;
  }

  turretuser = data.victim.owner;

  if(!isDefined(turretuser)) {
    return;
  }

  turretuser startforcedfire();
}

function function_fb327fd48c0e34e0(data) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  data.victim childthread function_48f07ea78daa5b21();
  bundle = self.tableinfo.bundle;
  haywireduration = default_to(bundle.var_7c742af3d434b807, 0.25);
  haywireduration = getdvarfloat(@ "hash_e66e541920ac9101", haywireduration);
  data.victim waittill_any_timeout_5(haywireduration, "haywire_cleared", "haywire_max_duration", "shockstick_interrupt", "killed_player", "last_stand_start");
}

function function_48f07ea78daa5b21() {
  self endon("haywire_cleared");
  self endon("haywire_max_duration");

  while(true) {
    if(isPlayer(self)) {
      if(self isinexecutionvictim()) {
        self notify("shockstick_interrupt");
        break;
      }
    }

    waitframe();
  }
}

function function_a9a57668997e3c85(ishaywire, islauncher) {
  if(ishaywire) {
    val::set("haywire_controls", "sprint", 0);
    val::set("haywire_controls", "supersprint", 0);
    val::set("haywire_controls", "ads", 0);
    val::set("haywire_controls", "weapon_switch", 0);
    val::set("haywire_controls", "weapon_pickup", 0);
    val::set("haywire_controls", "ascender_use", 0);
    val::set("haywire_controls", "autoreload", 0);
    val::set("haywire_controls", "reload", 0);
    val::set("haywire_controls", "mantle", 0);
    val::set("haywire_controls", "weapon_switch_clip", 0);
    val::set("haywire_controls", "melee", 0);
    val::set("haywire_controls", "offhand_throwback", 0);
    val::set("haywire_controls", "offhand_weapons", 0);
    val::set("haywire_controls", "supers", 0);
    val::set("haywire_controls", "usability", 0);
    val::set("haywire_controls", "interactions", 0);
    val::set("haywire_controls", "ladder", 0);
    val::set("haywire_controls", "execution_attack", 0);

    if(scripts\mp\equipment\nvg::function_258c5e445c8b7f80()) {
      val::set("haywire_controls", "nvg", 0);
    }

    scripts\mp\utility\player::codcastersetplayerstatuseffect("shock", -1);

    if(istrue(islauncher)) {
      val::set("haywire_controls", "fire", 0);
    }

    return;
  }

  val::reset_all("haywire_controls");
  scripts\mp\utility\player::codcastersetplayerstatuseffect("shock", 0);
}

function function_c927fd013fc6e502(haywiredata, bundle) {
  victim = haywiredata.victim;
  objweapon = haywiredata.objweapon;

  print("<dev string:x2e9>");

  level endon("game_ended");

  if(istrue(victim.ishaywire) || victim isusingremote() || !isreallyalive(victim)) {
    return;
  }

  victim.ishaywire = 1;

  if(scripts\mp\utility\game::getgametype() == "rescue") {
    if(isDefined(victim.carryobject)) {
      hostage = victim.carryobject;
      hostage scripts\mp\gameobjects::setdropped(0);
      hostage scripts\mp\gametypes\rescue::function_4988b37643f2672f(victim);

      if(isnullweapon(victim getcurrentweapon())) {
        foreach(weap in victim.primaryweapons) {
          if(!isnullweapon(weap)) {
            victim scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weap, 1);
            break;
          }
        }
      }
    }
  } else if(isDefined(victim.carryobject)) {
    victim notify("force_manual_drop");
  }

  if(victim ishanging()) {
    victim clearhanging();
  }

  if(isDefined(haywiredata.victim.var_aa6fe6af4cbbdd47)) {
    haywiredata.victim thread[[haywiredata.victim.var_aa6fe6af4cbbdd47]](haywiredata);
  }

  curweapon = victim getcurrentweapon();
  gestureref = "vm_ges_shockstick_react";

  if(curweapon.basename == "iw9_me_fists_mp") {
    gestureref = "vm_ges_shockstick_react_fists";
  }

  islauncher = isDefined(curweapon) && weaponclass(curweapon.basename) == "rocketlauncher";
  victim function_a9a57668997e3c85(1, islauncher);
  victim function_7e66e7ae96dd938(1);

  if(istrue(scripts\cp_mp\utility\player_utility::function_b7869f6d9d4242e3(victim))) {
    victim.var_4a2f2f50a9020e2e = 1;
  }

  if(!isDefined(bundle)) {
    bundle = self.tableinfo.bundle;
  }

  if(isDefined(bundle.gestureref)) {
    gestureref = bundle.gestureref;
  }

  if(isDefined(bundle.var_1d572199f88fb41b)) {
    [[bundle.var_1d572199f88fb41b]]();
  } else {
    victim function_4ce69562a1b41fc7(objweapon);
  }

  victim childthread function_efe1093111eaf7c2(bundle);
  victim childthread function_6cda7b0c3d3f6f3c(curweapon, gestureref, self);

  if(!istrue(victim.var_108e6be5e24e9d1d)) {
    victim childthread function_627c93c58129d8f4(bundle);
  }

  victim childthread function_e57c787da33655d9(bundle);
  victim childthread function_a386b883464f4891(bundle, islauncher);

  if(!istrue(bundle.var_e926abd3e5970492) && issubstr(objweapon.basename, "shock_stick")) {
    scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_shockstick", self.owner, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
  }

  victim notify("player_isHaywire");
}

function function_efe1093111eaf7c2(bundle) {
  self endon("death_or_disconnect");
  movespeedscale = getdvarfloat(@ "hash_d677956e73b3bfb4", 0.8);
  movespeedscale = default_to(bundle.var_77ae83eedd8cab0c, movespeedscale);

  if(!scripts\mp\utility\perk::_hasperk("specialty_tac_resist") && !scripts\mp\utility\perk::_hasperk("specialty_shock_resist")) {
    self setmovespeedscale(movespeedscale);

    while(!self isswimming() && istrue(self.ishaywire)) {
      wait 0.1;
    }

    scripts\mp\weapons::updatemovespeedscale();
    return;
  }

  scripts\mp\perks\perks::activateperk("specialty_tac_resist");
}

function function_6cda7b0c3d3f6f3c(curweapon, gestureref, grenade) {
  level endon("game_ended");
  grenade endon("death");
  self endon("death_or_disconnect");

  while(self function_55965d2ca2ada688()) {
    waitframe();
  }

  if(!scripts\mp\utility\weapon::isakimbo(curweapon) && curweapon.basename != "iw9_me_sword01_mp") {
    while(!self isgestureplaying(gestureref)) {
      self forceplaygestureviewmodel(gestureref);
      waitframe();
    }
  }

  if(!istrue(self.ishaywire) && !scripts\mp\utility\weapon::isakimbo(curweapon)) {
    self stopgestureviewmodel(gestureref, 0.7);
  }
}

function function_a386b883464f4891(bundle, islauncher) {
  if(istrue(bundle.var_d5798377c05f4edf) && !islauncher) {
    self startforcedfire();
  }
}

function function_627c93c58129d8f4(bundle) {
  if(istrue(bundle.var_b79e08e886b92d46)) {
    self setempjammed(1);
    self.var_cb886ff3371f4df8 = gettime();
  }

  self waittill("haywire_cleared");

  if(istrue(bundle.var_b79e08e886b92d46)) {
    self setempjammed(0);
  }
}

function function_e57c787da33655d9(bundle) {
  if(istrue(bundle.var_7c149d627799674)) {
    function_600c7c4c73c6a773(1);
  }

  self waittill("haywire_cleared");

  if(istrue(bundle.var_7c149d627799674)) {
    function_600c7c4c73c6a773(0);
  }
}

function function_cf082013d5205e0d(weapon) {
  weaponname = weapon.basename;

  if(function_aa6acff8443c394b(weaponname)) {
    return 1;
  }

  if(istrue(scripts\cp_mp\weapon::issuperuseweapon(weapon))) {
    return 0;
  }

  if(scripts\cp_mp\weapon::function_5419ac7173288fc1(weapon)) {
    return 1;
  }

  if(scripts\cp_mp\weapon::isdeploytablet(weapon)) {
    return 1;
  }

  if(scripts\cp_mp\weapon::iskillstreakweapon(weapon) || scripts\mp\utility\weapon::issuperweapon(weapon)) {
    return 1;
  }

  if(scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(weaponname) || scripts\cp_mp\superdeploy::function_b04cbd5db8951229(weaponname)) {
    return 1;
  }

  if(scripts\cp_mp\killstreaks\helper_drone::function_8c4ab0a7799e7ab8(weapon)) {
    return 1;
  }

  return 0;
}

function function_aa6acff8443c394b(weaponname) {
  switch (weaponname) {
    case #"hash_22f1c67a16accbe":
    case #"hash_23e064160a945b76":
    case #"hash_4391d14a10c9085b":
    case #"hash_56ee829cc162271a":
    case #"hash_5be4c94863c15240":
    case #"hash_e6e5011c399831fc":
      return 1;
    default:
      return 0;
  }
}

function function_ed29898d6e83dd3(weaponname) {
  switch (weaponname) {
    case #"hash_10480ca9423043c7":
    case #"hash_4cdc20240e59faaf":
      return 0;
    default:
      return 1;
  }
}

function function_5e15cf3721cdcaab(shockstick) {
  print("<dev string:x2fd>");

  self endon("death_or_disconnect");
  shockstick endon("death");
  currentweapon = undefined;

  if(scripts\mp\utility\weapon::grenadeinpullback()) {
    currentweapon = scripts\cp_mp\weapon::getgrenadeinpullback();

    if(shockstick.owner == self && currentweapon.basename == "shock_stick_mp") {
      return 1;
    }

    currentweapon = scripts\cp_mp\weapon::getgrenadeinpullback();

    if(!isDefined(currentweapon)) {
      currentweapon = self.currentweapon;
    }
  } else {
    currentweapon = self.currentweapon;
  }

  if(!isDefined(currentweapon) || isnullweapon(currentweapon)) {
    return 0;
  }

  if(!istrue(function_ed29898d6e83dd3(currentweapon.basename))) {
    return 0;
  }

  ammocount = self getweaponammoclip(currentweapon);
  shouldstowweapon = function_cf082013d5205e0d(currentweapon);
  prevweapon = self.prevweaponobj;

  if(!isDefined(prevweapon)) {
    prevweapon = makeweapon("iw9_me_fists");
  }

  print("<dev string:x7c>" + self getentitynumber() + "<dev string:x319>");

  if(!shouldstowweapon) {
    print("<dev string:x7c>" + self getentitynumber() + "<dev string:x33d>");

    var_87caac6bf5e569e7 = self.origin;
    equipmenttype = scripts\mp\utility\weapon::getequipmenttype(currentweapon);
    shoulddropweapon = !self function_55965d2ca2ada688();

    if(!isDefined(equipmenttype)) {
      return 1;
    }

    if(equipmenttype == "tactical") {
      var_87caac6bf5e569e7 = self gettagorigin("tag_accessory_right");
    } else if(equipmenttype == "lethal") {
      var_87caac6bf5e569e7 = self gettagorigin("tag_accessory_left");
    }

    if(shoulddropweapon) {
      velocityvec = (0, 0, 0);
      velocityvec += anglesToForward(self.angles) * getdvarfloat(@ "hash_c7f7fb9ea22e108f", 200);
      velocityvec += anglestoup(self.angles) * getdvarfloat(@ "hash_b2d4c6bd7da9e85f", 100);
      scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(currentweapon, undefined, undefined, 1);
      droppedgrenade = scripts\mp\utility\weapon::_launchgrenade(currentweapon.basename, var_87caac6bf5e569e7, velocityvec);
      self setweaponammoclip(currentweapon, ammocount - 1);
      scripts\mp\weapons::grenadeinitialize(droppedgrenade, currentweapon, 0, self);
      scripts\mp\weapons::grenadeused(droppedgrenade);
    }

    return 1;
  }

  return function_de0e81433eb4b20c(currentweapon);
}

function function_e3bcea2db6ca29bc() {
  return isDefined(self.var_318e9ed18014aada) && gettime() - self.var_318e9ed18014aada < 0.5;
}

function function_de0e81433eb4b20c(currentweapon) {
  print("<dev string:x34e>");

  if(scripts\cp_mp\utility\killstreak_utility::isremotekillstreaktabletweapon(currentweapon.basename)) {
    return 0;
  }

  if(scripts\cp_mp\killstreaks\helper_drone::function_8c4ab0a7799e7ab8(currentweapon)) {
    return 0;
  }

  if(scripts\cp_mp\weapon::function_5419ac7173288fc1(currentweapon)) {
    self.var_4a2f2f50a9020e2e = 1;
    self notify("cancel_location");
    return 0;
  }

  if(currentweapon.basename == "deploy_sentry_mp" || currentweapon.basename == "deploy_remote_turret_mp") {
    self notify("equip_deploy_cancel");
    return 1;
  }

  if(currentweapon.basename == "deploy_loadout_drop_mp") {
    print("<dev string:x36b>");

    self notify("cancel_all_killstreak_deployments");
    return 1;
  }

  if(function_84422a637aa542e2(currentweapon.basename)) {
    function_5ac47272c12bd920(currentweapon);

    if(scripts\mp\utility\weapon::issuperweapon(currentweapon)) {
      if(function_e3bcea2db6ca29bc()) {
        scripts\mp\supers::refundsuper();

        if(isDefined(self.var_9df92c66c8402503)) {
          self.var_9df92c66c8402503 delete();
        }
      }
    }

    return 1;
  }

  if(scripts\mp\laststand::function_3b4a396318897a49(currentweapon)) {
    self.var_a23f35f8460d8857 = 1;
  }

  scripts\cp_mp\utility\inventory_utility::getridofweapon(currentweapon, 1);
  return 1;
}

function function_5ac47272c12bd920(weapon) {
  self endon("death_or_disconnect");
  self endon("killed_player");
  level endon("game_ended");
  ammoclip = self getweaponammoclip(weapon);
  ammostock = self getweaponammostock(weapon);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
  wait 0.05;
  scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon, undefined, undefined);
  self setweaponammoclip(weapon, ammoclip);
  self setweaponammostock(weapon, ammostock);

  if(scripts\mp\utility\weapon::issuperweapon(weapon)) {
    self assignweaponoffhandspecial(weapon);
    return;
  }

  equipmentref = scripts\mp\equipment::getequipmentreffromweapon(weapon);

  if(isDefined(equipmentref)) {
    slot = scripts\mp\equipment::findequipmentslot(equipmentref);
    assertex(isDefined(slot) && (slot == "<dev string:x38b>" || slot == "<dev string:x396>"), "<dev string:x3a3>" + equipmentref + "<dev string:x3bf>");

    if(slot == "primary") {
      self assignweaponoffhandprimary(weapon);
      return;
    }

    if(slot == "secondary") {
      self assignweaponoffhandsecondary(weapon);
    }
  }
}

function function_84422a637aa542e2(weaponname) {
  if(scripts\mp\utility\weapon::issuperweapon(weaponname)) {
    return 1;
  }

  switch (weaponname) {
    case #"hash_22f1c67a16accbe":
    case #"hash_23e064160a945b76":
    case #"hash_56ee829cc162271a":
    case #"hash_5be4c94863c15240":
      return 1;
    default:
      return 0;
  }
}

function shockstick_haywireagent(haywiredata) {
  level endon("game_ended");
  victim = haywiredata.victim;
  attacker = haywiredata.attacker;
  objweapon = haywiredata.objweapon;
  inflictor = haywiredata.inflictor;

  if(isstruct(inflictor)) {
    inflictor = attacker;
  }

  if(victim.health > 0 && !victim scripts\asm\asm_bb::bb_isanimScripted()) {
    firstshock = gettime() > victim._blackboard.var_dc51d4ea36da3ae1 + getdvarint(@ "hash_acf5b8fed3c019");
    victim._blackboard.var_dc51d4ea36da3ae1 = gettime();
    newshockstick = 0;

    if(!isDefined(victim.shocksticks)) {
      victim.shocksticks = [];
    }

    if(!array_contains(victim.shocksticks, self)) {
      victim.shocksticks[victim.shocksticks.size] = self;
      newshockstick = 1;
    }

    params = spawnStruct();
    params.haywiredata = haywiredata;
    params.firstshock = firstshock;
    params.newshockstick = newshockstick;
    victim callback::callback("shockStick_agentApplyHaywire", params);

    if(istrue(victim.allowpain) && victim asmhaspainstate(victim.asmname) && firstshock) {
      victim asmevalpaintransition(victim.asmname);
    }

    victim function_4ce69562a1b41fc7(objweapon);

    if(firstshock) {
      if(!isDefined(level.var_2d4ec6306e1af875)) {
        level.var_2d4ec6306e1af875 = throttle_initialize("shockStick_haywireAgent", 1, level.framedurationseconds);
      }

      function_f632348cbb773537(level.var_2d4ec6306e1af875, victim);
      victim dodamage(1, victim.origin, attacker, inflictor, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper");
    }

    victim.ishaywire = 1;
  }
}

function function_5dd66ebda239d1b(data) {
  level endon("game_ended");

  if(isDefined(data.victim.var_aa6fe6af4cbbdd47)) {
    data.victim thread[[data.victim.var_aa6fe6af4cbbdd47]](data);
  }
}

function function_46b866d198a76ddc(data, fromdeath) {
  if(istrue(data.victim.ishaywire)) {
    if(isDefined(data.victim.shocksticks) && data.victim.shocksticks.size > 0) {
      data.victim.shocksticks = array_remove(data.victim.shocksticks, self);
      data.victim.shocksticks = array_removeundefined(data.victim.shocksticks);

      if(data.victim.shocksticks.size > 0) {
        return;
      }
    }

    data.victim.ishaywire = undefined;

    if(isagent(data.victim)) {
      params = spawnStruct();
      params.haywiredata = data;
      params.fromdeath = fromdeath;
      data.victim callback::callback("shockStick_agentClearHaywire", params);

      if(data.victim isscriptable() && data.victim getscriptablehaspart("shockStickVfx")) {
        scriptablepart = data.victim getscriptablepartstate("shockStickVfx", 1);

        if(isDefined(scriptablepart)) {
          data.victim setscriptablepartstate("shockStickVfx", "off", 0);
        } else {
          assertmsg("<dev string:x3dd>");
        }
      }
    } else if(isPlayer(data.victim)) {
      data.victim thread function_6c0a9d95ebb14f2a(fromdeath);
    } else if(scripts\mp\utility\entity::isturret(data.victim)) {
      if(isDefined(data.victim.owner)) {
        data.victim.owner stopforcedfire();
      }
    } else if(isDefined(data.victim.var_2ca1a8cc9f467817)) {
      data.victim[[data.victim.var_2ca1a8cc9f467817]](data);
    }

    if(scripts\mp\utility\entity::isturret(data.victim) && isDefined(data.victim.var_2ca1a8cc9f467817)) {
      data.victim[[data.victim.var_2ca1a8cc9f467817]](data);
    }

    data.victim notify("haywire_cleared");
  }
}

function function_f100472240074998(applycallback) {
  self.var_aa6fe6af4cbbdd47 = applycallback;
}

function function_6eb20c71654fb6b4(removecallback) {
  self.var_63cf7c55a99888eb = removecallback;
}

function function_6c0a9d95ebb14f2a(fromdeath, bundle) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self stopforcedfire();
  self function_7e66e7ae96dd938(0);
  blendouttime = getdvarfloat(@ "hash_bcf804b0535227b8", 1.3);

  if(isDefined(bundle) && isDefined(bundle.var_1d572199f88fb41b)) {
    [[bundle.var_1d572199f88fb41b]]();
  } else {
    self setscriptablepartstate("shockStickVfx", "off", 0);
  }

  curweapon = self getcurrentweapon();

  if(!scripts\mp\utility\weapon::isakimbo(curweapon)) {
    self stopgestureviewmodel("vm_ges_shockstick_react", 0.7);
    self stopgestureviewmodel("vm_ges_shockstick_react_fists", 0.7);
  }

  scripts\mp\weapons::updatemovespeedscale();

  if(!fromdeath) {
    function_a9a57668997e3c85(0);
  }

  if(isDefined(self.var_2ca1a8cc9f467817)) {
    self thread[[self.var_2ca1a8cc9f467817]]();
  }
}

function function_600c7c4c73c6a773(lock) {
  stance = self getstance();

  if(lock) {
    if(stance == "stand") {
      val::set("shockstick_stance", "crouch", 0);
      val::set("shockstick_stance", "prone", 0);
    } else if(stance == "crouch") {
      val::set("shockstick_stance", "stand", 0);
      val::set("shockstick_stance", "prone", 0);
    } else if(stance == "prone") {
      val::set("shockstick_stance", "crouch", 0);
      val::set("shockstick_stance", "stand", 0);
    }

    return;
  }

  val::reset_all("shockstick_stance");
}

function function_9c95c914395a9d4a(impactorigin, radius) {
  if(!scripts\mp\bots\bots_util::bot_bots_enabled_or_added() && !scripts\common\utility::function_a10967d736dc56e5()) {
    return;
  }

  if(isDefined(level.var_85f0faee1e7958bb)) {
    badplace = function_619cdac2efb21978(impactorigin, (radius, radius, 125), (0, 0, 0), level.var_85f0faee1e7958bb);
  } else {
    badplace = createnavbadplacebybounds(impactorigin, (radius, radius, 125), (0, 0, 0));
  }

  return badplace;
}

function function_5d58ea6516bf050c(duration) {
  self endon("clearShockFX");
  self endon("disconnect");
  self notify("shockFX_active");
  self endon("shockFX_active");
  thread function_17adeb1fe103990d();
  wait duration;
  stopshockfx();
}

function function_17adeb1fe103990d() {
  self notify("stopShockFX");
  self endon("disconnect");
  self endon("stopShockFX");

  while(true) {
    if(!isreallyalive(self)) {
      return;
    }

    var_d0fe1a6b5a5e42b5 = !istrue(self isswimming());
    var_a576cb241180fb7f = istrue(self.var_a576cb241180fb7f);

    if(var_d0fe1a6b5a5e42b5 && var_a576cb241180fb7f) {
      scripts\mp\damage::dequeuecorpsetablefunc("shockStickDeath");
      self.var_a576cb241180fb7f = undefined;
    } else if(!var_d0fe1a6b5a5e42b5 && !var_a576cb241180fb7f) {
      scripts\mp\damage::enqueuecorpsetablefunc("shockStickDeath", &function_a09639f24d4e918e);
      self.var_a576cb241180fb7f = 1;
    }

    waitframe();
  }
}

function stopshockfx() {
  self notify("stopShockFX");
  scripts\mp\damage::dequeuecorpsetablefunc("shockStickDeath");
  self.var_a576cb241180fb7f = undefined;
}

function function_a09639f24d4e918e(corpsetable) {
  corpsetable setscriptablepartstate("shockStickDeath", "vfx_start", 0);
}

function function_4ce69562a1b41fc7(objweapon) {
  shockevent = "vfx_start";

  if(isDefined(objweapon) && isDefined(objweapon.basename)) {
    switch (objweapon.basename) {
      case #"hash_4cdc20240e59faaf":
        shockevent = "vfx_start_super";
        break;
    }
  }

  if(self getscriptablehaspart("shockStickVfx")) {
    self setscriptablepartstate("shockStickVfx", shockevent, 0);
  }
}
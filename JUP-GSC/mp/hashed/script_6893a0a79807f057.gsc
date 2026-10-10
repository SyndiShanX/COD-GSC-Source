/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6893a0a79807f057.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\mp_agent;
#namespace namespace_96967e67f325d164;

function activate() {
  var_67fff5b201c4698d = 120;

  for(i = 0; i < 3; i++) {
    spawnangle = var_67fff5b201c4698d * i + randomfloatrange(-15, 15);
    spawnpos = level.player.origin + 75 * (cos(spawnangle), sin(spawnangle), 0);
    agent = scripts\mp\mp_agent::spawnnewagentaitype("support_mp_ar_base", spawnpos, (0, spawnangle, 0), level.player.team);
    agent.leader = level.player;
    agent.issupport = 1;
    agent thread function_2afd04eb035f975();
    agent thread function_456ff70fc6a3b1f8();
  }
}

function activate_enemy() {
  var_67fff5b201c4698d = 360;
  enemyorigin = level.player.origin + anglesToForward(level.player.angles) * 1000;

  for(i = 0; i < 1; i++) {
    spawnangle = var_67fff5b201c4698d * i + randomfloatrange(-15, 15);
    spawnpos = enemyorigin + 75 * (cos(spawnangle), sin(spawnangle), 0);
    agent = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_ar_base", spawnpos, (0, spawnangle, 0), "team_hundred_ninety_five");
  }
}

function function_2afd04eb035f975() {
  self endon("death");
  self.leader endon("death_or_disconnect");

  while(true) {
    self.leader waittill("calloutmarkerping_notifyhandled", notification, pingindex, var_60fdfb1cfd734d00);

    if(!isDefined(notification) || !isDefined(pingindex)) {
      continue;
    }

    if(notification == "calloutmarkerping_cleared" && isDefined(self.followingping) && self.followingping == pingindex) {
      self notify("ping_canceled");
      self.followingping = undefined;
      continue;
    }

    switch (notification) {
      case #"hash_bf30d88fa3f51a24":
        pingtype = self.leader calloutmarkerping_gettype(pingindex);
        pingorigin = self.leader calloutmarkerping_getorigin(pingindex);

        if(scripts\cp_mp\calloutmarkerping::function_c648f0fd527e089a(pingtype)) {
          var_d16c481bae2b1cd3 = self.leader calloutmarkerping_getEnt(pingindex);

          if(isDefined(var_d16c481bae2b1cd3)) {
            self.followingping = pingindex;
            self setgoalpos(getclosestpointonnavmesh(var_d16c481bae2b1cd3.origin));
          }
        } else if(scripts\cp_mp\calloutmarkerping::function_5dacc89a40a58737(pingtype)) {
          var_c0e3b7c8c7c23791 = self.leader calloutmarkerping_getEnt(pingindex);

          if(isDefined(var_c0e3b7c8c7c23791) && isDefined(var_c0e3b7c8c7c23791.entity)) {
            var_c0e3b7c8c7c23791 = var_c0e3b7c8c7c23791.entity;
          }

          self.favoriteenemy = var_c0e3b7c8c7c23791;
          self notify("target_switch");
          thread function_675553db448c2741(var_c0e3b7c8c7c23791);
        } else if(scripts\cp_mp\calloutmarkerping::function_d3789a9a4be5df2e(pingtype)) {
          var_c0e3b7c8c7c23791 = self.leader calloutmarkerping_getEnt(pingindex);

          if(isDefined(var_c0e3b7c8c7c23791) && isDefined(var_c0e3b7c8c7c23791.entity)) {
            var_c0e3b7c8c7c23791 = var_c0e3b7c8c7c23791.entity;
          }

          self.followingping = pingindex;
          self setgoalpos(getclosestpointonnavmesh(var_c0e3b7c8c7c23791.origin));
        } else if(scripts\cp_mp\calloutmarkerping::function_87df78670540e9b2(pingtype)) {} else {
          switch (pingtype) {
            case 3:
              break;
            case 2:
            case 4:
              self.followingping = pingindex;
              self setgoalpos(getclosestpointonnavmesh(pingorigin));
              break;
            case 6:
              break;
            case 5:
              break;
            case 12:
              break;
            default:
              break;
          }
        }

        break;
    }
  }
}

function function_456ff70fc6a3b1f8() {
  self.leader endon("death_or_disconnect");

  while(true) {
    self.leader waittill("damage", damage, attacker);

    if(isDefined(self.favoriteenemy) && self.leader.health >= 0.5 * self.leader.maxhealth) {
      continue;
    }

    if(isDefined(attacker) && isalive(attacker) && attacker.team != self.team) {
      if(isDefined(self.favoriteenemy) && self.favoriteenemy == attacker) {
        continue;
      }

      self.favoriteenemy = attacker;
      self notify("target_switch");
      thread function_675553db448c2741(attacker);
    }
  }
}

function function_675553db448c2741(attacker) {
  self endon("death");
  self endon("target_switch");

  while(true) {
    attacker waittill("death");
    self.favoriteenemy = undefined;
    return;
  }
}

function function_92cfd582ab09b167(pickup) {
  if(scripts\mp\gametypes\br_public::isammo(pickup.scriptablename)) {
    var_fb40d5954b4f6792 = canholdammobox(pickup.scriptablename);

    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_f8a3ff0a73fa0c1d(pickup, var_fb40d5954b4f6792);
    } else if(var_fb40d5954b4f6792) {
      return 1;
    } else {
      return 4;
    }
  }

  isautouse = istrue(pickup.isautouse);

  if(isweaponpickupitem(pickup)) {
    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      return 17;
    }

    newweapon = scripts\mp\gametypes\br_weapons::function_55c5d35c8c76a95b(pickup)[0];

    foreach(weap in self.primaryweapons) {
      if(issameweapon(weap, newweapon)) {
        fakepickup = spawnStruct();
        fakepickup.scriptablename = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(newweapon);
        fakepickup.count = weaponclipsize(newweapon);

        if(isDefined(fakepickup.scriptablename)) {
          result = function_f8a3ff0a73fa0c1d(fakepickup, canholdammobox(pickup.scriptablename));

          if(result == 1) {
            result = 5;
          } else if(result == 20) {
            result = 27;
          }

          return result;
        }

        return 28;
      }
    }

    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename) && namespace_aead94004cf4c147::function_3ab0a87eeaa203bf()) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      result = namespace_aead94004cf4c147::function_e01d9736b2d100ac(lootid, pickup.count);

      if(istrue(result)) {
        return 20;
      }
    }

    return 1;
  }

  if(scripts\mp\gametypes\br_public::isequipment(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup, isautouse);
    }

    return 1;
  }

  if(isplunder(pickup.scriptablename)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.plunderlimit) && self.plundercount >= level.br_plunder.plunderlimit) {
      return 11;
    }

    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup, isautouse);
    }
  }

  if(isgasmask(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup, isautouse);
    }
  }

  if(function_6b5f3fb6550ae6d5(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      result = namespace_aead94004cf4c147::function_e01d9736b2d100ac(lootid, pickup.count);

      if(istrue(result)) {
        return 20;
      }
    }

    return 1;
  }

  if(iskillstreak(pickup.scriptablename)) {
    killstreakref = level.br_pickups.var_14bd11727c4b6629[pickup.scriptablename];

    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename) && namespace_aead94004cf4c147::function_d674d32c2d3ba5ed(self)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      result = namespace_aead94004cf4c147::function_e01d9736b2d100ac(lootid, pickup.count);

      if(istrue(result)) {
        return 20;
      }
    }

    return 4;
  }

  if(issuperpickup(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      if(namespace_aead94004cf4c147::function_5e7049647595ab97()) {
        return function_cbbf9bf3544dc456(pickup);
      }
    }

    return 4;
  }

  if(scripts\mp\gametypes\br_public::isarmor(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_99ab09ba7022d107(pickup);
    }

    return 1;
  }

  if(function_a5202e2fc8ecb076(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      if(!isDefined(pickup.count)) {
        pickup.count = 1;
      }

      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isaccesscard(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isattachment(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }
  }

  if(iskey(pickup.scriptablename)) {
    if(function_9a5d18fbdad686c2(pickup.scriptablename)) {
      if(istrue(self.var_43b2a82936a5e974)) {
        return 23;
      } else {
        return 1;
      }
    }

    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(pickup.scriptablename);
      index = namespace_aead94004cf4c147::function_e05897f5d860188e(lootid, pickup.count, 0);

      if(isDefined(index)) {
        keystruct = namespace_aead94004cf4c147::function_6738846da50730f1(index);

        if(isDefined(keystruct) && isDefined(keystruct[1]) && keystruct[1] > 2) {
          return 23;
        }
      }

      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isvaluable(pickup.scriptablename) || ispersonal(pickup.scriptablename) || function_cb1e30930c35f2e2(pickup.scriptablename) || function_5449da9d3d0358a4(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isweaponcase(pickup.scriptablename)) {
    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      return function_cbbf9bf3544dc456(pickup);
    }

    return 1;
  }

  if(isdogtag(pickup.scriptablename)) {
    scripts\mp\gametypes\dmz_dog_tag::function_b5d4fcc3fab92696(pickup);

    if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
      if(scripts\mp\gametypes\dmz_dog_tag::function_d9f5c5090de1241b(self, pickup.count)) {
        [victimindex, _] = scripts\mp\gametypes\dmz_dog_tag::getdogtagvictimandkiller(pickup.count);

        if(isDefined(level.dogtaginfo[victimindex].player)) {
          scripts\mp\gametypes\dmz_dog_tag::function_8e643d6706defeea(level.dogtaginfo[victimindex].player, pickup.count);
        }

        if(level.dogtaginfo[victimindex].player != self) {
          scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_recover_dog_tag", [self], undefined);
        }

        return 1;
      }

      result = function_cbbf9bf3544dc456(pickup);

      if(result == 20) {
        if(isDefined(level.var_9a3c2481a4cd4b46)) {
          [[level.var_9a3c2481a4cd4b46]](self, pickup.count);
        }

        if(scripts\mp\gametypes\dmz_dog_tag::function_1129ba5718d33025(self, pickup.count)) {
          thread scripts\mp\gametypes\dmz_dog_tag::function_ea29bccf97cb1b9a(self, pickup.count);
        }

        scripts\mp\gametypes\dmz_dog_tag::function_b5fbe3cb4ed955f4(self, pickup.count);
      }

      return result;
    }

    return 1;
  }

  if(scripts\mp\gametypes\br_public::function_4aa12e0ed3f6b745(pickup.scriptablename)) {
    platelevel = scripts\mp\gametypes\br_public::function_692c3df266580df6(pickup.scriptablename);

    if(self.platecarrierlevel < platelevel) {
      return 1;
    }

    return function_cbbf9bf3544dc456(pickup);
  }

  if(function_36de08ea672b354c(pickup.scriptablename)) {
    if(isDefined(self.brperkpack) && self.brperkpack != "brloot_perkpack_custom" && self.brperkpack == pickup.scriptablename) {
      if(namespace_aead94004cf4c147::function_7e103028c464ab9a(pickup.scriptablename)) {
        result = function_cbbf9bf3544dc456(pickup);

        if(result == 4) {
          return 29;
        } else {
          return result;
        }
      } else {
        return 4;
      }
    }

    return 1;
  }

  return 4;
}

function function_b95656bc9f3d0896(var_d16c481bae2b1cd3) {
  self endon("ping_canceled");
  self waittill("goal");
  isdoor = var_d16c481bae2b1cd3 scriptableisdoor();
  islootcache = var_d16c481bae2b1cd3 scriptableislootcache();
  isusable = var_d16c481bae2b1cd3 function_6954a8d7ba8cd9fb();

  if(isusable) {
    if(isdoor) {
      if(var_d16c481bae2b1cd3 scriptabledoorisclosed()) {}

      return;
    }

    if(islootcache) {
      return;
    }

    part = var_d16c481bae2b1cd3.type;
    state = var_d16c481bae2b1cd3 getscriptablepartstate(part);
    pickup = spawnStruct();
    pickup.scriptablename = var_d16c481bae2b1cd3.type;
    pickup.origin = var_d16c481bae2b1cd3.origin;
    pickup.count = loot_getitemcount(var_d16c481bae2b1cd3);
    pickup.countlefthand = loot_getitemcountlefthand(var_d16c481bae2b1cd3);
    pickup.countalt = function_3a5f7703319142dd(var_d16c481bae2b1cd3);
    pickup.instance = var_d16c481bae2b1cd3;
    pickup.customweaponname = var_d16c481bae2b1cd3.customweaponname;
    pickup.maxcount = level.br_pickups.maxcounts[pickup.scriptablename];
    pickup.stackable = level.br_pickups.stackable[pickup.scriptablename];
    assert(isDefined(pickup.count));

    if(!pickup.count && isDefined(level.br_pickups.counts[pickup.scriptablename])) {
      pickup.count = level.br_pickups.counts[pickup.scriptablename];
    }

    pickup.isweaponfromcrate = var_d16c481bae2b1cd3.isweaponfromcrate;
    pickup.isautouse = 0;

    if(!isDefined(var_d16c481bae2b1cd3) || var_d16c481bae2b1cd3 getscriptableisloot() && !lootusedignore(var_d16c481bae2b1cd3)) {
      results = function_92cfd582ab09b167(pickup);

      if(results == 1) {
        return function_60234aa487445085(pickup, self, 0, var_d16c481bae2b1cd3);
      }

      if(results == 20) {
        return function_8f0bd51f5c6108b(pickup, self, 0, var_d16c481bae2b1cd3);
      }

      if(results == 5 || results == 27) {
        newweapon = scripts\mp\gametypes\br_weapons::function_55c5d35c8c76a95b(pickup)[0];
        fakepickup = spawnStruct();
        fakepickup.scriptablename = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(newweapon);
        fakepickup.origin = pickup.origin;
        fakepickup.count = weaponclipsize(newweapon);

        if(results == 5) {
          function_60234aa487445085(fakepickup, self);
        } else {
          function_8f0bd51f5c6108b(fakepickup, self);
        }

        if(isDefined(var_d16c481bae2b1cd3)) {
          loothide(var_d16c481bae2b1cd3);
        }
      }
    }
  }
}
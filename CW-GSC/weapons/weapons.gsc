/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\weapons.gsc
***********************************************/

#using script_7a8059ca02b7b09e;
#using scripts\core_common\array_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\debug_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;
#namespace weapons;

function init_shared() {
  level.weaponnone = getweapon(#"none");
  level.weaponnull = getweapon(#"weapon_null");
  level.var_60fa96d6 = getweapon(#"bare_hands");
  level.weaponbasemelee = getweapon(#"knife");
  level.weaponbasemeleeheld = getweapon(#"knife_held");
  level.weaponballisticknife = getweapon(#"special_ballisticknife_t9_dw");
  level.var_38b456aa = getweapon(#"special_nailgun_t9");
  level.weaponspecialcrossbow = getweapon(#"special_crossbow_t9");
  level.var_91199825 = getweapon(#"special_grenadelauncher_t9");
  level.weaponflechette = getweapon(#"tr_flechette_t8");
  level.weaponriotshield = getweapon(#"riotshield");
  level.weaponflashgrenade = getweapon(#"flash_grenade");
  level.weaponsatchelcharge = getweapon(#"satchel_charge");
  level.var_43a51921 = getweapon(#"hash_5a7fd1af4a1d5c9");
  level.var_387e902c = getweapon(#"hash_31be8125c7d0f273");
  level.var_34d27b26 = getweapon(#"null_offhand_primary");
  level.var_6388e216 = getweapon(#"null_offhand_secondary");
  level.var_507570e9 = getweapon(#"eq_stimshot");

  if(!isDefined(level.trackweaponstats)) {
    level.trackweaponstats = 1;
  }

  if(!isDefined(level.var_8c5a071d)) {
    level.var_8c5a071d = 1;
  }

  level._effect[#"flashninebang"] = # "_t6/misc/fx_equip_tac_insert_exp";
  callback::on_start_gametype(&init);
  callback::on_player_killed(&on_death);
  level.detach_all_weapons = &detach_all_weapons;
}

function function_6916626d() {
  level.var_e520065 = 1;
}

function init() {
  level.missileentities = [];
  level.hackertooltargets = [];
  level.var_2d187870 = [];
  level.missileduddeletedelay = getdvarint(#"scr_missileduddeletedelay", 3);

  if(!isDefined(level.roundstartexplosivedelay)) {
    level.roundstartexplosivedelay = 0;
  }

  clientfield::register_clientuimodel("hudItems.pickupHintWeaponIndex", 1, 10, "int");
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_weapon_change(&on_weapon_change);
  callback::on_grenade_fired(&on_grenade_fired);
  callback::function_4b7977fe(&function_4b7977fe);
  self callback::on_end_game(&on_end_game);

  if(level.var_e520065 === 1) {
    level thread function_220ea8ba();
  }
}

function function_4fddf732() {
  self.concussionendtime = 0;
  self.scavenged = 0;
  self.hasdonecombat = 0;
  self.shielddamageblocked = 0;
  self.usedkillstreakweapon = [];
  self.usedkillstreakweapon[#"minigun"] = 0;
  self.usedkillstreakweapon[#"m32"] = 0;
  self.usedkillstreakweapon[#"m220_tow"] = 0;
  self.usedkillstreakweapon[#"mp40_blinged"] = 0;
  self.killstreaktype = [];
  self.killstreaktype[#"minigun"] = "minigun";
  self.killstreaktype[#"m32"] = "m32";
  self.killstreaktype[#"m220_tow"] = "m220_tow";
  self.killstreaktype[#"mp40_blinged"] = "mp40_blinged_drop";
  self.throwinggrenade = 0;
  self.gotpullbacknotify = 0;
  self.lastdroppableweapon = level.weaponnone;
  self.lastweaponchange = 0;
  self.droppeddeathweapon = undefined;
  self.tookweaponfrom = [];
  self.pickedupweaponkills = [];
  self.var_3ffebf0a = 0;
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
}

function on_player_connect() {
  self.usedweapons = 0;
  self.lastfiretime = 0;
  self.hits = 0;
  self.headshothits = 0;
  self function_4fddf732();

  if(is_true(level.var_3a0bbaea)) {
    function_878d649f(self);
  }
}

function on_player_spawned() {
  self function_4fddf732();
  newweapon = self getcurrentweapon();

  if(may_drop(newweapon)) {
    self.lastdroppableweapon = newweapon;
  }

  self function_2a928426();
}

function function_878d649f(player) {
  assert(isPlayer(player));
  player thread function_388f7cf7();
}

function event_handler[weapon_change] function_edc4ebe8(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  newweapon = eventstruct.weapon;

  if(may_drop(newweapon)) {
    self.lastdroppableweapon = newweapon;
    self.lastweaponchange = gettime();
  }

  if(!isDefined(self.spawnweapon)) {
    self.spawnweapon = newweapon;
  }

  if(doesweaponreplacespawnweapon(self.spawnweapon, newweapon)) {
    self.spawnweapon = newweapon;
    self.pers[#"spawnweapon"] = newweapon;
  }

  if(!isDefined(self.lastnonkillstreakweapon) && isDefined(newweapon)) {
    self.lastnonkillstreakweapon = newweapon;
  }

  self callback::callback(#"weapon_change", eventstruct);
}

function may_drop(weapon) {
  if(weapon == level.weaponnone) {
    return false;
  }

  if(isDefined(level.laststandpistol) && weapon == level.laststandpistol) {
    return false;
  }

  if(isDefined(level.var_f425c7f3)) {
    foreach(var_22174a13 in level.var_f425c7f3) {
      if(var_22174a13 == weapon) {
        return false;
      }
    }
  }

  if(killstreaks::is_killstreak_weapon(weapon)) {
    return false;
  }

  if(weapon.iscarriedkillstreak) {
    return false;
  }

  if(weapon.isgameplayweapon) {
    return false;
  }

  if(!weapon.isprimary) {
    return false;
  }

  if(weapon.var_29d24e37) {
    return false;
  }

  if(weapon.var_9a789947) {
    return false;
  }

  if(weapon.isnotdroppable) {
    return false;
  }

  return true;
}

function function_fe1f5cc() {
  last_weapon = undefined;

  if(isDefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon)) {
    last_weapon = self.lastnonkillstreakweapon;
  } else if(isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
    last_weapon = self.lastdroppableweapon;
  }

  return last_weapon;
}

function function_2be39078(last_weapon) {
  if(!isDefined(last_weapon)) {
    return false;
  }

  if(!self hasweapon(last_weapon)) {
    return false;
  }

  if(!may_drop(last_weapon)) {
    return false;
  }

  return true;
}

function function_d571ac59(last_weapon = undefined, immediate = 0, awayfromball = 0, var_81af68a5 = 0) {
  ball = getweapon(#"ball");

  if(isDefined(ball) && self hasweapon(ball) && !is_true(awayfromball)) {
    self switchtoweaponimmediate(ball);
    self disableweaponcycling();
    self disableoffhandweapons();
    return;
  } else if(self laststand::player_is_in_laststand()) {
    if(isDefined(self.laststandpistol) && self hasweapon(self.laststandpistol)) {
      self switchtoweapon(self.laststandpistol);
      return;
    }
  } else {
    to_weapon = undefined;

    if(var_81af68a5 || function_2be39078(last_weapon)) {
      to_weapon = last_weapon;
    }

    if(!isDefined(to_weapon)) {
      to_weapon = function_fe1f5cc();
    }

    if(isDefined(to_weapon)) {
      if(to_weapon.isheavyweapon) {
        if(to_weapon.gadget_heroversion_2_0) {
          if(to_weapon.isgadget && self getammocount(to_weapon) > 0) {
            slot = self gadgetgetslot(to_weapon);

            if(self util::gadget_is_in_use(slot)) {
              if(is_true(immediate)) {
                self switchtoweaponimmediate(to_weapon);
                return;
              }

              self switchtoweapon(to_weapon);
              return;
            }
          }
        } else if(self getammocount(to_weapon) > 0) {
          if(is_true(immediate)) {
            self switchtoweaponimmediate(to_weapon);
            return;
          }

          self switchtoweapon(to_weapon);
          return;
        }
      } else if(self getammocount(to_weapon) > 0 || to_weapon.ismeleeweapon) {
        if(is_true(immediate)) {
          self switchtoweaponimmediate(to_weapon);
          return;
        }

        self switchtoweapon(to_weapon);
        return;
      }
    }
  }

  if(is_true(immediate)) {
    self switchtoweaponimmediate();
    return;
  }

  self switchtoweapon();
}

function update_last_held_weapon_timings(newtime, var_d75fdbe3 = self.currentweapon) {
  if(isDefined(self.currentweapon) && isDefined(self.currentweaponstarttime)) {
    totaltime = int(float(newtime - self.currentweaponstarttime) / 1000);

    if(totaltime > 0) {
      weaponpickedup = 0;

      if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[var_d75fdbe3])) {
        weaponpickedup = 1;
      }

      self stats::function_eec52333(var_d75fdbe3, #"timeused", totaltime, self.class_num, weaponpickedup);
      level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
        #player: self, #weapon: var_d75fdbe3, #statname: # "timeused", #value: totaltime, #weaponpickedup: weaponpickedup
      });
      self.currentweaponstarttime = newtime;
    }
  }
}

function update_timings(newtime) {
  if(isbot(self)) {
    return;
  }

  update_last_held_weapon_timings(newtime);

  if(!isDefined(self.staticweaponsstarttime)) {
    return;
  }

  totaltime = int(float(newtime - self.staticweaponsstarttime) / 1000);

  if(totaltime < 0) {
    return;
  }

  self.staticweaponsstarttime = newtime;

  if(isDefined(self.weapon_array_grenade)) {
    for(i = 0; i < self.weapon_array_grenade.size; i++) {
      self stats::function_eec52333(self.weapon_array_grenade[i], #"timeused", totaltime, self.class_num);
    }
  }

  if(isDefined(self.weapon_array_inventory)) {
    for(i = 0; i < self.weapon_array_inventory.size; i++) {
      self stats::function_eec52333(self.weapon_array_inventory[i], #"timeused", totaltime, self.class_num);
    }
  }

  if(isDefined(self.killstreak)) {
    for(i = 0; i < self.killstreak.size; i++) {
      killstreaktype = level.menureferenceforkillstreak[self.killstreak[i]];

      if(isDefined(killstreaktype)) {
        killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
        self stats::function_eec52333(killstreakweapon, #"timeused", totaltime, self.class_num);
      }
    }
  }

  if(level.rankedmatch && level.perksenabled) {
    perksindexarray = [];
    specialtys = self.specialty;

    if(!isDefined(specialtys)) {
      return;
    }

    if(!isDefined(self.curclass)) {
      return;
    }

    if(isDefined(self.class_num)) {
      for(numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
        perk = self getloadoutitem(self.class_num, "specialty" + numspecialties + 1);

        if(perk != 0) {
          perksindexarray[perk] = 1;
        }
      }

      foreach(k, v in perksindexarray) {
        if(v == 1 && k >= 0) {
          self stats::inc_stat(#"itemstats", k, #"stats", #"timeused", #"statvalue", totaltime);
        }
      }
    }
  }
}

function on_death(params) {
  if(game.state == # "playing" && level.trackweaponstats) {
    if(!isDefined(self.var_e09dd2bf)) {
      self.var_e09dd2bf = gettime();
    }

    self bb::commit_weapon_data(getplayerspawnid(self), self getcurrentweapon(), self.var_e09dd2bf);
    update_timings(gettime());
  }
}

function private function_220ea8ba() {
  self notify("a113b21a3f97cb8");
  self endon("a113b21a3f97cb8");
  level endon(#"game_ended");

  if(!isDefined(level.var_c5a37526)) {
    level.var_c5a37526 = [];
  }

  while(!isDefined(level.var_445b1bca)) {
    level waittill(#"hash_8c9c1055b97344e");
  }

  while(true) {
    waitframe(1);

    if(level.var_c5a37526.size == 0) {
      level waittill(#"hash_8c9c1055b97344e");
      continue;
    }

    if(level.var_445b1bca + function_60d95f53() >= gettime()) {
      continue;
    }

    waittillframeend();
    pixbeginevent(#"");
    info = level.var_c5a37526[0];

    if(function_c44bf23e(info)) {
      info.victim function_6cf6f3fb(info.attacker, info.sweapon, info.smeansofdeath, info.damage, info.var_1940b58e, info);
    }

    arrayremoveindex(level.var_c5a37526, 0, 0);
    pixendevent();
  }
}

function private function_c44bf23e(info) {
  if(!isDefined(info.victim)) {
    return false;
  }

  if(info.victim.var_3ffebf0a !== 1) {
    return false;
  }

  if(info.time + 500 < gettime()) {
    return false;
  }

  return true;
}

function drop_for_death(attacker, sweapon, smeansofdeath, damage, var_1940b58e = 1) {
  if(isDefined(level.var_c5a37526)) {
    if(level.var_c5a37526.size + 1 >= 20) {
      return;
    }

    var_cef01b32 = {};
    var_cef01b32.time = gettime();
    var_cef01b32.victim = self;
    var_cef01b32.attacker = attacker;
    var_cef01b32.sweapon = sweapon;
    var_cef01b32.smeansofdeath = smeansofdeath;
    var_cef01b32.damage = damage;
    var_cef01b32.var_1940b58e = var_1940b58e;
    lastdroppableweapon = self.lastdroppableweapon;

    if(isDefined(lastdroppableweapon)) {
      var_cef01b32.lastdroppableweapon = lastdroppableweapon;
      var_cef01b32.weaponammoclip = self getweaponammoclip(lastdroppableweapon);
      var_cef01b32.var_bf0fb76a = self getweaponammostock(lastdroppableweapon);
      var_cef01b32.anyammoforweaponmodes = self anyammoforweaponmodes(lastdroppableweapon);
    }

    if(!isDefined(level.var_c5a37526)) {
      level.var_c5a37526 = [];
    } else if(!isarray(level.var_c5a37526)) {
      level.var_c5a37526 = array(level.var_c5a37526);
    }

    level.var_c5a37526[level.var_c5a37526.size] = var_cef01b32;
    self.var_3ffebf0a = 1;

    if(level.var_c5a37526.size == 1) {
      level notify(#"hash_8c9c1055b97344e");
    }

    return;
  }

  self function_6cf6f3fb(attacker, sweapon, smeansofdeath, damage, var_1940b58e);
}

function private function_6cf6f3fb(attacker, sweapon, smeansofdeath, damage, var_1940b58e = 1, var_8211a4fa) {
  if(level.disableweapondrop == 1) {
    return;
  }

  if(getdvarint(#"hash_240ba8055f788068", 0)) {
    return;
  }

  weapon = isDefined(var_8211a4fa) ? var_8211a4fa.lastdroppableweapon : self.lastdroppableweapon;

  if(isDefined(self.droppeddeathweapon)) {
    return;
  }

  if(!isDefined(weapon)) {
    if(getdvarint(#"scr_dropdebug", 0) == 1) {
      println("<dev string:x38>");
    }

    return;
  }

  if(weapon == level.weaponnone) {
    if(getdvarint(#"scr_dropdebug", 0) == 1) {
      println("<dev string:x5b>");
    }

    return;
  }

  if(!self hasweapon(weapon)) {
    if(getdvarint(#"scr_dropdebug", 0) == 1) {
      println("<dev string:x81>" + weapon.name + "<dev string:xb0>");
    }

    return;
  }

  if(!(isDefined(var_8211a4fa.anyammoforweaponmodes) ? var_8211a4fa.anyammoforweaponmodes : self anyammoforweaponmodes(weapon))) {
    if(getdvarint(#"scr_dropdebug", 0) == 1) {
      println("<dev string:xb5>");
    }

    return;
  }

  if(!should_drop_limited_weapon(weapon, self)) {
    return;
  }

  if(weapon.iscarriedkillstreak) {
    return;
  }

  clipammo = isDefined(var_8211a4fa.weaponammoclip) ? var_8211a4fa.weaponammoclip : self getweaponammoclip(weapon);
  stockammo = isDefined(var_8211a4fa.var_182b7344) ? var_8211a4fa.var_182b7344 : self getweaponammostock(weapon);
  clip_and_stock_ammo = clipammo + stockammo;

  if(!clip_and_stock_ammo && !is_true(weapon.unlimitedammo)) {
    if(getdvarint(#"scr_dropdebug", 0) == 1) {
      println("<dev string:xe5>");
    }

    return;
  }

  if(is_true(weapon.isnotdroppable)) {
    return;
  }

  stockmax = weapon.maxammo;

  if(stockammo > stockmax) {
    stockammo = stockmax;
  }

  item = self dropitem(weapon);

  if(!isDefined(item)) {
    iprintlnbold("<dev string:x104>" + weapon.name);

    return;
  }

  if(getdvarint(#"scr_dropdebug", 0) == 1) {
    println("<dev string:x12e>" + weapon.name);
  }

  if(!isDefined(item.model) || item.model == # "") {
    iprintlnbold("<dev string:x142>" + weapon.name);
  }

  if(!item hasdobj()) {
    iprintlnbold("<dev string:x165>" + weapon.name);
  }

  self dropweaponfordeathlaunch(item, damage, self.angles, weapon, 1, 1, smeansofdeath);
  drop_limited_weapon(weapon, self, item);
  self.droppeddeathweapon = 1;

  if(!isDefined(item)) {
    return;
  }

  if(var_1940b58e) {
    item itemweaponsetammo(clipammo, stockammo);
  }

  item.owner = self;
  item.ownersattacker = sweapon;
  item.weapon = weapon;
  item.smeansofdeath = smeansofdeath;

  if(is_true(level.var_3a0bbaea)) {
    arrayremovevalue(level.var_2d187870, undefined);
    array::add(level.var_2d187870, item, 0);
  }

  item thread watch_pickup();
  item thread delete_pickup_after_awhile();
}

function function_388f7cf7() {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self notify("62d50dc4cfa71f56");
  self endon("62d50dc4cfa71f56");
  self waittill(#"spawned_player");

  while(true) {
    function_d2c66128(self.origin);
    waitframe(1);
  }
}

function function_d2c66128(origin) {
  maxdist = util::function_16fb0a3b();
  var_fbe2cce0 = 0;
  var_9b882d22 = self function_ee839fac();

  if(isDefined(var_9b882d22)) {
    var_fbe2cce0 = distancesquared(origin, var_9b882d22.origin) < sqr(maxdist);
  }

  if(var_fbe2cce0) {
    objstate = 0;
    neardist = util::function_4c1656d5();

    if(neardist < maxdist && distancesquared(origin, var_9b882d22.origin) > sqr(neardist)) {
      objstate = 1;
    }

    weaponindex = 0;

    if(isDefined(var_9b882d22.item)) {
      weaponindex = isDefined(getbaseweaponitemindex(var_9b882d22.item)) ? getbaseweaponitemindex(var_9b882d22.item) : 0;
    }

    self clientfield::set_player_uimodel("hudItems.pickupHintWeaponIndex", weaponindex);
    return;
  }

  self clientfield::set_player_uimodel("hudItems.pickupHintWeaponIndex", 0);
}

function delete_pickup_after_awhile() {
  self endon(#"death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  arrayremovevalue(level.var_2d187870, self);
  self delete();
}

function watch_pickup() {
  self endon(#"death");
  weapon = self.item;
  waitresult = self waittill(#"trigger");
  player = waitresult.activator;
  droppeditem = waitresult.dropped_item;
  pickedupontouch = waitresult.is_pickedup_ontouch;
  var_90f043d2 = pickedupontouch && !isDefined(droppeditem);

  if(!var_90f043d2) {
    if(isDefined(player) && isPlayer(player)) {
      if(isDefined(player.weaponpickupscount)) {
        player.weaponpickupscount++;
      } else {
        player.weaponpickupscount = 1;
      }

      if(!isDefined(player.pickedupweapons)) {
        player.pickedupweapons = [];
      }

      if(isDefined(self.owner)) {
        player.pickedupweapons[weapon] = self.owner getentitynumber();
      } else {
        player.pickedupweapons[weapon] = -1;
      }
    }
  }

  if(getdvarint(#"scr_dropdebug", 0) == 1) {
    println("<dev string:x187>" + weapon.name + "<dev string:x19d>" + isDefined(self.ownersattacker));
  }

  assert(isDefined(player.tookweaponfrom));
  assert(isDefined(player.pickedupweaponkills));

  if(!isDefined(player.tookweaponfrom)) {
    player.tookweaponfrom = [];
  }

  if(!isDefined(player.pickedupweaponkills)) {
    player.pickedupweaponkills = [];
  }

  if(isDefined(droppeditem)) {
    for(i = 0; i < droppeditem.size; i++) {
      if(!isDefined(droppeditem[i])) {
        continue;
      }

      droppedweapon = droppeditem[i].item;

      if(isDefined(player.tookweaponfrom[droppedweapon])) {
        droppeditem[i].owner = player.tookweaponfrom[droppedweapon].previousowner;
        droppeditem[i].ownersattacker = player;
        player.tookweaponfrom[droppedweapon] = undefined;
      }

      array::add(level.var_2d187870, droppeditem[i], 0);
      droppeditem[i] thread watch_pickup();
      droppeditem[i] thread delete_pickup_after_awhile();
    }
  }

  if(!isDefined(pickedupontouch) || !pickedupontouch) {
    if(isDefined(self.ownersattacker) && self.ownersattacker == player) {
      player.tookweaponfrom[weapon] = spawnStruct();
      player.tookweaponfrom[weapon].previousowner = self.owner;
      player.tookweaponfrom[weapon].weapon = self.weapon;
      player.tookweaponfrom[weapon].smeansofdeath = self.smeansofdeath;
      player.pickedupweaponkills[weapon] = 0;
      return;
    }

    player.tookweaponfrom[weapon] = undefined;
    player.pickedupweaponkills[weapon] = undefined;
  }
}

function event_handler[weapon_fired] function_cafc776a(eventstruct) {
  self callback::callback(#"weapon_fired", eventstruct);
  self callback::callback_weapon_fired(eventstruct.weapon);
  self function_f2c53bb2(eventstruct.weapon);
}

function event_handler[weapon_melee] function_3eaa5d64(eventstruct) {
  self callback::callback(#"weapon_melee", eventstruct);
}

function event_handler[weapon_melee_charge] function_9847a517(eventstruct) {
  self callback::callback(#"weapon_melee_charge", eventstruct);
}

function function_f2c53bb2(curweapon) {
  if(is_true(level.var_2511b5f1)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(sessionmodeiswarzonegame() && game.state !== # "playing") {
    return;
  }

  var_9ec972ec = 1;

  if(sessionmodeiscampaigngame()) {
    var_9ec972ec = 0;
  }

  self.lastfiretime = gettime();
  self.hasdonecombat = 1;

  if(var_9ec972ec) {
    switch (curweapon.weapclass) {
      case # "smg":
      case # "pistol spread":
      case # "mg":
      case # "spread":
      case # "pistol":
      case # "rifle":
        self track_fire(curweapon);
        break;
      case # "rocketlauncher":
      case # "grenade":
        self stats::function_eec52333(curweapon, #"shots", 1, self.class_num, 0);
        break;
      default:
        break;
    }
  }

  if(isDefined(curweapon.gadget_type) && curweapon.gadget_type == 11) {
    if(isDefined(self.heavyweaponshots)) {
      self.heavyweaponshots++;
    }
  }

  statweapon = getweapon(curweapon.statname);
  assert(statweapon != level.weaponnone);

  if(statweapon.iscarriedkillstreak) {
    var_607dffd9 = killstreaks::function_fde227c6(curweapon, statweapon);

    if(isDefined(self.pers[#"held_killstreak_ammo_count"][var_607dffd9])) {
      self.pers[#"held_killstreak_ammo_count"][var_607dffd9]--;
    }

    self.usedkillstreakweapon[statweapon.name] = 1;
  }

  if(var_9ec972ec) {
    self function_f95ea9b6(statweapon);
  }

  if(isDefined(level.var_c8241070)) {
    [[level.var_c8241070]](self, statweapon);
  }
}

function track_fire(curweapon) {
  pixbeginevent(#"");
  shotsfired = 1;

  if(1 < curweapon.shotcount) {
    shotsfired *= curweapon.shotcount;
  }

  weaponpickedup = 0;

  if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[curweapon])) {
    weaponpickedup = 1;
  } else {
    level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
      #player: self, #weapon: curweapon, #statname: # "shots", #value: shotsfired, #weaponpickedup: weaponpickedup
    });
    level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
      #player: self, #weapon: curweapon, #statname: # "hits", #value: isDefined(self.hits) ? self.hits : 0, #weaponpickedup: weaponpickedup
    });
  }

  self trackweaponfirenative(curweapon, shotsfired, isDefined(self.hits) ? self.hits : 0, isDefined(self.headshothits) ? self.headshothits : 0, 1, self.class_num, weaponpickedup);

  if(isDefined(self.var_fd243db7) && isDefined(self.var_fd243db7.var_245ad74)) {
    foreach(entry in self.var_fd243db7.var_245ad74) {
      self stats::function_328bc34a(curweapon.statname, entry.shitloc, entry.hitcount);
    }

    self util::function_a0d3d36f();
  }

  if(isDefined(self.totalmatchshots)) {
    self.totalmatchshots++;
  }

  if(isDefined(level.var_b10e134d)) {
    [[level.var_b10e134d]](self, curweapon, #"shots", shotsfired);
    [[level.var_b10e134d]](self, curweapon, #"hits", self.hits);
  }

  if(isDefined(level.var_4e390265)) {
    [[level.var_4e390265]](self, curweapon, shotsfired, self.hits);
  }

  self bb::add_to_stat("shots", shotsfired);
  self bb::add_to_stat("hits", self.hits);

  if(level.mpcustommatch === 1 || is_true(level.var_674e8051)) {
    self.pers[#"shotsfired"]++;
    shotsmissed = self.pers[#"shotsfired"] - self.pers[#"shotshit"];

    if(shotsmissed < 0) {
      shotsmissed = 0;
    }

    self.pers[#"shotsmissed"] = shotsmissed;
  }

  self.hits = 0;
  self.headshothits = 0;

  if(curweapon.issniperweapon) {
    if(isDefined(self.var_88f25284)) {
      self.var_4ea3d30c = 0;
    }

    self.var_88f25284 = 1;
  }

  pixendevent();
}

function function_b1d41bd5(weapon, damagedone) {
  self stats::function_eec52333(weapon, #"damagedone", damagedone, self.class_num);
}

function on_end_game() {
  if(!isPlayer(self)) {
    return;
  }

  if(isbot(self)) {
    return;
  }

  self function_53524d84();
}

function event_handler[grenade_pullback] function_5755a808(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  weapon = eventstruct.weapon;
  self stats::function_eec52333(weapon, #"shots", 1, self.class_num);
  self.hasdonecombat = 1;
  self.throwinggrenade = 1;
  self.gotpullbacknotify = 1;
  self thread watch_offhand_end(weapon);
  self thread begin_grenade_tracking();
}

function event_handler[missile_fire] function_f075cefa(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  missile = eventstruct.projectile;
  weapon = eventstruct.weapon;
  var_72ed30b7 = eventstruct.target;
  self.hasdonecombat = 1;

  if(isDefined(missile) && isDefined(level.missileentities)) {
    if(!isDefined(level.missileentities)) {
      level.missileentities = [];
    }

    level.missileentities[level.missileentities.size] = missile;
    missile.weapon = weapon;
    missile.var_72ed30b7 = var_72ed30b7;
    missile thread watch_missile_death();
  }
}

function watch_missile_death() {
  self waittill(#"death");
  arrayremovevalue(level.missileentities, self);
}

function drop_all_to_ground(origin, radius) {
  weapons = getdroppedweapons();

  for(i = 0; i < weapons.size; i++) {
    if(distancesquared(origin, weapons[i].origin) < radius * radius) {
      trace = bulletTrace(weapons[i].origin, weapons[i].origin + (0, 0, -2000), 0, weapons[i]);
      weapons[i].origin = trace[#"position"];
    }
  }
}

function drop_grenades_to_ground(origin, radius) {
  grenades = getEntArray("grenade", "classname");

  for(i = 0; i < grenades.size; i++) {
    if(distancesquared(origin, grenades[i].origin) < radius * radius) {
      grenades[i] launch((5, 5, 5));
    }
  }
}

function watch_grenade_cancel() {
  self endon(#"death", #"disconnect", #"grenade_fire");
  waittillframeend();

  while(true) {
    if(!isPlayer(self)) {
      return;
    }

    if(self isthrowinggrenade()) {
      self waittill(#"weapon_change", #"hash_391799142463c3d4");
      continue;
    }

    if(self function_55acff10()) {
      util::wait_network_frame();
      continue;
    }

    break;
  }

  self.throwinggrenade = 0;
  self.gotpullbacknotify = 0;
  self notify(#"grenade_throw_cancelled");
}

function watch_offhand_end(weapon) {
  self notify(#"watchoffhandend");
  self endon(#"watchoffhandend");

  if(weapon.drawoffhandmodelinhand) {
    self setoffhandvisible(1);

    while(self function_2d96f300(weapon)) {
      msg = self waittill(#"offhand_end", #"death", #"disconnect", #"grenade_fire", #"weapon_change");

      if(msg._notify == # "grenade_fire") {
        if(isDefined(self) && is_true(weapon.var_d69ee9ed) && self getweaponammoclip(weapon) > 0) {
          continue;
        }

        break;
      }

      if(msg._notify == # "death" || msg._notify == # "disconnect" || msg._notify == # "offhand_end") {
        break;
      }
    }

    if(isDefined(self)) {
      self setoffhandvisible(0);
    }
  }
}

function function_2d96f300(weapon) {
  if(!isDefined(self)) {
    return 0;
  }

  currentweapon = self getcurrentoffhand();

  if(currentweapon == weapon && weapon.drawoffhandmodelinhand) {
    return self function_6577d473();
  }

  return 0;
}

function function_6dafe6d6(grenade, weapon) {
  if(isDefined(weapon) && weapon.name === "eq_hawk") {
    if(isDefined(grenade)) {
      self.throwinggrenade = 0;
      grenade deletedelay();

      if(isDefined(level.hawk_settings.spawn)) {
        self thread[[level.hawk_settings.spawn]]();
      }
    }
  }
}

function begin_grenade_tracking() {
  self notify(#"begin_grenade_tracking");
  self endon(#"begin_grenade_tracking", #"death", #"disconnect", #"grenade_throw_cancelled");
  starttime = gettime();
  self thread watch_grenade_cancel();
  waitresult = self waittill(#"grenade_fire");
  grenade = waitresult.projectile;
  function_6dafe6d6(grenade, waitresult.weapon);

  if(!isDefined(grenade)) {
    return;
  }

  weapon = waitresult.weapon;
  cooktime = waitresult.cook_time;
  grenade.originalowner = self;
  assert(isDefined(grenade));

  if(!isDefined(level.missileentities)) {
    level.missileentities = [];
  }

  level.missileentities[level.missileentities.size] = grenade;
  grenade.weapon = weapon;
  grenade thread watch_missile_death();

  if(is_true(level.projectiles_should_ignore_world_pause)) {
    grenade setignorepauseworld(1);
  }

  if(grenade util::ishacked()) {
    return;
  }

  structname = # "mpequipmentuses";
  eventname = # "hash_7cbbee88c5db5494";

  if(sessionmodeiscampaigngame()) {
    structname = # "cpequipmentuses";
    eventname = # "hash_4b0d58055ad60c5a";
  } else if(sessionmodeiszombiesgame()) {
    structname = # "zmequipmentuses";
    eventname = # "hash_637ce41bcec9842c";
  }

  function_92d1707f(eventname, structname, {
    #gametime: gettime(), #spawnid: getplayerspawnid(self), #weaponname: weapon.name
  });
  cookedtime = gettime() - starttime;

  if(cookedtime > 1000) {
    grenade.iscooked = 1;
  }

  if(isDefined(self.grenadesused)) {
    self.grenadesused++;
  }

  switch (weapon.rootweapon.name) {
    case # "frag_grenade":
      level.globalfraggrenadesfired++;
    case # "sticky_grenade":
      self stats::function_e24eec31(weapon, #"used", 1);
      grenade setteam(self.pers[#"team"]);
      grenade setowner(self);
    case # "explosive_bolt":
      grenade.originalowner = self;
      break;
    case # "satchel_charge":
      level.globalsatchelchargefired++;
      break;
    case # "flash_grenade":
    case # "concussion_grenade":
      self stats::function_e24eec31(weapon, #"used", 1);
      break;
  }

  self.throwinggrenade = 0;

  if(weapon.var_98333ae > 0 && weapon.cookoffholdtime > 0) {
    grenade thread track_cooked_detonation(self, weapon, cooktime);
  } else if(weapon.multidetonation > 0) {
    grenade thread track_multi_detonation(self, weapon, cooktime);
  }

  if(isDefined(level.var_9d47488) && isDefined(level.var_9d47488.script)) {
    self thread[[level.var_9d47488.script]](grenade, weapon);
  }

  self thread begin_grenade_tracking();
}

function event_handler[grenade_fire] function_e2b6d5a5(eventstruct) {
  self callback::callback(#"grenade_fired", eventstruct);

  if(!isPlayer(self)) {
    return;
  }

  grenade = eventstruct.projectile;
  weapon = eventstruct.weapon;
  grenade.var_c6c56953 = grenade.origin;

  if(grenade util::ishacked()) {
    return;
  }

  if(isDefined(level.var_f9b89e94)) {
    grenade thread[[level.var_f9b89e94]]();
  }

  switch (weapon.rootweapon.name) {
    case # "eq_sticky_grenade":
    case # "eq_cluster_semtex_grenade":
      grenade thread check_stuck_to_player(1, 1, weapon);

      if(isDefined(level.var_b61fb563)) {
        grenade thread[[level.var_b61fb563]]();
      }

      break;
    case # "c4":
    case # "satchel_charge":
      grenade thread check_stuck_to_player(1, 0, weapon);
      break;
    case # "hatchet":
      grenade.lastweaponbeforetoss = self function_fe1f5cc();
      grenade thread check_hatchet_bounce();
      grenade thread check_stuck_to_player(0, 0, weapon, 0);
      self stats::function_e24eec31(weapon, #"used", 1);
      break;
    default:
      break;
  }
}

function event_handler[grenade_throwback] function_e32d30(eventstruct) {
  eventstruct.projectile.throwback = 1;
  eventstruct.projectile.previousowner = eventstruct.owner;
}

function event_handler[offhand_fire] function_97023fdf(eventstruct) {
  self callback::callback(#"offhand_fire", eventstruct);
}

function event_handler[grenade_launcher_fire] function_aa7da3a(eventstruct) {
  self callback::callback(#"hash_198a389d6b65f68d", eventstruct);
}

function function_43ec7f33(str_notify) {
  killcament = self.killcament;
  waitframe(1);

  if(isDefined(killcament)) {
    killcament delete();
  }
}

function function_5ed178fd(parentent) {
  parentent endon(#"death", #"stuck_to_player");
  self endon(#"death");
  parentent endoncallback(&function_43ec7f33, #"death", #"stuck_to_player");

  while(true) {
    waitframe(1);
    forward = anglesToForward(parentent.angles);
    pos = parentent.origin - forward * 20;

    if(!validateorigin(pos)) {
      parentent.killcament delete();
      return;
    }

    self.origin = pos;
  }
}

function check_stuck_to_player(deleteonteamchange, awardscoreevent, weapon, var_c49b0e24 = 200) {
  self endon(#"death");

  if(validateorigin(self.origin) && !sessionmodeiscampaigngame()) {
    killcament = spawn("script_model", self.origin);
    killcament.targetname = "killcament_" + weapon.name;
    killcament setweapon(weapon);
    self.killcament = killcament;
    killcament thread function_5ed178fd(self);
  }

  waitresult = self waittill(#"stuck_to_player");
  player = waitresult.player;

  if(isDefined(killcament)) {
    forward = anglesToForward(self.angles);
    pos = self.origin - forward * var_c49b0e24;

    if(isDefined(player)) {
      dir = player.origin - pos;
      dir = vectornormalize(dir);
      killcament.angles = vectortoangles(dir);
    }

    if(validateorigin(pos)) {
      killcament.origin = pos;
    } else {
      killcament delete();
    }
  }

  if(isDefined(player)) {
    if(deleteonteamchange) {
      self thread stuck_to_player_team_change(player);
    }

    if(awardscoreevent && isDefined(self.originalowner)) {
      if(self.originalowner util::isenemyplayer(player)) {
        scoreevents::processscoreevent(#"cluster_semtex_stick", self.originalowner, player, weapon);
        self.originalowner contracts::increment_contract(#"hash_2a588f6e2e49309");

        if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
          self.originalowner stats::function_622feb0d(weapon.name, #"semtex_sticks", 1);
          self.originalowner stats::function_622feb0d(weapon.name, #"hash_14d32aad854916ec", 1);
        }
      }
    }

    self.stucktoplayer = player;
  }
}

function check_hatchet_bounce() {
  self endon(#"stuck_to_player", #"death");
  self waittill(#"grenade_bounce");
  self.bounced = 1;
}

function stuck_to_player_team_change(player) {
  self endon(#"death");
  player endon(#"disconnect");
  originalteam = player.pers[#"team"];

  while(true) {
    player waittill(#"joined_team");

    if(player.pers[#"team"] != originalteam) {
      self detonate();
      return;
    }
  }
}

function wait_and_delete_dud(waittime) {
  self endon(#"death");
  wait waittime;

  if(isDefined(self)) {
    self delete();
  }
}

function gettimefromlevelstart() {
  if(!isDefined(level.starttime)) {
    return 0;
  }

  return gettime() - level.starttime;
}

function turn_grenade_into_a_dud(weapon, isthrowngrenade, player) {
  if(currentsessionmode() == 2) {
    return;
  }

  time = float(gettimefromlevelstart()) / 1000;

  if(level.roundstartexplosivedelay >= time) {
    if(weapon.disallowatmatchstart) {
      timeleft = int(level.roundstartexplosivedelay - time);

      if(!timeleft) {
        timeleft = 1;
      }

      if(isthrowngrenade) {
        player iprintlnbold(#"hash_10012bedb9f60e99", " " + timeleft + " ", #"hash_79a58948c3b976f5");
      } else {
        player iprintlnbold(#"hash_255050263c8cd26d", " " + timeleft + " ", #"hash_79a58948c3b976f5");
      }

      self makegrenadedud();
    }
  }
}

function function_c135199b(params) {
  grenade = params.projectile;
  weapon = params.weapon;
  grenade turn_grenade_into_a_dud(weapon, 1, self);
}

function on_grenade_fired(params) {
  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self stats::function_622feb0d(params.weapon.name, #"uses", 1);
  }

  function_c135199b(params);
}

function function_4b7977fe(params) {
  grenade = params.projectile;
  weapon = params.weapon;
  grenade turn_grenade_into_a_dud(weapon, 0, self);
  assert(isDefined(grenade));

  if(!isDefined(level.missileentities)) {
    level.missileentities = [];
  }

  level.missileentities[level.missileentities.size] = grenade;
  grenade.weapon = weapon;
  grenade thread watch_missile_death();
}

function get_damageable_ents(pos, radius, dolos, startradius) {
  ents = [];

  if(!isDefined(dolos)) {
    dolos = 0;
  }

  if(!isDefined(startradius)) {
    startradius = 0;
  }

  players = level.players;

  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing") {
      continue;
    }

    playerpos = players[i].origin + (0, 0, 32);
    distsq = distancesquared(pos, playerpos);

    if(distsq < radius * radius && (!dolos || damage_trace_passed(pos, playerpos, startradius, undefined))) {
      newent = spawnStruct();
      newent.isplayer = 1;
      newent.isadestructable = 0;
      newent.isadestructible = 0;
      newent.isactor = 0;
      newent.entity = players[i];
      newent.damagecenter = playerpos;
      ents[ents.size] = newent;
    }
  }

  grenades = getEntArray("grenade", "classname");

  for(i = 0; i < grenades.size; i++) {
    entpos = grenades[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || damage_trace_passed(pos, entpos, startradius, grenades[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.isadestructible = 0;
      newent.isactor = 0;
      newent.entity = grenades[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  destructibles = getEntArray("destructible", "targetname");

  for(i = 0; i < destructibles.size; i++) {
    entpos = destructibles[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || damage_trace_passed(pos, entpos, startradius, destructibles[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.isadestructible = 1;
      newent.isactor = 0;
      newent.entity = destructibles[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  destructables = getEntArray("destructable", "targetname");

  for(i = 0; i < destructables.size; i++) {
    entpos = destructables[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || damage_trace_passed(pos, entpos, startradius, destructables[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 1;
      newent.isadestructible = 0;
      newent.isactor = 0;
      newent.entity = destructables[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  return ents;
}

function damage_trace_passed(from, to, startradius, ignore) {
  trace = damage_trace(from, to, startradius, ignore);
  return trace[#"fraction"] == 1;
}

function damage_trace(from, to, startradius, ignore) {
  midpos = undefined;
  diff = to - from;

  if(lengthsquared(diff) < startradius * startradius) {
    midpos = to;
  }

  dir = vectornormalize(diff);
  midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
  trace = bulletTrace(midpos, to, 0, ignore);

  if(getdvarint(#"scr_damage_debug", 0) != 0) {
    if(trace[#"fraction"] == 1) {
      thread debug::drawdebugline(midpos, to, (1, 1, 1), 600);
    } else {
      thread debug::drawdebugline(midpos, trace[#"position"], (1, 0.9, 0.8), 600);
      thread debug::drawdebugline(trace[#"position"], to, (1, 0.4, 0.3), 600);
    }
  }

  return trace;
}

function damage_ent(einflictor, eattacker, idamage, smeansofdeath, weapon, damagepos, damagedir) {
  if(self.isplayer) {
    self.damageorigin = damagepos;
    self.entity thread[[level.callbackplayerdamage]](einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, undefined);
    return;
  }

  if(self.isactor) {
    self.damageorigin = damagepos;
    self.entity thread[[level.callbackactordamage]](einflictor, eattacker, idamage, 0, smeansofdeath, weapon, damagepos, damagedir, "none", damagepos, 0, 0, 0, 0, (1, 0, 0));
    return;
  }

  if(self.isadestructible) {
    self.damageorigin = damagepos;
    self.entity dodamage(idamage, damagepos, eattacker, einflictor, 0, smeansofdeath, 0, weapon);
    return;
  }

  self.entity util::damage_notify_wrapper(idamage, eattacker, (0, 0, 0), (0, 0, 0), "mod_explosive", "", "");
}

function on_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
  self endon(#"death", #"disconnect");

  if(isDefined(level._custom_weapon_damage_func)) {
    is_weapon_registered = self[[level._custom_weapon_damage_func]](eattacker, einflictor, weapon, meansofdeath, damage);

    if(is_weapon_registered) {
      return;
    }
  }

  switch (weapon.statname) {
    case # "eq_slow_grenade":
    case # "concussion_grenade":
      self.lastconcussedby = eattacker;
      break;
    default:
      if(isDefined(level.shellshockonplayerdamage) && isPlayer(self)) {
        [[level.shellshockonplayerdamage]](eattacker, einflictor, weapon, meansofdeath, damage);
      }

      break;
  }
}

function play_concussion_sound(duration) {
  self endon(#"death", #"disconnect");
  concussionsound = spawn("script_origin", (0, 0, 1));
  concussionsound.origin = self.origin;
  concussionsound linkto(self);
  concussionsound thread delete_ent_on_owner_death(self);
  concussionsound playSound(#"");
  concussionsound playLoopSound(#"");

  if(duration > 0.5) {
    wait duration - 0.5;
  }

  concussionsound playSound(#"");
  concussionsound stoploopsound(0.5);
  wait 0.5;
  concussionsound notify(#"delete");
  concussionsound delete();
}

function delete_ent_on_owner_death(owner) {
  self endon(#"delete");
  owner waittill(#"death");
  self delete();
}

function function_1e2ad832(weapon) {
  player = self;

  if(!isDefined(player.var_9c4683a0)) {
    player.var_9c4683a0 = [];
  }

  array::add(player.var_9c4683a0, weapon);
  force_stowed_weapon_update();
}

function function_8f148257(weapon) {
  player = self;

  if(!isDefined(player.var_9c4683a0)) {
    return;
  }

  foundindex = undefined;

  for(index = 0; index < player.var_9c4683a0.size; index++) {
    if(player.var_9c4683a0[index] == weapon) {
      foundindex = index;
    }
  }

  if(!isDefined(foundindex)) {
    return;
  }

  player.var_9c4683a0 = array::remove_index(player.var_9c4683a0, foundindex);
  force_stowed_weapon_update();
}

function on_weapon_change(params) {
  if(level.trackweaponstats) {
    if(!isDefined(self.var_e09dd2bf)) {
      self.var_e09dd2bf = gettime();
    }

    if(params.last_weapon != level.weaponnone) {
      self bb::commit_weapon_data(getplayerspawnid(self), params.last_weapon, self.var_e09dd2bf);
    }

    if(params.weapon != level.weaponnone && params.weapon != params.last_weapon) {
      self.var_e09dd2bf = gettime();
      update_last_held_weapon_timings(self.var_e09dd2bf, params.last_weapon);
      self loadout::initweaponattachments(params.weapon);
    }
  }

  team = self.pers[#"team"];
  playerclass = self.pers[#"class"];

  if(self ismantling()) {
    return;
  }

  currentstowed = self getstowedweapon();
  hasstowed = 0;
  self.weapon_array_primary = [];
  self.weapon_array_sidearm = [];
  self.weapon_array_grenade = [];
  self.weapon_array_inventory = [];
  weaponslist = self getweaponslist();

  for(idx = 0; idx < weaponslist.size; idx++) {
    switch (weaponslist[idx].name) {
      case # "m32":
      case # "minigun":
        continue;
      default:
        break;
    }

    if(!hasstowed || currentstowed == weaponslist[idx]) {
      currentstowed = weaponslist[idx];
      hasstowed = 1;
    }

    if(is_primary_weapon(weaponslist[idx])) {
      self.weapon_array_primary[self.weapon_array_primary.size] = weaponslist[idx];
      continue;
    }

    if(is_side_arm(weaponslist[idx])) {
      self.weapon_array_sidearm[self.weapon_array_sidearm.size] = weaponslist[idx];
      continue;
    }

    if(is_grenade(weaponslist[idx])) {
      self.weapon_array_grenade[self.weapon_array_grenade.size] = weaponslist[idx];
      continue;
    }

    if(is_inventory(weaponslist[idx])) {
      self.weapon_array_inventory[self.weapon_array_inventory.size] = weaponslist[idx];
      continue;
    }

    if(weaponslist[idx].isprimary) {
      self.weapon_array_primary[self.weapon_array_primary.size] = weaponslist[idx];
    }
  }

  if(params.weapon != level.weaponnone || !hasstowed) {
    detach_all_weapons();
    stow_on_back();
    stow_on_hip();
  }
}

function loadout_get_offhand_count(stat) {
  count = 0;

  if(isDefined(level.givecustomloadout)) {
    return 0;
  }

  assert(isDefined(self.class_num));

  if(isDefined(self.class_num)) {
    count = self loadout::getloadoutitemfromddlstats(self.class_num, stat);
  }

  return count;
}

function scavenger_think() {
  self endon(#"death");
  waitresult = self waittill(#"scavenger");
  player = waitresult.player;
  primary_weapons = player getweaponslistprimaries();

  if(is_true(level.var_d98576f2)) {
    offhand_weapons_and_alts = array::exclude(player getweaponslist(1), primary_weapons);
    arrayremovevalue(offhand_weapons_and_alts, level.weaponbasemelee);
    offhand_weapons_and_alts = array::reverse(offhand_weapons_and_alts);
    player.scavenged = 0;

    for(i = 0; i < offhand_weapons_and_alts.size; i++) {
      weapon = offhand_weapons_and_alts[i];

      if(!weapon.isscavengable || killstreaks::is_killstreak_weapon(weapon)) {
        continue;
      }

      maxammo = 0;
      loadout = player loadout::find_loadout_slot(weapon);

      if(isDefined(loadout)) {
        if(loadout.count > 0) {
          maxammo = loadout.count;
        } else if(weapon.isheavyweapon && is_true(level.overrideammodropheavyweapon)) {
          maxammo = weapon.maxammo;
        }
      } else if(isDefined(player.grenadetypeprimary) && weapon == player.grenadetypeprimary && isDefined(player.grenadetypeprimarycount) && player.grenadetypeprimarycount > 0) {
        maxammo = player.grenadetypeprimarycount;
      } else if(isDefined(player.grenadetypesecondary) && weapon == player.grenadetypesecondary && isDefined(player.grenadetypesecondarycount) && player.grenadetypesecondarycount > 0) {
        maxammo = player.grenadetypesecondarycount;
      }

      if(isDefined(level.customloasdoutscavenge)) {
        maxammo = self[[level.customloadoutscavenge]](weapon);
      }

      if(maxammo == 0) {
        continue;
      }

      if(weapon.rootweapon == level.weaponsatchelcharge) {
        if(player weaponobjects::anyobjectsinworld(weapon.rootweapon)) {
          continue;
        }
      }

      stock = player getweaponammostock(weapon);

      if(stock < maxammo) {
        ammo = stock + 2;

        if(ammo > maxammo) {
          ammo = maxammo;
        }

        player setweaponammostock(weapon, ammo);
        player.scavenged = 1;
        player thread challenges::scavengedgrenade(weapon);
      }
    }
  }

  for(i = 0; i < primary_weapons.size; i++) {
    weapon = primary_weapons[i];

    if(!weapon.isscavengable || killstreaks::is_killstreak_weapon(weapon)) {
      continue;
    }

    stock = player getweaponammostock(weapon);
    start = player getfractionstartammo(weapon);
    clip = weapon.clipsize;
    clip *= getdvarfloat(#"scavenger_clip_multiplier", 2);
    clip = int(clip);
    maxammo = weapon.maxammo;

    if(stock < maxammo - clip) {
      ammo = stock + clip;
      player setweaponammostock(weapon, ammo);
      player.scavenged = 1;
      continue;
    }

    player setweaponammostock(weapon, maxammo);
    player.scavenged = 1;
  }

  if(player.scavenged) {
    player playSound(#"wpn_ammo_pickup");
    player playlocalsound(#"wpn_ammo_pickup");
    player hud::function_4a4de0de();
    player contracts::increment_contract(#"hash_58af19ef8022b83c");
    player stats::function_dad108fa(#"hash_2f86e77179c4ba91", 1);
    player stats::function_dad108fa(#"hash_4cf0323c7ecb3711", 1);
    player stats::function_dad108fa(#"hash_1464eb72733fe9f8", 1);
    player stats::function_dad108fa(#"hash_1464f272733ff5dd", 1);
    player stats::function_dad108fa(#"hash_1464f172733ff42a", 1);
    player stats::function_dad108fa(#"hash_1464f072733ff277", 1);
  }
}

function drop_scavenger_for_death(attacker) {
  if(is_true(level.var_827f5a28)) {
    return;
  }

  if(!isDefined(attacker)) {
    return;
  }

  if(attacker == self) {
    return;
  }

  if(level.gametype == "hack") {
    item = self dropscavengeritem(getweapon(#"scavenger_item_hack"));
  } else if(isPlayer(attacker)) {
    item = self dropscavengeritem(getweapon(#"scavenger_item"));
  } else {
    return;
  }

  if(is_true(level.var_8c5a071d)) {
    if(isDefined(self.var_e602a1ca)) {
      self.var_e602a1ca delete();
    }

    self.var_e602a1ca = item;
  }

  item thread scavenger_think();
}

function add_limited_weapon(weapon, owner, num_drops) {
  limited_info = spawnStruct();
  limited_info.weapon = weapon;
  limited_info.drops = num_drops;
  owner.limited_info = limited_info;
}

function should_drop_limited_weapon(weapon, owner) {
  limited_info = owner.limited_info;

  if(!isDefined(limited_info)) {
    return true;
  }

  if(limited_info.weapon != weapon) {
    return true;
  }

  if(limited_info.drops <= 0) {
    return false;
  }

  return true;
}

function drop_limited_weapon(weapon, owner, item) {
  limited_info = owner.limited_info;

  if(!isDefined(limited_info)) {
    return;
  }

  if(limited_info.weapon != weapon) {
    return;
  }

  limited_info.drops -= 1;
  owner.limited_info = undefined;
  item thread limited_pickup(limited_info);
}

function limited_pickup(limited_info) {
  self endon(#"death");
  waitresult = self waittill(#"trigger");

  if(!isDefined(waitresult.dropped_item)) {
    return;
  }

  waitresult.activator.limited_info = limited_info;
}

function track_cooked_detonation(attacker, weapon, cooktime) {
  self endon(#"trophy_destroyed");
  wait float(weapon.fusetime) / 1000;

  if(!isDefined(self)) {
    return;
  }

  self thread ninebang_doninebang(attacker, weapon, cooktime);
}

function ninebang_doninebang(attacker, weapon, cooktime) {
  level endon(#"game_ended");
  maxstages = weapon.var_98333ae;
  cookstages = min(floor(cooktime / weapon.cookoffholdtime * maxstages), maxstages);
  intervaltime = float(weapon.var_1c0e3cb7) / 1000;
  var_9729fdb9 = float(weapon.var_4941de5) / 1000;
  cookstages *= 3;

  if(!cookstages) {
    cookstages = 3;
  }

  wait float(weapon.fusetime) / 1000;

  for(i = 0; i < cookstages; i++) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(attacker)) {
      break;
    }

    attacker magicgrenadeplayer(weapon.grenadeweapon, self.origin, (0, 0, 0));

    if((i + 1) % 3 == 0) {
      wait var_9729fdb9;
      continue;
    }

    wait intervaltime;
  }

  if(isDefined(self)) {
    self delete();
  }
}

function track_multi_detonation(ownerent, weapon, cooktime) {
  self endon(#"trophy_destroyed");
  waitresult = self waittill(#"explode", #"death");

  if(waitresult._notify == "death") {
    return;
  }

  for(i = 0; i < cooktime.multidetonation; i++) {
    if(!isDefined(weapon)) {
      return;
    }

    dir = level multi_detonation_get_cluster_launch_dir(cooktime, i, cooktime.multidetonation, waitresult.normal);
    fusetime = randomfloatrange(cooktime.var_cb3d0f65, cooktime.var_cd539cb2);
    speed = randomintrangeinclusive(cooktime.var_95d8fabf, cooktime.var_c264efc6);
    vel = dir * speed;
    var_561c6e7c = waitresult.position + dir * 5;

    if(cooktime === getweapon(#"hash_117b6097e272dd1f")) {
      var_d097c411 = getweapon(#"cymbal_monkey");
      grenade = weapon magicgrenadetype(var_d097c411, var_561c6e7c, vel, fusetime);
      grenade util::deleteaftertime(180);
    } else {
      var_d097c411 = cooktime.grenadeweapon;
      grenade = weapon magicgrenadetype(var_d097c411, var_561c6e7c, vel, fusetime);
    }

    util::wait_network_frame();
  }
}

function multi_detonation_get_cluster_launch_dir(weapon, index, multival, normal) {
  pitch = randomfloatrange(weapon.var_367c47fc, weapon.var_7872b3a);
  var_a978e158 = randomfloatrange(weapon.var_ccebc40 * -1, weapon.var_ccebc40);
  yaw = -180 + 360 / multival * index + var_a978e158;
  angles = (pitch * -1, yaw, 0);
  dir = anglesToForward(angles);
  c = vectorcross(normal, dir);
  f = vectorcross(c, normal);
  theta = 90 - pitch;
  dir = normal * cos(theta) + f * sin(theta);
  dir = vectornormalize(dir);
  return dir;
}

function event_handler[grenade_stuck] function_5c5941ef(eventstruct) {
  grenade = eventstruct.projectile;

  if(!isDefined(grenade)) {
    return;
  }

  if(!isDefined(self.stuck_items)) {
    self.stuck_items = [];
  }

  arrayremovevalue(self.stuck_items, undefined);
  array::add(self.stuck_items, grenade);
}

function function_356292be(owner, origin, radius) {
  owner_team = isDefined(owner) ? owner.team : undefined;

  if(level.teambased && isDefined(owner_team) && level.friendlyfire == 0) {
    potential_targets = [];
    potential_targets = arraycombine(potential_targets, function_dbb62de0(owner_team, origin, radius), 0, 0);
    potential_targets = arraycombine(potential_targets, function_fd768835(owner_team, origin, radius), 0, 0);
    potential_targets = arraycombine(potential_targets, function_5db5c32(owner_team, origin, radius), 0, 0);

    if(isDefined(radius) && radius > 0) {
      nearby_targets = [];

      foreach(target in potential_targets) {
        if(distancesquared(target.origin, origin) <= sqr(radius)) {
          if(!isDefined(nearby_targets)) {
            nearby_targets = [];
          } else if(!isarray(nearby_targets)) {
            nearby_targets = array(nearby_targets);
          }

          if(!isinarray(nearby_targets, target)) {
            nearby_targets[nearby_targets.size] = target;
          }
        }
      }

      potential_targets = nearby_targets;
    }

    if(isDefined(level.missileentities) && level.missileentities.size > 0 && isPlayer(owner)) {
      var_f1fe3f3c = owner getentitiesinrange(level.missileentities, int(radius), origin);
      potential_targets = arraycombine(potential_targets, var_f1fe3f3c, 0, 0);
    }

    return potential_targets;
  }

  all_targets = [];
  all_targets = arraycombine(all_targets, function_8c285f35(origin, radius), 0, 0);
  all_targets = arraycombine(all_targets, function_a38db454(origin, radius), 0, 0);

  if(level.friendlyfire > 0) {
    return all_targets;
  }

  potential_targets = [];

  foreach(target in all_targets) {
    if(!isDefined(target)) {
      continue;
    }

    if(!isDefined(target.team)) {
      continue;
    }

    if(isDefined(owner)) {
      if(target != owner) {
        if(!isDefined(owner_team)) {
          continue;
        }

        if(!util::function_fbce7263(target.team, owner_team)) {
          continue;
        }
      }
    } else {
      if(!isDefined(self)) {
        continue;
      }

      if(!isDefined(self.team)) {
        continue;
      }

      if(!util::function_fbce7263(target.team, self.team)) {
        continue;
      }
    }

    potential_targets[potential_targets.size] = target;
  }

  return potential_targets;
}

function function_830e007d() {
  for(i = 0; i < level.missileentities.size; i++) {
    item = level.missileentities[i];

    if(!isDefined(item)) {
      continue;
    }

    if(!isDefined(item.weapon)) {
      continue;
    }

    if(item.owner !== self && item.originalowner !== self) {
      continue;
    }

    item notify(#"detonating");

    if(isDefined(item)) {
      item delete();
    }
  }
}

function dropweaponfordeathlaunch(item, damage, angles, weapon, var_a5baf64e, var_6f02cffb, smeansofdeath) {
  if(!isDefined(item)) {
    println("<dev string:x1a3>");
    return;
  }

  if(!isDefined(item.model) || item.model == # "") {
    println("<dev string:x1dc>" + weapon.name);
    return;
  }

  if(!item hasdobj()) {
    println("<dev string:x212>" + weapon.name);
    return;
  }

  if(smeansofdeath === "MOD_EXECUTION") {
    return;
  }

  if(!isDefined(damage)) {
    damage = 0;
  }

  normalizeddamage = math::normalize_value(0, 200, damage);
  var_92043f3a = math::factor_value(250 * var_6f02cffb, 320 * var_6f02cffb, normalizeddamage);
  var_9e5cfd66 = randomfloatrange(40 * var_a5baf64e, 80 * var_a5baf64e);
  var_19a39012 = randomfloatrange(40 * var_a5baf64e, 80 * var_a5baf64e);

  if(math::cointoss()) {
    var_19a39012 *= -1;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  launchvelocity = (0, 0, 0);
  launchvelocity += anglesToForward(angles) * var_9e5cfd66;
  launchvelocity += anglestoright(angles) * var_19a39012;
  launchvelocity += anglestoup(angles) * var_92043f3a;
  var_f45e7999 = randomfloatrange(100, 150);

  if(math::cointoss()) {
    var_f45e7999 *= -1;
  }

  var_af228248 = randomfloatrange(100, 150);

  if(math::cointoss()) {
    var_af228248 *= -1;
  }

  var_46dcaa45 = randomfloatrange(250, 350);

  if(math::cointoss()) {
    var_46dcaa45 *= -1;
  }

  var_342f4a88 = (var_f45e7999, var_af228248, var_46dcaa45);
  item function_1e25084(launchvelocity, var_342f4a88);
}
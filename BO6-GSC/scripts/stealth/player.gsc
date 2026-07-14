/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\player.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace player;

function main() {
  if(isDefined(self.stealth)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x9b\xc5\xffIc\xd7\xc8\x1cE\xd4G*\x9c\x8b\xba\x82");
  self.stealth = spawnStruct();
  utility::group_flag_init("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
  utility::ent_flag_init("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  function_d08bc3b308232c9d("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  utility::ent_flag_init("v8\xde\xcb\x1a\x8b>w\xac\xf2sJ\xfd_\xf3\xe4\x8f");
  utility::ent_flag_init("\x92D\xa5\xc8\xe0\xab\xc5\x8f\xa55\xfd\xb2\xca\xf3Oy\xa1\xd2\xe5d\xfc\x8bm\xbc\xd6");
  utility::ent_flag_init("L\x04\xbe\x19\xba\xcdgu\xea\x93(\xe7\xac\x11\x85\xec\xb2\x06\xe3\xfa}B\xac&\xcc\x0e\r\xc5Lw\x1c\x89\xcbA");
  utility::group_add();

  if(utility::issp()) {
    thread stealthhints_thread();

    if(isDefined(level.stealth.fnsixthsense)) {
      [[level.stealth.fnsixthsense]]();
    }
  } else {
    thread stealth_manager::player_grenade_check();

    if(isDefined(level.var_3ff01407b806d257)) {
      self thread[[level.var_3ff01407b806d257]]();
    }
  }

  childthread debug::debug_player();
}

function function_d08bc3b308232c9d(message) {
  function_aa53df4e555ff8d2(self, message, 1);
  utility::ent_flag_set(message);
}

function function_c174a04e30f56398(message) {
  function_aa53df4e555ff8d2(self, message, 0);
  utility::ent_flag_clear(message);
}

function combatstate_thread(enabled) {
  if(!isDefined(enabled)) {
    enabled = 1;
  }

  if(!enabled) {
    self notify("\xaa\xd9\x1eV5\xaal\x1d\xb3j\xf2\xa2\x953]\xfc:\xb0\x85L\xa0\xca\xb1\xaf-r(\x19\x91\t%");
    self.stealth.combatstate = undefined;
    return;
  } else if(isDefined(self.stealth.combatstate)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x9b\xc5\xffIc\xd7\xc8\x1cE\xd4G*\x9c\x8b\xba\x82");
  self endon("\xaa\xd9\x1eV5\xaal\x1d\xb3j\xf2\xa2\x953]\xfc:\xb0\x85L\xa0\xca\xb1\xaf-r(\x19\x91\t%");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  childthread playerattackedmonitor();
  childthread combatstate_updatethread();
  self.stealth.combatstate = spawnStruct();
  self.stealth.combatstate.name = "\x12\xc2\xc8\x9d-\x1d\x9b";
  self.stealth.combatstate.type = "\x91\x88\xc2*";
  self.stealth.combatstate.updatefuncs = [];
  oldcombatenemies = [];
  oldhuntenemies = [];

  while(true) {
    utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    oldcombatenemies = utility::array_removeundefined(oldcombatenemies);
    oldcombatenemies = utility::array_removedead(oldcombatenemies);
    oldhuntenemies = utility::array_removeundefined(oldhuntenemies);
    oldhuntenemies = utility::array_removedead(oldhuntenemies);
    combatenemies = [];
    huntenemies = [];
    var_27c77118cae6435a = 0;

    if(isDefined(self.lastattackedtime) && !utility::time_has_passed(self.lastattackedtime, 10)) {
      var_27c77118cae6435a = 1;
    }

    investigating = 0;

    foreach(enemy in getaiarray("?\xb1\xc0\x9a")) {
      if(!isalive(enemy)) {
        continue;
      }

      if(!arraycontains(oldcombatenemies, enemy)) {
        if(enemy utility::doinglongdeath()) {
          continue;
        }

        if(enemy.script == "\x80\xb5\xc7J") {
          continue;
        }
      }

      if(enemy[[enemy.fnisinstealthcombat]]()) {
        if(isDefined(self.stealth.combatstate.maxcombatdist)) {
          dist = self.stealth.combatstate.maxcombatdist;

          if(distancesquared(self.origin, enemy.origin) > squared(dist)) {
            huntenemies[huntenemies.size] = enemy;
            continue;
          }
        }

        combatenemies[combatenemies.size] = enemy;

        if(var_27c77118cae6435a) {
          continue;
        }

        if(enemy.enemy != self) {
          continue;
        }

        if(enemy cansee(self)) {
          var_27c77118cae6435a = 1;
        }
      } else if(enemy[[enemy.fnisinstealthhunt]]()) {
        huntenemies[huntenemies.size] = enemy;
      }

      if(enemy[[enemy.fnisinstealthinvestigate]]()) {
        investigating = 1;
      }
    }

    lastname = self.stealth.combatstate.name;
    lasttype = self.stealth.combatstate.type;
    name = lastname;
    type = undefined;

    if(name == "\x12\xc2\xc8\x9d-\x1d\x9b" && investigating) {
      type = "\xc2\x99.K\xdd\x9fBw>]\x8e";
    }

    if(lastname == "\xe3\xd0\xc3e\x85h") {
      if(combatenemies.size == 0) {
        name = "\x12\xc2\xc8\x9d-\x1d\x9b";

        if(utility::array_intersection(oldcombatenemies, huntenemies).size > 0) {
          type = "\x11t\x12\x1a";
        } else if(huntenemies.size == 0) {
          type = "-\xbcI\x10\xd3\xc1\xd6<\x1a";
        } else {
          type = "\xf6\x18\x10\x063]\xf0\x85\xfd\x84\xff[";
        }
      } else if(lasttype == "\xff\xdb\xba\xa7\xd5\x8d\xe1" && var_27c77118cae6435a) {
        type = "\xcf\x93\xd7,U";
      }
    } else if(combatenemies.size > 0) {
      name = "\xe3\xd0\xc3e\x85h";

      if(var_27c77118cae6435a) {
        type = "\xcf\x93\xd7,U";
      } else {
        type = "\xff\xdb\xba\xa7\xd5\x8d\xe1";
      }
    } else if(lasttype == "\x11t\x12\x1a" && huntenemies.size == 0) {
      type = "-\xbcI\x10\xd3\xc1\xd6<\x1a";
    }

    if(name == "\x12\xc2\xc8\x9d-\x1d\x9b" && !isDefined(type) && lasttype == "\xc2\x99.K\xdd\x9fBw>]\x8e") {
      type = "\x91\x88\xc2*";
    }

    if(name != lastname || isDefined(type) && type != lasttype) {
      self.stealth.combatstate.name = name;
      self.stealth.combatstate.type = type;
      self notify("\x058\xa7\xf6\xa4\xef\x84Q\x81\r\xab\x94\xc6\x9fD\x15IH\xb7l\xa4\xe3)y\x8d\xed\xbf", name, type);
    }

    oldcombatenemies = combatenemies;
    oldhuntenemies = huntenemies;
    waitframe();
  }
}

function combatstate_updatethread() {
  while(true) {
    self waittill("\x058\xa7\xf6\xa4\xef\x84Q\x81\r\xab\x94\xc6\x9fD\x15IH\xb7l\xa4\xe3)y\x8d\xed\xbf", name, type);

    foreach(func in self.stealth.combatstate.updatefuncs) {
      self thread[[func]](name, type);
    }
  }
}

function combatstate_addupdatefunc(key, func) {
  assert(isPlayer(self));
  assert(isDefined(self.stealth));
  assert(isDefined(self.stealth.combatstate));
  assert(isDefined(key), "<dev string:x24>");
  assert(!utility::array_contains_key(self.stealth.combatstate.updatefuncs, key), "<dev string:x51>" + key + "<dev string:x75>");
  self.stealth.combatstate.updatefuncs[key] = func;
}

function combatstate_removeupdatefunc(key) {
  assert(isPlayer(self));
  assert(isDefined(self.stealth));
  assert(isDefined(self.stealth.combatstate));
  assert(isDefined(key), "<dev string:x24>");
  assert(utility::array_contains_key(self.stealth.combatstate.updatefuncs, key), "<dev string:x51>" + key + "<dev string:x89>");
  self.stealth.combatstate.updatefuncs = utility::array_remove_key(self.stealth.combatstate.updatefuncs, key);
}

function playerattackedmonitor() {
  while(true) {
    level utility::waittill_any("\xd0\xd6H\xe4t\x06_\x9b\x998\xb3u\xb5", "+\xdce\xd6\x97\xd7\xb3\xc9\xb2n\x85\xc8V\xbe\xcc\x96r+");
    self.lastattackedtime = gettime();
  }
}

function function_c5efec7ebf2d47c5(var_a96188df8be1eb3f) {
  if(isDefined(level.var_f2adcd6d25078d35)) {
    return level.var_f2adcd6d25078d35[var_a96188df8be1eb3f];
  }

  return -1;
}

function stealthhints_thread() {
  self endon("\x9b\xc5\xffIc\xd7\xc8\x1cE\xd4G*\x9c\x8b\xba\x82");
  self.stealth.hints = spawnStruct();
  self.stealth.hints.causeofdeath = undefined;
  self.stealth.hints.investigators = [];
  self.stealth.hints.deathhints["\x82\xe4/D\x10Z\x7f\x11\x031\x94:\xddY>"] = function_c5efec7ebf2d47c5(%"hash_4440006f6dd71854");
  self.stealth.hints.deathhints["\x10\xf9\xb6@\xddN\xeb\xe3\x17\xb5\x9dK\xe7\x88\xa7\x93\x12@"] = function_c5efec7ebf2d47c5(%"hash_6edba37d6ef71d47");
  self.stealth.hints.deathhints["\xa0\x81\xa4\xcf\x955\xea\xe2\r\xb1\xfb\x8b\xe5\x1db"] = function_c5efec7ebf2d47c5(%"hash_60c0af92f2c2f9cb");
  self.stealth.hints.deathhints["\xcdZ;h\x1d\xebsG\vndZ\x9b\xb3"] = function_c5efec7ebf2d47c5(%"hash_4e3b484fc8be701a");
  self.stealth.hints.deathhints["\xa3^6\xd74#\xbd"] = function_c5efec7ebf2d47c5(%"hash_1747bc9a7c8035f6");
  self.stealth.hints.deathhints["]\xa0\xfb\x14$N\xda\xdb\x06\x0e\x1a\x99\x01"] = function_c5efec7ebf2d47c5(%"hash_2407b15141d19bb0");
  childthread stealthhints_eventmonitor();
  childthread stealthhints_deathmonitor();
  childthread stealthhints_combatmonitor();
}

function stealthhints_eventmonitor() {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(isalive(self)) {
    utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    level waittill("\xdc\xe8+,\x8d\xa3\x1a_\xb2\xece\xdc:", event, receiver);

    if(!isalive(receiver)) {
      continue;
    }

    if(event.entity != level.player) {
      continue;
    }

    if(!utility::ent_flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
      self.stealth.hints.causeofdeath = undefined;
      self.stealth.hints.investigators = [];
      continue;
    }

    if(utility::any_groups_in_combat()) {
      if(event.type != "\xe3\xd0\xc3e\x85h") {
        continue;
      }

      var_68ceee8da69dc82c = 0;

      foreach(guy in getaiarray(receiver.team)) {
        if(guy == receiver) {
          continue;
        }

        if(guy[[guy.fnisinstealthcombat]]()) {
          var_68ceee8da69dc82c = 1;
          break;
        }
      }

      if(var_68ceee8da69dc82c) {
        continue;
      }
    }

    eventtype = event.typeorig;

    if(eventtype == "\xa3^6\xd74#\xbd" && istrue(level.hassuppressedweapons)) {
      eventtype = "\x10\xf9\xb6@\xddN\xeb\xe3\x17\xb5\x9dK\xe7\x88\xa7\x93\x12@";
    } else if((eventtype == "\xc7@\xe1xS" || eventtype == "\x11G\x10\x1c\xd36\b\xd4\xe2") && self issprinting()) {
      eventtype = "\x82\xe4/D\x10Z\x7f\x11\x031\x94:\xddY>";
    } else if(eventtype == "\x11G\x10\x1c\xd36\b\xd4\xe2" && length2dsquared(level.player getvelocity()) > 11025) {
      eventtype = "\xa0\x81\xa4\xcf\x955\xea\xe2\r\xb1\xfb\x8b\xe5\x1db";
    } else if(eventtype == "\xc7@\xe1xS" && self getstance() == "\x8b\x90\xb5\xc4W") {
      eventtype = "\xcdZ;h\x1d\xebsG\vndZ\x9b\xb3";
    }

    if(!isDefined(self.stealth.hints.deathhints[eventtype])) {
      continue;
    }

    if(arraycontains(self.stealth.hints.investigators, receiver)) {
      continue;
    }

    childthread stealthhints_aimonitor(receiver, eventtype);
  }
}

function stealthhints_aimonitor(ai, eventtype) {
  self endon("X\xf8\xb0/\x1a\x12g\a9P.9\xef\xf8");
  self endon("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  self.stealth.hints.investigators[self.stealth.hints.investigators.size] = ai;

  if(ai[[ai.fnisinstealthhunt]]()) {
    ai utility::delaythread(10, &utility::send_notify, "aYZ\xbc\x18\xe1K\xed}O\xc1\xe1]xsvb\x1fZ\x04");
    ai utility::waittill_any("'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ", "\x1e\xfd\xd1\xa2\a", "aYZ\xbc\x18\xe1K\xed}O\xc1\xe1]xsvb\x1fZ\x04");
  } else if(ai[[ai.fnisinstealthinvestigate]]()) {
    ai utility::waittill_any(";P\x94\xd8z\x14\x82\xa4U\x82H\xce", "'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ", "\x1e\xfd\xd1\xa2\a");
  }

  self.stealth.hints.investigators = arrayremove(self.stealth.hints.investigators, ai);

  if(!isalive(ai) || !ai[[ai.fnisinstealthcombat]]()) {
    return;
  }

  self.stealth.hints.causeofdeath = eventtype;
  self.stealth.hints.investigators = [];
  self notify("X\xf8\xb0/\x1a\x12g\a9P.9\xef\xf8");
}

function stealthhints_deathmonitor() {
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(!utility::ent_flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
    return;
  }

  if(isDefined(level.custom_death_quote)) {
    return;
  }

  if(!isDefined(self.stealth.hints.causeofdeath)) {
    return;
  }

  if(istrue(level.var_56ee5b5aa7ee9269)) {
    return;
  }

  level.custom_death_quote = self.stealth.hints.deathhints[self.stealth.hints.causeofdeath];
}

function stealthhints_combatmonitor() {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(istrue(level.laststandentered)) {
      self waittill("\xd4\xfa\xc7\xb1\xd4\xdab\x16\x02}p\xba\x83\xa1\x0f");
    } else {
      utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    }

    while(!isDefined(self.stealth.hints.causeofdeath)) {
      waitframe();
    }

    while(utility::any_groups_in_combat()) {
      waitframe();
    }

    self.stealth.hints.causeofdeath = undefined;
  }
}
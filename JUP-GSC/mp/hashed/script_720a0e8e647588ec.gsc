/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_720a0e8e647588ec.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_3f8889c16399185c;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\weapon;
#using scripts\mp\weaponrank;
#namespace rankup;

function private onplayerconnect(params) {
  var_5c9f21448aa0c962 = getdvarint(@ "hash_5e68ed857a17e11", 0);

  if(getbuildversion() != "SHIP") {
    if(var_5c9f21448aa0c962 > 0 && !scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
      level.dontendonscore = 1;

      if(!isbot(self)) {
        thread function_d579c78c2ac10132();
      }
    }
  }
}

function private init() {
  callback::add("player_connect", &onplayerconnect);
}

function private function_d579c78c2ac10132() {
  self notify("player_rankup_loop_singleton");
  self endon("player_rankup_loop_singleton");
  level endon("game_ended");
  self endon("disconnect");
  level waittill("matchStartTimer_done");

  while(!isalive(self)) {
    wait 1;
  }

  thread function_f2d9a40693e59a95();
  thread _switchweaponloop();

  while(false) {
    if(isalive(self)) {
      curweap = self getcurrentweapon();

      if(function_e16bb69fe1ca890a(curweap)) {
        currootweapon = getweaponrootname(curweap);
        rank = function_37f14fd361bd3290(currootweapon);
        numranks = level.weaponranktable.maxweaponranks[currootweapon];

        if(rank >= numranks - 1) {
          nextweap = function_8fd5629428f0752b();

          if(!isDefined(nextweap)) {
            break;
          }

          _switchtoweapon(nextweap);
        }
      }
    }

    wait 2;
  }
}

function private function_8fd5629428f0752b() {
  foreach(weap, rank in level.weaponranktable.maxweaponranks) {
    if(!isDefined(weap)) {
      continue;
    }

    rootweapon = getweaponrootname(weap);

    if(function_e16bb69fe1ca890a(rootweapon)) {
      rank = function_37f14fd361bd3290(rootweapon);
      numranks = level.weaponranktable.maxweaponranks[rootweapon];

      if(rank < numranks - 1) {
        return rootweapon;
      }
    }
  }

  return undefined;
}

function private _switchtoweapon(weap) {
  if(!isDefined(weap)) {
    return;
  }

  curweap = self getcurrentweapon();
  currootweapon = getweaponrootname(curweap);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(curweap);
  rootweapon = getweaponrootname(weap);
  weapon = buildweapon(rootweapon);
  self giveweapon(weapon);
  self setweaponammoclip(weapon, weaponclipsize(weapon));
  self setweaponammostock(weapon, weaponmaxammo(weapon));
  self switchtoweaponimmediate(weapon);
}

function private function_604e6c056c7de43d() {
  self notify("player_shooting_loop");
  self endon("player_shooting_loop");
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self startforcedfire();
    wait 0.2;
    self stopforcedfire();
    wait 0.2;
  }
}

function private function_f2d9a40693e59a95() {
  self notify("player_aim_loop");
  self endon("player_aim_loop");
  level endon("game_ended");
  self endon("disconnect");
  targetpos = getdvarvector(@ "hash_47b188962f53ea3b", (-2269, -705, 258));
  targetangles = getdvarvector(@ "hash_4bd47ef19661c575", (0, 177, 0));

  while(true) {
    pos = self getorigin();
    angles = self getplayerangles();
    delta = distance(pos, targetpos);

    if(delta > 3) {
      pos = self setOrigin(targetpos);
    }

    delta = distance(angles, targetangles);

    if(delta > 2) {
      pos = self setplayerangles(targetangles);
    }

    wait 10;
  }
}

function private function_37f14fd361bd3290(weaponname) {
  var_32e9d6e2b27343b9 = self getplayerdata(level.loadoutdata, "squadMembers", "weapon_xp", weaponname);
  curxp = 0;

  foreach(elem in self.pers["weaponStats"]) {
    elemrootweapon = getweaponrootname(elem.weapon);

    if(elemrootweapon == weaponname && isDefined(elem.stats["xp_earned"])) {
      curxp += elem.stats["xp_earned"];
    }
  }

  weapxp = var_32e9d6e2b27343b9 + curxp;
  rank = getweaponrankforxp(weapxp);
  return rank;
}

function private _isriotshield(weaponname) {
  if(isweapon(weaponname) && isnullweapon(weaponname)) {
    return false;
  }

  if(isstring(weaponname) && weaponname == "none") {
    return false;
  }

  return weaponname == "iw9_me_riotshield";
}

function private _ismeleeweapon(weaponname) {
  ismeleeweapon = isknifeonly(weaponname) || isakimbomeleeweapon(weaponname) || isaxeweapon(weaponname);
  return ismeleeweapon;
}

function private function_e16bb69fe1ca890a(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = getweaponrootname(weapon);
  } else {
    weaponname = weapon;
  }

  if(_ismeleeweapon(weaponname)) {
    return false;
  }

  if(_isriotshield(weaponname)) {
    return false;
  }

  if(!weaponshouldgetxp(weaponname)) {
    return false;
  }

  return true;
}

function private _switchweaponloop() {
  self notify("_switchWeaponLoop");
  self endon("_switchWeaponLoop");
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    var_b92bd81c89f295e6 = getDvar(@ "hash_cf91e71876e160cc");

    if(var_b92bd81c89f295e6 != "") {
      _switchtoweapon(var_b92bd81c89f295e6);
      setDvar(@ "hash_cf91e71876e160cc", "");
    }

    wait 0.5;
  }
}
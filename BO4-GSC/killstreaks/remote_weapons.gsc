/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\remote_weapons.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\killstreaks\killstreaks_shared;

#namespace remote_weapons;

init_shared() {
  if(!isDefined(level.var_4249c222)) {
    level.var_4249c222 = {};
    level.remoteweapons = [];
    level.remoteexithint = #"mp/remote_exit";
    callback::on_spawned(&on_player_spawned);
  }
}

on_player_spawned() {
  self endon(#"disconnect");
  self assignremotecontroltrigger();
}

removeandassignnewremotecontroltrigger(remotecontroltrigger) {
  arrayremovevalue(self.activeremotecontroltriggers, remotecontroltrigger);
  self assignremotecontroltrigger(1);
}

assignremotecontroltrigger(force_new_assignment = 0) {
  if(!isDefined(self.activeremotecontroltriggers)) {
    self.activeremotecontroltriggers = [];
  }

  arrayremovevalue(self.activeremotecontroltriggers, undefined);

  if((!isDefined(self.remotecontroltrigger) || force_new_assignment) && self.activeremotecontroltriggers.size > 0) {
    self.remotecontroltrigger = self.activeremotecontroltriggers[self.activeremotecontroltriggers.size - 1];
  }

  if(isDefined(self.remotecontroltrigger)) {
    self.remotecontroltrigger.origin = self.origin;
    self.remotecontroltrigger linkto(self);
  }
}

registerremoteweapon(weaponname, hintstring, usecallback, endusecallback, hidecompassonuse = 1) {
  assert(isDefined(level.remoteweapons));
  level.remoteweapons[weaponname] = spawnStruct();
  level.remoteweapons[weaponname].hintstring = hintstring;
  level.remoteweapons[weaponname].usecallback = usecallback;
  level.remoteweapons[weaponname].endusecallback = endusecallback;
  level.remoteweapons[weaponname].hidecompassonuse = hidecompassonuse;
}

useremoteweapon(weapon, weaponname, immediate, allowmanualdeactivation = 1, always_allow_ride = 0) {
  player = self;
  assert(isplayer(player));
  weapon.remoteowner = player;
  weapon.inittime = gettime();
  weapon.remotename = weaponname;
  weapon.remoteweaponallowmanualdeactivation = allowmanualdeactivation;
  weapon thread watchremoveremotecontrolledweapon();

  if(!immediate) {
    weapon createremoteweapontrigger();
    return;
  }

  weapon thread watchownerdisconnect();
  weapon useremotecontrolweapon(allowmanualdeactivation, always_allow_ride);
}

watchforhack() {
  weapon = self;
  weapon endon(#"death");
  waitresult = weapon waittill(#"killstreak_hacked");

  if(isDefined(weapon.remoteweaponallowmanualdeactivation) && weapon.remoteweaponallowmanualdeactivation) {
    weapon thread watchremotecontroldeactivate();
  }

  weapon.remoteowner = waitresult.hacker;
}

on_game_ended() {
  weapon = self;
  weapon endremotecontrolweaponuse(0, 1);
}

watchremoveremotecontrolledweapon() {
  weapon = self;
  weapon endon(#"remote_weapon_end");
  waitresult = weapon waittill(#"death", #"remote_weapon_shutdown");

  if(weapon.watch_remote_weapon_death === 1 && isDefined(waitresult._notify) && waitresult._notify == "remote_weapon_shutdown") {
    weapon notify(#"hash_59b25025ce93a142");
    weapon waittill(#"death");
  }

  weapon endremotecontrolweaponuse(0);

  while(isDefined(weapon)) {
    waitframe(1);
  }
}

createremoteweapontrigger() {
  weapon = self;
  player = weapon.remoteowner;

  if(isDefined(weapon.usetrigger)) {
    weapon.usetrigger delete();
  }

  weapon.usetrigger = spawn("trigger_radius_use", player.origin, 0, 32, 32);
  weapon.usetrigger enablelinkto();
  weapon.usetrigger linkto(player);
  weapon.usetrigger sethintlowpriority(1);
  weapon.usetrigger setcursorhint("HINT_NOICON");

  if(isDefined(level.remoteweapons[weapon.remotename])) {
    weapon.usetrigger sethintstring(level.remoteweapons[weapon.remotename].hintstring);
  }

  weapon.usetrigger setteamfortrigger(player.team);
  weapon.usetrigger.team = player.team;
  player clientclaimtrigger(weapon.usetrigger);
  player.remotecontroltrigger = weapon.usetrigger;
  player.activeremotecontroltriggers[player.activeremotecontroltriggers.size] = weapon.usetrigger;
  weapon.usetrigger.claimedby = player;
  weapon thread watchweapondeath();
  weapon thread watchownerdisconnect();
  weapon thread watchremotetriggeruse();
  weapon thread watchremotetriggerdisable();
}

watchweapondeath() {
  weapon = self;
  weapon.usetrigger endon(#"death");
  weapon waittill(#"death", #"remote_weapon_end");

  if(isDefined(weapon.remoteowner)) {
    weapon.remoteowner removeandassignnewremotecontroltrigger(weapon.usetrigger);
  }

  weapon.usetrigger delete();
}

watchownerdisconnect() {
  weapon = self;
  weapon endon(#"remote_weapon_end", #"remote_weapon_shutdown");

  if(isDefined(weapon.usetrigger)) {
    weapon.usetrigger endon(#"death");
  }

  weapon.remoteowner waittill(#"joined_team", #"disconnect", #"joined_spectators");
  endremotecontrolweaponuse(0);

  if(isDefined(weapon) && isDefined(weapon.usetrigger)) {
    weapon.usetrigger delete();
  }
}

watchremotetriggerdisable() {
  weapon = self;
  weapon endon(#"remote_weapon_end", #"remote_weapon_shutdown");
  weapon.usetrigger endon(#"death");
  weapon.remoteowner endon(#"disconnect");

  while(true) {
    weapon.usetrigger triggerenable(!weapon.remoteowner iswallrunning());
    wait 0.1;
  }
}

allowremotestart(var_59d2c24b) {
  player = self;

  if((isDefined(var_59d2c24b) && var_59d2c24b || player usebuttonpressed()) && !player.throwinggrenade && !player meleebuttonpressed() && !player util::isusingremote() && !(isDefined(player.carryobject) && isDefined(player.carryobject.disallowremotecontrol) && player.carryobject.disallowremotecontrol)) {
    return 1;
  }

  return 0;
}

watchremotetriggeruse() {
  weapon = self;
  weapon endon(#"death", #"remote_weapon_end");

  if(isbot(weapon.remoteowner)) {
    return;
  }

  while(true) {
    res = weapon.usetrigger waittill(#"trigger", #"death");

    if(res._notify == "death") {
      return;
    }

    if(weapon.remoteowner isusingoffhand() || weapon.remoteowner iswallrunning() || weapon.remoteowner util::isusingremote() && weapon.remoteowner.usingremote !== weapon.remotename) {
      continue;
    }

    if(isDefined(weapon.hackertrigger) && isDefined(weapon.hackertrigger.progressbar)) {
      if(weapon.remotename == "killstreak_remote_turret") {
        weapon.remoteowner iprintlnbold(#"hash_7b4c84d5307fea60");
      }

      continue;
    }

    if(weapon.remoteowner allowremotestart()) {
      var_48096e05 = gettime() - (isDefined(weapon.lastusetime) ? weapon.lastusetime : 0);

      if(var_48096e05 > 700) {
        useremotecontrolweapon();
      }
    }
  }
}

useremotecontrolweapon(allowmanualdeactivation = 1, always_allow_ride = 0) {
  self endon(#"death");
  weapon = self;
  assert(isDefined(weapon.remoteowner));
  weapon.control_initiated = 1;
  weapon.endremotecontrolweapon = 0;
  weapon.remoteowner endon(#"disconnect", #"joined_team");
  weapon.remoteowner disableoffhandweapons();
  weapon.remoteowner disableweaponcycling();
  weapon.remoteowner.dofutz = 0;

  if(!isDefined(weapon.disableremoteweaponswitch)) {
    remoteweapon = getweapon(#"killstreak_remote");
    weapon.remoteowner giveweapon(remoteweapon);
    weapon.remoteowner switchtoweapon(remoteweapon);

    if(always_allow_ride) {
      weapon.remoteowner waittill(#"weapon_change", #"death");
    } else {
      waitresult = weapon.remoteowner waittill(#"weapon_change");
      newweapon = waitresult.weapon;
    }
  }

  if(isDefined(newweapon)) {
    if(newweapon != remoteweapon || weapon.remoteowner util::isusingremote() && weapon.remoteowner.usingremote !== weapon.remotename) {
      weapon.remoteowner killstreaks::clear_using_remote(1, 1);
      return;
    }
  }

  weapon callback::function_d8abfc3d(#"on_end_game", &on_game_ended);
  weapon.var_57446df7 = 1;
  weapon.remoteowner thread killstreaks::watch_for_remove_remote_weapon();
  weapon.remoteowner util::setusingremote(weapon.remotename);
  weapon.remoteowner val::set(#"useremotecontrolweapon", "freezecontrols");
  weapon.remoteowner thread resetcontrols(weapon);
  result = weapon.remoteowner killstreaks::init_ride_killstreak(weapon.remotename, always_allow_ride);

  if(result != "success") {
    if(result != "disconnect") {
      weapon.remoteowner killstreaks::clear_using_remote();
      weapon thread resetcontrolinitiateduponownerrespawn();
    }
  } else {
    weapon.controlled = 1;
    weapon.killcament = self;
    weapon notify(#"remote_start");

    if(allowmanualdeactivation) {
      weapon thread watchremotecontroldeactivate();
    }

    weapon.remoteowner thread[[level.remoteweapons[weapon.remotename].usecallback]](weapon);

    if(level.remoteweapons[weapon.remotename].hidecompassonuse) {
      weapon.remoteowner killstreaks::hide_compass();
    }
  }

  weapon notify(#"reset_controls");
}

resetcontrols(weapon) {
  weapon waittill(#"death", #"reset_controls");

  if(isDefined(self)) {
    self val::reset(#"useremotecontrolweapon", "freezecontrols");
  }
}

resetcontrolinitiateduponownerrespawn() {
  self endon(#"death");
  self.remoteowner waittill(#"spawned");
  self.control_initiated = 0;
}

watchremotecontroldeactivate() {
  self notify(#"watchremotecontroldeactivate_remoteweapons");
  self endon(#"watchremotecontroldeactivate_remoteweapons");
  weapon = self;
  weapon endon(#"remote_weapon_end", #"death");
  weapon.remoteowner endon(#"disconnect");

  while(weapon.remoteowner usebuttonpressed()) {
    waitframe(1);
  }

  while(true) {
    timeused = 0;

    while(weapon.remoteowner usebuttonpressed()) {
      timeused += 0.05;

      if(timeused > 0.25) {
        weapon thread endremotecontrolweaponuse(1);
        weapon.lastusetime = gettime();
        return;
      }

      waitframe(1);
    }

    waitframe(1);
  }
}

endremotecontrolweaponuse(exitrequestedbyowner, gameended) {
  weapon = self;

  if(!isDefined(weapon) || isDefined(weapon.endremotecontrolweapon) && weapon.endremotecontrolweapon) {
    return;
  }

  weapon.endremotecontrolweapon = 1;
  remote_controlled = isDefined(weapon.control_initiated) && weapon.control_initiated || isDefined(weapon.controlled) && weapon.controlled;

  while(isDefined(weapon) && weapon.forcewaitremotecontrol === 1 && remote_controlled == 0) {
    remote_controlled = isDefined(weapon.control_initiated) && weapon.control_initiated || isDefined(weapon.controlled) && weapon.controlled;
    waitframe(1);
  }

  if(!isDefined(weapon)) {
    return;
  }

  if(isDefined(weapon.remoteowner) && remote_controlled) {
    if(isDefined(weapon.remoteweaponshutdowndelay)) {
      wait weapon.remoteweaponshutdowndelay;
    }

    player = weapon.remoteowner;

    if(player.dofutz === 1) {
      player clientfield::set_to_player("static_postfx", 1);
      wait 1;

      if(isDefined(player)) {
        player clientfield::set_to_player("static_postfx", 0);
        player.dofutz = 0;
      }
    } else if(!exitrequestedbyowner && weapon.watch_remote_weapon_death === 1 && !isalive(weapon)) {
      weapon.dontfreeme = 1;
      wait isDefined(weapon.watch_remote_weapon_death_duration) ? weapon.watch_remote_weapon_death_duration : 1;
      weapon.dontfreeme = undefined;
    }

    if(isDefined(player)) {
      player thread fadetoblackandbackin();
      player waittill(#"fade2black");

      if(remote_controlled) {
        player unlink();
      }

      player killstreaks::clear_using_remote(0, undefined, gameended);
      cleared_killstreak_delay = 1;
      player enableusability();
    }
  }

  if(isDefined(weapon) && isDefined(weapon.remotename)) {
    self[[level.remoteweapons[weapon.remotename].endusecallback]](weapon, exitrequestedbyowner);
  }

  if(isDefined(weapon)) {
    weapon.killcament = weapon;

    if(isDefined(weapon.remoteowner)) {
      if(remote_controlled) {
        weapon.remoteowner unlink();

        if(!(isDefined(cleared_killstreak_delay) && cleared_killstreak_delay)) {
          weapon.remoteowner killstreaks::reset_killstreak_delay_killcam();
        }

        weapon.remoteowner util::clientnotify("nofutz");
      }

      if(isDefined(level.gameended) && level.gameended) {
        weapon.remoteowner val::set(#"game_end", "freezecontrols");
      }
    }
  }

  if(isDefined(weapon)) {
    if(isDefined(weapon.var_57446df7) && weapon.var_57446df7) {
      weapon callback::function_52ac9652(#"on_end_game", &on_game_ended);
    }

    weapon.control_initiated = 0;
    weapon.controlled = 0;

    if(isDefined(weapon.remoteowner)) {
      weapon.remoteowner killstreaks::unhide_compass();
    }

    if(!exitrequestedbyowner || isDefined(weapon.one_remote_use) && weapon.one_remote_use) {
      weapon.remote_weapon_end = 1;
      weapon notify(#"remote_weapon_end");
    }
  }
}

fadetoblackandbackin() {
  self endon(#"disconnect");
  lui::screen_fade_out(0.1);
  self destroyhud();
  waitframe(1);
  self notify(#"fade2black");
  lui::screen_fade_in(0.2);
}

stunstaticfx(duration) {
  self endon(#"remove_remote_weapon");
  wait duration - 0.5;
  time = duration - 0.5;

  while(time < duration) {
    waitframe(1);
    time += 0.05;
  }
}

destroyhud() {
  if(isDefined(self)) {
    self notify(#"stop_signal_failure");
    self.flashingsignalfailure = 0;
    self clientfield::set_to_player("static_postfx", 0);
    self destroyremotehud();
    self util::clientnotify("nofutz");
  }
}

destroyremotehud() {
  self useservervisionset(0);
  self setinfraredvision(0);
}

set_static(val) {
  owner = self.owner;

  if(val) {
    if(isDefined(owner) && owner.usingvehicle && isDefined(owner.viewlockedentity) && owner.viewlockedentity == self) {
      owner clientfield::set_to_player("static_postfx", 1);
    }

    return;
  }

  if(isDefined(owner)) {
    owner function_3c9e877a();
  }
}

function_3c9e877a() {
  self clientfield::set_to_player("static_postfx", 0);
}

do_static_fx() {
  self set_static(1);
  owner = self.owner;
  wait 2;

  if(isDefined(owner)) {
    owner function_3c9e877a();
  }

  if(isDefined(self)) {
    self notify(#"static_fx_done");
  }
}
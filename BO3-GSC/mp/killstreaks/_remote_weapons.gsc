/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_remote_weapons.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\killstreaks\_ai_tank;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_qrdrone;
#using scripts\mp\killstreaks\_turret;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\util_shared;
#namespace remote_weapons;

function init() {
  level.remoteweapons = [];
  level.remoteexithint = & "MP_REMOTE_EXIT";
  callback::on_spawned( & on_player_spawned);
}

function on_player_spawned() {
  self endon("disconnect");
  self assignremotecontroltrigger();
}

function removeandassignnewremotecontroltrigger(remotecontroltrigger) {
  arrayremovevalue(self.activeremotecontroltriggers, remotecontroltrigger);
  self assignremotecontroltrigger(1);
}

function assignremotecontroltrigger(force_new_assignment = 0) {
  if(!isDefined(self.activeremotecontroltriggers)) {
    self.activeremotecontroltriggers = [];
  }
  arrayremovevalue(self.activeremotecontroltriggers, undefined);
  if(!isDefined(self.remotecontroltrigger) || force_new_assignment && self.activeremotecontroltriggers.size > 0) {
    self.remotecontroltrigger = self.activeremotecontroltriggers[self.activeremotecontroltriggers.size - 1];
  }
  if(isDefined(self.remotecontroltrigger)) {
    self.remotecontroltrigger.origin = self.origin;
    self.remotecontroltrigger linkto(self);
  }
}

function registerremoteweapon(weaponname, hintstring, usecallback, endusecallback, hidecompassonuse = 1) {
  assert(isDefined(level.remoteweapons));
  level.remoteweapons[weaponname] = spawnStruct();
  level.remoteweapons[weaponname].hintstring = hintstring;
  level.remoteweapons[weaponname].usecallback = usecallback;
  level.remoteweapons[weaponname].endusecallback = endusecallback;
  level.remoteweapons[weaponname].hidecompassonuse = hidecompassonuse;
}

function useremoteweapon(weapon, weaponname, immediate, allowmanualdeactivation = 1, always_allow_ride = 0) {
  player = self;
  assert(isplayer(player));
  weapon.remoteowner = player;
  weapon.inittime = gettime();
  weapon.remotename = weaponname;
  weapon.remoteweaponallowmanualdeactivation = allowmanualdeactivation;
  weapon thread watchremoveremotecontrolledweapon();
  if(!immediate) {
    weapon createremoteweapontrigger();
  } else {
    weapon thread watchownerdisconnect();
    weapon useremotecontrolweapon(allowmanualdeactivation, always_allow_ride);
  }
}

function watchforhack() {
  weapon = self;
  weapon endon("death");
  weapon waittill("killstreak_hacked", hacker);
  if(isDefined(weapon.remoteweaponallowmanualdeactivation) && weapon.remoteweaponallowmanualdeactivation == 1) {
    weapon thread watchremotecontroldeactivate();
  }
  weapon.remoteowner = hacker;
}

function watchremoveremotecontrolledweapon() {
  weapon = self;
  weapon endon("remote_weapon_end");
  weapon util::waittill_any("death", "remote_weapon_shutdown");
  weapon endremotecontrolweaponuse(0);
  while(isDefined(weapon)) {
    wait(0.05);
  }
}

function createremoteweapontrigger() {
  weapon = self;
  player = weapon.remoteowner;
  if(isDefined(weapon.usetrigger)) {
    weapon.usetrigger delete();
  }
  weapon.usetrigger = spawn("trigger_radius_use", player.origin, 32, 32);
  weapon.usetrigger enablelinkto();
  weapon.usetrigger linkto(player);
  weapon.usetrigger sethintlowpriority(1);
  weapon.usetrigger setcursorhint("HINT_NOICON");
  weapon.usetrigger sethintstring(level.remoteweapons[weapon.remotename].hintstring);
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

function watchweapondeath() {
  weapon = self;
  weapon.usetrigger endon("death");
  weapon util::waittill_any("death", "remote_weapon_end");
  if(isDefined(weapon.remoteowner)) {
    weapon.remoteowner removeandassignnewremotecontroltrigger(weapon.usetrigger);
  }
  weapon.usetrigger delete();
}

function watchownerdisconnect() {
  weapon = self;
  weapon endon("remote_weapon_end");
  weapon endon("remote_weapon_shutdown");
  if(isDefined(weapon.usetrigger)) {
    weapon.usetrigger endon("death");
  }
  weapon.remoteowner util::waittill_any("joined_team", "disconnect", "joined_spectators");
  endremotecontrolweaponuse(0);
  if(isDefined(weapon) && isDefined(weapon.usetrigger)) {
    weapon.usetrigger delete();
  }
}

function watchremotetriggerdisable() {
  weapon = self;
  weapon endon("remote_weapon_end");
  weapon endon("remote_weapon_shutdown");
  weapon.usetrigger endon("death");
  while(true) {
    weapon.usetrigger triggerenable(!weapon.remoteowner iswallrunning());
    wait(0.1);
  }
}

function allowremotestart() {
  player = self;
  if(player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player util::isusingremote() && (!(isDefined(player.carryobject) && (isDefined(player.carryobject.disallowremotecontrol) && player.carryobject.disallowremotecontrol)))) {
    return true;
  }
  return false;
}

function watchremotetriggeruse() {
  weapon = self;
  weapon endon("death");
  weapon endon("remote_weapon_end");
  if(weapon.remoteowner util::is_bot()) {
    return;
  }
  while(true) {
    weapon.usetrigger waittill("trigger", player);
    if(weapon.remoteowner isusingoffhand() || weapon.remoteowner iswallrunning()) {
      continue;
    }
    if(isDefined(weapon.hackertrigger) && isDefined(weapon.hackertrigger.progressbar)) {
      if(weapon.remotename == "killstreak_remote_turret") {
        weapon.remoteowner iprintlnbold(&"KILLSTREAK_AUTO_TURRET_NOT_AVAILABLE");
      }
      continue;
    }
    if(weapon.remoteowner allowremotestart()) {
      useremotecontrolweapon();
    }
  }
}

function useremotecontrolweapon(allowmanualdeactivation = 1, always_allow_ride = 0) {
  self endon("death");
  weapon = self;
  assert(isDefined(weapon.remoteowner));
  weapon.control_initiated = 1;
  weapon.endremotecontrolweapon = 0;
  weapon.remoteowner endon("disconnect");
  weapon.remoteowner endon("joined_team");
  weapon.remoteowner disableoffhandweapons();
  weapon.remoteowner disableweaponcycling();
  weapon.remoteowner.dofutz = 0;
  if(!isDefined(weapon.disableremoteweaponswitch)) {
    remoteweapon = getweapon("killstreak_remote");
    weapon.remoteowner giveweapon(remoteweapon);
    weapon.remoteowner switchtoweapon(remoteweapon);
    if(always_allow_ride) {
      weapon.remoteowner util::waittill_any("weapon_change", "death");
    } else {
      weapon.remoteowner waittill("weapon_change", newweapon);
    }
  }
  if(isDefined(newweapon)) {
    if(newweapon != remoteweapon) {
      weapon.remoteowner killstreaks::clear_using_remote(1, 1);
      return;
    }
  }
  weapon.remoteowner thread killstreaks::watch_for_remove_remote_weapon();
  weapon.remoteowner util::setusingremote(weapon.remotename);
  weapon.remoteowner util::freeze_player_controls(1);
  result = weapon.remoteowner killstreaks::init_ride_killstreak(weapon.remotename, always_allow_ride);
  if(result != "success") {
    if(result != "disconnect") {
      weapon.remoteowner killstreaks::clear_using_remote();
      weapon thread resetcontrolinitiateduponownerrespawn();
    }
  } else {
    weapon.controlled = 1;
    weapon.killcament = self;
    weapon notify("remote_start");
    if(allowmanualdeactivation) {
      weapon thread watchremotecontroldeactivate();
    }
    weapon.remoteowner thread[[level.remoteweapons[weapon.remotename].usecallback]](weapon);
    if(level.remoteweapons[weapon.remotename].hidecompassonuse) {
      weapon.remoteowner killstreaks::hide_compass();
    }
  }
  weapon.remoteowner util::freeze_player_controls(0);
}

function resetcontrolinitiateduponownerrespawn() {
  self endon("death");
  self.remoteowner waittill("spawned");
  self.control_initiated = 0;
}

function watchremotecontroldeactivate() {
  self notify("watchremotecontroldeactivate_remoteweapons");
  self endon("watchremotecontroldeactivate_remoteweapons");
  weapon = self;
  weapon endon("remote_weapon_end");
  weapon endon("death");
  weapon.remoteowner endon("disconnect");
  while(true) {
    timeused = 0;
    while(weapon.remoteowner usebuttonpressed()) {
      timeused = timeused + 0.05;
      if(timeused > 0.25) {
        weapon thread endremotecontrolweaponuse(1);
        return;
      }
      wait(0.05);
    }
    wait(0.05);
  }
}

function endremotecontrolweaponuse(exitrequestedbyowner) {
  weapon = self;
  if(!isDefined(weapon) || (isDefined(weapon.endremotecontrolweapon) && weapon.endremotecontrolweapon)) {
    return;
  }
  weapon.endremotecontrolweapon = 1;
  remote_controlled = isDefined(weapon.control_initiated) && weapon.control_initiated || (isDefined(weapon.controlled) && weapon.controlled);
  while(isDefined(weapon) && weapon.forcewaitremotecontrol === 1 && remote_controlled == 0) {
    remote_controlled = isDefined(weapon.control_initiated) && weapon.control_initiated || (isDefined(weapon.controlled) && weapon.controlled);
    wait(0.05);
  }
  if(!isDefined(weapon)) {
    return;
  }
  if(isDefined(weapon.remoteowner) && remote_controlled) {
    if(isDefined(weapon.remoteweaponshutdowndelay)) {
      wait(weapon.remoteweaponshutdowndelay);
    }
    player = weapon.remoteowner;
    if(player.dofutz === 1) {
      player clientfield::set_to_player("static_postfx", 1);
      wait(1);
      if(isDefined(player)) {
        player clientfield::set_to_player("static_postfx", 0);
        player.dofutz = 0;
      }
    } else if(!exitrequestedbyowner && weapon.watch_remote_weapon_death === 1 && !isalive(weapon)) {
      wait((isDefined(weapon.watch_remote_weapon_death_duration) ? weapon.watch_remote_weapon_death_duration : 1));
    }
    if(isDefined(player)) {
      player thread fadetoblackandbackin();
      player waittill("fade2black");
      if(remote_controlled) {
        player unlink();
      }
      player killstreaks::clear_using_remote(1);
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
        weapon.remoteowner util::freeze_player_controls(1);
      }
    }
  }
  if(isDefined(weapon)) {
    weapon.control_initiated = 0;
    weapon.controlled = 0;
    if(isDefined(weapon.remoteowner)) {
      weapon.remoteowner killstreaks::unhide_compass();
    }
    if(!exitrequestedbyowner || (isDefined(weapon.one_remote_use) && weapon.one_remote_use)) {
      weapon notify("remote_weapon_end");
    }
  }
}

function fadetoblackandbackin() {
  self endon("disconnect");
  lui::screen_fade_out(0.1);
  self qrdrone::destroyhud();
  wait(0.05);
  self notify("fade2black");
  lui::screen_fade_in(0.2);
}

function stunstaticfx(duration) {
  self endon("remove_remote_weapon");
  self.fullscreen_static.alpha = 0.65;
  wait(duration - 0.5);
  time = duration - 0.5;
  while(time < duration) {
    wait(0.05);
    time = time + 0.05;
    self.fullscreen_static.alpha = self.fullscreen_static.alpha - 0.05;
  }
  self.fullscreen_static.alpha = 0.15;
}

function destroyremotehud() {
  self useservervisionset(0);
  self setinfraredvision(0);
  if(isDefined(self.fullscreen_static)) {
    self.fullscreen_static destroy();
  }
  if(isDefined(self.hud_prompt_exit)) {
    self.hud_prompt_exit destroy();
  }
}

function set_static(val) {
  owner = self.owner;
  if(isDefined(owner) && owner.usingvehicle && isDefined(owner.viewlockedentity) && owner.viewlockedentity == self) {
    owner clientfield::set_to_player("static_postfx", val);
  }
}

function do_static_fx() {
  self endon("death");
  self set_static(1);
  wait(2);
  self set_static(0);
  self notify("static_fx_done");
}
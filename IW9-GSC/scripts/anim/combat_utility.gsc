/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\combat_utility.gsc
***********************************************/

shootuntilshootbehaviorchange() {}

initgrenadethrowanims() {}

throwgrenadeatplayerasap_combat_utility() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] _meth_4C108309DC0D7FD2() == 0)
      _func_B4EBE6632D7E8EFE(level.players[_id_AC0E594AC96AA3A8], "lethal", 0);
  }

  _func_98DEAE9464F6C005(1);
}

trygrenadethrow(_id_A15426692301F3F0, destination, _id_4ED24C46C4F57095, _id_B1C462B90341E70E, fastthrow, withbounce, _id_973C51E9FD66D178) {}

getgrenadedropvelocity() {
  yaw = randomfloat(360);
  pitch = randomfloatrange(30, 75);
  _id_F8F00F4ADF868A35 = sin(pitch);
  _id_D62BEC0FA0B05A5E = cos(pitch);
  _id_F8F00D4ADF8685CF = cos(yaw) * _id_D62BEC0FA0B05A5E;
  _id_F8F00C4ADF86839C = sin(yaw) * _id_D62BEC0FA0B05A5E;
  speed = randomfloatrange(100, 200);
  velocity = (_id_F8F00D4ADF8685CF, _id_F8F00C4ADF86839C, _id_F8F00F4ADF868A35) * speed;
  return velocity;
}

dropgrenade() {
  if(isDefined(self.nodropgrenade)) {
    return;
  }
  _id_F3E5EC9ECAAF8E1B = self gettagorigin("tag_accessory_right");
  velocity = getgrenadedropvelocity();
  self magicgrenademanual(_id_F3E5EC9ECAAF8E1B, velocity, 3);
}

getpitchtoshootspot(_id_0C3EA9B1A20FF199) {
  if(!isDefined(_id_0C3EA9B1A20FF199))
    return 0;

  _id_4532BCBE2927F239 = _id_0C3EA9B1A20FF199 - self getshootatpos();
  _id_4532BCBE2927F239 = vectorNormalize(_id_4532BCBE2927F239);
  pitchdelta = vectortoangles(_id_4532BCBE2927F239)[0];
  return angleclamp180(pitchdelta);
}

watchreloading() {
  self.isreloading = 0;
  self.lastreloadstarttime = -1;

  for(;;) {
    self waittill("reload_start");
    self.isreloading = 1;
    self.lastreloadstarttime = gettime();
    thread _id_50EEB9595C6D6E1B::_id_C4E2E61A7CE330C0();
    waittillreloadfinished();
    self.isreloading = 0;
  }
}

waittillreloadfinished() {
  thread timednotify(4, "reloadtimeout");
  self endon("reloadtimeout");
  self endon("weapon_taken");

  for(;;) {
    self waittill("reload");
    _id_DE88CD14114C1E24 = self getcurrentweapon();

    if(isnullweapon(_id_DE88CD14114C1E24)) {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(_id_DE88CD14114C1E24)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

timednotify(time, msg) {
  self endon(msg);
  wait(time);
  self notify(msg);
}

monitorflash() {
  self endon("death");

  if(!isDefined(level.neverstopmonitoringflash))
    self endon("stop_monitoring_flash");

  for(;;) {
    _id_B1225349B792FFAD = undefined;
    origin = undefined;
    _id_DDA6D54C623139BD = undefined;
    attacker = undefined;
    attackerteam = undefined;
    self waittill("flashbang", origin, _id_B1225349B792FFAD, _id_DDA6D54C623139BD, attacker, attackerteam, duration);

    if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
      continue;
    }
    if(isDefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }
    if(isDefined(self.team) && isDefined(attackerteam) && self.team == attackerteam) {
      _id_B1225349B792FFAD = 3 * (_id_B1225349B792FFAD - 0.75);

      if(_id_B1225349B792FFAD < 0) {
        continue;
      }
      if(isDefined(self.teamflashbangimmunity))
        continue;
    }

    _id_0FBC487FAA5BF1FF = 0.2;

    if(_id_B1225349B792FFAD > 1 - _id_0FBC487FAA5BF1FF)
      _id_B1225349B792FFAD = 1.0;
    else
      _id_B1225349B792FFAD = _id_B1225349B792FFAD / (1 - _id_0FBC487FAA5BF1FF);

    if(!isDefined(duration))
      duration = 4.5;

    duration = duration * _id_B1225349B792FFAD;

    if(duration < 0.25) {
      continue;
    }
    self.flashingteam = attackerteam;
    flashbangstart(duration);
    self notify("doFlashBanged", origin, attacker);
  }
}

flashbangstart(duration) {
  if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
    return;
  }
  if(isDefined(self.syncedmeleetarget)) {
    return;
  }
  if(self isinscriptedstate() || scripts\asm\asm_bb::bb_isanimScripted()) {
    return;
  }
  if(!self.allowpain || !self.allowpain_internal) {
    return;
  }
  _id_CEDD6DB7D7DAA84F = gettime() + int(duration * 1000);

  if(isDefined(self.flashendtime))
    self.flashendtime = int(max(self.flashendtime, _id_CEDD6DB7D7DAA84F));
  else {
    self.flashendtime = _id_CEDD6DB7D7DAA84F;

    if(isDefined(self.asm))
      scripts\asm\asm::asm_setstate("pain_flashed_transition");
  }

  self notify("flashed");
}

fasteranimspeed() {
  return 1.5;
}
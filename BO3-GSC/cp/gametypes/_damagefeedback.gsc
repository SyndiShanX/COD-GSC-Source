/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_damagefeedback.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace damagefeedback;

function autoexec __init__sytem__() {
  system::register("damagefeedback", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype( & init);
  callback::on_connect( & on_player_connect);
}

function init() {}

function on_player_connect() {
  self.hud_damagefeedback = newdamageindicatorhudelem(self);
  self.hud_damagefeedback.horzalign = "center";
  self.hud_damagefeedback.vertalign = "middle";
  self.hud_damagefeedback.x = -12;
  self.hud_damagefeedback.y = -12;
  self.hud_damagefeedback.alpha = 0;
  self.hud_damagefeedback.archived = 1;
  self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  self.hitsoundtracker = 1;
}

function should_play_sound(mod) {
  if(!isDefined(mod)) {
    return false;
  }
  switch (mod) {
    case "MOD_CRUSH":
    case "MOD_GRENADE_SPLASH":
    case "MOD_HIT_BY_OBJECT":
    case "MOD_MELEE":
    case "MOD_MELEE_ASSASSINATE":
    case "MOD_MELEE_WEAPON_BUTT": {
      return false;
    }
  }
  return true;
}

function update(mod, inflictor, perkfeedback) {
  if(!isplayer(self) || sessionmodeiszombiesgame()) {
    return;
  }
  if(should_play_sound(mod)) {
    if(isDefined(inflictor) && isDefined(inflictor.soundmod)) {
      switch (inflictor.soundmod) {
        case "player": {
          self playlocalsound("mpl_hit_alert");
          break;
        }
        case "heli": {
          self thread play_hit_sound(mod, "mpl_hit_alert_air");
          break;
        }
        case "hpm": {
          self thread play_hit_sound(mod, "mpl_hit_alert_hpm");
          break;
        }
        case "taser_spike": {
          self thread play_hit_sound(mod, "mpl_hit_alert_taser_spike");
          break;
        }
        case "dog":
        case "straferun": {
          break;
        }
        case "default_loud": {
          self thread play_hit_sound(mod, "mpl_hit_heli_gunner");
          break;
        }
        default: {
          self thread play_hit_sound(mod, "mpl_hit_alert_low");
          break;
        }
      }
    } else {
      self playlocalsound("mpl_hit_alert_low");
    }
  }
  if(isDefined(perkfeedback)) {} else {
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  }
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(1);
  self.hud_damagefeedback.alpha = 0;
}

function play_hit_sound(mod, alert) {
  self endon("disconnect");
  if(self.hitsoundtracker) {
    self.hitsoundtracker = 0;
    self playlocalsound(alert);
    wait(0.05);
    self.hitsoundtracker = 1;
  }
}

function update_special(hitent) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(hitent)) {
    return;
  }
  if(!isplayer(hitent)) {
    return;
  }
  wait(0.05);
  if(!isDefined(self.directionalhitarray)) {
    self.directionalhitarray = [];
    hitentnum = hitent getentitynumber();
    self.directionalhitarray[hitentnum] = 1;
    self thread send_hit_special_event_at_frame_end(hitent);
  } else {
    hitentnum = hitent getentitynumber();
    self.directionalhitarray[hitentnum] = 1;
  }
}

function send_hit_special_event_at_frame_end(hitent) {
  self endon("disconnect");
  waittillframeend();
  enemyshit = 0;
  value = 1;
  entbitarray0 = 0;
  for(i = 0; i < 32; i++) {
    if(isDefined(self.directionalhitarray[i]) && self.directionalhitarray[i] != 0) {
      entbitarray0 = entbitarray0 + value;
      enemyshit++;
    }
    value = value * 2;
  }
  entbitarray1 = 0;
  for(i = 33; i < 64; i++) {
    if(isDefined(self.directionalhitarray[i]) && self.directionalhitarray[i] != 0) {
      entbitarray1 = entbitarray1 + value;
      enemyshit++;
    }
    value = value * 2;
  }
  if(enemyshit) {
    self directionalhitindicator(entbitarray0, entbitarray1);
  }
  self.directionalhitarray = undefined;
  entbitarray0 = 0;
  entbitarray1 = 0;
}
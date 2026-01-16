/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_damagefeedback.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace damagefeedback;

function __init__() {
  callback::on_start_gametype( & main);
  callback::on_connect( & on_player_connect);
}

function main() {}

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
  if(!isdefined(mod)) {
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

function updatedamagefeedback(mod, inflictor, perkfeedback) {
  if(!isplayer(self) || sessionmodeiszombiesgame()) {
    return;
  }
  if(should_play_sound(mod)) {
    if(isdefined(inflictor) && isdefined(inflictor.soundmod)) {
      switch (inflictor.soundmod) {
        case "player": {
          self thread playhitsound(mod, "mpl_hit_alert");
          break;
        }
        case "heli": {
          self thread playhitsound(mod, "mpl_hit_alert_air");
          break;
        }
        case "hpm": {
          self thread playhitsound(mod, "mpl_hit_alert_hpm");
          break;
        }
        case "taser_spike": {
          self thread playhitsound(mod, "mpl_hit_alert_taser_spike");
          break;
        }
        case "dog":
        case "straferun": {
          break;
        }
        case "default_loud": {
          self thread playhitsound(mod, "mpl_hit_heli_gunner");
          break;
        }
        default: {
          self thread playhitsound(mod, "mpl_hit_alert_low");
          break;
        }
      }
    } else {
      self thread playhitsound(mod, "mpl_hit_alert_low");
    }
  }
  if(isdefined(perkfeedback)) {} else {
    self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  }
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(1);
  self.hud_damagefeedback.alpha = 0;
}

function playhitsound(mod, alert) {
  self endon("disconnect");
  if(self.hitsoundtracker) {
    self.hitsoundtracker = 0;
    self playlocalsound(alert);
    wait(0.05);
    self.hitsoundtracker = 1;
  }
}

function updatespecialdamagefeedback(hitent) {
  if(!isplayer(self)) {
    return;
  }
  if(!isdefined(hitent)) {
    return;
  }
  if(!isplayer(hitent)) {
    return;
  }
  wait(0.05);
  if(!isdefined(self.directionalhitarray)) {
    self.directionalhitarray = [];
    hitentnum = hitent getentitynumber();
    self.directionalhitarray[hitentnum] = 1;
    self thread sendhitspecialeventatframeend(hitent);
  } else {
    hitentnum = hitent getentitynumber();
    self.directionalhitarray[hitentnum] = 1;
  }
}

function sendhitspecialeventatframeend(hitent) {
  self endon("disconnect");
  waittillframeend();
  enemyshit = 0;
  value = 1;
  entbitarray0 = 0;
  for (i = 0; i < 32; i++) {
    if(isdefined(self.directionalhitarray[i]) && self.directionalhitarray[i] != 0) {
      entbitarray0 = entbitarray0 + value;
      enemyshit++;
    }
    value = value * 2;
  }
  entbitarray1 = 0;
  for (i = 33; i < 64; i++) {
    if(isdefined(self.directionalhitarray[i]) && self.directionalhitarray[i] != 0) {
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
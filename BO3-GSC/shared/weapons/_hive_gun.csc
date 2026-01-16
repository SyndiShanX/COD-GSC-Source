/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_hive_gun.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace hive_gun;

function init_shared() {
  level thread register();
}

function register() {
  clientfield::register("scriptmover", "firefly_state", 1, 3, "int", & firefly_state_change, 0, 0);
  clientfield::register("toplayer", "fireflies_attacking", 1, 1, "int", & fireflies_attacking, 0, 1);
  clientfield::register("toplayer", "fireflies_chasing", 1, 1, "int", & fireflies_chasing, 0, 1);
}

function getotherteam(team) {
  if(team == "allies") {
    return "axis";
  }
  if(team == "axis") {
    return "allies";
  }
  return "free";
}

function fireflies_attacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  if(newval) {
    self notify("stop_player_fx");
    if(self islocalplayer() && !self getinkillcam(localclientnum)) {
      fx = playfxoncamera(localclientnum, "weapon/fx_ability_firefly_attack_1p", (0, 0, 0), (1, 0, 0), (0, 0, 1));
      self thread watch_player_fx_finished(localclientnum, fx);
    }
  } else {
    self notify("stop_player_fx");
  }
}

function fireflies_chasing(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  if(newval) {
    self notify("stop_player_fx");
    if(self islocalplayer() && !self getinkillcam(localclientnum)) {
      fx = playfxoncamera(localclientnum, "weapon/fx_ability_firefly_chase_1p", (0, 0, 0), (1, 0, 0), (0, 0, 1));
      sound = self playloopsound("wpn_gelgun_hive_hunt_lp");
      self playrumblelooponentity(localclientnum, "firefly_chase_rumble_loop");
      self thread watch_player_fx_finished(localclientnum, fx, sound);
    }
  } else {
    self notify("stop_player_fx");
  }
}

function watch_player_fx_finished(localclientnum, fx, sound) {
  self util::waittill_any("entityshutdown", "stop_player_fx");
  if(isdefined(self)) {
    self stoprumble(localclientnum, "firefly_chase_rumble_loop");
  }
  if(isdefined(fx)) {
    stopfx(localclientnum, fx);
  }
  if(isdefined(sound) && isdefined(self)) {
    self stoploopsound(sound);
  }
}

function firefly_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isdefined(self)) {
    return;
  }
  if(!isdefined(self.initied)) {
    self thread firefly_init(localclientnum);
    self.initied = 1;
  }
  switch (newval) {
    case 0: {
      break;
    }
    case 1: {
      self firefly_deploying(localclientnum);
      break;
    }
    case 2: {
      self firefly_hunting(localclientnum);
      break;
    }
    case 3: {
      self firefly_attacking(localclientnum);
      break;
    }
    case 4: {
      self firefly_link_attacking(localclientnum);
      break;
    }
  }
}

function on_shutdown(localclientnum, ent) {
  if(isdefined(ent) && isdefined(ent.origin) && self === ent && (!(isdefined(self.no_death_fx) && self.no_death_fx))) {
    fx = playfx(localclientnum, "weapon/fx_hero_firefly_death", ent.origin, (0, 0, 1));
    setfxteam(localclientnum, fx, ent.team);
  }
}

function firefly_init(localclientnum) {
  self callback::on_shutdown( & on_shutdown, self);
}

function firefly_deploying(localclientnum) {
  fx = playfx(localclientnum, "weapon/fx_hero_firefly_start", self.origin, anglestoup(self.angles));
  setfxteam(localclientnum, fx, self.team);
}

function firefly_hunting(localclientnum) {
  fx = playfxontag(localclientnum, "weapon/fx_hero_firefly_hunting", self, "tag_origin");
  setfxteam(localclientnum, fx, self.team);
  self thread firefly_watch_fx_finished(localclientnum, fx);
}

function firefly_watch_fx_finished(localclientnum, fx) {
  self util::waittill_any("entityshutdown", "stop_effects");
  if(isdefined(fx)) {
    stopfx(localclientnum, fx);
  }
}

function firefly_attacking(localclientnum) {
  self notify("stop_effects");
  self.no_death_fx = 1;
}

function firefly_link_attacking(localclientnum) {
  fx = playfx(localclientnum, "weapon/fx_hero_firefly_start_entity", self.origin, anglestoup(self.angles));
  setfxteam(localclientnum, fx, self.team);
  self notify("stop_effects");
  self.no_death_fx = 1;
}

function gib_fx(localclientnum, fxfilename, gibflag) {
  fxtag = gibclientutils::playergibtag(localclientnum, gibflag);
  if(isdefined(fxtag)) {
    fx = playfxontag(localclientnum, fxfilename, self, fxtag);
    setfxteam(localclientnum, fx, getotherteam(self.team));
  }
}

function gib_corpse(localclientnum, value) {
  self endon("entityshutdown");
  self thread watch_for_gib_notetracks(localclientnum);
}

function watch_for_gib_notetracks(localclientnum) {
  self endon("entityshutdown");
  if(!util::is_mature() || util::is_gib_restricted_build()) {
    return;
  }
  fxfilename = "weapon/fx_hero_firefly_attack_limb";
  bodytype = self getcharacterbodytype();
  if(bodytype >= 0) {
    bodytypefields = getcharacterfields(bodytype, currentsessionmode());
    if((isdefined(bodytypefields.digitalblood) ? bodytypefields.digitalblood : 0)) {
      fxfilename = "weapon/fx_hero_firefly_attack_limb_reaper";
    }
  }
  arm_gib = 0;
  leg_gib = 0;
  while (true) {
    notetrack = self util::waittill_any_return("gib_leftarm", "gib_leftleg", "gib_rightarm", "gib_rightleg", "entityshutdown");
    switch (notetrack) {
      case "gib_rightarm": {
        arm_gib = arm_gib | 1;
        gib_fx(localclientnum, fxfilename, 16);
        self gibclientutils::playergibleftarm(localclientnum);
        self setcorpsegibstate(leg_gib, arm_gib);
        break;
      }
      case "gib_leftarm": {
        arm_gib = arm_gib | 2;
        gib_fx(localclientnum, fxfilename, 32);
        self gibclientutils::playergibleftarm(localclientnum);
        self setcorpsegibstate(leg_gib, arm_gib);
        break;
      }
      case "gib_rightleg": {
        leg_gib = leg_gib | 1;
        gib_fx(localclientnum, fxfilename, 128);
        self gibclientutils::playergibleftleg(localclientnum);
        self setcorpsegibstate(leg_gib, arm_gib);
        break;
      }
      case "gib_leftleg": {
        leg_gib = leg_gib | 2;
        gib_fx(localclientnum, fxfilename, 256);
        self gibclientutils::playergibleftleg(localclientnum);
        self setcorpsegibstate(leg_gib, arm_gib);
        break;
      }
      default: {
        break;
      }
    }
  }
}
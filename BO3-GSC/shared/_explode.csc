/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\_explode.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace explode;

function autoexec __init__sytem__() {
  system::register("explode", & __init__, undefined, undefined);
}

function __init__() {
  level.dirt_enable_explosion = getdvarint("scr_dirt_enable_explosion", 1);
  level.dirt_enable_slide = getdvarint("scr_dirt_enable_slide", 1);
  level.dirt_enable_fall_damage = getdvarint("scr_dirt_enable_fall_damage", 1);
  callback::on_localplayer_spawned( & localplayer_spawned);
  level thread updatedvars();
}

function updatedvars() {
  while(true) {
    level.dirt_enable_explosion = getdvarint("", level.dirt_enable_explosion);
    level.dirt_enable_slide = getdvarint("", level.dirt_enable_slide);
    level.dirt_enable_fall_damage = getdvarint("", level.dirt_enable_fall_damage);
    wait(1);
  }
}

function localplayer_spawned(localclientnum) {
  if(self != getlocalplayer(localclientnum)) {
    return;
  }
  if(level.dirt_enable_explosion || level.dirt_enable_slide || level.dirt_enable_fall_damage) {
    filter::init_filter_sprite_dirt(self);
    filter::disable_filter_sprite_dirt(self, 5);
    if(level.dirt_enable_explosion) {
      self thread watchforexplosion(localclientnum);
    }
    if(level.dirt_enable_slide) {
      self thread watchforplayerslide(localclientnum);
    }
    if(level.dirt_enable_fall_damage) {
      self thread watchforplayerfalldamage(localclientnum);
    }
  }
}

function watchforplayerfalldamage(localclientnum) {
  self endon("entityshutdown");
  seed = 0;
  xdir = 0;
  ydir = 270;
  while(true) {
    self waittill("fall_damage");
    self thread dothedirty(localclientnum, xdir, ydir, 1, 1000, 500);
  }
}

function watchforplayerslide(localclientnum) {
  self endon("entityshutdown");
  seed = 0;
  self.wasplayersliding = 0;
  xdir = 0;
  ydir = 6000;
  while(true) {
    self.isplayersliding = self isplayersliding();
    if(self.isplayersliding) {
      if(!self.wasplayersliding) {
        self notify("endthedirty");
        seed = randomfloatrange(0, 1);
      }
      filter::set_filter_sprite_dirt_opacity(self, 5, 1);
      filter::set_filter_sprite_dirt_seed_offset(self, 5, seed);
      filter::enable_filter_sprite_dirt(self, 5);
      filter::set_filter_sprite_dirt_source_position(self, 5, xdir, ydir, 1);
      filter::set_filter_sprite_dirt_elapsed(self, 5, getservertime(localclientnum));
    } else if(self.wasplayersliding) {
      self thread dothedirty(localclientnum, xdir, ydir, 1, 300, 300);
    }
    self.wasplayersliding = self.isplayersliding;
    wait(0.016);
  }
}

function dothedirty(localclientnum, right, up, distance, dirtduration, dirtfadetime) {
  self endon("entityshutdown");
  self notify("dothedirty");
  self endon("dothedirty");
  self endon("endthedirty");
  filter::enable_filter_sprite_dirt(self, 5);
  filter::set_filter_sprite_dirt_seed_offset(self, 5, randomfloatrange(0, 1));
  starttime = getservertime(localclientnum);
  currenttime = starttime;
  elapsedtime = 0;
  while(elapsedtime < dirtduration) {
    if(elapsedtime > (dirtduration - dirtfadetime)) {
      filter::set_filter_sprite_dirt_opacity(self, 5, (dirtduration - elapsedtime) / dirtfadetime);
    } else {
      filter::set_filter_sprite_dirt_opacity(self, 5, 1);
    }
    filter::set_filter_sprite_dirt_source_position(self, 5, right, up, distance);
    filter::set_filter_sprite_dirt_elapsed(self, 5, currenttime);
    wait(0.016);
    currenttime = getservertime(localclientnum);
    elapsedtime = currenttime - starttime;
  }
  filter::disable_filter_sprite_dirt(self, 5);
}

function watchforexplosion(localclientnum) {
  self endon("entityshutdown");
  while(true) {
    level waittill("explode", localclientnum, position, mod, weapon, owner_cent);
    explosiondistance = distance(self.origin, position);
    if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH" && explosiondistance < 600 && !getinkillcam(localclientnum) && !isthirdperson(localclientnum)) {
      cameraangles = self getcamangles();
      if(!isDefined(cameraangles)) {
        continue;
      }
      forwardvec = vectornormalize(anglesToForward(cameraangles));
      upvec = vectornormalize(anglestoup(cameraangles));
      rightvec = vectornormalize(anglestoright(cameraangles));
      explosionvec = vectornormalize(position - self getcampos());
      if(vectordot(forwardvec, explosionvec) > 0) {
        trace = bulletTrace(getlocalclienteyepos(localclientnum), position, 0, self);
        if(trace["fraction"] >= 0.9) {
          udot = -1 * vectordot(explosionvec, upvec);
          rdot = vectordot(explosionvec, rightvec);
          udotabs = abs(udot);
          rdotabs = abs(rdot);
          if(udotabs > rdotabs) {
            if(udot > 0) {
              udot = 1;
            } else {
              udot = -1;
            }
          } else {
            if(rdot > 0) {
              rdot = 1;
            } else {
              rdot = -1;
            }
          }
          self thread dothedirty(localclientnum, rdot, udot, 1 - (explosiondistance / 600), 2000, 500);
        }
      }
    }
  }
}
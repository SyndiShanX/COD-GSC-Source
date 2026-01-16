/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\exploder_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\sound_shared;
#using scripts\zm\_util;
#namespace fx;

function print_org(fxcommand, fxid, fxpos, waittime) {
  if(getdvarstring("") == "") {
    println("");
    println(((((("" + fxpos[0]) + "") + fxpos[1]) + "") + fxpos[2]) + "");
    println("");
    println("");
    println(("" + fxcommand) + "");
    println(("" + fxid) + "");
    println(("" + waittime) + "");
    println("");
  }
}

function gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

function gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  level endon("hash_ce9de5d2");
  wait(0.05);
  if(betweensetsmax < betweensetsmin) {
    temp = betweensetsmax;
    betweensetsmax = betweensetsmin;
    betweensetsmin = temp;
  }
  betweensetsbase = betweensetsmin;
  betweensetsrange = betweensetsmax - betweensetsmin;
  if(shotdelaymax < shotdelaymin) {
    temp = shotdelaymax;
    shotdelaymax = shotdelaymin;
    shotdelaymin = temp;
  }
  shotdelaybase = shotdelaymin;
  shotdelayrange = shotdelaymax - shotdelaymin;
  if(shotsmax < shotsmin) {
    temp = shotsmax;
    shotsmax = shotsmin;
    shotsmin = temp;
  }
  shotsbase = shotsmin;
  shotsrange = shotsmax - shotsmin;
  fxent = spawnfx(level._effect[fxid], fxpos);
  for (;;) {
    shotnum = shotsbase + randomint(shotsrange);
    for (i = 0; i < shotnum; i++) {
      triggerfx(fxent);
      wait(shotdelaybase + randomfloat(shotdelayrange));
    }
    wait(betweensetsbase + randomfloat(betweensetsrange));
  }
}

function gunfireloopfxvec(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  thread gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

function gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  level endon("hash_ce9de5d2");
  wait(0.05);
  if(betweensetsmax < betweensetsmin) {
    temp = betweensetsmax;
    betweensetsmax = betweensetsmin;
    betweensetsmin = temp;
  }
  betweensetsbase = betweensetsmin;
  betweensetsrange = betweensetsmax - betweensetsmin;
  if(shotdelaymax < shotdelaymin) {
    temp = shotdelaymax;
    shotdelaymax = shotdelaymin;
    shotdelaymin = temp;
  }
  shotdelaybase = shotdelaymin;
  shotdelayrange = shotdelaymax - shotdelaymin;
  if(shotsmax < shotsmin) {
    temp = shotsmax;
    shotsmax = shotsmin;
    shotsmin = temp;
  }
  shotsbase = shotsmin;
  shotsrange = shotsmax - shotsmin;
  fxpos2 = vectornormalize(fxpos2 - fxpos);
  fxent = spawnfx(level._effect[fxid], fxpos, fxpos2);
  for (;;) {
    shotnum = shotsbase + randomint(shotsrange);
    for (i = 0; i < (int(shotnum / level.fxfireloopmod)); i++) {
      triggerfx(fxent);
      delay = (shotdelaybase + randomfloat(shotdelayrange)) * level.fxfireloopmod;
      if(delay < 0.05) {
        delay = 0.05;
      }
      wait(delay);
    }
    wait(shotdelaybase + randomfloat(shotdelayrange));
    wait(betweensetsbase + randomfloat(betweensetsrange));
  }
}

function grenadeexplosionfx(pos) {
  playfx(level._effect["mechanical explosion"], pos);
  earthquake(0.15, 0.5, pos, 250);
}
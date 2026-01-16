/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\fx.gsc
***********************************************/

#include scripts\core_common\exploder_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\struct;
#include scripts\zm_common\util;

#namespace fx;

print_org(fxcommand, fxid, fxpos, waittime) {
  if(getdvarint(#"debug", 0)) {
    println("<dev string:x38>");
    println("<dev string:x3c>" + fxpos[0] + "<dev string:x49>" + fxpos[1] + "<dev string:x49>" + fxpos[2] + "<dev string:x4d>");
    println("<dev string:x51>");
    println("<dev string:x6e>");
    println("<dev string:x7d>" + fxcommand + "<dev string:x4d>");
    println("<dev string:x94>" + fxid + "<dev string:x4d>");
    println("<dev string:xa6>" + waittime + "<dev string:x4d>");
    println("<dev string:xb9>");
  }
}

  function gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
  }

gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  level endon(#"stop all gunfireloopfx");
  waitframe(1);

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

  for(;;) {
    shotnum = shotsbase + randomint(shotsrange);

    for(i = 0; i < shotnum; i++) {
      triggerfx(fxent);
      wait shotdelaybase + randomfloat(shotdelayrange);
    }

    wait betweensetsbase + randomfloat(betweensetsrange);
  }
}

gunfireloopfxvec(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  thread gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
  level endon(#"stop all gunfireloopfx");
  waitframe(1);

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

  for(;;) {
    shotnum = shotsbase + randomint(shotsrange);

    for(i = 0; i < int(shotnum / level.fxfireloopmod); i++) {
      triggerfx(fxent);
      delay = (shotdelaybase + randomfloat(shotdelayrange)) * level.fxfireloopmod;

      if(delay < 0.05) {
        delay = 0.05;
      }

      wait delay;
    }

    wait shotdelaybase + randomfloat(shotdelayrange);
    wait betweensetsbase + randomfloat(betweensetsrange);
  }
}

grenadeexplosionfx(pos) {
  playFX(level._effect[#"mechanical explosion"], pos);
  earthquake(0.15, 0.5, pos, 250);
}
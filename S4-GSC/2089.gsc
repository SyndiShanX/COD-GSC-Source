/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2089.gsc
*************************************************/

_id_9487() {
  wait 0.05;
  setomnvar("winner_circle_lgt_dvars", 1);
  level notify("winner_start");

  if(isDefined(level._id_59D6)) {
    visionsetnaked("", 0);
    wait 0.05;
    visionsetnaked(level._id_59D6, 0);
  }

  level waittill("winner_end");
  setomnvar("winner_circle_lgt_dvars", 0);
}

_id_9488() {
  setomnvar("winner_circle_lgt_dvars", 1);
  level notify("winner_start");

  if(isDefined(level._id_10E5E)) {
    visionsetnaked("", 0);
    wait 0.05;
    visionsetnaked(level._id_10E5E, 0);
  }

  if(isDefined(level.sunvfx)) {
    scripts\engine\utility::_id_8D1F(level.sunvfx);
  }

  level waittill("winner_end");
  setomnvar("winner_circle_lgt_dvars", 0);
}
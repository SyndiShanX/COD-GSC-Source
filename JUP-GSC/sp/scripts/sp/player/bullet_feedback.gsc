/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\bullet_feedback.gsc
*************************************************/



#using scripts\common\whizby;
#using scripts\engine\utility;
#namespace bullet_feedback;

function bullet_feedback_init() {
  scripts\common\whizby::init();
  level.player ent_flag_init("pause_suppression");
  level.player thread bulletwhizby_monitor();
  level.player scripts\common\whizby::initplayer();
}

function bulletwhizby_monitor() {
  self endon("death");

  while(true) {
    self waittill("bulletwhizby", attacker, distance, position, forward);

    if(!shoulddobulletwhizby()) {
      continue;
    }

    scripts\common\whizby::whizbyeffect(attacker, distance, position, forward);
  }
}

function shoulddobulletwhizby() {
  if(ent_flag("pause_suppression")) {
    return false;
  }

  return true;
}
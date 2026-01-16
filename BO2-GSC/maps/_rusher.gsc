/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_rusher.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#include animscripts\anims_table;
#include animscripts\anims_table_rusher;

init_rusher() {
  level.rusher_default_goalradius = 64;
  level.rusher_default_pathenemydist = 200;
  level.rusher_pistol_pathenemydist = 300;
}

rush(endon_flag, timeout) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.rusher)) {
    return;
  }
  self.rusher = 1;
  self set_rusher_type();

  if(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))
    disable_cqb();

  self.a.neversprintforvariation = 1;
  self.noheatanims = 1;
  self.disablereact = 1;
  self disable_tactical_walk();
  self setup_rusher_anims();
  self.oldgoalradius = self.goalradius;
  self.goalradius = level.rusher_default_goalradius;

  if(self.rushertype == "pistol") {
    self.a.fakepistolweaponanims = 1;
    self.oldpathenemyfightdist = self.pathenemyfightdist;
    self.pathenemyfightdist = level.rusher_pistol_pathenemydist;
  } else {
    self.oldpathenemyfightdist = self.pathenemyfightdist;
    self.pathenemyfightdist = level.rusher_default_pathenemydist;
    self.disableexits = 1;
    self.disablearrivals = 1;
  }

  self disable_react();
  self.ignoresuppression = 1;
  self.health = self.health + 100;
  player = get_closest_player(self.origin);
  self.favoriteenemy = player;
  self.rushing_goalent = spawn("script_origin", player.origin);
  self.rushing_goalent linkto(player);
  self thread keep_rushing_player();
  self thread rusher_yelling();

  if(isDefined(endon_flag) || isDefined(timeout))
    self thread rusher_go_back_to_normal(endon_flag, timeout);
}

rusher_go_back_to_normal(endon_flag, timeout, b_stop_immediately) {
  if(!isDefined(b_stop_immediately))
    b_stop_immediately = 0;

  self endon("death");

  if(!b_stop_immediately) {
    if(isDefined(timeout))
      self thread notifytimeout(timeout, 0, "stop_rushing_timeout");

    if(!isDefined(endon_flag))
      endon_flag = "nothing";

    self waittill_any(endon_flag, "stop_rushing_timeout");
  }

  self notify("stop_rushing");
  self rusher_reset();
}

rusher_reset() {
  self reset_rusher_anims();
  self.rusher = 0;
  self.goalradius = self.oldgoalradius;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.moveplaybackrate = 1;
  self enable_react();
  self.ignoresuppression = 0;
  self.disableexits = 0;
  self.disablearrivals = 0;
  self.rushing_goalent delete();
}

keep_rushing_player() {
  self endon("death");
  self endon("stop_rushing");

  while(true) {
    self setgoalentity(self.rushing_goalent);
    self thread notifytimeout(8, 1, "timeout");
    self waittill_any("goal", "timeout");
  }
}

notifytimeout(timeout, endon_goal, notify_string) {
  self endon("death");
  self endon("stop_rushing");

  if(isDefined(endon_goal) && endon_goal)
    self endon("goal");

  wait(timeout);
  self notify(notify_string);
}

rusher_yelling() {
  self endon("death");
  self endon("stop_rushing");

  if(isDefined(self.norusheryell) && self.norusheryell) {
    return;
  }
  while(true) {
    wait(randomfloatrange(1, 3));
    self playsound("chr_npc_charge_viet");
  }
}

set_rusher_type() {
  if(self usingshotgun()) {
    self.rushertype = "shotgun";
    self.perfectaim = 1;
    self.norusheryell = 1;
    self.nowoundedrushing = 1;
  } else if(self usingpistol()) {
    self.rushertype = "pistol";
    self.norusheryell = 1;
    self.nowoundedrushing = 1;
  } else {
    self.rushertype = "default";

    if(self.animtype == "spetsnaz") {
      self.norusheryell = 1;
      self.nowoundedrushing = 1;
    }
  }
}
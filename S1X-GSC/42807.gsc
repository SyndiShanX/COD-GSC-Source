/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42807.gsc
**************************************/

monitor_exocrossbow_launch() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  level._effect["exocrossbow_sticky_explosion"] = loadfx("vfx/explosion/frag_grenade_default");
  level._effect["exocrossbow_sticky_blinking"] = loadfx("vfx/lights/light_beacon_crossbow");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    var_2 = 0;

    if(issubstr(var_1, "iw5_exocrossbow")) {
      var_2 = 1;
    } else if(issubstr(var_1, "dlcgun11loot0")) {
      var_2 = 1;
    }

    if(!var_2) {
      continue;
    }
    var_0 setotherent(self);
    var_0.ch_crossbow_player_jumping = self ishighjumping();
    thread wait_for_stuck(var_0);
  }
}

wait_for_stuck(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);
  var_0 thread determine_sticky_position(self, var_1);
}

determine_sticky_position(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("faux_spawn");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1) && !maps\mp\_utility::invirtuallobby() && isplayer(var_1)) {
    self.ch_crossbow_victim_jumping = var_1 ishighjumping();

    if(var_0 maps\mp\gametypes\_weapons::isstucktofriendly(var_1)) {
      self.isstuck = "friendly";
    } else {
      self.isstuck = "enemy";
      self.stuckenemyentity = var_1;
      var_0 maps\mp\_events::crossbowstickevent(var_1);
      var_0 notify("process", "ch_bullseye");
    }
  }

  thread sticky_timer(var_0);
  thread sticky_fx(var_0);
  thread remove_sticky_on_explosion(var_0);
  thread cleanup_sticky_on_death();
  thread maps\mp\gametypes\_weapons::stickyhandlemovers("detonate");
}

sticky_timer(var_0) {
  self endon("death");
  wait 1.5;
  self notify("exocrossbow_exploded");
}

sticky_fx(var_0) {
  self endon("exocrossbow_exploded");
  self endon("death");
  self.fx_origin = common_scripts\utility::spawn_tag_origin();
  self.fx_origin.origin = self.origin;
  self.fx_origin.angles = self.angles;
  self.fx_origin show();
  self.fx_origin linkto(self);
  wait 0.1;
  playFXOnTag(common_scripts\utility::getfx("exocrossbow_sticky_blinking"), self.fx_origin, "tag_origin");
  self playSound("exocrossbow_warning");
}

remove_sticky_on_explosion(var_0) {
  self endon("death");
  self waittill("exocrossbow_exploded");
  cleanup_sticky();
}

cleanup_sticky_on_death() {
  self endon("exocrossbow_exploded");
  self waittill("death");
  cleanup_sticky();
}

cleanup_sticky() {
  stopFXOnTag(common_scripts\utility::getfx("exocrossbow_sticky_blinking"), self.fx_origin, "tag_origin");
  self.fx_origin delete();
}
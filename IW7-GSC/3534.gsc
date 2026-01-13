/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3534.gsc
************************/

func_139F9() {
  self endon("death");
  self endon("disconnect");
  self notify("setDodge");
  self endon("setDodge");
  self endon("removeArchetype");
  thread func_5802();
  for(;;) {
    self waittill("dodgeBegin");
    scripts\mp\utility::printgameaction("dodge", self);
    if(isDefined(self.controlsfrozen) && self.controlsfrozen == 1) {
      continue;
    }

    if(isDefined(self.usingremote) && self.usingremote != "") {
      continue;
    }

    self.dodging = 1;
    scripts\mp\missions::func_D991("ch_scout_dodge_uses");
    if(scripts\mp\utility::_hasperk("specialty_dodge_defense")) {
      self setclientomnvar("ui_light_armor", 1);
    }

    thread func_139FB();
    var_0 = self getnormalizedmovement();
    for(;;) {
      if(var_0[0] > 0) {
        if(var_0[1] <= 0.7 && var_0[1] >= -0.7) {
          self setscriptablepartstate("dodge", "dodge_forward");
          break;
        }

        if(var_0[0] > 0.5 && var_0[1] > 0.7) {
          self setscriptablepartstate("dodge", "dodge_forward_right");
          break;
        }

        if(var_0[0] > 0.5 && var_0[1] < -0.7) {
          self setscriptablepartstate("dodge", "dodge_forward_left");
          break;
        }
      }

      if(var_0[0] < 0) {
        if(var_0[1] < 0.4 && var_0[1] > -0.4) {
          self setscriptablepartstate("dodge", "dodge_back");
          break;
        }

        if(var_0[0] < -0.5 && var_0[1] > 0.5) {
          self setscriptablepartstate("dodge", "dodge_back_right");
          break;
        }

        if(var_0[0] < -0.5 && var_0[1] < -0.5) {
          self setscriptablepartstate("dodge", "dodge_back_left");
          break;
        }
      }

      if(var_0[1] > 0.4) {
        self setscriptablepartstate("dodge", "dodge_right");
        break;
      }

      if(var_0[1] < -0.4) {
        self setscriptablepartstate("dodge", "dodge_left");
        break;
      } else {
        break;
      }
    }

    if(isDefined(self.var_5809)) {
      triggerfx(self.var_5809);
    }

    foreach(var_2 in level.players) {
      if(isDefined(var_2) && var_2 != self) {
        playfxontagforclients(level._effect["dash_trail"], self, "tag_shield_back", var_2);
      }
    }

    if(!self isjumping()) {}

    self playlocalsound("synaptic_dash");
    self playSound("synaptic_dash_npc");
    wait(1.5);
    self setscriptablepartstate("dodge", "default");
  }
}

func_5802() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self endon("setDodge");
  for(;;) {
    var_0 = self goal_position(1);
    var_1 = self energy_getmax(1);
    if(var_0 >= var_1) {
      self setclientomnvar("ui_dodge_charges", 1);
    } else {
      self setclientomnvar("ui_dodge_charges", 0);
    }

    wait(0.05);
  }
}

func_139FB() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("dodgeEnd", "death", "disconnect");
  self.dodging = 0;
  if(scripts\mp\utility::_hasperk("specialty_dodge_defense")) {
    self setclientomnvar("ui_light_armor", 0);
  }

  if(isDefined(self)) {
    stopFXOnTag(level._effect["dash_trail"], self, "tag_shield_back");
  }

  if(isDefined(self.var_5809)) {
    self.var_5809 delete();
  }
}
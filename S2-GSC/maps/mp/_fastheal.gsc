/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_fastheal.gsc
*********************************************/

func_A908() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  if(!isDefined(level.var_3A58)) {
    func_3A57();
  }

  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "fast_heal_mp") {
      if(!isalive(self)) {
        var_00 delete();
        return;
      }

      thread func_9E29();
    }
  }
}

func_3A57() {
  self.var_3A58 = spawnStruct();
}

func_9E29() {
  if(!isDefined(self.var_3A58)) {
    func_3A57();
  }

  func_7D5D();
  thread func_92CC();
  thread func_63BF();
  return 1;
}

func_92CC() {
  self endon("ClearFastHeal");
  self endon("death");
  self method_8615("earn_superbonus");
  self.var_56E9 = 1;
  self.var_50A0 = 1;
  self.var_98E1 = 1.5;
  self.var_98E2 = 13.33;
  self notify("damage");
  wait(10);
  self.var_98E1 = undefined;
  self.var_98E2 = undefined;
  self.var_56E9 = 0;
  if(isDefined(self.var_3A58.var_6CA4)) {
    self.var_3A58.var_6CA4 destroy();
  }

  self notify("EndFastHeal");
}

func_7D5D() {
  if(isDefined(self.var_56E9) && self.var_56E9 == 1) {
    if(isDefined(self.var_3A58.var_6CA4)) {
      self.var_3A58.var_6CA4 destroy();
    }

    self.var_98E1 = undefined;
    self.var_98E2 = undefined;
    self notify("ClearFastHeal");
  }
}

func_63BF() {
  self endon("EndFastHeal");
  self waittill("death");
  self.var_98E1 = undefined;
  self.var_98E2 = undefined;
  self.var_56E9 = 0;
  if(isDefined(self.var_3A58.var_6CA4)) {
    self.var_3A58.var_6CA4 destroy();
  }
}

func_7723() {
  self endon("EndFastHeal");
  self endon("death");
  for(;;) {
    iprintlnbold(self.var_00BC);
    wait(1);
  }
}
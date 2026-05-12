/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_assassin_aud.gsc
***************************************************/

init_assassin_aud_state_info() {
  self endon("death");
  wait 0.05;
  self.assassinaudioinformation = spawnStruct();
  self.assassinaudioinformation.players_near = [];
  self.assassinaudioinformation.players_far = [];
  self.assassinaudioinformation.isagressive = [];
  self.assassinaudioinformation.isrunningaway = [];
  childthread update_assassin_audio_info();
}

update_assassin_audio_info() {
  var_00 = 0.125;
  for(;;) {
    self.assassinaudioinformation.players_near = [];
    self.assassinaudioinformation.players_far = [];
    foreach(var_02 in level.var_744A) {
      if(distance(self.var_116, var_02.var_116) > 700) {
        self.assassinaudioinformation.players_far = common_scripts\utility::func_F6F(self.assassinaudioinformation.players_far, var_02);
      } else {
        self.assassinaudioinformation.players_near = common_scripts\utility::func_F6F(self.assassinaudioinformation.players_near, var_02);
      }

      self.assassinaudioinformation.isagressive = common_scripts\utility::func_3794("zmb_assassin_is_alarmed");
      self.assassinaudioinformation.isrunningaway = common_scripts\utility::func_3794("Phase 4: EXITING");
    }

    wait(var_00);
  }
}
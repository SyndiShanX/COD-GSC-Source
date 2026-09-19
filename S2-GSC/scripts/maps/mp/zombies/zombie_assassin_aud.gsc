/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin_aud.gsc
***********************************************************/

init_assassin_aud_state_info() {
  self endon("death");
  waitframe();
  self.assassinaudioinformation = spawnStruct();
  self.assassinaudioinformation.players_near = [];
  self.assassinaudioinformation.players_far = [];
  self.assassinaudioinformation.isagressive = [];
  self.assassinaudioinformation.isrunningaway = [];
  childthread update_assassin_audio_info();
}

update_assassin_audio_info() {
  var_0 = 0.125;

  for(;;) {
    self.assassinaudioinformation.players_near = [];
    self.assassinaudioinformation.players_far = [];

    foreach(var_2 in level.players) {
      if(distance(self.origin, var_2.origin) > 700)
        self.assassinaudioinformation.players_far = common_scripts\utility::_id_0F6F(self.assassinaudioinformation.players_far, var_2);
      else
        self.assassinaudioinformation.players_near = common_scripts\utility::_id_0F6F(self.assassinaudioinformation.players_near, var_2);

      self.assassinaudioinformation.isagressive = common_scripts\utility::_id_3794("zmb_assassin_is_alarmed");
      self.assassinaudioinformation.isrunningaway = common_scripts\utility::_id_3794("Phase 4: EXITING");
    }

    wait(var_0);
  }
}
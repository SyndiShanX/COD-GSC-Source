/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_m_king_create_script.gsc
*************************************************/

bot_ctf_player_has_flag(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 1;
  return var_4;
}

bot_ctf_my_team_flag_is_picked_up(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 3;
  return var_4;
}

bot_ctf_player_always_attacker(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.bot_ctf_recover_flag;
  var_5 = abs(var_4 getturretcurrentpitch());
  var_6 = abs(var_4 getturretcurrentyaw());
  var_7 = var_5 < 0.1 && var_6 < 0.1;
  return var_7;
}

_id_1244A(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;
  scripts\common\ai::bot_ctf_flag_picked_up_of_team();
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

_id_12447(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;
  var_4 = var_3 gettagorigin("_encstr_92BA0B78CA075F093F9EC04D7A");
  var_5 = var_3 gettagangles("_encstr_92BA0B78CA075F093F9EC04D7A");

  if(self islinked())
    self unlink();

  var_3.inuse = 1;
  var_3 setturretteam(self.team);
  var_3 setmode("_encstr_97910BA3154320F8EBBA8811A2");
  self forceteleport(var_4, var_5);
  self linktoblendtotag(var_3, "_encstr_92BA0B78CA075F093F9EC04D7A", 0);
  self useturret(var_3);
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

_id_12445(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;
  var_3.inuse = 0;
  var_3 setturretteam("_encstr_A7A408B9CA5D1D4E2C63");
  var_3 setmode("_encstr_849007B268BD03DFD8");
  self stopuseturret();
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

_id_12446(var_0, var_1, var_2) {
  if(self islinked())
    self unlink();

  scripts\common\ai::bot_ctf_flag_is_home_of_team();
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

_id_1245D(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;

  if(isDefined(var_3)) {
    var_3.inuse = 0;
    var_3 setturretteam("_encstr_A7A408B9CA5D1D4E2C63");
    var_3 setmode("_encstr_849007B268BD03DFD8");
  }

  scripts\asm\soldier\death::playdeathanim(var_0, var_1, var_2);
}
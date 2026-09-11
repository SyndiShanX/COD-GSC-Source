/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_m_king_create_script.gsc
*********************************************************/

function bot_ctf_player_has_flag(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 1;
  return var_4;
}

function bot_ctf_my_team_flag_is_picked_up(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 3;
  return var_4;
}

function bot_ctf_player_always_attacker(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.bot_ctf_recover_flag;
  var_5 = abs(var_4 getturretcurrentpitch());
  var_6 = abs(var_4 getturretcurrentyaw());
  var_7 = var_5 < 0.1 && var_6 < 0.1;
  return var_7;
}

function ref_1244a(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;
  scripts\common\ai::bot_ctf_flag_picked_up_of_team();
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

function ref_12447(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;
  var_4 = var_3 gettagorigin("tag_gunner");
  var_5 = var_3 gettagangles("tag_gunner");

  if(self islinked()) {
    self unlink();
  }

  var_3.inuse = 1;
  var_3 setturretteam(self.team);
  var_3 setmode("auto_nonai");
  self forceteleport(var_4, var_5);
  self linktoblendtotag(var_3, "tag_gunner", 0);
  self useturret(var_3);
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

function ref_12445(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;
  var_3.inuse = 0;
  var_3 setturretteam("neutral");
  var_3 setmode("manual");
  self stopuseturret();
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

function ref_12446(var_0, var_1, var_2) {
  if(self islinked()) {
    self unlink();
  }

  scripts\common\ai::bot_ctf_flag_is_home_of_team();
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

function ref_1245d(var_0, var_1, var_2) {
  var_3 = self._blackboard.bot_ctf_recover_flag;

  if(isDefined(var_3)) {
    var_3.inuse = 0;
    var_3 setturretteam("neutral");
    var_3 setmode("manual");
  }

  scripts\asm\soldier\death::playdeathanim(var_0, var_1, var_2);
}
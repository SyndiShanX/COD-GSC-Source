/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_m_king_create_script.gsc
*********************************************************/

function bot_ctf_player_has_flag(var0, var1, var2, var3) {
  var4 = isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 1;
  return var4;
}

function bot_ctf_my_team_flag_is_picked_up(var0, var1, var2, var3) {
  var4 = isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 3;
  return var4;
}

function bot_ctf_player_always_attacker(var0, var1, var2, var3) {
  var4 = self._blackboard.bot_ctf_recover_flag;
  var5 = abs(var4 getturretcurrentpitch());
  var6 = abs(var4 getturretcurrentyaw());
  var7 = var5 < 0.1 && var6 < 0.1;
  return var7;
}

function ref_1244a(var0, var1, var2) {
  var3 = self._blackboard.bot_ctf_recover_flag;
  scripts\common\ai::bot_ctf_flag_picked_up_of_team();
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function ref_12447(var0, var1, var2) {
  var3 = self._blackboard.bot_ctf_recover_flag;
  var4 = var3 gettagorigin("tag_gunner");
  var5 = var3 gettagangles("tag_gunner");

  if(self islinked()) {
    self unlink();
  }

  var3.inuse = 1;
  var3 setturretteam(self.team);
  var3 setmode("auto_nonai");
  self forceteleport(var4, var5);
  self linktoblendtotag(var3, "tag_gunner", 0);
  self useturret(var3);
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function ref_12445(var0, var1, var2) {
  var3 = self._blackboard.bot_ctf_recover_flag;
  var3.inuse = 0;
  var3 setturretteam("neutral");
  var3 setmode("manual");
  self stopuseturret();
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function ref_12446(var0, var1, var2) {
  if(self islinked()) {
    self unlink();
  }

  scripts\common\ai::bot_ctf_flag_is_home_of_team();
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function ref_1245d(var0, var1, var2) {
  var3 = self._blackboard.bot_ctf_recover_flag;

  if(isDefined(var3)) {
    var3.inuse = 0;
    var3 setturretteam("neutral");
    var3 setmode("manual");
  }

  scripts\asm\soldier\death::playdeathanim(var0, var1, var2);
}
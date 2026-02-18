/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4d984e2ed26bb2d9.gsc
***********************************************/

#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\values_shared;
#using scripts\cp_common\snd;
#namespace namespace_1d6bb8b4;

function postload() {
  level.var_17d7d4dc = spawnStruct();
  level.var_17d7d4dc.var_d337de55 = 1;
  var_121c5e14 = getent("vault_lift", "targetname");
  level.var_17d7d4dc.var_121c5e14 = var_121c5e14;
  var_5a8a0179 = getent(var_121c5e14.target, "targetname");
  var_5a8a0179 linkto(var_121c5e14);
  var_5a8a0179 notsolid();
  level.var_17d7d4dc.var_5a8a0179 = var_5a8a0179;
  var_1c0f5f3 = struct::get(var_121c5e14.target2, "targetname");
  level.var_17d7d4dc.v_angle_offset = var_121c5e14.angles - var_1c0f5f3.angles;
  var_121c5e14.var_1c0f5f3 = var_1c0f5f3;
}

function function_3b57a70e() {
  e_player = getplayers()[0];
  e_player.var_37936369 = 1;
  e_player function_f1218e92();
  snd::client_msg("audio_server_lift_start");
  level.ai_woods linkto(level.var_17d7d4dc.var_121c5e14);
  level.ai_woods thread scene::play("scene_yam_8020_sra_server_ascent_woods");
  level scene::play("scene_yam_8015_sra_server_ascent", array(level.e_server_cable, level.var_ebbd5cf8, level.e_server_hook, level.var_17d7d4dc.var_121c5e14));
  level notify(#"hash_3c878f4d1248ed7f");
  level thread scene::play("scene_yam_9010_out_heli_outro", array(level.e_server_cable, level.var_ebbd5cf8, level.e_server_hook, level.var_17d7d4dc.var_121c5e14));
  level.ai_woods thread scene::play("scene_yam_9010_out_heli_outro_woods", level.ai_woods);
}

function private function_f1218e92() {
  str_stance = self getstance();

  switch (str_stance) {
    case # "crouch":
      self setstance("stand");
      wait 0.2;
      break;
    case # "prone":
      self setstance("stand");
      wait 1;
      break;
  }

  self val::set("vault_lift", "allow_jump", 0);
  self val::set("vault_lift", "allow_sprint", 0);
  self val::set("vault_lift", "allow_prone", 0);
  self setmovespeedscale(0.7);
  self playersetgroundreferenceent(level.var_17d7d4dc.var_121c5e14, 1);
}

function private function_a84c9b37(e_player) {
  level endon(#"game_ended");
  level.var_17d7d4dc.var_5a8a0179 solid();
  earthquake(0.15, 1.5, e_player.origin, 100);
  self function_8d2ab330(1.7, undefined, 0.8, 0);
  self function_8d2ab330(1.3);
  self function_8d2ab330(0.9);
  self function_8d2ab330(0.7);
  earthquake(0.85, 1, e_player.origin, 100);
  earthquake(0.35, 2, e_player.origin, 100);
  e_player applyknockback(40, anglestoright(self.var_1c0f5f3.angles));
  self function_8d2ab330(1.25);
  self function_8d2ab330(0.35);
  e_player applyknockback(30, anglestoright(self.var_1c0f5f3.angles) * -1);
  self function_8d2ab330(0.3);
  self function_8d2ab330(0.3, undefined, 0, 0.2);
  earthquake(0.15, 4, e_player.origin, 100);
  self function_8d2ab330(1.4, undefined, 0.8, 0);
  self function_8d2ab330(1.2);
  self function_8d2ab330();
  self function_8d2ab330(0.8, undefined, 0.2, 0.6);
  earthquake(0.15, 4, e_player.origin, 100);
  self function_8d2ab330(0.9, undefined);
  self function_8d2ab330(1.3, undefined, 0.2, 0.6);
  earthquake(0.15, 4, e_player.origin, 100);
  self function_8d2ab330(1.5);
  self function_8d2ab330(1.2);
  self function_8d2ab330(1);
  self function_8d2ab330(0.8);
  earthquake(1, 1.5, e_player.origin, 100);
  self function_8d2ab330(0.25);
  e_player applyknockback(100, anglesToForward(self.var_1c0f5f3.angles) * -1 * anglestoup(self.var_1c0f5f3.angles));
  self function_8d2ab330(0.2);
  self function_8d2ab330(0.2, undefined, 0, 0.1);
  earthquake(0.15, 1.5, e_player.origin, 100);
  self function_8d2ab330(1.4, undefined, 0.8, 0);
  self function_8d2ab330(1.4);
  level notify(#"hash_253c2c69fe0a2dbe");
  level waittill(#"hash_67c4a38cb2c8b9d0");

  iprintlnbold("<dev string:x38>");

  e_player.var_37936369 = 0;
  e_player notify(#"hash_3725134b3e724575");
  level notify(#"hash_3725134b3e724575");
  e_player val::reset_all("vault_lift");
  e_player setmovespeedscale(1);
}

function private function_8d2ab330(var_2c00bd33 = 1, var_8c0ade1d = undefined, var_2c9a2558 = 0, var_993f10a2 = 0) {
  var_1c0f5f3 = self.var_1c0f5f3;
  level notify(var_1c0f5f3.targetname + "_complete");
  self.var_1c0f5f3 = function_44fc18c(var_1c0f5f3.target, self);
  var_1c0f5f3 = self.var_1c0f5f3;

  if(isDefined(var_8c0ade1d)) {
    n_move_time = var_8c0ade1d;
  } else {
    n_move_time = var_1c0f5f3.n_move_time * var_2c00bd33;
  }

  self moveto(var_1c0f5f3.origin, n_move_time, n_move_time * var_2c9a2558, n_move_time * var_993f10a2);
  self rotateto(var_1c0f5f3.angles + level.var_17d7d4dc.v_angle_offset, n_move_time);
  self waittill(#"movedone");
}

function private function_44fc18c(str_targetname, var_6641f28e) {
  s_return = struct::get(str_targetname, "targetname");

  if(isDefined(s_return)) {
    s_return.n_move_time = distance(var_6641f28e.origin, s_return.origin) * 0.032;
  }

  return s_return;
}
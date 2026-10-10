/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_8cd9c937ed5832c.gsc
************************************************/

#using script_1c8bc690442e0123;
#using script_49933f4f48d029a1;
#namespace namespace_ee1dacfbea82d21d;

function function_7fa382ebd44ac411() {
  level.var_6f626f29ffd28538 = spawnStruct();
  level.var_6f626f29ffd28538.steps = [];
  level.var_6f626f29ffd28538.currentstep = 1;
  level.var_6f626f29ffd28538.var_5f5f6fb97e94ac59 = 0;
  level.var_6f626f29ffd28538.matchcompleted = 0;
  addstep("infil", &infilsequence, undefined);
  addstep("initial_execution", &function_be0865890f99c70e, undefined);
  addstep("gamepad_prompt", &function_20e6c27a91c3accd, undefined);
  addstep("spawn_forward_lock_1", &function_f68e1a166600bcdf, "forward_lock_1");
  addstep("move_camera", &function_49cab10caac7c6cd, undefined);
  addstep("move_to_pos_0", &function_91b5b282cb2b18fc, 0);
  addstep("look_at_weapon", &function_931dc024b9a4425d, undefined);
  addstep("pick_up_weapon", &function_6c00d659b72888bf, undefined);
  addstep("despawn_forward_lock_1", &function_ec363f75c60d5900, "forward_lock_1");
  addstep("spawn_forward_lock_2", &function_f68e1a166600bcdf, "forward_lock_2");
  addstep("pick_up_ammo", &function_4b422fdc1b596ef9, undefined);
  addstep("autofire_prompt", &function_ee69c387d92c4b38, undefined);
  addstep("kill_with_autofire", &function_b6001ea887635de4, level.ftuedata.enemygroups.autofire);
  addstep("reload", &reloadstep, undefined);
  addstep("armor_up", &function_8ab6a96b2278d5cf, undefined);
  addstep("despawn_forward_lock_2", &function_ec363f75c60d5900, "forward_lock_2");
  addstep("spawn_forward_lock_3", &function_f68e1a166600bcdf, "forward_lock_3");
  addstep("move_to_pos_1", &function_91b5b282cb2b18fc, 1);
  addstep("spawn_backward_lock_1", &function_f68e1a166600bcdf, "backward_lock_1");
  addstep("aim_with_ads", &function_ed36379da3790cba, undefined);
  addstep("despawn_forward_lock_3", &function_ec363f75c60d5900, "forward_lock_3");
  addstep("spawn_forward_lock_4", &function_f68e1a166600bcdf, "forward_lock_4");
  addstep("kill_with_ads", &killwithads, level.ftuedata.enemygroups.ads);
  addstep("exit_ads", &function_7931a9f93d82dd27, undefined);
  addstep("despawn_forward_lock_4", &function_ec363f75c60d5900, "forward_lock_4");
  addstep("spawn_forward_lock_5", &function_f68e1a166600bcdf, "forward_lock_5");
  addstep("move_to_pos_2", &function_91b5b282cb2b18fc, 2);
  addstep("spawn_backward_lock_2", &function_f68e1a166600bcdf, "backward_lock_2");
  addstep("manualfire_prompt", &function_463d388fed95c483, undefined);
  addstep("kill_with_manualfire", &function_a31a8245682550c1, level.ftuedata.enemygroups.manualfire);
  addstep("choose_firemode_prompt", &function_de9508d62f36ec59, undefined);
  addstep("despawn_forward_lock_5", &function_ec363f75c60d5900, "forward_lock_5");
  addstep("spawn_forward_lock_6", &function_f68e1a166600bcdf, "forward_lock_6");
  addstep("final_combat", &combatstep, level.ftuedata.enemygroups.combat);
  addstep("heli_destruction", &function_e48318bd7516fde6, undefined);
  addstep("despawn_forward_lock_6", &function_ec363f75c60d5900, "forward_lock_6");
  addstep("move_to_pos_3", &function_91b5b282cb2b18fc, 3);
  addstep("end_match", &function_ab5ab2886323a8a5, undefined);
}

function function_c53f0344e549edd5() {
  level endon("game_ended");
  function_56ddff8548c968d6();

  for(i = 0; i < level.var_6f626f29ffd28538.steps.size; i++) {
    startstep(level.var_6f626f29ffd28538.steps[i]);
  }
}
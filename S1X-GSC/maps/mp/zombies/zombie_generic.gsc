/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_generic.gsc
**********************************************/

init() {
  level.agent_funcs["zombie_generic"] = level.agent_funcs["zombie"];
  level.agent_funcs["zombie_generic"]["think"] = ::zombie_generic_think;
  level.crawlingzombies = 0;
  level.dismemberedbodyparts = [];
  level.nextdismemberedbodypartindex = 0;

  if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark") {
    var_0[0] = ["zom_civ_ruban_male_torso_slice"];
    var_1[0]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice"];
    var_1[0]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice"];
    var_1[0]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
    var_1[0]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
    var_2[0] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_shg_dlc_b"];
    var_0[1] = ["zom_civ_ruban_male_torso_slice_b"];
    var_1[1]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_b"];
    var_1[1]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_b"];
    var_1[1]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
    var_1[1]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
    var_2[1] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_shg_dlc_b"];
    var_0[2] = ["zom_marine_shotgun_torso_slice"];
    var_1[2]["right_arm"] = ["zom_marine_shotgun_r_arm_slice"];
    var_1[2]["left_arm"] = ["zom_marine_shotgun_l_arm_slice"];
    var_1[2]["right_leg"] = ["zom_marine_shotgun_r_leg_slice"];
    var_1[2]["left_leg"] = ["zom_marine_shotgun_l_leg_slice"];
    var_2[2] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_shg_dlc_b"];
  } else {
    var_0[0] = ["zom_civ_ruban_male_torso_slice"];
    var_1[0]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice"];
    var_1[0]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice"];
    var_1[0]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
    var_1[0]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
    var_2[0] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    var_0[1] = ["zom_civ_ruban_male_torso_slice_ab"];
    var_1[1]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_ab"];
    var_1[1]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_ab"];
    var_1[1]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
    var_1[1]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
    var_2[1] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    var_0[2] = ["zom_civ_ruban_male_torso_slice_b"];
    var_1[2]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_b"];
    var_1[2]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_b"];
    var_1[2]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
    var_1[2]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
    var_2[2] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    var_0[3] = ["zom_civ_ruban_male_torso_slice_c"];
    var_1[3]["right_arm"] = ["zom_civ_ruban_male_r_arm_slice_c"];
    var_1[3]["left_arm"] = ["zom_civ_ruban_male_l_arm_slice_c"];
    var_1[3]["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
    var_1[3]["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
    var_2[3] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    var_0[4] = ["zom_marine_shotgun_torso_slice"];
    var_1[4]["right_arm"] = ["zom_marine_shotgun_r_arm_slice"];
    var_1[4]["left_arm"] = ["zom_marine_shotgun_l_arm_slice"];
    var_1[4]["right_leg"] = ["zom_marine_shotgun_r_leg_slice"];
    var_1[4]["left_leg"] = ["zom_marine_shotgun_l_leg_slice"];
    var_2[4] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
    var_0[5] = ["zom_marine_shotgun_torso_slice_bb"];
    var_1[5]["right_arm"] = ["zom_marine_shotgun_r_arm_slice_bb"];
    var_1[5]["left_arm"] = ["zom_marine_shotgun_l_arm_slice_bb"];
    var_1[5]["right_leg"] = ["zom_marine_shotgun_r_leg_slice_bb"];
    var_1[5]["left_leg"] = ["zom_marine_shotgun_l_leg_slice_bb"];
    var_2[5] = ["zombies_head_cau_dlc_a", "zombies_head_cau_dlc_b", "zombies_head_cau_dlc_c", "zombies_head_shg_dlc_b"];
  }

  var_3 = spawnStruct();
  var_3.agent_type = "zombie_generic";
  var_3.animclass = "zombie_animclass";
  var_3.model_bodies = var_0;
  var_3.model_limbs = var_1;
  var_3.model_heads = var_2;
  var_3.health_scale = 1.0;
  var_3.meleedamage = 45;

  if(isDefined(level.modifygenericzombieclassfunc)) {
    var_3 = [[level.modifygenericzombieclassfunc]](var_3);
  }

  maps\mp\zombies\_util::agentclassregister(var_3, "zombie_generic");
}

zombie_generic_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
  thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
  thread maps\mp\zombies\_util::waitforbadpath();
  thread zombie_generic_moan();
  thread zombie_audio_monitor();
  thread maps\mp\zombies\_zombies::updatebuffs();
  thread maps\mp\zombies\_zombies::updatepainsensor();

  if(level.nextgen) {
    var_0 = 0.05;
  } else {
    var_0 = 0.2;
  }

  for(;;) {
    if(maps\mp\zombies\_behavior::humanoid_begin_melee()) {
      wait(var_0);
      continue;
    }

    if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee()) {
      wait(var_0);
      continue;
    }

    if(maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known()) {
      wait(var_0);
      continue;
    }

    maps\mp\zombies\_behavior::humanoid_seek_random_loc();
    wait(var_0);
  }
}

zombie_generic_moan() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    while(!isDefined(self.curmeleetarget)) {
      wait 0.25;
    }

    while(isDefined(self.curmeleetarget) && distancesquared(self.origin, self.curmeleetarget.origin) > 40000) {
      if(self.movemode == "walk") {
        maps\mp\zombies\_zombies_audio::do_zombies_playvocals("idle_low", self.agent_type);
        wait(randomfloatrange(1.5, 4));
        continue;
      }

      if(self.movemode == "run" || self.movemode == "sprint") {
        maps\mp\zombies\_zombies_audio::do_zombies_playvocals("move", self.agent_type);
        wait(randomfloatrange(2.5, 5.5));
      }
    }

    while(isDefined(self.curmeleetarget) && (distancesquared(self.origin, self.curmeleetarget.origin) > 10000 && distancesquared(self.origin, self.curmeleetarget.origin) <= 40000)) {
      maps\mp\zombies\_zombies_audio::do_zombies_playvocals("idle_high", self.agent_type);
      wait(randomfloatrange(1.5, 2));
    }

    if(level.nextgen) {
      wait 0.05;
      continue;
    }

    wait 0.2;
  }
}

zombie_audio_monitor() {
  self endon("death");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return_parms("attack_hit", "attack_miss");

    if(maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() <= 6) {
      var_1 = randomintrange(0, 2);
    } else {
      var_1 = randomintrange(0, 4);
    }

    switch (var_0[0]) {
      case "attack_hit":
        if(var_1 == 0) {
          thread maps\mp\zombies\_zombies_audio::do_zombies_playvocals("attack", self.agent_type);
        }

        var_2 = var_0[1];

        if(isDefined(var_2) && isPlayer(var_2)) {
          if(isalive(var_2)) {
            if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && self.agent_type == "zombie_boss_oz_stage2") {
              var_2 playlocalsound("zmb_hit_oz_boss");
            }
          } else {
            var_2 playsoundtoplayer("zmb_hit", var_2);
          }
        }

        break;
      case "attack_miss":
        if(var_1 == 0) {
          thread maps\mp\zombies\_zombies_audio::do_zombies_playvocals("attack", self.agent_type);
        }

        break;
    }
  }
}

snd_play_linked_notify_on_ent(var_0, var_1, var_2) {
  thread snd_play_linked_notify_on_ent_thread(var_0, var_1, var_2);
}

snd_play_linked_notify_on_ent_thread(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", self.origin);
  var_3 linkto(self);
  var_3 playSound(var_0);
  self waittill(var_1);
  var_3 scalevolume(0, var_2);
  wait(var_2);
  var_3 stopsounds();
  waitframe();
  var_3 delete();
}
/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_training_aud.gsc
**********************************************/

func_00F9() {
  lib_0367::func_8E3E("train");
  func_7BBA();
  thread func_526E();
}

func_7BBA() {
  lib_0378::func_8DC7("player_connect_map", ::func_7248);
  lib_0378::func_8DC7("player_spawned", ::func_7330);
  lib_0378::func_8DC7("wave_begin", ::func_A979);
  lib_0378::func_8DC7("wave_end", ::func_A97A);
  lib_0378::func_8DC7("aud_wakeup_submix_start", ::func_A7B1);
  lib_0378::func_8DC7("aud_pre_flare", ::func_762F);
  lib_0378::func_8DC7("aud_intro_flare", ::func_5460);
  lib_0378::func_8DC7("training_dist_gunfire", ::func_9C46);
  lib_0378::func_8DC7("see_massacre", ::func_8380);
  lib_0378::func_8DC7("corpse_land_stinger", ::func_2676);
  lib_0378::func_8DC7("aud_german_crawling_foley", ::func_404B);
  lib_0378::func_8DC7("aud_pickup_shovel", ::func_6FC4);
  lib_0378::func_8DC7("random_growl", ::func_7A3A);
  lib_0378::func_8DC7("ger_search", ::func_403F);
  lib_0378::func_8DC7("ger_combat1", ::func_403A);
  lib_0378::func_8DC7("crawl_beam_buckle", ::func_2767);
  lib_0378::func_8DC7("crawl_beam_collapse", ::func_2768);
  lib_0378::func_8DC7("door_open", ::func_326F);
  lib_0378::func_8DC7("door_close", ::func_3257);
  lib_0378::func_8DC7("ee_complete", ::func_3577);
  lib_0378::func_8DC7("ee_update", ::func_3598);
  lib_0378::func_8DC7("uber_battery_pickup", ::func_9FE2);
  lib_0378::func_8DC7("play_revive_sound", ::func_718F);
  lib_0378::func_8DC7("first_zombie_tree_jumpscare", ::func_3C61);
  lib_0378::func_8DC7("player_entered_house", ::func_726F);
  lib_0378::func_8DC7("aud_start_player_vox", ::aud_start_player_vox);
  lib_0378::func_8DC7("aud_stop_player_vox", ::aud_stop_player_vox);
}

func_526E() {}

func_A979() {
  if(isDefined(self.var_11CB.var_601A)) {
    lib_0380::func_2893(self.var_11CB.var_601A, 8);
    self.var_11CB.var_601A = undefined;
  }
}

func_A97A() {}

func_7248() {}

func_7330() {
  self method_8626("train_global", 0.25);
  lib_0366::snd_zmb_set_plr_vox_scare_count_max(1);
}

func_A7B1() {
  level.var_721C method_8626("wake_up");
  level.var_11CB.var_A7A5 = lib_0380::func_2888("training_intro_fire", undefined, 2);
  lib_0378::func_8D14(level.var_11CB.var_A7A5);
  level.var_11CB.var_A7A6 = lib_0380::func_2888("zmb_training_intro_hit");
  lib_0378::func_8D14(level.var_11CB.var_A7A6);
  level.var_11CB.var_A7A7 = lib_0380::func_2888("training_intro_tinnitus");
  lib_0378::func_8D14(level.var_11CB.var_A7A7);
}

func_762F() {
  wait(17);
  level.var_11CB.var_7A75 = lib_0380::func_2888("training_train_fire_ratchets_loud");
  lib_0378::func_8D14(level.var_11CB.var_7A75);
}

func_5460() {
  level.var_11CB.var_5460 = lib_0380::func_2888("training_intro_flare");
  lib_0378::func_8D14(level.var_11CB.var_5460);
  wait(2);
  level.var_11CB.var_A7A4 = lib_0380::func_2888("zmb_training_intro_end");
  lib_0378::func_8D14(level.var_11CB.var_A7A4);
  wait(4);
  level.var_721C method_8627("wake_up");
}

func_9C46() {
  var_00 = lib_0380::func_2888("zmb_training_dist_mp40");
  lib_0378::func_8D14(var_00);
  var_01 = lib_0380::func_2888("zmb_training_dist_kar98");
  lib_0378::func_8D14(var_01);
}

func_8380() {
  self.var_11CB.var_601A = lib_0380::func_2888("mus_training");
  lib_0378::func_93E2();
}

func_404B() {
  var_00 = self;
  wait(6.4);
  level.var_721C method_8626("german_soldiers_encounter", 0.25);
  lib_0380::func_6844("training_dying_soldier_foley", undefined, var_00);
  wait(1.5);
  lib_0380::func_6844("zmb_soldier_death_vox", undefined, var_00);
  wait(3);
  level.var_721C method_8627("german_soldiers_encounter", 5);
}

func_6FC4() {
  level.var_11CB.var_6FC4 = lib_0380::func_2888("training_pickup_shovel");
  lib_0378::func_8D14(level.var_11CB.var_6FC4);
}

func_2676() {
  var_00 = self;
  lib_0366::func_8E34("training_stinger", var_00);
}

func_7A3A(param_00) {
  lib_0380::func_2889("training_z_growl", undefined, param_00.var_0116);
}

func_403F(param_00, param_01) {
  lib_0380::func_2889("zmb_train_gsld1_heyoverhereiheardsomeone", undefined, param_00.var_0116, 0, 0.7);
}

func_403A(param_00) {
  lib_0380::func_2889("zmb_train_gsld2_haltoverhere", undefined, param_00.var_0116, 0, 0.8);
  wait(1);
  lib_0380::func_2889("zmb_training_dist_zombies", undefined, param_00.var_0116, 0, 1);
  wait(1.5);
  lib_0380::func_2889("zmb_train_gsld1_whatherrstraubsaidtheywer", undefined, param_00.var_0116, 0, 1);
  wait(2.5);
  lib_0380::func_2889("zmb_train_gsld2_gethelp", undefined, param_00.var_0116, 0, 0.9);
  wait(1.5);
  lib_0380::func_2889("zmb_train_gsld1_aaaahhhh", undefined, param_00.var_0116, 0, 0.8);
  wait(1.5);
  lib_0380::func_2889("zmb_train_gsld2_run", undefined, param_00.var_0116, 0, 0.7);
}

func_2767() {
  level.var_11CB.var_9D3E = lib_0380::func_2888("training_tree_collapse_main");
  lib_0378::func_8D14(level.var_11CB.var_9D3E);
}

func_2768() {}

func_326F() {}

func_3257() {
  level.var_120E = lib_0380::func_2889("training_house_door_close", undefined, self.var_0116);
  lib_0378::func_8D14(level.var_120E);
  if(isDefined(level.var_744A)) {
    foreach(var_01 in level.var_744A) {
      var_01 aud_start_player_vox();
    }
  }
}

func_3577() {
  lib_0380::func_2889("training_pressure", undefined, self.var_0116);
}

func_3598() {
  lib_0380::func_2889("training_crow_caw", undefined, self.var_0116);
}

func_9FE2() {
  level.var_9FE3 = lib_0380::func_6846("zmb_uber_battery_lp", undefined, self, 0.5, 1, 0.5);
}

func_718F() {
  lib_0380::func_6840("zmb_uberschnell_heal");
  if(isDefined(level.var_9FE3)) {
    lib_0380::func_6850(level.var_9FE3, 0.1);
    level.var_9FE3 = undefined;
  }
}

func_3C61(param_00, param_01) {
  lib_0380::func_2888("stinger_round_start_hit", self);
  lib_0380::func_2888("training_tree_js_stinger", self);
  wait(0.5);
  lib_0380::func_2888("training_tree_js_zobmie_roar", self);
}

func_726F() {
  self endon("death");
  level endon("flag_player_reached_exit");
  self.var_11CB.var_726F = 1;
  var_00 = 0;
  var_01 = 1120;
  var_02 = 1045;
  var_03 = 4;
  for(;;) {
    var_04 = lib_0366::func_8E1A();
    foreach(var_06 in var_04) {
      var_07 = var_06.var_0116[2];
      if(var_07 >= var_01 && level.var_721C.var_0116[2] < var_02 && var_00 <= var_03) {
        if(!isDefined(var_06.var_A1C6)) {
          var_06.var_A1C6 = lib_0380::func_288B("zmb_house_upstairs_fs_lp", undefined, var_06);
        }

        var_00++;
        continue;
      }

      if(isDefined(var_06.var_A1C6)) {
        lib_0380::func_2893(var_06.var_A1C6, 0.25);
        var_06.var_A1C6 = undefined;
      }
    }

    var_00 = 0;
    wait 0.05;
  }
}

aud_start_player_vox() {
  lib_0378::func_9266();
  wait 0.05;
  lib_0378::func_1BBD();
  lib_0378::set_expletive_chance(0);
}

aud_stop_player_vox() {
  lib_0378::func_93E2();
}
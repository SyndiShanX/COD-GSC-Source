/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_8b6f2185feb33ac.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3d81630134db409c;
#using script_3dc93ca9902a9cda;
#using script_6e46300ab1cb7adb;
#using script_c36b776c6718540;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\surveycam;
#using scripts\cp_common\util;
#namespace namespace_c8bf7287;

function preload() {
  clientfield::register("toplayer", "survey_equipment_focal_length_toggle", 1, 4, "int");
}

function function_c17f029c() {
  level endon(#"game_ended");

  if(!isDefined(level.player)) {
    a_e_players = getplayers();
    level.player = a_e_players[0];
  }

  level.var_b386071f = struct::get("office_survey_interact", "targetname");
  level.var_b386071f util::create_cursor_hint(undefined, undefined, #"hash_14877aca74141b14");
  level.var_b386071f waittill(#"trigger");

  if(!level flag::get("flg_bunker_survey_interacted")) {
    level flag::set("flg_bunker_survey_interacted");
  }

  level.player thread function_46ae3e19();

  if(!level flag::get("survey_equipment_completed")) {
    level thread namespace_8a404420::function_301a4927();
  }
}

function function_46ae3e19() {
  self endon(#"death");
  self function_903e9054();
  wait 0.5;
  level thread scene::play("scene_yam_6010_grp_enter_react_player");
  self waittill(#"hash_39fbe9dbd19f01ae");
  level flag::set("flg_survey_fade_in");
  self function_a9cee9e2();
  self val::reset(#"hash_4e0de8df528281e0", "freezecontrols");
  self thread function_46496018();
  self thread function_f02410a6();
  self.var_eb71bc34 = gettime();

  if(!level flag::get("survey_equipment_completed")) {
    level thread namespace_73841f48::function_4a6ba207();
    level thread function_dff14491();
    level waittill(#"hash_6b2091e6c001e49a");
  }

  level.player thread util::show_hint_text(#"hash_7da83bbeaa1266dd", undefined, "remove_survey_equipment_exit_hint", -1);
  self thread function_feadce70();
  self waittill(#"survey_equipment_exit");
  level notify(#"survey_equipment_exit", {
    #var_d69de23d: gettime() - self.var_eb71bc34
  });
  level.player notify(#"remove_survey_equipment_exit_hint");
  self val::set(#"hash_4e0de8df528281e0", "freezecontrols", 1);
  self function_86617714();
  self function_425703b5();
  level flag::set("survey_equipment_completed");
  level thread function_c17f029c();
}

function function_903e9054() {
  self.var_2a9c750 = 1;
  self val::set(#"hash_4e0de8df528281e0", "freezecontrols", 1);
  self val::set(#"hash_4e0de8df528281e0", "disable_weapons", 1);
  self val::set(#"hash_4e0de8df528281e0", "disable_offhand_weapons", 1);
  self val::set(#"hash_4e0de8df528281e0", "disable_weapon_cycling", 1);
  self val::set(#"hash_4e0de8df528281e0", "allow_jump", 0);
  self val::set(#"hash_4e0de8df528281e0", "allow_crouch", 0);
  self val::set(#"hash_4e0de8df528281e0", "allow_prone", 0);
  self val::set(#"hash_4e0de8df528281e0", "allow_melee", 0);
  self val::set(#"hash_4e0de8df528281e0", "allow_ads", 0);
  self val::set(#"hash_4e0de8df528281e0", "allowdeath", 0);
  self val::set(#"hash_4e0de8df528281e0", "show_weapon_hud", 0);
}

function function_425703b5() {
  self val::reset_all(#"hash_4e0de8df528281e0");
  self.var_2a9c750 = 0;
}

function function_a9cee9e2() {
  waitframe(1);
  var_b22820f2 = struct::get("survey_camera", "targetname");
  var_b22820f2.var_721fe4cf = self.origin;
  var_b22820f2.var_d298ff03 = self.angles;
  level.var_b22820f2 = var_b22820f2;
  self thread lui::screen_flash(0.15, 0.4, 0.15, 1, "black");
  wait 0.35;
  var_b22820f2.var_afe8c0dc = util::spawn_model(#"tag_origin", var_b22820f2.origin - (0, 0, 60), var_b22820f2.angles);
  var_afe8c0dc = level.var_b22820f2.var_afe8c0dc;
  self setorigin(var_afe8c0dc.origin);
  self setplayerangles(var_afe8c0dc.angles);
  self playerlinktodelta(var_afe8c0dc, "tag_origin", 1, 28, 28, 28, 28);
  self hideviewmodel();
  setslowmotion(1, 0.999, 0.1, 1, 0.45);
  self surveycam::function_87b9c1ef(17, 50);
  self clientfield::set_to_player("survey_equipment_focal_length_toggle", 1);
  namespace_a43d1663::remove();
  wait 0.1;
  self setplayerangles(var_afe8c0dc.angles);
  wait 0.25;
}

function function_86617714() {
  var_b22820f2 = level.var_b22820f2;
  self thread lui::screen_flash(0.125, 0.25, 0.125, 1, "black");
  wait 0.2;
  self clientfield::set_to_player("survey_equipment_focal_length_toggle", 12);
  self surveycam::function_56d93dca(0);
  var_b22820f2.var_afe8c0dc unlink();
  var_b22820f2.var_afe8c0dc delete();
  self setorigin(var_b22820f2.var_721fe4cf);
  self setplayerangles(var_b22820f2.var_d298ff03);
  self showviewmodel();
  setslowmotion(0.999, 1, 0.1, 0.45, 1);
  wait 0.35;
}

function private function_feadce70() {
  self endon(#"death");
  waitframe(1);
  self namespace_61e6d095::function_b0bad5ff();
  self notify(#"survey_equipment_exit");
}

function private function_46496018() {
  self endon(#"death", #"survey_equipment_exit");
  self.var_b10345b3 = 0;
  self.var_17d27e91 = 0;
  self.var_df3bdc3 = 1;

  while(true) {
    var_402d2591 = self getnormalizedmovement();

    if(var_402d2591[0] > 0.1) {
      if(self.var_df3bdc3 < 11) {
        if(!self.var_17d27e91) {
          self notify(#"hash_5612e889a163033a");
          self.var_17d27e91 = 1;
        }

        if(!self.var_b10345b3) {
          self function_fd8c139b();
        }

        self.var_df3bdc3++;
        self clientfield::set_to_player("survey_equipment_focal_length_toggle", self.var_df3bdc3);
      }
    } else if(var_402d2591[0] < -0.1) {
      if(self.var_df3bdc3 > 0) {
        if(!self.var_17d27e91) {
          self notify(#"hash_5612e889a163033a");
          self.var_17d27e91 = 1;
        }

        if(!self.var_b10345b3) {
          self function_fd8c139b();
        }

        self.var_df3bdc3--;
        self clientfield::set_to_player("survey_equipment_focal_length_toggle", self.var_df3bdc3);
      }
    } else {
      self.var_b10345b3 = 0;
      snd::stop(self.var_9d22797b, 0.15);
    }

    wait 0.15;
  }
}

function function_f02410a6() {
  self endon(#"death", #"survey_equipment_exit");
  self.var_b0ec0c03 = 0;

  while(true) {
    var_7df86393 = self hms_util::function_e93aa7b3();

    if(var_7df86393 != (0, 0, 0) && self.var_b0ec0c03 == 0) {
      self function_aee7319a();
    } else if(var_7df86393 == (0, 0, 0) && self.var_b0ec0c03 == 1) {
      self.var_b0ec0c03 = 0;
      snd::stop(self.var_ba6895ae);
    }

    waitframe(1);
  }
}

function function_fd8c139b() {
  self.var_b10345b3 = 1;
  self.var_9d22797b = snd::play("evt_survey_equipment_zoom_lp");
}

function function_aee7319a() {
  self.var_b0ec0c03 = 1;
  self.var_ba6895ae = snd::play("evt_survey_equipment_lp");
}

function private function_dff14491() {
  level endon(#"hash_6b2091e6c001e49a");

  while(true) {
    objectives_ui::function_1c6b4aeb();
    wait 25;
  }
}
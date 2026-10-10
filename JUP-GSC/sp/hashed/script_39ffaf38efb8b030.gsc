/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_39ffaf38efb8b030.gsc
*************************************************/

#using scripts\common\basic_wind;
#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\cp\cp_audio;
#using scripts\cp\utility;
#using scripts\engine\utility;
#using scripts\stealth\utility;
#namespace namespace_db6d946f0063cf7a;

function main() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  flag_init("flag_aud_combat_systems_end");
  thread function_d3fbaef4d5cdea71("aud_ext_grass_area");
  thread function_13b2c0cc738ee137("aud_ext_house_area");
  thread function_cad8126e6be4919e();
  thread scripts\cp\cp_audio::function_f1dd559fdd8216d1(3, 6, 10, 1500, "ranch", "flag_aud_combat_systems_end");
  thread function_a1ea209642c59fdb();
}

function function_cad8126e6be4919e() {
  flag_wait("dungeon_load_finished");
  level.player setsoundsubmix("cp_jup_ranch_global");
}

function function_e5fa9c74eac6670b() {
  flag_set("flag_aud_combat_systems_end");
  level.player clearsoundsubmix("cp_jup_ranch_global");
}

function function_d3fbaef4d5cdea71(var_eaad182af1b91884) {
  flag_wait("dungeon_load_finished");
  var_bbba576a25b49793 = getEntArray(var_eaad182af1b91884, "targetname");

  foreach(trig in var_bbba576a25b49793) {
    thread function_39a1ac4197ec37d9(trig);
  }
}

function function_39a1ac4197ec37d9(trig) {
  var_abb80afa28c799fd = 0;

  while(true) {
    trig waittill("trigger");

    while(function_2407e74aee5346eb(trig)) {
      var_53fda60304330f0e = level.player getstance();
      var_7ec27648dcc4c980 = level.var_73bf08015fe2dd2a;

      if(!istrue(level.var_73bf08015fe2dd2a)) {
        if(var_53fda60304330f0e != "stand") {
          if(!istrue(var_abb80afa28c799fd)) {
            level.player setsoundsubmix("cp_jup_ranch_script_grass_prone", 0.15);
            var_abb80afa28c799fd = 1;
          }
        } else if(var_53fda60304330f0e == "stand" && istrue(var_abb80afa28c799fd)) {
          level.player clearsoundsubmix("cp_jup_ranch_script_grass_prone", 0.5);
          var_abb80afa28c799fd = 0;
        }
      }

      wait 0.5;
    }
  }
}

function function_13b2c0cc738ee137(var_eaad182af1b91884) {
  flag_wait("dungeon_load_finished");
  var_5a1df9a6287a20c5 = getEntArray(var_eaad182af1b91884, "targetname");

  foreach(trig in var_5a1df9a6287a20c5) {
    thread function_981cf4a78abbb4db(trig);
  }
}

function function_981cf4a78abbb4db(trig) {
  while(true) {
    level.var_73bf08015fe2dd2a = 0;
    trig waittill("trigger");
    level.var_73bf08015fe2dd2a = 1;
    level.player clearsoundsubmix("cp_jup_ranch_script_grass_prone", 0.5);

    while(function_2407e74aee5346eb(trig)) {
      wait 0.5;
    }
  }
}

function function_2407e74aee5346eb(trig) {
  var_e63ee12ac4f13b5b = level.player istouching(trig);

  if(level.player istouching(trig)) {
    return true;
  }

  return false;
}

function function_89c1c5d06e96b565() {
  level.player setsoundsubmix("cp_jup_ranch_infil");
  level.player playSound("cp_jup_ranch_scn_infil_feet");
}

function function_804e583857d3cde0() {
  level.player clearsoundsubmix("cp_jup_ranch_infil");
}

function function_ced0986f270ad64() {
  level.player setsoundsubmix("cp_jup_ranch_exfil");
  level.player playSound("cp_jup_ranch_scn_outro_farah_feet");
}

function function_3e5ca72ec676d4bd() {
  level.player clearsoundsubmix("cp_jup_ranch_exfil");
}

function function_6bb2d4f65ab5b358() {
  if(isDefined(level.player)) {
    var_3f27111af8941084 = (1908.5, 1710.5, 153.5);
    playsoundatpos(var_3f27111af8941084, "evt_cp_jup_ranch_flight_recorder_interact");
    wait 0.5;
  }

  var_ade6791a8e0a3d09 = (1915, 1735, 140);
  wait 3;
  playsoundatpos(var_ade6791a8e0a3d09, "evt_jup_ranch_recorder_defuse_sparks");
  wait 1;
  playsoundatpos(var_ade6791a8e0a3d09, "evt_jup_ranch_recorder_defuse_zaps");
  wait 0.5;
  playsoundatpos(var_ade6791a8e0a3d09, "evt_jup_ranch_recorder_defuse_zaps");
  wait 1.5;
  playsoundatpos(var_ade6791a8e0a3d09, "evt_jup_ranch_recorder_defuse_zaps");
}

function function_6e702f33ebd498d7(vehicle) {
  level.player setsoundsubmix("cp_jup_ranch_script_veh_reinforcements", 0.5);
  vehicle playsoundonmovingent("cp_jup_ranch_scn_reinforcements");
  wait 5;
  level.player clearsoundsubmix("cp_jup_ranch_script_veh_reinforcements", 5);
}

function function_3f52eef92c21512(guy_eye) {}

function function_53669ce4cec22991(var_2bbbbdbcf9eaa1da, guypos) {
  level.player setsoundsubmix("cp_jup_ranch_script_sniper_support", 0.5);
  closepos = guypos getEye();
  var_ab065b3bc8dc8ebc = var_2bbbbdbcf9eaa1da.origin;
  var_8ab275884ba39e6 = vectorNormalize(var_ab065b3bc8dc8ebc - closepos);
  var_511fb48c5c5e327e = distance(closepos, var_ab065b3bc8dc8ebc);
  var_eb40e24459b6336 = closepos + var_8ab275884ba39e6 * 400;
  thread function_f88d1373d0b2d87b(closepos, var_eb40e24459b6336);
  thread function_384343a7dfee4153(var_ab065b3bc8dc8ebc);
}

function function_f88d1373d0b2d87b(var_d5d70b539f35bde4, var_eb40e24459b6336) {
  var_3949e3fba2d50427 = spawn("script_model", var_eb40e24459b6336);
  var_3949e3fba2d50427 playSound("cp_jup_ranch_sniper_whizby");
  var_3949e3fba2d50427 moveTo(var_d5d70b539f35bde4, 0.3);
  wait 0.4;
  playsoundatpos(var_d5d70b539f35bde4, "cp_jup_ranch_sniper_impact");
  wait 1;
  var_3949e3fba2d50427 delete();
}

function function_384343a7dfee4153(var_73bd1518c8d5da38) {
  wait randomfloatrange(0.6, 1);
  playsoundatpos(var_73bd1518c8d5da38, "cp_jup_ranch_sniper_shot_rifle");
  wait 0.4;
  playsoundatpos(var_73bd1518c8d5da38, "cp_jup_ranch_sniper_shot_report");
  level.player clearsoundsubmix("cp_jup_ranch_script_sniper_support", 2.5);
}

function function_f93ac0b6a493f09e() {
  level endon("alex_guards_were_attacked");
  level endon("game_ended");

  if(flag("alex_guards_were_attacked") || flag("hostage_ai_goto_combat")) {
    return 1;
  }

  var_2ed9672c23966c27 = (1960, -2390, 855);
  var_aa1098d9df22e66a = spawn("script_model", var_2ed9672c23966c27);
  level.player setsoundsubmix("cp_jup_ranch_script_capture_sequence", 1);

  if(function_1bb1470f934a81eb()) {
    level.player playsoundonmovingent("cp_jup_ranch_capture_alex_shots_combat");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_alex_dry_gunfire_combat");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_alex_dry_gunfire_combat_sweetener");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_konni_dry_gunfire_combat");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_enemies_dry_guns_smg_combat");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_enemies_dry_guns_ar_combat");
    thread function_bfa4e6f5b7188aa1("cp_jup_ranch_capture_alex_shots_combat", var_aa1098d9df22e66a);
  } else {
    level.player playsoundonmovingent("cp_jup_ranch_capture_alex_shots_stealth");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_alex_dry_gunfire_stealth");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_alex_dry_gunfire_stealth_sweetener");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_konni_dry_gunfire_stealth");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_enemies_dry_guns_smg_stealth");
    var_aa1098d9df22e66a playsoundonmovingent("cp_jup_ranch_capture_enemies_dry_guns_ar_stealth");
    thread function_bfa4e6f5b7188aa1("cp_jup_ranch_capture_alex_shots_stealth", var_aa1098d9df22e66a);
  }

  wait 10;
  flag_set("capture_sfx_audio_played");
  level.player clearsoundsubmix("cp_jup_ranch_script_capture_sequence", 1);
  var_aa1098d9df22e66a delete();
}

function function_bfa4e6f5b7188aa1(var_8bf2e07098084a02, var_aa1098d9df22e66a) {
  level endon("capture_sfx_audio_played");
  level endon("game_ended");

  while(!flag("alex_guards_were_attacked") && !flag("hostage_ai_goto_combat")) {
    waitframe();
  }

  level.player stoplocalsound(var_8bf2e07098084a02);
  var_aa1098d9df22e66a stopsounds();
  level.player playSound("cp_jup_ranch_capture_alex_shots_interrupt");
  level.player clearsoundsubmix("cp_jup_ranch_script_capture_sequence", 1);
}

function function_e12313ab820b22a9(alias) {
  self endon("death");
  var_d453796cbe92a747 = alias;
  var_6ffc770d4ade2e40 = randomfloatrange(0, 1.7);
  duration = lookupsoundlength(alias) / 1000;
  wait duration - var_6ffc770d4ade2e40;
}

function function_a1ea209642c59fdb() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("end_ally_overwatch");
  var_edcdcc918d7f4b83 = (473, 654, 750);
  var_565a67140613c568 = (-677, 600, 600);
  var_fc5896095d3792dd = (1600, -180, 600);
  var_fc5893095d378c44 = (1521, 2000, 600);
  var_24568941836b8efb = [var_565a67140613c568, var_fc5896095d3792dd, var_fc5893095d378c44];
  var_9a224e213c7cbfeb = [];
  var_2e5c1e54c7e71f2 = 0;
  var_24e3e1a62fdfdd39 = 0;
  var_dab1e989aeb51876 = 0;

  for(i = 0; i < 9; i++) {
    var_9a224e213c7cbfeb[var_9a224e213c7cbfeb.size] = i + 1;
  }

  var_9a224e213c7cbfeb = array_randomize_objects(var_9a224e213c7cbfeb);
  var_60ef6a0fc92bb3a0 = var_9a224e213c7cbfeb[0];
  var_60ef6d0fc92bba39 = var_9a224e213c7cbfeb[1];
  var_b6fecaa155f93749 = var_9a224e213c7cbfeb[2];
  var_b6fec7a155f930b0 = var_9a224e213c7cbfeb[3];
  var_b86331ff25503f7e = var_9a224e213c7cbfeb[4];
  var_b86330ff25503d4b = var_9a224e213c7cbfeb[5];
  flag_wait("ranch_ais_initialized");
  wait 5;
  var_aa5a19661392172a = getaiarrayinradius(var_565a67140613c568, 1250, "axis");
  var_f3f63900b2d7c8d9 = getaiarrayinradius(var_fc5896095d3792dd, 1250, "axis");
  var_9ec76cddc4f28918 = getaiarrayinradius(var_fc5893095d378c44, 1250, "axis");

  while(!flag("end_ally_overwatch")) {
    if(!istrue(var_2e5c1e54c7e71f2)) {
      var_aa5a19661392172a = getaiarrayinradius(var_565a67140613c568, 1250, "axis");

      if(var_aa5a19661392172a.size > 2) {
        thread function_ecf751ed41de5ff6(var_565a67140613c568, var_60ef6a0fc92bb3a0, var_60ef6d0fc92bba39);
        var_2e5c1e54c7e71f2 = 1;
      }
    }

    if(!istrue(var_24e3e1a62fdfdd39)) {
      var_f3f63900b2d7c8d9 = getaiarrayinradius(var_fc5896095d3792dd, 1250, "axis");

      if(var_f3f63900b2d7c8d9.size > 2) {
        thread function_ecf751ed41de5ff6(var_fc5896095d3792dd, var_b6fecaa155f93749, var_b6fec7a155f930b0);
        var_24e3e1a62fdfdd39 = 1;
      }
    }

    if(!istrue(var_dab1e989aeb51876)) {
      var_9ec76cddc4f28918 = getaiarrayinradius(var_fc5893095d378c44, 1250, "axis");

      if(var_9ec76cddc4f28918.size > 2) {
        thread function_ecf751ed41de5ff6(var_fc5893095d378c44, var_b86331ff25503f7e, var_b86330ff25503d4b);
        var_dab1e989aeb51876 = 1;
      }
    }

    if(flag("active_combat_begun")) {
      var_2e5c1e54c7e71f2 = 0;
      var_24e3e1a62fdfdd39 = 0;
      var_dab1e989aeb51876 = 0;
      flag_wait("active_combat_cooldown");
      wait 10;
    }

    wait 5;
  }
}

function function_496b7ad284cead00(var_359a07201fd9b0b7) {
  var_a183ce16596b14c8 = getaiarrayinradius(var_359a07201fd9b0b7, 1250, "axis");
  return var_a183ce16596b14c8.size;
}

function function_ecf751ed41de5ff6(var_13cd8f37c03fca8a, var_816f2674e1448b1f, var_816f2774e1448d52) {
  level endon("active_combat_begun");
  var_13507baea85cfbbe = [1.5, 2.5];
  var_be223154fc5cc5ce = randomintrange(8, 14);
  var_be223054fc5cc39b = randomintrange(8, 14);
  var_6d8e7d60710a90c1 = 1;
  var_376eabd83af7f73e = 1;
  wait randomintrange(1, 5);

  while(!flag("active_combat_begun")) {
    if(istrue(var_6d8e7d60710a90c1) && istrue(var_376eabd83af7f73e)) {
      var_6d8e7d60710a90c1 = 0;
      var_376eabd83af7f73e = 0;

      if(var_be223154fc5cc5ce >= var_be223054fc5cc39b) {
        var_d37282837c4b3673 = var_be223154fc5cc5ce;
        var_d37283837c4b38a6 = var_be223054fc5cc39b;
      } else {
        var_d37282837c4b3673 = var_be223054fc5cc39b;
        var_d37283837c4b38a6 = var_be223154fc5cc5ce;
      }

      for(i = 0; i < var_d37282837c4b3673; i++) {
        var_97169b6f83dede9 = function_496b7ad284cead00(var_13cd8f37c03fca8a);

        if(var_97169b6f83dede9 > 2 && !flag("active_combat_begun")) {
          play_sound_in_space("jup_cp_ranch_walla_ext_guy0" + var_816f2674e1448b1f + "_idle", var_13cd8f37c03fca8a);
        } else {
          break;
        }

        function_e12313ab820b22a9("jup_cp_ranch_walla_ext_guy0" + var_816f2674e1448b1f + "_idle");

        if(i < var_d37283837c4b38a6) {
          if(var_97169b6f83dede9 > 2 && !flag("active_combat_begun")) {
            play_sound_in_space("jup_cp_ranch_walla_ext_guy0" + var_816f2774e1448d52 + "_idle", var_13cd8f37c03fca8a);
          } else {
            break;
          }

          function_e12313ab820b22a9("jup_cp_ranch_walla_ext_guy0" + var_816f2774e1448d52 + "_idle");
        }
      }
    }

    wait randomfloatrange(var_13507baea85cfbbe[0], var_13507baea85cfbbe[1]);
    var_6d8e7d60710a90c1 = 1;
    var_376eabd83af7f73e = 1;
  }
}
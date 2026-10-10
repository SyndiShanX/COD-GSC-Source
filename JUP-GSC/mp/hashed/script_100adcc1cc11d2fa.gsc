/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_100adcc1cc11d2fa.gsc
*************************************************/

#using script_485622d93fa7e4cf;
#using script_5080d40cd904ba73;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace namespace_cc781f142d33c074;

function function_c9eea6ea790d37bd() {
  level._effect["dark_aether_exit_3p"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_outro.vfx");
}

function function_348e0a3041479e64() {
  if(istrue(self.b_dark_aether_exit_used)) {
    return self getEye();
  }
}

function function_a13799ae222a8b48(var_bf174c7766c4a233, var_2e2204c429664d9b) {
  level.var_2e2204c429664d9b = default_to(var_2e2204c429664d9b, 0);
  var_65c377a3c5cb00ff = getdvarint(@ "hash_73cfb77eb49c943", 0);
  var_da8d68cc5b875714 = getStructArray(var_bf174c7766c4a233, "targetname");

  foreach(s_exit in var_da8d68cc5b875714) {
    v_angles = s_exit.angles;

    if(var_65c377a3c5cb00ff) {
      v_angles += (0, 180, 0);
    }

    gate_model = utility::spawn_model("jup_zm_rift_portal_small", s_exit.origin, v_angles);

    if(isDefined(gate_model)) {
      gate_model.targetname = "dark_aether_exit";

      if(var_65c377a3c5cb00ff) {
        gate_model setscriptablepartstate("aether_exit_body", "visuals_high_power");
      } else if(level.var_2e2204c429664d9b) {
        gate_model setscriptablepartstate("aether_exit_body", "rift_mission_exit");
      }

      gate_model.gate_interact = scripts\cp_mp\interaction::register_interact(s_exit.origin + (0, 0, 48), 150, &function_5927fdb24018f9c7);
      gate_model.gate_interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_5aa40913d9085c11);
      gate_model.gate_interact sethintonobstruction("hide");
    }

    waitframe();
  }
}

function function_fc3d453bbcdb9a5a() {
  exits = getEntArray("dark_aether_exit", "targetname");

  foreach(var_13382965c57818a1 in exits) {
    var_13382965c57818a1 setscriptablepartstate("aether_exit_body", "off");
    var_13382965c57818a1.gate_interact delete();
    var_13382965c57818a1 notsolid();
  }
}

function function_e7995c28c01d9c() {
  exits = getEntArray("dark_aether_exit", "targetname");

  foreach(var_13382965c57818a1 in exits) {
    var_13382965c57818a1 setscriptablepartstate("aether_exit_body", "visuals");
    var_13382965c57818a1.gate_interact = scripts\cp_mp\interaction::register_interact(var_13382965c57818a1.origin, 150, &function_5927fdb24018f9c7);
    var_13382965c57818a1.gate_interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_5aa40913d9085c11);
    var_13382965c57818a1.gate_interact sethintonobstruction("show");
    var_13382965c57818a1 solid();
  }
}

function function_5aa40913d9085c11(interact, player) {
  if(level.mapname == "mp_jup_bigmap") {
    return {
      #string: &"JUP_OB_OBJECTIVES/BIGMAP_EXFILL", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"JUP_OB_S1/RIFT_EXIT", #type: "HINT_BUTTON"};
}

function function_5927fdb24018f9c7(player) {
  if(istrue(player.var_f52eb40ba99ffa4c)) {
    return;
  }

  thread function_b67447cfa15eb9e6(player);
}

function function_b67447cfa15eb9e6(player) {
  player endon("death_or_disconnect");
  player callback::callback("ob_dark_aether_exit_used");
  player.b_dark_aether_exit_used = 1;
  player.var_f52eb40ba99ffa4c = 1;
  player.var_68b9486f4adbcb62 = 1;
  player.var_764da0de2a46452c = 1;

  if(!isDefined(player.s_exfil)) {
    player.s_exfil = spawnStruct();
  }

  player val::set("exfil", "ignoreme", 1);
  player val::set("exfil", "freezecontrols", 1);
  player val::set("exfil", "damage", 0);
  player val::set("exfil", "weapon", 0);
  player val::set("exfil", "breath_system", 0);
  player val::set("exfil", "cg_drawcrosshair", 0);
  player val::set("exfil", "show_weapon_hud", 0);
  player cleardamageindicators();
  playFXOnTag(level._effect["dark_aether_exit_3p"], player, "j_spineupper");
  wait 0.35;
  player playerhide();
  player function_2241b80779e319a0();
  player callback::callback("teleport_movie_complete");

  if(level.var_2e2204c429664d9b != 1) {
    if(getdvarint(@ "ob_rift_run", 0)) {
      str_type = "rift_run";
    } else {
      str_type = "none";
    }

    level thread namespace_134d54e39331ee45::function_bf01aba31e9023d1(0, [player], str_type);
  }
}

function function_2241b80779e319a0() {
  self endon("death_or_disconnect");
  var_7848ff3f98ef4a73 = 0;
  var_8c6c2faac72ea626 = 10;
  videoduration = 6;
  var_1bab87417f147c8f = 0;
  self setclientomnvar("ui_br_bink_overlay_state", var_8c6c2faac72ea626);
  utility::hidehudenable();
  self playsoundtoplayer("bik_jup_ob_teleport", self);
  self setsoundsubmix("jup_ob_endgame", 0.1);
  self playcinematicforplayer("jup_ob_dark_aether_portal", 1, var_1bab87417f147c8f);
  wait videoduration - 0.1;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.1);
  wait 0.1;
  self stopcinematicforplayer();
  utility::hidehuddisable();
  self setclientomnvar("ui_br_bink_overlay_state", var_7848ff3f98ef4a73);
}

function function_ccde446fe7425514(var_e98a2e24f991b6f6) {
  if(!isDefined(var_e98a2e24f991b6f6)) {
    var_e98a2e24f991b6f6 = 0;
  }

  level endon("game_ended");
  var_1d6aa90a9f946bbe = istrue(var_e98a2e24f991b6f6) ? "ob_infil_rift_gate_alternate" : "ob_infil_rift_gate";
  s_gate = utility::getStruct(var_1d6aa90a9f946bbe, "targetname");

  if(!isDefined(s_gate)) {
    return;
  }

  scriptable = spawnscriptable("ob_jup_scriptable_rift_gate_collapse", s_gate.origin, s_gate.angles);
  level flag_wait("ob_infil_completed");
  size = (250, 50, 250);
  trigger = spawn("trigger_box", s_gate.origin, 0, size, size + (1, 1, 1));
  trigger thread function_67145692c7f7c798();
  var_710204d0c2677821 = gettime() + 60000;
  v_look = s_gate.origin + (0, 0, 64);

  while(isDefined(scriptable)) {
    foreach(player in level.players) {
      if(utility::within_fov(player getEye(), player getplayerangles(), v_look, cos(35))) {
        b_collapse = 1;
        break;
      }

      waitframe();
    }

    if(level.players.size == 0) {
      b_collapse = 1;
    }

    if(istrue(b_collapse) || flag("rift_run_infil_gate_collapse_triggered") || var_710204d0c2677821 < gettime()) {
      if(isDefined(trigger)) {
        trigger delete();
      }

      wait 2.5;
      scriptable setscriptablepartstate("body", "collapse");
      wait 10;

      if(isDefined(scriptable)) {
        scriptable freescriptable();
      }

      break;
    }
  }
}

function function_67145692c7f7c798() {
  self endon("death");
  self waittill("trigger");
  flag_set("rift_run_infil_gate_collapse_triggered");
}
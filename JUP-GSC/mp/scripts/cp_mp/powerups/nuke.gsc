/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\powerups\nuke.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\powerups\powerups;
#using scripts\engine\utility;
#namespace nuke;

function autoexec main() {
  init_nuke();
}

function init_nuke() {
  register_powerup("nuke", &grab_nuke, &function_f23ad00303ba63e2);

  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2f>", "<dev string:x49>", &function_e2b8eeccc951133f);
  function_b23a59dfb4ca49a1("<dev string:x67>", "<dev string:x81>", &function_e2b8eeccc951133f);
  function_fe953f000498048f();
}

function private function_f23ad00303ba63e2() {
  if(flag("powerup_disable_nuke")) {
    return false;
  }

  return true;
}

function grab_nuke(str_powerup, ent_powerup, var_e3f071c0be79ecce, var_1c0c489113c9d46a, var_8d1aa1efbf8b3c6e, var_2bb5673b997944c1, var_82bc4143d5c2c838, ai_override) {
  if(!istrue(var_2bb5673b997944c1) && !isent(ent_powerup) && !ent_powerup isscriptableinstance()) {
    assertmsg("<dev string:x9f>");
  }

  root = function_ecdae672c660149e();
  v_origin = ent_powerup.origin;
  a_players = function_a56a8b17eae57b09(str_powerup, v_origin);
  powerup_radius = function_896f9300bcde23c2(str_powerup);
  level thread function_989aab7b4cf26796(str_powerup);
  a_ai = [];

  if(powerup_radius > 0) {
    a_ai = getaiarrayinradius(v_origin, powerup_radius);
  } else {
    a_ai = getaiarray();
  }

  var_97ab608af336843f = [];

  foreach(player in a_players) {
    player notify("nuke_triggered");

    if(!istrue(var_82bc4143d5c2c838)) {
      player thread nuke_screen_flash();
    }

    if(!istrue(var_1c0c489113c9d46a)) {
      player thread function_676437737684783f(str_powerup);
    }

    foreach(ai in a_ai) {
      if(ai.team == player.team || ai.team == "neutral" || array_contains(var_97ab608af336843f, ai)) {
        continue;
      }

      var_97ab608af336843f = array_add(var_97ab608af336843f, ai);
    }
  }

  params = spawnStruct();
  params.player = self;
  callback::callback("on_powerup_nuke_pickup", params);

  if(!isDefined(ai_override)) {
    nuke_ais(v_origin, var_97ab608af336843f, str_powerup, var_8d1aa1efbf8b3c6e);
  } else {
    nuke_ais(v_origin, ai_override, str_powerup, var_8d1aa1efbf8b3c6e);
  }

  ent_powerup notify("picked_up");
  level notify("nuke_complete");

  if(isDefined(root.var_cc680f1d779ccc51) && !istrue(var_e3f071c0be79ecce)) {
    foreach(player in a_players) {
      player[[root.var_cc680f1d779ccc51]]("powerup_nuke");
    }
  }
}

function private nuke_ais(v_location, a_ais, str_powerup, var_8d1aa1efbf8b3c6e) {
  foreach(ai in a_ais) {
    if(isalive(ai) && !istrue(ai.var_9469c4af69070d96)) {
      ai function_b9fd0ad5dff0ced6(1.5);
    }
  }

  wait 0.5;
  var_473ff5b31f1ed342 = array_removedead(a_ais);
  var_473ff5b31f1ed342 = get_array_of_closest(v_location, var_473ff5b31f1ed342);
  var_3162896c2041ab88 = [];

  foreach(ai in var_473ff5b31f1ed342) {
    if(!isalive(ai)) {
      continue;
    }

    b_skip = 0;

    if(istrue(ai.ignore_nuke) || istrue(ai.var_9469c4af69070d96) || istrue(ai.magic_bullet_shield)) {
      b_skip = 1;
    }

    if(istrue(ai.marked_for_death)) {
      b_skip = 1;
    }

    if(isDefined(ai.nuke_damage_func)) {
      ai thread[[ai.nuke_damage_func]]();
      b_skip = 1;
    }

    if(b_skip) {
      if(!istrue(ai.var_9469c4af69070d96)) {
        ai function_d4e0b51ec4d153cd();
      }

      continue;
    }

    ai function_f6ac370ea1b13ec7(100);
    ai.marked_for_death = 1;

    if(!istrue(ai.nuked)) {
      ai.nuked = 1;
      ai.no_powerups = 1;
      ai.var_7e4b076a06c6df27 = 1;
      ai.full_gib = 1;
      ai.var_745cd904c1ec804c = 1;

      if(isDefined(level.gametype) && level.gametype == "zm_rb") {
        ai.var_745cd904c1ec804c = 0;
      }

      var_3162896c2041ab88 = array_add(var_3162896c2041ab88, ai);

      if(issharedfuncdefined("zombie_utils", "setMoveSpeed")) {
        ai utility::callsharedfunc("zombie_utils", "setMoveSpeed", "walk", "nuke", 26);
      }
    }
  }

  nuke_ent = undefined;

  foreach(ai_nuked in var_3162896c2041ab88) {
    wait randomfloatrange(0.1, 0.3);

    if(!isalive(ai_nuked)) {
      continue;
    }

    ai_nuked function_d4e0b51ec4d153cd();

    if(istrue(ai_nuked.magic_bullet_shield)) {
      continue;
    }

    ai_nuked playSound("evt_zm_core_powerup_nuke_soul");
    var_bc8818c262ac2b04 = undefined;

    if(isDefined(ai_nuked.aicategory) && !istrue(var_8d1aa1efbf8b3c6e)) {
      if(ai_nuked.aicategory == "special") {
        var_bc8818c262ac2b04 = ai_nuked.maxhealth * function_519d44e54a9b8ae5(str_powerup).var_74576b4dd247d7b1;
      } else if(ai_nuked.aicategory == "elite") {
        var_bc8818c262ac2b04 = ai_nuked.maxhealth * function_519d44e54a9b8ae5(str_powerup).var_e896465ad8ccd911;
      } else if(ai_nuked.aicategory == "boss") {
        var_bc8818c262ac2b04 = ai_nuked.maxhealth * function_519d44e54a9b8ae5(str_powerup).var_ef9e49bce3c346a3;
      }
    }

    if(isagent(ai_nuked) && isDefined(ai_nuked.unittype) && ai_nuked.unittype == "soldier") {
      ai_nuked notify("flashbang", ai_nuked.origin, 1, 1, self, self.team);
      var_bc8818c262ac2b04 = 0;
    }

    if(isDefined(var_bc8818c262ac2b04) && var_bc8818c262ac2b04 < ai_nuked.health) {
      if(!isDefined(nuke_ent)) {
        nuke_ent = spawn("script_model", v_location);
      }

      if(var_bc8818c262ac2b04 > 0) {
        ai_nuked dodamage(int(var_bc8818c262ac2b04), ai_nuked.origin, isDefined(self) ? self : undefined, nuke_ent, "MOD_UNKNOWN", "none", "none", undefined, 65536);
      }

      ai_nuked.marked_for_death = 0;
      ai_nuked.nuked = 0;
      ai_nuked.var_745cd904c1ec804c = 0;
      ai_nuked.no_powerups = 0;
      ai_nuked.var_7e4b076a06c6df27 = 0;
      ai_nuked.full_gib = 0;
      continue;
    }

    ai_nuked kill();
  }

  if(isDefined(nuke_ent)) {
    nuke_ent delete();
  }
}

function private function_989aab7b4cf26796(str_powerup) {
  level endon("game_ended");
  function_32bcd3aa4ea61fef(1);
  level waittill("nuke_complete");
  var_7cdde71f8305d204 = default_to(function_519d44e54a9b8ae5(str_powerup).var_35b3bfa760c6734a, 1);
  level waittill_notify_or_timeout("abort_nuke", var_7cdde71f8305d204);
  function_32bcd3aa4ea61fef(0);
}

function private function_c50deed1f3c001cd(var_9611ccf0d8d1a3b1) {
  self.nuke_damage_func = &nuke_damage_func;
  self.var_a9b5b540de6a20da = var_9611ccf0d8d1a3b1;
}

function private nuke_damage_func() {
  self endon("death");
  wait randomfloatrange(0.1, 0.7);
  self dodamage(self.maxhealth * self.var_a9b5b540de6a20da, self.origin);
}

function private nuke_screen_flash() {
  self notify("play_nuke_screen_flash");
  self endon("death_or_disconnect");
  self endon("play_nuke_screen_flash");

  if(!isDefined(self.white_screen_overlay)) {
    self.white_screen_overlay = newclienthudelem(self);
    self.white_screen_overlay.x = 0;
    self.white_screen_overlay.y = 0;
    self.white_screen_overlay setshader("white", 640, 480);
    self.white_screen_overlay.alignx = "left";
    self.white_screen_overlay.aligny = "top";
    self.white_screen_overlay.sort = 1;
    self.white_screen_overlay.horzalign = "fullscreen";
    self.white_screen_overlay.vertalign = "fullscreen";
    self.white_screen_overlay.alpha = 0;
    self.white_screen_overlay.foreground = 1;
    self.white_screen_overlay.archived = 0;
    self.white_screen_overlay.scramblerdisabled = 1;
  }

  var_52bee65a8171b558 = 0.2;
  n_target_alpha = 0.8;
  self.white_screen_overlay fadeovertime(var_52bee65a8171b558);
  self.white_screen_overlay.alpha = n_target_alpha;
  wait 0.5;
  var_52bee65a8171b558 = 0.5;
  self.white_screen_overlay fadeovertime(var_52bee65a8171b558);
  self.white_screen_overlay.alpha = 0;
  wait var_52bee65a8171b558;

  if(isDefined(self.white_screen_overlay)) {
    self.white_screen_overlay destroy();
  }
}

function private function_66f6f1eccfecf8b2(screen_alpha) {
  if(isDefined(self.white_screen_overlay)) {
    self.white_screen_overlay.alpha = clamp(screen_alpha, 0, 1);
  }
}

function private function_32bcd3aa4ea61fef(var_cc3537297eff0ba9) {
  root = function_ecdae672c660149e();

  if(!isDefined(root.var_52a317ac50778cc2)) {
    return;
  }

  foreach(listener in root.var_52a317ac50778cc2) {
    level[[listener]](var_cc3537297eff0ba9);
  }
}

function private function_f6ac370ea1b13ec7(n_dur) {
  if(utility::issharedfuncdefined("zombie", "stunZombie")) {
    utility::callsharedfunc("zombie", "stunZombie", n_dur);
  }
}

function private function_b9fd0ad5dff0ced6(var_8c28aac0b76c1e2e) {
  function_f6ac370ea1b13ec7(var_8c28aac0b76c1e2e);
  params = spawnStruct();
  params.attacker = undefined;
  params.var_51357609845cf128 = gettime();
  callback::callback("burned", params);
}

function private function_d4e0b51ec4d153cd() {
  if(utility::issharedfuncdefined("zombie", "clearStunZombie")) {
    utility::callsharedfunc("zombie", "clearStunZombie");
  }

  params = spawnStruct();
  params.attacker = undefined;
  params.var_51357609845cf128 = gettime();
  callback::callback("burned_end", params);
}

function function_15bb2ab41d66232b(var_74eaaa06e59a9abe) {
  root = function_ecdae672c660149e();

  if(!isDefined(root.var_52a317ac50778cc2)) {
    root.var_52a317ac50778cc2 = [];
  }

  root.var_52a317ac50778cc2[root.var_52a317ac50778cc2.size] = var_74eaaa06e59a9abe;
}

function function_5e61eba5db66a9d4(var_c73f22604801c8a8) {
  root = function_ecdae672c660149e();
  root.var_c88dfab5f7fb9cdb = var_c73f22604801c8a8;
}

function function_3204683321678438() {
  root = function_ecdae672c660149e();

  if(!isDefined(root.var_c88dfab5f7fb9cdb)) {
    return 1;
  }

  return root.var_c88dfab5f7fb9cdb;
}
/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1260535c202c8074.gsc
*************************************************/

#using script_36d7680b337b15b;
#using script_7edf952f8921aa6b;
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_deathworm;

function function_14c91797faca36ea() {
  self.var_544ffa1d219d6810 = undefined;
  self.var_a60b211ca1cf2a4e = 0;
  self.var_cadb0f258ae78683 = 400;
  self.var_ee9e6782a568c4b8 = (0, 0, 0);
  self.var_fbef01b91da52bb4 = (0, 0, 0);
  thread function_b0e7001af987a581();

  function_ac58fa04e888ee59();
}

function private function_c40494a8d15caec5() {
  self endon("death");
  self endon("head_banger_end");
  self.var_ee9e6782a568c4b8 = function_1e6eb451a42c6428();

  while(true) {
    lerp_speed = getdvarfloat(@ "hash_a306914883c4c84c", 1);
    self.var_fbef01b91da52bb4 = vectorlerp(self.var_fbef01b91da52bb4, self.var_ee9e6782a568c4b8, lerp_speed * level.framedurationseconds);
    self.var_a60b211ca1cf2a4e = remap(self.var_fbef01b91da52bb4[0], -1, 1, -10, 10);
    self.var_cadb0f258ae78683 = remap(self.var_fbef01b91da52bb4[1], -1, 1, 500, 1000);
    self function_a490fd20800374d8(self.var_a60b211ca1cf2a4e);
    self function_12df4eebdbb4f79(self.var_cadb0f258ae78683);

    if(function_f21916a31744af3d()) {
      head_pos = self gettagorigin("<dev string:x1c>");
      line(self.origin, head_pos, (1, 0, 0));
      bite_print("<dev string:x26>" + distance2d(self.origin, head_pos), head_pos);
    }

    waitframe();
  }
}

function private function_b0e7001af987a581() {
  self endon("death");

  while(true) {
    self waittill("head_banger_start");
    thread function_c40494a8d15caec5();
    thread function_6a5dc7d9a0e40afd();
    ai::function_3e5ce428974325fb("head_banger_cooldown", getdvarint(@ "hash_8d491b8262cfd18c", 15000));
  }
}

function private function_6a5dc7d9a0e40afd() {
  self endon("death");
  self endon("head_banger_start");
  self endon("head_banger_end");
  alive_percentage = [[self.var_c54a21ea717fe8a5]]();

  while(true) {
    self waittill("head_banger_hit");
    head_pos = self gettagorigin("j_head");
    self.var_ee9e6782a568c4b8 = function_1e6eb451a42c6428();
    self setscriptablepartstate("audio", "headbanger_impact");
    damage = 2000;

    if(istrue(self.var_fa1a1806d30a40e1) && alive_percentage >= 0.5 && self.var_f8adf1aaec88d636 > 1) {
      damage *= 10;
    }

    melee_impact(0, 800, damage);
  }
}

function private function_832a9a6b9710311b(player, damage_point) {
  player knockback_flat(player.origin - damage_point, 400);
  player playRumbleOnEntity("heavy_1s");
}

function private function_1e6eb451a42c6428() {
  target_point = (randomfloat(1) - 0.5, randomfloat(1) - 0.5, 0);
  target_point = rotatepointaroundvector((0, 0, 1), target_point, 45);
  return target_point;
}

function function_ac58fa04e888ee59() {
  function_6e7290c8ee4f558b("<dev string:x3c>");
  function_a9a864379a098ad6("<dev string:x5b>", "<dev string:x70>", &function_c81577b184a48779);
  function_a9a864379a098ad6("<dev string:x8a>", "<dev string:x9f>", &function_6eb4d0ea6eb40878);
  function_fe953f000498048f();
}

function private function_c81577b184a48779() {
  worm = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:xb9>");

  if(!isDefined(worm)) {
    return;
  }

  worm function_3e89eb3d8e3f1811("<dev string:xcd>", 1);
}

function private function_f21916a31744af3d() {
  return getdvarint(@ "hash_2602a364f90130b2", 0) > 0;
}

function private function_6eb4d0ea6eb40878() {
  function_2fb888667001fc39("<dev string:xdf>", @ "hash_2602a364f90130b2");
}

function private bite_print(text, pos) {
  if(function_f21916a31744af3d()) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:xfe>" + text, (1, 0, 0));
  }
}

# /
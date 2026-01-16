/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_damagefeedback.gsc
*****************************************************/

init() {
  precacheshader("damage_feedback");
  common_scripts\utility::array_thread(level.players, ::init_damage_feedback);
  common_scripts\utility::array_thread(level.players, ::monitordamage);
}

init_damage_feedback() {
  self.hud_damagefeedback = newclienthudelem(self);
  self.hud_damagefeedback.alignx = "center";
  self.hud_damagefeedback.aligny = "middle";
  self.hud_damagefeedback.horzalign = "center";
  self.hud_damagefeedback.vertalign = "middle";
  self.hud_damagefeedback.alpha = 0;
  self.hud_damagefeedback.archived = 1;
  self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  self.hud_damagefeedback.y = 12;
}

monitordamage() {
  maps\_utility::add_damage_function(::damagefeedback_took_damage);
}

stopmonitordamage() {
  maps\_utility::remove_damage_function(::damagefeedback_took_damage);
}

damagefeedback_took_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isplayer(var_1)) {
    return;
  }
  if(!maps\_utility::is_damagefeedback_enabled()) {
    return;
  }
  if(isDefined(self.bullet_resistance)) {
    var_7 = [];
    var_7["MOD_PISTOL_BULLET"] = 1;
    var_7["MOD_RIFLE_BULLET"] = 1;

    if(isDefined(var_7[var_4])) {
      if(var_0 <= self.bullet_resistance)
        return;
    }
  }

  var_1 updatedamagefeedback(self);
}

updatedamagefeedback(var_0) {
  if(!isplayer(self)) {
    return;
  }
  if(!isDefined(var_0.team)) {
    return;
  }
  if(var_0.team == self.team || var_0.team == "neutral") {
    return;
  }
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield) {
    return;
  }
  if(isDefined(var_0.godmode) && var_0.godmode) {
    return;
  }
  if(isDefined(var_0.script_godmode) && var_0.script_godmode) {
    return;
  }
  self playlocalsound("SP_hit_alert");
  var_1 = 1;

  if(isDefined(level.slowmo.speed_slow))
    var_1 = level.slowmo.speed_slow;

  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(var_1);
  self.hud_damagefeedback.alpha = 0;
  var_2 = getdvarfloat("cg_crosshairVerticalOffset") * 240;
  self.hud_damagefeedback.y = 12 - int(var_2);
}
/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\227.gsc
**************************************/

init() {
  precacheshader("damage_feedback");
  common_scripts\utility::array_thread(level.players, ::_id_1A26);
  common_scripts\utility::array_thread(level.players, ::_id_1A28);
}

_id_1A26() {
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

_id_1A28() {
  maps\_utility::_id_12E2(::_id_1A2B);
}

_id_1A29() {
  maps\_utility::_id_1A2A(::_id_1A2B);
}

_id_1A2B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isplayer(var_1)) {
    return;
  }
  if(!maps\_utility::_id_1A2C()) {
    return;
  }
  if(isDefined(self._id_1A2D)) {
    var_7 = [];
    var_7["MOD_PISTOL_BULLET"] = 1;
    var_7["MOD_RIFLE_BULLET"] = 1;

    if(isDefined(var_7[var_4])) {
      if(var_0 <= self._id_1A2D) {
        return;
      }
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
  if(isDefined(var_0._id_0D04) && var_0._id_0D04) {
    return;
  }
  if(isDefined(var_0.godmode) && var_0.godmode) {
    return;
  }
  if(isDefined(var_0._id_2982) && var_0._id_2982) {
    return;
  }
  self playlocalsound("SP_hit_alert");
  var_1 = 1;

  if(isDefined(level._id_1A2F._id_1A30)) {
    var_1 = level._id_1A2F._id_1A30;

  }
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(var_1);
  self.hud_damagefeedback.alpha = 0;
  var_2 = getdvarfloat("cg_crosshairVerticalOffset") * 240;
  self.hud_damagefeedback.y = 12 - int(var_2);
}
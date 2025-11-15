/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\shrapnel.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;

#namespace shrapnel;

autoexec __init__system__() {
  system::register(#"shrapnel", undefined, &__postload_init__, undefined);
}

__postload_init__() {
  if(!getdvarint(#"shrapnel_enabled", 0)) {
    return;
  }

  if(!level.new_health_model) {
    return;
  }

  level.var_67f97f4 = [];
  level.var_67f97f4[1] = "generic_explosion_overlay_01";
  level.var_67f97f4[2] = "generic_explosion_overlay_02";
  level.var_67f97f4[3] = "generic_explosion_overlay_03";
  level.var_67f97f4[4] = "generic_explosion_overlay_03";
  callback::on_localplayer_spawned(&localplayer_spawned);
}

private localplayer_spawned(localclientnum) {
  if(!self function_21c0fa55()) {
    return;
  }

  level thread wait_game_ended(localclientnum);
  self thread function_989d336d(localclientnum);
  self thread function_8f0cb320(localclientnum);
  new_health_model_ui_model = createuimodel(getuimodelforcontroller(localclientnum), "usingNewHealthModel");

  if(isDefined(new_health_model_ui_model)) {
    setuimodelvalue(new_health_model_ui_model, level.new_health_model);
  }
}

private function_8f0cb320(localclientnum) {
  self waittill(#"death");
  self function_816d735d(localclientnum);
  self end_splatter(localclientnum);
}

private enable_shrapnel(localclientnum) {
  self.shrapnel_enabled = 1;

  if(!isDefined(self.var_f08b8b9)) {
    self.var_f08b8b9 = "generic_explosion_overlay_01";
  }

  setfilterpassmaterial(localclientnum, 6, 1, get_mat_id(localclientnum, self.var_f08b8b9));
  filter::function_9ff66ea3(localclientnum, 6, 1, 1);
  setfilterpassenabled(localclientnum, 6, 1, 1);
}

private get_mat_id(localclientnum, filter_name) {
  mat_id = filter::mapped_material_id(filter_name);

  if(!isDefined(mat_id)) {
    filter::map_material_helper_by_localclientnum(localclientnum, filter_name);
    mat_id = filter::mapped_material_id(filter_name);
  }

  return mat_id;
}

private function_816d735d(localclientnum) {
  if(isDefined(self)) {
    self.shrapnel_enabled = 0;
  }

  setfilterpassenabled(localclientnum, 6, 1, 0);
}

private function_989d336d(localclientnum) {
  self endon(#"disconnect");
  self endon(#"death");
  assert(level.new_health_model == 1);
  basehealth = 100;
  playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
  var_8e5bb835 = playerhealth;

  while(true) {
    if(!isDefined(self.shrapnel_enabled)) {
      self.shrapnel_enabled = 0;
    }

    var_df99eba3 = 0;

    if(renderhealthoverlay(localclientnum)) {
      priorplayerhealth = playerhealth;
      playerhealth = renderhealthoverlayhealth(localclientnum, basehealth);
      var_89524e53 = function_e31d7cf9(playerhealth, priorplayerhealth, basehealth);
      var_d081e441 = function_bf9b3d6(playerhealth, basehealth);

      if(playerhealth > var_8e5bb835 || playerhealth <= var_d081e441) {
        var_8e5bb835 = playerhealth;
      }

      var_387f8be9 = self function_a6fe4166();
      var_ba6de045 = self.var_d9167e48 === 1;

      if(var_ba6de045) {
        var_1e429b84 = var_8e5bb835 - playerhealth >= 1 / basehealth - 0.0001;

        if(var_1e429b84 && playerhealth > var_d081e441) {
          self thread splatter(localclientnum);
          var_8e5bb835 = playerhealth;
          self.var_d9167e48 = 0;
        }
      }

      shouldenabledoverlay = 0;

      if(var_387f8be9 > 0 && playerhealth <= var_89524e53) {
        var_df99eba3 = 1;
      }

      self function_4e9cfc19(localclientnum, playerhealth, priorplayerhealth, basehealth);
    }

    if(var_df99eba3) {
      if(!self.shrapnel_enabled) {
        self enable_shrapnel(localclientnum);
      }
    } else if(self.shrapnel_enabled) {
      self function_816d735d(localclientnum);
    }

    waitframe(1);
  }
}

private function_a6fe4166() {
  return false;
}

function_e31d7cf9(playerhealth, priorplayerhealth, basehealth) {
  healing = playerhealth > priorplayerhealth;

  if(healing || self.var_fe44fc0f === 1) {
    self.var_fe44fc0f = playerhealth >= priorplayerhealth;
    return (getdvarint(#"hash_5a4cebcd3aef8f0", 90) / basehealth);
  }

  return getdvarint(#"hash_213e599222859525", 90) / basehealth;
}

function_bf9b3d6(playerhealth, basehealth) {
  return getdvarint(#"hash_213e599222859525", 90) / basehealth;
}

private function_4e9cfc19(localclientnum, playerhealth, priorplayerhealth, basehealth = 100) {
  if(!isDefined(self.var_996ceac2)) {
    self.var_996ceac2 = 0;
  }

  var_89524e53 = self function_e31d7cf9(playerhealth, priorplayerhealth, basehealth);
  stage2_threshold = getdvarint(#"hash_213e56922285900c", 69) / basehealth;
  stage3_threshold = getdvarint(#"hash_213e5792228591bf", 29) / basehealth;
  stage4_threshold = getdvarint(#"hash_213e549222858ca6", 1) / basehealth;
  var_5142946f = self.var_996ceac2;
  var_387f8be9 = self function_a6fe4166();

  if(var_387f8be9 != var_5142946f) {
    if(var_387f8be9 > 0) {
      self.var_f08b8b9 = level.var_67f97f4[var_387f8be9];
      filter::map_material_helper_by_localclientnum(localclientnum, self.var_f08b8b9);

      if(self.shrapnel_enabled) {
        setfilterpassmaterial(localclientnum, 6, 1, filter::mapped_material_id(self.var_f08b8b9));
      }
    }
  }

  self.var_996ceac2 = var_387f8be9;
}

private splatter(localclientnum) {
  self notify(#"hash_343f00346af5b101");
  self endon(#"hash_343f00346af5b101");
  splatter_opacity = getdvarfloat(#"hash_95576df1970dd46", 1);
  start_splatter(localclientnum);
  initial_delay = math::clamp(getdvarint(#"hash_41140ec15abcde62", 100), 10, 3000);
  wait float(initial_delay) / 1000;

  if(!isDefined(self)) {
    end_splatter(localclientnum);
    return;
  }

  lasttime = self getclienttime();

  while(splatter_opacity > 0.9 && isDefined(self)) {
    now = self getclienttime();
    elapsedtime = now - lasttime;

    if(elapsedtime > 0) {
      fadeduration = math::clamp(getdvarint(#"hash_34e60a4256fbc184", 5000), 10, 88000);
      splatter_opacity -= elapsedtime / fadeduration;
      splatter_opacity = math::clamp(splatter_opacity, 0, 1);
      lasttime = now;
    }

    filter::function_9ff66ea3(localclientnum, 6, 0, splatter_opacity);
    waitframe(1);
  }

  wait getdvarfloat(#"hash_624718787e051400", 1.5);

  if(!isDefined(self)) {
    end_splatter(localclientnum);
    return;
  }

  lasttime = self getclienttime();

  while(splatter_opacity > 0 && isDefined(self)) {
    now = self getclienttime();
    elapsedtime = now - lasttime;

    if(elapsedtime > 0) {
      fadeduration = math::clamp(getdvarint(#"hash_34e60d4256fbc69d", 500), 10, 88000);
      splatter_opacity -= elapsedtime / fadeduration;
      splatter_opacity = math::clamp(splatter_opacity, 0, 1);
      lasttime = now;
    }

    filter::function_9ff66ea3(localclientnum, 6, 0, splatter_opacity);
    waitframe(1);
  }

  end_splatter(localclientnum);
}

private start_splatter(localclientnum) {
  filter::map_material_helper_by_localclientnum(localclientnum, "generic_explosion_overlay_00");
  setfilterpassmaterial(localclientnum, 6, 0, filter::mapped_material_id("generic_explosion_overlay_00"));
  filter::function_9ff66ea3(localclientnum, 6, 0, getdvarfloat(#"hash_95576df1970dd46", 1));
  setfilterpassenabled(localclientnum, 6, 0, 1);
}

private end_splatter(localclientnum) {
  setfilterpassenabled(localclientnum, 6, 0, 0);
}

private wait_game_ended(localclientnum) {
  if(!isDefined(level.var_b6a1586d)) {
    level.var_b6a1586d = [];
  }

  if(level.var_b6a1586d[localclientnum] === 1) {
    return;
  }

  level.var_b6a1586d[localclientnum] = 1;
  level waittill(#"game_ended");
  level.var_b6a1586d[localclientnum] = 0;
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\sensor_dart.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace sensor_dart;

autoexec __init__system__() {
  system::register(#"sensor_dart", &init_shared, undefined, undefined);
}

init_shared(localclientnum) {
  clientfield::register("missile", "sensor_dart_state", 1, 1, "int", &function_73021afc, 0, 1);
  clientfield::register("clientuimodel", "hudItems.sensorDartCount", 1, 3, "int", undefined, 0, 0);
  callback::on_localclient_connect(&player_init);
  callback::add_weapon_type("eq_sensor", &arrow_spawned);
}

arrow_spawned(localclientnum) {
  self.var_44dad7e8 = 1;
}

player_init(localclientnum) {
  self thread on_game_ended(localclientnum);
}

private function_73021afc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  starttime = gettime();

  while(isDefined(self) && !self hasdobj(localclientnum)) {
    if(gettime() - starttime > 1000) {
      return;
    }

    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  self function_8e04481f();

  switch (newval) {
    case 0:
    default:
      self disablevisioncircle(localclientnum);
      break;
    case 1:
      self thread function_a252eaf0(localclientnum);
      self thread function_e3a084cd(localclientnum);
      self hideunseencompassicon();
      break;
  }
}

private function_a252eaf0(localclientnum) {
  var_9cf4b61c = self getentitynumber();
  self waittill(#"death");

  if(isDefined(self.var_b44c157f)) {
    self.var_b44c157f delete();
  }

  disablevisioncirclebyentnum(localclientnum, var_9cf4b61c);
}

private function_e3a084cd(localclientnum) {
  self setcompassicon("minimap_sensor_dart_flying");
  self function_8e04481f();
  self function_a5edb367(#"neutral");
  self thread function_6527a2e9(localclientnum, "o_recon_sensor_gun_projectile_closed_idle");
  var_9cf4b61c = self getentitynumber();
  self endon(#"death");
  flystarttime = getservertime(localclientnum);
  startorigin = self.origin;
  var_dc3f8ecd = startorigin;
  var_3d3d7bb1 = 0;
  localplayer = function_5c10bd79(localclientnum);
  self.var_b44c157f = spawn(localclientnum, self.origin, "script_model", localplayer getentitynumber(), self.team);
  self.var_b44c157f setModel(#"tag_origin");
  self.var_b44c157f linkto(self);
  self.var_b44c157f setcompassicon("minimap_sensor_dart_pip");
  self.var_b44c157f function_8e04481f();
  self.var_b44c157f function_5e00861(0.25);
  self.var_b44c157f function_a5edb367(#"neutral");

  while(var_3d3d7bb1 < 250) {
    var_dc3f8ecd = self.origin;
    var_450cbe48 = getservertime(localclientnum);
    elapsedtime = var_450cbe48 - flystarttime;

    if(true) {
      var_e460f21 = math::clamp(elapsedtime / 500, 0, 1);
      radius = lerpfloat(200, 600, var_e460f21);
      distance = distance2d(self.origin, startorigin);

      if(distance > 200) {
        self.angles = vectortoangles(self.origin - startorigin);
        var_354c76a5 = atan(radius / distance);

        if(var_3d3d7bb1 > 0) {
          var_354c76a5 *= (250 - var_3d3d7bb1) / 250;
          self function_5e00861(0);
        } else {
          self function_5e00861(radius / 200 * 0.6);
        }

        self enablevisioncircle(localclientnum, distance, 1, var_354c76a5 * 2);
      }
    }

    waitframe(1);
    parent = self getlinkedent();

    if(isDefined(parent) || var_dc3f8ecd == self.origin) {
      var_3d3d7bb1 = var_3d3d7bb1 + getservertime(localclientnum) - var_450cbe48;
      continue;
    }

    var_3d3d7bb1 = 0;
  }

  if(isDefined(self.var_b44c157f)) {
    self.var_b44c157f delete();
  }

  self setcompassicon("minimap_sensor_dart");
  self function_8e04481f();
  self function_5e00861(0.62);
  dart_radius = sessionmodeiswarzonegame() ? 2400 : 800;

  if(isDefined(level.sensor_dart_radius)) {
    dart_radius = level.sensor_dart_radius;
  }

  self enablevisioncircle(localclientnum, dart_radius, 1);
  self thread function_6527a2e9(localclientnum, "o_recon_sensor_gun_projectile_open", "o_recon_sensor_gun_projectile_closed_idle");
  self thread function_e140ca2b(localclientnum);
}

private on_game_ended(localclientnum) {
  level waittill(#"game_ended");
  disableallvisioncircles(localclientnum);
}

function_6527a2e9(localclientnum, animname, prevanim) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanimrestart(animname, 1, 0, 1);

  if(isDefined(prevanim)) {
    self setanimrestart(prevanim, 0, 0, 1);
  }
}

function_e140ca2b(localclientnum) {
  self endon(#"death");
  self waittill(#"finished_opening");
  self thread function_6527a2e9(localclientnum, "o_recon_sensor_gun_projectile_open_idle");
}
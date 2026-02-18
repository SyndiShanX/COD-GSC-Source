/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4a04e1760d0523d3.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\struct;
#using scripts\core_common\throttle_shared;
#namespace namespace_b77e8eb1;

function init() {
  level.var_cd139dc0 = max(isDefined(getgametypesetting(#"hash_7f837b709840950")) ? getgametypesetting(#"hash_7f837b709840950") : 1, 1) * 100;
  level.var_60693fca = (isDefined(getgametypesetting(#"hash_37aefeabeef0ec6c")) ? getgametypesetting(#"hash_37aefeabeef0ec6c") : 0) * 100;
  clientfield::register("scriptmover", "ftdb_zoneCircle", 1, 3, "int", &function_f4d234f9, 0, 0);
  clientfield::register("scriptmover", "zoneNearOOB", 1, 1, "int", &function_b315a5d2, 0, 0);
  clientfield::register("scriptmover", "disable_compass_arrow", 1, 1, "int", &disable_compass_arrow, 0, 0);

  if(!isDefined(level.var_cfdf3928)) {
    level.var_99266dd4 = new class_c6c0e94();
    [[level.var_99266dd4]] - > initialize("radiation_compass", 1, 0.016);
  }

  level.circleradius = 800;
  level.var_53b9c763 = [];
  level.var_4f67e1b = [];
  level.var_bae7602b = 1;
  level thread function_84d33874();
  callback::on_localclient_connect(&on_local_client_connect);
}

function private function_f4d234f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"hash_41a7922ed68f0877");

  if(bwastimejump == 3) {
    compassicon = "ui_icon_minimap_radiation_intensity_3";
    self setcompassicon(compassicon);
    self function_811196d1(0);
    self function_60212003(0);
    self function_a5edb367(#"neutral");
    self function_5e00861(level.var_60693fca * 2, 1);
    level thread function_81784679(self, fieldname);
    return;
  }

  if(bwastimejump == 4) {
    self function_1cfa2520(fieldname);
    return;
  }

  if(bwastimejump > 0) {
    self function_6856257d(fieldname);
    compassicon = "ui_icon_minimap_radiation_cloud";
    self setcompassicon(compassicon);
    self function_811196d1(0);
    self function_95bc465d(1);
    self function_60212003(0);
    self function_ce541a6(1);

    if(bwastimejump == 1) {
      self thread function_1ef0dbb2();
    } else if(bwastimejump == 2) {
      self function_5f865d4b(fieldname, level.var_bae7602b);
      self thread function_88008fc3();
    }

    level thread function_81784679(self, fieldname);
    return;
  }

  self function_811196d1(1);
  self function_5f865d4b(fieldname, 0);
}

function function_b315a5d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(is_true(level.var_ce4d744a)) {
    return;
  }

  if(bwastimejump) {
    function_c8be8eb1(fieldname, 1);
    return;
  }

  function_c8be8eb1(fieldname, 0);
}

function private function_6856257d(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.zonefx)) {
    self.zonefx = [];
  }

  if(isDefined(self.zonefx[localclientnum])) {
    return;
  }

  if(!squad_spawn::function_21b773d5(localclientnum)) {
    self.zonefx[localclientnum] = playFX(localclientnum, "wz/fx9_dirtybomb_radiation_zone", self.origin + (0, 0, 80));
  } else {
    self.zonefx[localclientnum] = playFX(localclientnum, "wz/fx9_dirtybomb_radiation_zone_spawn", self.origin + (0, 0, 80));
  }

  if(!isDefined(level.var_53b9c763[localclientnum])) {
    level.var_53b9c763[localclientnum] = [];
  }

  level.var_53b9c763[localclientnum][self.zonefx[localclientnum]] = self;
}

function private function_1cfa2520(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.zonefx[localclientnum])) {
    return;
  }

  level.var_53b9c763[localclientnum][self.zonefx[localclientnum]] = undefined;
  arrayremovevalue(level.var_53b9c763[localclientnum], undefined);
  stopfx(localclientnum, self.zonefx[localclientnum]);
  self.zonefx[localclientnum] = undefined;
  arrayremovevalue(self.zonefx, undefined);

  if(self.zonefx.size == 0) {
    self.zonefx = undefined;
  }
}

function private function_1ef0dbb2() {
  self endon(#"death", #"hash_41a7922ed68f0877");

  while(isDefined(self) && isDefined(self.scale)) {
    if(!isDefined(level.circleradius) || !(isint(level.circleradius) || isfloat(level.circleradius))) {
      waitframe(1);
      continue;
    }

    if(!isDefined(self.scale) || !(isint(self.scale) || isfloat(self.scale))) {
      waitframe(1);
      continue;
    }

    compassscale = level.circleradius * self.scale * 3;
    self function_5e00861(compassscale, 1);
    [[level.var_99266dd4]] - > waitinqueue(self);
  }
}

function private function_88008fc3() {
  self endon(#"death", #"hash_41a7922ed68f0877");

  while(isDefined(self.scale)) {
    compassscale = level.var_cd139dc0 * self.scale * 2.8 * 10;
    self function_5e00861(compassscale, 1);
    [[level.var_99266dd4]] - > waitinqueue(self);
  }
}

function private function_81784679(ent, localclientnum) {
  ent waittill(#"death");
  ent function_811196d1(1);
  ent function_1cfa2520(localclientnum);
  ent function_5f865d4b(localclientnum, 0);
}

function on_local_client_connect(localclientnum) {
  function_8cf3a7d9(localclientnum);
}

function function_84d33874() {
  level endon(#"game_ended");
  level endon(#"disable_compass_arrow");

  while(true) {
    wait 0.05;

    foreach(localclientnum, var_4f67e1b in level.var_4f67e1b) {
      player = function_5c10bd79(localclientnum);
      mapcenter = getmapcenter();
      total_offset = (0, 0, 0);
      var_2932eb0b = 0;

      foreach(var_483a1937 in var_4f67e1b.var_7351c8e1) {
        if(!isDefined(var_483a1937.origin) || !isDefined(var_483a1937.scale)) {
          continue;
        }

        var_9a8acd88 = distance2dsquared(player.origin, var_483a1937.origin);
        radius = level.var_cd139dc0 * var_483a1937.scale * 10;
        radius += 600;

        if(radius * radius < var_9a8acd88) {
          continue;
        }

        var_8675da3 = player.origin - var_483a1937.origin;
        var_8675da3 = (var_8675da3[0], var_8675da3[1], 0);
        var_bd581e61 = vectornormalize(var_8675da3) * radius;

        if(isDefined(var_4f67e1b.targetent)) {
          target = var_4f67e1b.targetent.origin;
        } else if(var_4f67e1b.var_93364ebb) {
          target = getmapcenter();
        }

        if(isDefined(target)) {
          var_d43dd174 = target - player.origin;
          var_d43dd174 = (var_d43dd174[0], var_d43dd174[1], 0);
          a = vectordot(var_d43dd174, var_d43dd174);
          b = 2 * vectordot(var_8675da3, var_d43dd174);
          c = vectordot(var_8675da3, var_8675da3) - radius * radius;
          d = sqrt(b * b - 4 * a * c);

          if(a) {
            t = (d - b) / 2 * a;
            var_14ff2ad5 = t * var_d43dd174;
          } else {
            var_14ff2ad5 = var_d43dd174;
          }
        } else {
          var_14ff2ad5 = var_bd581e61 - var_8675da3;
        }

        total_offset += var_14ff2ad5;
        var_2932eb0b = 1;
      }

      if(isDefined(var_d43dd174) && length2dsquared(total_offset) > length2dsquared(var_d43dd174)) {
        total_offset = target;
      } else {
        total_offset += player.origin;
      }

      function_5c719bd8(localclientnum, var_2932eb0b, total_offset);
    }
  }
}

function function_8cf3a7d9(localclientnum) {
  level.var_4f67e1b[localclientnum] = spawnStruct();
  level.var_4f67e1b[localclientnum].var_7351c8e1 = [];
  level.var_4f67e1b[localclientnum].var_93364ebb = 0;
}

function function_c8be8eb1(localclientnum, enable) {
  level.var_4f67e1b[localclientnum].var_93364ebb = enable;
}

function function_5f865d4b(localclientnum, enable) {
  if(enable) {
    if(!isDefined(level.var_4f67e1b[localclientnum].var_7351c8e1)) {
      level.var_4f67e1b[localclientnum].var_7351c8e1 = [];
    } else if(!isarray(level.var_4f67e1b[localclientnum].var_7351c8e1)) {
      level.var_4f67e1b[localclientnum].var_7351c8e1 = array(level.var_4f67e1b[localclientnum].var_7351c8e1);
    }

    if(!isinarray(level.var_4f67e1b[localclientnum].var_7351c8e1, self)) {
      level.var_4f67e1b[localclientnum].var_7351c8e1[level.var_4f67e1b[localclientnum].var_7351c8e1.size] = self;
    }

    return;
  }

  if(isarray(level.var_4f67e1b[localclientnum].var_7351c8e1)) {
    arrayremovevalue(level.var_4f67e1b[localclientnum].var_7351c8e1, self);
  }
}

function function_270bde4c(localclientnum, ent) {
  level.var_4f67e1b[localclientnum].targetent = ent;
}

function disable_compass_arrow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    level notify(#"disable_compass_arrow");
    level.var_bae7602b = 0;
    return;
  }

  level.var_bae7602b = 1;
}
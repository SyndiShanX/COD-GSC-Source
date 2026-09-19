/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_trap_betty.gsc
*********************************************************/

_id_9C97(var_0) {
  var_0 notify("bouncing_betty_trap_started");
  var_0._id_6667 = common_scripts\utility::_id_46B7("trap_betty_fx_spawns", "script_noteworthy");
  var_1 = getEntArray(var_0.target, "targetname");
  level._id_9C97 = var_1[0];
  level._id_9C97._id_9C92 = var_0;
  level._id_9C97._id_9CBB = var_0._id_0165;

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_0165)) {
      continue;
    }
    if(var_3._id_0165 == "betty_trigger") {
      var_4 = common_scripts\utility::_id_46B7(var_3.target, "targetname");

      if(!isDefined(var_4)) {
        return;
      }
      var_0 thread _id_9CC4(var_3, var_4);
      waitframe();
    }
  }
}

_id_8C2C(var_0) {
  thread _id_9409();
  self._id_9409 = 0;

  while(!common_scripts\utility::_id_562E(self._id_9409)) {
    var_1 = [];
    var_2 = [];
    var_3 = common_scripts\utility::random(var_0);
    var_0 = _func_1AC(var_0, var_3.origin);

    for(var_4 = 0; var_4 < 4; var_4++)
      var_2[var_4] = var_0[int(var_0.size / (var_4 + 1)) - 1];

    for(var_4 = 0; var_4 < 4; var_4++) {
      var_1[var_4] = spawn("script_model", var_2[var_4].origin);
      var_1[var_4] setModel("tag_origin");
      var_1[var_4]._id_65FA = _id_2832(var_1[var_4]);
      var_1[var_4] thread _id_3D8E(var_4 + 1);
    }

    wait 1.5;
  }
}

_id_3D8E(var_0) {
  wait(1 / var_0);
  self._id_65FA fadeovertime(1);
  self._id_65FA.alpha = 0.65;
  wait 1;
  self._id_65FA fadeovertime(1);
  self._id_65FA.alpha = 0;
  wait 1;
  self._id_65FA destroy();
  self delete();
}

_id_9409() {
  self._id_9409 = 0;
  common_scripts\utility::_id_A70A("cooldown", "no_power", "deactivate", "ready");
  self._id_9409 = 1;
}

_id_2832(var_0) {
  var_1 = newhudelem();
  var_1 setshader("hud_destructibledeathicon", 1, 1);
  var_1.alpha = 0;
  var_1.color = (1, 1, 1);
  var_1.x = var_0.origin[0];
  var_1.y = var_0.origin[1];
  var_1._id_01D9 = var_0.origin[2];
  var_1 _meth_80CB(0);
  var_1 _meth_80C0(var_0);
  return var_1;
}

_id_9CC4(var_0, var_1) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_2 = 0;
  var_3 = 0.15;

  if(isDefined(self._id_817A))
    var_4 = self._id_817A;
  else
    var_4 = 20;

  var_5 = [];

  for(var_6 = 0; var_6 < var_1.size; var_6++)
    var_5[var_6] = var_1[var_6].origin;

  while(var_2 < var_4) {
    var_3 = _func_0A3(0.75) + 0.5;
    wait(var_3);
    var_2 = var_2 + var_3;
    thread _id_2E66(common_scripts\utility::random(var_5));
  }
}

_id_2E66(var_0) {
  var_1 = var_0;

  if(!isDefined(self._id_5BBA))
    self._id_5BBA = (0, 0, 0);

  self._id_5BBA = var_1;
  playFX(level._effect["bouncing_betty_explode"], var_1);
  _id_0378::_id_8D74("aud_trap_betty_triggered", var_1);
  wait 0.6;
  var_2 = var_1 + (0, 0, 70);
  playFX(level._effect["bouncing_betty_explosion"], var_2);
  _id_0378::_id_8D74("aud_trap_betty_explo", var_1);
  var_3 = _id_0547::_id_408F();

  foreach(var_5 in var_3) {
    var_6 = distance(var_5.origin, var_2);

    if(var_6 < 256) {
      if(var_5 _id_0547::_id_580A())
        var_5 _meth_8059(var_5.health * 0.25, var_2, level._id_9C97, level._id_9C97, "MOD_EXPLOSIVE", "trap_zm_mp");
      else {
        maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_6FEE(var_5);
        var_5 _meth_8059(var_5.health + 666, var_2, level._id_9C97, level._id_9C97, "MOD_EXPLOSIVE", "trap_zm_mp");

        if(!isDefined(self.hitbytrap)) {
          foreach(var_8 in level.players) {
            var_8 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
            self.hitbytrap = 1;
          }
        }
      }

      waitframe();
    }
  }

  foreach(var_8 in level.players) {
    var_6 = distance(var_8.origin, var_2);

    if(var_6 < 256)
      var_8 _meth_8059(30 * (1 - var_6 / 256), var_2, undefined, undefined, "MOD_EXPLOSIVE");
  }

  _func_17F(0.8, 0.6, var_2, 200);
  wait 0.4;
  self._id_1732 = 0;
}
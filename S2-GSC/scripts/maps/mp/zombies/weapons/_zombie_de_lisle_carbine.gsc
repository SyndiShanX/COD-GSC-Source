/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_de_lisle_carbine.gsc
************************************************************************/

init() {
  level._effect["trap_ready_red"] = loadfx("vfx/zombie/zmb_trap_light_red");
  level._effect["trap_ready_blue"] = loadfx("vfx/zombie/zmb_trap_light_blue");
  level thread maps\mp\_utility::_id_6F74(::player_fire_tracking);
}

player_fire_tracking() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("tag_origin");
  var_1 _meth_805C();
  var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_1);
  var_2 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 35);

  for(;;) {
    var_0 waittill("weapon_fired", var_3);
    var_3 = _id_0547::_id_AAF9(var_3, 1);

    if(!_id_0547::_id_5565(var_3, "delisle_pap_zm") && !_id_0547::_id_5565(var_3, "wz35_pap_zm")) {
      continue;
    }
    var_4 = var_0 getEye();
    var_5 = var_4 + 10000 * vectorNormalize(anglesToForward(var_0 _meth_8566()));
    var_6 = bulletTrace(var_4, var_5, 1, var_0);
    var_7 = bulletTrace(var_4, var_5, 0, var_0, 0, 0, 0, 0, 1, 0, 0);
    var_8 = distance(var_6["position"], var_7["position"]);

    if(var_8 < 4) {
      var_1 _meth_805B();
      var_1.origin = _func_10A(var_4, var_7["position"], 0.99);
      var_1 set_fx("trap_ready");

      if(_id_0547::_id_5565(var_3, "delisle_pap_zm"))
        wait 2;
      else
        wait 1;

      if(_id_0547::_id_5565(var_3, "delisle_pap_zm"))
        var_1 set_fx("trap_ready_red");
      else
        var_1 set_fx("trap_ready_blue");

      wait 1;
      var_9 = 10;

      while(var_9 > 0) {
        var_10 = [];
        var_10 = var_1 get_close_zombies(var_0, _id_0547::_id_5565(var_3, "delisle_pap_zm"));

        if(var_10.size > 0) {
          break;
        }

        var_9 = var_9 - 0.1;
        wait 0.1;
      }

      wait 0.5;
      var_10 = var_1 get_close_zombies(var_0, _id_0547::_id_5565(var_3, "delisle_pap_zm"));
      var_1 clear_betty();

      if(_id_0547::_id_5565(var_3, "delisle_pap_zm")) {
        for(var_11 = 0; var_11 < var_10.size; var_11++) {
          if(var_11 == 5) {
            break;
          }

          var_12 = _func_1B5("delisle_pap_zm", var_1.origin, var_10[var_11] getEye(), var_0);
          var_10[var_11] _meth_8059(var_2, var_1.origin, var_0, var_12, "MOD_RIFLE_BULLET", "delisle_pap_zm", "head");
        }
      } else
        var_0 maps\mp\zombies\weapons\_zombie_type_38::spawn_electro_blast(var_1.origin, 1);
    }
  }
}

get_close_zombies(var_0, var_1) {
  var_2 = [];
  var_3 = self;

  if(var_1)
    var_4 = 375;
  else
    var_4 = 160;

  foreach(var_6 in _id_0547::_id_408F()) {
    if(distance(var_3.origin, var_6.origin) > var_4) {
      continue;
    }
    var_2 = common_scripts\utility::_id_0F6F(var_2, var_6);
  }

  return var_2;
}

clear_betty() {
  if(isDefined(self.fx))
    self.fx delete();
}

set_fx(var_0) {
  var_1 = self;

  if(isDefined(var_1.fx))
    var_1.fx delete();

  var_2 = _func_2A8(level._effect[var_0], var_1, "tag_origin");
  _func_14C(var_2);
  var_1.fx = var_2;
}